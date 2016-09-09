<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--
/*
 ************************************************************************************************
 * @source  : assetList.jsp
 * @desc    : 실시간으로 SAP 의 자산 현황을 조회 하고 보유 자산 중, 매각 폐기를 요청 하는 화면
 *-----------------------------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  ----------------------------------------------------------------
 * 1.0  2015/12/21	 hckim		 Init      		 		  
 * ---  -----------  ----------  ----------------------------------------------------------------
 * Copyright(c) 2006-2007 LG CNS,  All rights reserved.
 ************************************************************************************************
 */
--%>
<%@ page import="devon.core.collection.LMultiData"%>
<%@ page import="devon.core.collection.LData"%>
<%@ page import="java.util.Date"%>
<%@ include file="/include/head.jsp"%>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<meta content="blendTrans(Duration=0.0)" http-equiv="Page-Enter" />
<meta content="blendTrans(Duration=0.0)" http-equiv="Page-Exit" />

<%@ page import="devon.core.util.*" %>
<jsp:useBean id="inputData" class="devon.core.collection.LData" scope="request"/>

<%	  
	String currentDate             = LDateUtils.getDate("yyyy/MM");                          // 현재 년월
	String msgInfoChange           = source.getMessage("dev.inf.com.nochange");              // no data for change.
	String msgSave                 = source.getMessage("dev.cfm.com.save");                  // Are you sure to save?
	String msgDelete               = source.getMessage("dev.cfm.com.delete");                // Are you sure to Delete?
	String msgContinue             = source.getMessage("dev.cfm.com.continue");              // Are you sure to Continue?	
	String msgWarnRetrieve         = source.getMessage("dev.warn.com.retrieve");             // please first retrieve!	
	String msgCheckNumber          = source.getMessage("dev.warn.com.checkNumber");          // Numbers only.		
	String magCheckAmount          = source.getMessage("dev.warn.com.checkAmount");          // Round off the numbers to the nearest thousandth.	
	String magCheckAssetNoRequest  = source.getMessage("dev.warn.com.checkAssetNoRequest");  // Please press the Check button.
	String magCheckAssetNoRequestY = source.getMessage("dev.warn.com.checkAssetNoRequestY"); // The asset already requested.
	String magCheckAssetNoRequestN = source.getMessage("dev.warn.com.checkAssetNoRequestN"); // You can request it.
	String msgChkCurrency          = source.getMessage("dev.warn.com.checkCurrency");        // The Currency IDR needs Integer Amount.
%> 

<head>

<script type="text/javascript">
parent.centerFrame.cols='220,*';

String.prototype.trim = function() { 
	return this.replace(/(^\s*)|(\s*$)/g, ""); 
}

String.prototype.replaceAll = function(va,re) { 
	
	var reValue = this; 
	
	while(reValue.search(va)  > -1){
		reValue = reValue.replace(va,re);
	} 
		 	
	return reValue; 
} 

//-------------------------------------------------------------------------
// 초기값 셋팅	 	
//-------------------------------------------------------------------------		
function init(){
	
	var frm = document.schForm;
	
	var saveYn        = "<%=inputData.getString("saveYn")%>";
	var yearMonth     = "<%=inputData.getString("yearMonth")%>";
	var costCenterIdx = "<%=inputData.getString("costCenterIdx")%>";
	var assetClassIdx = "<%=inputData.getString("assetClassIdx")%>";
	var assetNo       = "<%=inputData.getString("assetNo")%>";
	var assetNm       = "<%=inputData.getString("assetNm")%>";
	var resultMsg     = "<%=inputData.getString("resultMsg")%>";
	
	// 매각요청정보, 폐기요청정보 등록 인 경우
	if(saveYn == "Y"){
		
		// 등록 성공
		if(resultMsg == "Ok"){
			alert("<%=source.getMessage("dev.suc.com.save")%>");
		// 파일 사이즈 체크	결과	
		}else if(resultMsg == "FileSizeOver"){
			alert("<%=source.getMessage("dev.warn.com.filesize")%>");
		// 등록실패
		}else{
			alert(resultMsg);
		}
		
		frm.yearMonth.value = yearMonth;
		frm.costCenter.Index = costCenterIdx;
		frm.assetClass.Index = assetClassIdx;
		frm.assetNo.value = assetNo;
		frm.assetNm.value = assetNm;
				
		// Current Asset List 정보 조회
		f_Retrieve();
	}
}
 
