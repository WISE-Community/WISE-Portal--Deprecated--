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
package org.telscenter.sail.webapp.presentation.web;

import java.io.Serializable;

/**
 * The class encapsulates all of the data necessary for students
 * in a workgroup to sign in before starting a project
 * 
 * @author Hiroki Terashima
 * @version $Id: $
 */
public class TeamSignInForm implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Long runId;
	
	private String username1, username2, username3, password2, password3;

	/**
	 * @return the runId
	 */
	public Long getRunId() {
		return runId;
	}

	/**
	 * @param runId the runId to set
	 */
	public void setRunId(Long runId) {
		this.runId = runId;
	}

	/**
	 * @return the password2
	 */
	public String getPassword2() {
		return password2;
	}

	/**
	 * @param password2 the password2 to set
	 */
	public void setPassword2(String password2) {
		this.password2 = password2;
	}

	/**
	 * @return the password3
	 */
	public String getPassword3() {
		return password3;
	}

	/**
	 * @param password3 the password3 to set
	 */
	public void setPassword3(String password3) {
		this.password3 = password3;
	}

	/**
	 * @return the username1
	 */
	public String getUsername1() {
		return username1;
	}

	/**
	 * @param username1 the username1 to set
	 */
	public void setUsername1(String username1) {
		this.username1 = username1;
	}

	/**
	 * @return the username2
	 */
	public String getUsername2() {
		return username2;
	}

	/**
	 * @param username2 the username2 to set
	 */
	public void setUsername2(String username2) {
		this.username2 = username2;
	}

	/**
	 * @return the username3
	 */
	public String getUsername3() {
		return username3;
	}

	/**
	 * @param username3 the username3 to set
	 */
	public void setUsername3(String username3) {
		this.username3 = username3;
	}

}
