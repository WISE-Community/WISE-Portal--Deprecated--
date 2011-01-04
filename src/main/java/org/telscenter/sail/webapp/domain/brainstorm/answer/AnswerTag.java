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

import org.telscenter.sail.webapp.domain.brainstorm.answer.impl.AnswerTagType;
import org.telscenter.sail.webapp.domain.workgroup.WISEWorkgroup;

/**
 * Tag for tagging Q&A Answers. A tag can be made by teacher workgroups
 * or student workgroups. There are different types of Tags that can be
 * made on Answers. These include:
 * - AnswerTagType.NUTURAL  = for tagging answers with no weight
 * - AnswerTagType.POSITIVE = for tagging answers as something positive
 * - AnswerTagType.NEGATIVE = for tagging answers as something negative
 * 
 * AnswerTag must have an owner workgroup
 * 
 * AnswerTag can have an explanation, or it can be null.
 * 
 * @author hirokiterashima
 * @version $Id:$
 */
public interface AnswerTag extends Persistable, Comparable<AnswerTag> {
	
	/**
	 * Sets the AnswerTagType.
	 * 
	 * @param answerTagType
	 */
	public void setAnswerTagType(AnswerTagType answerTagType);

	/**
	 * Returns the AnswerTagType.
	 * 
	 * @return
	 */
	public AnswerTagType getAnswerTagType();

	/**
	 * Sets the owner workgroup of this AnswerTag.
	 * @param ownerWorkgroup
	 */
	public void setOwnerWorkgroup(WISEWorkgroup ownerWorkgroup);
	
	/**
	 * Gets the owner workgroup of this AnswerTag.
	 * @return
	 */
	public WISEWorkgroup getOwnerWorkgroup();
	
	/**
	 * Sets the explanation for this AnswerTag.
	 * @param explanation
	 */
	public void setExplanation(String explanation);
	
	/**
	 * Returns the explanation associated with this AnswerTag.
	 * Can be null if the owner did not specify any explanation.
	 * @return
	 */
	public String getExplanation();
	
	/**
	 * Indicates if this AnswerTag was written by a teacher.
	 * 
	 * @return true iff this AnswerTag was tagged by a teacher.
	 */
	public boolean isTeacherAnswerTag();
}
