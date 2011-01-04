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

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.sail.emf.sailuserdata.EAnnotation;
import net.sf.sail.emf.sailuserdata.EAnnotationGroup;
import net.sf.sail.emf.sailuserdata.ESockEntry;
import net.sf.sail.emf.sailuserdata.ESockPart;
import net.sf.sail.webapp.domain.sessionbundle.SessionBundle;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import org.telscenter.pas.emf.pas.EActivity;
import org.telscenter.pas.emf.pas.ERim;
import org.telscenter.pas.emf.pas.EStep;
import org.telscenter.sail.webapp.domain.grading.GradeWorkByWorkgroupAggregate;
import org.telscenter.sail.webapp.domain.workgroup.WISEWorkgroup;
import org.telscenter.sail.webapp.service.grading.GradingService;
import org.telscenter.sail.webapp.service.workgroup.WISEWorkgroupService;

/**
 * @author patrick lawler
 */
public class ProgressCellInfoController extends AbstractController{

	private final static String RUNID = "runId";
	
	private final static String WORKGROUPID = "workgroupId";
	
	private final static String XMLDOC = "xmlDoc";
		
	private GradingService gradingService;
	
	private WISEWorkgroupService workgroupService;
	
	/**
	 * @see org.springframework.web.servlet.mvc.AbstractController#handleRequestInternal(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	@SuppressWarnings("unchecked")
	@Override
	protected ModelAndView handleRequestInternal(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		String xmlDoc = "<progresscellinfo>";
		EStep latestStep = null;
		float totalCompletedSteps = 0;
		float totalPossibleScore = 0;
		float totalTeacherGradedPossible = 0;
		int totalTeacherGradedActual = 0;

		//get steps and total score
		long runId = Long.parseLong(request.getParameter(RUNID));
		List<EStep> gradableSteps = this.gradingService.getGradableSteps(runId);
		List<EStep> cloned = copy(gradableSteps);
		totalPossibleScore = this.gradingService.getTotalPossibleScore(runId);
		totalCompletedSteps = gradableSteps.size();
		
		//get aggregate for this cell
		GradeWorkByWorkgroupAggregate aggregate = this.gradingService.
			getGradeWorkByWorkgroupAggregate(runId, (WISEWorkgroup) this.
			workgroupService.retrieveById(Long.parseLong(request.getParameter(WORKGROUPID))));
		
		//find skipped steps and set latestStep
		boolean missingPart = false;
		for(EStep step : gradableSteps){
			List<ERim> copiedRims = getCopiedRims(step);
			for(ERim rim : (List<ERim>) step.getRim()){
				for(SessionBundle sessionBundle : aggregate.getSessionBundles()){
					for(ESockPart sockPart : (List<ESockPart>) sessionBundle.getESessionBundle().getSockParts()){
						if(sockPart.getPodId().equals(step.getPodUUID()) && sockPart.getRimName().equals(rim.getRimname())){
							copiedRims.remove(rim);
//							ESockEntry sockEntry = ((ESockEntry) sockPart.getSockEntries().get(sockPart.getSockEntries().size()-1));
//							if(sockEntry.getValue() == null || sockEntry.getValue() == ""){
//								missingPart = true;
//							}
						}
					}
				}
			}
			if(missingPart || copiedRims.size() > 0){
				totalCompletedSteps -= 1;
			} else {
				if(latestStep == null || num(step) > num(latestStep)){
					latestStep = step;
				}
				cloned.remove(step);
			}
			missingPart = false;
		}
		
		//remove any steps that are greater than latest activity and step
		//which will leave only skipped steps
		for(EStep step : gradableSteps){
			if(latestStep != null && num(step) > num(latestStep)){
				cloned.remove(step);
			}
		}

		//find skipped activities (all steps skipped within a specific activity)
		//and then remove them from skipped steps
		List<EActivity> activities = getActivities(cloned);
		List<EActivity> skippedActivities = new LinkedList<EActivity>();
		for(EActivity activity : activities){
			if(getCount(activity, gradableSteps) == getCount(activity, cloned)){
				for(EStep step : gradableSteps){
					if(((EActivity) step.eContainer()).equals(activity)){
						cloned.remove(step);
					}
				}
				skippedActivities.add(activity);
			}
		}
		
		//get score and possible score for teacher graded steps
		List<EAnnotationGroup> annotationGroups = aggregate.getAnnotationBundle().getEAnnotationBundle().getAnnotationGroups();
		for(EAnnotationGroup annotationGroup : annotationGroups){
			for(EAnnotation annotation : (List<EAnnotation>) annotationGroup.getAnnotations()){
				for(EStep step : gradableSteps){
					if(step.getPodUUID().toString().equals(annotation.getEntityUUID().toString())){
						if(annotationGroup.getAnnotationSource().equals("http://telscenter.org/annotation/score")){
							if(annotation.getContents() != "" && annotation.getContents() != null){
								totalTeacherGradedActual += Integer.parseInt(annotation.getContents());
								totalTeacherGradedPossible += step.getPossibleScore();
							}
						}
					}
				}
			}
		}
		
		//set tags and data for xmlDoc
		if(latestStep == null){
			xmlDoc = xmlDoc + "<currentstep>None</currentstep>";
			xmlDoc = xmlDoc + "<percentcomplete>0</percentcomplete>";
		} else {
			xmlDoc = xmlDoc + "<currentstep>" + num(latestStep) + "</currentstep>";
			xmlDoc = xmlDoc + "<percentcomplete>" + Math.round((totalCompletedSteps / gradableSteps.size()) * 100) + "</percentcomplete>";
			for(EStep step : cloned){
				xmlDoc = xmlDoc + "<skipped><activitynum>" + (Integer.parseInt(((EActivity) 
					step.eContainer()).getNumber()) + 1) + "</activitynum><stepnum>" + 
					(Integer.parseInt(step.getNumber()) + 1) + "</stepnum></skipped>";
			}
			for(EActivity activity : skippedActivities){
				xmlDoc = xmlDoc + "<skippedactivity>" + (Integer.parseInt(activity.getNumber()) + 1) + "</skippedactivity>";
			}
		}
		
		xmlDoc = xmlDoc + "<rawactual>" + totalTeacherGradedActual + "</rawactual>";
		xmlDoc = xmlDoc + "<rawpossible>" + Math.round(totalPossibleScore) + "</rawpossible>";
		xmlDoc = xmlDoc + "<teacheractual>" + totalTeacherGradedActual + "</teacheractual>";
		xmlDoc = xmlDoc + "<teacherpossible>" + Math.round(totalTeacherGradedPossible) + "</teacherpossible>";
		
		//TODO needs to be updated when autograding is implemented
		xmlDoc = xmlDoc + "<autoactual>0</autoactual><autopossible>0</autopossible>";
		xmlDoc = xmlDoc + getStepActivityMap(gradableSteps);
		xmlDoc = xmlDoc + "</progresscellinfo>";
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject(XMLDOC, xmlDoc);
		return modelAndView;
	}
	
	@SuppressWarnings("unchecked")
	private List<ERim> getCopiedRims(EStep step) {
		List<ERim> rims = new LinkedList<ERim>();
		for(ERim rim : (List<ERim>) step.getRim()){
			rims.add(rim);
		}
		return rims;
	}

	//given an activity and a list<EStep> returns the number of steps
	//that contain this activity
	private int getCount(EActivity activity, List<EStep> steps) {
		int count = 0;
		for(EStep step : steps){
			if(((EActivity) step.eContainer()).equals(activity))
				count += 1;
		}
		return count;
	}

	//given a list of steps returns a list of activities where each
	//activity is only listed once
	private List<EActivity> getActivities(List<EStep> gradableSteps) {
		List<EActivity> activities = new LinkedList<EActivity>();
		for(EStep step : gradableSteps){
			if(!activities.contains((EActivity) step.eContainer())){
				activities.add((EActivity) step.eContainer());
			}
		}
		return activities;
	}

	//copies and returns a EStep list
	private List<EStep> copy(List<EStep> steps){
		List<EStep> copied = new ArrayList<EStep>();
		for(EStep step : steps){
			copied.add(step);
		}
		return copied;
	}
	
	//given a step returns a unique int based on a 
	//concatenation of activity number and step number
	private int num(EStep step){
		return Integer.parseInt(((EActivity) step.eContainer()).getNumber() + step.getNumber());
	}
	
	//returns xml String activity/step number map keyed on unique 
	//combination of activity number and step number
	private String getStepActivityMap(List<EStep> steps){
		String map = "<entry><key>None</key><activity>0</activity><step>0</step></entry>";
		for(EStep step : steps){
			map = map + "<entry><key>" + num(step) + "</key><activity>" + 
				(Integer.parseInt(((EActivity) step.eContainer()).getNumber()) + 1) + 
				"</activity><step>" + (Integer.parseInt(step.getNumber()) + 1) + "</step></entry>";
		}
		return map;
	}
	
	/**
	 * @param gradingService the gradingService to set
	 */
	public void setGradingService(GradingService gradingService) {
		this.gradingService = gradingService;
	}

	/**
	 * @param workgroupService the workgroupService to set
	 */
	public void setWorkgroupService(WISEWorkgroupService workgroupService) {
		this.workgroupService = workgroupService;
	}
	
}
