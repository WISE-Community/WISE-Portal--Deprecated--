package org.telscenter.sail.webapp.domain.project.cmsImpl;

import javax.persistence.Transient;

import org.telscenter.sail.webapp.domain.project.FamilyTag;
import org.telscenter.sail.webapp.domain.project.impl.ProjectImpl;

import roolo.elo.api.IELO;


/**
 * Project implementation using Roolo. RooloProjects are also stored in
 * the datastore; the difference between RooloProjects and ProjectImpl is
 * where the curnit is stored (roolo vs confluence), and RooloProject
 * has a <code>CurnitProxy</code> object.
 * 
 * @author Carlos Celorrio
 * @author Hiroki Terashima
 *
 * @version $Id:$
 */
public class RooloLORProjectImpl extends ProjectImpl {

	@Transient
    private static final long serialVersionUID = 1L;

	@Transient
    private IELO learningObject;
    
	/**
	 * @return the familytag
	 */
	public FamilyTag getFamilytag() {
		return projectinfo.getFamilyTag();
	}

	/**
	 * @param familytag the familytag to set
	 */
	public void setFamilytag(FamilyTag familytag) {
		this.familytag = familytag;
		this.projectinfo.setFamilyTag(familytag);
	}

	/**
	 * @return the isCurrent
	 */
	public boolean isCurrent() {
		return projectinfo.isCurrent();
	}

	/**
	 * @param isCurrent the isCurrent to set
	 */
	public void setCurrent(boolean isCurrent) {
		this.isCurrent = isCurrent;
		this.projectinfo.setCurrent(isCurrent);
	}

	public void setLearningObject(IELO learningObject) {
		this.learningObject = learningObject;
	}

	public IELO getLearningObject() {
		return learningObject;
	}

}
