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
package org.telscenter.sail.webapp.dao.brainstorm;

import java.util.Set;

import org.telscenter.sail.webapp.domain.Run;
import org.telscenter.sail.webapp.domain.brainstorm.Brainstorm;
import org.telscenter.sail.webapp.domain.brainstorm.answer.Answer;
import org.telscenter.sail.webapp.domain.project.Project;

import net.sf.sail.webapp.dao.SimpleDao;

/**
 * Dao for Brainstorms
 * 
 * @author Hiroki Terashima
 * @version $Id$
 */
public interface BrainstormDao<T extends Brainstorm> extends SimpleDao<T> {

	/**
	 * Looks up Brainstorm that contains the specified
	 *     Answer.
	 * 
	 * @param answer
	 * @return
	 */
	public Brainstorm retrieveByAnswer(Answer answer);
	
	/**
	 * Looks up Brainstorms that are used in the 
	 * specified <code>Run</code>
	 *     
	 * @param run
	 * @return
	 */
	public Set<Brainstorm> retrieveByRun(Run run);
	
	/**
	 * Looks up Brainstorms that are used in the 
	 * specified <code>Run</code>
	 *     
	 * @param run
	 * @return
	 */
	public Brainstorm retrieveByRunIdAndParentId(Long runId, Long parentBrainstormId);
	
	/**
	 * Looks up Brainstorms that are used by the specified
	 * project and is not being used in a run.
	 *     
	 * @param run
	 * @return
	 */
	public Set<Brainstorm> retrieveByProjectAndParentId(Project project, Long parentBrainstormId);
	
	/**
	 * Retrieves Answers that are associated with a Brainstorm with the given id
	 * 
	 * @param <code>Long</code> id
	 * @return <code>Set<Answer></code>
	 */
	public Set<Answer> getAnswersByBrainstormId(Long id);
}
