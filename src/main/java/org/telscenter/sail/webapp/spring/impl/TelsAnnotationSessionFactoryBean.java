/**
 * Copyright (c) 2013 Regents of the University of California (Regents). Created
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
package org.telscenter.sail.webapp.spring.impl;

import java.io.IOException;
import java.util.Properties;

import org.hibernate.cfg.AnnotationConfiguration;
import org.springframework.orm.hibernate3.annotation.AnnotationSessionFactoryBean;

/**
 * Overrides default behavior to account for loading in properties via portal.properties file
 * @author Hiroki Terashima
 * @version $Id:$
 */
public class TelsAnnotationSessionFactoryBean extends
		AnnotationSessionFactoryBean {
	
	protected void postProcessAnnotationConfiguration(AnnotationConfiguration config) {
		Properties portalProperties = new Properties();
    	try {
    		portalProperties.load(TelsAnnotationSessionFactoryBean.class.getClassLoader().getResourceAsStream("portal.properties"));
		} catch (IOException e) {
			// pretend like nothing happened.
			e.printStackTrace();
		}
    	config.addProperties(portalProperties);  // add extra property overrides (like url,username,password) in vle.properties
	}

}