//-------------------------------------------------------------------------
// 조회조건 입력시 	 	
//-------------------------------------------------------------------------				
function keyDownSch(evt){
	if ( evt.keyCode == 13 || evt == '^') {
		f_Retrieve();	
	}
}

//-------------------------------------------------------------------------
// Search 버튼 클릭 시 - Current Asset List 정보 조회 (SAP 호출)
//-------------------------------------------------------------------------
function f_Retrieve() {

	var frm = document.schForm;
	var assetClass = frm.assetClass.ValueOfIndex("code",frm.assetClass.Index);
	
	// Asset Class 조회 조건 필수 선택
	if(f_isNull(assetClass)){
		alert("<%=source.getMessage("dev.warn.com.select", columnData.getString("asset_class"))%>" );
		frm.assetClass.focus();
		return;
	}
	
	var condition = "?";
    	condition += "yearMonth=" + removeDash(frm.yearMonth.value,"/");
    	condition += "&costCenter=" + frm.costCenter.ValueOfIndex("code",frm.costCenter.Index);
    	condition += "&assetClass=" + frm.assetClass.ValueOfIndex("code",frm.assetClass.Index);
    	condition += "&assetNo=" + frm.assetNo.value;
    	condition += "&assetNm=" + frm.assetNm.value;
    	
    ds_grid.DataID = "fi.at.retrieveCurrentAssetList.gau"+condition;
	ds_grid.Reset();			
}				   	
		
//-------------------------------------------------------------------------
// Disposal 버튼 클릭시 (매각 요청 정보 저장)
//-------------------------------------------------------------------------			
function f_Disposal(){		
	
	var form = document.saveForm;
	var schForm = document.schForm;
	
	if(ds_grid.CountRow == 0) {
        alert("<%= msgWarnRetrieve %>"); // please first retrieve!
        return;
    }		 

	// 유효성 체크
	if (checkSaveData('D')) {

		// 매각 요청 정보
		var disposalRequestInfo = "?";
			disposalRequestInfo += "assetNm=" + form.assetNm.value;                                             // 자산명			
			disposalRequestInfo += "&assetNo=" + form.assetNo.value;                                            // 자산번호
			disposalRequestInfo += "&assetSubNo=" + form.assetSubNo.value;                                      // 자산서브번호
			disposalRequestInfo += "&requestDate=" + removeDash(form.requestDate.value,"/");                    // 요청일자
			disposalRequestInfo += "&amount=" + removeDash(form.amount.value,",");                              // 금액
			disposalRequestInfo += "&currCd=" + form.currCd.ValueOfIndex("code",form.currCd.Index);             // 통화코드
			disposalRequestInfo += "&qty=" + form.qty.value;                                                    // 수량
			disposalRequestInfo += "&unit=" + form.unit.value;						                            // 수량단위
			disposalRequestInfo += "&customerCd=" + form.customerCd.value;                                      // Vendor
			disposalRequestInfo += "&assetDesc=" + form.assetDesc.value;						                // 자산설명			
			disposalRequestInfo += "&sYearMonth=" + schForm.yearMonth.value;						            // 검색조건 (Year Month)
			disposalRequestInfo += "&sCostCenterIdx=" + schForm.costCenter.Index;                               // 검색조건 (Cost Center)
			disposalRequestInfo += "&sAssetClassIdx=" + schForm.assetClass.Index;                               // 검색조건 (Asset Class)
			disposalRequestInfo += "&sAssetNo=" + schForm.assetNo.value;                                        // 검색조건 (Asset No)
			disposalRequestInfo += "&sAssetNm=" + schForm.assetNm.value;                                        // 검색조건 (Asset Name)					
			
		if (confirm('<%= msgSave %>')) {
			form.action = "fi.at.cudDisposalRequest.dev"+disposalRequestInfo;
			form.submit();
			
			// 자산번호 - 매각, 폐기 신청여부 초기화
			form.assetNoRequestYn.value = "";
		}

	}

}

