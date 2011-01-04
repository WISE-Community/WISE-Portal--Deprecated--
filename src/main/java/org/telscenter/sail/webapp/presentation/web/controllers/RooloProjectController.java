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
package org.telscenter.sail.webapp.presentation.web.controllers;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.sail.webapp.domain.Workgroup;
import net.sf.sail.webapp.service.workgroup.WorkgroupService;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import org.telscenter.sail.webapp.domain.Run;
import org.telscenter.sail.webapp.domain.impl.RooloOtmlModuleImpl;
import org.telscenter.sail.webapp.service.module.ModuleService;
import org.telscenter.sail.webapp.service.offering.RunService;

import roolo.elo.api.IELO;

/**
 * @author patrick lawler
 * @version $Id:$
 */
public class RooloProjectController extends AbstractController{

	private RunService runService;
	
	private WorkgroupService workgroupService;
	
	private ModuleService moduleService;
	
	private final static String RUN = "run";
	
	private final static String WORKGROUP = "workgroup";
	
	private final static String RUNID = "runId";
	
	private final static String WORKGROUPID = "workgroupId";
	
	private final static String PREVIEW = "preview";
	
	private final static String ELO = "elo";
	
	@Override
	protected ModelAndView handleRequestInternal(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Workgroup workgroup = this.workgroupService.retrieveById(Long.parseLong(request.getParameter(WORKGROUPID)));
		Run run = this.runService.retrieveById(Long.parseLong(request.getParameter(RUNID)));
		RooloOtmlModuleImpl mod = (RooloOtmlModuleImpl) this.moduleService.getById(run.getProject().getCurnit().getId());
		IELO elo = this.moduleService.getEloForModule(mod);
		mod.setElo(elo);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject(RUN, run);
		modelAndView.addObject(WORKGROUP, workgroup);
		modelAndView.addObject(PREVIEW, request.getParameter(PREVIEW));
		modelAndView.addObject(ELO, mod.getElo());
		
		return modelAndView;
	}

	/**
	 * @param runService the runService to set
	 */
	public void setRunService(RunService runService) {
		this.runService = runService;
	}

	/**
	 * @param workgroupService the workgroupService to set
	 */
	public void setWorkgroupService(WorkgroupService workgroupService) {
		this.workgroupService = workgroupService;
	}

	/**
	 * @param moduleService the moduleService to set
	 */
	public void setModuleService(ModuleService moduleService) {
		this.moduleService = moduleService;
	}

}
