<%--
/*
 *************************************************************************
 * @source  : stockMoveCancel.jsp
 * @desc    : Stock Movement Sap Cancel
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2010.08.27   mskim       Init
 * 1.1  2011.08.29    hskim        CSR:C20110823_49874
 * ---  -----------  ----------  -----------------------------------------
 * PT-PAM 시스템
 * Copyright(c) 2006-2007 LG CNS,  All rights reserved.
 *************************************************************************
 */
--%> 
<%@ page import="devon.core.util.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Stock Movement Registration</title>
<%@ include file="/include/head.jsp" %>

<%	
	String prevDate	     = LDateUtils.getDate("yyyy/MM/") +"01"; 
	String currentDate   = LDateUtils.getDate("yyyy/MM/dd");          // currentDate

	String msgNoRequestRequisition = source.getMessage("dev.msg.po.noRequestRequisition");    // The selected item's Requisition Status is not request status!
	String msgNoTransfer = source.getMessage("dev.msg.po.noTranster");    // The selected item does not transfer mode!
	String msgNoSapSendConfirm = source.getMessage("dev.msg.po.noSapSendConfirm");    // The selected item is not sap send confirm mode!
	String msgNoMoveCreate = source.getMessage("dev.msg.po.noMoveCreate");    // The selected item does not transfer mode!
	String msgNoRequest = source.getMessage("dev.msg.po.noRequest");    // The selected item does not request mode!
	String msgNoConfirm = source.getMessage("dev.msg.po.noConfirm");    // The selected item does not confirm status!
    String msgConfirm     = source.getMessage("dev.cfm.com.confirm");    	 // Are you sure to Confirm?
    String msgReject     = source.getMessage("dev.cfm.com.reject");    	 // Are you sure to Reject?
    String msgSave     = source.getMessage("dev.cfm.com.save");    	 // Are you sure to save?
    String msgSapSend     = source.getMessage("dev.msg.po.sapsend");    	 // Are you sure to SAP Send?
    String msgSapCancel     = source.getMessage("dev.msg.po.sapcancelcontinue");    	 // Are you sure to SAP Cancel?
    String msgCheckDate  = source.getMessage("dev.warn.com.checkDate");    // Check Date Format
//    String msgQuantityChk  = source.getMessage("dev.msg.po.biggerIssue");    // Check Date Format
    String msgQuantityChk  = source.getMessage("dev.msg.po.chkQuantity");    // Check Date Format
    String msgQuantityZeroChk  = source.getMessage("dev.msg.po.chkQuantityZero");    // Check Date Format
%>

<script type="text/javascript">

var msgType = "";
var lastTransNo = "";
//-------------------------------------------------------------------------
// Location을 로그인한 사용자의 dept_Cd와 맞춰줌 
//-------------------------------------------------------------------------		
function init(){
	for(var i=1; i<=ds_recelocation.CountRow; i++){
		if(ds_recelocation.NameValue(i, "code") == ds_defaultDeptCd.NameValue(1, "deptCd")){
			receLoc.Index = i-1;
			break;
		}
	}

}


//-------------------------------------------------------------------------
// 검색 버튼 클릭시 재고 조회
//-------------------------------------------------------------------------		
function f_Retrieve() {

	var orderDateFrom = removeDash(document.all.orderDateFrom.value,"/");
	var orderDateTo   = removeDash(document.all.orderDateTo.value,"/");
	var orderFrMon    = orderDateFrom.substring(0, 6);
	var orderToMon    = orderDateTo.substring(0, 6);

	if ( orderFrMon != orderToMon ) {
		alert('<%= source.getMessage("dev.msg.po.chkSameMonth","From Date","To Date") %>' );
		document.all.orderDateFrom.focus();
		return false;
	}
	
	var param = "";

	param += "issueLoc="  + issueLoc.ValueOfIndex("code",issueLoc.Index);
	param += "&receLoc="  + receLoc.ValueOfIndex("code",receLoc.Index);
	param += "&orderDateFrom=" + removeDash(document.all.orderDateFrom.value, "/");
	param += "&orderDateTo=" + removeDash(document.all.orderDateTo.value, "/");
	param += "&status="  + progStatus.ValueOfIndex("code",progStatus.Index);
	param += "&delFlag="  + "N";

	ds_stockMoveMst.DataID = "po.is.retrieveStockMoveCancelMst.gau?"+param;
	ds_stockMoveMst.Reset();
	
	//alert(ds_stockMoveMst.countrow);
}  

