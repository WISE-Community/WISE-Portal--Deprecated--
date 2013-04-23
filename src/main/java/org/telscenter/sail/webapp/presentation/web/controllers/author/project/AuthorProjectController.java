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

import java.io.IOException;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.sail.webapp.dao.ObjectNotFoundException;
import net.sf.sail.webapp.domain.Curnit;
import net.sf.sail.webapp.domain.User;
import net.sf.sail.webapp.domain.impl.CurnitGetCurnitUrlVisitor;
import net.sf.sail.webapp.domain.webservice.http.HttpRestTransport;
import net.sf.sail.webapp.presentation.web.controllers.ControllerUtil;
import net.sf.sail.webapp.presentation.web.listeners.PasSessionListener;
import net.sf.sail.webapp.service.NotAuthorizedException;
import net.sf.sail.webapp.service.curnit.CurnitService;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import org.springframework.web.servlet.view.RedirectView;
import org.telscenter.sail.webapp.domain.Run;
import org.telscenter.sail.webapp.domain.authentication.MutableUserDetails;
import org.telscenter.sail.webapp.domain.impl.CreateUrlModuleParameters;
import org.telscenter.sail.webapp.domain.impl.ProjectParameters;
import org.telscenter.sail.webapp.domain.project.FamilyTag;
import org.telscenter.sail.webapp.domain.project.Project;
import org.telscenter.sail.webapp.domain.project.ProjectMetadata;
import org.telscenter.sail.webapp.domain.project.impl.AuthorProjectParameters;
import org.telscenter.sail.webapp.domain.project.impl.PreviewProjectParameters;
import org.telscenter.sail.webapp.domain.project.impl.ProjectMetadataImpl;
import org.telscenter.sail.webapp.domain.project.impl.ProjectType;
import org.telscenter.sail.webapp.presentation.util.Util;
import org.telscenter.sail.webapp.presentation.util.json.JSONArray;
import org.telscenter.sail.webapp.presentation.util.json.JSONException;
import org.telscenter.sail.webapp.presentation.util.json.JSONObject;
import org.telscenter.sail.webapp.presentation.web.controllers.CredentialManager;
import org.telscenter.sail.webapp.presentation.web.controllers.TaggerController;
import org.telscenter.sail.webapp.presentation.web.filters.TelsAuthenticationProcessingFilter;
import org.telscenter.sail.webapp.service.authentication.UserDetailsService;
import org.telscenter.sail.webapp.service.offering.RunService;
import org.telscenter.sail.webapp.service.project.ProjectService;

/**
 * Controller for users with author privileges to author projects
 * 
 * @author Hiroki Terashima
 * @version $Id$
 */
public class AuthorProjectController extends AbstractController {

	// path to project thumb image relative to project folder
	private static final String PROJECT_THUMB_PATH = "/assets/project_thumb.png";
		
	private static final String PROJECT_ID_PARAM_NAME = "projectId";

	private static final String FORWARD = "forward";

	private static final String COMMAND = "command";

	private ProjectService projectService;

	private Properties portalProperties = null;

	private HttpRestTransport httpRestTransport;

	private CurnitService curnitService;

	private TaggerController tagger;

	private final static List<String> filemanagerProjectlessRequests;

	private final static List<String> minifierProjectlessRequests;

	private RunService runService;
	
	static {
		filemanagerProjectlessRequests = new ArrayList<String>();
		filemanagerProjectlessRequests.add("createProject");
		
		minifierProjectlessRequests = new ArrayList<String>();
		minifierProjectlessRequests.add("getTimestamp");
	}
	
	/**
	 * @see org.springframework.web.servlet.mvc.AbstractController#handleRequestInternal(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	@Override
	protected ModelAndView handleRequestInternal(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		User user = ControllerUtil.getSignedInUser();

		String projectIdStr = request.getParameter(PROJECT_ID_PARAM_NAME);
		String forward = request.getParameter(FORWARD);

		Project project;
		if(projectIdStr != null && !projectIdStr.equals("") && !projectIdStr.equals("none")){
			//project = projectService.getProjectWithoutMetadata(Long.parseLong(projectIdStr));
			project = projectService.getById(Long.parseLong(projectIdStr));
		} else {
			project = null;
		}

		/* catch forwarding requests, authenticate and forward request upon successful authentication */
		if(forward != null && !forward.equals("")){
			ServletContext servletContext = this.getServletContext().getContext("/vlewrapper");

			//get the command
			String command = request.getParameter("command");

			if(forward.equals("filemanager") || forward.equals("assetmanager")){

				if((this.isProjectlessRequest(request, forward) || this.projectService.canAuthorProject(project, user)) ||
						("copyProject".equals(command) && project.getFamilytag().equals(FamilyTag.TELS)) ||
						("retrieveFile".equals(command) && project.getFamilytag().equals(FamilyTag.TELS))){

					if("createProject".equals(command) && !this.hasAuthorPermissions(user)){
						return new ModelAndView(new RedirectView("accessdenied.html"));
					}

					if("copyProject".equals(command) && 
							(project == null || 
							(!project.getFamilytag().equals(FamilyTag.TELS) && !this.projectService.canAuthorProject(project, user)))){
						return new ModelAndView(new RedirectView("accessdenied.html"));
					}

					//command is review update project or to update project
					if("reviewUpdateProject".equals(command) || "updateProject".equals(command)) {
						//get the curriculum base directory
						String curriculumBaseDir = portalProperties.getProperty("curriculum_base_dir");

						//get the project url
						String projectUrl = (String) project.getCurnit().accept(new CurnitGetCurnitUrlVisitor());

						//get the parent project id
						Long parentProjectId = project.getParentProjectId();

						//get the parent project
						Project parentProject = projectService.getById(parentProjectId);

						//get the parent project url
						String parentProjectUrl = (String) parentProject.getCurnit().accept(new CurnitGetCurnitUrlVisitor());

						//set the attributes so that FileManager.java can access these values in the vlewrapper
						request.setAttribute("curriculumBaseDir", curriculumBaseDir);
						request.setAttribute("projectUrl", projectUrl);
						request.setAttribute("parentProjectUrl", parentProjectUrl);
					} else if("importSteps".equals(command)) {
						//get the curriculum base directory
						String curriculumBaseDir = portalProperties.getProperty("curriculum_base_dir");

						//get the project url
						String projectUrl = (String) project.getCurnit().accept(new CurnitGetCurnitUrlVisitor());

						//set the attributes so that FileManager.java can access these values in the vlewrapper
						request.setAttribute("curriculumBaseDir", curriculumBaseDir);
						request.setAttribute("projectUrl", projectUrl);

						//get the from project id string
						String fromProjectIdStr = request.getParameter("fromProjectId");

						if(fromProjectIdStr != null) {
							try {
								//get the from project id
								long fromProjectId = Long.parseLong(fromProjectIdStr);

								//get the from project
								Project fromProject = projectService.getById(fromProjectId);

								//get the from project url e.g. /172/wise4.project.json
								String fromProjectUrl = (String) fromProject.getCurnit().accept(new CurnitGetCurnitUrlVisitor());

								//set the from project url into the request so we can have access to it in other controllers
								request.setAttribute("fromProjectUrl", fromProjectUrl);
							} catch(Exception e) {
								e.printStackTrace();
							}
						}
					}

					//add any necessary attributes to the request object
					addRequestAttributeForCommand(request, project, command, forward);

					CredentialManager.setRequestCredentials(request, user);
					servletContext.getRequestDispatcher("/vle/" + forward + ".html").forward(request, response);

					if("updateFile".equals(command)) {
						//we have updated a file in a project so we will update the project edited timestamp

						/*
						 * set the project into the request so the handleProjectEdited 
						 * function doesn't have to retrieve it again
						 */
						request.setAttribute("project", project);

						//update the project edited timestamp
						handleProjectEdited(request, response);						
					}

					return null;
				} else {
					return new ModelAndView(new RedirectView("accessdenied.html"));
				}
			} else if(forward.equals("minifier")){
				if(this.isProjectlessRequest(request, forward) || this.projectService.canAuthorProject(project, user)){
					CredentialManager.setRequestCredentials(request, user);
					servletContext.getRequestDispatcher("/util/" + forward + ".html").forward(request, response);
					return null;
				}
			}
		}

