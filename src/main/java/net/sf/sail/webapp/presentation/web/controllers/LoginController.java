/**
 * Copyright (c) 2006 Encore Research Group, University of Toronto
 * 
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 */
package net.sf.sail.webapp.presentation.web.controllers;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.StringUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;

/**
 * @author Cynick Young
 * 
 * @version $Id$
 * 
 */
public class LoginController extends AbstractController {

  /**
   * @see org.springframework.web.servlet.mvc.AbstractController#handleRequestInternal(javax.servlet.http.HttpServletRequest,
   *      javax.servlet.http.HttpServletResponse)
   */
  @Override
  protected ModelAndView handleRequestInternal(HttpServletRequest request,
      HttpServletResponse response) throws Exception {
    String failed = request.getParameter("failed");
    String redirectUrl = request.getParameter("redirect");
    
    //get the user name that we will use to pre-populate the Username field
    String userName = request.getParameter("userName");
    
    ModelAndView modelAndView = new ModelAndView();
    if (StringUtils.hasText(failed)) {
      modelAndView.addObject("failed", Boolean.TRUE);
    }
    
    if(StringUtils.hasText(redirectUrl)){
    	modelAndView.addObject("redirect",redirectUrl);
    }
    
    if(userName != null) {
    	//make the userName available to the jsp page
    	modelAndView.addObject("userName", userName);
    }
    return modelAndView;
  }
}