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

import java.io.File;
import java.util.Set;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Lob;
import javax.persistence.Table;
import javax.persistence.Transient;

import net.sf.sail.webapp.domain.CurnitVisitor;
import net.sf.sail.webapp.domain.User;
import net.sf.sail.webapp.domain.impl.CurnitImpl;

import org.telscenter.sail.webapp.domain.Module;

/**
 * @author Hiroki Terashima
 * @version $Id$
 */
@Entity
@Table(name = OtmlModuleImpl.DATA_STORE_NAME)
public class OtmlModuleImpl extends ModuleImpl implements Module {

	@Transient
	private static final long serialVersionUID = 1L;

	@Transient
	public static final String DATA_STORE_NAME = "otmlmodules";

	@Transient
	public static final String COLUMN_NAME_OTMLFILE = "otml";

	@Transient
	private static final String COLUMN_NAME_RETREIVEOTMLURL = "retrieveotmlurl";
	
	@Transient
	public File otmlfile;
	
	@Lob
	@Basic(fetch = FetchType.LAZY)
	@Column(name = OtmlModuleImpl.COLUMN_NAME_OTMLFILE, length = 2147483647)
	public byte[] otml;
	
	@Column(name = OtmlModuleImpl.COLUMN_NAME_RETREIVEOTMLURL)
	public String retrieveotmlurl;  // url to retrieve this otml
	
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
		// TODO Auto-generated method stub

	}

	/**
	 * @return the otmlfile
	 */
	public File getOtmlfile() {
		return otmlfile;
	}

	/**
	 * @param otmlfile the otmlfile to set
	 */
	public void setOtmlfile(File otmlfile) {
		this.otmlfile = otmlfile;
	}

	/**
	 * @return the otml
	 */
	public byte[] getOtml() {
		return otml;
	}

	/**
	 * @param otml the otml to set
	 */
	public void setOtml(byte[] otml) {
		this.otml = otml;
	}

	/**
	 * @return the retrieveotmlurl
	 */
	public String getRetrieveotmlurl() {
		return retrieveotmlurl;
	}

	/**
	 * @param retrieveotmlurl the retrieveotmlurl to set
	 */
	public void setRetrieveotmlurl(String retrieveotmlurl) {
		this.retrieveotmlurl = retrieveotmlurl;
	}
	
    /**
     * @see net.sf.sail.webapp.domain.Curnit#accept(net.sf.sail.webapp.domain.CurnitVisitor)
     */
	public Object accept(CurnitVisitor visitor) {
		return visitor.visit(this);
	}
}
