/**
 * Copyright (c) 2008 Regents of the University of California (Regents). Created
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
package org.telscenter.sail.webapp.presentation.web.controllers.teacher.management;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Set;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.sail.webapp.domain.Workgroup;
import net.sf.sail.webapp.domain.group.Group;
import net.sf.sail.webapp.domain.impl.CurnitGetCurnitUrlVisitor;
import net.sf.sail.webapp.presentation.web.controllers.ControllerUtil;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import org.telscenter.sail.webapp.domain.Run;
import org.telscenter.sail.webapp.domain.project.impl.ProjectTypeVisitor;
import org.telscenter.sail.webapp.service.grading.GradingService;
import org.telscenter.sail.webapp.service.offering.RunService;

/**
 * Controller to display ClassMonitor page
 * 
 * @author Hiroki Terashima
 * @version $Id$
 */
public class ClassMonitorController extends AbstractController {

	private RunService runService;
	
	private static final String VIEW_NAME = "teacher/management/classmonitor";

	private static final String RUNID = "runId";
	
	private static final String RUN = "run";
	
	private static final String DATE = "date";
	
	private static final String TAB = "tab";
	
	private static final String WORKGROUPS = "workgroups";

	/**
	 * @see org.springframework.web.servlet.mvc.AbstractController#handleRequestInternal(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	@Override
	protected ModelAndView handleRequestInternal(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		Run run = runService.retrieveById(Long.valueOf(request.getParameter(RUNID)));
		Long runId = Long.valueOf(request.getParameter(RUNID));
		String isPaused = request.getParameter("paused");
		String showNodeId = request.getParameter("showNodeId");
		
		/*
		 * check if the paused parameter was passed and set it accordingly
		 * in the run
		 */
		if(isPaused != null && !isPaused.equals("")) {
			if (showNodeId != null && !showNodeId.equals("")) {
				runService.setInfo(runId, isPaused, showNodeId);
			} else {
				runService.setInfo(runId, isPaused, null);
			}
			
			return null;
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss MM/dd/yyyy");

		TreeMap<Long, Set<Workgroup>> workgroups = new TreeMap<Long, Set<Workgroup>>();
		for(Group period : run.getPeriods()){
			workgroups.put(period.getId(), this.runService.getWorkgroups(run.getId(), period.getId()));
		}
		
		ModelAndView modelAndView = new ModelAndView(VIEW_NAME);
		modelAndView.addObject(RUN, run);
		modelAndView.addObject(TAB, request.getParameter(TAB));
		modelAndView.addObject(DATE, sdf.format(new Date()));
		modelAndView.addObject(WORKGROUPS, workgroups);
		
		ProjectTypeVisitor typeVisitor = new ProjectTypeVisitor();
		String result = (String) run.getProject().accept(typeVisitor);
		if (result.equals("LDProject")) {
			// LDProject, get the .project file
			String portalurl = ControllerUtil.getBaseUrlString(request);

			String getContentUrl = (String) run.getProject().getCurnit().accept(new CurnitGetCurnitUrlVisitor());
			
			int lastIndexOfSlash = getContentUrl.lastIndexOf("/");
			String contentBaseUrl = getContentUrl.substring(0, lastIndexOfSlash);

	    	String progressMonitorUrl = portalurl + "/vlewrapper/vle/vle.html";

			String portalVLEControllerUrl = portalurl + "/webapp/student/vle/vle.html?runId=" + run.getId();
			String getUserInfoUrl = portalVLEControllerUrl + "&action=getUserInfo";
	    	String getDataUrl = portalurl + "/vlewrapper/getdata.html";

	    	modelAndView.addObject("getContentUrl", getContentUrl);
			modelAndView.addObject("progressMonitorUrl", progressMonitorUrl);
	    	modelAndView.addObject("contentBaseUrl", contentBaseUrl);
			modelAndView.addObject("getUserInfoUrl", getUserInfoUrl);
			modelAndView.addObject("getDataUrl", getDataUrl);
		}
		return modelAndView;
	}

	/**
	 * @param runService the runService to set
	 */
	public void setRunService(RunService runService) {
		this.runService = runService;
	}

}
