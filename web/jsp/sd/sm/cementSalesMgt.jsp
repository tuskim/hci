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
parent.centerFrame.cols='220,*';

var g_flug =false; // Detail작업 flag
var g_msPos = 0;   // save후  focus 제정의 Row
var g_ddtPos = 0;  // save후  focus 제정의 Row
/***************************************************************************************************/
/*초기 세팅
/***************************************************************************************************/
function onLoad(){
	//Order Status
	ds_status.DataID ="cm.cm.retrieveCommCodeCombo.gau?groupCd=2318&firstVal=Select";
	ds_status.Reset();
	
	//Currency
	ds_currCd.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2004";
	ds_currCd.Reset();
	ds_currCd.RowPosition = ds_currCd.NameValueRow("code","MMK");
	
	//Tax Code
	ds_vatCd.DataId="sd.sm.retrieveSalesMgmtVatACombo.gau?groupCd=2007";
	ds_vatCd.Reset();
	
	//Payment Method
	ds_payTerm.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2206";
	ds_payTerm.Reset();
	ds_payTerm.RowPosition = ds_payTerm.NameValueRow("code","AA03");
	
	//Storage Loc.
	ds_storCd.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2005&attr2=P";
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
	<%--
	if(ds_main.IsUpdated || ds_detail.IsUpdated){
		if(!g_flug){
			alert("<%=source.getMessage("dev.warn.com.continue")%>");
			return;
		}
	}
	--%>
	
	cfHideNoDataMsg(gr_main);//no data 메시지 숨기기
	  
	ds_main.UndoAll();// 빈 row는 1개만 가능하도록 처리
	  
	if(ds_main.CountRow<1){
		var strHeader = "salesNo"          + ":STRING(13)"
									+",salesDate"        + ":STRING(10)"
									+",customer"         + ":STRING(100)"
									+",customerCd"       + ":STRING(50)"
									+",delivery"         + ":STRING(100)"
									+",deliveryCd"       + ":STRING(50)"
									+",grandTotalQty"    + ":DECIMAL(13.3)"
									+",currencyCd"       + ":STRING(20)"
									+",grandTotalAmt"    + ":DECIMAL(13.2)"
									+",payTerm"		       + ":STRING(4)"
									+",orderStatusNm"	   + ":STRING(30)"
									+",orderStatus"      + ":STRING(2)"
									+",status"           + ":STRING(2)"
									+",sapSeq"  	       + ":STRING(6)"
									+",groupCd"          + ":STRING(3)"
									+",sapRtnMsg"		     + ":STRING(300)"
									+",transDate"        + ":STRING(10)"
									;
		ds_main.SetDataHeader(strHeader);
    cfHideNoDataMsg(gr_main);		
	}
	
	ds_main.AddRow(); 
	ds_main.NameValue(ds_main.RowPosition,"currencyCd") = "MMK";
	ds_main.NameValue(ds_main.RowPosition,"payTerm") ="AA03";
	 
}

//Detail Add
function f_addRowDetail(){
	
	if(ds_main.NameValue(ds_main.RowPosition,"orderStatus") =="2"){
		alert("Can't delete, \nBecause Order Status is 'Ordered' ");
		return;
	}
	
	if(ds_main.CountRow>0){
		if(ds_detail.CountRow<1){
			var strHeader =  "materCd"      +    ":STRING(18)"
							+",materNm"             +    ":STRING(50)"
							+",unit"                +    ":STRING(3)"
							+",storLoct"            +    ":STRING(4)"
							+",salesQty"            +    ":DECIMAL(13.3)"
							+",unitPrice"           +    ":DECIMAL(13.2)"
							+",salesAmt"            +    ":DECIMAL(13)"
							+",vatCd"               +    ":STRING(20)" 
							+",vatAmt"              +    ":DECIMAL(13)"
							+",totalAmt"            +    ":DECIMAL(13)"
							+",salesNo"             +   ":STRING(13)"
							+",salesDate"           +   ":STRING(10)"
							+",salesItemSeq"        +   ":STRING(6)"
							;

			ds_detail.SetDataHeader(strHeader);
		}		 
		
		ds_detail.AddRow();  
		ds_detail.NameValue(ds_detail.RowPosition,"materCd")   = "";  
		ds_detail.NameValue(ds_detail.RowPosition,"unit")      = "";  
		ds_detail.NameValue(ds_detail.RowPosition,"unitPrice") = 0;
		ds_detail.NameValue(ds_detail.RowPosition,"vatCd")     ="AM";
		ds_detail.NameValue(ds_detail.RowPosition,"salesNo")   = "";
		ds_detail.NameValue(ds_detail.RowPosition,"salesDate") = "";
		
		f_Enable();
	    
	}
}

