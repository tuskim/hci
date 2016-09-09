<!DOCTYPE html >

<%--
/*
 *************************************************************************
 * @source  : index.jsp
 * @desc    : Login  
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------

 * ---  -----------  ----------  -----------------------------------------
 * PT-PAM 시스템
 * Copyright(c) 2006-2007 LG CNS,  All rights reserved.
 *************************************************************************
 */
--%>

<html>
<jsp:useBean class="devon.core.collection.LData" id="result" scope="request"/>


<%@ page import="devon.core.collection.LMultiData"%>
<%@ page import="devon.core.collection.LData"%>

<%@ include file="/include/head.jsp" %>
<head> 
	<meta http-ｅquiv="X-UA-Compatible" content="IE=Edge">
	<title>HCI System</title>
	<link href="/common/css/pwchange.css" rel = "stylesheet" type="text/css"/>
	<script type="text/javascript">
		
	<%
		String pwValidation ;
		if(loginUser.getString("pwValidation")== null){
			pwValidation = result.getString("pwValidation");
		}else {
			pwValidation = loginUser.getString("pwValidation");
		}
 	%>
	
	function passwordChange() {	
		var validation = true;
		var pwChange = document.pwChange;	
		if (validation && pwChange.newPassword.value.length <= 0) {
			alert("Please type in your New Password!");
			validation = false;
			pwChange.newPassword.focus();
		}

		if (validation && pwChange.newPasswordConfirm.value.length <= 0) {
			alert("Please insert your password confirm!");
			validation = false;
			pwChange.newPasswordConfirm.focus();
		}
		
		if (validation) {
			pwChange.submit();
		}
	}
	
	function init(){
		var pwValidation = "<%=pwValidation%>";
		if(pwValidation == "01"){
			alert("Please input the new Passowrd");
		}
		if(pwValidation == "02"){
			alert("Check the password rule");
		}
		if(pwValidation == "03"){
			alert("Check the password confirm");
		}if(pwValidation =="99"){
			alert("Password is successfully changed");
			alert("Close the Pop-Up window");
			window.opener.location.href = "/index.jsp";
			window.close();
		}	
	}
	</script>

</head>

<body id="cent_bg" onLoad = "init();" style="">
		
	<div class="loginform"><!-- https://ptmpp.lgi.co.kr/cm.ur.passwordChange.dev -->
		<form action="cm.ur.passwordChange.dev" name="pwChange" id="pwChange" method="post">
			<ul>
				 <li>
				 	<img src="sys/images/hci_logo_150.gif" style="margin-bottom: 20px"/>
				 <li/>
				 <li>
					<label for="New Password" >New Password</label>
                    <input type="password" title="New Password" id="newPassword" name="newPassword" value=""  OnKeyDown="keyLogin(event)" />
                 </li>
                 <li>
                 	<label for="Password Confirm" >New Password Confirm</label>
                    <input type="password" title="Confirm your Password" id="newPasswordConfirm" name="newPasswordConfirm" value=""   OnKeyDown="keyLogin(event)" required />
                 </li>
                 
                 <li>
					<input type="button" value="Password Submit"  onclick="javascript:passwordChange();" >
				</li>
			</ul>
				<input type="hidden" name="lang"   id="lang" value="en">				 
		</form>
	</div>
		<div class= "notice"><h2 style="color: red !important">Your current password is expired.</h2>  <h1> Please change your password</h1> 
		</div>
		
		<ol style="">
			<li>1. New password have to same or longer than 8 characters.</li>
			<li>2. Consist of character(s), number(s) and special character(s).<br/>&nbsp&nbsp  ex) <font color = "green" >smith@12 (O), jhonson14! (O)</font></li>
			<li>3. More than three same or serial numbers and characters are not allowed.<br/>&nbsp&nbsp   ex)<font color = "red" > 234(X), 111(X), abc(X), aaa(X)</font></li>
			<li>4. Upper and lower cases are classified.</li>
		</ol>
		
</body>

</html>