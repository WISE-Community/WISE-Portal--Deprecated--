/**
 * 
 */
package org.telscenter.sail.webapp.presentation.web.controllers.teacher.grading;

import java.util.Iterator;
import java.util.Set;
import java.util.TreeSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.sail.webapp.domain.User;
import net.sf.sail.webapp.domain.impl.UserImpl;
import net.sf.sail.webapp.presentation.web.controllers.ControllerUtil;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import org.telscenter.sail.webapp.domain.Run;
import org.telscenter.sail.webapp.domain.impl.PremadeCommentListParameters;
import org.telscenter.sail.webapp.domain.impl.RunImpl;
import org.telscenter.sail.webapp.domain.premadecomment.PremadeComment;
import org.telscenter.sail.webapp.domain.premadecomment.PremadeCommentList;
import org.telscenter.sail.webapp.service.premadecomment.PremadeCommentService;

/**
 * @author Geoffrey Kwan
 *
 */
public class CreateNewCommentListController extends AbstractController {

	private PremadeCommentService premadeCommentService;
	
	private final static String LIST_ID = "listId";
	
	/* (non-Javadoc)
	 * @see org.springframework.web.servlet.mvc.AbstractController#handleRequestInternal(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	@Override
	protected ModelAndView handleRequestInternal(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		//retrieves the name of the new list the user wants to create
		String label = request.getParameter("label");
		
		//retrieves the current user to be set as the owner of the list
		User user = ControllerUtil.getSignedInUser();
		
		//creates an empty list of PremadeComments
		Set<PremadeComment> list = new TreeSet<PremadeComment>();
		
		//TODO: this should retrieve the current run
		Run run = null;
		
		/* creates the parameter object to be used to create a new 
		   PremadeCommentList object */
		PremadeCommentListParameters listParams = 
			new PremadeCommentListParameters();
		listParams.setLabel(label);
		listParams.setList(list);
		listParams.setOwner(user);
		listParams.setRun(run);
		
		//calls the premadeCommentService to create a new list in the database
		PremadeCommentList commentList = 
			premadeCommentService.createPremadeCommentList(listParams);
		
		//sends the Id of the newly created list back to the user
		modelAndView.addObject(LIST_ID, commentList.getId());
		
		return modelAndView;
	}

	/**
	 * @return the premadeCommentService
	 */
	public PremadeCommentService getPremadeCommentService() {
		return premadeCommentService;
	}

	/**
	 * @param premadeCommentService the premadeCommentService to set
	 */
	public void setPremadeCommentService(PremadeCommentService premadeCommentService) {
		this.premadeCommentService = premadeCommentService;
	}
}
