<%@ page language ="java"  pageEncoding="EUC-KR" contentType="text/html; charset=EUC-KR" %>
<%@ include file="/common/include/doctype.jsp" %>
<%@ page errorPage = "/common/error/errorpage.jsp" %>
<%--
/* ------------------------------------------------------------------------
 * @source  : 404.jsp
 * @desc    : HTTP Status 404 - Page Not Found Error
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
response.setStatus(200);
%>

<html>
<head>
<title>Page Not Found</title>
<%@ include file="/common/include/head.jsp" %>
<script type="text/javascript">
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
                  <td class="con_subtitle1">Page Not Found</td>
                </tr>
                <tr valign="top">
                  <td>&nbsp;</td>
                </tr>
                <tr valign="top">
                  <td>
                    <p>
                      Sorry! We couldn't find your document.
                      <br><br>
                      The file that you requested could not be found on this server. If you provided the URL, please check to ensure that it is correct or try a search above.
                      <br><br>
                      If you are certain that this URL is valid, please send us feedback about the broken link.
                      <br><br>
                      Thank you.
                    </p>
                  </td>
                </tr>
                <tr valign="top">
                  <td>&nbsp;</td>
                </tr>
                <tr valign="top"> 
                  <td class="con_subtitle2">Contact Information or Troubleshooting Tips</td>
                </tr>
                <tr valign="top">
                  <td class="instruction">
                    E-mail us at <LTag:message code="dev.inf.contact.email"> </LTag:message><br>
                    Call us at <LTag:message code="dev.inf.contact.phone"> </LTag:message>
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