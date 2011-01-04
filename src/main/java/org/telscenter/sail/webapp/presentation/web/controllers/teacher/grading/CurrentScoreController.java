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

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.sail.webapp.domain.User;
import net.sf.sail.webapp.domain.Workgroup;
import net.sf.sail.webapp.domain.group.Group;
import net.sf.sail.webapp.presentation.web.controllers.ControllerUtil;
import net.sf.sail.webapp.service.annotation.AnnotationBundleService;
import net.sf.sail.webapp.service.workgroup.WorkgroupService;

import org.eclipse.emf.common.util.EList;
import org.springframework.security.acls.domain.BasePermission;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import org.springframework.web.servlet.view.RedirectView;
import org.telscenter.pas.emf.pas.EActivity;
import org.telscenter.pas.emf.pas.ECurnitmap;
import org.telscenter.pas.emf.pas.EProject;
import org.telscenter.pas.emf.pas.EStep;
import org.telscenter.sail.webapp.domain.Run;
import org.telscenter.sail.webapp.domain.grading.GradeWorkByWorkgroupAggregate;
import org.telscenter.sail.webapp.domain.grading.IndividualScore;
import org.telscenter.sail.webapp.domain.workgroup.WISEWorkgroup;
import org.telscenter.sail.webapp.service.grading.GradingService;
import org.telscenter.sail.webapp.service.offering.RunService;

/**
 * A Controller for TELS's displaying the current score for periods of a run
 *
 * @author Anthony Perritano
 * @version $Id: $
 */
public class CurrentScoreController extends AbstractController {

	private static final String ALL_SCORES = "allScores";

	private static final String SCORE_MAP = "scoreMap";

	public static final String RUN_ID = "runId";
	
	public static final String CURNIT_MAP = "curnitMap";

	private static final String PROJECT_TITLE = "title";

	private static final String CURNIT_ID = "curnitId";
	
	private GradingService gradingService;
	private RunService runService;
	private AnnotationBundleService annotationBundleService;
	private WorkgroupService workgroupService;
	private List<IndividualScore> allScores = new ArrayList<IndividualScore>();
	private HashMap<String, List<IndividualScore>> periodsToScoreLists = new HashMap<String, List<IndividualScore>>();
	
	/**
	 * @see org.springframework.web.servlet.mvc.AbstractController#handleRequestInternal(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	@SuppressWarnings("unchecked")
	@Override
	protected ModelAndView handleRequestInternal(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		String runId = request.getParameter(RUN_ID);
		
		if( runId != null ) {
			
			//get the stuff from the run
			Run aRun = runService.retrieveById(new Long(runId));
			User user = ControllerUtil.getSignedInUser();
			if(this.runService.hasRunPermission(aRun, user, BasePermission.READ)){
				System.out.println("OBJECT ID: " + aRun.getSdsOffering().getSdsCurnit().getSdsObjectId() );
				String curnitId = aRun.getSdsOffering().getSdsCurnit().getSdsObjectId().toString();
				
				ECurnitmap curnitMap = this.gradingService.getCurnitmap(new Long(runId));
				EProject project = curnitMap.getProject();
				
				HashMap<String, EStep> gradableSteps = new HashMap<String, EStep>();
				
				//find all the gradable steps
				for (Iterator iterator = curnitMap.getProject().getActivity().iterator(); iterator.hasNext();) {
					EActivity foundActivity = (EActivity) iterator.next();
					EList stepList = foundActivity.getStep();
					//find the gradable steps
					for (Iterator stepListIt = stepList.iterator(); stepListIt
							.hasNext();) {
						EStep step = (EStep) stepListIt.next();
						
						//if it is a gradeable record the scores
						//if(GradingToolController.isGradable(step.getType()) ) {
						//	gradableSteps.put(step.getPodUUID().toString(),step);
						//}// if
					}// for
				}// for
				
				
				//get all workgroups
				Set<Workgroup> workgroups = runService.getWorkgroups(new Long(runId));
				periodsToScoreLists = new HashMap<String, List<IndividualScore>>();
				
				//go through all the workgroups and create the score list
				for (Workgroup workgroup : workgroups) {
					
					GradeWorkByWorkgroupAggregate gradeWorkByWorkgroupAggregate = this.gradingService.getGradeWorkByWorkgroupAggregate(new Long(runId), workgroup);
					List<IndividualScore> individualScores = this.gradingService.getIndividualScores(gradeWorkByWorkgroupAggregate, gradableSteps);
					
					Group period = ((WISEWorkgroup)workgroup).getPeriod();
					
					if (period != null) {
						String periodKey = period.getName();
	
						if( periodsToScoreLists.containsKey(periodKey) ) {
							periodsToScoreLists.get(periodKey).addAll(individualScores);
						} else {
							periodsToScoreLists.put(periodKey, individualScores);
						}// if
					}				
				
				}// for
				
				allScores = new ArrayList<IndividualScore>();
				for (Map.Entry<String, List<IndividualScore>> entry : periodsToScoreLists.entrySet()) {
					allScores.addAll(entry.getValue());
				}
				
				Collections.sort(allScores);
			
				//Map<String, List<IndividualScore>> mockMap = this.createMockMap(gradableSteps.size());
				
				ModelAndView modelAndView = new ModelAndView();
				
				
				modelAndView.addObject(PROJECT_TITLE,project.getTitle());
				modelAndView.addObject(CURNIT_ID,curnitId);
				modelAndView.addObject(RUN_ID, runId);
				//modelAndView.addObject(CURNIT_MAP, curnitMap);
				modelAndView.addObject(SCORE_MAP, periodsToScoreLists);
				modelAndView.addObject(ALL_SCORES,allScores);
				
				return modelAndView;
			} else {
				return new ModelAndView(new RedirectView("../../accessdenied.html"));
			}
		} else {
			
			//throw error
			
		}// if
		
		ModelAndView modelAndView = new ModelAndView();

        return modelAndView;
	}


	/**
	 * Gets the individual score for a username
	 * 
	 * @param username - a username
	 * @param scoreList - list of scores
	 * 
	 * @return a score
	 */
	private IndividualScore getIndividualScore(String username, List<IndividualScore> scoreList) {
		for (IndividualScore individualScore : scoreList) {
			if( individualScore.getUsername().equals(username)) {
				return individualScore;
			}// if
		}// if
		
		return null;
	}

