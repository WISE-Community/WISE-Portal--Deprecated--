package eu.scy.controllers;

/*import eu.scy.core.*;
import eu.scy.core.model.impl.pedagogicalplan.*;
import eu.scy.core.model.pedagogicalplan.*;
*/

import net.sf.sail.webapp.presentation.web.controllers.ControllerUtil;
//import org.acegisecurity.BadCredentialsException;
//import org.acegisecurity.userdetails.UserDetails;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import org.telscenter.sail.webapp.service.project.ProjectService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by IntelliJ IDEA.
 * User: Henrik
 * Date: 15.okt.2009
 * Time: 00:16:30
 * To change this template use File | Settings | File Templates.
 */
public class ViewScenarioBankController extends AbstractController {

    protected static final String VIEW_NAME = "admin/scenarios";

    //private ScenarioService scenarioService;

    private ProjectService projectService;

    public ViewScenarioBankController() {
        super();
        logger.info("********** ******** CREATED VIEW!!!");
    }

    /*@Override
    @Transactional
    public ModelAndView handleRequest(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws Exception {
        logger.info("******* ******** *****HANDLING REQUEST!!!!");
        Scenario scenario = new ScenarioImpl();
            scenario.setName("Hillaryyyy");
            logger.info("HR: SCENARIO ID: " + ((ScenarioImpl)scenario).getId());
            logger.info("Scenarios before: " + getScenarioService().getScenarios().size());
            getScenarioService().createScenario(scenario);
            logger.info("Scenarios after: " + getScenarioService().getScenarios().size());
            logger.info("HR: SCENARIO ID AFTER SAVE: " + ((ScenarioImpl)scenario).getId());
        return super.handleRequest(httpServletRequest, httpServletResponse);    //To change body of overridden methods use File | Settings | File Templates.
    } */

    @Override
    @Transactional
    protected ModelAndView handleRequestInternal(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws Exception {
        logger.info("******* ******** *****HANDLING REQUEST INTERNAL !!!!");
        ModelAndView modelAndView = null;


        /*try {
            modelAndView = new ModelAndView(VIEW_NAME);
            ControllerUtil.addUserToModelAndView(httpServletRequest, modelAndView);

            Scenario scenario = new ScenarioImpl();
            scenario.setName("DA SCENARIO");

            LearningActivitySpace planning = new LearningActivitySpaceImpl();
            planning.setName("Planning");
            scenario.setLearningActivitySpace(planning);


            Activity firstActivity = new ActivityImpl();
            firstActivity.setName("Gather in the big hall and listen to your teacher");
            planning.addActivity(firstActivity);

            Activity conceptMappingSession = new ActivityImpl();
            conceptMappingSession.setName("Concept mapping");
            planning.addActivity(conceptMappingSession);

            AnchorELO conceptMap = new AnchorELOImpl();
            conceptMap.setName("Expected concept map");
            conceptMappingSession.setAnchorELO(conceptMap);

            LearningActivitySpace lastSpace = new LearningActivitySpaceImpl();
            lastSpace.setName("Evaluation");
            conceptMap.setInputTo(lastSpace);


            //logger.info("Scenarios before: " + getScenarioService().getScenarios().size());
            getScenarioService().createScenario(scenario);

            ScenarioImpl impl = (ScenarioImpl) scenario;

            logger.info("SCENARIO ID AFTER SAVE: " + impl.getId() + " " + impl.getTimeCreated());
            //logger.info("Scenarios after: " + getScenarioService().getScenarios().size());
            modelAndView.addObject("TULL", "TULLING");
            modelAndView.addObject("MODEL", scenario);
            modelAndView.addObject("SCENARIOS", getScenarioService().getScenarios());
        } catch (Exception e) {
            logger.debug(e);
            e.printStackTrace();
        }
                    */
        return modelAndView;
    }


    /* public ScenarioService getScenarioService() {
       return scenarioService;
   }

   public void setScenarioService(ScenarioService scenarioService) {
       this.scenarioService = scenarioService;
   }

   public ProjectService getProjectService() {
       return projectService;
   }

   public void setProjectService(ProjectService projectService) {
       this.projectService = projectService;
   } */
}
