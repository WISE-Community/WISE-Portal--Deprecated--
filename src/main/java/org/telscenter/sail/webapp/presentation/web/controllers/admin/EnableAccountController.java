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
package org.telscenter.sail.webapp.presentation.web.controllers.admin;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.sail.webapp.domain.User;
import net.sf.sail.webapp.presentation.web.controllers.ControllerUtil;
import net.sf.sail.webapp.service.UserService;

import org.springframework.validation.BindException;
import org.springframework.validation.Errors;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;
import org.telscenter.sail.webapp.domain.impl.ChangeStudentPasswordParameters;
import org.telscenter.sail.webapp.domain.impl.EnableAccountParameters;
import org.telscenter.sail.webapp.service.authentication.UserDetailsService;

/**
 * Controller for admins to enable/disable user accounts.
 * 
 * @author hirokiterashima
 * @version $Id:$
 */
public class EnableAccountController extends SimpleFormController {
	
	private static final String USERNAME_PARAM = "username";

	private static final String DO_ENABLE_PARAM = "doEnable";
	
	private UserService userService;
	
	/**
	 * @see org.springframework.web.servlet.mvc.SimpleFormController#showForm(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, org.springframework.validation.BindException)
	 */
    @Override
    protected ModelAndView showForm(HttpServletRequest request,
            HttpServletResponse response,
            BindException errors)
     throws Exception {
    	// first get the logged-in user and check that the user has permission to change the
    	// specified user's password
		User loggedInUser = ControllerUtil.getSignedInUser();
		
    	String username = request.getParameter(USERNAME_PARAM);
    	User userToChange = null;
    	if (username != null) {
    		userToChange = userService.retrieveUserByUsername(username);
    	} else {
    		// if username is not specified, assume that logged-in user wants to change his/her own password.
    		userToChange = loggedInUser;
    	}
    	if (canChangeEnableStatus(loggedInUser, userToChange)) {
			return super.showForm(request, response, errors);
		} else {
			// otherwise, the logged-in user does not have permission to change the password.
			response.setStatus(HttpServletResponse.SC_FORBIDDEN);
			return null;
		}    
	}
    
    /*
	@Override
    protected Object formBackingObject(HttpServletRequest request) throws Exception {
    	String username = request.getParameter(USERNAME_PARAM);
    	EnableAccountParameters params = new EnableAccountParameters();
    	User userToChange = null;
    	if (username != null) {
    		userToChange = userService.retrieveUserByUsername(username);
    	} else {
    		// if username is not specified, assume that logged-in user wants to change his/her own password.
    		userToChange = ControllerUtil.getSignedInUser();
    	}
		ChangeStudentPasswordParameters params = new ChangeStudentPasswordParameters();
		params.setUser(userToChange);
		return params;
    }
    */
	@Override
    protected Map<String, Object> referenceData(HttpServletRequest request,
            Object command,
            Errors errors)
     throws Exception {
    	String username = request.getParameter(USERNAME_PARAM);
		User userToChange = userService.retrieveUserByUsername(username);

		Map<String, Object> model = new HashMap<String, Object>();
		model.put("username", username);
		if ( userToChange.getUserDetails().isEnabled()) {
			model.put("current_enable_status","ENABLED");
		} else {
			model.put("current_enable_status","DISABLED");
		}
		return model;
    }
     
    /**
     * Returns true iff loggedInUser has permissions to change
     * enable/disable status of the userToChange.
     *  This is true when:
     *  1) loggedInUser is an admin
     *  2) loggedInUser == userToChange
     *  
     * @param loggedInUser
     * @param userToChange
     * @return
     */
	private boolean canChangeEnableStatus(User loggedInUser, User userToChange) {
		return loggedInUser.getUserDetails().hasGrantedAuthority(UserDetailsService.ADMIN_ROLE) 
			|| userToChange.equals(loggedInUser);
	}
	
	@Override
	protected ModelAndView onSubmit(HttpServletRequest request,
            HttpServletResponse response,
            Object command,
            BindException errors)
     throws Exception {
		String username = request.getParameter(USERNAME_PARAM);
		String doEnable = request.getParameter(DO_ENABLE_PARAM);
		User userToEdit = userService.retrieveUserByUsername(username);
		userToEdit.getUserDetails().setEnabled(Boolean.parseBoolean(doEnable));
		userService.updateUser(userToEdit);
		//ModelAndView mav = new ModelAndView(this.getSuccessView());
		//return mav;
		return null;
	}

	/**
	 * @param userService the userService to set
	 */
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
}
