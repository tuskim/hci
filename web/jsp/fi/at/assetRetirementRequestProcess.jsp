<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--
/*
 *************************************************************************
 * @source  : assetRetirementRequestProcess.jsp
 * @desc    : 자산 폐기 요청 정보 등록 결과 메시지 처리 및 호출 페이지 처리
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2016.01.04   hckim       신규작성
 * ---  -----------  ----------  -----------------------------------------
 * PT-GAM 시스템
 * Copyright(c) 2006-2007 LG CNS,  All rights reserved.
 *************************************************************************
 */
--%> 
<%@ page import="devonframework.bridge.gauce.LGauceId" %>
<jsp:useBean id="inputData" class="devon.core.collection.LData" scope="request"/>
<jsp:useBean id="resultMsg" class="devon.core.collection.LData" scope="request"/>
<% 
	// 결과 메시지
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

// 자산 폐기 요청 등록 결과 메시지 처리 및 호출 페이지 처리
function result(){
	
	var form = document.fform;	
	var resultMsg ="<%=msg%>";
											
	var condition = "?";
		condition += "progCd=FI0019";
   		condition += "&yearMonth=" + form.yearMonth.value;
   		condition += "&costCenterIdx=" + form.costCenterIdx.value;
   		condition += "&assetClassIdx=" + form.assetClassIdx.value;
   		condition += "&assetNo=" + form.assetNo.value;
   		condition += "&assetNm=" + form.assetNm.value;
   		condition += "&saveYn=Y";
   		condition += "&resultMsg=" + resultMsg;
			
	form.action = "assetListScn.dev" + condition;						
	form.submit();		
}

</script>

</head>

<body onload="result();">
<form name="fform" method="post">
	<input type="hidden" name="companyCd" value="<%=g_companyCd%>"/>
	
	<!-- 부모창 검색조건 -->
	<input type="hidden" name="yearMonth" id="yearMonth" value="<%=inputData.getString("sYearMonth")%>"/>
	<input type="hidden" name="costCenterIdx" id="costCenterIdx" value="<%=inputData.getString("sCostCenterIdx")%>"/>
	<input type="hidden" name="assetClassIdx" id="assetClassIdx" value="<%=inputData.getString("sAssetClassIdx")%>"/>
	<input type="hidden" name="assetNo" id="assetNo" value="<%=inputData.getString("sAssetNo")%>"/>
	<input type="hidden" name="assetNm" id="assetNm" value="<%=inputData.getString("sAssetNm")%>"/>
	
</form>
</body>
</html>


