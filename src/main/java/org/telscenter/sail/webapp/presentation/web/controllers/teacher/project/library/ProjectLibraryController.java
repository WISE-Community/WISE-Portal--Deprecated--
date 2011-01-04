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
package org.telscenter.sail.webapp.presentation.web.controllers.teacher.project.library;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.sail.webapp.domain.User;
import net.sf.sail.webapp.domain.impl.CurnitGetCurnitUrlVisitor;
import net.sf.sail.webapp.presentation.web.controllers.ControllerUtil;

import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;
import org.springframework.web.servlet.view.RedirectView;
import org.telscenter.sail.webapp.domain.project.Project;
import org.telscenter.sail.webapp.service.offering.RunService;
import org.telscenter.sail.webapp.service.project.ProjectService;

/**
 * Controller for displaying WISE's Project Library
 * 
 * @authors Hiroki Terashima, Patrick Lawler
 * @version $Id$
 */
public class ProjectLibraryController extends SimpleFormController {

	private ProjectService projectService;
	
	private RunService runService;
	
	private Properties portalProperties;
	
	/**
	 * @see org.springframework.web.servlet.mvc.SimpleFormController#onSubmit(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, java.lang.Object, org.springframework.validation.BindException)
	 */
	@Override
    protected ModelAndView onSubmit(HttpServletRequest request,
            HttpServletResponse response, Object command, BindException errors) {
		SearchProjectLibraryParameters params = (SearchProjectLibraryParameters) command;
		String query = "select project from ProjectImpl as project where project.isPublic=1";
		
		query = this.appendFamilyTagCriteria(query, params.getFamily());
		query = this.appendStatusCriteria(query, params.getStatus());
		query = this.appendTextFieldsCriteria(query, params);
		query = this.appendNumericFieldsCriteria(query, params);
		
		ModelAndView mav = new ModelAndView(new RedirectView("projectlibrary.html"));
		mav.addObject("query", query);
		return mav;
	}
	
	/**
	 * @see org.springframework.web.servlet.mvc.AbstractFormController#formBackingObject(javax.servlet.http.HttpServletRequest)
	 */
	@Override
	protected Object formBackingObject(HttpServletRequest request) throws Exception {
		SearchProjectLibraryParameters params = new SearchProjectLibraryParameters();
		params.setFamily("-1");
		params.setStatus("-1");
		params.setSearchtype("contains");
		return params;
	}
	
	/**
	 * @see org.springframework.web.servlet.mvc.SimpleFormController#referenceData(javax.servlet.http.HttpServletRequest)
	 */
	@Override
	protected Map<String, Object> referenceData(HttpServletRequest request) 
	    throws Exception {
		Map<String, Object> model = new HashMap<String, Object>();
		User user = ControllerUtil.getSignedInUser();
		List<Project> projectList;
		String query = request.getParameter("query");
		
		if(query != null && query != ""){
			projectList = this.projectService.getProjectList(query);
		} else {
			projectList = new ArrayList<Project>();
		}
		
		String curriculumBaseDir = this.portalProperties.getProperty("curriculum_base_dir");
		Map<Long,Integer> usageMap = new TreeMap<Long,Integer>();
		Map<Long,String> urlMap = new TreeMap<Long,String>();
		Map<Long,String> filenameMap = new TreeMap<Long,String>();
		for(Project p : projectList){
			String url = (String) p.getCurnit().accept(new CurnitGetCurnitUrlVisitor());
			if(url != null && url != ""){
				int ndx = url.lastIndexOf("/");
				if(ndx == -1){
					urlMap.put((Long) p.getId(), curriculumBaseDir);
					filenameMap.put((Long) p.getId(), url);
				} else {
					urlMap.put((Long) p.getId(), curriculumBaseDir + "/" + url.substring(0, ndx));
					filenameMap.put((Long) p.getId(), url.substring(ndx + 1, url.length()));
				}
			}
			usageMap.put((Long) p.getId(), this.runService.getProjectUsage((Long) p.getId()));
		}
		
		model.put("userId", user.getId());
		model.put("projectList", projectList);
		model.put("usageMap", usageMap);
		model.put("urlMap", urlMap);
		model.put("filenameMap", filenameMap);
		model.put("curriculumBaseDir", curriculumBaseDir);
		return model;
	}
	
	/**
	 * Given a <code>String</code> query and the <code>String</code> val, appends
	 * the family tag criteria to the query if val is not empty or null and returns
	 * the <code>String</code> query.
	 * 
	 * @param <code>String</code> query
	 * @param <code>String</code> val
	 * @return <code>String</code> query
	 */
	private String appendFamilyTagCriteria(String query, String val){
		if(val != null && val != "" && !val.equals("-1")){
			String base = " project.familytag=\'" + val + "\'";
			return this.insertAppropriateLead(query, base);
		}
		
		return query;
	}
	
