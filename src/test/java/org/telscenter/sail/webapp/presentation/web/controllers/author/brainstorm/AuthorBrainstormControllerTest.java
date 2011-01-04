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
package org.telscenter.sail.webapp.presentation.web.controllers.author.brainstorm;

import static org.easymock.EasyMock.*;

import java.io.Serializable;

import javax.servlet.http.HttpServletResponse;

import net.sf.sail.webapp.dao.ObjectNotFoundException;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.internal.runners.TestClassRunner;
import org.junit.runner.RunWith;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.test.web.AbstractModelAndViewTests;
import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;
import org.telscenter.sail.webapp.domain.brainstorm.Brainstorm;
import org.telscenter.sail.webapp.domain.brainstorm.impl.BrainstormImpl;
import org.telscenter.sail.webapp.service.brainstorm.BrainstormService;

/**
 * @author hirokiterashima
 * @version $Id$
 */
@RunWith(TestClassRunner.class)
public class AuthorBrainstormControllerTest extends AbstractModelAndViewTests {

	private AuthorBrainstormController controller;
	
	private static final String SCHEME = "http";
	
	private static final String SERVERNAME = "123.456.789.012";

	private static final int SERVERPORT = 8080;
	
	private static final String CONTEXTPATH = "/webapp";

	private static final Serializable NONEXISTING_BRAINSTORMID = 5;

	private static final Object EXISTING_BRAINSTORMID = 1;

	private MockHttpServletRequest request;
	
	private MockHttpServletResponse response;

	private BindException errors;

	private BrainstormService brainstormService;
	
	private Brainstorm brainstorm;

	@Before
	public void runBeforeEveryTest() {
		controller = new AuthorBrainstormController();
		request = new MockHttpServletRequest();
		request.setScheme(SCHEME);
		request.setServerName(SERVERNAME);
		request.setServerPort(SERVERPORT);
		request.setContextPath(CONTEXTPATH);
		response = new MockHttpServletResponse();
		brainstormService = createMock(BrainstormService.class);
		controller.setBrainstormService(brainstormService);
		brainstorm = new BrainstormImpl();
		errors = new BindException(brainstorm, "");
	}
	
	@After
	public void runAfterEveryTest() {
		controller = null;
		request = null;
		response = null;
	}
	
	@Test
	public void showFormNoBrainstormId() throws ObjectNotFoundException {
		expect(brainstormService.getBrainstormById(null))
		    .andThrow(new NullPointerException());
		replay(brainstormService);
		try {
			controller.showForm(request, response, errors);
			fail("exception expected but was not thrown.");
		} catch (Exception npe) {
		}
		verify(brainstormService);
	}
	
	@Test
	public void showFormBadBrainstormId() throws ObjectNotFoundException {
		expect(brainstormService.getBrainstormById(NONEXISTING_BRAINSTORMID.toString()))
	       .andThrow(new ObjectNotFoundException(NONEXISTING_BRAINSTORMID, 
	    		Brainstorm.class));
		replay(brainstormService);
		request.setParameter(AuthorBrainstormController.BRAINSTORMID_PARAM, 
				NONEXISTING_BRAINSTORMID.toString());
		try {
			controller.showForm(request, response, errors);
			fail("objectnotfoundexception expected but was not thrown.");
		} catch (ObjectNotFoundException onfe) {
		} catch (Exception e) {
			fail("unexpected exception thrown.");
			e.printStackTrace();
		}
		assertEquals(HttpServletResponse.SC_BAD_REQUEST, response.getStatus());
		verify(brainstormService);
	}
	
	@Test
	public void showForm() throws ObjectNotFoundException {
		expect(brainstormService.getBrainstormById(EXISTING_BRAINSTORMID.toString()))
	       .andReturn(brainstorm);
		replay(brainstormService);
		request.setParameter(AuthorBrainstormController.BRAINSTORMID_PARAM, 
				EXISTING_BRAINSTORMID.toString());
		ModelAndView mav = null;
		try {
			mav = controller.showForm(request, response, errors);
		} catch (Exception e) {
			fail("unexpected exception thrown.");
			e.printStackTrace();
		}
		assertEquals(HttpServletResponse.SC_OK, response.getStatus());
		assertModelAttributeValue(mav,
				AuthorBrainstormController.BRAINSTORM_PARAM, brainstorm);
		verify(brainstormService);	
	}
	
	@Test
	public void onSubmit() {
		brainstormService.createBrainstorm(brainstorm);
		expectLastCall();
		replay(brainstormService);
		ModelAndView mav = null;
		try {
			mav = controller.onSubmit(request, response, brainstorm, errors);
		} catch (Exception e) {
			fail("unexpected exception thrown");
		}
		verify(brainstormService);	
	}

}
