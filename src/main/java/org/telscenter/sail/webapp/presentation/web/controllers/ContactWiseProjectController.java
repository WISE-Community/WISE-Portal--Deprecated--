/**
 * 
 */
package org.telscenter.sail.webapp.presentation.web.controllers;

import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.sail.webapp.domain.User;
import net.sf.sail.webapp.mail.IMailFacade;
import net.sf.sail.webapp.presentation.web.controllers.ControllerUtil;

import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;
import org.telscenter.sail.webapp.domain.authentication.MutableUserDetails;
import org.telscenter.sail.webapp.domain.authentication.impl.TeacherUserDetails;
import org.telscenter.sail.webapp.domain.general.contactwise.ContactWISE;
import org.telscenter.sail.webapp.domain.general.contactwise.IssueType;
import org.telscenter.sail.webapp.domain.general.contactwise.OperatingSystem;
import org.telscenter.sail.webapp.domain.general.contactwise.WebBrowser;
import org.telscenter.sail.webapp.domain.general.contactwise.impl.ContactWISEGeneral;
import org.telscenter.sail.webapp.domain.general.contactwise.impl.ContactWISEProject;
import org.telscenter.sail.webapp.domain.project.Project;
import org.telscenter.sail.webapp.service.project.ProjectService;

/**
 * @author gloriasass
 *
 */
public class ContactWiseProjectController extends SimpleFormController {

	protected IMailFacade javaMail = null;
	
	protected Properties uiHTMLProperties = null;
	
	private ProjectService projectService;

	/* change this to true if you are testing and do not want to send mail to
	   the actual groups */
	private static final Boolean DEBUG = false;
	
	//set this to your email
	private static final String DEBUG_EMAIL = "youremail@gmail.com";
	
	public ContactWiseProjectController() {
		setSessionForm(true);
	}
	
	@Override
	public ModelAndView onSubmit(HttpServletRequest request,
			HttpServletResponse response, Object command, BindException errors)
	throws Exception {
		
		ContactWISEProject contactWISEProject = (ContactWISEProject) command;

		//retrieves the contents of the email to be sent
		String[] recipients = contactWISEProject.getMailRecipients();
		String subject = contactWISEProject.getMailSubject();
		String message = contactWISEProject.getMailMessage();
		String fromEmail = contactWISEProject.getEmail();
		String[] cc = contactWISEProject.getMailCcs();
		
		if(DEBUG) {
			cc = new String[1];
			cc[0] = fromEmail;
			recipients[0] = DEBUG_EMAIL;
		}
		
		//sends the email to the recipients
		javaMail.postMail(recipients, subject, message, fromEmail, cc);
		
		//System.out.println(message);
		
		ModelAndView modelAndView = new ModelAndView(getSuccessView());

		return modelAndView;
	}
	
	@Override
	protected Object formBackingObject(HttpServletRequest request) 
			throws Exception {
		ContactWISEProject contactWISEProject = new ContactWISEProject();
		
		//tries to retrieve the user from the session
		User user = ControllerUtil.getSignedInUser();

		/* if the user is logged in to the session, auto populate the name and 
		email address in the form, if not, the fields will just be blank */
		if (user != null) {
			//contactWISEProject.setUser(user);
			contactWISEProject.setIsStudent(user);
			
			MutableUserDetails telsUserDetails = 
				(MutableUserDetails) user.getUserDetails();

			contactWISEProject.setName(telsUserDetails.getFirstname() + " " + 
					telsUserDetails.getLastname());
			
			//if user is a teacher, retrieve their email
			/* NOTE: this check may be removed later if we never allow students
			   to submit feedback */
			if(telsUserDetails instanceof TeacherUserDetails) {
				contactWISEProject.setEmail(telsUserDetails.getEmailAddress());
			}
		}
		
		//tries to retrieve the project ID number from the request
		if(request.getParameter("projectId") != null) {
			Project project = projectService.getById(Long.parseLong(
					request.getParameter("projectId")));
			
			if(project != null) {
				//sets the project and project name
				contactWISEProject.setProjectName(
						project.getName());
				contactWISEProject.setProjectId(Long.parseLong(
						request.getParameter("projectId")));
			}
		}
		
		contactWISEProject.setIssuetype(IssueType.PROJECT_PROBLEMS);
		
		return contactWISEProject;
	}
	
	@Override
	protected Map<String, Object> referenceData(HttpServletRequest request) 
			throws Exception {
		Map<String, Object> model = new HashMap<String, Object>();
		
		//places the array of constants into the model so the view can display
		model.put("issuetypes", IssueType.values());
		model.put("operatingsystems", OperatingSystem.values());
		model.put("webbrowsers", WebBrowser.values());
		return model;
	}

	/**
	 * @return the javaMail
	 */
	public IMailFacade getJavaMail() {
		return javaMail;
	}

	/**
	 * @param javaMail is the object that contains the functionality to send
	 * an email. This javaMail is set by the contactWiseController bean 
	 * in controllers.xml.
	 */
	public void setJavaMail(IMailFacade javaMail) {
		this.javaMail = javaMail;
	}


	/**
	 * @param uiHTMLProperties contains the regularly formatted (regular 
	 * casing and spaces instead of underscores) for the enums. This properties
	 * file is set by the contactWiseController bean in controllers.xml.
	 */
	public void setUiHTMLProperties(Properties uiHTMLProperties) {
		/* these are necessary so that the enums can retrieve the values from 
		the properties file */
		IssueType.setProperties(uiHTMLProperties);
		OperatingSystem.setProperties(uiHTMLProperties);
		WebBrowser.setProperties(uiHTMLProperties);
	}

	/**
	 * @return the projectService
	 */
	public ProjectService getProjectService() {
		return projectService;
	}

	/**
	 * @param projectService the projectService to set
	 */
	public void setProjectService(ProjectService projectService) {
		this.projectService = projectService;
	}
	
}
