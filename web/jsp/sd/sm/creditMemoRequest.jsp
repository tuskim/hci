<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html xmlns="http://www.w3.org/1999/xhtml">
<%--
/*
 *************************************************************************
 * @source  :creditMemoRequest.jsp
 * @desc    : 가격정정
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2016.08.02   hskim        신규작성
 * ---  -----------  ----------  -----------------------------------------
 * HCI 시스템
 * Copyright(c) 2006-2007 LG CNS,  All rights reserved.
 *************************************************************************
 */
--%> 
<%@ page import = "java.util.*" %>
<%@ page import = "java.lang.*" %>
<%@ page import="devon.core.util.*" %>
<%@ page import="comm.util.*"%>
<%@ include file="/include/head.jsp" %>
<%
	String prevDate	   = LDateUtils.getDate("yyyy/MM/") +"01"; 		//조회시작 default 날짜
	String currentDate = LDateUtils.getDate("yyyy/MM/dd");          //조회조건 현재 날짜
	
	String msgInfoChange    = source.getMessage("dev.inf.com.nochange");    // no data for change.
	String msgSave            = source.getMessage("dev.cfm.com.save");      // Are you sure to save?
	String msgDelete          = source.getMessage("dev.cfm.com.delete");    // Are you sure to Delete?
	String msgCancel          = source.getMessage("dev.cfm.com.cancel");  // Are you sure to Continue?
	String msgContinue          = source.getMessage("dev.cfm.com.continue");  // Are you sure to Continue?
	String msgApproval          = source.getMessage("dev.cfm.com.approval");  // Are you sure to approval?
	String msgConfirm          = source.getMessage("dev.cfm.com.confirm");  // Are you sure to confirm?
	String msgSAPsend          = source.getMessage("dev.msg.po.sapsend");  // Are you sure to confirm?

%>
<html>
<head> 
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
	ds_status.DataID ="cm.cm.retrieveCommCodeCombo.gau?groupCd=2320&firstVal=Select";
	ds_status.Reset();	  
	ds_currCd.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2004";
	ds_currCd.Reset();		
	//ds_currCd.RowPosition = ds_currCd.NameValueRow("code","IDR");
	ds_memoCd.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2100";
	ds_memoCd.Reset();		
	ds_memoCd.RowPosition = ds_memoCd.NameValueRow("code","C");
	ds_vatCd.DataId="sd.sm.retrieveSalesMgmtVatACombo.gau?groupCd=2007";
	ds_vatCd.Reset();	 	
	ds_payTerm.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2206";
	ds_payTerm.Reset();	 
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
	for(var k=1; k<=ds_main.CountRow;k++){ 
  		 if(ds_main.NameValue(k,"chk")=="T"){	
			alert("<%=source.getMessage("dev.warn.com.continue")%>");
			return;
  	 	 }
	} 
	if(ds_detail.IsUpdated){
		if(!g_flug){
			alert("<%=source.getMessage("dev.warn.com.continue")%>");
			return;
		}
	}

	if(ds_main.CountRow<1){
		var strHeader =  "chk"               +   ":STRING(1)"
									+",salesNo"        +   ":STRING(13)"
									+",originalSalesNo"        +   ":STRING(13)"
									+",customer"             +   ":STRING(100)"
									+",customerCd"              +   ":STRING(50)"
									+",salesDate"         +   ":STRING(10)"
									+",docDate"         +   ":STRING(10)"
									+",postingDate"+  ":STRING(10)"
									+",grandTotalQty"  +   ":DECIMAL(13.3)"
									+",currencyCd"       +   ":STRING(3)"
									+",memoType"       +   ":STRING(4)"
									+",grandTotalAmt"      +   ":DECIMAL(13.2)"
									+",payTerm"		+ ":STRING(4)"
									+",originalAmt"         +   ":DECIMAL(13.2)"
									+",conditionValue"+   ":DECIMAL(13.2)"
									+",conditionVatAmt"       +   ":DECIMAL(13.2)"
									+",conditionVatCd"        +    ":STRING(20)"
									+",conditionTotalAmt"            +    ":DECIMAL(13.2)"
									+",status"          +   ":STRING(2)"
									+",sapSeq"  	+   ":STRING(6)"
									+",groupCd"          +   ":STRING(3)"
									+",sapRtnMsg"		+  ":STRING(300)"
									+",transDate"         +   ":STRING(10)"
									+",orgBillingNo"         +   ":STRING(10)"
									;					
		ds_main.SetDataHeader(strHeader);
    	cfHideNoDataMsg(gr_main);		
	}
	ds_main.AddRow();  

}

