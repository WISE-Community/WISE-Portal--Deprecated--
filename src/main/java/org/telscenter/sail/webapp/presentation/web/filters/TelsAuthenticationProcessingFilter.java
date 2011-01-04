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
package org.telscenter.sail.webapp.presentation.web.filters;

import java.io.IOException;
import java.util.Calendar;

import javax.servlet.ServletException;

import net.sf.sail.webapp.presentation.web.filters.PasAuthenticationProcessingFilter;
import net.sf.sail.webapp.service.authentication.AuthorityNotFoundException;

import org.springframework.security.Authentication;
import org.springframework.security.GrantedAuthority;
import org.springframework.security.userdetails.UserDetails;
import org.springframework.util.StringUtils;
import org.telscenter.sail.webapp.domain.authentication.MutableUserDetails;
import org.telscenter.sail.webapp.domain.authentication.impl.StudentUserDetails;
import org.telscenter.sail.webapp.domain.authentication.impl.TeacherUserDetails;
import org.telscenter.sail.webapp.service.authentication.UserDetailsService;

/**
 * Custom AuthenticationProcessingFilter that subclasses Acegi Security. This
 * filter upon successful authentication will retrieve a <code>User</code> and
 * put it into the http session.
 *
 * @author Hiroki Terashima
 * @version $Id$
 */
public class TelsAuthenticationProcessingFilter extends
		PasAuthenticationProcessingFilter {

	public static final String STUDENT_DEFAULT_TARGET_PATH = "/student/index.html";
	//private static final String STUDENT_DEFAULT_TARGET_PATH = "/student/vle/vle.html?runId=65";
	public static final String TEACHER_DEFAULT_TARGET_PATH = "/teacher/index.html";
	public static final String ADMIN_DEFAULT_TARGET_PATH = "/admin/index.html";
	public static final String RESEARCHER_DEFAULT_TARGET_PATH = "/teacher/index.html";

	private UserDetailsService userDetailsService;
	
	
	/**
	 * @see org.acegisecurity.ui.AbstractProcessingFilter#successfulAuthentication(javax.servlet.http.HttpServletRequest,
	 *      javax.servlet.http.HttpServletResponse,
	 *      org.acegisecurity.Authentication)
	 */
	@Override
	protected void successfulAuthentication(
			javax.servlet.http.HttpServletRequest request,
			javax.servlet.http.HttpServletResponse response,
			Authentication authResult) throws IOException, ServletException {
		
        UserDetails userDetails = (UserDetails) authResult.getPrincipal();
        if (userDetails instanceof StudentUserDetails) {
        	this.setDefaultTargetUrl(STUDENT_DEFAULT_TARGET_PATH);
        }
        else if (userDetails instanceof TeacherUserDetails) {
	   		this.setDefaultTargetUrl(TEACHER_DEFAULT_TARGET_PATH);

        	GrantedAuthority researcherAuth = null;
        	try {
        		researcherAuth = userDetailsService.loadAuthorityByName(UserDetailsService.RESEARCHER_ROLE);
			} catch (AuthorityNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			GrantedAuthority authorities[] = userDetails.getAuthorities();
        	for (int i = 0; i < authorities.length; i++) {
        		if (researcherAuth.equals(authorities[i])) {
        			this.setDefaultTargetUrl(RESEARCHER_DEFAULT_TARGET_PATH);
        		}
        	}
	   		
        	GrantedAuthority adminAuth = null;
        	try {
				adminAuth = userDetailsService.loadAuthorityByName(UserDetailsService.ADMIN_ROLE);
			} catch (AuthorityNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        	for (int i = 0; i < authorities.length; i++) {
        		if (adminAuth.equals(authorities[i])) {
        			this.setDefaultTargetUrl(ADMIN_DEFAULT_TARGET_PATH);
        		}
        	}
        }
        
        /* redirect if specified in the login request */
   		String redirectUrl = request.getParameter("redirect");
   		if(StringUtils.hasText(redirectUrl)){
   			this.setDefaultTargetUrl(redirectUrl);
   		}
   		
		super.successfulAuthentication(request, response, authResult);
		((MutableUserDetails) userDetails).incrementNumberOfLogins();
		((MutableUserDetails) userDetails).setLastLoginTime(Calendar.getInstance().getTime());
		userDetailsService.updateUserDetails((MutableUserDetails) userDetails);
       
	}

	/**
	 * @return the userDetailsService
	 */
	public UserDetailsService getUserDetailsService() {
		return userDetailsService;
	}

	/**
	 * @param userDetailsService the userDetailsService to set
	 */
	public void setUserDetailsService(UserDetailsService userDetailsService) {
		this.userDetailsService = userDetailsService;
	}		

}
