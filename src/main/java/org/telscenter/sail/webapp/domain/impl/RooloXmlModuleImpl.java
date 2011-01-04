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

import org.telscenter.sail.webapp.domain.Module;
import org.telscenter.sail.webapp.domain.project.ProjectInfo;

import net.sf.sail.webapp.domain.CurnitVisitor;
import net.sf.sail.webapp.domain.User;
import net.sf.sail.webapp.domain.impl.CurnitImpl;
import net.sf.sail.webapp.domain.sds.SdsCurnit;

import roolo.elo.ELOMetadataKeys;
import roolo.elo.api.IELO;
import roolo.elo.api.IMetadata;
import roolo.elo.api.IMetadataValueContainer;

/**
 * @author patrick lawler
 * @version $Id:$
 */
@Entity
@Table(name = RooloXmlModuleImpl.DATA_STORE_NAME)
public class RooloXmlModuleImpl extends CurnitImpl implements Module{
	
	@Transient
	public static final String DATA_STORE_NAME = "rooloxmlmodules";

    @Transient
    public static final String COLUMN_NAME_ROOLOMODULEURI = "roolomoduleuri";  
    
    @Transient
    public static final String COLUMN_NAME_ROOLOURL = "roolorepositoryurl";
    
	@Transient
	private static final long serialVersionUID = 1L;
	
	@Column(name = RooloXmlModuleImpl.COLUMN_NAME_ROOLOMODULEURI)
	private String rooloModuleUri;
	
	@Column(name = RooloXmlModuleImpl.COLUMN_NAME_ROOLOURL)
	private String rooloRepositoryUrl;
	
	@Transient
	private IELO elo;

	public Object accept(CurnitVisitor visitor) {
		return null;
	}

	public Long getId() {
		return null;
	}

	public SdsCurnit getSdsCurnit() {
		return null;
	}

	public void setSdsCurnit(SdsCurnit sdsCurnit) {
	}

	public String getAuthors() {
		// TODO Auto-generated method stub
		return null;
	}

	public Long getComputerTime() {
		// TODO Auto-generated method stub
		return null;
	}

	public String getDescription() {
		// TODO Auto-generated method stub
		return null;
	}

	public String getGrades() {
		// TODO Auto-generated method stub
		return null;
	}

	public Set<User> getOwners() {
		// TODO Auto-generated method stub
		return null;
	}

	public String getTechReqs() {
		// TODO Auto-generated method stub
		return null;
	}

	public String getTopicKeywords() {
		// TODO Auto-generated method stub
		return null;
	}

	public Long getTotalTime() {
		// TODO Auto-generated method stub
		return null;
	}

	public void setAuthors(String authors) {
		// TODO Auto-generated method stub
		
	}

	public void setComputerTime(Long computerTime) {
		// TODO Auto-generated method stub
		
	}

	public void setDescription(String description) {
		// TODO Auto-generated method stub
		
	}

	public void setGrades(String grades) {
		// TODO Auto-generated method stub
		
	}

	public void setOwners(Set<User> owners) {
		// TODO Auto-generated method stub
		
	}

	public void setTechReqs(String techReqs) {
		// TODO Auto-generated method stub
		
	}

	public void setTopicKeywords(String topicKeywords) {
		// TODO Auto-generated method stub
		
	}

	public void setTotalTime(Long totalTime) {
		// TODO Auto-generated method stub
		
	}

	/**
	 * @return the roolomoduleuri
	 */
	public String getRoolomoduleuri() {
		return rooloModuleUri;
	}

	/**
	 * @param roolomoduleuri the roolomoduleuri to set
	 */
	public void setRoolomoduleuri(String roolomoduleuri) {
		this.rooloModuleUri = roolomoduleuri;
	}

	/**
	 * @return the roolorepositoryurl
	 */
	public String getRoolorepositoryurl() {
		return rooloRepositoryUrl;
	}

	/**
	 * @param roolorepositoryurl the roolorepositoryurl to set
	 */
	public void setRoolorepositoryurl(String roolorepositoryurl) {
		this.rooloRepositoryUrl = roolorepositoryurl;
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
	 * Updates this IELO given projectinfo values.
	 * @param projectInfo
	 */
	public void updateProxy(ProjectInfo projectInfo) {
		IMetadata metadata = this.getElo().getMetadata();
		IMetadataValueContainer container;
		container = metadata.getMetadataValueContainer(ELOMetadataKeys.AUTHOR.getKey());
		container.setValue( projectInfo.getAuthor() );
		container = metadata.getMetadataValueContainer(ELOMetadataKeys.COMMENT.getKey());
		container.setValue( projectInfo.getComment() );
		container = metadata.getMetadataValueContainer(ELOMetadataKeys.FAMILYTAG.getKey());
		container.setValue( projectInfo.getFamilyTag() );
		container = metadata.getMetadataValueContainer(ELOMetadataKeys.ISCURRENT.getKey());
		container.setValue( Boolean.toString(projectInfo.isCurrent()) );
		container = metadata.getMetadataValueContainer(ELOMetadataKeys.DESCRIPTION.getKey());
		container.setValue( projectInfo.getDescription() );
		container = metadata.getMetadataValueContainer(ELOMetadataKeys.GRADELEVEL.getKey());
		container.setValue( projectInfo.getGradeLevel() );
		container = metadata.getMetadataValueContainer(ELOMetadataKeys.SUBJECT.getKey());
		container.setValue( projectInfo.getSubject() );
		container = metadata.getMetadataValueContainer(ELOMetadataKeys.KEYWORDS.getKey());
		container.setValue( projectInfo.getKeywords() );
	}
	
	public void populateModuleFromProxy(IELO elo) {
		IMetadata metadata = elo.getMetadata();
		IMetadataValueContainer container = metadata.getMetadataValueContainer(ELOMetadataKeys.DESCRIPTION.getKey());
		this.setDescription( container.getValue().toString() );
		this.setElo(elo);
	}
	
	
}
