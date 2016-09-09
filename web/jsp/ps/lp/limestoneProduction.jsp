<%--
/*
 *********************************************************************************************
 * @source  : limestoneProduction.jsp
 * @desc    : Limestone Production
 *--------------------------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -------------------------------------------------------------
 * 1.0  2016/08/10   kjkim       Init
 * ---  -----------  ----------  -------------------------------------------------------------
 * PT-PAM System.
 * Copyright(c) 2006-2007 LG CNS,  All rights reserved.
 *********************************************************************************************
 */
--%>
<%@ page import="devon.core.util.*" %>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="blendTrans(Duration=0.0)" http-equiv="Page-Enter" />
<meta content="blendTrans(Duration=0.0)" http-equiv="Page-Exit" />
<title>Limestone Production</title>
<%@ include file="/include/head.jsp" %>

<%
  String prevDate    = LDateUtils.getDate("yyyy/MM/") +"01";
  String currentDate = LDateUtils.getDate("yyyy/MM/dd");                        // currentDate
  int lastDay        = LDateUtils.getLastDate(LDateUtils.getDate("yyyyMMdd"));
  String lastDate    = LDateUtils.getDate("yyyy/MM/") + lastDay;                  //  last day of month

  String msgWarnRetrieve    = source.getMessage("dev.warn.com.retrieve");         // please first retrieve!
  String msgSave            = source.getMessage("dev.cfm.com.save");              // Are you sure to save?
  String msgDelete          = source.getMessage("dev.cfm.com.delete");            // Are you sure to Delete?
  String msgApproval        = source.getMessage("dev.cfm.com.approval");          // Are you sure to Approval?
  String msgReject          = source.getMessage("dev.cfm.com.reject");            // Are you sure to Reject?
  String msgCompDebitCredit = source.getMessage("dev.msg.fi.diffDebitCredit");    // The debit and credit total are not right
  String msgSucProcess      = source.getMessage("dev.suc.com.process");           // successfully processed.
  String msgSucSave         = source.getMessage("dev.suc.com.save");              // successfully saved.
  String msgSucDel          = source.getMessage("dev.suc.com.delete");            // successfully deleted.
  String msgSucCancel       = source.getMessage("dev.suc.com.cancel");            // successfully canceled.
  String msgSucApproval     = source.getMessage("dev.suc.com.approval");          // successfully approvaled.
  String msgSucReject       = source.getMessage("dev.suc.com.reject");            // successfully rejected.
  
  String msgNoDataItem      = source.getMessage("dev.warn.com.noDataItem");       // The selected item does not exist.
  String msgMustReqMode     = source.getMessage("dev.msg.fi.condCheck");          // The selected condition must be Request Status.
  String msgNoNegativeNum   = source.getMessage("dev.msg.fi.noNegativeNum");      // The negative number will not be able to input!
  String msgInfoChange      = source.getMessage("dev.inf.com.nochange");          // no data for change.
  String msgNoDelete        = source.getMessage("dev.inf.com.nodelete");          // no data for deleting.
  String msgCheckEntryDate  = source.getMessage("dev.warn.com.checkEntryDate");   // Check searching condition.(Entry Date)
  String msgCheckDocDate    = source.getMessage("dev.warn.com.checkDocDate");     // Check searching condition.(Doc Date)
  String msgSAPsend         = source.getMessage("dev.msg.po.sapsend");            // Are you sure to SAP Send?
  String msgSAPcancel       = source.getMessage("dev.msg.po.sapcancelcontinue");  // Are you sure to SAP Cancel?
  String msgSAPsendSuc      = source.getMessage("dev.msg.po.sapsucess");          // successfully SAP Send.
  String msgSAPcancelSuc    = source.getMessage("dev.msg.po.sapcancel");          // successfully SAP Cancel.		  
  String msgSapRtnMsg       = source.getMessage("dev.warn.com.checkSapReturnMsg");// SAP sending error, please check the message.
  
  
  String msgNoData          = source.getMessage("dev.inf.com.nodata");            // no such data found.
  String msgNoDataSave      = source.getMessage("dev.inf.com.nosave");            // no data for saving.
  String msgNoDataDelete    = source.getMessage("dev.inf.com.nodelete");          // no data for deleting.
  String msgNoDataChange    = source.getMessage("dev.inf.com.nochange");          // no data for change.
%>

<script type="text/javascript">
parent.centerFrame.cols='220,*';
var g_mstRowPosition = 1;   //LimeStone Production List Row Position
//-------------------------------------------------------------------------
//Page Init
//-------------------------------------------------------------------------
function f_Init() {
  document.all.productDate.value = "<%=currentDate%>";
}

