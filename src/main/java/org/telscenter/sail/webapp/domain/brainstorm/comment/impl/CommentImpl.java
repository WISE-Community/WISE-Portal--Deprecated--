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
package org.telscenter.sail.webapp.domain.brainstorm.comment.impl;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.Transient;
import javax.persistence.Version;

import org.telscenter.sail.webapp.domain.brainstorm.comment.Comment;
import org.telscenter.sail.webapp.domain.workgroup.WISEWorkgroup;
import org.telscenter.sail.webapp.domain.workgroup.impl.WISEWorkgroupImpl;

/**
 * @author Hiroki Terashima
 * @version $Id$
 */
@Entity(name = CommentImpl.DATA_STORE_NAME)
public class CommentImpl implements Comment {

	@Transient
	public static final String DATA_STORE_NAME = "brainstormcomments";
	
    @Transient
    private static final long serialVersionUID = 1L;

    @Transient
	private static final String COLUMN_NAME_ISANONYMOUS = "isanonymous";

    @Transient
	private static final String COLUMN_NAME_TIMESTAMP = "timestamp";

    @Transient
	private static final String WORKGROUPS_JOIN_COLUMN_NAME = "workgroups_fk";

    @Transient
	private static final String COLUMN_NAME_BODY = "body";

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id = null;
    
    @Version
    @Column(name = "OPTLOCK")
    private Integer version = null;
    
    @Lob
    @Column(name = CommentImpl.COLUMN_NAME_BODY)
    private String body;

    @ManyToOne(targetEntity = WISEWorkgroupImpl.class)
    @JoinColumn(name = WORKGROUPS_JOIN_COLUMN_NAME, nullable = false, unique = false)
    private WISEWorkgroup workgroup;
    
    @Column(name = CommentImpl.COLUMN_NAME_TIMESTAMP, nullable = false)
    private Date timestamp;

    @Column(name = CommentImpl.COLUMN_NAME_ISANONYMOUS)    
    private boolean isAnonymous;
    
	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.comment.Comment#getBody()
	 */
	public String getBody() {
		return body;
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.comment.Comment#getTimestamp()
	 */
	public Date getTimestamp() {
		return timestamp;
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.comment.Comment#getWorkgroup()
	 */
	public WISEWorkgroup getWorkgroup() {
		return workgroup;
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.comment.Comment#isAnnonymous()
	 */
	public boolean isAnonymous() {
		return isAnonymous;
	}
	
	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.comment.Comment#setAnonymous(boolean)
	 */
	public void setAnonymous(boolean isAnonymous) {
		this.isAnonymous = isAnonymous;
	}
	
	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.comment.Comment#getBody(java.lang.String)
	 */
	public void setBody(String body) {
		this.body = body;
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.comment.Comment#setTimestamp(java.util.Date)
	 */
	public void setTimestamp(Date timestamp) {
		this.timestamp = timestamp;
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.comment.Comment#setWorkgroup(org.telscenter.sail.webapp.domain.workgroup.WISEWorkgroup)
	 */
	public void setWorkgroup(WISEWorkgroup workgroup) {
		this.workgroup = workgroup;
	}

	/**
     * @see net.sf.sail.webapp.domain.group.Group#getId()
     */
    public Long getId() {
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

	public int compareTo(Comment o) {
		return this.timestamp.compareTo(o.getTimestamp());
	}
}
