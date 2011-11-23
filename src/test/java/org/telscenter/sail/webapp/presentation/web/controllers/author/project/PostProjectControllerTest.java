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
package org.telscenter.sail.webapp.presentation.web.controllers.author.project;

import static org.easymock.EasyMock.*;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import net.sf.sail.webapp.dao.ObjectNotFoundException;

import org.apache.commons.httpclient.HttpStatus;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.internal.runners.TestClassRunner;
import org.junit.runner.RunWith;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.test.web.AbstractModelAndViewTests;
import org.telscenter.sail.webapp.domain.impl.OtmlModuleImpl;
import org.telscenter.sail.webapp.domain.project.Project;
import org.telscenter.sail.webapp.domain.project.impl.ProjectImpl;
import org.telscenter.sail.webapp.service.module.ModuleService;
import org.telscenter.sail.webapp.service.project.ProjectService;

/**
 * @author hirokiterashima
 * @version $Id:$
 */
@RunWith(TestClassRunner.class)
public class PostProjectControllerTest extends AbstractModelAndViewTests {
	
	private static final String DEFAULT_PROJECT_ID = "5";

	private static final String DEFAULT_OTML_CONTENT = "<otml><project></project></otml>";

	private static String ENCODED_DEFAULT_OTML_CONTENT = "";
	
	static {
		try {
			ENCODED_DEFAULT_OTML_CONTENT = URLEncoder.encode(DEFAULT_OTML_CONTENT, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}

	private PostProjectController controller;
	
	private MockHttpServletRequest request;
	
	private MockHttpServletResponse response;

	private ProjectService projectService;

	private ModuleService moduleService;
	
	private Project defaultProject;
	
	@Before
	public void runBeforeEveryTest() {
		controller = new PostProjectController();
		request = new MockHttpServletRequest();
		request.setParameter(PostProjectController.PROJECT_ID_PARAM, DEFAULT_PROJECT_ID);
		request.setParameter(PostProjectController.OTML_CONTENT_PARAM, ENCODED_DEFAULT_OTML_CONTENT);
		response = new MockHttpServletResponse();
		projectService = createMock(ProjectService.class);
		controller.setProjectService(projectService);
		moduleService = createMock(ModuleService.class);
		controller.setModuleService(moduleService);
		defaultProject = new ProjectImpl();
		defaultProject.setCurnit(new OtmlModuleImpl());
	}
	
	@After
	public void runAfterEveryTest() {
		controller = null;
		request = null;
		response = null;
		projectService = null;
		moduleService = null;
		defaultProject = null;
	}
	
	@Test
	public void postPOTrunkProject_success() throws ObjectNotFoundException {
		try {
		expect(projectService.getById(DEFAULT_PROJECT_ID)).andReturn(defaultProject);
		OtmlModuleImpl curnit = (OtmlModuleImpl) defaultProject.getCurnit();
		curnit.setOtml(DEFAULT_OTML_CONTENT.getBytes());
		moduleService.updateCurnit(curnit);
		expectLastCall();
		projectService.updateProject(defaultProject,null);
		expectLastCall();
		replay(projectService);
		replay(moduleService);
			controller.handleRequestInternal(request, response);
		} catch (Exception e) {
			fail("exception thrown but was not expected");
		}
		assertEquals(response.getStatus(), HttpStatus.SC_OK);
		verify(projectService);
		verify(moduleService);
	}
	
	@Test
	public void postPOTrunkProject_failure_empty_projectId() throws ObjectNotFoundException {
		request.setParameter(PostProjectController.PROJECT_ID_PARAM, "");
		expect(projectService.getById("")).andThrow(new NullPointerException());
		replay(projectService);
		replay(moduleService);
		try {
			controller.handleRequestInternal(request, response);
			fail("exception expected but was not thrown.");			
		} catch (Exception e) {
		}
		assertEquals(response.getStatus(), HttpStatus.SC_BAD_REQUEST);
		verify(projectService);
		verify(moduleService);
	}

	@Test
	public void postPOTrunkProject_failure_null_otmlcontent() throws ObjectNotFoundException {
		request.removeParameter(PostProjectController.OTML_CONTENT_PARAM);
		replay(projectService);
		replay(moduleService);
		try {
			controller.handleRequestInternal(request, response);
			fail("exception expected but was not thrown.");			
		} catch (Exception e) {
		}
		assertEquals(response.getStatus(), HttpStatus.SC_BAD_REQUEST);
		verify(projectService);
		verify(moduleService);

	}

}
