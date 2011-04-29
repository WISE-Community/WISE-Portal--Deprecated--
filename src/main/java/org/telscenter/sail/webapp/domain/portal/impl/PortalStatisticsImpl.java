package org.telscenter.sail.webapp.domain.portal.impl;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.telscenter.sail.webapp.domain.portal.PortalStatistics;

@Entity
@Table(name = PortalStatisticsImpl.DATA_STORE_NAME)
public class PortalStatisticsImpl implements PortalStatistics {

	@Transient
	private static final long serialVersionUID = 1L;
	
	@Transient
	public static final String DATA_STORE_NAME = "portal_statistics";
	
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
	public Long id = null;
    
    @Column(name = "timestamp")
    private Date timestamp;

	@Column(name = "totalNumberStudents")
    private Long totalNumberStudents;
    
    @Column(name = "totalNumberStudentLogins")
    private Long totalNumberStudentLogins;
    
    @Column(name = "totalNumberTeachers")
    private Long totalNumberTeachers;
    
    @Column(name = "totalNumberTeacherLogins")
    private Long totalNumberTeacherLogins;
    
    @Column(name = "totalNumberRuns")
    private Long totalNumberRuns;
    
    @Column(name = "totalNumberProjectsRun")
    private Long totalNumberProjectsRun;
    
	public Serializable getId() {
		return this.id;
	}
	
	public void setId(Long id) {
		this.id = id;
	}
    
    public Date getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(Date timestamp) {
		this.timestamp = timestamp;
	}

	public Long getTotalNumberStudents() {
		return totalNumberStudents;
	}

	public void setTotalNumberStudents(Long totalNumberStudents) {
		this.totalNumberStudents = totalNumberStudents;
	}

	public Long getTotalNumberStudentLogins() {
		return totalNumberStudentLogins;
	}

	public void setTotalNumberStudentLogins(Long totalNumberStudentLogins) {
		this.totalNumberStudentLogins = totalNumberStudentLogins;
	}

	public Long getTotalNumberTeachers() {
		return totalNumberTeachers;
	}

	public void setTotalNumberTeachers(Long totalNumberTeachers) {
		this.totalNumberTeachers = totalNumberTeachers;
	}

	public Long getTotalNumberTeacherLogins() {
		return totalNumberTeacherLogins;
	}

	public void setTotalNumberTeacherLogins(Long totalNumberTeacherLogins) {
		this.totalNumberTeacherLogins = totalNumberTeacherLogins;
	}

	public Long getTotalNumberRuns() {
		return totalNumberRuns;
	}

	public void setTotalNumberRuns(Long totalNumberRuns) {
		this.totalNumberRuns = totalNumberRuns;
	}

	public Long getTotalNumberProjectsRun() {
		return totalNumberProjectsRun;
	}

	public void setTotalNumberProjectsRun(Long totalNumberProjectsRun) {
		this.totalNumberProjectsRun = totalNumberProjectsRun;
	}
}