//-------------------------------------------------------------------------
// Retirement 버튼 클릭시 (폐기 요청 정보 저장)
//-------------------------------------------------------------------------			
function f_Retirement(){		
	
	var form = document.saveForm;
	var schForm = document.schForm;
	
	if(ds_grid.CountRow == 0) {
     	alert("<%= msgWarnRetrieve %>"); // please first retrieve!
     	return;
 	}

	// 유효성 체크
	if (checkSaveData('R')) {

		// 폐기 요청 정보
		var retirementRequestInfo = "?";
			retirementRequestInfo += "assetNm=" + form.assetNm.value;                                             // 자산명
			retirementRequestInfo += "&assetNo=" + form.assetNo.value;                                            // 자산번호
			retirementRequestInfo += "&assetSubNo=" + form.assetSubNo.value;                                      // 자산서브번호
			retirementRequestInfo += "&requestDate=" + removeDash(form.requestDate.value,"/");                    // 요청일자
			retirementRequestInfo += "&amount=" + removeDash(form.amount.value,",");                              // 금액
			retirementRequestInfo += "&currCd=" + form.currCd.ValueOfIndex("code",form.currCd.Index);             // 통화코드
			retirementRequestInfo += "&qty=" + form.qty.value;                                                    // 수량
			retirementRequestInfo += "&unit=" + form.unit.value;						                          // 수량단위
			retirementRequestInfo += "&customerCd=" + form.customerCd.value;                                      // Vendor
			retirementRequestInfo += "&assetDesc=" + form.assetDesc.value;						                  // 자산설명			
			retirementRequestInfo += "&sYearMonth=" + schForm.yearMonth.value;						              // 검색조건 (Year Month)
			retirementRequestInfo += "&sCostCenterIdx=" + schForm.costCenter.Index;                               // 검색조건 (Cost Center)
			retirementRequestInfo += "&sAssetClassIdx=" + schForm.assetClass.Index;                               // 검색조건 (Asset Class)
			retirementRequestInfo += "&sAssetNo=" + schForm.assetNo.value;                                        // 검색조건 (Asset No)
			retirementRequestInfo += "&sAssetNm=" + schForm.assetNm.value;                                        // 검색조건 (Asset Name)			
		
		if (confirm('<%= msgSave %>')) {
			form.action = "fi.at.cudRetirementRequest.dev"+retirementRequestInfo;
			form.submit();
		}

	}

}

//-------------------------------------------------------------------------
// validation (유효성 체크)
//-------------------------------------------------------------------------					
function checkSaveData(str) {
	
	var form             = document.saveForm;
	var assetNm          = form.assetNm.value;
	var requestDate      = removeDash(form.requestDate.value,"/");
	var amount           = removeDash(form.amount.value,",");
	var sDotAmt          = "0"; // amount 소수점이하 초기값
	var currCd           = form.currCd.ValueOfIndex("code",form.currCd.Index);	
	var customerCd       = form.customerCd.value;
	var assetNoRequestYn = form.assetNoRequestYn.value;
	
	// 자산번호 - 매각, 폐기 요청 여부 체크
	if(assetNoRequestYn == "Y"){
		alert("<%=magCheckAssetNoRequestY%>");
		return;
	}else if(assetNoRequestYn == ""){
		alert("<%=magCheckAssetNoRequest%>");
		return;
	}
	
	// 매각 일 경우
	if(str == "D"){
		
		// 자산명이 없는 경우
		if(f_isNull(assetNm)){
			alert("<%=source.getMessage("dev.warn.com.input", columnData.getString("asset_nm"))%>" );
			form.assetNm.focus();
			return;
		}
		
		// 요청일자 값이 없는 경우
		if(f_isNull(requestDate)){
			alert("<%=source.getMessage("dev.warn.com.select", columnData.getString("request_date"))%>" );
			form.requestDate.focus();
			return;
		}
		
		// 금액이 없는 경우
		if(f_isNull(amount)){
			alert("<%=source.getMessage("dev.warn.com.input", columnData.getString("amount"))%>" );
			form.amount.focus();
			return;
		}
		
		// 통화코드 값이 선택되지 않는 경우
		if(f_isNull(currCd)){
			alert("<%=source.getMessage("dev.warn.com.select", columnData.getString("curr_cd"))%>" );
			form.currCd.focus();
			return;
		}
		
		// Customer 값이 선택되지 않는 경우
		if(f_isNull(customerCd)){
			alert("<%=source.getMessage("dev.warn.com.select", columnData.getString("customer_cd"))%>" );
			form.customerNm.focus();
			return;
		}
		
		// Amount 소수점 값이 있는 경우
		if(String(amount).indexOf(".", 0) != -1){
			sDotAmt = removeDash(String(amount).substring(String(amount).indexOf(".", 0), String(amount).length),".");	
		}
		
		// Currency : IDR (Indonesia) 인 경우 금액(Amount) 소수점 입력 여부 체크
		if(Number(sDotAmt) > 0){
			alert("<%=msgChkCurrency%>");			
			form.amount.focus();			
			return false;				
		}
	}
	
	// 폐기 일 경우
	if(str == "R"){
		
		// 자산명이 없는 경우
		if(f_isNull(assetNm)){
			alert("<%=source.getMessage("dev.warn.com.input", columnData.getString("asset_nm"))%>" );
			form.assetNm.focus();
			return;
		}
		
		// 요청일자 값이 없는 경우
		if(f_isNull(requestDate)){
			alert("<%=source.getMessage("dev.warn.com.select", columnData.getString("request_date"))%>" );
			form.requestDate.focus();
			return;
		}
				 
	}
		
	return true;
}				

