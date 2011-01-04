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
package org.telscenter.sail.webapp.presentation.web.controllers.student.brainstorm;

import java.io.Serializable;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.JAXBElement;

import org.imsglobal.xsd.imsqti_v2p0.ImgType;
import org.imsglobal.xsd.imsqti_v2p0.SimpleChoiceType;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import org.telscenter.sail.webapp.domain.brainstorm.Brainstorm;
import org.telscenter.sail.webapp.domain.brainstorm.answer.Answer;
import org.telscenter.sail.webapp.domain.brainstorm.answer.Revision;
import org.telscenter.sail.webapp.domain.brainstorm.answer.impl.RevisionImpl;
import org.telscenter.sail.webapp.presentation.google.charts.BarChart;
import org.telscenter.sail.webapp.presentation.google.charts.BarChartOptions;
import org.telscenter.sail.webapp.presentation.google.charts.impl.BarChartImpl;
import org.telscenter.sail.webapp.presentation.google.charts.impl.BarChartOptionsImpl;
import org.telscenter.sail.webapp.service.brainstorm.BrainstormService;

/**
 * @author patrick lawler
 * @version $Id:$
 */
public class ResultsGraphController extends AbstractController{

	private final static String XMLDOC = "xmlDoc";
	
	private final static String BRAINSTORMID = "brainstormId";
	
	private BrainstormService brainstormService;
	
	private final static Integer WIDTH = 800;
	
	private final static Integer HEIGHT = 350;
	
	/**
	 * @see org.springframework.web.servlet.mvc.AbstractController#handleRequestInternal(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	@Override
	protected ModelAndView handleRequestInternal(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		String xmlDoc;
		Brainstorm brainstorm = this.brainstormService.getBrainstormById(Long.parseLong(request.getParameter(BRAINSTORMID)));
		if(brainstorm.isPollEnded()){
			//Get and organize data
			Map<String,Integer> answerCount = new LinkedHashMap<String,Integer>();
			Map<String, Serializable> answerMap = new LinkedHashMap<String,Serializable>();
			answerMap = BrainstormUtils.getChoiceMap(brainstorm.getQuestion().getChoices());

			for(Answer answer : brainstorm.getAnswers()){
				Revision latestRevision = new RevisionImpl();
				for(Iterator<Revision> iterator = answer.getRevisions().iterator(); iterator.hasNext();){
					latestRevision = iterator.next();
				}
				if(answerCount.get(latestRevision.getBody())==null){
					answerCount.put(latestRevision.getBody(), 1);
				} else {
					answerCount.put(latestRevision.getBody(), answerCount.get(latestRevision.getBody()) + 1);
				}
			}
	
			Integer numOfChoices = answerMap.keySet().size();
			int highestCount = 0;
			
			List<Serializable> labels = new LinkedList<Serializable>();
			List<Integer> data = new LinkedList<Integer>();
			for(String key : answerMap.keySet()){
				if(isURL((String)answerMap.get(key))){
					labels.add(key);
				} else {
					labels.add(answerMap.get(key));
				}
				if(answerCount.get(key)!=null){
					highestCount = Math.max(highestCount, answerCount.get(key));
					data.add(answerCount.get(key));
				} else {
					data.add(0);
				}
			}
			
			BarChartOptions options = new BarChartOptionsImpl();
			BarChart chart = new BarChartImpl();
			chart.setChartSize(WIDTH, HEIGHT);
			chart.setOptions(options);
			chart.addData(data);
			
			options.addLabels("x", labels);
			options.addLabels("y", null);
			options.addScaling(0f, (float) highestCount);
			options.setBarWidthAndSpacing(WIDTH/(numOfChoices + 1), (WIDTH/(numOfChoices + 1))/10, 0);
			options.addAxisRange(1, 0, highestCount);
			options.addChartColor("000000ee");
			
			Map<String,Double> gradient = new LinkedHashMap<String, Double>();
			gradient.put("8844ff", 0.25);
			gradient.put("ff2244", 1.00);
			gradient.put("000000", 0.70);
			
			options.addLinearGradient("c", 45, gradient);
			options.addLinearGradient("bg", 45, gradient);
			options.addAxisStyle(0, "000000");
			options.addAxisStyle(1, "000000");
			
			xmlDoc = chart.getURL();
		} else {
			xmlDoc = "";
		}
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject(XMLDOC, xmlDoc);
		return modelAndView;
	}

	/**
	 * @param brainstormService the brainstormService to set
	 */
	public void setBrainstormService(BrainstormService brainstormService) {
		this.brainstormService = brainstormService;
	}
	
	private boolean isURL(String str){
		if(str.contains("img src=")){
			return true;
		};
		return false;
	}
}
