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
package org.telscenter.sail.webapp.domain.brainstorm.answer.impl;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.Transient;
import javax.persistence.Version;

import org.telscenter.sail.webapp.domain.brainstorm.answer.Revision;

/**
 * @author Hiroki Terashima
 * @version $Id$
 */
@Entity(name = RevisionImpl.DATA_STORE_NAME)
public class RevisionImpl implements Revision {

    @Transient
    private static final long serialVersionUID = 1L;

    @Transient
    public static final String DATA_STORE_NAME = "brainstormrevisions";

    @Transient
	private static final String COLUMN_NAME_TIMESTAMP = "timestamp";

    @Transient
	private static final String COLUMN_NAME_BODY = "body";

    @Transient
	private static final String COLUMN_NAME_DISPLAYNAME = "displayname";
	
    @Column(name = RevisionImpl.COLUMN_NAME_TIMESTAMP, nullable = false)
	private Date timestamp;
	
    @Column(name = RevisionImpl.COLUMN_NAME_DISPLAYNAME)
    private String displayname;  // not null only if this is for a PreparedAnswer.
                                 // for all other cases, this should be null.
    @Lob
    @Column(name = RevisionImpl.COLUMN_NAME_BODY)
	private String body = null;
	
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id = null;
    
    @Version
    @Column(name = "OPTLOCK")
    private Integer version = null;

	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.answer.Revision#getBody()
	 */
	public String getBody() {
		return body;
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.answer.Revision#getTimestamp()
	 */
	public Date getTimestamp() {
		return timestamp;
	}

	/**
	 * @param timestamp the timestamp to set
	 */
	public void setTimestamp(Date timestamp) {
		this.timestamp = timestamp;
	}

	/**
	 * @param body the body to set
	 */
	public void setBody(String body) {
		this.body = body;
	}
	
	/**
	 * @return the displayname
	 */
	public String getDisplayname() {
		return displayname;
	}

	/**
	 * @param displayname the displayname to set
	 */
	public void setDisplayname(String displayname) {
		this.displayname = displayname;
	}

	/**
	 * @see net.sf.sail.webapp.domain.Persistable#getId()
	 */
	public Serializable getId() {
		return id;
	}
	
    /**
     * @param id
     *            the id to set
     */
    @SuppressWarnings("unused")
    private void setId(Long id) {
        this.id = id;
    }

    /**
     * @return the version
     */
    @SuppressWarnings("unused")
    private Integer getVersion() {
        return version;
    }

    /**
     * @param version
     *            the version to set
     */
    @SuppressWarnings("unused")
    private void setVersion(Integer version) {
        this.version = version;
    }

    /**
     * Compare by timestamp.
     * 
     * @see java.lang.Comparable#compareTo(java.lang.Object)
     */
	public int compareTo(Revision o) {
		return this.timestamp.compareTo(o.getTimestamp());
	}

}
