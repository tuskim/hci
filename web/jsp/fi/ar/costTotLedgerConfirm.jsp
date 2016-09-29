<%--
/*
 *************************************************************************
 * @source  : costTotLedgerConfirm.jsp
 * @desc    : cost Total Ledger Excel Upload
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2010/09/13   mskim       Init
 * ---  -----------  ----------  -----------------------------------------
 * PT-PAM System.
 * Copyright(c) 2006-2007 LG CNS,  All rights reserved.
 *************************************************************************
 */
--%>

<%@ page import="devon.core.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Cost Total Ledger Excel Upload</title>
<%@ include file="/include/head.jsp" %>

<%
	String prevDate	   = LDateUtils.getDate("yyyy/MM/") +"01"; 
	String currentDate = LDateUtils.getDate("yyyy/MM/dd");          // currentDate

    String msgWarnRetrieve    = source.getMessage("dev.warn.com.retrieve");   // please first retrieve!
    String msgApproval        = source.getMessage("dev.cfm.com.approval");    // Are you sure to Approval?
    String msgCancel          = source.getMessage("dev.cfm.com.cancel");    // Are you sure to Cancel?
	String msgSave            = source.getMessage("dev.cfm.com.save");    // Are you sure to save?
	String msgDelete          = source.getMessage("dev.cfm.com.delete");    // Are you sure to Delete?
    String msgNoDataItem      = source.getMessage("dev.warn.com.noDataItem");    // The selected item does not exist.
    String msgNoDetailSave    = source.getMessage("dev.warn.com.noDetailSave");    // Detail Data Must be Saved.
    String msgCompDebitCredit = source.getMessage("dev.msg.fi.diffDebitCredit");    // The debit and credit total are not right
    String msgChkHeaderChk    = source.getMessage("dev.warn.com.chkHeaderCount");    // Check one Item.
    String msgMustReqMode     = source.getMessage("dev.msg.fi.condCheck");    		// The selected condition must be Request Status.
    String msgSapSend        = source.getMessage("dev.cfm.com.send");    // Are you sure to Approval?
%>

<script type="text/javascript">

//저장 시 Rowposion
var g_Pos =0;

//-------------------------------------------------------------------------
// Approval
//-------------------------------------------------------------------------	
function f_Approval(){

	//2014 데이터 이전 입력 불가 처리(결산기간)  
	if(saveCudData_check() == false){
		return;
	}

	if (checkSaveData('APPR')) {
		
		//Dataset 저장		
		saveCudData();
		
		//ds_cudDtlData.UseChangeInfo = "false";

		if (confirm('<%=msgApproval%>')) {
			g_Pos = ds_costTotMst.RowPosition;	 
			mode = "process";
			tr_cudData.Action   = "fi.ar.cudApprCostTotLedgerConfirm.gau";
			tr_cudData.KeyValue	= "JSP(I:IN_DS1=ds_cudMstData)";
	 		tr_cudData.Post();//Cost Total Ledger Approval
	 	}
 	}

}


//-------------------------------------------------------------------------
// Cost Total Ledger Approval Cancel
//-------------------------------------------------------------------------	
function f_Cancel(){
	
	
	for(var i=1; i <= ds_costTotMst.countRow; i++){
		if(ds_costTotMst.NameValue(i,"chk") == "T"){
			if(ds_costTotMst.NameValue(i,"sapDocSeq") !=""){
				alert('<%=source.getMessage("dev.fi.ar.costpricemgt.reject.chk")%>');
				return;
			}
		}
	}
	
	if (checkSaveData('APPR_CANCEL')) {

		//Dataset 저장		
		saveCudData();

		if (confirm('<%=msgCancel%>')) {
			g_Pos = ds_costTotMst.RowPosition;	 
			mode = "process";
			tr_cudData.Action   = "fi.ar.cudApprCostTotLedgerCancelConfirm.gau";
			tr_cudData.KeyValue	= "JSP(I:IN_DS1=ds_cudMstData)";
	 		tr_cudData.Post();//Cost Total Ledger Approval
	 	}
 	}

}

