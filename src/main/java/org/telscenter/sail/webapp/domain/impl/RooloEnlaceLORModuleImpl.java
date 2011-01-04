package org.telscenter.sail.webapp.domain.impl;

import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

import net.sf.sail.webapp.domain.User;
import net.sf.sail.webapp.domain.impl.CurnitImpl;

import org.telscenter.sail.webapp.domain.Module;
import org.telscenter.sail.webapp.domain.project.ProjectInfo;

import roolo.elo.ELOMetadataKeys;
import roolo.elo.api.IELO;
import roolo.elo.api.IMetadata;
import roolo.elo.api.IMetadataValueContainer;

@Entity
@Table(name = RooloEnlaceLORModuleImpl.DATA_STORE_NAME)
public class RooloEnlaceLORModuleImpl extends CurnitImpl implements Module {

	@Transient
	public static final String DATA_STORE_NAME = "rooloenlacelormodules";

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
    private IELO learningObject;
	
	/**
	 * @see org.telscenter.sail.webapp.domain.Module#getComputerTime()
	 */
	public Long getComputerTime() {
		return null;
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.Module#getDescription()
	 */
	public String getDescription() {
		return null;
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.Module#getOwners()
	 */
	public Set<User> getOwners() {
		return null;
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.Module#getTechReqs()
	 */
	public String getTechReqs() {
		return null;
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.Module#getTotalTime()
	 */
	public Long getTotalTime() {
		return null;
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.Module#setComputerTime(java.lang.Long)
	 */
	public void setComputerTime(Long computerTime) {
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.Module#setDescription(java.lang.String)
	 */
	public void setDescription(String description) {
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.Module#setOwners(java.util.Set)
	 */
	public void setOwners(Set<User> owners) {
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.Module#setTechReqs(java.lang.String)
	 */
	public void setTechReqs(String techReqs) {
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.Module#setTotalTime(java.lang.Long)
	 */
	public void setTotalTime(Long totalTime) {
	}

	/**
	 * Given a CurnitProxy object, retrieves corresponding attributes
	 * from it and sets them on this object.
	 * 
	 * @param learningObject
	 */
	public void populateModuleFromProxy(IELO learningObject) {
		IMetadata metadata = learningObject.getMetadata();
		IMetadataValueContainer container = metadata.getMetadataValueContainer(ELOMetadataKeys.DESCRIPTION.getKey());
		this.setDescription( container.getValue().toString() );
		this.setLearningObject(learningObject);
	}
	
	/**
	 * Returns a url string that can be used to retrieve this
	 * module's otml
	 * 
	 * @return <code>String</code> url where this module's 
	 *     otml can be retrieved.
	 */
	public String getRetrieveOtmlUrl() {
		return this.rooloRepositoryUrl + "/view.do?id=" +
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

	/**
	 * Updates this proxy given projectinfo values.
	 * @param projectInfo
	 */
	public void updateProxy(ProjectInfo projectInfo) {
		IMetadata metadata = this.getLearningObject().getMetadata();
		IMetadataValueContainer container;
		container = metadata.getMetadataValueContainer(ELOMetadataKeys.AUTHOR.getKey());
		container.setValue( projectInfo.getAuthor() );
//		container = metadata.getMetadataValueContainer(EnlaceLORMetadataKeys.COMMENT.getKey());
//		container.setValue( projectInfo.getComment() );
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
		container = metadata.getMetadataValueContainer(ELOMetadataKeys.TYPE.getKey());
		container.setValue("Curnit");
	}

	public void setLearningObject(IELO learningObject) {
		this.learningObject = learningObject;
	}

	public IELO getLearningObject() {
		return learningObject;
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
}