<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--
/*
 *************************************************************************
 * @source  : index.jsp
 * @desc    : Login  
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2010.07.21 노태훈       신규작성
 * 1.1  2014.04.14    한재우	  CSR:C20140414_23324
 * ---  -----------  ----------  -----------------------------------------
 * PT-PAM 시스템
 * Copyright(c) 2006-2007 LG CNS,  All rights reserved.
 *************************************************************************
 */
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<jsp:useBean id="loginUser"  class="devon.core.collection.LData" scope="session" />
<jsp:useBean id="validation" class="devon.core.collection.LData" scope="request" />

	<%
	
		if (loginUser == null || loginUser.isEmpty()) {
			String loginValue = validation.getString("validation")== null ? "" : validation.getString("validation");
			String userid = request.getParameter("userid");
			
	%> 

<html>
<head> 
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<link href="xjos/xjos.css" rel="stylesheet" type="text/css" /> 
<link rel="stylesheet" type="text/css" href="sys/css/common.css" />
<link rel="stylesheet" type="text/css" href="sys/css/login.css" />
<script type="text/javascript" src="/sys/js/comm/comm.js"></script>
<script type="text/javascript" src="sys/js/comm_ptpam.js"></script>
<title>PT-MPP System</title>

	<script type="text/javascript">
	
	var loginValue 	= "<%=loginValue%>";
	var userid 		= "<%=userid%>";
	var msg;
	     	
	//LoginCheck
	if (loginValue != "") {
		
	    if (loginValue == "0001") {
	        msg = "Account is incorrect. Please try it again";
	        
	    } else if(loginValue == "0002") {
	    	
	        msg = "Account is incorrect. Please try it again";
	        
	    } else if (loginValue == "0003" ) {
	    	msg = "Your account is blocked. Please ask to manager.";
	    	
	    }else if (loginValue == "0004"){
	    	msg = "You did not login more than 2 months, \nSo, your account is blocked. \nPlease make a request to the system manager.";
	    }
	    	if (msg != "" && msg != null) alert(msg);
	}
	//=======
	
	function loginAction() {	
		var validation = true;
		var login = document.login;	
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
	}
	
	function chkLang()
	{
		for (var i = 0; i < ra_lang.length; i++) {
			
			if (ra_lang[i].checked) {
				login.lang.value= ra_lang[i].value;
				 
			}		
		}	
	}
	
	

	</script>

</head>

<body  style="background-color:#c5d2e0; margin-top:150px;">

<div id="login_box">
	<h1> <img src="sys/images/button/pt_mpp.png" alt="pt_mpp logo" /></h1>
			<form action="unblocking.dev" name="login" method="post">
                <fieldset>
                		<label for = "unblockId" class = "eng">Unblock ID</label>
                		<input type = "text" title = "ID Unblock" id= "unblockId" name = "unblockId" value="" style="width:130px;"  required/>
                		<br/>
                        <label for="id" class="eng">ID</label>
                        <input type="text" title="Input ID" id="userid" name="userid" value="" maxlength="30" tabindex="1" style="width:130px;" OnKeyDown="keyLogin(event)" required/>
                        <br/>
                        <label for="name" class="eng">Password</label>
                        <input type="password" title="Input Password" id="password" name="password" value="" maxlength="30" tabindex="2" style="width:130px;" OnKeyDown="keyLogin(event)" required />
                       
					    <div class="loginbtnarea"> 
							<p> <span class="loginbtn">
                  				  <input type="button" onfocus="blur();" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='#8a96ac'" value="UnBlock" onclick="javascript:loginAction()" /></span> 	<p>
						</div>
                       
					    <div class="btn">
							<p>							
								 </p>  
						</div>
                 </fieldset>
                 		<input type="hidden" name="lang" id="lang" value="en"/>      
						<input type="hidden" name="companyCd" id="companyCd" value="MB00"/>    
		    										
        	 </form>

	</div>
	
<div id="login_footer">Copyright(c)2013.LGI CORP . All Rights Reserved.</div>
	

</body>


<%
} else {
%>
<jsp:forward page="/jsp/Frameset.jsp"/>
<%
}
%>

<script src="/xjos/xjos.js" language="JScript"/></script>
</html>

</head> 