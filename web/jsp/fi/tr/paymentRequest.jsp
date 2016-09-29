<!DOCTYPE html >
<html>
<%@ include file="/include/doctype.jsp"%>
<%--
/*
 *********************************************************************************
 * @source  : paymentRequest.jsp
 * @desc    : SAP 에 Open AP 를 조회하여 출금정보를 입력하고 출금요청 하는 화면
 *--------------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -------------------------------------------------
 * 1.0  2015/12/02	 hckim		 Init      		 		  
 * ---  -----------  ----------  -------------------------------------------------
 * Copyright(c) 2006-2007 LG CNS,  All rights reserved.
 *********************************************************************************
 */
--%>
<%@ page import="devon.core.collection.LMultiData"%>
<%@ page import="devon.core.collection.LData"%>
<%@ page import="java.util.Date"%>
<%@ include file="/include/head.jsp"%>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="blendTrans(Duration=0.0)" http-equiv="Page-Enter" />
<meta content="blendTrans(Duration=0.0)" http-equiv="Page-Exit" />
<%@ page import="devon.core.util.*" %>


<%	  
	String currentDate             = LDateUtils.getDate("yyyy/MM/dd");                         // 오늘일자

	String msgInfoChange           = source.getMessage("dev.inf.com.nochange");                // no data for change.
	String msgSave                 = source.getMessage("dev.cfm.com.save");                    // Are you sure to save?
	String msgDelete               = source.getMessage("dev.cfm.com.delete");                  // Are you sure to Delete?
	String msgContinue             = source.getMessage("dev.cfm.com.continue");                // Are you sure to Continue?		
	String msgSelectDoc            = source.getMessage("dev.warn.com.selectDoc");              // Please select least one document.
	String msgDiffVendCd           = source.getMessage("dev.warn.com.diffVendCd");             // Vendor code have to same with others.
	String msgDiffCurrCd           = source.getMessage("dev.warn.com.diffCurrCd");             // Currency have to same with others.	
	String msgCheckDueDate         = source.getMessage("dev.warn.com.checkDueDate");           // Check due date.
	String msgCheckPymtMth         = source.getMessage("dev.warn.com.checkPymtMth");           // Select payment method.
	String msgCheckPartnerBankType = source.getMessage("dev.warn.com.checkPartnerBankType");   // Select partner bank type.
	String msgCheckHouseBank       = source.getMessage("dev.warn.com.checkHouseBank");         // Select House Bank.
	String msgCheckHouseCurrency   = source.getMessage("dev.warn.com.checkHouseBankCurrency"); // Check the house bank currency code.
%> 

<head>

<script type="text/javascript">
parent.centerFrame.cols='220,*';
//-------------------------------------------------------------------------
// 초기값 셋팅	 	
//-------------------------------------------------------------------------		
function init(){

	var sPostDate     = document.all.sPostDate.value;
	var sBaselineDate = document.all.sBaselineDate.value;
	var baselineDate  = document.all.baselineDate.value;
	var tomorrowDate  = "<%= currentDate %>";  //getTomorrow();		//현재 일자로 변경.
	
	// Posting Date 값이 없는 경우 (검색조건 필드)
	if(sPostDate == "" || sPostDate == null){
		
		// Posting Date 검색필드 초기값 셋팅
		document.all.sPostDate.value = tomorrowDate;
	}
	
	// Baseline Date 값이 없는 경우 (검색조건 필드)
	if(sBaselineDate == "" || sBaselineDate == null){
		
		// Baseline Date 검색필드 초기값 셋팅
		document.all.sBaselineDate.value = tomorrowDate;
	}
	
	// Baseline Date 값이 없는 경우 (Payment Information 필드)
	if(baselineDate == "" || baselineDate == null){
		
		// Baseline Date 필드 초기값 셋팅
		document.all.baselineDate.value = tomorrowDate;
	}

}

