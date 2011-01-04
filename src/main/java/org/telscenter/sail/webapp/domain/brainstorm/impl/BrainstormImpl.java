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
package org.telscenter.sail.webapp.domain.brainstorm.impl;

import java.util.Calendar;
import java.util.Date;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.persistence.Version;

import org.hibernate.annotations.Cascade;
import org.hibernate.annotations.Sort;
import org.hibernate.annotations.SortType;
import org.telscenter.sail.webapp.domain.Run;
import org.telscenter.sail.webapp.domain.brainstorm.Brainstorm;
import org.telscenter.sail.webapp.domain.brainstorm.DisplayNameOption;
import org.telscenter.sail.webapp.domain.brainstorm.Questiontype;
import org.telscenter.sail.webapp.domain.brainstorm.answer.Answer;
import org.telscenter.sail.webapp.domain.brainstorm.answer.PreparedAnswer;
import org.telscenter.sail.webapp.domain.brainstorm.answer.impl.AnswerImpl;
import org.telscenter.sail.webapp.domain.brainstorm.answer.impl.PreparedAnswerImpl;
import org.telscenter.sail.webapp.domain.brainstorm.question.Question;
import org.telscenter.sail.webapp.domain.brainstorm.question.impl.JaxbQuestionImpl;
import org.telscenter.sail.webapp.domain.brainstorm.question.impl.QuestionImpl;
import org.telscenter.sail.webapp.domain.impl.RunImpl;
import org.telscenter.sail.webapp.domain.project.Project;
import org.telscenter.sail.webapp.domain.project.impl.ProjectImpl;
import org.telscenter.sail.webapp.domain.workgroup.WISEWorkgroup;
import org.telscenter.sail.webapp.domain.workgroup.impl.WISEWorkgroupImpl;

/**
 * Simple brainstorm implementation.
 * 
 * @author Hiroki Terashima
 * @version $Id$
 */
@Entity
@Table(name = BrainstormImpl.DATA_STORE_NAME)
public class BrainstormImpl implements Brainstorm {

	@Transient
	private static final long serialVersionUID = 1L;

    @Transient
    public static final String DATA_STORE_NAME = "brainstorms";
    
    @Transient
    public static final String ANSWERS_JOIN_TABLE_NAME = "brainstorms_related_to_brainstormanswers";
    
    @Transient
	private static final String PREPAREDANSWERS_JOIN_TABLE_NAME = "brainstorms_related_to_brainstormpreparedanswers";

    @Transient
    public static final String BRAINSTORMS_JOIN_COLUMN_NAME = "brainstorms_fk";

    @Transient
    public static final String ANSWERS_JOIN_COLUMN_NAME = "brainstormanswers_fk";

    @Transient
	private static final String PREPAREDANSWERS_JOIN_COLUMN_NAME = "brainstormpreparedanswers_fk";

    @Transient
    public static final String QUESTIONS_JOIN_COLUMN_NAME = "brainstormquestions_fk";
    
    @Transient
    public static final String COLUMN_NAME_RUN_FK = "runs_fk";

    @Transient
    private static final String COLUMN_NAME_PROJECT_FK = "projects_fk";

    @Transient
	private static final String COLUMN_NAME_ISANONYMOUSALLOWED = "isanonymousallowed";

    @Transient
	private static final String COLUMN_NAME_ISGATED = "isgated";

    @Transient
	private static final String WORKGROUPS_JOIN_TABLE_NAME = "brainstorms_related_to_workgroups";

    @Transient
	private static final String WORKGROUP_JOIN_COLUMN_NAME = "workgroups_fk";

    @Transient
	private static final String COLUMN_NAME_STARTTIME = "starttime";

    @Transient
	private static final String COLUMN_NAME_DISPLAYNAME_OPTION = "displaynameoption";

    @Transient
    private static final String COLUMN_NAME_ISRICHTEXTEDITORALLOWED = "isrichtexteditorallowed";

    @Transient
	private static final String COLUMN_NAME_PARENTBRAINSTORMID = "parent_brainstorm_id";
    
    @Transient
    private static final String COLUMN_NAME_QUESTIONTYPE = "questiontype";
    
    @Transient
    private static final String COLUMN_NAME_ISPOLLENDED = "ispollended";
    
    @Transient
    private static final String COLUMN_NAME_ISINSTANTPOLLACTIVE = "isinstantpollactive";

