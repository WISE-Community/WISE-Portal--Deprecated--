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
package org.telscenter.sail.webapp.presentation.web.controllers.teacher.reports;

import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
import java.util.TreeSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import org.telscenter.pas.emf.pas.EStep;
import org.telscenter.sail.webapp.domain.Run;
import org.telscenter.sail.webapp.domain.workgroup.WISEWorkgroup;
import org.telscenter.sail.webapp.presentation.google.charts.BarChart;
import org.telscenter.sail.webapp.presentation.google.charts.BarChartOptions;
import org.telscenter.sail.webapp.presentation.google.charts.impl.BarChartImpl;
import org.telscenter.sail.webapp.presentation.google.charts.impl.BarChartOptionsImpl;
import org.telscenter.sail.webapp.presentation.util.WorkgroupNavLog;
import org.telscenter.sail.webapp.presentation.util.impl.WorkgroupNavLogImpl;
import org.telscenter.sail.webapp.service.grading.GradingService;
import org.telscenter.sail.webapp.service.offering.RunService;
import org.telscenter.sail.webapp.service.workgroup.WISEWorkgroupService;

/**
 * @author patrick lawler
 * @version $Id:$
 */
public class TotalTimePerStepController extends AbstractController{

	private RunService runService;
	
	private WISEWorkgroupService workgroupService;
	
	private GradingService gradingService;
	
	private final static String RUNID = "runId";
	
	private final static String WORKGROUPIDS = "workgroupIds";
	
	private final static String WORKGROUPS = "workgroups";
	
	private final static String URL = "url";
	
	private final static int WIDTH = 750;
	
	private final static int HEIGHT = 400;
	
	private List<EStep> allSteps;
	
	/**
	 * @see org.springframework.web.servlet.mvc.AbstractController#handleRequestInternal(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	@SuppressWarnings("unchecked")
	@Override
	protected ModelAndView handleRequestInternal(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		Run run = this.runService.retrieveById(Long.parseLong(request.getParameter(RUNID)));
		this.allSteps = this.gradingService.getSteps(run.getId());
		Set<WISEWorkgroup> workgroups = new TreeSet<WISEWorkgroup>();
		parseIDs(workgroups, request.getParameter(WORKGROUPIDS));
		
		List<WorkgroupNavLog> navLogLists = new LinkedList<WorkgroupNavLog>();
		for(WISEWorkgroup workgroup : workgroups){
			navLogLists.add(new WorkgroupNavLogImpl(run.getId(), workgroup.getId(), this.allSteps));
		}
		Map<String,Float> averagedData = getAverages(navLogLists);
		float longest = this.getLongestTime(navLogLists);
		NumberFormat nf = NumberFormat.getInstance();
		nf.setMaximumFractionDigits(2);
		
		BarChart chart = new BarChartImpl();
		chart.setChartSize(WIDTH,HEIGHT);
		chart.addData(new LinkedList<Float>(averagedData.values()));
		chart.setOrientation("v");
		
		BarChartOptions options = new BarChartOptionsImpl();
		options.addScaling(0, longest);
		
		//check for amount of data -- if off chart make adjustments to granularity,
		//spacing, and x-axis labels
		List rawLabels = new ArrayList(averagedData.keySet());
		if(averagedData.size() > 25){
			List xLabelsInner = new ArrayList();
			List xLabelsOuter = new ArrayList();
			Integer size = ((WIDTH - (averagedData.size() * 5))/ averagedData.size()) - 1;
			options.setBarWidthAndSpacing(size, 5, 0);
			
			for(int x = 0; x < rawLabels.size(); x++){
				if(x%2 != 0){
					xLabelsOuter.add(rawLabels.get(x));
					xLabelsInner.add("");
				} else {
					xLabelsInner.add(rawLabels.get(x));
					xLabelsOuter.add("");
				}
			}
			options.addLabels("x", xLabelsInner);
			options.addLabels("x", xLabelsOuter);
			options.addAxisStyle(0, "666666", 9);
			options.addAxisStyle(1, "666666", 9);
		} else {
			options.addLabels("x", rawLabels);
			options.addAxisStyle(0, "666666", 9);
		}
		
		//y-axis labels and their position on the axis
		List yLabels = new LinkedList();
		List<Float> labelPos = new LinkedList<Float>();
		for(float x = 0f; x <= 100; x+= 10){
			labelPos.add(x);
		}
		
		float stepSize = longest/10;
		for(float x = 0; x <= longest; x += stepSize){
			yLabels.add(Float.parseFloat(nf.format(x)));
		}
		options.addLabels("y", yLabels);
		options.addLabelPosition(2, labelPos);

		
		chart.setOptions(options);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject(WORKGROUPS, workgroups);
		modelAndView.addObject(URL, chart.getURL());
		
		return modelAndView;
	}
	
	/**
	 * Recursive function to parse a <code>String</code> of ids. Retrieves and 
	 * adds the <code>WISEWorkgroup</code> to the provided <code>Set<WISEWorkgroup></code>.
	 * 
	 * @param <code>Set<WISEWorkgroup></code> workgroups
	 * @param <code>String</code> ids
	 * @throws <code>Exception</code> when a parsed id does not exist in the data store
	 */
	private void parseIDs(Set<WISEWorkgroup> workgroups, String ids)throws Exception{
		if(ids == null || ids.length() < 1){
			return;
		} else if(ids.indexOf(",") == -1){
			workgroups.add((WISEWorkgroup)this.workgroupService.retrieveById(Long.parseLong(ids)));
			return;
		} else {
			workgroups.add((WISEWorkgroup)this.workgroupService.retrieveById(Long.parseLong(ids.substring(0,ids.indexOf(",")))));
			parseIDs(workgroups, ids.substring(ids.indexOf(",") + 1));
		}
	}
	
