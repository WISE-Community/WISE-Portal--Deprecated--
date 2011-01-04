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
package org.telscenter.sail.webapp.domain.brainstorm;

import java.util.Date;
import java.util.Map;
import java.util.Set;

import org.telscenter.sail.webapp.domain.Run;
import org.telscenter.sail.webapp.domain.brainstorm.answer.Answer;
import org.telscenter.sail.webapp.domain.brainstorm.answer.PreparedAnswer;
import org.telscenter.sail.webapp.domain.brainstorm.question.Question;
import org.telscenter.sail.webapp.domain.project.Project;
import org.telscenter.sail.webapp.domain.workgroup.WISEWorkgroup;

import net.sf.sail.webapp.domain.Persistable;

/**
 * Brainstorm (aka "Q&A") interface. A Brainstorm has:
 * -- a question, usually made by teachers
 * -- 0 or more answers (or "posts") usually made by students
 * 
 * @author Hiroki Terashima
 * @version $Id$
 */
public interface Brainstorm extends Persistable {
	
	/**
	 * Returns the <code>Question</code> for this brainstorm.
	 * 
	 * @return <code>Question</code> this <code>Brainstorm</code>'s
	 *     question.
	 */
	public Question getQuestion();
	
	/**
	 * Set the <code>Question</code> for this brainstorm.
	 * 
	 * @param <code>Question</code> this <code>Brainstorm</code>'s
	 *     question.
	 */
	public void setQuestion(Question question);
	
	/**
	 * Returns a list of <code>Answer</code> for this brainstorm, filtered
	 * by the subgroups of the logged-in user, if such subgroup exists.
	 * 
	 * @return a List of <code>Answer</code> 
	 */
	public Set<Answer> getAnswers();
	
	/**
	 * Sets a list of <code>Answer</code> for this brainstorm.
	 * 
	 * @param a List of <code>Answer</code> 
	 */
	public void setAnswers(Set<Answer> answers);

	/**
	 * Returns a set of PreparedAnswer for this brainstorm.
	 * 
	 * @param answers
	 */
	public Set<PreparedAnswer> getPreparedAnswers();

	/**
	 * Sets a set of PreparedAnswer for this brainstorm.
	 * 
	 * @param answers
	 */
	public void setPreparedAnswers(Set<PreparedAnswer> answers);

	/**
	 * Adds an <code>Answer</code> to this brainstorm.
	 * 
	 * @param answer Add this Answer to this Brainstorm.
	 */
	public void addAnswer(Answer answer);
	
	/**
	 * Indicates whether the students posts to this brainstorm anonymously
	 * 
	 * @return true iff students can post anonymously on this brainstorm.
	 */
	public boolean isAnonymousAllowed();
	
	/**
	 * Indicates whether the students can use the RichTextEditor
	 * 
	 * @param true iff students can use the RichTextEditor
	 */
	public void setRichTextEditorAllowed(boolean isRichTextEditorAllowed);
	
	/**
	 * Indicates whether the students can use the RichTextEditor
	 * 
	 * @return true iff students can use the RichTextEditor
	 */
	public boolean isRichTextEditorAllowed();
	
	/**
	 * Indicates whether the students posts to this brainstorm anonymously
	 * 
	 * @param true iff students can post anonymously on this brainstorm.
	 */
	public void setAnonymousAllowed(boolean isPostingAnonymousAllowed);
	
	/**
	 * Return the <code>Run</code> that this Brainstorm is for
	 * 
	 * @return <code>Run</code> that this Brainstorm has
	 *    been set up in.
	 */
	public Run getRun();
	
	/**
	 * Set the <code>Run</code> that this Brainstorm is for
	 * 
	 * @param <code>Run</code> that this Brainstorm has
	 *    been set up in.
	 */
	public void setRun(Run run);
	
	/**
	 * Returns this Brainstorm's parent brainstormId.  If this
	 * Brainstorm does not have a parent, return null.
	 * 
	 * @return <code>Long</code> this Brainstorm's parent's Id.
	 */
	public Long getParentBrainstormId();
	
	/**
	 * Sets this Brainstorm's parent brainstormId.
	 * 
	 * @param parentBrainstormId the Id of this Brainstorm's parent
	 * Brainstorm.
	 */
	public void setParentBrainstormId(Long parentBrainstormId);
	