		AuthorProjectParameters params = new AuthorProjectParameters();
		params.setAuthor(user);
		params.setProject(project);
		params.setHttpServletRequest(request);
		params.setHttpServletResponse(response);
		params.setHttpRestTransport(httpRestTransport);
		params.setPortalUrl(Util.getPortalUrl(request));
		params.setVersionId(request.getParameter("versionId"));

		String command = request.getParameter(COMMAND);
		if(command != null && command != ""){
			if(command.equals("launchAuthoring")){
				return (ModelAndView) projectService.authorProject(params);
			} else if(command.equals("createProject")){
				return handleCreateProject(request, response);
			} else if(command.equals("projectList")){
				return handleProjectList(request, response);
			} else if(command.equals("getProjectInfo")){
				return handleProjectInfo(request, response);
			} else if (command.equals("notifyProjectOpen")) {
				return handleNotifyProjectOpen(request, response);
			} else if (command.equals("notifyProjectClose")){
				return handleNotifyProjectClose(request, response);
			} else if(command.equals("publishMetadata")){
				return this.handlePublishMetadata(request, response);
			} else if(command.equals("getUsername")){
				return this.handleGetUsername(request, response);
			} else if(command.equals("getCurriculumBaseUrl")) {
				return this.handleGetCurriculumBaseUrl(request, response);
			} else if(command.equals("getConfig")) {
				return this.handleGetConfig(request, response);
			} else if(command.equals("getEditors")){
				if(this.projectService.canAuthorProject(project, user)){
					return this.handleGetEditors(request, response);
				} else {
					return new ModelAndView(new RedirectView("accessdenied.html"));
				}
			} else if(command.equals("preview")){
				PreviewProjectParameters previewParams = new PreviewProjectParameters();
				previewParams.setProject(project);
				previewParams.setPortalUrl(Util.getPortalUrl(request));
				previewParams.setHttpServletRequest(request);
				previewParams.setHttpRestTransport(this.httpRestTransport);

				return (ModelAndView) this.projectService.previewProject(previewParams);
			} else if(command.equals("createTag") || command.equals("updateTag") || 
					command.equals("removeTag") || command.equals("retrieveProjectTags")){
				return this.tagger.handleRequest(request, response);
			} else if(command.equals("getMetadata")) {
				request.setAttribute("project", project);
				return handleGetMetadata(request, response);
			} else if(command.equals("postMetadata")) {
				request.setAttribute("project", project);
				return handlePostMetadata(request, response);
			} else if(command.equals("reviewUpdateProject")) {
				return handleReviewUpdateProject(request, response);
			} else if(command.equals("updateProject")) {
				return handleUpdateProject(request, response);
			} else if(command.equals("importSteps")) {
				return handleReviewOrUpdateProject(request, response);
			} else if(command.equals("welcomeProjectList")){
				return handleWelcomeProjectList(request, response);
			}
		}

