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
package org.telscenter.sail.webapp.presentation.web.controllers.author.module;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.sail.webapp.domain.impl.CurnitParameters;

import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;
import org.telscenter.sail.webapp.dao.module.impl.RooloOtmlModuleDao;
import org.telscenter.sail.webapp.domain.impl.CreateRooloOtmlModuleParameters;

import roolo.elo.api.IRepository;

/**
 * Controller for registering a new RooloOtmlModule with the portal.
 * Saves otml into RepositoryOfOpenLearningObjects (roolo).
 * 
 * @author Hiroki Terashima
 * @version $Id$
 */
public class RegisterRooloOtmlModuleController extends RegisterModuleController {
	
	private IRepository repository;

	/**
	 * @see net.sf.sail.webapp.presentation.web.controllers.curnit.RegisterCurnitController#onSubmit(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, java.lang.Object, org.springframework.validation.BindException)
	 */
	@Override
    protected ModelAndView onSubmit(HttpServletRequest request,
            HttpServletResponse response, Object command, BindException errors)  {
//		CreateRooloOtmlModuleParameters params = (CreateRooloOtmlModuleParameters) command;
//		params.setName(curnitProxy.getMetaData().getMetadataValue(MetadataKeyProxy.TITLE).getStringValue());
//		params.setUrl(RooloOtmlModuleDao.defaultOtrunkCurnitUrl);
//		params.setRoolouri(curnitProxy.getUri().toString());
//		params.setRooloRepositoryUrl(RooloOtmlModuleDao.rooloRepositoryUrl);
//		curnitService.createCurnit(params);
//
//		
//		CurnitParameters curnitParameters = (CurnitParameters) command;
//		this.curnitService.createCurnit(curnitParameters);
		
		return null;
	}

	/**
	 * @param repository the repository to set
	 */
	public void setRepository(IRepository repository) {
		this.repository = repository;
	}

}
