<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%--
/*
 *************************************************************************
 * @source  : cementSalesMgt.jsp
 * @desc    : Cement 판매관리
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2016.08.02   hskim       신규작성
 * ---  -----------  ----------  -----------------------------------------
 * HCI 시스템
 * Copyright(c) 2006-2007 LG CNS,  All rights reserved.
 *************************************************************************
 */
--%>
<%@ page import="java.util.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="devon.core.util.*"%>
<%@ page import="comm.util.*"%>
<%@ include file="/include/head.jsp"%>
<%
	String prevDate = LDateUtils.getDate("yyyy/MM/") + "01"; //조회시작 default 날짜
	String currentDate = LDateUtils.getDate("yyyy/MM/dd"); //조회조건 현재 날짜

	String msgInfoChange = source.getMessage("dev.inf.com.nochange"); // no data for change.
	String msgSave = source.getMessage("dev.cfm.com.save"); // Are you sure to save?
	String msgDelete = source.getMessage("dev.cfm.com.delete"); // Are you sure to Delete?
	String msgCancel = source.getMessage("dev.cfm.com.cancel"); // Are you sure to Continue?
	String msgContinue = source.getMessage("dev.cfm.com.continue"); // Are you sure to Continue?
	String msgApproval = source.getMessage("dev.cfm.com.approval"); // Are you sure to approval?
	String msgConfirm = source.getMessage("dev.cfm.com.confirm"); // Are you sure to confirm?
	String msgSAPsend = source.getMessage("dev.msg.po.sapsend"); // Are you sure to confirm?
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title>PIT PAM System</title>
<head>
<script language="javascript">
var g_flug =false; // Detail작업 flag
var g_msPos = 0;   // save후  focus 제정의 Row
var g_ddtPos = 0;  // save후  focus 제정의 Row
/***************************************************************************************************/
/*초기 세팅
/***************************************************************************************************/
function onLoad(){
	ds_status.DataID ="cm.cm.retrieveCommCodeCombo.gau?groupCd=2319&firstVal=Select";
	ds_status.Reset();	  
	ds_currCd.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2004";
	ds_currCd.Reset();		
	ds_currCd.RowPosition = ds_currCd.NameValueRow("code","IDR");
	ds_vatCd.DataId="sd.sm.retrieveSalesMgmtVatACombo.gau?groupCd=2007";
	ds_vatCd.Reset();	 	
	ds_payTerm.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2206";
	ds_payTerm.Reset();
	ds_payTerm.RowPosition = ds_payTerm.NameValueRow("code","PD03");
	ds_storCd.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2005";
	ds_storCd.Reset();		
	//costomer
	ds_vendor.DataID ="cm.cm.retrieveCommComboVendorList.gau";
	ds_vendor.Reset();
	
	cfUnionBlank(ds_vendor,lc_vendor,"code","name","--Total--");
	
}

/***************************************************************************************************/
/*추가/및 삭제
/***************************************************************************************************/
// Main Add
function f_addRowMain(){ 
	if(ds_main.IsUpdated || ds_detail.IsUpdated){
		if(!g_flug){
			alert("<%=source.getMessage("dev.warn.com.continue")%>");
			return;
		}
	}
 
	if(ds_main.CountRow<1){
		var strHeader =  "chk"               +   ":STRING(1)"
									+",salesNo"        +   ":STRING(13)"
									+",customer"             +   ":STRING(100)"
									+",customerCd"              +   ":STRING(50)"
									+",salesDate"         +   ":STRING(10)"
									+",grandTotalQty"+   ":DECIMAL(13.3)"
									+",currencyCd"       +   ":STRING(20)"
									+",grandTotalAmt"      +   ":DECIMAL(13.2)"
									+",payTerm"		+ ":STRING(4)"
									+",statusNm"		+ ":STRING(30)"
									+",status"          +   ":STRING(2)"
									+",sapSeq"  	+   ":STRING(6)"
									+",groupCd"          +   ":STRING(3)"
									+",sapRtnMsg"		+  ":STRING(300)"
									+",transDate"         +   ":STRING(10)"
									;
		ds_main.SetDataHeader(strHeader);
    	cfHideNoDataMsg(gr_main);		
	}
	ds_main.AddRow(); 
	ds_main.NameValue(ds_main.RowPosition,"currencyCd") = "IDR";
	ds_main.NameValue(ds_main.RowPosition,"payTerm") ="PD03";
}

//Detail Add
function f_addRowDetail(){
	if(ds_main.NameValue(ds_main.RowPosition,"status")!=""){
		alert("Add only When the status is Sales Confirm!");
		return;
	}
	if(ds_main.CountRow>0){
		if(ds_detail.CountRow<1){
			var strHeader =  "materCd"          +    ":STRING(18)"
							+",materNm"          +    ":STRING(50)"
							+",unit"            +    ":STRING(3)"
							+",storLoct"           +    ":STRING(4)"
							+",currentQty"              +    ":DECIMAL(13.3)"
							+",salesQty"              +    ":DECIMAL(13.3)"
							+",unitPrice"            +    ":DECIMAL(13.2)"
							+",salesAmt"           +    ":DECIMAL(13)"
							+",vatCd"            +    ":STRING(20)" 
							+",vatAmt"           +    ":DECIMAL(13)"
							+",totalAmt"           +    ":DECIMAL(13)"
							+",salesNo"        +   ":STRING(13)"
							+",salesDate"         +   ":STRING(10)"
							+",salesItemSeq"         +   ":STRING(6)"
							;

			ds_detail.SetDataHeader(strHeader);
		}		 
		ds_detail.AddRow();  
		ds_detail.NameValue(ds_detail.RowPosition,"materCd"      )="";  
		ds_detail.NameValue(ds_detail.RowPosition,"unit"      )="";  
		ds_detail.NameValue(ds_detail.RowPosition,"unitPrice"         )="0";
		ds_detail.NameValue(ds_detail.RowPosition,"vatCd"        )="A0";
		ds_detail.NameValue(ds_detail.RowPosition,"salesNo")  = "";
		ds_detail.NameValue(ds_detail.RowPosition,"salesDate" )  = "";
	}
}

