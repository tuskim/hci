<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--
/*
*************************************************************************
* @source  : cementPacking.jsp
* @desc    : Cement Packing
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
var g_flagDetail = false; // Detail작업 flag
var g_rowPosMaster = 0;   // save후  focus 제정의 Row
var g_rowPosDetail = 0;  // save후  focus 제정의 Row
var g_msg = "";

/***************************************************************************************************/
/*초기 세팅
/***************************************************************************************************/
function init(){
	f_setData(); // Ds 초기화(콤보)
}

// Ds 초기화(콤보)
function f_setData() {
	ds_masterStatus.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2315";
	ds_masterStatus.Reset();  
	cfUnionBlank(ds_masterStatus,lc_postatus,"code","name","--Total--"); 
}





/***************************************************************************************************/
/*조회
/***************************************************************************************************/

// Master 조회
function f_retrieve(){ 
	///////////////////////////////////////////////////////////////////////
	// 검색조건
	var v_url = new cfURI();
	v_url.Add("fromDate",encodeURIComponent(fromDate.value));
	v_url.Add("toDate"  ,encodeURIComponent(toDate.value));
	v_url.Add("status",ds_masterStatus.NameValue(ds_masterStatus.RowPosition,"code"));	
	///////////////////////////////////////////////////////////////////////

	v_url.SetPage("ps.pk.retrieveCementPackingMasterList.gau");
	ds_master.DataId = v_url.GetURI();
	ds_master.Reset(); 
}

//Detail 조회
function f_retrieveDetail(){
	///////////////////////////////////////////////////////////////////////
	// 검색조건
	var v_url = new cfURI();
	v_url.Add("syskey",ds_master.NameValue(ds_master.RowPosition,"syskey")); 
	///////////////////////////////////////////////////////////////////////

	v_url.SetPage("ps.pk.retrieveCementPackingDetailList.gau");
	ds_detail.DataId = v_url.GetURI();
	ds_detail.Reset(); 
}

//Result 조회
function f_retrieveResult(){
	///////////////////////////////////////////////////////////////////////
	// 검색조건
	var v_url = new cfURI();
	v_url.Add("syskey",ds_master.NameValue(ds_master.RowPosition,"syskey")); 
	///////////////////////////////////////////////////////////////////////

	v_url.SetPage("ps.pk.retrieveCementPackingResultList.gau");
	ds_result.DataId = v_url.GetURI();
	ds_result.Reset(); 
}


// Total Qty 계산
function f_calculation() {
	ds_master.NameValue(ds_master.RowPosition, "cementBagQty") =  ds_result.NameValue(ds_result.RowPosition, "prodInQty"); // 1 BAG = 50 KG
	ds_detail.NameValue(ds_detail.RowPosition, "prodOutQty") =  ds_result.NameValue(ds_result.RowPosition, "prodInQty") * 50 / 1000; // 1 BAG = 50 KG
}

/***************************************************************************************************/
/* 엑셀
/***************************************************************************************************/
function f_excelDown() {
	// 엑셀다운
	var v_url = new cfURI();
	v_url.Add("fromDate",encodeURIComponent(fromDate.value));
	v_url.Add("toDate"  ,encodeURIComponent(toDate.value));
	v_url.Add("status",ds_masterStatus.NameValue(ds_masterStatus.RowPosition,"code"));	
	///////////////////////////////////////////////////////////////////////

	v_url.SetPage("ps.pk.retrieveCementPackingExcelList.gau");
	ds_excelDown.DataID = v_url.GetURI();
	ds_excelDown.Reset();
}

function f_excel() {
	gf_excel2(ds_excelDown, gr_excelDown, "<%=currentDate%>", "Cement Packing Report","c:\\"); // 시트명 길이 31자 제한됨
}

