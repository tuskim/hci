<%--
 *************************************************************************
 * @source  : pop_VendorBankAccList.jsp
 * @desc    : 거래선 별 계좌 조회 팝업
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2015/11/25               Init
 * ---  -----------  ----------  -----------------------------------------
 * PT-PAM System.
 * Copyright(c) 2006-2007 LG CNS,  All rights reserved.
 *************************************************************************
--%>

<%@ page import="devon.core.util.*" %>
<jsp:useBean id="Util"  class="comm.util.Util"  scope="request" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>Vendor Bank Account List</title>
<%@ include file="/include/head.jsp" %>

<%
	String vendCd = Util.nullToString(request.getParameter("vendCd"));	
%>

<script type="text/javascript">

//-------------------------------------------------------------------------
// Load
//-------------------------------------------------------------------------
function f_Onload() {	
	
	f_Retrieve();
}

//-------------------------------------------------------------------------
// 검색
//-------------------------------------------------------------------------
function f_Retrieve() {

    var condition = "?";

    condition += "&vendCd=" + document.schForm.vendCd.value;

    ds_grid.DataID = "retrieveVendorBankAcctListPopup.gau"+condition;
    ds_grid.Reset();
}

//-------------------------------------------------------------------------
// 선택 & 창닫기
//-------------------------------------------------------------------------
function f_select(row,colid) {
        
    if(row>0){
        var partnerBankType = ds_grid.NameValue(row , "partnerBankType" );
        
        window.returnValue = partnerBankType;
        self.close(); 
    }
}

</script>

<!-----------------------------------------------------------------------------
    D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- ds_grid DataSet -->
<object id="ds_grid" classid="<%=LGauceId.DATASET%>">
    <param name="SyncLoad" value="true">
</object>

<!-----------------------------------------------------------------------------
    G A U C E   C O M P O N E N T' S   E V E N T S
------------------------------------------------------------------------------>

<script language=JavaScript for=ds_grid event=OnLoadStarted()>
    cfHideNoDataMsg(gr_grid);
    cfShowDSWaitMsg(gr_grid);
</script>

<!-- 그리드 더블클릭시 -->
<script language=JavaScript for=gr_grid event=OnDblClick(row,colid)>
    if(row > 0){
        // 선택 & 창닫기
        f_select(row, colid);
    }
</script>

<script language=JavaScript for=ds_grid event=OnLoadCompleted(rowCnt)>
    cfFillGridNoDataMsg(gr_grid,"gridColLineCnt=2");
    cfHideDSWaitMsg(gr_grid);
</script>

<script language=JavaScript for=gr_grid event=OnReturn(row,colid)>
    // 선택 & 창닫기
    f_select(row, colid);
</script>
</head>

<body style="background-color:#34a8db;padding-left:0px;" onload="f_Onload();"> 
    <div id="pop_ContentsBox">    
		<div id="TitleArea2"><h1> Vendor Bank Account List </h1></div>    
       			 
        <div id="ContentesArea">	
			
			<form name="schForm" method="post">
				<input type="hidden" id="vendCd" name="vendCd" value="<%= vendCd %>" />
			</form>

			<div id="n_board_area">
				<object id="gr_grid" classid="<%=LGauceId.GRID %>" class="comn" style="width:100%;height:200px;" validFeatures="ignoreStatus=no" validExp="">
			     	<param name="DataID"            value="ds_grid">
			      	<Param name="AutoResizing"      value=true>
			      	<param name="ColSizing"         value=true>
			      	<Param name="DragDropEnable"    value=True>
			      	<param name="AddSelectRows"     value=True>
			      	<Param name="SortView"          value="right">
			    	<param name="TitleHeight"       value="40">
			      	<param name="Editable"          value=false>
			      	<param name="Format" value='			      		
			            <C> id="acctNum"          name="Account no"    	      align="center"  Edit="none"  width="150"  show="true"   </C>			            
			            <C> id="partnerBankType"  name="Partner \\bank type"  align="center"  Edit="none"  width="80"   show="true"   </C>
			            <C> id="bankName"         name="Bank Name"            align="left"    Edit="none"  width="220"  show="true"   </C>
			            <C> id="acctOwner"        name="Account Owner"        align="left"    Edit="none"  width="170"  show="true"   </C> '>
				</object>
			</div>

		 	<!-- 버튼 S -->	
			<p class="rbtn">
				<span class="sbtn_r"><input type="button"  value="Close" onclick="javascript:window.close()" /></span>
			</p>					
		</div>					
	</div>              
</body>
</html>
