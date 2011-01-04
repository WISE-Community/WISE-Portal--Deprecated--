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
package org.telscenter.sail.webapp.dao.brainstorm.impl;

import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import net.sf.sail.webapp.domain.Curnit;
import net.sf.sail.webapp.domain.Jnlp;
import net.sf.sail.webapp.domain.impl.CurnitImpl;
import net.sf.sail.webapp.domain.impl.JnlpImpl;
import net.sf.sail.webapp.domain.sds.SdsCurnit;
import net.sf.sail.webapp.domain.sds.SdsJnlp;
import net.sf.sail.webapp.domain.sds.SdsOffering;

import org.hibernate.Session;
import org.telscenter.sail.webapp.dao.AbstractTransactionalDaoTests;
import org.telscenter.sail.webapp.domain.Run;
import org.telscenter.sail.webapp.domain.brainstorm.Brainstorm;
import org.telscenter.sail.webapp.domain.brainstorm.impl.BrainstormImpl;
import org.telscenter.sail.webapp.domain.brainstorm.question.Question;
import org.telscenter.sail.webapp.domain.brainstorm.question.impl.QuestionImpl;
import org.telscenter.sail.webapp.domain.project.Project;
import org.telscenter.sail.webapp.domain.project.impl.ProjectImpl;

/**
 * @author hirokiterashima
 * @version $Id$
 */
public class HibernateBrainstormDaoTest extends AbstractTransactionalDaoTests<HibernateBrainstormDao, Brainstorm> {

	private static final String SDS_OFFERING_NAME = "offering name";

    private static final Long SDS_CURNIT_ID = new Long(7);

    private static final Long SDS_JNLP_ID = new Long(5);

	private static final Long SDS_ID = new Long(7);
    
    private static final String CURNIT_NAME = "Airbags Curnit";

    private static final String CURNIT_URL = "http://curnitmrpotatoiscoolerthanwoody.com";

    private static final String JNLP_NAME = "Airbags JNLP";

    private static final String JNLP_URL = "http://jnlpmrpotatoiscoolerthanwoody.com";
	
	private Question question;
	
	private String questionbody;
	
	private Run run;
	
	private SdsOffering sdsOffering;
	
	private static final Curnit DEFAULT_CURNIT = new CurnitImpl();

	private static final Jnlp DEFAULT_JNLP = new JnlpImpl();
	
	private static final SdsCurnit DEFAULT_SDS_CURNIT = new SdsCurnit();

	private static final SdsJnlp DEFAULT_SDS_JNLP = new SdsJnlp();
	
	private static final Date START_TIME = Calendar.getInstance().getTime();

	private static final Date END_TIME = Calendar.getInstance().getTime();
	
	private static final String RUNCODE = "abcde-123";
	
	private static Project DEFAULT_PROJECT = new ProjectImpl();
	
	/**
     * @see net.sf.sail.webapp.junit.AbstractTransactionalDbTests#onSetUpBeforeTransaction()
     */
    @Override
    protected void onSetUpBeforeTransaction() throws Exception {
    	super.onSetUpBeforeTransaction();
    	this.dao = (HibernateBrainstormDao) this.applicationContext
    	    .getBean("brainstormDao");
    	this.dataObject = (BrainstormImpl) this.applicationContext
    	    .getBean("brainstorm");
    	this.question = (QuestionImpl) this.applicationContext
	        .getBean("brainstormquestion");
    	this.questionbody = "watch this video and write two thoughts";
    	this.question.setBody(this.questionbody);
    	
        DEFAULT_SDS_CURNIT.setSdsObjectId(SDS_CURNIT_ID);
        DEFAULT_SDS_CURNIT.setName(CURNIT_NAME);
        DEFAULT_SDS_CURNIT.setUrl(CURNIT_URL);

        DEFAULT_SDS_JNLP.setSdsObjectId(SDS_JNLP_ID);
        DEFAULT_SDS_JNLP.setName(JNLP_NAME);
        DEFAULT_SDS_JNLP.setUrl(JNLP_URL);
    	
    	this.run = (Run) this.applicationContext
    	    .getBean("run");
    	this.run.setStarttime(START_TIME);
    	this.run.setEndtime(END_TIME);
		this.run.setRuncode(RUNCODE);
    	this.sdsOffering = (SdsOffering) this.applicationContext.getBean("sdsOffering");
    	this.sdsOffering.setName(SDS_OFFERING_NAME);
		this.sdsOffering.setSdsObjectId(SDS_ID);
		
    	this.dataObject.setQuestion(this.question);
    	this.dataObject.setRun(this.run);
    	
        DEFAULT_CURNIT.setSdsCurnit(DEFAULT_SDS_CURNIT);
        DEFAULT_PROJECT.setCurnit(DEFAULT_CURNIT);
        DEFAULT_JNLP.setSdsJnlp(DEFAULT_SDS_JNLP);
        DEFAULT_PROJECT.setJnlp(DEFAULT_JNLP);
    }
    
