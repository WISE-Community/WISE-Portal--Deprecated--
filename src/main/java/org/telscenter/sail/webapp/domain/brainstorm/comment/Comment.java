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
package org.telscenter.sail.webapp.domain.brainstorm.comment;

import java.util.Date;

import org.telscenter.sail.webapp.domain.workgroup.WISEWorkgroup;

import net.sf.sail.webapp.domain.Persistable;

/**
 * A Comment is a second-level response to an <code>Answer</code>.
 * A comment does not have any children
 *
 * @author Hiroki Terashima
 * @version $Id$
 */
public interface Comment extends Persistable, Comparable<Comment> {

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
	 * Returns when this comment was authored.
	 * 
	 * @return <code>Date</code> timestamp indicating
	 *     when this comment was written.
	 */
	public Date getTimestamp();
	
	/**
	 * Sets when this comment was authored.
	 * 
	 * @return <code>Date</code> timestamp indicating
	 *     when this comment was written.
	 */
	public void setTimestamp(Date timestamp);
	
	/**
	 * Gets the actual body of this revision in string format.
	 * 
	 * @return the body of this comment as a String.
	 */
	public String getBody();
	
	/**
	 * Gets the actual body of this revision in string format.
	 * 
	 * @return the body of this comment as a String.
	 */
	public void setBody(String body);

	/**
	 * Indicates whether this comment should be posted
	 * as anonymous.
	 * 
	 * @return true iff this post should be posted as
	 *     comment.
	 */
	public boolean isAnonymous();
	
	/**
	 * Indicates whether this comment should be posted
	 * as anonymous.
	 * 
	 * @param true iff this post should be posted as
	 *     comment.
	 */
	public void setAnonymous(boolean isAnonymous);
}
