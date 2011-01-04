/**
 * Copyright (c) 2006 Encore Research Group, University of Toronto
 * 
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 */
package org.telscenter.sail.webapp.service.brainstorm.impl;

import static org.easymock.EasyMock.*;

import java.io.Serializable;

import junit.framework.TestCase;

import net.sf.sail.webapp.dao.ObjectNotFoundException;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.telscenter.sail.webapp.dao.brainstorm.BrainstormDao;
import org.telscenter.sail.webapp.domain.brainstorm.Brainstorm;
import org.telscenter.sail.webapp.domain.brainstorm.answer.Answer;
import org.telscenter.sail.webapp.domain.brainstorm.answer.impl.AnswerImpl;
import org.telscenter.sail.webapp.domain.brainstorm.impl.BrainstormImpl;
import org.telscenter.sail.webapp.domain.brainstorm.question.Question;
import org.telscenter.sail.webapp.domain.brainstorm.question.impl.JaxbQuestionImpl;

/**
 * Tests for brainstorm service.
 * 
 * @author Hiroki Terashima
 * @version $Id:$
 */
public class BrainstormServiceImplTest extends TestCase {

	private BrainstormServiceImpl  brainstormServiceImpl;
	
	private Answer answer;
	
	private Question question;
	
	private Brainstorm brainstorm;
	
	private BrainstormDao<Brainstorm> mockBrainstormDao;  // mock this
	
	private static final Serializable EXISTING_BRAINSTORM_ID = 1;

	private static final Serializable NONEXISTING_BRAINSTORM_ID = 123456;
	
	@SuppressWarnings("unchecked")
	@Before
	public void setUp() {
		brainstormServiceImpl = new BrainstormServiceImpl();
		brainstorm = new BrainstormImpl();
		answer = new AnswerImpl();
		question = new JaxbQuestionImpl();
		brainstorm.setQuestion(question);
		mockBrainstormDao = createMock(BrainstormDao.class);
	}
	
	@After
	public void tearDown() {
		brainstormServiceImpl = null;
		answer = null;
	}
	
	
	@Test
	public void testAddAnswer() {
		// this test simply confirms that the dao is called appropriately,
		// since the DAO is being tested and does all the work
		mockBrainstormDao.save(brainstorm);
		expectLastCall();
		replay(mockBrainstormDao);

		brainstormServiceImpl.setBrainstormDao(mockBrainstormDao);
		brainstormServiceImpl.addAnswer(brainstorm, answer);
		assertEquals(1, brainstorm.getAnswers().size());
		assertTrue(brainstorm.getAnswers().contains(answer));
		verify(mockBrainstormDao);
	}
	
	@Test
	@SuppressWarnings("unchecked")
	public void testGetBrainstormById_NoException() throws ObjectNotFoundException {
		// this test simply confirms that the dao is called appropriately,
		// since the DAO is being tested and does all the work
		expect(mockBrainstormDao.getById(EXISTING_BRAINSTORM_ID)).andReturn(brainstorm);
		replay(mockBrainstormDao);

		brainstormServiceImpl.setBrainstormDao(mockBrainstormDao);
		Brainstorm retrievedBrainstorm = null;
		try {
			retrievedBrainstorm = brainstormServiceImpl.getBrainstormById(EXISTING_BRAINSTORM_ID);
		} catch (ObjectNotFoundException e) {
			fail("unexpected exception thrown");
		}
		assertEquals(brainstorm, retrievedBrainstorm);
		assertNotNull(retrievedBrainstorm.getAnswers());
		assertEquals(0, retrievedBrainstorm.getAnswers().size());
		assertNotNull(retrievedBrainstorm.getQuestion());
		assertEquals(question, retrievedBrainstorm.getQuestion());
		verify(mockBrainstormDao);
	}
	
	@Test
	@SuppressWarnings("unchecked")
	public void testGetBrainstormById_BraistormDNE() throws ObjectNotFoundException {
		// this test simply confirms that the dao is called appropriately,
		// since the DAO is being tested and does all the work
		// tests when brainstorm cannot be found using this id.
		expect(mockBrainstormDao.getById(NONEXISTING_BRAINSTORM_ID)).andThrow(new ObjectNotFoundException(NONEXISTING_BRAINSTORM_ID, Brainstorm.class));
		replay(mockBrainstormDao);

		brainstormServiceImpl.setBrainstormDao(mockBrainstormDao);
		Brainstorm retrievedBrainstorm = null;
		try {
			retrievedBrainstorm = brainstormServiceImpl.getBrainstormById(NONEXISTING_BRAINSTORM_ID);
			fail("exception expected, but was not thrown");
		} catch (ObjectNotFoundException e) {
		}
		assertNull(retrievedBrainstorm);
		verify(mockBrainstormDao);
	}
	
	@Test
	public void testGetBrainstormByAnswer() {
		brainstorm.addAnswer(answer);
		expect(mockBrainstormDao.retrieveByAnswer(answer)).andReturn(brainstorm);
		replay(mockBrainstormDao);
		brainstormServiceImpl.setBrainstormDao(mockBrainstormDao);
		Brainstorm retrievedBrainstorm = brainstormServiceImpl.getBrainstormByAnswer(answer);
		assertEquals(brainstorm, retrievedBrainstorm);
		assertTrue(retrievedBrainstorm.getAnswers().contains(answer));
		verify(mockBrainstormDao);
	}
	
	@Test
	public void testCreateBrainstorm() {
		// TODO HIROKI: implement me
		assertTrue(true);
	}
	
	
}
