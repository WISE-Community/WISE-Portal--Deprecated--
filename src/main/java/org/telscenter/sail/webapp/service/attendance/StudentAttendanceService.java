package org.telscenter.sail.webapp.service.attendance;

import java.util.Date;

import org.telscenter.sail.webapp.dao.attendance.StudentAttendanceDao;
import org.telscenter.sail.webapp.domain.attendance.StudentAttendance;

public interface StudentAttendanceService {

	public void addStudentAttendanceEntry(Long workgroupId, Long runId, Date loginTimestamp, String presentUserIds, String absentUserIds);
	
	public StudentAttendanceDao<StudentAttendance> getStudentAttendanceDao();

	public void setStudentAttendanceDao(StudentAttendanceDao<StudentAttendance> studentAttendanceDao);
}
