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

import java.text.NumberFormat;

/**
 * @author patrick lawler
 * @version $Id:$
 */
public class NavStep implements Comparable<NavStep>{
		
	private int open;
	
	private int close;
	
	private String activityNum;
	
	private String stepNum;
	
	private String podId;
	
	private NumberFormat nf = NumberFormat.getInstance();
	
	public NavStep(){
		nf.setMaximumFractionDigits(1);
		nf.setGroupingUsed(false);
	}

	/**
	 * @return the <code>int</code> duration for this step in milliseconds
	 */
	public int getDurationMilliseconds(){
		return this.close - this.open;
	}
	
	/**
	 * @return the <code>float</code> duration for this step in seconds
	 */
	public float getDurationSeconds(){
		return Float.parseFloat(nf.format(this.getDurationMilliseconds() / 1000f));
	}
	
	/**
	 * @return the <code>float</code> duration for this step in minutes
	 */
	public float getDurationMinutes(){
		return Float.parseFloat(nf.format(this.getDurationSeconds() / 60));
	}
	
	/**
	 * @return the <code>String</code> representation of the Activity 
	 * number and Step number for this NavStep
	 */
	public String getActivityStepString(){
		return "A" + (Integer.parseInt(this.activityNum) + 1) + " S" +
			(Integer.parseInt(this.stepNum) + 1);
	}
	
	/**
	 * @return <code>String</code> a unique number comprised of the Activity
	 * number concatenated with the dot operater and the Step number for this
	 * NavStep
	 */
	public String getUniqueOrderedNum(){
		return this.activityNum + "." + this.stepNum;
	}
	
	/**
	 * @return a <code>NavStep</code> copy of this NavStep
	 */
	public NavStep copy(){
		NavStep newStep = new NavStep();
		newStep.setClose(this.close);
		newStep.setOpen(this.open);
		newStep.setActivityNum(this.activityNum);
		newStep.setPodId(this.podId);
		newStep.setStepNum(this.stepNum);
		return newStep;
	}
	
	/**
	 * @return whether this step has been closed or not
	 */
	public boolean isClosed(){
		return this.close > 0;
	}

	/**
	 * @return the open
	 */
	public int getOpen() {
		return open;
	}

	/**
	 * @param open the open to set
	 */
	public void setOpen(int open) {
		this.open = open;
	}

	/**
	 * @return the close
	 */
	public int getClose() {
		return close;
	}

	/**
	 * @param close the close to set
	 */
	public void setClose(int close) {
		this.close = close;
	}

	public int compareTo(NavStep o) {
		return this.getOpen() - o.getOpen();
	}

	/**
	 * @return the activityNum
	 */
	public String getActivityNum() {
		return activityNum;
	}

	/**
	 * @param activityNum the activityNum to set
	 */
	public void setActivityNum(String activityNum) {
		this.activityNum = activityNum;
	}

	/**
	 * @return the stepNum
	 */
	public String getStepNum() {
		return stepNum;
	}

	/**
	 * @param stepNum the stepNum to set
	 */
	public void setStepNum(String stepNum) {
		this.stepNum = stepNum;
	}

	/**
	 * @return the podId
	 */
	public String getPodId() {
		return podId;
	}

	/**
	 * @param podId the podId to set
	 */
	public void setPodId(String podId) {
		this.podId = podId;
	}

}
