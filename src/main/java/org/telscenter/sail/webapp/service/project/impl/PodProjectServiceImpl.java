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
import java.io.Serializable;
import java.net.URL;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.sail.webapp.dao.ObjectNotFoundException;
import net.sf.sail.webapp.domain.Curnit;
import net.sf.sail.webapp.domain.Jnlp;
import net.sf.sail.webapp.domain.User;
import net.sf.sail.webapp.domain.Workgroup;
import net.sf.sail.webapp.domain.webservice.http.HttpRestTransport;
import net.sf.sail.webapp.service.AclService;
import net.sf.sail.webapp.service.NotAuthorizedException;
import net.sf.sail.webapp.service.UserService;
import net.sf.sail.webapp.service.curnit.CurnitService;
import net.sf.sail.webapp.service.file.impl.AuthoringJNLPModifier;
import net.sf.sail.webapp.service.jnlp.JnlpService;
import net.sf.sail.webapp.service.workgroup.WorkgroupService;

import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.acls.model.AlreadyExistsException;
import org.springframework.security.acls.model.NotFoundException;
import org.springframework.security.acls.model.Permission;
import org.springframework.security.acls.domain.BasePermission;
import org.springframework.security.annotation.Secured;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import org.telscenter.sail.webapp.dao.project.ProjectDao;
import org.telscenter.sail.webapp.domain.Run;
import org.telscenter.sail.webapp.domain.impl.AddSharedTeacherParameters;
import org.telscenter.sail.webapp.domain.impl.ModuleImpl;
import org.telscenter.sail.webapp.domain.impl.ProjectParameters;
import org.telscenter.sail.webapp.domain.impl.RunParameters;
import org.telscenter.sail.webapp.domain.project.FamilyTag;
import org.telscenter.sail.webapp.domain.project.Project;
import org.telscenter.sail.webapp.domain.project.ProjectInfo;
import org.telscenter.sail.webapp.domain.project.ProjectMetadata;
import org.telscenter.sail.webapp.domain.project.Tag;
import org.telscenter.sail.webapp.domain.project.impl.AuthorProjectParameters;
import org.telscenter.sail.webapp.domain.project.impl.LaunchProjectParameters;
import org.telscenter.sail.webapp.domain.project.impl.LaunchReportParameters;
import org.telscenter.sail.webapp.domain.project.impl.PreviewProjectParameters;
import org.telscenter.sail.webapp.domain.project.impl.ProjectImpl;
import org.telscenter.sail.webapp.presentation.util.json.JSONObject;
import org.telscenter.sail.webapp.service.authentication.UserDetailsService;
import org.telscenter.sail.webapp.service.offering.RunService;
import org.telscenter.sail.webapp.service.project.ProjectService;

/**
 * TELS Portal's PodProjectService can work with projects that are persisted
 * in the local datastore via hibernate, as well as projects that are persisted
 * in the local or remote content management system, via rmi or webdav.
 * 
 * @author Hiroki Terashima
 *
 * @version $Id$
 */
public class PodProjectServiceImpl implements ProjectService {

	protected static final String PREVIEW_RUN_NAME = "preview";

	private static final String PREVIEW_PERIOD_NAME = "preview period";

	protected static final String JNLP_CONTENT_TYPE = "application/x-java-jnlp-file";
	
	protected static Set<String> PREVIEW_PERIOD_NAMES;

	protected ProjectDao<Project> projectDao;
	
	protected CurnitService curnitService;
	
	protected JnlpService jnlpService;
	
	protected RunService runService;
	
	protected WorkgroupService workgroupService;
	
	protected UserService userService;

	protected AuthoringJNLPModifier modifier;
	
	protected String authoringToolJnlpUrl;
	
	public static String retrieveAnnotationBundleUrl = "/student/getannotationbundle.html";

	protected AclService<Project> aclService;

	{
		PREVIEW_PERIOD_NAMES = new HashSet<String>();
		PREVIEW_PERIOD_NAMES.add(PREVIEW_PERIOD_NAME);
	}
	
