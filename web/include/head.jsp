<%@ page language ="java"  pageEncoding="UTF-8"%>
<%--
/*
 *************************************************************************
 * @source  : head.jsp
 * @desc    : Included JSP Page
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2010.07.21 노태훈       신규작성
 * ---  -----------  ----------  -----------------------------------------
 * PT-PAM 시스템
 * Copyright(c) 2006-2007 LG CNS,  All rights reserved.
 *************************************************************************
 */
--%>
<%@ page import="devonframework.bridge.gauce.LGauceId" %>
<%@ page import = "devon.core.collection.LData" %>
<%@ page import = "devon.core.collection.LMultiData" %>
<%@ page import = "devonframework.service.message.LMessageSource" %>
<%@ page import = "java.util.Locale" %>
<%@ page import = "devon.core.log.trace.LTraceID" %>
<%@ page import = "devon.core.util.stopwatch.LHistorialWatch" %>
<%@ page import = "devon.core.log.LLog" %>
<jsp:useBean id="loginUser" class="devon.core.collection.LData" scope="session" />
<jsp:useBean id="menuList" class="devon.core.collection.LMultiData" scope="session" />
<jsp:useBean id="columnData" class="devon.core.collection.LData" scope="request"/>


<%
LData sessionUserInfo = new LData();
LData sessionMenuInfo = new LData();
String g_companyCd  = "";
String g_userId     = "";
String g_userNm     = "";
String g_authCd     = "";
String g_email      = ""; 

String strCdForwardF = "";
String strCdHub      = "";
String strCdVendor   = "";
String g_lang        = "";
String g_deptCd      = ""; 
if (loginUser == null || loginUser.isEmpty()) {
%>
<script type="text/javascript">
			alert(" Session is Terminated. You need to relogin! ");
			window.parent.location.href = "/index.jsp";
</script>

<%} else {

	sessionUserInfo = (LData) session.getAttribute("loginUser");
	g_companyCd    	= sessionUserInfo.getString("companyCd");
    g_userId 		= sessionUserInfo.getString("userId");
    g_userNm   		= sessionUserInfo.getString("userNm");
    g_authCd   		= sessionUserInfo.getString("authCd");
    g_email 		= sessionUserInfo.getString("email"); 
    g_lang 			= sessionUserInfo.getString("lang");
    g_deptCd 		= sessionUserInfo.getString("deptCd");    
    g_authCd 		= sessionUserInfo.getString("authCd");   
    
  } 

LMessageSource source = new LMessageSource(new Locale(g_lang), "utf-8");
String btnSave 			= source.getMessage("normal.save");  
String btnSearch 		= source.getMessage("normal.search"); 
String btnNew 			= source.getMessage("normal.new");  
String btnDel 			= source.getMessage("normal.del");  
String btnList 			= source.getMessage("normal.list");  
String btnApproval 		= source.getMessage("normal.approval");  
String btnSapSend 	    = source.getMessage("normal.sap_send");  
String btnSamlpDown 	= source.getMessage("normal.samlp_down"); 
String btnExcelDown 	= source.getMessage("normal.excel_down");  
String btnIdCheck 		= source.getMessage("normal.id_check");  
String btnModify 		= source.getMessage("normal.modify");  
String btnReturn 		= source.getMessage("normal.return"); 			//반려 button
String btnPurchReq 		= source.getMessage("normal.purch_req"); 		//구매요청 button
String btnPoCreate 		= source.getMessage("normal.po_create");  
String btnReceipt 		= source.getMessage("normal.receipt"); 			//입고 button
String btnCancel 		= source.getMessage("normal.cancel"); 
String btnSalesConfirm 	= source.getMessage("normal.sales_confirm"); 	//매출확정 
String btnAddRow 		= source.getMessage("normal.add_row");  //행 추가
String btnDelRow    	= source.getMessage("normal.del_row"); 	//행삭제 
String btnLogOut 		= source.getMessage("normal.log_out");   
String btnLogInfo       = source.getMessage("normal.log_info"); 	
String btnWrite         = source.getMessage("normal.write"); 
String btnCancelReq     = source.getMessage("normal.cancel_req"); 
String btnMore          = source.getMessage("normal.more"); 
String btnSapCancel	    = source.getMessage("normal.sap_cancel");  
String btnOrder	        = source.getMessage("normal.order");
String btnPrint	        = source.getMessage("normal.print");
String btnCopy	        = source.getMessage("normal.copy");
String btnPoSend        = source.getMessage("normal.po_send");
String btnConfirm       = source.getMessage("normal.confirm");
String btnReject        = source.getMessage("normal.reject"); 
String btnPriceSearch   = source.getMessage("normal.price_search"); 
String btnBargeSearch   = source.getMessage("normal.barge_search"); 
String btnValidation    = source.getMessage("normal.validation");
String btnTransfer      = source.getMessage("normal.transfer");
String btnSinglePrint   = source.getMessage("normal.single_print");
String btnListPrint     = source.getMessage("normal.list_print"); 
String btnRefresh       = source.getMessage("normal.refresh"); 

String ptpam_home = "";
String images 	= ptpam_home + "/sys/images/";
String css 		= ptpam_home + "/sys/css/";
String js 		= ptpam_home + "/sys/js/";
String xjos		= ptpam_home + "/xjos/";

String menucd = request.getParameter("pcode");

if(menucd == null) menucd = "";


%>

<link rel="stylesheet" type="text/css" href="<%= css %>common.css" />
<link rel="stylesheet" type="text/css" href="<%= css %>sub_style.css" />
<link rel="stylesheet" type="text/css" href="<%= css %>button2.css" />
<link rel="stylesheet" type="text/css" href="<%= css %>dui_slidemenu.css.css" />

<script type="text/javascript" src="<%= js %>comm/gauceObject.js"></script>
<script type="text/javascript" src="<%= js %>comm/Calendar.js"></script>
<script type="text/javascript" src="<%= js %>comm/lafui.js"></script>
<script type="text/javascript" src="<%= js %>comm/comm.js"></script>
<script type="text/javascript" src="<%= js %>comm/Progress.js"></script> 
<script type="text/javascript" src="<%= js %>comm/dui_prototype.js"></script> 
<script type="text/javascript" src="<%= js %>comm/dui_slidemenu.js.js"></script> 
<script type="text/javascript" src="<%= js %>comm_ptpam.js"></script>
<script type="text/javascript" src="<%= js %>common.js"></script> 
<script type="text/javascript">
//-------------------------------------------------------------------------
//esc와 back-space 클릭 방지
//-------------------------------------------------------------------------
 
document.onkeydown=checkKey;

function checkKey(){
 //alert("You pressed a following key: "+window.event.keyCode);
 // ESC Key 누를 때 데이터 사라지는 것 방지
 if(window.event.keyCode == 27){
  window.event.returnValue = false;
  return;
 }

 // back-space 누를 때 
 if(window.event.keyCode == 8){

  // TextEdit가 아니면 작동하지 않도록
  if(!window.event.srcElement.isTextEdit){
   window.event.returnValue = false;
   return;
  }else if(window.event.srcElement.readOnly || window.event.srcElement.disabled){
   // readOnly나 disabled인 경우 작동하지 않도록
   window.event.returnValue = false;
   return;
  }
 }
 
 event.returnValue = true;
}
</script>