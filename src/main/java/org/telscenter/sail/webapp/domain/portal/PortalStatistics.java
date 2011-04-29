package org.telscenter.sail.webapp.domain.portal;

import java.util.Date;

import net.sf.sail.webapp.domain.Persistable;

public interface PortalStatistics extends Persistable {

    public Date getTimestamp();

	public void setTimestamp(Date timestamp);
	
	public Long getTotalNumberStudents();
	
	public void setTotalNumberStudents(Long totalNumberStudents);

	public Long getTotalNumberStudentLogins();

	public void setTotalNumberStudentLogins(Long totalNumberStudentLogins);

	public Long getTotalNumberTeachers();

	public void setTotalNumberTeachers(Long totalNumberTeachers);

	public Long getTotalNumberTeacherLogins();

	public void setTotalNumberTeacherLogins(Long totalNumberTeacherLogins);

	public Long getTotalNumberRuns();

	public void setTotalNumberRuns(Long totalNumberRuns);

	public Long getTotalNumberProjectsRun();

	public void setTotalNumberProjectsRun(Long totalNumberProjectsRun);
}
