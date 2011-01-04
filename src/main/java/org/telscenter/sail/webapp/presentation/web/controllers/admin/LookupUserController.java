/**
 * Copyright (c) 2007 Regents of the University of California (Regents). Created
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

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.sail.webapp.domain.User;
import net.sf.sail.webapp.domain.webservice.http.HttpRestTransport;
import net.sf.sail.webapp.presentation.web.controllers.ControllerUtil;
import net.sf.sail.webapp.service.UserService;

import org.springframework.beans.factory.annotation.Required;
import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import org.springframework.web.servlet.mvc.SimpleFormController;
import org.telscenter.sail.webapp.domain.authentication.MutableUserDetails;
import org.telscenter.sail.webapp.domain.impl.LookupUserParameters;

/**
 * @author Sally Ahn
 * @version $Id: $
 */
public class LookupUserController extends SimpleFormController {

	private static final String VIEW_NAME = "admin/lookupuser";
	
	private UserService userService;
		
	/**
     * On submission of the Change Password form, the logged-in user's password
     * in the database gets changed to the submitted password
     * 
     * @see org.springframework.web.servlet.mvc.SimpleFormController#onSubmit(javax.servlet.http.HttpServletRequest,
     *      javax.servlet.http.HttpServletResponse, java.lang.Object,
     *      org.springframework.validation.BindException)
     */
    @Override
    protected ModelAndView onSubmit(HttpServletRequest request,
            HttpServletResponse response, Object command, BindException errors){
		User user = ControllerUtil.getSignedInUser();
    	LookupUserParameters params = (LookupUserParameters) command;

    	ModelAndView modelAndView = null;

   		User retrievedUser = userService.retrieveUserByUsername(params.getUsernameToLookup());

   		if (retrievedUser == null) {
   			modelAndView = new ModelAndView(getFormView());
   			modelAndView.addObject("message", "User not found.");
   		} else {
   	   		MutableUserDetails userDetails = (MutableUserDetails)retrievedUser.getUserDetails();
   			modelAndView = new ModelAndView(getSuccessView());
   			modelAndView.addObject("retrievedUser", retrievedUser);
   			modelAndView.addObject("userInfoMap", userDetails.getInfo());
   		}

    	return modelAndView;
    }
    
	/**
	 * @param userService the userService to set
	 */
    public void setUserService(UserService userService) {
    	this.userService = userService;
    }
    
	/**
	 * @param userService the userService to get
	 */
    public UserService getUserService() {
    	return this.userService;
    }
	
	
}