//Detail Add
function f_addRowDetail(){
	if(ds_main.NameValue(ds_main.RowPosition,"status")!=""){
		alert("<%=source.getMessage("dev.msg.po.statusAdd")%>");
		return;
	}
	if(ds_main.CountRow>0){
		if(ds_detail.CountRow<1){
			var strHeader =  "conditionValue"          +     ":DECIMAL(13)"
							+",conditionVatCd"          +    ":STRING(20)"
							+",conditionVatAmt"              +    ":DECIMAL(13)"
							+",conditionTotalAmt"            +    ":DECIMAL(13)";
			ds_detail.SetDataHeader(strHeader);
		}		 
		ds_detail.AddRow();  
	}
			ds_detail.NameValue(ds_detail.RowPosition,"conditionVatCd"        )="AM";
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
	grandTotalQty.Text = 0;
	grandTotalAmt.Text = 0;
	ds_main.DataID  = "/sd.sm.retrieveCementCreditMemoMgnt.gau?";
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
	for(var i=1; i<=ds_main.CountRow;i++){ 
	  	if(ds_main.NameValue(i,"chk")=="T"){
	  		chkCountNo++;
	 	}
	}	
	if(chkCountNo >1){
		alert("You must select only one." );
		return false;	  
	}
	if(f_isNull(ds_main.NameValue(ds_main.RowPosition,"status")) || ds_main.NameValue(ds_main.RowPosition,"status") == "9"){
		if(!ds_main.IsUpdated && !ds_detail.IsUpdated) {
			alert("<%=msgInfoChange%>" );
			return;
		}else{	
			if(f_vali()){
			    if(confirm("<%=msgSave%>")){
			        g_msPos = ds_main.RowPosition;
			        g_ddtPos = ds_detail.RowPosition;		
				    g_flug=true;
					tr_cudMaster.KeyValue = "Servlet( I:IN_DS1 = ds_main)";
					tr_cudMaster.Action   = "/sd.sm.cudCementCreditMemoMgnt.gau?";
					tr_cudMaster.post();
				}
			}
		}
	}else{
		alert("You can save, when the status is New, Confirm Or Error!");
		return false;
  	}
}

//Delele
function f_delete(){
	if(ds_main.CountRow<1){
		alert("<%=source.getMessage("dev.inf.com.nodelete")%>");
		return;
	}
	var chkCountNo=0;
	for(var i=1; i<=ds_main.CountRow;i++){ 
	  	if(ds_main.NameValue(i,"chk")=="T"){
	  		chkCountNo++;
	 	}
	}	
	if(chkCountNo >1){
		alert("You must select only one." );
		return false;	  
	}
	if(f_isNull(ds_main.NameValue(ds_main.RowPosition,"status")) || ds_main.NameValue(ds_main.RowPosition,"status") == "9"){
		if(confirm("<%=source.getMessage("dev.cfm.com.delete")%>")){
			if(ds_detail.RowPosition>0)	{
				ds_detail.DeleteAll();
			}	
			if(ds_main.RowPosition>0){	
				ds_main.DeleteRow(ds_main.RowPosition);
			}
		    g_flug=true;
			tr_dMaster.KeyValue = "Servlet( I:IN_DS1 = ds_main)";
			tr_dMaster.Action   = "/sd.sm.cudCementCreditMemoMgnt.gau?";
			tr_dMaster.post();
		}
	}else{
		alert("You can delete, when the status is New, Confirm Or Error!");
		return false;
  	}
}


//선택한 RowPosition이 Sales No. 생성된 경우 Sales Date 변경 못 하게 체크
function f_isSalesNoExist(asValue) {
	if(asValue == "SN"){
		if(ds_main.NameValue(ds_main.RowPosition, "salesNo") != ""){
			alert("Can not change the Original Sales No, \nClick the 'New' Button to create a new Credit Memo!");
			return;
		}
		f_openOriginalSalesNo();
	}
	if(asValue == "SD"){
		alert("Can not change the Sales Date!");
		return;
	}
}

//Original Sales No 조회 팝업
function f_openOriginalSalesNo(){
	openOriginalSalesNoWin();
}