	/**
	 * @see org.telscenter.sail.webapp.service.project.ProjectService#createProject(org.telscenter.sail.webapp.domain.impl.ProjectParameters)
	 */
	@Transactional(rollbackFor = { AlreadyExistsException.class,
            NotFoundException.class, DataIntegrityViolationException.class
	})
	public Project createProject(ProjectParameters projectParameters) 
	    throws ObjectNotFoundException {
		Curnit curnit = 
			this.curnitService.getById(projectParameters.getCurnitId());
		Jnlp jnlp = 
			this.jnlpService.getById(projectParameters.getJnlpId());
		Project project = this.projectDao.createEmptyProject();
		project.setCurnit(curnit);
		project.setJnlp(jnlp);
		project.setName(projectParameters.getProjectname());
		project.setOwners(projectParameters.getOwners());
		project.setMetadata(projectParameters.getMetadata());
		this.projectDao.save(project);
		this.aclService.addPermission(project, BasePermission.ADMINISTRATION);		
		createPreviewRun(project);
		return project;
	}

	/**
	 * @override @see org.telscenter.sail.webapp.service.project.ProjectService#updateProject(org.telscenter.sail.webapp.domain.project.Project)
	 */
	@Transactional()
	public void updateProject(Project project, User user) throws NotAuthorizedException{
		if(this.aclService.hasPermission(project, BasePermission.ADMINISTRATION, user) || 
				this.aclService.hasPermission(project, BasePermission.WRITE, user)){
			this.projectDao.save(project);
		} else {
			throw new NotAuthorizedException("You are not authorized to update this project.");
		}
	}
	
	/**
	 * Creates a PreviewRun for this project and
	 * set it in this project
	 * @param project
	 * @throws ObjectNotFoundException 
	 */
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
	 * @see org.telscenter.sail.webapp.service.project.ProjectService#launchProject(org.telscenter.sail.webapp.domain.project.impl.LaunchProjectParameters)
	 */
	public ModelAndView launchProject(LaunchProjectParameters params) {
		String entireUrl = generateStudentStartProjectUrlString(
				params.getHttpRestTransport(), params.getHttpServletRequest(), 
				params.getRun(), params.getWorkgroup(),
				retrieveAnnotationBundleUrl
				);
		return new ModelAndView(new RedirectView(entireUrl));
	}

	/**
	 * @throws IOException 
	 * @see org.telscenter.sail.webapp.service.project.ProjectService#previewProject(java.lang.Long)
	 */
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
				
