package org.telscenter.sail.webapp.dao.attendance.impl;

import org.telscenter.sail.webapp.dao.attendance.StudentAttendanceDao;
import org.telscenter.sail.webapp.domain.attendance.StudentAttendance;

import net.sf.sail.webapp.dao.impl.AbstractHibernateDao;

public class HibernateStudentAttendanceDao extends AbstractHibernateDao<StudentAttendance> implements StudentAttendanceDao<StudentAttendance> {

	@Override
	protected Class<? extends StudentAttendance> getDataObjectClass() {
		return null;
	}

	@Override
	protected String getFindAllQuery() {
		return null;
	}

}
