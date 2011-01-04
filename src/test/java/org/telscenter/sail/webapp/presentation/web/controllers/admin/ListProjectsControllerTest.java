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
package org.telscenter.sail.webapp.presentation.web.controllers.admin;

import static org.easymock.EasyMock.createMock;
import static org.easymock.EasyMock.expect;
import static org.easymock.EasyMock.replay;

import java.util.ArrayList;
import java.util.List;

import org.easymock.EasyMock;
import org.junit.After;
import org.junit.Before;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.test.web.AbstractModelAndViewTests;
import org.springframework.web.servlet.ModelAndView;
import org.telscenter.sail.webapp.domain.project.Project;
import org.telscenter.sail.webapp.domain.project.impl.ProjectImpl;
import org.telscenter.sail.webapp.service.project.ProjectService;

/**
 * @author patrick lawler
 *
 */
public class ListProjectsControllerTest extends AbstractModelAndViewTests{

	private MockHttpServletRequest request;

	private MockHttpServletResponse response;
	
	private ListProjectsController controller;
	
	private ProjectService projectService;
	
	private ArrayList<Project> projects;
	
	private Project project;
	
	@Before
	public void setUp() {
		this.request = new MockHttpServletRequest();
		this.response = new MockHttpServletResponse();
		this.projectService = createMock(ProjectService.class);
		this.controller = new ListProjectsController();
		this.controller.setProjectService(this.projectService);
		this.projects = new ArrayList<Project>();
		this.project = new ProjectImpl();
	}
	
	@After
	public void tearDown() {
		this.request = null;
		this.response = null;
		this.projectService = null;
		this.controller = null;
		this.projects = null;
		this.project = null;
	}
	
	public void testHandleRequestInternalNoProjects() {
		expect(projectService.getProjectList()).andReturn(projects);
		replay(projectService);
		ModelAndView modelAndView = null; 
		try {
			modelAndView = controller.handleRequestInternal(request, response);
		} catch (Exception e) {
			fail("unexpected exception");
		}
		
		assertModelAttributeValue(modelAndView, 
				"projects", projects);
		EasyMock.verify(projectService);
	}
	
	@SuppressWarnings("unchecked")
	public void testHandleRequestInternalProjects() {
		projects.add(project);
		expect(projectService.getProjectList()).andReturn(projects);
		replay(projectService);
		ModelAndView modelAndView = null; 
		try {
			modelAndView = controller.handleRequestInternal(request, response);
		} catch (Exception e) {
			fail("unexpected exception");
		}
		
		assertModelAttributeValue(modelAndView, 
				"projects", projects);
		List<Project> returnedProjects = (List<Project>) modelAndView.getModel().get("projects");
		assertEquals(returnedProjects.size(), 1);
		assertEquals(returnedProjects.get(0), project);
		EasyMock.verify(projectService);
	}
}
