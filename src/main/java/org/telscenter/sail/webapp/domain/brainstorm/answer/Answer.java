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
package org.telscenter.sail.webapp.domain.brainstorm.answer;

import java.util.Set;

import org.telscenter.sail.webapp.domain.brainstorm.comment.Comment;
import org.telscenter.sail.webapp.domain.workgroup.WISEWorkgroup;

import net.sf.sail.webapp.domain.Persistable;
import net.sf.sail.webapp.domain.group.Group;

/**
 * An answer is a first-level post to a Brainstorm question.
 * 
 * @author Hiroki Terashima
 * @version $Id$
 */
public interface Answer extends Persistable, Comparable<Answer> {
	
	/**
	 * Gets all the revisions in this Answer.
	 * @return
	 */
	public Set<Revision> getRevisions();
	
	/**
	 * Returns the Group that this answer was posted to, and
	 * members in the group can see this answer
	 * 
	 * @return <code>Group</code> which group can see this
	 *    answer
	 */
	public Group getGroup();
	
	/**
	 * Sets the Group that this answer was posted to, and
	 * members in the group can see this answer
	 * 
	 * @param <code>Group</code> which group can see this
	 *    answer
	 */
	public void setGroup(Group group);
	
	/**
	 * Get the <code>WISEWorkgroup</code> that authored
	 *   this answer
	 * @return <code>WISEWorkgroup</code>
	 */
	public WISEWorkgroup getWorkgroup();
	
	/**
	 * Set the <code>WISEWorkgroup</code> that authored
	 *   this answer
	 * @param <code>WISEWorkgroup</code>
	 */
	public void setWorkgroup(WISEWorkgroup workgroup);
	
	/**
	 * Get all the comments for this answer.
	 * 
	 * @return Set of Comments
	 */
	public Set<Comment> getComments();
	
	/**
	 * Adds a comment to this answer.
	 * 
	 * @param <code>Comment</code> to add.
	 */
	public void addComment(Comment comment);
	
	/**
	 * Adds a revision to this answer.
	 * 
	 * @param revision
	 */
	public void addRevision(Revision revision);
	

	/**
	 * Indicates whether this answer should be posted
	 * as anonymous.  Indicating as true will mean that all of the
	 * revisions that the author of this answer has done will also
	 * be posted as anonymous. This flag does not affect the anonimity
	 * of the comments.
	 * 
	 * @return true iff this post should be posted as
	 *     anonymous.
	 */
	public boolean isAnonymous();
	
	/**
	 * Indicates whether this answer should be posted
	 * as anonymous.  Indicating as true will mean that all of the
	 * revisions that the author of this answer has done will also
	 * be posted as anonymous. This flag does not affect the anonimity
	 * of the comments.
	 * 
	 * @param true iff this post should be posted as
	 *     anonymous.
	 */
	public void setAnonymous(boolean isAnonymous);
	
	/**
	 * Saves a workgroup that found this Answer to be helpful. If this
	 * workgroup has already indicated this before, nothing will happen.
	 * 
	 * @param <code>Workgroup</code> that found this answer
	 * helpful.
	 */
	public void markAsHelpful(WISEWorkgroup workgroup);
	
	/**
	 * Returns a <code>Set</code> of Workgroups that found this answer
	 * helpful.
	 * 
	 * @return <code>Set</code> of Workgroups that found this answer
	 * helpful.
	 */
	public Set<WISEWorkgroup> getWorkgroupsThatFoundAnswerHelpful();
	
	/**
	 * Returns all of the AnserTags that are on this
	 * Answer.
	 * 
	 * @return
	 */
	public Set<AnswerTag> getAnswerTags();
	
	/**
	 * Indicates that the specified workgroup no longer finds this
	 * Answer helpful.
	 * 
	 * @param workgroup
	 */
	public void unmarkAsHelpful(WISEWorkgroup workgroup);
	
	/**
	 * Returns whether the specified workgroup found this answer as
	 * helpful.
	 * 
	 * @param workgroup
	 * @return
	 */
	public boolean workgroupMarkedAnswerHelpful(WISEWorkgroup workgroup);
}