		return new ModelAndView(new RedirectView(previewProjectUrl));
	}
	
	/**
	 * @see org.telscenter.sail.webapp.service.project.ProjectService#authorProject(org.telscenter.sail.webapp.domain.project.impl.AuthorProjectParameters)
	 */
	@Transactional
	public ModelAndView authorProject(AuthorProjectParameters authorProjectParameters)
			throws Exception {
		// TODO get the author jnlpurl from project
		
		// TODO replace the below when ready to switch to otml
		//String curnitUrl = project.getCurnit().getSdsCurnit().getUrl();
		Project project = authorProjectParameters.getProject();
		String curnitUrl = project.getCurnit().getSdsCurnit().getUrl();
		
		if (project instanceof ProjectImpl || curnitUrl == null) {
			curnitUrl = "http://www.telscenter.org/confluence/download/attachments/20047/Airbags.otml";
		} else {
		}
		//else if (project instanceof RooloProjectImpl) {
		//	curnitUrl = "http://localhost:8080/webapp/repository/retrieveotml.html?uri=" + ((RooloProjectImpl) project).getProxy().getUri();
		//}

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
	 * Generates the url string that users need to go to start the project
	 * @param httpRestTransport
	 * @param request request that was made
	 * @param run <code>Run</code> that the user is in
	 * @param workgroup <code>Workgroup</code> that the user is in
	 * @param retrieveAnnotationBundleUrl
	 * @returnurl String url representation to download the jnlp and start
     *     the project
	 */
	public String generateStudentStartProjectUrlString(HttpRestTransport httpRestTransport, HttpServletRequest request,
			Run run, Workgroup workgroup, String retrieveAnnotationBundleUrl) {
		String jnlpUrl = generateLaunchProjectUrlString(httpRestTransport, run,
				workgroup);

		String entireUrl = jnlpUrl + "?" + generateRetrieveAnnotationBundleParamRequestString(request, workgroup);

		return entireUrl;
	}
	
	/**
	 * Generates the request parameter string to be added to the end of
	 * the launch/preview project url
	 * 
	 * @param request
	 * @param workgroup
	 * @return
	 */
	public static String generateRetrieveAnnotationBundleParamRequestString(HttpServletRequest request, Workgroup workgroup) {
		String portalUrl = request.getScheme() + "://" + request.getServerName() + ":" +
		request.getServerPort() + request.getContextPath();

	    String retrieveAnnotationBundleUrlString = "emf.annotation.bundle.url=" + 
	         portalUrl + retrieveAnnotationBundleUrl + "?workgroupId=" + workgroup.getId();

		return retrieveAnnotationBundleUrlString;
	}
	
	/**
	 * Generates the request parameter string to be added to the end of
	 * the launch/preview project url
	 * 
	 * @param request
	 * @return
	 */
	public static String generatePortalBaseUrlParamRequestString(HttpServletRequest request) {
		String portalUrl = request.getScheme() + "://" + request.getServerName() + ":" +
		request.getServerPort() + request.getContextPath();

		return "jnlp.portal_baseurl=" + portalUrl;
	}
	

	/**
	 * Generates the request parameter string to be added to the end of
	 * the launch/preview project url
	 * 
	 * @param request
	 * @param runId
	 * @return
	 */
	public static String generateRunIdParamRequestString(Long runId) {
		return "jnlp.run_id=" + runId;
	}
	
	/**
	 * Generates the url string that is used to preview a project
	 * @param httpRestTransport
	 * @param request
	 * @param run
	 * @param workgroup
	 * @return
	 */
	public static String generatePreviewProjectUrlString(HttpRestTransport httpRestTransport, Run run, Workgroup workgroup) {
		String launchProjectUrlString = generateLaunchProjectUrlString(httpRestTransport, run, workgroup);
		String previewProjectUrlString = launchProjectUrlString + "/view";
		return previewProjectUrlString;
	}


	/**
	 * Returns the basic URL used to launch the project, ie
	 * http://saildataservice.concord.org/3/offering/2374/jnlp/12063
	 * 
	 * @param httpRestTransport
	 * @param run
	 * @param workgroup
	 * @return
	 */
	protected static String generateLaunchProjectUrlString(
			HttpRestTransport httpRestTransport, Run run, Workgroup workgroup) {
		String jnlpUrl = httpRestTransport.getBaseUrl() + "/offering/" + 
		run.getSdsOffering().getSdsObjectId() + "/jnlp/" +
		workgroup.getSdsWorkgroup().getSdsObjectId();
		return jnlpUrl;
	}
	
	/**
	 * @see org.telscenter.sail.webapp.service.project.ProjectService#getById(java.lang.Long)
	 */
    @Transactional(readOnly = true)
	public Project getById(Serializable projectId) throws ObjectNotFoundException {
    	Project project = this.projectDao.getById(projectId);
		populateProjectInfo(project);  // need to deprecate.
		project.populateProjectInfo();
    	return project;
	}

	/**
	 * If the project is gotten from a datasource other than local database,
	 * its projectInfo needs to be populated.
	 * 
	 * @param project
	 * @throws ObjectNotFoundException
	 */
    @Deprecated
	private void populateProjectInfo(Project project)
			throws ObjectNotFoundException {
		Curnit curnit = project.getCurnit();
		if (curnit instanceof ModuleImpl) {
			// populate iscurrent and familytag from database
			project.getProjectInfo().setName(project.getName());
		}
	}

	/**
	 * @see org.telscenter.sail.webapp.service.project.ProjectService#getProjectList()
	 */
    @Secured( { "ROLE_USER", "AFTER_ACL_COLLECTION_READ" })    
    @Transactional(readOnly = true)
	public List<Project> getProjectList() {
    	List<Project> projectList = this.projectDao.getList();
    	// populate roolo projects' projectinfos
    	for (Project project : projectList) {
    		try {
				populateProjectInfo(project);
				project.populateProjectInfo();
			} catch (ObjectNotFoundException e) {
				e.printStackTrace();
			}
    	}
    	
		return projectList;
	}

    @Secured( { "ROLE_USER", "AFTER_ACL_COLLECTION_READ" })
	public List<Project> getProjectList(User user) {
    	return this.projectDao.getProjectListByUAR(user, "owner");
	}
    
    /**
     * @see org.telscenter.sail.webapp.service.project.ProjectService#getSharedProjectList(net.sf.sail.webapp.domain.User)
     */
	public List<Project> getSharedProjectList(User user) {
		return this.projectDao.getProjectListByUAR(user, "sharedowner");
	}
	
	/**
	 * @override @see org.telscenter.sail.webapp.service.project.ProjectService#getProjectListByTag(java.lang.String)
	 */
	public List<Project> getProjectListByTag(String projectinfotag) throws ObjectNotFoundException {
    	List<Project> projectList = this.projectDao.retrieveListByTag(projectinfotag);
		return projectList;
	}

	/**
	 * @override @see org.telscenter.sail.webapp.service.project.ProjectService#getProjectListByTag(org.telscenter.sail.webapp.domain.project.impl.FamilyTag)
	 */
	public List<Project> getProjectListByTag(FamilyTag familytag) throws ObjectNotFoundException {
    	List<Project> projectList = this.projectDao.retrieveListByTag(familytag);
    	// populate roolo projects' projectinfos
    	for (Project project : projectList) {
    		populateProjectInfo(project);  // should be deprecated. each project should know how to populate its projectinfo
    		project.populateProjectInfo();
    	}
		return projectList;
	}
	
	/**
	 * @see org.telscenter.sail.webapp.service.project.ProjectService#getBookmarkerProjectList(net.sf.sail.webapp.domain.User)
	 */
	public List<Project> getBookmarkerProjectList(User bookmarker) throws ObjectNotFoundException{
		return this.projectDao.getProjectListByUAR(bookmarker, "bookmarker");
	}
	
	/**
	 * @override @see org.telscenter.sail.webapp.service.project.ProjectService#getProjectListByInfo(org.telscenter.sail.webapp.domain.project.impl.ProjectInfo)
	 */
	public List<Project> getProjectListByInfo(ProjectInfo info)
			throws ObjectNotFoundException {
    	List<Project> projectList = this.projectDao.retrieveListByInfo(info);
		return projectList;		
	}

	/**
	 * @see org.telscenter.sail.webapp.service.project.ProjectService#getAdminProjectList()
	 */
	public List<Project> getAdminProjectList(){
		return this.projectDao.getList();
	}
	
	/**
	 * @param projectDao the projectDao to set
	 */
	public void setProjectDao(ProjectDao<Project> projectDao) {
		this.projectDao = projectDao;
	}

	/**
	 * @param curnitService the curnitService to set
	 */
	public void setCurnitService(CurnitService curnitService) {
		this.curnitService = curnitService;
	}

	/**
	 * @param jnlpService the jnlpService to set
	 */
	public void setJnlpService(JnlpService jnlpService) {
		this.jnlpService = jnlpService;
	}

	/**
	 * @param runService the runService to set
	 */
	public void setRunService(RunService runService) {
		this.runService = runService;
	}

	/**
	 * @param workgroupService the workgroupService to set
	 */
	public void setWorkgroupService(WorkgroupService workgroupService) {
		this.workgroupService = workgroupService;
	}

	/**
	 * @param userService the userService to set
	 */
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	/**
	 * @param modifier the modifier to set
	 */
	public void setModifier(AuthoringJNLPModifier modifier) {
		this.modifier = modifier;
	}

	/**
	 * @param authoringToolJnlpUrl the authoringToolJnlpUrl to set
	 */
	public void setAuthoringToolJnlpUrl(String authoringToolJnlpUrl) {
		this.authoringToolJnlpUrl = authoringToolJnlpUrl;
	}
		
	/**
	 * @override @see org.telscenter.sail.webapp.service.offering.RunService#addSharedTeacherToRun(org.telscenter.sail.webapp.domain.impl.AddSharedTeacherParameters)
	 */
	public void addSharedTeacherToProject(
			AddSharedTeacherParameters addSharedTeacherParameters) {
		Project project = addSharedTeacherParameters.getProject();
		String sharedOwnerUsername = addSharedTeacherParameters.getSharedOwnerUsername();
		User user = userService.retrieveUserByUsername(sharedOwnerUsername);
		project.getSharedowners().add(user);
		this.projectDao.save(project);

		String permission = addSharedTeacherParameters.getPermission();
		if (permission.equals(UserDetailsService.PROJECT_WRITE_ROLE)) {
			this.aclService.removePermission(project, BasePermission.READ, user);
			this.aclService.addPermission(project, BasePermission.WRITE, user);	
		} else if (permission.equals(UserDetailsService.PROJECT_READ_ROLE)) {
			this.aclService.removePermission(project, BasePermission.WRITE, user);
			this.aclService.addPermission(project, BasePermission.READ, user);
		} else if (permission.equals(UserDetailsService.PROJECT_SHARE_ROLE)) {
			this.aclService.removePermission(project, BasePermission.READ, user);
			this.aclService.addPermission(project, BasePermission.WRITE, user);	
			this.aclService.addPermission(project, BasePermission.ADMINISTRATION, user);
		}
	}
	
	/**
	 * @see org.telscenter.sail.webapp.service.project.ProjectService#getSharedTeacherRole(org.telscenter.sail.webapp.domain.project.Project, net.sf.sail.webapp.domain.User)
	 */
	public String getSharedTeacherRole(Project project, User user) {
		List<Permission> permissions = this.aclService.getPermissions(project, user);
		// for projects, a user can have at most one permission per project
		if (!permissions.isEmpty()) {
			if (permissions.contains(BasePermission.ADMINISTRATION)) {
				return UserDetailsService.PROJECT_SHARE_ROLE;
			}
			Permission permission = permissions.get(0);
			if (permission.equals(BasePermission.READ)) {
				return UserDetailsService.PROJECT_READ_ROLE;
			} else if (permission.equals(BasePermission.WRITE)) {
				return UserDetailsService.PROJECT_WRITE_ROLE;
			}
		}
		return null;
	}

	/**
	 * @see org.telscenter.sail.webapp.service.project.ProjectService#addBookmarkerToProject(org.telscenter.sail.webapp.domain.project.Project, net.sf.sail.webapp.domain.User)
	 */
	public void addBookmarkerToProject(Project project, User bookmarker){
		project.getBookmarkers().add(bookmarker);
		this.projectDao.save(project);
	}
	
	/**
	 * @see org.telscenter.sail.webapp.service.project.ProjectService#removeBookmarkerFromProject(org.telscenter.sail.webapp.domain.project.Project, net.sf.sail.webapp.domain.User)
	 */
	public void removeBookmarkerFromProject(Project project, User bookmarker){
		project.getBookmarkers().remove(bookmarker);
		this.projectDao.save(project);
	}
	
	public void setAclService(AclService<Project> aclService) {
		this.aclService = aclService;
	}

	public Object launchReport(LaunchReportParameters launchReportParameters) {
		// TODO hiroki: implement me
		return null;
	}

	/**
	 * @see org.telscenter.sail.webapp.service.project.ProjectService#getAllProjectsList()
	 */
	@Transactional
	public List<Project> getAllProjectsList() {
		List<Project> projectList = this.projectDao.getList();
    	// populate roolo projects' projectinfos
    	for (Project project : projectList) {
    		try {
				populateProjectInfo(project);
				project.populateProjectInfo();
			} catch (ObjectNotFoundException e) {
				e.printStackTrace();
			}
    	}
    	
		return projectList;
	}
	
	/**
	 * @see org.telscenter.sail.webapp.service.project.ProjectService#getProjectList(java.lang.String)
	 */
	@Transactional
	public List<Project> getProjectList(String query){
		List<Project> projectList = this.projectDao.getProjectList(query);
		
		for(Project project : projectList){
			project.populateProjectInfo();
		}
		
		return projectList;
	}

	public String minifyProject(Project project) {
		// TODO Auto-generated method stub
		return null;
	}

	public JSONObject getProjectMetadataFile(Project project) {
		// TODO Auto-generated method stub
		return null;
	}
	
	/**
	 * @see org.telscenter.sail.webapp.service.project.ProjectService#canCreateRun(org.telscenter.sail.webapp.domain.project.Project, net.sf.sail.webapp.domain.User)
	 */
	public boolean canCreateRun(Project project, User user) {
		return project.getFamilytag().equals(FamilyTag.TELS) || 
			this.aclService.hasPermission(project, BasePermission.ADMINISTRATION, user) || 
			this.aclService.hasPermission(project, BasePermission.WRITE, user);
	}

	/**
	 * @see org.telscenter.sail.webapp.service.project.ProjectService#canAuthorProject(org.telscenter.sail.webapp.domain.project.Project, net.sf.sail.webapp.domain.User)
	 */
	public boolean canAuthorProject(Project project, User user) {
		return this.aclService.hasPermission(project, BasePermission.ADMINISTRATION, user) ||
			this.aclService.hasPermission(project, BasePermission.WRITE, user);
	}

	public boolean canReadProject(Project project, User user) {
		// TODO Auto-generated method stub
		return false;
	}
	
		public String getActiveVersion(Project project) {
		// TODO Auto-generated method stub
		return null;
	}

	public String takeSnapshot(Project project, String username,
			String snapshotName) {
		// TODO Auto-generated method stub
		return null;
	}

	public ProjectMetadata getMetadata(Long projectId) {
		// TODO Auto-generated method stub
		return null;
	}

	public void sortProjectsByDateCreated(List<Project> projectList) {
		// TODO Auto-generated method stub
		
	}
	
	public Long addTagToProject(Tag tag, Long projectId) {
		// TODO Auto-generated method stub
		return null;
	}

	public Long addTagToProject(String tag, Long projectId) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<Project> getProjectListByTagName(String tagName) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<Project> getProjectListByTagNames(Set<String> tagNames) {
		// TODO Auto-generated method stub
		return null;
	}

	public boolean isAuthorizedToCreateTag(User user, String name) {
		// TODO Auto-generated method stub
		return false;
	}

	public boolean projectContainsTag(Long projectId, String name) {
		// TODO Auto-generated method stub
		return false;
	}

	public void removeTagFromProject(Long tagId, Long projectId) {
		// TODO Auto-generated method stub
		
	}

	public Long updateTag(Long tagId, Long projectId, String name) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<Project> getProjectCopies(Long projectId) {
		// TODO Auto-generated method stub
		return null;
	}

	public void removeSharedTeacherFromProject(String username, Project project)
			throws ObjectNotFoundException {
		// TODO Auto-generated method stub
		
	}

	public Project getProjectFull(Long projectId)
			throws ObjectNotFoundException {
		// TODO Auto-generated method stub
		return null;
	}

	public Long identifyRootProjectId(Project projectId)
			throws ObjectNotFoundException {
		// TODO Auto-generated method stub
		return null;
	}
}