//-------------------------------------------------------------------------
// SAP Cancel
//-------------------------------------------------------------------------	
function f_sapCancel() {

	
	var status = ds_stockMoveMst.nameValue(ds_stockMoveMst.RowPosition,"status");
	if ( status != '03' ) {
		alert("<%= msgNoSapSendConfirm %>");
		return;
	}


	var currDate      = removeDash("<%= currentDate %>","/");
	var orderDateFrom = removeDash(document.all.orderDateFrom.value,"/");
	var currMon       = currDate.substring(0, 6);
	var orderFrMon    = orderDateFrom.substring(0, 6);

/*
	if ( orderFrMon != currMon ) {
		alert('<%= source.getMessage("dev.msg.po.chkSameMonth", columnData.getString("posting_date"), columnData.getString("current_date")) %>');
		document.all.orderDateFrom.focus();
		return false;
	}
*/

	//변경한 데이터가 있는지 체크한다.
	if(confirm("<%= msgSapCancel %>")){
		
		msgType = "sapCancel";
		lastTransNo = ds_stockMoveMst.nameValue(ds_stockMoveMst.RowPosition,"tranNo");
		ds_stockMoveDtl.UseChangeInfo = "false";

		var param = "";

		param += "companyCd=" + ds_stockMoveMst.nameValue(ds_stockMoveMst.RowPosition,"companyCd");
		param += "&tranNo=" + ds_stockMoveMst.nameValue(ds_stockMoveMst.RowPosition,"tranNo");
		param += "&sapDocNo=" + ds_stockMoveMst.nameValue(ds_stockMoveMst.RowPosition,"sapDocNo");
		param += "&postingDate=" + ds_stockMoveMst.nameValue(ds_stockMoveMst.RowPosition,"postingDate");
		param += "&moveDate=" + ds_stockMoveMst.nameValue(ds_stockMoveMst.RowPosition,"postingDate");
		
		tr_master.KeyValue = "Servlet(I:IN_DS1=ds_stockMoveDtl)";
		tr_master.Action   = "po.is.cudStockMoveSapCancel.gau?"+param;
		tr_master.post();
	}

}

//-------------------------------------------------------------------------
// SAP Save
//-------------------------------------------------------------------------	
function f_sapSend() {

	if(ds_stockMoveDtl.IsUpdated) {
 		alert("<%=source.getMessage("dev.msg.po.savecontinue")%>");
		return;			 
	}
	
	// 저장을 안했으면 저장하라는 메세지 표시
	for(var i=1; i<=ds_stockMoveDtl.CountRow; i++){
		if(ds_stockMoveDtl.NameValue(i, "tranQty") != ds_stockMoveDtl.NameValue(i, "requestMoveQty") - ds_stockMoveDtl.NameValue(i, "returnQty") ){
	 		alert("<%=source.getMessage("dev.msg.po.savecontinue")%>");
			return;	
		}
	}
	
	if(ds_stockMoveDtl.IsUpdated) {
 		alert("<%=source.getMessage("dev.msg.po.savecontinue")%>");
		return;			 
	}
		
	var status = ds_stockMoveMst.nameValue(ds_stockMoveMst.RowPosition,"status");
	//var requisitionStatus = ds_stockMoveMst.nameValue(ds_stockMoveMst.RowPosition,"requisitionStatus");
	if ( status != '01' ) {
		alert("<%= msgNoMoveCreate %>");
		return;
	}
	/*
	else if( requisitionStatus != '20') {
		alert("<%= msgNoConfirm %>");
		return;
	
	}
	*/
	
	// 아이템이 1개이고 receipt 수량이 0개이면 전송하지 못하게 막음
	var isZero = true;
	for( var i=1; i<=ds_stockMoveDtl.CountRow; i++){
		if(ds_stockMoveDtl.NameValue(i, "tranQty") != "0"){
			isZero = false;
		}
	}
	
	if(isZero == true){
 		alert("<%=msgQuantityZeroChk%>");
		return;
	}
	
	//변경한 데이터가 있는지 체크한다.
	if(confirm("<%= msgSapSend %>")){
	
		msgType = "sapSend";
		lastTransNo = ds_stockMoveMst.nameValue(ds_stockMoveMst.RowPosition,"tranNo");
		
		ds_stockMoveDtl.UseChangeInfo = "false";

		var param = "";

			param += "issueLoc="  + ds_stockMoveMst.nameValue(ds_stockMoveMst.RowPosition,"issueLoc");
			param += "&receLoc="  + ds_stockMoveMst.nameValue(ds_stockMoveMst.RowPosition,"receLoc");
			param += "&moveDate=" + ds_stockMoveMst.nameValue(ds_stockMoveMst.RowPosition,"moveDate");
			param += "&postingDate=" + ds_stockMoveMst.nameValue(ds_stockMoveMst.RowPosition,"postingDate");
			param += "&tranNo=" + ds_stockMoveMst.nameValue(ds_stockMoveMst.RowPosition,"tranNo");
			
			
		tr_master.KeyValue = "Servlet(I:IN_DS1=ds_stockMoveDtl)";
		tr_master.Action   = "po.is.cudStockMoveSapSend.gau?"+param;
		tr_master.post();
	}

}

