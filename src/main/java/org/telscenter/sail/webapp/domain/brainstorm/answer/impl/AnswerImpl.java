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
import java.util.Set;
import java.util.TreeSet;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Transient;
import javax.persistence.Version;

import net.sf.sail.webapp.domain.group.Group;
import net.sf.sail.webapp.domain.group.impl.PersistentGroup;

import org.hibernate.annotations.Sort;
import org.hibernate.annotations.SortType;
import org.telscenter.sail.webapp.domain.brainstorm.answer.Answer;
import org.telscenter.sail.webapp.domain.brainstorm.answer.AnswerTag;
import org.telscenter.sail.webapp.domain.brainstorm.answer.Revision;
import org.telscenter.sail.webapp.domain.brainstorm.comment.Comment;
import org.telscenter.sail.webapp.domain.brainstorm.comment.impl.CommentImpl;
import org.telscenter.sail.webapp.domain.workgroup.WISEWorkgroup;
import org.telscenter.sail.webapp.domain.workgroup.impl.WISEWorkgroupImpl;

/**
 * @author Hiroki Terashima
 * @version $Id$
 */
@Entity(name = AnswerImpl.DATA_STORE_NAME)
public class AnswerImpl implements Answer {
	
    @Transient
    public static final String DATA_STORE_NAME = "brainstormanswers";

    @Transient
    private static final long serialVersionUID = 1L;
    
    @Transient
    public static final String WORKGROUPS_JOIN_COLUMN_NAME = "workgroups_fk";

    @Transient
	private static final String COMMENTS_JOIN_TABLE_NAME = "brainstormanswers_related_to_brainstormcomments";

    @Transient
	private static final String ANSWERS_JOIN_COLUMN_NAME = "brainstormanswers_fk";

    @Transient
	private static final String COMMENTS_JOIN_COLUMN_NAME = "brainstormcomments_fk";

    @Transient
	private static final String REVISIONS_JOIN_TABLE_NAME = "brainstormanswers_related_to_brainstormrevisions";

    @Transient
	private static final String REVISIONS_JOIN_COLUMN_NAME = "brainstormrevisions_fk";

    @Transient
	private static final String COLUMN_NAME_ISANONYMOUS = "isanonymous";

    @Transient
	private static final String WORKGROUPS_JOIN_TABLE_NAME = "brainstormanswers_related_to_workgroups";

    @Transient
	private static final String WORKGROUP_JOIN_COLUMN_NAME = "workgroups_fk";

    @Transient
	private static final String GROUPS_JOIN_COLUMN_NAME = "groups_fk";

    @Transient
	private static final String ANSWERTAG_JOIN_TABLE_NAME = "brainstormanswers_related_to_answertags";

    @Transient
	private static final String ANSWERTAGS_JOIN_COLUMN_NAME = "answer_tag_fk";

    @ManyToOne(targetEntity = WISEWorkgroupImpl.class)
    @JoinColumn(name = WORKGROUPS_JOIN_COLUMN_NAME, nullable = false, unique = false)
    private WISEWorkgroup workgroup;
    
    @OneToMany(cascade = CascadeType.ALL, targetEntity = CommentImpl.class, fetch = FetchType.EAGER)
    @JoinTable(name = COMMENTS_JOIN_TABLE_NAME, joinColumns = { @JoinColumn(name = ANSWERS_JOIN_COLUMN_NAME, nullable = false) }, inverseJoinColumns = @JoinColumn(name = COMMENTS_JOIN_COLUMN_NAME, nullable = false))
    @Sort(type = SortType.NATURAL)
    private Set<Comment> comments = new TreeSet<Comment>();
   
    @OneToMany(cascade = CascadeType.ALL, targetEntity = RevisionImpl.class, fetch = FetchType.EAGER)
    @JoinTable(name = REVISIONS_JOIN_TABLE_NAME, joinColumns = { @JoinColumn(name = ANSWERS_JOIN_COLUMN_NAME, nullable = false) }, inverseJoinColumns = @JoinColumn(name = REVISIONS_JOIN_COLUMN_NAME, nullable = false))
    @Sort(type = SortType.NATURAL)    
    private Set<Revision> revisions = new TreeSet<Revision>();

    @ManyToMany(targetEntity = WISEWorkgroupImpl.class, fetch = FetchType.EAGER)
    @JoinTable(name = AnswerImpl.WORKGROUPS_JOIN_TABLE_NAME, joinColumns = { @JoinColumn(name = ANSWERS_JOIN_COLUMN_NAME, nullable = false)}, inverseJoinColumns = @JoinColumn(name = WORKGROUP_JOIN_COLUMN_NAME, nullable = false))
    private Set<WISEWorkgroup> workgroupsThatFoundAnswerHelpful = new TreeSet<WISEWorkgroup>();

