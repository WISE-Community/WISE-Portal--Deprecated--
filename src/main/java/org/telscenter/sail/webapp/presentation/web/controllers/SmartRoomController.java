
package org.telscenter.sail.webapp.presentation.web.controllers;

import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.sail.webapp.dao.ObjectNotFoundException;
import net.sf.sail.webapp.domain.Offering;
import net.sf.sail.webapp.domain.User;
import net.sf.sail.webapp.domain.Workgroup;
import net.sf.sail.webapp.domain.group.Group;
import net.sf.sail.webapp.service.UserService;
import net.sf.sail.webapp.service.group.GroupService;
import net.sf.sail.webapp.service.offering.OfferingService;
import net.sf.sail.webapp.service.workgroup.WorkgroupService;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import org.telscenter.sail.webapp.domain.Run;
import org.telscenter.sail.webapp.domain.project.Project;
import org.telscenter.sail.webapp.domain.project.ProjectInfo;
import org.telscenter.sail.webapp.service.offering.RunService;
import org.telscenter.sail.webapp.service.project.ProjectService;
import org.telscenter.sail.webapp.service.student.StudentService;

public class SmartRoomController  extends AbstractController {
	
	private static final String USERID = "userId";
	private static final String RUNID = "runId";
	private static final String OFFERINGID = "offeringId";
	private static final String GROUPID = "groupId";
	private static final String WORKGROUPID = "workgroupId";
	private static final String PROJECTID = "prjectId"; 
	
	private WorkgroupService workgroupService;
	private StudentService studentService;
	private UserService userService;
	private RunService runService;
	private OfferingService offeringService;
	private GroupService groupService;
	private ProjectService projectService;
	
	@Override
	protected ModelAndView handleRequestInternal(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView();

		String action = request.getParameter("action");
		if (action != null) {
			if (action.equals("help")) {
				// Returns the USER information of the specific USER_ID as an XML string 
				// for see the result http://localhost:8080/webapp/smartroom/smartroom.html?action=help
				return handleGetHelp(request, response);
			}
				if (action.equals("commands")) {
					// commands
					// for see the result http://localhost:8080/webapp/smartroom/smartroom.html?action=test
					return handleGetCommands(request, response);
			}if (action.equals("getUserInfo")) { //finished
				// Retrieves User domain object using unique userId
				// for see the result http://localhost:8080/webapp/smartroom/smartroom.html?action=getUserInfo&userId=3
				return handleGetUserInfo(request, response);
			}if (action.equals("getUsers")) {//finished
				// Retrieves Users domain objects 
				// for see the result http://localhost:8080/webapp/smartroom/smartroom.html?action=getUsers
				return handleGetUsers(request, response);
			}if (action.equals("getRunInfo")) {//finished
				// Retrieves Run domain object using unique runId
				// for see the result http://localhost:8080/webapp/smartroom/smartroom.html?action=getRunInfo&runId=1
				return handleGetRunInfo(request, response);
			}if (action.equals("getRuns")) {//finished
				// Retrieves all Runs domain objects or
				// Retrieves Runs domain objects using unique userId  
				// for see the result of all Runs http://localhost:8080/webapp/smartroom/smartroom.html?action=getRuns
				// for see the result of unique userId http://localhost:8080/webapp/smartroom/smartroom.html?action=getRuns&userId=5
				return handleGetRuns(request, response);
			}if (action.equals("getRunOwners")) {//finished
				//retrieves all owners(users) of a Run using unique runId
				// for see the result http://localhost:8080/webapp/smartroom/smartroom.html?action=getRunOwners&runId=2
				return handleGetRunOwners(request, response);
			}if (action.equals("getRunPeriods")) {//finished
				//retrieves all periods of a Run using unique runId
				// for see the result http://localhost:8080/webapp/smartroom/smartroom.html?action=getRunPeriods&runId=2
				return handleGetRunPeriods(request, response);
			}if (action.equals("getGroupInfo")) {//finished
				//retrieves Group domain object using unique groupId
				// for see the result http://localhost:8080/webapp/smartroom/smartroom.html?action=getGroupInfo&groupId=2
				return handleGetGroupInfo(request, response);
			}if (action.equals("getGroups")) { //**** does not work correctly
												//if it would be commented line 165 of GroupService.java it works correctly
				//Retrieves all Groups domain objects 
				// for see the result http://localhost:8080/webapp/smartroom/smartroom.html?action=getGroups
				return handleGetGroups(request, response);
//			}if (action.equals("getGroupsByOfferingId")) { //******************************** should be checked & Be tested
//				//Retrieves all Groups domain objects using unique offeringId
//				// for see the result http://localhost:8080/webapp/smartroom/smartroom.html?action=getGroupByOfferingId=3
//				return handleGetGroupsByOfferingId(request, response);
			}if (action.equals("getGroupMembers")) {//finished
				// retrieves all members(users) in a Group using unique groupId
				// for see the result http://localhost:8080/webapp/smartroom/smartroom.html?action=getGroupMembers&groupId=6
				return handleGetGroupMembers(request, response);
			}if (action.equals("getWorkgroupInfo")) {//finished
				//retrieves the workgroup domain object using unique workgroupId 
				// for see the result http://localhost:8080/webapp/smartroom/smartroom.html?action=getWorkgroupInfo&workgroupId=2
				return handleGetWorkgroupInfo(request, response);
			}if (action.equals("getWorkgroups")) {//finished
				//retrieves all workgroup domain objects 
				// for see the result http://localhost:8080/webapp/smartroom/smartroom.html?action=getWorkgroups
				return handleGetWorkgroups(request, response);
			}if (action.equals("getWorkgroupsByofferingId")) {//****************** be tested and compares out put with getGroupsInfo out put
				//returns the workgroups of the specific OFFERING ID as an XML String 
				// for see the result http://localhost:8080/webapp/smartroom/smartroom.html?action=getgetWorkgroups&offeringId=2
				return handleGetWorkgroupsByOfferingId(request, response);
			}if (action.equals("getWorkgroupsByRunId")) {//********************* Be Tetsted it can mix to getWorkgroups 
				//returns the workgroups of the specific OFFERING ID as an XML String 
				// for see the result http://localhost:8080/webapp/smartroom/smartroom.html?action=getgetWorkgroupsByRunId&runId=2
				return handleGetWorksgroupsByRunId(request, response);
			}if (action.equals("getOfferingInfo")) {//finished
				//retrieves the offering domain object using unique offeringId
				// for see the result http://localhost:8080/webapp/smartroom/smartroom.html?action=getOfferingInfo&offeringId=2
				return handleGetOfferingInfo(request, response);
			}if (action.equals("getOfferings")) {//finished
				// retrieves all offering domain objects
				// for see the result http://localhost:8080/webapp/smartroom/smartroom.html?action=getOfferings
				return handleGetOfferings(request, response);
			}if (action.equals("getProjectInfo")) {//*********** under construction
				//retrieves the project domain object using unique projectId
				// for see the result http://localhost:8080/webapp/smartroom/smartroom.html?action=getProjectInfo&projectId=2
				return handleGetProjectInfo(request, response);
			}if (action.equals("getProjects")) {//*********** under construction
				//retrieves all project domain objects 
				//retrieves project domain objects using unique projectId  
				// for see the result of unique userId http://localhost:8080/webapp/smartroom/smartroom.html?action=getprojects&projectId=2
				// for see the result http://localhost:8080/webapp/smartroom/smartroom.html?action=getProjects
				return handleGetProjects(request, response);
			}if (action.equals("getAll")) {//++++++++++++++++++++++++++++++++++++++ this is for test
				// returns all information about workgroups this is for test 
				// for see the result http://localhost:8080/webapp/smartroom/smartroom.html?action=getAll
				return handleGetAll(request, response);
			} else {
				// shouldn't get here
				throw new RuntimeException("should not get here");
			}
		} else {
			// need action
			throw new RuntimeException("need action parameter");
		}

	}
	
