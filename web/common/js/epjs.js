/* body */
function allblur() { 
for (i = 0; i < document.links.length; i++)
document.links[i].onfocus = document.links[i].blur;}

/* jumpMenu */
function MM_jumpMenu(targ,selObj,restore){ //v3.0
  eval(targ+".location='"+selObj.options[selObj.selectedIndex].value+"'");
  if (restore) selObj.selectedIndex=0;
}
/* table */
function fnSetSelectedRow(selectedRow) {
	var selectedRow = selectedRow.parentNode.parentNode;
	var rows = selectedRow.parentNode.getElementsByTagName("TR");
	for (var i=0; i<rows.length; i++) {
		if (rows[i].rowSelected && rows[i].rowSelected == "true") {
			rows[i].rowSelected = "false";
			cellOut(rows[i]);
			break;
		}
	}
	selectedRow.rowSelected = "true";
}
function cellOver(el) {
el.style.backgroundColor="#F7F9E7";
}
function cellOut(el){
if ( !(el.rowSelected && el.rowSelected == "true") ) el.style.backgroundColor="#FFFFFF";
}
function cellOut2(el){
el.style.backgroundColor="";
}
/* btn over */
   function changeImg() 
   { 
      var img_id = event.srcElement.id; 

      event.srcElement.src = "../images/" + img_id + "_on.gif"; 
   } 

   function restoreImg() 
   { 
      var img_id = event.srcElement.id; 
      event.srcElement.src = "../images/" + img_id + ".gif"; 
   } 
   
   function changeonImg() 
   { 
      var img_id = event.srcElement.id; 
      event.srcElement.src = "../images/" + img_id + "_on.gif"; 
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

function MM_nbGroup(event, grpName) { //v6.0
  var i,img,nbArr,args=MM_nbGroup.arguments;
  if (event == "init" && args.length > 2) {
    if ((img = MM_findObj(args[2])) != null && !img.MM_init) {
      img.MM_init = true; img.MM_up = args[3]; img.MM_dn = img.src;
      if ((nbArr = document[grpName]) == null) nbArr = document[grpName] = new Array();
      nbArr[nbArr.length] = img;
      for (i=4; i < args.length-1; i+=2) if ((img = MM_findObj(args[i])) != null) {
        if (!img.MM_up) img.MM_up = img.src;
        img.src = img.MM_dn = args[i+1];
        nbArr[nbArr.length] = img;
    } }
  } else if (event == "over") {
    document.MM_nbOver = nbArr = new Array();
    for (i=1; i < args.length-1; i+=3) if ((img = MM_findObj(args[i])) != null) {
      if (!img.MM_up) img.MM_up = img.src;
      img.src = (img.MM_dn && args[i+2]) ? args[i+2] : ((args[i+1])? args[i+1] : img.MM_up);
      nbArr[nbArr.length] = img;
    }
  } else if (event == "out" ) {
    for (i=0; i < document.MM_nbOver.length; i++) {
      img = document.MM_nbOver[i]; img.src = (img.MM_dn) ? img.MM_dn : img.MM_up; }
  } else if (event == "down") {
    nbArr = document[grpName];
    if (nbArr)
      for (i=0; i < nbArr.length; i++) { img=nbArr[i]; img.src = img.MM_up; img.MM_dn = 0; }
    document[grpName] = nbArr = new Array();
    for (i=2; i < args.length-1; i+=2) if ((img = MM_findObj(args[i])) != null) {
      if (!img.MM_up) img.MM_up = img.src;
      img.src = img.MM_dn = (args[i+1])? args[i+1] : img.MM_up;
      nbArr[nbArr.length] = img;
  } }
}

/* btn */
function btnOver(el) {
el.style.color="#0088D4";
}
function btnOut(el){
el.style.color="#2359A3";
}

function btnsOver(el) {
el.style.color="#000000";
}
function btnsOut(el){
el.style.color="#615C1C";
}

function seayOver(el) {
el.style.color="#000000";
}
function seayOut(el){
el.style.color="#FFFFFF";
}
function seaOver(el) {
el.style.color="#000000";
}
function seaOut(el){
el.style.color="#FFFFFF";
}
/* left_menu */
function js_menu(menuName, num) {
		if (eval(menuName + ".style.display != 'none'")) 
					js_menuhide(menuName, num);
		else js_menushow(menuName, num);			
}

function js_menushow(menuName, num) {
		eval(menuName + ".style.display = 'block'");
		eval("img" + num + ".src='../images/left_open.gif'");
}

function js_menuhide(menuName, num) {
		eval(menuName + ".style.display = 'none'");
		eval("img" + num + ".src='../images/left_close.gif'");
}
/* radio */
function MM_goToURL() { //v3.0
  var i, args=MM_goToURL.arguments; document.MM_returnValue = false;
  for (i=0; i<(args.length-1); i+=2) eval(args[i]+".location='"+args[i+1]+"'");
}

/* 여기서부터 임시로 추가 */
document.attachEvent ("onreadystatechange", function() {
  if (document.readyState=="complete")   {
    if (window.cbOnBeforeLoad) window.cbOnBeforeLoad();
  }
})

/**
 * @type   : function
 * @access : public
 * @desc   :
 * @author : tkyushin
 */
function actSubmitValidate(oform, action, target) {
  if (target) oform.target = target;
  if (action) oform.action = action;
  if (!oform.method) oform.method = "post";
  if (oform.fireSubmit) oform.fireSubmit();
  else oform.submit();

}

function actCancel(oform, action, target) {
  if (target) oform.target = target;
  if (action) oform.action = action;
  if (!oform.method) oform.method = "post";
  oform.reset();
  oform.submit();
}

function actSubmit(oform, action, target) {
  if (target) oform.target = target;
  if (action) oform.action = action;
  if (!oform.method) oform.method = "post";
  oform.submit();
}

function xjosiate(oTag) {
  _xjosiage(oTag.getElementsByTagName("INPUT"));
  _xjosiage(oTag.getElementsByTagName("SELECT"));
  _xjosiage(oTag.getElementsByTagName("TEXTAREA"));
}

function _xjosiage(oTags) {
  for (var idx=0; idx < oTags.length; idx ++) {
    if (!window.xGetOption("X_SUPPORT_HIDDEN_TYPE") && oTags[idx].type == 'hidden') continue;
    oTags[idx].initialize = em_initialize;
    oTags[idx].initialize(oTags[idx].form);
  }
}

function findParentTag(oTag, tagName) {
  while (oTag && oTag.tagName != "BODY") {
    if (oTag.tagName == tagName) return oTag;
    oTag = oTag.parentNode;
  }
  return null;
}

function findTagByName(oTag, tagName, name) {
  var tags = oTag.getElementsByTagName(tagName);
  for (var idx=0; idx<tags.length; idx++) {
    if (tags[idx].name == name) return tags[idx];
  }
  return null;
}

function flipCheckBox(oCheck) {
  if (!oCheck) return;
  if (oCheck.tagName && oCheck.tagName=="INPUT" && oCheck.type=="checkbox") {
    oCheck.checked = oCheck.checked ? false : true;
  } else if (oCheck.length && oCheck.length > 1) {
    var until = oCheck.length;
    for (var idx=0; idx < until; idx++) {
      oCheck[idx].checked = oCheck[idx].checked ? false : true;
    }
  }
}

function getCheckedOnly(inputs) {
  var result = new Array();
  if (inputs && inputs.tagName == "INPUT" && inputs.checked) result[0] = inputs;
  else if (inputs && inputs.length && inputs.length > 0 ) {
    var until = inputs.length;
    for (var idx=0; idx<until; idx++) {
      if (inputs[idx].tagName == "INPUT" && inputs[idx].checked) result[result.length] = inputs[idx];
    }
  }
  return result;
}


function cloneRow(sourceRowId, targetTableId, xjosEnable) {
  var oTR = document.getElementById(sourceRowId);
  var tTable = document.getElementById(targetTableId);
  var tTbody = tTable.tBodies[0];
  var oNewTR = oTR.cloneNode(true);
  oNewTR.id = "";
  tTbody.appendChild(oNewTR);
  //if (xjosEnable == true) xjosiate(oNewTR);
  return oNewTR;
}

function getLength(inputs) {
  return (!inputs || !inputs.length) ?  0 : inputs.length;
}


function clearInput(oInput) {
  if (oInput.tagName == "FORM") {
    var until = oInput.elements.length;
    for (var idx=0; idx < until; idx++) {
      clearInput(oInput.elements[idx]);
    }
  } else if (oInput.tagName == "INPUT" ||  oInput.tagName == "SELECT" || oInput.tagName == "TEXTAREA") {
      switch (oInput.type) {
        case "text" :  case "hidden" : case "password" : case "textarea" :
        case "select-one" : case "select-multiple" :
          oInput.value = "";
        break;
        case "radio" :  case "checkbox" :
          oInput.checked = false;
        break;
      }
  }
}

function removeOptions(oSelect) {
  if (oSelect.tagName != "SELECT") return;
  var until = oSelect.options.length;
  for (var idx=0; idx < until ; idx++) oSelect.remove(0);
}

/**
 * @desc   : 로컬 파일 크기 알아내는 함수. byte 크기를 리턴한다.
 * @source : http://javacan.madvirus.net/main/content/read.tle?contentId=121
 * @author : 최범균(madvirus@madvirus.net)
 */
function getFileSize(filePath) {
    var len = 0;
    if ( navigator.appName.indexOf("Netscape") != -1) {
        try {
            netscape.security.PrivilegeManager.enablePrivilege('UniversalXPConnect');
        } catch(e) {
            alert("signed.applets.codebase_principal_support를 설정해주세요!\n"+e);
            return -1;
        }
        try {
            var file = Components.classes["@mozilla.org/file/local;1"]
                                 .createInstance(Components.interfaces.nsILocalFile);
            file.initWithPath ( filePath );
            len = file.fileSize;
        } catch(e) {
            alert("에러 발생:"+e);
        }
    } else if (navigator.appName.indexOf('Microsoft') != -1) {
        var img = new Image();
        img.dynsrc = filePath;
        len = img.fileSize;
    }
    return len;
}

/**
 * 날짜선택용 달력(calendar.js가 반드시 import되어 있어야함)
 * oTarget : 날짜값이 찍힐 목표객체
 * anchorName : 달력이 위치할 기준 앵커이름(id, name 모두 지정되어야하며 동일해야 함)
 * dateFormat : 날짜값 포맷(yyyy, MM, dd 사용가능하며 미지정시 'yyyy/MM/dd' 포맷이 사용됨)
 */
function showCalendar(oTarget, anchorName, dateFormat) {
  var calendar = new CalendarPopup();
  calendar.setMonthNames('1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월');
  calendar.setDayHeaders('일','월','화','수','목','금','토');
  calendar.showNavigationDropdowns();
  calendar.setYearSelectStartOffset(3);
  calendar.setTodayText('오늘');

  if(!dateFormat) dateFormat = 'yyyy/MM/dd';
  calendar.select(oTarget, anchorName, dateFormat);
}
