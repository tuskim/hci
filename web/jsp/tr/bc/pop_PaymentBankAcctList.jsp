<%--
 *************************************************************************
 * @source  : pop_PaymentBankAcctList.jsp
 * @desc    : 출금 계좌 조회 팝업
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2015/11/26               Init
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
<title>Payment Bank Account List</title>
<%@ include file="/include/head.jsp" %>



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
   
    ds_grid.DataID = "retrievePaymentBankAcctListPopup.gau";
    ds_grid.Reset();
}

//-------------------------------------------------------------------------
// 선택 & 창닫기
//-------------------------------------------------------------------------
function f_select(row,colid) {
        
    if(row>0){
        var bankId      = ds_grid.NameValue(row , "bankId" );
        var bankAccount = ds_grid.NameValue(row , "bankAccount" );
        var country     = ds_grid.NameValue(row , "country" );
        
        window.returnValue = bankId + ";" 
                           + bankAccount + ";"
                           + country + ";"
                           ;                
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
		<div id="TitleArea2"><h1> Payment Bank Account List </h1></div>    
       			 
        <div id="ContentesArea">	
			
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
			      		<C> id="seq"          name="seq"           align="center"  Edit="none"  width="35"   </C>
			        	<C> id="bankId"       name="House Bank"    align="center"  Edit="none"  width="75"   </C>
			            <C> id="country"      name="Currency"      align="center"  Edit="none"  width="60"   </C>
			            <C> id="bankAccount"  name="Bank Account"  align="left"    Edit="none"  width="120"  </C>
			            <C> id="bankDesc"     name="Bank Desc"     align="left"    Edit="none"  width="330"  </C>  '>
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
