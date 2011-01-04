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
package org.telscenter.sail.webapp.presentation.web.controllers.teacher.grading;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.sail.webapp.domain.User;
import net.sf.sail.webapp.domain.Workgroup;
import net.sf.sail.webapp.presentation.web.controllers.ControllerUtil;
import net.sf.sail.webapp.service.UserService;

import org.springframework.security.context.SecurityContext;
import org.springframework.security.context.SecurityContextHolder;
import org.springframework.security.userdetails.UserDetails;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import org.telscenter.sail.webapp.domain.Run;
import org.telscenter.sail.webapp.service.offering.RunService;

/**
 * @author Hiroki Terashima
 * @author Patrick Lawler
 */
public class ProjectPickerGradingController extends AbstractController {

	private RunService runService;

	private UserService userService;

	private static final String VIEW_NAME = "teacher/grading/projectPickerGrading";

	protected static final String CURRENT_RUN_LIST_KEY = "current_run_list";
	
	protected static final String ARCHIVED_RUN_LIST_KEY = "archived_run_list";

	protected static final String GRADE_BY_TYPE_REQUEST_PARAM_NAME = "gradeByType";
	
	private static String GRADING_PAGE_BASE_URL = "gradingpage";
	
	
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
		
		// set grading page base url...gradeByTypeParam is assumed to be not null
		String gradingPageBaseUrl = "";
		String gradeByTypeParam = request.getParameter(GRADE_BY_TYPE_REQUEST_PARAM_NAME);
		if (gradeByTypeParam.equals("step")) {
			gradingPageBaseUrl = "gradework.html?gradingType=step";
		} else if (gradeByTypeParam.equals("team")) {
			gradingPageBaseUrl = "gradework.html?gradingType=team";
		} else if (gradeByTypeParam.equals("group")) {
			gradingPageBaseUrl = "selectworkgroup.html";
		} else if (gradeByTypeParam.equals("value")) {
			gradingPageBaseUrl = "editmaxstepvalues.html";
		}

		modelAndView.addObject(CURRENT_RUN_LIST_KEY, current_runs);
		modelAndView.addObject(ARCHIVED_RUN_LIST_KEY, archived_runs);
		modelAndView.addObject(GRADING_PAGE_BASE_URL, gradingPageBaseUrl);
		modelAndView.addObject(GRADE_BY_TYPE_REQUEST_PARAM_NAME, gradeByTypeParam);

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