/***************************************************************************************************/
/*저장
/***************************************************************************************************/
function f_save() {
	if(!ds_master.IsUpdated && !ds_detail.IsUpdated && !ds_result.IsUpdated) {
		// 변경여부 체크
		alert("<%=source.getMessage("dev.inf.com.nochange")%>");
		return;
	} 
	
	if(ds_result.NameValue(ds_result.RowPosition, "prodInQty") == 0){
		alert("<%=source.getMessage("dev.warn.com.inputQty","Cement Pack")%>");
		return;
	}	
	
    var rowStatus = ds_master.NameValue(ds_master.RowPosition, "status");
    if(rowStatus != '00'){
    	alert("<%=source.getMessage("dev.msg.ps.statusSave")%>");
        return;	
    }

	
	//변경한 데이터가 있는지 체크한다.
	if(confirm("<%=source.getMessage("dev.cfm.com.save")%>")){         
	    g_flagDetail = true;	    
		g_msg ="<%=source.getMessage("dev.suc.com.save")%>";	 
		
		f_setCondition(); // Reflush이후  Row  원복
		
		//////////////////////////////////////////////////////////////////////////////////////////
		// cud 호출
		tr_cudMaster.Action   = "ps.pk.cudCementPacking.gau";		
		tr_cudMaster.post();
		//////////////////////////////////////////////////////////////////////////////////////////
	} 
}



function f_validationProdDate() {
	///////////////////////////////////////////////////////////////////////
	// 검색조건
	var v_url = new cfURI();
	v_url.Add("sqlType", "prodDate");
	v_url.Add("prodDate", ds_master.NameValue(ds_master.RowPosition,"prodDate")); 
	///////////////////////////////////////////////////////////////////////

	v_url.SetPage("ps.pk.retrieveCementPackingMasterList.gau");
	ds_masterProdDate.DataId = v_url.GetURI();
	ds_masterProdDate.Reset(); 
	
	if(ds_masterProdDate.CountRow > 0) {
		return true; // 같은날짜 존재함	
	} else {
		return false; // 같은날짜 존재하지 않음
	}
}


function f_del() {
	
    var rowStatus = ds_master.NameValue(ds_master.RowPosition, "status");
    if(rowStatus != '00'){
    	alert("<%=source.getMessage("dev.msg.ps.statusDelete")%>");
        return;	
    }
    
	//변경한 데이터가 있는지 체크한다.
	if(confirm("<%=source.getMessage("dev.cfm.com.delete")%>")){         
		g_msg ="<%=source.getMessage("dev.suc.com.delete")%>";	 
		
		f_setCondition(); // Reflush이후  Row  원복
		
		ds_master.UserStatus(ds_master.RowPosition) = 2; // 0: normal, 1: insert, 2:delete
		
		//////////////////////////////////////////////////////////////////////////////////////////
		// cud 호출
		tr_cudMaster.Action   = "ps.pk.cudCementPacking.gau";		
		tr_cudMaster.post();
		//////////////////////////////////////////////////////////////////////////////////////////
	} 
}


/***************************************************************************************************/
/*추가
/***************************************************************************************************/
function f_new(){
	cfHideNoDataMsg(gr_master);//no data 메시지 숨기기
	
	////////////////////////////////////////////////////////////////////////////
	// 키생성
	var condition = "?";
	    condition += "companyCd=<%=g_companyCd %>";
		condition += "&dsType=master";
		
	ds_master.UndoAll();
	ds_masterTmp.DataID = "ps.pk.retrieveCementPackingAddRow.gau"+condition;
	ds_masterTmp.Reset();
	////////////////////////////////////////////////////////////////////////////

	
	
	////////////////////////////////////////////////////////////////////////////
	// 행추가 Master
	if(ds_master.CountRow == 0){
		var strHeader =  "syskey"        +   ":STRING(50)"
						+",prodDate"     +   ":STRING(50)"
						+",prodDateOld"     +   ":STRING(50)"
						+",cementBagQty"    +   ":DECIMAL(13.3)"
						+",status"       +   ":STRING(50)"
						+",giIfDocSeq"   +   ":STRING(50)"
						+",reIfDocSeq"   +   ":STRING(50)";
		
		ds_master.SetDataHeader(strHeader);
	}
	ds_master.AddRow();  
	
	ds_master.NameValue(ds_master.RowPosition, "syskey") = ds_masterTmp.NameValue(1, "syskey");
	ds_master.NameValue(ds_master.RowPosition, "prodDate") = ds_masterTmp.NameValue(1, "prodDate");
	ds_master.NameValue(ds_master.RowPosition, "cementBagQty") = ds_masterTmp.NameValue(1, "cementBagQty");
	ds_master.NameValue(ds_master.RowPosition, "status") = ds_masterTmp.NameValue(1, "status");
	////////////////////////////////////////////////////////////////////////////

	
	////////////////////////////////////////////////////////////////////////////
	// 행추가 Detail
	ds_detail.ClearData();
	ds_detail.DataID = "ps.pk.retrieveCementPackingAddRow.gau?dsType=detail";
	ds_detail.Reset();
	
	for(var i=1; i<=ds_detail.CountRow; i++) {
		ds_detail.NameValue(i, "syskey") = ds_masterTmp.NameValue(1, "syskey");
		ds_detail.UserStatus(i) =  1; // 1: Insert
	}
	////////////////////////////////////////////////////////////////////////////
	
	
	
	////////////////////////////////////////////////////////////////////////////
	// 행추가 Result
	ds_result.ClearData();
	ds_result.DataID = "ps.pk.retrieveCementPackingAddRow.gau?dsType=result";
	ds_result.Reset();	
	
	for(var i=1;i<=ds_result.CountRow;i++) {
		ds_result.NameValue(i, "syskey") = ds_masterTmp.NameValue(1, "syskey");
		ds_result.UserStatus(i) =  1; // 1: Insert
	}
	////////////////////////////////////////////////////////////////////////////
	
	document.getElementById("gr_master").focus();
	
	//f_Enable();
}


