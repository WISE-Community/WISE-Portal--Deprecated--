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

import java.util.Date;

import net.sf.sail.webapp.domain.Persistable;

/**
 * A revision contains a timestamp and the actual body of the post.
 * 
 * @author Hiroki Terashima
 * @author Patrick Lawler
 * @version $Id$
 */
public interface Revision extends Persistable, Comparable<Revision> {

	/**
	 * Returns when this revision was authored.
	 * 
	 * @return <code>Date</code> timestamp indicating
	 *     when this revision was written.
	 */
	public Date getTimestamp();
	
	/**
	 * Sets when this revision was authored.
	 * 
	 * @param timestamp <code>Date</code> timestamp indicating
	 *     when this revision was written.
	 */
	public void setTimestamp(Date timestamp);
	
	/**
	 * Gets the actual body of this revision in string format.
	 * @return body of this revision
	 */
	public String getBody();
	
	/**
	 * Sets the body of this revision in string format.
	 * @param body
	 */
	public void setBody(String body);
	
	/**
	 * Returns the displayname of this revision. This is only
	 * applicable if this revision is for a <code>PreparedAnswer</code>
	 * 
	 * @return String displayname. Name to display this revision under.
	 */
	public String getDisplayname();

	/**
	 * Sets the displayname of this revision. This is only
	 * applicable if this revision is for a <code>PreparedAnswer</code>
	 * 
	 * @param String displayname. Name to display this revision under.
	 */
	public void setDisplayname(String displayname);

}
