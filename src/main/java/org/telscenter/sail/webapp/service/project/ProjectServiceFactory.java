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
package org.telscenter.sail.webapp.service.project;

import net.sf.sail.webapp.domain.Curnit;
import net.sf.sail.webapp.domain.impl.CurnitImpl;

import org.telscenter.sail.webapp.domain.impl.OtmlModuleImpl;
import org.telscenter.sail.webapp.domain.impl.UrlModuleImpl;
import org.telscenter.sail.webapp.domain.project.Project;
import org.telscenter.sail.webapp.domain.project.impl.ProjectType;
import org.telscenter.sail.webapp.domain.project.impl.ProjectTypeVisitor;
import org.telscenter.sail.webapp.service.module.ModuleService;

/**
 * Factory for creating <code>ProjectService</code> instances.
 * 
 * @author Hiroki Terashima
 * @version $Id$
 */
public class ProjectServiceFactory {
	
	private ProjectService podProjectService;
	
	private ProjectService potrunkProjectService;
	
	private ProjectService otrunkProjectService;
	
	private ExternalProjectService externalProjectService;
	
	private ProjectService rooloProjectService;
	
	private ProjectService ldProjectService;
	
	private ModuleService moduleService;
	
	/**
	 * Returns a <code>ProjectService</code> instance that serves
	 * the provided <code>Project</code>.
	 * 
	 * @param project <code>Project</code> used to lookup appropriate
	 *     <code>ProjectService</code>
	 * @return <code>ProjectService</code> to serve the specified project.
	 */
	public ProjectService getProjectService(Project project) {
		ProjectService projectService = null;

		if(project==null){
			return ldProjectService;
		}
		
		ProjectTypeVisitor typeVisitor = new ProjectTypeVisitor();
		String result = (String) project.accept(typeVisitor);
		if (result.equals("ExternalProject")) {
			return externalProjectService;
		}
		
		Curnit curnit = new CurnitImpl();
		try{
			curnit = moduleService.getById(project.getCurnit().getId());
		}catch(Exception e){
			//System.out.println(e);
		}
		if (curnit instanceof OtmlModuleImpl) {
			projectService = potrunkProjectService;
		} else if (curnit instanceof UrlModuleImpl) {
			projectService = ldProjectService;
		} else {
			projectService = podProjectService;
		}		
		return projectService;
	}
	
	/**
	 * Returns a <code>ProjectService</code> instance that serves
	 * the provided <code>Project</code>.
	 * 
	 * @param projectParameters <code>ProjectParameters</code> used to lookup appropriate
	 *     <code>ProjectService</code>
	 * @return <code>ProjectService</code> to serve the specified project.
	 */
	public ProjectService getProjectService(ProjectType projectType) {
		ProjectService projectService = null;

		if (projectType == ProjectType.OTRUNK) {
			projectService = otrunkProjectService;
		} else if (projectType == ProjectType.POTRUNK) {
			projectService = potrunkProjectService;
		} else if (projectType == ProjectType.ROLOO) {
			projectService = rooloProjectService;
		} else if (projectType == ProjectType.LD){
			projectService = ldProjectService;
		} else {
			projectService = podProjectService;
		}
		return projectService;
	}

	/**
	 * @param podProjectService the podProjectService to set
	 */
	public void setPodProjectService(ProjectService podProjectService) {
		this.podProjectService = podProjectService;
	}

	/**
	 * @param potrunkProjectService the potrunkProjectService to set
	 */
	public void setPotrunkProjectService(ProjectService potrunkProjectService) {
		this.potrunkProjectService = potrunkProjectService;
	}

	/**
	 * @param otrunkProjectService the otrunkProjectService to set
	 */
	public void setOtrunkProjectService(ProjectService otrunkProjectService) {
		this.otrunkProjectService = otrunkProjectService;
	}

	/**
	 * @param externalProjectService the externalProjectService to set
	 */
	public void setExternalProjectService(
			ExternalProjectService externalProjectService) {
		this.externalProjectService = externalProjectService;
	}

	/**
	 * @param moduleService the moduleService to set
	 */
	public void setModuleService(ModuleService moduleService) {
		this.moduleService = moduleService;
	}

	/**
	 * @param rooloProjectService the rooloProjectService to set
	 */
	public void setRooloProjectService(ProjectService rooloProjectService) {
		this.rooloProjectService = rooloProjectService;
	}

	/**
	 * @param ldProjectService the ldProjectService to set
	 */
	public void setLdProjectService(ProjectService ldProjectService) {
		this.ldProjectService = ldProjectService;
	}

}