//Detail Del
function f_delRowDetail(){
	if(ds_detail.CountRow==1){
		alert("<%=source.getMessage("dev.msg.po.itemchk")%>");
	} 
	if(ds_detail.CountRow>1){
		ds_detail.DeleteRow(ds_detail.RowPosition);
		var sumTotalQty = 0;
	    for ( var i = 1; i <= ds_detail.CountRow; i++) {
			sumTotalQty = sumTotalQty + ds_detail.NameValue(i,"salesQty");
	    }
	    grandTotalQty.Text = sumTotalQty;
		var sumTotalAmt = 0;
	    for ( var i = 1; i <= ds_detail.CountRow; i++) {
			sumTotalAmt = sumTotalAmt + ds_detail.NameValue(i,"totalAmt");
	    }
	    grandTotalAmt.Text = sumTotalAmt;
	}
	 f_setCondition(); 
}

// Reflush이후  Row  원복
function f_setCondition(){
    g_msPos = ds_main.RowPosition;
    g_ddtPos = ds_detail.RowPosition;		
} 

/***************************************************************************************************/
/*버튼 클릭시
/***************************************************************************************************/
//Search 버튼 클릭
function f_retrieve(){
	ds_main.ClearAll();
	ds_detail.ClearAll();
	ds_main.DataID  = "/sd.sm.retrieveCementSalesConfirm.gau?";
//    ds_main.DataID += "saleNo=" 		   + document.getElementById("saleNo").value;
    ds_main.DataID += "vendorCd=" 		   + ds_vendor.NameValue(ds_vendor.RowPosition,"code");
    ds_main.DataID += "&salesDateFrom="   + encodeURIComponent(salesDateFrom.value);
    ds_main.DataID += "&salesDateTo=" + encodeURIComponent(salesDateTo.value);
	ds_main.DataID += "&status=" 		   + ds_status.nameValue(ds_status.rowPosition,"code");
 	ds_main.DataID += "&lang="			   +"<%=g_lang%>";	
	ds_main.Reset();
	g_flug = false;
}
//save 버튼 클릭
function f_save(){
	var chkCountNo=0;
	if(!ds_main.IsUpdated && !ds_detail.IsUpdated) {
		alert("<%=msgInfoChange%>" );
		return;
	
	}else{	
	for(var inx=1; inx<=ds_main.CountRow;inx++){ 
  		if(ds_main.NameValue(inx,"chk")=="T"){
  			chkCountNo++;
  		}
  	}	
 	if(chkCountNo>1){
			alert("Select only one Sales List!");
			return;
	}
	if(f_isNull(ds_main.NameValue(ds_main.RowPosition,"status")) || ds_main.NameValue(ds_main.RowPosition,"status") == "9"){
		if(f_vali()){
			if(confirm("<%=msgSave%>")){
				g_msPos = ds_main.RowPosition;
				g_ddtPos = ds_detail.RowPosition;		
				g_flug=true;
				tr_cudMaster.KeyValue = "Servlet( I:IN_DS1 = ds_main, I:IN_DS2 = ds_detail )";
				tr_cudMaster.Action   = "/sd.sf.cudCementSalesConfirm.gau?";
				tr_cudMaster.post();
			}
		}
	}else{
		alert("You can save, when the status is SAP Confirm Or Error!");
		return;
	}
  }
}

//Delele
function f_delete(){
	var chkCountNo=0;
	if(ds_main.CountRow<1){
		alert("<%=source.getMessage("dev.inf.com.nodelete")%>");
		return;
	}
	for(var inx=1; inx<=ds_main.CountRow;inx++){ 
  		if(ds_main.NameValue(inx,"chk")=="T"){
  			chkCountNo++;
  		}
  	}	
 	if(chkCountNo>1){
		alert("Select only one Sales List!");
		return;
	}
	if(f_isNull(ds_main.NameValue(ds_main.RowPosition,"status")) || ds_main.NameValue(ds_main.RowPosition,"status") == "9"){
		if(confirm("<%=source.getMessage("dev.cfm.com.delete")%>")){
			if(ds_detail.RowPosition>0)	{
				ds_detail.DeleteAll();
			}	
			if(ds_main.RowPosition>0)	{
				ds_main.DeleteRow(ds_main.RowPosition);
			}
		    g_flug=true;
			tr_dMaster.KeyValue = "Servlet( I:IN_DS1 = ds_main, I:IN_DS2 = ds_detail )";
			tr_dMaster.Action   = "/sd.sm.cudCementSalesMgnt.gau?";
			tr_dMaster.post();
		}
	}else{
		alert("You can delete, when the status is SAP Confirm Or Error!");
		return;
	}
}

//-------------------------------------------------------------------------
// SAP send (SAP Send 클릭시)
//-------------------------------------------------------------------------	 
 function f_sapSend(){
 
  var chkCountNo=0;
  var chkStatus =0;
  for(var inx=1; inx<=ds_main.CountRow;inx++){ 
  		if(ds_main.NameValue(inx,"chk")=="T"){
  			chkCountNo++;
  		}
  	}	
  	//checkbox체크안된경우
  	if(	chkCountNo <1){
	  		alert("<%=source.getMessage("dev.msg.fi.selectOne")%>" );return false;	  
 	 
 	 //checkbox체크시
 	 }else{ 
		for(var k=1; k<=ds_main.CountRow;k++){ 
	  		 if(ds_main.NameValue(k,"chk")=="T"){	
	  		  	if(ds_main.NameValue(k,"status") == undefined){
	 				alert("Check the Status of  "+ k + " row! \n Save the sales Item." );
	 				return false;
	  		  	}
	  		  	if(ds_main.NameValue(k,"status") == "6"){
	 				alert("Check the Status of  "+ k + " row! \n The status is Billing Confirm!" );
	 				return false;
	  		  	}
	  		  	if(ds_main.NameValue(k,"status") == "8"){
	 				alert("Check the Status of  "+ k + " row! \n The status is Error." );
	 				return false;
	  		  	}
	  	 	 }
  		} 
		for(var j=1; j<=ds_main.CountRow;j++){ 
		  	if(ds_main.NameValue(j,"chk")=="T"){
			  	ds_main.NameValue(j,"salesDate") = funcReplaceStrAll(ds_main.NameValue(j,"salesDate"),"/","");
			}
		}
 	 		if(confirm("<%=msgSAPsend%>")){
					tr_sendMaster.Action   = "/sd.sf.cudCementSalesSapSend.gau";
					tr_sendMaster.KeyValue	= "Servlet( I:IN_DS1 = ds_main )";
			 		tr_sendMaster.Post();
		 	}	
 	 }
}

