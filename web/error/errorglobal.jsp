<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="devon.core.log.LLog" %>
<%@ include file="/include/doctype.jsp" %>
<%@ page errorPage = "jsp/error/errorpage.jsp" %>

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
 * 1.0  2015.10.08   hskim CSR:C20151005_87394 Error 공통 신규 추가
 * ------------------------------------------------------------------------ */
--%>

<%
response.setStatus(200);
String imagePath = "/error";
%>

<html>
<head>
<title>Page Not Found</title>
<script language="javascript">
function cbOnBeforeLoad() {}
</script>
</head>

<body>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="con_fr">
    <tr>
      <td class="con_w">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="error_bg">
          <tr>
            <td>
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr valign="top">
                  <td width="140" rowspan="6"><img src="<%=imagePath%>/error.gif" width="139" height="94"></td>
                  <td class="con_subtitle1">Sorry. Unexpected error occurred.</td>
                </tr>
                <tr valign="top">
                  <td>&nbsp;</td>
                </tr>
                <tr valign="top">
                  <td>&nbsp;</td>
                </tr>
                <tr valign="top">
                  <td class="con_subtitle2">Contact Information or Troubleshooting Tips</td>
                </tr>
                <tr valign="top">
                  <td class="instruction">
                    E-mail us at chumji10@lgcns.com<br>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr align="right">
            <td>
              <input type="button" class="button_default" onmouseover="btnOver(this)" onmouseout="btnOut(this)" name="Back" value="&lt;  Back" onclick="history.back()">
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</body>
</html>