//-------------------------------------------------------------------------
// DB Save
//-------------------------------------------------------------------------	
function f_save() {

	var status = ds_stockMoveMst.nameValue(ds_stockMoveMst.RowPosition,"status");
	if ( status != '01' ) {
		alert("<%= msgNoRequest %>");
		return;
	}
	
	var currDate      = removeDash("<%= currentDate %>","/");
	var orderDateFrom = removeDash(document.all.orderDateFrom.value,"/");
	var currMon       = currDate.substring(0, 6);
	var orderFrMon    = orderDateFrom.substring(0, 6);

/*
	if ( orderFrMon != currMon ) {
		alert('<%= source.getMessage("dev.msg.po.chkSameMonth", columnData.getString("posting_date"), columnData.getString("current_date")) %>');
		document.all.orderDateFrom.focus();
		return false;
	}
*/

	//변경한 데이터가 있는지 체크한다.
	if(confirm("<%= msgSave %>")){
		
		ds_stockMoveDtl.UseChangeInfo = "false";
		lastTransNo = ds_stockMoveMst.nameValue(ds_stockMoveMst.RowPosition,"tranNo");

		var param = "";

		param += "companyCd=" + ds_stockMoveMst.nameValue(ds_stockMoveMst.RowPosition,"companyCd");
		param += "&tranNo=" + ds_stockMoveMst.nameValue(ds_stockMoveMst.RowPosition,"tranNo");
		param += "&sapDocNo=" + ds_stockMoveMst.nameValue(ds_stockMoveMst.RowPosition,"sapDocNo");
		
		tr_master.KeyValue = "Servlet(I:IN_DS1=ds_stockMoveDtl)";
		tr_master.Action   = "po.is.cudStockMoveSave.gau?"+param;
		tr_master.post();
	}

}

//-------------------------------------------------------------------------
// DB Confirm
//-------------------------------------------------------------------------	
function f_confirm() {

	if(ds_stockMoveDtl.IsUpdated) {
 		alert("<%=source.getMessage("dev.msg.po.savecontinue")%>");
		return;			 
	}

	var status = ds_stockMoveMst.nameValue(ds_stockMoveMst.RowPosition,"requisitionStatus");
	if ( status != '10' ) {
		alert("<%= msgNoRequestRequisition %>");
		return;
	}

	var currDate      = removeDash("<%= currentDate %>","/");
	var orderDateFrom = removeDash(document.all.orderDateFrom.value,"/");
	var currMon       = currDate.substring(0, 6);
	var orderFrMon    = orderDateFrom.substring(0, 6);

/*
	if ( orderFrMon != currMon ) {
		alert('<%= source.getMessage("dev.msg.po.chkSameMonth", columnData.getString("posting_date"), columnData.getString("current_date")) %>');
		document.all.orderDateFrom.focus();
		return false;
	}
*/

	//변경한 데이터가 있는지 체크한다.
	if(confirm("<%= msgConfirm %>")){

		lastTransNo = ds_stockMoveMst.nameValue(ds_stockMoveMst.RowPosition,"tranNo");		
		ds_stockMoveDtl.UseChangeInfo = "false";
		ds_stockMoveMst.NameValue(ds_stockMoveMst.RowPosition, "chk") = "T";    // 변경 위해 update를 해주는 것.

		var param = "";

		param += "companyCd=" + ds_stockMoveMst.nameValue(ds_stockMoveMst.RowPosition,"companyCd");
		param += "&tranNo=" + ds_stockMoveMst.nameValue(ds_stockMoveMst.RowPosition,"tranNo");
		param += "&sapDocNo=" + ds_stockMoveMst.nameValue(ds_stockMoveMst.RowPosition,"sapDocNo");
		
		tr_master.KeyValue = "Servlet(I:IN_DS1=ds_stockMoveMst)";
		tr_master.Action   = "po.is.cudStockMoveConfirm.gau?"+param;
		tr_master.post();
	}

}

