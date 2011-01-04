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
package org.telscenter.sail.webapp.presentation.util.impl;

import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import net.sf.sail.webapp.domain.sessionbundle.SessionBundle;

import org.telscenter.pas.emf.pas.EStep;
import org.telscenter.sail.webapp.domain.workgroup.WISEWorkgroup;
import org.telscenter.sail.webapp.presentation.util.NavStep;
import org.telscenter.sail.webapp.presentation.util.SessionNavLog;
import org.telscenter.sail.webapp.presentation.util.WorkgroupNavLog;
import org.telscenter.sail.webapp.service.grading.GradingService;
import org.telscenter.sail.webapp.service.grading.SessionBundleService;
import org.telscenter.sail.webapp.service.workgroup.WISEWorkgroupService;

/**
 * @author patrick lawler
 * @version $Id:$
 */
public class WorkgroupNavLogImpl implements WorkgroupNavLog {

	private List<SessionNavLog> sessionNavLogs = new LinkedList<SessionNavLog>();
	
	private List<NavStep> collapsed = new LinkedList<NavStep>();
	
	private WISEWorkgroup workgroup;
	
	private static SessionBundleService sessionBundleService;

	private static WISEWorkgroupService workgroupService;
	
	private static GradingService gradingService;
	
	private List<EStep> allSteps;
	
	public WorkgroupNavLogImpl(){}
	
	public WorkgroupNavLogImpl(long runId, long workgroupId) throws Exception{
		this.allSteps = this.gradingService.getSteps(runId);
		workgroup = (WISEWorkgroup) this.workgroupService.retrieveById(workgroupId); 
		for(SessionBundle session : this.sessionBundleService.getSessionBundles(runId, workgroup)){
			sessionNavLogs.add(new SessionNavLogImpl(session, runId, this.allSteps));
		}
		collapse();		
	}
	
	public WorkgroupNavLogImpl(long runId, long workgroupId, List<EStep> allSteps) throws Exception{
		this.allSteps = allSteps;
		workgroup = (WISEWorkgroup) this.workgroupService.retrieveById(workgroupId); 
		for(SessionBundle session : this.sessionBundleService.getSessionBundles(runId, workgroup)){
			sessionNavLogs.add(new SessionNavLogImpl(session, runId, this.allSteps));
		}
		collapse();
	}
	
	/**
	 * @see org.telscenter.sail.webapp.presentation.util.WorkgroupNavLog#getTotalTime()
	 */
	public int getTotalTime(){
		int total = 0;
		for(SessionNavLog session : sessionNavLogs){
			total = total + session.getTotalTime();
		}
		return total;
	}
	
	/**
	 * @see org.telscenter.sail.webapp.presentation.util.WorkgroupNavLog#getAverageTimeSpentPerStep()
	 */
	public int getAverageTimeSpentPerStep(){
		int total = 0;
		for(NavStep step : collapsed){
			total = total + step.getDurationMilliseconds();
		}
		return total / getNumOfSteps();
	}
	
	/**
	 * @see org.telscenter.sail.webapp.presentation.util.WorkgroupNavLog#getAverageTimeSpentPerVisit()
	 */
	public int getAverageTimeSpentPerVisit(){
		return getTotalTime() / getNumOfVisits();
	}
	
	/**
	 * @see org.telscenter.sail.webapp.presentation.util.WorkgroupNavLog#getNumOfSteps()
	 */
	public int getNumOfSteps(){
		return collapsed.size();
	}
	
	/**
	 * @see org.telscenter.sail.webapp.presentation.util.WorkgroupNavLog#getNumOfVisits()
	 */
	public int getNumOfVisits(){
		int total = 0;
		for(SessionNavLog session : sessionNavLogs){
			total = total + session.getNavSteps().size();
		}
		return total;
	}
	
	/**
	 * @see org.telscenter.sail.webapp.presentation.util.WorkgroupNavLog#getLongestTimeSpentStep()
	 */
	public NavStep getLongestTimeSpentStep(){
		NavStep longest = null;
		for(NavStep step : collapsed){
			if(longest==null || step.getDurationMilliseconds() > longest.getDurationMilliseconds()){
				longest = step;
			}
		}
		return longest;
	}
	
