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
package org.telscenter.sail.webapp.presentation.web.controllers.teacher.grading;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

import net.sf.sail.webapp.dao.ObjectNotFoundException;
import net.sf.sail.webapp.domain.Offering;
import net.sf.sail.webapp.domain.Workgroup;
import net.sf.sail.webapp.domain.group.Group;
import net.sf.sail.webapp.domain.group.impl.PersistentGroup;
import net.sf.sail.webapp.domain.impl.OfferingImpl;
import net.sf.sail.webapp.domain.impl.WorkgroupImpl;
import net.sf.sail.webapp.service.offering.OfferingService;

import static org.easymock.EasyMock.*;

import org.easymock.IExpectationSetters;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.test.web.AbstractModelAndViewTests;
import org.springframework.web.servlet.ModelAndView;
import org.telscenter.sail.webapp.domain.Run;
import org.telscenter.sail.webapp.domain.impl.RunImpl;
import org.telscenter.sail.webapp.domain.workgroup.WISEWorkgroup;
import org.telscenter.sail.webapp.domain.workgroup.impl.WISEWorkgroupImpl;

/**
 * @author Hiroki Terashima
 * @version $Id$
 */
public class SelectWorkgroupControllerTest extends AbstractModelAndViewTests {

	private SelectWorkgroupController selectWorkgroupController;
	
	private MockHttpServletRequest request;

	private MockHttpServletResponse response;

	private OfferingService offeringService;
	
	private Workgroup workgroup;
	
	private Group group;
	
	private Run run;
	
	/**
	 * @see junit.framework.TestCase#setUp()
	 */
	protected void setUp() throws Exception {
		super.setUp();
		this.request = new MockHttpServletRequest();
		this.request.setParameter("runId", "4");
		this.response = new MockHttpServletResponse();
		this.workgroup = new WISEWorkgroupImpl();
		this.group = new PersistentGroup();
		this.group.setName("group1");
		((WISEWorkgroup) this.workgroup).setPeriod(group);
		Set<Group> periods = new HashSet<Group>();
		periods.add(this.group);
		this.run = new RunImpl();
		this.run.setPeriods(periods);

		offeringService = createMock(OfferingService.class);
		selectWorkgroupController = new SelectWorkgroupController();
		selectWorkgroupController.setOfferingService(offeringService);
	}
	
	/**
	 * @see junit.framework.TestCase#tearDown()
	 */
	protected void tearDown() throws Exception {
		super.tearDown();
		this.request = null;
		this.response = null;
		this.offeringService = null;
		this.workgroup = null;
	}
	
	/**
	 * tests when there are no problems when this controller is
	 * invoked and when the offering has no workgroups created yet
	 * @throws ObjectNotFoundException 
	 */
	@SuppressWarnings("unchecked")
	public void testHandleRequestInternal_no_workgroups() throws ObjectNotFoundException {
		String runIdString = request.getParameter("runId");
		assertNotNull(runIdString);
		Long offeringId = new Long(runIdString);
		
		Set<Workgroup> expectedWorkgroups = new HashSet<Workgroup>();
		expect(offeringService.getWorkgroupsForOffering(offeringId)).andReturn(expectedWorkgroups);
		expect(offeringService.getOffering(offeringId)).andReturn(run);
		replay(offeringService);

		Map<Group,List<Workgroup>> expectedPeriodsToWorkgroups = 
			new TreeMap<Group, List<Workgroup>>();
		expectedPeriodsToWorkgroups.put(this.group, new ArrayList<Workgroup>());
		
		ModelAndView modelAndView = null;
		try {
			modelAndView = selectWorkgroupController.handleRequestInternal(request, response);
		} catch (Exception e) {
			fail("Unexpected exception was thrown");
		}
		assertNotNull(modelAndView);
		assertModelAttributeValue(modelAndView, 
				SelectWorkgroupController.RUN_ID_PARAM_NAME, offeringId);
		assertModelAttributeAvailable(modelAndView, SelectWorkgroupController.PERIODS_TO_WORKGROUPS_PARAM_NAME);
		assertModelAttributeValue(modelAndView, 
				SelectWorkgroupController.PERIODS_TO_WORKGROUPS_PARAM_NAME, expectedPeriodsToWorkgroups);
		verify(offeringService);
	}

	/**
	 * tests when there are no problems when this controller is
	 * invoked and when the offering has workgroups created for it
	 * @throws ObjectNotFoundException 
	 */
	@SuppressWarnings("unchecked")
	public void testHandleRequestInternal_with_workgroups() throws ObjectNotFoundException {
		String runIdString = request.getParameter("runId");
		assertNotNull(runIdString);
		Long offeringId = new Long(runIdString);
		
		Set<Workgroup> expectedWorkgroups = new HashSet<Workgroup>();
		expectedWorkgroups.add(workgroup);
		expect(offeringService.getWorkgroupsForOffering(offeringId)).andReturn(expectedWorkgroups);
		expect(offeringService.getOffering(offeringId)).andReturn(run);
		replay(offeringService);
		
		Map<Group,List<Workgroup>> expectedPeriodsToWorkgroups = 
			new HashMap<Group, List<Workgroup>>();
		expectedPeriodsToWorkgroups.put(this.group, new ArrayList<Workgroup>());
		expectedPeriodsToWorkgroups.get(this.group).add(this.workgroup);
		
		ModelAndView modelAndView = null;
		try {
			modelAndView = selectWorkgroupController.handleRequestInternal(request, response);
		} catch (Exception e) {
			fail("Unexpected exception was thrown");
		}
		assertNotNull(modelAndView);
		assertModelAttributeValue(modelAndView, 
				SelectWorkgroupController.RUN_ID_PARAM_NAME, offeringId);
		assertModelAttributeValue(modelAndView, 
				SelectWorkgroupController.PERIODS_TO_WORKGROUPS_PARAM_NAME, expectedPeriodsToWorkgroups);
		Map<Group,List<Workgroup>> actualPeriodsToWorkgroups = 
			(Map<Group,List<Workgroup>>) modelAndView.getModel().get(SelectWorkgroupController.PERIODS_TO_WORKGROUPS_PARAM_NAME);
		assertTrue(!actualPeriodsToWorkgroups.isEmpty());
		assertTrue(actualPeriodsToWorkgroups.size() == 1);
		assertTrue(actualPeriodsToWorkgroups.get(group).contains(workgroup));
		verify(offeringService);
	}

	
}
