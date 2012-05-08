/**
 * 
 */
package org.telscenter.sail.webapp.presentation.web.controllers.teacher.management;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.sail.webapp.domain.User;
import net.sf.sail.webapp.presentation.web.controllers.ControllerUtil;
import net.sf.sail.webapp.service.UserService;

import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import org.telscenter.sail.webapp.domain.Run;
import org.telscenter.sail.webapp.service.offering.RunService;

/**
 * @author mattfish
 *
 */
public class ProjectPickerManagementController extends AbstractController {

	private RunService runService;

	private UserService userService;

	private static final String VIEW_NAME = "teacher/management/projectPickerManagement";

	protected static final String CURRENT_RUN_LIST_KEY = "current_run_list";
	
	protected static final String ARCHIVED_RUN_LIST_KEY = "archived_run_list";

	
	/**
	 * @see org.springframework.web.servlet.mvc.AbstractController#handleRequestInternal(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	@SuppressWarnings("unchecked")
	@Override
	protected ModelAndView handleRequestInternal(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

    	ModelAndView modelAndView = new ModelAndView(VIEW_NAME);
    	ControllerUtil.addUserToModelAndView(request, modelAndView);
 
		User user = ControllerUtil.getSignedInUser();
		List<Run> runList = this.runService.getRunList();
		// this is a temporary solution to filtering out runs that the logged-in user owns.
		// when the ACL entry permissions is figured out, we shouldn't have to do this filtering
		// start temporary code
		List<Run> current_runs = new ArrayList<Run>();
		List<Run> archived_runs = new ArrayList<Run>();
		
		for (Run run : runList) {
			if (run.getOwners().contains(user)) {
				if (run.isEnded()) {
					archived_runs.add(run);
				} else {
					current_runs.add(run);
				}
			}
		}
		// end temporary code

		modelAndView.addObject(CURRENT_RUN_LIST_KEY, current_runs);
		modelAndView.addObject(ARCHIVED_RUN_LIST_KEY, archived_runs);

        return modelAndView;
	}


	/**
	 * @param runService the runService to set
	 */
	public void setRunService(RunService runService) {
		this.runService = runService;
	}

	/**
	 * @param userService the userService to set
	 */
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

}
