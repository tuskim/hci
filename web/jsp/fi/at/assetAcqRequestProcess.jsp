<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--
/*
 *************************************************************************
 * @source  : assetAcqRequestProcess.jsp
 * @desc    : 자산취득 요청 등록 결과 메시지 처리 및 호출 페이지 처리
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2015.12.23   hckim       신규작성
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
	String msg  = resultMsg.getString("msg") == null ? "" : resultMsg.getString("msg");
%>

<%@ include file="/include/head.jsp" %>

<html>
<head> 
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />  
<meta content="blendTrans(Duration=0.0)" http-equiv="Page-Enter" />
<meta content="blendTrans(Duration=0.0)" http-equiv="Page-Exit" />
<title>Asset Request Process</title>

<script language="javascript">

parent.centerFrame.cols='220,*';

// 자산취득 요청 등록 결과 메시지 처리 및 호출 페이지 처리
function result(){
	
	var form = document.fform;
	
	var status ="<%=msg%>";
	
	// 등록 성공
	if(status == "Ok"){			
		
		alert("<%=source.getMessage("dev.suc.com.save")%>");			
				
		form.action = "assetAcqRequestScn.dev?progCd=FI0017";				
		
		form.submit();
	
	// 파일 사이즈 체크	결과
	}else if(status == "FileSizeOver"){
		alert("<%=source.getMessage("dev.warn.com.filesize")%>");		 
		history.back();	
	
	// 등록 실패	
	}else{
		alert("<%=msg%>");		 
		history.back();		
	}
}

</script>

</head>

<body onload="result();">
<form name="fform" method="post">
	<input type="hidden" name="companyCd" value="<%=g_companyCd%>"/>
</form>
</body>
</html>