//-------------------------------------------------------------------------
// SAP Send
//-------------------------------------------------------------------------	
function f_SapSend(){

	//2014 이전 데이터 입력 불가 처리(결산기간)  
	if(saveCudData_check() == false){
		return;
	}
	
	if (checkSaveData('SAP')) {
		
		ds_cudDtlData.UseChangeInfo = "false";

		//Dataset 저장		
		saveCudData();

		if (confirm('<%=msgSapSend%>')) {
			g_Pos = ds_costTotMst.RowPosition;	 
			mode = "process";
			tr_cudData.Action   = "fi.ar.cudApprCostTotLedgerSapConfirm.gau";
			tr_cudData.KeyValue	= "JSP(I:IN_DS1=ds_cudMstData,I:IN_DS2=ds_cudDtlData)";
	 		tr_cudData.Post();//Cost Total Ledger Approval
	 	}
 	}

}

//-------------------------------------------------------------------------
// SAP Cancel
//-------------------------------------------------------------------------	
function f_SapCancel(){

	if (checkSaveData('SAP_CANCEL')) {
		
		ds_cudDtlData.UseChangeInfo = "false";

		//Dataset 저장		
		saveCudData();

		if (confirm('<%=msgCancel%>')) {
			g_Pos = ds_costTotMst.RowPosition;	 
			mode = "process";
			tr_cudData.Action   = "fi.ar.cudApprCostTotLedgerSapCancelConfirm.gau";
			tr_cudData.KeyValue	= "JSP(I:IN_DS1=ds_cudMstData,I:IN_DS2=ds_cudDtlData)";
	 		tr_cudData.Post();//Cost Total Ledger Approval
	 	}
 	}

}


//-------------------------------------------------------------------------
// 승인, 취소시 Parameter 데이타셋 저장
//-------------------------------------------------------------------------
function saveCudData() {
    
	//파라메타 데이타셋 설정하는 부분 시작
	if( ds_cudMstData.CountColumn == 0 ) {
			var strHeader = "companyCd:VARCHAR(4),"
			  +"deptCd:VARCHAR(4),"
			  +"docYm:VARCHAR(6),"
			  +"docSeq:VARCHAR(10),"
			  +"docDate:VARCHAR(8),"
			  +"postDate:VARCHAR(8),"
			  +"currencyCd:VARCHAR(3),"
			  +"progStatus:VARCHAR(20),"
			  +"attr2:VARCHAR(50),"
			  +"attr3:VARCHAR(50)"
			  ;
		ds_cudMstData.SetDataHeader(strHeader);
	}

	ds_cudMstData.ClearData();
	
	for(var i=1; i <= ds_costTotMst.countRow; i++){
		if(ds_costTotMst.NameValue(i,"chk") == "T"){
			ds_cudMstData.AddRow();
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"companyCd")  = ds_costTotMst.NameValue(i,"companyCd");
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"deptCd")     = ds_costTotMst.NameValue(i,"deptCd");
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"docYm")      = ds_costTotMst.NameValue(i,"docYm");
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"docSeq")     = ds_costTotMst.NameValue(i,"docSeq");
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"docDate")    = ds_costTotMst.NameValue(i,"docDate");
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"postDate")   = ds_costTotMst.NameValue(i,"postDate");
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"currencyCd") = ds_costTotMst.NameValue(i,"currencyCd");
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"progStatus") = '';
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"attr2") = ds_costTotMst.NameValue(i,"attr2");
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"attr3") = ds_costTotMst.NameValue(i,"attr3");
		}
	}
	
}

//-------------------------------------------------------------------------
// 승인, 취소시 Parameter 데이타셋 저장 전 체크 //2014 이전 데이터 입력 불가 처리(결산기간) 
//-------------------------------------------------------------------------
function saveCudData_check(f_gbn) {
	var chkedCnt = 0;
	for(var i=1; i <= ds_costTotMst.countRow; i++){
		if(ds_costTotMst.NameValue(i,"chk") == "T"){
			if(f_forbidBeforeDate('2014/01/01',ds_costTotMst.NameValue(i,"postDate"),'none') == false ){
				ds_costTotMst.NameValue(i,"chk") = "F";
				chkedCnt++;
			}
		}
	}
	
	if(chkedCnt>0){
		if(!confirm('We have made not to save the data for postDate before 01/01/2014. continue?')){
			return false;
		}
	}
    return true;
}