//-------------------------------------------------------------------------
// 해당 문자열이 널인지 점검
//-------------------------------------------------------------------------		
function f_isNull( asValue ) {
	if (asValue == null || asValue == undefined || asValue.toString().replace(/ /g,"") == "") {
		return  true;
	}
	return false;
}	

//------------------------------------------------------------------------ 
// 1000 단위마다 Comma(,) 찍기 
//------------------------------------------------------------------------ 
function toCurrencyChange(obj) { 

	if(!isCurrency(obj.value)) { 
		alert("<%= msgCheckNumber %>"); 
		obj.value = ""; 
		obj.focus(); 
		return; 
	} 
	
	var lastValue = obj.value.replaceAll(",",""); 
	
	if(lastValue.length > 3){
		obj.value = toCurrencyString(lastValue);		
	}  
}

//------------------------------------------------------------------------ 
// 숫자, ',', '.'만 입력 
//------------------------------------------------------------------------ 
function isCurrency(string) { 

	var replPatrn = /[\d\,\.]/g; 
	
	if (string.trim().replace(replPatrn, "").length == 0){
		return true;
	}else{
		return false; 
	}
} 

//------------------------------------------------------------------------ 
// 1000 단위마다 Comma(,) 찍기 
//------------------------------------------------------------------------ 
function toCurrencyString(strCurrency) { 

	var frm = document.saveForm;
	strCurrency += ""; 
	var isMinus = false; 
	var isDot   = false; 
	var sSecond = "";      //정수의 문자열 
	var sDot    = "";      //소수점이하의 문자열 
	
	if(strCurrency.charAt(0) == '-') { 
		strCurrency = strCurrency.substring(1); isMinus = true; 
	} 
	
	if(strCurrency.indexOf(".", 0) > 0) { 
		
		sSecond = strCurrency.substr(0, strCurrency.indexOf(".", 0)); 
		sDot = strCurrency.substring(strCurrency.indexOf(".", 0), strCurrency.length); 
		isDot = true; 
		
		var len = sDot.length - 1; 
		
		if (len > 2) { 
			
			alert("<%= magCheckAmount %>"); 
			
			sDot = sDot.substr(0, sDot.length - 1);
			
			// 금액 소수 둘째짜리 까지 셋팅
			frm.amount.value = toCurrencyString(sSecond + sDot);
			
			inField.focus(); 
			
			return false; 
			 
		}
		
		strCurrency = sSecond; 
	} 
	
	strlen  = strCurrency.length; 
	cntLoop = Math.floor(strlen / 3); 
	rem     = strlen % 3; 
	
	if(rem == 0) { 
		rem = 3; cntLoop--; 
	}
	
	result = strCurrency.substr(0, rem); 
	
	for(ipos = 0 ; ipos < cntLoop ; ipos++) {
		result += "," + strCurrency.substr(3 * ipos + rem , 3);
	}
		 
	if (isMinus){
		result = "-" + result; 
	}
	
	if(isDot){
		result = result + sDot; 
	}
	
	return result; 
}

