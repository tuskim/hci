<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--
/*
*************************************************************************
* @source  : openPurchOrder.jsp
* @desc    : Open P/O List
*------------------------------------------------------------------------
* VER  DATE         AUTHOR      DESCRIPTION
* ---  -----------  ----------  -----------------------------------------
* 1.0  2016.08.02    cspark       init
* ---  -----------  ----------  -----------------------------------------
* HCI System
* Copyright(c) 2006-2007 LG CNS,  All rights reserved.
*************************************************************************
*/
--%> 




<%@ page import="devon.core.util.*" %> 
<jsp:useBean id="stringUtil" class="comm.util.StringUtil"             scope="request" />
<jsp:useBean id="lgiHubUtil" class="comm.util.Util"                   scope="request" />
<jsp:useBean id="noticeList" class="devon.core.collection.LMultiData" scope="request"/>
<jsp:useBean id="qnaList"    class="devon.core.collection.LMultiData" scope="request"/>





<html xmlns="http://www.w3.org/1999/xhtml">
<head>   
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<meta content="blendTrans(Duration=0.0)" http-equiv="Page-Enter" />
<meta content="blendTrans(Duration=0.0)" http-equiv="Page-Exit" />





<title>HCI System</title>
<%@ include file="/include/head.jsp" %>



<%
String prevDate	   = LDateUtils.getDate("yyyy/MM/") +"01"; 
String currentDate = LDateUtils.getDate("yyyy/MM/dd");          // currentDate
%> 



<script type="text/javascript">
parent.centerFrame.cols='220,*';
var g_msg = "";

/***************************************************************************************************/
/*초기 세팅
/***************************************************************************************************/
function init() {
	f_retrieve();
}




/***************************************************************************************************/
/*조회
/***************************************************************************************************/

// Master 조회
function f_retrieve() { 
	///////////////////////////////////////////////////////////////////////
	// 검색조건
	var v_url = new cfURI();
	v_url.Add("fromDate",encodeURIComponent(fromDate.value));
	v_url.Add("toDate"  ,encodeURIComponent(toDate.value));
	v_url.Add("vendCd",document.all.sVendCd.value);
	///////////////////////////////////////////////////////////////////////

	v_url.SetPage("po.po.retrieveOpenPurchOrderMasterList.gau");
	ds_master.DataId = v_url.GetURI();
	ds_master.Reset(); 
}


/***************************************************************************************************/
/* 엑셀
/***************************************************************************************************/
function f_excel() {
	gf_excel2(ds_master, gr_master, "<%=currentDate%>", "Open P/O List", "c:\\");
}




//-------------------------------------------------------------------------
//Vendor 조회 팝업
//-------------------------------------------------------------------------		
function f_openVendorPop() {	
	
	openVendorSapListWin('P');		
}
</script>














 
 
<!-----------------------------------------------------------------------------
D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- Grid 용 DataSet-->
<object id="ds_master" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true">
	<param name="ViewDeletedRow"    value="false">
</object>



  
  
<!-----------------------------------------------------------------------------
Dataset   E V E N T S
------------------------------------------------------------------------------>
<!-- Dataset Master-------------------------------------------------------------------------------------->
<script language=JavaScript for=ds_master event=OnLoadStarted()>
  cfShowDSWaitMsg(gr_master);//progress bar 보이기
  cfHideNoDataMsg(gr_master);//no data 메시지 숨기기
</script>

<!-- Hub In Header 조회 DataSet -->
<script language=JavaScript for=ds_master event=OnLoadCompleted(rowCnt)>
  cfHideDSWaitMsg(gr_master);//progress bar 숨기기
  cfFillGridNoDataMsg(gr_master,"gridColLineCnt=2");//no data found   
  
  ////////////////////////////////////////////////////////////////
  // 그리드 total 표시
  gr_master.ColumnProp("prodDate", "SumText") = "Total";
  gr_master.ColumnProp("rawmixQty", "SumText") = "@sum";
  ////////////////////////////////////////////////////////////////
</script> 










<!-----------------------------------------------------------------------------
Grid   E V E N T S
------------------------------------------------------------------------------>
<!-- Grid Master-------------------------------------------------------------------------------------->
<script language=JavaScript for=gr_master event=OnKeyUp(row,colid,keycode)>
</script> 


 
</head>

