//-------------------------------------------------------------------------
// Master 승인 / 취소 시 필수 체크 사항
//-------------------------------------------------------------------------
function checkSaveData(applyStatus) {

	var chk_cnt = 0;

	if(ds_costTotMst.CountRow == 0){
		alert('<%= msgNoDataItem %>');
			return false;
	}
	
	//2010.09.30
	var attr2 = ds_costTotMst.NameValue(ds_costTotMst.RowPosition ,"attr2");
	if(attr2 == "C"){
		alert('<%= msgMustReqMode %>');
		return false;
	}
	
	var progStatus = '';
	for(var i=1; i <= ds_costTotMst.countRow; i++){
		if(ds_costTotMst.NameValue(i,"chk") == "T"){
			progStatus = ds_costTotMst.NameValue(i,"progStatus");
			if ( applyStatus == 'APPR' ) {
				if ( progStatus != '10' && progStatus != '40') {
    				alert('<%=source.getMessage("dev.msg.fi.statusCheck", columnData.getString("mode_ins_rtn"))%>');
					return false;
				}
			} else if (applyStatus == 'APPR_CANCEL' && progStatus != '20' && progStatus != '40' ) {  //승인
   				alert('<%=source.getMessage("dev.msg.fi.statusCheck", columnData.getString("mode_ins_rtn"))%>');
				return false;
			} else if (applyStatus == 'SAP' && progStatus != '10') {   //SAP승인
   				alert('<%=source.getMessage("dev.msg.fi.statusCheck", columnData.getString("mode_confirm"))%>');
				return false;
			} else if (applyStatus == 'SAP_CANCEL' && progStatus != '30' && progStatus != '90') {  //승인
   				alert('<%=source.getMessage("dev.msg.fi.statusCheck", columnData.getString("mode_trsn_post"))%>');
				return false;
			}
			chk_cnt = chk_cnt + 1;
		}
	}

	if( chk_cnt == 0 ) {
		alert('<%= msgChkHeaderChk %>');
		return false;
	}
	
	return true;
}


//-------------------------------------------------------------------------
// 검색 필수 체크
//-------------------------------------------------------------------------
function checkData() {

   	if(document.all.orderDateFrom.value == "") {
		alert('<%=source.getMessage("dev.warn.com.input", columnData.getString("from_date"))%>');
	    document.all.orderDateFrom.focus();
		return false;
	}
   	if(document.all.orderDateTo.value == "") {
		alert('<%=source.getMessage("dev.warn.com.input", columnData.getString("to_date"))%>');
	    document.all.orderDateTo.focus();
		return false;
	}
	return true;
}

//-------------------------------------------------------------------------
// 검색
//-------------------------------------------------------------------------
function f_Retrieve() {

    if (checkData()) {

		var condition = "?";
	    	condition += "companyCd=<%= g_companyCd %>";
	    	condition += "&deptCd=" + "<%= g_companyCd %>";
	 		condition += "&progStatus=" + progStatus.ValueOfIndex("code",progStatus.Index);
	 		condition += "&orderDateFrom=" + removeDash(document.all.orderDateFrom.value,"/");
	 		condition += "&orderDateTo=" + removeDash(document.all.orderDateTo.value,"/");
	 		condition += "&createType=" + createType.ValueOfIndex("code",createType.Index);
	 		
	 		//alert(condition);
	
		ds_costTotMst.DataID = "fi.ar.retrieveCostTotLedgerMstConfirm.gau"+condition;
		ds_costTotMst.Reset();
		
		ds_cudDtlData.ClearData();
	}
}

//-------------------------------------------------------------------------
// Page Init
//-------------------------------------------------------------------------
function f_Init() {
	//Cost Center Retrieve
	f_RetrieveCostCenter();
}

//-------------------------------------------------------------------------
// Cost Center Retrieve
//-------------------------------------------------------------------------
function f_RetrieveCostCenter() {
	var condition = "?";
 		condition += "&postDate=";

	ds_costCenter.DataId="cm.cm.retrieveCommComboCostCenterList.gau"+condition;
	ds_costCenter.Reset();
}

</script>

<!-----------------------------------------------------------------------------
  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- CUD TR -->
<!-- Payment Arrange CUD TR -->
<OBJECT id=tr_cudData classid="<%=LGauceId.TR%>">
    <param name="KeyName"   value="toinb_dataid4">
    <!-- param name="KeyValue"  value="JSP(I:IN_DS1=ds_costTotMst)"-->
    <param name="ServerIP"  value="">
</OBJECT>

<!-----------------------------------------------------------------------------
    D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-- Grid 용 Master DataSet-->