//-------------------------------------------------------------------------
// 내일일자 가져오기	 	
//-------------------------------------------------------------------------	
function getTomorrow(){ 

  	var today    = new Date(); 
  	var tomorrow = new Date(today.valueOf() + (24*60*60*1000)); 
  	var year     = tomorrow.getFullYear(); 
  	var month    = tomorrow.getMonth() + 1; 
  	var day      = tomorrow.getDate(); 
	var result   = year + "/" + ((month < 10) ? "0" : "") + month + "/" + ((day < 10) ? "0" : "") + day;
	
	return result;
} 


//-------------------------------------------------------------------------
// 조회조건 입력시 	 	
//-------------------------------------------------------------------------				
function keyDownSch(evt){
	if ( evt.keyCode == 13 || evt == '^') {
		f_search();	
	}
}

//-------------------------------------------------------------------------
// Search 버튼 클릭 시 - Payment Request 정보 조회
//-------------------------------------------------------------------------
function f_Retrieve() {

	var condition = "?";
    	condition += "postDate=" + removeDash(document.all.sPostDate.value,"/");
    	condition += "&vendCd=" + document.all.sVendCd.value;
    	condition += "&baselineDate=" + removeDash(document.all.sBaselineDate.value,"/");
    	condition += "&currCd=" + sCurrCd.ValueOfIndex("code",sCurrCd.Index);
    	condition += "&personalId=" + document.all.personalId.value;
 		 
	ds_grid.DataID = "fi.tr.retrieveOpenAPList.gau"+condition;
	ds_grid.Reset();
			
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
		
//-------------------------------------------------------------------------
// 저장버튼 클릭시
//-------------------------------------------------------------------------			
function f_Save(){

	var piVendCd = document.all.vendCd.value; // Payment Information : Vendor Code 정보
	var piCurrCd = document.all.currCd.value; // Payment Information : Vendor Code 정보
	var chk_cnt = 0;
	
	for(var i=1; i <= ds_grid.countRow; i++){
						
		if(ds_grid.NameValue(i,"chk") == "T"){
						
			var vendCd = ds_grid.NameValue(i,"vendCd"); // Open AP List - Vendor Code 정보
			var currCd = ds_grid.NameValue(i,"currCd"); // Open AP List - Currency Code 정보
			
			if(vendCd != piVendCd){
				alert('<%= msgDiffVendCd %>');
				return;
			}
			
			if(piCurrCd != currCd){
				alert('<%= msgDiffCurrCd %>');
				return;
			}
			
			chk_cnt = chk_cnt + 1;
		}
	}

	if( chk_cnt == 0 ) {
		alert('<%= msgSelectDoc %>');
		return;
	}
	
	if (checkSaveData()) {

		//Dataset 저장		
		saveCudData();

		if (confirm('<%= msgSave %>')) {
			
			mode = "process";

			// Payment Information 정보
		  	var param = "baselineDate=" + removeDash(document.all.baselineDate.value,"/")
				     + ",paymentMethod=" + sPaymentMethod.ValueOfIndex("code",sPaymentMethod.Index)				
				     + ",partnerBankType=" + document.all.partnerBankType.value
		  	         + ",houseBank=" + document.all.sHouseBank.value
		  	         + ",houseBankAcct=" + document.all.houseBankAcct.value;
			
		  	tr_cudData.Parameters = param;		  	
			tr_cudData.KeyValue	= "JSP(I:IN_DS1=ds_cudMstData)";
			tr_cudData.Action   = "fi.tr.cudPaymentRequest.gau";			
	 		tr_cudData.Post();
	 	}
 	
 	}

}

//-------------------------------------------------------------------------
// validation (유효성 체크)
//-------------------------------------------------------------------------					
function checkSaveData() {
	
	var baselineDate    = removeDash(document.all.baselineDate.value,"/");          // 출금일자 (Due Date)
	var currentDate     = removeDash(document.all.currentDate.value,"/");           // 현재일자
	var paymentMethod   = sPaymentMethod.ValueOfIndex("code",sPaymentMethod.Index); // 출금방법 (Payment Method)
	var partnerBankType = document.all.partnerBankType.value;                       // Partner Bank Type
	var houseBank       = document.all.sHouseBank.value;                            // House Bank
	var currCd          = document.all.currCd.value;                                // Currency
	var houseBankCurrCd = document.all.houseBankCurrCd.value;                       // House Bank Currency
	
	// 출금일자가 현재일자 보다 작을 경우
	if(baselineDate < currentDate){
		alert('<%=msgCheckDueDate%>');
		document.all.baselineDate.focus();
		return;
	}
	
	// Payment Method 를 선택하지 않은 경우
	if(paymentMethod == "" || paymentMethod == null){		
		alert('<%=msgCheckPymtMth%>');
		document.all.sPaymentMethod.focus();
		return;
	}
	
	// Partner Bank Type 값이 없는 경우
	if(partnerBankType == "" || partnerBankType == null){
		alert('<%=msgCheckPartnerBankType%>');
		document.all.partnerBankType.focus();
		return;
	}
	
	// House Bank 값이 없는 경우
	//Bank Transfer('T')인 경우에만 체크
	if(paymentMethod == "T"){
			
		if(houseBank == "" || houseBank == null){
			alert('<%=msgCheckHouseBank%>');
			document.all.sHouseBank.focus();
			return;
		}
		
		// 출금요청 통화코드와 House Bank 통화코드가 다른 경우
		if(currCd != houseBankCurrCd){
			alert('<%=msgCheckHouseCurrency%>');
			document.all.sHouseBank.focus();
			return;
		}
	}
	
	return true;
}				

//-------------------------------------------------------------------------
// Vendor 조회 팝업
//-------------------------------------------------------------------------		
function f_openVendorPop() {	
	
	openVendorSapListWin('P');		
}

//-------------------------------------------------------------------------
// 거래선 별 계좌 조회 팝업
//-------------------------------------------------------------------------		
function f_openVendorBankAcctListPop() {
	
	var vendCd = document.all.vendCd.value;
	
	if( vendCd != null && vendCd != "" ) {
		openVendorBankAcctListWin();
	
	// Open AP List Row를 선택하지 않은 경우 (vendCd가 정의되지 않은 경우)	
	}else{
		alert('<%=msgSelectDoc%>');
		return;
	}
}

//-------------------------------------------------------------------------
// House Bank 조회 팝업
//-------------------------------------------------------------------------		
function f_openHouseBankPop() {	
	
	openPaymentBankAcctListWin();		
}

//-------------------------------------------------------------------------
// 저장 시 Parameter 데이타셋 저장
//-------------------------------------------------------------------------
function saveCudData() {
 
	//파라메타 데이타셋 설정하는 부분 시작
	if( ds_cudMstData.CountColumn == 0 ) {
		var strHeader = "docNo:VARCHAR(50),"
			+ "lineItem:VARCHAR(50),"
			+ "vendCd:VARCHAR(50),"
			+ "vendNm:VARCHAR(50),"
			+ "acctCd:VARCHAR(50),"
			+ "acctNm:VARCHAR(50),"
			+ "postDate:VARCHAR(50),"
			+ "amount:DECIMAL(13.3),"						
			+ "currCd:VARCHAR(50),"			
			+ "sapRequestNo:VARCHAR(50),"
			+ "houseBank:VARCHAR(50),"
			+ "sapStatus:VARCHAR(50),"
			+ "fiscalYear:VARCHAR(50),"
			+ "exchAmount:DECIMAL(13.3),"
			+ "exchCurrCd:VARCHAR(50),"
			+ "docDesc:VARCHAR(50),"
			+ "docDate:VARCHAR(50),"
			+ "docType:VARCHAR(50),"
			+ "paymentBlock:VARCHAR(50),"
			+ "personalId:VARCHAR(50),"
			+ "baselineDate:VARCHAR(50),"
			+ "paymentMethod:VARCHAR(50),"
			+ "partnerBankType:VARCHAR(50),"
			+ "exchRate:VARCHAR(50),"
			+ "attr01:VARCHAR(50),"
			+ "attr02:VARCHAR(50),"
			+ "attr03:VARCHAR(50),"
			+ "attr04:VARCHAR(50),"
			+ "attr05:VARCHAR(50),"
			+ "attr06:VARCHAR(50),"
			+ "attr07:VARCHAR(50),"
			+ "attr08:VARCHAR(50),"
			+ "attr09:VARCHAR(50),"
			+ "attr10:VARCHAR(50)"			
			;
		
		ds_cudMstData.SetDataHeader(strHeader);
	}

	ds_cudMstData.ClearData();
	
	for(var i=1; i <= ds_grid.countRow; i++){
		if(ds_grid.NameValue(i,"chk") == "T"){
			ds_cudMstData.AddRow();
			
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"docNo")           = ds_grid.NameValue(i,"docNo");
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"lineItem")        = ds_grid.NameValue(i,"lineItem");
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"vendCd")          = ds_grid.NameValue(i,"vendCd");
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"vendNm")          = ds_grid.NameValue(i,"vendNm");
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"acctCd")          = ds_grid.NameValue(i,"acctCd");
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"acctNm")          = ds_grid.NameValue(i,"acctNm");			
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"postDate")        = ds_grid.NameValue(i,"postDate");
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"amount")          = ds_grid.NameValue(i,"amount");
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"currCd")          = ds_grid.NameValue(i,"currCd");			
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"sapRequestNo")    = ds_grid.NameValue(i,"sapRequestNo");
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"houseBank")       = ds_grid.NameValue(i,"houseBank");
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"sapStatus")       = ds_grid.NameValue(i,"sapStatus");
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"fiscalYear")      = ds_grid.NameValue(i,"fiscalYear");
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"exchAmount")      = ds_grid.NameValue(i,"exchAmount");
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"exchCurrCd")      = ds_grid.NameValue(i,"exchCurrCd");
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"docDesc")         = ds_grid.NameValue(i,"docDesc");
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"docDate")         = ds_grid.NameValue(i,"docDate");
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"docType")         = ds_grid.NameValue(i,"docType");
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"paymentBlock")    = ds_grid.NameValue(i,"paymentBlock");
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"personalId")      = ds_grid.NameValue(i,"personalId");			
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"baselineDate")    = ds_grid.NameValue(i,"baselineDate");
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"paymentMethod")   = ds_grid.NameValue(i,"paymentMethod");
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"partnerBankType") = ds_grid.NameValue(i,"partnerBankType");
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"exchRate")        = ds_grid.NameValue(i,"exchRate");
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"attr01")          = ds_grid.NameValue(i,"attr1");
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"attr02")          = ds_grid.NameValue(i,"attr2");
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"attr03")          = ds_grid.NameValue(i,"attr3");
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"attr04")          = ds_grid.NameValue(i,"attr4");
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"attr05")          = ds_grid.NameValue(i,"attr5");
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"attr06")          = ds_grid.NameValue(i,"attr6");
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"attr07")          = ds_grid.NameValue(i,"attr7");
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"attr08")          = ds_grid.NameValue(i,"attr8");
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"attr09")          = ds_grid.NameValue(i,"attr9");
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"attr10")          = ds_grid.NameValue(i,"attr10");
		}
	}
	
}

