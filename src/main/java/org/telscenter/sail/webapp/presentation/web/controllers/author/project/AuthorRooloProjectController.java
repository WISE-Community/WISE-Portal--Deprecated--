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
package org.telscenter.sail.webapp.presentation.web.controllers.author.project;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.sail.webapp.domain.User;
import net.sf.sail.webapp.presentation.web.controllers.ControllerUtil;
import net.sf.sail.webapp.service.NotAuthorizedException;

import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;
import org.springframework.web.servlet.view.RedirectView;
import org.telscenter.sail.webapp.domain.impl.RooloOtmlModuleImpl;
import org.telscenter.sail.webapp.domain.impl.RooloProjectParameters;
import org.telscenter.sail.webapp.domain.project.Project;
import org.telscenter.sail.webapp.service.module.ModuleService;
import org.telscenter.sail.webapp.service.project.ProjectService;

import roolo.elo.api.IELO;
import roolo.elo.content.StringContent;

/**
 * @author patrick lawler
 * @version $Id:$
 */
public class AuthorRooloProjectController extends SimpleFormController {
	
	private ProjectService projectService;
	
	private ModuleService moduleService;
	
	private final static String PROJECTID = "projectId";
	
    /**
     * @see org.springframework.web.servlet.mvc.SimpleFormController#referenceData(javax.servlet.http.HttpServletRequest)
     */
	@Override
	protected Map<String, Object> referenceData(HttpServletRequest request) throws Exception {
		Map<String, Object> model = new HashMap<String, Object>();
		model.put(PROJECTID, request.getParameter(PROJECTID));
		return model;
	}
	
	/**
	 * @see org.springframework.web.servlet.mvc.AbstractFormController#formBackingObject(javax.servlet.http.HttpServletRequest)
	 */
	@Override
	protected Object formBackingObject(HttpServletRequest request) throws Exception {
		RooloProjectParameters params = new RooloProjectParameters();
		Project project = this.projectService.getById(Long.parseLong(request.getParameter(PROJECTID)));
		params.setCurnitId(project.getCurnit().getId());
		params.setOwners(project.getOwners());
		params.setProjectname(project.getName());
		
		RooloOtmlModuleImpl mod = (RooloOtmlModuleImpl)this.moduleService.getById(project.getCurnit().getId());
		IELO elo = this.moduleService.getEloForModule(mod);
		params.setXml(elo.getContent().getXml());
		params.setJnlpId((Long)project.getId());
		return params;
	}

	/**
	 * @see org.springframework.web.servlet.mvc.SimpleFormController#onSubmit(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, java.lang.Object, org.springframework.validation.BindException)
	 */
    @Override
    protected ModelAndView onSubmit(HttpServletRequest request,
            HttpServletResponse response, Object command, BindException errors) throws Exception{
    	RooloProjectParameters params = (RooloProjectParameters) command;
    	User user = ControllerUtil.getSignedInUser();
    	
    	//not really jnlpid, it is projectid set in formbackingobject
    	Project project = this.projectService.getById(params.getJnlpId()); 
    	project.setOwners(params.getOwners());
    	project.setName(params.getProjectname());
    	
    	RooloOtmlModuleImpl mod = (RooloOtmlModuleImpl) this.moduleService.getById(params.getCurnitId());
    	IELO elo = this.moduleService.getEloForModule(mod);
    	elo.setContent(new StringContent(params.getXml()));
    	mod.setElo(elo);
    	this.moduleService.updateCurnit(mod);
    	
    	try{
    		this.projectService.updateProject(project, user);
    	} catch (NotAuthorizedException e){
    		e.printStackTrace();
    		return new ModelAndView(new RedirectView("/webapp/accessdenied.html"));
    	}
    	
    	ModelAndView mav = new ModelAndView(new RedirectView("./authorrooloproject.html"));
    	mav.addObject(PROJECTID, project.getId());
    	return mav;
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