<object id="ds_costTotMst" 	classid="<%=LGauceId.DATASET%>" >
  <param name="SyncLoad"          value="true">
  <param name="ViewDeletedRow"    value="true">
</object>

<!-- Grid 용 Detail DataSet-->
<object id="ds_costTotDtl" 	classid="<%=LGauceId.DATASET%>" >
  <param name="SyncLoad"          value="true">
  <param name="ViewDeletedRow"    value="true">
</object>

<!-- Type combo DataSet -->
<object id="ds_attr2"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
	<param name="DataID"          value="cm.cm.retrieveCommCodeCombo.gau?groupCd=2013">
</object>


<!-- 저장 DataSet -->
<object id=ds_cudMstData	classid="<%=LGauceId.DATASET%>"></object>

<!-- 저장 DataSet -->
<object id=ds_cudDtlData	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
</object>

<!-- Dept combo DataSet -->
<object id="ds_deptCode"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
	<param name="DataID"          value="cm.cm.retrieveCommCodeCombo.gau?groupCd=2001">
</object>

<!-- Status combo DataSet -->
<object id="ds_statusCode"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
	<param name="DataID"          value="cm.cm.retrieveCommCodeCombo.gau?groupCd=2002&firstVal=Total">
</object>

<!-- SPGL Combo 용 DataSet-->
<object id="ds_spgl" classid="<%=LGauceId.DATASET%>" >
  	<param name="SyncLoad"          value="fasle"> 
</object>

<!-- costCenter 용 DataSet-->
<object id="ds_costCenter" classid="<%=LGauceId.DATASET%>" >
  	<param name="SyncLoad"          value="true"> 
</object>

<!-- Vat combo DataSet -->
<object id="ds_vat"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
	<param name="DataID"          value="cm.cm.retrieveCommCodeCombo.gau?groupCd=2007">
</object>

<!-- Currency combo DataSet -->
<object id="ds_createType"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
	<param name="DataID"          value="cm.cm.retrieveCommCodeCombo.gau?groupCd=2003&firstVal=Total">
</object>
<!-----------------------------------------------------------------------------
    G A U C E   C O M P O N E N T' S   E V E N T S
------------------------------------------------------------------------------>
<script language=JavaScript for=ds_costTotMst event=OnLoadStarted()>
  cfHideNoDataMsg(gr_costTotMst);//no data 메시지 숨기기
  cfShowDSWaitMsg(gr_costTotMst);//progress bar 보이기
  mode = "";
</script>

<!-- Hub In Header 조회 DataSet -->
<script language=JavaScript for=ds_costTotMst event=OnLoadCompleted(rowCnt)>
  cfHideDSWaitMsg(gr_costTotMst);//progress bar 숨기기
  cfFillGridNoDataMsg(gr_costTotMst,"gridColLineCnt=2");//no data found   
  mode = "";
  
  gr_costTotMst.ColumnProp("deptNm", "SumText") = "Total";
  gr_costTotMst.ColumnProp("docSeq", "SumText") = "Cnt :"+rowCnt;
  gr_costTotMst.ColumnProp("amount", "SumText") = "@sum";
  gr_costTotMst.ViewSummary = "1";
</script>

<script language=JavaScript for=ds_costTotMst event=OnLoadError()>
  cfShowErrMsg(ds_costTotMst);
  //mode = "";
</script>

<!-- Hub In Confirm Detail 조회 DataSet -->
<script language=JavaScript for=ds_costTotDtl event=OnLoadCompleted(rowCnt)>
  cfFillGridNoDataMsg(gr_costTotDtl,"gridColLineCnt=2");//no data found   
</script>

<script language=JavaScript for=ds_costTotDtl event=OnLoadError()>
  cfShowErrMsg(ds_costTotDtl);
</script>

<script language="javascript"  for=gr_costTotMst event=OnCheckClick(row,colid,check)>

</script>


<script language="javascript"  for=ds_costTotMst event=OnRowPosChanged(row)>

	//Detail Dataset Clear
  	ds_costTotDtl.ClearData();
  //alert(ds_costTotMst.NameValue(row,"currencyCd")+"  "+ds_costTotMst.NameValue(row,"attr3"));
	if ( row > 0 ) {
	    var condition = "?";
		condition += "&companyCd="+ds_costTotMst.NameValue(row,"companyCd");
		condition += "&deptCd="+ds_costTotMst.NameValue(row,"deptCd");
		condition += "&docYm="+ds_costTotMst.NameValue(row,"docYm");
		condition += "&docSeq="+ds_costTotMst.NameValue(row,"docSeq");
		ds_costTotDtl.DataID = "fi.ar.retrieveCostTotLedgerDtlConfirm.gau"+condition;
		ds_costTotDtl.Append();
	}