//-------------------------------------------------------------------------
//검색
//-------------------------------------------------------------------------
function f_Retrieve() {

    if (checkData()) {

    var condition = "?";
        condition += "companyCd=<%= g_companyCd %>";
        condition += "&status=" + progStatus.ValueOfIndex("code",progStatus.Index);
        condition += "&productDateFrom=" + removeDash(document.all.productDateFrom.value,"/");
        condition += "&productDateTo=" + removeDash(document.all.productDateTo.value,"/");

      //alert(condition);

    ds_master.DataID = "ps.lp.retrieveLimestoneProductionList.gau"+condition;
    ds_master.Reset();
    
    ds_master.RowPosition = g_mstRowPosition;
    
  }

}

//-------------------------------------------------------------------------
//검색 필수 체크
//-------------------------------------------------------------------------
function checkData() {

  if(document.all.productDateFrom.value == "") {
    alert('<%=source.getMessage("dev.warn.com.input", columnData.getString("from_date"))%>');
    document.all.productDateFrom.focus();
    return false;
  }
  
  if(document.all.productDateTo.value == "") {
    alert('<%=source.getMessage("dev.warn.com.input", columnData.getString("to_date"))%>');
      document.all.productDateTo.focus();
    return false;
  }
  
  return true;
}

//-------------------------------------------------------------------------
//New
//-------------------------------------------------------------------------
function f_New(){
	
  cfHideNoDataMsg(gr_master);//no data 메시지 숨기기
  
  ds_master.UndoAll();// 빈 row는 1개만 가능하도록 처리
  
  //ds_master Add Row
  var condition = "?";
      condition += "companyCd=<%=g_companyCd %>";
      condition += "&dsType=master";
  ds_masterTmp.DataID = "ps.lp.retrieveLimestoneProductionAddRow.gau"+condition;
  ds_masterTmp.Reset();

  if(ds_master.CountRow == 0){
    var strHeader =  "syskey"        +   ":STRING(10)"
                   +",prodDate"      +   ":STRING(10)"
                   +",postDate"      +   ":STRING(10)"
                   +",prodDateOld"   +   ":STRING(10)"
                   +",limestoneQty"  +   ":DECIMAL(13.3)"
                   +",status"        +   ":STRING(10)"
                   +",giIfDocSeq"    +   ":STRING(10)"
                   +",ReIfDocSeq"    +   ":STRING(10)"
                   +",giIfRvsDocSeq" +   ":STRING(10)"
                   +",ReIfRvsDocSeq" +   ":STRING(10)"
                   +",sapRtnMsg"     +   ":STRING(300)"
                   ;

    ds_master.SetDataHeader(strHeader);
  }

  ds_master.AddRow();

  ds_master.NameValue(ds_master.RowPosition, "syskey") = ds_masterTmp.NameValue(1, "syskey");
  ds_master.NameValue(ds_master.RowPosition, "prodDate") = ds_masterTmp.NameValue(1, "prodDate");
  ds_master.NameValue(ds_master.RowPosition, "limestoneQty") = ds_masterTmp.NameValue(1, "limestoneQty");
  ds_master.NameValue(ds_master.RowPosition, "status") = ds_masterTmp.NameValue(1, "status");

  //ds_input Add Row
      condition = "?";
      condition += "companyCd=<%=g_companyCd %>";
      condition += "&dsType=info";

  ds_inputTmp.DataID = "ps.lp.retrieveLimestoneProductionAddRow.gau"+condition;
  ds_inputTmp.Reset();

  ds_input.ClearData();
  if(ds_input.CountRow == 0){
    var strHeader =  "syskey"        +  ":STRING(10)"
                   +",materSeq"      +  ":STRING(4)"
                   +",materCd"      +   ":STRING(20)"
                   +",materNm"      +   ":STRING(50)"                     
                   +",unit    "     +   ":STRING(5)"
                   +",prodInQty"   +   ":DECIMAL(13.3)"
                   +",storLoct"     +   ":STRING(4)"
                   +",attr1"        +   ":STRING(300)";

    ds_input.SetDataHeader(strHeader);
  }

  for( var i=1; i <= ds_inputTmp.CountRow; i++ ) {
    ds_input.AddRow();

    ds_input.NameValue(ds_input.RowPosition, "materSeq")   = ds_inputTmp.NameValue(i, "materSeq");
    ds_input.NameValue(ds_input.RowPosition, "syskey")     = ds_inputTmp.NameValue(i, "syskey");
    ds_input.NameValue(ds_input.RowPosition, "materCd")    = ds_inputTmp.NameValue(i, "materCd");
    ds_input.NameValue(ds_input.RowPosition, "materNm")    = ds_inputTmp.NameValue(i, "materNm");    
    ds_input.NameValue(ds_input.RowPosition, "unit")       = ds_inputTmp.NameValue(i, "unit");
    ds_input.NameValue(ds_input.RowPosition, "prodInQty") = ds_inputTmp.NameValue(i, "prodInQty");
    ds_input.NameValue(ds_input.RowPosition, "storLoct")   = ds_inputTmp.NameValue(i, "storLoct");
    ds_input.NameValue(ds_input.RowPosition, "attr1")      = ds_inputTmp.NameValue(i, "attr1");
  }

  f_Enable();  //입력 필드 활성화.
}