// Original Sales No Popup
function openOriginalSalesNoWin() {

    var result = "";
    var firstList = new Array ();

    var popupId             = "OriginalSalesNo";
    var popupStr            = "/jsp/cm/cd/pop_" + popupId + ".jsp";

    var popType             = "?popType="           + "ptpam_" + popupId;
    var popupWidth          = "dialogWidth="        + "542px";
    var popupHeight         = ";dialogHeight="      + "400px";

    result = window.showModalDialog( popupStr + popType, popupId, popupWidth + popupHeight );
    if (result == -1 || result == null || result == "") {
        ds_main.NameValue(ds_main.RowPosition,"originalSalesNo") = "";
        ds_main.NameValue(ds_main.RowPosition,"customer") = "";
        ds_main.NameValue(ds_main.RowPosition,"customerCd") = "";
        ds_main.NameValue(ds_main.RowPosition,"salesDate") = "";
        ds_main.NameValue(ds_main.RowPosition,"grandTotalQty") = "0";
        ds_main.NameValue(ds_main.RowPosition,"currencyCd") = "";
        ds_main.NameValue(ds_main.RowPosition,"grandTotalAmt") = "0";
        ds_main.NameValue(ds_main.RowPosition,"payTerm") = "";
        ds_main.NameValue(ds_main.RowPosition,"originalAmt") = "0";
        ds_main.NameValue(ds_main.RowPosition,"status") = "";
        ds_main.NameValue(ds_main.RowPosition,"orgBillingNo") = "";
		grandTotalQty.Text = 0;
		grandTotalAmt.Text = 0;
		ds_detail.NameValue(ds_detail.RowPosition,"conditionVatCd") = "AM";
        return;
    } else {
	    firstList = result.split(";");
        ds_main.NameValue(ds_main.RowPosition,"originalSalesNo") =  firstList[0];
        ds_main.NameValue(ds_main.RowPosition,"customer") = firstList[1];
        ds_main.NameValue(ds_main.RowPosition,"customerCd") = firstList[2];
        ds_main.NameValue(ds_main.RowPosition,"salesDate") = firstList[3];
        ds_main.NameValue(ds_main.RowPosition,"grandTotalQty") =  firstList[4];
        ds_main.NameValue(ds_main.RowPosition,"currencyCd") =  firstList[5];
		ds_main.NameValue(ds_main.RowPosition,"grandTotalAmt") = firstList[6];
        ds_main.NameValue(ds_main.RowPosition,"payTerm") = firstList[7];
        ds_main.NameValue(ds_main.RowPosition,"originalAmt") = firstList[6];
        ds_main.NameValue(ds_main.RowPosition,"orgBillingNo") = firstList[8];
		grandTotalQty.Text = firstList[4];
		grandTotalAmt.Text = firstList[6];
		document.getElementById("docDate").value = firstList[3];
		document.getElementById("postingDate").value = firstList[3];
        ds_main.NameValue(ds_main.RowPosition,"status") = "";
		ds_detail.NameValue(ds_detail.RowPosition,"conditionVatCd") = firstList[9];
   }
}

