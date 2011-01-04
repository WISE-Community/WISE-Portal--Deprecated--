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

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.Serializable;
import java.math.BigInteger;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.xml.bind.JAXBException;

import net.sf.sail.jaxb.extension.BlockInteractionType;
import net.sf.sail.jaxb.extension.JaxbQtiMarshallingUtils;
import net.sf.sail.jaxb.extension.JaxbQtiCreationUtils;

import org.apache.commons.lang.StringUtils;
import org.imsglobal.xsd.imsqti_v2p0.AssessmentItemType;
import org.imsglobal.xsd.imsqti_v2p0.ChoiceInteractionType;
import org.imsglobal.xsd.imsqti_v2p0.CorrectResponseType;
import org.imsglobal.xsd.imsqti_v2p0.ExtendedTextInteractionType;
import org.imsglobal.xsd.imsqti_v2p0.SimpleChoiceType;
import org.telscenter.sail.webapp.domain.brainstorm.question.Question;
import org.telscenter.sail.webapp.presentation.web.controllers.student.brainstorm.BrainstormUtils;

/**
 * @author Anthony Perritano
 * @version $Id$
 */
@Entity
@Table(name = JaxbQuestionImpl.DATA_STORE_NAME)
public class JaxbQuestionImpl extends QuestionImpl {

	@Transient
	public static final String DATA_STORE_NAME = "jaxbquestions";
	
	@Transient
	private static final long serialVersionUID = 1L;

	/**
	 * The assessment Items for this question
	 */
	@Transient
	protected AssessmentItemType assessmentItemType;
	
	/**
	 * an interaction can be a choice or interaction
	 */
	@Transient	
	protected BlockInteractionType blockInteractionType;
	
	/**
	 * Prompt of this question, this is a substring of the body
	 */
	@Transient
	protected String prompt;
	
	/**
	 * The body will be xml formatted JAXB QTI String. It will also unmarshall the XML
	 * 
	 * @param body the body to set
	 */
	public void setBody(String body) {
		this.body = body;
		parseToQTI(this.body);
	}

	/**
	 * @param body
	 */
	private void parseToQTI(String body) {
		if(body == null)
			throw new NullPointerException();
			
		InputStream is = new ByteArrayInputStream(body.getBytes());
		try {
			assessmentItemType = JaxbQtiMarshallingUtils.unmarshallAssessmentItemType(is);
			is.close();
		} catch (IOException ioe) {
			ioe.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//parse the blockinteraction for this question it will only have one part
		//for now
		blockInteractionType = (BlockInteractionType) assessmentItemType.getItemBody().getBlockElementGroup().get(0);
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.question.impl.QuestionImpl#getAnswerFieldExpectedLines()
	 */
	public BigInteger getAnswerFieldExpectedLines() {
		
		if( blockInteractionType instanceof ExtendedTextInteractionType)
			return ((ExtendedTextInteractionType) blockInteractionType).getExpectedLines();
		
		return new BigInteger("0");
	}

	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.question.impl.QuestionImpl#getPrompt()
	 */
	@Override
	public String getPrompt() {
		if (blockInteractionType == null) {
			parseToQTI(this.body);
		}
		List<Serializable> blockContent = blockInteractionType.getPrompt().getContent();
		
		if(blockContent != null) {
			return BrainstormUtils.replaceTagsOut((String) blockContent.get(0));
		}
		return null;
	}

	/**
	 * @param prompt the prompt to set
	 */
	public void setPrompt(String prompt) {
		this.prompt = BrainstormUtils.replaceTags(prompt);

		if (blockInteractionType == null) {
			parseToQTI(this.body);
		}
		List<Serializable> blockContent = blockInteractionType.getPrompt().getContent();
		
		if(blockContent != null) {
			blockContent.set(0,this.prompt);
			try {
				this.body = JaxbQtiMarshallingUtils.marshallAssessmentItemTypeToString(assessmentItemType);
			} catch (JAXBException e) {
				e.printStackTrace();
			}
		}

	}
	
	
	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.question.Question#getCopy()
	 */
	public Question getCopy() {
		JaxbQuestionImpl copy = new JaxbQuestionImpl();
		copy.setBody(this.getBody());
		return copy;
	}

	/**
	 * @return the choices
	 */
	@Override
	public List<SimpleChoiceType> getChoices() {
		if (blockInteractionType == null) {
			parseToQTI(this.body);
		}
		if(blockInteractionType instanceof ChoiceInteractionType){
			return ((ChoiceInteractionType) blockInteractionType).getSimpleChoice();
		}
		return null;
	}

	public void setNewChoices(String choiceList){
		if (blockInteractionType == null) {
			parseToQTI(this.body);
		}
		List<SimpleChoiceType> copiedChoices = new LinkedList<SimpleChoiceType>();
		copiedChoices.addAll(this.getChoices());
		for(SimpleChoiceType choice : copiedChoices){
			JaxbQtiCreationUtils.removeChoice(this.blockInteractionType, choice);
		}
		
		if(choiceList != null && choiceList != ""){
			Map<String, String> choiceMap = BrainstormUtils.parseChoices(choiceList);
			for(String key : choiceMap.keySet()){
				this.addChoice(key, choiceMap.get(key));
			}
		}
		
		try {
			this.body = JaxbQtiMarshallingUtils.marshallAssessmentItemTypeToString(assessmentItemType);
		} catch (JAXBException e) {
			e.printStackTrace();
		}		
	}
	
	/**
	 * @see org.telscenter.sail.webapp.domain.brainstorm.question.impl.QuestionImpl#getNewChoices()
	 */
	@Override
	public String getNewChoices(){
		return "";
	}
	
	/**
	 * @param choices the choices to set
	 */
	public void setChoices(String choiceList) {
	}

	public void addChoice(String identifier, String content){
		if(this.blockInteractionType instanceof ChoiceInteractionType){
			JaxbQtiCreationUtils.addSimpleChoice(BrainstormUtils.replaceTags(identifier), BrainstormUtils.replaceTags(content), (ChoiceInteractionType)this.blockInteractionType, false);
		}
	}
	
	public void setCorrectChoice(String identifier){
		if (blockInteractionType == null) {
			parseToQTI(this.body);
		}
		this.assessmentItemType.getResponseDeclaration().get(0).getCorrectResponse().getValue().get(0).setValue(identifier);
	
		try {
			this.body = JaxbQtiMarshallingUtils.marshallAssessmentItemTypeToString(assessmentItemType);
		} catch (JAXBException e) {
			e.printStackTrace();
		}
	}
	
	public String getCorrectChoice(){
		if (blockInteractionType == null) {
			parseToQTI(this.body);
		}
		if(this.assessmentItemType.getResponseDeclaration().isEmpty()){
			return null;
		} else {
			return this.assessmentItemType.getResponseDeclaration().get(0).getCorrectResponse().getValue().get(0).getValue();
		}
	}
}
