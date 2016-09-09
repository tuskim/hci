<%--
 *************************************************************************
 * @source  : pop_OriginalSalesNo.jsp
 * @desc    : Original Sales List
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2012/10/04    이태경          	Init
 * ---  -----------  ----------  -----------------------------------------
 * PT-PAM System.
 * Copyright(c) 2006-2007 LG CNS,  All rights reserved.
 *************************************************************************
--%>

<%@ page import="devon.core.util.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Material Code List</title>
<%@ include file="/include/head.jsp"%>
<%
	String prevDate	   = LDateUtils.getDate("yyyy/MM/") +"01"; 		//조회시작 default 날짜
	String currentDate = LDateUtils.getDate("yyyy/MM/dd");          //조회조건 현재 날짜
	String msgNotUse = source.getMessage("dev.warn.com.noUse"); // Not Use !
%>

<script type="text/javascript">
//-------------------------------------------------------------------------
// Load
//-------------------------------------------------------------------------
function f_Onload() { 
//	ds_status.DataID ="cm.cm.retrieveCommCodeCombo.gau?groupCd=2319&firstVal=Select!";
//	ds_status.Reset();	  
	ds_currCd.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2004";
	ds_currCd.Reset();		
	ds_currCd.RowPosition = ds_currCd.NameValueRow("code","IDR");
	ds_payTerm.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2206";
	ds_payTerm.Reset();
	ds_vatCd.DataId="sd.sm.retrieveSalesMgmtVatACombo.gau?groupCd=2007";
	ds_vatCd.Reset();	 	
	//costomer
	ds_vendor.DataID ="cm.cm.retrieveCommComboVendorList.gau"; 
	ds_vendor.Reset();
} 
//-------------------------------------------------------------------------
// 검색
//-------------------------------------------------------------------------
//Search 버튼 클릭
function f_Retrieve(){
	ds_grid.ClearAll();
	ds_grid.DataID  = "/cm.cd.retrievePopUpOriginalSalesList.gau?";
    ds_grid.DataID += "vendorCd=" 		   + ds_vendor.NameValue(ds_vendor.RowPosition,"code");
    ds_grid.DataID += "&salesDateFrom="   + encodeURIComponent(salesDateFrom.value);
    ds_grid.DataID += "&salesDateTo=" + encodeURIComponent(salesDateTo.value);
	ds_grid.DataID += "&status=6" ;
 	ds_grid.DataID += "&lang="			   +"<%=g_lang%>";	
	ds_grid.Reset();
	
}

//-------------------------------------------------------------------------
// 선택 & 창닫기
//-------------------------------------------------------------------------
function f_select(row,colid) {

    var useyn    = ds_grid.NameValue(row , "status" );
    if ( useyn != "6" ) {
		alert("<%= msgNotUse %>");
    	return;
    }

    if(row>0){
        var originalSalesNo = ds_grid.NameValue(row , "salesNo" );
        var customer = ds_grid.NameValue(row , "customer" );
        var customerCd = ds_grid.NameValue(row , "customerCd" );
        var salesDate = ds_grid.NameValue(row , "salesDate" );
        var grandTotalQty = ds_grid.NameValue(row , "grandTotalQty" );
        var currencyCd = ds_grid.NameValue(row , "currencyCd" );
        var grandTotalAmt = ds_grid.NameValue(row , "grandTotalAmt" );
        var payTerm = ds_grid.NameValue(row , "payTerm" );
        var blIfDocSeq = ds_grid.NameValue(row , "blIfDocSeq" );
        var vatCd = ds_grid.NameValue(row , "vatCd" );
 
        window.returnValue = originalSalesNo + ";" 
                           + customer + ";" 
                           + customerCd + ";" 
                           + salesDate + ";" 
                           + grandTotalQty + ";" 
                           + currencyCd + ";" 
                           + grandTotalAmt + ";" 
                           + payTerm + ";" 
                           + blIfDocSeq + ";" 
                           + vatCd + ";" 
                           ;
        self.close(); 
    }
}

function f_close(){
	if(ds_grid.RowPosition>0){
        f_select(ds_grid.RowPosition,'');
    }else{
    	self.close();
    }
}
</script>

<!-----------------------------------------------------------------------------
  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- CUD TR -->

<!-----------------------------------------------------------------------------
    D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- ds_grid DataSet -->
<object id="ds_grid" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad" value="true">
</object>

<object id="ds_status"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"          value="true">
</object></comment>

 <!-- lx Combo 용 DataSet-->
<object id="ds_currCd" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true"> 
</object> 

<object id="ds_vatCd" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true">
</object>

<!-- lx Combo 용 DataSet-->
<object id="ds_payTerm" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true"> 
</object>