//Save validation Check
function f_vali(){
	var val_flag = true;

	//ds_main validation
	if( f_isNull(ds_main.NameValue( ds_main.rowPosition , "originalSalesNo" ))){
		document.all.originalSalesNo.setActive();
		alert("<%=source.getMessage("dev.warn.com.input",columnData.getString("original_sales_no"))%>");
		return false;
	}
	if( f_isNull(ds_main.NameValue( ds_main.rowPosition , "salesDate" ))){
		document.all.salesDate.setActive();
		alert("<%=source.getMessage("dev.warn.com.input",columnData.getString("sales_date"))%>");
		return false;
	}
	if( f_isNull(ds_main.NameValue( ds_main.rowPosition , "docDate" ))){
		document.all.docDate.setActive();
		alert("<%=source.getMessage("dev.warn.com.input",columnData.getString("doc_date"))%>");
		return false;
	}
	if( f_isNull(ds_main.NameValue( ds_main.rowPosition , "postingDate" ))){
		document.all.postingDate.setActive();
		alert("<%=source.getMessage("dev.warn.com.input",columnData.getString("posting_date"))%>");
		return false;
	}
	if( f_isNull(ds_main.NameValue( ds_main.rowPosition , "memoType" ))){
		document.all.memoType.setActive();
		alert("<%=source.getMessage("dev.warn.com.input",columnData.getString("memo_type"))%>");
		return false;
	}
	if( f_isNull(ds_main.NameValue( ds_main.rowPosition , "conditionValue" ))){
		gr_detail.SetColumn("conditionValue" );
		alert("<%=source.getMessage("dev.warn.com.input",columnData.getString("condition_value"))%>");
		return false;
	}
	if( f_isNull(ds_main.NameValue( ds_main.rowPosition , "conditionVatCd" ))){
		gr_detail.SetColumn("conditionVatCd" );
		alert("<%=source.getMessage("dev.warn.com.input",columnData.getString("vat_cd"))%>");
		return false;
	}
	if( f_isNull(ds_main.NameValue( ds_main.rowPosition , "conditionTotalAmt" ))){
		gr_detail.SetColumn("conditionVatCd" );
		alert("<%=source.getMessage("dev.warn.com.input",columnData.getString("total_amount"))%>");
		return false;
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
	  		  	if(ds_main.NameValue(k,"status") != "0"  ){
	 				alert("You may not transfer in current status.");
	 				//alert("Check the Status of  "+ k + " row! \n Save the Credit Memo list." );
	 				return false;
	  		  	}
	  	 	 }
  		} 
		for(var j=1; j<=ds_main.CountRow;j++){ 
		  	if(ds_main.NameValue(j,"chk")=="T"){
			  	ds_main.NameValue(j,"salesDate") = funcReplaceStrAll(ds_main.NameValue(j,"salesDate"),"/","");
			  	ds_main.NameValue(j,"docDate") = funcReplaceStrAll(ds_main.NameValue(j,"docDate"),"/","");
			  	ds_main.NameValue(j,"postingDate") = funcReplaceStrAll(ds_main.NameValue(j,"postingDate"),"/","");
			}
		}
 	 		if(confirm("<%=msgSAPsend%>")){
					tr_sendMaster.Action   = "/sd.sm.cudCementCreditMemoSapSend.gau";
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
			if(f_isNull(ds_main.NameValue(j,"status")) || ds_main.NameValue(j,"status") == "0" || ds_main.NameValue(j,"status") == "8" || ds_main.NameValue(j,"status") == "9"){
 	 			alert("You may not cancel in current status.");
 //				alert("Check the Status of  "+ j + " row!, \nYou can cancel, when the status is Billing Confirm" );
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
		tr_sapCandMaster.Action   = "/sd.sm.cudCementCreditMemoSapCancel.gau";
		tr_sapCandMaster.Post();
	}
}

</script> 

<!-----------------------------------------------------------------------------
  프로그램 전용 D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- Grid 용 DataSet-->
<object id="ds_main" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true">
	<param name="ViewDeletedRow"    value="false">
</object>

<!-- Grid 용 DataSet-->
<object id="ds_detail" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true">
	<param name="ViewDeletedRow"    value="false">
</object>

<object id="ds_status"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"          value="true">
</object></comment>

<!-- lx Combo 용 DataSet-->
<object id="ds_currCd" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true"> 
</object> 

<!-- lx Combo 용 DataSet-->
<object id="ds_memoCd" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true"> 
</object> 

<object id="ds_vatCd" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true">
</object>

<!-- lx Combo 용 DataSet-->
<object id="ds_payTerm" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true"> 
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
<script language=JavaScript for=gr_main event=OnHeadCheckClick(Col,Colid,bCheck)>
	if(ds_detail.IsUpdated){
		if(!g_flug){	
			alert("<%=source.getMessage("dev.warn.com.continue")%>");
			return false;
		}
	}				
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

<!--grid DataSet -->
<script language=JavaScript for=ds_main event=OnLoadCompleted(rowCnt)>
	  cfHideDSWaitMsg(gr_main);//progress bar 숨기기
	  cfFillGridNoDataMsg(gr_main,"gridColLineCnt=2");//no data found   
	  mode = "";
</script>
<script language=JavaScript for=ds_main event=OnLoadStarted()>
	  cfShowDSWaitMsg(gr_main);//progress bar 보이기
	  cfHideNoDataMsg(gr_main);//no data 메시지 숨기기
	  mode = "";
</script>
 

<script language=JavaScript for="ds_main" event=OnRowPosChanged(row)>
 	var salesNo = ds_main.NameValue(row,"salesNo");
	ds_detail.ClearAll();
	if(row>0 && salesNo != "" ){
		ds_detail.DataID     = "/sd.sm.retrieveCementCreditMemoCondition.gau?";
		ds_detail.DataID    += "&salesDate="+funcReplaceStrAll(ds_main.NameValue(row,"salesDate"),"/","");
		ds_detail.DataID    += "&salesNo="+salesNo;
		ds_detail.DataID    += "&lang= "+"<%=g_lang%>";
		ds_detail.Reset();			      
		grandTotalQty.Text = ds_main.NameValue(ds_main.RowPosition,"grandTotalQty");
		grandTotalAmt.Text = ds_main.NameValue(ds_main.RowPosition,"grandTotalAmt");
	}else if(row>0 && salesNo == "" ){
		f_addRowDetail();
		grandTotalQty.Text = 0;
		grandTotalAmt.Text = 0;
	}
	g_flug = false;
