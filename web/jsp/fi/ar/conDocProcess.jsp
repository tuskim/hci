<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--
/*
 *************************************************************************
 * @source  : ConDocProcess.jsp
 * @desc    : 공지사항 등록
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
<%@ page import="devonframework.bridge.gauce.LGauceId" %>
<jsp:useBean id="inputData" class="devon.core.collection.LData" scope="request"/>
<jsp:useBean id="resultMsg" class="devon.core.collection.LData" scope="request"/>
<% 
	String msg  = resultMsg.getString("msg")== null ? "" : resultMsg.getString("msg");
	String g_docNo  = inputData.getString("docNo")== null ? "" : inputData.getString("docNo");
%>
<%@ include file="/include/head.jsp" %>

<html>
<head> 
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="blendTrans(Duration=0.0)" http-equiv="Page-Enter" />
<meta content="blendTrans(Duration=0.0)" http-equiv="Page-Exit" />   
<title>ConDoc Update</title>
<script language="javascript">
parent.centerFrame.cols='220,*';
	function result()
	{
		var status ="<%=msg%>";
		
		if(status == "Success")
		{			
			alert("<%=source.getMessage("dev.suc.com.process")%>");
			
			document.fform.action="conDocList.dev?progCd=FI0007&docNo=";
			document.fform.submit();
		}
		else if(status == "FileSizeOver")
		{
			alert("<%=source.getMessage("dev.warn.com.filesize")%>");		 
			history.back();	
		}
		else
		{
			alert("<%=source.getMessage("dev.err.com.save")%>");
			document.fform.action="./conDocList.dev?progCd=FI0007&docNo=&subject=&writerNm=";
			document.fform.submit();		
		}
	}

</script>



</head>

<body onload="result();">
<form name="fform" method="post">
	<input type="hidden" name="companyCd" value="<%=g_companyCd%>"/>
	<input type="hidden" name="docNo" value="<%=g_docNo%>"/>
</form>
</body>
</html>


