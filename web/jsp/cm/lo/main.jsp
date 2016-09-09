<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--
/*
 *************************************************************************
 * @source  : main.jsp
 * @desc    : Main Page
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2010.07.21    노태훈       init
 * 1.1  2014.04.14    한재우	   CSR:C20140414_23324
 * ---  -----------  ----------  -----------------------------------------
 * PT-MPP System
 * Copyright(c) 2006-2007 LG CNS,  All rights reserved.
 *************************************************************************
 */
--%> 
<%@ page import="devon.core.util.*" %>
<%@ page import="comm.util.DateUtil" %>

<%String currentDate  = LDateUtils.getDate("yyyy.MM.dd");          // currentDate%>
<jsp:useBean id="stringUtil" class="comm.util.StringUtil"             scope="request" />
<jsp:useBean id="lgiHubUtil" class="comm.util.Util"                   scope="request" />
<jsp:useBean id="noticeList" class="devon.core.collection.LMultiData" scope="request"/>
<jsp:useBean id="qnaList"    class="devon.core.collection.LMultiData" scope="request"/>
<jsp:useBean id="passwordBetween"    class="devon.core.collection.LData"      scope="request"/>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>   
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 

<title>PT-PAM System</title>
<%@ include file="/include/head.jsp" %>

<script language="javascript">

//-------------------------------------------------------------------------
// notice Image Control
//-------------------------------------------------------------------------
function init(){  

	if(<%=passwordBetween.getInt("passwordBetween")%> >= 90 )
	{
		alert(" ** Your password have not been changed for 90 days.\n Please change your password.");
		changeUser();
		
	}
}
//-------------------------------------------------------------------------
// notice Detail 바로가기
//-------------------------------------------------------------------------
function fncBbsDetail(p_seq,p_company,p_user) {
	var form = document.frm;
	var menuOk = false;
	form.h_menuCd.value = "CM0000"; 
	form.h_gubun.value = "DETAIL";		
	form.h_seq.value = p_seq;
	form.h_company.value = p_company;
	form.h_useId.value = p_user;			
	form.h_menuNm.value = "Master";				
    form.action = "commRetrieveLeftMenuCmd.dev";
	form.submit();	    
}
//-------------------------------------------------------------------------
// notice List 바로가기
//-------------------------------------------------------------------------
function fncBbsList() {
	var form = document.frm;
	var menuOk = false;
	form.h_menuCd.value = "CM0000";  	
	form.h_gubun.value = "LIST";
	form.h_menuNm.value = "Master";						
    form.action = "commRetrieveLeftMenuCmd.dev";
	form.submit();
}
//-------------------------------------------------------------------------
// Log out
//-------------------------------------------------------------------------
function logOut(){
	parent.document.location.href="/commLogoutUserCmd.dev";
	parent.document.location.target="_top";
}
   
//-------------------------------------------------------------------------
// User Info Change 바로가기
//-------------------------------------------------------------------------
function changeUser(){
	var form = document.frm;
	var menuOk = false;
	form.h_menuCd.value = "CM0000";	
	form.h_gubun.value = "USERCHANGE";	
	form.h_menuNm.value = "Master";		 
    form.action = "commRetrieveLeftMenuCmd.dev?progCd=CM0002";
	form.submit();      
}
</script>
</head>
 
<body id="all_bg" onload="init();">
<form name="frm" method="post" target="leftFrame">
	<input type="hidden" name="h_seq" value=""/>
	<input type="hidden" name="h_menuCd" value="" />
	<input type="hidden" name="h_menuNm" value="" />
	<input type="hidden" name="h_gubun" value="" />
	<input type="hidden" name="h_company" value="" />
	<input type="hidden" name="h_useId" value="" />	
	
</form>
<div id="mainbox" style="background-color:#fff;">
	<div id="log_box">
    	<p> <%=currentDate%></p>
	    <p><img src="<%= images %>button/bullet01.gif" />
	    	<span class="blue b"> <%=g_userNm%>
	    	</span>  
	    </p> 
	    <p> 
			<span class="sbtn_r2">
			<input type="button" onfocus="blur();" onmouseover="this.style.color='#c52553'" onmouseout="this.style.color='#f0f0f0'" value="<%=btnLogOut%>" onclick="logOut()"/></span>  			
			<span class="sbtn_r2">
			<input type="button" onfocus="blur();" onmouseover="this.style.color='#c52553'" onmouseout="this.style.color='#f0f0f0'" value="<%=btnLogInfo%>" onclick="changeUser()"/></span>  			
		</p>
    </div>    
  	<div id="notice">
        <h2>Notice</h2>  
    <!---  Notice Start ---->  
        <ul>
               	<% 
	               	int subjectLength = 65;
	       	        String subject = "";  
               		if(noticeList.getDataCount() == 0) {     			
               	%>
            <li><span><a href="#">No Notice. </a></span></li>
            	
               	<%}else{ 
               		
               		for(int idx=0; idx < noticeList.getDataCount(); idx++){
						//제목 자르기
                        subject = stringUtil.cropByte(lgiHubUtil.nullToString(noticeList.getString("subject",idx)), subjectLength, "...");
 
               	%>               	            
            <li><a href="javascript:fncBbsDetail('<%=noticeList.getString("seq",idx)%>','<%=noticeList.getString("companyCd",idx)%>','<%=noticeList.getString("regid",idx)%>');"> <%=subject%> </a> 
                <span> <%=noticeList.getString("regdate",idx)%> </span>
            </li>

           		<%
           				}
               		}
           		%>              
           		</ul>
    <!---  Notice End ------> 
        <p class="more"><a href="javascript:fncBbsList();"> <%=btnMore %> </a></p>
  	</div>
</div> 
</body>
 </html>
 