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
package org.telscenter.sail.webapp;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;

import org.springframework.beans.BeanInstantiationException;
import org.springframework.beans.BeanUtils;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.telscenter.sail.webapp.dao.module.impl.RooloOtmlModuleDao;
import org.telscenter.sail.webapp.domain.impl.CreateOtmlModuleParameters;

import net.sf.sail.webapp.service.curnit.CurnitService;
import net.sf.sail.webapp.spring.SpringConfiguration;

/**
 * Adds default otml curnits to local database.
 * 
 * @author Hiroki Terashima
 * @version $Id$
 */
public class CreateDefaultOtmlCurnits {

	private CurnitService curnitService;

	public CreateDefaultOtmlCurnits(
			ConfigurableApplicationContext applicationContext) {
		this.setCurnitService((CurnitService) applicationContext.getBean("curnitService"));
	}
	
	public void createDefaultCurnits(ConfigurableApplicationContext applicationContext) {
		 createCurnit("airbags", CreateDefaultOtmlCurnits.class.getResource("airbags.otml"));
	}

	/**
	 * Creates Default Curnits
	 * @param args
	 */
	public static void main(String[] args) {		
		try {
	        ConfigurableApplicationContext applicationContext = null;
			SpringConfiguration springConfig;
			springConfig = (SpringConfiguration) BeanUtils
			.instantiateClass(Class.forName("org.telscenter.sail.webapp.spring.impl.SpringConfigurationImpl"));
			applicationContext = new ClassPathXmlApplicationContext(
					springConfig.getRootApplicationContextConfigLocations());
			CreateDefaultOtmlCurnits cdoc = new CreateDefaultOtmlCurnits(applicationContext);
			cdoc.createDefaultCurnits(applicationContext);
			applicationContext.close();
		} catch (BeanInstantiationException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	private void createCurnit(String name, URL otmlUrl) {
		// Create a curnit
		CreateOtmlModuleParameters params = new CreateOtmlModuleParameters();
		try {
			FileInputStream fis;
				fis = new FileInputStream( new File(otmlUrl.toURI()) );
			
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			byte [] buffer = new byte[4096];
			int read;
				while ( (read = fis.read(buffer))!= -1) {
					baos.write( buffer, 0, read);
				}
			
			fis.close();
			params.setOtml(baos.toByteArray());
		} catch (URISyntaxException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		params.setName(name);
		params.setUrl(RooloOtmlModuleDao.defaultOtrunkCurnitUrl);
		curnitService.createCurnit(params);
	}

	
	/**
	 * @param curnitService the curnitService to set
	 */
	public void setCurnitService(CurnitService curnitService) {
		this.curnitService = curnitService;
	}

}
