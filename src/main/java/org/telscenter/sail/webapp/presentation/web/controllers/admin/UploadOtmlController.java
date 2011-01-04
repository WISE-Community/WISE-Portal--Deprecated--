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
package org.telscenter.sail.webapp.presentation.web.controllers.admin;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.sail.webapp.domain.Curnit;
import net.sf.sail.webapp.domain.User;
import net.sf.sail.webapp.domain.impl.CurnitImpl;
import net.sf.sail.webapp.presentation.web.controllers.ControllerUtil;
import net.sf.sail.webapp.service.NotAuthorizedException;
import net.sf.sail.webapp.service.curnit.CurnitService;

import org.springframework.validation.BindException;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;
import org.springframework.web.servlet.view.RedirectView;
import org.telscenter.sail.webapp.domain.Module;
import org.telscenter.sail.webapp.domain.admin.OtmlFileUpload;
import org.telscenter.sail.webapp.domain.impl.ModuleImpl;
import org.telscenter.sail.webapp.domain.impl.OtmlModuleImpl;
import org.telscenter.sail.webapp.domain.impl.RooloOtmlModuleImpl;
import org.telscenter.sail.webapp.domain.project.Project;
import org.telscenter.sail.webapp.domain.project.impl.ProjectCurnitVisitor;
import org.telscenter.sail.webapp.service.module.ModuleService;
import org.telscenter.sail.webapp.service.project.ProjectService;

/**
 * Allows administrators to manually edit the otml file, without using
 * authoring tool.
 * 
 * @author Hiroki Terashima
 * @version $Id$
 */
public class UploadOtmlController extends SimpleFormController {

	private static final String PROJECT_KEY = "project";
	private ProjectService projectService;
	
	private ModuleService moduleService;

	public UploadOtmlController() {
		setSessionForm(true);
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
		Project project = projectService.getById(request.getParameter("projectId"));
		Map<String, Object> model = new HashMap<String, Object>();
		model.put(PROJECT_KEY, project);
		return model;
	}
	
	/**
	 * @override @see org.springframework.web.servlet.mvc.SimpleFormController#onSubmit(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, java.lang.Object, org.springframework.validation.BindException)
	 */
	@Override
	protected ModelAndView onSubmit(HttpServletRequest request,
			HttpServletResponse response, Object command, BindException errors)
			throws Exception {
		OtmlFileUpload bean = (OtmlFileUpload) command;
		MultipartFile file = bean.getFile();
		User user = ControllerUtil.getSignedInUser();
		
		if (file == null) {
			ModelAndView modelAndView = new ModelAndView(new RedirectView(getSuccessView()));		
			return modelAndView;
		} else {
			Project project = projectService.getById(request.getParameter("projectId"));
			Module curnit = new ModuleImpl();
			try{
				curnit = (Module)moduleService.getById(project.getCurnit().getId());
			}catch(Exception e){
			}
			
			if (curnit instanceof RooloOtmlModuleImpl) {
				((RooloOtmlModuleImpl) curnit).getElo().getContent().setBytes(file.getBytes());		
			} else if (curnit instanceof OtmlModuleImpl) {
				((OtmlModuleImpl) curnit).setOtml(file.getBytes());
				moduleService.updateCurnit(curnit);
			}
			
			try{
				projectService.updateProject(project, user);
			} catch (NotAuthorizedException e){
				e.printStackTrace();
				return new ModelAndView(new RedirectView("/webapp/accessdenied.html"));
			}
		}
		ModelAndView modelAndView = new ModelAndView(new RedirectView(getSuccessView()));		
		return modelAndView;
	}
		
	/**
	 * @param projectService the projectService to set
	 */
	public void setProjectService(ProjectService projectService) {
		this.projectService = projectService;
	}

	/**
	 * @param moduleService the moduleService to set
	 */
	public void setModuleService(ModuleService moduleService) {
		this.moduleService = moduleService;
	}
	
}