	/**
	 * Returns <code> action </code> and <code> parameter </code> for all available services
	 * @param request
	 * @param response
	 * @return
	 * @throws ObjectNotFoundException
	 * @throws IOException
	 */
	private ModelAndView handleGetHelp(HttpServletRequest request,
			HttpServletResponse response) throws ObjectNotFoundException, IOException {

		String action ;
		String parameter ;
		String description ;
		String example ;
		String commentXML ="<services>";
		
		action = "getUserInfo";
		parameter = "userId";
		description = "Retrieves User domain object using unique userId"; 
		example = new String("http://localhost:8080/webapp/smartroom/smartroom.html?action=getUserInfo&userId=3");
		commentXML += makeHelpXML(action, parameter,description, example);

		action = "getUsers";
		parameter = "";
		description = "Retrieves Users domain objects"; 
		example = "http://localhost:8080/webapp/smartroom/smartroom.html?action=getUsers";
		commentXML += makeHelpXML(action, parameter,description, example);

		action = "getRunInfo";
		parameter = "runId";
		description = "Retrieves Run domain object using unique runId"; 
		example = "http://localhost:8080/webapp/smartroom/smartroom.html?action=getRunInfo&runId=1";
		commentXML += makeHelpXML(action, parameter,description, example);

		action = "getRuns";
		parameter = "userId";
		description = "Retrieves Runs domain objects using unique userId"; 
		example = "http://localhost:8080/webapp/smartroom/smartroom.html?action=getRuns&userId=5";
		commentXML += makeHelpXML(action, parameter,description, example);

		action = "getRuns";
		parameter = "";
		description = "Retrieves all Runs domain objects"; 
		example = "http://localhost:8080/webapp/smartroom/smartroom.html?action=getRuns";
		commentXML += makeHelpXML(action, parameter,description, example);

		action = "getRunOwners";
		parameter = "runId";
		description = "retrieves all owners(users) of a Run using unique runId"; 
		example = "http://localhost:8080/webapp/smartroom/smartroom.html?action=getRunOwners&runId=2";
		commentXML += makeHelpXML(action, parameter,description, example);

		action = "getRunPeriods";
		parameter = "runId";
		description = "retrieves all periods of a Run using unique runId"; 
		example = "http://localhost:8080/webapp/smartroom/smartroom.html?action=getRunPeriods&runId=2";
		commentXML += makeHelpXML(action, parameter,description, example);

		action = "getGroupInfo";
		parameter = "groupId";
		description = "retrieves Group domain object using unique groupId"; 
		example = "http://localhost:8080/webapp/smartroom/smartroom.html?action=getGroupInfo&groupId=2";
		commentXML += makeHelpXML(action, parameter,description, example);

		action = "getGroups";
		parameter = "";
		description = "retrieves all Groups domain objects"; 
		example = "http://localhost:8080/webapp/smartroom/smartroom.html?action=getGroups";
		commentXML += makeHelpXML(action, parameter,description, example);

		action = "getGroupMembers";
		parameter = "groupId";
		description = "retrieves all group members(users) using unique groupId"; 
		example = "http://localhost:8080/webapp/smartroom/smartroom.html?action=getGroupMembers&groupId=6";
		commentXML += makeHelpXML(action, parameter,description, example);

		action = "getWorkgroupInfo";
		parameter = "workgroupId";
		description = "retrieves the workgroup domain object using unique workgroupId"; 
		example = "http://localhost:8080/webapp/smartroom/smartroom.html?action=getWorkgroupInfo&workgroupId=2";
		commentXML += makeHelpXML(action, parameter,description, example);

		action = "getWorkgroups";
		parameter = "";
		description = "retrieves all workgroup domain objects"; 
		example = "http://localhost:8080/webapp/smartroom/smartroom.html?action=getWorkgroups";
		commentXML += makeHelpXML(action, parameter,description, example);

		action = "getOfferingInfo";
		parameter = "offeringId";
		description = "retrieves the offering domain object using unique offeringId";
		example = "http://localhost:8080/webapp/smartroom/smartroom.html?action=getOfferingInfo&offeringId=2";
		commentXML += makeHelpXML(action, parameter,description, example);

		action = "getOfferings";
		parameter = "";
		description = "retrieves all offering domain objects";
		example = "http://localhost:8080/webapp/smartroom/smartroom.html?action=getOfferings";
		commentXML += makeHelpXML(action, parameter,description, example);

		action = "getProjectInfo";
		parameter = "projectId";
		description = "retrieves the project domain object using unique projectId";
		example = "http://localhost:8080/webapp/smartroom/smartroom.html?action=getProjectInfo&projectId=2";
		commentXML += makeHelpXML(action, parameter,description, example);

		action = "getProjects";
		parameter = "";
		description = "retrieves all project domain objects";
		example = "http://localhost:8080/webapp/smartroom/smartroom.html?action=getProjects";
		commentXML += makeHelpXML(action, parameter,description, example);

		action = "getProjects";
		parameter = "userId";
		description = "retrieves project domain objects using unique projectId";
		example = "http://localhost:8080/webapp/smartroom/smartroom.html?action=getProjects&userId";
		commentXML += makeHelpXML(action, parameter,description, example);

		commentXML += "</services>";
		setResponse(response, commentXML);
		return null;
	}
	/**
	 * commands
	 * @param request
	 * @param response
	 * @return
	 * @throws ObjectNotFoundException
	 * @throws IOException
	 */
	private ModelAndView handleGetCommands(HttpServletRequest request,
			HttpServletResponse response) throws ObjectNotFoundException, IOException {

		String action ;
		String parameter ;
		String description ;
		String example ;
		//String commentXML ="<strong><b>" + "&#60;" + "services" + "&#62;" + "</b></strong>" ;
		String commandsXML ="<services>" ;

		ModelAndView modelAndView = new ModelAndView();

		action = "getUserInfo";
		parameter = "userId";
		description = "Retrieves User domain object using unique userId"; 
		example = "http://localhost:8080/webapp/smartroom/smartroom.html?action=getUserInfo&userId=3";
		commandsXML += makeCommandsXML(action, parameter,description, example);

		action = "getUsers";
		parameter = "";
		description = "Retrieves Users domain objects"; 
		example = "http://localhost:8080/webapp/smartroom/smartroom.html?action=getUsers";
		commandsXML += makeCommandsXML(action, parameter,description, example);

		action = "getRunInfo";
		parameter = "runId";
		description = "Retrieves Run domain object using unique runId"; 
		example = "http://localhost:8080/webapp/smartroom/smartroom.html?action=getRunInfo&runId=1";
		commandsXML += makeCommandsXML(action, parameter,description, example);

		action = "getRuns";
		parameter = "userId";
		description = "Retrieves Runs domain objects using unique userId"; 
		example = "http://localhost:8080/webapp/smartroom/smartroom.html?action=getRuns&userId=5";
		commandsXML += makeCommandsXML(action, parameter,description, example);

		action = "getRuns";
		parameter = "";
		description = "Retrieves all Runs domain objects"; 
		example = "http://localhost:8080/webapp/smartroom/smartroom.html?action=getRuns";
		commandsXML += makeCommandsXML(action, parameter,description, example);

		action = "getRunOwners";
		parameter = "runId";
		description = "retrieves all owners(users) of a Run using unique runId"; 
		example = "http://localhost:8080/webapp/smartroom/smartroom.html?action=getRunOwners&runId=2";
		commandsXML += makeCommandsXML(action, parameter,description, example);

		action = "getRunPeriods";
		parameter = "runId";
		description = "retrieves all periods of a Run using unique runId"; 
		example = "http://localhost:8080/webapp/smartroom/smartroom.html?action=getRunPeriods&runId=2";
		commandsXML += makeCommandsXML(action, parameter,description, example);

		action = "getGroupInfo";
		parameter = "groupId";
		description = "retrieves Group domain object using unique groupId"; 
		example = "http://localhost:8080/webapp/smartroom/smartroom.html?action=getGroupInfo&groupId=2";
		commandsXML += makeCommandsXML(action, parameter,description, example);

		action = "getGroups";
		parameter = "";
		description = "retrieves all Groups domain objects"; 
		example = "http://localhost:8080/webapp/smartroom/smartroom.html?action=getGroups";
		commandsXML += makeCommandsXML(action, parameter,description, example);

		action = "getGroupMembers";
		parameter = "groupId";
		description = "retrieves all group members(users) using unique groupId"; 
		example = "http://localhost:8080/webapp/smartroom/smartroom.html?action=getGroupMembers&groupId=6";
		commandsXML += makeCommandsXML(action, parameter,description, example);

		action = "getWorkgroupInfo";
		parameter = "workgroupId";
		description = "retrieves the workgroup domain object using unique workgroupId"; 
		example = "http://localhost:8080/webapp/smartroom/smartroom.html?action=getWorkgroupInfo&workgroupId=2";
		commandsXML += makeCommandsXML(action, parameter,description, example);

		action = "getWorkgroups";
		parameter = "";
		description = "retrieves all workgroup domain objects"; 
		example = "http://localhost:8080/webapp/smartroom/smartroom.html?action=getWorkgroups";
		commandsXML += makeCommandsXML(action, parameter,description, example);

		action = "getOfferingInfo";
		parameter = "offeringId";
		description = "retrieves the offering domain object using unique offeringId";
		example = "http://localhost:8080/webapp/smartroom/smartroom.html?action=getOfferingInfo&offeringId=2";
		commandsXML += makeCommandsXML(action, parameter,description, example);

		action = "getOfferings";
		parameter = "";
		description = "retrieves all offering domain objects";
		example = "http://localhost:8080/webapp/smartroom/smartroom.html?action=getOfferings";
		commandsXML += makeCommandsXML(action, parameter,description, example);

		action = "getProjectInfo";
		parameter = "projectId";
		description = "retrieves the project domain object using unique projectId";
		example = "http://localhost:8080/webapp/smartroom/smartroom.html?action=getProjectInfo&projectId=2";
		commandsXML += makeCommandsXML(action, parameter,description, example);

		action = "getProjects";
		parameter = "";
		description = "retrieves all project domain objects";
		example = "http://localhost:8080/webapp/smartroom/smartroom.html?action=getProjects";
		commandsXML += makeCommandsXML(action, parameter,description, example);

		action = "getProjects";
		parameter = "userId";
		description = "retrieves project domain objects using unique projectId";
		example = "http://localhost:8080/webapp/smartroom/smartroom.html?action=getProjects&userId=3";
		commandsXML += makeCommandsXML(action, parameter,description, example);

		commandsXML += "</services>";
		modelAndView.addObject("commandsXML", commandsXML);
		
		return modelAndView;
	}
	/**
	 * Retrieves User domain object using unique userId
	 * @param request
	 * @param response
	 * @return
	 * @throws ObjectNotFoundException
	 * @throws IOException
	 */
	private ModelAndView handleGetUserInfo(HttpServletRequest request,
			HttpServletResponse response) throws ObjectNotFoundException, IOException {

		Long userId = Long.parseLong(request.getParameter(USERID));
		
		User user = this.userService.retrieveById(userId);
		
		String userInfoXML = "<userInfo>";
		userInfoXML += makeUserInfoXML(user);
		userInfoXML += "</userInfo>";
		
		setResponse(response, userInfoXML);
		return null;
	}