//-------------------------------------------------------------------------
//Delete
//-------------------------------------------------------------------------
function f_Delete(){
	if(ds_master.CountRow == 0){
		alert("<%=msgNoDataDelete%>");
		return;
	}	

    var mstStatus = ds_master.NameValue(ds_master.RowPosition, "status");
    //00:Progress
    if(mstStatus != '00'){
    	alert("<%=source.getMessage("dev.msg.ps.statusDelete")%>");
        return;	
    }

    //0:Normal, 1:Insert, 2:Delete, 3:Update, 4:Logical
    var rowStatus = ds_master.RowStatus(ds_master.RowPosition);
	if( rowStatus == '1'){
		alert("Can't delete status.");
		return;
	}
	
	if(confirm("<%=msgDelete%>")){
		ds_master.UserStatus(ds_master.RowPosition)=2;//delete status update
		
		g_mstRowPosition = ds_master.RowPosition;  //Limestone Production List Row Position
		
		tr_cudDataDelete.KeyValue = "Servlet(I:IN_DS1=ds_master)";
		tr_cudDataDelete.Action   = "/ps.lp.cudLimestoneProductionDel.gau";
		tr_cudDataDelete.post();
	}
	
}

//-------------------------------------------------------------------------
//Save
//-------------------------------------------------------------------------
function f_Save(){
	if(ds_master.CountRow == 0){
		alert("<%=msgNoDataSave%>");
		return;
	}

	if(!ds_master.IsUpdated && !ds_input.IsUpdated) {
		// 변경여부 체크
		alert("<%=msgNoDataChange%>");
		return;
	} 
	
	if(ds_master.NameValue(ds_master.RowPosition,"prodDate") != ds_master.NameValue(ds_master.RowPosition,"prodDateOld")) {
		// Production Date 가 변경되거나 신규일때만 날짜 체크
		if(f_validationProdDate() == true) {
			var msg = "<%=source.getMessage("dev.warn.com.checkDuplicateDate")%>";
			msg += ds_master.NameValue(ds_master.RowPosition,"prodDate")
			alert(msg);
			return;
		} 
	}
	
	var limestoneQty = ds_input.NameValue(ds_input.RowPosition, "prodInQty");
	if(limestoneQty == 0){
		alert("<%=source.getMessage("dev.warn.com.inputQty","Limestone")%>");
		return;
	}
	
    var productStatus = ds_master.NameValue(ds_master.RowPosition, "status");
    //00:Progress
    if(productStatus != '00'){
    	alert("<%=source.getMessage("dev.msg.ps.statusSave")%>");
        return;	
    }
    
   if(confirm('<%=msgSave%>')){
	  
    g_mstRowPosition = ds_master.RowPosition;  //Limestone Production List Row Position
   
    tr_cudDataSave.KeyValue = "Servlet(I:IN_DS1=ds_master, I:IN_DS2=ds_input)";
    tr_cudDataSave.Action   = "/ps.lp.cudLimestoneProductionReg.gau";
    tr_cudDataSave.post();
    
  }
}

//-------------------------------------------------------------------------
//Approval
//-------------------------------------------------------------------------
function f_Approval(){
	if(ds_master.CountRow == 0){
		alert("<%=msgNoData%>");
		return;
	}

	var limestoneQty = ds_input.NameValue(ds_input.RowPosition, "prodInQty");
	if(limestoneQty == 0){
		alert("Input Material for Limestone Qty.");
		return;
	}

	var rowStatus = ds_master.RowStatus(ds_master.RowPosition);
    if(rowStatus != '0'){
    	alert("Please first save.");
        return;	
    }
    
	var productStatus = ds_master.NameValue(ds_master.RowPosition, "status");
    //00:Progress
    if(productStatus != '00'){
    	alert("<%=source.getMessage("dev.msg.ps.statusApproval")%>");
        return;	
    }
    
	if(confirm("<%=msgApproval%>")){
		
		ds_master.UserStatus(ds_master.RowPosition)=2;//delete status update
		
	    g_mstRowPosition = ds_master.RowPosition; //Limestone Production List Row Position
		
		tr_cudDataApproval.KeyValue = "Servlet(I:IN_DS1=ds_master)";
		tr_cudDataApproval.Action   = "/ps.lp.cudLimestoneProductionApproval.gau";
		tr_cudDataApproval.post();
	}
}