//-------------------------------------------------------------------------
//Status가 PROCESS(00)인 경우에만 입력 enable처리.
//-------------------------------------------------------------------------
function f_Enable(){
	gr_detail.ColumnProp("materCd", "Edit") = "";
	gr_detail.ColumnProp("materNm", "Edit") = "";
	gr_detail.ColumnProp("attr1", "Edit") = "";
	
	gr_result.ColumnProp("materCd", "Edit") = "";
	gr_result.ColumnProp("materNm", "Edit") = "";
	gr_result.ColumnProp("attr1", "Edit") = "";
	gr_result.ColumnProp("prodInQty", "Edit") = "";
	
	document.getElementById("prodDate").readOnly = false;
	document.all.prodCalDate.disabled          = false;
	document.all.prodCalDate.src = "<%= images %>button/cal_icon.gif";	
}

//-------------------------------------------------------------------------
//Status가 PROCESS(00)이 아니면 입력 Disable
//-------------------------------------------------------------------------
function f_Disable() {
	gr_detail.ColumnProp("materCd", "Edit") = "none";
	gr_detail.ColumnProp("materNm", "Edit") = "none";
	gr_detail.ColumnProp("attr1", "Edit") = "none";

	gr_result.ColumnProp("materCd", "Edit") = "none";
	gr_result.ColumnProp("materNm", "Edit") = "none";
	gr_result.ColumnProp("attr1", "Edit") = "none";
	gr_result.ColumnProp("prodInQty", "Edit") = "none";
	
	document.getElementById("prodDate").readOnly = true;
	document.all.prodCalDate.disabled          = true;
	document.all.prodCalDate.src = "<%= images %>button/cal_icon2.gif";	
}


/***************************************************************************************************/
/*EX
/***************************************************************************************************/
function f_approval() {
    if(ds_master.RowStatus(ds_master.RowPosition) != '0') {
    	alert("Please first save.");
        return;	
    }
    
	var rowStatus = ds_master.NameValue(ds_master.RowPosition, "status");
    if(ds_master.RowStatus(ds_master.RowPosition) == '1' || rowStatus != '00'){
    	alert("<%=source.getMessage("dev.msg.ps.statusApproval")%>");
        return;	
    }

	// 승인호출
	if(confirm("<%=source.getMessage("dev.cfm.com.approval")%>")){         
		g_msg ="<%=source.getMessage("dev.suc.com.approval")%>";	 

		f_setCondition(); // Reflush이후  Row  원복
		
		//////////////////////////////////////////////////////////////////////////////////////////
		// cud 호출
		ds_master.NameValue(ds_master.RowPosition, "status") = "01"; // 01:approval, 00: reject(progress)
		
		tr_cudMaster.Action   = "ps.pk.cudCementPackingStatus.gau";		
		tr_cudMaster.post();
		//////////////////////////////////////////////////////////////////////////////////////////
	} 
}

