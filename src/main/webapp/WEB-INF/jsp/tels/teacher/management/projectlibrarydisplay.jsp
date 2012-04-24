<link href="<spring:theme code="teacherrunstylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="jquerydatatables.css"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="facetedfilter.css"/>" media="screen" rel="stylesheet"  type="text/css" />
<script type="text/javascript" src="<spring:theme code="jquerydatatables.js"/>"></script>
<script type="text/javascript" src="<spring:theme code="datatables.fngetfilterednodes.js"/>"></script>
<script type="text/javascript" src="<spring:theme code="facetedfilter.js"/>"></script>
<script type="text/javascript" src="<spring:theme code="jqueryprintelement.js"/>"></script>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page buffer="100kb" %>

<!-- Page-specific script, TODO: move to external js - will need client-side i18n support -->

<script type="text/javascript">
	// TODO: convert to prototype format: ProjectLibrary.js (requires js i18n)

	var children = {}, // object to hold all child project divs
		rootProjectIds = [], // array to hold root project ids
		totalProjects, // int to hold total number of projects in user's library
		otable; // object to hold datatables instance (requires jQuery datatables plugin: http://datatables.net/)

	/** AJAX Functions **/
	
	// adds/removes bookmark (favorite) for the specified project. pID=projectID of project to remove bookmark
	function toggleBookmark(pID){
		var checked = $('#bookmark_' + pID).hasClass('true');
		$.ajax({
			type: 'get',
			url: '/webapp/teacher/projects/bookmark.html?projectId=' + pID + '&checked=' + !checked,
			success: function(request){
				var updateString = '',
					updateRow,
					updateColumn = 9;
				if(checked){
					updateString = 'false';
					$('#bookmark_' + pID).removeClass('true');
					if($('#projectBox_' + pID).hasClass('rootProject')){
						$('#projectRow_' + pID + '> td').eq(9).text('false');
						updateRow = $('#projectRow_' + pID)[0];
					} else {
						var rootId = $('#projectBox_' + pID).parent().parent().attr('id').replace('projectRow_','');
						var text = $('#projectRow_' + rootId + '> td').eq(9).text().replace('true','false');
						$('#projectRow_' + rootId + '> td').eq(9).text(text);
						updateRow = $('#projectRow_' + rootId)[0];
					}
				} else {
					updateString = 'true';
					$('#bookmark_' + pID).addClass('true');
					$('#bookmark_' + pID).removeClass('false');
					if($('#projectBox_' + pID).hasClass('rootProject')){
						$('#projectRow_' + pID + '> td').eq(9).text('true');
						updateRow = $('#projectRow_' + pID)[0];
					} else {
						var rootId = $('#projectBox_' + pID).parent().parent().attr('id').replace('projectRow_','');
						var text = $('#projectRow_' + rootId + '> td').eq(9).text().replace('false','true');
						$('#projectRow_' + rootId + '> td').eq(9).text(text);
						updateRow = $('#projectRow_' + rootId)[0];
					}
				}
				otable.fnUpdate( updateString, updateRow, updateColumn, false, true );
			},
			error: function(request,error){
				alert('Error: failed to update favorite');
			}
		});
	};

	/**
	 *
	 * @param pId project id
	 * @param type the project type e.g. "LD"
	 * @param name the project name
	 * @param fileName the project file name e.g. "/wise4.project.json"
	 * @param relativeProjectFilePathUrl the relative project file path e.g. "/513/wise4.project.json" 
	 */
	function copy(pID, type, name, fileName, relativeProjectFilePathUrl){
		var $copyDialog = '<div id="copyDialog"><p><spring:message code="teacher.manage.library.copy.2" /></p>' +
			'<p><spring:message code="teacher.manage.library.copy.3" /></p></div>';
		
		var agreed = false;
		$($copyDialog).dialog({
			modal: true,
			title: '<spring:message code="teacher.manage.library.copy.1" /> ' + name,
			width: '500',
			closeOnEscape: false,
			beforeclose : function() { return agreed; },
			buttons: {
				Cancel: function(){
					agreed = true;
					$(this).dialog('close');
				},
				OK: function(){
					var $copyingDialog = '<p><spring:message code="teacher.manage.library.copy.4" /></p>' + 
						'<p><img src="/webapp/themes/tels/default/images/rel_interstitial_loading.gif" /></p>';
					$('#copyDialog').css('text-align','center');
					$('#copyDialog').html($copyingDialog);
					$('ui-dialog-titlebar-close',$(this).parent()).hide();
					$('button',$(this).parent()).hide().unbind();
					var escapedName = escape(name);
					if(type=='LD'){
						$.ajax({
							type: 'post',
							url: '/webapp/author/authorproject.html',
							data: 'forward=filemanager&projectId=' + pID + '&command=copyProject',
							dataType:'text',
							success: function(response){
								/*
								 * response is the new project folder
								 * e.g.
								 * 513
								 */
								
								/*
								 * get the relative project file path for the new project
								 * e.g.
								 * /513/wise4.project.json
								 */ 
								var projectPath = '/' + response + fileName;
								
								$.ajax({
									type: 'post',
									url: '/webapp/author/authorproject.html',
									data: 'command=createProject&parentProjectId='+pID+'&projectPath=' + projectPath + '&projectName=' + escapedName,
									dataType:'text',
									success: function(response){
										var successText = '<p><spring:message code="teacher.manage.library.copy.5" /> ' + name + '<spring:message code="teacher.manage.library.copy.6" /></p><p><spring:message code="teacher.manage.library.copy.7" /></p>';
										processCopyResult(this,successText,true);
									},
									error: function(response){
										var failureText = '<p><spring:message code="teacher.manage.library.copy.8" /></p>';
										processCopyResult(this,failureText,false);
									},
									context: this
								});								
							},
							error: function(response){
								var failureText = '<p><spring:message code="teacher.manage.library.copy.9" /></p><p><spring:message code="teacher.manage.library.copy.10" /></p>';
								processCopyResult(this,failureText,false);
							},
							context: this
						});
					} else {
						$.ajax({
							type: 'get',
							url: 'copyproject.html?projectId=' + pID,
							success: function(response){//alert(o.responseText);
								var successText = '<p><spring:message code="teacher.manage.library.copy.5" /> ' + name + '<spring:message code="teacher.manage.library.copy.6" /></p><p><spring:message code="teacher.manage.library.copy.7" /></p>'
								processCopyResult(this,successText,true);
							},
							error: function(response){
								var failureText = '<p><spring:message code="teacher.manage.library.copy.11" /><p></p><spring:message code="teacher.manage.library.copy.10" /></p>';
								processCopyResult(this,failureText,false);
							}
						});
					}
				}
			}
		});
		
		function processCopyResult(item,message,success){
			$('#copyDialog').html(message);
			$('button:eq(1)',$('#copyDialog').parent()).show().click(function(){
				agreed = true;
				$(item).dialog('close');
				if(success){
					$("html, body").animate({ scrollTop: 0 }, "1");
					window.location.reload(); // TODO: modify this so that the reloaded library scrolls to the copied project and expands it
				}
			});
		};
	};

	/**
	 * Load thumbnails for each project by looking for curriculum_folder/assets/project_thumb.png (makes an ajax GET request)
	 * @method loadProjectThumbnails
	 * @returns void
	 */
	function loadProjectThumbnails() {		
		$(".projectThumb").each(
			function() {
				var thumbUrl = $(this).attr("thumbUrl");
				// check if thumbUrl exists
				$.ajax({
					url:thumbUrl,
					context:this,
					statusCode: {
						200:function() {
				  		    // If found (returns 200 status), replace the default image with the fetched image
							$(this).html("<img src='"+$(this).attr("thumbUrl")+"' alt='thumb'></img>");
						},
						404:function() {
						    // If not found (returns 400 status), do nothing (use the default image)
							//$(this).html("<img src='/webapp/themes/tels/default/images/projectThumb.png' alt='thumb'></img>");
						}
					}
				});
			});
	};
	
	function getRootId(id){
		var rootBox = $('#projectBox_' + id);
		var newId = rootBox.attr('rootid');
		if(rootBox.hasClass('childProject') && newId){
    	  	return getRootId(newId);
       	} else {
       		return id;
       	}
	};
	
	$(document).ready(function() {
		
		totalProjects = $('div.projectBox').length;
		
		// resolve child projects that have roots set that are also children
		$("div.childProject").each(function(){
			var rootId = $(this).attr('rootid');
			var newRootId = getRootId(rootId);
			$(this).attr('rootid',newRootId);
		});
		
		// Show child link for projects with children
		$("div.projectBox").not(".childProject").each(function(){
			var id = $(this).attr('id').replace('projectBox_','');
			// get all child projects of current project (as projectbox div)
			var projectChildren = $('div[rootid="' + id + '"]');
			var numChildren = projectChildren.length;
			if(numChildren > 0){
				rootProjectIds.push(id);
				var copyLabel = ' <spring:message code="teacher.manage.library.30" />';
				if (numChildren == 1) {
					copyLabel = ' <spring:message code="teacher.manage.library.31" />';
				}
				var $childLink = '<div style="float:left;"><a id="childToggle_' + id + '" class="childToggle">' + numChildren + copyLabel + ' +</a></div>';
				$('#projectBox_' + id + ' .detailsLinks').prepend($childLink);
				$('#childToggle_' + id).live('click',function(){
					if ($('#childToggle_' + id).hasClass('expanded')){
						toggleChildren(id,false);
					} else {
						toggleChildren(id,true);
					}
					
				});
				
				// add child divs to global children object
				var key = "children_" + id;
				children[key] = projectChildren;
				
				// add all metadata (used for filtering) from child trs to corresponding root project
				// since child trs are removed from datatables object (and therefore can't be used in default serach/filter),
				// we append child characteristics to root projects so the children will be included in search and filters
				// post-processing of any filters checks all projects in a family for individual matches/non-matches
				for (var i=0; i<numChildren; i++){
					var childid = $(projectChildren[i]).attr('id').replace('projectBox_','');
					if($(projectChildren[i]).hasClass('shared')){
						$('#projectRow_' + id + ' > td').eq(2).append(', shared');
					} else if($(projectChildren[i]).hasClass('owned')){
						$('#projectRow_' + id + ' > td').eq(2).append( ', owned');
					}
					if($('#projectRow_' + childid + ' > td').eq(9).text().match('true')){
						$('#projectRow_' + id + '> td').eq(9).append(', true');
					}
					$('#projectRow_' + id + ' > td').eq(3).append(', ' + $('#projectRow_' + childid + ' > td').eq(3).text());
					$('#projectRow_' + id + ' > td').eq(4).append(', ' + $('#projectRow_' + childid + ' > td').eq(4).text());
					$('#projectRow_' + id + ' > td').eq(5).append(', ' + $('#projectRow_' + childid + ' > td').eq(5).text());
					$('#projectRow_' + id + ' > td').eq(7).append(', ' + $('#projectRow_' + childid + ' > td').eq(7).text());
					
					// remove all child trs from DOM
					$(projectChildren[i]).parent().parent().remove();
				}
			}
		});
		
		// add child project divs back into DOM
		addChildren();
		
		// Set up the bookmark link click action for each project
		$('a.bookmark').live('click',function(){
			var id = $(this).attr('id').replace('bookmark_','');
			toggleBookmark(id);
		});
		
		// Set up more details toggle click action for each project
		$('.detailsToggle, .projectTitle').live("click",function(){
			var id;
			if($(this).hasClass('detailsToggle')){
				id = $(this).attr('id').replace('detailsToggle_','');
			} else if($(this).hasClass('projectTitle')){
				id = $(this).attr('id').replace('project_','');
			}
			
			if($('#detailsToggle_' + id).hasClass('expanded')){
				toggleDetails(id,false);
			} else {
				toggleDetails(id,true);
			}
		});
		
		// Set up view project details click action for each project id link
		$('a.projectDetail').live('click',function(){
			var title = $(this).attr('title');
			var projectId = $(this).attr('id').replace('projectDetail_','');
			var path = "/webapp/teacher/projects/projectinfo.html?projectId=" + projectId;
			var div = $('#projectDetailDialog').html('<iframe id="projectIfrm" width="100%" height="100%"></iframe>');
			$('body').css('overflow-y','hidden');
			div.dialog({
				modal: true,
				width: '800',
				height: '400',
				title: title,
				position: 'center',
				close: function(){ $(this).html(''); $('body').css('overflow-y','auto'); },
				buttons: {
					Close: function(){
						$(this).dialog('close');
					}
				}
			});
			$("#projectDetailDialog > #projectIfrm").attr('src',path);
		});
		
		// Set up view lesson plan click action for each project
		$('a.viewLesson').live('click',function(){
			var id = $(this).attr('id').replace('viewLesson_','');
			$('#lessonPlan_' + id).dialog({
				width: 800,
				height: 400, // TODO: modify so height is set to 'auto', but if content results in dialog taller than window on load, set height smaller than window
				buttons: { "Close": function() { $(this).dialog("close"); } }
			});
		});
		
		// Set up print lesson click action for each project
		$('.printLesson').live('click',function(){
			var id = $(this).attr('id').replace('printLesson_','');
			var printstyle = "<spring:theme code="teacherrunstylesheet"/>"; // TODO: create print-optimized stylesheet
			$('#lessonPlan_' + id).printElement({
				pageTitle:'LessonPlan-WISE4-Project-' + id + '.html',
				overrideElementCSS:[{href:printstyle, media:'print'}] // TODO: create print-optimized stylesheet
			});
		});
		
		// setup project run dialog
		$('.shareProject').live('click',function(){
			var title = $(this).attr('title');
			var projectId = $(this).attr('id').replace('shareProject_','');
			var path = "/webapp/teacher/projects/customized/shareproject.html?projectId=" + projectId;
			var div = $('#shareDialog').html('<iframe id="shareIfrm" width="100%" height="100%"></iframe>');
			div.dialog({
				modal: true,
				width: '650',
				height: $(window).height() - 100,
				title: title,
				position: 'center',
				close: function(){ $(this).html('');},
				buttons: {
					Close: function(){$(this).dialog('close');}
				}
			});
			$("#shareDialog > #shareIfrm").attr('src',path);
		});
		
		// initialize datatable on #myProjects
		otable = $('#myProjects').dataTable({
			"sPaginationType": "full_numbers",
			"iDisplayLength": 10,
			"aLengthMenu": [[5, 10, 25, -1], [5, 10, 25, "All"]],
			"aaSorting": [ [11,'desc'], [12,'asc'], [8,'desc'] ],
			"oLanguage": {
				"sInfo": "_TOTAL_ <spring:message code="teacher.datatables.16"/>",
				// TODO: Mofidy these entries in ui-html.properties (make separate entries for datatables - not teacher.datatables.1, for ex.)
				//"sInfo": "<spring:message code="teacher.datatables.1"/> _START_-_END_ <spring:message code="teacher.datatables.2"/> _TOTAL_ <spring:message code="teacher.datatables.16"/>",
				"sInfoEmpty": "<spring:message code="teacher.datatables.3"/>",
				"sInfoFiltered": "<spring:message code="teacher.datatables.17"/> _MAX_ <spring:message code="teacher.datatables.18"/>", // (from _MAX_ total)
				"sLengthMenu": "<spring:message code="teacher.datatables.5"/> _MENU_ <spring:message code="teacher.datatables.6"/>",
				"sProcessing": "<spring:message code="teacher.datatables.7"/>",
				"sZeroRecords": "<spring:message code="teacher.datatables.8"/>",
				"sInfoPostFix":  "<spring:message code="teacher.datatables.9"/>",
				"sSearch": "<spring:message code="teacher.datatables.10"/>",
				"sUrl": "<spring:message code="teacher.datatables.11"/>",
				"oPaginate": {
					"sFirst":    "<spring:message code="teacher.datatables.12"/>",
					"sPrevious": "<spring:message code="teacher.datatables.13"/>",
					"sNext":     "<spring:message code="teacher.datatables.14"/>",
					"sLast":     "<spring:message code="teacher.datatables.15"/>"
				}
			},
			"fnDrawCallback": function ( oSettings ) {
				var filtered = false;
				for(iCol = 0; iCol < oSettings.aoPreSearchCols.length; iCol++) {
					if (oSettings.aoPreSearchCols[ iCol ].sSearch != '' && oSettings.aoPreSearchCols[ iCol ].sSearch != null) {
						filtered = true;
					}
				}
				if(filtered){					
					// calculate which projects, including children, are actual matches for current filters (and not just family matches)
					processFilters(oSettings);
				} else {
					$('.projectBox').removeClass('noMatch');
					// hide all filtered children
					$('.childToggle').each(function(){
						var id = $(this).attr('id').replace('childToggle_','');
						toggleChildren(id,false);
					});
					updateProjectCounts(filtered); // update project counts display
				}
				
				// automatically scroll to top of page
				var targetOffset = $('.projectTable').offset().top - 10;
				if ($(window).scrollTop() > targetOffset){
					$('html,body').scrollTop(targetOffset);
				}
				
				if($(this).is(':visible')){
					$('div.projectBox').each(function(){setTitleWidth(this);}); //set project title widths
				}
				
				// hide all project details
				$('div.projectBox').each(function(){
					var id = $(this).attr('id').replace('projectBox_','');
					toggleDetails(id,false);
				});

				// load project thumbnails
				loadProjectThumbnails();
				
				// TODO: add url params to current page location for each filter/search/sort/pagination/projects per page
			},
			"sDom":'<"top"lip>rt<"bottom"ip<"clear">><"clear">'
			//"sDom":'<"top"lip<"clear">>rt<"bottom"ip><"clear">'
		});
		
		// Define FacetedFilter options for #myProjects datatable object
		var facets = new FacetedFilter( otable.fnSettings(), {
			"bScroll": false,
			"sClearFilterLabel": "<spring:message code="teacher.datatables.filter.clear"/>",
			"sClearSearchLabel": "<spring:message code="teacher.datatables.search.clear"/>",
			"sFilterLabel": "<spring:message code="teacher.datatables.filter.label"/>",
			"sSearchLabel": "<spring:message code="teacher.datatables.search.label"/>",
			"fnCallback": function(){
				$('div.projectBox').each(function(){setTitleWidth(this);});
			},
			"fnInitCallback": function(){
				setTimeout(function(){$('div.projectBox').each(function(){setTitleWidth(this);}),1000});
				// TODO: call function that processes any url params and sets specified filters/searches/sort/pagination/projects per page
			},
			"aSearchOpts": [
				{
					"identifier": "<spring:message code="teacher.datatables.search.1a"/>", "label": "<spring:message code="teacher.datatables.search.1b"/> ", "column": 0, "maxlength": 50
				}
			 ],
			"aFilterOpts": [
				{
					"identifier": "bookmark", "label": "<spring:message code="teacher.datatables.filter.3a"/>", "column": 9,
					"options": [
						{"query": "true", "display": "<spring:message code="teacher.datatables.filter.3b"/>"} // TODO: modify FacetedFilter plugin to only require a query for each filter, use query as display if display option is not set
					]
				},
				{
					"identifier": "source", "label": "<spring:message code="teacher.datatables.filter.4a"/>", "column": 2,
					"options": [
						{"query": "library", "display": "<spring:message code="teacher.datatables.filter.4b"/>"}, // TODO: modify FacetedFilter plugin to only require a query for each filter, use query as display if display option is not set
						{"query": "owned", "display": "<spring:message code="teacher.datatables.filter.4c"/>"},
						{"query": "shared", "display": "<spring:message code="teacher.datatables.filter.4d"/>"}
					]
				},
				{
					"identifier": "subject", "label": "<spring:message code="teacher.datatables.filter.5a"/>", "column": 3,
					"options": [
						{"query": "<spring:message code="teacher.datatables.filter.5b"/>", "display": "<spring:message code="teacher.datatables.filter.5b"/>"}, // TODO: modify FacetedFilter plugin to only require a query for each filter, use query as display if display option is not set
						{"query": "<spring:message code="teacher.datatables.filter.5c"/>", "display": "<spring:message code="teacher.datatables.filter.5c"/>"},
						{"query": "<spring:message code="teacher.datatables.filter.5d"/>", "display": "<spring:message code="teacher.datatables.filter.5d"/>"},
						{"query": "<spring:message code="teacher.datatables.filter.5e"/>", "display": "<spring:message code="teacher.datatables.filter.5e"/>"},
						{"query": "<spring:message code="teacher.datatables.filter.5f"/>", "display": "<spring:message code="teacher.datatables.filter.5f"/>"},
						{"query": "<spring:message code="teacher.datatables.filter.5g"/>", "display": "<spring:message code="teacher.datatables.filter.5g"/>"},
						{"query": "<spring:message code="teacher.datatables.filter.5h"/>", "display": "<spring:message code="teacher.datatables.filter.5h"/>"},
						{"query": "<spring:message code="teacher.datatables.filter.5i"/>", "display": "<spring:message code="teacher.datatables.filter.5i"/>"}
					]
				},
				{
					"identifier": "grade", "label": "<spring:message code="teacher.datatables.filter.6a"/>", "column": 4,
					"options": [
						{"query": "<spring:message code="teacher.datatables.filter.6b"/>", "display": "<spring:message code="teacher.datatables.filter.6b"/>"},
						{"query": "<spring:message code="teacher.datatables.filter.6c"/>", "display": "<spring:message code="teacher.datatables.filter.6c"/>"},
						{"query": "<spring:message code="teacher.datatables.filter.6d"/>", "display": "<spring:message code="teacher.datatables.filter.6d"/>"},
						{"query": "<spring:message code="teacher.datatables.filter.6e"/>", "display": "<spring:message code="teacher.datatables.filter.6e"/>"}
					]
				},
				{
					"identifier": "duration", "label": "<spring:message code="teacher.datatables.filter.7a"/>", "column": 5,
					"options": [
						{"query": "<spring:message code="teacher.datatables.filter.7b"/>", "display": "<spring:message code="teacher.datatables.filter.7b"/>"},
						{"query": "<spring:message code="teacher.datatables.filter.7c"/>", "display": "<spring:message code="teacher.datatables.filter.7c"/>"},
						{"query": "<spring:message code="teacher.datatables.filter.7d"/>", "display": "<spring:message code="teacher.datatables.filter.7d"/>"},
						{"query": "<spring:message code="teacher.datatables.filter.7e"/>", "display": "<spring:message code="teacher.datatables.filter.7e"/>"},
						{"query": "<spring:message code="teacher.datatables.filter.7f"/>", "display": "<spring:message code="teacher.datatables.filter.7f"/>"},
						{"query": "<spring:message code="teacher.datatables.filter.7g"/>", "display": "<spring:message code="teacher.datatables.filter.7g"/>"}
					]
				},
				{
					"identifier": "language", "label": "<spring:message code="teacher.datatables.filter.8a"/>", "column": 7,
					"options": [
						{"query": "<spring:message code="teacher.datatables.filter.8b"/>", "display": "<spring:message code="teacher.datatables.filter.8b"/>"},
						{"query": "<spring:message code="teacher.datatables.filter.8c"/>", "display": "<spring:message code="teacher.datatables.filter.8c"/>"},
						{"query": "<spring:message code="teacher.datatables.filter.8d"/>", "display": "<spring:message code="teacher.datatables.filter.8d"/>"},
						{"query": "<spring:message code="teacher.datatables.filter.8e"/>", "display": "<spring:message code="teacher.datatables.filter.8e"/>"},
						{"query": "<spring:message code="teacher.datatables.filter.8f"/>", "display": "<spring:message code="teacher.datatables.filter.8f"/>"},
						{"query": "<spring:message code="teacher.datatables.filter.8g"/>", "display": "<spring:message code="teacher.datatables.filter.8g"/>"}
					]
				}
			]
		});
		
		// define sort options
		var sortParams = {
			"items": [
				{"label": "<spring:message code="teacher.datatables.sort.2a"/>", "columns": [11,12,8], "directions": ["desc","asc","desc"] },
				{"label": "<spring:message code="teacher.datatables.sort.2b"/>", "columns": [8], "directions": ["desc"] },
				{"label": "<spring:message code="teacher.datatables.sort.2c"/>", "columns": [8], "directions": ["asc"] },
				{"label": "<spring:message code="teacher.datatables.sort.2d"/>", "columns": [14], "directions": ["desc"] },
				{"label": "<spring:message code="teacher.datatables.sort.2e"/>", "columns": [0], "directions": ["asc"] },
				{"label": "<spring:message code="teacher.datatables.sort.2f"/>", "columns": [0], "directions": ["desc"] }
			]
		}
		var wrapper = otable.fnSettings().nTableWrapper;
		var index = $.fn.dataTableExt.iApiIndex;
		// add sort logic
		setSort(index,sortParams,wrapper);
		
		// Make top header scroll with page
		var $stickyEl = $('.dataTables_wrapper .top'),
			elTop = $stickyEl.offset().top,
			width = $stickyEl.width();
		$(window).scroll(function() {
	        var windowTop = $(window).scrollTop();
	        if (windowTop > elTop) {
	            $stickyEl.addClass('sticky');
	        	$stickyEl.css('width',width);
	        } else {
	            $stickyEl.removeClass('sticky');
	        	$stickyEl.css('width','auto');
	        }
	    });
		
		/**
		 * Setup datatable sorting
		 * @method setSort
		 * @param {integer} index iApiIndex of datatables object
		 * @param {object} sortParams Sort settings object
		 * @param {object} wrapper Dom element of datatables wrapper
		 * @returns void
		 */
		function setSort(index,sortParams,wrapper) {
			if(sortParams.items.length){
				// insert sort options into DOM
				var sortHtml = '<div class="dataTables_sort"><spring:message code="teacher.datatables.sort.label"/> <select id="' + 'datatablesSort_' + index + '"  size="1">';
				$.each(sortParams.items,function(){
					sortHtml += '<option>' + this.label + '</option>';
				});
				sortHtml +=	'</select></div>';
				$(wrapper).children('.top').prepend(sortHtml);
				
				$('#datatablesSort_' + index).change(function(){
					$.fn.dataTableExt.iApiIndex = index;
					var i = $('option:selected', '#datatablesSort_' + index).index();
					var sortOptions = [];
					for(var a=0;a<sortParams.items[i].columns.length;a++){
						sortOptions.push([sortParams.items[i].columns[a],sortParams.items[i].directions[a]]);
					}
					otable.fnSort( sortOptions );
				});
			}
		};
		
		/**
		 * Show or hide list of child projects for a root project
		 * @method toggleChildren
		 * @param {string} id Root project's projectId
		 * @param {boolean} open Boolean to specify whether children should be shown (optional) 
		 * @returns void
		 */
		function toggleChildren(id,open){
			if (typeof open == 'undefined'){
				open = false;
			}
			var text = $('#childToggle_' + id).text();
			if(open){
				$('#childToggle_' + id).addClass('expanded');
				$('div[rootid="' + id + '"]').slideDown('fast');
				text = text.replace('+','-');
				$('#childToggle_' + id).text(text);
			} else {
				$('#childToggle_' + id).removeClass('expanded');
				if($('#projectBox_' + id).is(":hidden")) {
					$('div[rootid="' + id + '"]').hide();
				} else {
					$('div[rootid="' + id + '"]').slideUp("fast");
				}
				text = text.replace('-','+');
				$('#childToggle_' + id).text(text);
			}
		};
		
		/**
		 * Add child projects back into DOM as appended divs (not trs - to preserve datatables paging)
		 * @method addChildren
		 * @returns void
		 */
		function addChildren(){
			for (var i=0; i<rootProjectIds.length; i++){
				var id = rootProjectIds[i];
				var parent = $('#projectBox_' + id);
				var key = "children_" + id;
				for (var a=0; a<children[key].length; a++){
					parent.after($(children[key][a]));
				}
			}
		};
		
		/**
		 * Dynamically set width of project title depending on which tool links are active for the project
		 * @method setTitleWidth
		 * @param {object} projectDiv DOM element of target project
		 * @returns void
		 */
		function setTitleWidth(projectDiv){
			var id = $(projectDiv).attr('id');
			var toolWidth = $('#' + id + ' .projectTools').width();
			var titleWidth = $('#' + id + ' .projectHeader').width() - toolWidth - 10;
			$('#' + id + ' .projectInfo').width(titleWidth);
		}
		
		/**
		 * Show or hide detailed info for a project
		 * @method toggleDetails
		 * @param {string} id Target project's projectId
		 * @param {boolean} open Boolean to specify whether details should be shown or hidden (optional)
		 * @returns void
		 */
		function toggleDetails(id,open){
			if (typeof open == 'undefined'){
				open = false;
			}
			if (open){
				if($('#projectBox_' + id).hasClass('childProject')){
					$('#projectBox_' + id + ' .childDate').hide();
					$('#projectBox_' + id + ' ul.actions').show(0,function(){
						setTitleWidth($('#projectBox_' + id));
					});
					$('#projectBox_' + id + ' .projectSummary').slideDown('fast');
					$('#projectBox_' + id + ' .detailsLinks').slideDown('fast');
				} else {
					$('#summaryText_' + id + ' .ellipsis').remove();
					$('#summaryText_' + id + ' .truncated').slideDown('fast');
					$('#summaryText_' + id + ' .truncated').css('display','inline');
				}
				$('#detailsToggle_' + id).addClass('expanded').text('<spring:message code="teacher.manage.library.29" />');
				$('#details_' + id).slideDown('fast');
			} else {
				if($('#projectBox_' + id).hasClass('childProject')){
					$('#projectBox_' + id + ' ul.actions').hide();
					$('#projectBox_' + id + ' .childDate').show(0,function(){
						setTitleWidth($('#projectBox_' + id));
					});
					if($('#projectBox_' + id).is(":hidden")) {
						$('#projectBox_' + id + ' .projectSummary').hide();
						$('#projectBox_' + id + ' .detailsLinks').hide();
					} else {
						$('#projectBox_' + id + ' .projectSummary').slideUp('fast');
						$('#projectBox_' + id + ' .detailsLinks').slideUp('fast');
					}
				} else {
					if($('#summaryText_' + id + ' span.ellipsis').length == 0){
						$('#summaryText_' + id + ' .truncated').before('<span class="ellipsis">...</span>');	
					}
					if($('#projectBox_' + id).is(":hidden")) {
						$('#summaryText_' + id + ' .truncated').hide();
					} else {
						$('#summaryText_' + id + ' .truncated').slideUp('fast');
					}
				}
				if($('#projectBox_' + id).is(":hidden")) {
					$('#details_' + id).hide();
				} else {
					$('#details_' + id).slideUp('fast');
				}
				$('#detailsToggle_' + id).removeClass('expanded').text('<spring:message code="teacher.manage.library.28" />');
			}
		};
		
		/**
		 * Gray out project parents or children that are not matches for the current filters
		 * @method processFilters
		 * @param {object} oSettings Setting object of datatables instance
		 * @returns void
		 */
		function processFilters(oSettings){
			$('.projectBox',otable.fnGetNodes()).removeClass('noMatch');
			
			var searchStrings = [], // array to hold keyword search strings
			filterStrings = [], // array to hold selected faceted filter options (except source)
			sourceStrings = [], // array to hold selected source options
			favoriteOptions = []; // array to hold favorite filter options
			var matchIds = []; // array to hold div ids that match all filters
			
			// populate filter arrays
			for(iCol = 0; iCol < oSettings.aoPreSearchCols.length; iCol++) {
				if (oSettings.aoPreSearchCols[ iCol ].sSearch != '' && oSettings.aoPreSearchCols[ iCol ].sSearch != null) {
					var current = [];
					if(iCol==0){
						current = oSettings.aoPreSearchCols[ iCol ].sSearch.split(/[\s]+/);
						for (var i=0; i<current.length; i++){
							searchStrings.push(current[i]);
						}
					} else if (iCol==2){
						current = oSettings.aoPreSearchCols[ iCol ].sSearch.split('|');
						for (var i=0; i<current.length; i++){
							sourceStrings.push(current[i]);
						}
					} else if (iCol==9){
						current = oSettings.aoPreSearchCols[ iCol ].sSearch;
						favoriteOptions.push(current);
					} else {
						current = oSettings.aoPreSearchCols[ iCol ].sSearch.split('|');
						for (var i=0; i<current.length; i++){
							filterStrings.push(current[i]);
						}
					}
					
				}
			}
			
			// process filter arrays - check whether current filters match each project in filter results
			// gray out divs of non-matches
			$('.projectBox',otable.fnGetFilteredNodes()).each(function(){
				var searchMatch = true,
					filterMatch = true,
					sourceMatch = true,
					favoriteMatch = true;
				if (searchStrings.length > 0){
					for (var i=0; i<searchStrings.length; i++){
						if($(this).text().match(new RegExp(searchStrings[i], "i"))){
							searchMatch = true;
						} else {
							searchMatch = false;
							break;
						}
					}
				}
				if (searchMatch){
					if (filterStrings.length > 0){
						for (var i=0; i<filterStrings.length; i++){
							if($('.basicInfo', this).text().match(new RegExp(filterStrings[i], "i"))){
								filterMatch = true;
								break;
							} else {
								filterMatch = false;
							}
						}
					}
				}
				if (filterMatch){
					if (sourceStrings.length > 0){
						for (var i=0; i<sourceStrings.length; i++){
							if($(this).hasClass(sourceStrings[i])){
								sourceMatch = true;
								break;
							} else {
								sourceMatch = false;
							}
						}
					}
				}
				if (sourceMatch){
					if (favoriteOptions.length > 0){
						for (var i=0; i<favoriteOptions.length; i++){
							if($('.bookmark',this).hasClass(favoriteOptions[i])){
								favoriteMatch = true;
								break;
							} else {
								favoriteMatch = false;
							}
						}
					}
				}
				if (!filterMatch || !searchMatch || !sourceMatch || !favoriteMatch){
					$(this).addClass('noMatch');
				}
			});
			
			// if at least one child matches in a family, show them
			$('.childToggle').each(function(){
				var id = $(this).attr('id').replace('childToggle_',''),
					match = false,
					children = $('div[rootid="' + id + '"]');
				for(var i=0; i<children.length; i++){
					if (!$(children[i]).hasClass('noMatch')){
						match = true;
						break;
					}
				};
				if (match){
					toggleChildren(id,true);
				}
			});
			updateProjectCounts(true,otable.fnGetFilteredNodes());
		};
		
		/**
		 * Update the jQuery datables instance's info display with correct project count depending on set filters (count all matched projects)
		 * @method updateProjectCounts
		 * @param {boolean} filtered Boolean specifying whether datables instance has been filtered
		 * @param {object} $targets Set of target DOM elements 
		 * @returns void
		 */
		function updateProjectCounts(filtered,$targets){
			var $items;
			if($targets){
				$items = $('.projectBox:not(.noMatch)',$targets);
			} else {
				$items = $('.projectBox:not(.noMatch)');
			}
			if(filtered){
				var numResults = $items.length;
				$('#myProjects_wrapper .dataTables_info').text('<spring:message code="teacher.datatables.1"/> ' + 
						numResults + ' <spring:message code="teacher.datatables.16"/> ' + 
						'<spring:message code="teacher.datatables.17"/> ' +
						totalProjects + ' <spring:message code="teacher.datatables.18"/>');
			} else {
				$('#myProjects_wrapper .dataTables_info').text(totalProjects + ' <spring:message code="teacher.datatables.16"/>');
			}
		};
		
		// load project thumbnails		
		loadProjectThumbnails();
	});
