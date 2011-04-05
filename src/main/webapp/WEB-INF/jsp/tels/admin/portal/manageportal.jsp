<%@ include file="../../include.jsp"%>
<html>
<head>
<script type="text/javascript" src="../../javascript/tels/jquery-1.4.1.min.js"></script>

<script type="text/javascript">
$(document).ready(function() {
  $(".isLoginAllowedSelect").bind("change",
		  function() {
	        var portalId = this.id.substr(this.id.lastIndexOf("_")+1);
	        $(this).find(":selected").each(function() {
	    	        var isLoginAllowed = $(this).val();
	    	    	$.ajax(
	    	    	    	{type:'POST', 
	    		    	    	url:'manageportal.html', 
	    		    	    	data:'attr=isLoginAllowed&portalId=' + portalId + '&val=' + isLoginAllowed, 
	    		    	    	error:function(){alert('Error: please talk to wise administrator, which might be you. If this is the case, please talk to yourself.');}, 
	    		    	    	success:function(){}
	    	    	    	});
	        });
  });  
});
</script>
</head>
<body>
<a href="../index.html">Go back to Admin home page</a>
<br/><br/>
<br/>
name: ${portal.portalName}
<br/>
address: ${portal.address}
<br/>
send_email_on_exception: ${portal.sendMailOnException}
<br/>
<br/>
Is Login Allowed:
<select class="isLoginAllowedSelect" id="isLoginAllowedSelect_${portal.id}">
	    		<c:choose>
	    			<c:when test="${portal.loginAllowed}">
				    	<option value="true" selected="selected">YES</option>
	    				<option value="false">NO</option>
	    			</c:when>
	    			<c:otherwise>
				    	<option value="true">YES</option>
	    				<option value="false" selected="selected">NO</option>
	    			</c:otherwise>
	    		</c:choose>
</select>


<br/><br/>
<a href="../index.html">Go back to Admin home page</a>
</body>
</html>