//-------------------------------------------------------------------------
// DB Reject
//-------------------------------------------------------------------------	
function f_reject() {

	var status = ds_stockMoveMst.nameValue(ds_stockMoveMst.RowPosition,"status");
	var requisitionStatus = ds_stockMoveMst.nameValue(ds_stockMoveMst.RowPosition,"requisitionStatus");
	if ( status != '01') {
		alert("<%= msgNoRequest %>");
		return;
	}else if ( requisitionStatus != '20') {
		alert("<%= msgNoConfirm %>");
		return;
	}
	

	//변경한 데이터가 있는지 체크한다.
	if(confirm("<%= msgReject %>")){

		lastTransNo = ds_stockMoveMst.nameValue(ds_stockMoveMst.RowPosition,"tranNo");
		ds_stockMoveDtl.UseChangeInfo = "false";
		ds_stockMoveMst.NameValue(ds_stockMoveMst.RowPosition, "chk") = "T";    // 변경 위해 update를 해주는 것.

		var param = "";

		param += "companyCd=" + ds_stockMoveMst.nameValue(ds_stockMoveMst.RowPosition,"companyCd");
		param += "&tranNo=" + ds_stockMoveMst.nameValue(ds_stockMoveMst.RowPosition,"tranNo");
		param += "&sapDocNo=" + ds_stockMoveMst.nameValue(ds_stockMoveMst.RowPosition,"sapDocNo");
		
		tr_master.KeyValue = "Servlet(I:IN_DS1=ds_stockMoveMst)";
		tr_master.Action   = "po.is.cudStockMoveReject.gau?"+param;
		tr_master.post();
	}

}
//-------------------------------------------------------------------------
// excel
//-------------------------------------------------------------------------					   
function f_excelDown(){

	if (ds_stockMoveMst.CountRow > 0) {

		var condition = "?";
	 		condition += "issueLoc="  + issueLoc.ValueOfIndex("code",issueLoc.Index);
			condition += "&receLoc="  + receLoc.ValueOfIndex("code",receLoc.Index);
			condition += "&orderDateFrom=" + removeDash(document.all.orderDateFrom.value, "/");
			condition += "&orderDateTo=" + removeDash(document.all.orderDateTo.value, "/");
			condition += "&status="  + progStatus.ValueOfIndex("code",progStatus.Index);
			condition += "&delFlag="  + "N";

		ds_excelDown.DataID = "po.is.retrieveStockExcelDownList.gau?"+condition;
		ds_excelDown.Reset();	
	}else {
		alert("No data");
	}
}

function f_excel() {
	gf_excel(ds_excelDown,gr_excelDown,"<%=columnData.getString("page_title") %>","c:\\");
}

</script>  

<!-----------------------------------------------------------------------------
  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<OBJECT id="tr_master" classid="<%=LGauceId.TR%>">
	<param name="KeyName" value="toinb_dataid4">
</OBJECT>

<!-----------------------------------------------------------------------------
    D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-- Grid 용 Master DataSet-->
<object id="ds_stockMoveMst" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"    		value="true">
	<param name="ViewDeletedRow" 	value="true">
</object>

<!-- Grid 용 Detail DataSet-->
<object id="ds_stockMoveDtl" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"    		value="true">
	<param name="ViewDeletedRow" 	value="true">
</object>

<!-- Hidden Grid 용 Detail DataSet-->
<object id="ds_excelDown" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/> 
  <param name="ViewDeletedRow"    value="false"/>
</object>

<!-- 입고/출고 저장소 combo DataSet -->
<object id="ds_issuelocation"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"  value="true">
	<param name="DataID"    value="cm.cm.retrieveCommCodeCombo.gau?groupCd=2005&firstVal=Total&attr2=M">
</object>

<!-- 입고/출고 저장소 combo DataSet -->
<object id="ds_recelocation"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"  value="true">
	<param name="DataID"    value="cm.cm.retrieveCommCodeCombo.gau?groupCd=2005&attr2=M">
</object>

<!-- status combo DataSet -->
<object id="ds_status"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"  value="true">
	<param name="DataID"    value="cm.cm.retrieveCommCodeCombo.gau?groupCd=2209&firstVal=Total">
</object>

<!-- 입고/출고 저장소 초기 default값 얻어오는 DataSet -->
<object id="ds_defaultDeptCd"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
	<param name="DataID"          value="cm.cm.retrieveCommDefaultDeptCd.gau?groupCd=2001">