//-------------------------------------------------------------------------
// Current Asset List - Asset No 매각, 폐기 신청 여부 체크
//-------------------------------------------------------------------------		
function f_AssetNoRequestCheck(){
	
	var form = document.saveForm;
	
	if(ds_grid.CountRow == 0) {
        alert("<%= msgWarnRetrieve %>"); // please first retrieve!
        return;
    }				
			
	var paramHead = "assetNo:STRING(100)";
	ds_param.setDataHeader("assetNo:STRING(100)");
	ds_param.AddRow();

	ds_param.NameValue(1, "assetNo") = form.assetNo.value; // 자산번호
			
	tr_assetNoRequestCheck.Action   = "/fi.at.retrieveAssetNoRequestCheck.gau";
	tr_assetNoRequestCheck.KeyValue = "SERVLET(I:ds_param=ds_param, O:ds_assetNoCheckResult=ds_assetNoCheckResult)";
	tr_assetNoRequestCheck.post();		    			   						
} 

//-------------------------------------------------------------------------
// Customer 조회 팝업
//-------------------------------------------------------------------------		
function f_openVendorPop() {	
	
	openVendorSapListWin('A2');		
}

</script>


<!-----------------------------------------------------------------------------
		 D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- Grid  DataSet-->
<object id="ds_grid" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad" value="true">
	<param name="ViewDeletedRow" value="true">
</object>

<!-- currency code combo 용 DataSet -->
<object id="ds_currencyCode" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad" value="true">
	<param name="DataID"   value="cm.cm.retrieveCommCodeCombo.gau?groupCd=2004&firstVal=Select">
</object>

<!-- cost center Combo 용 DataSet-->
<object id="ds_cost_center" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad" value="true">
	<param name="DataID"   value="cm.cm.retrieveCommComboCostCenterList.gau?firstVal=Total">
</object>

<!-- Asset Class Combo 용 DataSet-->
<object id="ds_asset_class" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad" value="true">
	<param name="DataID"   value="cm.cm.retrieveCommCodeCombo.gau?groupCd=ASCL&firstVal=Total">
</object>

<!-- 저장 DataSet -->
<object id="ds_cudMstData" classid="<%=LGauceId.DATASET%>"></object>

<!-- 조회 조건 DataSet -->
<object id="ds_param" classid="<%=LGauceId.DATASET%>"></object>

<!-- 자산번호 - 매각, 폐기 요청 여부 확인 결과 DataSet -->
<object id="ds_assetNoCheckResult" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad" value="true">
	<param name="ViewDeletedRow" value="true">
</object>

<!-----------------------------------------------------------------------------
  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- CUD TR -->
<OBJECT id=tr_cudData classid="<%=LGauceId.TR%>">
	<param name="KeyName" value="toinb_dataid4">
	<param name="ServerIP"  value="">
</OBJECT>

<!-- MASTER TR -->
<OBJECT id="tr_master" classid="<%=LGauceId.TR%>">
	<param name="KeyName" value="toinb_dataid4">
</OBJECT>

<OBJECT id="tr_assetNoRequestCheck" classid="<%=LGauceId.TR%>">
	<param name="KeyName" value="toinb_dataid4">
</OBJECT>

<!-----------------------------------------------------------------------------
	G A U C E   C O M P O N E N T' S   E V E N T S
------------------------------------------------------------------------------>
<script language=JavaScript for=ds_grid event=OnLoadStarted()>
  	cfHideNoDataMsg(gr_grid);//no data 메시지 숨기기
  	cfShowDSWaitMsg(gr_grid);//progress bar 보이기
  	mode = "";
</script>

<script language=JavaScript for=ds_grid event=OnLoadCompleted(rowCnt)>
  	cfHideDSWaitMsg(gr_grid);//progress bar 숨기기
  	cfFillGridNoDataMsg(gr_grid,"gridColLineCnt=2");//no data found   
  	mode = "";
