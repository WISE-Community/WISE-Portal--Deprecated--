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
import org.telscenter.sail.webapp.domain.project.Project;
import org.telscenter.sail.webapp.service.project.ProjectService;

/**
 * @author Hiroki Terashima
 *
 * @version $Id: ContactWISEGeneral.java 1651 2008-01-28 20:13:43Z geoff $
 */
public class ContactWISEProject extends ContactWISEGeneral {
	
	private static final long serialVersionUID = 1L;
	
	private String projectName;
	
	private Long projectId;
	
	private Long runId;
	
	public String getMailSubject() {
		String subject = "[Contact WISE Project] " + issuetype + ": " + summary;
		
		return subject;
	}
	
	public String getMailMessage() {		
		String message = "Contact WISE Project Request\n" +
		 "=================\n" + 
		 "Name: " + name + "\n" + 
		 "Email: " + email + "\n" + 
		 "Project Name: " + projectName + "\n" +
		 "Project ID: " + projectId + "\n" +
		 "Issue Type: " + issuetype + "\n" +
		 "Summary: " + summary + "\n" + 
		 "Description: " + description + "\n" +
		 "User System: " + usersystem + "\n";
		
		return message;
	}

	/**
	 * @return the projectName
	 */
	public String getProjectName() {
		return projectName;
	}

	/**
	 * @param projectName the projectName to set
	 */
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	/**
	 * @return the projectId
	 */
	public Long getProjectId() {
		return projectId;
	}

	/**
	 * @param projectId the projectId to set
	 */
	public void setProjectId(Long projectId) {
		this.projectId = projectId;
	}
	
	/**
	 * @return the run id
	 */
	public Long getRunId() {
		return runId;
	}

	/**
	 * @param runId the run id
	 */
	public void setRunId(Long runId) {
		this.runId = runId;
	}
}
