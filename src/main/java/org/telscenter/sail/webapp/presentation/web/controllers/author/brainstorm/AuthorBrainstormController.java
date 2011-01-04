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
package org.telscenter.sail.webapp.presentation.web.controllers.author.brainstorm;

import java.io.Serializable;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.JAXBElement;

import net.sf.sail.webapp.dao.ObjectNotFoundException;

import org.imsglobal.xsd.imsqti_v2p0.ImgType;
import org.imsglobal.xsd.imsqti_v2p0.SimpleChoiceType;
import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;
import org.springframework.web.servlet.view.RedirectView;
import org.telscenter.sail.webapp.domain.brainstorm.Brainstorm;
import org.telscenter.sail.webapp.domain.brainstorm.DisplayNameOption;
import org.telscenter.sail.webapp.domain.brainstorm.Questiontype;
import org.telscenter.sail.webapp.presentation.web.controllers.student.brainstorm.BrainstormUtils;
import org.telscenter.sail.webapp.service.brainstorm.BrainstormService;

/**
 * Controller to edit an existing brainstorm.
 * The brainstormId must be passed in the request.
 * 
 * @author hirokiterashima
 * @version $Id$
 */
public class AuthorBrainstormController extends SimpleFormController {
	
	protected static final String BRAINSTORMID_PARAM = "brainstormId";
	
	protected static final String BRAINSTORM_PARAM = "brainstorm";
	
	protected static final String CHOICES = "choices";
	
	protected static final String KEYS = "keys";
	
	private BrainstormService brainstormService;

	/**
	 * @see org.springframework.web.servlet.mvc.SimpleFormController#showForm(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, org.springframework.validation.BindException)
	 */
	@Override
	protected ModelAndView showForm(HttpServletRequest request, HttpServletResponse response, BindException bindException) throws Exception {
		ModelAndView modelAndView = super.showForm(request, response, bindException);
		String brainstormId = request.getParameter(BRAINSTORMID_PARAM);
		Brainstorm brainstorm = null;
		
		try {
			brainstorm = brainstormService.getBrainstormById(brainstormId);
		} catch (ObjectNotFoundException onfe) {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			throw onfe;
		}
		Map<String, Serializable> choiceMap = new LinkedHashMap<String, Serializable>();
		if(brainstorm.getQuestiontype()==Questiontype.SINGLE_CHOICE){
			choiceMap = BrainstormUtils.getChoiceMap(brainstorm.getQuestion().getChoices());
		}
		
        modelAndView.addObject(BRAINSTORM_PARAM, brainstorm);
        modelAndView.addObject(CHOICES, choiceMap);
        modelAndView.addObject(KEYS, choiceMap.keySet());
		return modelAndView;
	}

	@Override
	protected Object formBackingObject(HttpServletRequest request) throws Exception {
		String brainstormId = request.getParameter(BRAINSTORMID_PARAM);
		Brainstorm brainstorm = null;
		
		try {
			brainstorm = brainstormService.getBrainstormById(Long.parseLong(brainstormId));
		} catch (ObjectNotFoundException onfe) {
			throw onfe;
		}
        return brainstorm;
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
		Brainstorm brainstorm = (Brainstorm) command;
		brainstormService.createBrainstorm(brainstorm);
		ModelAndView modelAndView = new ModelAndView(new RedirectView("authorbrainstorm.html"));
		modelAndView.addObject(BRAINSTORM_PARAM, brainstorm);
		modelAndView.addObject(BRAINSTORMID_PARAM, brainstorm.getId());
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
}