</script>

<script language=JavaScript for=ds_main  event=CanRowPosChange(row)> 
	if(ds_detail.IsUpdated){
		if(!g_flug){	
			alert("<%=source.getMessage("dev.warn.com.continue")%>");
			return false;
		}
	}				
</script>

<script language=JavaScript for=ds_main  event=OnColumnChanged(row,colid)> 
	if(ds_main.CountRow>1){
		if(ds_detail.IsUpdated){
			if(!g_flug){	
			  	if ( colid == "chk") {
					ds_main.Namevalue(row,"chk") = "F";
					ds_main.resetStatus();
				}
				return false;
			}
		}
	}	
</script>

<script language="javascript"  for="ds_detail" event="OnColumnChanged(row,colid)">
  	if ( colid == "conditionValue") {
  	    if(ds_detail.NameValue(row,"conditionVatCd") == "AN"){
			ds_detail.NameValue(row,"conditionVatAmt") = ds_detail.NameValue(row,"conditionValue") * 0;
		}else if(ds_detail.NameValue(row,"conditionVatCd") == "AM"){
			ds_detail.NameValue(row,"conditionVatAmt") = ds_detail.NameValue(row,"conditionValue") * 0.05;
		}else{
			ds_detail.NameValue(row,"conditionVatAmt") = ds_detail.NameValue(row,"conditionValue") * 0;
		}
	}
  	if ( colid == "conditionVatCd") {
  	    if(ds_detail.NameValue(row,"conditionVatCd") == "AN"){
			ds_detail.NameValue(row,"conditionVatAmt") = ds_detail.NameValue(row,"conditionValue") * 0;
		}else if(ds_detail.NameValue(row,"conditionVatCd") == "AM"){
			ds_detail.NameValue(row,"conditionVatAmt") = ds_detail.NameValue(row,"conditionValue") * 0.05;
		}else{
			ds_detail.NameValue(row,"conditionVatAmt") = ds_detail.NameValue(row,"conditionValue") * 0;
		}
	}
	ds_detail.NameValue(row,"conditionTotalAmt") = Math.round(ds_detail.NameValue(row,"conditionValue")) + Math.round(ds_detail.NameValue(row,"conditionVatAmt"));
	ds_main.NameValue(ds_main.RowPosition,"conditionVatAmt") = Math.round(ds_detail.NameValue(row,"conditionVatAmt"));
	ds_main.NameValue(ds_main.RowPosition,"conditionVatCd") = ds_detail.NameValue(row,"conditionVatCd");
	ds_main.NameValue(ds_main.RowPosition,"conditionTotalAmt") = Math.round(ds_detail.NameValue(row,"conditionTotalAmt"));
	ds_main.NameValue(ds_main.RowPosition,"conditionValue") = Math.round(ds_detail.NameValue(row,"conditionValue"));
</script>

<!-----------------------------------------------------------------------------
    화면영역 시작
------------------------------------------------------------------------------>
</head>

