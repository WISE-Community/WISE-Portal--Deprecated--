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

import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

import net.sf.sail.webapp.domain.User;
import net.sf.sail.webapp.domain.impl.CurnitImpl;

import org.telscenter.sail.webapp.dao.module.impl.RooloOtmlModuleDao;
import org.telscenter.sail.webapp.domain.Module;
import org.telscenter.sail.webapp.domain.project.ProjectInfo;
import org.telscenter.sail.webapp.service.module.impl.ModuleServiceImpl;

import roolo.elo.ELOMetadataKeys;
import roolo.elo.api.IELO;
import roolo.elo.api.IMetadata;
import roolo.elo.api.IMetadataValueContainer;

/**
 * @author Hiroki Terashima
 * @version $Id$
 */
@Entity
@Table(name = RooloOtmlModuleImpl.DATA_STORE_NAME)
public class RooloOtmlModuleImpl extends ModuleImpl {

	@Transient
	public static final String DATA_STORE_NAME = "roolootmlmodules";

    @Transient
    public static final String COLUMN_NAME_ROOLOMODULEURI = "roolomoduleuri";  
    
    @Transient
    public static final String COLUMN_NAME_ROOLOURL = "roolorepositoryurl";  // uri within roolo
    
	@Transient
	private static final long serialVersionUID = 1L;

	@Column(name = RooloOtmlModuleImpl.COLUMN_NAME_ROOLOMODULEURI)
	private String rooloModuleUri;  // uri of the module within roolo
	
	@Column(name = RooloOtmlModuleImpl.COLUMN_NAME_ROOLOURL)
	private String rooloRepositoryUrl;    // url of the roolo repository

	@Transient
	private IELO elo;
	
	/**
	 * @see org.telscenter.sail.webapp.domain.Module#getComputerTime()
	 */
	public Long getComputerTime() {
		// TODO Auto-generated method stub
		return null;
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.Module#getDescription()
	 */
	public String getDescription() {
		// TODO Auto-generated method stub
		return null;
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.Module#getOwners()
	 */
	public Set<User> getOwners() {
		// TODO Auto-generated method stub
		return null;
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.Module#getTechReqs()
	 */
	public String getTechReqs() {
		// TODO Auto-generated method stub
		return null;
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.Module#getTotalTime()
	 */
	public Long getTotalTime() {
		// TODO Auto-generated method stub
		return null;
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.Module#setComputerTime(java.lang.Long)
	 */
	public void setComputerTime(Long computerTime) {
		// TODO Auto-generated method stub

	}

	/**
	 * @see org.telscenter.sail.webapp.domain.Module#setDescription(java.lang.String)
	 */
	public void setDescription(String description) {
		// TODO Auto-generated method stub

	}

	/**
	 * @see org.telscenter.sail.webapp.domain.Module#setOwners(java.util.Set)
	 */
	public void setOwners(Set<User> owners) {
		// TODO Auto-generated method stub

	}

	/**
	 * @see org.telscenter.sail.webapp.domain.Module#setTechReqs(java.lang.String)
	 */
	public void setTechReqs(String techReqs) {
		// TODO Auto-generated method stub

	}

	/**
	 * @see org.telscenter.sail.webapp.domain.Module#setTotalTime(java.lang.Long)
	 */
	public void setTotalTime(Long totalTime) {
	}
	
	/**
	 * Returns a url string that can be used to retrieve this
	 * module's otml
	 * 
	 * @return <code>String</code> url where this module's 
	 *     otml can be retrieved.
	 */
	public String getRetrieveOtmlUrl() {
		return this.rooloRepositoryUrl + "/retrieveotml.html?uri=" +
		    this.rooloModuleUri;
	}

	/**
	 * @return the rooloModuleUri
	 */
	public String getRooloModuleUri() {
		return rooloModuleUri;
	}

	/**
	 * @param rooloModuleUri the rooloModuleUri to set
	 */
	public void setRooloModuleUri(String rooloModuleUri) {
		this.rooloModuleUri = rooloModuleUri;
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

	public String getAuthors() {
		// TODO Auto-generated method stub
		return null;
	}

	public String getGrades() {
		// TODO Auto-generated method stub
		return null;
	}

	public String getTopicKeywords() {
		// TODO Auto-generated method stub
		return null;
	}

	public void setAuthors(String authors) {
		// TODO Auto-generated method stub
		
	}

	public void setGrades(String grades) {
		// TODO Auto-generated method stub
		
	}

	public void setTopicKeywords(String topicKeywords) {
		// TODO Auto-generated method stub
		
	}

	/**
	 * @return the elo
	 */
	public IELO getElo() {
		return elo;
	}

	/**
	 * @param elo the elo to set
	 */
	public void setElo(IELO elo) {
		this.elo = elo;
	}

}
