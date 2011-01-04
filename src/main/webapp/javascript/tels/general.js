
var wiseImages = new Array('./themes/tels/default/images/wiseInAction/kidsOnComputer.jpg','./themes/tels/default/images/wiseInAction/kidsinaquarium.jpg','./themes/tels/default/images/wiseInAction/csiScreenshot.jpg','./themes/tels/default/images/wiseInAction/Studentputdata.jpg','./themes/tels/default/images/wiseInAction/AirBag.jpg','./themes/tels/default/images/wiseInAction/Reflection.jpg','./themes/tels/default/images/wiseInAction/PondSim.jpg','./themes/tels/default/images/wiseInAction/OnlineDiscussion.jpg',
'./themes/tels/default/images/wiseInAction/MolecularModel.jpg','./themes/tels/default/images/wiseInAction/SkinCells.jpg');

function swapImage(id,link){
	if(document.images){
		document.getElementById(id).src=link;
	}
};

function swapWelcomeMsg(index) {
	$('.welcomeBullet').hide();
	$('.welcomeBullet:eq('+ index +')').fadeIn('slow',function(){
		$(this).removeAttr('filter');
	});
};

function changeNavigationColor(id,link){
	if(document.images){
		document.getElementById(id).src = link;
	}
}

function displayNotAvailable(message){
	alert(message);	
}

function moveToImage(id,value){
	if((value >=0) && (value < 10)){
		document.getElementById(id).src = wiseImages[value-1];	
	}
}

function changeText(id,value){
  value = value % 10;
  value += 1;
  document.getElementById(id).innerHTML= value + ' of 10';	
}

function changeText_T(id,value){
  value = value % 5;
  value += 1;
  document.getElementById(id).innerHTML= value + ' of 5';	
}


/*These two functions are used for the FORM HINT functionality on registration pages */

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
    	if (this.parentNode.getElementsByTagName("span").length > 0) {
    		this.parentNode.getElementsByTagName("span")[0].style.display = "inline";
    	}
    }
    inputs[i].onblur = function () {
    	if (this.parentNode.getElementsByTagName("span").length > 0) {
    		this.parentNode.getElementsByTagName("span")[0].style.display = "none";
    	}
    }
  }
  var selects = document.getElementsByTagName("select");
  for (var k=0; k<selects.length; k++){
    selects[k].onfocus = function () {
    	if (this.parentNode.getElementsByTagName("span").length > 0) {
    		this.parentNode.getElementsByTagName("span")[0].style.display = "inline";
    	}
    }
    selects[k].onblur = function () {
    	if (this.parentNode.getElementsByTagName("span").length > 0) {
    		this.parentNode.getElementsByTagName("span")[0].style.display = "none";
    	}
    }
  }
}
addLoadEvent(prepareInputsForHints);


// Added my MattFish to handle Rollover behavior on Home Page (index.html) //

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

// Added my MattFish to handle special Pop-Up Windows on Teacher Dashboard pages //

function popupSpecial(mylink, windowname)
		{
		if (! window.focus)return true;
		var href;
		if (typeof(mylink) == 'string')
		   href=mylink;
		else
		   href=mylink.href;
		window.open(href, windowname, 'width=850,height=600,resizable=yes,scrollbars=yes');
		return false;
		}
		

function popup640(mylink, windowname)
		{
		if (! window.focus)return true;
		var href;
		if (typeof(mylink) == 'string')
		   href=mylink;
		else
		   href=mylink.href;
		window.open(href, windowname, 'width=640,height=480,resizable=yes,scrollbars=yes');
		return false;
		}
		
function popup300(mylink, windowname)
		{
		if (! window.focus)return true;
		var href;
		if (typeof(mylink) == 'string')
		   href=mylink;
		else
		   href=mylink.href;
		window.open(href, windowname, 'width=300,height=300,resizable=yes,scrollbars=yes');
		return false;
		}
		
