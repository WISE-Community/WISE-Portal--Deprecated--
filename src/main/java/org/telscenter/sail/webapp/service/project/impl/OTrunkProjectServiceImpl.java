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
package org.telscenter.sail.webapp.service.project.impl;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.sail.webapp.dao.ObjectNotFoundException;
import net.sf.sail.webapp.domain.Curnit;
import net.sf.sail.webapp.domain.User;
import net.sf.sail.webapp.domain.Workgroup;
import net.sf.sail.webapp.domain.webservice.http.HttpRestTransport;
import net.sf.sail.webapp.service.NotAuthorizedException;

import org.springframework.security.acls.domain.BasePermission;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import org.telscenter.sail.webapp.domain.Run;
import org.telscenter.sail.webapp.domain.impl.RooloOtmlModuleImpl;
import org.telscenter.sail.webapp.domain.impl.RunParameters;
import org.telscenter.sail.webapp.domain.project.FamilyTag;
import org.telscenter.sail.webapp.domain.project.Project;
import org.telscenter.sail.webapp.domain.project.cmsImpl.RooloProjectImpl;
import org.telscenter.sail.webapp.domain.project.impl.AuthorProjectParameters;
import org.telscenter.sail.webapp.domain.project.impl.LaunchProjectParameters;
import org.telscenter.sail.webapp.domain.project.impl.PreviewProjectParameters;
import org.telscenter.sail.webapp.domain.project.impl.ProjectImpl;

/**
 * ProjectService for OTrunk projects: 
 *    http://confluence.concord.org/display/CSP/OTrunk
 * 
 * @author Hiroki Terashima
 * @version $Id$
 */
public class OTrunkProjectServiceImpl extends PodProjectServiceImpl {
	
	/**
	 * Creates a PreviewRun for this project and
	 * set it in this project. Overrides PodProjectService's 
	 * createPreviewRun method. This method does not generate
	 * a curnitmap because OTrunk projects do not use curnitmaps
	 * 
	 * @param project
	 * @throws ObjectNotFoundException 
	 */
	@Override
	@Transactional
	protected void createPreviewRun(Project project) throws ObjectNotFoundException {
		RunParameters runParameters = new RunParameters();
		runParameters.setCurnitId(project.getCurnit().getId());
		runParameters.setJnlpId(project.getJnlp().getId());
		runParameters.setName(PREVIEW_RUN_NAME);
		runParameters.setOwners(null);
		runParameters.setPeriodNames(PREVIEW_PERIOD_NAMES);
		runParameters.setProject(project);
		Run previewRun = this.runService.createRun(runParameters);
		project.setPreviewRun(previewRun);
		this.projectDao.save(project);
	}
	
	/**
	 * @throws IOException 
	 * @see org.telscenter.sail.webapp.service.project.ProjectService#previewProject(java.lang.Long)
	 */
	@Override
	@Transactional
	public ModelAndView previewProject(PreviewProjectParameters params) throws ObjectNotFoundException, IOException {
		Project project = params.getProject();
		// this is a temporary hack until projects can be run without have to create a 
		// workgroup with at least 1 member in it. See this JIRA task:
		// http://jira.concord.org/browse/SDS-23
		User previewUser = userService.retrieveById(new Long(2));// preview user is user #2 in the database
		Workgroup previewWorkgroup = 
			workgroupService.getWorkgroupForPreviewOffering(project.getPreviewRun(), previewUser);
		
		String previewProjectUrl = generatePreviewProjectUrlString(
				params.getHttpRestTransport(),
				project.getPreviewRun(),
				previewWorkgroup);
		
		Curnit curnit = project.getCurnit();
		String curnitOtmlUrl = ((RooloOtmlModuleImpl) curnit).getRetrieveOtmlUrl();
		previewProjectUrl += "?sailotrunk.otmlurl=" + curnitOtmlUrl;
		// TODO HT: put these param-generation into run/project domain object as much as possible to stop
		// cluttering services
		if (project.getFamilytag().equals(FamilyTag.UCCP)) {
			previewProjectUrl += "&jnlp.style=UCCP";			
		}
		
		
		return new ModelAndView(new RedirectView(previewProjectUrl));
	}
	
	
	/**
	 * @see org.telscenter.sail.webapp.service.project.ProjectService#authorProject(org.telscenter.sail.webapp.domain.project.impl.AuthorProjectParameters)
	 */
	@Override
	@Transactional
	public ModelAndView authorProject(AuthorProjectParameters authorProjectParameters)
			throws Exception {
		// TODO get the author jnlpurl from project
		Project project = authorProjectParameters.getProject();
		String curnitUrl = project.getCurnit().getSdsCurnit().getUrl();
		
		if (project instanceof ProjectImpl || curnitUrl == null) {
			curnitUrl = "http://www.telscenter.org/confluence/download/attachments/20047/Airbags.otml";
		} else if (project instanceof RooloProjectImpl) {
			curnitUrl = "http://localhost:8080/webapp/repository/retrieveotml.html?uri=" + ((RooloProjectImpl) project).getProxy().getUri();
		}
		
		Curnit curnit = project.getCurnit();
		RooloOtmlModuleImpl rooloOtmlModule = (RooloOtmlModuleImpl) curnit;
		curnitUrl = rooloOtmlModule.getRetrieveOtmlUrl();

		URL jnlpURL = new URL(authoringToolJnlpUrl);
		BufferedReader in = new BufferedReader(
				new InputStreamReader(jnlpURL.openStream()));
		
		String jnlpString = "";
		String inputLine;
		while ((inputLine = in.readLine()) != null) {
			jnlpString += inputLine;
		}

		HttpServletResponse httpServletResponse = authorProjectParameters.getHttpServletResponse();
		
		String outputJNLPString = modifier.modifyJnlp(jnlpString, curnitUrl, (Long) project.getId());
		httpServletResponse.setHeader("Cache-Control", "no-cache");
		httpServletResponse.setHeader("Pragma", "no-cache");
		httpServletResponse.setDateHeader ("Expires", 0);

		String fileName = authorProjectParameters.getHttpServletRequest().getServletPath();
		fileName = fileName.substring(fileName.lastIndexOf("/") + 1);
		fileName = fileName.substring(0, fileName.indexOf(".")) + ".jnlp";
		httpServletResponse.addHeader("Content-Disposition", "Inline; fileName=" + fileName);

		httpServletResponse.setContentType(JNLP_CONTENT_TYPE);
		httpServletResponse.getWriter().print(outputJNLPString);
		System.out.println(outputJNLPString);
		
		return null;
	}
	
