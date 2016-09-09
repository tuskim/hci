<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%--
/*
 *************************************************************************
 * @source  : cementSampleIssue.jsp
 * @desc    : Cement Sample Issue
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
	// 2319 Cement Sales Status
	ds_status.DataID ="cm.cm.retrieveCommCodeCombo.gau?groupCd=2321&firstVal=Select"; 
	ds_status.Reset();	  
	
	ds_currCd.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2004";
	ds_currCd.Reset();
	ds_currCd.RowPosition = ds_currCd.NameValueRow("code","IDR");

	//Storage Loc.
	ds_storCd.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2005";
	ds_storCd.Reset();
}


//Search 버튼 클릭
function f_retrieve(){
	ds_master.ClearAll();
	ds_detail.ClearAll();
	ds_master.DataID  = "/sd.si.retrieveCementSampleIssueMasterList.gau?";
    ds_master.DataID += "salesDateFrom="   + encodeURIComponent(salesDateFrom.value);
    ds_master.DataID += "&salesDateTo=" + encodeURIComponent(salesDateTo.value);
	ds_master.DataID += "&status=" 		   + ds_status.nameValue(ds_status.rowPosition,"code");
 	ds_master.DataID += "&lang="			   +"<%=g_lang%>";	
	ds_master.Reset();
	g_flug = false;
}

/***************************************************************************************************/
/*추가/및 삭제
/***************************************************************************************************/
// Main Add
function f_addRowMain(){ 
	if(ds_master.IsUpdated || ds_detail.IsUpdated){
		if(!g_flug){
			alert("<%=source.getMessage("dev.warn.com.continue")%>");
			return;
		}
	}
 
	if(ds_master.CountRow<1){
		var strHeader =  "chk"               +   ":STRING(1)"
									+",salesNo"        +   ":STRING(13)"
									+",customerCd"              +   ":STRING(50)"
									+",customer"             +   ":STRING(100)"
									+",deliveryCd"              +   ":STRING(50)"
									+",deliveryNm"             +   ":STRING(100)"
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
		ds_master.SetDataHeader(strHeader);
    	cfHideNoDataMsg(gr_main);		
	}
	ds_master.AddRow(); 
	ds_master.NameValue(ds_master.RowPosition,"currencyCd") = "MMK";
	//ds_master.NameValue(ds_master.RowPosition,"payTerm") ="PD03";
}

//Detail Add
function f_addRowDetail(){
	if(ds_master.NameValue(ds_master.RowPosition,"status")!=""){
		alert("Add only When the status is Sales Confirm!");
		return;
	}
	if(ds_master.CountRow>0){
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
		ds_detail.NameValue(ds_detail.RowPosition, "salesNo") = "";
		ds_detail.NameValue(ds_detail.RowPosition, "salesDate") = "";
		ds_detail.NameValue(ds_detail.RowPosition, "materCd") = "";
		ds_detail.NameValue(ds_detail.RowPosition, "unit") = "";
		ds_detail.NameValue(ds_detail.RowPosition, "unitPrice") = "0";
		ds_detail.NameValue(ds_detail.RowPosition, "vatCd") = "";
	}
}

//Detail Del
function f_delRowDetail(){
	if(ds_detail.CountRow==1){
		alert("<%=source.getMessage("dev.msg.po.itemchk")%>");
	} 
	
	if(ds_detail.CountRow > 1) {
		ds_detail.DeleteRow(ds_detail.RowPosition);
		f_calcDetailSum(); // 상세합계
	}
	
	//f_setCondition(); 
}

function f_calcDetailSum() {
	// 상세합계
	var detailSum = 0;
    for ( var i = 1; i <= ds_detail.CountRow; i++) {
//    	if(ds_detail.RowStatus(ds_detail.RowPosition) != "2") {
    		// 2: delete
			detailSum += ds_detail.NameValue(i,"salesQty");
  //  	}
    }
    grandTotalQty.Text = detailSum;  		
    ds_master.NameValue(ds_master.RowPosition,"grandTotalQty") = detailSum;
}

// Reflush이후  Row  원복
function f_setCondition(){
    g_msPos = ds_master.RowPosition;
    g_ddtPos = ds_detail.RowPosition;		
} 





/***************************************************************************************************/
/*버튼 클릭시
/***************************************************************************************************/



