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
package org.telscenter.sail.webapp.domain.brainstorm.question.impl;

import java.io.Serializable;
import java.math.BigInteger;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.Lob;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.persistence.Version;

import org.imsglobal.xsd.imsqti_v2p0.SimpleChoiceType;
import org.telscenter.sail.webapp.domain.brainstorm.question.Question;

/**
 * @author Hiroki Terashima
 * @version $Id$
 */
@Entity
@Table(name = QuestionImpl.DATA_STORE_NAME)
@Inheritance(strategy = InheritanceType.JOINED)
public class QuestionImpl implements Question {

    @Transient
    public static final String DATA_STORE_NAME = "brainstormquestions";

    @Transient
    private static final long serialVersionUID = 1L;

    @Transient
	public static final String COLUMN_NAME_BODY = "body";
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    protected Long id = null;
    
    @Version
    @Column(name = "OPTLOCK")
    protected Integer version = null;
    
    @Lob
    @Column(name = QuestionImpl.COLUMN_NAME_BODY)
	protected String body = null;
    
	/**
	 * @see net.sf.sail.webapp.domain.Persistable#getId()
	 */
	public Serializable getId() {
		return id;
	}
	
    /**
     * @param id
     *            the id to set
     */
    @SuppressWarnings("unused")
    protected void setId(Long id) {
        this.id = id;
    }

    /**
     * @return the version
     */
    @SuppressWarnings("unused")
    protected Integer getVersion() {
        return version;
    }

    /**
     * @param version
     *            the version to set
     */
    @SuppressWarnings("unused")
    protected void setVersion(Integer version) {
        this.version = version;
    }

	/**
	 * @return the body
	 */
	public String getBody() {
		return body;
	}

	/**
	 * @param body the body to set
	 */
	public void setBody(String body) {
		this.body = body;
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.question.Question#getAnswerFieldExpectedLines()
	 */
	public BigInteger getAnswerFieldExpectedLines() {
		return null;
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.question.Question#getPrompt()
	 */
	public String getPrompt() {
		return null;
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.question.Question#getCopy()
	 */
	public Question getCopy() {
		Question copy = new QuestionImpl();
		copy.setBody(this.getBody());
		return copy;
	}
	
	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.question.Question#getChoices()
	 */
	public List<SimpleChoiceType> getChoices(){
		return null;
	}
	
	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.question.Question#getCorrectChoice()
	 */
	public String getCorrectChoice(){
		return null;
	}
	
	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.question.Question#getNewChoices()
	 */
	public String getNewChoices(){
		return null;
	}
	
	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.question.Question#setCorrectChoice(java.lang.String)
	 */
	public void setCorrectChoice(String correctChoice){
	}
}
