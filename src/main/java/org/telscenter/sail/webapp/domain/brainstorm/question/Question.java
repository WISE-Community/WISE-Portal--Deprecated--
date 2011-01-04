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
package org.telscenter.sail.webapp.domain.brainstorm.question;

import java.math.BigInteger;
import java.util.List;

import org.imsglobal.xsd.imsqti_v2p0.SimpleChoiceType;

import net.sf.sail.webapp.domain.Persistable;

/**
 * Brainstorm Question interface.  The question can be of different types, 
 * such as multiple-choice, short-answer, coding.
 * 
 * @author Hiroki Terashima
 * @version $Id$
 */
public interface Question extends Persistable {

	/**
	 * Gets the question prompt, which is the part that will be shown to
	 * the students.
	 * 
	 * @return
	 */
	public String getPrompt();
	
	/**
	 * Gets the number of lines long the answer Field
	 * 
	 * @return
	 */
	public BigInteger getAnswerFieldExpectedLines();
	
	/**
	 * The entire question body string. This might include xml tags.
	 * 
	 * @return
	 */
	public String getBody();
	
	/**
	 * 
	 * @param body
	 */
	public void setBody(String body);
	
	/**
	 * Instantiates a copy of thie Question.
	 * 
	 * @return
	 */
	public Question getCopy();
		
	/**
	 * Gets a <code>List<SimpleChoiceType></code> for this question
	 * 
	 * @return <code>List<SimpleChoiceType></code> choices
	 */
	public List<SimpleChoiceType> getChoices();
	
	/**
	 * Gets the <code>String</code> correct choice for this question
	 * @return <code>String</code>
	 */
	public String getCorrectChoice();
	
	/**
	 * Gets the <code>String</code> new choices for this question
	 * @return <code>String</code>
	 */
	public String getNewChoices();
}
