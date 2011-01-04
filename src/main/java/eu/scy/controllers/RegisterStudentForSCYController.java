package eu.scy.controllers;

/*import eu.scy.core.ScenarioService;
import eu.scy.core.model.impl.pedagogicalplan.ScenarioImpl;
import eu.scy.core.model.pedagogicalplan.Scenario;*/
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.BindException;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.servlet.ModelAndView;
import org.telscenter.sail.webapp.domain.authentication.impl.StudentUserDetails;
import org.telscenter.sail.webapp.presentation.web.StudentAccountForm;
import org.telscenter.sail.webapp.presentation.web.controllers.student.RegisterStudentController;
import org.telscenter.sail.webapp.service.student.StudentService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import net.sf.sail.webapp.domain.User;

/**
 * Created by IntelliJ IDEA.
 * User: Henrik
 * Date: 16.sep.2009
 * Time: 06:27:23
 * To change this template use File | Settings | File Templates.
 */
public class RegisterStudentForSCYController extends RegisterStudentController {

    private StudentService studentService;

    //private ScenarioService scenarioService;


    public RegisterStudentForSCYController() {
        logger.debug("** **** **** CREATING REGISTER STUDENT FOR SCY CONTROLLER!!");
		setValidateOnBinding(false);
	}

    /**
     * On submission of the signup form, a user is created and saved to the data
     * store.
     *
     * @see org.springframework.web.servlet.mvc.SimpleFormController#onSubmit(javax.servlet.http.HttpServletRequest,
     *      javax.servlet.http.HttpServletResponse, java.lang.Object,
     *      org.springframework.validation.BindException)
     */
    @Override
    @Transactional
    protected ModelAndView onSubmit(HttpServletRequest request, HttpServletResponse response, Object command, BindException errors) throws Exception {
        System.out.println("SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
        logger.debug("--- ---- ------ --REGISTERING STUDENT!");
        StudentAccountForm accountForm = (StudentAccountForm) command;
        StudentUserDetails userDetails = (StudentUserDetails) accountForm.getUserDetails();

        //if (accountForm.isNewAccount()) {
            try {
                User user = userService.createUser(userDetails);


           /*     logger.info("Scenarios before: " + getScenarioService().getScenarios().size());
            Scenario scenario = new ScenarioImpl();
            scenario.setName("Hillary");
            logger.info("SCENARIO ID: " + ((ScenarioImpl)scenario).getId());
            getScenarioService().createScenario(scenario);

            ScenarioImpl impl = (ScenarioImpl) scenario;

            logger.info("SCENARIO ID AFTER SAVE: " + impl.getId() + " " + impl.getTimeCreated());
            logger.info("Scenarios after: " + getScenarioService().getScenarios().size());
             */
                //Projectcode projectcode = new Projectcode(accountForm.getProjectCode());
                //studentService.addStudentToRun(user, projectcode);
            } catch (Exception e) {
                e.printStackTrace();
                return showForm(request, response, errors);
            } /*catch (ObjectNotFoundException e) {
	    		errors.rejectValue("projectCode", "error.illegal-projectcode");
	    		return showForm(request, response, errors);
	    	} catch (PeriodNotFoundException e) {
	    		errors.rejectValue("projectCode", "error.illegal-projectcode");
	    		return showForm(request, response, errors);

        //} else {
            //userService.updateUser(userDetails);    // TODO HT: add updateUser() to UserService
        //}
        */
        ModelAndView modelAndView = new ModelAndView(getSuccessView());

        modelAndView.addObject(USERNAME_KEY, userDetails.getUsername());
        return modelAndView;

    }


@Override
	protected void onBindAndValidate(HttpServletRequest request, Object command, BindException errors) {
    System.out.println("******************************************************************************");
        logger.debug("ON BINDE AND VALIDATE STUDENT CONTROLLER!");
		StudentAccountForm accountForm = (StudentAccountForm) command;
		StudentUserDetails userDetails = (StudentUserDetails) accountForm.getUserDetails();
		if (accountForm.isNewAccount()) {
			userDetails.setSignupdate(Calendar.getInstance().getTime());
			Calendar birthday       = Calendar.getInstance();
			int birthmonth = Integer.parseInt(accountForm.getBirthmonth());
			int birthdate = Integer.parseInt(accountForm.getBirthdate());
			birthday.set(Calendar.MONTH, birthmonth-1);  // month is 0-based
			birthday.set(Calendar.DATE, birthdate);
			userDetails.setBirthday(birthday.getTime());
		}

		//getValidator().validate(accountForm, errors);
	}

	@Override
	protected void initBinder(HttpServletRequest request, ServletRequestDataBinder binder) throws Exception
	{
        System.out.println("________________________________________________________________________________________");
        logger.debug("INIT BINDER IN STUDENT CONTROLLER");
	  //super.initBinder(request, binder);
	  binder.registerCustomEditor(Date.class,
	    new CustomDateEditor(new SimpleDateFormat("MM/dd"), false)
	  );
	}



    public void setStudentService(StudentService studentService) {
        System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
        this.studentService = studentService;
    }

    /*public ScenarioService getScenarioService() {
        return scenarioService;
    }

    public void setScenarioService(ScenarioService senScenarioService) {
        this.scenarioService = senScenarioService;
    } */
}
