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
package org.telscenter.sail.webapp.service.repository;

import java.net.URI;

import roolo.elo.api.IELO;
import roolo.elo.api.IMetadata;

/**
 * Service for communicating with the Repository
 * 
 * @author Hiroki Terashima
 * @version $Id$
 */
public interface RepositoryService {
	
	/**
	 * Retrieves IELO from the repository given
	 * the URI.
	 * 
	 * @param uri <code>URI</code> uniquely identifies the IELO
	 * in the repository
	 * @return <code>IELO</code> what is retrieved from
	 * the repository
	 */
	public IELO getByUri(URI uri);
	
	/**
	 * Adds an IELO to the repository and returns the metadata.
	 * 
	 * @param <code>IELO</code> elo
	 * @return <code>IMetadata</code>
	 */
	public IMetadata addELO(IELO elo);

	/**
	 * Removes an IELO from the repository
	 * 
	 * @param <code>URI</code>
	 */
	public void removeELO(URI uri);
}
