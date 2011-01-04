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
package org.telscenter.sail.webapp.domain.impl;

import net.sf.sail.webapp.domain.impl.CurnitParameters;
import roolo.elo.api.IELO;

/**
 * Params for creating RooloLOROtmlModule
 * @author Anthony Perritano
 * @version $Id$
 */
public class CreateRooloLOROtmlModuleParameters extends CurnitParameters {

	public static String FIELD_ROOLOURI = "roolouri";
	
	private String roolouri;
	
	private String rooloRepositoryUrl;
	
	private IELO learningObject;
	
	/**
	 * @return the roolouri
	 */
	public String getRoolouri() {
		return roolouri;
	}

	/**
	 * @param roolouri the roolouri to set
	 */
	public void setRoolouri(String roolouri) {
		this.roolouri = roolouri;
	}

	/**
	 * @return the rooloRepositoryUrl
	 */
	public String getRooloRepositoryUrl() {
		return rooloRepositoryUrl;
	}

	/**
	 * @param rooloRepositoryUrl the rooloRepositoryUrl to set
	 */
	public void setRooloRepositoryUrl(String rooloRepositoryUrl) {
		this.rooloRepositoryUrl = rooloRepositoryUrl;
	}

	public void setLearningObject(IELO learningObject) {
		this.learningObject = learningObject;
	}

	public IELO getLearningObject() {
		return learningObject;
	}
	
}