//-------------------------------------------------------------------------
//Reject
//-------------------------------------------------------------------------
function f_Reject(){
	if(ds_master.CountRow == 0){
		alert("<%=msgNoData%>");
		return;
	}

    var productStatus = ds_master.NameValue(ds_master.RowPosition, "status");
    //01:Approval
    if(productStatus != '01'){
    	alert("<%=source.getMessage("dev.msg.ps.statusReject")%>");
        return;	
    }
    
	if(confirm("<%=msgReject%>")){
		ds_master.UserStatus(ds_master.RowPosition)=2;//delete status update(Mater Table 변경을 위하여 강제 상태 변경)
		
		g_mstRowPosition = ds_master.RowPosition; //Limestone Production List Row Position
		
		tr_cudDataReject.KeyValue = "Servlet(I:IN_DS1=ds_master)";
		tr_cudDataReject.Action   = "/ps.lp.cudLimestoneProductionReject.gau";
		tr_cudDataReject.post();
	}
}


//-------------------------------------------------------------------------
//SAP Send
//-------------------------------------------------------------------------
function f_sapSend(){
	if(ds_master.CountRow == 0){
		alert("<%=msgNoData%>");
		return;
	}
	
    var productStatus = ds_master.NameValue(ds_master.RowPosition, "status");
    //01:Approval
    if(productStatus != '01'){
    	alert("<%=source.getMessage("dev.msg.ps.statusSapGRSend")%>");
        return;	
    }
    	
	if(confirm("<%=msgSAPsend%>")){
		
		ds_master.UserStatus(ds_master.RowPosition)=2;//delete status update
		
		g_mstRowPosition = ds_master.RowPosition; //Limestone Production List Row Position
		
		tr_sapSend.Action   = "/ps.lp.cudLimestoneProductionSAPsend.gau";
		tr_sapSend.KeyValue	= "Servlet( I:IN_DS1 = ds_master )"
 		tr_sapSend.Post();
	}	
	
}


//-------------------------------------------------------------------------
//SAP Cancel
//-------------------------------------------------------------------------
function f_sapCancel(){
	if(ds_master.CountRow == 0){
		alert("<%=msgNoData%>");
		return;
	}
	
    var productStatus = ds_master.NameValue(ds_master.RowPosition, "status");
    //03:SAP G/I
    if(productStatus != '03'){
    	alert("<%=source.getMessage("dev.msg.ps.statusSapGRCancel")%>");
        return;	
    }

	if(confirm("<%=msgSAPcancel%>")){
		
		ds_master.UserStatus(ds_master.RowPosition)=2;//delete status update
		
		g_mstRowPosition = ds_master.RowPosition; //LimeStone Production List Row Position
		
		tr_sapCancel.Action   = "/ps.lp.cudLimestoneProductionSAPcancel.gau";
		tr_sapCancel.KeyValue	= "Servlet( I:IN_DS1 = ds_master )"
		tr_sapCancel.Post();
	}	
}



//-------------------------------------------------------------------------
//Excel 조회
//-------------------------------------------------------------------------
function f_excelDown(){
	
    if (checkData()) {

        var condition = "?";
            condition += "companyCd=<%= g_companyCd %>";
            condition += "&status=" + progStatus.ValueOfIndex("code",progStatus.Index);
            condition += "&productDateFrom=" + removeDash(document.all.productDateFrom.value,"/");
            condition += "&productDateTo=" + removeDash(document.all.productDateTo.value,"/");

          //alert(condition);

        ds_excelDown.DataID = "ps.lp.retrieveLimestoneProductionExcelList.gau"+condition;
        ds_excelDown.Reset();
        
      }
}

//-------------------------------------------------------------------------
//Excel Download
//-------------------------------------------------------------------------
function f_excel() {
	gf_excel2(ds_excelDown,gr_excelDown,"<%= currentDate %>" ,"Limestone Production Report","c:\\");
}


//-------------------------------------------------------------------------
//Product Date Duplicate Check
//-------------------------------------------------------------------------
function f_validationProdDate() {
	var v_url = new cfURI();
	v_url.Add("sqlType", "prodDate");
	v_url.Add("prodDate", ds_master.NameValue(ds_master.RowPosition,"prodDate")); 

	v_url.SetPage("ps.lp.retrieveLimestoneProductionList.gau");
	ds_masterProdDate.DataId = v_url.GetURI();
	ds_masterProdDate.Reset(); 
	
	if(ds_masterProdDate.CountRow > 0) {
		return true; // 같은날짜 존재함	
	} else {
		return false; // 같은날짜 존재하지 않음
	}
}


//-------------------------------------------------------------------------
//Status가 PROCESS(00)인 경우에만 입력 enable처리.
//-------------------------------------------------------------------------
function f_Enable(){
	gr_input.ColumnProp("prodInQty", "Edit") = "";
	gr_input.ColumnProp("attr1", "Edit") = "";
	document.getElementById("productDate").readOnly = false;
	prodCalDate.disabled          = false;
	document.all.prodCalDate.src = "<%= images %>button/cal_icon.gif";	
}

//-------------------------------------------------------------------------
//Status가 PROCESS(00)이 아니면 입력 Disable
//-------------------------------------------------------------------------
function f_Disable() {
	gr_input.ColumnProp("prodInQty", "Edit") = "none";
	gr_input.ColumnProp("attr1", "Edit") = "none";
	document.getElementById("productDate").readOnly = true;
	prodCalDate.disabled          = true;
	document.all.prodCalDate.src = "<%= images %>button/cal_icon2.gif";	
}
</script>



