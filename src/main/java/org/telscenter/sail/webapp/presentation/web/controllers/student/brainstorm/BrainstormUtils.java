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
package org.telscenter.sail.webapp.presentation.web.controllers.student.brainstorm;

import java.io.Serializable;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.xml.bind.JAXBElement;

import org.apache.commons.lang.StringUtils;
import org.imsglobal.xsd.imsqti_v2p0.ImgType;
import org.imsglobal.xsd.imsqti_v2p0.SimpleChoiceType;

/**
 * @author patrick lawler
 * @version $Id:$
 */
public final class BrainstormUtils {
	
	private final static String IDENTIFIER = "<simpleChoice identifier=\"";
	
	private final static String BEFORECONTENT = "\">";
	
	private final static String AFTERCONTENT = "</simpleChoice>";

	public static String replaceTags(SimpleChoiceType choice){
		if(!(choice.getContent().get(0) instanceof String)){
			if(((JAXBElement)choice.getContent().get(0)).getDeclaredType()==ImgType.class){
				return "<img src=\"" + ((ImgType)((JAXBElement)choice.getContent().get(0)).getValue()).getSrc() + "\"/>";
			} else {
				return "";
			}
		} else {
			return replaceTagsOut((String) choice.getContent().get(0));
		}
	}
	
	public static String replaceTags(String str){
		if(str.contains("<")){
			str = str.replaceAll("<", "&lt;");
		}
		if(str.contains(">")){
			str = str.replaceAll(">", "&gt;");
		}
		return str;
	}
	
	public static String replaceTagsOut(String str){
		if(str.contains("&lt;")){
			str = str.replaceAll("&lt;", "<");
		}
		if(str.contains("&gt;")){
			str = str.replaceAll("&gt;", ">");
		}
		return str;
	}
	
	public static String replaceSimpleChoiceStringTags(String str){
		Map<String, String> choiceMap = parseChoices(str);
		String retStr = "";
		for(String key : choiceMap.keySet()){
			retStr = retStr + IDENTIFIER + key + BEFORECONTENT + replaceTags(choiceMap.get(key)) + AFTERCONTENT;
		}
		return retStr;
	}
	
	public static Map<String, Serializable> getChoiceMap(List<SimpleChoiceType> choices){
		Map<String, Serializable> choiceMap = new LinkedHashMap<String, Serializable>();
		for(SimpleChoiceType choice : choices){
			choiceMap.put(choice.getIdentifier(), replaceTags(choice));
		}
		return choiceMap;
	}
	
	public static Map<String, String> parseChoices(String choiceList) {
		Map<String, String> choiceMap = new LinkedHashMap<String, String>();
		while(choiceList != null && choiceList != "" && StringUtils.contains(choiceList, "simpleChoice")){
			choiceList = StringUtils.removeStart(choiceList, IDENTIFIER);
			String key = StringUtils.substring(choiceList, 0, StringUtils.indexOf(choiceList, "\""));
			choiceList = StringUtils.removeStart(choiceList, key);
			choiceList = StringUtils.removeStart(choiceList, BEFORECONTENT);
			String content = StringUtils.substring(choiceList, 0, StringUtils.indexOf(choiceList, AFTERCONTENT));
			choiceList = StringUtils.removeStart(choiceList, content);
			choiceList = StringUtils.removeStart(choiceList, AFTERCONTENT);
			choiceMap.put(key, replaceTags(content));
		}
		return choiceMap;
	}
}
