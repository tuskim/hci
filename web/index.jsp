<%--
/*
 *************************************************************************
 * @source  : index.jsp
 * @desc    : Login  
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2012.08.09 이상호       신규작성
 * 1.1  2014.04.14    한재우	  CSR:C20140414_23324
 * ---  -----------  ----------  -----------------------------------------
 * PT-MDL 시스템
 * Copyright(c) 2006-2007 LG CNS,  All rights reserved.
 *************************************************************************
 */PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
--%>

<!DOCTYPE html >
<jsp:useBean id="loginUser" class="devon.core.collection.LData" scope="session" />
<jsp:useBean id="validation" class="devon.core.collection.LData" scope="request" />
<jsp:useBean id="pwValidation" class="devon.core.collection.LData" scope="request" />

<%
		String pwValidCode = loginUser.getString("pwValidCode"); 
	if (loginUser == null || loginUser.isEmpty() || pwValidCode.equals("false") ) {

	String loginValue = validation.getString("validation")== null ? "" : validation.getString("validation");
	String userid = request.getParameter("userid");
%>  

<html>
<head> 
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<link href="xjos/xjos.css" rel="stylesheet" type="text/css" /> 
<link rel="stylesheet" type="text/css" href="/sys/css/common01.css" />
<link rel="stylesheet" type="text/css" href="/sys/css/login.css" />
<link rel="stylesheet" type="text/css" href="/sys/css/table01.css" />
<script type="text/javascript" src="/sys/js/comm/comm.js"></script>
<script type="text/javascript" src="/sys/js/comm_ptmdl.js"></script>
<title>HCI System</title>

<script type="text/javascript">

	var loginValue 	= "<%=loginValue%>";
	var userid 		= "<%=userid%>";

	var pwValidCode = "<%=pwValidCode%>";
	var msg;
   	popupUrl    =  "pwchange.jsp";
	popupOption =  "width=550, height=600 , resizable=no, dependent, scrollbars=no, status=no , dependent = yes, screenX=0, screenY=0 , alwayseRaised = yess;";

//LoginCheck
	if (loginValue != "") {
		
	    if (loginValue == "0001") {
	        msg = "Account incorrect. Please try it again";
	        
	    } else if(loginValue == "0002") {
	        msg = "Account incorrect. Please try it again\n ";
	        
	    } else if (loginValue == "0003" ) {
	    	msg = "Your account is blocked. Please ask to system manager.";
	    	
	    }else if (loginValue == "0004"){
	    	msg = "You did not login more than 3 months, \nSo, your account is blocked. \nPlease make a request to the system manager.";
	    }else if(loginValue =="0005"){
	    	msg = "Password have not been changed for more than 90 days.\nPlease change your password";
	    }
	    	if (msg != "" && msg != null)
	    	{alert(msg);}
	}

	function loginAction() {	
		var validation = true;
		var login = document.login;
		
		if (validation && login.companyCd.value == "") {
			alert("Please Select your COMPANY!");
			validation = false;
			login.userid.focus();
		}	
		if (validation && login.userid.value.length <= 0) {
			alert("Please insert your ID!");
			validation = false;
			login.userid.focus();
		}	
		if (validation && login.password.value.length <= 0) {
			alert("Please insert your password!");
			validation = false;
			login.password.focus();
		}
		if (validation) {
			login.submit();
		}
	}

	function keyLogin(evt){
	    if ( evt.keyCode == 13 || evt == '^') {
	        loginAction();	
	    }
	}

	function init(){
		if (loginValue == "") {
			document.login.userid.focus();
		
		} 
	
		if(pwValidCode =="false"){
			alert( "Please change your password" );
			var win = window.open(popupUrl , "PasswordChange", popupOption );
	
			if(win){
				win.focus();
			}
		}
	}

function chkLang()
{
	var ra_lang = document.login;	
	
	for (var i = 0; i < ra_lang.length; i++) {
		
		if (ra_lang[i].checked) {
			login.lang.value= ra_lang[i].value;
			 
		}		
	}	
}

function findUserId(){
	 cfWinOpen("jsp/cm/lo/searchId.jsp","User_Information",400,230) ;
}

function findUserPw(){ 
	 cfWinOpen("jsp/cm/lo/searchPw.jsp","User_Information",400,230) ;	
}

</script>
</head>

<body onload="init();">

<form action="commLoginUserCmd.dev" name="login" method="post">
<input type="hidden" name="lang" id="lang" value="en"/>      
<input type="hidden" name="companyCd" id="companyCd" value="GA00"/>  

<div id="intro">
	<div class="logo">
		<a href="#"><img src="sys/images/hci_logo_200.gif" width="200" height="52" /></a>
	</div>
	<div class="login_t">
   		<div class="top_bg"></div>
		<div class="login_box">
    		<div class="id_box">
    			<span  class="pad_03"></span>
			    <br />			
    			<span class="pad_01">ID</span><input type="text" id="userid" name="userid" value="" maxlength="30" tabindex="1" OnKeyDown="keyLogin(event)"/><br />
        		<span class="pad_02">Password</span><input type="password" id="password" name="password" value="" maxlength="30" tabindex="2"  OnKeyDown="keyLogin(event)"/><br />
            	<div class="pass_box">
          			<div class="pass_bg"><a href="#"  onclick="javascript:findUserId();">ID search</a></div>
          			<div class="pass_bg"><a href="#" onclick="javascript:findUserPw();">PW search</a></div>
           		</div>
        	</div>
        	<div class="id_btn"><a href="#"><img src="sys/images/login_btn.jpg" width="101" height="49" alt="로그인버튼" onclick="javascript:loginAction();" /></a></div> 
    	</div>
	</div>
</div>
<div class="copy">COPYRIGHT©2016 BY LG International Corp.</div> 
</form>
</body>
<%
}  else if(loginUser.getString("pwValidCode").equals("true")) {
%>

<jsp:forward page="/jsp/Frameset.jsp"/>
<%
}
%>
<script src="/xjos/xjos.js" language="JScript"/></script>
</html>
 
 