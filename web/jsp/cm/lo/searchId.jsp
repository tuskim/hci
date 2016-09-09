<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--
/*
 *************************************************************************
 * @source  : serchid.jsp
 * @desc    : ID찾기
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
function init(){

}

function searchId()
{
	var companyCd = window.opener.document.login.companyCd.value;
	var form 	= document.bForm;
	var	gubun	= "";
	
	var val = document.aForm.validate();
	if (val) {	
		ds_findId.DataID  = "/cm.lo.login.commRetrieveUserId.gau?";
		ds_findId.DataID += "companyCd=" + "GA00"; 
	    ds_findId.DataID += "&userNm=" + aForm.userNm.value; 
	    ds_findId.DataID += "&residentNum=" + aForm.residentNum.value; 
		ds_findId.Reset();	 
		
		if(ds_findId.CountRow==0){
			alert("The Value is not exist.");
		}else{
			aForm.userId.value = ds_findId.NameValue(1,"userId");
		}		
	}
}
</script>

<%----------------------------------------------------------------------------------------------------
 Gauce obj  정의
------------------------------------------------------------------------------------------------------%>

<object id="ds_findId" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/>
  <param name="ViewDeletedRow"    value="true"/>
</object>

<%----------------------------------------------------------------------------------------------------
 Gauce obj  event  정의
------------------------------------------------------------------------------------------------------%>
 
</head>

<body style="background-color:#34a8db;">
<form name="aForm">
	<div id="pop_ContentsBox" >  
		<div id="TitleArea2"><h1> ID Search </h1> </div>    
		<div id="ContentesArea">			    
		<!-- 팝업내용 S -->	
			<div class="logBox">
		    	<fieldset>
		        	<label for="number">Significant No.</label>
		                <input type="text" title="식별번호입력" id="residentNum"  maxlength="12" tabindex="1" style="width:150px;"  required/>
		                <br/>
	                <label for="name"> Name</label>
		                <input type="text" title="이름입력" id="userNm"  maxlength="12" tabindex="2" style="width:150px;" required/>
		                <br/>
	                <label for="id">ID</label>
		                <input type="text" title="아이디입력" id="userId" name="userId" class="txtField_read" maxlength="30" tabindex="3" style="width:150px;" readonly/> 
				</fieldset>    											        
			 </div>	 	
		</div> 
		<!-- 버튼 S -->	
  		<div id="popbtn_area">
  			<p class="p_b_r"> 
			 <span class="sbtn_r">
			 	<input type="button" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'"  value="Search" onclick="searchId();" /></span>
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
