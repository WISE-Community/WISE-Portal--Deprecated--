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
package org.telscenter.sail.webapp.presentation.web.controllers.teacher.run.brainstorm;

import java.math.BigInteger;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.sail.jaxb.extension.JaxbQtiMarshallingUtils;

import org.imsglobal.xsd.imsqti_v2p0.AssessmentItemType;
import org.imsglobal.xsd.imsqti_v2p0.ChoiceInteractionType;
import org.imsglobal.xsd.imsqti_v2p0.ItemBodyType;
import org.imsglobal.xsd.imsqti_v2p0.ResponseProcessingType;
import org.imsglobal.xsd.imsqti_v2p0.SimpleChoiceType;
import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;
import org.springframework.web.servlet.view.RedirectView;
import org.telscenter.sail.webapp.domain.brainstorm.Brainstorm;
import org.telscenter.sail.webapp.domain.brainstorm.CreateSingleChoiceBrainstormParameters;
import org.telscenter.sail.webapp.domain.brainstorm.DisplayNameOption;
import org.telscenter.sail.webapp.domain.brainstorm.Questiontype;
import org.telscenter.sail.webapp.domain.brainstorm.impl.BrainstormImpl;
import org.telscenter.sail.webapp.domain.brainstorm.question.Question;
import org.telscenter.sail.webapp.domain.brainstorm.question.impl.JaxbQuestionImpl;
import org.telscenter.sail.webapp.presentation.web.controllers.student.brainstorm.BrainstormUtils;
import org.telscenter.sail.webapp.service.brainstorm.BrainstormService;
import org.telscenter.sail.webapp.service.offering.RunService;
import org.telscenter.sail.webapp.service.project.ProjectService;

/**
 * @author patrick lawler
 * @version $Id:$
 */
public class CreateSingleChoiceBrainstormController extends SimpleFormController{

	private BrainstormService brainstormService;
	
	private RunService runService;
	
	private ProjectService projectService;
	
	private final static String RUNID = "runId";
	
	private final static String PROJECTID = "projectId";
	
	private final static String VIEW = "/webapp/author/brainstorm/authorbrainstorm.html";
	
	private final static String BRAINSTORMID = "brainstormId";
	
	private final static String BRAINSTORM = "brainstorm";
	
	private final static String PART1 = "<assessmentItem xmlns=\"http://www.imsglobal.org/xsd/imsqti_v2p0\" xmlns:ns2=\"http://www.w3.org/1999/xlink\" xmlns:ns3=\"http://www.w3.org/1998/Math/MathML\" " +
		"identifier=\"choice\" adaptive=\"false\" timeDependent=\"false\">" +
		"<responseDeclaration identifier=\"RESPONSE\" cardinality=\"single\" baseType=\"identifier\">" +
		"<correctResponse>" +
		"<value>";
	
	private final static String PART2 = "</value>" +
		"</correctResponse>" +
		"</responseDeclaration>" +
		"<outcomeDeclaration identifier=\"SCORE\" cardinality=\"single\" baseType=\"integer\">" +
			"<defaultValue>" +
				"<value>0</value>" +
			"</defaultValue>" +
		"</outcomeDeclaration>" +
		"<itemBody>" +
		"<choiceInteraction responseIdentifier=\"RESPONSE\" shuffle=\"false\" maxChoices=\"1\">" +
			"<prompt>";
	
	private final static String PART3 = "</prompt>";
	
	private final static String PART4 = "</choiceInteraction>" +
		"</itemBody>" +
		"<responseProcessing template=\"http://www.imsglobal.org/question/qti_v2p1/rptemplates/match_correct\"/>" +
		"</assessmentItem>";	
	
	@Override
	protected Object formBackingObject(HttpServletRequest request) throws Exception {
		CreateSingleChoiceBrainstormParameters params = new CreateSingleChoiceBrainstormParameters();
		params.setRun(this.runService.retrieveById(Long.parseLong(request.getParameter(RUNID))));
		params.setProject(this.projectService.getById(Long.parseLong(request.getParameter(PROJECTID))));
		params.setQuestionType(Questiontype.SINGLE_CHOICE);
		return params;
	}
	
	/**
	 * @see org.springframework.web.servlet.mvc.SimpleFormController#onSubmit(javax.servlet.http.HttpServletRequest,
	 *      javax.servlet.http.HttpServletResponse, java.lang.Object,
	 *      org.springframework.validation.BindException)
	 */
	@Override
	protected ModelAndView onSubmit(HttpServletRequest request,
			HttpServletResponse response, Object command, BindException errors)
			throws Exception {
		CreateSingleChoiceBrainstormParameters params = (CreateSingleChoiceBrainstormParameters) command;
		
		Brainstorm brainstorm = new BrainstormImpl();
		brainstorm.setPollEnded(false);
		brainstorm.setInstantPollActive(false);
		brainstorm.setGated(params.isGated());
		brainstorm.setRichTextEditorAllowed(params.isRichTextEditorAllowed());
		brainstorm.setRun(params.getRun());
		brainstorm.setProject(params.getProject());
		brainstorm.setDisplayNameOption(params.getDisplayNameOption());
		brainstorm.setQuestiontype(params.getQuestionType());
		
		Question question = new JaxbQuestionImpl();
		String body;
		if(params.getCorrectChoice()==null || params.getCorrectChoice()==""){
			body = PART1 + PART2 + BrainstormUtils.replaceTags(params.getQuestion()) + PART3 + 
				BrainstormUtils.replaceSimpleChoiceStringTags(params.getChoices()) + PART4;
		} else {
			body = PART1 + params.getCorrectChoice() + PART2 + BrainstormUtils.replaceTags(params.getQuestion()) + 
				PART3 + BrainstormUtils.replaceSimpleChoiceStringTags(params.getChoices()) + PART4;
		}
		question.setBody(body);
		brainstorm.setQuestion(question);
		
		brainstormService.createBrainstorm(brainstorm);
		
		ModelAndView modelAndView = new ModelAndView(new RedirectView(VIEW));
		modelAndView.addObject(BRAINSTORMID, brainstorm.getId());
		modelAndView.addObject(BRAINSTORM, brainstorm);
		return modelAndView;
	}
	
	/**
	 * @see org.springframework.web.servlet.mvc.SimpleFormController#referenceData(javax.servlet.http.HttpServletRequest)
	 */
	@Override
	protected Map<String, Object> referenceData(HttpServletRequest request) throws Exception {
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("displayNameOptions", DisplayNameOption.values());
		return model;
	}

	/**
	 * @param brainstormService the brainstormService to set
	 */
	public void setBrainstormService(BrainstormService brainstormService) {
		this.brainstormService = brainstormService;
	}

	/**
	 * @param runService the runService to set
	 */
	public void setRunService(RunService runService) {
		this.runService = runService;
	}

	/**
	 * @param projectService the projectService to set
	 */
	public void setProjectService(ProjectService projectService) {
		this.projectService = projectService;
	}
	
}