    @OneToMany(cascade = CascadeType.ALL, targetEntity = AnswerImpl.class, fetch = FetchType.LAZY)
    @JoinTable(name = ANSWERS_JOIN_TABLE_NAME, joinColumns = { @JoinColumn(name = BRAINSTORMS_JOIN_COLUMN_NAME, nullable = false) }, inverseJoinColumns = @JoinColumn(name = ANSWERS_JOIN_COLUMN_NAME, nullable = false))
    @Sort(type = SortType.NATURAL)
	private Set<Answer> answers = new TreeSet<Answer>();

    @OneToMany(cascade = CascadeType.ALL, targetEntity = PreparedAnswerImpl.class, fetch = FetchType.LAZY)
    @JoinTable(name = PREPAREDANSWERS_JOIN_TABLE_NAME, joinColumns = { @JoinColumn(name = BRAINSTORMS_JOIN_COLUMN_NAME, nullable = false) }, inverseJoinColumns = @JoinColumn(name = PREPAREDANSWERS_JOIN_COLUMN_NAME, nullable = false))
    @Sort(type = SortType.NATURAL)
	private Set<PreparedAnswer> preparedAnswers = new TreeSet<PreparedAnswer>();

    @OneToOne(cascade = CascadeType.ALL, targetEntity = QuestionImpl.class, fetch = FetchType.EAGER)
    @JoinColumn(name = QUESTIONS_JOIN_COLUMN_NAME)
	private Question question = new JaxbQuestionImpl();
	
	@ManyToOne(cascade = CascadeType.ALL, targetEntity = RunImpl.class)
    @Cascade( { org.hibernate.annotations.CascadeType.SAVE_UPDATE })
    @JoinColumn(name = COLUMN_NAME_RUN_FK, unique = false)
	private Run run;   // if the run is not specified, this brainstorm is not able to be used by students.
	
	@ManyToOne(targetEntity = ProjectImpl.class)
	@JoinColumn(name = COLUMN_NAME_PROJECT_FK)
    private Project project;   // project that this brainstorm is in.
	
    @ManyToMany(targetEntity = WISEWorkgroupImpl.class, fetch = FetchType.LAZY)
    @JoinTable(name = BrainstormImpl.WORKGROUPS_JOIN_TABLE_NAME, joinColumns = { @JoinColumn(name = BRAINSTORMS_JOIN_COLUMN_NAME, nullable = false)}, inverseJoinColumns = @JoinColumn(name = WORKGROUP_JOIN_COLUMN_NAME, nullable = false))
    private Set<WISEWorkgroup> workgroupsThatRequestHelp = new TreeSet<WISEWorkgroup>();
	
	@Column(name = BrainstormImpl.COLUMN_NAME_ISANONYMOUSALLOWED)
	private boolean isAnonymousAllowed;
	
	@Column(name = BrainstormImpl.COLUMN_NAME_DISPLAYNAME_OPTION)
	private DisplayNameOption displayNameOption;

	@Column(name = BrainstormImpl.COLUMN_NAME_ISGATED)	
	private boolean isGated;
	
	@Column(name = BrainstormImpl.COLUMN_NAME_ISRICHTEXTEDITORALLOWED)	
	private boolean isRichTextEditorAllowed;
	
    @Column(name = BrainstormImpl.COLUMN_NAME_STARTTIME)
	private Date starttime;

    @Column(name = BrainstormImpl.COLUMN_NAME_PARENTBRAINSTORMID)
    private Long parentBrainstormId = null;
    
    @Column(name = BrainstormImpl.COLUMN_NAME_QUESTIONTYPE)
    private Questiontype questiontype;
    
    @Column(name = BrainstormImpl.COLUMN_NAME_ISPOLLENDED)
    private boolean isPollEnded;
    
    @Column(name = BrainstormImpl.COLUMN_NAME_ISINSTANTPOLLACTIVE)
    private boolean isInstantPollActive;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id = null;
    