<!-----------------------------------------------------------------------------
  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- CUD TR -->
<OBJECT id=tr_cudDataSave classid="<%=LGauceId.TR%>">
    <param name="KeyName"   value="toinb_dataid4">
    <param name="ServerIP"  value="">
</OBJECT>

<OBJECT id=tr_cudDataDelete classid="<%=LGauceId.TR%>">
    <param name="KeyName"   value="toinb_dataid4">
    <param name="ServerIP"  value="">
</OBJECT>

<OBJECT id=tr_cudDataApproval classid="<%=LGauceId.TR%>">
    <param name="KeyName"   value="toinb_dataid4">
    <param name="ServerIP"  value="">
</OBJECT>

<OBJECT id=tr_cudDataReject classid="<%=LGauceId.TR%>">
    <param name="KeyName"   value="toinb_dataid4">
    <param name="ServerIP"  value="">
</OBJECT>

<OBJECT id=tr_sapSend classid="<%=LGauceId.TR%>">
    <param name="KeyName"   value="toinb_dataid4">
    <param name="ServerIP"  value="">
</OBJECT>

<OBJECT id=tr_sapCancel classid="<%=LGauceId.TR%>">
    <param name="KeyName"   value="toinb_dataid4">
    <param name="ServerIP"  value="">
</OBJECT>
<!-----------------------------------------------------------------------------
    D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-- Grid 용 Limestone Production List DataSet-->
<object id="ds_master"  classid="<%=LGauceId.DATASET%>" >
  <param name="SyncLoad"            value="true">
  <param name="ViewDeletedRow"      value="false">
</object>

<object id="ds_masterTmp"   classid="<%=LGauceId.DATASET%>" >
  <param name="SyncLoad"            value="true">
  <param name="ViewDeletedRow"      value="false">
</object>

<!-- Grid 용Limestone Information -->
<object id="ds_input"   classid="<%=LGauceId.DATASET%>" >
  <param name="SyncLoad"          value="true">
  <param name="ViewDeletedRow"    value="false">
</object>

<object id="ds_inputTmp"    classid="<%=LGauceId.DATASET%>" >
  <param name="SyncLoad"          value="true">
  <param name="ViewDeletedRow"    value="false">
</object>

<!-- Status combo DataSet -->
<object id="ds_statusCode"  classid="<%=LGauceId.DATASET%>">
  <param name="SyncLoad"        value="true">
  <param name="DataID"          value="cm.cm.retrieveCommCodeCombo.gau?groupCd=2316&firstVal=Total">
</object>

<!-- Warehouse Combo DataSet -->
<object id="ds_warehouseCode" classid="<%=LGauceId.DATASET%>">
  <param name="SyncLoad"        value="true">
  <param name="DataID"          value="cm.cm.retrieveCommCodeCombo.gau?groupCd=2005">
</object>

<!-- Material Combo DataSet -->
<object id="ds_materialCode"  classid="<%=LGauceId.DATASET%>">
  <param name="SyncLoad"        value="true">
  <param name="DataID"          value="cm.cm.retrieveCommComboMaterList.gau">
</object>

<!-- Hidden Grid 용 Detail DataSet-->
<object id="ds_excelDown" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/> 
  <param name="ViewDeletedRow"    value="false"/>
</object>

<!-- Production Date Duplicate Check -->
<object id="ds_masterProdDate" 	classid="<%=LGauceId.DATASET%>" >
  <param name="SyncLoad"            value="true">
  <param name="ViewDeletedRow"      value="false">
</object>
<!-----------------------------------------------------------------------------
    G A U C E   C O M P O N E N T' S   E V E N T S
------------------------------------------------------------------------------>
<!-- Limestone Production List DataSet Event[S] -->
<script language=JavaScript for=ds_master event=OnLoadStarted()>
  cfShowDSWaitMsg(gr_master);//progress bar 보이기
  cfHideNoDataMsg(gr_master);//no data 메시지 숨기기
</script>
<script language=JavaScript for=ds_master event=OnLoadCompleted(rowCnt)>
 	cfHideDSWaitMsg(gr_master);//progress bar 숨기기
	cfFillGridNoDataMsg(gr_master,"gridColLineCnt=3");//no data found
	if(rowCnt == 0) document.all.productDate.value = "<%=currentDate%>";
</script>

