/**
 * 
 */
package org.telscenter.sail.webapp.service.impl;

import java.util.Properties;

import javax.mail.MessagingException;

import net.sf.sail.webapp.dao.sds.HttpStatusCodeException;
import net.sf.sail.webapp.domain.User;
import net.sf.sail.webapp.domain.authentication.MutableUserDetails;
import net.sf.sail.webapp.domain.sds.SdsUser;
import net.sf.sail.webapp.mail.IMailFacade;
import net.sf.sail.webapp.service.authentication.DuplicateUsernameException;
import net.sf.sail.webapp.service.authentication.UserNotFoundException;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.transaction.annotation.Transactional;
import org.telscenter.sail.webapp.domain.authentication.impl.StudentUserDetails;
import org.telscenter.sail.webapp.domain.authentication.impl.TeacherUserDetails;
import org.telscenter.sail.webapp.service.authentication.UserDetailsService;

/**
 * @author Hiroki Terashima
 * @version $Id$
 */
public class UserServiceImpl extends
		net.sf.sail.webapp.service.impl.UserServiceImpl {

	private IMailFacade javaMail = null;

	private Properties emaillisteners = null;

	private Properties portalProperties;
	
	/**
	 * @throws DuplicateUsernameException 
	 * @see net.sf.sail.webapp.service.UserService#createUser(net.sf.sail.webapp.domain.authentication.MutableUserDetails)
	 */
	@Override
	@Transactional(rollbackFor = { DuplicateUsernameException.class, HttpStatusCodeException.class})
	public User createUser(final MutableUserDetails userDetails) throws DuplicateUsernameException, HttpStatusCodeException {

		org.telscenter.sail.webapp.domain.authentication.MutableUserDetails details = 
			(org.telscenter.sail.webapp.domain.authentication.MutableUserDetails) userDetails;

		// assign roles
		if (userDetails instanceof StudentUserDetails) {
			this.assignRole(userDetails, UserDetailsService.STUDENT_ROLE);
		} else if (userDetails instanceof TeacherUserDetails) {
			this.assignRole(userDetails, UserDetailsService.TEACHER_ROLE);
			this.assignRole(userDetails, UserDetailsService.AUTHOR_ROLE);
		} 
		
		// trim firstname and lastname so it doesn't contain leading or trailing spaces
		details.setFirstname(details.getFirstname().trim());
		details.setLastname(details.getLastname().trim());
		String coreUsername = details.getCoreUsername();
		String[] suffixes = details.getUsernameSuffixes(); // extra at end to ensure username uniqueness
		int index = 0;  // index within suffixes array 
		
		details.setNumberOfLogins(0);
		for (;;) {   // loop until a unique username can be found
			try {
				details.setUsername(coreUsername + suffixes[index]);
				User createdUser = super.createUser(details);
				if (createdUser.getUserDetails() instanceof TeacherUserDetails) {
					NewAccountEmailService newAccountEmailService = new NewAccountEmailService(createdUser);
					Thread thread = new Thread(newAccountEmailService);
					thread.start();
				}
				return createdUser;
			}
			catch (DuplicateUsernameException e) {
				if (index >= suffixes.length) {
					throw e;
				}
				index++;
				continue;
			}
			catch (HttpStatusCodeException e) {
				throw e;
			}
		}
	}
	
	/**
	 * @see net.sf.sail.webapp.service.impl.UserServiceImpl#createSdsUser(net.sf.sail.webapp.domain.authentication.MutableUserDetails)
	 */
	@Override
	public SdsUser createSdsUser(final MutableUserDetails userDetails) {
		org.telscenter.sail.webapp.domain.authentication.MutableUserDetails telsUserDetails 
		 = (org.telscenter.sail.webapp.domain.authentication.MutableUserDetails) userDetails;
		SdsUser sdsUser = new SdsUser();
		sdsUser.setFirstName(telsUserDetails.getFirstname());
		sdsUser.setLastName(telsUserDetails.getLastname());
		return sdsUser;	
	}

	/**
	 * Comment me.
	 * 
	 * @param userDetails
	 * @throws UserNotFoundException
	 */
	public void checkUserUpdateErrors(MutableUserDetails userDetails) throws UserNotFoundException {
		//check if the use does exist
		User user = this.retrieveUser(userDetails);
		if(user == null) {
			throw new UserNotFoundException(userDetails.getUsername());
		}// if
	}
	
	/**
	 * @see net.sf.sail.webapp.service.UserService#retrieveUserByUsername(java.lang.String)
	 */
	@Override
	@Transactional(readOnly = true)
	public User retrieveUserByUsername(String username) {
		User user = null;
		try {
  		   user = super.retrieveUserByUsername(username);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
		return user;
	}	
	
	  class NewAccountEmailService implements Runnable {

	    	private User newUser;
	    	
			public NewAccountEmailService(User newUser) {
				this.newUser = newUser;
			}

			public void run() {
				this.sendEmail();
			}

			/**
		     * Sends a welcome email to the new user with WISE4 resources
		     * On exception sending the email, ignore.
		     */
			private void sendEmail() {

				String sendEmailEnabledStr = portalProperties.getProperty("send_email_enabled");
				Boolean sendEmailEnabled = Boolean.valueOf(sendEmailEnabledStr);
				if (!sendEmailEnabled) {
					return;
				}
				TeacherUserDetails newUserDetails = 
					(TeacherUserDetails) newUser.getUserDetails();
				String userUsername = newUserDetails.getUsername();
				String userEmailAddress = newUserDetails.getEmailAddress();
								
				String[] recipients = {userEmailAddress, emaillisteners.getProperty("uber_admin")};
				
				String subject = "Welcome to WISE4!";	
				String portalbaseurl = portalProperties.getProperty("portal_baseurl");
				String message =
					"Your username is: " + userUsername + "\n\n" +					
					"Welcome to our new WISE4 learning environment. Our research over the past many " +
					"years demonstrates that students have significant learning gains when using WISE " +
					"projects. We are still actively developing WISE4 so you may notice some teacher support " +
					"links that are not yet available. These will not limit your use of the program with students. " +
					"The following resource link will be of help to you: \"Teacher Information Sheet\" at " +
					portalbaseurl + "/pages/gettingstarted.html. Be sure to let us know if you " +
					"have any problems or questions.\n\n" +
					"WISE Team";					

				
				String fromEmail = emaillisteners.getProperty("portalemailaddress");
				
				try {
					//sends the email to the recipients
					javaMail.postMail(recipients, subject, message, fromEmail);
				} catch (MessagingException e) {
					// do nothing, no notification to uber_admin required.
					e.printStackTrace();
				}
			}
	    }
	  

		/**
		 * @param emaillisteners the emaillisteners to set
		 */
		public void setEmaillisteners(Properties emaillisteners) {
			this.emaillisteners = emaillisteners;
		}
		
		/**
		 * @param javaMail the javaMail to set
		 */
		public void setJavaMail(IMailFacade javaMail) {
			this.javaMail = javaMail;
		}

		/**
		 * @param portalProperties the portalProperties to set
		 */
		public void setPortalProperties(Properties portalProperties) {
			this.portalProperties = portalProperties;
		}
}