<body id="cent_bg" onload="init();">
<div id="conts_box">
	<h2> <span> Open P/O List </span></h2>
	<!--검색 S -->	
	<fieldset class="boardSearch"> 
		<div>
			<dl>
				<dt> 
					<table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board2" >
						<colgroup>
							<col width="21%"/>
							<col width="37%"/>
							<col width="17%"/>
							<col width="14%"/>
							<col width="10%"/>
							<col width=""/>
						</colgroup>
						<tr>
							<th>P/O Date</th>
							<td>
								<input type="text" onblur="valiDate(this);" style="width:70px;" id="fromDate" value="<%= prevDate %>" />
								<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="" onclick="javascript:OpenCalendar(fromDate);" class="button_cal"/>
								~
								<input type="text" onblur="valiDate(this);" style="width:70px;" id="toDate" value="<%= currentDate %>" />
								<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="" onclick="javascript:OpenCalendar(toDate);" class="button_cal"/>
							</td> 
							<th>Vendor</th>									
							<td>
								<input type="hidden" id="sVendCd" name="sVendCd"/>
								<input type="text" id="sVendNm" name="sVendNm" style="width:120px;" readOnly/>&nbsp;
					  			<img src="<%= images %>button/search_icon_2.gif"  onClick="javascript:f_openVendorPop();" style="cursor:hand"/>
					    </td>
						</tr>
					</table>
				</dt>              		  	   	 	
				<dd class="btnseat1"> 
					<span class="search_btn_r search_btn_l">
						<input type="button" onfocus="blur();" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='#e2ebf7'" value="<%=btnSearch %>" onclick="f_retrieve();"/>
					</span> 
				</dd>						
			</dl>
		</div>
	</fieldset>
	<!--검색 E -->
	
	
	
			

	<div class="sub_stitle"> 
		<p>P/O List</p>
		<p class="rightbtn">
			<span class="excel_btn_r excel_btn_l">
				<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="<%=btnExcelDown %>" onclick="f_excel()"/>
			</span>   
		</p>			
	</div>    
		<!-- 그리드 Master S -->
		<div>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<comment id="__NSID__">
						<object id="gr_master" classid="<%=LGauceId.GRID %>" style="width:100%;height:450px;" class="comn">
							<param name="DataID"            value="ds_master"/> 
							<param name="Editable"          value="true"/>
							<Param name="AutoResizing"      value=true>
							<param name="UrlImages"         value="<I>Type='PopupBotton', Url='/sys/images/button/search_icon_2.gif', Fit='AutoFit', Flat='True'</I>">
        					<param name="ViewSummary"         value="1"/>
							<param name="Format"            
							value="
							    <FC> id='poNo'    		name='P/O No.'			align='center' 	width='95' Edit='none' show='true'	Suppress='1'</FC>
							    <C>  id='sapPoNo'     	name='SAP P/O No.'     	align='center' 	width='95' Edit='none' show='true'	Suppress='1'</C>
							    <C>  id='vendNm'     	name='Vender'     		align='left'  	width='150' Edit='none' show='true'	Suppress='1'</C>
							    <C>  id='poDate'     	name='P/O Date'     	align='center' 	width='95' Edit='none' show='true'  Suppress='1' DisplayFormat ='XXXX/XX/XX'</C>
							    <C>  id='deliDate'     	name='Delivery Date'    align='center' 	width='95' Edit='none' show='true'  Suppress='1' DisplayFormat ='XXXX/XX/XX'</C>
							    <C>  id='materCd'     	name='Material Code'    align='center' 	width='95' Edit='none' show='true'</C>
							    <C>  id='materNm'     	name='Material Name'    align='left'  	width='150' Edit='none' show='true'	SumText='Total'</C>
							    <C>  id='unit'     		name='Unit'     		align='center' 	width='40' Edit='none' show='true'</C>
							    <C>  id='qty'     		name='P/O Qty.'     	align='right'  	width='95' Edit='none' show='true'  DisplayFormat ='#,###.000'	SumText='@sum'</C>
							    <C>  id='receiptQty'    name='Delivered Qty.'   align='right'  	width='95' Edit='none' show='true'  DisplayFormat ='#,###.000'	SumText='@sum'</C>
							    <C>  id='balanceQty'    name='Balance Qty.'     align='right'  	width='95' Edit='none' show='true'  DisplayFormat ='#,###.000'	SumText='@sum'</C>
	                        "/>
						</object>
						</comment><script>__WS__(__NSID__);</script>
					</td>
				</tr>
			</table>
		</div>
		<!-- 그리드 Master E -->

		
</div>

</body>
</html>
