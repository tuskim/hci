<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="devon.core.log.LLog" %> 

<%--
/* ------------------------------------------------------------------------
 * @source  : 404.jsp
 * @desc    : HTTP Status 404 - Page Not Found Error
 * ------------------------------------------------------------------------
 * LG CNS LTE(LAF/J Test Environment)
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
String imagePath = "/error";
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Cost Total Ledger Excel Upload</title>
<%@ include file="/include/head.jsp" %>

<script language="javascript">
function cbOnBeforeLoad() {}
</script>
</head>

<body id="cent_bg">
<div id="conts_box">
  <table width="100%" border="0" cellspacing="0" cellpadding="0"  >
    <tr>
      <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0"  >
          <tr>
            <td>
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr valign="top">
                  <td width="140" rowspan="6"><img src="<%=imagePath%>/error.gif" width="139" height="94"></td>
                  <td>Page Not Found</td>
                </tr>
                <tr valign="top">
                  <td>&nbsp;</td>
                </tr>
                <tr valign="top">
                  <td>
                    <p>
                      Sorry! We couldn't find your document.
                      <br><br>
                      The file that you requested could not be found on this server. If you provided the URL, 
                      <br><br>
                      please check to ensure that it is correct or try a search above.
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
                  <td >Contact Information or Troubleshooting Tips</td>
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
 
        </table>
      </td>
    </tr>
  </table>
  </div>
</body>
</html>