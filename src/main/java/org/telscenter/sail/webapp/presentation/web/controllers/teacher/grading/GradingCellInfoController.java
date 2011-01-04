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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.List;
import java.util.TreeSet;

import net.sf.sail.webapp.domain.sessionbundle.SessionBundle;
import net.sf.sail.emf.sailuserdata.EAnnotation;
import net.sf.sail.emf.sailuserdata.EAnnotationGroup;
import net.sf.sail.emf.sailuserdata.ESockEntry;
import net.sf.sail.emf.sailuserdata.ESockPart;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import org.telscenter.pas.emf.pas.EActivity;
import org.telscenter.pas.emf.pas.ERim;
import org.telscenter.pas.emf.pas.EStep;
import org.telscenter.sail.webapp.domain.Run;
import org.telscenter.sail.webapp.domain.grading.GradeWorkByWorkgroupAggregate;
import org.telscenter.sail.webapp.domain.workgroup.WISEWorkgroup;
import org.telscenter.sail.webapp.service.grading.GradingService;
import org.telscenter.sail.webapp.service.offering.RunService;
import org.telscenter.sail.webapp.service.workgroup.WISEWorkgroupService;

/**
 * @author patrick lawler
 *
 */
public class GradingCellInfoController extends AbstractController{
	
	private final static String RUNID = "runId";
	
	private final static String WORKGROUPID = "workgroupId";
	
	private final static String PODUUID = "podUUID";
	
	private final static String XMLDOC = "xmlDoc";
	
	private GradingService gradingService;
	
	private WISEWorkgroupService workgroupService;
	
	private RunService runService;