	/**
	 * @override @see org.telscenter.sail.webapp.service.project.ProjectService#updateProject(org.telscenter.sail.webapp.domain.project.Project)
	 */
	@Override
	@Transactional()
	public void updateProject(Project project, User user) throws NotAuthorizedException {
		if(this.aclService.hasPermission(project, BasePermission.ADMINISTRATION, user) || 
				this.aclService.hasPermission(project, BasePermission.WRITE, user)){
			this.projectDao.save(project);
			Curnit curnit = project.getCurnit();
			RooloOtmlModuleImpl rooloOtmlModule = (RooloOtmlModuleImpl) curnit;
			//rooloOtmlModule.updateProxy(project.getProjectInfo());
			curnitService.updateCurnit(project.getCurnit());
		} else {
			throw new NotAuthorizedException("You are not authorized to update this project");
		}
	}
	
	/**
	 * @see org.telscenter.sail.webapp.service.project.ProjectService#launchProject(org.telscenter.sail.webapp.domain.project.impl.LaunchProjectParameters)
	 */
	@Override
	public ModelAndView launchProject(LaunchProjectParameters params) {
		String entireUrl = generateStudentStartProjectUrlString(
				params.getHttpRestTransport(), params.getHttpServletRequest(), 
				params.getRun(), params.getWorkgroup(),
				retrieveAnnotationBundleUrl
				);
		return new ModelAndView(new RedirectView(entireUrl));
	}
	
	/**
	 * Generates the url string that users need to go to start the project
	 * @param httpRestTransport
	 * @param request request that was made
	 * @param run <code>Run</code> that the user is in
	 * @param workgroup <code>Workgroup</code> that the user is in
	 * @param retrieveAnnotationBundleUrl
	 * @returnurl String url representation to download the jnlp and start
     *     the project
	 */
	@Override
	public String generateStudentStartProjectUrlString(HttpRestTransport httpRestTransport, HttpServletRequest request,
			Run run, Workgroup workgroup, String retrieveAnnotationBundleUrl) {
		String jnlpUrl = generateLaunchProjectUrlString(httpRestTransport, run,
				workgroup);

		String entireUrl = jnlpUrl + "?" + generateRetrieveAnnotationBundleParamRequestString(request, workgroup);
		// TODO HT: put these param-generation into run/project domain object as much as possible to stop
		// cluttering services
		// add jnlp.portal_baseurl and jnlp.runId to the request
		entireUrl += "&" + generatePortalBaseUrlParamRequestString(request);
		entireUrl += "&" + generateRunIdParamRequestString(run.getId());
		if (run.getProject().getFamilytag().equals(FamilyTag.UCCP)) {
			entireUrl += "&jnlp.style=UCCP";			
		}
		Curnit curnit = run.getProject().getCurnit();
		String curnitOtmlUrl = ((RooloOtmlModuleImpl) curnit).getRetrieveOtmlUrl();
		entireUrl += "&sailotrunk.otmlurl=" + curnitOtmlUrl;

		return entireUrl;
	}
	
}