	/**
	 * @see org.springframework.test.AbstractTransactionalSpringContextTests#onSetUpInTransaction()
	 */
	@Override
	protected void onSetUpInTransaction() throws Exception {
		super.onSetUpInTransaction();
		Session session = this.sessionFactory.getCurrentSession();
	
		session.save(DEFAULT_SDS_CURNIT); // save sds curnit
		session.save(DEFAULT_SDS_JNLP); // save sds jnlp
        session.save(DEFAULT_CURNIT);  // save curnit
        session.save(DEFAULT_JNLP);  // save jnlp
        session.save(DEFAULT_PROJECT);  // save project
		this.sdsOffering.setSdsCurnit(DEFAULT_SDS_CURNIT);
    	this.sdsOffering.setSdsJnlp(DEFAULT_SDS_JNLP);
    	this.run.setSdsOffering(this.sdsOffering);
    	this.run.setProject(DEFAULT_PROJECT);
    	session.save(this.question);
    	session.save(this.run);
	}
	


	/**
	 * @see net.sf.sail.webapp.dao.AbstractTransactionalDaoTests#testSave()
	 */
	@Override	
	public void testSave() {
//		assertTrue(true);
		verifyDataStoreIsEmpty();
		this.dao.save(this.dataObject);
		this.toilet.flush();
		
        // verify data store contains saved data using direct jdbc retrieval
        // (not using dao)
		List<?> actualList = retrieveBrainstormListFromDb();
		assertEquals(1, actualList.size());
		
		Map<?,?> actualBrainstormMap = (Map<?,?>) actualList.get(0);
		assertEquals(this.questionbody,
				actualBrainstormMap.get(QuestionImpl.COLUMN_NAME_BODY.toUpperCase()));
	}
	
	 /**
     * @see net.sf.sail.webapp.dao.AbstractTransactionalDaoTests#testDelete()
     */
    @Override
    public void testDelete() {
    	// TODO HIROKI implement me
    	assertTrue(true);
    }
    
    /**
     * @see net.sf.sail.webapp.dao.AbstractTransactionalDaoTests#testGetList()
     */
    @Override
    public void testGetList() {
    	// TODO HIROKI implement me
    	assertTrue(true);
    }
    
    /**
     * @see net.sf.sail.webapp.dao.AbstractTransactionalDaoTests#testGetById()
     */
    @Override
    public void testGetById() {
    	// TODO HIROKI implement me
    	assertTrue(true);
    }
    
	/**
	 * @see net.sf.sail.webapp.dao.AbstractTransactionalDaoTests#retrieveDataObjectListFromDb()
	 */
	@Override
	protected List<?> retrieveDataObjectListFromDb() {
		return this.jdbcTemplate.queryForList("SELECT * FROM "
				+ BrainstormImpl.DATA_STORE_NAME, (Object[]) null);	
	}
	
	/*
	 * SELECT * FROM brainstorms b,brainstormanswers ba,brainstormquestions bq,
	 *    brainstorms_related_to_brainstormanswers b_ba
	 * WHERE b.id=b_ba.brainstorms_fk 
     * AND ba.id=b_ba.brainstormanswers_fk
	 * AND b.brainstormquestions_fk=bq.id
	 */
	private static final String RETRIEVE_BRAINSTORM_LIST_SQL =
		 "SELECT * FROM brainstorms b, brainstormquestions bq" +
		 " WHERE b.brainstormquestions_fk=bq.id";
	
    private List<?> retrieveBrainstormListFromDb() {
        return this.jdbcTemplate.queryForList(RETRIEVE_BRAINSTORM_LIST_SQL,
                (Object[]) null);
    }

}
