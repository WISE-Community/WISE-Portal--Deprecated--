/**
 * 
 */
package org.telscenter.sail.webapp.presentation.web.controllers.teacher.grading;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import org.telscenter.sail.webapp.domain.premadecomment.PremadeComment;
import org.telscenter.sail.webapp.domain.premadecomment.impl.PremadeCommentImpl;
import org.telscenter.sail.webapp.service.premadecomment.PremadeCommentService;

/**
 * @author Geoffrey Kwan
 *
 */
public class AddCommentToListController extends AbstractController {

	private PremadeCommentService premadeCommentService;
	
	
	
	/* (non-Javadoc)
	 * @see org.springframework.web.servlet.mvc.AbstractController#handleRequestInternal(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	@Override
	protected ModelAndView handleRequestInternal(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		//retrieve the listId that we are going to add a comment to
		String listId = request.getParameter("listNumber");
		
		//retrieve the text of the comment we are going to add
		String comment = request.getParameter("comment");
		
		//create a premade comment with the text of the new comment
		PremadeComment premadeComment = new PremadeCommentImpl();
		premadeComment.setComment(comment);
		//premadeComment.setLabel(comment);
		
		//add the new comment to the existing list with listId
		premadeCommentService.addPremadeCommentToList(new Long(listId), premadeComment);
		
		ModelAndView modelAndView = new ModelAndView();
		
		//send back the Id of the comment, this Id is unique from all other comment Ids
		modelAndView.addObject("commentId", premadeComment.getId());
		
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