    @Version
    @Column(name = "OPTLOCK")
    private Integer version = null;
	
	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.Brainstorm#getAnswers()
	 */
	public Set<Answer> getAnswers() {
		return answers;
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.Brainstorm#getQuestion()
	 */
	public Question getQuestion() {
		return question;
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.Brainstorm#getRun()
	 */
	public Run getRun() {
		return run;
	}

	 /**
     * @return the id
     */
    public Long getId() {
        return id;
    }

    /**
     * @param id
     *            the id to set
     */
    @SuppressWarnings("unused")
    private void setId(Long id) {
        this.id = id;
    }

    /**
     * @return the version
     */
    @SuppressWarnings("unused")
    private Integer getVersion() {
        return version;
    }

    /**
     * @param version
     *            the version to set
     */
    @SuppressWarnings("unused")
    private void setVersion(Integer version) {
        this.version = version;
    }

    /**
     * @see org.telscenter.sail.webapp.domain.brainstorm.Brainstorm#setRun(org.telscenter.sail.webapp.domain.Run)
     */
	public void setRun(Run run) {
		this.run = run;
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.Brainstorm#setAnswers(java.util.Set)
	 */
	public void setAnswers(Set<Answer> answers) {
		this.answers = answers;
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.Brainstorm#addAnswer(org.telscenter.sail.webapp.domain.brainstorm.answer.Answer)
	 */
	public void addAnswer(Answer answer) {
		this.answers.add(answer);
	}

	/**
	 * @return the preparedAnswers
	 */
	public Set<PreparedAnswer> getPreparedAnswers() {
		return preparedAnswers;
	}

	/**
	 * @param preparedAnswers the preparedAnswers to set
	 */
	public void setPreparedAnswers(Set<PreparedAnswer> preparedAnswers) {
		this.preparedAnswers = preparedAnswers;
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.Brainstorm#setQuestion(org.telscenter.sail.webapp.domain.brainstorm.question.Question)
	 */
	public void setQuestion(Question question) {
		this.question = question;
	}

	/**
	 * @return the parentBrainstormId
	 */
	public Long getParentBrainstormId() {
		return parentBrainstormId;
	}

	/**
	 * @param parentBrainstormId the parentBrainstormId to set
	 */
	public void setParentBrainstormId(Long parentBrainstormId) {
		this.parentBrainstormId = parentBrainstormId;
	}

	/**
	 * @return the isAnonymousAllowed
	 */
	public boolean isAnonymousAllowed() {
		return isAnonymousAllowed;
	}

	/**
	 * @param isAnonymousAllowed the isAnonymousAllowed to set
	 */
	public void setAnonymousAllowed(boolean isAnonymousAllowed) {
		this.isAnonymousAllowed = isAnonymousAllowed;
	}

	public Map<WISEWorkgroup, Date> getWorkgroupLastVisitedMap() {
		// TODO Auto-generated method stub
		return null;
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.Brainstorm#getWorkgroupsThatRequestHelp()
	 */
	public Set<WISEWorkgroup> getWorkgroupsThatRequestHelp() {
		return workgroupsThatRequestHelp;
	}

	/**
	 * @param workgroupsThatRequestHelp the workgroupsThatRequestHelp to set
	 */
	public void setWorkgroupsThatRequestHelp(
			Set<WISEWorkgroup> workgroupsThatRequestHelp) {
		this.workgroupsThatRequestHelp = workgroupsThatRequestHelp;
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.Brainstorm#addWorkgroupThatRequestHelp(org.telscenter.sail.webapp.domain.workgroup.WISEWorkgroup)
	 */
	public void addWorkgroupThatRequestHelp(WISEWorkgroup workgroup) {
		this.workgroupsThatRequestHelp.add(workgroup);
	}
	
	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.Brainstorm#removeWorkgroupThatRequestHelp(org.telscenter.sail.webapp.domain.workgroup.WISEWorkgroup)
	 */
	public void removeWorkgroupThatRequestHelp(WISEWorkgroup workgroup) {
		this.workgroupsThatRequestHelp.remove(workgroup);
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.Brainstorm#isGated()
	 */
	public boolean isGated() {
		return isGated;
	}

	/**
	 * @param isGated the isGated to set
	 */
	public void setGated(boolean isGated) {
		this.isGated = isGated;
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.Brainstorm#isSessionStarted()
	 */
	public boolean isSessionStarted() {
		if (starttime == null) {
			return false;
		}
		return Calendar.getInstance().getTime().after(this.starttime);
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.Brainstorm#setSessionStarted(boolean)
	 */
	public void setSessionStarted(boolean sessionStarted) {
		if (sessionStarted) {
			starttime = Calendar.getInstance().getTime();
		} else {
			starttime = null;
		}
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.Brainstorm#hasWorkgroupPosted(org.telscenter.sail.webapp.domain.workgroup.WISEWorkgroup)
	 */
	public boolean hasWorkgroupPosted(WISEWorkgroup workgroup) {
		Set<Answer> allAnswers = this.answers;
		for (Answer anAnswer : allAnswers) {
			if (anAnswer.getWorkgroup().equals(workgroup)) {
				return true;
			}
		}
		return false;
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.Brainstorm#canWorkgroupSeeResponses(org.telscenter.sail.webapp.domain.workgroup.WISEWorkgroup)
	 */
	public boolean canWorkgroupSeeResponses(WISEWorkgroup workgroup) {
		return (isSessionStarted() && !isGated())
		    || (isSessionStarted() && isGated() && hasWorkgroupPosted(workgroup));
	}

	/**
	 * @return the starttime
	 */
	public Date getStarttime() {
		return starttime;
	}

	/**
	 * @param starttime the starttime to set
	 */
	public void setStarttime(Date starttime) {
		this.starttime = starttime;
	}

	/**
	 * @return the project
	 */
	public Project getProject() {
		return project;
	}

	/**
	 * @param project the project to set
	 */
	public void setProject(Project project) {
		this.project = project;
	}

	/**
	 * @return the displayNameOption
	 */
	public DisplayNameOption getDisplayNameOption() {
		return displayNameOption;
	}

	/**
	 * @param displayNameOption the displayNameOption to set
	 */
	public void setDisplayNameOption(DisplayNameOption displayNameOption) {
		this.displayNameOption = displayNameOption;
	}

	/**
	 * @return the isRichTextEditorAllowed
	 */
	public boolean isRichTextEditorAllowed() {
		return isRichTextEditorAllowed;
	}

	/**
	 * @param isRichTextEditorAllowed the isRichTextEditorAllowed to set
	 */
	public void setRichTextEditorAllowed(boolean isRichTextEditorAllowed) {
		this.isRichTextEditorAllowed = isRichTextEditorAllowed;
	}
	
	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.Brainstorm#getCopy()
	 */
	public Brainstorm getCopy() {
		Brainstorm copy = new BrainstormImpl();
		copy.setDisplayNameOption(this.getDisplayNameOption());
		copy.setAnonymousAllowed(this.isAnonymousAllowed());
		Set<PreparedAnswer> preparedAnswers2 = this.getPreparedAnswers();
		for (PreparedAnswer preparedAnswer : preparedAnswers2) {
			PreparedAnswer copyPreparedAnswer = new PreparedAnswerImpl();
			copyPreparedAnswer.setBody(preparedAnswer.getBody());
			copyPreparedAnswer.setDisplayname(preparedAnswer.getDisplayname());
			copy.getPreparedAnswers().add(copyPreparedAnswer);
		}
		copy.setGated(this.isGated);
		copy.setParentBrainstormId(this.getId());
		copy.setProject(this.getProject());
		copy.setQuestion(this.getQuestion().getCopy());
		copy.setRichTextEditorAllowed(this.isRichTextEditorAllowed());
		copy.setSessionStarted(this.isSessionStarted());
		copy.setInstantPollActive(this.isInstantPollActive);
		copy.setPollEnded(this.isPollEnded);
		copy.setQuestiontype(this.questiontype);
		return copy;
	}

	/**
	 * @return the questiontype
	 */
	public Questiontype getQuestiontype() {
		return questiontype;
	}

	/**
	 * @param questiontype the questiontype to set
	 */
	public void setQuestiontype(Questiontype questiontype) {
		this.questiontype = questiontype;
	}

	/**
	 * @return the isPollEnded
	 */
	public boolean isPollEnded() {
		return isPollEnded;
	}

	/**
	 * @param isPollEnded the isPollEnded to set
	 */
	public void setPollEnded(boolean isPollEnded) {
		this.isPollEnded = isPollEnded;
	}

	/**
	 * @return the isInstantPollActive
	 */
	public boolean isInstantPollActive() {
		return isInstantPollActive;
	}

	/**
	 * @param isInstantPollActive the isInstantPollActive to set
	 */
	public void setInstantPollActive(boolean isInstantPollActive) {
		this.isInstantPollActive = isInstantPollActive;
	}
}
