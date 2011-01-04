/**
 * 
 */
package org.telscenter.sail.webapp.presentation.web.controllers.teacher.grading;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import org.telscenter.sail.webapp.service.premadecomment.PremadeCommentService;

/**
 * @author Geoffrey Kwan
 *
 */
public class EditCommentController extends AbstractController {
	
	private PremadeCommentService premadeCommentService;
	
	/* (non-Javadoc)
	 * @see org.springframework.web.servlet.mvc.AbstractController#handleRequestInternal(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	@Override
	protected ModelAndView handleRequestInternal(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		//retrieves the id of the comment
		String commentId = request.getParameter("commentId");
		
		//retrieves the edited version of the comment
		String editedComment = request.getParameter("editedComment");
		
		//updates the comment in the database
		premadeCommentService.updatePremadeCommentMessage(new Long(commentId), editedComment);
		
		ModelAndView modelAndView = new ModelAndView();
		
		//sends back the edited comment to be displayed
		modelAndView.addObject("editedComment", editedComment);
		
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
