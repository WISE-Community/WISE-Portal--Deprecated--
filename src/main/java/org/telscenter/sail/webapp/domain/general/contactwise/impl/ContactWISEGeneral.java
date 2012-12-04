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
package org.telscenter.sail.webapp.domain.general.contactwise.impl;

import java.util.Properties;

import net.sf.sail.webapp.domain.User;

import org.telscenter.sail.webapp.domain.authentication.impl.StudentUserDetails;
import org.telscenter.sail.webapp.domain.general.contactwise.ContactWISE;
import org.telscenter.sail.webapp.domain.general.contactwise.IssueType;
import org.telscenter.sail.webapp.domain.general.contactwise.OperatingSystem;
import org.telscenter.sail.webapp.domain.general.contactwise.WebBrowser;

/**
 * @author Hiroki Terashima
 *
 * @version $Id$
 */
public class ContactWISEGeneral implements ContactWISE {

	private static final long serialVersionUID = 1L;

	protected IssueType issuetype;
	
	protected String name;
	
	protected String email;
	
	protected String summary;
	
	protected String description;
	
	private static Properties emaillisteners;
	
	private User user;
	
	private Boolean isStudent = false;
	
	protected String usersystem;
	

	
	/**
	 * @param properties the properties to set
	 */
	public void setEmaillisteners(Properties emaillisteners) {
		this.emaillisteners = emaillisteners;
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.general.contactwise.ContactWISE#getDescription()
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.general.contactwise.ContactWISE#getEmail()
	 */
	public String getEmail() {
		return email;
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.general.contactwise.ContactWISE#getIssueType()
	 */
	public IssueType getIssuetype() {
		return issuetype;
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.general.contactwise.ContactWISE#getName()
	 */
	public String getName() {
		return name;
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.general.contactwise.ContactWISE#getSummary()
	 */
	public String getSummary() {
		return summary;
	}

	/**
	 * @param issueType the issueType to set
	 */
	public void setIssuetype(IssueType issuetype) {
		this.issuetype = issuetype;
	}

	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @param email the email to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}

	/**
	 * @param summary the summary to set
	 */
	public void setSummary(String summary) {
		this.summary = summary;
	}

	/**
	 * @param description the description to set
	 */
	public void setDescription(String description) {
		this.description = description;
	}

	public String[] getMailRecipients() {
		String[] recipients = new String[0];
		
		if(this.issuetype != null) {
			//get the email recipient for the issue type
			String emailForIssueType = emaillisteners.getProperty(this.issuetype.name().toLowerCase());
			
			if(emailForIssueType != null && !emailForIssueType.equals("")) {
				//we have an email address for the issue type
				recipients = emailForIssueType.split(",");
			}
		}
		
		if(recipients.length == 0) {
			/*
			 * we did not have an email address for the issue type so we will try
			 * to use the uber_admin email address
			 */
			
			//get the uber_admin email address
			String uberAdminEmailAddress = emaillisteners.getProperty("uber_admin");
			
			if(uberAdminEmailAddress != null && !uberAdminEmailAddress.equals("")) {
				//set the uber_admin email address into the recipients
				recipients = uberAdminEmailAddress.split(",");
			}
		}
				
		return recipients;
	}
	
	/*
	 * Returns a string array of emails to be cc'd
	 */
	public String[] getMailCcs() {
		String[] cc = {getEmail()};
		return cc;
	}
	
	public String getMailSubject() {
		String subject = "[Contact WISE General] " + issuetype + ": " + summary;
		
		return subject;
	}
	
	public String getMailMessage() {
		String message = "Contact WISE General Request\n" +
		 "=================\n" + 
		 "Name: " + name + "\n" + 
		 "Email: " + email + "\n" + 
		 "Issue Type: " + issuetype + "\n" +
		 "Summary: " + summary + "\n" + 
		 "Description: " + description + "\n" +
		 "User System: " + usersystem + "\n";
		
		return message;
	}
	
	public void setIsStudent(Boolean isStudent) {
		this.isStudent = isStudent;
		setEmail("student@wise.com");
	}

	public void setIsStudent(User user) {
		if(user != null && user.getUserDetails() instanceof StudentUserDetails) {
			isStudent = true;
			setEmail("student@wise.com");
		}
	}
	
	public Boolean getIsStudent() {
		return isStudent;
	}
	

	/**
	 * @return the usersystem
	 */
	public String getUsersystem() {
		return usersystem;
	}

	/**
	 * @param usersystem the usersystem to set
	 */
	public void setUsersystem(String usersystem) {
		this.usersystem = usersystem;
	}
}
