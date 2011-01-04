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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.sail.webapp.domain.User;
import net.sf.sail.webapp.presentation.web.controllers.ControllerUtil;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.AbstractController;
import org.springframework.web.servlet.view.RedirectView;
import org.telscenter.sail.webapp.domain.Run;
import org.telscenter.sail.webapp.domain.brainstorm.Brainstorm;
import org.telscenter.sail.webapp.domain.brainstorm.DisplayNameOption;
import org.telscenter.sail.webapp.domain.brainstorm.impl.BrainstormImpl;
import org.telscenter.sail.webapp.domain.brainstorm.question.Question;
import org.telscenter.sail.webapp.domain.brainstorm.question.impl.JaxbQuestionImpl;
import org.telscenter.sail.webapp.domain.project.Project;
import org.telscenter.sail.webapp.service.brainstorm.BrainstormService;
import org.telscenter.sail.webapp.service.offering.RunService;
import org.telscenter.sail.webapp.service.project.ProjectService;

/**
 * Creates a dummy brainstorm for a run that is specified in the request.
 * For creating a brainstorm for a project, see createBrainstormQuestionController
 * 
 * @author hirokiterashima
 * @version $Id$
 */
public class CreateBrainstormController extends AbstractController {

	private RunService runService;

	private ProjectService projectService;

	private BrainstormService brainstormService;
	
	private static final String DEFAULT_QUESTIONBODY = 
		"<assessmentItem xmlns=\"http://www.imsglobal.org/xsd/imsqti_v2p0\" xmlns:ns2=\"http://www.w3.org/1999/xlink\" xmlns:ns3=\"http://www.w3.org/1998/Math/MathML\" timeDependent=\"false\" adaptive=\"false\">" +
        "<responseDeclaration identifier=\"TEXT_NOTE_ID\"/>" +
        "<itemBody>" +
        "<extendedTextInteraction hasInlineFeedback=\"false\" placeholderText=\"placeholdertext goes here\" responseIdentifier=\"TEXT_NOTE_ID\" expectedLines=\"6\">" +
            "<prompt>&lt;p&gt;Watch the following Video on Java and &lt;b&gt;post 2 thoughts that you have&lt;/b&gt; on the video.&lt;/p&gt;&lt;object width='425' height='344'&gt;&lt;param name='movie' value='http://www.youtube.com/v/SRLU1bJSLVg&amp;hl=en&amp;fs=1'&gt;&lt;/param&gt;&lt;param name='allowFullScreen' value='true'&gt;&lt;/param&gt;&lt;embed src='http://www.youtube.com/v/SRLU1bJSLVg&amp;hl=en&amp;fs=1' type='application/x-shockwave-flash' allowfullscreen='true' width='425' height='344'&gt;&lt;/embed&gt;&lt;/object&gt;</prompt>" +
        "</extendedTextInteraction>" +
        "</itemBody>" +
        "</assessmentItem>";
	
	private static final String RUNID_PARAM_NAME = "runId";

	private static final String PROJECTID_PARAM_NAME = "projectId";
	
	private static final String AUTHOR_BRAINSTORM_REDIRECT_VIEW = "../../../author/brainstorm/authorbrainstorm.html";

	private static final String MYPROJECTRUNS_REDIRECT_VIEW = "../myprojectruns.html";

	/**
	 * The Request must have a runId of the run to create the brainstorm for.
	 * The runId must belong to an existing run.
	 * 
	 * Logged in user must have privileges to create a Q&A step for the specified run.
	 * 
	 * @see org.springframework.web.servlet.mvc.AbstractController#handleRequestInternal(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	@Override
	protected ModelAndView handleRequestInternal(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String runIdStr = request.getParameter(RUNID_PARAM_NAME);
		String projectIdStr = request.getParameter(PROJECTID_PARAM_NAME);
		Brainstorm brainstorm = new BrainstormImpl();
		
		User user = ControllerUtil.getSignedInUser();

		if (runIdStr != null) {
			Long runId = Long.parseLong(runIdStr);
			Run run = this.runService.retrieveById(runId);
			
			// if logged-in user does not have access to create a Q&A for the
			// specified run, return to original page
			if (!run.getOwners().contains(user)) {
				ModelAndView modelAndView = new ModelAndView(new RedirectView(MYPROJECTRUNS_REDIRECT_VIEW));
				return modelAndView;
			} 
			brainstorm.setRun(run);
		}

		if (projectIdStr != null) {
			Project project = this.projectService.getById(projectIdStr);
			brainstorm.setProject(project);
		}
		
		brainstorm.setAnonymousAllowed(true);
		Question question = new JaxbQuestionImpl();
		question.setBody(DEFAULT_QUESTIONBODY);
		brainstorm.setQuestion(question);
		brainstorm.setDisplayNameOption(DisplayNameOption.USERNAME_OR_ANONYMOUS);
		brainstorm.setGated(false);
		brainstorm.setSessionStarted(true);
		brainstorm.setRichTextEditorAllowed(true);
		brainstormService.createBrainstorm(brainstorm);
		ModelAndView mav = new ModelAndView(new RedirectView(AUTHOR_BRAINSTORM_REDIRECT_VIEW + "?brainstormId=" + brainstorm.getId()));
		return mav;
	}

	/**
	 * @param runService the runService to set
	 */
	public void setRunService(RunService runService) {
		this.runService = runService;
	}

	/**
	 * @param brainstormService the brainstormService to set
	 */
	public void setBrainstormService(BrainstormService brainstormService) {
		this.brainstormService = brainstormService;
	}

	/**
	 * @param projectService the projectService to set
	 */
	public void setProjectService(ProjectService projectService) {
		this.projectService = projectService;
	}

}
