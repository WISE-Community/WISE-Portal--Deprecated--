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
package org.telscenter.sail.webapp.service.module.impl;

import java.util.ArrayList;
import java.util.List;

import net.sf.sail.webapp.dao.ObjectNotFoundException;
import net.sf.sail.webapp.dao.sds.HttpStatusCodeException;
import net.sf.sail.webapp.domain.Curnit;
import net.sf.sail.webapp.domain.impl.CurnitParameters;
import net.sf.sail.webapp.domain.sds.SdsCurnit;
import net.sf.sail.webapp.service.curnit.impl.CurnitServiceImpl;

import org.springframework.transaction.annotation.Transactional;
import org.telscenter.sail.webapp.dao.module.ModuleDao;
import org.telscenter.sail.webapp.domain.Module;
import org.telscenter.sail.webapp.domain.impl.CreateOtmlModuleParameters;
import org.telscenter.sail.webapp.domain.impl.CreateRooloOtmlModuleParameters;
import org.telscenter.sail.webapp.domain.impl.CreateRooloXmlModuleParameters;
import org.telscenter.sail.webapp.domain.impl.CreateUrlModuleParameters;
import org.telscenter.sail.webapp.domain.impl.ModuleImpl;
import org.telscenter.sail.webapp.domain.impl.OtmlModuleImpl;
import org.telscenter.sail.webapp.domain.impl.RooloOtmlModuleImpl;
import org.telscenter.sail.webapp.domain.impl.UrlModuleImpl;
import org.telscenter.sail.webapp.service.module.ModuleService;

import roolo.elo.api.IELO;

/**
 *  Service for the TELS's Module Domain Object
 *  
 * @author Hiroki Terashima
 * @version $Id$
 */