	/**
	 * @param gradingService the gradingService to set
	 */
	public void setGradingService(GradingService gradingService) {
		this.gradingService = gradingService;
	}
	
	/**
	 * a run service
	 * 
	 * @param runService
	 */
	public void setRunService(RunService runService) {
		this.runService = runService;
	}
	
	/**
	 * an annotationBundleService
	 * 
	 * @param annotationBundleService
	 */
	public void setAnnotationBundleService(
			AnnotationBundleService annotationBundleService) {
		this.annotationBundleService = annotationBundleService;
	}
	
	/**
	 * a workgroup service
	 * 
	 * @param workgroupService
	 */
	public void setWorkgroupService(WorkgroupService workgroupService) {
		this.workgroupService = workgroupService;
	}
	
//	private Map<String, List<IndividualScore>> createMockMap(int numberOfGradableSteps) {
//		
//		IndividualScoreNumericImpl score1 = new IndividualScoreNumericImpl();
//		score1.setUsername("supabob");
//		score1.setFirstName("bob");
//		score1.setLastName("guccie");
//		score1.setWorkgroup(null);
//		score1.setGroup(null);
//		score1.setTotalGradableSteps(new Integer(numberOfGradableSteps));
//		
//		score1.setAccmulatedScore("1", "20");
//		score1.setPossibleScore("1", "40");
//		
//		score1.setAccmulatedScore("2", "20");
//		score1.setPossibleScore("2", "40");
//		
//		score1.setAccmulatedScore("3", "unscored");
//		score1.setPossibleScore("3", "40");
//		
//		score1.setAccmulatedScore("4", "16");
//		score1.setPossibleScore("4", "40");
//		
//		IndividualScoreNumericImpl score2 = new IndividualScoreNumericImpl();
//		score2.setUsername("hepa");
//		score2.setFirstName("mary");
//		score2.setLastName("cary");
//		score2.setWorkgroup(null);
//		score2.setGroup(null);
//		score2.setTotalGradableSteps(new Integer(numberOfGradableSteps));
//		
//		score2.setAccmulatedScore("1", "20");
//		score2.setPossibleScore("1", "40");
//		
//		score2.setAccmulatedScore("2", "20");
//		score2.setPossibleScore("2", "40");
//		
//		score2.setAccmulatedScore("3", "33");
//		score2.setPossibleScore("3", "40");
//		
//		score2.setAccmulatedScore("4", "16");
//		score2.setPossibleScore("4", "40");
//		
//		IndividualScoreNumericImpl score3 = new IndividualScoreNumericImpl();
//		score3.setUsername("choosa");
//		score3.setFirstName("zack");
//		score3.setLastName("yupiey");
//		score3.setWorkgroup(null);
//		score3.setGroup(null);
//		
//		score3.setAccmulatedScore("1", "20");
//		score3.setPossibleScore("1", "40");
//		
//		score3.setAccmulatedScore("2", "20");
//		score3.setPossibleScore("2", "40");
//		
//		score3.setAccmulatedScore("3", "33");
//		score3.setPossibleScore("3", "40");
//		
//		score3.setAccmulatedScore("4", "16");
//		score3.setPossibleScore("4", "40");
//		score3.setTotalGradableSteps(new Integer(numberOfGradableSteps));
//		//map
//		
//		Map<String, List<IndividualScore>> periodsToScoreLists = new LinkedMap();
//		
//		
//		// score lists
//		List<IndividualScore> scoreList1 = new ArrayList<IndividualScore>();
//		scoreList1.add(score1);
//		scoreList1.add(score2);
//		scoreList1.add(score3);
//		
//		Collections.sort(scoreList1);
//		 
//		periodsToScoreLists.put("Period 1", scoreList1);
//		
//		
//		
//		List<IndividualScore> scoreList2 = new ArrayList<IndividualScore>();
//		scoreList2.add(score1);
//		scoreList2.add(score2);
//		
//		Collections.sort(scoreList2);
//		
//		periodsToScoreLists.put("Period 2", scoreList2);
//		
//		
//		List<IndividualScore> scoreList3 = new ArrayList<IndividualScore>();
//		scoreList3.add(score2);
//		
//		
//		Collections.sort(scoreList3);
//		
//		periodsToScoreLists.put("Period 3", scoreList3);
//		
//		allScores.addAll(scoreList1);
//		allScores.addAll(scoreList2);
//		allScores.addAll(scoreList3);
//		
//		Collections.sort(allScores);
//		
//		return periodsToScoreLists;
//		
//	}

}