</script>

<script language=JavaScript for=ds_grid event=OnLoadError()>
  	cfShowErrMsg(ds_grid);
  	//mode = "";
</script>

<script language="javascript" for=ds_grid event=OnRowPosChanged(row)>	
	var form = document.saveForm;
	
	//자산번호 - 매각, 폐기 신청여부 초기화
	form.assetNoRequestYn.value = "";
</script>

<script language=JavaScript for=tr_cudData event=OnFail()>	
	mode = "";
    
	if(tr_cudData.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
        window.parent.location.href = "/index.jsp";    
    }	
	alert("Error Code : " + tr_cudData.ErrorCode + "\n" + "Error Message : " + tr_cudData.ErrorMsg + "\n");
</script>

<script language=JavaScript for=tr_cudData event=OnSuccess()>	
    alert("successfully saved.");
    f_Retrieve();
</script>

<script language="javascript" for="ds_assetNoCheckResult" event="onLoadCompleted(rowcnt)">

	// 자산번호 - 매각, 폐기 요청 여부 결과 값 셋팅
	if( ds_assetNoCheckResult.CountRow > 0 ) {
				
		if("exist" == ds_assetNoCheckResult.NameValue(ds_assetNoCheckResult.RowPosition, "existCheck") ) {			
			document.getElementById("assetNoRequestYn").value = "Y";
			alert("<%=magCheckAssetNoRequestY%>");			
		}else{			
			document.getElementById("assetNoRequestYn").value = "N";
			alert("<%=magCheckAssetNoRequestN%>");			
		}
	}
</script>

</head>

<body id="cent_bg" onload="init();">