	/**
	 * @see org.telscenter.sail.webapp.presentation.util.WorkgroupNavLog#getLongestTimeSpentVisit()
	 */
	public NavStep getLongestTimeSpentVisit(){
		NavStep longest = null;
		for(SessionNavLog session : this.sessionNavLogs){
			if(longest==null || session.getLongestTimeSpentStep().getDurationMilliseconds() 
					> longest.getDurationMilliseconds()){
				longest = session.getLongestTimeSpentStep();
			}
		}
		return longest;
	}
	
	/**
	 * @see org.telscenter.sail.webapp.presentation.util.WorkgroupNavLog#getLeastTimeSpentStep()
	 */
	public NavStep getLeastTimeSpentStep(){
		NavStep least = null;
		for(NavStep step : collapsed){
			if(least==null || step.getDurationMilliseconds()< least.getDurationMilliseconds()){
				least = step;
			}
		}
		return least;
	}
	
	/**
	 * @see org.telscenter.sail.webapp.presentation.util.WorkgroupNavLog#getLeastTimeSpentVisit()
	 */
	public NavStep getLeastTimeSpentVisit(){
		NavStep least = null;
		for(SessionNavLog session : this.sessionNavLogs){
			if(least==null || session.getLeastTimeSpentStep().getDurationMilliseconds() 
					< least.getDurationMilliseconds()){
				least = session.getLeastTimeSpentStep();
			}
		}
		return least;
	}
	
	/**
	 * @see org.telscenter.sail.webapp.presentation.util.WorkgroupNavLog#getTimeStepMap()
	 */
	public Map<Float,NavStep> getTimeStepMap(){
		Map<Float,NavStep> timeStepMap = new TreeMap<Float,NavStep>();
		float currentTime = 0f;
		
		for(SessionNavLog session : this.sessionNavLogs){
			for(NavStep step : session.getNavSteps()){
				timeStepMap.put(currentTime, step);
				currentTime = currentTime + step.getDurationMinutes();
			}
		}
		
		return timeStepMap;
	}
	
	/**
	 * @see org.telscenter.sail.webapp.presentation.util.WorkgroupNavLog#getTotalTimePerStepMap()
	 */
	public Map<String,Float> getTotalTimePerStepMap(){
		Map<String,Float> totalTimeMap = new TreeMap<String,Float>();
		
		for(NavStep step : collapsed){
			totalTimeMap.put(step.getActivityStepString(), step.getDurationMinutes());
		}
		
		return totalTimeMap;
	}
		
	/**
	 * Conflates all equivalent NavSteps from all sessions (if more than
	 * one NavStep, it means the student has visited that step multiple times)
	 */
	private void collapse(){
		for(SessionNavLog session : sessionNavLogs){
			for(NavStep step : session.getNavSteps()){
				NavStep adjust = exists(step);
				if(adjust==null){
					collapsed.add(step.copy());
				} else {
					adjust.setClose(adjust.getClose() +  step.getDurationMilliseconds());
				}
			}
		}
	}
	
	/**
	 * Given a <code>NavStep</code> searches this.collapsed for an already
	 * existing step. If it is found, returns that NavStep, if not, returns null
	 * 
	 * @param <code>NavStep</code> outerStep
	 * @return <code>NavStep</code>
	 */
	private NavStep exists(NavStep outerStep){
		for(NavStep innerStep : collapsed){
			if(outerStep.getUniqueOrderedNum().equals(innerStep.getUniqueOrderedNum())){
				return innerStep;
			}
		}
		return null;
	}

	/**
	 * @return the allSteps
	 */
	public List<EStep> getAllSteps() {
		return allSteps;
	}

	/**
	 * @param allSteps the allSteps to set
	 */
	public void setAllSteps(List<EStep> allSteps) {
		this.allSteps = allSteps;
	}

	/**
	 * @param sessionBundleService the sessionBundleService to set
	 */
	public void setSessionBundleService(SessionBundleService sessionBundleService) {
		this.sessionBundleService = sessionBundleService;
	}

	/**
	 * @param workgroupService the workgroupService to set
	 */
	public void setWorkgroupService(WISEWorkgroupService workgroupService) {
		this.workgroupService = workgroupService;
	}
	
	/**
	 * @param gradingService the gradingService to set
	 */
	public void setGradingService(GradingService gradingService) {
		WorkgroupNavLogImpl.gradingService = gradingService;
	}
}