//save 버튼 클릭
function f_save() {
	var chkCountNo = 0;
	if (!ds_master.IsUpdated && !ds_detail.IsUpdated) {
		alert("<%=msgInfoChange%>");
		return;

	} else {
		for ( var inx = 1; inx <= ds_master.CountRow; inx++) {
			if (ds_master.NameValue(inx, "chk") == "T") {
				chkCountNo++;
			}
		}

		if (chkCountNo > 1) {
			alert("Select only one Sales List!");
			return;
		}

		if (f_isNull(ds_master.NameValue(ds_master.RowPosition, "status"))
				|| ds_master.NameValue(ds_master.RowPosition, "status") == "9") {
			// 9: Error

			if (f_vali()) {
				if (confirm("<%=msgSave%>")) {
					g_msPos = ds_master.RowPosition;
					g_ddtPos = ds_detail.RowPosition;
					g_flug = true;
					tr_cudMaster.KeyValue = "Servlet( I:IN_DS1 = ds_master, I:IN_DS2 = ds_detail )";
					tr_cudMaster.Action = "/sd.si.cudCementSampleIssue.gau?";
					tr_cudMaster.post();
				}
			}
		} else {
			alert("You can save, when the status is SAP Confirm Or Error!");
			return;
		}
	}
}

//Delele
function f_delete(){
	var chkCountNo=0;
	if(ds_master.CountRow<1){
		alert("<%=source.getMessage("dev.inf.com.nodelete")%>");
		return;
	}
	for(var inx=1; inx<=ds_master.CountRow;inx++){ 
  		if(ds_master.NameValue(inx,"chk")=="T"){
  			chkCountNo++;
  		}
  	}	
 	if(chkCountNo>1){
		alert("Select only one Sales List!");
		return;
	}
	if(f_isNull(ds_master.NameValue(ds_master.RowPosition,"status")) || ds_master.NameValue(ds_master.RowPosition,"status") == "9"){
		if(confirm("<%=source.getMessage("dev.cfm.com.delete")%>")){
			if(ds_detail.RowPosition>0)	{
				ds_detail.DeleteAll();
			}	
			if(ds_master.RowPosition>0)	{
				ds_master.DeleteRow(ds_master.RowPosition);
			}
		    g_flug=true;
			tr_dMaster.KeyValue = "Servlet( I:IN_DS1 = ds_master, I:IN_DS2 = ds_detail )";
			tr_dMaster.Action   = "/sd.si.cudCementSampleIssue.gau?";
			tr_dMaster.post();
		}
	}else{
		alert("You can delete, when the status is SAP Confirm Or Error!");
		return;
	}
}