//-------------------------------------------------------------------------
// SAP Cancel (SAP Cancel 클릭시)
//-------------------------------------------------------------------------	 
 function f_sapCancel(){
  var chkCountNo=0;
  for(var i=1; i<=ds_main.CountRow;i++){ 
  		if(ds_main.NameValue(i,"chk")=="T"){
  			chkCountNo++;
  		}
  }	
  if(chkCountNo <1){
	  		alert("<%=source.getMessage("dev.msg.fi.selectOne")%>" );return false;	  
  }
  	
  for(var j=1; j<=ds_main.CountRow;j++){ 
 		if(ds_main.NameValue(j,"chk")=="T"){
			if(f_isNull(ds_main.NameValue(j,"status")) || ds_main.NameValue(j,"status") == "8" || ds_main.NameValue(j,"status") == "9"){
 				alert("Check the Status of  "+ j + " row!, \nYou can cancel, when the status is SAP Confirm Or Error!" );
				return false;
			}
 		}
	}
	for(var j=1; j<=ds_main.CountRow;j++){
		 if(ds_main.NameValue(j,"chk")=="T"){
			  ds_main.NameValue(j,"salesDate") = funcReplaceStrAll(ds_main.NameValue(j,"salesDate"),"/","");
		}
	}
	if(confirm("<%=msgCancel%>")){
		tr_sapCandMaster.KeyValue	= "Servlet( I:IN_DS1 = ds_main )";
		tr_sapCandMaster.Action   = "/sd.sf.cudCementSalesSapCancel.gau";
		tr_sapCandMaster.Post();
	}
}

//고객 조회 팝업
function f_openCustomer(){
	/*
	if(ds_main.NameValue(ds_main.RowPosition, "salesNo") != ""){
		alert("Can not change the Sales Date, \nBecause The Sales NO. was created!");
		return;
	}
	*/
	openVendorCodeListWin();
}

//고객 조회 팝업
function f_openDelivery(){
	/*
	if(ds_main.NameValue(ds_main.RowPosition, "salesNo") != ""){
		alert("Can not change the Sales Date, \nBecause The Sales NO. was created!");
		return;
	}
	*/
	openDeliveryCodeListWin();
}

// Vendor Popup
function openVendorCodeListWin() {

    var result = "";
    var firstList = new Array ();

    var popupId             = "CustomerCodeList";
    var popupStr            = "/jsp/cm/cd/pop_" + popupId + ".jsp";

    var vendCd              = "?vendCd="            + document.all.vendCd.value;
//    var tgOneSelect         = "&tgOneSelect="       + "T";                      // 한 건인 경우 자동선택
    var popType             = "&popType="           + "ptpam_" + popupId;
    var popupWidth          = "dialogWidth="        + "542px";
    var popupHeight         = ";dialogHeight="      + "400px";

    result = window.showModalDialog( popupStr + vendCd + popType, popupId, popupWidth + popupHeight );
    
    if (result == -1 || result == null || result == "") {
        document.all.vendCd.value = "";  // 초기화
        document.all.vendNm.value = "";  // 초기화
        return;
    } else {
	    firstList = result.split(";");
    	document.all.vendCd.value = firstList[0];
        document.all.vendNm.value = firstList[1];
    }

}

//Delivery Popup
function openDeliveryCodeListWin() {

    var result = "";
    var firstList = new Array ();

    var popupId             = "CustomerCodeList";
    var popupStr            = "/jsp/cm/cd/pop_" + popupId + ".jsp";

    var vendCd              = "?vendCd="            + document.all.deliveryCd.value;
//    var tgOneSelect         = "&tgOneSelect="       + "T";                      // 한 건인 경우 자동선택
    var popType             = "&popType="           + "ptpam_" + popupId;
    var popupWidth          = "dialogWidth="        + "542px";
    var popupHeight         = ";dialogHeight="      + "400px";

    result = window.showModalDialog( popupStr + vendCd + popType, popupId, popupWidth + popupHeight );
    
    if (result == -1 || result == null || result == "") {
        document.all.deliveryCd.value = "";  // 초기화
        document.all.deliveryNm.value = "";  // 초기화
        return;
    } else {
	    firstList = result.split(";");
    	document.all.deliveryCd.value = firstList[0];
        document.all.deliveryNm.value = firstList[1];
    }

}

// Grid Material Popup
function openCementMaterialCodeListPopUp(row, obj,type) {
    var result = "";
    var firstList = new Array ();

	if(f_isNull(document.all.salesDate.value)){
		alert("Please, Select Sales Date!");
		return false;
	}
    var popupId             = "CementMaterialCodeList";
    var popupStr            = "/jsp/cm/cd/pop_" + popupId + ".jsp" +  "?salesDate="           + funcReplaceStrAll(document.all.salesDate.value,"/","");
    
//    var tgOneSelect         = "&tgOneSelect="       + "T";                      // 한 건인 경우 자동선택
    var popupWidth          = "dialogWidth="        + "542px";
    var popupHeight         = ";dialogHeight="      + "450px";

    result = window.showModalDialog( popupStr , popupId, popupWidth + popupHeight );
//    result = window.open( popupStr , popupId, popupWidth + popupHeight );
    if (result == -1 || result == null || result == "") {
    	obj.NameValue(row,"materCd") = "";
        obj.NameValue(row,"materNm") = "";
        obj.NameValue(row,"currentQty") = "0";
        obj.NameValue(row,"unit") = "";
        obj.NameValue(row,"storLoct") = "";
       	obj.NameValue(row,"vatCd") = "A1";
        obj.NameValue(row,"unitPrice") = "";
	} else {
         firstList = result.split(";");
        obj.NameValue(row,"materCd") = firstList[0];
        obj.NameValue(row,"materNm") = firstList[1];
        obj.NameValue(row,"storLoct") =  firstList[2];
        obj.NameValue(row,"currentQty") = firstList[3];
        obj.NameValue(row,"unit") = firstList[4];
        if(firstList[5] == "7920"){
        	obj.NameValue(row,"vatCd") = "A1";
        }else{
        	obj.NameValue(row,"vatCd") = "A0";
        }
        obj.NameValue(row,"unitPrice") = firstList[6];
    }
}      