</script>

<table id="myProjects" class="projectTable">
	<thead class="tableHeaderMain">
		<tr>
			<th><spring:message code="teacher.manage.library.1" /> (${fn:length(ownedProjectsList) + fn:length(sharedProjectsList) + fn:length(libraryProjectsList)})</th>
			<th>root project</th>
			<th>source</th>
			<th>subject</th>
			<th>grade level</th>
			<th>duration</th>
			<th>comp duration</th>
			<th>language</th>
			<th>date created</th>
			<th>isBookmarked</th>
			<th>isRoot</th>
			<th>isLibraryFamily</th>
			<th>libraryFamilyName</th>
			<th>libraryFamilyId</th>
			<th>last updated</th>
		</tr>
	</thead>
	<tbody>
		<c:choose>
			<c:when test="${fn:length(ownedProjectsList) > 0}">
				<c:forEach var="project" items="${ownedProjectsList}">
					<c:set var="projectName" value="${projectNameMap[project.id]}" />
					<c:set var="projectNameEscaped" value="${projectNameEscapedMap[project.id]}" />
					<tr class="projectRow" id="projectRow_${project.id}">
						<td>
							<c:set var="projectClass" value="projectBox owned" />
							<c:set var="isChildNoRoot" value="false" />
							<c:set var="isChild" value="false" />
							<c:choose>
								<c:when test="${project.rootProjectId == project.id}">
									<c:set var="projectClass" value="projectBox owned rootProject" />
								</c:when>
								<c:otherwise>
									<c:forEach var="item" items="${projectIds}">
									  <c:if test="${item eq project.rootProjectId}">
									    <c:set var="rootId" value="${project.rootProjectId}" />
									    <c:set var="projectClass" value="projectBox owned childProject" />
									    <c:set var="isChild" value="true" />
									  </c:if>
									</c:forEach>
									<c:if test="${!isChild}">
										<c:forEach var="item" items="${projectIds}">
										  <c:if test="${item eq project.parentProjectId}">
										  	<c:set var="projectClass" value="projectBox owned childProject" />
										    <c:set var="rootId" value="${project.parentProjectId}" />
										    <c:set var="isChildNoRoot" value="true" />
										  </c:if>
										</c:forEach>
									</c:if>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${isChild || isChildNoRoot}">
									<div class="${projectClass}" id="projectBox_${project.id}" rootid="${rootId}">
								</c:when>
								<c:otherwise>
									<div class="${projectClass}" id="projectBox_${project.id}">
								</c:otherwise>
							</c:choose>
								<div class="projectOverview">
									<div class="projectHeader">
										<div class="projectInfo">
											<c:set var="bookmarked" value="false" />
											<c:forEach var="bookmark" items="${bookmarkedProjectsList}">
												<c:if test="${bookmark.id == project.id}">
													<c:set var="bookmarked" value="true" />
												</c:if>
											</c:forEach>
											<a id="bookmark_${project.id}" class="bookmark ${bookmarked}" title="<spring:message code="teacher.manage.library.2" />"></a>
											<a class="projectTitle" id="project_${project.id}">${projectName}</a>
											<span>(<spring:message code="teacher.manage.library.4" /> ${project.id})</span>
										</div>
										<div class="projectTools">
											<c:if test="${isChild}">
												<span class="childDate"><spring:message code="teacher.manage.library.3" /> <fmt:formatDate value="${project.dateCreated}" type="date" dateStyle="medium" /></span>
											</c:if>
											<ul class="actions">
												<li><a href="<c:url value="/previewproject.html"><c:param name="projectId" value="${project.id}"/></c:url>" title="<spring:message code="teacher.manage.library.6a" />" target="_blank"><img class="icon" alt="preview" src="/webapp/themes/tels/default/images/icons/teal/screen.png" />
													<span<c:if test="${!isChild}"> style="font-weight:bold;"</c:if>><spring:message code="teacher.manage.library.6" /></span></a>&nbsp;|
												</li>
												<sec:accesscontrollist domainObject="${project}" hasPermission="2,16">
													<li><a id="shareProject_${project.id}" class="shareProject" title="<spring:message code="teacher.manage.library.7" /> ${project.name} (<spring:message code="teacher.manage.library.5" /> ${project.id})"><img class="icon" alt="share" src="/webapp/themes/tels/default/images/icons/teal/agent.png" /><span><spring:message code="teacher.manage.library.8" /></span></a>&nbsp;|</li>
												</sec:accesscontrollist>
												<li><a title="<spring:message code="teacher.manage.library.9a" />" onclick="copy('${project.id}','${project.projectType}','${projectNameEscaped}','${filenameMap[project.id]}','${urlMap[project.id]}')" ><img class="icon" alt="copy" src="/webapp/themes/tels/default/images/icons/teal/copy-item.png" /><span><spring:message code="teacher.manage.library.9" /></span></a>&nbsp;|</li>
												<sec:accesscontrollist domainObject="${project}" hasPermission="2,16">
													<li><a title="<spring:message code="teacher.manage.library.10a" />" href="/webapp/author/authorproject.html?projectId=${project.id}"><img class="icon" alt="edit" src="/webapp/themes/tels/default/images/icons/teal/edit.png" /><span><spring:message code="teacher.manage.library.10" /></span></a>&nbsp;|</li>
												</sec:accesscontrollist>
												<!-- <li><a style="color:#666;">Archive</a>
												<input type='checkbox' id='public_${project.id}' onclick='changePublic("${project.id}")'/> Is Public</li>-->
												<li><a class="setupRun" title="<spring:message code="teacher.manage.library.11a" />" href="<c:url value="../run/createRun.html"><c:param name="projectId" value="${project.id}"/></c:url>"><img class="icon" alt="new run" src="/webapp/themes/tels/default/images/icons/teal/computer.png" />
													<span<c:if test="${!isChild}"> style="font-weight:bold;"</c:if>><spring:message code="teacher.manage.library.11" /></span></a>
												</li>
											</ul>
										</div>
										<div style="clear:both;"></div>
									</div>
									<div class="projectSummary">
										<div class="projectThumb" thumbUrl="${projectThumbMap[project.id]}"><img src='/webapp/themes/tels/default/images/projectThumb.png' alt='thumb'></div>
										<div class="summaryInfo">
											<div class="basicInfo">
												<c:if test="${project.metadata.subject != null && project.metadata.subject != ''}">${project.metadata.subject} | </c:if>
												<c:if test="${project.metadata.gradeRange != null && project.metadata.gradeRange != ''}"><spring:message code="teacher.manage.library.20" /> ${project.metadata.gradeRange} | </c:if>
												<c:if test="${project.metadata.totalTime != null && project.metadata.totalTime != ''}"><spring:message code="teacher.manage.library.21" /> ${project.metadata.totalTime} | </c:if>
												<c:if test="${project.metadata.language != null && project.metadata.language != ''}">${project.metadata.language}</c:if>
												<div style="float:right;"><spring:message code="teacher.manage.library.3" /> <fmt:formatDate value="${project.dateCreated}" type="date" dateStyle="medium" /></div>
											</div>
											<div id="summaryText_${project.id}" class="summaryText">
											<c:if test="${project.metadata.summary != null && project.metadata.summary != ''}">
												<c:choose>
													<c:when test="${(fn:length(project.metadata.summary) > 170) && !isChild}">
														<c:set var="length" value="${fn:length(project.metadata.summary)}" />
														<c:set var="summary" value="${fn:substring(project.metadata.summary,0,170)}" />
														<c:set var="truncated" value="${fn:substring(project.metadata.summary,170,length)}" />
														<span style="font-weight:bold;"><spring:message code="teacher.manage.library.12" /></span> ${summary}<span class="ellipsis">...</span><span class="truncated">${truncated}</span>
													</c:when>
													<c:otherwise>
														<span style="font-weight:bold;"><spring:message code="teacher.manage.library.12" /></span> ${project.metadata.summary}
													</c:otherwise>
												</c:choose>
											</c:if>
											</div>
											<div class="details" id="details_${project.id}">
												<c:if test="${project.metadata.keywords != null && project.metadata.keywords != ''}"><p><span style="font-weight:bold;"><spring:message code="teacher.manage.library.13" /></span> ${project.metadata.keywords}</p></c:if>
												<c:if test="${project.metadata.techDetailsString != null && project.metadata.techDetailsString != ''}"><p><span style="font-weight:bold;"><spring:message code="teacher.manage.library.14" /></span> ${project.metadata.techDetailsString} (<a href="/webapp/check.html" target="_blank"><spring:message code="teacher.manage.library.22" /></a>)</p></c:if>
												<c:if test="${project.metadata.compTime != null && project.metadata.compTime != ''}"><p><span style="font-weight:bold;"><spring:message code="teacher.manage.library.15" /></span> ${project.metadata.compTime}</p></c:if>
												<p><span style="font-weight:bold;"><spring:message code="teacher.manage.library.19" /></span> <a href="/webapp/contactwiseproject.html?projectId=${project.id}"><spring:message code="teacher.manage.library.16" /></a></p>
												<c:if test="${project.metadata.author != null && project.metadata.author != ''}"><p><span style="font-weight:bold;"><spring:message code="teacher.manage.library.17" /></span> ${project.metadata.author}</p></c:if>
												<c:set var="lastEdited" value="${project.metadata.lastEdited}" />
												<c:if test="${lastEdited == null || lastEdited == ''}">
													<c:set var="lastEdited" value="${project.dateCreated}" />
												</c:if>
												<p><span style="font-weight:bold;"><spring:message code="teacher.manage.library.18" /></span> <fmt:formatDate value="${lastEdited}" type="both" dateStyle="medium" timeStyle="short" /></p>
												<c:if test="${project.parentProjectId != null}">
													<p><span style="font-weight:bold"><spring:message code="teacher.run.myprojectruns.40"/></span> <a id="projectDetail_${project.parentProjectId}" class="projectDetail" title="Project Details">${project.parentProjectId}</a></p>
												</c:if>
												<c:if test="${(project.metadata.lessonPlan != null && project.metadata.lessonPlan != '') ||
													(project.metadata.standards != null && project.metadata.standards != '')}">
													<div class="viewLesson"><a class="viewLesson" id="viewLesson_${project.id}" title="<spring:message code="teacher.manage.library.23" />"><spring:message code="teacher.manage.library.24" /></a></div>
													<div class="lessonPlan" id="lessonPlan_${project.id}" title="<spring:message code="teacher.manage.library.24" />">
														<div class="panelHeader">${project.name} (<spring:message code="teacher.manage.library.4" /> ${project.id})
															<span style="float:right;"><a class="printLesson" id="printLesson_${project.id}">Print</a></span>
														</div>
														<c:if test="${project.metadata.lessonPlan != null && project.metadata.lessonPlan != ''}">
															<div class="basicInfo sectionContent">
																<c:if test="${project.metadata.subject != null && project.metadata.subject != ''}">${project.metadata.subject} | </c:if>
																<c:if test="${project.metadata.gradeRange != null && project.metadata.gradeRange != ''}"><spring:message code="teacher.manage.library.20" /> ${project.metadata.gradeRange} | </c:if>
																<c:if test="${project.metadata.totalTime != null && project.metadata.totalTime != ''}"><spring:message code="teacher.manage.library.21" /> ${project.metadata.totalTime} | </c:if>
																<c:if test="${project.metadata.language != null && project.metadata.language != ''}">${project.metadata.language}</c:if>
																<c:if test="${project.metadata.techDetailsString != null && project.metadata.techDetailsString != ''}"><p><span style="font-weight:bold;"><spring:message code="teacher.manage.library.14" /></span> ${project.metadata.techDetailsString}</p></c:if>
															</div>
															<div class="sectionHead"><spring:message code="teacher.manage.library.25" /></div>
															<div class="lessonHelp"><spring:message code="teacher.manage.library.25a" /></div><!-- TODO: remove this, convert to global info/help rollover popup -->
															<div class="sectionContent">${project.metadata.lessonPlan}</div>
														</c:if>
														<c:if test="${project.metadata.standards != null && project.metadata.standards != ''}">
															<div class="sectionHead"><spring:message code="teacher.manage.library.26" /></div>
															<div class="lessonHelp"><spring:message code="teacher.manage.library.26a" /></div><!-- TODO: remove this, convert to global info/help rollover popup -->
															<div class="sectionContent">${project.metadata.standards}</div>
														</c:if>
													</div>
												</c:if>
												<c:if test="${fn:length(project.sharedowners) > 0}">
													<div class="sharedIcon">
														<img src="/webapp/themes/tels/default/images/shared.png" alt="shared project" />
														<spring:message code="teacher.manage.library.27" /> 
														<span style="font-weight:normal"><c:forEach var="sharedowner" items="${project.sharedowners}" varStatus="status">
														  <c:out value="${sharedowner.userDetails.firstname}"/>
														  <c:out value="${sharedowner.userDetails.lastname}"/>${not status.last ? ', ' : ''}
														</c:forEach></span>
													</div>
												</c:if>
											</div>
										</div>
									</div>
									<div style="clear:both;"></div>
									<div class="detailsLinks">
										<div style="float:right; text-align:right">
											<a id="detailsToggle_${project.id}" class="detailsToggle"><spring:message code="teacher.manage.library.28" /></a>
										</div>
										<div style="clear:both;"></div>
									</div>
								</div>
							</div>
						</td>
						<td style="display:none;">
							<c:choose>
								<c:when test="${isChildNoRoot}">
									${project.parentProjectId}
								</c:when>
								<c:otherwise>
									${project.rootProjectId}
								</c:otherwise>
							</c:choose>
						</td>
						<td style="display:none;">owned</td>
						<td style="display:none;">${project.metadata.subject}</td>
						<td style="display:none;">${project.metadata.gradeRange}</td>
						<td style="display:none;">${project.metadata.totalTime}</td>
						<td style="display:none;">${project.metadata.compTime}</td>
						<td style="display:none;">${project.metadata.language}</td>
						<td style="display:none;">${project.dateCreated}</td>
						<td style="display:none;">${bookmarked}</td>
						<c:set var="root" value="0" />
						<c:if test="${project.rootProjectId == project.id}">
							<c:set var="root" value="1" />
						</c:if>
						<td style="display:none;">${root}</td>
						<c:set var="isLibraryFamily" value="0" />
						<c:set var="libraryFamilyName" value="" />
						<c:set var="libraryFamilyId" value="" />
						<c:forEach var="libraryProject" items="${libraryProjectsList}">
							<c:if test="${project.rootProjectId == libraryProject.id}">
								<c:set var="isLibraryFamily" value="1" />
								<c:set var="libraryFamilyName" value="${libraryProject.name}" />
								<c:set var="libraryFamilyId" value="${libraryProject.id}" />
							</c:if>
						</c:forEach>
						<td style="display:none;">${isLibraryFamily}</td>
						<td style="display:none;">${libraryFamilyName}</td>
						<td style="display:none;">${libraryFamilyId}</td>
						<td style="display:none;">${lastEdited}</td>
					</tr>
				</c:forEach>
			</c:when>
		</c:choose>
		
		<c:choose>
			<c:when test="${fn:length(sharedProjectsList) > 0}">
				<c:forEach var="project" items="${sharedProjectsList}">
					<c:set var="projectName" value="${projectNameMap[project.id]}" />
					<c:set var="projectNameEscaped" value="${projectNameEscapedMap[project.id]}" />
					<tr class="projectRow"  id="projectRow_${project.id}">
						<td>
							<c:set var="projectClass" value="projectBox shared" />
							<c:set var="isChildNoRoot" value="false" />
							<c:set var="isChild" value="false" />
							<c:choose>
								<c:when test="${project.rootProjectId == project.id}">
									<c:set var="projectClass" value="projectBox shared rootProject" />
								</c:when>
								<c:otherwise>
									<c:forEach var="item" items="${projectIds}">
									  <c:if test="${item eq project.rootProjectId}">
									    <c:set var="rootId" value="${project.rootProjectId}" />
									    <c:set var="projectClass" value="projectBox shared childProject" />
									    <c:set var="isChild" value="true" />
									  </c:if>
									</c:forEach>
									<c:if test="${!isChild}">
										<c:forEach var="item" items="${projectIds}">
										  <c:if test="${item eq project.parentProjectId}">
										  	<c:set var="projectClass" value="projectBox shared childProject" />
										    <c:set var="rootId" value="${project.parentProjectId}" />
										    <c:set var="isChildNoRoot" value="true" />
										  </c:if>
										</c:forEach>
									</c:if>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${isChild || isChildNoRoot}">
									<div class="${projectClass}" id="projectBox_${project.id}" rootid="${rootId}">
								</c:when>
								<c:otherwise>
									<div class="${projectClass}" id="projectBox_${project.id}">
								</c:otherwise>
							</c:choose>
								<div class="projectOverview">
									<div class="projectHeader">
										<div class="projectInfo">
											<c:set var="bookmarked" value="false" />
											<c:forEach var="bookmark" items="${bookmarkedProjectsList}">
												<c:if test="${bookmark.id == project.id}">
													<c:set var="bookmarked" value="true" />
												</c:if>
											</c:forEach>
											<a id="bookmark_${project.id}" class="bookmark ${bookmarked}" title="<spring:message code="teacher.manage.library.2" />"></a>
											<a class="projectTitle" id="project_${project.id}">${project.name}</a>
											<span>(<spring:message code="teacher.manage.library.4" /> ${project.id})</span>
										</div>
										<div class="projectTools">
											<c:if test="${isChild}">
												<span class="childDate"><spring:message code="teacher.manage.library.3" /> <fmt:formatDate value="${project.dateCreated}" type="date" dateStyle="medium" /></span>
											</c:if>
											<ul class="actions">
												<li><a href="<c:url value="/previewproject.html"><c:param name="projectId" value="${project.id}"/></c:url>" title="<spring:message code="teacher.manage.library.6a" />" target="_blank"><img class="icon" alt="preview" src="/webapp/themes/tels/default/images/icons/teal/screen.png" />
													<span<c:if test="${!isChild}"> style="font-weight:bold;"</c:if>><spring:message code="teacher.manage.library.6" /></span></a>&nbsp;|
												</li>
												<sec:accesscontrollist domainObject="${project}" hasPermission="2,16">
													<li><a id="shareProject_${project.id}" class="shareProject" title="<spring:message code="teacher.manage.library.7" /> ${project.name} (<spring:message code="teacher.manage.library.5" /> ${project.id})"><img class="icon" alt="share" src="/webapp/themes/tels/default/images/icons/teal/agent.png" /><span><spring:message code="teacher.manage.library.8" /></span></a>&nbsp;|</li>
												</sec:accesscontrollist>
												<li><a title="<spring:message code="teacher.manage.library.9a" />" onclick="copy('${project.id}','${project.projectType}','${projectNameEscaped}','${filenameMap[project.id]}','${urlMap[project.id]}')" ><img class="icon" alt="copy" src="/webapp/themes/tels/default/images/icons/teal/copy-item.png" /><span><spring:message code="teacher.manage.library.9" /></span></a>&nbsp;|</li>
												<sec:accesscontrollist domainObject="${project}" hasPermission="2,16">
													<li><a title="<spring:message code="teacher.manage.library.10a" />" href="/webapp/author/authorproject.html?projectId=${project.id}"><img class="icon" alt="edit" src="/webapp/themes/tels/default/images/icons/teal/edit.png" /><span><spring:message code="teacher.manage.library.10" /></span></a>&nbsp;|</li>
												</sec:accesscontrollist>
												<!-- <li><a style="color:#666;">Archive</a>
												<input type='checkbox' id='public_${project.id}' onclick='changePublic("${project.id}")'/> Is Public</li>-->
												<li><a class="setupRun" title="<spring:message code="teacher.manage.library.11a" />" href="<c:url value="../run/createRun.html"><c:param name="projectId" value="${project.id}"/></c:url>"><img class="icon" alt="new run" src="/webapp/themes/tels/default/images/icons/teal/computer.png" />
													<span<c:if test="${!isChild}"> style="font-weight:bold;"</c:if>><spring:message code="teacher.manage.library.11" /></span></a>
												</li>
											</ul>
										</div>
										<div style="clear:both;"></div>
									</div>
									<div class="projectSummary">
										<div class="projectThumb" thumbUrl="${projectThumbMap[project.id]}"><img src='/webapp/themes/tels/default/images/projectThumb.png' alt='thumb'></div>
										<div class="summaryInfo">
											<div class="sharedIcon">
											<c:if test="${fn:length(project.sharedowners) > 0}">
												<img src="/webapp/themes/tels/default/images/shared.png" alt="shared project" />
												Shared by 
												<c:forEach var="projectowner" items="${project.owners}" varStatus="status">
													<c:out value="${projectowner.userDetails.firstname}" />
						  							<c:out value="${projectowner.userDetails.lastname}" />
												</c:forEach>
											</c:if>
											</div>
											<div class="basicInfo">
												<c:if test="${project.metadata.subject != null && project.metadata.subject != ''}">${project.metadata.subject} | </c:if>
												<c:if test="${project.metadata.gradeRange != null && project.metadata.gradeRange != ''}"><spring:message code="teacher.manage.library.20" /> ${project.metadata.gradeRange} | </c:if>
												<c:if test="${project.metadata.totalTime != null && project.metadata.totalTime != ''}"><spring:message code="teacher.manage.library.21" /> ${project.metadata.totalTime} | </c:if>
												<c:if test="${project.metadata.language != null && project.metadata.language != ''}">${project.metadata.language}</c:if>
												<div style="float:right;"><spring:message code="teacher.manage.library.3" /> <fmt:formatDate value="${project.dateCreated}" type="date" dateStyle="medium" /></div>
											</div>
											<div id="summaryText_${project.id}" class="summaryText">
											<c:if test="${project.metadata.summary != null && project.metadata.summary != ''}">
												<c:choose>
													<c:when test="${(fn:length(project.metadata.summary) > 170) && !isChild}">
														<c:set var="length" value="${fn:length(project.metadata.summary)}" />
														<c:set var="summary" value="${fn:substring(project.metadata.summary,0,170)}" />
														<c:set var="truncated" value="${fn:substring(project.metadata.summary,170,length)}" />
														<span style="font-weight:bold;"><spring:message code="teacher.manage.library.12" /></span> ${summary}<span class="ellipsis">...</span><span class="truncated">${truncated}</span>
													</c:when>
													<c:otherwise>
														<span style="font-weight:bold;"><spring:message code="teacher.manage.library.12" /></span> ${project.metadata.summary}
													</c:otherwise>
												</c:choose>
											</c:if>
											</div>
											<div class="details" id="details_${project.id}">
												<c:if test="${project.metadata.keywords != null && project.metadata.keywords != ''}"><p><span style="font-weight:bold;"><spring:message code="teacher.manage.library.13" /></span> ${project.metadata.keywords}</p></c:if>
												<c:if test="${project.metadata.techDetailsString != null && project.metadata.techDetailsString != ''}"><p><span style="font-weight:bold;"><spring:message code="teacher.manage.library.14" /></span> ${project.metadata.techDetailsString} (<a href="/webapp/check.html" target="_blank"><spring:message code="teacher.manage.library.22" /></a>)</p></c:if>
												<c:if test="${project.metadata.compTime != null && project.metadata.compTime != ''}"><p><span style="font-weight:bold;"><spring:message code="teacher.manage.library.15" /></span> ${project.metadata.compTime}</p></c:if>
												<p><span style="font-weight:bold;"><spring:message code="teacher.manage.library.19" /></span> <a href="/webapp/contactwiseproject.html?projectId=${project.id}"><spring:message code="teacher.manage.library.16" /></a></p>
												<c:if test="${project.metadata.author != null && project.metadata.author != ''}"><p><span style="font-weight:bold;"><spring:message code="teacher.manage.library.17" /></span> ${project.metadata.author}</p></c:if>
												<c:set var="lastEdited" value="${project.metadata.lastEdited}" />
												<c:if test="${lastEdited == null || lastEdited == ''}">
													<c:set var="lastEdited" value="${project.dateCreated}" />
												</c:if>
												<p><span style="font-weight:bold;"><spring:message code="teacher.manage.library.18" /></span> <fmt:formatDate value="${lastEdited}" type="both" dateStyle="medium" timeStyle="short" /></p>
												<c:if test="${project.parentProjectId != null}">
													<p><span style="font-weight:bold"><spring:message code="teacher.run.myprojectruns.40"/></span> <a id="projectDetail_${project.parentProjectId}" class="projectDetail" title="Project Details">${project.parentProjectId}</a></p>
												</c:if>
												<c:if test="${(project.metadata.lessonPlan != null && project.metadata.lessonPlan != '') ||
													(project.metadata.standards != null && project.metadata.standards != '')}">
													<div class="viewLesson"><a class="viewLesson" id="viewLesson_${project.id}" title="<spring:message code="teacher.manage.library.23" />"><spring:message code="teacher.manage.library.24" /></a></div>
													<div class="lessonPlan" id="lessonPlan_${project.id}" title="<spring:message code="teacher.manage.library.24" />">
														<div class="panelHeader">${project.name} (<spring:message code="teacher.manage.library.4" /> ${project.id})
															<span style="float:right;"><a class="printLesson" id="printLesson_${project.id}">Print</a></span>
														</div>
														<c:if test="${project.metadata.lessonPlan != null && project.metadata.lessonPlan != ''}">
															<div class="basicInfo sectionContent">
																<c:if test="${project.metadata.subject != null && project.metadata.subject != ''}">${project.metadata.subject} | </c:if>
																<c:if test="${project.metadata.gradeRange != null && project.metadata.gradeRange != ''}"><spring:message code="teacher.manage.library.20" /> ${project.metadata.gradeRange} | </c:if>
																<c:if test="${project.metadata.totalTime != null && project.metadata.totalTime != ''}"><spring:message code="teacher.manage.library.21" /> ${project.metadata.totalTime} | </c:if>
																<c:if test="${project.metadata.language != null && project.metadata.language != ''}">${project.metadata.language}</c:if>
																<c:if test="${project.metadata.techDetailsString != null && project.metadata.techDetailsString != ''}"><p><span style="font-weight:bold;"><spring:message code="teacher.manage.library.14" /></span> ${project.metadata.techDetailsString}</p></c:if>
															</div>
															<div class="sectionHead"><spring:message code="teacher.manage.library.25" /></div>
															<div class="lessonHelp"><spring:message code="teacher.manage.library.25a" /></div><!-- TODO: remove this, convert to global info/help rollover popup -->
															<div class="sectionContent">${project.metadata.lessonPlan}</div>
														</c:if>
														<c:if test="${project.metadata.standards != null && project.metadata.standards != ''}">
															<div class="sectionHead"><spring:message code="teacher.manage.library.26" /></div>
															<div class="lessonHelp"><spring:message code="teacher.manage.library.26a" /></div><!-- TODO: remove this, convert to global info/help rollover popup -->
															<div class="sectionContent">${project.metadata.standards}</div>
														</c:if>
													</div>
												</c:if>
												<c:if test="${fn:length(project.sharedowners) > 0}">
													<div class="sharedIcon">
														<img src="/webapp/themes/tels/default/images/shared.png" alt="shared project" />
														<spring:message code="teacher.manage.library.27" /> 
														<span style="font-weight:normal"><c:forEach var="sharedowner" items="${project.sharedowners}" varStatus="status">
														  <c:out value="${sharedowner.userDetails.firstname}"/>
														  <c:out value="${sharedowner.userDetails.lastname}"/>${not status.last ? ', ' : ''}
														</c:forEach></span>
													</div>
												</c:if>
											</div>
										</div>
									</div>
									<div style="clear:both;"></div>
									<div class="detailsLinks">
										<div style="float:right; text-align:right">
											<a id="detailsToggle_${project.id}" class="detailsToggle"><spring:message code="teacher.manage.library.28" /></a>
										</div>
										<div style="clear:both;"></div>
									</div>
								</div>
							</div>
						</td>
						<td style="display:none;">
							<c:choose>
								<c:when test="${isChildNoRoot}">
									${project.parentProjectId}
								</c:when>
								<c:otherwise>
									${project.rootProjectId}
								</c:otherwise>
							</c:choose>
						</td>
						<td style="display:none;">shared</td>
						<td style="display:none;">${project.metadata.subject}</td>
						<td style="display:none;">${project.metadata.gradeRange}</td>
						<td style="display:none;">${project.metadata.totalTime}</td>
						<td style="display:none;">${project.metadata.compTime}</td>
						<td style="display:none;">${project.metadata.language}</td>
						<td style="display:none;">${project.dateCreated}</td>
						<td style="display:none;">${bookmarked}</td>
						<c:set var="root" value="0" />
						<c:if test="${project.rootProjectId == project.id}">
							<c:set var="root" value="1" />
						</c:if>
						<td style="display:none;">${root}</td>
						<c:set var="isLibraryFamily" value="0" />
						<c:set var="libraryFamilyName" value="" />
						<c:set var="libraryFamilyId" value="" />
						<c:forEach var="libraryProject" items="${libraryProjectsList}">
							<c:if test="${project.rootProjectId == libraryProject.id}">
								<c:set var="isLibraryFamily" value="1" />
								<c:set var="libraryFamilyName" value="${libraryProject.name}" />
								<c:set var="libraryFamilyId" value="${libraryProject.id}" />
							</c:if>
						</c:forEach>
						<td style="display:none;">${isLibraryFamily}</td>
						<td style="display:none;">${libraryFamilyName}</td>
						<td style="display:none;">${libraryFamilyId}</td>
						<td style="display:none;">${lastEdited}</td>
					</tr>
				</c:forEach>
			</c:when>
		</c:choose>
		
		<c:choose>
			<c:when test="${fn:length(libraryProjectsList) > 0}">
				<c:forEach var="project" items="${libraryProjectsList}">
					<c:set var="projectName" value="${projectNameMap[project.id]}" />
					<c:set var="projectNameEscaped" value="${projectNameEscapedMap[project.id]}" />
					<tr class="projectRow" id="projectRow_${project.id}">
						<td>
							<c:set var="projectClass" value="projectBox rootProject library" />
							<c:forEach var="item" items="${ownedRemove}">
								<c:if test="${project eq item}">
									<c:set var="projectClass" value="projectBox rootProject library owned" />
								</c:if>
							</c:forEach>
							<c:forEach var="item" items="${sharedRemove}">
								<c:if test="${project eq item}">
									<c:set var="projectClass" value="projectBox rootProject library shared" />
								</c:if>
							</c:forEach>
							<div class="${projectClass}" id="projectBox_${project.id}">
								<div class="projectOverview">
									<div class="projectHeader">
										<div class="projectInfo">
											<c:set var="bookmarked" value="false" />
											<c:forEach var="bookmark" items="${bookmarkedProjectsList}">
												<c:if test="${bookmark.id == project.id}">
													<c:set var="bookmarked" value="true" />
												</c:if>
											</c:forEach>
											<a id="bookmark_${project.id}" class="bookmark ${bookmarked}" title="<spring:message code="teacher.manage.library.2" />"></a>
											<a class="projectTitle" id="project_${project.id}">${project.name}</a>
											<span>(<spring:message code="teacher.manage.library.4" /> ${project.id})</span>
										</div>
										<div class="projectTools">
											<c:if test="${isChild}">
												<span class="childDate"><spring:message code="teacher.manage.library.3" /> <fmt:formatDate value="${project.dateCreated}" type="date" dateStyle="medium" /></span>
											</c:if>
											<ul class="actions">
												<li><a href="<c:url value="/previewproject.html"><c:param name="projectId" value="${project.id}"/></c:url>" title="<spring:message code="teacher.manage.library.6a" />" target="_blank"><img class="icon" alt="preview" src="/webapp/themes/tels/default/images/icons/teal/screen.png" />
													<span<c:if test="${!isChild}"> style="font-weight:bold;"</c:if>><spring:message code="teacher.manage.library.6" /></span></a>&nbsp;|
												</li>
												<sec:accesscontrollist domainObject="${project}" hasPermission="2,16">
													<li><a id="shareProject_${project.id}" class="shareProject" title="<spring:message code="teacher.manage.library.7" /> ${project.name} (<spring:message code="teacher.manage.library.5" /> ${project.id})"><img class="icon" alt="share" src="/webapp/themes/tels/default/images/icons/teal/agent.png" /><span><spring:message code="teacher.manage.library.8" /></span></a>&nbsp;|</li>
												</sec:accesscontrollist>
												<li><a title="<spring:message code="teacher.manage.library.9a" />" onclick="copy('${project.id}','${project.projectType}','${projectNameEscaped}','${filenameMap[project.id]}','${urlMap[project.id]}')" ><img class="icon" alt="copy" src="/webapp/themes/tels/default/images/icons/teal/copy-item.png" /><span><spring:message code="teacher.manage.library.9" /></span></a>&nbsp;|</li>
												<sec:accesscontrollist domainObject="${project}" hasPermission="2,16">
													<li><a title="<spring:message code="teacher.manage.library.10a" />" href="/webapp/author/authorproject.html?projectId=${project.id}"><img class="icon" alt="edit" src="/webapp/themes/tels/default/images/icons/teal/edit.png" /><span><spring:message code="teacher.manage.library.10" /></span></a>&nbsp;|</li>
												</sec:accesscontrollist>
												<!-- <li><a style="color:#666;">Archive</a>
												<input type='checkbox' id='public_${project.id}' onclick='changePublic("${project.id}")'/> Is Public</li>-->
												<li><a class="setupRun" title="<spring:message code="teacher.manage.library.11a" />" href="<c:url value="../run/createRun.html"><c:param name="projectId" value="${project.id}"/></c:url>"><img class="icon" alt="new run" src="/webapp/themes/tels/default/images/icons/teal/computer.png" />
													<span<c:if test="${!isChild}"> style="font-weight:bold;"</c:if>><spring:message code="teacher.manage.library.11" /></span></a>
												</li>
											</ul>
										</div>
									</div>
									<div style="clear:both;"></div>
									<div class="projectSummary">
										<div class="projectThumb" thumbUrl="${projectThumbMap[project.id]}"><img src='/webapp/themes/tels/default/images/projectThumb.png' alt='thumb'></div>
										<div class="summaryInfo">
											<c:if test="${fn:length(project.sharedowners) > 0}">
												<div class="sharedIcon" style="float:right;">
													<img src="/webapp/themes/tels/default/images/shared.png" alt="shared project" />
													Shared by 
													<c:forEach var="projectowner" items="${project.owners}" varStatus="status">
														<c:out value="${projectowner.userDetails.firstname}" />
							  							<c:out value="${projectowner.userDetails.lastname}" />
													</c:forEach>
												</div>
											</c:if>
											<div class="libraryIcon"><img src="/webapp/themes/tels/default/images/open_book.png" alt="library project" /> <spring:message code="teacher.manage.library.32" /></div>
											<div class="basicInfo">
												<c:if test="${project.metadata.subject != null && project.metadata.subject != ''}">${project.metadata.subject} | </c:if>
												<c:if test="${project.metadata.gradeRange != null && project.metadata.gradeRange != ''}"><spring:message code="teacher.manage.library.20" /> ${project.metadata.gradeRange} | </c:if>
												<c:if test="${project.metadata.totalTime != null && project.metadata.totalTime != ''}"><spring:message code="teacher.manage.library.21" /> ${project.metadata.totalTime} | </c:if>
												<c:if test="${project.metadata.language != null && project.metadata.language != ''}">${project.metadata.language}</c:if>
												<div style="float:right;"><spring:message code="teacher.manage.library.3" /> <fmt:formatDate value="${project.dateCreated}" type="date" dateStyle="medium" /></div>
											</div>
											<div id="summaryText_${project.id}" class="summaryText">
											<c:if test="${project.metadata.summary != null && project.metadata.summary != ''}">
												<c:choose>
													<c:when test="${(fn:length(project.metadata.summary) > 170) && (projectClass != 'projectBox childProject')}">
														<c:set var="length" value="${fn:length(project.metadata.summary)}" />
														<c:set var="summary" value="${fn:substring(project.metadata.summary,0,170)}" />
														<c:set var="truncated" value="${fn:substring(project.metadata.summary,170,length)}" />
														<span style="font-weight:bold;"><spring:message code="teacher.manage.library.12" /></span> ${summary}<span class="ellipsis">...</span><span class="truncated">${truncated}</span>
													</c:when>
													<c:otherwise>
														<span style="font-weight:bold;"><spring:message code="teacher.manage.library.12" /></span> ${project.metadata.summary}
													</c:otherwise>
												</c:choose>
											</c:if>
											</div>
											<div class="details" id="details_${project.id}">
												<c:if test="${project.metadata.keywords != null && project.metadata.keywords != ''}"><p><span style="font-weight:bold;"><spring:message code="teacher.manage.library.13" /></span> ${project.metadata.keywords}</p></c:if>
												<c:if test="${project.metadata.techDetailsString != null && project.metadata.techDetailsString != ''}"><p><span style="font-weight:bold;"><spring:message code="teacher.manage.library.14" /></span> ${project.metadata.techDetailsString} (<a href="/webapp/check.html" target="_blank"><spring:message code="teacher.manage.library.22" /></a>)</p></c:if>
												<c:if test="${project.metadata.compTime != null && project.metadata.compTime != ''}"><p><span style="font-weight:bold;"><spring:message code="teacher.manage.library.15" /></span> ${project.metadata.compTime}</p></c:if>
												<p><span style="font-weight:bold;"><spring:message code="teacher.manage.library.19" /></span> <a href="/webapp/contactwiseproject.html?projectId=${project.id}"><spring:message code="teacher.manage.library.16" /></a></p>
												<c:if test="${project.metadata.author != null && project.metadata.author != ''}"><p><span style="font-weight:bold;"><spring:message code="teacher.manage.library.17" /></span> ${project.metadata.author}</p></c:if>
												<c:set var="lastEdited" value="${project.metadata.lastEdited}" />
												<c:if test="${lastEdited == null || lastEdited == ''}">
													<c:set var="lastEdited" value="${project.dateCreated}" />
												</c:if>
												<p><span style="font-weight:bold;"><spring:message code="teacher.manage.library.18" /></span> <fmt:formatDate value="${lastEdited}" type="both" dateStyle="medium" timeStyle="short" /></p>
												<c:if test="${(project.metadata.lessonPlan != null && project.metadata.lessonPlan != '') ||
													(project.metadata.standards != null && project.metadata.standards != '')}">
													<div class="viewLesson"><a class="viewLesson" id="viewLesson_${project.id}" title="<spring:message code="teacher.manage.library.23" />"><spring:message code="teacher.manage.library.24" /></a></div>
													<div class="lessonPlan" id="lessonPlan_${project.id}" title="<spring:message code="teacher.manage.library.24" />">
														<div class="panelHeader">${project.name} (<spring:message code="teacher.manage.library.4" /> ${project.id})
															<span style="float:right;"><a class="printLesson" id="printLesson_${project.id}">Print</a></span>
														</div>
														<c:if test="${project.metadata.lessonPlan != null && project.metadata.lessonPlan != ''}">
															<div class="basicInfo sectionContent">
																<c:if test="${project.metadata.subject != null && project.metadata.subject != ''}">${project.metadata.subject} | </c:if>
																<c:if test="${project.metadata.gradeRange != null && project.metadata.gradeRange != ''}"><spring:message code="teacher.manage.library.20" /> ${project.metadata.gradeRange} | </c:if>
																<c:if test="${project.metadata.totalTime != null && project.metadata.totalTime != ''}"><spring:message code="teacher.manage.library.21" /> ${project.metadata.totalTime} | </c:if>
																<c:if test="${project.metadata.language != null && project.metadata.language != ''}">${project.metadata.language}</c:if>
																<c:if test="${project.metadata.techDetailsString != null && project.metadata.techDetailsString != ''}"><p><span style="font-weight:bold;"><spring:message code="teacher.manage.library.14" /></span> ${project.metadata.techDetailsString}</p></c:if>
															</div>
															<div class="sectionHead"><spring:message code="teacher.manage.library.25" /></div>
															<div class="lessonHelp"><spring:message code="teacher.manage.library.25a" /></div><!-- TODO: remove this, convert to global info/help rollover popup -->
															<div class="sectionContent">${project.metadata.lessonPlan}</div>
														</c:if>
														<c:if test="${project.metadata.standards != null && project.metadata.standards != ''}">
															<div class="sectionHead"><spring:message code="teacher.manage.library.26" /></div>
															<div class="lessonHelp"><spring:message code="teacher.manage.library.26a" /></div><!-- TODO: remove this, convert to global info/help rollover popup -->
															<div class="sectionContent">${project.metadata.standards}</div>
														</c:if>
													</div>
											</c:if>
											</div>
										</div>
									</div>
									<div style="clear:both;"></div>
									<div class="detailsLinks">
										<div style="float:right; text-align:right">
											<a id="detailsToggle_${project.id}" class="detailsToggle"><spring:message code="teacher.manage.library.28" /></a>
										</div>
										<div style="clear:both;"></div>
									</div>
								</div>
							</div>
						</td>
						<td style="display:none;">${project.rootProjectId}</td>
						<td style="display:none;">library</td>
						<td style="display:none;">${project.metadata.subject}</td>
						<td style="display:none;">${project.metadata.gradeRange}</td>
						<td style="display:none;">${project.metadata.totalTime}</td>
						<td style="display:none;">${project.metadata.compTime}</td>
						<td style="display:none;">${project.metadata.language}</td>
						<td style="display:none;">${project.dateCreated}</td>
						<td style="display:none;">${bookmarked}</td>
						<td style="display:none;">1</td>
						<td style="display:none;">1</td>
						<td style="display:none;">${project.name}</td>
						<td style="display:none;">${project.id}</td>
						<td style="display:none;">${lastEdited}</td>
					</tr>
				</c:forEach>
			</c:when>
		</c:choose>
		
	</tbody>
</table>

<div id="projectDetailDialog" style="overflow:hidden;" class="dialog"></div>
<div id="shareDialog" class="dialog"></div>