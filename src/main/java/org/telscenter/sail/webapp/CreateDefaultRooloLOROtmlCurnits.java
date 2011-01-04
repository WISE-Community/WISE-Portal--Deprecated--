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
import java.io.IOException;
import java.net.URISyntaxException;
import java.net.URL;

import net.sf.sail.webapp.service.curnit.CurnitService;
import net.sf.sail.webapp.spring.SpringConfiguration;

import org.springframework.beans.BeanInstantiationException;
import org.springframework.beans.BeanUtils;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.telscenter.sail.webapp.dao.module.impl.RooloLOROtmlModuleDao;
import org.telscenter.sail.webapp.domain.impl.CreateRooloLOROtmlModuleParameters;

import roolo.elo.BasicELO;
import roolo.elo.ELOMetadataKeys;
import roolo.elo.api.IContent;
import roolo.elo.api.IELO;
import roolo.elo.api.IMetadata;
import roolo.elo.api.IMetadataValueContainer;
import roolo.elo.api.IRepository;

/**
 * Adds default otml-curnits into Roolo repository.
 * 
 * @author Hiroki Terashima
 * @version $Id: CreateDefaultRooloOtmlCurnits.java 2102 2008-09-17 23:26:15Z hiroki $
 */
public class CreateDefaultRooloLOROtmlCurnits {
	
	private IRepository rep;
	private static final String WS_URL = "http://tels-web.soe.berkeley.edu:8080/lor/services/LORService";
	private static final String WS_USER = "admin";
	private static final String WS_PASS = "admin";
	    
	private CurnitService curnitService;
	
	
	public CreateDefaultRooloLOROtmlCurnits(
			ConfigurableApplicationContext applicationContext) {
		this.setCurnitService((CurnitService) applicationContext.getBean("curnitService"));
	}

	private IELO createAirbagsCurnit() {
		IELO curnit = createCurnit("hydrogencarsweb.otml");
		return curnit;
	}

	private IELO createChemicalReactionsCurnit() {
		IELO curnit = createCurnit("ChemicalReactions.otml");
		return curnit;
	}
	
	private IELO createCurnit(String filename) {
		// Create a curnit
		IELO curnit = new BasicELO();
		// Create content
		IContent content = curnit.getContent();
		URL url = CreateDefaultRooloLOROtmlCurnits.class.getResource(filename);

		try {
			FileInputStream fis;
				fis = new FileInputStream( new File(url.toURI()) );
			
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			byte [] buffer = new byte[4096];
			int read;
				while ( (read = fis.read(buffer))!= -1) {
					baos.write( buffer, 0, read);
				}
			
			fis.close();
			content.setBytes( baos.toByteArray());
			
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
		
		IMetadata metadata1 = curnit.getMetadata();
		IMetadataValueContainer container;
		container = metadata1.getMetadataValueContainer(ELOMetadataKeys.TITLE.getKey());
		container.setValue(filename);
		container = metadata1.getMetadataValueContainer(ELOMetadataKeys.TYPE.getKey());
		container.setValue("Curnit");
		container = metadata1.getMetadataValueContainer(ELOMetadataKeys.DESCRIPTION.getKey());
		container.setValue("This is a test curnit based on a curnit");
		container = metadata1.getMetadataValueContainer(ELOMetadataKeys.AUTHOR.getKey());
		container.setValue("tony p");
		container = metadata1.getMetadataValueContainer(ELOMetadataKeys.FAMILYTAG.getKey());
		container.setValue("TELS");
		container = metadata1.getMetadataValueContainer(ELOMetadataKeys.ISCURRENT.getKey());
		container.setValue("yes");

		return curnit;
	}


	
	public void createDefaultCurnits(ConfigurableApplicationContext applicationContext) {
		// Create repository
		//rep = rep = new RooloEnlaceLOR(WS_URL, WS_USER, WS_PASS);
		IELO airbagsCurnit = createAirbagsCurnit();
		rep.addELO(airbagsCurnit);
		saveToLocalDb(applicationContext, airbagsCurnit);
		
//		LearningObject chemicalReactionsCurnit = createChemicalReactionsCurnit();
//		rep.addELO(chemicalReactionsCurnit);
//		saveToLocalDb(applicationContext, chemicalReactionsCurnit);
		
//		CurnitProxy meiosisCurnit = createMeiosisCurnit();
//		rep.addELO(meiosisCurnit);
//		saveToLocalDb(applicationContext, meiosisCurnit);
//		
//		
//		CurnitProxy hydrogenCarsCurnit = createHydrogenCarsCurnit();
//		rep.addELO(hydrogenCarsCurnit);
//		saveToLocalDb(applicationContext, hydrogenCarsCurnit);
//		
//		CurnitProxy globalWarmingCurnit = createGlobalWarmingCurnit();
//		rep.addELO(globalWarmingCurnit);
//		saveToLocalDb(applicationContext, globalWarmingCurnit);
//		
//		
//		CurnitProxy thermodynamicsCurnit = createThermodynamicsCurnit();
//		rep.addELO(thermodynamicsCurnit);
//		saveToLocalDb(applicationContext, thermodynamicsCurnit);
//
//		CurnitProxy diyCurnit = createDiyCurnit();
//		rep.addELO(diyCurnit);
//		saveToLocalDb(applicationContext, diyCurnit);

	}

	/**
	 * @param applicationContext 
	 * @param lo
	 */
	private void saveToLocalDb(ConfigurableApplicationContext applicationContext, IELO lo) {
		CreateRooloLOROtmlModuleParameters params = (CreateRooloLOROtmlModuleParameters) 
		    applicationContext.getBean("createRooloLOROtmlModuleParameters");
		params.setName(lo.getMetadata().getMetadataValueContainer(ELOMetadataKeys.TITLE.getKey()).getValue().toString());
		params.setUrl(RooloLOROtmlModuleDao.defaultOtrunkCurnitUrl);
		//params.setUrl("http://rails.dev.concord.org/curnits/otrunk-curnit-external-diytest.jar");
		params.setRoolouri(lo.getUri().toString());
		params.setRooloRepositoryUrl(RooloLOROtmlModuleDao.rooloRepositoryUrl);
		params.setLearningObject(lo);
		curnitService.createCurnit(params);
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

			CreateDefaultRooloLOROtmlCurnits cdc = new CreateDefaultRooloLOROtmlCurnits(applicationContext);
			cdc.createDefaultCurnits(applicationContext);
			applicationContext.close();
		} catch (BeanInstantiationException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
//		cdc.createDefaultProjects();
	}

	/**
	 * @param curnitService the curnitService to set
	 */
	public void setCurnitService(CurnitService curnitService) {
		this.curnitService = curnitService;
	}
}