//Save validation Check
function f_vali(){
	var val_flag = true;

	//ds_main validation
	if( f_isNull(ds_main.NameValue( ds_main.rowPosition , "customer" ))){
		alert("<%=source.getMessage("dev.warn.com.input",columnData.getString("customer"))%>");
		return false;
	}
	if( f_isNull(ds_main.NameValue( ds_main.rowPosition , "customerCd" ))){
		alert("<%=source.getMessage("dev.warn.com.input",columnData.getString("customer"))%>");
		return false;
	}
	if( f_isNull(ds_main.NameValue( ds_main.rowPosition , "payTerm" ))){
		alert("<%=source.getMessage("dev.warn.com.input",columnData.getString("terms_of_payment"))%>");
		return false;
	}
	if( f_isNull(ds_main.NameValue( ds_main.rowPosition , "salesDate" ))){
		alert("<%=source.getMessage("dev.warn.com.input",columnData.getString("sales_date"))%>");
		return false;
	}
	if( f_isNull(ds_main.NameValue(ds_main.RowPosition,"grandTotalQty"))){
		alert("<%=source.getMessage("dev.warn.com.input",columnData.getString("grand_total_qty"))%>");
		return false;
	}
	if( f_isNull(ds_main.NameValue(ds_main.RowPosition,"currencyCd"))){
		alert("<%=source.getMessage("dev.warn.com.input",columnData.getString("currency"))%>");
		return false;
	}
	if( f_isNull(ds_main.NameValue(ds_main.RowPosition,"grandTotalAmt"))){
		alert("<%=source.getMessage("dev.warn.com.input",columnData.getString("grand_total_amount"))%>");
		return false;
	}

	//ds_detail validation
	for ( var i = 1; i <= ds_detail.CountRow; i++) {
		if( f_isNull(ds_detail.NameValue( i , "materNm" ))){
			alert("<%=source.getMessage("dev.warn.com.input",columnData.getString("material_name"))%>");
			return false;
		}
		if( f_isNull(ds_detail.NameValue( i , "materCd" ))){
			alert("<%=source.getMessage("dev.warn.com.input",columnData.getString("material_name"))%>");
			return false;
		}
		if( f_isNull(ds_detail.NameValue( i , "currentQty" ))){
			alert("<%=source.getMessage("dev.warn.com.input",columnData.getString("current_qty"))%>");
			return false;
		}
		if( f_isNull(ds_detail.NameValue( i , "salesQty" ))){
			alert("<%=source.getMessage("dev.warn.com.input",columnData.getString("sales_qty"))%>");
			return false;
		}
		if( f_isNull(ds_detail.NameValue( i , "unitPrice" ))){
			alert("<%=source.getMessage("dev.warn.com.input",columnData.getString("unit_price"))%>");
			return false;
		}
		if( f_isNull(ds_detail.NameValue( i , "salesAmt" ))){
			alert("<%=source.getMessage("dev.warn.com.input",columnData.getString("sales_amount"))%>");
			return false;
		}
		if( f_isNull(ds_detail.NameValue( i , "vatCd" ))){
			alert("<%=source.getMessage("dev.warn.com.input",columnData.getString("vat_cd"))%>");
			return false;
		}
		if( f_isNull(ds_detail.NameValue( i , "totalAmt" ))){
			alert("<%=source.getMessage("dev.warn.com.input",columnData.getString("total_amount"))%>");
			return false;
		}
	}

 	return val_flag;	
}

//해당 문자열이 널인지 점검
function f_isNull( asValue ) {
   	if (asValue == null || asValue == undefined || asValue.toString().replace(/ /g,"") == "" || asValue == 0 ) {
      	 return  true;
   	}
  	return false;
}

//선택한 RowPosition이 Sales No. 생성된 경우 Sales Date 변경 못 하게 체크
function f_isSalesNoExist() {
	/*
	if(ds_main.NameValue(ds_main.RowPosition, "salesNo") != ""){
		alert("Can not change the Sales Date, \nBecause The Sales NO. was created!");
		return;
	}
	*/
	OpenCalendar(salesDate);
}

//-------------------------------------------------------------------------
//Status가 PROCESS(00)인 경우에만 입력 enable처리.
//-------------------------------------------------------------------------
function f_Enable(){
	document.getElementById("salesDate").readOnly = false;
	salesDateIcon.disabled          = false;
	document.all.salesDateIcon.src = "<%= images %>button/cal_icon.gif";	
}

//-------------------------------------------------------------------------
//Status가 PROCESS(00)이 아니면 입력 Disable
//-------------------------------------------------------------------------
function f_Disable() {
	document.getElementById("salesDate").readOnly = true;
	salesDateIcon.disabled          = true;
	document.all.salesDateIcon.src = "<%= images %>button/cal_icon2.gif";	
}


</script>

<!-----------------------------------------------------------------------------
  프로그램 전용 D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- Grid 용 DataSet-->
<object id="ds_main" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad" value="true">
	<param name="ViewDeletedRow" value="false">
</object>

<!-- Grid 용 DataSet-->
<object id="ds_detail" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad" value="true">
	<param name="ViewDeletedRow" value="false">
</object>

<object id="ds_status" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad" value="true">
</object>
</comment>

<!-- lx Combo 용 DataSet-->
<object id="ds_currCd" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad" value="true">
</object>

<!-- lx Combo 용 DataSet-->
<object id="ds_storCd" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad" value="true">
</object>

<object id="ds_vatCd" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad" value="true">
</object>

<!-- lx Combo 용 DataSet-->
<object id="ds_payTerm" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad" value="true">
</object>

<!-- CUD TR -->
<OBJECT id=tr_cudMaster classid="<%=LGauceId.TR%>">
	<param name="KeyName" value="toinb_dataid4">
</OBJECT>
<!-- Delete TR -->
<OBJECT id=tr_dMaster classid="<%=LGauceId.TR%>">
	<param name="KeyName" value="toinb_dataid4">
</OBJECT>

<!-- sap send TR -->
<OBJECT id=tr_sendMaster classid="<%=LGauceId.TR%>">
	<param name="KeyName" value="toinb_dataid4">
</OBJECT>

