//TODO: Convert to prototype format

/*
 * Finds any DOM elements with the 'tooltip' class and initializes the miniTip plugin on each.
 * 
 * @param options An object to specify default miniTip settings for all tooltips (Optional; 
 * see http://goldfirestudios.com/blog/81/miniTip-jQuery-Plugin for allowable options)
 * 
 * Individual tooltip options can be customized by adding additional attributes to the target DOM 
 * element (optional):
 * - tooltip-event:'click' sets the tooltip to render on mouse click (vs. hover, which is the default)
 * - tooltip-anchor:'bottom', 'left', and 'right' set the positions of the tooltip to bottom, left, 
 * and right respectively (default is top)
 * - tooltip-maxW:'XXXpx' sets the max-width of the tooltip element to XXX pixels (default is '250px');
 * - tooltip-content: String (or HTML String) to set as the tooltip's content (default is the element's 
 * title attribute)
 * - tooltip-title: String to set as the tooltip's title (default is no title)
 * - tooltip-class: String to add to the tooltip element's css class (default is none)
 */
insertTooltips = function(options){
	// for all DOM elements with the 'tooltip' class, initialize miniTip
	$('.tooltip').each(function(){
		// set miniTip default options
		var settings = {};
		if(options != null && typeof options == 'object'){
			// options have been sent in as a parameter
			settings = options;
		} else {
			// options have not been sent in as a paremeter, so set them 
			settings = {
				anchor:'n',
				event:'hover',
				aHide:false,
				maxW:'250px',
				fadeIn:1,
				fadOut:1,
				delay:100,
				show: function(){},
				hide: function(){}
			};
		}
		
		// set options based on target element attributes
		if($(this).attr('tooltip-event') == 'click'){
			settings.event = 'click';
		}
		if($(this).attr('tooltip-anchor') == 'right'){
			settings.anchor = 'e';
		} else if ($(this).attr('tooltip-anchor') == 'bottom'){
			settings.anchor = 's';
		} else if ($(this).attr('tooltip-anchor') == 'left'){
			settings.anchor = 'w';
		}
		if($(this).attr('tooltip-maxW') && $(this).attr('tooltip-maxW').match(/^[0-9]+px$/)){
			settings.maxW = $(this).attr('tooltip-maxW');
		}
		if(typeof $(this).attr('tooltip-content') == 'string'){
			settings['content'] = $(this).attr('tooltip-content');
		}
		if(typeof $(this).attr('tooltip-title') == 'string'){
			settings['title'] = $(this).attr('tooltip-title');
		}
		if(typeof $(this).attr('tooltip-class') == 'string'){
			var doShow = settings.show, doHide = settings.hide;
			settings.show = function(){
				$('#miniTip').addClass($(this).attr('tooltip-class'));
				doShow();
			};
			settings.hide = function(){
				setTimeout(function(){$('#miniTip').removeClass($(this).attr('tooltip-class'));},200);
				doHide();
			};
		} else {
			var doShow = settings.show;
			settings.show = function(){
				$('#miniTip').attr('class','');
				doShow();
			};
		}
		
		// initialize miniTip on element
		$(this).miniTip(settings);
		
		// remove all tooltip attributes and class from DOM element (to clean up html and so item are not re-processed if insertTooltips is called again on same page)
		$(this).removeAttr('tooltip-event').removeAttr('tooltip-anchor').removeAttr('tooltip-maxW').removeAttr('tooltip-content').removeAttr('tooltip-title').removeClass('tooltip');
	});
};


/*These two functions are used for the FORM HINT functionality on registration pages*/

function addLoadEvent(func) {
  var oldonload = window.onload;
  if (typeof window.onload != 'function') {
    window.onload = func;
  } else {
    window.onload = function() {
      oldonload();
      func();
    }
  }
}

function prepareInputsForHints() {
  var inputs = document.getElementsByTagName("input");
  for (var i=0; i<inputs.length; i++){
    inputs[i].onfocus = function () {
    	if (this.parentNode.getElementsByClassName("hint").length > 0) {
    		var hint = this.parentNode.getElementsByClassName("hint")[0];
    		var xpos = $(this).offset().left + $(this).width() + 15 + 'px';
    		var ypos = $(this).offset().top + 'px';
    		$(hint).css({'display':'block','left':xpos,'top':ypos});
    		//this.parentNode.getElementsByTagName("span")[0].style.display = "inline";
    	}
    }
    inputs[i].onblur = function () {
    	if (this.parentNode.getElementsByClassName("hint").length > 0) {
    		this.parentNode.getElementsByClassName("hint")[0].style.display = "none";
    	}
    }
  }
  var selects = document.getElementsByTagName("select");
  for (var k=0; k<selects.length; k++){
    selects[k].onfocus = function () {
    	if (this.parentNode.getElementsByClassName("hint").length > 0) {
    		var hint = this.parentNode.getElementsByClassName("hint")[0];
    		var xpos = $(this).offset().left + $(this).width() + 35 + 'px';
    		var ypos = $(this).offset().top + 'px';
    		$(hint).css({'display':'block','left':xpos,'top':ypos});
    		//this.parentNode.getElementsByTagName("span")[0].style.display = "inline";
    	}
    }
    selects[k].onblur = function () {
    	if (this.parentNode.getElementsByClassName("hint").length > 0) {
    		this.parentNode.getElementsByClassName("hint")[0].style.display = "none";
    	}
    }
  }
}
addLoadEvent(prepareInputsForHints);