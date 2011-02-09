/**
 * Copyright (c) 2007 Regents of the University of California (Regents). Created
 * by TELS, Graduate School of Education, University of California at Berkeley.
 *
 * This software is distributed under the GNU Lesser General Public License, v2.
 *
 * Permission is hereby granted, without written agreement and without license
 * or royalty fees, to use, copy, modify, and distribute this software and its
 * documentation for any purpose, provided that the above copyright notice and
 * the following two paragraphs appear in all copies of this software.
 *
 * REGENTS SPECIFICALLY DISCLAIMS ANY WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE. THE SOFTWAREAND ACCOMPANYING DOCUMENTATION, IF ANY, PROVIDED
 * HEREUNDER IS PROVIDED "AS IS". REGENTS HAS NO OBLIGATION TO PROVIDE
 * MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS.
 *
 * IN NO EVENT SHALL REGENTS BE LIABLE TO ANY PARTY FOR DIRECT, INDIRECT,
 * SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES, INCLUDING LOST PROFITS,
 * ARISING OUT OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF
 * REGENTS HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
package org.telscenter.sail.webapp.presentation.web.controllers.student;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.sail.webapp.domain.User;
import net.sf.sail.webapp.domain.Workgroup;
import net.sf.sail.webapp.domain.group.Group;
import net.sf.sail.webapp.domain.webservice.http.HttpRestTransport;
import net.sf.sail.webapp.presentation.web.controllers.ControllerUtil;
import net.sf.sail.webapp.presentation.web.listeners.PasSessionListener;
import net.sf.sail.webapp.service.UserService;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import org.telscenter.sail.webapp.domain.Run;
import org.telscenter.sail.webapp.domain.project.impl.LaunchProjectParameters;
import org.telscenter.sail.webapp.domain.workgroup.WISEWorkgroup;
import org.telscenter.sail.webapp.service.offering.RunService;
import org.telscenter.sail.webapp.service.project.ProjectService;
import org.telscenter.sail.webapp.service.workgroup.WISEWorkgroupService;

/**
 * Controller to allow students to launch the VLE using the project.
 * This link is *always* used to start the project for students, whether
 * - they're not in a workgroup
 * - they're in a workgroup by themself
 * - they're in a workgroup with other people
 *
 * @author Hiroki Terashima
 * @version $Id$
 */
public class StartProjectController extends AbstractController {

	private static final String SELECT_TEAM_URL = "student/selectteam";

	private static final String TEAM_SIGN_IN_URL = "student/teamsignin";

	private RunService runService;

	private WISEWorkgroupService workgroupService;

	private ProjectService projectService;
	
	private HttpRestTransport httpRestTransport;
	
	/**
	 * @see org.springframework.web.servlet.mvc.AbstractController#handleRequestInternal(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	@Override
	protected ModelAndView handleRequestInternal(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		 User user = ControllerUtil.getSignedInUser();

		String runIdStr = request.getParameter("runId");
		String projectIdStr = request.getParameter("projectId");
		Long runId = null;
		if (runIdStr != null) {
			runId = Long.valueOf(runIdStr);
		} else if (projectIdStr != null) {
			// we need to look up the run that the logged-in user is 
			// associated with that has been set up with the specified projectId.
			// currently, this assumes that student can be associated with one
			// run of that project.
			Long projectId = Long.valueOf(projectIdStr);
			List<Run> runList = runService.getRunList(user);
			for (Run run : runList) {
				if (run.getProject().getId().equals(projectId)) {
					runId = run.getId();
				}
			}
			if (runId == null) {
				// this means that the run has not been set up, or the student has not
				// associated with the project run yet.
				response.getWriter().print("You cannot see this yet. Either your teacher has not " +
						"set up the run, or you have not added the run. Please talk to your teacher.");
				return null;
			}
		}
		
		String bymyselfStr = request.getParameter("bymyself");
		boolean bymyself = false;
		if (bymyselfStr != null) {
			bymyself = Boolean.valueOf(bymyselfStr);
		}
		
		Run run = runService.retrieveById(runId);

		Group period = run.getPeriodOfStudent(user);
		
		List<Workgroup> workgroups = workgroupService.getWorkgroupListByOfferingAndUser(run, user);
		assert(workgroups.size() <= 1);
		
		WISEWorkgroup workgroup = null;
		if (workgroups.size() == 0) { 	// student is not yet in a workgroup
			if (bymyself) { 
				// if bymyself=true was passed in as request
				// create new workgroup with this student in it
				String name = "Workgroup for user: " + user.getUserDetails().getUsername();
				Set<User> members = new HashSet<User>();
				members.add(user);
				workgroup = workgroupService.createWISEWorkgroup(name, members, run, period);
				
				/* update run statistics */
				this.runService.updateRunStatistics(run);
				