</script>

<!-- 전체 체크박스 선택/해제 -->
<script language=JavaScript for=gr_costTotMst event=OnHeadCheckClick(Col,Colid,bCheck)>

	if(bCheck == 0){//uncheck

		for(var i=1; i <= ds_costTotMst.countRow; i++)
		{
			ds_costTotMst.Namevalue(i,"chk") = "F";
		}

		// DataSet의 Clear 시킨다.
		ds_cudDtlData.ClearData();

	}else{//check

	    if (checkData()) {

			for(var i=1; i <= ds_costTotMst.countRow; i++)
			{
				ds_costTotMst.Namevalue(i,"chk") = "T";
			}
			
		}
		
	}
</script>

<script language=JavaScript for="ds_costTotDtl" event=OnRowPosChanged(row)>
	
</script>

<script language=JavaScript for=gr_costTotDtl event=OnCloseUp(row,colid)>
	
	
</script>

<script language=JavaScript for=gr_costTotDtl event=OnClick(row,colid)>

</script>

<script language=JavaScript for=DataSetID event=OnColumnChanged(row,colid)>

</script>

<!-- 저장 TR -->
<script language=JavaScript for=tr_cudData event=OnSuccess()>
	mode = "";
	f_Retrieve();
	alert('<%=source.getMessage("dev.suc.com.save")%>');
	ds_costTotMst.RowPosition = g_Pos; 			
</script>

<script language=JavaScript for=tr_cudData event=OnFail()>
  if(tr_cudData.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
        window.parent.location.href = "/index.jsp";    
   }
   mode = "";
   
  	alert("Error Code : " + tr_cudData.ErrorCode + "\n" + "Error Message : " + tr_cudData.ErrorMsg + "\n");  
</script>

<script language="javascript"  for=gr_costTotDtl event=OnColumnPosChanged(row,colid)>
    
    // SEARCH 버튼  DISPLAY
    if (colid.toLowerCase() == "acctcd") cfSetSearchGridBtn(gr_costTotDtl);
    if (colid.toLowerCase() == "sapacctc") cfSetSearchGridBtn(gr_costTotDtl);
    if (colid.toLowerCase() == "sapacctv") cfSetSearchGridBtn(gr_costTotDtl);
    
</script>

<script language="javascript"  for=gr_costTotDtl event=OnPopup(Row,Colid,data)>
  
</script>


</head>

<body id="cent_bg" onload="f_Init();">

