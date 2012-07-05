/**
 * Copyright (c) 2007 Regents of the University of California (Regents). Created
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
package org.telscenter.sail.webapp.service.premadecomment.impl;

import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import net.sf.sail.webapp.dao.ObjectNotFoundException;
import net.sf.sail.webapp.domain.User;

import org.springframework.transaction.annotation.Transactional;
import org.telscenter.sail.webapp.dao.premadecomment.PremadeCommentDao;
import org.telscenter.sail.webapp.dao.premadecomment.PremadeCommentListDao;
import org.telscenter.sail.webapp.domain.Run;
import org.telscenter.sail.webapp.domain.impl.PremadeCommentListParameters;
import org.telscenter.sail.webapp.domain.impl.PremadeCommentParameters;
import org.telscenter.sail.webapp.domain.premadecomment.PremadeComment;
import org.telscenter.sail.webapp.domain.premadecomment.PremadeCommentList;
import org.telscenter.sail.webapp.domain.premadecomment.impl.PremadeCommentImpl;
import org.telscenter.sail.webapp.domain.premadecomment.impl.PremadeCommentListImpl;
import org.telscenter.sail.webapp.service.premadecomment.PremadeCommentService;

/**
 * @author patrick lawler
 *
 */
public class PremadeCommentServiceImpl implements PremadeCommentService {
	
	private PremadeCommentDao<PremadeComment> premadeCommentDao;
	
	private PremadeCommentListDao<PremadeCommentList> premadeCommentListDao;
	
	@Transactional()
	public PremadeComment createPremadeComment (PremadeCommentParameters param){
		PremadeComment premadeComment = new PremadeCommentImpl();
		premadeComment.setComment(param.getComment());
		premadeComment.setOwner(param.getOwner());
		premadeComment.setListPosition(param.getListPosition());
		
		premadeCommentDao.save(premadeComment);
		return premadeComment;
	}
	
	@Transactional()
	public void deletePremadeComment(Long commentId){
		try{
			PremadeComment premadeComment = premadeCommentDao.getById(commentId);
			premadeCommentDao.delete(premadeComment);
		} catch (ObjectNotFoundException e) {
		}
	}
	
	@Transactional()
	public PremadeComment updatePremadeCommentMessage (Long premadeCommentId, String newComment)
		throws ObjectNotFoundException{
		try{
			PremadeComment premadeComment = premadeCommentDao.getById(premadeCommentId);
			premadeComment.setComment(newComment);
			premadeCommentDao.save(premadeComment);
			return premadeComment;
		} catch (ObjectNotFoundException e){
			throw e;
		}
	}
	
	@Transactional()
	public PremadeComment updatePremadeCommentListPosition (Long premadeCommentId, Long listPosition)
		throws ObjectNotFoundException{
		try{
			PremadeComment premadeComment = premadeCommentDao.getById(premadeCommentId);
			premadeComment.setListPosition(listPosition);
			premadeCommentDao.save(premadeComment);
			return premadeComment;
		} catch (ObjectNotFoundException e){
			throw e;
		}
	}
	
	@Transactional()
	public PremadeComment updatePremadeCommentLabels (Long premadeCommentId, String labels)
		throws ObjectNotFoundException{
		try{
			PremadeComment premadeComment = premadeCommentDao.getById(premadeCommentId);
			premadeComment.setLabels(labels);
			premadeCommentDao.save(premadeComment);
			return premadeComment;
		} catch (ObjectNotFoundException e){
			throw e;
		}
	}
	
	@Transactional()
	public Set<PremadeComment> retrieveAllPremadeComments(){
		TreeSet<PremadeComment> returnSet = new TreeSet<PremadeComment>();
		List<PremadeComment> returnedList = premadeCommentDao.getList();
		
		returnSet.addAll(returnedList);
		return returnSet;
	}
	
	@Transactional()
	public Set<PremadeComment> retrieveAllPremadeCommentsByUser(User user){
		TreeSet<PremadeComment> returnSet = new TreeSet<PremadeComment>();
		returnSet.addAll(premadeCommentDao.getPremadeCommentsByUser(user));
		return returnSet;
	}
	
	@Transactional()
	public PremadeCommentList createPremadeCommentList(PremadeCommentListParameters param){
		PremadeCommentList premadeCommentList = new PremadeCommentListImpl();
		premadeCommentList.setOwner(param.getOwner());
		premadeCommentList.setLabel(param.getLabel());
		premadeCommentList.setGlobal(param.isGlobal());
		premadeCommentList.setPremadeCommentList(param.getList());
		
		premadeCommentListDao.save(premadeCommentList);
		return premadeCommentList;
	}
	
	@Transactional()
	public void deletePremadeCommentList (Long commentListId) throws ObjectNotFoundException {
		try{
			PremadeCommentList premadeCommentList = premadeCommentListDao.getById(commentListId);
			premadeCommentListDao.delete(premadeCommentList);
		}catch (ObjectNotFoundException e){
		}
	}
	
