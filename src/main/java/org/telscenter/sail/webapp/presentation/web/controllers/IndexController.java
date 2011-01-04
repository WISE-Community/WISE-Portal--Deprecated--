/**
 * Copyright (c) 2007 Regents of the University of California (Regents). Created
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
package org.telscenter.sail.webapp.presentation.web.controllers;

import java.util.Calendar;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.sail.webapp.dao.ObjectNotFoundException;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import org.telscenter.sail.webapp.domain.newsitem.NewsItem;
import org.telscenter.sail.webapp.domain.newsitem.impl.NewsItemImpl;
import org.telscenter.sail.webapp.service.newsitem.NewsItemService;

/**
 * Controller for index pages in TELS
 *
 * @author Hiroki Terashima
 * @version $Id$
 */
public class IndexController extends AbstractController {
	
	private NewsItemService newsItemService;
	
	/** 
	 * @see org.springframework.web.servlet.mvc.AbstractController#handleRequestInternal(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	@SuppressWarnings("unchecked")
	@Override
	protected ModelAndView handleRequestInternal(HttpServletRequest arg0,
			HttpServletResponse arg1) throws Exception {

		NewsItem newsItem;
		try{
			newsItem = newsItemService.retrieveLatest();
		} catch (ObjectNotFoundException e){
			newsItem = new NewsItemImpl();
			newsItem.setDate(Calendar.getInstance().getTime());
			newsItem.setTitle("No News found - default News Title");
			newsItem.setNews("This will be filled with the latest news " +
					"once News Items are created. This can be done by your " +
					"administrator or other helpful WISE personnel.");
		}

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("newsItem", newsItem);
        return modelAndView;
	}

	/**
	 * @param newsItemService the newsItemService to set
	 */
	public void setNewsItemService(NewsItemService newsItemService) {
		this.newsItemService = newsItemService;
	}

}