<!-- costomer Combo 용 DataSet-->
<object id="ds_vendor" classid="<%=LGauceId.DATASET%>" >
  	<param name="SyncLoad"          value="true">
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
    if(row>0){
        // 선택 & 창닫기
        f_select(row,colid);
    }
</script>

<script language=JavaScript for=ds_grid event=OnLoadCompleted(rowCnt)>

    cfFillGridNoDataMsg(gr_grid,"gridColLineCnt=2");
    cfHideDSWaitMsg(gr_grid);

</script>

<script language=JavaScript for=gr_grid event=OnReturn(row,colid)>
    // 선택 & 창닫기
    f_select(row,colid);
</script>
</HEAD>

<body style="background-color:#34a8db;" onload="f_Onload()">


<div id="pop_ContentsBox">
<div id="TitleArea2">
<h1>Original Sales List</h1>
</div>


<div id="ContentesArea">

	<!--검색 S -->	 
	 <fieldset class="boardSearch"> 
		<div>
			 <dl>
				<dt  class="w400"> 
					<table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board2" />
						<colgroup> 
						<col width="23%"/>
						<col width=""/>
						</colgroup>
						<tr>
							<th>Customer</th>
							<td><object id="lc_vendor"  classid="<%=LGauceId.LUXECOMBO%>" width="230">
								<param name="ComboDataID"       value="ds_vendor">
								<param name="ListCount"     	value="10">
								<param name=SearchColumn		value="name">
								<param name="BindColumn"    	value="code">
								<param name=ListExprFormat		value="name^0^210,code^0^70">
								<param name=index           	value=0>
								</object>
							</td>	
						</tr>
						<tr>
							<th>Sales Date</th>
							<td><input type="text" id="salesDateFrom" name="salesDateFrom" value="<%= prevDate %>"  onblur="valiDate(this);"  style="width:60px;"/>&nbsp;
								<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(salesDateFrom);" style="cursor:hand"/> 
								~&nbsp;<input type="text" id="salesDateTo" name="salesDateTo"  value="<%= currentDate %>" onblur="valiDate(this);"   style="width:60px;"/>&nbsp;
								<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(salesDateTo);" style="cursor:hand"/> 
							</td>
						</tr>
					</table>
				</dt>              		  	   	 	
				<dd class="btnseat2">
					<span class="search_btn2_r">
					<input type="button" onfocus="blur();" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='#e2ebf7'" value="Search" onclick="f_Retrieve();" />
					</span>
				</dd>											
			</dl>
		</div>
	</fieldset>
    <!--검색 E --><!--조회영역 끝 -->

<div class="pad_t5"></div>
<div id="n_board_area">
	<object id="gr_grid" classid="<%=LGauceId.GRID %>" class="comn" style="width:100%;height:210px;" validFeatures="ignoreStatus=no" validExp="">
	<param name="DataID" value="ds_grid">
	<Param name="AutoResizing" value=true>
	<param name="ColSizing" value=true>
	<Param name="DragDropEnable" value=True>
	<param name="AddSelectRows" value=True>
	<Param name="SortView" value="right">
	<param name="TitleHeight" value="30">
	<param name="Editable" value=false>
	<param name="Format" value="
			            	<C>id='salesNo' 		name='Sales No' 		 width='100' align='center'   Edit='none' </c>			            	
			            	<C>id='customer' 	name='Customer' 	 width='150' align='center' Edit='none' </c>
			            	<C>id='customerCd' 	name='Customer CD' 	width='70' align='center' Edit='none'  show='false'</c>
			            	<C>id='salesDate' name='Sales Date'  	width='70'  align='center' Edit='none'</c>
			            	<C>id='grandTotalQty'  	name='Grand Total Qty'  width='95'  align='right'  Edit='none'  show='false'</c>
							<C>id='currencyCd'  name='Currency CD' width='40' align='right' Edit='none' Data='ds_currCd:code:name'  show='false'</C>							
			            	<C>id='grandTotalAmt'  	name='Grand Total Amount'  width='130'  align='right'  Edit='none'</c>
							<C>id='payTerm'  name='Terms Of Payment' width='40' align='right' Edit='none' Data='ds_payTerm:code:name'  show='false'</C>
							<C>id='vatCd'  name='Vat Code' width='40' align='center'  Edit='none' Data='ds_vatCd:code:name'  show='false'</C>
							<C>id='statusNm'   	name='status'    		 	width='100' align='center' Edit='none'  show='false'</c>
			            	<C>id='status'   	name='Status'  width='100' align='center' Edit='none' show='false'</c>
			            	<C>id='blIfDocSeq'  	name='Billing NO'  width='100' align='center' Edit='none'  show='false'</c>
			        ">
	</object>
</div>
<!-- 버튼 S -->
<p class="rbtn"><span class="sbtn_r"><input type="button"	value="Close" onclick="javascript:f_close()" /></span></p>
</div>

<!-- 팝업내용 E -->
</div>
</body>
</html>