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
package org.telscenter.sail.webapp.presentation.web.controllers.teacher.grading;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.sail.webapp.dao.ObjectNotFoundException;

import org.eclipse.emf.ecore.resource.Resource;
import org.springframework.validation.BindException;
import org.springframework.validation.Errors;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.AbstractController;
import org.springframework.web.servlet.mvc.SimpleFormController;
import org.springframework.web.servlet.view.RedirectView;
import org.telscenter.pas.emf.pas.EActivity;
import org.telscenter.pas.emf.pas.ECurnitmap;
import org.telscenter.pas.emf.pas.EStep;
import org.telscenter.sail.webapp.domain.Run;
import org.telscenter.sail.webapp.domain.project.Curnitmap;
import org.telscenter.sail.webapp.domain.project.impl.CurnitmapImpl;
import org.telscenter.sail.webapp.presentation.web.TeacherAccountForm;
import org.telscenter.sail.webapp.service.grading.GradingService;
import org.telscenter.sail.webapp.service.offering.RunService;

/**
 * @author MattFish
 * @author Hiroki Terashima
 * @version $$Id:$$
 */
public class EditMaxStepValuesController extends SimpleFormController {

	public static final String RUNID_PARAM_NAME = "runId";
	
	public static final String CURNIT_MAP = "curnitmap";
	
	private GradingService gradingService;
	
	private RunService runService;

	/**
	 * @see org.springframework.web.servlet.mvc.AbstractFormController#formBackingObject(javax.servlet.http.HttpServletRequest)
	 */
	@Override
	protected Object formBackingObject(HttpServletRequest request) throws Exception {
		Long runId = Long.parseLong(request.getParameter(RUNID_PARAM_NAME));
		ECurnitmap eCurnitmap = gradingService.getCurnitmap(runId);
		Curnitmap curnitmap = new CurnitmapImpl();
		curnitmap.setECurnitmap(eCurnitmap);
		return curnitmap;
	}
	
	/**
	 * This method is called right before the view is rendered to the user
	 * Add the run to the model
	 * 
	 * @see org.springframework.web.servlet.mvc.AbstractWizardFormController#referenceData(javax.servlet.http.HttpServletRequest, int)
	 */
	@Override
	protected Map<String, Object> referenceData(HttpServletRequest request, 
			Object command, Errors errors) {
		Map<String, Object> model = new HashMap<String, Object>();
		Long runId = Long.parseLong(request.getParameter(RUNID_PARAM_NAME));
		Run run = null;
		Float totalPossibleScore = new Float(0);
		try {
			run = runService.retrieveById(runId);
			totalPossibleScore = gradingService.getTotalPossibleScore(runId);
		} catch (ObjectNotFoundException e) {
			e.printStackTrace();
		}
		
		model.put("run", run);
		model.put("totalPossibleScore", totalPossibleScore);
		
		return model;
	}
	
	/**
	 * On submission of the editmaxstepvalues form, 
	 * the modified curnitmap is saved with the associated run
	 *  
	 * @see org.springframework.web.servlet.mvc.SimpleFormController#onSubmit(javax.servlet.http.HttpServletRequest,
	 *      javax.servlet.http.HttpServletResponse, java.lang.Object,
	 *      org.springframework.validation.BindException)
	 */
	@Override
	protected ModelAndView onSubmit(HttpServletRequest request,
			HttpServletResponse response, Object command, BindException errors)
	throws Exception {
		Curnitmap curnitmap = (Curnitmap) command;
		Long runId = Long.parseLong(request.getParameter(RUNID_PARAM_NAME));
		runService.updateCurnitmapForOffering(runId, curnitmap.getECurnitmap());
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setView(new RedirectView("editmaxstepvalues.html" + "?runId=" + runId));
		return modelAndView;
	}
	
	/**
	 * @param gradingService the gradingService to set
	 */
	public void setGradingService(GradingService gradingService) {
		this.gradingService = gradingService;
	}

	/**
	 * @param runService the runService to set
	 */
	public void setRunService(RunService runService) {
		this.runService = runService;
	}




}
