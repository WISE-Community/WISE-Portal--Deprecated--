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

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.validation.BindException;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import org.telscenter.sail.webapp.dao.module.impl.RooloOtmlModuleDao;
import org.telscenter.sail.webapp.domain.admin.OtmlFileUpload;
import org.telscenter.sail.webapp.domain.impl.CreateOtmlModuleParameters;
import org.telscenter.sail.webapp.presentation.util.Util;

/**
 * Allows authors to upload an otml file and register it as an available
 * module in the portal.  Once added, the module becomes available to
 * use in a project.
 * 
 * @author hirokiterashima
 * @version $Id$
 */
public class RegisterOtmlModuleController extends RegisterModuleController {

	/**
	 * @override @see org.springframework.web.servlet.mvc.SimpleFormController#onSubmit(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, java.lang.Object, org.springframework.validation.BindException)
	 */
	@Override
	protected ModelAndView onSubmit(HttpServletRequest request,
			HttpServletResponse response, Object command, BindException errors) {
		OtmlFileUpload bean = (OtmlFileUpload) command;
		MultipartFile file = bean.getFile();
				
		
		if (file == null) {
			ModelAndView modelAndView = new ModelAndView(new RedirectView(getSuccessView()));		
			return modelAndView;
		} else {
			CreateOtmlModuleParameters params = new CreateOtmlModuleParameters();
			params.setName(bean.getName());
			params.setUrl(RooloOtmlModuleDao.defaultOtrunkCurnitUrl);
			params.setRetrieveotmlurl(Util.getPortalUrl(request) + "/repository/retrieveotml.html?otmlModuleId=");
			try {
				params.setOtml(file.getBytes());
			} catch (IOException e) {
				e.printStackTrace();
				return null;
			}
			curnitService.createCurnit(params);
		}
		return null;
	}
		
}