</object>


<!-- lx Combo 용 DataSet-->
<object id="ds_mater"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
	<param name="DataID"          value="cm.cm.retrieveCommComboMaterList.gau?materType=3110">
</object>

<!-----------------------------------------------------------------------------
    G A U C E   C O M P O N E N T' S   E V E N T S
------------------------------------------------------------------------------>
<script language=JavaScript for=ds_stockMoveMst event=OnLoadStarted()>
  cfHideNoDataMsg(gr_stockMoveMst);//no data 메시지 숨기기
  cfShowDSWaitMsg(gr_stockMoveMst);//progress bar 보이기
  mode = "";
</script>

<!-- Hub In Header 조회 DataSet -->
<script language=JavaScript for=ds_stockMoveMst event=OnLoadCompleted(rowCnt)>
  cfHideDSWaitMsg(gr_stockMoveMst);//progress bar 숨기기
  cfFillGridNoDataMsg(gr_stockMoveMst,"gridColLineCnt=2");//no data found   
  mode = "";
</script>

<script language=JavaScript for=ds_stockMoveMst event=OnLoadError()>
  cfShowErrMsg(ds_stockMoveMst);
  //mode = "";
</script>

<script language=JavaScript for=ds_excelDown event=OnLoadCompleted(rowCnt)>
f_excel();
</script>

<!-- Hub In Confirm Detail 조회 DataSet -->
<script language=JavaScript for=ds_stockMoveDtl event=OnLoadCompleted(rowCnt)>
  cfFillGridNoDataMsg(gr_stockMoveDtl,"gridColLineCnt=2");//no data found   
  
  
  /*
  for(var i=1; i<= ds_stockMoveDtl.CountRow; i++){
  	ds_stockMoveDtl.NameValue(i, "tranQty") =  ds_stockMoveDtl.NameValue(i, "requestMoveQty") - ds_stockMoveDtl.NameValue(i, "returnQty") ;
  }
  */
  
</script>

<script language=JavaScript for=ds_stockMoveDtl event=OnLoadError()>
  cfShowErrMsg(ds_stockMoveDtl);
</script>

<script language=JavaScript for=gr_stockMoveDtl event=OnExit(row,colid,olddata)>

	var returnQty = ds_stockMoveDtl.NameValue(row, "requestMoveQty") - ds_stockMoveDtl.NameValue(row, "tranQty")	;
	
	if(parseFloat(returnQty) < 0.0){
		alert('<%=msgQuantityChk %>');
		ds_stockMoveDtl.NameValue(row, "tranQty") = olddata;
	}else{
		ds_stockMoveDtl.NameValue(row, "returnQty") = returnQty;
	}
	

</script>

<script language=JavaScript for=tr_master event=OnSuccess()>
	f_Retrieve();			
	

	// TR 이후에 작업 했었던 행을 찾아주는 작업
	for(var i=1; i<=ds_stockMoveMst.CountRow; i++){
		if(ds_stockMoveMst.NameValue(i, "tranNo") == lastTransNo){
			ds_stockMoveMst.RowPosition = i;
			break;
		}
	}
	
	
	if(msgType == "sapSend"){
	    alert('<%= source.getMessage("dev.msg.po.sapsucess") %>' );	  
	}else if(msgType == "sapCancel"){
	    alert('<%= source.getMessage("dev.msg.po.sapcancel") %>' );	     
	}else{
	    alert('<%= source.getMessage("dev.suc.com.save") %>' );	    
	}
	
	
	msgType = "";
	

</script>

<script language=JavaScript for=tr_master event=OnFail()>
    if(tr_master.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
        window.parent.location.href = "/index.jsp";    
    }
    
   	if ( tr_master.ErrorMsg.indexOf("simpleMsg")) {
		var cnt = 12 + tr_master.ErrorMsg.indexOf("simpleMsg");
		alert(tr_master.ErrorMsg.substring(cnt, tr_master.ErrorMsg.length));
   	}

</script>

<script language="javascript"  for=ds_stockMoveMst event=OnRowPosChanged(row)>

	//Detail Dataset Clear
  	ds_stockMoveDtl.ClearData();

	if ( row > 0 ) {

		var param = "";
		param += "tranNo="  + ds_stockMoveMst.NameValue(row,"tranNo");
		
		ds_stockMoveDtl.DataID = "po.is.retrieveStockMoveCancelDtl.gau?"+param;
		ds_stockMoveDtl.Reset();
	}

</script>

