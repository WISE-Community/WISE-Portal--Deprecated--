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
package org.telscenter.sail.webapp.service.brainstorm.impl;

import java.io.Serializable;
import java.util.Set;
import java.util.TreeSet;

import net.sf.sail.webapp.dao.ObjectNotFoundException;

import org.springframework.transaction.annotation.Transactional;
import org.telscenter.sail.webapp.dao.brainstorm.BrainstormDao;
import org.telscenter.sail.webapp.dao.brainstorm.answer.AnswerDao;
import org.telscenter.sail.webapp.domain.Run;
import org.telscenter.sail.webapp.domain.brainstorm.Brainstorm;
import org.telscenter.sail.webapp.domain.brainstorm.answer.Answer;
import org.telscenter.sail.webapp.domain.brainstorm.answer.AnswerTag;
import org.telscenter.sail.webapp.domain.brainstorm.answer.PreparedAnswer;
import org.telscenter.sail.webapp.domain.brainstorm.answer.Revision;
import org.telscenter.sail.webapp.domain.brainstorm.answer.impl.AnswerImpl;
import org.telscenter.sail.webapp.domain.brainstorm.answer.impl.AnswerTagImpl;
import org.telscenter.sail.webapp.domain.brainstorm.answer.impl.AnswerTagType;
import org.telscenter.sail.webapp.domain.brainstorm.answer.impl.PreparedAnswerImpl;
import org.telscenter.sail.webapp.domain.brainstorm.comment.Comment;
import org.telscenter.sail.webapp.domain.project.Project;
import org.telscenter.sail.webapp.domain.workgroup.WISEWorkgroup;
import org.telscenter.sail.webapp.service.brainstorm.BrainstormService;

/**
 * @author Hiroki Terashima
 * @version $Id$
 */
public class BrainstormServiceImpl implements BrainstormService {

	private BrainstormDao<Brainstorm> brainstormDao;
	
	private AnswerDao<Answer> answerDao;
	
	/**
	 * @see org.telscenter.sail.webapp.service.brainstorm.BrainstormService#createBrainstorm(org.telscenter.sail.webapp.domain.brainstorm.Brainstorm)
	 */
	@Transactional()
	public void createBrainstorm(Brainstorm brainstorm) {
		this.brainstormDao.save(brainstorm);
	}

	/**
	 * @see org.telscenter.sail.webapp.service.brainstorm.BrainstormService#addAnswer(org.telscenter.sail.webapp.domain.brainstorm.Brainstorm, org.telscenter.sail.webapp.domain.brainstorm.answer.Answer)
	 */
	@Transactional()
	public void addAnswer(Brainstorm brainstorm, Answer answer) {
		brainstorm.addAnswer(answer);
		this.brainstormDao.save(brainstorm);
	}

	/**
	 * @see org.telscenter.sail.webapp.service.brainstorm.BrainstormService#addComments(org.telscenter.sail.webapp.domain.brainstorm.answer.Answer, org.telscenter.sail.webapp.domain.brainstorm.comment.Comment)
	 */
	@Transactional()	
	public void addComments(Answer answer, Comment comment) {
		answer.addComment(comment);
		this.answerDao.save(answer);
	}

	/**
	 * @see org.telscenter.sail.webapp.service.brainstorm.BrainstormService#addRevision(org.telscenter.sail.webapp.domain.brainstorm.answer.Answer, org.telscenter.sail.webapp.domain.brainstorm.answer.Revision)
	 */
	@Transactional()	
	public void addRevision(Answer answer, Revision revision) {
		answer.addRevision(revision);
		this.answerDao.save(answer);
	}

	/**
	 * @throws ObjectNotFoundException 
	 * @see org.telscenter.sail.webapp.service.brainstorm.BrainstormService#getBrainstormById(java.io.Serializable)
	 */
	@Transactional(readOnly = true)
	public Brainstorm getBrainstormById(Serializable id) throws ObjectNotFoundException {
		return this.brainstormDao.getById(id);
	}

	/**
	 * @see org.telscenter.sail.webapp.service.brainstorm.BrainstormService#getBrainstorm(java.lang.Long, java.lang.Long)
	 */
	@Transactional(readOnly = true)
	public Brainstorm getBrainstorm(Long runId, Long parentBrainstormId) {
		return this.brainstormDao.retrieveByRunIdAndParentId(runId, parentBrainstormId);
	}


	/**
	 * @see org.telscenter.sail.webapp.service.brainstorm.BrainstormService#getBrainstormsByRun(org.telscenter.sail.webapp.domain.Run)
	 */
	@Transactional()
	public Set<Brainstorm> getBrainstormsByRun(Run run) {
		return this.brainstormDao.retrieveByRun(run);
	}

	/**
	 * Returns a set of Brainstorms that are used in the project. 
	 * requirements:
	 *    - brainstorm's project = specified project
	 *    - brainstorm's parentBrainstormId = null
	 * 
	 * @param run
	 * @return
	 */
	@Transactional(readOnly = true)
	public Set<Brainstorm> getParentBrainstormsForProject(Project project) {
		return this.brainstormDao.retrieveByProjectAndParentId(project, null);
	}
	
	/**
	 * @see org.telscenter.sail.webapp.service.brainstorm.BrainstormService#markAsHelpful(org.telscenter.sail.webapp.domain.brainstorm.answer.Answer, org.telscenter.sail.webapp.domain.workgroup.WISEWorkgroup)
	 */
	@Transactional()
	public void markAsHelpful(Answer answer, WISEWorkgroup workgroup) {
		answer.markAsHelpful(workgroup);
		this.answerDao.save(answer);
	}
	