//-------------------------------------------------------------------------
// Excel Down 버튼 클릭
//-------------------------------------------------------------------------					   
function f_excelDown() {
	
	gf_excel(ds_grid,gr_grid,"<%=columnData.getString("sub1_title") %>","c\\");
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
	<param name="DataID"   value="cm.cm.retrieveCommCodeCombo.gau?groupCd=2004&firstVal=Total">
</object>

<!-- payment method combo 용 DataSet -->
<object id="ds_paymentMethod" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad" value="true">
	<param name="DataID"   value="cm.cm.retrieveCommCodeCombo.gau?groupCd=TRPM&firstVal=Select">
</object>

<!-- house bank combo 용 DataSet -->
<object id="ds_houseBank" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad" value="true">
	<param name="DataID"   value="cm.cm.retrieveCommCodeCombo.gau?groupCd=TRPM&firstVal=Select">
</object>

<!-- 저장 DataSet -->
<object id="ds_cudMstData" classid="<%=LGauceId.DATASET%>"></object>

<!-----------------------------------------------------------------------------
  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- CUD TR -->
<OBJECT id=tr_cudData classid="<%=LGauceId.TR%>">
	<param name="KeyName" value="toinb_dataid4">
	<param name="ServerIP"  value="">
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
  
  //Payment Information 정보 초기화
  sPaymentMethod.Index = 0;
  partnerBankType.value = "";
  partnerAcctNum.value = "";
  sHouseBank.value = "";
  houseBankAcct.value = "";
</script>

<script language=JavaScript for=ds_grid event=OnLoadError()>
  cfShowErrMsg(ds_grid);
  //mode = "";
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

<!-- 전체 체크박스 선택/해제 -->
<script language=JavaScript for=gr_grid event=OnHeadCheckClick(Col,Colid,bCheck)>

	// 전체 체크박스 해제
	if(bCheck == 0){

		for(var i=1; i <= ds_grid.countRow; i++){
			ds_grid.Namevalue(i,"chk") = "F";
		}
	
	// 전체 체크박스 선택
	}else{
	  
		for(var i=1; i <= ds_grid.countRow; i++){
			ds_grid.Namevalue(i,"chk") = "T";
		}				
	}
</script>

</head>

<body id="cent_bg" onload="init();">

<div id="conts_box">
	<h2><span><%=columnData.getString("page_title") %></span></h2>

	<!-- Payment Request 검색 영역 Start -->			
	<fieldset class="boardSearch">
		<div>
			<dl>
				<dt>
					<input type="hidden" id="personalId" name="personalId" value="" /> 
					<table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board2" >
						<colgroup>
							<col width="22%"/>
							<col width="25%"/>
							<col width="11%"/>
							<col width=""/>
						</colgroup>
						<tr>
							<th><%= columnData.getString("post_date") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%= columnData.getString("until") %></th>
							<td align="left">								
								<input type="text" id="sPostDate" onblur="valiDate(this);" style="width:60px;" readonly />
								<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(sPostDate);" style="cursor:hand"/>									
							</td>
							<th><%=columnData.getString("vend_nm") %> </th>									
							<td>
							  <input type="hidden" id="sVendCd" name="sVendCd" />
								<input type="text" id="sVendNm" name="sVendNm" style="width:140px;" readOnly/>&nbsp;
					  			<img src="<%= images %>button/search_icon_2.gif"  onClick="javascript:f_openVendorPop();" style="cursor:hand"/>
					  		</td>
																									
						</tr>
						<tr>								
							<th><%= columnData.getString("baseline_date") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%= columnData.getString("until") %></th>
							<td>								
								<input type="text" id="sBaselineDate" onblur="valiDate(this);" style="width:60px;" readonly />
								<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(sBaselineDate);" style="cursor:hand"/>									
							</td>
							<th><%=columnData.getString("curr_cd") %> </th>		
							<td>									
								<object id="sCurrCd"  classid="<%=LGauceId.LUXECOMBO%>" width="150">
								    <param name="ComboDataID"       value="ds_currencyCode">
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
                		<input type="button" onfocus="blur();" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='#e2ebf7'" value="<%=btnSearch %>" onclick="f_Retrieve();"/>
                	</span> 
				</dd>
			</dl>
		</div>
	</fieldset>      		
	<!-- Payment Request 검색 영역 End -->

	<div class="sub_stitle">
		<p><%=columnData.getString("sub1_title") %></p>
		<p class="rightbtn">
			<span class="excel_btn_r excel_btn_l">
            	<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="<%=btnExcelDown %>" onclick="f_excelDown()"/>
            </span>   
		</p>
	</div>
	
	<!-- Open AP List GRID 영역 Start -->
	<div>
		<object id="gr_grid" classid="<%=LGauceId.GRID %>" style="width:100%;height:240px;" class="comn" dataName="payment request" validFeatures="ignoreStatus=no" validExp="">
			<param Name="DataID" 			value='ds_grid'>
	    	<Param name="AutoResizing"      value=true>	 
	    	<param name="Editable"          value=True>
	    	<Param NAME="TitleHeight"      	value="40">
	    	<param name="UsingOneClick"     value="1"/>
			<param Name='Format' value='
				<c>id="chk"    	      name="<%=columnData.getString("chk") %>"                        width="40"   Edit="true"  show="true"  {IF(returnMsg="","White","Red")}  EditStyle=CheckBox	HeadAlign=center HeadCheck=false HeadCheckShow=true  </c> 																					
				<c>id="docNo"         name="<%=columnData.getString("doc_no") %>"     align="center"  width="80"  Edit="none"  show="true"  </c>
	        	<c>id="lineItem"      name="<%=columnData.getString("line_item") %>"  align="center"  width="90"   Edit="none"  show="false" </c>	        	
	        	<c>id="vendCd"        name="<%=columnData.getString("vend_cd") %>"    align="center"  width="60"   Edit="none"  show="true"  </c>
	        	<c>id="vendNm"        name="<%=columnData.getString("vend_nm2") %>"   align="left"    width="140"  Edit="none"  show="true"  </c>	        		        										        					        	 	
	        	<c>id="acctCd"        name="<%=columnData.getString("acct_cd") %>"    align="center"  width="70"   Edit="none"  show="true"  </c> 		
	        	<c>id="acctNm"        name="<%=columnData.getString("acct_nm") %>"    align="left"    width="140"  Edit="none"  show="true"  </c>   		
	        	<c>id="amount"        name="<%=columnData.getString("amount") %>"     align="right"   width="110"  Edit="none"  show="true"  </c>
	        	<c>id="currCd"        name="<%=columnData.getString("curr_cd") %>"    align="center"  width="62"  Edit="none"  show="true"  </c>
	        	<c>id="postDate"      name="<%=columnData.getString("post_date") %>"  align="center"  width="90"   Edit="none"  show="true"  Mask="XXXX/XX/XX"  </c> 			        				    				        					        		        	 
	        	<c>id="sapRequestNo"                                                  align="center"  width="110"  Edit="none"  show="false" </c>
	        	<c>id="houseBank"                                                     align="center"  width="110"  Edit="none"  show="false" </c>
	        	<c>id="sapStatus"                                                     align="center"  width="110"  Edit="none"  show="false" </c>
	        	<c>id="fiscalYear"                                                    align="center"  width="110"  Edit="none"  show="false" </c>
	        	<c>id="exchAmount"                                                    align="center"  width="110"  Edit="none"  show="false" </c>
	        	<c>id="exchCurrCd"                                                    align="center"  width="110"  Edit="none"  show="false" </c>
	        	<c>id="docDesc"                                                       align="left"  width="110"  Edit="none"  show="false" </c>
	        	<c>id="docDate"                                                       align="center"  width="110"  Edit="none"  show="false" </c>
	        	<c>id="docType"                                                       align="center"  width="110"  Edit="none"  show="false" </c>
	        	<c>id="paymentBlock"                                                  align="center"  width="110"  Edit="none"  show="false" </c>
	        	<c>id="personalId"                                                    align="center"  width="110"  Edit="none"  show="false" </c>
	        	<c>id="attr1"                                                         align="center"  width="110"  Edit="none"  show="false" </c>
	        	<c>id="attr2"                                                         align="center"  width="110"  Edit="none"  show="false" </c>
	        	<c>id="attr3"                                                         align="center"  width="110"  Edit="none"  show="false" </c>
	        	<c>id="attr4"                                                         align="center"  width="110"  Edit="none"  show="false" </c>
	        	<c>id="attr5"                                                         align="center"  width="110"  Edit="none"  show="false" </c>
	        	<c>id="attr6"                                                         align="center"  width="110"  Edit="none"  show="false" </c>
	        	<c>id="attr7"                                                         align="center"  width="110"  Edit="none"  show="false" </c>
	        	<c>id="attr8"                                                         align="center"  width="110"  Edit="none"  show="false" </c>
	        	<c>id="attr9"                                                         align="center"  width="110"  Edit="none"  show="false" </c>
	        	<c>id="attr10"                                                        align="center"  width="110"  Edit="none"  show="false" </c>  
	        	<c>id="baselineDate"                                                  align="center"  width="110"  Edit="none"  show="false" </c>
	        	<c>id="paymentMethod"                                                 align="center"  width="110"  Edit="none"  show="false" </c>
	        	<c>id="partnerBankType"                                               align="center"  width="110"  Edit="none"  show="false" </c>
	        	<c>id="exchRate"                                                      align="center"  width="110"  Edit="none"  show="false" </c>  '>	
	        </param>	      
		</object>
 	</div>	
	<!-- Open AP List GRID 영역 End -->
	
	<div class="sub_stitle">
		<p><%=columnData.getString("sub2_title") %></p>		
	</div>
	
	<!-- Payment Information 영역 Start -->
	<div id="output_board_area">
		
		<input type="hidden" id="vendCd" name="vendCd" value="" />
		<input type="hidden" id="currentDate" name="currentDate" value="<%= currentDate %>" />
		<input type="hidden" id="houseBankCurrCd" name="houseBankCurrCd" />
		
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board" >
			<colgroup>
	        	<col width="20%"/>
	        	<col width="30%"/>
	        	<col width="20%"/>
	        	<col width=""/>	        	
			</colgroup>    
	    	<tr>
		  		<th><%= columnData.getString("vend_nm") %></th>
          		<td><input type="text" id="vendNm" 	style="width:142px;" readonly class="txtField_read" /></td>
		  		<th><%= columnData.getString("curr_cd") %></th>
		  		<td><input type="text" id="currCd" 	style="width:142px;" readonly class="txtField_read" /></td>
		  	</tr>
		  	<tr>	
		  		<th><%= columnData.getString("baseline_date") %></th>
		  		<td>
		  			<input type="text" id="baselineDate" onblur="valiDate(this);" style="width:60px;" readonly />
					<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(baselineDate);" style="cursor:hand"/>
		      	</td>
		      	<th><%= columnData.getString("payment_method") %></th>
          		<td>					
					<object id="sPaymentMethod"  classid="<%=LGauceId.LUXECOMBO%>" width="150">
					    <param name="ComboDataID"       value="ds_paymentMethod">
						<param name="ListCount"     	value="10">
						<param name="BindColumn"    	value="code">
						<param name="WantSelChgEvent"   value="TRUE">
					    <param name=ListExprFormat		value="name^0^90,code^0^70">
					    <param name=index           	value=0>
				   	</object>					
		  		</td>
			</tr>
	    	<tr>		  												
		  		<th><%= columnData.getString("partner_bank_type") %></th>
		  		<td>
		  			<input id="partnerBankType" name="partnerBankType" type="text" style="width:40px;" readonly />&nbsp;
		  			<input id="partnerAcctNum" name="partnerAcctNum" type="text" style="width:120px;" readonly />&nbsp;
		  			<img src="<%= images %>button/search_icon_2.gif"  onClick="javascript:f_openVendorBankAcctListPop();" style="cursor:hand"/>
		  		</td>
		  		<th><%= columnData.getString("house_bank") %></th>
		  		<td>
		  			<input id="sHouseBank" name="sHouseBank" type="text" style="width:60px;" readonly />&nbsp;
		  			<input id="houseBankAcct" name="houseBankAcct" type="text" style="width:80px;" readonly />&nbsp;
		  			<img src="<%= images %>button/search_icon_2.gif"  onClick="javascript:f_openHouseBankPop();" style="cursor:hand"/>
		  		</td>		  		
			</tr>
	  	</table>			
	</div>
	<!-- Payment Information 영역 End -->
			
	<!-- 하단 버튼 영역 Start -->
	<div id="btn_area">
		<p class="b_right">
			<span class="btn_r btn_l"> 
				<input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnSave %>" onclick="javascript:f_Save()" />
			</span>
		</p>
	</div>
	<!-- 하단 버튼 영역 End --> 
	
	<comment id="__NSID__">
		<object id="bi_grid" classid="<%=LGauceId.BIND%>">
			<param name="DataID" value="ds_grid">
			<param name="BindInfo" value='
				<c> Col=vendCd  Ctrl=vendCd  Param=Value </c>
			    <c> Col=vendNm  Ctrl=vendNm	 Param=Value </c>                    
	            <c> Col=currCd  Ctrl=currCd  Param=Value </c>  '/>
		</object>
	</comment>
	<SCRIPT>__WS__(__NSID__);</SCRIPT>	
	
</div>	
</body>
</html>