	/**
	 * Returns the Project that has this brainstorm.
	 * 
	 * @return the project
	 */
	public Project getProject();

	/**
	 * Sets the Project that has this brainstorm. 
	 * @param project the project to set
	 */
	public void setProject(Project project);
	
	/**
	 * Returns a Set of Workgroups that has requested for help
	 * on this Brainstorm.
	 * 
	 * @return <code>Set</code> of <code>WISEWorkgroup</code>.
	 */
	public Set<WISEWorkgroup> getWorkgroupsThatRequestHelp();
	
	/**
	 * Indicate that the specified workgroup is requesting 
	 * help to this brainstorm.
	 * 
	 * @param workgroup
	 */
	public void addWorkgroupThatRequestHelp(WISEWorkgroup workgroup);
	
	/**
	 * Indicates that the specified workgroup is no longer
	 * seeking help on this brainstorm.
	 * 
	 * @param workgroup
	 */
	public void removeWorkgroupThatRequestHelp(WISEWorkgroup workgroup);

	/**
	 * Returns an association of workgroup and their last visited timestamp
	 * on this brainstorm step.
	 * 
	 * @return <code>Map</code> of <code>WISEWorkgroup</code> and 
	 *     <code>Date</code>
	 */
	public Map<WISEWorkgroup, Date> getWorkgroupLastVisitedMap();
	
	/**
	 * Returns when this brainstorm step session has started.  If it has,
	 * students will be able to post.
	 * 
	 * @return true iff this brainstorm session has started.
	 */
	public boolean isSessionStarted();

	/**
	 * Sets when this brainstorm step session has started.  If it has,
	 * students will be able to post.
	 * 
	 * @param true iff this brainstorm session has started.
	 */
	public void setSessionStarted(boolean sessionStarted);
	/**
	 * Returns whether the students need to submit a post before seeing responses
	 * from other students or if they can see responses from others without first
	 * posting a response.
	 * 
	 * @return true iff students need to post a response before seeing 
	 * others' posts.
	 */
	public boolean isGated();
	
	/**
	 * @param isGated the isGated to set
	 */
	public void setGated(boolean isGated);
	
	/**
	 * Returns whether the specified workgroup has posted an answer to this
	 * brainstorm yet.
	 * 
	 * @return true iff the workgroup has posted a response to this workgroup.
	 */
	public boolean hasWorkgroupPosted(WISEWorkgroup workgroup);
	
	/**
	 * Returns whether the specified workgroup can see other students' 
	 * responses.
	 * 
	 * @param workgroup
	 * @return
	 */
	public boolean canWorkgroupSeeResponses(WISEWorkgroup workgroup);
	
	/**
	 * Returns how the students' responses should be labeled.
	 * @return the displayNameOption
	 */
	public DisplayNameOption getDisplayNameOption();

	/**
	 * Sets how the students' responses should be labeled.
	 * @param displayNameOption the displayNameOption to set
	 */
	public void setDisplayNameOption(DisplayNameOption displayNameOption);
	
	/**
	 * Returns a copy of this Brainstorm object. Does not save in datastore
	 * but only instantiates a new copy of this object.
	 * 
	 * @return a new instance of this project with same attributes
	 * except id and version.
	 */
	public Brainstorm getCopy();
	
	/**
	 * Sets the type of Question for this brainstorm
	 * 
	 * @param <code>Questiontype</code> questiontype
	 */
	public void setQuestiontype(Questiontype questiontype);
	
	/**
	 * Returns the type of Question for this brainstorm
	 * 
	 * @return <code>Questiontype<code>
	 */
	public Questiontype getQuestiontype();
	
	/**
	 * Allows students to then view feedback, graphs, charts, etc.
	 * of the results of a poll.
	 * 
	 * @param <code>boolean</code> ended
	 */
	public void setPollEnded(boolean ended);
	
	/**
	 * @return <code>boolean</code>
	 */
	public boolean isPollEnded();
	
	/**
	 * Sets whether this instant poll is currently active
	 * @param <code>boolean</code> active
	 */
	public void setInstantPollActive(boolean active);
	
	/**
	 * @return <code>boolean</code>
	 */
	public boolean isInstantPollActive();
}