	/**
	 * @see org.springframework.web.servlet.mvc.AbstractController#handleRequestInternal(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	@SuppressWarnings("unchecked")
	@Override
	protected ModelAndView handleRequestInternal(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
				
		WISEWorkgroup workgroup = (WISEWorkgroup) this.workgroupService.retrieveById(Long.parseLong(request.getParameter(WORKGROUPID)));
		Run run = this.runService.retrieveById(Long.parseLong(request.getParameter(RUNID)));
		//get aggregate for the specified workgroup for this run
		GradeWorkByWorkgroupAggregate aggregate = this.gradingService.getGradeWorkByWorkgroupAggregate(run.getId(), workgroup);

		String xmlDoc = "<gradingcellinfo>";
		String UUID = request.getParameter(PODUUID);		

		if (UUID != null) {
			// this request is made from a grade-by-step page
			
			//get step for this cell
			EStep thisStep = null;
			List<EActivity> activities = this.gradingService.getCurnitmap(run.getId()).getProject().getActivity();
			for(EActivity activity : activities){
				for(EStep step : (List<EStep>) activity.getStep()){
					if(step.getPodUUID().toString().equals(UUID))
						thisStep = step;
				}
			}

			//get score and teacher comments for this step and add them to xmlDoc
			List<EAnnotationGroup> annotationGroups = aggregate.getAnnotationBundle().getEAnnotationBundle().getAnnotationGroups();
			for(EAnnotationGroup annotationGroup : annotationGroups){
				for(EAnnotation annotation : (List<EAnnotation>) annotationGroup.getAnnotations()){
					if(UUID.equals(annotation.getEntityUUID().toString())){
						if(annotationGroup.getAnnotationSource().equals("http://telscenter.org/annotation/comments") && annotation.getEntityName() == null){
							xmlDoc = xmlDoc + "<comments>" + annotation.getContents() + "</comments>";
						}
						if(annotationGroup.getAnnotationSource().equals("http://telscenter.org/annotation/score")){
							xmlDoc = xmlDoc + "<score>" + annotation.getContents() + "</score>";
						}
					}
				}
			}

			//get prompts and responses for this cell and add them to xmlDoc
			// since they don't appear in order of the parts (instead, they appear in the order of timestamp when
			// student entered their response), we need to establish order by comparing the rimname.
			String prompt = null;
			String answer = null;
			TreeSet<PromptResponse> promptResponses = new TreeSet<PromptResponse>();
			for(ERim rim : (List<ERim>) thisStep.getRim()){			
				prompt = this.extractBody(rim.getPrompt());
				for(SessionBundle sessionBundle : aggregate.getSessionBundles()){
					for(ESockPart sockPart : (List<ESockPart>) sessionBundle.getESessionBundle().getSockParts()){
						if(sockPart.getPodId().equals(thisStep.getPodUUID()) && sockPart.getRimName().equals(rim.getRimname())){
							answer = ((ESockEntry)sockPart.getSockEntries().get(sockPart.getSockEntries().size() -1)).getValue();
						}
					}
				}
				if(answer == null)
					answer = "no student response yet";

				PromptResponse promptResponse = new PromptResponse();
				promptResponse.setPrompt(prompt);
				promptResponse.setResponse(answer);
				promptResponse.setRimName(rim.getRimname());
				promptResponses.add(promptResponse);
				prompt = null;
				answer = null;
			}


			//xmlDoc = xmlDoc + responseDoc;
			for (PromptResponse pr : promptResponses) {
				xmlDoc += "<promptresponse><prompt>" + pr.getPrompt() + "</prompt><response>" +
				pr.getResponse() + "</response></promptresponse>";
			}

		} else {
			// this request was made from grade-by-workgroup page
			
			//get step for this cell
			EStep thisStep = null;
			List<EActivity> activities = this.gradingService.getCurnitmap(run.getId()).getProject().getActivity();
			for(EActivity activity : activities){
				for(EStep step : (List<EStep>) activity.getStep()){
					if(step.getPodUUID().toString().equals(UUID))
						thisStep = step;
				}
			}

			//get score and teacher comments for this step and add them to xmlDoc
			List<EAnnotationGroup> annotationGroups = aggregate.getAnnotationBundle().getEAnnotationBundle().getAnnotationGroups();
			for(EAnnotationGroup annotationGroup : annotationGroups){
				for(EAnnotation annotation : (List<EAnnotation>) annotationGroup.getAnnotations()){
					if(UUID.equals(annotation.getEntityUUID().toString())){
						if(annotationGroup.getAnnotationSource().equals("http://telscenter.org/annotation/comments") && annotation.getEntityName() == null){
							xmlDoc = xmlDoc + "<comments>" + annotation.getContents() + "</comments>";
						}
						if(annotationGroup.getAnnotationSource().equals("http://telscenter.org/annotation/score")){
							xmlDoc = xmlDoc + "<score>" + annotation.getContents() + "</score>";
						}
					}
				}
			}

			//get prompts and responses for this cell and add them to xmlDoc
			// since they don't appear in order of the parts (instead, they appear in the order of timestamp when
			// student entered their response), we need to establish order by comparing the rimname.
			String prompt = null;
			String answer = null;
			TreeSet<PromptResponse> promptResponses = new TreeSet<PromptResponse>();
			for(ERim rim : (List<ERim>) thisStep.getRim()){			
				prompt = this.extractBody(rim.getPrompt());
				for(SessionBundle sessionBundle : aggregate.getSessionBundles()){
					for(ESockPart sockPart : (List<ESockPart>) sessionBundle.getESessionBundle().getSockParts()){
						if(sockPart.getPodId().equals(thisStep.getPodUUID()) && sockPart.getRimName().equals(rim.getRimname())){
							answer = ((ESockEntry)sockPart.getSockEntries().get(sockPart.getSockEntries().size() -1)).getValue();
						}
					}
				}
				if(answer == null)
					answer = "no student response yet";

				PromptResponse promptResponse = new PromptResponse();
				promptResponse.setPrompt(prompt);
				promptResponse.setResponse(answer);
				promptResponse.setRimName(rim.getRimname());
				promptResponses.add(promptResponse);
				prompt = null;
				answer = null;
			}


			//xmlDoc = xmlDoc + responseDoc;
			for (PromptResponse pr : promptResponses) {
				xmlDoc += "<promptresponse><prompt>" + pr.getPrompt() + "</prompt><response>" +
				pr.getResponse() + "</response></promptresponse>";
			}
		}
		
		//closing tag of xmlDoc
		xmlDoc = xmlDoc + "</gradingcellinfo>";

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject(XMLDOC, xmlDoc);

		return modelAndView;
	}
	
	class PromptResponse implements Comparable<PromptResponse> {

		private String rimName;
		
		private String prompt;
		
		private String response;
		
		/**
		 * @return the prompt
		 */
		public String getPrompt() {
			return prompt;
		}

		/**
		 * @param prompt the prompt to set
		 */
		public void setPrompt(String prompt) {
			this.prompt = prompt;
		}

		/**
		 * @return the response
		 */
		public String getResponse() {
			return response;
		}

		/**
		 * @param response the response to set
		 */
		public void setResponse(String response) {
			this.response = response;
		}

		/**
		 * @return the rimName
		 */
		public String getRimName() {
			return rimName;
		}

		/**
		 * @param rimName the rimName to set
		 */
		public void setRimName(String rimName) {
			this.rimName = rimName;
		}
		
		public int compareTo(PromptResponse o) {
			return this.rimName.compareTo(o.rimName);
		}
	}
	
	/**
	 * extract the html from the body
	 * 
	 * @param prompt
	 * @return
	 */
	public String extractBody(String prompt) {
		  int start = prompt.indexOf("<body>");
		  int end = prompt.indexOf("</body>");
		  String extractedBody = "";
		  
		  if (start != -1 && end != -1) {
		   extractedBody = prompt.substring(start+6, end);
		   return extractedBody;
		  }   
		  return prompt;
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

	/**
	 * @param runService the runService to set
	 */
	public void setRunService(RunService runService) {
		this.runService = runService;
	}
}
