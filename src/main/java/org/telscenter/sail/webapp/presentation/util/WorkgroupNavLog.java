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

import java.util.List;
import java.util.Map;

import org.telscenter.pas.emf.pas.EStep;

/**
 * Representation of the Sds navigation log for a workgroup
 * 
 * @author patrick lawler
 * @version $Id:$
 */
public interface WorkgroupNavLog {

	/**
	 * Returns the total time <code>int</code> in milliseconds that 
	 * this workgroup has spent on the activities and steps so far
	 * 
	 * @return <code>int</code>
	 */
	public int getTotalTime();
	
	/**
	 * Returns the average time <code>int</code> in milliseconds that this
	 * workgroup has spent on all activities and steps - conflated for multiple 
	 * visits
	 * 
	 * @return <code>int</code>
	 */
	public int getAverageTimeSpentPerStep();
	
	/**
	 * Returns the average time <code>int</code> in milliseconds that this workgroup
	 * has spent on a steps visited - multiple visits are not conflated
	 * 
	 * @return <code>int</code>
	 */
	public int getAverageTimeSpentPerVisit();
	
	/**
	 * Returns the total number <code>int</code> of unique steps for this 
	 * project
	 * 
	 * @return <code>int</code>
	 */
	public int getNumOfSteps();
	
	/**
	 * Returns the number <code>int</code> of visits to steps (not necessarily
	 * unique) for this project
	 * 
	 * @return <code>int</code>
	 */
	public int getNumOfVisits();
		
	/**
	 * Returns the <code>NavStep</code> of the step that the workgroup cumulatively
	 * spent the longest amount of time on
	 * 
	 * @return <code>NavStep</code>
	 */
	public NavStep getLongestTimeSpentStep();
	
	/**
	 * Returns the <code>NavStep</code> of the step visited that the workgroup
	 * spent the longest time on - not cumulative
	 * 
	 * @return <code>NavStep</code>
	 */
	public NavStep getLongestTimeSpentVisit();
	
	/**
	 * Returns the <code>NavStep</code> of the step that the workgroup spent
	 * the least amount of time on - cumulative for the step
	 * 
	 * @return <code>NavStep</code>
	 */
	public NavStep getLeastTimeSpentStep();
	
	/**
	 * Returns the <code>NavStep</code> of the the step visited that the workgroup
	 * spent the least amount of time on - not cumulative
	 * 
	 * @return <code>NavStep</code>
	 */
	public NavStep getLeastTimeSpentVisit();
	
	/**
	 * Returns a <code>Map<Integer,NavStep></code> keyed in the sequence that
	 * the students visited the step - Integer is the time in minutes from
	 * starting the project that the student visited that particular NavStep
	 * 
	 * @return <code>Map<Integer,NavStep></code>
	 */
	public Map<Float,NavStep> getTimeStepMap();
	
	/**
	 * Returns a <code>Map<String,Integer></code> keyed and ordered by the 
	 * unique Activity Step number - each value duration is the accumulated time over
	 * all sessions that a student spent on that step
	 * 
	 * @return <code>Map<String,Integer></code>
	 */
	public Map<String,Float> getTotalTimePerStepMap();
	
	/**
	 * Returns a <code>List<EStep></code>, all steps associated with the run for this
	 * WorkgroupNavLog
	 * 
	 * @return <code>List<EStep></code>
	 */
	public List<EStep> getAllSteps();
}
