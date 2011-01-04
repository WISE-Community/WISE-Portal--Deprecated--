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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import org.telscenter.sail.webapp.domain.brainstorm.Brainstorm;
import org.telscenter.sail.webapp.domain.workgroup.WISEWorkgroup;
import org.telscenter.sail.webapp.service.brainstorm.BrainstormService;

/**
 * Controller to add/delete <code>PreparedAnswer</code>.
 * 
 * @author hirokiterashima
 * @version $Id$
 */
public class EditPreparedAnswerController extends AbstractController {

	private BrainstormService brainstormService;

	private final static String BRAINSTORMID = "brainstormId";

	private final static String PREPARED_ANSWER_ID = "preparedAnswerId";

	private final static String ACTION = "action";

	private static final String NEW_PREPARED_ANSWER_ID = null;
	
	/**
	 * @see org.springframework.web.servlet.mvc.AbstractController#handleRequestInternal(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	@Override
	protected ModelAndView handleRequestInternal(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		Brainstorm brainstorm = this.brainstormService.getBrainstormById(Long.parseLong(request.getParameter(BRAINSTORMID)));

		ModelAndView modelAndView = new ModelAndView();

		if(request.getParameter(ACTION).equals("add")){
			Long newPreparedAnswerId = brainstormService.addPreparedAnswer(brainstorm);
			response.getWriter().print(brainstorm.getPreparedAnswers().size()-1);
		} else if(request.getParameter(ACTION).equals("delete")) {   // delete specified prepared answer.
			brainstormService.deletePreparedAnswer(brainstorm, Long.parseLong(request.getParameter(PREPARED_ANSWER_ID)));
			//brainstormService.requestHelp(brainstorm, workgroup);
		}
		
		return null;
	}

	/**
	 * @param brainstormService the brainstormService to set
	 */
	public void setBrainstormService(BrainstormService brainstormService) {
		this.brainstormService = brainstormService;
	}

}
