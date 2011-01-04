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
package org.telscenter.sail.webapp.dao.module.impl;

import java.io.Serializable;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import net.sf.sail.webapp.dao.ObjectNotFoundException;
import net.sf.sail.webapp.dao.impl.AbstractHibernateDao;

import org.telscenter.sail.webapp.dao.module.ModuleDao;
import org.telscenter.sail.webapp.domain.Module;
import org.telscenter.sail.webapp.domain.impl.RooloOtmlModuleImpl;
import org.telscenter.sail.webapp.domain.project.FamilyTag;
import org.telscenter.sail.webapp.domain.project.ProjectInfo;
import org.telscenter.sail.webapp.domain.project.impl.ProjectInfoImpl;

import roolo.elo.ELOMetadataKeys;
import roolo.elo.api.IELO;
import roolo.elo.api.IMetadata;
import roolo.elo.api.IMetadataValueContainer;
import roolo.elo.api.IRepository;
import roolo.elo.api.exceptions.ELODoesNotExistException;

/**
 * @author Hiroki Terashima
 * @author Carlos Celorrio
 *
 * @version $Id$
 */
public class RooloOtmlModuleDao extends AbstractHibernateDao<Module> 
    implements ModuleDao<Module> {

	public static String rooloRepositoryUrl;
	
	public static String defaultOtrunkCurnitUrl;
	
	// Roolo client
	private IRepository rooloClientCurnitRepository;

	private static final String FIND_ALL_QUERY = "from RooloOtmlModuleImpl";

	/**
	 * @see net.sf.sail.webapp.dao.SimpleDao#getById(java.io.Serializable)
	 */
	@Override
	public Module getById(Serializable id) throws ObjectNotFoundException {
		RooloOtmlModuleImpl module = (RooloOtmlModuleImpl) super.getById(id);
//		String rooloUri = module.getRooloModuleUri();
//		try {
//			URI uri = new URI(rooloUri);
//			IELO curnitProxy = rooloClientCurnitRepository.retrieveELO(uri);
//			module.populateModuleFromProxy(curnitProxy);
//		} catch (URISyntaxException e) {
//			e.printStackTrace();
//		}
		return module;
	}
	
	public IELO getEloForModule(Module mod){
		IELO elo = null;
		String rooloUri = ((RooloOtmlModuleImpl)mod).getRooloModuleUri();
		try{
			URI uri = new URI(rooloUri);
			elo = rooloClientCurnitRepository.retrieveELO(uri);
		} catch (URISyntaxException e){
			e.printStackTrace();
		}
		return elo;
	}
	
	/**
	 * @see net.sf.sail.webapp.dao.impl.AbstractHibernateDao#save(java.lang.Object)
	 */
	@Override
	public void save(Module module) {
		super.save(module);
		try{
			this.rooloClientCurnitRepository.updateELO(((RooloOtmlModuleImpl)module).getElo());
		} catch(ELODoesNotExistException e){  
			//if this is thrown, then add it to repository
			this.rooloClientCurnitRepository.addELO(((RooloOtmlModuleImpl)module).getElo());
		}
	}
	
	/**
	 * @see net.sf.sail.webapp.dao.impl.AbstractHibernateDao#delete(java.lang.Object)
	 */
	@Override
	public void delete(Module module){
		super.delete(module);
		try{
			this.rooloClientCurnitRepository.deleteELO(new URI( ((RooloOtmlModuleImpl)module).getRooloModuleUri()));
		} catch(URISyntaxException e){
			e.printStackTrace();
		}
	}
	
	/**
	 * @see net.sf.sail.webapp.dao.SimpleDao#getList()
	 */
	@Override
	public List<Module> getList() {
		List<Module> moduleList = super.getList();
		List<Module> modules = new ArrayList<Module>();
//		SimpleQueryMetadata query = new SimpleQueryMetadata();
//		CurnitMetadataProxy metadata = new CurnitMetadataProxy();
//		metadata.setMetadataValue(MetadataKeyProxy.URI, new MetadataValueProxy("%"));
//		query.setMetadataPattern(metadata);
//		List<URI> curnitIds = rooloClientCurnitRepository.search(query);
//		for(URI id : curnitIds) {
//			try {
//				modules.add( this.getById(id));
//			} catch (ObjectNotFoundException e) {
//			}
//		}
//		moduleList.addAll(modules);
//		for (Module module : moduleList) {
//			module
//		}
		return moduleList;
	}
	
	private ProjectInfo createProjectInfo(IMetadata metadata) {
		ProjectInfo info = new ProjectInfoImpl();
		IMetadataValueContainer container;
		container = metadata.getMetadataValueContainer(ELOMetadataKeys.AUTHOR.getKey());
		info.setAuthor( container.getValue().toString() );
		container = metadata.getMetadataValueContainer(ELOMetadataKeys.GRADELEVEL.getKey());
		info.setGradeLevel( container.getValue().toString() );
		container = metadata.getMetadataValueContainer(ELOMetadataKeys.SUBJECT.getKey());
		info.setSubject( container.getValue().toString() );
		container = metadata.getMetadataValueContainer(ELOMetadataKeys.KEYWORDS.getKey());
		info.setKeywords( container.getValue().toString() );
		//container = metadata.getMetadataValueContainer(CurnitClientMetadataKeys.LIFECYCLE.getKey());
		//info.setProjectLiveCycle( container.getValue().toString() );
		// TODO Add the lifecycle metadata
		container = metadata.getMetadataValueContainer(ELOMetadataKeys.KEYWORDS.getKey());		
		String familyTag = container.getValue().toString();
		List<FamilyTag> possibleValues = Arrays.asList( FamilyTag.values());
		if( familyTag != null && possibleValues.contains( FamilyTag.valueOf(familyTag))) {
			info.setFamilyTag(FamilyTag.valueOf(familyTag));
		}
		else {
			info.setFamilyTag(FamilyTag.OTHER);
		}
		container = metadata.getMetadataValueContainer(ELOMetadataKeys.COMMENT.getKey());
		String isCurrent = container.getValue().toString();
		info.setCurrent("yes".equals(isCurrent));
		container = metadata.getMetadataValueContainer(ELOMetadataKeys.COMMENT.getKey());
		info.setComment( container.getValue().toString() );
		container = metadata.getMetadataValueContainer(ELOMetadataKeys.DESCRIPTION.getKey());
		info.setDescription( container.getValue().toString() );
		return info;
	}

	/**
	 * @param rooloClientCurnitRepository the rooloClientCurnitRepository to set
	 */
	public void setRooloClientCurnitRepository(
			IRepository rooloClientCurnitRepository) {
		this.rooloClientCurnitRepository = rooloClientCurnitRepository;
	}

	/**
	 * @see net.sf.sail.webapp.dao.impl.AbstractHibernateDao#getDataObjectClass()
	 */
	@Override
	protected Class<RooloOtmlModuleImpl> getDataObjectClass() {
		return RooloOtmlModuleImpl.class;
	}

	/**
	 * @see net.sf.sail.webapp.dao.impl.AbstractHibernateDao#getFindAllQuery()
	 */
	@Override
	protected String getFindAllQuery() {
		return FIND_ALL_QUERY;
	}


	public Module getByUri(String uriString) {
		try {
			URI uri = new URI(uriString);
			IELO curnitProxy = rooloClientCurnitRepository.retrieveELO(uri);
			
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * @param rooloRepositoryUrl the rooloRepositoryUrl to set
	 */
	public void setRooloRepositoryUrl(String rooloRepositoryUrl) {
		this.rooloRepositoryUrl = rooloRepositoryUrl;
	}

	/**
	 * @return the rooloRepositoryUrl
	 */
	public String getRooloRepositoryUrl() {
		return rooloRepositoryUrl;
	}

	/**
	 * @param defaultOtrunkCurnitUrl the defaultOtrunkCurnitUrl to set
	 */
	public void setDefaultOtrunkCurnitUrl(String defaultOtrunkCurnitUrl) {
		this.defaultOtrunkCurnitUrl = defaultOtrunkCurnitUrl;
	}

	/**
	 * @return the defaultOtrunkCurnitUrl
	 */
	public String getDefaultOtrunkCurnitUrl() {
		return defaultOtrunkCurnitUrl;
	}

	public Long getLatestId() {
		// TODO Auto-generated method stub
		return null;
	}

}
