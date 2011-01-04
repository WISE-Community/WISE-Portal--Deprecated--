/**
 * Copyright (c) 2007 Regents of the University of California (Regents). Created
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
package org.telscenter.sail.webapp.presentation.web.controllers.teacher.management;

import javax.servlet.http.HttpSession;

import org.junit.After;
import org.junit.Before;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.test.web.AbstractModelAndViewTests;
import org.springframework.web.servlet.ModelAndView;
import org.telscenter.sail.webapp.domain.Run;
import org.telscenter.sail.webapp.domain.impl.RunImpl;
import org.telscenter.sail.webapp.service.offering.RunService;
import org.easymock.EasyMock;

/**
 * @author patricklawler
 * @version $Id:$
 */
public class ManageExtraTeachersControllerTest extends AbstractModelAndViewTests {

	private MockHttpServletRequest request;

	private MockHttpServletResponse response;
	
	private ManageExtraTeachersController manageExtraTeachersController;
	
	private Run returnedRun;
	
	private RunService mockRunService;
	
	
	/**
	 * @see junit.framework.TestCase#setUp()
	 */
	@Before
	public void setUp(){
		this.request = new MockHttpServletRequest();
		this.response = new MockHttpServletResponse();
		HttpSession mockSession = new MockHttpSession();
		this.request.setSession(mockSession);
		
		this.mockRunService=EasyMock.createMock(RunService.class);
		manageExtraTeachersController = new ManageExtraTeachersController();
		manageExtraTeachersController.setRunService(mockRunService);
	}
	
	/**
	 * @see junit.framework.TestCase#tearDown()
	 */
	@After
	public void tearDown(){
		mockRunService = null;
		manageExtraTeachersController = null;
		request = null;
		response = null;
	}
	
	public void testHandleRequestInternal() throws Exception{
		returnedRun = new RunImpl();
		String id = "1";
		request.setParameter("runId", id);
		
		EasyMock.expect(this.mockRunService.retrieveById(Long.parseLong(id))).andReturn(returnedRun);
		EasyMock.replay(this.mockRunService);
		
		ModelAndView mav = manageExtraTeachersController.handleRequestInternal(request, response);
		
		assertEquals(manageExtraTeachersController.RUN, "run");
		
		EasyMock.verify(this.mockRunService);
	}
	
}
