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
package org.telscenter.sail.webapp.presentation.web.controllers.teacher.reports;

import java.text.NumberFormat;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import org.telscenter.pas.emf.pas.EActivity;
import org.telscenter.pas.emf.pas.EStep;
import org.telscenter.sail.webapp.domain.Run;
import org.telscenter.sail.webapp.domain.workgroup.WISEWorkgroup;
import org.telscenter.sail.webapp.presentation.google.charts.LineChart;
import org.telscenter.sail.webapp.presentation.google.charts.LineChartOptions;
import org.telscenter.sail.webapp.presentation.google.charts.impl.LineChartImpl;
import org.telscenter.sail.webapp.presentation.google.charts.impl.LineChartOptionsImpl;
import org.telscenter.sail.webapp.presentation.util.NavStep;
import org.telscenter.sail.webapp.presentation.util.WorkgroupNavLog;
import org.telscenter.sail.webapp.presentation.util.impl.WorkgroupNavLogImpl;
import org.telscenter.sail.webapp.service.offering.RunService;
import org.telscenter.sail.webapp.service.workgroup.WISEWorkgroupService;

/**
 * @author patrick lawler
 *
 */
public class StepActivityGraphController extends AbstractController {
	
	private RunService runService;
	
	private WISEWorkgroupService workgroupService;
	
	private List<EStep> allSteps;
	
	private final static String RUNID = "runId";
	
	private final static String WORKGROUPID = "workgroupId";
	
	private final static String WORKGROUP = "workgroup";
	
	private final static String URL = "url";
	
	private final static int CHARTWIDTH = 750;
	
	private final static int CHARTHEIGHT = 400;
	
	private NumberFormat nf = NumberFormat.getInstance();
	
	/**
	 * @see org.springframework.web.servlet.mvc.AbstractController#handleRequestInternal(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	@SuppressWarnings("unchecked")
	@Override
	protected ModelAndView handleRequestInternal(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		nf.setMaximumFractionDigits(1);
		Run run = this.runService.retrieveById(Long.parseLong(request.getParameter(RUNID)));
		WISEWorkgroup workgroup = (WISEWorkgroup) this.workgroupService.retrieveById(Long.parseLong(request.getParameter(WORKGROUPID)));
		WorkgroupNavLog workgroupNavLog = new WorkgroupNavLogImpl(run.getId(),workgroup.getId());
		
		allSteps = workgroupNavLog.getAllSteps();
		
		List<Float> xdata = new LinkedList<Float>();
		List<NavStep> yData = new LinkedList<NavStep>(workgroupNavLog.getTimeStepMap().values());
		List<Integer> ydata = new LinkedList<Integer>();
		
		float currentTime = 0f;
		for(NavStep step : yData){
			xdata.add(Float.parseFloat(nf.format(currentTime)));
			ydata.add(this.getLocation(step));
			currentTime = currentTime + step.getDurationMinutes();
			xdata.add(Float.parseFloat(nf.format(currentTime)));
			ydata.add(this.getLocation(step));
			xdata.add(-1f);
			ydata.add(-1);
		}

		List<String> yLabels = new LinkedList<String>();
		yLabels.add("");
		for(EStep step : allSteps){
			yLabels.add(this.getActivityStep(step));
		}
		
		List<String> xLabels = new LinkedList<String>();
		float stepSize = currentTime / 20;
		for(float x = 0f; x <= currentTime; x += stepSize){
			xLabels.add(nf.format(x));
		}
				
		LineChartOptions options = new LineChartOptionsImpl();
		LineChart chart = new LineChartImpl();
		chart.setChartSize(CHARTWIDTH, CHARTHEIGHT);
		chart.setXYType(true);
		
		options.addScaling(0, currentTime);
		options.addScaling(-1, allSteps.size());
		options.addLabels("x", xLabels);
		options.addLabels("y", yLabels);
		options.addGridLines(0, 100d / yLabels.size());
		
		chart.addData(xdata);
		chart.addData(ydata);
		chart.setOptions(options);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject(WORKGROUP, workgroup);
		modelAndView.addObject(URL, chart.getURL());
		
		return modelAndView;
	}

	private int getLocation(NavStep step){
		for(EStep eStep : allSteps){
			if(eStep.getPodUUID().toString().equals(step.getPodId())){
				return allSteps.indexOf(eStep);
			}
		}
		return -1;
	}
	
	private String getActivityStep(EStep step){
		return "A" + (Integer.parseInt(((EActivity) step.eContainer()).getNumber()) + 1) 
			+ " S" + (Integer.parseInt(step.getNumber()) + 1);
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
}
