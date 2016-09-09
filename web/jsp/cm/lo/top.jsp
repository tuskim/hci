<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--
/*
 *************************************************************************
 * @source  : top.jsp
 * @desc    : 메인 메뉴
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
<%@ page import = "devon.core.collection.LData" %>
<%@ include file="/include/head.jsp" %>

<html>
<head> 
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />  
<title>PT-MPP System</title> 
<script type="text/JavaScript">
<!--
//-------------------------------------------------------------------------
// login out
//-------------------------------------------------------------------------
function logout(){
  window.location.href="logout.jsp";			
}	
//-------------------------------------------------------------------------
// Master AddRow
//-------------------------------------------------------------------------
function pwdChange(){
	window.open("commRetrieveLoginUser.dev", "User_Information","width=500,height=180");
}
//-------------------------------------------------------------------------
// Show Left Menu
//-------------------------------------------------------------------------	
function showMenu(_menuCd,_menuNm) { 
	var form = document.searchCondition;
	var menuOk = false; 
	form.h_menuCd.value = _menuCd;
	form.h_menuNm.value = _menuNm;
	form.submit();
}
function fn_menu() {
	//parent.leftFrame.display = "";
}
	   
//-->
</script>

</head>

<body id="all_bg">
<form name="searchCondition" mehtod="post" action="commRetrieveLeftMenuCmd.dev" target="leftFrame">
<div id="topbox">
  	<div id="logo"><a href="/index.jsp" target="_top"> <img src="<%= images %>hci_logo_150.gif"/></a></div>
    <div id="topmenu_5"> 
    	<ul>
   <%		
  			LMultiData LmainList = new LMultiData();
   			LmainList = (LMultiData) session.getAttribute("menuList");
            LMultiData Lmain = new LMultiData();
            for (int i = 0; i < LmainList.getDataCount(); i++) {
           
            	if (LmainList.getString("depth", i).equals("1")) { 

            		Lmain.add("progCd", LmainList.getString("progCd", i));
            		Lmain.add("progNm", LmainList.getString("progNm", i));         
            	}
            }
            for(int t = 0; t<Lmain.getDataCount(); t++) {
            	if(Lmain.getDataCount()==(t+1))	{
   %>
           			<li class="b_none">
   <%
            	}else{
   %>
           			<li> 
   <%
            	}
   %>
            	<a href="javascript:showMenu('<%=Lmain.getString("progCd", t) %>','<%=Lmain.getString("progNm", t) %>');" onclick="fn_menu();"><%=Lmain.getString("progNm", t) %></a></li>
   <%	            	
            }
   %>        
        </ul>
	</div>
</div>  

<input type="hidden" name="cmd" value="left" />
<input type="hidden" name="h_menuCd" value="" />
<input type="hidden" name="h_menuNm" value="" />	
</form>
</body>
</html>
	