	/**
	 * Retrieves Users domain objects
	 * @param request
	 * @param response
	 * @return
	 * @throws ObjectNotFoundException
	 * @throws IOException
	 */
	private ModelAndView handleGetUsers(HttpServletRequest request,
			HttpServletResponse response) throws ObjectNotFoundException, IOException {

		List<User> usersList = this.userService.retrieveAllUsers();
		String usersXML = "<users>";
		Boolean no_user = true;
		for(Iterator<User> iter=usersList.iterator(); iter.hasNext();){
			usersXML += "<userInfo>";
			usersXML += makeUserInfoXML(iter.next());
			usersXML += "</userInfo>";
			no_user = false;
		}
		if (no_user)
			usersXML = "null";
		usersXML += "</users>";

		setResponse(response, usersXML);
		return null;
	}
	
	/**
	 * Retrieves Run domain object using unique runId
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException 
	 * @throws ObjectNotFoundException 
	 */
	private ModelAndView handleGetRunInfo(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ObjectNotFoundException {

		Long runId = Long.parseLong(request.getParameter(RUNID));
		Run run = this.runService.retrieveById(runId);
		
		setResponse(response, makeRunInfoXML(run));
		return null;
	}

	/**
	 * Retrieves all Runs domain objects or
	 * Retrieves Runs domain objects using unique userId  
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException \\\
	 * @throws ObjectNotFoundException
	 */
	private ModelAndView handleGetRuns(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ObjectNotFoundException {

		List<Run> runsList;
		String runsXML = "<runs>";
		Boolean no_run = true;

		if (request.getParameter(USERID) != null){

			Long userId = Long.parseLong(request.getParameter(USERID));
			User user = this.userService.retrieveById(userId);
			runsList = this.runService.getRunList(user);
			
		}else{

			runsList = this.runService.getRunList();
		}
		for(Iterator<Run> iter = runsList.iterator(); iter.hasNext();){
			runsXML += makeRunInfoXML(iter.next());
			no_run = false;
		}
		if (no_run)
			runsXML += "null";

		runsXML += "</runs>";
		setResponse(response, runsXML);
		return null;
	}

	/**
	 * Returns the OWNERs information of the specific RUN as an XML String 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException 
	 * @throws ObjectNotFoundException
	 */
	private ModelAndView handleGetRunOwners(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ObjectNotFoundException {

		Long runId = Long.parseLong(request.getParameter(RUNID));
		Run run = this.runService.retrieveById(runId);
		Boolean no_owner = true;
		Set<User> ownersSet = run.getOwners();
		
 		String runOwnersInfoXML = "<runOwners>";

		for(Iterator<User> iter = ownersSet.iterator(); iter.hasNext();){
			runOwnersInfoXML += "<member>";
			runOwnersInfoXML += makeUserInfoXML(iter.next());
			runOwnersInfoXML += "</member>";
		}
		if (no_owner){
			runOwnersInfoXML += "null";
		}
 		runOwnersInfoXML += "</runOwners>";
		
		setResponse(response, runOwnersInfoXML);
		return null;
	}

	/**
	 * Returns the OWNERs information of the specific RUN as an XML String 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException 
	 * @throws ObjectNotFoundException
	 */
	private ModelAndView handleGetRunPeriods(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ObjectNotFoundException {

		Long runId = Long.parseLong(request.getParameter(RUNID));
		Run run = this.runService.retrieveById(runId);
		Boolean no_owner = true;
		Set<Group> periodsSet = run.getPeriods();
		
 		String runPeriodsInfoXML = "<runPeriods>";

		for(Iterator<Group> iter = periodsSet.iterator(); iter.hasNext();){
			runPeriodsInfoXML += "<period>";
			runPeriodsInfoXML += makeGroupInfoXML(iter.next());
			runPeriodsInfoXML += "</period>";
		}
		if (no_owner){
			runPeriodsInfoXML += "null";
		}
 		runPeriodsInfoXML += "</runPeriods>";
		
		setResponse(response, runPeriodsInfoXML);
		return null;
	}

	/**
	 * retrieves Group domain object using unique groupId
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException 
	 * @throws ObjectNotFoundException
	 */
	private ModelAndView handleGetGroupInfo(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ObjectNotFoundException {

		Long groupId = Long.parseLong(request.getParameter(GROUPID));
		
		Group group = this.groupService.retrieveById(groupId);
		String groupInfoXML = "<groupInfo>";
		Boolean no_group = true;
		
		groupInfoXML += makeGroupInfoXML(group);
		if (no_group)
			groupInfoXML += "null";
		
		groupInfoXML += "</groupInfo>";

		setResponse(response, groupInfoXML);
		return null;
	}
	
	/**
	 * Retrieves all Groups domain objects
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException 
	 * @throws ObjectNotFoundException
	 */
	private ModelAndView handleGetGroups(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ObjectNotFoundException {

		Boolean no_group = true;
		String groupXML = "<groups>";

		List<Group> groupsList = this.groupService.getGroups();
		for(Iterator<Group> iter = groupsList.iterator(); iter.hasNext();){
			Group group = iter.next();
			groupXML += "<groupInfo>"; 
			groupXML += makeGroupInfoXML(group);
			groupXML += "</groupInfo>"; 
			no_group = false;
		}
		if (no_group)
			groupXML += "null";
		groupXML += "</groups>";
		setResponse(response, groupXML);
		return null;
	}

//	/**
//	 * //retrieve all Groups by specific offeringId as an XML String
//	 * @param request
//	 * @param response
//	 * @return
//	 * @throws IOException 
//	 * @throws ObjectNotFoundException
//	 */
//	private ModelAndView handleGetGroupsByOfferingId(HttpServletRequest request,
//			HttpServletResponse response) throws IOException, ObjectNotFoundException {
//
//		Long offeringId = Long.parseLong(request.getParameter(OFFERINGID));
//		Boolean no_group = true;
//		String groupXML = "<groups>";
//		List<Workgroup> workgroupsList = this.workgroupService.getWorkgroupList();
//		for(Iterator<Workgroup> iter = workgroupsList.iterator(); iter.hasNext();){
//			Workgroup workgroup = iter.next();
//			Offering offering = workgroup.getOffering();
//			if (offeringId.longValue() == offering.getId()){
//				Group group = workgroup.getGroup();
//				groupXML += "<group>";
//				groupXML += "<id>" + group.getId().toString() + "</id>";
//				groupXML += "<name>" + group.getName() + "</name>";
//				groupXML += "</group>";
//				no_group = false; 
//			}
//		}
//		if (no_group)
//			groupXML += "null";
//		groupXML += "</groups>";
//		setResponse(response, groupXML);
//		return null;
//	}

	/**
	 * Returns the Members(users) of a Group by specific group ID as an XML String 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException 
	 * @throws ObjectNotFoundException
	 */
	private ModelAndView handleGetGroupMembers(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ObjectNotFoundException {

		Long groupId = Long.parseLong(request.getParameter(GROUPID));
		Boolean no_member = true;
		String groupMembersXML = "<groupMembers>";

		Group group = this.groupService.retrieveById(groupId);
		Set<User> userSet = group.getMembers();

		for(Iterator<User> iter = userSet.iterator(); iter.hasNext();){
			User user = iter.next();
			groupMembersXML += makeGroupMemberInfoXML(user);
			no_member = false;
		}
		if (no_member)
			groupMembersXML += "null";
		groupMembersXML += "</groupMembers>";
		
		setResponse(response, groupMembersXML);
		return null;

	}

	/**
	 * retrieves the Workgroup domain object using unique workgroupId 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException 
	 * @throws ObjectNotFoundException
	 */
	private ModelAndView handleGetWorkgroupInfo(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ObjectNotFoundException {

		Long workgroupId = Long.parseLong(request.getParameter(WORKGROUPID));
		
		
		Workgroup workgroup = this.workgroupService.retrieveById(workgroupId);
		String workgroupInfoXML = "<workgroupInfo>";
		//Boolean no_workgroup = true;
		
		workgroupInfoXML += makeWorkgroupInfoXML(workgroup);
		//if (no_workgroup)
		//	workgroupInfoXML += "null";
		
		workgroupInfoXML += "</workgroupInfo>";

		setResponse(response, workgroupInfoXML);
		return null;
	}
	
	/**
	 * Retrieves all Workgroups domain objects
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException 
	 * @throws ObjectNotFoundException
	 */
	private ModelAndView handleGetWorkgroups(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ObjectNotFoundException {

		Boolean no_workgroup = true;
		String workgroupXML = "<workgroups>";

		List<Workgroup> workgroupsList = this.workgroupService.getWorkgroupList();
		for(Iterator<Workgroup> iter = workgroupsList.iterator(); iter.hasNext();){
			Workgroup workgroup = iter.next();
			workgroupXML += "<workgroupInfo>"; 
			workgroupXML += makeWorkgroupInfoXML(workgroup);
			workgroupXML += "</workgroupInfo>"; 
			no_workgroup = false;
		}
		if (no_workgroup)
			workgroupXML += "null";
		workgroupXML += "</workgroups>";
		setResponse(response, workgroupXML);
		return null;
	}

	/**
	 * Returns the Workgroups of the specific OFFERING ID as an XML String 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException 
	 * @throws ObjectNotFoundException
	 */
	private ModelAndView handleGetWorkgroupsByOfferingId(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ObjectNotFoundException {

		Long offeringId = Long.parseLong(request.getParameter(OFFERINGID));
		Set<Workgroup> workgroupSet = this.offeringService.getWorkgroupsForOffering(offeringId);
		
 		String workgroupXML = "<workgrpups>";
		for(Iterator<Workgroup> iter = workgroupSet.iterator(); iter.hasNext();){
			
			Workgroup workgroup = iter.next();
			workgroupXML += "<id>" + workgroup.getId() + "</id>";
			//workgroupXML += "<sds_name>" + workgroup.getSdsWorkgroup().getName() + "</sds_name>";
		}
		workgroupXML += "</workgrpups>";
		
		setResponse(response, workgroupXML);
		return null;
	}
	/**
	 * Returns the Workgroups of the specific RUN ID as an XML String 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException 
	 * @throws ObjectNotFoundException
	 */
	private ModelAndView handleGetWorksgroupsByRunId(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ObjectNotFoundException {

		Long runId = Long.parseLong(request.getParameter(RUNID));
		Set<Workgroup> workgroupSet = this.runService.getWorkgroups(runId);
		
 		String workgroupXML = "<workgrpups>";
		for(Iterator<Workgroup> iter = workgroupSet.iterator(); iter.hasNext();){
			
			Workgroup workgroup = iter.next();
			workgroupXML += "<id>" + workgroup.getId() + "</id>";
			//workgroupXML += "<sds_name>" + workgroup.getSdsWorkgroup().getName() + "</sds_name>";
		}
		workgroupXML += "</workgrpups>";
		
		setResponse(response, workgroupXML);
		return null;
	}

	/**
	 * retrieves the Offering domain object using unique offeringId 
	 * is paused or messages that teacher wants to send to students.
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException 
	 * @throws ObjectNotFoundException 
	 */
	private ModelAndView handleGetOfferingInfo(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ObjectNotFoundException {

		Long offeringId = Long.parseLong(request.getParameter(OFFERINGID));
		Offering offering = this.offeringService.getOffering(offeringId);

		//String offeringXML = "<offering>";
		String offeringXML = makeOfferingInfoXML(offering);
		//offeringXML += "</offering>";
		setResponse(response, offeringXML);
		return null;
	}

	/**
	 * retrieves all Offering domain objects
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException 
	 * @throws ObjectNotFoundException 
	 */
	private ModelAndView handleGetOfferings(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ObjectNotFoundException {

		List<Offering> offeringList = this.offeringService.getOfferingList();
		String offeringXML = "<offerings>";
		for(Iterator<Offering> iter = offeringList.iterator(); iter.hasNext();){
			offeringXML += makeOfferingInfoXML(iter.next());
		}
		offeringXML += "</offerings>";
		setResponse(response, offeringXML);
		return null;
	}

	/**
	 * retrieves the project domain object using unique projectId
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException 
	 * @throws ObjectNotFoundException 
	 */
	private ModelAndView handleGetProjectInfo(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ObjectNotFoundException {

		Long projectId = Long.parseLong(request.getParameter(PROJECTID));
		Project project = this.projectService.getById(projectId);

		//String projectXML = "<project>";
		String projectXML = makeProjectInfoXML(project);
		//projectXML += "</project>";
		setResponse(response, projectXML);
		return null;
	}

	/**
	 * retrieves all project domain objects
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException 
	 * @throws ObjectNotFoundException 
	 */
	private ModelAndView handleGetProjects(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ObjectNotFoundException {

		List<Project> projectList;

		String projectsXML = "<projects>";
		Boolean no_project = true;

		if (request.getParameter(USERID) != null){

			Long userId = Long.parseLong(request.getParameter(USERID));
			User user = this.userService.retrieveById(userId);
			projectList = this.projectService.getProjectList(user);
			
		}else{

			projectList = this.projectService.getProjectList();
		}
		for(Iterator<Project> iter = projectList.iterator(); iter.hasNext();){
			projectsXML += makeProjectInfoXML(iter.next());
			no_project = false;
		}
		if (no_project)
			projectsXML += "null";

		projectsXML += "</projects>";
		setResponse(response, projectsXML);
		return null;
	}
	

	/**
	 * Returns the RUN information of the specific RUN_ID as an XML String 
	 * is paused or messages that teacher wants to send to students.
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException 
	 * @throws ObjectNotFoundException 
	 */
	private ModelAndView handleGetAll(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ObjectNotFoundException {

		List<Workgroup> workgroupsList = this.workgroupService.getWorkgroupList() ;
		String workgroupXML = "<workgroups>";
		for(Iterator<Workgroup> iter = workgroupsList.iterator(); iter.hasNext();){
			workgroupXML += "<workgroup>";
			Workgroup workgroup = iter.next();
			workgroupXML += "<id_workgroup>" + workgroup.getId().toString() + "</id_workgroup>";
			Offering offering = workgroup.getOffering();
			workgroupXML += "<offeringId_workgroup>" + offering.getId().toString() + "</offeringId_workgroup>";
			Group group = workgroup.getGroup();
			workgroupXML += "<group>";
			workgroupXML += "<id_group>" + group.getId().toString() + "</id_group>";
			workgroupXML += "<name_group>" + group.getName() + "</name_group>";
			Set<User> groupMembersSet = group.getMembers();
			workgroupXML += "<groupMembers>";
			for(Iterator<User> i = groupMembersSet.iterator(); i.hasNext();){
				User user = i.next();
				workgroupXML += "<groupMember>";
				workgroupXML += "<id_groupMember>" + user.getUserDetails().getId().toString() + "</id_groupMember>";
				workgroupXML += "<name_groupMember>" + user.getUserDetails().getUsername().toString() + "</name_groupMember>";
				//workgroupXML += "<email>" + user.getUserDetails().getEmailAddress() + "</email>";
				workgroupXML += "</groupMember>";
			}
			workgroupXML += "</groupMembers>";
			workgroupXML += "</group>";

			Set<User> workgroupMemberSet = workgroup.getMembers();
			workgroupXML += "<workgroupMembers>";
			for(Iterator<User> i = groupMembersSet.iterator(); i.hasNext();){
				User user = i.next();
				workgroupXML += "<member>";
				workgroupXML += "<id_member>" + user.getUserDetails().getId().toString() + "</id_member>";
				workgroupXML += "<name_member>" + user.getUserDetails().getUsername().toString() + "</name_member>";
				//workgroupXML += "<email>" + user.getUserDetails().getEmailAddress() + "</email>";
				workgroupXML += "</member>";
			}
			workgroupXML += "</workgroupMembers>";
			workgroupXML += "</workgroup>";
		}
		workgroupXML += "</workgroups>";
		setResponse(response, workgroupXML);
		return null;
	
	}

	/**
	 * Returns the userInfo XML containing some information about user
	 * @param user
	 * @return
	 */
	private String makeUserInfoXML(User user){
	
		String userInfoXML = "<id>" + user.getUserDetails().getId().toString() + "</id>";
		userInfoXML += "<name>" + user.getUserDetails().getUsername().toString() + "</name>";
		userInfoXML += "<email>" + user.getUserDetails().getEmailAddress() + "</email>";
		return userInfoXML;
	}

	/**
	 * Returns the RunInfo XML containing some information about run
	 * @param run
	 * @return
	 */
	private String makeRunInfoXML(Run run){

		String runInfoXML = "<runInfo>";
		runInfoXML += "<id>" + run.getId()+ "</id>";
		runInfoXML += "<name>" + run.getName() + "</name>";
		runInfoXML += "<runCode>" + run.getRuncode()+ "</runCode>";
		runInfoXML += "<projectId>" + run.getProject().getId()+ "</projectId>";
		//runInfoXML += "<status>" + run.getRunStatus().toString()+ "</status>";
		runInfoXML += "<startTime>" + run.getStarttime().toString() + "</startTime>";
		if (run.isEnded())
			runInfoXML += "<endTime>" + run.getEndtime().toString() + "</endTime>";
		else
			runInfoXML += "<endTime>" + "null" + "</endTime>";
		runInfoXML += "</runInfo>";
		return runInfoXML;
	}
	
	/**
	 * Returns the groupInfo XML containing some information about group
	 * @param group
	 * @return
	 */
	private String makeGroupInfoXML(Group group){
	
		String groupInfoXML = "<id>" + group.getId().toString() + "</id>";
		groupInfoXML += "<name>" + group.getName() + "</name>";
		Set<User> groupMembersSet = group.getMembers();
		Boolean no_member = true;
		groupInfoXML += "<members>";
		for(Iterator<User> i = groupMembersSet.iterator(); i.hasNext();){
			User user = i.next();
			groupInfoXML += makeGroupMemberInfoXML(user);
			no_member = false;
		}
		if (no_member){
			groupInfoXML += "null";
		}
		groupInfoXML += "</members>";

		return groupInfoXML;
	}
	
	/**
	 * Returns the groupMemberInfo XML containing some information about group member
	 * @param user
	 * @return
	 */
	private String makeGroupMemberInfoXML(User user){
	
		String memberXML = "<member>";
		memberXML += "<id_member>" + user.getUserDetails().getId().toString() + "</id_member>";
		memberXML += "<name_member>" + user.getUserDetails().getUsername().toString() + "</name_member>";
		memberXML += "<email_member>" + user.getUserDetails().getEmailAddress() + "</email_member>";
		memberXML += "</member>";
		return memberXML;
	}
	
	/**
	 * Returns the offeringXML containing some information about offering
	 * @param offerin
	 * @return
	 */
	private String makeOfferingInfoXML(Offering offering){
	
		String offeringInfoXML = "<offeringInfo>";
		offeringInfoXML += "<id>";
		offeringInfoXML += offering.getId().toString();
		offeringInfoXML += "</id>";
		offeringInfoXML += "</offeringInfo>";
		return offeringInfoXML;
	}
	
	/**
	 * Returns the projectXML containing some information about project
	 * @param project
	 * @return
	 */
	private String makeProjectInfoXML(Project project){
	
		ProjectInfo projectInfo = project.getProjectInfo();

		String projectXML = "<projectInfo>";
		projectXML += "<id>";
		projectXML += project.getId().toString();
		projectXML += "</id>";
		projectXML += "<name>";
		projectXML += projectInfo.getName();
		projectXML += "</name>";
		projectXML += "<subject>";
		projectXML += projectInfo.getSubject();
		projectXML += "</subject>";
		projectXML += "<auther>";
		projectXML += projectInfo.getAuthor();
		projectXML += "</auther>";
		projectXML += "<comment>";
		projectXML += projectInfo.getComment();
		projectXML += "</comment>";
		projectXML += "<description>";
		projectXML += projectInfo.getDescription();
		projectXML += "</description>";
		projectXML += "<gread_level>";
		projectXML += projectInfo.getGradeLevel();
		projectXML += "</gread_level>";
		projectXML += "</projectInfo>";
		return projectXML;
	}
	
	/**
	 * Returns the workgroupInfoXML containing some information about workgroup
	 * @param workgroup
	 * @return
	 */
	private String makeWorkgroupInfoXML(Workgroup workgroup){
	
		String workgroupInfoXML = "<id>" + workgroup.getId().toString() + "</id>";
		Offering offering = workgroup.getOffering();
		
		workgroupInfoXML += "<offeringId>" + offering.getId().toString() + "</offeringId>";
		
		Group group = workgroup.getGroup();

		workgroupInfoXML += "<group>";
		workgroupInfoXML += makeGroupInfoXML(group);
		workgroupInfoXML += "</group>";

		return workgroupInfoXML;
	}
	
	/**
	 * Makes one node of help XML
	 * @param action
	 * @param parameter
	 * @param example
	 * @return
	 */
	private String makeHelpXML(String action,String parameter,String description, String example) {

		
		String  serviceXML = "<service>";
				serviceXML += "<action>";
				serviceXML += action;
				serviceXML += "</action>";
				serviceXML += "<parameter>";
				if (parameter == "")
					serviceXML += "null";
				else
					serviceXML += parameter;
				serviceXML += "</parameter>";
				serviceXML += "<description>";
				serviceXML += description;
				serviceXML += "</description>";
				serviceXML += "<example>";
				serviceXML += "<![CDATA[";
				serviceXML += example;
				serviceXML += "]]>";
				serviceXML += "</example>";
				serviceXML += "</service>";
				
		return serviceXML;
	}

	/**
	 * Makes test XML
	 * @param action
	 * @param parameter
	 * @param example
	 * @return
	 */
	private String makeCommandsXML(String action,String parameter,String description, String example) {

		String serviceXML = "<p><pre><strong><b>";
		
		serviceXML += "&#60;" + "service" + "&#62;";
		
		serviceXML += "<br/>" + "    ";
		
		serviceXML += "&#60;" + "action" + "&#62;" + "</b></strong>";
		
		serviceXML += "<code>";
		serviceXML += action;
		serviceXML += "</code><strong><b>";
		serviceXML += "&#60;" + "/action" + "&#62;";
		serviceXML += "<br/>" + "    ";
		serviceXML += "&#60;" + "parameter" + "&#62;" + "</b></strong>";
		serviceXML += "<code>";

		if (parameter == "")
			serviceXML += "null";
		else
			serviceXML += parameter;
		serviceXML += "</code><strong><b>";
		serviceXML += "&#60;" + "/parameter" + "&#62;";
		serviceXML += "<br/>" + "    ";
		serviceXML += "&#60;" + "description" + "&#62;" + "</b></strong>";
		serviceXML += "<code>";
		serviceXML += description;
		serviceXML += "</code><strong><b>";
		serviceXML += "&#60;" + "/description" + "&#62;";
		serviceXML += "<br/>" + "    ";
		serviceXML += "&#60;" + "example" + "&#62;" + "</b></strong>";
		serviceXML += "<kbd>";
		serviceXML += "<a href=\"" + example +"\">" + example + "</a>";	
		serviceXML += "</kbd><strong><b>";
		serviceXML += "&#60;" + "/example" + "&#62;";
		serviceXML += "<br/>";
		serviceXML += "&#60;" + "/service" + "&#62;" + "</b></strong></p></pre>";
				
		return serviceXML;
	}
	public void setWorkgroupService(WorkgroupService workgroupService) {
		this.workgroupService = workgroupService;
	}
//
//	public void setStudentService(StudentService studentService) {
//		this.studentService = studentService;
//	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	public void setRunService(RunService runService) {
		this.runService = runService;
	}

	public void setOfferingService(OfferingService offeringService) {
		this.offeringService = offeringService;
	}

	public void setGroupService(GroupService groupService){
		this.groupService = groupService;
	}
	
	public void setProjectService(ProjectService projectService){
		this.projectService = projectService;
	}
	private void setResponse(HttpServletResponse response, String strXML) throws IOException{
		
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);

		response.setContentType("text/xml");
		response.getWriter().print(strXML);

	}
}
