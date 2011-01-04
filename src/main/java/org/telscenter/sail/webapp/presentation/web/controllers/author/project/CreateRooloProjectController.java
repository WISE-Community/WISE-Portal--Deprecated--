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

import java.net.URI;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.sail.webapp.dao.ObjectNotFoundException;
import net.sf.sail.webapp.domain.Curnit;
import net.sf.sail.webapp.domain.User;
import net.sf.sail.webapp.domain.impl.CurnitParameters;
import net.sf.sail.webapp.presentation.web.controllers.ControllerUtil;
import net.sf.sail.webapp.service.curnit.CurnitService;

import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;
import org.springframework.web.servlet.view.RedirectView;
import org.telscenter.sail.webapp.domain.impl.CreateRooloOtmlModuleParameters;
import org.telscenter.sail.webapp.domain.impl.CreateRooloXmlModuleParameters;
import org.telscenter.sail.webapp.domain.impl.RooloProjectParameters;
import org.telscenter.sail.webapp.domain.project.Project;
import org.telscenter.sail.webapp.domain.project.impl.ProjectType;
import org.telscenter.sail.webapp.service.module.ModuleService;
import org.telscenter.sail.webapp.service.project.ProjectService;

import roolo.elo.BasicELO;
import roolo.elo.ELOMetadataKeys;
import roolo.elo.api.I18nType;
import roolo.elo.api.IELO;
import roolo.elo.api.IMetadata;
import roolo.elo.api.IMetadataKey;
import roolo.elo.api.IMetadataValueContainer;
import roolo.elo.api.metadata.MetadataValueCount;
import roolo.elo.content.StringContent;
import roolo.elo.metadata.keys.LongMetadataKey;
import roolo.elo.metadata.value.containers.MetadataSingleUniversalValueContainer;

/**
 * @author patrick lawler
 * @version $Id:$
 */
public class CreateRooloProjectController extends SimpleFormController{
	
	private final static ProjectType TYPE = ProjectType.ROLOO;
	
	private final static String REP_URL = "http://localhost:8080/webapp/repository";
	
	private final static String PROJECTID = "projectId";
	
	private ProjectService projectService;
	
	private CurnitService curnitService;
	
    @Override
    protected ModelAndView onSubmit(HttpServletRequest request,
            HttpServletResponse response, Object command, BindException errors) throws Exception{
    	
    	RooloProjectParameters params = (RooloProjectParameters) command;
    	
		User user = ControllerUtil.getSignedInUser();
		Set<User> owners = new HashSet<User>();
		owners.add(user);
		params.setOwners(owners);
		params.setProjectType(TYPE);
		
		CurnitParameters curnitParams = getRooloParams(params.getXml());
		Curnit curnit = curnitService.createCurnit(curnitParams);
		
		params.setCurnitId(curnit.getId());
		Project project = projectService.createProject(params);
    	
		ModelAndView mav = new ModelAndView(new RedirectView("./authorrooloproject.html"));
		mav.addObject(PROJECTID, project.getId());
    	return mav;
    }

    private CreateRooloXmlModuleParameters getRooloParams(String xml) throws Exception{
    	CreateRooloXmlModuleParameters params = new CreateRooloXmlModuleParameters();
    	IELO elo = new BasicELO();
    	Long id = ((ModuleService) this.curnitService).getLatestId() + 1;
    	URI uri = new URI("roolootmlmod." + id);
    	
    	elo.setContent(new StringContent(xml));
		IMetadata metadata = elo.getMetadata();
		
		IMetadataKey uriKey = this.createLongMetadataKey();
		IMetadataValueContainer container = new MetadataSingleUniversalValueContainer(metadata, uriKey);
		container.setValue(uri);
		
		metadata.addMetadataPair(uriKey, container);
		((BasicELO)elo).setUriKey(uriKey);
		setContainersEssentialKeys(metadata, container);
		
		params.setElo(elo);
		params.setRoolouri(elo.getUri().toString());
		params.setRooloRepositoryUrl(REP_URL);
    	
    	return params;
    }
    
	private void setContainersEssentialKeys(IMetadata metadata, IMetadataValueContainer container ){
		//Create container with essential keys and value
		container = metadata.getMetadataValueContainer(ELOMetadataKeys.TYPE.getKey());
		container.setValue("Universal Type");
		
		container = metadata.getMetadataValueContainer(ELOMetadataKeys.VERSION.getKey());
		container.setValue("First VERSION");
		
		container = metadata.getMetadataValueContainer(ELOMetadataKeys.TITLE.getKey());
		container.setValue("The TITLE of ELO");
		
		container = metadata.getMetadataValueContainer(ELOMetadataKeys.AUTHOR.getKey());
		container.setValue("ELO AUTHOR");
		
		container = metadata.getMetadataValueContainer(ELOMetadataKeys.SUBJECT.getKey());
		container.setValue("This is the SUBJECT of ELO");
		
		container = metadata.getMetadataValueContainer(ELOMetadataKeys.GRADELEVEL.getKey());
		container.setValue("GRADELEVEL 5");
		
		container = metadata.getMetadataValueContainer(ELOMetadataKeys.FAMILYTAG.getKey());
		container.setValue("FAMILYTAG R");
		
		container = metadata.getMetadataValueContainer(ELOMetadataKeys.ISCURRENT.getKey());
		container.setValue("ISCURRENT Yes");
	}

	
	private IMetadataKey createLongMetadataKey(){
		String uriId = ELOMetadataKeys.URI.getId();
		String uriXpath = ELOMetadataKeys.URI.getXpath();
		I18nType uriType = ELOMetadataKeys.URI.getI18n();
		MetadataValueCount uriCount = ELOMetadataKeys.URI.getCount();
		
		IMetadataKey uriKey = new LongMetadataKey(uriId, uriXpath, uriType, uriCount , null);
		
		return uriKey;
	}
    
	/**
	 * @param curnitService the curnitService to set
	 */
	public void setCurnitService(CurnitService curnitService) {
		this.curnitService = curnitService;
	}

	/**
	 * @param projectService the projectService to set
	 */
	public void setProjectService(ProjectService projectService) {
		this.projectService = projectService;
	}
}
