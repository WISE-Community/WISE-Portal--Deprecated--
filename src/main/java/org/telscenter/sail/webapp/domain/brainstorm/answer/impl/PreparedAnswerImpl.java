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

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.Transient;
import javax.persistence.Version;

import org.telscenter.sail.webapp.domain.brainstorm.answer.PreparedAnswer;

/**
 * @author hirokiterashima
 * @version $Id:$
 */
@Entity(name = PreparedAnswerImpl.DATA_STORE_NAME)
public class PreparedAnswerImpl implements PreparedAnswer {

    @Transient
    public static final String DATA_STORE_NAME = "brainstormpreparedanswers";

	@Transient
	private static final long serialVersionUID = 1L;

	@Transient
	private static final String COLUMN_NAME_BODY = "body";

	@Transient
	private static final String COLUMN_NAME_DISPLAYNAME = "displayname";

	@Column(name = PreparedAnswerImpl.COLUMN_NAME_BODY, length=1024)
	private String body;

	@Column(name = PreparedAnswerImpl.COLUMN_NAME_DISPLAYNAME)
	private String displayname;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id = null;
    
    @Version
    @Column(name = "OPTLOCK")
    private Integer version = null;
    
	/**
	 * @return the body
	 */
	public String getBody() {
		return body;
	}

	/**
	 * @param body the body to set
	 */
	public void setBody(String body) {
		this.body = body;
	}

	/**
	 * @return the dislayname
	 */
	public String getDisplayname() {
		return displayname;
	}

	/**
	 * @param dislayname the dislayname to set
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
     * @see java.lang.Comparable#compareTo(java.lang.Object)
     */
	public int compareTo(PreparedAnswer o) {
		if (id == null) {
			return -1;
		} else if (o.getId() == null) {
			return 1;
		} else {
		    return this.id.compareTo((Long) o.getId());
		}
	}

}
