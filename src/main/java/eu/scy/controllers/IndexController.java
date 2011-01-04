package eu.scy.controllers;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by IntelliJ IDEA.
 * User: Henrik
 * Date: 26.nov.2009
 * Time: 10:23:39
 * To change this template use File | Settings | File Templates.
 */
public class IndexController extends AbstractController {

    protected ModelAndView handleRequestInternal(HttpServletRequest arg0,
			HttpServletResponse arg1) throws Exception {

        ModelAndView modelAndView = new ModelAndView();
        return modelAndView;
	}

    
}
