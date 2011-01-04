package org.telscenter.sail.webapp.dao.module.impl;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Set;

import net.sf.sail.webapp.dao.impl.AbstractHibernateDao;
import net.sf.sail.webapp.domain.User;
import net.sf.sail.webapp.domain.sds.SdsCurnit;

import org.telscenter.sail.webapp.dao.module.ModuleDao;
import org.telscenter.sail.webapp.domain.Module;
import org.telscenter.sail.webapp.domain.impl.RooloEnlaceLORModuleImpl;
import org.telscenter.sail.webapp.domain.impl.RooloOtmlModuleImpl;
import org.telscenter.sail.webapp.domain.project.FamilyTag;
import org.telscenter.sail.webapp.domain.project.ProjectInfo;
import org.telscenter.sail.webapp.domain.project.impl.ProjectInfoImpl;

import roolo.elo.ELOMetadataKeys;
import roolo.elo.api.IELO;
import roolo.elo.api.IMetadata;
import roolo.elo.api.IMetadataValueContainer;
import roolo.elo.api.IRepository;


public class RooloLOROtmlModuleDao extends AbstractHibernateDao<Module>
		implements ModuleDao<Module> {

	public static String rooloRepositoryUrl;

	public static String defaultOtrunkCurnitUrl;

	// Roolo client
	private IRepository rooloClientRepository;

	private static final String FIND_ALL_QUERY = "from RooloEnlaceLORModuleImpl";

	@Override
	public void save(Module module) {
		super.save(module);
		IELO lo = ((RooloEnlaceLORModuleImpl) module).getLearningObject();
		rooloClientRepository.updateELO(lo);
	}

	@Override
	public List<Module> getList() {
		List<Module> moduleList = super.getList();
		List<Module> modules = new ArrayList<Module>();
		return moduleList;
	}

	protected ProjectInfo createProjectInfo(
			IMetadata metadata) {
		ProjectInfo info = new ProjectInfoImpl();
		IMetadataValueContainer container;
		container = metadata
				.getMetadataValueContainer(ELOMetadataKeys.AUTHOR
						.getKey());
		info.setAuthor(container.getValue().toString());
		container = metadata
				.getMetadataValueContainer(ELOMetadataKeys.GRADELEVEL
						.getKey());
		info.setGradeLevel(container.getValue().toString());
		container = metadata
				.getMetadataValueContainer(ELOMetadataKeys.SUBJECT
						.getKey());
		info.setSubject(container.getValue().toString());
		container = metadata
				.getMetadataValueContainer(ELOMetadataKeys.KEYWORDS
						.getKey());
		info.setKeywords(container.getValue().toString());
		// container =
		// metadata.getMetadataValueContainer(CurnitClientMetadataKeys.LIFECYCLE.getKey());
		// info.setProjectLiveCycle( container.getValue().toString() );
		// TODO Add the lifecycle metadata
		container = metadata
				.getMetadataValueContainer(ELOMetadataKeys.FAMILYTAG
						.getKey());
		String familyTag = container.getValue().toString();
		List<FamilyTag> possibleValues = Arrays.asList(FamilyTag.values());
		if (familyTag != null
				&& possibleValues.contains(FamilyTag.valueOf(familyTag))) {
			info.setFamilyTag(FamilyTag.valueOf(familyTag));
		} else {
			info.setFamilyTag(FamilyTag.OTHER);
		}
		container = metadata
				.getMetadataValueContainer(ELOMetadataKeys.ISCURRENT
						.getKey());
		String isCurrent = container.getValue().toString();
		info.setCurrent("yes".equals(isCurrent));
		container = metadata
				.getMetadataValueContainer(ELOMetadataKeys.DESCRIPTION
						.getKey());
		info.setComment(container.getValue().toString());
		container = metadata
				.getMetadataValueContainer(ELOMetadataKeys.DESCRIPTION
						.getKey());
		info.setDescription(container.getValue().toString());
		
		
		return info;
	}

	@Override
	protected Class<RooloEnlaceLORModuleImpl> getDataObjectClass() {
		return RooloEnlaceLORModuleImpl.class;
	}

	@Override
	protected String getFindAllQuery() {
		return FIND_ALL_QUERY;
	}

	public Module getByUri(String uriString) {

		try {
			URI uri = new URI(uriString);
			IELO curnitProxy = rooloClientRepository.retrieveELO(uri);

		} catch (URISyntaxException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * @param rooloClientCurnitRepository
	 *            the rooloClientCurnitRepository to set
	 */
	public void setRooloLORClientCurnitRepository(IRepository rooloClientCurnitRepository) {
		this.rooloClientRepository = rooloClientCurnitRepository;
	}

	/**
	 * @param rooloRepositoryUrl
	 *            the rooloRepositoryUrl to set
	 */
	public void setRooloRepositoryUrl(String rooloRepositoryUrl) {
		this.rooloRepositoryUrl = rooloRepositoryUrl;
	}

	/**
	 * @return the rooloRepositoryUrl
	 */
	public String getRooloRepositoryUrl() {
		return rooloRepositoryUrl;
	}

	/**
	 * @param defaultOtrunkCurnitUrl
	 *            the defaultOtrunkCurnitUrl to set
	 */
	public void setDefaultOtrunkCurnitUrl(String defaultOtrunkCurnitUrl) {
		this.defaultOtrunkCurnitUrl = defaultOtrunkCurnitUrl;
	}

	/**
	 * @return the defaultOtrunkCurnitUrl
	 */
	public String getDefaultOtrunkCurnitUrl() {
		return defaultOtrunkCurnitUrl;
	}

	public Long getLatestId() {
		return null;
	}

	public IELO getEloForModule(Module mod) {
		// TODO Auto-generated method stub
		return null;
	}

}
