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

import java.io.Serializable;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.JAXBElement;

import net.sf.sail.webapp.dao.ObjectNotFoundException;
import net.sf.sail.webapp.domain.User;
import net.sf.sail.webapp.domain.Workgroup;
import net.sf.sail.webapp.presentation.web.controllers.ControllerUtil;

import org.imsglobal.xsd.imsqti_v2p0.ImgType;
import org.imsglobal.xsd.imsqti_v2p0.SimpleChoiceType;
import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import org.springframework.web.servlet.mvc.SimpleFormController;
import org.telscenter.sail.webapp.domain.Run;
import org.telscenter.sail.webapp.domain.brainstorm.Brainstorm;
import org.telscenter.sail.webapp.domain.brainstorm.DisplayNameOption;
import org.telscenter.sail.webapp.domain.brainstorm.Questiontype;
import org.telscenter.sail.webapp.domain.impl.AddSharedTeacherParameters;
import org.telscenter.sail.webapp.domain.workgroup.WISEWorkgroup;
import org.telscenter.sail.webapp.presentation.web.controllers.student.brainstorm.BrainstormUtils;
import org.telscenter.sail.webapp.service.brainstorm.BrainstormService;
import org.telscenter.sail.webapp.service.workgroup.WISEWorkgroupService;

/**
 * @author hirokiterashima
 * @version $Id$
 */
public class ManageBrainstormController extends SimpleFormController {

	private static final String BRAINSTORM_KEY = "brainstorm";
	
	private static final String WORKGROUP = "workgroup";
	
	private static final String BRAINSTORMID_PARAM = "brainstormId";

	private static final String RESTRICTED_VIEW = "student/brainstorm/restricted";

	private static final String NOT_IN_WKGP_MSG = 
		"You cannot see this brainstorm because you are not in a workgroup for this run. Please go back.";

	private static final Object BRAINSTORM_CLOSED_MSG = 
		"This Brainstorm Step has not started yet. Please come back later.";

	private static final String CANNOT_SEE_RESPONSES = "cannotseeresponses";
	
	private static final String CHOICES = "choices";
	
	private static final String KEYS = "keys";

	private BrainstormService brainstormService;

	private WISEWorkgroupService workgroupService;
	
	/**
	 * @see org.springframework.web.servlet.mvc.SimpleFormController#showForm(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, org.springframework.validation.BindException)
	 */
	@Override
	protected ModelAndView showForm(HttpServletRequest request, HttpServletResponse response, BindException bindException) throws Exception {
		ModelAndView modelAndView = super.showForm(request, response, bindException);
		Map<String, Serializable> choiceMap = new LinkedHashMap();
		String brainstormId = request.getParameter(BRAINSTORMID_PARAM);
		Brainstorm brainstorm = null;
		
		try {
			brainstorm = brainstormService.getBrainstormById(brainstormId);
		} catch (ObjectNotFoundException onfe) {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			throw onfe;
		}
		
        modelAndView.addObject(BRAINSTORM_KEY, brainstorm);
        
		User user = ControllerUtil.getSignedInUser();

		List<Workgroup> workgroupListByOfferingAndUser 
		    = workgroupService.getWorkgroupListByOfferingAndUser(brainstorm.getRun(), user);
		
		WISEWorkgroup workgroup = (WISEWorkgroup) workgroupListByOfferingAndUser.get(0);
		
		if(brainstorm.getQuestiontype().equals(Questiontype.SINGLE_CHOICE)){
			choiceMap = BrainstormUtils.getChoiceMap(brainstorm.getQuestion().getChoices());
		}
		
        modelAndView.addObject("displayNameOptions", DisplayNameOption.values());
        modelAndView.addObject(WORKGROUP, workgroup);
        modelAndView.addObject(KEYS, choiceMap.keySet());
        modelAndView.addObject(CHOICES, choiceMap);

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
     * Adds the existing shared teachers and their permissions for
     * the run requested to the page.
     * 
     * @see org.springframework.web.servlet.mvc.SimpleFormController#referenceData(javax.servlet.http.HttpServletRequest)
     */
	@Override
	protected Map<String, Object> referenceData(HttpServletRequest request) 
	    throws Exception {
		Map<String, Object> model = new HashMap<String, Object>();
		
		User user = ControllerUtil.getSignedInUser();

		String brainstormId = request.getParameter(BRAINSTORMID_PARAM);
		Brainstorm brainstorm = brainstormService.getBrainstormById(brainstormId);
		
		List<Workgroup> workgroupListByOfferingAndUser 
		    = workgroupService.getWorkgroupListByOfferingAndUser(brainstorm.getRun(), user);
		
		if (workgroupListByOfferingAndUser.size() == 0) {
			if (brainstorm.getRun().getOwners().contains(user)) {
				workgroupService.createWISEWorkgroup("teacher", brainstorm.getRun().getOwners(), brainstorm.getRun(), null);
				workgroupListByOfferingAndUser 
			    = workgroupService.getWorkgroupListByOfferingAndUser(brainstorm.getRun(), user);
			}
		}
		
		WISEWorkgroup workgroup = (WISEWorkgroup) workgroupListByOfferingAndUser.get(0);
		model.put("displayNameOptions", DisplayNameOption.values());
		model.put(WORKGROUP, workgroup);
		return model;
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
	    
	    return showForm(request, response, errors);

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