function f_reject() {
    var rowStatus = ds_master.NameValue(ds_master.RowPosition, "status");
    if(rowStatus != '01'){
    	alert("<%=source.getMessage("dev.msg.ps.statusReject")%>");
        return;	
    }

	// 거절호출
	if(confirm("<%=source.getMessage("dev.cfm.com.reject")%>")){         
		g_msg ="<%=source.getMessage("dev.suc.com.reject")%>";	 
		
		f_setCondition(); // Reflush이후  Row  원복

		//////////////////////////////////////////////////////////////////////////////////////////
		// cud 호출
		ds_master.NameValue(ds_master.RowPosition, "status") = "00"; // 01:approval, 00: reject(progress)

		tr_cudMaster.Action   = "ps.pk.cudCementPackingStatus.gau";		
		tr_cudMaster.post();
		//////////////////////////////////////////////////////////////////////////////////////////
	} 
}


function f_sapSend(){
	// SAP 전송
    var rowStatus = ds_master.NameValue(ds_master.RowPosition, "status");
    if(rowStatus != '01' && rowStatus != '03'){
    	alert("<%=source.getMessage("dev.msg.ps.statusSapSend")%>");
        return;	
    }
	
	if(confirm("<%=source.getMessage("dev.msg.po.sapsend")%>")){         
		g_msg ="<%=source.getMessage("dev.msg.po.sapsucess")%>";	 
		
		f_setCondition(); // Reflush이후  Row  원복

		//////////////////////////////////////////////////////////////////////////////////////////
		// cud 호출
		ds_master.UserStatus(ds_master.RowPosition) = 2; // 0: normal, 1: insert, 2:delete

		tr_cudMaster.Action   = "ps.pk.cudCementPackingSap.gau?sapType=f_sapSend";		
		tr_cudMaster.post();
		//////////////////////////////////////////////////////////////////////////////////////////
	} 
} 

function f_sapCancel(){
	// SAP 취소
    var rowStatus = ds_master.NameValue(ds_master.RowPosition, "status");
    if(rowStatus != '03' && rowStatus != '04'){
    	alert("<%=source.getMessage("dev.msg.ps.statusSapCancel")%>");
        return;	
    }
	
	if(confirm("<%=source.getMessage("dev.msg.po.sapcancelcontinue")%>")){         
		g_msg ="<%=source.getMessage("dev.msg.po.sapcancel")%>";	 
		
		f_setCondition(); // Reflush이후  Row  원복

		//////////////////////////////////////////////////////////////////////////////////////////
		// cud 호출
		ds_master.UserStatus(ds_master.RowPosition) = 2; // 0: normal, 1: insert, 2:delete

		tr_cudMaster.Action   = "ps.pk.cudCementPackingSap.gau?sapType=f_sapCancel";		
		tr_cudMaster.post();
		//////////////////////////////////////////////////////////////////////////////////////////
	} 
} 



// Reflush이후  Row  원복
function f_setCondition() {
    g_rowPosMaster = ds_master.RowPosition;
    g_rowPosDetail = ds_detail.RowPosition;		
} 