<body id="cent_bg" onload="onLoad()">
<div id="conts_box">
	<h2> <span> <%=columnData.getString("page_title") %>  </span></h2>
	<!--검색 S -->	 
	 <fieldset class="boardSearch"> 
		<div>
			 <dl>
				<dt> 
					<table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board2">
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
							<th><%=columnData.getString("sales_date") %></th>
							<td><input type="text" id="salesDateFrom" name="salesDateFrom" value="<%= prevDate %>"  onblur="valiDate(this);"  style="width:65px;"/>&nbsp;
								<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(salesDateFrom);" style="cursor:hand"/> 
								~&nbsp;<input type="text" id="salesDateTo" name="salesDateTo"  value="<%= currentDate %>" onblur="valiDate(this);"   style="width:65px;"/>&nbsp;
								<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(salesDateTo);" style="cursor:hand"/> 
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
				<dd class="btnseat1"> 
						<span class="search_btn_r search_btn_l">
						<input type="button" onfocus="blur();" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='#e2ebf7'" value="Search" onclick="f_retrieve();"/></span> 
				</dd>											
			</dl>
		</div>
	</fieldset>
    <!--검색 E --><!--조회영역 끝 -->
     <div class="sub_stitle"> <p><%=columnData.getString("sub1_title") %>  </p> </div>        		
 	 <!-- 그리드 S -->	 <!--==============================Credit Memo List=====================================-->
     <div> 
			<table width="100%" border="0" cellspacing="0" cellpadding="0" >
			  <tr>
			    <td>
			      <comment id="__NSID__">
			        <object id="gr_main" classid="<%=LGauceId.GRID %>" style="width:100%;height:150px" class="comn_status">
			          <param name="DataID"              value="ds_main">
			          <param name="Editable"            value="true">
			          <param name="SortView" 			value="Left">			          
			          <param name="UrlImages"           value="<I>Type='PopupBotton', Url='/sys/images/button/cal_icon.gif', Fit='AutoFit', Flat='True'</I>">
			          <param name="UsingOneClick"       value="1">
			          <param name=ViewSummary           value="1">
			          <param name="Format"              value="
			          		<C>id='chk'			HeadAlign='center' HeadCheck=false  HeadCheckShow=true 	width='25'	EditStyle=CheckBox	 </c>
			            	<C>id='salesNo' 		name='<%=columnData.getString("sale_no") %>' 		 width='100' align='center'   Edit='none' </c>			            	
			            	<C>id='originalSalesNo' 		name='<%=columnData.getString("original_sales_no") %>'  width='110' align='center' Edit='none' show='true'</c>			            	
			            	<C>id='customer' 	name='<%=columnData.getString("customer") %>' 	 	 	width='160' align='left' Edit='none' </c>
			            	<C>id='customerCd' 	name='<%=columnData.getString("customer_cd") %>' 	width='70' align='center' Edit='none'  show='false'</c>
			            	<C>id='salesDate' name='<%=columnData.getString("sales_date") %>'  	width='100'  align='center' Edit='none'  show='false'</c>
			            	<C>id='docDate' name='<%=columnData.getString("doc_date") %>'  	width='100'  align='center' Edit='none'   show='false'</c>
			            	<C>id='postingDate' name='<%=columnData.getString("posting_date") %>'  	width='100'  align='center' Edit='none'   show='false'</c>
			            	<C>id='grandTotalQty'  	name='<%=columnData.getString("grand_total_qty") %>'  	 	width='150'  align='right'  Edit='none'   show='false' </c>
							<C>id='currencyCd'  name='<%=columnData.getString("currency_cd") %>' width='50' align='right' Edit='none' Data='ds_currCd:code:name'  EditStyle=Lookup    show='false'   </C>							
							<C>id='memoType'  name='<%=columnData.getString("memo_type") %>' width='70' align='right' Edit='none' Data='ds_memoCd:code:name'  EditStyle=Lookup    show='false'   </C>							
			            	<C>id='grandTotalAmt'  	name='<%=columnData.getString("grand_total_amount") %>'  	 	width='150'  align='right'  Edit='none'   show='false'</c>
							<C>id='payTerm'  name='<%=columnData.getString("terms_of_payment") %>' width='100' align='right' Edit='none' Data='ds_payTerm:code:name'  EditStyle=Lookup   show='false'</C>							
			            	<C>id='originalAmt' name='<%=columnData.getString("original_amount") %>'  	width='150'  align='center' Edit='none'   show='false'</c>
			            	<C>id='conditionValue'  	name='<%=columnData.getString("condition_value") %>'  	 	width='110'  align='right'  Edit='none' DEC='0' numeric</c>
							<C>id='conditionVatAmt'  name='<%=columnData.getString("condition_vat") %>' width='100' align='right' Edit='none'  DEC='0' numeric  sumtext='Total'</C>							
							<C>id='conditionVatCd'           name='<%=columnData.getString("vat_cd") %>'            width='120' align='right'      Data='ds_vatCd:code:name' EditStyle=Lookup   show='false'</C>
							<C>id='conditionTotalAmt'   	name='<%=columnData.getString("total_amount")%>'  width='110' align='right'  DEC='0' numeric  show='true' sumtext='@sum', sumbgcolor='#ECE6DE' sumcolor='#666666'</c> 
			            	<C>id='statusNm'   	name='<%=columnData.getString("status") %>'    		 	width='100' align='left' Edit='none'</c>
			            	<C>id='status'   	name='<%=columnData.getString("status") %>'    		 	width='100' align='center' Edit='none'   show='false'</c>
			            	<C>id='sapSeq'   	name='SAP SEQ'    		 	width='60' align='center' Edit='none' show='false'</c>
			            	<C>id='groupCd'   	name='Group CD'    		 	width='30' align='center' Edit='none' show='false'</c>
			            	<C>id='sapRtnMsg'   	name='SAP Return Message'    		 	width='300' align='left' Edit='none' </c>
			            	<C>id='transDate' name='Trans Date'  	width='70'  align='center' Edit='none' show='true' show='false'</c>
			            	<C>id='orgBillingNo'  	name='Original Billing NO'  width='100' align='center' Edit='none' show='false'</c>
					"/>
			        </object>
			      </comment>
			      <script>__WS__(__NSID__);</script>
			    </td>
			  </tr>
			</table>
      </div>
	<!-- 그리드 E -->	
	<div class="sub_stitle"> <p> <%= columnData.getString("sub2_title") %> </p> </div> 
	<!-- ==============================Sales Information=====================================-->
    <div id="output_board_area">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board" >
		<colgroup>
	        <col width="12%"/>
	        <col width="20%"/>
	        <col width="13%"/>
	        <col width="22%"/>
	        <col width="12%"/>
	        <col width=""/>
		</colgroup>    
	    <tr>
		  <th><%= columnData.getString("sale_no") %></th>
		  <td><input type="text" id="salesNo" 	style="width:110px;" maxlength="19" readonly class="txtField_read"></td>
		  <th><%= columnData.getString("original_sales_no") %></th>
          <td><input type="text" id="originalSalesNo" 	style="width:110px;" maxlength="19" readonly>
		  	<img src="<%= images %>button/search_icon_2.gif"  alt="customer search popup" onClick="javascript:f_isSalesNoExist('SN');" style="cursor:hand"/>
		  </td>
		</tr>
	    <tr>
		  <th><%= columnData.getString("customer") %></th>
		  <td><input type="text" id="customer" 	style="width:170px;" maxlength="50" readonly class="txtField_read"> </td>
		  <th><%= columnData.getString("terms_of_payment") %></th>
			<td>	
			<object id="termsOfPayment"  classid="<%=LGauceId.LUXECOMBO%>" align="absmiddle" width="150">
				<param name="ComboDataID"       value="ds_payTerm">
				<param name="ListCount"     	value="10">
				<param name="BindColumn"    	value="code">
				<param name="ListExprFormat"		value="name^0^150,code^0^50">
				<param name=Enable         value="false">
				<param name="index"           	value="0">
			</object>
			</td>
		</tr>
	    <tr>
		  <th><%= columnData.getString("sales_date") %></th>
		  <td><input type="text" id="salesDate" 	style="width:70px;" maxlength="10" readonly class="txtField_read">
		      <img id=docDateIcon src="<%= images %>button/cal_icon2.gif" alt="Calendar Icon" onClick="javascript:f_isSalesNoExist('SD');" style="cursor:hand"/>
		   </td>
		  <th><%= columnData.getString("grand_total_qty") %></th>
		  <td>
		  		<!-- input type="text" id="totalQty" 	style="width:130px;" maxlength="19" readonly -->
				<object id="grandTotalQty" classid="<%=LGauceId.EMEDIT%>" align="absmiddle" width="120">
				<param name="ReadOnly"      value="true">
				<param name="Alignment"     value="2">
				<param name=IsComma      value="true">
				<param name="PromptChar"      value="">
				<param name="MaxDecimalPlace"     value="3">
				</object>
		  </td>
		</tr>
	    <tr>
		  <th><%= columnData.getString("currency") %></th>
          <td>
			<object id="currCd"  classid="<%=LGauceId.LUXECOMBO%>" align="absmiddle" width="80">
				<param name="ComboDataID"       value="ds_currCd">
				<param name="ListCount"     	value="10">
				<param name="BindColumn"    	value="code">
				<param name=ListExprFormat		value="name^0^80,code^0^50">
				<param name=Enable         value="false">
				<param name=index           	value=0>
			</object>
		  </td>										
		  <th><%= columnData.getString("grand_total_amount") %></th>
		  <td>
		  		<!--  input type="text" id="totalAmount" 	style="width:130px;" maxlength="19" readonly -->
				<object id="grandTotalAmt" classid="<%=LGauceId.EMEDIT%>" align="absmiddle" width="120">
				<param name="ReadOnly"      value="true">
				<param name="Alignment"     value="2">
				<param name=IsComma      value="true">
				<param name="PromptChar"      value="">
				<param name="MaxDecimalPlace"     value="2">
				</object>
		  </td>
		</tr>
	    <tr>
		  <th><%= columnData.getString("memo_type") %></th>
          <td>
			<object id="memoType"  classid="<%=LGauceId.LUXECOMBO%>" align="absmiddle" width="80">
				<param name="ComboDataID"       value="ds_memoCd">
				<param name="ListCount"     	value="10">
				<param name="BindColumn"    	value="code">
				<param name=ListExprFormat		value="name^0^80,code^0^50">
				<param name=index           	value=0>
			</object>
		  </td>										
		  <th></th>
		  <td></td>
		</tr>
	    <tr>
		  <th><%= columnData.getString("doc_date") %></th>
		  <td><input type="text" id="docDate" 	style="width:70px;" maxlength="10" readonly >
		      <img id=docDateIcon src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(docDate);" style="cursor:hand"/>
		   </td>
		  <th><%= columnData.getString("posting_date") %></th>
		  <td><input type="text" id="postingDate" 	style="width:70px;" maxlength="10" readonly >
		      <img id=docDateIcon src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(postingDate);" style="cursor:hand"/>
		   </td>
		</tr>
	  </table>
	</div>
	<!-- 그리드 E -->	
	<object id=bd_main classid="<%=LGauceId.BIND%>">
		<param name=DataID value=ds_main>
		<param name=BindInfo 
			value='
                <C> Col=salesNo   Ctrl=salesNo      Param=value  </C>
                <C> Col=originalSalesNo   Ctrl=originalSalesNo      Param=value  </C>
                <C> Col=customer   Ctrl=customer      Param=value  </C>
                <C> Col=salesDate   Ctrl=salesDate        Param=value  </C>
                <C> Col=payTerm      Ctrl=termsOfPayment     Param=BindColVal  </C>
                <C> Col=currencyCd      Ctrl=currCd     Param=BindColVal  </C>
                <C> Col=memoType      Ctrl=memoType     Param=BindColVal  </C>
                <C> Col=docDate   Ctrl=docDate        Param=value  </C>
                <C> Col=postingDate   Ctrl=postingDate        Param=value  </C>
	  		'>
	</object>
   <div class="sub_stitle"> <!--==============================Sales Condition=====================================--> 
        <p><%=columnData.getString("sub3_title") %> </p>
	</div>
    <!-- 그리드 S -->	
	<div>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr>
		    <td>
		      <comment id="__NSID__">
		        <object id="gr_detail" classid="<%=LGauceId.GRID %>" style="width:100%;height:55px" class="comn_status">
		          <param name="DataID"              value="ds_detail"/>
		          <param name="Editable"            value="true"/>
		          <param name="UrlImages"         value="<I>Type='PopupBotton', Url='/sys/images/button/search_icon_2.gif', Fit='AutoFit', Flat='True'</I>">	
		          <param name="TitleHeight"         value="30"> 
		          <param name="SortView" 			value="Left">
		          <param name="Format"              value="
					<C>id='conditionValue'   	name='<%=columnData.getString("condition_value") %>'     width='100' align='right' Dec=0</C>
					<C>id='conditionVatCd'           name='<%=columnData.getString("vat_cd") %>'            width='150' align='left'  Data='ds_vatCd:code:name'  Edit='none' EditStyle=Lookup</C>
					<C>id='conditionVatAmt'   		name='<%=columnData.getString("vat_amount") %>'      width='100'  align='right'  Edit='none'  Value={Round(conditionVatAmt,0)} Dec=0</C>
					<C>id='conditionTotalAmt'   	name='<%=columnData.getString("total_amount")%>'  width='140' align='right'  Edit='none' Value={Round(conditionTotalAmt,0)} Dec=0</C>
		          "/>
		        </object>
		      </comment> 
		      <script>__WS__(__NSID__);</script>
		    </td>
		  </tr>
		</table>
	</div>
 	<!-- 그리드 E --> <!--===================================================================--> 	
	<!-- 버튼 S -->	
	<div id="btn_area">
		<p class="b_right">
			<span class="btn_r btn_l"> 
			<input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnNew%>" onclick="f_addRowMain();"/></span> 
			<span class="btn_r btn_l"> 
			<input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnDel%>" onclick="f_delete();"/></span>
			<span class="btn_r btn_l">
		    <input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnSave%>" onclick="f_save();"/></span>
		    <span>|</span> 
		    <span class="btn_r btn_l">
		    <input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnSapSend%>" onclick="f_sapSend();"/></span> 
	 		<span class="btn_r btn_l">
			<input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnSapCancel%>" onclick="f_sapCancel();"/></span>
		</p>
	</div>
	<!-- 버튼 E -->  
</div>
</body>
</html>