<!-- sap send TR -->
<OBJECT id=tr_sapCandMaster classid="<%=LGauceId.TR%>">
	<param name="KeyName" value="toinb_dataid4">
</OBJECT>

<!-- costomer Combo 용 DataSet-->
<object id="ds_vendor" classid="<%=LGauceId.DATASET%>" >
  	<param name="SyncLoad"          value="true">
</object> 

<!-----------------------------------------------------------------------------
		   프로그램 전용 G A U C E   C O M P O N E N T' S   E V E N T S
------------------------------------------------------------------------------>
<!-- INSERT/UPDATE Tr 의 트렌젝션 실행 시 -->
<script language=JavaScript for=tr_cudMaster event=OnFail()>
    mode = "";
    if(tr_cudMaster.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
        window.parent.location.href = "/index.jsp";    
    }
    if(tr_cudMaster.ErrorMsg.lastIndexOf("]") != -1) {
      var msgs= tr_cudMaster.ErrorMsg.substring(tr_cudMaster.ErrorMsg.lastIndexOf("]")+2,tr_cudMaster.ErrorMsg.length);
      alert(msgs);
      }  
</script>

<!-- SAP SEND Tr 의 트렌젝션 실행 시 -->
<script language=JavaScript for=tr_sendMaster event=OnFail()>
	    mode = "";
	    if(tr_sendMaster.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
	        window.parent.location.href = "/index.jsp";    
	    }
	    if(tr_sendMaster.ErrorMsg.lastIndexOf("]") != -1) {
      var msgs= tr_sendMaster.ErrorMsg.substring(tr_sendMaster.ErrorMsg.lastIndexOf("]")+2,tr_sendMaster.ErrorMsg.length);
      alert(msgs);
      } 
     f_retrieve();
</script>
<script language=JavaScript for=tr_sendMaster event=OnSuccess()>	
		f_retrieve();
		alert("<%=source.getMessage("dev.suc.com.sapSend")%>" );		
	    
</script>

<!-- SAP Cancle Tr 의 트렌젝션 실행 시 -->
<script language=JavaScript for=tr_sapCandMaster event=OnFail()>
	    mode = "";
	    if(tr_sapCandMaster.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
	        window.parent.location.href = "/index.jsp";    
	    }
	    alert(tr_sapCandMaster.ErrorMsg);
     f_retrieve();
</script>
<script language=JavaScript for=tr_sapCandMaster event=OnSuccess()>	
        f_retrieve();
		alert("<%=source.getMessage("dev.suc.com.sapCancel")%>" );		
</script>

<script language=JavaScript for=tr_cudMaster event=OnSuccess()>	
     f_retrieve();
     ds_main.RowPosition = g_msPos;
     ds_detail.RowPosition= g_ddtPos;		
	 alert("<%=source.getMessage("dev.suc.com.save")%>" );		
</script>

<!-- DELETE Tr 의 트렌젝션 실행 시 -->
<script language=JavaScript for=tr_dMaster event=OnFail()>
    mode = "";
    if(tr_dMaster.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
        window.parent.location.href = "/index.jsp";    
    }
    alert(tr_dMaster.ErrorMsg);
</script>
<script language=JavaScript for=tr_dMaster event=OnSuccess()>	       
     f_retrieve();
     if(ds_main.CountRow >0){ 
        ds_main.RowPosition = 1;
        ds_detail.RowPosition= 1;	
     }	
	alert("<%=source.getMessage("dev.suc.com.delete")%>" );
</script>

<!--grid DataSet -->
<script language=JavaScript for=ds_main event=OnLoadCompleted(rowCnt)>
	  cfHideDSWaitMsg(gr_main);//progress bar 숨기기
	  cfFillGridNoDataMsg(gr_main,"gridColLineCnt=2");//no data found   
	  mode = "";
	  
	  f_Disable();
</script>
<script language=JavaScript for=ds_main event=OnLoadStarted()>
	  cfShowDSWaitMsg(gr_main);//progress bar 보이기
	  cfHideNoDataMsg(gr_main);//no data 메시지 숨기기
	  mode = "";
</script>

<script language=JavaScript for="ds_main" event=OnRowPosChanged(row)>
 	var salesNo = ds_main.NameValue(row,"salesNo");
	if(row>0 && salesNo != "" ){
		ds_detail.DataID     = "/sd.sm.retrieveCementDetailSalesMgnt.gau?";
		ds_detail.DataID    += "salesDate="+funcReplaceStrAll(ds_main.NameValue(row,"salesDate"),"/","");
		ds_detail.DataID    += "&salesNo="+salesNo;
		ds_detail.DataID    += "&lang= "+"<%=g_lang%>";
		ds_detail.Reset();
		grandTotalQty.Text = ds_main.NameValue(ds_main.RowPosition,"grandTotalQty");
		grandTotalAmt.Text = ds_main.NameValue(ds_main.RowPosition,"grandTotalAmt");
		termsOfPayment.Enable = false;
		currCd.Enable = false;
		gr_detail.ColumnProp("salesQty", "Edit") = "none";
		gr_detail.ColumnProp("unitPrice", "Edit") = "none";
		gr_detail.ColumnProp("salesAmt", "Edit") = "none";
		
		
		
	}else if(row>0 && salesNo == "" ){
		ds_detail.ClearAll();
		f_addRowDetail();
		grandTotalQty.Text = 0;
		grandTotalAmt.Text = 0;
		termsOfPayment.Enable = false;
		currCd.Enable = false;
		gr_detail.ColumnProp("salesAmt", "Edit") = true;
		gr_detail.ColumnProp("unitPrice", "Edit") = true;
		gr_detail.ColumnProp("salesQty", "Edit") = true;

	}
	g_flug = false;
</script>

<script language=JavaScript for=ds_main event=CanRowPosChange(row)> 
	if(ds_detail.IsUpdated){
		if(!g_flug){	
			alert("<%=source.getMessage("dev.warn.com.continue")%>");
			return false;
		}
	}				
</script>

<!-----------------------------------------------------------------------------
  전체 체크박스 선택/해제
------------------------------------------------------------------------------>
<script language=JavaScript for=gr_main event=OnHeadCheckClick(Col,Colid,bCheck)>
	if(bCheck == "0"){//uncheck
		for(var i=1; i <= ds_main.countRow; i++){
			ds_main.Namevalue(i,"chk") = "F";
			ds_main.resetStatus();
		}
	}else{//check
		for(var i=1; i <= ds_main.countRow; i++){
			ds_main.NameValue(i,"chk") = "T";	
		}
	}
