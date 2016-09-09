
<%@ include file="/include/doctype.jsp"%>
<%--
/* ------------------------------------------------------------------------
 * @source  : error.jsp
 * @desc    : error jsp page (which defined from devon navigation xml)
 * ------------------------------------------------------------------------
 * LG CNS LTE(LAF/J Test Environment)
 * Copyright(c) 2006 LG CNS,  All rights reserved.
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2006.01.18   tkyushin           최초 작성
 * 1.1  2006.12.27   조남웅/이상원/황아영  LTE에 적용
 * 1.2  2014.04.14    한재우	  CSR:C20140414_23324
 * ------------------------------------------------------------------------ */
--%>
<%@ include file="/include/doctype.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ 
	page language="java" pageEncoding="EUC-KR"
	 isErrorPage="true"
	session="false" 
	import="devon.core.util.stopwatch.LHistorialWatch"
	import="devon.core.util.LHtmlUtils" 
	import="devon.core.log.LLog"
	import="devonframework.service.message.LMessageSource"
	import="devon.core.config.LConfiguration"
	import="devon.core.log.trace.LTraceID"
	import="devon.core.exception.LException"
	%>
<%
String contextPath = request.getContextPath();
String cssPath =     contextPath + "/css";
String imagePath =   contextPath + "/error";
Throwable throwable = (Throwable)request.getAttribute(comm.util.Constants.SERVLET_ERROR_EXCEPTION_KEY);
if (throwable == null) throwable = exception;
%>

<html>
<head>
<title>Uncatchable Error Page - DevOn</title>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR" />
<link href="<%= cssPath %>/epstyle.css" rel="stylesheet" type="text/css" />
<link href="<%= cssPath %>/behavior.css" rel="stylesheet" type="text/css"/>

<script language="javascript">
  function cbOnBeforeLoad() {}

  function flipInfoDiv() {
    var oDiv = document.getElementById("idDiv");
    oDiv.style.display = oDiv.style.display == "none" ? "block" : "none";
  }
</script>
<style type="text/css">
  pre.scrollable-codebox {
    background-color:#eaeaea;
    margin: 2px;
    padding: 4px;
    height:230px;
    overflow-y:scroll;
    white-space:normal;
    word-wrap:break-word;
    word-break:break-all;
  }
</style>
</head>

<body>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="con_fr">
    <tr>
      <td class="con_w">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td>&nbsp;
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr valign="top">
                  <td width="140" rowspan="6"><img src="<%=imagePath%>/error.gif" width="139" height="94"></td>
                  <td class="con_subtitle1">unexpected error occurred</td>
                </tr>
                <tr valign="top">
                  <td>&nbsp;</td>
                </tr>
                <tr valign="top">
                  <td>Sorry. Unexpected error occurred.</td>
                </tr>
                <tr valign="top">
                  <td>&nbsp;</td>
                </tr>
                <tr valign="top">
                  <td class="con_subtitle2">Contact Information or Troubleshooting Tips</td>
                </tr>
                <tr valign="top">
                  <td class="instruction">
                    E-mail us at dev.inf.contact.email<br>
                    Call us at dev.inf.contact.phone
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr align="right">
            <td>
              <input type="button" class="button_default" onmouseover="btnOver(this)" onmouseout="btnOut(this)" name="back" value="&lt;  Back" onclick="history.back()">
<%
if (throwable != null) {
%>
              <input type="button" class="button_default" onmouseover="btnOver(this)" onmouseout="btnOut(this)" name="debug" value="Debug" onclick="flipInfoDiv()">
              <input type="button" class="button_default" onmouseover="btnOver(this)" onmouseout="btnOut(this)" name="reload" value="Reload" onclick="location.reload()">
<%
}
%>
            </td>
          </tr>
        </table>
<%
if (throwable != null) {
    java.text.SimpleDateFormat df = new java.text.SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
    String host = request.getRemoteHost() + ":" + request.getServerPort();
    String client = request.getRemoteAddr();
    String date = df.format(new java.util.Date());
    String url = request.getRequestURI();
    Object status = "500 (unexpected error)";
    Object type = throwable.getClass().getName();
    String message = throwable.getMessage();
%>
        <br>
        <table id="idDiv" width="100%" border="0" cellspacing="1" cellpadding="0"  class="table_bg">
          <colgroup>
            <col width="100" />
            <col width="295" />
            <col width="100" />
            <col width="295" />
          </colgroup>
          <tr>
            <td class="table_header_right">Host</td>
            <td class="table_default"><%=host%></td>
            <td class="table_header_right">Client</td>
            <td class="table_default"><%=client%></td>
          </tr>
          <tr>
            <td class="table_header_right">Status Code</td>
            <td class="table_default"><%=status%></td>
            <td class="table_header_right">Date & Time</td>
            <td class="table_default"><%=date%></td>
          </tr>
          <tr>
            <td class="table_header_right">Access URL</td>
            <td class="table_default" colspan="3"><%=url%></td>
          </tr>
          <tr>
            <td class="table_header_right">Exception Type</td>
            <td class="table_default" colspan="3"><%=type%></td>
          </tr>
          <tr>
            <td class="table_header_right">LTrace Tx ID</td>
            <td class="table_default" colspan="3"><%=LTraceID.getTxID()%></td>
          </tr>
          <tr>
            <td class="table_header_right">Message</td>
            <td class="table_default" colspan="3"><%=message%></td>
          </tr>
          <tr>
            <td class="table_default" colspan="4">
              <pre class="scrollable-codebox">
<%
    throwable.printStackTrace(response.getWriter());
%>
              </pre>
            </td>
          </tr>
        </table>
<%
}
%>
      </td>
    </tr>
  </table>
</body>
</html>