//Grid Material Popup
function openCementMaterialCodeListPopUp(row, obj, type) {
	var result = "";
	var firstList = new Array();

	var popupId = "ProductMaterialCodeListCon";
	var popupStr = "/jsp/cm/cd/pop_" + popupId + ".jsp";

	if (type != "") {
		popupStr = popupStr + "?type=" + type;
	}

	// var tgOneSelect = "&tgOneSelect=" + "T"; // 한 건인 경우 자동선택
	var popupWidth = "dialogWidth=" + "580px";
	var popupHeight = ";dialogHeight=" + "470px";

	result = window.showModalDialog(popupStr, popupId, popupWidth + popupHeight);

	if (result == -1 || result == null || result == "") {
		/*
		obj.NameValue(row, "materCd") = "";
		obj.NameValue(row, "materNm") = "";
		obj.NameValue(row, "unit") = "";
		*/
	} else {
		firstList = result.split(";");
		obj.NameValue(row, "materCd") = firstList[0];
		obj.NameValue(row, "materNm") = firstList[1];
		obj.NameValue(row, "unit") = firstList[2];
	}
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

<object id="ds_masterTmp" 	classid="<%=LGauceId.DATASET%>" >
  <param name="SyncLoad"            value="true">
  <param name="ViewDeletedRow"      value="false">
</object>

<object id="ds_masterProdDate" 	classid="<%=LGauceId.DATASET%>" >
  <param name="SyncLoad"            value="true">
  <param name="ViewDeletedRow"      value="false">
</object>

<object id="ds_excelDown" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/> 
  <param name="ViewDeletedRow"    value="false"/>
</object>




<!-- Grid 용 DataSet-->
<object id="ds_detail" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true">
	<param name="ViewDeletedRow"    value="false">
</object>


<!-- Grid 용 DataSet-->
<object id="ds_result" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true">
	<param name="ViewDeletedRow"    value="false">
</object>



 
<!-- lx Combo 용 DataSet-->
<object id="ds_masterStatus" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true"> 
</object>


<!-- Warehouse Combo DataSet -->
<object id="ds_warehouseCode"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
	<param name="DataID"          value="cm.cm.retrieveCommCodeCombo.gau?groupCd=2005">
</object>

<!-- Material Combo DataSet -->
<object id="ds_materialCode"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
	<param name="DataID"          value="cm.cm.retrieveCommComboMaterList.gau">
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
  gr_master.ColumnProp("cementBagQty", "SumText") = "@sum";
  ////////////////////////////////////////////////////////////////
</script> 

<script language=JavaScript for=ds_master event=CanRowPosChange(row)> 
</script>

<script language=JavaScript for="ds_master" event=OnRowPosChanged(row)>
	if(ds_master.RowStatus(row) == '0' ) {
		ds_master.UndoAll(); // 한건씩 처리하므로 수정으로 변경된 데이터를 복원함
	}	
	ds_detail.ClearAll();
	ds_result.ClearAll();
	
	
    //////////////////////////////////////////////////////////////////
	// 상태에 따라 수정 못하게(다른 상태에서 수정하여 보낼수 있음)
    if(ds_master.NameValue(ds_master.RowPosition, "status") != '00' && ds_master.NameValue(ds_master.RowPosition, "status") != ''){
    	f_Disable();  //입력 필드 비활성화.
    }else{
    	f_Enable();  //입력 필드 활성화.
    }
    //////////////////////////////////////////////////////////////////
	
	
	if(row>0 && ds_master.RowStatus(row)!=1){
		f_retrieveDetail(); // 상세조회 호출
		f_retrieveResult(); // 결과조회 호출
		//f_calculation();	 
	}
</script>


<!-- Dataset excel-------------------------------------------------------------------------------------->
<script language=JavaScript for=ds_excelDown event=OnLoadCompleted(rowCnt)>
	f_excel();
</script>


<!-- Dataset detail-------------------------------------------------------------------------------------->
<script language=JavaScript for=ds_detail event=OnColumnChanged(row,colid)>
</script>


<script language=JavaScript for=ds_detail event=OnLoadCompleted(rowCnt)>
</script> 


<!-- Dataset result-------------------------------------------------------------------------------------->
<script language=JavaScript for=ds_result event=OnColumnChanged(row,colid)>
	if(colid=="prodInQty") {
		if(Number(ds_result.NameValue(row,colid)) < 0){
			alert("<%=source.getMessage("dev.warn.com.minus",columnData.getString("qty"))%>"); // does not allow the value '-'.
			return false;
		}

		f_calculation(); // Total Qty 계산
	} 
</script>


<script language=JavaScript for=ds_result event=OnLoadCompleted(rowCnt)>
</script> 





<!-----------------------------------------------------------------------------
Grid   E V E N T S
------------------------------------------------------------------------------>
<!-- Grid Master-------------------------------------------------------------------------------------->
<script language=JavaScript for=gr_master event=OnKeyUp(row,colid,keycode)>
</script> 


<!-- Grid Detail-------------------------------------------------------------------------------------->
<script language="JavaScript" for="gr_detail" event="OnPopup(row,colid,data)">
 	if (colid == "materCd" || colid == "materNm") {
 		openCementMaterialCodeListPopUp(row, ds_detail,"SD");
	}
</script>


<!-- Grid Result-------------------------------------------------------------------------------------->
<script language="JavaScript" for="gr_result" event="OnPopup(row,colid,data)">
	if (colid == "materCd" || colid == "materNm") {
 		openCementMaterialCodeListPopUp(row, ds_result,"SD");
	}
</script>


 
 
 
 
 
 
 
 
<!-----------------------------------------------------------------------------
T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- CUD TR -->
<!-- Payment Arrange CUD TR -->
<OBJECT id=tr_cudMaster classid="<%=LGauceId.TR%>">
	<param name="KeyName"   value="toinb_dataid4"> 
	<param name="KeyValue"  value="JSP(I:ds_master=ds_master,I:ds_detail=ds_detail,I:ds_result=ds_result)">
	<param name="ServerIP"  value=""> 
</OBJECT>
 
 
 

<!-----------------------------------------------------------------------------
Tr   E V E N T S
------------------------------------------------------------------------------>
<script language=JavaScript for=tr_cudMaster event=OnSuccess()>
	g_flagDetail=false;  	
	ds_detail.UseChangeInfo="true"; 

	f_retrieve(); // 재조회
    ds_master.RowPosition    = g_rowPosMaster; // 그리드 위치 이동
    ds_detail.RowPosition  = g_rowPosDetail;	// 그리드 위치 이동	
	
    //gr_master.SetColumn("purDeptCd");
	alert(g_msg);
</script>  

<script language=JavaScript for=tr_cudMaster event=OnFail()>
	mode = ""; 
    ds_detail.UseChangeInfo="true"; 
	
    if(tr_cudMaster.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
		window.parent.location.href = "/index.jsp";    
	}
    
	g_flagDetail=false;  
	
	f_retrieve(); // 재조회
    ds_master.RowPosition    = g_rowPosMaster; // 그리드 위치 이동
    ds_detail.RowPosition  = g_rowPosDetail;	// 그리드 위치 이동	

    //gr_master.SetColumn("purDeptCd");
	alert(tr_cudMaster.ErrorMsg);
</script>

 
</head>

















<body id="cent_bg" onload="init();">
<div id="conts_box">
	<h2> <span> Cement Packing </span></h2>
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
							<th>Packing Date</th>
							<td>
								<input type="text" onblur="valiDate(this);" style="width:70px;" id="fromDate" value="<%= prevDate %>" />
								<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="" onclick="javascript:OpenCalendar(fromDate);" class="button_cal"/>
								~
								<input type="text" onblur="valiDate(this);" style="width:70px;" id="toDate" value="<%= currentDate %>" />
								<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="" onclick="javascript:OpenCalendar(toDate);" class="button_cal"/>
							</td> 
							<th>Status</th>
							<td>
								<comment id="__NSID__"><object id="lc_postatus"  classid="<%=LGauceId.LUXECOMBO%>" width="150">
								<param name="ComboDataID"       value="ds_masterStatus">
								<param name="ListCount"     	value="10">
								<param name=SearchColumn		value="name">
								<param name="BindColumn"    	value="code">
								<param name=ListExprFormat		value="name^0^150,code^0^70">
								<param name=index           	value=0>
								</object></comment><script>__WS__(__NSID__); </script>
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
		<p>Cement Packing List</p>
		<p class="rightbtn">
			<span class="excel_btn_r excel_btn_l">
				<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="<%=btnExcelDown %>" onclick="f_excelDown()"/>
			</span>   
		</p>			
	</div>    
		<!-- 그리드 Master S -->
		<div>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<comment id="__NSID__">
						<object id="gr_master" classid="<%=LGauceId.GRID %>" style="width:100%;height:168px;" class="comn">
							<param name="DataID"            value="ds_master"/> 
							<param name="Editable"          value="true"/>
							<Param name="AutoResizing"      value=true>
							<param name="UrlImages"         value="<I>Type='PopupBotton', Url='/sys/images/button/search_icon_2.gif', Fit='AutoFit', Flat='True'</I>">
        					<param name="ViewSummary"         value="1"/>
							<param name="Format"            
							value="
							    <FC> id='syskey'      	name='Packing No.'				align='center'   	width='140' Edit='none' show='true'      </FC>
							    <FC> id='prodDate'    	name='Packing Date'              align='center'   	width='120' Edit='none' show='true'		 </FC>
							    <C>  id='cementBagQty'     name='Packing;Quantity(KG)'     	align='right'   	width='120' Edit='none' show='true'     DisplayFormat ='#,###.000'</C>
							    <C>  id='status'       	name='Status'                       align='center'   	width='140' Edit='none' show='true' 	EditStyle='Lookup' Data='ds_masterStatus:code:name'</C>
								<G>  name='Packing Status'
							    <C>  id='giIfDocSeq'    name='SAP Issue No.'                align='center'   	width='120' Edit='none' show='true'      </C>
							    <C>  id='reIfDocSeq'   	name='SAP Receipt No.'              align='center'   	width='120' Edit='none' show='true'      </C>
							    </G>
								<G>  name='Cancel Status'
							    <C>  id='giIfRvsDocSeq' name='SAP Issue No.'                align='center'   	width='120' Edit='none' show='true'      </C>
							    <C>  id='reIfRvsDocSeq' name='SAP Receipt No.'              align='center'   	width='120' Edit='none' show='true'      </C>
							    </G>
							    <C>  id='sapRtnMsg'   	name='SAP Message'              	align='left'   		width='400' Edit='none' show='true'      </C>
	                        "/>
						</object>
						</comment><script>__WS__(__NSID__);</script>
					</td>
				</tr>
			</table>
		</div>
		<!-- 그리드 Master E -->


		
		
		<!-- 그리드 Detail S -->
	    <div class="sub_stitle"> <p>Use of Material for Packing</p>
		</div>	
		<div>
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board" >
				<colgroup>
				       <col width="12%"/>
				       <col width="40%"/>
				</colgroup>    
				<tr>
				  	<th>Packing Date</th>
					<td>
						<input type="text" id="prodDate" 	style="width:70px;" maxlength="10" onblur="valiDate(this);">
						<img id="prodCalDate" src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(prodDate);" style="cursor:hand"/>
					</td>
				</tr>
				<object id="bd_master" classid="<%=LGauceId.BIND%>">
					<param name="DataID" value="ds_master">
					<param name="BindInfo" 
						value='
			                <C> Col=prodDate    Ctrl=prodDate    Param=value      </C>
				  		'>
				</object>				
			</table>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<comment id="__NSID__">
						<object id="gr_detail" classid="<%=LGauceId.GRID %>" style="width:100%;height:64px;" class="comn">
							<param name="DataID"            value="ds_detail"/> 
							<param name="Editable"          value="true"/> 
					      	<param name="UrlImages"       	value="<I>Type='PopupBotton', Url='/sys/images/button/search_icon_2.gif', Fit='AutoFit', Flat='True'</I>">
							<Param name="AutoResizing"      value=true>
							<param name="ColSizing"         value=true>
							<Param name="DragDropEnable"    value=True>
        					<param name="ViewSummary"       value="0"/>
							<param name="Format"              
							value="
				           		<C> id='materSeq'       name='Seq'           align='center'  	width='60'   Edit='none'   	   	show='true'  	</C>
                       			<C> id='materCd'        name='Material Code' align='center'  	width='100'  Edit='none'        show='true'    EditStyle='popupfix' </C>
				           		<C> id='materNm'       	name='Material Name' align='left'  		width='170'  Edit='Any'        	show='true'	   EditStyle='popupfix'</C>
				           		<C> id='unit'           name='Unit'          align='center'  	width='60'   Edit='none'        show='true'	   	</C>
				           		<C> id='prodOutQty'     name='Qty.'          align='right'  	width='90'   Edit='none' 		show='true'	   DisplayFormat ='#,###.000'</C>
				           		<C> id='storLoct'     	name='Warehouse'     align='left'  		width='140'  Edit='none'        show='true'	   EditStyle='LookUp' 	Data='ds_warehouseCode:code:name'	</C>
				           		<C> id='attr1'          name='Description'   align='left'  		width='139'  Edit='Any'        	show='true'	   	</C>
	                        "/>
						</object>
						</comment><script>__WS__(__NSID__);</script>
					</td>
				</tr>
			</table>
		</div>
		<!-- 그리드 Detail E -->
		
		
		
		
		
		<!-- 그리드 Result S -->
	    <div class="sub_stitle"> <p>Result of Packing</p>
		</div>	
		<div>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<object id="gr_result" classid="<%=LGauceId.GRID %>" style="width:100%;height:64px;" class="comn">
							<param name="DataID"            value="ds_result"/> 
							<param name="Editable"          value="true"/>  
							<param name="UrlImages"         value="<I>Type='PopupBotton', Url='/sys/images/button/search_icon_2.gif', Fit='AutoFit', Flat='True'</I>">	
							<Param name="AutoResizing"      value=true>
							<param name="ColSizing"         value=true>
							<Param name="DragDropEnable"    value=True>
        					<param name="ViewSummary"       value="0"/>
							<param name="Format"              
							value="
				           		<C> id='materSeq'       name='Seq'           align='center'  	width='60'   Edit='none'   	   	show='true'  	</C>
                       			<C> id='materCd'        name='Material Code' align='center'  	width='100'  Edit='none'        show='true'    EditStyle='popupfix' </C>
				           		<C> id='materNm'       	name='Material Name' align='left'  		width='170'  Edit='none'        show='true'	   EditStyle='popupfix'</C>
				           		<C> id='unit'           name='Unit'          align='center'  	width='60'   Edit='none'        show='true'	   	</C>
				           		<C> id='prodInQty'     	name='Qty.'          align='right'  	width='90'   Edit='RealNumeric'	show='true'	   DisplayFormat ='#,###.000'</C>
				           		<C> id='storLoct'     	name='Warehouse'     align='left'  		width='140'  Edit='none'        show='true'	   EditStyle='LookUp' 	Data='ds_warehouseCode:code:name'	</C>
				           		<C> id='attr1'          name='Description'   align='left'  		width='139'  Edit='Any'        	show='true'	   	</C>
	                        "/>
						</object>
					</td>
				</tr>
			</table>
		</div>				
		<!-- 그리드 Result E -->
		
		
		
		
		
		<br>
		<!-- 버튼 S -->	
		<div id="btn_area">
			<p class="b_right">
				<span class="btn_r btn_l"><input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnNew%>" onclick="f_new();"/></span> 
				<span class="btn_r btn_l"><input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnDel%>" onclick="f_del();"/></span>
				<span class="btn_r btn_l"><input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnSave%>" onclick="f_save()"/></span>  								
<%
// 버튼 권한 처리
if(g_authCd.equals("AD") || g_authCd.equals("PDM")) {
%>
        		<span>|</span>
				<span class="btn_r btn_l"><input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnApproval%>" onclick="f_approval()"/></span>  								
				<span class="btn_r btn_l"><input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnReject%>" onclick="f_reject()"/></span>  								
<% 
}
%>
        		<span>|</span>
				<span class="btn_r btn_l"><input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnSapSend%>" onclick="f_sapSend();"/></span>  
				<span class="btn_r btn_l"><input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnSapCancel%>" onclick="f_sapCancel();"/></span> 
			</p>
		</div>
		<!-- 버튼 E --> 
		
		
		
		
		
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
			<param Name="Editable" 			value="true">
	        <param name=ViewSummary         value="1">
			<param Name="Format"
				value="
				    <C> id='syskey'      		name='Production No.'			align='center'   	width='140' Edit='none' show='true' 	</C>
				    <C> id='prodDate'    		name='Production Date'          align='center'   	width='120' Edit='none' show='true'		SumText='Total'</C>
				    <C> id='statusNm'       	name='Status'                   align='center'   	width='140' Edit='none' show='true' 	</C>
					<G> name='Use of Material'
				    <C> id='prodOut10Qty'     	name='Cement'     				align='right'   	width='120' Edit='none' show='true' 	DisplayFormat ='#,###.000'	SumText='@sum'</C>
				    </G>
					<G> name='Result of Production'
				    <C> id='cementBagQty'     	name='Packing Cement'     		align='right'   	width='120' Edit='none' show='true' 	DisplayFormat ='#,###.000'	SumText='@sum'</C>
				    </G>
		       ">
		</object>
    </div>   		
		
		
</div>


</body>
</html>
