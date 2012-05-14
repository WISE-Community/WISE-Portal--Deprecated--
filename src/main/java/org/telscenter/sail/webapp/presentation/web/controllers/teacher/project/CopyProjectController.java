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
package org.telscenter.sail.webapp.presentation.web.controllers.teacher.project;

import java.util.Set;
import java.util.TreeSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.sail.webapp.domain.Curnit;
import net.sf.sail.webapp.domain.User;
import net.sf.sail.webapp.domain.impl.CurnitGetOtmlVisitor;
import net.sf.sail.webapp.presentation.web.controllers.ControllerUtil;
import net.sf.sail.webapp.service.curnit.CurnitService;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import org.telscenter.sail.webapp.domain.impl.CreateOtmlModuleParameters;
import org.telscenter.sail.webapp.domain.impl.OtmlModuleImpl;
import org.telscenter.sail.webapp.domain.impl.ProjectParameters;
import org.telscenter.sail.webapp.domain.project.Project;
import org.telscenter.sail.webapp.domain.project.impl.ProjectType;
import org.telscenter.sail.webapp.presentation.util.Util;
import org.telscenter.sail.webapp.service.project.ProjectService;

/**
 * @author patrick lawler
 * @version $Id:$
 */
public class CopyProjectController extends AbstractController{

	private ProjectService projectService;
	
	private CurnitService curnitService;
	
	protected final static String PROJECTID = "projectId";
	
	protected final static String RESPONSE = "response";
	
	/**
	 * @see org.springframework.web.servlet.mvc.AbstractController#handleRequestInternal(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	@Override
	protected ModelAndView handleRequestInternal(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		String outResponse = "";
		User user = ControllerUtil.getSignedInUser();
		Set<User> owners = new TreeSet<User>();
		owners.add(user);
		
		Project project = projectService.getById(Long.parseLong(request.getParameter(PROJECTID)));
		
		CreateOtmlModuleParameters params = new CreateOtmlModuleParameters();
		params.setName(project.getCurnit().getSdsCurnit().getName());
		params.setUrl("");
		params.setRetrieveotmlurl(Util.getPortalUrl(request) + "/repository/retrieveotml.html?otmlModuleId=");
		byte[] otmlbytes = (byte[]) project.getCurnit().accept(new CurnitGetOtmlVisitor());
		if(otmlbytes != null) {
			params.setOtml(otmlbytes);
			Curnit copiedCurnit = curnitService.createCurnit(params);

			ProjectParameters projParams = new ProjectParameters();
			
			projParams.setCurnitId(copiedCurnit.getId());
			projParams.setJnlpId(project.getJnlp().getId());
			projParams.setOwners(owners);
			projParams.setProjectname(project.getName());
			projParams.setProjectType(project.getProjectType());
			
			projectService.createProject(projParams);
			
			outResponse = "Project " + project.getName() + " has been successfully " +
			"copied and can be found in My Customized Projects.";
		} else {
			outResponse = "This project is not of a type that can be copied.";
		}
		
		 ModelAndView modelAndView = new ModelAndView();
		 modelAndView.addObject(RESPONSE, outResponse);
		 return modelAndView;
	}

	/**
	 * @param projectService the projectService to set
	 */
	public void setProjectService(ProjectService projectService) {
		this.projectService = projectService;
	}

	/**
	 * @param curnitService the curnitService to set
	 */
	public void setCurnitService(CurnitService curnitService) {
		this.curnitService = curnitService;
	}
}