				LaunchProjectParameters launchProjectParameters = new LaunchProjectParameters();
				launchProjectParameters.setRun(run);
				launchProjectParameters.setWorkgroup(workgroup);
				launchProjectParameters.setHttpRestTransport(this.httpRestTransport);
				launchProjectParameters.setHttpServletRequest(request);

				// update servlet session
				notifyServletSession(request, run);

				return (ModelAndView) projectService.launchProject(launchProjectParameters);
			} else {
				// need to create a workgroup for this user, take them to create workgroup wizard
				ModelAndView modelAndView = new ModelAndView(SELECT_TEAM_URL);
				modelAndView.addObject("runId", runId);
				return modelAndView;
			}
		} else if (workgroups.size() == 1) {
			workgroup = (WISEWorkgroup) workgroups.get(0);
			if (workgroup.getMembers().size() == 1) {
				/* update run statistics */
				this.runService.updateRunStatistics(run);
				
				// if the student is already in a workgroup and she is the only member,
				// launch the project
				LaunchProjectParameters launchProjectParameters = new LaunchProjectParameters();
				launchProjectParameters.setRun(run);
				launchProjectParameters.setWorkgroup(workgroup);
				launchProjectParameters.setHttpRestTransport(this.httpRestTransport);
				launchProjectParameters.setHttpServletRequest(request);
				
				// update servlet session
				notifyServletSession(request, run);
				return (ModelAndView) projectService.launchProject(launchProjectParameters);				
			} else {
				ModelAndView modelAndView = new ModelAndView(TEAM_SIGN_IN_URL);
				modelAndView.addObject("runId", runId);
				return modelAndView;
			}
		} else {
			// TODO HT: this case should never happen. But since WISE requirements are not clear yet regarding
			// the workgroup issues, leave this for now.
			workgroup = (WISEWorkgroup) workgroups.get(0);
			ModelAndView modelAndView = new ModelAndView(TEAM_SIGN_IN_URL);
			modelAndView.addObject("runId", runId);
			return modelAndView;

//			
//			throw new IllegalStateException("The user " + 
//					user.getUserDetails().getUsername() + " is in more than one " +
//							"groups for the run " + run.getSdsOffering().getName());
		}

	}
	
	/**
	 * Inserts [user's sessionId,run] info into servletContext session variable.
	 * @param request current request
	 * @param run run that the logged in user is running
	 */
	public static void notifyServletSession(HttpServletRequest request, Run run) {
		HttpSession session = request.getSession();

		// add new session in a allLoggedInUsers servletcontext HashMap variable
		String sessionId = session.getId();
		HashMap<String, Run> studentToRuns = (HashMap<String, Run>) session.getServletContext().getAttribute("studentsToRuns");
		if (studentToRuns == null) {
			studentToRuns = new HashMap<String, Run>();
			session.getServletContext().setAttribute("studentsToRuns", studentToRuns);
		}
		studentToRuns.put(sessionId, run);
	}

	/**
	 * @param runService the runService to set
	 */
	public void setRunService(RunService runService) {
		this.runService = runService;
	}
	
	/**
	 * @param httpRestTransport the httpRestTransport to set
	 */
	public void setHttpRestTransport(HttpRestTransport httpRestTransport) {
		this.httpRestTransport = httpRestTransport;
	}

	/**
	 * @param workgroupService the workgroupService to set
	 */
	public void setWorkgroupService(WISEWorkgroupService workgroupService) {
		this.workgroupService = workgroupService;
	}

	/**
	 * @param projectService the projectService to set
	 */
	public void setProjectService(ProjectService projectService) {
		this.projectService = projectService;
	}
}