</script>	

<script language="JavaScript" for="gr_detail" event="OnPopup(row,colid,data)">
 	if ( colid == "materNm") {
 		openCementMaterialCodeListPopUp(row, ds_detail,"");
	}
</script>
<script language="javascript" for="ds_detail" event="OnColumnChanged(row,colid)">

  	if ( colid == "salesQty") {
  		if( ds_detail.NameValue(row,"salesQty") > ds_detail.NameValue(row,"currentQty")){
  			alert("You can not register Sales Qty Than Cunrrent Qty!");
  			ds_detail.NameValue(row,"salesQty") = "0";
  		}
		ds_detail.NameValue(row,"salesAmt") = Math.round(ds_detail.NameValue(row,"salesQty") * ds_detail.NameValue(row,"unitPrice"));
		var sumTotalQty = 0;
	    for ( var i = 1; i <= ds_detail.CountRow; i++) {
			sumTotalQty = sumTotalQty + ds_detail.NameValue(i,"salesQty");
	    }
	    grandTotalQty.Text = sumTotalQty;
	    ds_main.NameValue(ds_main.RowPosition,"grandTotalQty") = grandTotalQty.Text;
  	    if(ds_detail.NameValue(row,"vatCd") == "A0"){
			ds_detail.NameValue(row,"vatAmt") = Math.round(ds_detail.NameValue(row,"salesAmt") * 0);
		}else if(ds_detail.NameValue(row,"vatCd") == "A1"){
			ds_detail.NameValue(row,"vatAmt") = Math.round(ds_detail.NameValue(row,"salesAmt") * 0.1);
		}else{
			ds_detail.NameValue(row,"vatAmt") = Math.round(ds_detail.NameValue(row,"salesAmt") * 0);
		}
		ds_detail.NameValue(row,"totalAmt") = Math.round(ds_detail.NameValue(row,"salesAmt")) + Math.round(ds_detail.NameValue(row,"vatAmt"));
	}
  	if ( colid == "unitPrice") {
		ds_detail.NameValue(row,"salesAmt") = Math.round(ds_detail.NameValue(row,"salesQty") * ds_detail.NameValue(row,"unitPrice"));
  	    if(ds_detail.NameValue(row,"vatCd") == "A0"){
			ds_detail.NameValue(row,"vatAmt") = Math.round(ds_detail.NameValue(row,"salesAmt")) * 0;
		}else if(ds_detail.NameValue(row,"vatCd") == "A1"){
			ds_detail.NameValue(row,"vatAmt") = Math.round(ds_detail.NameValue(row,"salesAmt")) * 0.1;
		}else{
			ds_detail.NameValue(row,"vatAmt") = Math.round(ds_detail.NameValue(row,"salesAmt")) * 0;
		}
		ds_detail.NameValue(row,"totalAmt") = Math.round(ds_detail.NameValue(row,"salesAmt") + ds_detail.NameValue(row,"vatAmt"));
	}
  	if ( colid == "vatCd") {
  	    if(ds_detail.NameValue(row,"vatCd") == "A0"){
			ds_detail.NameValue(row,"vatAmt") = Math.round(ds_detail.NameValue(row,"salesAmt")) * 0;
		}else if(ds_detail.NameValue(row,"vatCd") == "A1"){
			ds_detail.NameValue(row,"vatAmt") = Math.round(ds_detail.NameValue(row,"salesAmt")) * 0.1;
		}else{
			ds_detail.NameValue(row,"vatAmt") = Math.round(ds_detail.NameValue(row,"salesAmt")) * 0;
		}
		ds_detail.NameValue(row,"totalAmt") = Math.round(ds_detail.NameValue(row,"salesAmt")) + Math.round(ds_detail.NameValue(row,"vatAmt"));
	}
  	if ( colid == "salesAmt") {
  	    if(ds_detail.NameValue(row,"vatCd") == "A0"){
			ds_detail.NameValue(row,"vatAmt") = Math.round(ds_detail.NameValue(row,"salesAmt")) * 0;
		}else if(ds_detail.NameValue(row,"vatCd") == "A1"){
			ds_detail.NameValue(row,"vatAmt") = Math.round(ds_detail.NameValue(row,"salesAmt")) * 0.1;
		}else{
			ds_detail.NameValue(row,"vatAmt") = Math.round(ds_detail.NameValue(row,"salesAmt")) * 0;
		}
  	
		ds_detail.NameValue(row,"totalAmt") = Math.round(ds_detail.NameValue(row,"salesAmt")) + Math.round(ds_detail.NameValue(row,"vatAmt"));
	}

  	if ( colid == "totalAmt") {
		var sumTotalAmt = 0;
	    for ( var i = 1; i <= ds_detail.CountRow; i++) {
			sumTotalAmt = sumTotalAmt + Math.round(ds_detail.NameValue(i,"totalAmt"));
	    }
	    grandTotalAmt.Text= Math.round(sumTotalAmt);
	    ds_main.NameValue(ds_main.RowPosition,"grandTotalAmt") = grandTotalAmt.Text;
	}
</script>


<!-----------------------------------------------------------------------------
    화면영역 시작
------------------------------------------------------------------------------>
</head>

