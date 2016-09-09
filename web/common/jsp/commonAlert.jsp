<%@page session="false" contentType="text/html;charset=EUC-KR" %>
<HTML>
<HEAD>
<TITLE>결과</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset="EUC-KR">
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Cache-Control" content="no-cache">
</HEAD>

<BODY bgcolor="#FFFFFF" aLink=#000000 link=#000000 text=#000000 topMargin=0 vLink=#000000>

<script>
<%  
if(request.getAttribute("alert") != null) {%>
  alert("<%=request.getAttribute("alert")%>");
<%}%>
<%  
if(request.getAttribute("reload") != null) {%>
    <%=request.getAttribute("reload")%>;
<%} else {%>
	location.replace("<%=request.getAttribute("href")%>");
<%}%>
</script>

</html>