<script language=JavaScript for= materCd event=OnKeyDown(kcode)>
    if(kcode != 8 && kcode != 13 && kcode != 27 && kcode != 33 && kcode != 34 && kcode != 35 &&
        kcode != 36 && kcode != 37 && kcode != 38 && kcode != 39 && kcode != 40 && kcode != 45 &&
        kcode != 46 && kcode != undefined) {	
    		setTimeout("On_Apply()");
   		}
</script>
</head>

<body id="cent_bg" onload = "init()">

<div id="conts_box">
	<h2> <span> <%= columnData.getString("page_title") %></span></h2>


	<!--검색 S -->	
	 <fieldset class="boardSearch">
		<div>
			 <dl>
				<dt> 
					<table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board2" >
						<colgroup>
							<col width="17%"/>
							<col width="40%"/>
							<col width="18%"/>
							<col width=""/>
						</colgroup>
						<tr>
							<th><%= columnData.getString("issue_loc") %></th>
							<td>

								<object id="issueLoc"  classid="<%=LGauceId.LUXECOMBO%>" align="absmiddle" width="150">
								    <param name="ComboDataID"       value="ds_issuelocation">
									<param name="ListCount"     	value="10">
									<param name=SyncComboData       value="false">
									<param name="BindColumn"    	value="code">
								    <param name=ListExprFormat		value="name^0^150,code^0^70">
								    <param name=index           	value=0>
							   	</object>
							</td>										
							<th>Receipt Location</th>
							<td>
								<object id="receLoc"  classid="<%=LGauceId.LUXECOMBO%>" align="absmiddle" width="150">
								    <param name="ComboDataID"       value="ds_recelocation">
									<param name="ListCount"     	value="10">
									<param name=SyncComboData       value="false">
									<param name="BindColumn"    	value="code">
									<param name="WantSelChgEvent"   value="TRUE">
								    <param name=ListExprFormat		value="name^0^150,code^0^70">
								    <param name=index           	value=0>
							   	</object>
							</td>
						</tr>
						<tr>
							<th><%= columnData.getString("posting_date") %></th>
							<td>
								<input type="text" id="orderDateFrom" value="<%= prevDate %>" 	 onblur="valiDate(this);"  style="width:70px;"/>&nbsp;<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(orderDateFrom);" style="cursor:hand"/> ~ 
								<input type="text" id="orderDateTo"   value="<%= currentDate %>" onblur="valiDate(this);"  style="width:70px;"/>&nbsp;<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(orderDateTo);" style="cursor:hand"/>
							</td>
							<th><%= columnData.getString("status") %></th>
							<td>
								<object id="progStatus"  classid="<%=LGauceId.LUXECOMBO%>" align="absmiddle" width="150">
								    <param name="ComboDataID"       value="ds_status">
									<param name="ListCount"     	value="10">
									<param name=SyncComboData       value="false">
									<param name="BindColumn"    	value="code">
									<param name="WantSelChgEvent"   value="TRUE">
								    <param name=ListExprFormat		value="name^0^150,code^0^70">
								    <param name=index           	value=0>
							   	</object>
							</td>						</tr>
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
      

      	<!-- 그리드 E -->	
		<div class="sub_stitle"> <p><%= columnData.getString("sub1_title") %> </p> 
			<p class="rightbtn"> 
				<span class="excel_btn_r excel_btn_l">
           	 	<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="<%=btnExcelDown %>" onclick="javascript:f_excelDown();"/>
            	</span> 
			</p>	
		</div>      	
 		
		<!--<div style="width:760px; overflow:auto;height:170px;" >	-->
		<!-- 그리드 S -->	
		<div id="n_board_area">
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="100%"><comment id="__NSID__"><object id="gr_stockMoveMst" classid="<%=LGauceId.GRID%>" class="comn" width="100%"	height="180px" class="B_list">
				<param name="DataID" value="ds_stockMoveMst">
				<param name="RowHeight" 	value="20">
				<param name="Enable" 		value="TRUE">
				<param name="ColSizing" 	value="true">
				<param name="SortView" 		value="Left">
				<Param Name="ColSelect" 	value="true">
				<param name="Format"
					value='
	           			<C>id=seq         		name="<%=columnData.getString("seq") %>"        		Edit="none"		align="center"   	width="30"  Value={CurRow} </C>
			            <C>id="companyCd"   	name="<%=columnData.getString("company_cd") %>" 		Edit="none"		align="center"  	width="110"  show="false"</C> 
			            <C>id="tranNo"    		name="<%=columnData.getString("tran_no") %>"    		Edit="none"   	align="center"  	width="90"   show="true"</C>
			            <C>id="issueLocNm"  	name="<%=columnData.getString("issue_loc") %>" 	    	Edit="none"		align="left"  		width="110"  show="true"</C> 
			            <C>id="receLocNm"   	name="Receipt Location"	    	Edit="none"  	align="left"    	width="110"  show="true"</C>
			            <C>id="postingDate" 	name="<%=columnData.getString("posting_date") %>"   	Edit="none"   	align="center"  	width="90"   show="true" Mask="XXXX/XX/XX"</C>
			            <C>id="statusNm"    	name="<%=columnData.getString("status") %>"       		Edit="none"   	align="left"  		width="120"   show="true"</C>
			            <C>id="sapDocNo"    	name="<%=columnData.getString("sap_doc_no") %>"     	Edit="none"   	align="center"  	width="110"  show="true"</C>
			            <C>id="sapCancelDocNo"  name="<%=columnData.getString("sap_cancel_doc_no") %>"  Edit="none"   	align="center"  	width="120"  show="true"</C>
			            <C>id="sapRtnMsg"   	name="<%=columnData.getString("sap_rtn_msg") %>"    	Edit="none"   	align="left"  		width="400"   show="true"  BgColor={IF(sapRtnMsg="","White","Red")}</C>
   			            <C>id="requisitionStatusNm"    	name="<%=columnData.getString("requisition_status") %>"       	show="false"	Edit="none"   	align="left"  		width="110"   </C>
				'>
			     </object></comment> <script>__WS__(__NSID__);</script>
		        </td>
		       </tr>
       	  	 </table>  
  		 </div>
        <!-- 그리드 E -->

      	
      	<!-- 그리드 E -->	
		<div class="sub_stitle"> <p><%= columnData.getString("sub2_title") %> </p> </div>      	
 		
		<!--<div style="width:760px; overflow:auto;height:170px;" >	-->
		<!-- 그리드 S -->	
       <div id="n_board_area">
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="100%"><comment id="__NSID__"><object id="gr_stockMoveDtl" classid="<%=LGauceId.GRID%>" class="comn" width="100%"	height="140px" class="B_list">
				<param name="DataID" value="ds_stockMoveDtl">
				<param name="RowHeight" 	value="20">
				<param name="Enable" 		value="TRUE">
				<param name="ColSizing" 	value="true">
				<param name="SortView" 		value="Left">
				<Param Name="ColSelect" 	value="true">
				<param name="Editable" 		 value="true">
				<param name="Format"
					value='
	           			<C>id=seq         	name="<%=columnData.getString("seq") %>"        	Edit="none"		align="center"   	width="30"  Value={CurRow} </C>
			            <C>id="materCd"    	name="<%=columnData.getString("mater_cd") %>" 	    Edit="none"		align="center"  	width="110" </C> 
			            <C>id="materNm"     name="<%=columnData.getString("mater_nm") %>"	    Edit="none"  	align="left"    	width="220" Data="ds_mater:code:name:code" editstyle="lookup"</C>
			            <C>id="unit"    	name="<%=columnData.getString("unit") %>"    	    Edit="none"   	align="center"  	width="50" </C>
			            <C>id="requestMoveQty"    	name="<%=columnData.getString("request_move_qty") %>"       Edit="none"   	align="right"  		width="110" DisplayFormat ="#,###.000" </C>
			            <C>id="tranQty"    	name="<%=columnData.getString("receipt_qty") %>"       Edit="true"   	align="right"  		width="110"  DisplayFormat ="#,###.000" </C>
			            <C>id="returnQty"    	name="<%=columnData.getString("return_qty") %>"       Edit="none"   	align="right"  		width="110" DisplayFormat ="#,###.000" </C>
				'>
			     </object></comment> <script>__WS__(__NSID__);</script>
		        </td>
		       </tr>
       	  	 </table>  
  		 </div>
        <!-- 그리드 E -->

		<!-- </div>	 -->
		 <!-- 버튼 S -->	
          <div id="btn_area">
           	 <p class="b_right">
				
                <span class="btn_r btn_l"><input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnSave%>" onclick="javascript:f_save();"/></span> 
                <span class="btn_r btn_l"><input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnSapSend%>" onclick="javascript:f_sapSend();"/></span> 
                <span class="btn_r btn_l"><input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnSapCancel%>" onclick="javascript:f_sapCancel();"/></span> 
            </p>
        </div>
        <!-- 버튼 E -->	

    <div class="pad_t5"></div>
    
    <div name = "excelDown" style="width:0px;height:0px;">
    	<object id="gr_excelDown" classid="<%=LGauceId.GRID %>" style="width:100%;height:130px;" class="comn">
			<param Name="DataID" 			value="ds_excelDown">
			<Param Name="AutoResizing" 		value="true">
			<param name="ColSizing" 		value="true">
			<param name="ColSelect"  		value="true">
			<param Name="AddSelectRows" 	value="True">
			<Param NAME="Sort"              value="true">
			<Param Name="SortView" 			value="right">
			<Param NAME="TitleHeight"      	value="30">	
			<param name="UsingOneClick" 	value="1">
		    <param name=SuppressOption 	    value="1">
			<param Name="Editable" 			value="true">
	        
	        <param name=SubsumExpr			value="1:tranNo">
			<param Name="Format"
				value='
			            <C>id="companyCd"   	name="<%=columnData.getString("company_cd") %>" 		Edit="none"		suppress="1"	align="center"  	width="110"  show="false"</C> 
			            <C>id="tranNo"      	name="<%=columnData.getString("tran_no") %>"	    	Edit="none"  	suppress="1"	align="left"    	width="110"  show="false"</C>
			            <C>id="issueLocNm"  	name="<%=columnData.getString("issue_loc") %>" 	    	Edit="none"		suppress="1"	align="left"  		width="140"  show="true"</C> 
			            <C>id="receLocNm"   	name="<%=columnData.getString("rece_loc") %>"	    	Edit="none"  	suppress="1"	align="left"    	width="140"  show="true"</C>
			            <C>id="tranNo"    		name="<%=columnData.getString("tran_no") %>"    		Edit="none"   	suppress="1"	align="center"  	width="90"   show="true"</C>
			            <C>id="postingDate" 	name="<%=columnData.getString("posting_date") %>"   	Edit="none"   	suppress="1"	align="center"  	width="90"   show="true" Mask="XXXX/XX/XX"</C>
			            <C>id="sapDocNo"    	name="<%=columnData.getString("sap_doc_no") %>"     	Edit="none"   	suppress="1"	align="center"  	width="110"  show="true"</C>
			            <C>id="sapCancelDocNo"  name="<%=columnData.getString("sap_cancel_doc_no") %>"  Edit="none"   	suppress="1"	align="center"  	width="120"  show="true"</C>
			            <C>id="requisitionStatusNm"    	name="<%=columnData.getString("requisition_status") %>"       	suppress="1"	Edit="none"   		align="left" width="110"   show="true"</C>
			            <C>id="statusNm"    	name="<%=columnData.getString("status") %>"       		Edit="none"   	suppress="1"	align="left"  		width="130"   show="true"</C>
			            <C>id="sapRtnMsg"   	name="<%=columnData.getString("sap_rtn_msg") %>"    	Edit="none"   	suppress="1"	align="left"  		width="400"   show="true"  BgColor={IF(sapRtnMsg="","White","Red")}</C>

	           			<C>id=seq         		name="<%=columnData.getString("seq") %>"        		Edit="none"		align="center"   	width="30"   </C>
			            <C>id="materCd"    		name="<%=columnData.getString("mater_cd") %>" 	    	Edit="none"		align="center"  	width="110" </C> 
			            <C>id="materNm"     	name="<%=columnData.getString("mater_nm") %>"	    	Edit="none"  	align="left"    	width="220" Data="ds_mater:code:name:code" editstyle="lookup"</C>
			            <C>id="modelNm"     	name="<%=columnData.getString("model_nm") %>"	    	Edit="none"  	align="left"    	width="80" Data="ds_mater:code:name:code" editstyle="lookup"</C>
			            <C>id="unit"    		name="<%=columnData.getString("unit") %>"    	    	Edit="none"   	align="center"  	width="50" </C>
			            <C>id="requestMoveQty"  name="<%=columnData.getString("request_move_qty") %>"   Edit="none"   	align="right"  		width="110" DisplayFormat ="#,###.000"  </C>
			            <C>id="tranQty"    		name="<%=columnData.getString("receipt_qty") %>"        Edit="true"   	align="right"  		width="110"  DisplayFormat ="#,###.000" </C>
			            <C>id="returnQty"    	name="<%=columnData.getString("return_qty") %>"         Edit="none"   	align="right"  		width="110" DisplayFormat ="#,###.000"   </C>		     
		      '>
		</object>
    </div>
        	  
</div>
</body>
</html>
