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
package org.telscenter.sail.webapp.service.brainstorm;

import java.io.Serializable;
import java.util.Set;

import net.sf.sail.webapp.dao.ObjectNotFoundException;

import org.telscenter.sail.webapp.domain.Run;
import org.telscenter.sail.webapp.domain.brainstorm.Brainstorm;
import org.telscenter.sail.webapp.domain.brainstorm.answer.Answer;
import org.telscenter.sail.webapp.domain.brainstorm.answer.Revision;
import org.telscenter.sail.webapp.domain.brainstorm.comment.Comment;
import org.telscenter.sail.webapp.domain.project.Project;
import org.telscenter.sail.webapp.domain.workgroup.WISEWorkgroup;

/**
 * Service layer for <code>Brainstorm</code>
 * 
 * @author Hiroki Terashima
 * @version $Id$
 */
public interface BrainstormService {
	
	/**
	 * Saves the given <code>Brainstorm</code> in the datastore
	 * 
	 * @param brainstorm save this Brainstorm in the datastore
	 */
	public void createBrainstorm(Brainstorm brainstorm);
	
	/**
	 * Returns a set of Brainstorms that are used in the run
	 * 
	 * @param run
	 * @return
	 */
	public Set<Brainstorm> getBrainstormsByRun(Run run);
	
	/**
	 * Returns a set of Brainstorms that are used in the project
	 * 
	 * @param run
	 * @return
	 */
	public Set<Brainstorm> getParentBrainstormsForProject(Project project);

	/**
	 * Returns a <code>Brainstorm</code> with the specified runId
	 * and parentBrainstormId.
	 * 
	 * @param runId Id of run that the brainstorm is in.
	 * @param parentBrainstormId Id of this brainstorm's parent
	 * brainstorm.
	 * 
	 * @return Brainstorm with the specified attributes
	 */
	public Brainstorm getBrainstorm(Long runId, Long parentBrainstormId);
	
	/**
	 * Retrieves a <code>Brainstorm</code> with the specified id.
	 * 
	 * @param id
	 * @return
	 * @throws ObjectNotFoundException when id does not return match.
	 */
	public Brainstorm getBrainstormById(Serializable id) throws ObjectNotFoundException;
	
	/**
	 * Saves an answer to this Brainstorm.
	 * 
	 * @param brainstorm which <code>Brainstorm</code to add the
	 *     <code>Answer</code> to.
	 * @param answer The <code>Answer</code> to add.
	 */
	public void addAnswer(Brainstorm brainstorm, Answer answer);
	
	/**
	 * Adds a revision to the specified Brainstorm and Answer.
	 * 
	 * @param brainstorm
	 * @param answer
	 * @param revision
	 */
	public void addRevision(Answer answer, Revision revision);
	
	/**
	 * For specified brainstorm and the specified answer, add a comment.
	 * 
	 * @param brainstorm
	 * @param answer
	 * @param comment
	 */
	public void addComments(Answer answer, Comment comment);
	
	/**
	 * Indicates that the specified workgroup needs help with the specified
	 * Brainstorm.
	 * 
	 * @param brainstorm
	 * @param workgroup
	 */
	public void requestHelp(Brainstorm brainstorm, WISEWorkgroup workgroup);

	/**
	 * Indicates that the specified workgroup no longer 
	 * needs help with the specified Brainstorm.
	 * 
	 * @param brainstorm
	 * @param workgroup
	 */
	public void unrequestHelp(Brainstorm brainstorm, WISEWorkgroup workgroup);

	/**
	 * Indicates that the workgroup found the answer helpful.
	 * 
	 * @param answer
	 * @param workgroup
	 */
	public void markAsHelpful(Answer answer, WISEWorkgroup workgroup);

	/**
	 * Indicates that the workgroup no longer finds 
	 * the answer helpful.
	 * 
	 * @param answer
	 * @param workgroup
	 */
	public void unmarkAsHelpful(Answer answer, WISEWorkgroup workgroup);

	/**
	 * The specified workgroup adds a tag to the specified
	 * answer
	 * 
	 * @param answer
	 * @param workgroup
	 */
	public void tag(Answer answer, WISEWorkgroup workgroup);

	/**
	 * Removes a tag made by the specified workgroup on the
	 * specified answer
	 * 
	 * @param answer
	 * @param workgroup
	 */
	public void untag(Answer answer, WISEWorkgroup workgroup);

	/**
	 * Creates and adds a PreparedAnswer to the specified brainstorm.
	 * 
	 * @param brainstorm
	 * @return Long id of the created preparedAnswer
	 */
	public Long addPreparedAnswer(Brainstorm brainstorm);
	
	/**
	 * Creates and adds a PreparedAnswer to the specified brainstorm.
	 * 
	 * @param brainstorm
	 */
	public void deletePreparedAnswer(Brainstorm brainstorm, Long preparedAnswerId);
	
	/**
	 * Looks up the Brainstorm that the answer is for.
	 * 
	 * @param answer <code>Answer</code> want to find which Brainstorm
	 *     this answer is in.
	 * @return <code>Brainstorm</code> that has this answer.
	 */
	public Brainstorm getBrainstormByAnswer(Answer answer);
	
	/**
	 * Returns the Answer with the provided Id
	 * 
	 * @param id <code>Long</code> of the answer to retrieve
	 * @return <code>Answer</code>
	 * @throws Exception when no answer with provided Id is found
	 */
	public Answer getAnswer(Long id) throws Exception;
	
	/**
	 * Returns a <code>Set<Answer></code> that are associated with the
	 * given <code>Long</code> id for a brainstorm.
	 * 
	 * @param <code>Long</code> id
	 * @return <code>Set<Answer></code>
	 * @throws Exception when no brainstorm with provided id exists
	 */
	public Set<Answer> getAnswersByBrainstormId(Long id) throws Exception;
}
