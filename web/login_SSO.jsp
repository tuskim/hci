<%@ page contentType="text/html; charset=UTF-8" %>

<%
String pernr = (String)session.getAttribute("RtSSO RtSabun");

if (pernr != null && pernr.length() > 5) {

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>LG INT'L Logistics System</title>

<script type="text/javascript">

function loginSSO() {

	loginForm.pernr.value = "<%=pernr%>";
	loginForm.submit();
}

</script>

</head>
<body onload="loginSSO();">
<form name="loginForm" action= "comm10LoginSSOUser.dev" method="post">
	<input type=hidden name="pernr"/>
</form>
<%
} else {
%>
<jsp:forward page="/index.jsp"/>
<%
}
%>
</body>
</html>