<script language=javascript for=ds_master event=OnRowPosChanged(row)>

   if(ds_master.RowStatus(row) == '0' ){
    ds_master.UndoAll();
  }

  ds_input.ClearAll();

  if(row>0 && ds_master.RowStatus(row)!=1 ){
	var status = ds_master.NameValue(ds_master.RowPosition, "status");
    var param = "";
    param += "companyCd="+ds_master.NameValue(ds_master.RowPosition, "companyCd");
    param += "&syskey="+ds_master.NameValue(ds_master.RowPosition, "syskey");

    ds_input.DataID = "/ps.lp.retrieveLimestoneProductionInfo.gau?"+param;
    ds_input.Reset();

    if(status != '00'){
    	f_Disable();  //입력 필드 비활성화.
    }else{
    	f_Enable();  //입력 필드 활성화.
    }
    

  }
</script>

<script language=JavaScript for=ds_master event=OnLoadError()>
</script>
<!-- Limestone Production List DataSet Event[E] -->


<!-- Use of Material for Limestone DataSet Event[S] -->
<script language=javascript for=ds_input event=OnColumnChanged(row,colid)>

ds_master.NameValue(ds_master.RowPosition, "limestoneQty") = ds_input.NameValue(ds_input.RowPosition, "prodInQty");

</script>

<script language=Javascript for=gr_input event=OnClick(row,colid)>
	var status = ds_master.NameValue(ds_master.RowPosition, "status");
	//Clinker & Gypsum은 Material , Warehouse 수정 불가. Fixed
	if(status == "00" && row > 2){
		gr_input.ColumnProp("materCd", "Edit") = "";
		gr_input.ColumnProp("storLoct", "Edit") = "";
	}else{
		gr_input.ColumnProp("materCd", "Edit") = "none";
		gr_input.ColumnProp("storLoct", "Edit") = "none";
	}
</script>

<script language=javascript for=gr_input event=OnPopup(Row,Colid,data)>
	if ( Colid == "materCd") {
		openMaterialCodeListGridConWin(Row, ds_input)
	}
</script>

<script language=JavaScript for=ds_input event=OnLoadError()>
</script>
<!-- Use of Material for Limestone DataSet Event[E] -->

<script language=JavaScript for=ds_masterProdDate event=OnLoadError()>
	alert("Fail search Production date");
</script>

<!-- Transaction Grid Event [S] -->
<script language=JavaScript for=tr_cudDataSave event=OnSuccess()>
	alert("<%=msgSucSave%>");
	f_Retrieve();
</script>

<script language=JavaScript for=tr_cudDataSave event=OnFail()>
	if(tr_cudDataSave.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
		window.parent.location.href = "/index.jsp";    
	}

	alert(tr_cudDataSave.ErrorMsg);
	
	f_Retrieve();
</script>

<script language=JavaScript for=tr_cudDataDelete event=OnSuccess()>
	alert("<%=msgSucDel%>");
	f_Retrieve();
</script>

<script language=JavaScript for=tr_cudDataDelete event=OnFail()>
	if(tr_cudDataDelete.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
		window.parent.location.href = "/index.jsp";    
	}

	alert(tr_cudDataDelete.ErrorMsg);
	f_Retrieve();
</script>

<script language=JavaScript for=tr_cudDataApproval event=OnSuccess()>
	alert("<%=msgSucApproval%>");
	f_Retrieve();
</script>

<script language=JavaScript for=tr_cudDataApproval event=OnFail()>
	if(tr_cudDataApproval.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
		window.parent.location.href = "/index.jsp";    
	}

	alert(tr_cudDataApproval.ErrorMsg);
	f_Retrieve();
</script>

<script language=JavaScript for=tr_cudDataReject event=OnSuccess()>
	alert("<%=msgSucReject%>");
	f_Retrieve();
</script>

<script language=JavaScript for=tr_cudDataReject event=OnFail()>
	if(tr_cudDataReject.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
		window.parent.location.href = "/index.jsp";    
	}
	alert(tr_cudDataReject.ErrorMsg);
	f_Retrieve();
</script>

<script language=JavaScript for=tr_sapSend event=OnSuccess()>
	alert("<%=msgSAPsendSuc%>");
	f_Retrieve();
</script>

<script language=JavaScript for=tr_sapSend event=OnFail()>
	if(tr_sapSend.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
		window.parent.location.href = "/index.jsp";    
	}
	
	alert(tr_sapSend.ErrorMsg);
	<%--
	alert("<%=msgSapRtnMsg%>");
	--%>
	f_Retrieve();
</script>

<script language=JavaScript for=tr_sapCancel event=OnSuccess()>
	alert("<%=msgSAPcancelSuc%>");
	f_Retrieve();
</script>

<script language=JavaScript for=tr_sapCancel event=OnFail()>
	if(tr_sapCancel.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
		window.parent.location.href = "/index.jsp";    
	}
	alert(tr_sapCancel.ErrorMsg);
	<%--
	alert("<%=msgSapRtnMsg%>");
	--%>
	f_Retrieve();
</script>
<!-- Transaction Grid Event [E] -->

<script language=JavaScript for=ds_excelDown event=OnLoadCompleted(rowCnt)>
f_excel();
</script>

</head>


<body id="cent_bg" onload="f_Init();">