<div id="conts_box">
	<h2><span><%=columnData.getString("page_title") %></span></h2>

	<!-- Asset List 검색 영역 Start -->			
	<fieldset class="boardSearch">
		<div>
			<dl>
				<dt>
					<form name="schForm" method="post">
						<table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board2" >
							<colgroup>
								<col width="13%"/>
								<col width="18%"/>
								<col width="14%"/>
								<col width="20%"/>
								<col width="14%"/>
								<col width=""/>
							</colgroup>
							<tr>
								<th><%= columnData.getString("year_month") %></th>
								<td>
									<input type="text"  name="yearMonth" id="yearMonth" value="<%= currentDate %>" onkeydown="keyLogin(event)" size="7" class="input_Licon" maxlength="100" readonly>
									<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:Calendar_M(yearMonth);" style="cursor:hand"/>					
								</td>
								<th><%=columnData.getString("cost_center") %> </th>		
								<td>									
									<object id="costCenter"  classid="<%=LGauceId.LUXECOMBO%>" width="100">
									    <param name="ComboDataID"       value="ds_cost_center">
										<param name="ListCount"     	value="10">
										<param name="BindColumn"    	value="code">
										<param name="WantSelChgEvent"   value="TRUE">
									    <param name=ListExprFormat		value="name^0^90,code^0^70">
									    <param name=index           	value=0>
								   	</object>									
								</td>
								<th><%=columnData.getString("asset_class") %> </th>		
								<td>									
									<object id="assetClass"  classid="<%=LGauceId.LUXECOMBO%>" width="100">
									    <param name="ComboDataID"       value="ds_asset_class">
										<param name="ListCount"     	value="10">
										<param name="BindColumn"    	value="code">
										<param name="WantSelChgEvent"   value="TRUE">
									    <param name=ListExprFormat		value="name^0^90,code^0^70">
									    <param name=index           	value=0>
								   	</object>									
								</td>																		
							</tr>
							<tr>								
								<th><%= columnData.getString("asset_no") %></th>
								<td>
									<input type="text" id="assetNo" style="width:76px;" onkeydown="keyDownSch(event)" />																
								</td>
								<th><%=columnData.getString("asset_nm") %> </th>		
								<td colspan="3">									
									<input type="text" id="assetNm" style="width:90px;" onkeydown="keyDownSch(event)" />									
								</td>
							</tr>
						</table>
					</form>
				</dt>              		  	   	 	
				<dd class="btnseat2"> 
				 	<span class="search_btn2_r search_btn2_l">
                		<input type="button" onfocus="blur();" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='#e2ebf7'" value="<%=btnSearch %>" onclick="f_Retrieve();"/>
                	</span> 
				</dd>
			</dl>
		</div>
	</fieldset>      		
	<!-- Asset List 검색 영역 End -->

	<div class="sub_stitle">
		<p><%=columnData.getString("sub1_title") %></p>		
	</div>
	
	<!-- Current Asset List GRID 영역 Start -->
	<div>
		<object id="gr_grid" classid="<%=LGauceId.GRID %>" style="width:100%;height:230px;" class="comn" dataName="payment request" validFeatures="ignoreStatus=no" validExp="">
			<param Name="DataID" 			value='ds_grid'>
	    	<Param name="AutoResizing"      value=true>	 
	    	<param name="Editable"          value=True>
	    	<Param NAME="TitleHeight"      	value="30">
	    	<param name="UsingOneClick"     value="1"/>
			<param Name='Format' value='
				<c>id="assetClass"    name="<%=columnData.getString("asset_class") %>"     align="center"  width="70"   Edit="none"  show="true"  </c>
	        	<c>id="assetClassNm"  name="<%=columnData.getString("asset_class_nm") %>"  align="left"    width="120"  Edit="none"  show="true"  </c>	        	
	        	<c>id="assetNo"       name="<%=columnData.getString("asset_no") %>"        align="center"  width="80"   Edit="none"  show="true"  </c>
	        	<c>id="assetNm"       name="<%=columnData.getString("asset_nm") %>"        align="left"    width="150"  Edit="none"  show="true"  </c>	        		        										        					        	 	
	        	<c>id="acqAmt"        name="<%=columnData.getString("acq_amount") %>"      align="right"   width="150"  Edit="none"  show="true"  </c> 		
	        	<c>id="depAmt"        name="<%=columnData.getString("dep_amount") %>"      align="right"   width="150"  Edit="none"  show="true"  </c>   			        	
	        	<c>id="balance"       name="<%=columnData.getString("balance") %>"         align="right"   width="90"   Edit="none"  show="true"  </c> 			        				    				        					        		        	 
	        	<c>id="qty"           name="<%=columnData.getString("qty") %>"             align="center"  width="110"  Edit="none"  show="true"  </c>
	        	<c>id="unit"          name="<%=columnData.getString("unit") %>"            align="center"  width="110"  Edit="none"  show="true"  </c>
	        	<c>id="durableYears"  name="<%=columnData.getString("useful_life") %>"     align="center"  width="110"  Edit="none"  show="true"  </c>
	        	<c>id="acqDate"       name="<%=columnData.getString("acq_date") %>"        align="center"  width="110"  Edit="none"  show="true"  Mask="XXXX/XX/XX"  </c>
	        	<c>id="dueDate"       name="<%=columnData.getString("end_date") %>"        align="center"  width="110"  Edit="none"  show="true"  Mask="XXXX/XX"  </c>
	        	<c>id="costCenter"    name="<%=columnData.getString("cost_center") %>"     align="center"  width="110"  Edit="none"  show="true"  </c>
	        	<c>id="costCenterNm"  name="<%=columnData.getString("cost_center_nm") %>"  align="center"  width="110"  Edit="none"  show="true"  </c>
	        	<c>id="currCd"        name="<%=columnData.getString("curr_cd") %>"         align="center"  width="110"  Edit="none"  show="true"  </c>
	        	<c>id="assetSubNo"                                                         align="center"  width="110"  Edit="none"  show="false" </c>  '>	
	        </param>	      
		</object>
 	</div>	
	<!-- Current Asset List GRID 영역 End -->
	
	<div class="sub_stitle">
		<p><%=columnData.getString("sub2_title") %></p>
	</div>
	
	<!-- Request Information 영역 Start -->
	<div id="output_board_area">	
		<form name="saveForm" method="post" enctype="multipart/form-data">	
		<input type="hidden" id="assetNo" name="assetNo" />
		<input type="hidden" id="assetSubNo" name="assetSubNo" />
		<input type="hidden" id="assetNoRequestYn" name="assetNoRequestYn" />		
		
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board" >
				<colgroup>
		        	<col width="18%"/>
		        	<col width="30%"/>
		        	<col width="18%"/>
		        	<col width=""/>	        	
				</colgroup>    
		    	<tr>
			  		<th><%= columnData.getString("asset_nm") %></th>
	          		<td>
	          			<input type="text" id="assetNm" style="width:142px;" readonly class="txtField_read" />
	          			<span class="sbtn_r sbtn_l">
							<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" id="imgIdCheck" onmouseout="this.style.color='#7b87a0'" value="<%=btnCheck%>" onclick="f_AssetNoRequestCheck();" />							
            			</span>
	          		</td>
			  		<th><%= columnData.getString("request_date") %></th>
			  		<td>
			  			<input type="text" id="requestDate" onblur="valiDate(this);" style="width:60px;" />
						<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(requestDate);" style="cursor:hand"/>
			      	</td>
			  	</tr>
			  	<tr>	
			  		<th><%= columnData.getString("amount") %></th>
			  		<td><input type="text" id="amount" style="width:139px;" onkeyup="javascript:toCurrencyChange(this)" /></td>
			      	<th><%=columnData.getString("curr_cd") %></th>                    		
					<td>									
						<object id="currCd"  classid="<%=LGauceId.LUXECOMBO%>" width="150">
						    <param name="ComboDataID"       value="ds_currencyCode">
							<param name="ListCount"     	value="10">
							<param name="BindColumn"    	value="code">
							<param name="WantSelChgEvent"   value="TRUE">
						    <param name=ListExprFormat		value="name^0^90,code^0^70">
						    <param name=index           	value=0>
					   	</object>									
					</td>
				</tr>			
		    	<tr>		  												
			  		<th><%=columnData.getString("qty") %></th>
	                <td><input id="qty" name="qty" type="text" style="width:142px;" readonly class="txtField_read" /></td>
			  		<th><%=columnData.getString("unit") %> </th>		
					<td><input type="text" id="unit" style="width:142px;" readonly class="txtField_read" /></td>						  		
				</tr>
				<tr>		  														  		
			  		<th><%=columnData.getString("customer_cd") %> </th>																
					<td>
						<input type="hidden" id="customerCd" name="customerCd" />
						<input type="text" id="customerNm" name="customerNm" style="width:138px;" readonly />&nbsp;
			  			<img src="<%= images %>button/search_icon_2.gif"  onClick="javascript:f_openVendorPop();" style="cursor:hand"/>
			  		</td>					
					<th><%=columnData.getString("asset_desc") %></th>
	                <td><input type="text" id="assetDesc" style="width:139px;" maxlength="200" /></td>					  		
				</tr>
				<tr>
	                 <th><%=columnData.getString("file_upload") %></th>
	                 <td colspan="3"><input name="fileUpload" type="file" class="input_text" style="width:355px;height:18px;" text="file"></td>
	             </tr>
		  	</table>
	  	</form>			
	</div>
	<!-- Request Information 영역 End -->
			
	<!-- 하단 버튼 영역 Start -->
	<div id="btn_area">
		<p class="b_right">
			<span class="btn_r btn_l"> 
				<input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnDisposal %>" onclick="javascript:f_Disposal();" />
				<input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnRetirement %>" onclick="javascript:f_Retirement();" />
			</span>
		</p>
	</div>
	<!-- 하단 버튼 영역 End --> 	
	
	<comment id="__NSID__">
		<object id="bi_grid" classid="<%=LGauceId.BIND%>">
			<param name="DataID" value="ds_grid">
			<param name="BindInfo" value='
				<c> Col=assetNo     Ctrl=assetNo     Param=Value </c>
				<c> Col=assetSubNo  Ctrl=assetSubNo  Param=Value </c>
				<c> Col=assetNm     Ctrl=assetNm     Param=Value </c>
			    <c> Col=qty         Ctrl=qty	     Param=Value </c>                    
	            <c> Col=unit        Ctrl=unit        Param=Value </c>  '/>
		</object>
	</comment>
	<SCRIPT>__WS__(__NSID__);</SCRIPT>
	
</div>	
</body>
</html>