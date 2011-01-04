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
package org.telscenter.sail.webapp.presentation.web.controllers.repository;

import java.io.ByteArrayOutputStream;
import java.net.URI;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import org.telscenter.sail.webapp.domain.impl.OtmlModuleImpl;
import org.telscenter.sail.webapp.service.module.ModuleService;
import org.telscenter.sail.webapp.service.repository.RepositoryService;

import roolo.elo.api.IELO;

/**
 * Retrieves otml from local repository and returns it.
 * 
 * a curnitId needs to be passed in the request
 * 
 * @author Hiroki Terashima
 * @version $Id$
 */
public class RetrieveOtmlController extends AbstractController {

	protected static final String URI_PARAM = "uri";

	protected static final String OTMLMODULEID_PARAM = "otmlModuleId";

	private static final String XML_CONTENT_TYPE = "application/xml";
	
	private RepositoryService repositoryService;
	
	private ModuleService moduleService;

	/**
	 * @see org.springframework.web.servlet.mvc.AbstractController#handleRequestInternal(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	@Override
	protected ModelAndView handleRequestInternal(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		byte[] otmlData = null;
		
		String uriString = request.getParameter(URI_PARAM);

		String otmlModuleIdString = request.getParameter(OTMLMODULEID_PARAM);

		
		if (uriString != null) {
			URI uri = new URI(uriString);

			IELO elo = repositoryService.getByUri(uri);
			otmlData = elo.getContent().getBytes();
		} else if (otmlModuleIdString != null) {
			Long moduleId = Long.parseLong(otmlModuleIdString);
			OtmlModuleImpl module = (OtmlModuleImpl) moduleService.getById(moduleId);
			otmlData = module.getOtml();
		}
		response.setContentType(XML_CONTENT_TYPE);

		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader ("Expires", 0);

		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		baos.write(otmlData);
		baos.writeTo(response.getOutputStream());
				
		/*
		BufferedReader in = new BufferedReader(
				new StringReader(otmlData.toString()));
		String inputLine;
		while ((inputLine = in.readLine()) != null) {
			response.getWriter().print(inputLine + "\n");			
		}
		*/

		return null;

	}


	/**
	 * @param repositoryService the repositoryService to set
	 */
	public void setRepositoryService(RepositoryService repositoryService) {
		this.repositoryService = repositoryService;
	}


	/**
	 * @param moduleService the moduleService to set
	 */
	public void setModuleService(ModuleService moduleService) {
		this.moduleService = moduleService;
	}

}
