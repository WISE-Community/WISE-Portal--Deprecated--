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

import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import org.apache.commons.lang.StringUtils;
import org.telscenter.pas.emf.pas.EActivity;
import org.telscenter.pas.emf.pas.EStep;
import org.telscenter.sail.webapp.presentation.util.NavStep;
import org.telscenter.sail.webapp.presentation.util.SessionNavLog;

import net.sf.sail.emf.sailuserdata.ESockEntry;
import net.sf.sail.emf.sailuserdata.ESockPart;
import net.sf.sail.webapp.domain.sessionbundle.SessionBundle;

/**
 * A representation of a specific SessionBundle's navigation log
 * 
 * @author patrick lawler
 * @version $Id:$
 */
public class SessionNavLogImpl implements SessionNavLog{
	
	private Set<NavStep> navSteps = new TreeSet<NavStep>();
	
	private long runId;
	
	private int openOffset;
	
	private List<EStep> allSteps;
	
	public SessionNavLogImpl(SessionBundle session, long runId, List<EStep> allSteps){
		this.runId = runId;
		this.allSteps = allSteps;
		try{
			createNavSteps(this.getNavLogs(session));
		}catch(Exception e){
			System.out.println(e);
			//error
		}
	}
	
	public SessionNavLogImpl(){}
	
	/**
	 * @see org.telscenter.sail.webapp.presentation.util.SessionNavLog#getNavSteps()
	 */
	public Set<NavStep> getNavSteps(){
		return this.navSteps;
	}
	
	/**
	 * @see org.telscenter.sail.webapp.presentation.util.SessionNavLog#getTotalTime()
	 */
	public int getTotalTime(){
		int total = 0;
		for(NavStep step : this.navSteps){
			total = total + step.getDurationMilliseconds();
		}
		return total;
	}
	
	/**
	 * @see org.telscenter.sail.webapp.presentation.util.SessionNavLog#getAverageTimeSpentPerStep()
	 */
	public int getAverageTimeSpentPerStep(){
		return this.getTotalTime() / this.navSteps.size();
	}
	
	/**
	 * @see org.telscenter.sail.webapp.presentation.util.SessionNavLog#getLongestTimeSpentStep
	 */
	public NavStep getLongestTimeSpentStep(){
		NavStep longest = null;
		for(NavStep step : this.navSteps){
			if(longest==null || step.getDurationMilliseconds() > longest.getDurationMilliseconds()){
				longest = step;
			}
		}
		return longest;
	}
	
	/**
	 * @see org.telscenter.sail.webapp.presentation.util.SessionNavLog#getLeastTimeSpentStep
	 */
	public NavStep getLeastTimeSpentStep(){
		NavStep shortest = null;
		for(NavStep step : this.navSteps){
			if(shortest==null || step.getDurationMilliseconds() < shortest.getDurationMilliseconds()){
				shortest = step;
			}
		}
		return shortest;
	}
	

