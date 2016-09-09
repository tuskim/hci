<%--
/* ------------------------------------------------------------------------
 * @source  : head.jsp
 * @desc    : Included JSP Page
 * ------------------------------------------------------------------------
 * LG CNS LTE(LAF/J Test Environment)
 * Copyright(c) 2006 LG CNS,  All rights reserved.
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2006.01.18   tkyushin           ���� �ۼ�
 * 1.1  2006.12.27   v����/�̻��/Ȳ�ƿ�  LTE�� ���
 * ------------------------------------------------------------------------ */
--%>
<%@ page session="false" %>
<%@ page 
  import="devon.core.util.stopwatch.LHistorialWatch"
  import="devon.core.util.LHtmlUtils"
  import="devon.core.log.LLog"
  import="devonframework.service.message.LMessageSource"
  import="devon.core.config.LConfiguration"
  import="devon.core.log.trace.LTraceID"
  import="devon.core.exception.LException"
%>

<%@ taglib prefix="c_rt" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="LTag" uri="/devon" %>
<%@ taglib prefix="sf" uri="/sf" %>

<%
  String contextPath = request.getContextPath();
  //System.out.println("**[" +contextPath +"]");
  if ("/".equals(contextPath)) contextPath = "";
  String imagePath =   contextPath + "/images";
  String cssPath =     contextPath + "/common/css";
  String jsPath =      contextPath + "/common/js";
  String menuPath =    contextPath + "/common/menu";
  String includePath = contextPath + "/common/include";
  String xjosPath =    contextPath + "/common/xjos";
  
  String locale = "ko";
  LConfiguration conf = LConfiguration.getInstance();
  request.setAttribute((String)conf.get("/devon/framework/message/locale-bind-key"), locale);

  LHistorialWatch historialWatch = (LHistorialWatch) request.getAttribute(uip.common.util.Constants.SERVLET_STOPWATCH_KEY);
  if (historialWatch == null) historialWatch = new LHistorialWatch();
  historialWatch.tick("Processing Jsp Begin");
  
  //session 
  HttpSession session = request.getSession(false);
  if (session != null) {
	  LData loginUser = (LData)session.getAttribute("loginUser");
  }
%>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR"/>
<link href="<%= cssPath %>/epstyle.css"    rel="stylesheet" type="text/css"/>
<link href="<%= cssPath %>/behavior.css" rel="stylesheet" type="text/css"/>
<link href="<%= xjosPath %>/xjos.css"    rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%= jsPath %>/epjs.js"></script>
