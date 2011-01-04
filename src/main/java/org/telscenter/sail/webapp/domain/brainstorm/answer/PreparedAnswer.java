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

import net.sf.sail.webapp.domain.Persistable;

/**
 * An author of the brainstorm can prepare canned responses. These
 * responses will be added to the brainstorm as Answers when the
 * brainstorm is set up for a run. This is so that when a student is first 
 * to post, he/she will be able to see these responses as opposed to nothing.
 * These will actually be posted by the teacher of the run, but the name
 * under which it will be posted can be set by the author of the brainstorm.
 * 
 * PreparedAnswers themselves cannot be added
 * 
 * @author hirokiterashima
 * @version $Id:$
 */
public interface PreparedAnswer extends Persistable, Comparable<PreparedAnswer> {
	
	/**
	 * Sets the name that this answer will be posted as.
	 * @return name
	 */
	public String getDisplayname();
	
	/**
	 * Sets the name that this answer will be posted as.
	 * @param name
	 */
	public void setDisplayname(String displayname);
	
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
}
