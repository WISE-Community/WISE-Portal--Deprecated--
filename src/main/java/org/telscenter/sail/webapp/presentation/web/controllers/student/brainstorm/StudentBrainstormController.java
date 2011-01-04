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
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.JAXBElement;

import net.sf.sail.webapp.domain.User;
import net.sf.sail.webapp.domain.Workgroup;
import net.sf.sail.webapp.presentation.web.controllers.ControllerUtil;

import org.imsglobal.xsd.imsqti_v2p0.ImgType;
import org.imsglobal.xsd.imsqti_v2p0.SimpleChoiceType;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import org.telscenter.sail.webapp.domain.brainstorm.Brainstorm;
import org.telscenter.sail.webapp.domain.brainstorm.Questiontype;
import org.telscenter.sail.webapp.domain.workgroup.WISEWorkgroup;
import org.telscenter.sail.webapp.service.brainstorm.BrainstormService;
import org.telscenter.sail.webapp.service.workgroup.WISEWorkgroupService;

/**
 * Displays Brainstorm step for students
 * @author Hiroki Terashima
 * @version $Id$
 */
public class StudentBrainstormController extends AbstractController {

	private static final String BRAINSTORM_KEY = "brainstorm";
	
	private static final String WORKGROUP = "workgroup";
	
	private static final String BRAINSTORMID_PARAM = "brainstormId";

	private static final String RESTRICTED_VIEW = "student/brainstorm/restricted";

	private static final String NOT_IN_WKGP_MSG = 
		"You cannot see this brainstorm because you are not in a workgroup for this run. Please go back.";

	private static final Object BRAINSTORM_CLOSED_MSG = 
		"This Brainstorm Step has not started yet. Please come back later.";
	
	private static final Object BAD_PARAMS_MESSAGE = 
		"You cannot see this brainstorm due to bad params.  Please contact WISE staff.";

	private static final Object BRAINSTORM_NOT_FOUND_MESSAGE = 
		"Brainstorm was not found. Please contact WISE staff.";

	private static final String CANNOT_SEE_RESPONSES = "cannotseeresponses";

	private static final String RUNID_PARAM = "runId";

	private static final String PARENTBRAINSTORMID_PARAM = "parentBrainstormId";
	
	private final static String CHOICES = "choices";
	
	private final static String KEYS = "keys";

	private BrainstormService brainstormService;

	private WISEWorkgroupService workgroupService;
	
	/**
	 * @see org.springframework.web.servlet.mvc.AbstractController#handleRequestInternal(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	@Override
	protected ModelAndView handleRequestInternal(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		User user = ControllerUtil.getSignedInUser();
		Map<String, Serializable> choiceMap = new LinkedHashMap<String, Serializable>();
		Brainstorm brainstorm = null;
		String brainstormIdStr = request.getParameter(BRAINSTORMID_PARAM);
		String runIdStr = request.getParameter(RUNID_PARAM);
		String parentBrainstormIdStr = request.getParameter(PARENTBRAINSTORMID_PARAM);

		if (brainstormIdStr != null) {
			brainstorm = brainstormService.getBrainstormById(brainstormIdStr);
		} else if (runIdStr != null && parentBrainstormIdStr != null) {
			brainstorm = brainstormService.getBrainstorm(new Long(runIdStr), new Long(parentBrainstormIdStr));			
		} else {
			ModelAndView modelAndView = new ModelAndView(RESTRICTED_VIEW);
			modelAndView.addObject("msg", BAD_PARAMS_MESSAGE);
			return modelAndView;			
		}
		
		if (brainstorm == null) {
			ModelAndView modelAndView = new ModelAndView(RESTRICTED_VIEW);
			modelAndView.addObject("msg", BRAINSTORM_NOT_FOUND_MESSAGE);
			return modelAndView;						
		}
		
		List<Workgroup> workgroupListByOfferingAndUser 
		    = workgroupService.getWorkgroupListByOfferingAndUser(brainstorm.getRun(), user);
		
		// if the user is not in a workgroup for this run, he/she cannot see this brainstorm.
		if (workgroupListByOfferingAndUser.isEmpty()) {
			ModelAndView modelAndView = new ModelAndView(RESTRICTED_VIEW);
			modelAndView.addObject("msg", NOT_IN_WKGP_MSG);
			return modelAndView;
		}
		
		// otherwise let the user see this brainstorm.
		WISEWorkgroup workgroup = (WISEWorkgroup) workgroupListByOfferingAndUser.get(0);
		
		
		// if this brainstorm session hasn't started yet, student cannot see this brainstorm.
		if (!brainstorm.isSessionStarted()) {
			ModelAndView modelAndView = new ModelAndView(RESTRICTED_VIEW);
			modelAndView.addObject("msg", BRAINSTORM_CLOSED_MSG);
			return modelAndView;
		}
		
		// if this brainstorm is gated, and the student has not posted yet,
		// he/she needs to post an answer first.
		if (brainstorm.isGated() && !brainstorm.hasWorkgroupPosted(workgroup)) {
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject(BRAINSTORM_KEY, brainstorm);
			modelAndView.addObject(CANNOT_SEE_RESPONSES, true);
			modelAndView.addObject(WORKGROUP, workgroup);
			return modelAndView;
		}

		if(brainstorm.getQuestiontype().equals(Questiontype.SINGLE_CHOICE)){
			choiceMap = BrainstormUtils.getChoiceMap(brainstorm.getQuestion().getChoices());
		}
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject(BRAINSTORM_KEY, brainstorm);
		modelAndView.addObject(WORKGROUP, workgroup);
		modelAndView.addObject(CHOICES, choiceMap);
		modelAndView.addObject(KEYS, choiceMap.keySet());
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
