/**
 * 
 */
package org.telscenter.sail.webapp.presentation.web.controllers.teacher.project.customized;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.sail.webapp.domain.User;
import net.sf.sail.webapp.domain.impl.CurnitGetCurnitUrlVisitor;
import net.sf.sail.webapp.presentation.web.controllers.ControllerUtil;
import net.sf.sail.webapp.service.UserService;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import org.telscenter.sail.webapp.domain.project.Project;
import org.telscenter.sail.webapp.service.offering.RunService;
import org.telscenter.sail.webapp.service.project.ProjectService;

/**
 * Controller for customized projects index page
 * @author Hiroki Terashima
 * @author MattFish
 */
public class CustomizedIndexController extends AbstractController {

	private ProjectService projectService;

	private UserService userService;

	private RunService runService;

	private Properties portalProperties;

	/**
	 * @see org.springframework.web.servlet.mvc.AbstractController#handleRequestInternal(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	@Override
	protected ModelAndView handleRequestInternal(HttpServletRequest request,
			HttpServletResponse response) throws Exception {		 
		ModelAndView modelAndView = new ModelAndView();
		User user = ControllerUtil.getSignedInUser();

		// separate owned projects to current and archived.
		List<Project> ownedProjectsList = this.projectService.getProjectList(user);
		List<Project> currentOwnedProjectsList = new ArrayList<Project>();
		List<Project> archivedOwnedProjectsList = new ArrayList<Project>();
		for (Project project : ownedProjectsList) {
			if (project.isCurrent()) {
				currentOwnedProjectsList.add(project);
			} else {
				archivedOwnedProjectsList.add(project);
			}
		}

		/* sort the project lists */
		this.projectService.sortProjectsByDateCreated(currentOwnedProjectsList);
		this.projectService.sortProjectsByDateCreated(archivedOwnedProjectsList);

		modelAndView.addObject("currentOwnedProjectsList", currentOwnedProjectsList);
		modelAndView.addObject("archivedOwnedProjectsList", archivedOwnedProjectsList);

		// separate shared projects to current and archived.
		List<Project> sharedProjectsList = this.projectService.getSharedProjectList(user);
		sharedProjectsList.removeAll(ownedProjectsList);
		List<Project> currentSharedProjectsList = new ArrayList<Project>();
		List<Project> archivedSharedProjectsList = new ArrayList<Project>();
		for (Project project : sharedProjectsList) {
			if (project.isCurrent()) {
				currentSharedProjectsList.add(project);
			} else {
				archivedSharedProjectsList.add(project);
			}
		}

		/* sort the project lists */
		this.projectService.sortProjectsByDateCreated(currentSharedProjectsList);
		this.projectService.sortProjectsByDateCreated(archivedSharedProjectsList);

		modelAndView.addObject("currentSharedProjectsList", currentSharedProjectsList);
		modelAndView.addObject("archivedSharedProjectsList", archivedSharedProjectsList);

		// send in bookmarked projects
		List<Project> bookmarkedProjectsList = this.projectService.getBookmarkerProjectList(user);
		modelAndView.addObject("bookmarkedProjectsList", bookmarkedProjectsList);

		Map<Long, Integer> usageMap = new TreeMap<Long, Integer>();
		Map<Long,String> urlMap = new TreeMap<Long,String>();
		Map<Long,String> filenameMap = new TreeMap<Long,String>();

		//a map to contain projectId to project name
		Map<Long,String> projectNameMap = new TreeMap<Long,String>();

		//a map to contain projectId to escaped project name
		Map<Long,String> projectNameEscapedMap = new TreeMap<Long,String>();

		String curriculumBaseDir = this.portalProperties.getProperty("curriculum_base_dir");
		for (Project p: ownedProjectsList) {
			if (p.isCurrent()){
				String url = (String) p.getCurnit().accept(new CurnitGetCurnitUrlVisitor());

				//get the project name and put it into the map
				String projectName = p.getName();
				projectNameMap.put((Long) p.getId(), projectName);

				//replace ' with \' in the project name and put it into the map
				projectName = projectName.replaceAll("\\'", "\\\\'");
				projectNameEscapedMap.put((Long) p.getId(), projectName);

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
		}

		for (Project p: sharedProjectsList) {
			if (p.isCurrent()){
				String url = (String) p.getCurnit().accept(new CurnitGetCurnitUrlVisitor());

				//get the project name and put it into the map
				String projectName = p.getName();
				projectNameMap.put((Long) p.getId(), projectName);

				//replace ' with \' in the project name and put it into the map
				projectName = projectName.replaceAll("\\'", "\\\\'");
				projectNameEscapedMap.put((Long) p.getId(), projectName);

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
		}

		modelAndView.addObject("usageMap", usageMap);
		modelAndView.addObject("urlMap", urlMap);
		modelAndView.addObject("filenameMap", filenameMap);
		modelAndView.addObject("curriculumBaseDir", curriculumBaseDir);
		modelAndView.addObject("projectNameMap", projectNameMap);
		modelAndView.addObject("projectNameEscapedMap", projectNameEscapedMap);
		return modelAndView;
	}

	/**
	 * @param projectService the projectService to set
	 */
	public void setProjectService(ProjectService projectService) {
		this.projectService = projectService;
	}
	/**
	 * @param userService the userService to set
	 */
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	/**
	 * @param portalProperties the portalProperties to set
	 */
	public void setPortalProperties(Properties portalProperties) {
		this.portalProperties = portalProperties;
	}

	/**
	 * @param runService the runService to set
	 */
	public void setRunService(RunService runService) {
		this.runService = runService;
	}
}