	@Transactional()
	public PremadeCommentList updatePremadeCommentListLabel(Long commentListId, String newLabel)
		throws ObjectNotFoundException{
		try{
			PremadeCommentList premadeCommentList = premadeCommentListDao.getById(commentListId);
			premadeCommentList.setLabel(newLabel);
			premadeCommentListDao.save(premadeCommentList);
			return premadeCommentList;
		} catch (ObjectNotFoundException e){
			throw e;
		}
	}
	
	@Transactional()
	public PremadeCommentList addPremadeCommentToList (Long commentListId, PremadeComment comment)
		throws ObjectNotFoundException{
		try{
			PremadeCommentList premadeCommentList = premadeCommentListDao.getById(commentListId);
			premadeCommentList.getPremadeCommentList().add(comment);
			premadeCommentDao.save(comment);
			premadeCommentListDao.save(premadeCommentList);
			return premadeCommentList;
		} catch (ObjectNotFoundException e){
			throw e;
		}
	}
	
	@Transactional()
	public PremadeCommentList removePremadeCommentFromList (Long commentListId, PremadeComment comment)
		throws ObjectNotFoundException{
		try{
			PremadeCommentList premadeCommentList = premadeCommentListDao.getById(commentListId);
			premadeCommentList.getPremadeCommentList().remove(comment);
			premadeCommentListDao.save(premadeCommentList);
			return premadeCommentList;
		} catch (ObjectNotFoundException e) {
			throw e;
		}
	}
	
	@Transactional()
	public Set<PremadeCommentList> retrieveAllPremadeCommentLists(){
		TreeSet<PremadeCommentList> returnSet = new TreeSet<PremadeCommentList>();
		List<PremadeCommentList> returnedList = premadeCommentListDao.getList();
		
		/*
		int length = returnedList.size();
		
		List<PremadeCommentList> returnedList2 = new ArrayList<PremadeCommentList>();
		
		PremadeCommentList premadeCustomCommentsList = new PremadeCommentListImpl();
		premadeCustomCommentsList.setId((long) 3);
		premadeCustomCommentsList.setLabel("Premade Custom Comments");
		returnedList2.add(premadeCustomCommentsList);
		
		PremadeCommentList premadeCustomCommentsList2 = new PremadeCommentListImpl();
		premadeCustomCommentsList2.setId((long) 4);
		premadeCustomCommentsList2.setLabel("Premade Custom Comments2");
		returnedList2.add(premadeCustomCommentsList2);
		
		returnSet.add(premadeCustomCommentsList);
		returnSet.add(premadeCustomCommentsList2);
		
		//System.out.println(premadeCustomCommentsList);
		
		returnSet.addAll(returnedList2);
		*/
		returnSet.addAll(returnedList);
		return returnSet;
	}
	
	@Transactional()
	public Set<PremadeCommentList> retrieveAllPremadeCommentListsByUser(User user){
		TreeSet<PremadeCommentList> returnSet = new TreeSet<PremadeCommentList>();
		returnSet.addAll(this.premadeCommentListDao.getListByOwner(user));
		return returnSet;
	}
	
	@Transactional()
	public Set<PremadeCommentList> retrieveAllPremadeCommentListsByRun(Run run){
		TreeSet<PremadeCommentList> returnSet = new TreeSet<PremadeCommentList>();
		returnSet.addAll(this.premadeCommentListDao.getListByRun(run));
		return returnSet;		
	}

	/**
	 * @param premadeCommentDao the premadeCommentDao to set
	 */
	public void setPremadeCommentDao(PremadeCommentDao<PremadeComment> premadeCommentDao) {
		this.premadeCommentDao = premadeCommentDao;
	}

	/**
	 * @param premadeCommentListDao the premadeCommentListDao to set
	 */
	public void setPremadeCommentListDao(
			PremadeCommentListDao<PremadeCommentList> premadeCommentListDao) {
		this.premadeCommentListDao = premadeCommentListDao;
	}

	/**
	 * 
	 * @see org.telscenter.sail.webapp.service.premadecomment.PremadeCommentService#retrieveAllGlobalPremadeCommentLists()
	 */
	public Set<PremadeCommentList> retrieveAllGlobalPremadeCommentLists() {
		TreeSet<PremadeCommentList> returnSet = new TreeSet<PremadeCommentList>();
		returnSet.addAll(this.premadeCommentListDao.getListByGlobal());
		return returnSet;		
	}
	

	@Transactional()
	public PremadeCommentList retrievePremadeCommentListById(Long id){
		return this.premadeCommentListDao.getListById(id);		
	}
	

	@Transactional()
	public PremadeComment retrievePremadeCommentById(Long id){
		PremadeComment premadeComment = null;
		try {
			premadeComment = this.premadeCommentDao.getById(id);
		} catch (ObjectNotFoundException e) {
			e.printStackTrace();
		}		
		
		return premadeComment;
	}
}