	/**
	 * Given a <code>String</code> query and the <code>String</code> val, appends
	 * the project status criteria to the query if val is not empty or null and returns
	 * the <code>String</code> query.
	 * 
	 * @param <code>String</code> query
	 * @param <code>String</code> val
	 * @return <code>String</code> query
	 */
	private String appendStatusCriteria(String query, String val){
		if(val != null && val != "" && !val.equals("-1")){
			String base = " project.isCurrent=" + val;
			return this.insertAppropriateLead(query, base);
		}
		
		return query;
	}
	
	/**
	 * Given the <code>String</code> query and the <code>SearchProjectLibraryParameters</code>
	 * params, creates the appropriate criteria for all of the text fields, appends and returns
	 * the <code>String</code> query.
	 * 
	 * @param <code>String</code> query
	 * @param <code>String</code> params
	 * @return <code>String</code> query
	 */
	private String appendTextFieldsCriteria(String query, SearchProjectLibraryParameters params){
		String precedingText;
		String followingText;
		
		//get the search type and set the appropriate preceding and following text
		if(params.getSearchtype().equals("matches")){
			precedingText = "=\'";
			followingText = "\'";
		} else {
			precedingText = " like \'%";
			followingText = "%\'";
		}
		
		query = this.appendTextFieldCriteria(query, "title", params.getTitle(), precedingText, followingText);
		query = this.appendTextFieldCriteria(query, "author", params.getAuthor(), precedingText, followingText);
		query = this.appendTextFieldCriteria(query, "contact", params.getContact(), precedingText, followingText);
		query = this.appendTextFieldCriteria(query, "summary", params.getSummary(), precedingText, followingText);
		query = this.appendTextFieldCriteria(query, "subject", params.getSubject(), precedingText, followingText);
		query = this.appendTextFieldCriteria(query, "gradeRange", params.getGradeRange(), precedingText, followingText);
		query = this.appendTextFieldCriteria(query, "techReqs", params.getTechReqs(), precedingText, followingText);
		
		return query;
	}
	
	/**
	 * Given the <code>String</code> query, <code>String</code> field name, <code>String</code> value,
	 * <code>String</code> preceding search type text and <code>String</code> following search type
	 * text, constructs the appropriate criteria, appends it the query and returns the <code>String</code>
	 * query.
	 * 
	 * @param <code>String</code> query
	 * @param <code>String</code> name
	 * @param <code>String</code> val
	 * @param <code>String</code> precedingText
	 * @param <code>String</code> followingText
	 * @return <code>String</code> query
	 */
	private String appendTextFieldCriteria(String query, String name, String val, String precedingText, String followingText){
		if(val != null && val != ""){
			String base = " project.metadata." + name + precedingText + val + followingText;
			return this.insertAppropriateLead(query, base);
		}
		
		return query;
	}
	
	/**
	 * Given the <code>String</code> query and the <code>SearchProjectLibraryParameters</code>
	 * params, creates the appropriate criteria for all of the numeric fields, appends and returns
	 * the <code>String</code> query.
	 * 
	 * @param <code>String</code> query
	 * @param <code>String</code> params
	 * @return <code>String</code> query
	 */
	private String appendNumericFieldsCriteria(String query, SearchProjectLibraryParameters params){
		query = this.appendNumericFieldCriteria(query, "totalTime", params.getTotalTime());
		query = this.appendNumericFieldCriteria(query, "compTime", params.getCompTime());
		
		return query;
	}
	
	/**
	 * Given the <code>String</code> query, <code>String</code> field name, <code>String</code> value,
	 * constructs the appropriate criteria, appends it the query and returns the <code>String</code> query.
	 * 
	 * @param <code>String</code> query
	 * @param <code>String</code> name
	 * @param <code>String</code> val
	 * @return <code>String</code> query
	 */
	private String appendNumericFieldCriteria(String query, String name, String val){
		if(val != null && val != ""){
			String base = " project.metadata." + name + "=" + val;
			return this.insertAppropriateLead(query, base);
		}
		
		return query;
	}
	
	/**
	 * Given the <code>String</code> query and the <code>String</code>
	 * base criteria, checks the query to determine if any previous
	 * criteria has been inserted and appends the appropriate lead followed
	 * by the base to the query and returns the <code>String</code> query
	 * 
	 * @param <code>String</code> query
	 * @param <code>String</code> base
	 * @return <code>String</code> query
	 */
	private String insertAppropriateLead(String query, String base){
		if(query.indexOf("as project where") == -1){
			query += " where" + base;
		} else {
			query += " and" + base;
		}
		
		return query;
	}
	
	/**
	 * @param projectService the projectService to set
	 */
	public void setProjectService(ProjectService projectService) {
		this.projectService = projectService;
	}

	/**
	 * @param runService the runService to set
	 */
	public void setRunService(RunService runService) {
		this.runService = runService;
	}

	/**
	 * @param portalProperties the portalProperties to set
	 */
	public void setPortalProperties(Properties portalProperties) {
		this.portalProperties = portalProperties;
	}
}
