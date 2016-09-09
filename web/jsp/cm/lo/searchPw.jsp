<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--
/*
 *************************************************************************
 * @source  : serchPw.jsp
 * @desc    : pw찾기
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2010.07.21 노태훈       신규작성
 * ---  -----------  ----------  -----------------------------------------
 * PT-PAM 시스템
 * Copyright(c) 2006-2007 LG CNS,  All rights reserved.
 *************************************************************************
 */
--%> 
<%@ page import = "java.util.*" %>
<%@ page import = "java.lang.*" %>
<%@ page import="devon.core.util.*" %>
<%@ page import = "devonframework.service.message.LMessageSource" %>
<%@ page import="devonframework.bridge.gauce.LGauceId" %>
<html>
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />  
<title> </title>
<link rel="stylesheet" type="text/css" href="/sys/css/common.css" />
<link rel="stylesheet" type="text/css" href="/sys/css/sub_style.css"/> 
<link rel="stylesheet" type="text/css" href="/sys/css/button2.css" />
<script type="text/javascript" src="/sys/js/comm_ptpam.js"></script>
<script type="text/javascript">
function searchPw()
{
	var companyCd = window.opener.document.login.companyCd.value;
	var form 	= document.bForm;
	var	gubun	= "";
	
	var val = document.aForm.validate();
	if (val) {	
		ds_findPw.DataID  = "/cm.lo.login.commRetrieveUserPw.gau?";
		ds_findPw.DataID += "companyCd=" + "O100"; 
	    ds_findPw.DataID += "&userId=" + aForm.userId.value; 
	    ds_findPw.DataID += "&residentNum=" + aForm.residentNum.value; 
		ds_findPw.Reset();	 
		
		if(ds_findPw.CountRow==0){
			alert("The Value is not exist.");
		}else{
			aForm.userPw.value = ds_findPw.NameValue(1,"userPw");
		}
	}
}
</script>

<%----------------------------------------------------------------------------------------------------
 Gauce obj  정의
------------------------------------------------------------------------------------------------------%>

<object id="ds_findPw" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/>
  <param name="ViewDeletedRow"    value="true"/>
</object>

<%----------------------------------------------------------------------------------------------------
 Gauce obj  event  정의
------------------------------------------------------------------------------------------------------%>
 
</head>

<body style="background-color:#34a8db;">
<form name="aForm">
	<div id="pop_ContentsBox"> 
		<div id="TitleArea2"><h1> Password Search </h1> </div>    
		<div id="ContentesArea">			    
			<!-- 팝업내용 S -->	
          	<div class="logBox"> 
	            <fieldset>
	            	<label for="number">Significant No.</label>
	                	<input type="text" id="residentNum" style="width:150px;" tabindex="1"   value="" maxlength="12" class=required" required/>
	              		<br/>
	                <label for="name"> ID</label>
	                    <input type="text" id="userId" style="width:150px;" tabindex="2"   value="" maxlength="12" class=required" required/>
	              		<br/>
	                <label for="id">PW</label>
	              	<input type="text" id="userPw" style="width:150px;" tabindex="3" class="txtField_read"   value="" maxlength="30" readonly/>
	            </fieldset>    										                 
			</div>
         	<!-- 팝업내용 E -->	
		</div>
 
		<!-- 버튼 S -->	
  		<div id="popbtn_area">
			 <p class="p_b_r"> 
			 <span class="sbtn_r">
			 	<input type="button" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'"  value="Search" onclick="searchPw();" /></span>
		     <span class="sbtn_r">
		     	<input type="button" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'"  value="Close" onclick="javascript:window.close()" /></span>
		     </p>
		</div>
		<!-- 버튼 E -->			 
	</div>
</form>
<script src="/xjos/xjos.js" language="JScript"/></script>
</body>
</html>