//Detail Del
function f_delRowDetail(){
	
	if(ds_detail.CountRow==1){
		alert("<%=source.getMessage("dev.msg.po.itemchk")%>");
	} 
	
	if(ds_detail.CountRow>1){
		
		if(ds_main.NameValue(ds_main.RowPosition,"orderStatus") =="2"){
			alert("Can't delete, \nBecause Order Status is 'Ordered' ");
			return;
		}
		
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
	ds_main.DataID  = "/sd.sm.retrieveCementSalesMgnt.gau?";
  ds_main.DataID += "vendorCd=" 		    + ds_vendor.NameValue(ds_vendor.RowPosition,"code");
  ds_main.DataID += "&salesDateFrom="   + encodeURIComponent(salesDateFrom.value);
  ds_main.DataID += "&salesDateTo="     + encodeURIComponent(salesDateTo.value);
	ds_main.DataID += "&orderStatus=" 		+ ds_status.nameValue(ds_status.rowPosition,"code");
 	ds_main.DataID += "&lang="			      + "<%=g_lang%>";
 	ds_main.DataID += "&searchType="		  + "search";
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
		/*
	  for(var inx=1; inx<=ds_main.CountRow;inx++){ 
  		if(ds_main.NameValue(inx,"chk")=="T"){
  			chkCountNo++;
  		}
  	}	
	  
 	  if(chkCountNo>1){
			alert("Select only one Sales List!");
			return;
	  }
 	  */
 	
	 	//Confirm 이 진행된 상태는 수정 및 삭제 불가
	 	var confirmStatus = ds_main.NameValue(ds_main.RowPosition,"status") ;
	 	var rowStatus = ds_main.RowStatus(ds_main.RowPosition);
	 	//신규건에 대해서는 체크 제외
	 	if(confirmStatus != "0" && rowStatus != 1){
	 		alert("Sales Order already confirmed.");
	 		return;
	 	}
	 	
	 	//Ordered Status 외에는 저장 및 수정 가능.
		if(ds_main.NameValue(ds_main.RowPosition,"orderStatus") != "2"){
			if(f_vali()){
				if(confirm("<%=msgSave%>")){
					g_msPos  = ds_main.RowPosition;
					g_ddtPos = ds_detail.RowPosition;		
					g_flug=true;
					tr_cudMaster.KeyValue = "Servlet( I:IN_DS1 = ds_main, I:IN_DS2 = ds_detail )";
					tr_cudMaster.Action   = "/sd.sm.cudCementSalesMgnt.gau?";
					tr_cudMaster.post();
				}
			}
		}else{
			alert("<%=source.getMessage("dev.msg.ps.statusSaveSales")%>");
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
	
	/*
	for(var inx=1; inx<=ds_main.CountRow;inx++){ 
  	if(ds_main.NameValue(inx,"chk")=="T"){
  		chkCountNo++;
  	}
  }
	
 	if(chkCountNo>1){
		alert("Select only one Sales List!");
		return;
	}
 	*/
 	
 	//Confirm 이 진행된 상태는 수정 및 삭제 불가
 	var confirmStatus = ds_main.NameValue(ds_main.RowPosition,"status") ;
 	if(confirmStatus != "0"){
 		alert("Sales Order already confirmed.");
 		return;
 	}
 	
 	//Ordered Status 외에는 저장 및 수정 가능.
 	if(ds_main.NameValue(ds_main.RowPosition,"orderStatus") != "2"){
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
		alert("<%=source.getMessage("dev.msg.ps.statusSaveSales")%>");
		return;
	}
 	
}

<%-- //SAP 전송 기능 미사용
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
					tr_sendMaster.Action   = "/sd.sm.cudCementSalesSapSend.gau";
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
		tr_sapCandMaster.Action   = "/sd.sm.cudCementSalesSapCancel.gau";
		tr_sapCandMaster.Post();
	}
}
--%>


//고객 조회 팝업
function f_openCustomer(){
	if(ds_main.NameValue(ds_main.RowPosition, "orderStatus") == "2"){
		alert("Can't change the Customer when the status is 'Ordered' ");
		return;
	}
	
	openVendorCodeListWin();
}

//고객 조회 팝업
function f_openDelivery(){
	if(ds_main.NameValue(ds_main.RowPosition, "orderStatus") == "2"){
		alert("Can't change the Delivery when the status is 'Ordered' ");
		return;
	}
	
	openDeliveryCodeListWin();
}

