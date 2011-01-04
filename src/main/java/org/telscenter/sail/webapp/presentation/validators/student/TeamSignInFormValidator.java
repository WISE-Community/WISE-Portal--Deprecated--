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
package org.telscenter.sail.webapp.presentation.validators.student;

import net.sf.sail.webapp.domain.User;
import net.sf.sail.webapp.service.UserService;

import org.apache.commons.lang.StringUtils;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;
import org.telscenter.sail.webapp.presentation.web.TeamSignInForm;

/**
 * Validator for the TeamSignIn form
 *
 * @author Hiroki Terashima
 * @version $Id$
 */
public class TeamSignInFormValidator implements Validator {

	private UserService userService;
	
	/**
	 * @see org.springframework.validation.Validator#supports(java.lang.Class)
	 */
	@SuppressWarnings("unchecked")
	public boolean supports(Class clazz) {
		return TeamSignInForm.class.isAssignableFrom(clazz);
	}

	/**
	 * @see org.springframework.validation.Validator#validate(java.lang.Object, org.springframework.validation.Errors)
	 */
	public void validate(Object teamSignInFormIn, Errors errors) {
		TeamSignInForm teamSignInForm = (TeamSignInForm) teamSignInFormIn;
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "username1", 
				"error.teamsignin-username-not-specified");

		if (errors.hasErrors()) {
			return;
		}

		User user1 = userService.retrieveUserByUsername(teamSignInForm.getUsername1());
		if (user1 == null) {
			errors.rejectValue("username1", "error.teamsignin-user-does-not-exist");
			return;
		}
		
		// handle user2 and user3 separately; be able to handle when user3 is filled in
		// but not user2
		if (!StringUtils.isEmpty(teamSignInForm.getUsername2())) {
			if (StringUtils.isEmpty(teamSignInForm.getPassword2())) {
				errors.rejectValue("password2", "error.teamsignin-password-not-specified");
			} else {
				User user2 = userService.retrieveUserByUsername(teamSignInForm.getUsername2());
				if (user2 == null) {
					errors.rejectValue("username2", "error.teamsignin-user-does-not-exist");
				} else if (user2.getUserDetails().getPassword() != teamSignInForm.getPassword2()) {
					//TODO FIGURE OUT HOW TO COMPARE PASSWORDS
					//errors.rejectValue("password2", "error.teamsignin-incorrect-password");
				}
			}
		}
		
		if (!StringUtils.isEmpty(teamSignInForm.getUsername3())) {
			if (StringUtils.isEmpty(teamSignInForm.getPassword3())) {
				errors.rejectValue("password3", "error.teamsignin-password-not-specified");
			} else {
				User user3 = userService.retrieveUserByUsername(teamSignInForm.getUsername3());
				if (user3 == null) {
					errors.rejectValue("username3", "error.teamsignin-user-does-not-exist");
				} else if (user3.getUserDetails().getPassword() != teamSignInForm.getPassword3()) {
					//errors.rejectValue("password3", "error.teamsignin-incorrect-password");
				}
			}
		}
	}

	/**
	 * @return the userService
	 */
	public UserService getUserService() {
		return userService;
	}

	/**
	 * @param userService the userService to set
	 */
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

}
