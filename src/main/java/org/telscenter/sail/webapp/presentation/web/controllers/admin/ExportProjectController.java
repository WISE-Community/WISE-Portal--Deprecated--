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
package org.telscenter.sail.webapp.presentation.web.controllers.admin;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Properties;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.sail.webapp.domain.impl.CurnitGetCurnitUrlVisitor;
import net.sf.sail.webapp.service.curnit.CurnitService;

import org.apache.commons.io.IOUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import org.telscenter.sail.webapp.domain.project.Project;
import org.telscenter.sail.webapp.service.project.ProjectService;

/**
 * @author hirokiterashima
 * @version $Id:$
 */
public class ExportProjectController extends AbstractController {

	private ProjectService projectService;
	
	private CurnitService curnitService;

	private Properties portalProperties;

	static final int BUFFER = 2048;

	/**
	 * @see org.springframework.web.servlet.mvc.AbstractController#handleRequestInternal(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	@Override
	protected ModelAndView handleRequestInternal(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		String projectId = request.getParameter("projectId");
		Project project = projectService.getById(projectId);
		String curriculumBaseDir = portalProperties.getProperty("curriculum_base_dir");

		String sep = System.getProperty("file.separator");

		String rawProjectUrl = (String) project.getCurnit().accept(new CurnitGetCurnitUrlVisitor());
		String projectJSONFullPath = curriculumBaseDir + sep + rawProjectUrl;
		String foldername = rawProjectUrl.substring(1, rawProjectUrl.lastIndexOf(sep));
		String projectJSONDir = projectJSONFullPath.substring(0, projectJSONFullPath.lastIndexOf(sep));
		
		response.setContentType("application/zip");
		response.addHeader("Content-Disposition", "attachment;filename=\"" + foldername+".zip" + "\"");
		//response.setHeader("filename", foldername+".zip");
		// zip the folder and write to outputstream		
		ServletOutputStream outputStream = response.getOutputStream();

		//create ZipOutputStream object
		ZipOutputStream out = new ZipOutputStream(
				new BufferedOutputStream(outputStream));

		
		//path to the folder to be zipped
		File zipFolder = new File(projectJSONDir);
		
		//get path prefix so that the zip file does not contain the whole path
		// eg. if folder to be zipped is /home/lalit/test
		// the zip file when opened will have test folder and not home/lalit/test folder
		int len = zipFolder.getAbsolutePath().lastIndexOf(File.separator);
		String baseName = zipFolder.getAbsolutePath().substring(0,len+1);
		
		addFolderToZip(zipFolder, out, baseName);
		
		out.close();

		
		/*
		try {
			BufferedInputStream origin = null;
			ZipOutputStream out = new ZipOutputStream(new 
					BufferedOutputStream(outputStream));
			out.setMethod(ZipOutputStream.STORED);  // do not compress files
			byte data[] = new byte[BUFFER];
			// get a list of files from project json dir
			File f = new File(projectJSONDir);
			String files[] = f.list();

			for (int i=0; i<files.length; i++) {
				System.out.println("Adding: "+files[i]);
				FileInputStream fi = new 
				FileInputStream(projectJSONDir + sep + files[i]);
				origin = new 
				BufferedInputStream(fi, BUFFER);
				ZipEntry entry = new ZipEntry(files[i]);
				out.putNextEntry(entry);
				int count;
				while((count = origin.read(data, 0, 
						BUFFER)) != -1) {
					out.write(data, 0, count);
				}
				origin.close();
			}
			out.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		*/
		return null;
	}

	private static void addFolderToZip(File folder, ZipOutputStream zip, String baseName) throws IOException {
		File[] files = folder.listFiles();
		for (File file : files) {
			if (file.isDirectory()) {
				// add folder to zip
				String name = file.getAbsolutePath().substring(baseName.length());
				ZipEntry zipEntry = new ZipEntry(name+"/");
				zip.putNextEntry(zipEntry);
				zip.closeEntry();
				addFolderToZip(file, zip, baseName);
			} else {
				String name = file.getAbsolutePath().substring(baseName.length());
				ZipEntry zipEntry = new ZipEntry(name);
				zip.putNextEntry(zipEntry);
				IOUtils.copy(new FileInputStream(file), zip);
				zip.closeEntry();
			}
		}
	}

	private void cleanUp(InputStream in) throws Exception
	{
		in.close();
	}

	private void cleanUp(OutputStream out) throws Exception
	{
		out.flush();
		out.close();
	}

	/**
	 * @param projectService the projectService to set
	 */
	public void setProjectService(ProjectService projectService) {
		this.projectService = projectService;
	}

	/**
	 * @param curnitService the curnitService to set
	 */
	public void setCurnitService(CurnitService curnitService) {
		this.curnitService = curnitService;
	}

	/**
	 * @param portalProperties the portalProperties to set
	 */
	public void setPortalProperties(Properties portalProperties) {
		this.portalProperties = portalProperties;
	}

}
