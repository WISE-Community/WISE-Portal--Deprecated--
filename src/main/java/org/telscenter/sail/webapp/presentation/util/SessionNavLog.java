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
package org.telscenter.sail.webapp.presentation.util;

import java.util.Set;

import org.telscenter.pas.emf.pas.EStep;

/**
 * A representation of a specific SessionBundle's navigation log
 * 
 * @author patrick lawler
 * @version $Id:$
 */
public interface SessionNavLog {

	/**
	 * Returns the total duration of all the steps completed
	 * during this session
	 * 
	 * @return <code>int</code>
	 */
	public int getTotalTime();
	
	/**
	 * Returns a <code>Set<NavStep></code> which contain information
	 * about the steps visited during this session
	 * 
	 * @return <code>Set<NavStep></code>
	 */
	public Set<NavStep> getNavSteps();
	
	/**
	 * Returns <code>int</code> the average amount of time spent on
	 * each step for this session
	 * 
	 * @return <code>int</code>
	 */
	public int getAverageTimeSpentPerStep();
	
	/**
	 * Returns the <code>NavStep</code> that the student spent the most
	 * time on
	 */
	public NavStep getLongestTimeSpentStep();
	
	/**
	 * Returns the <code>NavStep</code> that the student spent the least
	 * amount of time on
	 */
	public NavStep getLeastTimeSpentStep();
}