//고객 조회 팝업
function f_openCustomer(p_mode){
	if(ds_master.NameValue(ds_master.RowPosition, "salesNo") != ""){
		alert("Can not change the Sales Date, \nBecause The Sales NO. was created!");
		return;
	}
	
	if(p_mode == "deliveryCd") {
		// Delivery
		openDelivery();
	} else {
		// Customer
		openVendorCodeListWin();
	}
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

function openDelivery() {

    var result = "";
    var firstList = new Array ();

    var popupId             = "CustomerCodeList";
    var popupStr            = "/jsp/cm/cd/pop_" + popupId + ".jsp";

    var vendCd              = "?deliveryCd="            + document.all.deliveryCd.value;
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

	//ds_master validation
	if( f_isNull(ds_master.NameValue( ds_master.rowPosition , "customerCd" ))){
		alert("<%=source.getMessage("dev.warn.com.input", "Customer")%>");
		return false;
	}
	if( f_isNull(ds_master.NameValue( ds_master.rowPosition , "deliveryCd" ))){
		alert("<%=source.getMessage("dev.warn.com.input", "Delivery")%>");
		return false;
	}
	if( f_isNull(ds_master.NameValue( ds_master.rowPosition , "salesDate" ))){
		alert("<%=source.getMessage("dev.warn.com.input","Issue Date")%>");
		return false;
	}
	if( f_isNull(ds_master.NameValue(ds_master.RowPosition,"grandTotalQty"))){
		alert("<%=source.getMessage("dev.warn.com.input","Issue Quantity")%>");
		return false;
	}
	if( f_isNull(ds_master.NameValue(ds_master.RowPosition,"currencyCd"))){
		alert("<%=source.getMessage("dev.warn.com.input","currencyCd")%>");
		return false;
	}

	//ds_detail validation
	for ( var i = 1; i <= ds_detail.CountRow; i++) {
		if( f_isNull(ds_detail.NameValue( i , "materNm" ))){
			alert("<%=source.getMessage("dev.warn.com.input","Marterial")%>");
			return false;
		}
		if( f_isNull(ds_detail.NameValue( i , "materCd" ))){
			alert("<%=source.getMessage("dev.warn.com.input","Marterial")%>");
			return false;
		}
		if( f_isNull(ds_detail.NameValue( i , "currentQty" ))){
			alert("<%=source.getMessage("dev.warn.com.input","Current Quantity")%>");
			return false;
		}
		if( f_isNull(ds_detail.NameValue( i , "salesQty" ))){
			alert("<%=source.getMessage("dev.warn.com.input","Issue Quantity")%>");
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
	if(ds_master.NameValue(ds_master.RowPosition, "salesNo") != ""){
		alert("Can not change the Sales Date, \nBecause The Sales NO. was created!");
		return;
	}
	OpenCalendar(salesDate);
}


//-------------------------------------------------------------------------
//SAP send (SAP Send 클릭시)
//-------------------------------------------------------------------------	 
function f_sapSend() {

	var chkCountNo = 0;
	var chkStatus = 0;

	for ( var inx = 1; inx <= ds_master.CountRow; inx++) {
		if (ds_master.NameValue(inx, "chk") == "T") {
			chkCountNo++;
		}
	}

	if (chkCountNo < 1) {
		// checkbox체크안된경우
		alert("<%=source.getMessage("dev.msg.fi.selectOne")%>" );
		return false;
	} else {
		// checkbox체크시
		for ( var k = 1; k <= ds_master.CountRow; k++) {
			if (ds_master.NameValue(k, "chk") == "T") {
				if (ds_master.NameValue(k, "status") == undefined) {
					alert("Check the Status of  " + k + " row! \n Save the sales Item.");
					return false;
				}
				if (ds_master.NameValue(k, "status") == "6") {
					alert("Check the Status of  " + k + " row! \n The status is Billing Confirm!");
					return false;
				}
				if (ds_master.NameValue(k, "status") == "8") {
					alert("Check the Status of  " + k + " row! \n The status is Error.");
					return false;
				}
			}
		}
		
		for ( var j = 1; j <= ds_master.CountRow; j++) {
			if (ds_master.NameValue(j, "chk") == "T") {
				ds_master.NameValue(j, "salesDate") = funcReplaceStrAll(ds_master.NameValue(j, "salesDate"), "/", "");
			}
		}
		
		if (confirm("<%=msgSAPsend%>")) {
			tr_sendMaster.Action = "/sd.si.cudCementSampleIssueSapSend.gau";
			tr_sendMaster.KeyValue = "Servlet( I:IN_DS1 = ds_master )";
			tr_sendMaster.Post();
		}
	}
}

//-------------------------------------------------------------------------
//SAP Cancel (SAP Cancel 클릭시)
//-------------------------------------------------------------------------	 
function f_sapCancel() {
	var chkCountNo = 0;
	for ( var i = 1; i <= ds_master.CountRow; i++) {
		if (ds_master.NameValue(i, "chk") == "T") {
			chkCountNo++;
		}
	}
	if (chkCountNo < 1) {
		alert("<%=source.getMessage("dev.msg.fi.selectOne")%>" );
		return false;
	}

	for ( var j = 1; j <= ds_master.CountRow; j++) {
		if (ds_master.NameValue(j, "chk") == "T") {
			if (f_isNull(ds_master.NameValue(j, "status")) || ds_master.NameValue(j, "status") == "8" || ds_master.NameValue(j, "status") == "9") {
				alert("Check the Status of  " + j + " row!, \nYou can cancel, when the status is SAP Confirm Or Error!");
				return false;
			}
		}
	}
	for ( var j = 1; j <= ds_master.CountRow; j++) {
		if (ds_master.NameValue(j, "chk") == "T") {
			ds_master.NameValue(j, "salesDate") = funcReplaceStrAll(ds_master.NameValue(j, "salesDate"), "/", "");
		}
	}
	if (confirm("<%=msgCancel%>")) {
		tr_sapCandMaster.KeyValue = "Servlet( I:IN_DS1 = ds_master )";
		tr_sapCandMaster.Action = "/sd.si.cudCementSampleIssueSapCancel.gau";
		tr_sapCandMaster.Post();
	}
}


</script>

<!-----------------------------------------------------------------------------
  프로그램 전용 D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- Grid 용 DataSet-->
<object id="ds_master" classid="<%=LGauceId.DATASET%>">
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
     ds_master.RowPosition = g_msPos;
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
     if(ds_master.CountRow >0){ 
        ds_master.RowPosition = 1;
        ds_detail.RowPosition= 1;	
     }	
	alert("<%=source.getMessage("dev.suc.com.delete")%>" );
</script>

<!--grid DataSet -->
<script language=JavaScript for=ds_master event=OnLoadCompleted(rowCnt)>
	  cfHideDSWaitMsg(gr_main);//progress bar 숨기기
	  cfFillGridNoDataMsg(gr_main,"gridColLineCnt=2");//no data found   
	  mode = "";
</script>
<script language=JavaScript for=ds_master event=OnLoadStarted()>
	  cfShowDSWaitMsg(gr_main);//progress bar 보이기
	  cfHideNoDataMsg(gr_main);//no data 메시지 숨기기
	  mode = "";
</script>

<script language=JavaScript for="ds_master" event=OnRowPosChanged(row)>
 	var salesNo = ds_master.NameValue(row,"salesNo");
	if(row>0 && salesNo != "" ) {
		
		ds_detail.DataID     = "/sd.si.retrieveSampleIssueDetailList.gau?";
		ds_detail.DataID    += "salesDate="+funcReplaceStrAll(ds_master.NameValue(row,"salesDate"),"/","");
		ds_detail.DataID    += "&salesNo="+salesNo;
		ds_detail.DataID    += "&lang= "+"<%=g_lang%>";
		ds_detail.Reset();
		
		grandTotalQty.Text = ds_master.NameValue(ds_master.RowPosition,"grandTotalQty");
		grandTotalAmt.Text = ds_master.NameValue(ds_master.RowPosition,"grandTotalAmt");
		//termsOfPayment.Enable = false;
		gr_detail.ColumnProp("salesQty", "Edit") = "none";
		gr_detail.ColumnProp("unitPrice", "Edit") = "none";
		gr_detail.ColumnProp("salesAmt", "Edit") = "none";
		
		
		
	}else if(row>0 && salesNo == "" ){
		ds_detail.ClearAll();
		f_addRowDetail();
		grandTotalQty.Text = 0;
		grandTotalAmt.Text = 0;
		//termsOfPayment.Enable = true;
		gr_detail.ColumnProp("salesAmt", "Edit") = true;
		gr_detail.ColumnProp("unitPrice", "Edit") = true;
		gr_detail.ColumnProp("salesQty", "Edit") = true;

	}
	g_flug = false;
</script>

<script language=JavaScript for=ds_master event=CanRowPosChange(row)> 
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
		for(var i=1; i <= ds_master.countRow; i++){
			ds_master.Namevalue(i,"chk") = "F";
			ds_master.resetStatus();
		}
	}else{//check
		for(var i=1; i <= ds_master.countRow; i++){
			ds_master.NameValue(i,"chk") = "T";	
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
  		// 수량입력시

  		/////////////////////////////////////////////////////////////
  		// 현재수량보다 적게 입력
  		if( ds_detail.NameValue(row,"salesQty") > ds_detail.NameValue(row,"currentQty")){
  			alert("You can not register Sales Qty Than Cunrrent Qty!");
  			ds_detail.NameValue(row,"salesQty") = "0";
  		}
  		/////////////////////////////////////////////////////////////
  		
  		f_calcDetailSum(); // 상세합계
	}
</script>


<!-----------------------------------------------------------------------------
    화면영역 시작
------------------------------------------------------------------------------>
</head>

<body id="cent_bg" onload="onLoad()">
<div id="conts_box">
<h2><span> Sample Issue </span></h2>



<!--검색 S -->
<fieldset class="boardSearch">
<div>
	<dl>
		<dt>
		<table width="100%" border="0" cellpadding="0" cellspacing="0"	class="output_board2" >
			<colgroup>
				<col width="15%"/>
				<col width="38%"/>
				<col width="11%"/>
				<col width=""/>
			</colgroup>
			<tr>
				<th>Issue Date</th>
				<td><input type="text" id="salesDateFrom" name="salesDateFrom" value="<%= prevDate %>" onblur="valiDate(this);" style="width:65px;" />&nbsp;
				<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(salesDateFrom);" style="cursor:hand" /> ~&nbsp;
				<input type="text" id="salesDateTo" name="salesDateTo" value="<%= currentDate %>" onblur="valiDate(this);" style="width:65px;" />&nbsp; 
				<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(salesDateTo);" style="cursor:hand" />
				</td>
				
				<th>Status</th>
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
				<input type="button" onfocus="blur();" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='#e2ebf7'" value="Search" onclick="f_retrieve();" />
			</span>
		</dd>
	</dl>
	</div>
</fieldset>
<!--검색 E --><!--조회영역 끝 -->



<div class="sub_stitle">
<p>Sample Issue List</p>
</div>
<!-- 그리드 S --> <!--==============================Sales List=====================================-->
<div>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td><comment id="__NSID__"> <object id="gr_main"
			classid="<%=LGauceId.GRID %>" style="width:100%;height:150px"
			class="comn_status">
			<param name="DataID" value="ds_master">
			<param name="Editable" value="true">
			<param name="SortView" value="Left">
			<param name="UrlImages" value="<I>Type='PopupBotton', Url='/sys/images/button/cal_icon.gif', Fit='AutoFit', Flat='True'</I>">
			<param name="UsingOneClick" value="1">
			<param name=ViewSummary           value="1">
			<param name="Format"
				value="
			          		<FC>id='chk'				HeadAlign='center' 		HeadCheck=false  HeadCheckShow=true 	width='20'	EditStyle=CheckBox	 </FC>
			            	<C>id='salesNo' 		name='Sample Issue No' 	width='100' align='center'  Edit='none' </c>			            	
			            	<C>id='salesDate' 		name='Issue Date'  		width='80'  align='center' 	Edit='none' sumtext='Total'</c>
			            	<C>id='customerCd' 		name='customerCd' 		width='70' 	align='center' 	Edit='none' show='false'</c>
			            	<C>id='customer' 		name='Customer' 	 	width='160' align='left' 	Edit='none' </c>
			            	<C>id='deliveryCd' 		name='deliveryCd' 		width='70' 	align='center' 	Edit='none' show='false'</c>
			            	<C>id='deliveryNm' 		name='Delivery' 	 	width='160' align='left' 	Edit='none' </c>
			            	<C>id='grandTotalQty'  	name='Issue Quantity' 	width='95'  align='right'  	Edit='none' sumtext='@sum', sumbgcolor='#ECE6DE' sumcolor='#666666'</c>
							<C>id='currencyCd'  	name='Currency' 		width='60' 	align='right' 	Edit='none' Data='ds_currCd:code:name'  EditStyle=Lookup     </C>							
			            	<C>id='grandTotalAmt'  	name='Sales Amount'	 	width='120' align='right'  	Edit='none' Value={Round(grandTotalAmt,0)} Dec=0 sumtext='@sum', sumbgcolor='#ECE6DE' sumcolor='#666666'</c>
			            	<C>id='statusNm'   		name='Status'   	 	width='100' align='left' 	Edit='none'</c>
			            	<C>id='status'   		name='status'  		 	width='100' align='center' 	Edit='none' show='false'</c>
			            	<C>id='giIfDocSeq' 		name='SAP G/I No' 	 	width='100' align='center' 	Edit='none' show='true'</c>
						    <C>id='sapRtnMsg'   	name='SAP Message'      width='400' align='left'	Edit='none' show='true'      </C>
					  " />
		</object> </comment> <script>__WS__(__NSID__);</script></td>
	</tr>
</table>
</div>





<div class="sub_stitle">
<p>Sample Issue Information</p>
</div>
<!-- ==============================Sales Information=====================================-->
<div id="output_board_area">
<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="output_board">
	<colgroup>
		<col width="12%" />
		<col width="20%" />
		<col width="13%" />
		<col width="22%" />
		<col width="12%" />
		<col width="" />
	</colgroup>
	<tr>
		<th>Issue Date</th>
		<td>
			<input type="text" id="salesDate" name="salesDate" style="width:70px;" maxlength="10" readonly />
			<img id=docDateIcon src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:f_isSalesNoExist();" style="cursor:hand" />
		</td>
		 
		<th></th>
		<td>
		</td>
	</tr>
	<tr>
		<th>Customer</th>
		<td>
			<input type="text" id="vendNm" style="width:130px;" maxlength="500" readonly />
			<input type="hidden" id="vendCd" maxlength="19" />
			<img src="<%= images %>button/search_icon_2.gif" alt="customer search popup" onClick="javascript:f_openCustomer();" style="cursor:hand" />
		 </td>

		<th>Delivery</th>
		<td>
			<input type="text" id="deliveryNm" style="width:130px;" maxlength="500" readonly />
			<input type="hidden" id="deliveryCd" maxlength="19" />
			<img src="<%= images %>button/search_icon_2.gif" alt="customer search popup" onClick="javascript:f_openCustomer('deliveryCd');" style="cursor:hand" />
		 </td>
	</tr>
	<tr>
		<th>Issue Quantity</th>
		<td>
			<object id="grandTotalQty" classid="<%=LGauceId.EMEDIT%>" align="absmiddle" width="120">
			<param name="ReadOnly"      value="true">
			<param name="Alignment"     value="2">
			<param name=IsComma      value="true">
			<param name="PromptChar"      value="">
			<param name="MaxDecimalPlace"     value="3">
			</object>
		</td>
		
		<th>Issue Amount</th>
		<td>
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

<object id=bd_main classid="<%=LGauceId.BIND%>">
<param name=DataID value=ds_master>
<param name=BindInfo
	value='
               <C> Col=salesDate    	Ctrl=salesDate        	Param=value  </C>
               <C> Col=customerCd   	Ctrl=vendCd      		Param=value  </C>
               <C> Col=customer   		Ctrl=vendNm      		Param=value  </C>
               <C> Col=deliveryCd   	Ctrl=deliveryCd    		Param=value  </C>
               <C> Col=deliveryNm  		Ctrl=deliveryNm    		Param=value  </C>
  		'>
</object>
</div>





	
<div class="sub_stitle"><!--==============================Sales item=====================================-->
<p>Sample Issue Material</p>
<p class="rightbtn">
<span class="sbtn_r sbtn_l"> 
<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="<%=btnAddRow%>" onclick="f_addRowDetail();" />
</span> 
<span class="sbtn_r sbtn_l"> 
<input 	type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="<%=btnDelRow%>" onclick="f_delRowDetail();" />
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
                    <C>id='salesItemSeq'   	name='Seq'            	width='60'  align='center'  Edit='none'	show='false'</C>
		            <C>id='materCd'   	    name='materCd'  		width='90'  align='center'	edit='none' show='false'  </c> 
		            <C>id='materNm'   	    name='Material'      	width='200' align='left' 	editstyle='popupfix'</c> 
					<C>id='unit'   			name='Unit'       		width='40'  align='center' 	edit='none'</c> 
		          	<C>id='storLoct'       	name='Storage Loc.'     width='100' align='center' 	EditStyle=Lookup Data='ds_storCd:code:name'</C>
					<C>id='currentQty'   	name='currentQty'   	width='100'	align='right'	edit='none' show='false'</c> 
					<C>id='salesQty'   		name='Issue Quantity'   width='100'	align='right'</c> 
		          " />
		</object> </comment> <script>__WS__(__NSID__);</script></td>
	</tr>
</table>
</div>
<!-- 그리드 E --> <!--===================================================================-->






<!-- 버튼 S -->
<div id="btn_area">
	<p class="b_right">
		<span class="btn_r btn_l"><input type="button" onClick="f_addRowMain();" 		onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%= btnNew %>"/></span>
    	<span class="btn_r btn_l"><input type="button" onClick="f_delete();" 	    onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%= btnDel %>"/></span>
    	<span class="btn_r btn_l"><input type="button" onClick="f_save();" 	    onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%= btnSave %>"/></span>&nbsp;&nbsp;|&nbsp;
    	<span class="btn_r btn_l"><input type="button" onClick="f_sapSend();" 	    onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%= btnSapSend %>"  /></span>
    	<span class="btn_r btn_l"><input type="button" onClick="f_sapCancel();" 	onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%= btnSapCancel %>"  /></span>
	
</div>
<!-- 버튼 E -->




</div>
</body>
</html>