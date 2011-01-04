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
package org.telscenter.sail.webapp.presentation.web.controllers.teacher.grading;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.sail.webapp.domain.Workgroup;
import net.sf.sail.webapp.domain.group.Group;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import org.telscenter.sail.webapp.domain.Run;
import org.telscenter.sail.webapp.service.grading.GradingService;
import org.telscenter.sail.webapp.service.grading.impl.GradingServiceImpl;
import org.telscenter.sail.webapp.service.offering.RunService;
import org.telscenter.pas.emf.pas.*;

/**
 * Controller to display the teacher's interface for grading, including
 * students' work
 *
 * @author Anthony Perritano
 * @author Hiroki Terashima
 * @version $Id:$
 */
public class GradingToolController extends AbstractController {

	private static final String RUNID = "runId";
	
	private static final String RUN = "run";
	
	private static final String ACTIVITYNUM = "activityNumber";
	
	private static final String PROJECTTITLE = "projectTitle";
	
	private static final String STEP = "step";
	
	private static final String STEPID = "podUUID";
	
	private static final String NEXT = "next";
	
	private static final String PREVIOUS = "previous";
	
	private static final String TAB = "tab";
	
	private static final String WORKGROUPS = "workgroups";
	
	private RunService runService;
	
	private GradingService gradingService;

	/**
	 * @see org.springframework.web.servlet.mvc.AbstractController#handleRequestInternal(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	@SuppressWarnings("unchecked")
	@Override
	protected ModelAndView handleRequestInternal(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		String stepId = request.getParameter(STEPID);
		Run run = this.runService.retrieveById(Long.parseLong(request.getParameter(RUNID)));
		ECurnitmap curnitMap = this.gradingService.getCurnitmap(run.getId());
		
		List<EStep> steps = new LinkedList<EStep>();
		HashMap<EStep, EActivity> stepsActivities = new HashMap<EStep, EActivity>();
		EStep thisStep = null;
		EStep nextStep = null;
		EStep prevStep = null;
		EActivity thisActivity = null;
		for(EActivity activity : (List<EActivity>) curnitMap.getProject().getActivity()){
			for(EStep step : (List<EStep>) activity.getStep()){
				if(GradingServiceImpl.gradableStepTypes.contains(step.getType())){
					steps.add(step);
					stepsActivities.put(step, activity);
					if(step.getPodUUID().toString().equals(stepId)){
						thisStep = step;
						thisActivity = activity;
					}
				}
			}
		}
		
		int currentIndex = steps.indexOf(thisStep);
		if(currentIndex > 0)
			prevStep = steps.get(currentIndex - 1);
		if(currentIndex < steps.size()-1)
			nextStep = steps.get(currentIndex + 1);
		
		TreeMap<Long, Set<Workgroup>> workgroups = new TreeMap<Long, Set<Workgroup>>();
		for(Group period : run.getPeriods()){
			workgroups.put(period.getId(), this.runService.getWorkgroups(run.getId(), period.getId()));
		}
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject(RUN, run);
		modelAndView.addObject(STEP, thisStep);
		modelAndView.addObject(NEXT, nextStep);
		modelAndView.addObject(PREVIOUS, prevStep);
		modelAndView.addObject(ACTIVITYNUM, thisActivity.getNumber());
		modelAndView.addObject(PROJECTTITLE, curnitMap.getProject().getTitle());
		modelAndView.addObject(TAB, request.getParameter(TAB));
		modelAndView.addObject(WORKGROUPS, workgroups);
		
	    return modelAndView;
	}

	public void setRunService(RunService runService) {
		this.runService = runService;
	}

	public void setGradingService(GradingService gradingService) {
		this.gradingService = gradingService;
	}

}