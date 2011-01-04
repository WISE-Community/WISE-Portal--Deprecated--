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

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;
import org.springframework.web.servlet.view.RedirectView;
import org.telscenter.sail.webapp.domain.brainstorm.Brainstorm;
import org.telscenter.sail.webapp.domain.brainstorm.CreateOpenResponseBrainstormParameters;
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
public class CreateOpenResponseBrainstormController extends SimpleFormController {

	private BrainstormService brainstormService;
	
	private RunService runService;
	
	private ProjectService projectService;
	
	private final static String RUNID = "runId";
	
	private final static String PROJECTID = "projectId";
	
	private final static String VIEW = "/webapp/author/brainstorm/authorbrainstorm.html";
	
	private final static String BRAINSTORMID = "brainstormId";
	
	private final static String BRAINSTORM = "brainstorm";
	
	private final static String PART1 =	
		"<assessmentItem xmlns=\"http://www.imsglobal.org/xsd/imsqti_v2p0\" xmlns:ns2=\"http://www.w3.org/1999/xlink\" xmlns:ns3=\"http://www.w3.org/1998/Math/MathML\" timeDependent=\"false\" adaptive=\"false\">" +
        "<responseDeclaration identifier=\"TEXT_NOTE_ID\"/>" +
        "<itemBody>" +
        "<extendedTextInteraction hasInlineFeedback=\"false\" placeholderText=\"question here\" responseIdentifier=\"TEXT_NOTE_ID\" expectedLines=\"6\">" +
            "<prompt>";
	
	private final static String PART2 = "</prompt>" +
    	"</extendedTextInteraction>" +
    	"</itemBody>" +
    	"</assessmentItem>";
		
	
	@Override
	protected Object formBackingObject(HttpServletRequest request) throws Exception {
		CreateOpenResponseBrainstormParameters params = new CreateOpenResponseBrainstormParameters();
		params.setRun(this.runService.retrieveById(Long.parseLong(request.getParameter(RUNID))));
		params.setProject(this.projectService.getById(Long.parseLong(request.getParameter(PROJECTID))));
		params.setQuestionType(Questiontype.OPEN_RESPONSE);
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
		CreateOpenResponseBrainstormParameters params = (CreateOpenResponseBrainstormParameters) command;
		
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
		question.setBody(PART1 + BrainstormUtils.replaceTags(params.getQuestion()) + PART2);
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