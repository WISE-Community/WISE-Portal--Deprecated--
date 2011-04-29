package org.telscenter.sail.webapp.dao.portal.impl;

import org.telscenter.sail.webapp.dao.portal.PortalStatisticsDao;
import org.telscenter.sail.webapp.domain.portal.PortalStatistics;

import net.sf.sail.webapp.dao.impl.AbstractHibernateDao;

public class HibernatePortalStatisticsDao extends AbstractHibernateDao<PortalStatistics> implements PortalStatisticsDao<PortalStatistics> {

	@Override
	protected Class<? extends PortalStatistics> getDataObjectClass() {
		return null;
	}

	@Override
	protected String getFindAllQuery() {
		return null;
	}

}
