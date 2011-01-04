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
package org.telscenter.sail.webapp.presentation.web.controllers.forgotaccount.teacher;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.sail.webapp.domain.User;
import net.sf.sail.webapp.mail.JavaMailHelper;
import net.sf.sail.webapp.service.UserService;

import org.apache.commons.lang.StringUtils;
import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;
import org.telscenter.sail.webapp.domain.authentication.MutableUserDetails;

/**
 * Controller for lost password teacher username and email lookup
 * 
 * @author Anthony Perritano
 * @version
 */
public class ForgotAccountTeacherIndexController extends SimpleFormController {

	private static final String EMAIL = "email";
	private static final String USERNAME = "username";
	protected UserService userService = null;
	protected JavaMailHelper javaMail = null;
	
	private String errorView = "/forgotaccount/teacher/error";

	/**
	 * helper for sending emails
	 * 
	 * @return
	 */
	public JavaMailHelper getJavaMail() {
		return javaMail;
	}

	/**
	 * helper for sending emails
	 * 
	 * @param javaMail
	 */
	public void setJavaMail(JavaMailHelper javaMail) {
		this.javaMail = javaMail;
	}

	/**
	 * gets the information by username or email and sends an email to the user with the new password.
	 * 
	 * @see org.springframework.web.servlet.mvc.SimpleFormController#onSubmit(javax.servlet.http.HttpServletRequest,
	 *      javax.servlet.http.HttpServletResponse, java.lang.Object,
	 *      org.springframework.validation.BindException)
	 */
	@Override
	protected ModelAndView onSubmit(HttpServletRequest request,
			HttpServletResponse response, Object command, BindException errors)
			throws Exception {
		MutableUserDetails userDetails = (MutableUserDetails) command;

		String username = null;
		String emailAddress = null;
		
		try {

			username = StringUtils.trimToNull(userDetails.getUsername());
			emailAddress = StringUtils
					.trimToNull(userDetails.getEmailAddress());
			User user = null;
			if (username != null) {
				user = userService.retrieveUserByUsername(userDetails
						.getUsername());
				
				if( user == null ) {
					ModelAndView modelAndView = new ModelAndView(
					getErrorView());
					modelAndView.addObject(USERNAME, username);
					return modelAndView;
				}
				
			} else if (emailAddress != null) {
				List<User> users = userService
						.retrieveUserByEmailAddress(emailAddress);

				
				if (users.isEmpty()) {
					ModelAndView modelAndView = new ModelAndView(
							getErrorView());
					modelAndView.addObject(EMAIL, emailAddress);
					return modelAndView;
				} else {
					user = users.get(0);
					username = user.getUserDetails().getUsername();
				}
			}
			String generateRandomPassword = generateRandomPassword();
			userService.updateUserPassword(user, generateRandomPassword);

			String userEmail = user.getUserDetails().getEmailAddress();
			// send password in the email here
			javaMail.postMail(new String[]{userEmail}, "[Tels Portal] Changed Password", "Hi,\n\nfor username: " + username + " Your new password is: "+ generateRandomPassword +"\n\n\n-TELS Technology Team", "telsportal@gmail.com");
			
			Map<String, String> model = new HashMap<String, String>();
			model.put(EMAIL, userEmail);
			model.put(USERNAME, username);
			//model.put(NEW_PASSWORD, generateRandomPassword);
			return new ModelAndView(getSuccessView(), model);

		} catch (Exception e) {
			e.printStackTrace();
			return showForm(request, response, errors);
		}
	}

	/**
	 * Sets the userDetailsService object.
	 * 
	 * @param userDetailsService
	 */
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	/**
	 * generate random password
	 * 
	 * @return
	 */
	public static String generateRandomPassword() {
		// return RandomStringUtils.random(8);
		Random rnd = new Random();
		return Integer.toString(rnd.nextInt(), 27);
	}

	/**
	 * Tests the password generation
	 * 
	 * @param args
	 */
	public static void main(String[] args) {
		System.out.println("New Password: " + generateRandomPassword());
	}

	/**
	 * @return the errorView
	 */
	public String getErrorView() {
		return errorView;
	}

	/**
	 * @param errorView the errorView to set
	 */
	public void setErrorView(String errorView) {
		this.errorView = errorView;
	}

}