    @OneToMany(cascade = CascadeType.ALL, targetEntity = AnswerTagImpl.class, fetch = FetchType.EAGER)
    @JoinTable(name = ANSWERTAG_JOIN_TABLE_NAME, joinColumns = { @JoinColumn(name = ANSWERS_JOIN_COLUMN_NAME, nullable = false) }, inverseJoinColumns = @JoinColumn(name = ANSWERTAGS_JOIN_COLUMN_NAME, nullable = false))
    @Sort(type = SortType.NATURAL)    
    private Set<AnswerTag> answerTags = new TreeSet<AnswerTag>();
    
//    @ManyToOne(targetEntity = PersistentGroup.class)
//    @JoinColumn(name = GROUPS_JOIN_COLUMN_NAME, nullable = false)
    @Transient
    private Group group;

    @Column(name = AnswerImpl.COLUMN_NAME_ISANONYMOUS)
    private boolean isAnonymous;
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id = null;
    
    @Version
    @Column(name = "OPTLOCK")
    private Integer version = null;
    
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
     * @see org.telscenter.sail.webapp.domain.brainstorm.answer.Answer#getWorkgroup()
     */
	public WISEWorkgroup getWorkgroup() {
		return workgroup;
	}

	/**
	 * @param workgroup the workgroup to set
	 */
	public void setWorkgroup(WISEWorkgroup workgroup) {
		this.workgroup = workgroup;
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.answer.Answer#addComment(org.telscenter.sail.webapp.domain.brainstorm.comment.Comment)
	 */
	public void addComment(Comment comment) {
		this.comments.add(comment);
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.answer.Answer#getComments()
	 */
	public Set<Comment> getComments() {
		return this.comments;
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.answer.Answer#getRevisions()
	 */
	public Set<Revision> getRevisions() {
		return revisions;
	}

	/**
	 * @param revisions the revisions to set
	 */
	public void setRevisions(Set<Revision> revisions) {
		this.revisions = revisions;
	}

	/**
	 * @return the workgroupsThatFoundAnswerHelpful
	 */
	public Set<WISEWorkgroup> getWorkgroupsThatFoundAnswerHelpful() {
		return workgroupsThatFoundAnswerHelpful;
	}

	/**
	 * @param workgroupsThatFoundAnswerHelpful the workgroupsThatFoundAnswerHelpful to set
	 */
	public void setWorkgroupsThatFoundAnswerHelpful(
			Set<WISEWorkgroup> workgroupsThatFoundAnswerHelpful) {
		this.workgroupsThatFoundAnswerHelpful = workgroupsThatFoundAnswerHelpful;
	}
	
	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.answer.Answer#getAnswerTags()
	 */
	public Set<AnswerTag> getAnswerTags() {
		return answerTags;
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.answer.Answer#getAnswerTags()
	 */
	public void setAnswerTags(Set<AnswerTag> answerTags) {
		this.answerTags = answerTags;
	}
	
	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.answer.Answer#addWorkgroupThatFoundThisAnswerHelpful(org.telscenter.sail.webapp.domain.workgroup.WISEWorkgroup)
	 */
	public void markAsHelpful(WISEWorkgroup workgroup) {
		workgroupsThatFoundAnswerHelpful.add(workgroup);
	}
	
	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.answer.Answer#unmarkAsHelpful(org.telscenter.sail.webapp.domain.workgroup.WISEWorkgroup)
	 */
	public void unmarkAsHelpful(WISEWorkgroup workgroup) {
		workgroupsThatFoundAnswerHelpful.remove(workgroup);
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.answer.Answer#workgroupMarkedAnswerHelpful(org.telscenter.sail.webapp.domain.workgroup.WISEWorkgroup)
	 */
	public boolean workgroupMarkedAnswerHelpful(WISEWorkgroup workgroup) {
		return workgroupsThatFoundAnswerHelpful.contains(workgroup);
	}

	/**
	 * @return the isAnonymous
	 */
	public boolean isAnonymous() {
		return isAnonymous;
	}

	/**
	 * @param isAnonymous the isAnonymous to set
	 */
	public void setAnonymous(boolean isAnonymous) {
		this.isAnonymous = isAnonymous;
	}

	/**
	 * @param comments the comments to set
	 */
	public void setComments(Set<Comment> comments) {
		this.comments = comments;
	}
	
	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.answer.Answer#getGroup()
	 */
	public Group getGroup() {
		return group;
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.answer.Answer#setGroup(net.sf.sail.webapp.domain.group.Group)
	 */
	public void setGroup(Group group) {
		this.group = group;
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.answer.Answer#addRevision(org.telscenter.sail.webapp.domain.brainstorm.answer.Revision)
	 */
	public void addRevision(Revision revision) {
		this.revisions.add(revision);
	}

	/**
	 * @see java.lang.Comparable#compareTo(java.lang.Object)
	 */
	public int compareTo(Answer o) {
		if (id == null) {
			return -1;
		} else if (o.getId() == null) {
			return 1;
		} else {
		    return this.id.compareTo((Long) o.getId());
		}
	}
}