<div id="conts_box">
  <h2> <span>Limestone Production</span></h2>

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
							<th>Production Date</th>
							<td>
								<input type="text" onblur="valiDate(this);" style="width:70px;" id="productDateFrom" value="<%= prevDate %>" />
								<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="" onclick="javascript:OpenCalendar(productDateFrom);" class="button_cal"/>
								~
								<input type="text" onblur="valiDate(this);" style="width:70px;" id="productDateTo" value="<%= currentDate %>" />
								<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="" onclick="javascript:OpenCalendar(productDateTo);" class="button_cal"/>
							</td> 
							<th>Status</th>
							<td>
								<comment id="__NSID__"><object id="progStatus"  classid="<%=LGauceId.LUXECOMBO%>" width="150">
								<param name="ComboDataID"       value="ds_statusCode">
								<param name="ListCount"     	value="10">
								<param name=SearchColumn		value="name">
								<param name="BindColumn"    	value="code">
								<param name=ListExprFormat		value="name^0^90,code^0^70">
								<param name=index           	value=0>
								</object></comment><script>__WS__(__NSID__); </script>
							</td>
						</tr>
					</table>
				</dt>              		  	   	 	
				<dd class="btnseat1"> 
					<span class="search_btn_r search_btn_l">
						<input type="button" onfocus="blur();" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='#e2ebf7'" value="<%=btnSearch %>" onclick="f_Retrieve();"/>
					</span> 
				</dd>						
			</dl>
		</div>
	</fieldset>
      <!--검색 E -->

  <div class="sub_stitle">
    <p>Limestone Production List</p>
    <p class="rightbtn"> 
  	  <span class="excel_btn_r excel_btn_l">
        <input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="<%=btnExcelDown %>" onclick="f_excelDown()"/>
      </span>  
    </p>
  </div>

  <!-- 그리드 S -->
    <div>
      <object id="gr_master" classid="<%=LGauceId.GRID %>" style="width:100%;height:182px;" class="comn">
        <param name="DataID"      value='ds_master'>
        <Param name="AutoResizing"      value=true>
        <param name="ColSizing"         value=true>
        <Param name="DragDropEnable"    value=True>
        <param name="AddSelectRows"     value=True>
        <Param name="SortView"          value="right">
        <param name="Editable"          value=True>
        <Param name="TitleHeight"       value="35">
        <param name="UsingOneClick"     value="1">
        <param name="ViewSummary"       value="1">
        <param name='Format'
               value="
                   <C> id='syskey'        name='Production No.'                                     align='center'   width='140' Edit='none' show='true'      </C>
                   <C> id='prodDate'      name='Production Date'                                    align='center'   width='120' Edit='none' show='true'      sumtext='Total'</C>
                   <C> id='postDate'      name='Post Date'                                          align='center'   width='120' Edit='none' show='false'     </C>
                   <C> id='prodDateOld'   name='Old;Production Date'                                align='center'   width='120' Edit='none' show='false'     </C>
                   <C> id='limestoneQty'  name='Production;Quantity(KG)'                            align='right'    width='120' Edit='none' show='true'      DisplayFormat ='#,###.000' sumtext='@sum', sumbgcolor='#ECE6DE' sumcolor='#666666'</C>
                   <C> id='status'        name='Status'                                             align='center'   width='140' Edit='none' show='true'      EditStyle='LookUp'   Data='ds_statusCode:code:name'   </C>
                   
                   <C> id='ReIfDocSeq'    name='SAP Receipt No.'                                    align='center'   width='120' Edit='none' show='true'      </C>
                   <C> id='ReIfRvsDocSeq' name='SAP Cancel No.'                                     align='center'   width='120' Edit='none' show='true'      </C>
                   <C> id='sapRtnMSg'     name='SAP Message'                                        align='left'     width='400' Edit='none' show='true'      </C>
                 ">
      </object>
  </div>


  <div class="sub_stitle">
    <p>Limestone Information</p>
  </div>
    <!-- 검색 S -->
    <div id="output_board_area">
      <table width="758px" border="0" cellpadding="0" cellspacing="0" class="output_board" >
        <colgroup>
			<col width="12%"/>
			<col width="40%"/>
        </colgroup>
        <tr>
          <th>Production Date</th>
          <td>
            <input type="text" id="productDate"  value="<%=currentDate%>"  onblur="valiDate(this);" style="width:60px;"/>&nbsp;<img id="prodCalDate" src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(productDate);" style="cursor:hand"/>
          </td>
        </tr>
 	 
	</table>
  </div>
  <!-- 검색 E -->

  <!-- 그리드 S -->
    <div>
    	<table width="100%" border="0" cellpadding="0" cellspacing="0">
    		<tr>
    			<td>
    				<comment id="__NSID__">
					<object id="gr_input" classid="<%=LGauceId.GRID %>" style="width:100%;height:76px;" class="comn">
				        <param name="DataID"        value="ds_input">
				        <Param name="AutoResizing"  value="true">
				        <param name="ColSizing"     value="true">
				        <param name="ColSelect"     value="true">
				        <param name="AddSelectRows" value="True">
				        <param name="Sort"          value="true">
				        <param name="SortView"      value="right">
				        <param name="TitleHeight"   value="35">
				        <param name="UsingOneClick" value="1">
				        <param name="Editable"      value="true">
				        <param name="Format"
				               value="
				                       <C> id='materSeq'       name='Seq'            align='center'  width='60'   Edit='none'          Value={CurRow*10}  </C>
				                       <C> id='syskey'         name='Production No.' align='center'  width='120'  Edit='none'          show='false'</C>
				                       <C> id='materCd'        name='Material Code'  align='center'  width='100'  Edit='none'         show='true'     EditStyle='PopupFix'</C>
				                       <C> id='materNm'        name='Material Name'  align='left'    width='170'  Edit='none'          show='true'     <%--EditStyle='Lookup' Data='ds_materialCode:code:name'--%></C>
				                       <C> id='unit'           name='Unit'           align='center'  width='60'   Edit='none'          show='true'     sumtext='Total'</C>
				                       <C> id='prodInQty'      name='Qty.'           align='right'   width='90'   Edit='RealNumeric'   show='true'     DisplayFormat ='#,###.000' sumtext='@sum', sumbgcolor='#ECE6DE' sumcolor='#666666'</C>
				                       <C> id='storLoct'       name='Warehouse'      align='left'    width='140'  Edit='none'          show='true'     EditStyle='LookUp'   Data='ds_warehouseCode:code:name' </C>
				                       <C> id='attr1'          name='Description'    align='left'    width='138'                       show='true'     </C>
				                 ">
			        </object>
			        </comment><script>__WS__(__NSID__);</script>
		    	</td>
    		</tr>
      </table>
    </div>
  <!-- 그리드 E -->

  <!-- 버튼 S -->
    <div id="btn_area">
      <p class="b_right">
        <span class="btn_r btn_l"><input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnNew%>"      onClick="f_New();"/></span>
        <span class="btn_r btn_l"><input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnDel%>"      onClick="f_Delete();"/></span>
        <span class="btn_r btn_l"><input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnSave%>"     onClick="f_Save();"/></span>
        <span>|</span>
        <span class="btn_r btn_l"><input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnApproval%>"  onClick="f_Approval();"/></span>
        <span class="btn_r btn_l"><input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnReject%>"    onClick="f_Reject();"/></span>
        <span>|</span>
        <span class="btn_r btn_l"><input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnSapSend%>"   onclick="f_sapSend();"/></span>
        <span class="btn_r btn_l"><input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnSapCancel%>" onclick="f_sapCancel();"/></span>
      </p>
    </div>
    <!-- 버튼 E -->

    <div class="pad_t5"></div>
    <div name = "excelDown" style="width:0%;height:0px;">
    	<object id="gr_excelDown" classid="<%=LGauceId.GRID %>" style="width:100%;height:200px;" class="comn">
			<param name="DataID" 			value="ds_excelDown">
			<Param name="AutoResizing" 		value="true">
			<param name="ColSizing" 		value="true">
			<param name="ColSelect"  		value="true">
			<param name="AddSelectRows" 	value="true">
			<Param name="Sort"              value="true">
			<Param name="SortView" 			value="right">
			<Param name="TitleHeight"      	value="30">	
			<param name="UsingOneClick" 	value="1">
			<param name="Editable" 			value="false">
	        <param name="ViewSummary"         value="1">
			<param name="Format"
				value="
	               <C> id='syskey'      name='Production No.'                     align='center'   width='140' Edit='none' show='true'      </C>
	               <C> id='prodDate'    name='Production Date'                    align='center'   width='120' Edit='none' show='true'      Mask='XXXX/XX/XX'</C>
	               <C> id='status'      name='Status'                             align='center'   width='140' Edit='none' show='true'      EditStyle='LookUp'   Data='ds_statusCode:code:name'  sumtext='Total' </C>
	               
                   <G> name = 'Result of Production'
                     <C> id='limestoneQty'  name='Limestone'                       align='right'    width='160' Edit='none' show='true'      DisplayFormat ='#,###.000' sumtext='@sum', sumbgcolor='#ECE6DE' sumcolor='#666666'</C>
                   </G>
                   
		      ">
		</object>
    </div>   
    
	<comment id="__NSID__">
	<object id="bi_grid" classid="<%=LGauceId.BIND%>">
	  <param name="DataID" value="ds_master">
	  <param name="BindInfo"
	    value='
	        <C> Col=prodDate   Ctrl=productDate   Param=Value</C>
	        '/>
	
	</object>
	</comment>
	<SCRIPT>__WS__(__NSID__);</SCRIPT>

</div>
<input type="hidden" id="h_date"/>
</body>
</html>