<body id="cent_bg" onload="onLoad()">
<div id="conts_box">
<h2><span> Sales Confirm </span></h2>
<!--검색 S -->
<fieldset class="boardSearch">
<div>
<dl>
	<dt>
	<table width="100%" border="0" cellpadding="0" cellspacing="0"	class="output_board2" >
	<colgroup>
		<col width="14%"/>
		<col width="20%"/>
		<col width="15%"/>
		<col width="38%"/>
		<col width="11%"/>
		<col width="20%"/>
	</colgroup>
	<tr>
		<th><%=columnData.getString("customer") %></th>
		<td><object id="lc_vendor"  classid="<%=LGauceId.LUXECOMBO%>" width="100">
		<param name="ComboDataID"       value="ds_vendor">
		<param name="ListCount"     	value="10">
		<param name=SearchColumn		value="name">
		<param name="BindColumn"    	value="code">
		<param name=ListExprFormat		value="name^0^210,code^0^70">
		<param name=index           	value=0>
		</object>
		</td>	
		<th><%=columnData.getString("sales_date")%></th>
		<td><input type="text" id="salesDateFrom" name="salesDateFrom" value="<%= prevDate %>" onblur="valiDate(this);" style="width:65px;" />&nbsp;
		<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(salesDateFrom);" style="cursor:hand" /> ~&nbsp;
		<input type="text" id="salesDateTo" name="salesDateTo" value="<%= currentDate %>" onblur="valiDate(this);" style="width:65px;" />&nbsp; 
		<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(salesDateTo);" style="cursor:hand" />
		</td>
							<th><%=columnData.getString("status") %> </th>
							<td>
								<object id="lxd_status" classid="<%=LGauceId.LUXECOMBO%>"  width="90px">
									 <param name=ComboDataID     value="ds_status"/>
									 <param name=Sort			value=false/>
									 <param name=ListExprFormat	value="name^0^110, code^0^50"/> 
									 <param name=BindColumn	    value="code"/>
									 <param name=SearchColumn	value=name/> 
									 <param name=DisableBackColor  value="#FFFFCC"/>
								 </object>
							</td>
	</tr>
	</table>
	</dt>
	<dd class="btnseat1"><span class="search_btn_r search_btn_l">
	<input type="button" onfocus="blur();" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='#e2ebf7'" value="Search" onclick="f_retrieve();" /></span></dd>
</dl>
</div>
</fieldset>
<!--검색 E --><!--조회영역 끝 -->
<div class="sub_stitle">
<p><%=columnData.getString("sub1_title")%></p>
</div>
<!-- 그리드 S --> <!--==============================Sales List=====================================-->
<div>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td><comment id="__NSID__"> <object id="gr_main"
			classid="<%=LGauceId.GRID %>" style="width:100%;height:150px"
			class="comn_status">
			<param name="DataID" value="ds_main">
			<param name="Editable" value="true">
			<param name="SortView" value="Left">
			<param name="UrlImages" value="<I>Type='PopupBotton', Url='/sys/images/button/cal_icon.gif', Fit='AutoFit', Flat='True'</I>">
			<param name="UsingOneClick" value="1">
			<param name=ViewSummary           value="1">
			<param name="Format"
				value="
			          		<C>id='chk'			HeadAlign='center' HeadCheck=false  HeadCheckShow=true 	width='20'	EditStyle=CheckBox	 </c>
			            	<C>id='salesNo' 		name='<%=columnData.getString("sale_no") %>' 		 width='100' align='center'   Edit='none' </c>			            	
			            	<C>id='customer' 	name='<%=columnData.getString("customer") %>' 	 	 	width='160' align='left' Edit='none' </c>
			            	<C>id='customerCd' 	name='<%=columnData.getString("customer_cd") %>' 	width='70' align='center' Edit='none'  show='false'</c>
			            	<C>id='delivery' 	name='Delivery' 	 	 	width='160' align='left' Edit='none' </c>
			            	<C>id='deliveryCd' 	name='Delivery' 	width='70' align='center' Edit='none'  show='false'</c>
			            	<C>id='salesDate' name='<%=columnData.getString("sales_date") %>'  	width='80'  align='center' Edit='none' sumtext='Total'</c>
			            	<C>id='grandTotalQty'  	name='<%=columnData.getString("grand_total_qty") %>'  	 	width='95'  align='right'  Edit='none' sumtext='@sum', sumbgcolor='#ECE6DE' sumcolor='#666666'</c>
							<C>id='currencyCd'  name='<%=columnData.getString("currency_cd") %>' width='60' align='center' Edit='none' Data='ds_currCd:code:name'  EditStyle=Lookup     </C>							
			            	<C>id='grandTotalAmt'  	name='<%=columnData.getString("grand_total_amount") %>'  	 	width='120'  align='right'  Edit='none'  Value={Round(grandTotalAmt,0)} Dec=0 sumtext='@sum', sumbgcolor='#ECE6DE' sumcolor='#666666'</c>
							<C>id='payTerm'  name='<%=columnData.getString("terms_of_payment") %>' width='120' align='left' Edit='none' Data='ds_payTerm:code:name'  EditStyle=Lookup </C>							
			            	<C>id='statusNm'   	name='<%=columnData.getString("status") %>'    		 	width='100' align='left' Edit='none'</c>
			            	<C>id='status'   	name='<%=columnData.getString("status") %>'    		 	width='100' align='center' Edit='none' show='false'</c>
			            	<C>id='sapSeq'   	name='SAP SEQ'    		 	width='60' align='center' Edit='none' show='false'</c>
			            	<C>id='groupCd'   	name='Group CD'    		 	width='30' align='center' Edit='none' show='false'</c>
			            	<C>id='sapRtnMsg'   	name='SAP Return Message'    		 	width='300' align='left' Edit='none' </c>
			            	<C>id='transDate' name='Trans Date'  	width='70'  align='center' Edit='none' show='false'</c>
					  " />
		</object> </comment> <script>__WS__(__NSID__);</script></td>
	</tr>