<div id="conts_box">
	<h2> <span><%= columnData.getString("page_title") %></span></h2>

	<!--검색 S -->	
	 <fieldset class="boardSearch">
		<div>
			 <dl>
				<dt> 
					<table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board2" >
						<colgroup>
							<col width="15%"/>
							<col width="40%"/>
							<col width="20%"/>
							<col width="25%"/>
						</colgroup>
						<tr>
							<object id="deptCd"  classid="<%=LGauceId.LUXECOMBO%>" align="absmiddle" width="120" style='display:none'>
								<param name="ComboDataID"       value="ds_deptCode">
								<param name="ListCount"     	value="10">
								<param name="BindColumn"    	value="code">
								<param name=ListExprFormat		value="name^0^100,code^0^40">
								<param name=index           	value=0>
							</object>
							<th><%= columnData.getString("create_date") %></th>
							<td >
								<input type="text" id="orderDateFrom" value="<%= prevDate %>" 	 onblur="valiDate(this);"	style="width:70px;"/>&nbsp;<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(orderDateFrom);" style="cursor:hand"/> ~ 
								<input type="text" id="orderDateTo"   value="<%= currentDate %>" onblur="valiDate(this);"	style="width:70px;"/>&nbsp;<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(orderDateTo);" style="cursor:hand"/>
							</td>
							<th><%= columnData.getString("prog_status") %></th>
							<td>
								<object id="progStatus"  classid="<%=LGauceId.LUXECOMBO%>" align="absmiddle" width="100">
								    <param name="ComboDataID"       value="ds_statusCode">
									<param name="ListCount"     	value="10">
									<param name="BindColumn"    	value="code">
									<param name="WantSelChgEvent"   value="TRUE">
								    <param name=ListExprFormat		value="name^0^90,code^0^70">
								    <param name=index           	value=0>
							   	</object>
							</td>
						</tr>
						<tr>
							<th><%= columnData.getString("create_type") %></th>
							<td colspan="3">
								<object id="createType"  classid="<%=LGauceId.LUXECOMBO%>" align="absmiddle" width="100">
								    <param name="ComboDataID"       value="ds_createType">
									<param name="ListCount"     	value="10">
									<param name="BindColumn"    	value="code">
									<param name="WantSelChgEvent"   value="TRUE">
								    <param name=ListExprFormat		value="name^0^90,code^0^70">
								    <param name=index           	value=0>
							   	</object>
							</td>
						</tr>
					</table>
				 </dt>              		  	   	 	
				 <dd class="btnseat2"> 
				 	  <span class="search_btn2_r search_btn2_l">
                			  <input type="button" onfocus="blur();" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='#e2ebf7'" value="<%=btnSearch %>" onclick="f_Retrieve();"/></span> 
				 </dd>

			</dl>
		</div>
		</fieldset>
      <!--검색 E -->

	<div class="sub_stitle"> <p><%= columnData.getString("sub1_title") %></p> </div>     	
	
	<!-- 그리드 S -->	
    <div>
	<object id="gr_costTotMst" classid="<%=LGauceId.GRID %>" style="width:100%;height:150px;" class="comn"
		dataName="Cost Total Ledger Mst"
	    validFeatures="ignoreStatus=no"
		validExp="">
		<param Name="DataID" 			value='ds_costTotMst'>
	    <Param name="AutoResizing"      value=true>
	    <param name="ColSizing"         value=true>
	    <Param name="DragDropEnable"    value=True>
	    <param name="AddSelectRows"     value=True>
	    <Param name="SortView"          value="right">
	    <param name="Editable"          value=True>
	    <param name="UsingOneClick"     value=1>
        <param name=ViewSummary         value="1">
		<param Name='Format'
			value='
				<C> id=chk	        	name="<%= columnData.getString("chk") %>" 		                         width="40"	   Edit="true"   EditStyle=CheckBox	HeadAlign=center HeadCheck=false HeadCheckShow=true </c>
				<C> id=createType      	name="<%= columnData.getString("create_type") %>"     		 align="center"   width="50"    Edit="none"   EditStyle="LookUp" 	Data="ds_createType:Code:NAME" show="true"  </C>
                <C> id=companyCd   		name="<%= columnData.getString("company_cd") %>"     	 align="center"   width="70"    Edit="none"   show="false" </C>
                <C> id=deptCd      		name="<%= columnData.getString("dept_cd") %>"     		 align="center"   width="40"    Edit="none"   show="false" </C>
                <C> id=deptNm      		name="<%= columnData.getString("dept_cd") %>"     		 align="left"     width="70"    Edit="none"   show="false" </C>
                <C> id=docYm       		name="<%= columnData.getString("doc_ym") %>"     		 align="center"   width="65"    Edit="none"   show="true" </C>
                <C> id=docSeq      		name="<%= columnData.getString("doc_seq") %>"     		 align="center"   width="65"    Edit="none"   show="true" </C>
                <C> id=amount      		name="<%= columnData.getString("amount") %>"     		 align="right"    width="110"   Edit="none"   show="true"  sumbgcolor="#ECE6DE" sumcolor="#666666" DisplayFormat ="#,###.00"</C>
                <C> id=currencyCd    	name="<%= columnData.getString("currency_cd") %>"   	 align="center"   width="45"    Edit="none"   show="true" </C>
                <C> id=docType     		name="<%= columnData.getString("doc_type") %>"     	     align="center"   width="70"    Edit="none"   show="false" </C>
                <C> id=progStatus  		name="<%= columnData.getString("prog_status") %>"     	 align="center"   width="70"    Edit="none"   show="false" </C>
                <C> id=progStatusNm 	name="<%= columnData.getString("prog_status_nm") %>"     align="left"     width="90"    Edit="none"   show="true" </C>
                <C> id=attr2 				name="<%= columnData.getString("attr2") %>"      	 align="left"     width="74"    Edit="none"   show="false" EditStyle="LookUp" 	Data="ds_attr2:Code:NAME"  </C>
                <C> id=sapDocSeq  		name="<%= columnData.getString("sap_doc_seq") %>"     	 align="center"   width="87"    Edit="none"   show="true" </C>
                <C> id=createDate  		name="<%= columnData.getString("create_date") %>"     	 align="center"   width="80"    Edit="none"   show="true" Mask="XXXX/XX/XX"</C>
                <C> id=docDate     		name="<%= columnData.getString("doc_date") %>"     	     align="center"   width="80"    Edit="none"   show="true" Mask="XXXX/XX/XX"</C>
                <C> id=postDate    		name="<%= columnData.getString("post_date") %>"     	 align="center"   width="80"    Edit="none"   show="true" Mask="XXXX/XX/XX"</C>
                <C> id=successType 		name="<%= columnData.getString("success_type") %>"       align="center"   width="70"    Edit="none"   show="false" </C>
                <C> id=attr3 		show="false" </C>
	      '>
	</object>
 	</div>

    <div class="pad_t5"></div>
    <div class="sub_stitle"> <p>Cost Price Detail</p> </div>

	<!-- 그리드 S -->	
    <div>
	<object id="gr_costTotDtl" classid="<%=LGauceId.GRID %>" style="width:100%;height:160px;" class="comn"
		dataName="Cost Total Ledger Dtl"
	    validFeatures="ignoreStatus=no"
		validExp="">
		<param Name="DataID" 			value="ds_costTotDtl">
		<Param Name="AutoResizing" 		value="true">
		<param name="ColSizing" 		value="true">
		<Param Name="DragDropEnable"	value="True">
		<param Name="AddSelectRows" 	value="True">
		<Param NAME="Sort"              value="true">
		<Param Name="SortView" 			value="right">
		<Param NAME="TitleHeight"      	VALUE="30">	
		<param name="UsingOneClick" 	value="1">
        <param name=ViewSummary         value="1">
		<param Name="Format"
			value='
           		<C> id=seq                           name="<%= columnData.getString("item_seq") %>"       align="center"   width="30"    Edit="none"   Value={CurRow} </C>
                <C> id=companyCd            name="<%= columnData.getString("company_cd") %>"     align="center"   width="70"    Edit="none"   show="false" </C>
                <C> id=deptCd                    name="<%= columnData.getString("dept_cd") %>"     	align="center"   width="70"    Edit="none"   show="false" </C>
                <C> id=docYm            	        name="<%= columnData.getString("doc_ym") %>"     	align="center"   width="70"    Edit="none"   show="false" </C>
                <C> id=docSeq                    name="<%= columnData.getString("doc_seq") %>"     	align="center"   width="70"    Edit="none"   show="false" </C>
                <C> id=docNum          	        name="<%= columnData.getString("doc_num") %>"     	align="center"   width="70"    Edit="none"   show="false" </C>
                <C> id=sapAcctCd     	        name="<%= columnData.getString("acct_cd") %>"     	align="left"     width="57"    Edit="none"   show="true" EditStyle=PopupFix</C>
                <C> id=sapAcctNm    	        name="<%= columnData.getString("acct_nm") %>"        align="left"     width="215"   Edit="none"   show="true" sumtext="Total" </C>
                <C> id=debitAmt        	        name="<%= columnData.getString("debit_amt") %>"      align="right"    width="110"   EDIT="none"   show="true" sumtext="@sum", sumbgcolor="#ECE6DE" sumcolor="#666666" </C>
                <C> id=creditAmt               name="<%= columnData.getString("credit_amt") %>"     align="right"    width="110"   EDIT="none"   show="true" sumtext="@sum", sumbgcolor="#ECE6DE" sumcolor="#666666"</C>
                <C> id=vat                           name="Tax Code"     	    align="left"     width="110"   Edit="none"   show="true" Data="ds_vat:code:name" Editstyle="Lookup"</C>
                <C> id=vatBaseAmount    name="<%= columnData.getString("attr10") %>"     align="left"     width="110"   Edit="none"   show="false" dec=2</C>
                <C> id=base                         name="<%= columnData.getString("base") %>"     	    align="right"    width="110"    Edit="none"   show="false" </C>
                <C> id=type                         name="<%= columnData.getString("type") %>"     	    align="center"   width="70"    Edit="none"   show="false" </C>
                <C> id=code                         name="<%= columnData.getString("code") %>"           align="center"   width="50"    Edit="none"   show="false" </C>
                <C> id=rate                          name="<%= columnData.getString("rate") %>"           align="right"    width="50"    Edit="none"   show="false" </C>
                <C> id=center                      name="<%= columnData.getString("center") %>"     	align="left"     width="180"   Edit="none"   show="true" Data="ds_costCenter:code:name"  EditStyle="LookUp"</C>
                <C> id=priCenter                 name="<%= columnData.getString("pri_center") %>"     align="left"     width="100"   Edit="none"   show="false" Data="ds_costCenter:code:name"  EditStyle="LookUp"</C>
                <C> id=intOrderNm                   name="<%= columnData.getString("order") %>"     	    align="left"   width="140"    Edit="none"   show="true" </C>
                <C> id=docDesc                   name="<%= columnData.getString("doc_desc") %>"       align="left"     width="200"   Edit="none"   show="true" </C>
                <C> id=sapAcctV                 name="<%= columnData.getString("sap_acct_v") %>"     align="center"   width="140"   Edit="none"   show="false" </C>
                <C> id=sapAcctVNm           name="<%= columnData.getString("sap_acct_v") %>"     align="left"     width="140"   Edit="none"   show="true" </C>
                <C> id=sapAcctC                 name="<%= columnData.getString("sap_acct_c") %>"     align="center"   width="100"   Edit="none"   show="false" </C>
                <C> id=sapAcctCNm           name="<%= columnData.getString("sap_acct_c") %>"     align="left"     width="100"   Edit="none"   show="true" </C>
                <C> id=dueDate                   name="<%= columnData.getString("attr11") %>"     align="left"     width="100"   Edit="AlphaNum"   show="true" Mask="XXXX/XX/XX" editstyle="PopupFix" </C>
                <C> id=returnMsg                name="<%= columnData.getString("return_msg") %>"     align="center"   width="120"   Edit="none"   show="true" BgColor={IF(returnMsg="","White","Red")} </C>
                <C> id=spglNo                      name="<%= columnData.getString("spgl_no") %>"     	align="center"   width="80"    Edit="none"   show="true" Data="ds_spgl:code"  Editstyle="Lookup" </C>
                <C> id=sp                              name="<%= columnData.getString("sp") %>"             align="center"   width="70"    Edit="none"   show="false" </C>
                <C> id=periodCostFrom name="Period From"  align="center"  width="100"  Edit="RealNumeric"  show="true"   Mask="XXXX/XX/XX" editstyle="Popup"  </C>
                <C> id=periodCostTo   name="Period To"    align="center"  width="100"  Edit="RealNumeric"  show="true"   Mask="XXXX/XX/XX" editstyle="Popup"  </C>
                <C> id="attr12"            name="Activity"                                      align="center"   width="60"    Edit="none"       show="false" </C>
                <C> id="attr13"            name="Unit"	                                        align="center"   width="60"    Edit="none"       show="false" </C>
                <C> id="attr14"            name="Qty"	                                        align="right"    width="100"   Edit="none"       show="false" </C>
                <C> id="attr15"            name="Unit"	                                        align="center"   width="60"    Edit="none"       show="false" </C>
                <C> id="attr16"            name="Distance"                                      align="right"    width="100"   Edit="none"       show="false" </C>                
	      '>
	</object>
 	</div>
      
	<!-- 버튼 S -->	
    <div id="btn_area">
    	<p class="b_right">
    	<!-- 
    	<span class="btn_r btn_l"><input type="button" onClick="f_Approval();" 		onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%= btnApproval %>"/></span>
    	<span class="btn_r btn_l"><input type="button" onClick="f_Cancel();" 	    onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%= btnReject %>"/></span>&nbsp;&nbsp;|&nbsp;
    	 -->
    	<span class="btn_r btn_l"><input type="button" onClick="f_SapSend();" 	    onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%= btnSapSend %>"  /></span>
    	<span class="btn_r btn_l"><input type="button" onClick="f_SapCancel();" 	onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%= btnSapCancel %>"  /></span>
    	</p>
   	</div>
    <!-- 버튼 E -->
        
    
    <div class="pad_t5"></div>

<!--script src="/debug_utf8.js"></script-->

        	  
</div>
</body>
</html>
