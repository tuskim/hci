<%@ page import="devon.core.config.*" %>
 

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko">
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<TITLE>DevOn Resource Refresh</TITLE>
<META http-equiv="Cache-Control" content="no-cache; no-store; no-save">
<style type="text/css">
a:link   { text-decoration:none; }
a:visited{ text-decoration:none; }
p,br,body,table,td,form, { font-family:굴림; font-size:9pt; };
.subj    { color:#0033CC;  font-weight:bold; };
.subsubj { color:#0099FF;  font-weight:bold; };
.alert   { color:deeppink; font-weight:bold; };
</style>
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red" style="font-family:굴림,arial; font-size:10pt;">
<div align=center>
<table width=550 border=0 cellspacing=0 cellpadding=1 bgcolor=#6666FF>
  <tr>
    <td>
      <table width=550 border=0 cellspacing=0 cellpadding=5 bgcolor=white>
        <tr>
          <td>
            <table width="100%" border="1" cellspacing="3" cellpadding="3">
              <tr>
                <td bgcolor="#0000FF">
                  <div align="center"><font color="#FFFFFF"><b>DevOn Resource(Configuration,Message)</b></font></div>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<BR>
<%
		try {
			LConfiguration conf = LConfiguration.getInstance();
			conf.refresh();
%>
DevOn의 Xml Configuration이 refresh 되었습니다.<br><br>
<%
		} catch (Exception e){
%>
DevOn의 Xml Configuration이 refresh 되지 않았습니다.<br><br>
<%		    out.println(e.toString());
		}
%>
</div>
</html>