</table>
</div>
<div class="sub_stitle">
<p><%=columnData.getString("sub2_title")%></p>
</div>
<!-- ==============================Sales Information=====================================-->
<div id="output_board_area">
<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="output_board">
	<colgroup>
		<col width="20%" />
		<col width="30%" />
		<col width="20%" />
		<col width="30%" />
	</colgroup>
	<tr>
		<th><%=columnData.getString("sales_date")%></th>
		<td colspan="3"><input type="text" id="salesDate" name="salesDate" style="width:70px;" maxlength="10" readonly />
		 <img id=salesDateIcon src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:f_isSalesNoExist();" style="cursor:hand" />
		 </td>
	</tr>
	<tr>
		<th><%=columnData.getString("customer")%></th>
		<td>
		<input type="text" id="vendNm" style="width:145px;" maxlength="500" readonly />
		<input type="hidden" id="vendCd" maxlength="19" />
		 </td>
		<th>Delivery</th>
		<td>
		<input type="text" id="deliveryNm" style="width:145px;" maxlength="500" readonly />
		<input type="hidden" id="deliveryCd" maxlength="19" />
		 </td>
	</tr>
	<tr>
		<th><%=columnData.getString("terms_of_payment")%></th>
		<td>
		<object id="termsOfPayment" classid="<%=LGauceId.LUXECOMBO%>" align="absmiddle" width="150">
			<param name="ComboDataID" value="ds_payTerm">
			<param name="ListCount" value="10">
			<param name="BindColumn" value="code">
			<param name="ListExprFormat" value="name^0^150,code^0^50">
			<param name="index" value="0">
		</object>
		</td>
		<th><%=columnData.getString("currency")%></th>
		<td><object id="currCd" classid="<%=LGauceId.LUXECOMBO%>" align="absmiddle" width="100">
			<param name="ComboDataID" value="ds_currCd">
			<param name="ListCount" value="10">
			<param name="BindColumn" value="code">
			<param name=Enable         value="true">
			<param name=ListExprFormat value="name^0^80,code^0^50">
			<param name=index value=2>
		</object></td>
	</tr>
	<tr>
		<th><%=columnData.getString("grand_total_qty")%></th>
		<td>
		<!-- !input type="text" id="grandTotalQty" style="width:130px;text-align:right;" maxlength="13" readonly /-->
		<object id="grandTotalQty" classid="<%=LGauceId.EMEDIT%>" align="absmiddle" width="120">
		<param name="ReadOnly"      value="true">
		<param name="Alignment"     value="2">
		<param name=IsComma      value="true">
		<param name="PromptChar"      value="">
		<param name="MaxDecimalPlace"     value="3">
		</object>
		</td>
		<th><%=columnData.getString("grand_total_amount")%></th>
		<td clospan="3">
		<!--  input type="text" id="grandTotalAmt" style="width:130px;text-align:right;" maxlength="13"  readonly / -->
		<object id="grandTotalAmt" classid="<%=LGauceId.EMEDIT%>" align="absmiddle" width="120">
		<param name="ReadOnly"      value="true">
		<param name="Alignment"     value="2">
		<param name=IsComma      value="true">
		<param name="PromptChar"      value="">
		<param name="MaxDecimalPlace"     value="2">
		</object>
		</td>
	</tr>
</table>
</div>
<!-- 그리드 E --> <object id=bd_main classid="<%=LGauceId.BIND%>">
	<param name=DataID value=ds_main>
	<param name=BindInfo
		value='
                <C> Col=customer   Ctrl=vendNm      Param=value  </C>
                <C> Col=customerCd   Ctrl=vendCd      Param=value  </C>
                <C> Col=delivery   Ctrl=deliveryNm      Param=value  </C>
                <C> Col=deliveryCd   Ctrl=deliveryCd      Param=value  </C>
                <C> Col=salesDate         Ctrl=salesDate        Param=value  </C>
                <C> Col=payTerm      Ctrl=termsOfPayment     Param=BindColVal  </C>
                <C> Col=currencyCd      Ctrl=currCd     Param=BindColVal  </C>
	  		'>
</object>
<div class="sub_stitle"><!--==============================Sales item=====================================-->
<p><%=columnData.getString("sub3_title")%></p>
<p class="rightbtn">
<span class="sbtn_r sbtn_l"> 
</span>
</p>
</div>
<!-- 그리드 S -->
<div>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td><comment id="__NSID__"> <object id="gr_detail"
			classid="<%=LGauceId.GRID %>" style="width:100%;height:135px"
			class="comn_status">
			<param name="DataID" value="ds_detail" />
			<param name="Editable" value="true" />
			<param name="UrlImages"	value="<I>Type='PopupBotton', Url='/sys/images/button/search_icon_2.gif', Fit='AutoFit', Flat='True'</I>">
			<param name="TitleHeight" value="30">
			<param name="SortView" value="Left">
			<param name="Format"
				value="
		            <C>id='materNm'   	    name='<%=columnData.getString("material_name") %>'      width='170'  align='left' edit='none'</c> 
		            <C>id='materCd'   	    name='<%=columnData.getString("material_code") %>'  width='90'   show='true'  edit='none' align='center'</c> 
					<C>id='unit'   		name='Unit'       width='40'  align='center' edit='none'</c> 
					<C>id='storLoct'   		name='Storage Loc.'       width='100'  align='center'  Data='ds_storCd:code:name'  edit='none' EditStyle=Lookup</c> 
					<C>id='currentQty'   	name='<%=columnData.getString("current_qty") %>'     width='100' align='right' edit='none' show='false'</c> 
					<C>id='salesQty'   	name='<%=columnData.getString("sales_qty") %>'     width='100' align='right'</c> 
					<C>id='unitPrice'   		name='<%=columnData.getString("unit_price") %>'       width='80'  align='right'</c> 
					<C>id='salesAmt'   		name='<%=columnData.getString("sales_amount") %>' width='120'  align='right'   Dec=0</c> 
					<C>id='vatCd'           name='<%=columnData.getString("vat_cd") %>'            width='148' align='left'    edit='none'  Data='ds_vatCd:code:name' EditStyle=Lookup </C>
					<C>id='vatAmt'   		name='<%=columnData.getString("vat_amount") %>'      width='80'  align='right' edit='none' Value={Round(vatAmt,0)} Dec=0</c> 
					<C>id='totalAmt'   	name='<%=columnData.getString("total_amount")%>'  width='140' align='right'  edit='none'  Value={Round(totalAmt,0)} Dec=0 </c> 
					<C>id='salesNo' 		name='<%=columnData.getString("sale_no") %>' 		 width='150' align='left'   Edit='none' show='false'</c>			            	
					<C>id='salesDate' name='<%=columnData.getString("sales_date") %>'  	width='70'  align='center' Edit='none' show='false'</c>
		            <C>id='salesItemSeq'   	    name='<%=columnData.getString("sales_item_seq") %>' edit='none' show='false'</c> 
		          " />
		</object> </comment> <script>__WS__(__NSID__);</script></td>
	</tr>
</table>
</div>
<!-- 그리드 E --> <!--===================================================================-->
<!-- 버튼 S -->
<div id="btn_area">
	<p class="b_right">
    	<span class="btn_r btn_l"><input type="button" onClick="f_sapSend();" 	    onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%= btnSapSend %>"  /></span>
    	<span class="btn_r btn_l"><input type="button" onClick="f_sapCancel();" 	onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%= btnSapCancel %>"  /></span>
	
</div>
<!-- 버튼 E --></div>
</body>
</html>