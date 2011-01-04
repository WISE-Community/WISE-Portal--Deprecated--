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
import org.telscenter.sail.webapp.domain.brainstorm.answer.Answer;
import org.telscenter.sail.webapp.domain.workgroup.WISEWorkgroup;
import org.telscenter.sail.webapp.service.brainstorm.BrainstormService;
import org.telscenter.sail.webapp.service.workgroup.WISEWorkgroupService;

/**
 * @author Hiroki Terashima
 * @version $Id$
 */
public class MarkAnswerHelpfulController extends AbstractController {

	private final static String WORKGROUPID = "workgroupId";
	
	private final static String ANSWERID = "answerId";
	
	private final static String MARK = "mark";   // 0 = unmark, 1 = mark

	private final static String TYPE = "type";   // choices:{helpful,tag}
	
	private final static String HELPFUL = "helpful";
	
	private final static String TAG = "tag";
	
	private final static String XMLDOC = "xmlDoc";
	
	private BrainstormService brainstormService;
	
	private WISEWorkgroupService workgroupService;
	
	/**
	 * @see org.springframework.web.servlet.mvc.AbstractController#handleRequestInternal(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	@Override
	protected ModelAndView handleRequestInternal(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		Answer answer = this.brainstormService.getAnswer(Long.parseLong(request.getParameter(ANSWERID)));
		WISEWorkgroup workgroup = (WISEWorkgroup) this.workgroupService.retrieveById(Long.parseLong(request.getParameter(WORKGROUPID)));

		if (request.getParameter(TYPE).equals(TAG)) {
			if(Integer.parseInt(request.getParameter(MARK)) == 0){
				brainstormService.untag(answer, workgroup);
			} else {
				brainstormService.tag(answer, workgroup);
			}	
		} else if (request.getParameter(TYPE).equals(HELPFUL)) {
			if(Integer.parseInt(request.getParameter(MARK)) == 0){
				brainstormService.unmarkAsHelpful(answer, workgroup);
			} else {
				brainstormService.markAsHelpful(answer, workgroup);
			}			
		}
		
		String xmlDoc = XMLBrainstorm.getXMLAnswer(answer);
		
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

	/**
	 * @param workgroupService the workgroupService to set
	 */
	public void setWorkgroupService(WISEWorkgroupService workgroupService) {
		this.workgroupService = workgroupService;
	}
}