	/**
	 * @see org.telscenter.sail.webapp.service.brainstorm.BrainstormService#markAsHelpful(org.telscenter.sail.webapp.domain.brainstorm.answer.Answer, org.telscenter.sail.webapp.domain.workgroup.WISEWorkgroup)
	 */
	@Transactional()
	public void unmarkAsHelpful(Answer answer, WISEWorkgroup workgroup) {
		answer.unmarkAsHelpful(workgroup);
		this.answerDao.save(answer);
	}
	
	/**
	 * @see org.telscenter.sail.webapp.service.brainstorm.BrainstormService#tag(org.telscenter.sail.webapp.domain.brainstorm.answer.Answer, org.telscenter.sail.webapp.domain.workgroup.WISEWorkgroup)
	 */
	@Transactional()
	public void tag(Answer answer, WISEWorkgroup workgroup) {
		AnswerTag answerTag = new AnswerTagImpl();
		answerTag.setAnswerTagType(AnswerTagType.NUTURAL);
		answerTag.setOwnerWorkgroup(workgroup);
		answer.getAnswerTags().add(answerTag);
		this.answerDao.save(answer);
	}

	/**
	 * @see org.telscenter.sail.webapp.service.brainstorm.BrainstormService#untag(org.telscenter.sail.webapp.domain.brainstorm.answer.Answer, org.telscenter.sail.webapp.domain.workgroup.WISEWorkgroup)
	 */
	@Transactional()
	public void untag(Answer answer, WISEWorkgroup workgroup) {
		Set<AnswerTag> answerTags = answer.getAnswerTags();
		for (AnswerTag answerTag : answerTags) {
			if (answerTag.getAnswerTagType().equals(AnswerTagType.NUTURAL)
					&& answerTag.getOwnerWorkgroup().equals(workgroup)) {
				answerTags.remove(answerTag);
			}
		}
		this.answerDao.save(answer);
	}

	/**
	 * @see org.telscenter.sail.webapp.service.brainstorm.BrainstormService#requestHelp(org.telscenter.sail.webapp.domain.brainstorm.Brainstorm, org.telscenter.sail.webapp.domain.workgroup.WISEWorkgroup)
	 */
	@Transactional()
	public void requestHelp(Brainstorm brainstorm, WISEWorkgroup workgroup) {
		brainstorm.addWorkgroupThatRequestHelp(workgroup);
		this.brainstormDao.save(brainstorm);
	}
	
	/**
	 * @see org.telscenter.sail.webapp.service.brainstorm.BrainstormService#requestHelp(org.telscenter.sail.webapp.domain.brainstorm.Brainstorm, org.telscenter.sail.webapp.domain.workgroup.WISEWorkgroup)
	 */
	@Transactional()
	public void unrequestHelp(Brainstorm brainstorm, WISEWorkgroup workgroup) {
		brainstorm.removeWorkgroupThatRequestHelp(workgroup);
		this.brainstormDao.save(brainstorm);
	}

	/**
	 * @see org.telscenter.sail.webapp.service.brainstorm.BrainstormService#addPreparedAnswer(org.telscenter.sail.webapp.domain.brainstorm.Brainstorm)
	 */
	@Transactional()
	public Long addPreparedAnswer(Brainstorm brainstorm) {
		PreparedAnswer newPA = new PreparedAnswerImpl();
		newPA.setBody("");
		newPA.setDisplayname("");
		brainstorm.getPreparedAnswers().add(newPA);
		this.brainstormDao.save(brainstorm);
		return (Long) newPA.getId();
	}

	/**
	 * Creates and adds a PreparedAnswer to the specified brainstorm.
	 * 
	 * @param brainstorm
	 */
	@Transactional()
	public void deletePreparedAnswer(Brainstorm brainstorm, Long preparedAnswerId) {
		Set<PreparedAnswer> preparedAnswers = brainstorm.getPreparedAnswers();
		for (PreparedAnswer preparedAnswer : preparedAnswers) {
			if (preparedAnswer.getId().equals(preparedAnswerId)) {
				brainstorm.getPreparedAnswers().remove(preparedAnswer);
				this.brainstormDao.save(brainstorm);
				break;
			}
		}
	}
	/**
	 * @see org.telscenter.sail.webapp.service.brainstorm.BrainstormService#getBrainstormByAnswer(org.telscenter.sail.webapp.domain.brainstorm.answer.Answer)
	 */
	@Transactional(readOnly = true)
	public Brainstorm getBrainstormByAnswer(Answer answer) {
		return this.brainstormDao.retrieveByAnswer(answer);
	}
	
	/**
	 * @param Long the id of the answer to be retrieved
	 */
	@Transactional(readOnly = true)
	public Answer getAnswer(Long id) throws Exception{
		return this.answerDao.getById(id);
	}
	
	/**
	 * @see org.telscenter.sail.webapp.service.brainstorm.BrainstormService#getAnswersByBrainstormId(java.lang.Long)
	 */
	public Set<Answer> getAnswersByBrainstormId(Long id) throws Exception{
		return this.brainstormDao.getAnswersByBrainstormId(id);
	}
	
	/**
	 * @param brainstormDao the brainstormDao to set
	 */
	public void setBrainstormDao(BrainstormDao<Brainstorm> brainstormDao) {
		this.brainstormDao = brainstormDao;
	}

	/**
	 * @param answerDao the answerDao to set
	 */
	public void setAnswerDao(AnswerDao<Answer> answerDao) {
		this.answerDao = answerDao;
	}
}