		return (ModelAndView) projectService.authorProject(params);
	}

	/**
	 * Add any necessary attributes to the request object
	 * @param request the request object
	 * @param project the project object
	 * @param command the command e.g. "retrieveFile"
	 * @param forward the service to forward to e.g. "filemanager"
	 */
	private void addRequestAttributeForCommand(HttpServletRequest request, Project project, String command, String forward) {
		if("retrieveFile".equals(command)) {
			//get the file name
			String fileName = request.getParameter("fileName");

			//get the full file path
			String filePath = getFilePath(project, fileName);
			request.setAttribute("filePath", filePath);
		} else if("createProject".equals(command)) {
			//get the full curriculum base dir
			String curriculumBaseDir = portalProperties.getProperty("curriculum_base_dir");
			request.setAttribute("curriculumBaseDir", curriculumBaseDir);
		} else if("createNode".equals(command)) {
			//get the full project file path
			String projectFilePath = getProjectFilePath(project);
			request.setAttribute("projectFilePath", projectFilePath);
		} else if("getProjectFile".equals(command)) {
			//get the full project file path
			String projectFilePath = getProjectFilePath(project);
			request.setAttribute("filePath", projectFilePath);
		} else if("copyProject".equals(command)) {
			//get the full project folder path
			String projectFolderPath = getProjectFolderPath(project);
			request.setAttribute("projectFolderPath", projectFolderPath);

			//get the full curriculum base dir
			String curriculumBaseDir = portalProperties.getProperty("curriculum_base_dir");
			request.setAttribute("curriculumBaseDir", curriculumBaseDir);
		} else if("updateFile".equals(command) ||
				"copyNode".equals(command) ||
				"createSequence".equals(command) ||
				"createSequenceFromJSON".equals(command) ||
				"updateAudioFiles".equals(command) ||
				"createFile".equals(command) ||
				"removeFile".equals(command)||
				"assetList".equals(command) || 
				"getSize".equals(command) || 
				"assetmanager".equals(forward) ||
				"filemanager".equals(forward)) {
			//get the full project folder path
			String projectFolderPath = getProjectFolderPath(project);
			request.setAttribute("projectFolderPath", projectFolderPath);

			// get project asset max size (if overridden by admin) and add it to request
			Long maxTotalAssetsSize = project.getMaxTotalAssetsSize();
			request.setAttribute("projectMaxTotalAssetsSize", maxTotalAssetsSize);
		}
	}

	/**
	 * Handles creating a project.
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	private ModelAndView handleCreateProject(HttpServletRequest request, HttpServletResponse response) throws Exception{
		User user = ControllerUtil.getSignedInUser();
		if(this.hasAuthorPermissions(user)){
			/*
			 * get the relative path to the project
			 * e.g.
			 * /510/wise4.project.json
			 */
			String path = request.getParameter("projectPath");

			//get the name of the project
			String name = request.getParameter("projectName");

			String parentProjectId = request.getParameter("parentProjectId");
			Set<User> owners = new HashSet<User>();
			owners.add(user);

			CreateUrlModuleParameters cParams = new CreateUrlModuleParameters();
			cParams.setUrl(path);
			Curnit curnit = curnitService.createCurnit(cParams);

			ProjectParameters pParams = new ProjectParameters();

			pParams.setCurnitId(curnit.getId());
			pParams.setOwners(owners);
			pParams.setProjectname(name);
			pParams.setProjectType(ProjectType.LD);
			if (parentProjectId != null && !parentProjectId.equals("undefined")) {
				Project parentProject = projectService.getById(parentProjectId);
				if (parentProject != null) {
					pParams.setParentProjectId(Long.valueOf(parentProjectId));
					// get the project's metadata from the parent
					ProjectMetadata parentProjectMetadata = parentProject.getMetadata();
					if (parentProjectMetadata != null) {
						// copy into new metadata object
						ProjectMetadata newProjectMetadata = new ProjectMetadataImpl(parentProjectMetadata.toJSONString());
						pParams.setMetadata(newProjectMetadata);
					}
				}
			} else {
				// if this is new original project, set a new fresh metadata object
				ProjectMetadata metadata = new ProjectMetadataImpl();
				metadata.setTitle(name);
				pParams.setMetadata(metadata);
			}
			Project project = projectService.createProject(pParams);
			response.getWriter().write(project.getId().toString());
			return null;
		} else {
			return new ModelAndView(new RedirectView("accessdenied.html"));
		}
	}

	/**
	 * Handles notifications of opened projects
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	private ModelAndView handleNotifyProjectOpen(HttpServletRequest request, HttpServletResponse response) throws Exception{
		User user = ControllerUtil.getSignedInUser();
		if(this.hasAuthorPermissions(user)){

			//get the project object
			String projectId = request.getParameter("projectId");

			HttpSession currentUserSession = request.getSession();
			HashMap<String, ArrayList<String>> openedProjectsToSessions = 
					(HashMap<String, ArrayList<String>>) currentUserSession.getServletContext().getAttribute("openedProjectsToSessions");

			if (openedProjectsToSessions == null) {
				openedProjectsToSessions = new HashMap<String, ArrayList<String>>(); 
				currentUserSession.getServletContext().setAttribute("openedProjectsToSessions", openedProjectsToSessions);
			}

			if (openedProjectsToSessions.get(projectId) == null) {
				openedProjectsToSessions.put(projectId, new ArrayList<String>());
			}
			ArrayList<String> sessions = openedProjectsToSessions.get(projectId);  // sessions that are currently authoring this project
			if (!sessions.contains(currentUserSession.getId())) {
				sessions.add(currentUserSession.getId());
			}
			
			String otherUsersAlsoEditingProject = "";
			JSONArray editors = new JSONArray();

			HashMap<String, User> allLoggedInUsers = (HashMap<String, User>) currentUserSession.getServletContext()
					.getAttribute(PasSessionListener.ALL_LOGGED_IN_USERS);

			for (String sessionId : sessions) {
				if (sessionId != currentUserSession.getId()) {
					user = allLoggedInUsers.get(sessionId);
					if (user != null) {
						JSONObject editor = new JSONObject();
						//otherUsersAlsoEditingProject += user.getUserDetails().getUsername() + ",";
						MutableUserDetails userDetails = (MutableUserDetails)user.getUserDetails();
						String userFullName = userDetails.getFirstname() + ' ' + userDetails.getLastname();
						String username = userDetails.getUsername();
						editor.put("username", username);
						editor.put("userFullName",userFullName);
						editors.put(editor);
					}
				}
			}

			/* strip off trailing comma */
			//if(otherUsersAlsoEditingProject.contains(",")){
				//otherUsersAlsoEditingProject = otherUsersAlsoEditingProject.substring(0, otherUsersAlsoEditingProject.length() - 1);
			//}
			
			//response.getWriter().write(otherUsersAlsoEditingProject);
			response.getWriter().write(editors.toString());

			if(otherUsersAlsoEditingProject.contains(",")){
				otherUsersAlsoEditingProject = otherUsersAlsoEditingProject.substring(0, otherUsersAlsoEditingProject.length() - 1);
			}

			response.getWriter().write(otherUsersAlsoEditingProject);

			return null;
		} else {
			return new ModelAndView(new RedirectView("accessdenied.html"));
		}
	}

	/**
	 * Handles notifications of closed projects
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	private ModelAndView handleNotifyProjectClose(HttpServletRequest request, HttpServletResponse response) throws Exception{
		User user = ControllerUtil.getSignedInUser();
		if(this.hasAuthorPermissions(user)){
			String projectId = request.getParameter("projectId");
			HttpSession currentSession = request.getSession();

			Map<String, ArrayList<String>> openedProjectsToSessions = (Map<String, ArrayList<String>>) currentSession.getServletContext().getAttribute("openedProjectsToSessions");

			if(openedProjectsToSessions == null || openedProjectsToSessions.get(projectId) == null){
				return null;
			} else {
				ArrayList<String> sessions = openedProjectsToSessions.get(projectId);
				if(!sessions.contains(currentSession.getId())){
					return null;
				} else {
					sessions.remove(currentSession.getId());
					// if there are no more users authoring this project, remove this project from openedProjectsToSessions
					if (sessions.size() == 0) {
						openedProjectsToSessions.remove(projectId);
					}
					response.getWriter().write("success");
					return null;
				}
			}
		} else {
			return new ModelAndView(new RedirectView("accessdenied.html"));
		}
	}

	/**
	 * Gets other WISE users who are also editing the same project as the logged-in user
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")	
	private ModelAndView handleGetEditors(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String projectPath = request.getParameter("param1");

		// get current user session
		HttpSession currentUserSession = request.getSession();

		// get all sessions of people editing a project.
		HashMap<String, ArrayList<String>> openedProjectsToSessions = 
				(HashMap<String, ArrayList<String>>) currentUserSession.getServletContext().getAttribute("openedProjectsToSessions");

		if(openedProjectsToSessions != null){
			// if there are ppl editing projects, see if there are people editing the same project as logged in user.
			ArrayList<String> sessions = openedProjectsToSessions.get(projectPath);
			HashMap<String, User> allLoggedInUsers = (HashMap<String, User>) currentUserSession.getServletContext()
					.getAttribute(PasSessionListener.ALL_LOGGED_IN_USERS);

			String otherUsersAlsoEditingProject = "";
			if (sessions != null) {
				for (String sessionId : sessions) {
					if (sessionId != currentUserSession.getId()) {
						User user = allLoggedInUsers.get(sessionId);
						if (user != null) {
							otherUsersAlsoEditingProject += user.getUserDetails().getUsername() + ",";
						}
					}
				}
			}

			/* strip off trailing comma */
			if(otherUsersAlsoEditingProject.contains(",")){
				otherUsersAlsoEditingProject = otherUsersAlsoEditingProject.substring(0, otherUsersAlsoEditingProject.length() - 1);
			}

			response.getWriter().write(otherUsersAlsoEditingProject);
		} else {
			response.getWriter().write("");
		}


		return null;
	}

	/**
	 * Returns some additional info about a project being authored (owner/shared info, whether project is in public library,
	 * if it's bookmarked, thumbnail url)
	 * TODO: perhaps include last edited time (and user) in the future
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	private ModelAndView handleProjectInfo(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String projectId = request.getParameter("projectId");
		
		if(projectId != null) {
			Project project = projectService.getById(projectId);
			User signedInUser = ControllerUtil.getSignedInUser();
			List<Project> libraryProjects = projectService.getProjectListByTagName("library");
			List<Project> bookmarkedProjects = this.projectService.getBookmarkerProjectList(signedInUser);
			
			//get the project is owner
			Set<User> owners = project.getOwners();
			String projectOwnerName = new String();
			String projectOwnerUsername = new String();
			for(User owner : owners){
				MutableUserDetails ownerDetails = (MutableUserDetails)owner.getUserDetails();
				projectOwnerName = ownerDetails.getFirstname() + ' ' + ownerDetails.getLastname();
				projectOwnerUsername = ownerDetails.getUsername();
			}
			
			//get the shared users
			Set<User> sharedOwners = project.getSharedowners();
			String sharedUsers = "";
			String delim = "";
			for(User sharedOwner : sharedOwners){
				MutableUserDetails sharedUserDetails = (MutableUserDetails)sharedOwner.getUserDetails();
				sharedUsers = sharedUsers + delim + sharedUserDetails.getFirstname() + " " + sharedUserDetails.getLastname();
				delim = ", ";
			}
			
			//get if project is a public library project
			Boolean isLibrary = false;
			if(libraryProjects.contains(project)){
				isLibrary = true;
			}
			
			//get if project is bookmarked
			Boolean bookmarked = false;
			if(bookmarkedProjects.contains(project)){
				bookmarked = true;
			}
			
			String url = (String) project.getCurnit().accept(new CurnitGetCurnitUrlVisitor());
			String thumbUrl = "";
			if(url != null && url != ""){
				int ndx = url.lastIndexOf("/");
				if(ndx != -1){
					String curriculumBaseWWW = this.portalProperties.getProperty("curriculum_base_www");
					thumbUrl = curriculumBaseWWW + url.substring(0, ndx) + PROJECT_THUMB_PATH;
				}
			}
			
			/*
			 * create json object to hold project details
			 */
			JSONObject projectDetails = new JSONObject();
			projectDetails.put("projectOwnerName", projectOwnerName);
			projectDetails.put("projectOwnerUsername", projectOwnerUsername);
			projectDetails.put("isLibrary", isLibrary);
			projectDetails.put("isFavorite", bookmarked);
			projectDetails.put("sharedUsers", sharedUsers);
			projectDetails.put("thumbUrl", thumbUrl);
			
			response.getWriter().write(projectDetails.toString());
		}
		
		return null;
	}
	
	/**
	 * Returns a list of projects that the signed in user can author
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	private ModelAndView handleProjectList(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String projectTag = request.getParameter("projectTag");

		JSONArray projects = new JSONArray();

		if(projectTag == null) {
			//get all the projects the current user can author
			projects = getAuthorableProjects(request, response);
		} else if(projectTag.equals("library")) {
			//get all the library projects
			projects = getLibraryProjects(request, response);
		} else if(projectTag.equals("authorable")) {
			//get all the projects the current user can author
			projects = getAuthorableProjects(request, response);
		} else if(projectTag.equals("authorableAndLibrary")) {
			//get all the projects the current user can author
			JSONArray authorableProjects = getAuthorableProjects(request, response);

			//get all the library projects
			JSONArray libraryProjects = getLibraryProjects(request, response);

			//add the authorable projects to the array
			for(int x=0; x<authorableProjects.length(); x++) {
				JSONObject authorableProject = authorableProjects.getJSONObject(x);
				projects.put(authorableProject);
			}

			//add the library projects to the array
			for(int y=0; y<libraryProjects.length(); y++) {
				JSONObject libraryProject = libraryProjects.getJSONObject(y);
				projects.put(libraryProject);
			}
		}

		//write the JSONArray of projects to the response
		response.getWriter().write(projects.toString());

		return null;
	}

	/**
	 * Returns a list of projects that the signed in user can author for authoring welcome screen
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	private ModelAndView handleWelcomeProjectList(HttpServletRequest request, HttpServletResponse response) throws Exception{
		//get the number of projects the current user can author and recently edited projects
		getWelcomeProjects(request, response);
		
		return null;
	}
	
	/**
	 * Get all the projects the current user can author
	 * @param request
	 * @param response
	 * @throws Exception
	 * @return the JSONArray of authorable projects
	 */
	private JSONArray getAuthorableProjects(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String mode = request.getParameter("listMode");
		
		List<Project> allAuthorableProjects = new ArrayList<Project>();
		User signedInUser = ControllerUtil.getSignedInUser();
		List<Project> projects = projectService.getProjectList(signedInUser);
		List<Project> sharedProjects = projectService.getSharedProjectList(signedInUser);
		List<Project> libraryProjects = projectService.getProjectListByTagName("library");
		List<Project> bookmarkedProjects = this.projectService.getBookmarkerProjectList(signedInUser);

		// in the future, we'll want to filter this allAuthorableProjects list even further by what kind of
		// permissions (view, edit, share) the user has on the project.
		allAuthorableProjects.addAll(projects);
		allAuthorableProjects.addAll(sharedProjects);
		
		// remove projects from library list if they appear in the owned or shared lists (to avoid duplicates)
		List<Project> libraryRemove = new ArrayList<Project>();
		for (Project libProject : libraryProjects){
			if (sharedProjects.contains(libProject) || projects.contains(libProject)){
				libraryRemove.add(libProject);
			}
		}
		for (int a=0; a<libraryProjects.size(); a++){
			if(libraryRemove.contains(libraryProjects.get(a))){
				libraryProjects.remove(a);
			}
		}
		
		// if in copy dialog mode, add library projects to master list
		if(mode.equals("copy")){
			allAuthorableProjects.addAll(libraryProjects);
		}
		
		//an array to hold the information for the projects
		JSONArray projectArray = new JSONArray();

		//loop through all the projects
		for(Project project : allAuthorableProjects){
			if(project.getProjectType()==ProjectType.LD &&
					projectService.canAuthorProject(project, signedInUser) && !project.isDeleted()){
				/*
				 * get the relative project url
				 * e.g.
				 * /235/wise4.project.json
				 */
				String rawProjectUrl = (String) project.getCurnit().accept(new CurnitGetCurnitUrlVisitor());

				if(rawProjectUrl != null) {
					/*
					 * create json object to hold project details
					 */
					JSONObject projectDetails = new JSONObject();
					
					//get the title of the project
					String title = project.getName();
					
					//get who owns the project
					Set<User> owners = project.getOwners();
					String projectOwnerName = new String();
					for(User owner : owners){
						MutableUserDetails ownerDetails = (MutableUserDetails)owner.getUserDetails();
						projectOwnerName = ownerDetails.getFirstname() + ' ' + ownerDetails.getLastname();
					}
					
					//get the shared users
					Set<User> sharedOwners = project.getSharedowners();
					String sharedUsers = "";
					String delim = "";
					for(User sharedOwner : sharedOwners){
						MutableUserDetails sharedUserDetails = (MutableUserDetails)sharedOwner.getUserDetails();
						sharedUsers = sharedUsers + delim + sharedUserDetails.getFirstname() + " " + sharedUserDetails.getLastname();
						delim = ", ";
					}
					
					//get date created
					String dateCreated = DateFormat.getDateInstance(DateFormat.MEDIUM).format(project.getDateCreated());
					
					//get project runs
					List<Run> runList = runService.getProjectRuns((Long) project.getId());
					Long runId = null;
					if (!runList.isEmpty()){
						runId = runList.get(0).getId();
					}
					
					//get parent project id
					Long parentId = project.getParentProjectId();
					Boolean parentIsLibrary = null;
					String parentTitle = null;
					if(parentId != null){
						Project parent = projectService.getById(parentId);
						parentTitle = parent.getName();
						if(libraryProjects.contains(parent)){
							parentIsLibrary = true;
						} else {
							parentIsLibrary = false;
						}
					}
					
					//get if project is bookmarked
					Boolean bookmarked = false;
					if(bookmarkedProjects.contains(project)){
						bookmarked = true;
					}
					
					//get if project is a public library project
					Boolean isLibrary = false;
					if(libraryProjects.contains(project) || libraryRemove.contains(project)){
						isLibrary = true;
					}
					
					//get some metadata fields
					String lastEdited = "";
					Long lastEditedTime = null;
					//String subject = "";
					//String gradeRange = "";
					//String language = "";
					//String summary = "";
					if(project.getMetadata() != null){
						Date lastEditedDate = project.getMetadata().getLastEdited();
						if(lastEditedDate != null){
							lastEdited = DateFormat.getDateTimeInstance(DateFormat.MEDIUM, DateFormat.SHORT).format(lastEditedDate);
							lastEditedTime = lastEditedDate.getTime();
						}
						//subject = project.getMetadata().getSubject();
						//gradeRange = project.getMetadata().getGradeRange();
						//language = project.getMetadata().getLanguage();
						//summary = project.getMetadata().getSummary();
					}
					
					/*
					 * get the project file name
					 * e.g.
					 * /wise4.project.json
					 */
					String projectFileName = rawProjectUrl.substring(rawProjectUrl.lastIndexOf("/"));
					
					String url = (String) project.getCurnit().accept(new CurnitGetCurnitUrlVisitor());
					if(url != null && url != ""){
						int ndx = url.lastIndexOf("/");
						if(ndx != -1){
							String curriculumBaseWWW = this.portalProperties.getProperty("curriculum_base_www");
							String thumbUrl = curriculumBaseWWW + url.substring(0, ndx) + PROJECT_THUMB_PATH;
							projectDetails.put("thumbUrl", thumbUrl);
						}
					}
					
					if(mode.equals("copy")){
						// if in copy dialog mode, add whether project is authorable to the JSON object
						Boolean isAuthorable = false;
						if(projects.contains(project) || sharedProjects.contains(project)){
							isAuthorable = true;
						}
						projectDetails.put("authorable", isAuthorable);
					}
					
					/*
					 * add the project file name, project id, project title, and other details
					 * to the JSONObject
					 */
					projectDetails.put("id", project.getId());
					projectDetails.put("path", projectFileName);
					projectDetails.put("title", title);
					projectDetails.put("dateCreated", dateCreated);
					projectDetails.put("lastEdited", lastEdited);
					projectDetails.put("lastEditedTime", lastEditedTime);
					projectDetails.put("projectOwnerName", projectOwnerName);
					projectDetails.put("parentId", parentId);
					projectDetails.put("parentTitle", parentTitle);
					projectDetails.put("parentLibrary", parentIsLibrary);
					projectDetails.put("sharedUsers", sharedUsers);
					projectDetails.put("runId", runId);
					projectDetails.put("isFavorite", bookmarked);
					projectDetails.put("isLibrary", isLibrary);
					//projectDetails.put("subject", subject);
					//projectDetails.put("gradeRange", gradeRange);
					//projectDetails.put("language", language);
					//projectDetails.put("summary", summary);
					
					//add the JSONObject to our array
					projectArray.put(projectDetails);
				}
			}
		}

		//return the JSONArray
		return projectArray;
	}

	/**
	 * Get all the projects the current user can author (for authoring tool welcome screen)
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	private void getWelcomeProjects(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<Project> allAuthorableProjects = new ArrayList<Project>();
		User signedInUser = ControllerUtil.getSignedInUser();
		List<Project> projects = projectService.getProjectList(signedInUser);
		List<Project> sharedProjects = projectService.getSharedProjectList(signedInUser);
		List<Project> bookmarkedProjects = this.projectService.getBookmarkerProjectList(signedInUser);

		// in the future, we'll want to filter this allAuthorableProjects list even further by what kind of
		// permissions (view, edit, share) the user has on the project.
		allAuthorableProjects.addAll(projects);
		allAuthorableProjects.addAll(sharedProjects);
		
		//an array to hold the information for the recently edited projects
		JSONArray recentProjectArray = new JSONArray();
		
		//get total number of owned, shared, and bookmarked projects
		int totalOwned = 0;
		int totalShared = 0;
		int totalBookmarked = 0;
		
		List<Project> editedProjects = new ArrayList<Project>();
		List<Project> recentProjects = new ArrayList<Project>();
		
		//loop through all the projects
		for(Project project : allAuthorableProjects){
			if(project.getProjectType()==ProjectType.LD &&
					projectService.canAuthorProject(project, signedInUser) && !project.isDeleted()){
				
				if(projects.contains(project)){
					totalOwned+=1;
				}
				if(bookmarkedProjects.contains(project)){
					totalBookmarked+=1;
				}
				if(sharedProjects.contains(project)){
					totalShared+=1;
				}
				
				//check if project has been edited
				if(project.getMetadata() != null){
					Date lastEditedDate = project.getMetadata().getLastEdited();
					if(lastEditedDate != null){
						// if it has been edited, add to list of edited projects
						editedProjects.add(project);
					}
				}
			}
		}
		
		//sort edited projects by last edited time (descending) and limit to max of 10 projects
		this.projectService.sortProjectsByLastEdited(editedProjects);
		int size = editedProjects.size();
		if(size > 10){
			size = 10;
		}
		for(int n=0; n<size; n++){
			recentProjects.add(editedProjects.get(n));
		}
		
		//loop through all recently edited projects
		for(Project p : recentProjects){
			Date lastEditedDate = p.getMetadata().getLastEdited();
			String lastEdited = DateFormat.getDateTimeInstance(DateFormat.MEDIUM, DateFormat.SHORT).format(lastEditedDate);
			Long lastEditedTime = lastEditedDate.getTime();
			/*
			 * get the relative project url
			 * e.g.
			 * /235/wise4.project.json
			 */
			String rawProjectUrl = (String) p.getCurnit().accept(new CurnitGetCurnitUrlVisitor());
			
			//get the title of the project
			String title = p.getName();
			
			if(rawProjectUrl != null) {
				/*
				 * get the project file name
				 * e.g.
				 * /wise4.project.json
				 */
				String projectFileName = rawProjectUrl.substring(rawProjectUrl.lastIndexOf("/"));
				
				/*
				 * add the project file name, project id, project title, and other details
				 * to the JSONObject
				 */
				JSONObject projectDetails = new JSONObject();
				projectDetails.put("id", p.getId());
				projectDetails.put("path", projectFileName);
				projectDetails.put("title", title);
				projectDetails.put("lastEdited", lastEdited);
				projectDetails.put("lastEditedTime", lastEditedTime);
				
				//add the JSONObject to our array
				recentProjectArray.put(projectDetails);
			}
		}
		
		//create JSONObject and add recent project array and number of owned, shared, and bookmarked proejcts
		JSONObject myprojects = new JSONObject();
		myprojects.put("owned", totalOwned);
		myprojects.put("shared", totalShared);
		myprojects.put("bookmarked", totalBookmarked);
		myprojects.put("recentProjects", recentProjectArray);
		
		//return the JSONArray as a string
		response.getWriter().write(myprojects.toString());
	}
	
	/**
	 * Get all the library projects
	 * @param request
	 * @param response
	 * @throws Exception
	 * @return the JSONArray of library projects
	 */
	private JSONArray getLibraryProjects(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<Project> libraryProjects = projectService.getProjectListByTagName("library");

		//an array to hold the information for the projects
		JSONArray libraryProjectArray = new JSONArray();

		for(Project libraryProject : libraryProjects) {
			if(libraryProject.getProjectType()==ProjectType.LD) {
				/*
				 * get the relative project url
				 * e.g.
				 * /235/wise4.project.json
				 */
				String rawProjectUrl = (String) libraryProject.getCurnit().accept(new CurnitGetCurnitUrlVisitor());

				//get the title of the project
				String title = libraryProject.getName();

				if(rawProjectUrl != null) {
					/*
					 * get the project file name
					 * e.g.
					 * /wise4.project.json
					 */
					String projectFileName = rawProjectUrl.substring(rawProjectUrl.lastIndexOf("/"));

					/*
					 * add the project file name, project id, and project title
					 * to the JSONObject
					 */
					JSONObject projectDetails = new JSONObject();
					projectDetails.put("id", libraryProject.getId());
					projectDetails.put("path", projectFileName);
					projectDetails.put("title", title);

					//add the JSONObject to our array
					libraryProjectArray.put(projectDetails);
				}
			}
		}

		//return the JSONArray
		return libraryProjectArray;
	}

	/**
	 * Handles the publish metadata request from the authoring tool
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ObjectNotFoundException 
	 * @throws IOException 
	 */
	private ModelAndView handlePublishMetadata(HttpServletRequest request, HttpServletResponse response) throws ObjectNotFoundException, IOException{
		Long projectId = Long.parseLong(request.getParameter("projectId"));
		//String versionId = request.getParameter("versionId");
		String metadataString = request.getParameter("metadata");
		JSONObject metadata = null;

		try {
			metadata = new JSONObject(metadataString);
		} catch (JSONException e1) {
			e1.printStackTrace();
		}

		Project project = this.projectService.getById(projectId);
		User user = ControllerUtil.getSignedInUser();

		/* retrieve the metadata from the file */
		//JSONObject metadata = this.projectService.getProjectMetadataFile(project, versionId);

		/* set the fields in the ProjectMetadata where appropriate */
		if(metadata != null){
			//ProjectMetadata pMeta = this.projectService.getMetadata(projectId, versionId);
			ProjectMetadata pMeta = project.getMetadata();

			/* if no previous metadata exists for this project, then we want to create one
			 * and set it in the project */
			if(pMeta == null){
				pMeta = new ProjectMetadataImpl();
				pMeta.setProjectId(projectId);
				project.setMetadata(pMeta);
			}

			Object title = this.getJSONFieldValue(metadata, "title");
			if(title != null && ((String) title).trim().length() > 0 && !((String) title).equals("null")){
				pMeta.setTitle((String) title);
				project.setName((String) title);
			}

			Object author = this.getJSONFieldValue(metadata, "author");
			if(author != null){
				pMeta.setAuthor((String) author);
			}

			Object subject = this.getJSONFieldValue(metadata, "subject");
			if(subject != null){
				pMeta.setSubject((String) subject);
			}

			Object summary = this.getJSONFieldValue(metadata, "summary");
			if(summary != null){
				pMeta.setSummary((String) summary);
			}

			Object graderange = this.getJSONFieldValue(metadata, "graderange");
			if(graderange != null){
				pMeta.setGradeRange((String) graderange);
			}

			Object contact = this.getJSONFieldValue(metadata, "contact");
			if(contact != null){
				pMeta.setContact((String) contact);
			}

			Object techreqs = this.getJSONFieldValue(metadata, "techreqs");
			if(techreqs != null){
				pMeta.setTechReqs((String) techreqs);
			}

			Object tools = this.getJSONFieldValue(metadata, "tools");
			if(tools != null){
				pMeta.setTools((String) tools);
			}

			Object lessonplan = this.getJSONFieldValue(metadata, "lessonplan");
			if(lessonplan != null){
				pMeta.setLessonPlan((String) lessonplan);
			}

			Object standards = this.getJSONFieldValue(metadata, "standards");
			if(standards != null){
				pMeta.setStandards((String) standards);
			}

			Object totaltime = this.getJSONFieldValue(metadata, "totaltime");
			if(totaltime != null && !((String) totaltime).equals("")){
				pMeta.setTotalTime((String) totaltime);
			} 

			Object comptime = this.getJSONFieldValue(metadata, "comptime");
			if(comptime != null && !((String) comptime).equals("")){
				pMeta.setCompTime((String) comptime);
			}

			Object keywords = this.getJSONFieldValue(metadata, "keywords");
			if(keywords != null){
				pMeta.setKeywords((String) keywords);
			}

			Object language = this.getJSONFieldValue(metadata, "language");
			if(language != null){
				pMeta.setLanguage((String) language);
			}

			/* save the project */
			try{
				this.projectService.updateProject(project, user);
			} catch (NotAuthorizedException e){
				e.printStackTrace();
				response.getWriter().write(e.getMessage());
			}

			/* write success message */
			response.getWriter().write("Project metadata was successfully published to the portal.");
		} else {
			/* write error message that portal could not access metadata file */
			response.getWriter().write("The portal was unable to access the data in the metadata file. The metadata may be out of sync.");
		}

		return null;
	}

	/**
	 * Returns the value of the given <code>String</code> field name in the given
	 * <code>JSONObject</code> if it exists, returns null otherwise. This function
	 * is provided as a means to catch the JSON error that is associated with retrieving
	 * fields in JSONObjects without the caller having to catch it.
	 * 
	 * @param obj
	 * @param fieldName
	 * @return
	 */
	private Object getJSONFieldValue(JSONObject obj, String fieldName){
		try{
			return obj.get(fieldName);
		} catch(JSONException e){
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * Checks the request command for the given <code>String</code> servlet and returns
	 * <code>boolean</code> true if the request's command parameter value is listed as
	 * projectless, returns false otherwise.
	 * 
	 * @param request
	 * @param servlet
	 * @return boolean
	 */
	private boolean isProjectlessRequest(HttpServletRequest request, String servlet){
		if(servlet.equals("filemanager")){
			return filemanagerProjectlessRequests.contains(request.getParameter("command"));
		}

		if(servlet.equals("minifier")){
			return minifierProjectlessRequests.contains(request.getParameter("command"));
		}

		return false;
	}

	/**
	 * Returns <code>boolean</code> true if the given <code>User</code> user has sufficient permissions
	 * to create a project, returns false otherwise.
	 * 
	 * @param user
	 * @return boolean
	 */
	private boolean hasAuthorPermissions(User user){
		return user.getUserDetails().hasGrantedAuthority(UserDetailsService.AUTHOR_ROLE) || 
				user.getUserDetails().hasGrantedAuthority(UserDetailsService.TEACHER_ROLE);
	}

	/**
	 * Writes the current user's username to the response
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	private ModelAndView handleGetUsername(HttpServletRequest request, HttpServletResponse response) throws IOException{
		User user = (User) request.getSession().getAttribute(User.CURRENT_USER_SESSION_KEY);
		response.getWriter().write(user.getUserDetails().getUsername());
		return null;
	}

	/**
	 * Get the url to the curriculum base on the vlewrapper
	 * e.g.
	 * http://localhost:8080/vlewrapper/curriculum
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	private ModelAndView handleGetCurriculumBaseUrl(HttpServletRequest request, HttpServletResponse response) throws IOException{
		//get the curriculum_base_www variable from the portal.properties file
		String vlewrapperBaseUrl = portalProperties.getProperty("curriculum_base_www");

		//write the curriculum base url to the response
		response.getWriter().write(vlewrapperBaseUrl);

		return null;
	}

	/**
	 * Get the config for the authoring tool
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	private ModelAndView handleGetConfig(HttpServletRequest request, HttpServletResponse response) throws IOException{
		//get the user
		User user = (User) request.getSession().getAttribute(User.CURRENT_USER_SESSION_KEY);
		
		//get the username and full name
		MutableUserDetails userDetails = (MutableUserDetails)user.getUserDetails();
		String username = userDetails.getUsername();
		String userfullname = userDetails.getFirstname() + " " + userDetails.getLastname();

		//get the portal url
		String portalUrl = ControllerUtil.getBaseUrlString(request);

		//get the url to get and post metadata
		String projectMetaDataUrl = portalUrl + "/webapp/metadata.html";

		//get the url to make CRater requests
		String cRaterRequestUrl = portalUrl + "/webapp/bridge/request.html?type=cRater";

		//get the curriculum_base_www variable from the portal.properties file
		String vlewrapperBaseUrl = portalProperties.getProperty("curriculum_base_www");

		//get the url to make CRater requests
		String deleteProjectUrl = portalUrl + "/webapp/deleteproject.html";

		//get the url to make analyze project requests
		String analyzeProjectUrl = portalUrl + "/webapp/analyzeproject.html";

		//the get url for premade comments
		String getPremadeCommentsUrl = portalUrl + "/webapp/teacher/grading/premadeComments.html?action=getData";

		//the post url for premade comments
		String postPremadeCommentsUrl = portalUrl + "/webapp/teacher/grading/premadeComments.html?action=postData";

		//create a JSONObject to contain the config params
		JSONObject config = new JSONObject();

		try {
			//set the config variables
			config.put("username", username);
			config.put("userfullname", userfullname);
			config.put("projectMetaDataUrl", projectMetaDataUrl);
			config.put("vlewrapperBaseUrl", vlewrapperBaseUrl);
			config.put("indexUrl", ControllerUtil.getPortalUrlString(request) + TelsAuthenticationProcessingFilter.TEACHER_DEFAULT_TARGET_PATH);
			int maxInactiveInterval = request.getSession().getMaxInactiveInterval() * 1000;
			config.put("sessionTimeoutInterval", maxInactiveInterval);			// add sessiontimeout interval, in milleseconds
			int sessionTimeoutCheckInterval = maxInactiveInterval / 20;         // check 20 times during the session.
			if (sessionTimeoutCheckInterval > 60000) {
				// session should be checked at least every 60 seconds.
				sessionTimeoutCheckInterval = 60000;
			}
			config.put("sessionTimeoutCheckInterval", sessionTimeoutCheckInterval); // how often session should be checked...check every minute (1 min=60sec=60000 milliseconds)
			config.put("cRaterRequestUrl", cRaterRequestUrl);
			config.put("locale", request.getLocale());
			config.put("deleteProjectUrl", deleteProjectUrl);
			config.put("analyzeProjectUrl", analyzeProjectUrl);
			config.put("getPremadeCommentsUrl", getPremadeCommentsUrl);
			config.put("postPremadeCommentsUrl", postPremadeCommentsUrl);
		} catch (JSONException e) {
			e.printStackTrace();
		}

		//set the string value of the JSON object in the response
		response.getWriter().write(config.toString());

		return null;
	}

	private ModelAndView handleGetMetadata(HttpServletRequest request, HttpServletResponse response) throws IOException {
		Project project = (Project) request.getAttribute("project");
		User user = ControllerUtil.getSignedInUser();
		ProjectMetadata metadata = project.getMetadata();

		if(metadata == null) {
			metadata = new ProjectMetadataImpl();
			project.setMetadata(metadata);
			try {
				projectService.updateProject(project, user);
			} catch (NotAuthorizedException e) {
				e.printStackTrace();
			}
		}
		
		// check if original author has been set, if not set it
		String author = metadata.getAuthor();
		if(author == null || author == ""){
			JSONObject authorJSON = new JSONObject();
			
			// check if root project has been set, if not set it
			Long rootId = project.getRootProjectId();
			if(rootId == null){
				try {
					rootId = projectService.identifyRootProjectId(project);
					project.setRootProjectId(rootId);
				} catch (ObjectNotFoundException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			try {
				Project rootP = projectService.getById(rootId);
				Set<User> owners = rootP.getOwners();
				for(User owner : owners){
					MutableUserDetails ownerDetails = (MutableUserDetails)owner.getUserDetails();
					try {
						authorJSON.put("username", ownerDetails.getUsername());
						authorJSON.put("fullname", ownerDetails.getFirstname() + " " + ownerDetails.getLastname());
					} catch (JSONException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				metadata.setAuthor(authorJSON.toString());
				project.setMetadata(metadata);
				try {
					projectService.updateProject(project, user);
				} catch (NotAuthorizedException e) {
					e.printStackTrace();
				}
			} catch (ObjectNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		response.getWriter().write(metadata.toJSONString());
		return null;
	}

	private ModelAndView handlePostMetadata(HttpServletRequest request, HttpServletResponse response) throws IOException {
		Project project = (Project) request.getAttribute("project");
		User user = ControllerUtil.getSignedInUser();
		String metadataStr = request.getParameter("metadata");
		JSONObject metadataJSON = new JSONObject();
		try {
			metadataJSON = new JSONObject(metadataStr);
		} catch (JSONException e) {
			e.printStackTrace();
		}


		ProjectMetadata metadata = project.getMetadata();
		if (metadata == null) {
			metadata = new ProjectMetadataImpl(metadataJSON);
		} else {
			metadata.populateFromJSON(metadataJSON);
		}

		// get and set the name of the project.
		if(metadataJSON.has("title")) {
			try {
				String title = metadataJSON.getString("title");
				if (title != null && ((String) title).trim().length() > 0 && title != "null") {
					project.setName(title);
				}
			} catch (JSONException e) {
			}	
		}

		project.setMetadata(metadata);
		try {
			projectService.updateProject(project, user);
		} catch (NotAuthorizedException e) {
			e.printStackTrace();
		}

		return null;
	}

	/**
	 * Update the project edited timestamp
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	private ModelAndView handleProjectEdited(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//get the user
		User user = ControllerUtil.getSignedInUser();

		//get the project
		Project project = (Project) request.getAttribute("project");

		if(project != null) {
			//get the project metadata
			ProjectMetadata metadata = project.getMetadata();

			//create a new timestamp with the current time
			Date lastEdited = new Date();

			//set the last edited time
			metadata.setLastEdited(lastEdited);	

			try {
				//update the project in the db
				projectService.updateProject(project, user);
			} catch (NotAuthorizedException e) {
				e.printStackTrace();
			}
		}

		return null;
	}

	/**
	 * Handle the review update project
	 */
	private ModelAndView handleReviewUpdateProject(HttpServletRequest request, HttpServletResponse response) throws IOException {
		return handleReviewOrUpdateProject(request, response);
	}

	/**
	 * Handle the update project
	 */
	private ModelAndView handleUpdateProject(HttpServletRequest request, HttpServletResponse response) throws IOException {
		return handleReviewOrUpdateProject(request, response);
	}

	/**
	 * Handle the review update project or update project 
	 */
	private ModelAndView handleReviewOrUpdateProject(HttpServletRequest request, HttpServletResponse response) throws IOException {
		try {
			//get the service we will forward to, this should be "filemanager"
			String forward = request.getParameter("forward");

			//get the project id
			String projectId = request.getParameter("projectId");

			//get the project
			Project project = this.projectService.getById(projectId);

			//get the signed in user
			User user = ControllerUtil.getSignedInUser();

			//make sure the signed in user has write access
			if(this.projectService.canAuthorProject(project, user)) {
				//get the vlewrapper context
				ServletContext servletContext = this.getServletContext().getContext("/vlewrapper");
				CredentialManager.setRequestCredentials(request, user);

				//forward the request to the vlewrapper
				servletContext.getRequestDispatcher("/vle/" + forward + ".html").forward(request, response);

				//TODO: update the project edited timestamp
			}
		} catch (ObjectNotFoundException e) {
			e.printStackTrace();
		} catch (ServletException e) {
			e.printStackTrace();
		}

		return null;
	}

	/**
	 * Get the full project file path
	 * @param project the project object
	 * @return the full project file path
	 * e.g.
	 * /Users/geoffreykwan/dev/apache-tomcat-5.5.27/webapps/curriculum/667/wise4.project.json
	 */
	private String getProjectFilePath(Project project) {
		String curriculumBaseDir = portalProperties.getProperty("curriculum_base_dir");
		String projectUrl = (String) project.getCurnit().accept(new CurnitGetCurnitUrlVisitor());
		String projectFilePath = curriculumBaseDir + projectUrl;
		return projectFilePath;
	}

	/**
	 * Get the full file path given the project object and a file name
	 * @param project the project object
	 * @param fileName the file name
	 * @return the full file path
	 * e.g.
	 * /Users/geoffreykwan/dev/apache-tomcat-5.5.27/webapps/curriculum/667/node_2.or
	 */
	private String getFilePath(Project project, String fileName) {
		String projectFolderPath = getProjectFolderPath(project);
		String filePath = projectFolderPath + fileName;
		return filePath;
	}

	/**
	 * Get the full project folder path given the project object
	 * @param project the project object
	 * @return the full project folder path
	 * e.g.
	 * /Users/geoffreykwan/dev/apache-tomcat-5.5.27/webapps/curriculum/667
	 */
	private String getProjectFolderPath(Project project) {
		String projectFilePath = getProjectFilePath(project);
		String projectFolderPath = projectFilePath.substring(0, projectFilePath.lastIndexOf("/"));
		return projectFolderPath;
	}

	/**
	 * @param projectService the projectService to set
	 */
	public void setProjectService(ProjectService projectService) {
		this.projectService = projectService;
	}

	/**
	 * @param httpRestTransport the httpRestTransport to set
	 */
	public void setHttpRestTransport(HttpRestTransport httpRestTransport) {
		this.httpRestTransport = httpRestTransport;
	}

	/**
	 * @param portalProperties the portalProperties to set
	 */
	public void setPortalProperties(Properties portalProperties) {
		this.portalProperties = portalProperties;
	}

	/**
	 * @param curnitService the curnitService to set
	 */
	public void setCurnitService(CurnitService curnitService) {
		this.curnitService = curnitService;
	}

	/**
	 * @param tagger the tagger to set
	 */
	public void setTagger(TaggerController tagger) {
		this.tagger = tagger;
	}
	
	/**
	 * @param runService the runService to set
	 */
	public void setRunService(RunService runService) {
		this.runService = runService;
	}
}
