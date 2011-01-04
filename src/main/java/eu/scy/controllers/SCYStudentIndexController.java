package eu.scy.controllers;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by IntelliJ IDEA.
 * User: Henrik
 * Date: 11.nov.2009
 * Time: 21:44:43
 * To change this template use File | Settings | File Templates.
 */
public class SCYStudentIndexController extends AbstractController {

    private static final String VIEW_NAME="student/index";

    @Override
    protected ModelAndView handleRequestInternal(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws Exception {
        ModelAndView modelAndView = new ModelAndView(VIEW_NAME);
        return modelAndView;  //To change body of implemented methods use File | Settings | File Templates.
    }
}
