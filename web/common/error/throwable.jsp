<%@ page language ="java"  pageEncoding="EUC-KR" contentType="text/html; charset=EUC-KR" %>
<%@ include file="/common/include/doctype.jsp"%>
<%@ page errorPage="/common/error/errorpage.jsp"%>
<%--
/* ------------------------------------------------------------------------
 * @source  : throwable.jsp
 * @desc    : error jsp page
 * ------------------------------------------------------------------------
 * LG CNS LTE(DevOn/Framework Test Environment)
 * Copyright(c) 2006 LG CNS,  All rights reserved.
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2006.01.18   tkyushin           최초 작성
 * 1.1  2006.12.27   조남웅/이상원/황아영  LTE에 적용
 * ------------------------------------------------------------------------ */
--%>
<%
String errorCode = uip.common.util.Constants.MSG_ERROR_DEFAULT;
Throwable throwable = (Throwable)request.getAttribute("javax.servlet.error.exception");
%>

<html>
<head>
<title>Throwable Error Page - DevOn</title>
<%@ include file="/common/include/head.jsp"%>

<script type="text/javascript">
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
            <td>
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr valign="top">
                  <td width="140" rowspan="6"><img src="<%=imagePath%>/error.gif" width="139" height="94"></td>
                  <td class="subtitle_red"><LTag:message code="dev.err.com.title"> </LTag:message></td>
                </tr>
                <tr valign="top">
                  <td>&nbsp;</td>
                </tr>
                <tr valign="top">
                  <td><LTag:message code="<%=errorCode%>"> </LTag:message></td>
                </tr>
                <tr valign="top">
                  <td>&nbsp;</td>
                </tr>
                <tr valign="top">
                  <td class="instruction">Contact Information or Troubleshooting Tips</td>
                </tr>
                <tr valign="top">
                  <td>
                    E-mail us at <LTag:message code="dev.inf.contact.email"> </LTag:message><br>
                    Call us at <LTag:message code="dev.inf.contact.phone"> </LTag:message>
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
              <input type="button" class="button_default" onmouseover="btnOver(this)" onmouseout="btnOut(this)" name="Reload" value="Reload" onclick="location.reload()">
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
    String url = (String) request.getAttribute("javax.servlet.error.request_uri");
    Object status = request.getAttribute("javax.servlet.error.status_code");
    Object type = request.getAttribute("javax.servlet.error.exception_type");
    String message = (String) request.getAttribute("javax.servlet.error.message");
%>
        <br>
        <table width="100%" border="0" cellspacing="1" cellpadding="0" class="table_bg">
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
