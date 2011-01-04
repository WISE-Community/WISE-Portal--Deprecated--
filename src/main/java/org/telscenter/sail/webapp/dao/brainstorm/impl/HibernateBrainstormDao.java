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
package org.telscenter.sail.webapp.dao.brainstorm.impl;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import net.sf.sail.webapp.dao.impl.AbstractHibernateDao;

import org.springframework.dao.support.DataAccessUtils;
import org.telscenter.sail.webapp.dao.brainstorm.BrainstormDao;
import org.telscenter.sail.webapp.domain.Run;
import org.telscenter.sail.webapp.domain.brainstorm.Brainstorm;
import org.telscenter.sail.webapp.domain.brainstorm.answer.Answer;
import org.telscenter.sail.webapp.domain.brainstorm.impl.BrainstormImpl;
import org.telscenter.sail.webapp.domain.project.Project;

/**
 * @author Hiroki Terashima
 * @version $Id$
 */
public class HibernateBrainstormDao extends AbstractHibernateDao<Brainstorm> implements
		BrainstormDao<Brainstorm> {

	private static final String FIND_ALL_QUERY = "from BrainstormImpl";

	/**
	 * @see net.sf.sail.webapp.dao.impl.AbstractHibernateDao#getDataObjectClass()
	 */
	@Override
	protected Class<BrainstormImpl> getDataObjectClass() {
		return BrainstormImpl.class;
	}

	/**
	 * @see net.sf.sail.webapp.dao.impl.AbstractHibernateDao#getFindAllQuery()
	 */
	@Override
	protected String getFindAllQuery() {
		return FIND_ALL_QUERY;
	}

	/**
	 * @see org.telscenter.sail.webapp.dao.brainstorm.BrainstormDao#retrieveByAnswer(org.telscenter.sail.webapp.domain.brainstorm.answer.Answer)
	 */
	public Brainstorm retrieveByAnswer(Answer answer) {
		return (Brainstorm) this
		.getHibernateTemplate()
		.findByNamedParam(
				"from BrainstormImpl as brainstorm where brainstorm.answer = :answer",
				"answer", answer);
	}

	/**
	 * @see org.telscenter.sail.webapp.dao.brainstorm.BrainstormDao#retrieveByRun(org.telscenter.sail.webapp.domain.Run)
	 */
    @SuppressWarnings("unchecked")
	public Set<Brainstorm> retrieveByRun(Run run) {
		List<Brainstorm> listOfBrainstorms = this
        .getHibernateTemplate()
        .findByNamedParam(
                "from BrainstormImpl as brainstorm where brainstorm.run = :run",
                "run", run);
		Set<Brainstorm> setOfBrainstorms = new HashSet<Brainstorm>();
		setOfBrainstorms.addAll(listOfBrainstorms);
		return setOfBrainstorms;
	}

    /**
     * @see org.telscenter.sail.webapp.dao.brainstorm.BrainstormDao#retrieveByRunIdAndParentId(java.lang.Long, java.lang.Long)
     */
	public Brainstorm retrieveByRunIdAndParentId(Long runId,
			Long parentBrainstormId) {
		return (Brainstorm) DataAccessUtils
		    .uniqueResult(this
		    .getHibernateTemplate()
		    .findByNamedParam(
				"from BrainstormImpl as brainstorm where brainstorm.run.id = :runId " +
				"and brainstorm.parentBrainstormId = :parentBrainstormId", 
				new String[]{"runId", "parentBrainstormId"}, new Object[]{runId, parentBrainstormId}));
	}

	/**
	 * @see org.telscenter.sail.webapp.dao.brainstorm.BrainstormDao#retrieveByProjectAndParentId(org.telscenter.sail.webapp.domain.project.Project, java.lang.Long)
	 */
    @SuppressWarnings("unchecked")
	public Set<Brainstorm> retrieveByProjectAndParentId(Project project,
			Long parentBrainstormId) {
		List<Brainstorm> listOfBrainstorms = new ArrayList<Brainstorm>();
		if (parentBrainstormId == null) {
			listOfBrainstorms = this
			.getHibernateTemplate()
			.findByNamedParam(
					"from BrainstormImpl as brainstorm where brainstorm.project = :project " +
					"and brainstorm.parentBrainstormId is null",
					new String[]{"project"}, new Object[]{project});
		} else {
			listOfBrainstorms = this
			.getHibernateTemplate()
			.findByNamedParam(
					"from BrainstormImpl as brainstorm where brainstorm.project = :project " +
					"and brainstorm.parentBrainstormId = :parentBrainstormId",
					new String[]{"project", "parentBrainstormId"}, new Object[]{project, parentBrainstormId});
		}
		Set<Brainstorm> setOfBrainstorms = new HashSet<Brainstorm>();
		setOfBrainstorms.addAll(listOfBrainstorms);
		return setOfBrainstorms;	
	}

    public Set<Answer> getAnswersByBrainstormId(Long id){
    	String q = "select answer from BrainstormImpl brainstorm inner join brainstorm.answers answer" +
    		" where brainstorm.id='" + id + "'";
    	Set<Answer> answers = new TreeSet<Answer>(this.getHibernateTemplate().find(q));
    	return answers;
    }
}
