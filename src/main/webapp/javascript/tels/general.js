//TODO: Convert to prototype format

/*
 * Finds any DOM elements with the 'tooltip' class and initializes the miniTip plugin on each.
 * 
 * @param options An object to specify default miniTip settings for all tooltips (Optional; 
 * see http://goldfirestudios.com/blog/81/miniTip-jQuery-Plugin for allowable options)
 * @param target A jQuery DOM object on which to process elements (Optional; default is entire page)
 * 
 * Individual tooltip options can be customized by adding additional attributes to the DOM element 
 * (Optional; will override default settings):
 * - tooltip-event:'click' sets the tooltip to render on mouse click (vs. hover, which is the default)
 * - tooltip-anchor:'bottom', 'left', and 'right' set the positions of the tooltip to bottom, left, 
 * and right respectively (default is top)
 * - tooltip-maxW:'XXXpx' sets the max-width of the tooltip element to XXX pixels (default is '400px');
 * - tooltip-content: String (or HTML String) to set as the tooltip's content (default is the element's 
 * title attribute)
 * - tooltip-title: String to set as the tooltip's title (default is no title)
 * - tooltip-class: String to add to the tooltip element's css class (default is none)
 * - tooltip-offset: 'XX' sets as the offset of the tooltip element to XX pixels (default is '0')
 */
insertTooltips = function(options,target){
	function processElement(item,options){
		// set miniTip default options
		var settings = {
			anchor:'n',
			event:'hover',
			aHide:false,
			maxW:'400px',
			offset:0,
			fadeIn:10,
			fadOut:10,
			delay:100,
			show: function(){}
		};
		if(options != null && typeof options == 'object'){
			// miniTip options have been sent in as a parameter, so merge with defaults
			$.extend(settings,options);
		}
		
		// set options based on target element attributes
		if(item.attr('tooltip-event') == 'click'){
			settings.event = 'click';
		}
		if(item.attr('tooltip-anchor') == 'right'){
			settings.anchor = 'e';
		} else if (item.attr('tooltip-anchor') == 'bottom'){
			settings.anchor = 's';
		} else if (item.attr('tooltip-anchor') == 'left'){
			settings.anchor = 'w';
		}
		if(item.attr('tooltip-maxW') && item.attr('tooltip-maxW').match(/^[0-9]+px$/)){
			settings.maxW = item.attr('tooltip-maxW');
		}
		if(typeof item.attr('tooltip-content') == 'string'){
			settings['content'] = item.attr('tooltip-content');
		}
		if(typeof item.attr('tooltip-title') == 'string'){
			settings['title'] = item.attr('tooltip-title');
		}
		if(typeof item.attr('tooltip-offset') == 'string'){
			settings['offset'] = parseInt(item.attr('tooltip-offset'));
		}
		if(typeof item.attr('tooltip-class') == 'string'){
			var doShow = settings.show, newClass = item.attr('tooltip-class');
			settings.show = function(){
				$('#miniTip').attr('class',''); // clear out existing class
				$('#miniTip').addClass(newClass);
				doShow();
			};
		} else {
			var doShow = settings.show;
			settings.show = function(){
				$('#miniTip').attr('class',''); // clear out existing class
				doShow();
			};
		}
		
		// initialize miniTip on element
		item.miniTip(settings);
		
		// remove all tooltip attributes and class from DOM element (to clean up html and so item are not re-processed if insertTooltips is called again on same page)
		item.removeAttr('tooltip-event').removeAttr('tooltip-anchor').removeAttr('tooltip-maxW').removeAttr('tooltip-content').removeAttr('tooltip-class').removeAttr('tooltip-offset').removeAttr('tooltip-title').removeClass('tooltip');
	}
	
	// for all DOM elements with the 'tooltip' class, initialize miniTip
	if(target){
		$('.tooltip',target).each(function(){
			processElement($(this),options);
		});
	} else {
		$('.tooltip').each(function(){
			processElement($(this),options);
		});
	}
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