// Vendor Popup
function openVendorCodeListWin() {

  var result = "";
  var firstList = new Array ();

  var popupId             = "CustomerCodeList";
  var popupStr            = "/jsp/cm/cd/pop_" + popupId + ".jsp";

  var vendCd              = "?vendCd="            + document.all.vendCd.value;
  //var tgOneSelect         = "&tgOneSelect="       + "T";                      // 한 건인 경우 자동선택
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

  var popupId             = "DeliveryCodeList";
  var popupStr            = "/jsp/cm/cd/pop_" + popupId + ".jsp";

  var vendCd              = "?vendCd="            + document.all.deliveryCd.value;
  //var tgOneSelect         = "&tgOneSelect="       + "T";                      // 한 건인 경우 자동선택
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

/* 	if(f_isNull(document.all.salesDate.value)){
		alert("Please, Select Sales Date!");
		return false;
	} */
  
	var popupId             = "ProductMaterialCodeListCon";
  var popupStr            = "/jsp/cm/cd/pop_" + popupId + ".jsp";
  
  if (type != "") {
	  popupStr = popupStr + "?type=" + type;
  }
  
  /*
  if(type!=""){
	  popupStr += "&type="              + type; 
  } 
  */
    
  //var tgOneSelect         = "&tgOneSelect="       + "T";                      // 한 건인 경우 자동선택
  var popupWidth          = "dialogWidth="        + "580px";
  var popupHeight         = ";dialogHeight="      + "470px";

  result = window.showModalDialog( popupStr , popupId, popupWidth + popupHeight );

  if (result == -1 || result == null || result == "") {

	  obj.NameValue(row,"materCd") = "";
	  obj.NameValue(row,"materNm") = "";
	  obj.NameValue(row,"unit") = "";
	  obj.NameValue(row,"storLoct") = "";
	  obj.NameValue(row,"vatCd") = "AM";
	  obj.NameValue(row,"unitPrice") = "";
	} else {
    firstList = result.split(";");
    obj.NameValue(row,"materCd")    = firstList[0];
    obj.NameValue(row,"materNm")    = firstList[1];
    obj.NameValue(row,"unit")       = firstList[2];
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
	if( f_isNull(ds_main.NameValue( ds_main.rowPosition , "delivery" ))){
		alert("<%=source.getMessage("dev.warn.com.input",columnData.getString("delivery"))%>");
		return false;
	}
	if( f_isNull(ds_main.NameValue( ds_main.rowPosition , "deliveryCd" ))){
		alert("<%=source.getMessage("dev.warn.com.input",columnData.getString("delivery"))%>");
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



function creditChkFlag(){
	
	var orderStatus = ds_main.NameValue(ds_main.RowPosition,"orderStatus")  ;
	
	if(orderStatus == 1) {
		return true;	
	} else {
		return false;
	}
	
}

//Print
function f_print(){ 
	if(ds_main.CountRow < 1){
		alert("Please Search Sales List!");
		return;
	}
		
	if((ds_main.IsUpdated) || ds_detail.IsUpdated){
 		alert("<%=source.getMessage("dev.warn.com.continue")%>");
		return;			 
 
	} 	
	
	if(creditChkFlag() == false){
		alert("<%=source.getMessage("dev.msg.ps.statusSalesPrint")%>");
		return;
	}
	
	ds_main.UserStatus(ds_main.RowPosition) = "1";  //강제 Insert로 상태 변경
	ds_detail.UserStatus(ds_detail.RowPosition) = "1";  //강제 Insert로 상태 변경
	
  //여신체크 로직 추가
	tr_reportBefore.KeyValue = "Servlet( I:IN_DS1 = ds_main, I:IN_DS2 = ds_detail )";
	tr_reportBefore.Action   = "/sd.sm.cudCementSalesMgnt.gau?creditCheck=Y"
	tr_reportBefore.post();
	
	//tr_reportBefore event=OnSuccess() 에서 처리 하도록 변경.
	//f_report_set(); 
	//re_report.Preview();    	
}

//Print Dataset
function f_report_set(){
	var strHeader =  "addr1"           +    ":STRING(100)"
					      +",addr2"            +    ":STRING(100)"
					      +",addr3"            +    ":STRING(100)"
					      +",addr4"            +    ":STRING(100)"
					      +",addr5"            +    ":STRING(100)"
					      +",addr6"            +    ":STRING(100)"
					      +",custNm"           +    ":STRING(100)"
					      +",deliveryNm"       +    ":STRING(100)"
					      +",soNo"             +    ":STRING(100)"
					      +",salesDate"        +    ":STRING(100)"
					      +",subTot"           +    ":STRING(100)"		
					      +",tot"              +    ":STRING(100)"		
					      +",vatAmount"        +    ":STRING(100)"
					      +",gTot"             +    ":STRING(100)";
	
	ds_report_main.SetDataHeader(strHeader);			
	ds_report_main.AddRow();
	ds_report_main.NameValue(ds_report_main.RowPosition,"addr1")       = ds_main.NameValue(ds_main.RowPosition,"purDept1");
	ds_report_main.NameValue(ds_report_main.RowPosition,"addr2")       = ds_main.NameValue(ds_main.RowPosition,"purDept2");
	ds_report_main.NameValue(ds_report_main.RowPosition,"addr3")       = ds_main.NameValue(ds_main.RowPosition,"purDept3");		
	ds_report_main.NameValue(ds_report_main.RowPosition,"addr4")       = ds_main.NameValue(ds_main.RowPosition,"purDept4");
	ds_report_main.NameValue(ds_report_main.RowPosition,"addr5")       = ds_main.NameValue(ds_main.RowPosition,"purDept5");
	ds_report_main.NameValue(ds_report_main.RowPosition,"addr6")       = ds_main.NameValue(ds_main.RowPosition,"purDept6");
	
	ds_report_main.NameValue(ds_report_main.RowPosition,"custNm")      = ds_main.NameValue(ds_main.RowPosition,"customer");
	ds_report_main.NameValue(ds_report_main.RowPosition,"deliveryNm")  = ds_main.NameValue(ds_main.RowPosition,"delivery");
	ds_report_main.NameValue(ds_report_main.RowPosition,"soNo")        = ds_main.NameValue(ds_main.RowPosition,"salesNo");
	ds_report_main.NameValue(ds_report_main.RowPosition,"salesDate")   = ds_main.NameValue(ds_main.RowPosition,"salesDate");
	
 	var strSubTot = 0;
	var strTot = 0;
	var strVatTot = 0;	
	var strGTot = 0;
	
	for(var j=1;j<=ds_detail.CountRow;j++){
		strSubTot = Number(strSubTot) + Number(ds_detail.NameValue(j,"salesAmt"));
		strVatTot = Number(strVatTot) + Number(ds_detail.NameValue(j,"vatAmt"));		
	}
	
	strTot = Number(strSubTot) ;
	strVatTot = Number(strVatTot);
	
	ds_report_main.NameValue(ds_report_main.RowPosition,"subTot")      = setComma(strSubTot)=="0" ? "-" : setComma(strSubTot);
	ds_report_main.NameValue(ds_report_main.RowPosition,"tot")         = setComma(strTot)=="0" ? "-" : setComma(strTot);
	ds_report_main.NameValue(ds_report_main.RowPosition,"vatAmount")   = setComma(strVatTot)=="0" ? "-" : setComma(strVatTot);
	ds_report_main.NameValue(ds_report_main.RowPosition,"gTot")        = setComma(strTot+strVatTot)=="0" ? "-" : setComma(strTot+strVatTot);

			
	var strdHeader =  "seqNo"             +    ":STRING(100)"
					        +",materCd"           +    ":STRING(100)"
					        +",materNm"           +    ":STRING(100)"
					        +",salesQty"          +    ":STRING(100)"
					        +",unit"              +    ":STRING(100)"
					        +",unitPrice"         +    ":STRING(100)"
					        +",salesAmt"          +    ":STRING(100)";
				
	ds_report_dtl.SetDataHeader(strdHeader);
	
	for(var i=1;i<=ds_detail.CountRow;i++){ 
		ds_report_dtl.AddRow();		
		ds_report_dtl.NameValue(ds_report_dtl.RowPosition,"seqNo")       = i;
		ds_report_dtl.NameValue(ds_report_dtl.RowPosition,"materCd")     = ds_detail.NameValue(i,"materCd");
		ds_report_dtl.NameValue(ds_report_dtl.RowPosition,"materNm")     = ds_detail.NameValue(i,"materNm");
		ds_report_dtl.NameValue(ds_report_dtl.RowPosition,"salesQty")    = setComma(ds_detail.NameValue(i,"salesQty"));
		
		if(ds_detail.NameValue(i,"unit")=="L"){
			ds_report_dtl.NameValue(ds_report_dtl.RowPosition,"unit")      = "liter";
		}else{
			ds_report_dtl.NameValue(ds_report_dtl.RowPosition,"unit")      = ds_detail.NameValue(i,"unit");
		}
		
		ds_report_dtl.NameValue(ds_report_dtl.RowPosition,"unitPrice")   = setComma(ds_detail.NameValue(i,"unitPrice"));
		ds_report_dtl.NameValue(ds_report_dtl.RowPosition,"salesAmt")    = setComma(ds_detail.NameValue(i,"salesAmt"));		
	}						
    
  for(var t=1; t<=12; t++){
		ds_report_dtl.AddRow();
	}
	
	for(var s=ds_report_dtl.CountRow; s>13; s--){
		ds_report_dtl.DeleteRow(s);
	}	
}


//-------------------------------------------------------------------------
//ORDER_STATUS가 2가 아니면 입력 enable처리.
//-------------------------------------------------------------------------
function f_Enable(){
    termsOfPayment.Enable = true;
    currCd.Enable = true;

    gr_detail.ColumnProp("materNm", "Edit") = "";
    gr_detail.ColumnProp("storLoct", "Edit") = "";
    gr_detail.ColumnProp("salesQty", "Edit") = "";
    gr_detail.ColumnProp("unitPrice", "Edit") = "";
    gr_detail.ColumnProp("vatCd", "Edit") = "";
    
	  document.getElementById("salesDate").readOnly = false;
	  salesDateIcon.disabled          = false;
	  document.all.salesDateIcon.src = "<%= images %>button/cal_icon.gif";	
}

//-------------------------------------------------------------------------
//ORDER_STATUS가 2이면 입력 Disable
//-------------------------------------------------------------------------
function f_Disable() {
    termsOfPayment.Enable = false;
    currCd.Enable = false;

    gr_detail.ColumnProp("materNm", "Edit") = "none";
    gr_detail.ColumnProp("storLoct", "Edit") = 'none';
    gr_detail.ColumnProp("salesQty", "Edit") = 'none';
    gr_detail.ColumnProp("unitPrice", "Edit") = 'none';
    gr_detail.ColumnProp("vatCd", "Edit") = 'none';
    
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

<object id="ds_report_main" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true">
	<param name="ViewDeletedRow"    value="false">
</object> 

<object id="ds_report_dtl" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true">
	<param name="ViewDeletedRow"    value="false">
</object> 
<OBJECT id=tr_report classid="<%=LGauceId.TR%>">
	<param name="KeyName" value="toinb_dataid4">
</OBJECT>
<OBJECT id=tr_reportBefore classid="<%=LGauceId.TR%>">
	<param name="KeyName" value="toinb_dataid4">
</OBJECT>
<object id="ds_creditCheck" classid="<%=LGauceId.DATASET%>" >
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
<script language=JavaScript for=tr_report event=OnSuccess()>	
  f_retrieve();
  ds_main.RowPosition = g_msPos;
  ds_detail.RowPosition= g_ddtPos;	
</script>

<!-- SAP Cancle Tr 의 트렌젝션 실행 시 -->
<%--
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
--%>

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
	cfFillGridNoDataMsg(gr_main,"gridColLineCnt=3");//no data found   
	mode = "";
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
		
		grandTotalQty.Text = ds_main.NameValue(ds_main.RowPosition,"grandTotalQty");  //Sales Qty binding
		grandTotalAmt.Text = ds_main.NameValue(ds_main.RowPosition,"grandTotalAmt");  //Sales Amount binding
		
	  if(ds_main.NameValue(ds_main.RowPosition,"orderStatus") == "2"){
		  f_Disable();
	  }else{
		  f_Enable();
	  }
		
	}else if(row>0 && salesNo == "" ){
		ds_detail.ClearAll();
		f_addRowDetail();
		
		grandTotalQty.Text = 0;  //Sales Qty binding
		grandTotalAmt.Text = 0;  //Sales Amount binding
		
		f_Enable();
		
		//ds_payTerm.RowPosition = ds_payTerm.NameValueRow("code","AA03");

	}
	
	g_flug = false;
</script>

<script language=JavaScript for=ds_main event=CanRowPosChange(row)>
<%-- 
	if(ds_main.IsUpdated || ds_detail.IsUpdated){
		if(!g_flug){	
			alert("<%=source.getMessage("dev.warn.com.continue")%>");
			return false;
		}
	}				
--%>
</script>

<!-----------------------------------------------------------------------------
  전체 체크박스 선택/해제
------------------------------------------------------------------------------>
<script language=JavaScript for=gr_main event=OnHeadCheckClick(Col,Colid,bCheck)>
/*
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
*/	
</script>	

<script language="JavaScript" for="gr_detail" event="OnPopup(row,colid,data)">
 	if ( colid == "materNm") {
 		openCementMaterialCodeListPopUp(row, ds_detail,"SD");
	}
</script>
<script language="javascript" for="ds_detail" event="OnColumnChanged(row,colid)">

  	if ( colid == "salesQty") {
		  ds_detail.NameValue(row,"salesAmt") = Math.round(ds_detail.NameValue(row,"salesQty") * ds_detail.NameValue(row,"unitPrice"));
  		
		var sumTotalQty = 0;
	  for ( var i = 1; i <= ds_detail.CountRow; i++) {
			sumTotalQty = sumTotalQty + ds_detail.NameValue(i,"salesQty");
	  }
	  
	  //Sales Quantity binding
	  grandTotalQty.Text = sumTotalQty; 
	  ds_main.NameValue(ds_main.RowPosition,"grandTotalQty") = grandTotalQty.Text;
	  
	  //Tax Code
  	if(ds_detail.NameValue(row,"vatCd") == "AM"){
			ds_detail.NameValue(row,"vatAmt") = Math.round(ds_detail.NameValue(row,"salesAmt") * 0.05);
		}else{
			ds_detail.NameValue(row,"vatAmt") = Math.round(ds_detail.NameValue(row,"salesAmt") * 0);
		}
	  
		ds_detail.NameValue(row,"totalAmt") = Math.round(ds_detail.NameValue(row,"salesAmt")) + Math.round(ds_detail.NameValue(row,"vatAmt"));
	}
  
  if ( colid == "unitPrice") {
		ds_detail.NameValue(row,"salesAmt") = Math.round(ds_detail.NameValue(row,"salesQty") * ds_detail.NameValue(row,"unitPrice"));
		
  	if(ds_detail.NameValue(row,"vatCd") == "AM"){
			ds_detail.NameValue(row,"vatAmt") = Math.round(ds_detail.NameValue(row,"salesAmt")) * 0.05;
		}else{
			ds_detail.NameValue(row,"vatAmt") = Math.round(ds_detail.NameValue(row,"salesAmt")) * 0;
		}
  	
		ds_detail.NameValue(row,"totalAmt") = Math.round(ds_detail.NameValue(row,"salesAmt") + ds_detail.NameValue(row,"vatAmt"));
	}
  
  if ( colid == "vatCd") {
    if(ds_detail.NameValue(row,"vatCd") == "AM"){
			ds_detail.NameValue(row,"vatAmt") = Math.round(ds_detail.NameValue(row,"salesAmt")) * 0.05;
		}else{
			ds_detail.NameValue(row,"vatAmt") = Math.round(ds_detail.NameValue(row,"salesAmt")) * 0;
		}
    
		ds_detail.NameValue(row,"totalAmt") = Math.round(ds_detail.NameValue(row,"salesAmt")) + Math.round(ds_detail.NameValue(row,"vatAmt"));
	}
  
  if ( colid == "salesAmt") {
    if(ds_detail.NameValue(row,"vatCd") == "AM"){
			ds_detail.NameValue(row,"vatAmt") = Math.round(ds_detail.NameValue(row,"salesAmt")) * 0.05;
		}
  	
		ds_detail.NameValue(row,"totalAmt") = Math.round(ds_detail.NameValue(row,"salesAmt")) + Math.round(ds_detail.NameValue(row,"vatAmt"));
	}

  if ( colid == "totalAmt") {
		var sumTotalAmt = 0;
	  for ( var i = 1; i <= ds_detail.CountRow; i++) {
			sumTotalAmt = sumTotalAmt + Math.round(ds_detail.NameValue(i,"totalAmt"));
	  }
	  
		//Sales Amount binding
		grandTotalAmt.Text= Math.round(sumTotalAmt);
		ds_main.NameValue(ds_main.RowPosition,"grandTotalAmt") = grandTotalAmt.Text;
	}
</script>

<!-- Print Complete Event --> 
<script language=JavaScript for=re_report event=OnPrintCompleted()>
	//프린트 완료 후 주문 상태 변경 
	g_msPos  = ds_main.RowPosition;
	g_ddtPos = ds_detail.RowPosition;		
	g_flug=true;
	tr_report.KeyValue = "Servlet( I:IN_DS1 = ds_report_main, I:IN_DS2 = ds_report_dtl )";
	tr_report.Action   = "/sd.sm.cudCementSalesMgnt.gau?printMode=Y";
	tr_report.post();
</script>


<script language=JavaScript for=tr_reportBefore event=OnSuccess()>
	var salesNo = ds_main.NameValue(ds_main.RowPosition,"salesNo");
	var salesDate = ds_main.NameValue(ds_main.RowPosition,"salesDate");
	
  ds_creditCheck.ClearAll();
	ds_creditCheck.DataID  = "/sd.sm.retrieveCementSalesMgnt.gau?searchType=creditCheck&salesNo="+salesNo+"&salesDate="+salesDate;
	ds_creditCheck.Reset();

	var creditCheck = ds_creditCheck.NameValue(1,"orderStatus");
	var creditMsg = ds_creditCheck.NameValue(1,"creditMsg");
	if(creditCheck == 1 && creditMsg.indexOf("Customer Credit Available") > -1 ){
	  f_report_set(); 
	  re_report.Preview();
	}else{
		alert("Exceed Credit Limit. Check Credit Exposure.");
	}
	
	
</script>

<script language=JavaScript for=tr_reportBefore event=OnFail()>

</script>
<!-----------------------------------------------------------------------------
    화면영역 시작
------------------------------------------------------------------------------>
</head>

<body id="cent_bg" onload="onLoad()">
	<div id="conts_box">
		<h2><span>Sales Order</span></h2>
		
		<!--검색 S -->
		<fieldset class="boardSearch">
			<div>
				<dl>
					<dt>
						<table width="100%" border="0" cellpadding="0" cellspacing="0"  class="output_board2" >
							<colgroup>
						    	<col width="14%"/>
						      <col width="20%"/>
						      <col width="15%"/>
						      <col width="38%"/>
						      <col width="11%"/>
						      <col width="20%"/>
						  </colgroup>
						  <tr>
						    <th>Customer</th>
						    <td>
							    <object id="lc_vendor"  classid="<%=LGauceId.LUXECOMBO%>" width="100">
								    <param name="ComboDataID"     value="ds_vendor">
								    <param name="ListCount"       value="10">
								    <param name=SearchColumn      value="name">
								    <param name="BindColumn"      value="code">
								    <param name=ListExprFormat    value="name^0^210,code^0^70">
								    <param name=index             value=0>
							    </object>
						    </td>
						    <th>Sales Date</th>
						    <td>
						    	<input type="text" id="salesDateFrom" name="salesDateFrom" value="<%= prevDate %>" onblur="valiDate(this);" style="width:65px;" />&nbsp;
						    	<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(salesDateFrom);" style="cursor:hand" /> ~&nbsp;
						    	<input type="text" id="salesDateTo" name="salesDateTo" value="<%= currentDate %>" onblur="valiDate(this);" style="width:65px;" />&nbsp;
						    	<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(salesDateTo);" style="cursor:hand" />
						    </td>
						    <th>Status</th>
						    <td>
						    	<object id="lxd_status" classid="<%=LGauceId.LUXECOMBO%>"  width="90px">
						      	<param name=ComboDataID       value="ds_status"/>
						        <param name=Sort              value=false/>
						        <param name=ListExprFormat    value="name^0^110, code^0^50"/>
						        <param name=BindColumn        value="code"/>
						        <param name=SearchColumn      value=name/>
						        <param name=DisableBackColor  value="#FFFFCC"/>
						      </object>
						    </td>
						  </tr>
					  </table>
				  </dt>
				  <dd class="btnseat1"><span class="search_btn_r search_btn_l"><input type="button" onfocus="blur();" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='#e2ebf7'" value="Search" onclick="f_retrieve();" /></span></dd>
				</dl>
			</div>
		</fieldset>
	  <!--검색 E --><!--조회영역 끝 -->
	  
		<div class="sub_stitle">
			<p>Sales Order List</p>
			<p class="rightbtn">		  
				<span class="sbtn_r sbtn_l"> 
					<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="<%=btnPrint %>" onclick="f_print();"/></span>  	 
			</p>
		</div>
		
		<!-- 그리드 S --> <!--==============================Sales List=====================================-->
		<div>
		  <table width="100%" border="0" cellspacing="0" cellpadding="0">
		    <tr>
		      <td>
		        <comment id="__NSID__">
		            <object id="gr_main" classid="<%=LGauceId.GRID %>" style="width:100%;height:160px" class="comn_status">
			            <param name="DataID"          value="ds_main">
			            <param name="Editable"        value="true">
			            <param name="SortView"        value="Left">
			            <param name="UrlImages"       value="<I>Type='PopupBotton', Url='/sys/images/button/cal_icon.gif', Fit='AutoFit', Flat='True'</I>">
			            <param name="UsingOneClick"   value="1">
			            <Param name="TitleHeight"     value="35">
			            <param name="ViewSummary"     value="1">
			            <param name="Format"
			              value="
			              <%--
			                  <C>id='chk'             EditStyle=CheckBox          width='20'   HeadAlign='center' HeadCheck=false  HeadCheckShow=true</C>
			              --%>
			                  <C>id='salesNo'         name='Sales Order No.'      width='100'  align='center'  edit='none' </C>
			                  <C>id='salesDate'       name='Sales Date'     width='90'   align='center'  edit='none'  sumtext='Total'</C>
			                  <C>id='customer'        name='Customer'             width='125'  align='left'    edit='none' </C>
			                  <C>id='customerCd'      name='Customer Cd.'         width='70'   align='center'  edit='none'  show='false'</C>
			                  <C>id='delivery'        name='Delivery'             width='125'  align='left'    edit='none' </C>
			                  <C>id='deliveryCd'      name='Delivery Cd.'         width='70'   align='center'  edit='none'  show='false'</C>
			                  <C>id='grandTotalQty'   name='Sales;Quantity'       width='80'   align='right'   edit='none'  sumtext='@sum', sumbgcolor='#ECE6DE' sumcolor='#666666'</C>
			                  <C>id='currencyCd'      name='Currency'             width='70'   align='center'  edit='none'  Data='ds_currCd:code:name'  EditStyle=Lookup     </C>
			                  <C>id='grandTotalAmt'   name='Sales;Amount'         width='110'  align='right'   edit='none'  value={Round(grandTotalAmt,0)} Dec=0 sumtext='@sum', sumbgcolor='#ECE6DE' sumcolor='#666666'</C>
			                  <C>id='orderStatusNm'   name='Status'               width='100'  align='center'  edit='none'</C>
			                  <C>id='orderStatus'     name='Status'               width='100'  align='center'  edit='none'  show='false'</C>
			                  <C>id='creditMsg'       name='Credit Msg.'          width='270'  align='left'    edit='none'  </C>
			                  <C>id='status'          name='Confirm;Status'       width='100'  align='center'  edit='none'  show='false'</C>
			                  <C>id='payTerm'         name='Payment;Method'       width='100'  align='center'  edit='none'  Data='ds_payTerm:code:name'  EditStyle=Lookup show='false'</C>
			                  <C>id='sapSeq'          name='SAP SEQ'              width='60'   align='center'  edit='none'  show='false'</C>
			                  <C>id='groupCd'         name='Group CD'             width='30'   align='center'  edit='none'  show='false'</C>
			                  <C>id='sapRtnMsg'       name='SAP Return Message'   width='300'  align='left'    edit='none'  show='false'</C>
			                  <C>id='transDate'       name='Trans Date'           width='70'   align='center'  edit='none'  show='false'</C>
			            " />
		            </object> 
		        </comment><script>__WS__(__NSID__);</script>
		      </td>
		    </tr>
		  </table>
		</div>
		
		<div class="sub_stitle">
			<p>Sales Information</p>
		</div>
		
		<!-- ==============================Sales Information=====================================-->
		<div id="output_board_area">
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board">
			  <colgroup>
			    <col width="20%" />
			    <col width="30%" />
			    <col width="20%" />
			    <col width="30%" />
			  </colgroup>
			  <tr>
			    <th>Sales Date</th>
			    <td colspan="3"><input type="text" id="salesDate" name="salesDate" style="width:70px;" maxlength="10" readonly />
			     <img id=salesDateIcon src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:f_isSalesNoExist();" style="cursor:hand" />
			    </td>
			  </tr>
			  <tr>
			    <th>Customer</th>
			    <td>
				    <input type="text" id="vendNm" style="width:145px;" maxlength="500" readonly />
				    <input type="hidden" id="vendCd" maxlength="19" />
				    <img src="<%= images %>button/search_icon_2.gif" alt="customer search popup" onClick="javascript:f_openCustomer();" style="cursor:hand" />
			    </td>
			    <th>Delivery</th>
			    <td>
				    <input type="text" id="deliveryNm" style="width:145px;" maxlength="500" readonly />
				    <input type="hidden" id="deliveryCd" maxlength="19" />
				    <img src="<%= images %>button/search_icon_2.gif" alt="customer search popup" onClick="javascript:f_openDelivery();" style="cursor:hand" />
			    </td>
			  </tr>
			  <tr>
			    <th>Payment Method</th>
			    <td>
				    <object id="termsOfPayment" classid="<%=LGauceId.LUXECOMBO%>" align="absmiddle" width="150">
				      <param name="ComboDataID"    value="ds_payTerm">
				      <param name="ListCount"      value="10">
				      <param name="BindColumn"     value="code">
				      <param name="ListExprFormat" value="name^0^150,code^0^50">
				      <param name="index"          value="0">
				    </object>
			    </td>
			    <th>Sales Quantity</th>
			    <td>
			    	<!-- !input type="text" id="grandTotalQty" style="width:130px;text-align:right;" maxlength="13" readonly /-->
				    <object id="grandTotalQty" classid="<%=LGauceId.EMEDIT%>" align="absmiddle" width="120">
					    <param name="ReadOnly"          value="true">
					    <param name="Alignment"         value="2">
					    <param name=IsComma             value="true">
					    <param name="PromptChar"        value="">
					    <param name="MaxDecimalPlace"   value="3">
				    </object>
			    </td>
			  </tr>
			  <tr>
			    <th>Currency</th>
			    <td>
			      <object id="currCd" classid="<%=LGauceId.LUXECOMBO%>" align="absmiddle" width="100">
				      <param name="ComboDataID"  value="ds_currCd">
				      <param name="ListCount"    value="10">
				      <param name="ReadOnly"     value="true">
				      <param name="BindColumn"   value="code">
				      <param name=Enable         value="true">
				      <param name=ListExprFormat value="name^0^80,code^0^50">
				      <param name=index value=2>
			      </object>
			    </td>
			    <th>Sales Amount</th>
			    <td clospan="3">
			    	<!--  input type="text" id="grandTotalAmt" style="width:130px;text-align:right;" maxlength="13"  readonly / -->
				    <object id="grandTotalAmt" classid="<%=LGauceId.EMEDIT%>" align="absmiddle" width="120">
					    <param name="ReadOnly"         value="true">
					    <param name="Alignment"        value="2">
					    <param name=IsComma            value="true">
					    <param name="PromptChar"       value="">
					    <param name="MaxDecimalPlace"  value="2">
			    	</object>
			    </td>
			  </tr>
			</table>
		</div>
		
	<!-- 그리드 E --> 
		<object id=bd_main classid="<%=LGauceId.BIND%>">
		  <param name=DataID value=ds_main>
		  <param name=BindInfo
		    value='
					<C> Col=customer        Ctrl=vendNm           Param=value  </C>
					<C> Col=customerCd      Ctrl=vendCd           Param=value  </C>
					<C> Col=delivery        Ctrl=deliveryNm       Param=value  </C>
					<C> Col=deliveryCd      Ctrl=deliveryCd       Param=value  </C>
					<C> Col=salesDate       Ctrl=salesDate        Param=value  </C>
					<C> Col=payTerm         Ctrl=termsOfPayment   Param=BindColVal  </C>
					<C> Col=currencyCd      Ctrl=currCd           Param=BindColVal  </C>
	        '>
		</object>
		
		
		<div class="sub_stitle"><!--==============================Sales Material====================================-->
			<p>Sales Material</p>
			<p class="rightbtn">
			<span class="sbtn_r sbtn_l">
				<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="<%=btnAddRow%>" onclick="f_addRowDetail();" />
			</span>
			<span class="sbtn_r sbtn_l">
				<input  type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="<%=btnDelRow%>" onclick="f_delRowDetail();" />
			</span>
			</p>
		</div>
		
		<!-- 그리드 S -->
		<div>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			  <tr>
			    <td>
			    	<comment id="__NSID__">
			    		<object id="gr_detail" classid="<%=LGauceId.GRID %>" style="width:100%;height:135px" class="comn_status">
					      <param name="DataID"          value="ds_detail" />
					      <param name="Editable"        value="true" />
					      <param name="UrlImages"       value="<I>Type='PopupBotton', Url='/sys/images/button/search_icon_2.gif', Fit='AutoFit', Flat='True'</I>">
					      <param name="TitleHeight"     value="30">
					      <param name="SortView"        value="Left">
					      <Param name="TitleHeight"     value="35">
					      <param name="Format"
					        value="
										<C>id='materNm'        name='Material'         width='150'  align='left'   editstyle='popupfix'</C>
					          <C>id='materCd'        name='Material'         width='70'   align='center' edit='none' show='true'  </C>
					          <C>id='unit'           name='Unit'             width='40'   align='center' edit='none'</C>
					          <C>id='storLoct'       name='Storage Loc.'     width='100'  align='center' EditStyle=Lookup Data='ds_storCd:code:name'</C>
					          <C>id='salesQty'       name='Sales;Quantity'   width='80'   align='right'  </C>
					          <C>id='unitPrice'      name='Unit Price'       width='80'   align='right'  </C>
					          <C>id='salesAmt'       name='Sales;Amount'     width='110'  align='right'  edit='none' Dec=0</C>
					          <C>id='vatCd'          name='Tax Code(%)'      width='143'  align='left' EditStyle=Lookup Data='ds_vatCd:code:name'</C>
					          <C>id='vatAmt'         name='Tax Amount'       width='80'   align='right'  edit='none' value={Round(vatAmt,0)} Dec=0</C>
					          <C>id='totalAmt'       name='Total;Amount'     width='130'  align='right'  edit='none' value={Round(totalAmt,0)} Dec=0 </C>
					          <C>id='salesNo'        name='Sales No'         width='150'  align='left'   edit='none' show='false'</C>
					          <C>id='salesDate'      name='Sales Date'       width='70'   align='center' edit='none' show='false'</C>
					          <C>id='salesItemSeq'   name='Sales Item Seq'   width='70'   align='center' edit='none' show='false'</C>
					              " />
			        </object> 
			      </comment> <script>__WS__(__NSID__);</script></td>
			  </tr>
			</table>
		</div>
		<!-- 그리드 E --> <!--===================================================================-->
	
		<!-- 버튼 S -->
		<div id="btn_area">
	  	<p class="b_right">
	    	<span class="btn_r btn_l"><input type="button" onClick="f_addRowMain();"  onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%= btnNew %>"/></span>
	      <span class="btn_r btn_l"><input type="button" onClick="f_delete();"      onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%= btnDel %>"/></span>
	      <span class="btn_r btn_l"><input type="button" onClick="f_save();"        onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%= btnSave %>"/></span>
	      <%--
	      <span class="btn_r btn_l">|</span>
	      <span class="btn_r btn_l"><input type="button" onClick="f_sapSend();"     onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%= btnSapSend %>"/></span>
	      <span class="btn_r btn_l"><input type="button" onClick="f_sapCancel();"   onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%= btnSapCancel %>"/></span>
	       --%>
			</p>
		</div>
	<!-- 버튼 E -->
	
	</div>
	
	
<comment id="__NSID__">
<object id="re_report" classid="<%=LGauceId.REPORTS%>">
	<param name="MasterDataID", value="ds_report_main"> 
	<param name="DetailDataID", value="ds_report_dtl">
	<PARAM NAME="PaperSize" VALUE="A4">
	<PARAM NAME="Landscape" VALUE="false">
	<PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PrintMargine" VALUE="false">
	<param name="EnableFontFace" value="true"> 	
	<param name="EnglishUI" value="true"> 
	<param name="format"
		value="
		<B>id=FHeader ,left=0,top=0 ,right=2000 ,bottom=730 ,face='Tahoma' ,size=10 ,penwidth=1
			<X>left=11 ,top=479 ,right=728 ,bottom=574 ,border=true</X>
			<X>left=11 ,top=582 ,right=728 ,bottom=677 ,border=true</X>
			<X>left=1214 ,top=572 ,right=1931 ,bottom=667 ,border=true</X>
			<X>left=1214 ,top=479 ,right=1931 ,bottom=574 ,border=true</X>
			<C>id='addr1', left=5, top=116, right=836, bottom=161, align='left', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
			<C>id='addr2', left=5, top=161, right=836, bottom=206, align='left', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
			<C>id='addr3', left=5, top=206, right=836, bottom=251, align='left', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
			<C>id='addr4', left=5, top=251, right=836, bottom=296, align='left', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
			<C>id='addr5', left=5, top=296, right=836, bottom=341, align='left', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
			<C>id='addr6', left=5, top=341, right=836, bottom=386, align='left', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
			<T>id='DELIVERY ORDER' ,left=1273 ,top=24 ,right=1778 ,bottom=90 ,align='left' ,face='Arial' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
			<T>id='HIGHLAND CEMENT INTERNATAIONAL' ,left=5 ,top=29 ,right=1013 ,bottom=108 ,align='left' ,face='Arial' ,size=15 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
			<C>id='salesDate', left=1461, top=585, right=1921, bottom=640, align='left', face='Arial', size=9, bold=false, underline=false, italic=true, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
			<T>id='Sales Date:' ,left=1225 ,top=585 ,right=1447 ,bottom=640 ,align='left' ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=true ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
			<T>id='S/O Number :' ,left=1225 ,top=505 ,right=1447 ,bottom=561 ,align='left' ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=true ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
			<C>id='soNo', left=1461, top=505, right=1921, bottom=561, align='left', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
			<C>id='deliveryNm', left=209, top=598, right=709, bottom=654, align='left', face='Arial', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
			<T>id='Delivery :' ,left=16 ,top=598 ,right=204 ,bottom=654 ,align='left' ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=true ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
			<T>id='Customer :' ,left=21 ,top=497 ,right=209 ,bottom=553 ,align='left' ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=true ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
			<C>id='custNm', left=214, top=497, right=714, bottom=553, align='left', face='Arial', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
		</B>
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=122 ,face='Tahoma' ,size=10 ,penwidth=1
			<X>left=5 ,top=11 ,right=1924 ,bottom=122 ,border=true ,penstyle=solid ,penwidth=3</X>
			<L> left=1246 ,top=11 ,right=1246 ,bottom=122 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<L> left=1656 ,top=11 ,right=1656 ,bottom=122 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<L> left=1373 ,top=11 ,right=1373 ,bottom=122 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<L> left=312 ,top=11 ,right=312 ,bottom=122 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<L> left=984 ,top=11 ,right=984 ,bottom=122 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<T>id='No' ,left=13 ,top=45 ,right=79 ,bottom=98 ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='Material No.' ,left=87 ,top=45 ,right=310 ,bottom=95 ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='Qty' ,left=995 ,top=45 ,right=1241 ,bottom=95 ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='Unit' ,left=1254 ,top=45 ,right=1368 ,bottom=95 ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='Unit Price' ,left=1389 ,top=45 ,right=1651 ,bottom=95 ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='Amount' ,left=1667 ,top=45 ,right=1916 ,bottom=95 ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=82 ,top=11 ,right=82 ,bottom=122 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<T>id='Description' ,left=323 ,top=45 ,right=979 ,bottom=95 ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=45 ,face='Tahoma' ,size=10 ,penwidth=1
			<X>left=5 ,top=0 ,right=1924 ,bottom=45 ,border=true ,penstyle=solid ,penwidth=3</X>
			<C>id='seqNo', left=11, top=5, right=77, bottom=45, face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='materCd', left=87, top=5, right=307, bottom=45, face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='materNm', left=320, top=5, right=976, bottom=45, align='left', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='unit', left=1249, top=5, right=1365, bottom=45, face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='salesQty', left=992, top=5, right=1236, bottom=45, align='right', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='salesAmt', left=1659, top=5, right=1910, bottom=45, align='right', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
			<C>id='unitPrice', left=1447, top=5, right=1646, bottom=45, align='right', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=82 ,top=0 ,right=82 ,bottom=42 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<L> left=312 ,top=0 ,right=312 ,bottom=42 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<L> left=984 ,top=0 ,right=984 ,bottom=42 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<L> left=1246 ,top=0 ,right=1246 ,bottom=42 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<L> left=1373 ,top=0 ,right=1373 ,bottom=42 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<L> left=1656 ,top=0 ,right=1656 ,bottom=42 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		</B>
		<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=262 ,face='Tahoma' ,size=10 ,penwidth=1
			<X>left=984 ,top=0 ,right=1924 ,bottom=251 ,border=true ,penstyle=solid ,penwidth=3</X>
			<T>id='Sub Total' ,left=992 ,top=0 ,right=1159 ,bottom=53 ,align='left' ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='subTot', left=1381, top=0, right=1918, bottom=53, align='right', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Decao=2</C>
			<L> left=984 ,top=56 ,right=1921 ,bottom=56 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<L> left=984 ,top=116 ,right=1921 ,bottom=116 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<C>id='tot', left=1381, top=61, right=1918, bottom=114, align='right', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Decao=2</C>
			<T>id='Total' ,left=992 ,top=61 ,right=1159 ,bottom=114 ,align='left' ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=984 ,top=183 ,right=1921 ,bottom=183 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<C>id='vatAmount', left=1381, top=124, right=1918, bottom=177, align='right', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Decao=2</C>
			<T>id='Tax' ,left=992 ,top=124 ,right=1278 ,bottom=177 ,align='left' ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='gTot', left=1381, top=188, right=1918, bottom=241, align='right', face='Arial', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Decao=2</C>
			<T>id='Grand Total' ,left=992 ,top=188 ,right=1196 ,bottom=241 ,align='left' ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		</B>
		<B>id=Footer ,left=0 ,top=1771 ,right=1999 ,bottom=2870 ,face='Tahoma' ,size=10 ,penwidth=1
			<T>id='Sales Manager' ,left=1290 ,top=453 ,right=1589 ,bottom=505 ,face='Arial' ,size=9 ,bold=false ,underline=false ,italic=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='Approved by,' ,left=1310 ,top=148 ,right=1567 ,bottom=204 ,face='Arial' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='Sales Department' ,left=236 ,top=453 ,right=604 ,bottom=505 ,face='Arial' ,size=9 ,bold=false ,underline=false ,italic=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='Prepared by,' ,left=292 ,top=148 ,right=551 ,bottom=204 ,face='Arial' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		</B>
 ">
	</object>
	</comment>
	<SCRIPT>__WS__(__NSID__);</SCRIPT>
	
</body>
</html>