public class ModuleServiceImpl extends CurnitServiceImpl implements
		ModuleService {
	
	private ModuleDao<Module> moduleDao;
	
	private ModuleDao<Module> rooloOtmlModuleDao;
	
	/**
	 * @see net.sf.sail.webapp.service.curnit.impl.CurnitServiceImpl#createCurnit(net.sf.sail.webapp.domain.impl.CurnitParameters)
	 */
	 @Override
	 @Transactional(rollbackFor = { HttpStatusCodeException.class })	
	 public Module createCurnit(CurnitParameters curnitParameters) {
		Module module = null;
		
		if(curnitParameters instanceof CreateRooloXmlModuleParameters){
			module = new RooloOtmlModuleImpl();
			((RooloOtmlModuleImpl) module).setElo(((CreateRooloXmlModuleParameters)curnitParameters).getElo());
			((RooloOtmlModuleImpl) module).setRooloModuleUri(((CreateRooloXmlModuleParameters)curnitParameters).getRoolouri());
			((RooloOtmlModuleImpl) module).setRooloRepositoryUrl(((CreateRooloXmlModuleParameters)curnitParameters).getRooloRepositoryUrl());
			this.rooloOtmlModuleDao.save(module);
		} else if (curnitParameters instanceof CreateUrlModuleParameters) {
			UrlModuleImpl urlModule = new UrlModuleImpl();
			urlModule.setName(((CreateUrlModuleParameters) curnitParameters).getName());
			urlModule.setModuleUrl(((CreateUrlModuleParameters) curnitParameters).getUrl());
			this.moduleDao.save(urlModule);
			return urlModule;
		} else {
			SdsCurnit sdsCurnit = new SdsCurnit();
			sdsCurnit.setName(curnitParameters.getName());
			sdsCurnit.setUrl(curnitParameters.getUrl());
		    this.sdsCurnitDao.save(sdsCurnit);  
		    
		    if (curnitParameters instanceof CreateRooloOtmlModuleParameters) {
		    	module = new RooloOtmlModuleImpl();
		    	module.setSdsCurnit(sdsCurnit);
		    	((RooloOtmlModuleImpl) module).setRooloModuleUri(
		    			((CreateRooloOtmlModuleParameters) curnitParameters).getRoolouri());
		    	((RooloOtmlModuleImpl) module).setRooloRepositoryUrl(
		    			((CreateRooloOtmlModuleParameters) curnitParameters).getRooloRepositoryUrl());
		    	((RooloOtmlModuleImpl) module).setElo(((CreateRooloOtmlModuleParameters) curnitParameters).getElo());
		    	this.rooloOtmlModuleDao.save(module);
		    } else if (curnitParameters instanceof CreateOtmlModuleParameters) {
		    	OtmlModuleImpl otmlModuleImpl = new OtmlModuleImpl();
		    	otmlModuleImpl.setOtml(((CreateOtmlModuleParameters) curnitParameters).getOtml());
		    	otmlModuleImpl.setSdsCurnit(sdsCurnit);
		    	this.moduleDao.save(otmlModuleImpl);
		    	Long id = otmlModuleImpl.getId();
		    	// save id.  changeme with url.
		    	if (((CreateOtmlModuleParameters) curnitParameters).getRetrieveotmlurl() == null) {
		    		otmlModuleImpl.setRetrieveotmlurl("http://localhost:8080/webapp/repository/retrieveotml.html?otmlModuleId=" + id);	    
		    	} else {
		    		otmlModuleImpl.setRetrieveotmlurl(((CreateOtmlModuleParameters) curnitParameters).getRetrieveotmlurl() + id);
		    	}
		    	this.moduleDao.save(otmlModuleImpl);
		    	return otmlModuleImpl;
		    } else {
		    	module = new ModuleImpl();
		    	module.setSdsCurnit(sdsCurnit);
		    	this.moduleDao.save(module);
		    }
		}
    	return module;
	}

	 /**
	  * @see net.sf.sail.webapp.service.curnit.CurnitService#getCurnitList()
	  */
	 @Override	 
	 @Transactional(readOnly = true)
	 public List<? extends Curnit> getCurnitList() {
		 List<Module> podModuleList = this.moduleDao.getList();
		 List<Module> otmlModuleList = this.rooloOtmlModuleDao.getList();
		 List<Module> moduleList = new ArrayList<Module>();
		 moduleList.addAll(podModuleList);
		 moduleList.addAll(otmlModuleList);
		return moduleList;
		 
	 }
	 
	/**
	 * @throws ObjectNotFoundException 
	 * @see net.sf.sail.webapp.service.curnit.impl.CurnitServiceImpl#getById(java.lang.Long)
	 */
	@Override
	public Module getById(Long moduleId) throws ObjectNotFoundException {
		Module module = null;
		 try {
			module = moduleDao.getById(moduleId);
		} catch (ObjectNotFoundException e) {
			module = rooloOtmlModuleDao.getById(moduleId);
		} 
		return module;
	}
	
	/**
	 * @see net.sf.sail.webapp.service.curnit.CurnitService#updateCurnit(net.sf.sail.webapp.domain.Curnit)
	 */
	@Override
	@Transactional()
	public void updateCurnit(Curnit curnit) {
		if (curnit instanceof RooloOtmlModuleImpl) {
			this.rooloOtmlModuleDao.save((Module) curnit);
		} else {
			SdsCurnit sdsCurnit = curnit.getSdsCurnit();
			this.sdsCurnitDao.save(sdsCurnit);
			this.moduleDao.save((Module) curnit);
		}
	}

	public IELO getEloForModule(RooloOtmlModuleImpl mod) {
		return this.rooloOtmlModuleDao.getEloForModule(mod);
	}

	/**
	 * @param moduleDao the moduleDao to set
	 */
	public void setModuleDao(ModuleDao<Module> moduleDao) {
		this.moduleDao = moduleDao;
	}

	/**
	 * @param rooloOtmlModuleDao the rooloOtmlModuleDao to set
	 */
	public void setRooloOtmlModuleDao(ModuleDao<Module> rooloOtmlModuleDao) {
		this.rooloOtmlModuleDao = rooloOtmlModuleDao;
	}

}