	/**
	 * Given a <code>List<ESockEntry></code> creates and populates 
	 * <code>Set<NavStep></code>
	 * 
	 * @param <code>List<ESockEntry></code> navLogs
	 * @throws Exception
	 */
	private void createNavSteps(List<ESockEntry> navLogs) throws Exception{
		for(ESockEntry entry : navLogs){
			String activityType = this.activityType(entry.getValue());
			if(activityType.equals("project_open")){
				this.openOffset = entry.getMillisecondsOffset();
				NavStep navStep = new NavStep();
				navStep.setOpen(entry.getMillisecondsOffset() - openOffset);
				navStep.setPodId(null);
				this.navSteps.add(navStep);
			} else if(activityType.equals("step_open")){
				NavStep navStep = new NavStep();
				navStep.setOpen(entry.getMillisecondsOffset() - openOffset);
				EStep currentStep = this.getStepByPodUUID(this.podUUID(entry.getValue()), runId);
				navStep.setPodId(currentStep.getPodUUID().toString());
				navStep.setActivityNum(((EActivity) currentStep.eContainer()).getNumber());
				navStep.setStepNum(currentStep.getNumber());
				this.navSteps.add(navStep);
			} else if(activityType.equals("step_close")){
				String entryUUID = this.podUUID(entry.getValue());
				if(entryUUID.equals("null")){
					for(NavStep step : this.navSteps){
						if(step.getPodId()==null){
							this.navSteps.remove(step);
						}
					}
				} else {
					for(NavStep step : this.navSteps){
						if(step.getPodId()==null){
							step.setClose(entry.getMillisecondsOffset() - openOffset);
							EStep currentStep = this.getStepByPodUUID(entryUUID, runId);
							step.setPodId(currentStep.getPodUUID().toString());
							step.setActivityNum(((EActivity) currentStep.eContainer()).getNumber());
							step.setStepNum(currentStep.getNumber());
							break;
						} else if(step.getPodId().equals(entryUUID)){
							if(!step.isClosed()){
								step.setClose(entry.getMillisecondsOffset() - openOffset);
								break;
							}
						}
					}
				}
			} else if(activityType.equals("project_close")){
				for(NavStep step : this.navSteps){
					if(!step.isClosed()){
						step.setClose(entry.getMillisecondsOffset() - openOffset);
					}
				}
			} else {
				//error
			}
		}
	}
	
	/**
	 * Given a <code>SessionBundle</code> returns a <code>List<ESockEntry></code> list
	 * of navigation log entries
	 * 
	 * @param <code>SessionBundle</code> session
	 * @return <code>List<ESockEntry></code>
	 */
	@SuppressWarnings("unchecked")
	public List<ESockEntry> getNavLogs(SessionBundle session){
		List<ESockEntry> list = new ArrayList<ESockEntry>();
		for(ESockPart sockPart : (List<ESockPart>) session.getESessionBundle().getSockParts()){
			if(sockPart.getRimName().equals("navigation_log")){
				list.addAll(sockPart.getSockEntries());
			}
		}
		return list;
	}
	
	/**
	 * Given a <code>String</code> XML SockEntry, returns a <code>String</code>
	 * with the XML header info removed
	 * 
	 * @param <code>String</code> s
	 * @return <code>String</code>
	 */
	private String stripHead(String s){
		return StringUtils.strip(s.
				substring(StringUtils.indexOf(s, '>') + 1,StringUtils.lastIndexOf(s, '>')));
	}
	
	/**
	 * Given a <code>String</code> XML SockEntry, returns the <code>String</code>
	 * activityType
	 * 
	 * @param <code>String</code> s
	 * @return <code>String</code>
	 */
	public String activityType(String s){
		String headless = stripHead(s);
		return StringUtils.strip(headless.substring(StringUtils.indexOf(headless, '<') + 1, StringUtils.indexOf(headless, ' ')));
	}
	
	/**
	 * Given a <code>String</code> XML SockEntry, returns the <code>String</code>
	 * podUUID
	 * 
	 * @param <code>String</code> s
	 * @return <code>String</code>
	 */
	public String podUUID(String s){
		String headless = stripHead(s);
		return StringUtils.strip(headless.substring(StringUtils.indexOf(headless, '"') + 1, StringUtils.lastIndexOf(headless, '"')));
	}
	
	/**
	 * Given a <code>String</code> id (podUUID) and a <code>long</code> runId,
	 * returns the step that is associated with that run and that podUUID
	 * 
	 * @param <code>String</code> id
	 * @param <code>long</code> runId
	 * @return <code>EStep</code>
	 * @throws <code>ObjectNotFoundException</code> when no run is found with specified runId
	 */
	public EStep getStepByPodUUID(String id, long runId)throws Exception{
		for(EStep step : this.allSteps){
			if(step.getPodUUID().toString().equals(id)){
				return step;
			}
		}
		return null;
	}
}
