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

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.sail.webapp.domain.User;
import net.sf.sail.webapp.domain.Workgroup;
import net.sf.sail.webapp.domain.group.Group;
import net.sf.sail.webapp.domain.webservice.http.HttpRestTransport;
import net.sf.sail.webapp.presentation.web.controllers.ControllerUtil;
import net.sf.sail.webapp.service.UserService;

import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;
import org.telscenter.sail.webapp.domain.Run;
import org.telscenter.sail.webapp.domain.StudentUserAlreadyAssociatedWithRunException;
import org.telscenter.sail.webapp.domain.impl.Projectcode;
import org.telscenter.sail.webapp.domain.project.impl.LaunchProjectParameters;
import org.telscenter.sail.webapp.domain.run.StudentRunInfo;
import org.telscenter.sail.webapp.domain.workgroup.WISEWorkgroup;
import org.telscenter.sail.webapp.presentation.web.TeamSignInForm;
import org.telscenter.sail.webapp.service.offering.RunService;
import org.telscenter.sail.webapp.service.project.ProjectService;
import org.telscenter.sail.webapp.service.student.StudentService;
import org.telscenter.sail.webapp.service.workgroup.WISEWorkgroupService;

/**
 * Controller for handling team sign-ins before students start the project. The first user
 * entered in the form must be already signed-in and associated with a specific
 * <code>Run</code> and specific period. The second and third users entered will be
 * associated with the same <code>Run</code> and same period as the first user if
 * they are not already associated.
 *
 * @author Hiroki Terashima
 * @version $Id$
 */
public class TeamSignInController extends SimpleFormController {

	private UserService userService;
	
	private WISEWorkgroupService workgroupService;
	
	private RunService runService;
	
	private StudentService studentService;

	private ProjectService projectService;

	private HttpRestTransport httpRestTransport;

	public TeamSignInController() {
		setSessionForm(true);
	}
	
	/**
	 * On submission of the Team Sign In form, the workgroup is updated
	 * Assume that the usernames are valid usernames that exist in the data store
	 * 
	 * @see org.springframework.web.servlet.mvc.SimpleFormController#onSubmit(javax.servlet.http.HttpServletRequest,
	 *      javax.servlet.http.HttpServletResponse, java.lang.Object,
	 *      org.springframework.validation.BindException)
	 */
	@Override
	protected synchronized ModelAndView onSubmit(HttpServletRequest request,
			HttpServletResponse response, Object command, BindException errors)
	throws Exception {

		TeamSignInForm teamSignInForm = (TeamSignInForm) command;
		User user1 = userService.retrieveUserByUsername(teamSignInForm.getUsername1());
		User user2 = userService.retrieveUserByUsername(teamSignInForm.getUsername2());
		User user3 = userService.retrieveUserByUsername(teamSignInForm.getUsername3());
		
		Run run = runService.retrieveById(teamSignInForm.getRunId());
		
		// get projectcode to use to add user2 and user3 to run
		StudentRunInfo studentRunInfoUser1 = studentService.getStudentRunInfo(user1, run);
		Projectcode projectcode = new Projectcode(run.getRuncode(), studentRunInfoUser1.getGroup().getName());

		Set<User> members = new HashSet<User>();
		String workgroupname = "Workgroup for " + user1.getUserDetails().getUsername();
		members.add(user1);
		List<Workgroup> workgroups = workgroupService.getWorkgroupListByOfferingAndUser(run, user1);

		if (user2 != null) {
			try {
				studentService.addStudentToRun(user2, projectcode);
			} catch (StudentUserAlreadyAssociatedWithRunException e) {
				// do nothing. it's okay if the student is already associated with this run.
			}
			members.add(user2);
			workgroupname += user2.getUserDetails().getUsername();
			workgroups.addAll(workgroupService.getWorkgroupListByOfferingAndUser(run, user2));
		}
		if (user3 != null) {
			try {
				studentService.addStudentToRun(user3, projectcode);
			} catch (StudentUserAlreadyAssociatedWithRunException e) {
				// do nothing. it's okay if the student is already associated with this run.
			}
			members.add(user3);
			workgroupname += user3.getUserDetails().getUsername();
			workgroups.addAll(workgroupService.getWorkgroupListByOfferingAndUser(run, user3));
		}

		Workgroup workgroup = null;
		Group period = run.getPeriodOfStudent(user1);
		if (workgroups.size() == 0) {
			workgroup = workgroupService.createWISEWorkgroup(workgroupname, members, run, period);
		} else if (workgroups.size() == 1) {
			workgroup = workgroups.get(0);
			workgroupService.addMembers(workgroup, members);
		} else {
			// more than one user has created a workgroup for this run.
			// TODO HT gather requirements and find out what should be done in this case
			// for now, just choose one
			workgroup = workgroups.get(0);
			workgroupService.addMembers(workgroup, members);
		}
	    
		ModelAndView modelAndView = new ModelAndView();
		
		/* update run statistics */
		this.runService.updateRunStatistics(run.getId());
		
		LaunchProjectParameters launchProjectParameters = new LaunchProjectParameters();
		launchProjectParameters.setRun(run);
		launchProjectParameters.setWorkgroup((WISEWorkgroup) workgroup);
		launchProjectParameters.setHttpRestTransport(this.httpRestTransport);
		launchProjectParameters.setHttpServletRequest(request);
		StartProjectController.notifyServletSession(request, run);
		modelAndView = (ModelAndView) projectService.launchProject(launchProjectParameters);
		modelAndView.addObject("closeokay", true);
		
		return modelAndView;
	}
	
	@Override
	protected Object formBackingObject(HttpServletRequest request) throws Exception {
		User user = ControllerUtil.getSignedInUser();

		TeamSignInForm form = new TeamSignInForm();
		form.setUsername1(user.getUserDetails().getUsername());
		form.setRunId(Long.valueOf(request.getParameter("runId")));

		return form;
	}

	/**
	 * @param userService the userService to set
	 */
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	/**
	 * @param workgroupService the workgroupService to set
	 */
	public void setWorkgroupService(WISEWorkgroupService workgroupService) {
		this.workgroupService = workgroupService;
	}

	/**
	 * @param runService the runService to set
	 */
	public void setRunService(RunService runService) {
		this.runService = runService;
	}

	/**
	 * @param studentService the studentService to set
	 */
	public void setStudentService(StudentService studentService) {
		this.studentService = studentService;
	}

	/**
	 * @param httpRestTransport the httpRestTransport to set
	 */
	public void setHttpRestTransport(HttpRestTransport httpRestTransport) {
		this.httpRestTransport = httpRestTransport;
	}

	/**
	 * @param projectService the projectService to set
	 */
	public void setProjectService(ProjectService projectService) {
		this.projectService = projectService;
	}
}