	/**
	 * Provided a <code>List<WorkgroupNavLog>, returns a <code>Map<String,Float></code>
	 * of the average time spent on a given step.
	 * 
	 * @param <code>List<WorkgroupNavLog></code> navLogLists
	 * @return <code>Map<String,Float></code>
	 */
	private Map<String,Float> getAverages(List<WorkgroupNavLog> navLogLists){
		Map<String,Float> averagedData = new TreeMap<String,Float>();
		Map<String,Float> counts = new TreeMap<String,Float>();
		for(WorkgroupNavLog log : navLogLists){
			Map<String,Float> timeStepMap = log.getTotalTimePerStepMap();
			for(String key : timeStepMap.keySet()){
				boolean exists = false;
				for(String existingKey : averagedData.keySet()){
					if(key.equals(existingKey)){
						exists = true;
						float currentCount = counts.get(key);
						averagedData.put(key, (averagedData.get(key) * (currentCount/(currentCount + 1))) 
								+ (timeStepMap.get(key) * (1/(currentCount + 1))));
						counts.put(key, currentCount + 1f);
					}
				}
				if(!exists){
					averagedData.put(key, timeStepMap.get(key));
					counts.put(key, 1f);
				}
			}
		}
		return averagedData;
	}
	
	/**
	 * 
	 * @param <code>List<WorkgroupNavLog></code> logs
	 * @return <code>float</code>
	 */
	public float getLongestTime(List<WorkgroupNavLog> logs){
		float longest = 0f;
		for(WorkgroupNavLog log : logs){
			float logLongest = 0f;
			if(log.getLongestTimeSpentStep()!=null){
				logLongest = log.getLongestTimeSpentStep().getDurationMinutes();
			}
			longest = Math.max(longest, logLongest);
		}
		return longest;
	}

	/**
	 * @param runService the runService to set
	 */
	public void setRunService(RunService runService) {
		this.runService = runService;
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
		this.gradingService = gradingService;
	}
}
