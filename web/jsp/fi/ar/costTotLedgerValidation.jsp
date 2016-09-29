<%--
/*
 *************************************************************************
 * @source  : costTotLedgerValidation.jsp
 * @desc    : cost Total Ledger Excel Upload Validation
 *----------------------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  ---------------------------------------------------------
 * 1.0  2010/09/28   mskim       Init
 * 1.1  2015/12/01   hckim       그리드(Cost Price Detail) 내 Internal Order 필드 추가
 *                               Internal Order 필드 추가에 따른 유효성 검증 로직 추가
 * ---  -----------  ----------  ---------------------------------------------------------
 * PT-PAM System.
 * Copyright(c) 2006-2007 LG CNS,  All rights reserved.
 *****************************************************************************************
 */
--%>
 <%@ page import="java.util.*"%>
<%@ page import="devon.core.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/x1072html">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="blendTrans(Duration=0.0)" http-equiv="Page-Enter" />
<meta content="blendTrans(Duration=0.0)" http-equiv="Page-Exit" />
<title>Cost Total Ledger Validation</title>
<%@ include file="/include/head.jsp" %>

<%
	String prevDate	   = LDateUtils.getDate("yyyy/MM/") +"01"; 
	String currentDate = LDateUtils.getDate("yyyy/MM/dd");          // currentDate

    String msgWarnRetrieve    = source.getMessage("dev.warn.com.retrieve");   		// please first retrieve!
	String msgSave            = source.getMessage("dev.cfm.com.save");    			// Are you sure to save?
	String msgDelete          = source.getMessage("dev.cfm.com.delete");    		// Are you sure to Delete?

	String msgConfirm         = source.getMessage("dev.cfm.com.confirm");    		// Are you sure to confirm?
	String msgValidation      = source.getMessage("dev.cfm.com.validation");    	// Are you sure to validation?
			
	String msgCompDebitCredit = source.getMessage("dev.msg.fi.diffDebitCredit");    // The debit and credit total are not right
    String msgSucProcess      = source.getMessage("dev.suc.com.process");    		// successfully processed.
    String msgNoDataItem      = source.getMessage("dev.warn.com.noDataItem");    	// The selected item does not exist.
    String msgMustReqMode     = source.getMessage("dev.msg.fi.condCheck");    		// The selected condition must be Request Status.
	String msgNoNegativeNum	  = source.getMessage("dev.msg.fi.noNegativeNum");    	// The negative number will not be able to input!
	String msgSameNotVal      = source.getMessage("dev.msg.fi.sameNotValue");       // condition date is not the same month.
    String msgChkHeaderChk    = source.getMessage("dev.warn.com.chkHeaderCount");   // Check one Item.    
    String msgNoDetailSave    = source.getMessage("dev.warn.com.noDetailSave");     // Detail Data Must be Saved.
	String msgNoChange        = source.getMessage("dev.inf.com.nochange");          // no data for change.
	String msgErrorFound      = source.getMessage("dev.inf.com.errorFound");        // validation error data found.
	String msgChkCurrency     = source.getMessage("dev.warn.com.checkCurrency");    // The Currency IDR needs Integer Amount.		

	String msgInfoChange      = source.getMessage("dev.inf.com.nochange");          // no data for change.
	String msgNoDelete        = source.getMessage("dev.inf.com.nodelete");          // no data for deleting.
	String msgCheckEntryDate  = source.getMessage("dev.warn.com.checkEntryDate");   // Check searching condition.(Entry Date)		
%>

<script type="text/javascript">
parent.centerFrame.cols='220,*';
	// 주의: 하단 그리드의 컬럼이 추가되는 경우, [strHeaderDtl], [gr_grid]를 동일하게 구성해야 합니다.

   var strHeaderDtl = "chk"            + ":STRING(1)"
	                + "companyCd"      + ":STRING(4)"
	                + ",deptCd"        + ":STRING(4)"
	                + ",deptNm"        + ":STRING(100)"
	                + ",docYm"         + ":STRING(6)"
	                + ",docSeq"        + ":STRING(10)"
	                + ",amount"        + ":DECIMAL(13,2)"
	                + ",docType"       + ":STRING(1)"
	                + ",sapDocSeq"     + ":STRING(10)"
                    + ",currencyCd"    + ":STRING(3)"
                    + ",createDate"    + ":STRING(10)"
	                + ",docDate"       + ":STRING(10)"
	                + ",postDate"      + ":STRING(10)"
	                + ",errorMsg"      + ":STRING(20)"
	                + ",valiSuccessYn" + ":STRING(1)"
	                + ",valiSuccessNm" + ":STRING(10)"
	                + ",docDiv"        + ":STRING(1)"
	                + ",docDivNm"      + ":STRING(50)";

   var strBodyDtl = "companyCd"       + ":STRING(4)"
                  + ",deptCd"         + ":STRING(4)"
                  + ",docYm"          + ":STRING(6)"
                  + ",docSeq"         + ":STRING(10)"
                  + ",docNum"         + ":STRING(3)"
                  + ",sapAcctCd"      + ":STRING(10)"
                  + ",sapAcctNm"      + ":STRING(50)"
                  + ",debitAmt"       + ":DECIMAL(15.2)"
                  + ",creditAmt"      + ":DECIMAL(15.2)"
                  + ",costCenter"     + ":STRING(50)"                  
                  + ",intOrder"       + ":STRING(50)"
                  + ",intOrderNm"     + ":STRING(50)"
                  + ",docDesc"        + ":STRING(50)"
                  + ",vat"            + ":STRING(50)"
                  + ",base"           + ":DECIMAL(13.2)"
                  + ",code"           + ":STRING(50)"
                  + ",rate"           + ":DECIMAL(3.1)"
                  + ",dueDate"        + ":STRING(10)"
                  + ",spglNo"         + ":STRING(1)"
                  + ",sapAcctV"       + ":STRING(10)"
                  + ",sapAcctVNm"     + ":STRING(50)"
                  + ",sapAcctC"       + ":STRING(10)"
                  + ",sapAcctCNm"     + ":STRING(50)"
                  + ",errorMsg"       + ":STRING(100)"
                  + ",sp"             + ":STRING(1)"
                  + ",chkyn"          + ":STRING(1)"
                  + ",checkDuedate"   + ":STRING(1)"
                  + ",acctSapCd"      + ":STRING(10)"
                  + ",periodCostFrom" + ":STRING(10)"
                  + ",periodCostTo"   + ":STRING(10)";


var g_Pos =0;
	
//-------------------------------------------------------------------------
// 저장
//-------------------------------------------------------------------------
function f_Save() {
    
    if(ds_costTotDtl.CountRow == 0) {
        alert("<%= msgWarnRetrieve %>");      // please first retrieve!
        return;
    }
    
	// Save Data Check
	if (checkSaveData()) {

	    if(confirm("<%= msgSave %>")){     // Are you sure to save?
			mode = "process";

		  	var param = "companyCd=" + ds_costTotMst.Namevalue(ds_costTotMst.RowPosition,"companyCd")
		  				+",deptCd="  + ds_costTotMst.Namevalue(ds_costTotMst.RowPosition,"deptCd")
		  				+",docYm=" 	 + ds_costTotMst.Namevalue(ds_costTotMst.RowPosition,"docYm")
		  				+",docSeq="  + ds_costTotMst.Namevalue(ds_costTotMst.RowPosition,"docSeq")
		  	;

			g_Pos = ds_costTotMst.RowPosition;	 
			
			tr_cudData.Parameters = param;
			tr_cudData.KeyValue	  = "JSP(I:IN_DS1=ds_costTotMst, I:IN_DS2=ds_costTotDtl)";
			tr_cudData.Action     = "fi.ar.cudCostTotLedgerValidation.gau";
			tr_cudData.Post();
		}
	
	}

}

//-------------------------------------------------------------------------
// Cost Total Ledger Delete
//-------------------------------------------------------------------------	
function f_Delete(){

	var chk_cnt = 0;
	for(var i=1; i <= ds_costTotMst.countRow; i++){
		if(ds_costTotMst.NameValue(i,"chk") == "T"){
			chk_cnt = chk_cnt + 1;
		}
	}

	if( chk_cnt == 0 ) {
		alert('<%= msgChkHeaderChk %>');
		return;
	}
	
	if (checkDelData()) {

		//Dataset 저장		
		saveCudData();

		if (confirm('<%= msgDelete %>')) {
			mode = "process";

		  	var param = "companyCd=" + ds_costTotMst.Namevalue(ds_costTotMst.RowPosition,"companyCd")
					   +",deptCd=" + ds_costTotMst.Namevalue(ds_costTotMst.RowPosition,"deptCd")
					   +",docYm=" + ds_costTotMst.Namevalue(ds_costTotMst.RowPosition,"docYm")
					   +",docSeq=" + ds_costTotMst.Namevalue(ds_costTotMst.RowPosition,"docSeq");
					   
			tr_cudData.Parameters = param;
			tr_cudData.KeyValue	= "JSP(I:IN_DS1=ds_cudMstData)";
			tr_cudData.Action   = "fi.ar.deleteCostTotLedgerValidation.gau";
	 		tr_cudData.Post();//Cost Total Ledger Approval

	 	}
 	
 	}

}

//-------------------------------------------------------------------------
// Cost Total Ledger Transfer
//-------------------------------------------------------------------------	
function f_Transfer(){

	if(ds_costTotMst.CountRow == 0){
		alert('<%=source.getMessage("dev.warn.com.nonData", columnData.getString("cost_master")) %>');
		return false;
	}

	var chk_cnt = 0;
	for(var i=1; i <= ds_costTotMst.countRow; i++){
		var valiSuccessYn =	ds_costTotMst.NameValue(i,"valiSuccessYn")
		if(ds_costTotMst.NameValue(i,"chk") == "T"){
			chk_cnt = chk_cnt + 1;
			
			if ( valiSuccessYn == "N" ) {
				alert('<%= msgErrorFound %>');
				ds_costTotMst.RowPosition = i;
				gr_costTotMst.SetColumn("chk");
				return;
			}
		
		}
	}

	if( chk_cnt == 0 ) {
		alert('<%= msgChkHeaderChk %>');
		return;
	}
		
	//Dataset 저장		
	saveCudData();

	if (confirm('<%= msgConfirm %>')) {
		mode = "process";

	  	var param = "companyCd=" + ds_costTotMst.Namevalue(ds_costTotMst.RowPosition,"companyCd")
				   +",deptCd=" + ds_costTotMst.Namevalue(ds_costTotMst.RowPosition,"deptCd")
				   +",docYm=" + ds_costTotMst.Namevalue(ds_costTotMst.RowPosition,"docYm")
				   +",docSeq=" + ds_costTotMst.Namevalue(ds_costTotMst.RowPosition,"docSeq");
				   
		tr_cudData.Parameters = param;
		tr_cudData.KeyValue	= "JSP(I:IN_DS1=ds_cudMstData)";
		tr_cudData.Action   = "fi.ar.cudCostTotLedgerTransValidation.gau";
 		tr_cudData.Post();//Cost Total Ledger Approval

 	}

}

//-------------------------------------------------------------------------
// Cost Total Ledger Validation
//-------------------------------------------------------------------------	
function f_Validation(){

	if (confirm('<%= msgValidation %>')) {
		mode = "process";

	    var param = "deptCd=<%=g_companyCd%>"
	 		      +",orderDateFrom=" + removeDash(document.all.orderDateFrom.value,"/")
	 		      +",orderDateTo=" + removeDash(document.all.orderDateTo.value,"/");	    
	    
		tr_cudValiData.Parameters = param;
		tr_cudValiData.KeyValue	= "JSP(I:IN_DS1=ds_cudMstData)";
		tr_cudValiData.Action   = "fi.ar.cudCostTotLedgerCheckValidation.gau";
 		tr_cudValiData.Post();//Cost Total Ledger Approval

 	}

}

//-------------------------------------------------------------------------
// Master 삭제시 체크
//-------------------------------------------------------------------------
function checkDelData() {

	if(ds_costTotMst.CountRow == 0){
		alert('<%=source.getMessage("dev.warn.com.nonData", columnData.getString("cost_master")) %>');
		return false;
	}

	var RowStatus = ds_costTotMst.RowStatus(ds_costTotMst.RowPosition);
	if ( RowStatus == 1 ) {
    	ds_costTotMst.DeleteRow(ds_costTotMst.RowPosition);      // 신규 추가건만 삭제 가능
    	//ds_purchReqDtl.ClearAll();
    	return false;
    }
    
	return true;
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
			  +"currencyCd:VARCHAR(3)"
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
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"currencyCd") = ds_costTotMst.NameValue(i,"currencyCd");
		}
	}
	
}




//-------------------------------------------------------------------------
// Master 승인 / 취소 시 필수 체크 사항
//-------------------------------------------------------------------------
function checkSaveData() {
	

	
<%-- CostTotLedgerMgnt.jsp 에서 복사해 오기 이전 버전 validation --%>
	// 통화코드
	var currencyCd = ds_costTotMst.Namevalue(ds_costTotMst.RowPosition,"currencyCd");

 	// Retrieve Date Check    
    if (!checkData()) { 
    	return false;
    }

	if(ds_costTotDtl.CountRow == 0){
		alert('<%= msgNoDataItem %>');
		return false;
	}

	if ( !ds_costTotMst.IsUpdated && !ds_costTotDtl.IsUpdated) {
    	alert("<%= msgNoChange %>");
		return false;
	}

	for(var i=1; i <= ds_costTotDtl.countRow; i++){

		var debitAmt      = ds_costTotDtl.NameValue(i,"debitAmt");
		var creditAmt     = ds_costTotDtl.NameValue(i,"creditAmt");
		var baseAmt       = ds_costTotDtl.NameValue(i,"base");												
		var sDotDebitAmt  = "0"; // debitAmt 소수점이하 초기값
		var sDotCreditAmt = "0"; // creditAmt 소수점이하 초기값
		var sDotBaseAmt   = "0"; // baseAmt 소수점이하 초기값

		//essential Field Check
		if(ds_costTotDtl.NameValue(i,"sapAcctCd") == ""){
			alert('<%=source.getMessage("dev.warn.com.input",columnData.getString("acct_cd"))%>');
			ds_costTotDtl.RowPosition = i;
			gr_costTotDtl.SetColumn("sapAcctCd");
			return false;
		} 

		// 통화코드 : MMK (Myanmar) 인 경우 소수점 입력 여부 체크
		if(currencyCd == "MMK"){
			
			// debitAmt 소수점 값이 있는 경우
			if(String(debitAmt).indexOf(".", 0) != -1){
				sDotDebitAmt = removeDash(String(debitAmt).substring(String(debitAmt).indexOf(".", 0), String(debitAmt).length),".");	
			}						
			
			// creditAmt 소수점 값이 있는 경우
			if(String(creditAmt).indexOf(".", 0) != -1){
				sDotCreditAmt = removeDash(String(creditAmt).substring(String(creditAmt).indexOf(".", 0), String(creditAmt).length),".");	
			}						
			
			// baseAmt 소수점 값이 있는 경우
			if(String(baseAmt).indexOf(".", 0) != -1){
				sDotBaseAmt = removeDash(String(baseAmt).substring(String(baseAmt).indexOf(".", 0), String(baseAmt).length),".");	
			}						
			
			// debitAmt 입력시 소수점 등록 여부 체크
			if(Number(sDotDebitAmt) > 0){
				alert("<%=msgChkCurrency%>");
				
				ds_costTotDtl.RowPosition = i;
				gr_costTotDtl.SetColumn("debitAmt");
				
				return false;				
			}
			
			// creditAmt 입력시 소수점 등록 여부 체크
			if(Number(sDotCreditAmt) > 0){
				alert("<%=msgChkCurrency%>");
				
				ds_costTotDtl.RowPosition = i;
				gr_costTotDtl.SetColumn("creditAmt");
				
				return;
			}
			
			// baseAmt 입력시 소수점 등록 여부 체크
			if(Number(sDotBaseAmt) > 0){
				alert("<%=msgChkCurrency%>");
				
				ds_costTotDtl.RowPosition = i;
				gr_costTotDtl.SetColumn("base");
				
				return;
			}
			
		}
		
		//Negative DebitAmt Check
		if ( debitAmt < 0 ) {
			alert("<%= msgNoNegativeNum %>");
			ds_costTotDtl.RowPosition = i;
			gr_costTotDtl.SetColumn("debitAmt");
			return false;
		}

		//Negative CreditAmt Check
		if ( creditAmt < 0 ) {
			alert("<%= msgNoNegativeNum %>");
			ds_costTotDtl.RowPosition = i;
			gr_costTotDtl.SetColumn("creditAmt");
			return false;
		}

		//Debit & Credit Compare Check
		if(debitAmt == 0.0 && creditAmt == 0.0 ){
			alert("<%= msgCompDebitCredit %>");
			ds_costTotDtl.RowPosition = i;
			gr_costTotDtl.SetColumn("debitAmt");
			return false;
		} 
		
		
		
		

		//부가세 입력 검사   2016 01 14 수정
				var sapAcctCd = ds_costTotDtl.NameValue(i,"sapAcctCd");
		//부가세 계정 갯수 만큼 현재 로우를 비교 조사
		for( var j=1; j <= ds_checkSapVatAccount.CountRow; j++ ) {
			//alert("1. 현재로우 계정코드"+ds_costTotDtl.NameValue(row,"sapAcctCd")+"\n2. SAP VAT계정코드"+ds_checkSapVatAccount.NameValue( j , "acctSapCd" )+"3. VAT계정코드 맞는지"+ds_checkSapVatAccount.NameValue( j , "attr3" ));
			
			//부가세입력 받거나 받지 말아야 할 리스트 && 부가세 받아야 하는 경우
			if( ds_costTotDtl.NameValue(i,"sapAcctCd")== ds_checkSapVatAccount.NameValue( j , "acctSapCd" ) && ds_checkSapVatAccount.NameValue( j , "attr3" ) == 'Y'  ){
				
				if(ds_costTotDtl.NameValue(i,"vat")== null || ds_costTotDtl.NameValue(i,"vat")== ""){
					alert(ds_costTotDtl.NameValue(i,"sapAcctCd") + " is Tax account. \n Check Tax code");
					gr_costTotDtl.SetColumn("vat");
					return false;
				}
/* 				if(ds_costTotDtl.NameValue(i,"base")== null || ds_costTotDtl.NameValue(i,"base")== ""){
					alert(ds_costTotDtl.NameValue(i,"sapAcctCd") + " is VAT account. \n Check VAT amount");
					gr_costTotDtl.SetColumn("base");
					return false;
				} */
				
			}
			
			
			//원천세 계정 여부 체크는 두 가지 로직으로 되어 있음. 왜 이렇게 해 놨는지는 모르겠다 2016 01 14
			//원천세 계정인 경우 입력 불가 1 테이블에 attr3 이 N 표시 되어 있는 녀석들
			if( ds_costTotDtl.NameValue(i,"sapAcctCd")== ds_checkSapVatAccount.NameValue( j , "acctSapCd" ) && ds_checkSapVatAccount.NameValue( j , "attr3" ) == 'N') {
				//계정이 원천세 계정인 경우
				
				 if(ds_costTotDtl.NameValue(i,"vat")!= ""){
						alert("Account "+ds_costTotDtl.NameValue(i,"sapAcctCd")+ " is not required Tax");
						gr_costTotDtl.SetColumn("vat");
						return false;
				}
/* 				if(ds_costTotDtl.NameValue(i,"base")!= ""){
						alert("Account "+ds_costTotDtl.NameValue(i,"sapAcctCd")+ " is not required VAT amount");
						gr_costTotDtl.SetColumn("base");
						return false;
				} */
					
			}
			
			//원천세 계정인 경우 입력 불가 2 Commcd 에 등록 되어 있는 것들로 검사
			for(var j=1; j <= ds_checkAccount.countRow; j++){
				var acctCd = ds_checkAccount.NameValue(j,"acctCd");
				
				//계정코드가원천세 계정코드인 경우
				if (sapAcctCd == acctCd){		
					
					//계정이 원천세 계정인 경우
					 if(ds_costTotDtl.NameValue(i,"vat")!= ""){
							alert("Account "+ds_costTotDtl.NameValue(i,"sapAcctCd")+ " is not required VAT");
							gr_costTotDtl.SetColumn("vat");
							return false;
					}
					
					
/* 					if(ds_costTotDtl.NameValue(i,"base")!= ""){
							alert("Account "+ds_costTotDtl.NameValue(i,"sapAcctCd")+ " is not required VAT amount");
							gr_costTotDtl.SetColumn("base");
							return false;
					} */
						
				} 
			}
			
			
		}
		
		
		if (ds_costTotDtl.NameValue(i,"sp") == "D"){
			if(ds_costTotDtl.NameValue(i,"sapAcctCNm") == "") {
   				alert('<%=source.getMessage("dev.warn.com.input", columnData.getString("sap_acct_c"))%>');
				ds_costTotDtl.RowPosition = i;
				gr_costTotDtl.SetColumn("sapAcctCNm");
				return false;
			}
			
			if(ds_costTotDtl.NameValue(i,"sapAcctVNm") != "") {
   				alert('<%=source.getMessage("dev.warn.com.notRequired", columnData.getString("sap_acct_v"))%>');
				ds_costTotDtl.RowPosition = i;
				gr_costTotDtl.SetColumn("sapAcctVNm");
				return false;
			}
		}

		if (ds_costTotDtl.NameValue(i,"sp") == "K"){
			if(ds_costTotDtl.NameValue(i,"sapAcctVNm") == "") {
   				alert('<%=source.getMessage("dev.warn.com.input", columnData.getString("sap_acct_v"))%>');
				ds_costTotDtl.RowPosition = i;
				gr_costTotDtl.SetColumn("sapAcctVNm");
				return false;
			}

			if(ds_costTotDtl.NameValue(i,"sapAcctCNm") != "") {
   				alert('<%=source.getMessage("dev.warn.com.notRequired", columnData.getString("sap_acct_c"))%>');
				ds_costTotDtl.RowPosition = i;
				gr_costTotDtl.SetColumn("sapAcctCNm");
				return false;
			}			
			
		}

		if (ds_costTotDtl.NameValue(i,"sp") == "S"){
		
			if(ds_costTotDtl.NameValue(i,"spglNo") != "") {
   				alert('<%=source.getMessage("dev.warn.com.notRequired", columnData.getString("spgl_no"))%>');
				ds_costTotDtl.RowPosition = i;
				gr_costTotDtl.SetColumn("spglNo");
				return false;
			}
			
			if(ds_costTotDtl.NameValue(i,"sapAcctCNm") != "") {
   				alert('<%=source.getMessage("dev.warn.com.notRequired", columnData.getString("sap_acct_c"))%>');
				ds_costTotDtl.RowPosition = i;
				gr_costTotDtl.SetColumn("sapAcctCNm");
				return false;
			}
			
			if(ds_costTotDtl.NameValue(i,"sapAcctVNm") != "") {
   				alert('<%=source.getMessage("dev.warn.com.notRequired", columnData.getString("sap_acct_v"))%>');
				ds_costTotDtl.RowPosition = i;
				gr_costTotDtl.SetColumn("sapAcctVNm");
				return false;
			}

			if(ds_costTotDtl.NameValue(i,"checkDuedate") == "Y") {
				if(ds_costTotDtl.NameValue(i,"dueDate") == "") {
	   				alert('<%=source.getMessage("dev.warn.com.input", columnData.getString("due_date"))%>');
					ds_costTotDtl.RowPosition = i;
					gr_costTotDtl.SetColumn("dueDate");
					return false;
				}
			}

		}
		
		var accountCode = ds_costTotDtl.NameValue(i,"sapAcctCd"); // Documnet Detail 그리드 - Account Code
		var accountCodeF = accountCode.substring(0,1);            // Account Code 첫자리
		
		// Account Code 첫자리가 '8' 인 경우 Cost center 만 입력 가능
		// 상업 생산 시점 까지
		if(accountCodeF == "8"){
			
			// Cost center 값이 없는 경우
			if(ds_costTotDtl.NameValue(i,"costCenter") == "") {
				alert('<%=source.getMessage("dev.warn.com.input", columnData.getString("cost_center").replaceAll(";", " "))%>');
				ds_costTotDtl.RowPosition = i;
				gr_costTotDtl.SetColumn("costCenter");
				return false;
			}
			
			// CIP & DEC 값이 있는 경우
			if(ds_costTotDtl.NameValue(i,"intOrderNm") != "") {
				alert('<%=source.getMessage("dev.warn.com.notRequired", columnData.getString("order").replaceAll(";", " "))%>');
				ds_costTotDtl.RowPosition = i;
				gr_costTotDtl.SetColumn("intOrderNm");
				return false;
			}
		}
		
		// Account Code 첫자리가 '9' 인 경우 CIP & DEC (I/O) 만 입력 가능
		// 상업 생산 시점 까지
		if(accountCodeF == "9"){
			
			// Cost center 값이 있는 경우
			if(ds_costTotDtl.NameValue(i,"costCenter") != "") {
				alert('<%=source.getMessage("dev.warn.com.notRequired", columnData.getString("cost_center").replaceAll(";", " "))%>');
				ds_costTotDtl.RowPosition = i;
				gr_costTotDtl.SetColumn("costCenter");
				return false;
			}
			
			// CIP & DEC 값이 없는 경우
			if(ds_costTotDtl.NameValue(i,"intOrderNm") == "") {
				alert('<%=source.getMessage("dev.warn.com.input", columnData.getString("order").replaceAll(";", " "))%>');
				ds_costTotDtl.RowPosition = i;
				gr_costTotDtl.SetColumn("intOrderNm");
				return false;
			
			//9번대 계정 아닌데 IO 코드 있는 경우
		} else if (  accountCodeF != "9" && ds_costTotDtl.NameValue(i,"intOrderNm") != ""){
			alert("CIP / DEC cannot allowed on this account code\n" + accountCode+"");
			ds_costTotDtl.RowPosition = i;
			gr_costTotDtl.SetColumn("intOrderNm");
			return false;
		}
					
		
		//Cost Price Detail 그리드 Data 저장/수정 시 - Cost Center, I/O 필드 정보 중 하나의 정보만 저장/수정 가능
		var center = ds_costTotDtl.NameValue(i,"costCenter");
		var intOrder = ds_costTotDtl.NameValue(i,"intOrder");
		
		if ( center == "" && intOrder == "") {
			alert('<%=source.getMessage("dev.warn.com.inputIoCost")%>');			
			ds_costTotDtl.RowPosition = i;
			gr_costTotDtl.SetColumn("costCenter");
			return false;
		}
		
		if ( center != "" && intOrder != "") {
			alert('<%=source.getMessage("dev.warn.com.chooseIoCost")%>');
			ds_costTotDtl.RowPosition = i;
			gr_costTotDtl.SetColumn("costCenter");
			return false;
		}
		
		if(ds_costTotDtl.NameValue(i,"spglNo") != "") {
			if(ds_costTotDtl.NameValue(i,"dueDate") == "") {
   				alert('<%=source.getMessage("dev.warn.com.input", columnData.getString("due_date"))%>');
				ds_costTotDtl.RowPosition = i;
				gr_costTotDtl.SetColumn("dueDate");
				return false;
			}
		}
		
		var chkDateVal = true;
		if(ds_costTotDtl.NameValue(i,"dueDate")!=""){
			chkDateVal = valiDate2(ds_costTotDtl.NameValue(i,"dueDate"));
			if(chkDateVal == "F"){
				ds_costTotDtl.RowPosition = i;
				gr_costTotDtl.SetColumn("dueDate");
				return false;
			}
		}		
		
		// 기간비용 계정 인 경우 기간비용시작일자, 기간비용종료일자 필수 입력 유효성 체크
		for( var k=1; k <= ds_checkPeriodCostAccount.CountRow; k++ ) {
			
			// 입력한 Account Code가 기간비용 계정인 경우
			if(ds_checkPeriodCostAccount.NameValue( k , "code" ) == ds_costTotDtl.NameValue(i,"sapAcctCd") ) {
				// 기간비용시작일자를 입력하지 않는 경우
				if(ds_costTotDtl.NameValue(i,"periodCostFrom") == "" || ds_costTotDtl.NameValue(i,"periodCostFrom") == null){
					alert('<%=source.getMessage("dev.warn.com.input", "Period from date")%>');
					ds_costTotDtl.RowPosition = i;
					gr_costTotDtl.SetColumn("periodCostFrom");
					return false;
				}
				
				// 기간비용종료일자를 입력하지 않는 경우
				if(ds_costTotDtl.NameValue(i,"periodCostTo") == "" || ds_costTotDtl.NameValue(i,"periodCostTo") == null){
					alert('<%=source.getMessage("dev.warn.com.input", "Period to date")%>');
					ds_costTotDtl.RowPosition = i;
					gr_costTotDtl.SetColumn("periodCostTo");
					return false;
				}
				
				// 기간비용시작일자는 Posting Date와 동일해야함
				if(ds_costTotDtl.NameValue(i,"periodCostFrom") != removeDash(ds_costTotMst.NameValue(ds_costTotMst.RowPosition ,"postDate"),"/")){
					alert('Posting date and period from date are in different periods.');
					ds_costTotDtl.RowPosition = i;
					gr_costTotDtl.SetColumn("periodCostFrom");
					return false;
				}
				
				// 기간비용시작일자는 기가비용종료일자와 같을 수 없음
				if(ds_costTotDtl.NameValue(i,"periodCostFrom") == ds_costTotDtl.NameValue(i,"periodCostTo")){
					alert('Period from date and period to date are in same periods.');
					ds_costTotDtl.RowPosition = i;
					gr_costTotDtl.SetColumn("periodCostFrom");
					return false;
				}
				
				// 기간비용시작일자는 기가비용종료일자 보다 클 수 없음
				if(ds_costTotDtl.NameValue(i,"periodCostFrom") >= ds_costTotDtl.NameValue(i,"periodCostTo")){
					alert('Period from date cannot be later than period end date.');
					ds_costTotDtl.RowPosition = i;
					gr_costTotDtl.SetColumn("periodCostTo");
					return false;
				}
			}
		}
				
	}

	var debitAmt  = ds_costTotDtl.NameSum('debitAmt',0,0);
	var creditAmt = ds_costTotDtl.NameSum('creditAmt',0,0);
	if ( debitAmt != creditAmt) {
		alert("<%= msgCompDebitCredit %>");
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

	var _orderFromdate = removeDash(document.all.orderDateFrom.value,"/").substring(0,6);
	var _orderTodate   = removeDash(document.all.orderDateTo.value,"/").substring(0,6);

	if ( _orderFromdate != _orderTodate ) {
		alert('<%= msgSameNotVal %>');
		document.all.orderDateFrom.focus();
		return false;
	}
	
	var orderDateFrom = removeDash(document.all.orderDateFrom.value,"/");
	var orderDateTo   = removeDash(document.all.orderDateTo.value,"/");
	
	// Entry Date 시작일자, 종료일자가 모두 있는 경우
	if(orderDateFrom != "" && orderDateTo != ""){
		
		// Entry Date 시작일자가 Entry Date 종료일자보다 클 경우
		if(Number(orderDateFrom) > Number(orderDateTo)){
			alert('<%= msgCheckEntryDate %>');
			return false;
		}
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
	    	condition += "&deptCd=<%=g_companyCd%>";
	 		condition += "&valiSuccessYn=" + valiSuccessYn.ValueOfIndex("code",valiSuccessYn.Index)
	 		condition += "&orderDateFrom=" + removeDash(document.all.orderDateFrom.value,"/");
	 		condition += "&orderDateTo=" + removeDash(document.all.orderDateTo.value,"/");
	 	
	 	ds_costTotMst.DataID = "fi.ar.retrieveCostTotLedgerMstValidation.gau"+condition;
		ds_costTotMst.Reset();
		
	}
}

//-------------------------------------------------------------------------
// Add Item
//-------------------------------------------------------------------------
function f_Add(){

	if(ds_costTotMst.CountRow == 0){
		alert('<%= msgNoDataItem %>');
		return false;
	}
	
    if(ds_costTotDtl.CountRow == 0) {
        cfHideNoDataMsg(gr_costTotDtl);           // 최초 입력인 경우, 해당 건을 만들어주고 진행해야한다.
        ds_costTotDtl.ClearAll();
        ds_costTotDtl.setDataHeader( strBodyDtl );
		cfSetSearchGridBtn(strBodyDtl);
    }

	ds_costTotDtl.AddRow();
	ds_costTotDtl.Namevalue(ds_costTotDtl.RowPosition,"companyCd") = ds_costTotMst.Namevalue(ds_costTotMst.RowPosition,"companyCd");
	ds_costTotDtl.Namevalue(ds_costTotDtl.RowPosition,"deptCd")    = deptCd.ValueOfIndex("code",deptCd.Index);
	ds_costTotDtl.Namevalue(ds_costTotDtl.RowPosition,"docYm")     = ds_costTotMst.Namevalue(ds_costTotMst.RowPosition,"docYm");
	ds_costTotDtl.Namevalue(ds_costTotDtl.RowPosition,"docSeq")    = ds_costTotMst.Namevalue(ds_costTotMst.RowPosition,"docSeq");

	// Cost Center Retrieve
	f_RetrieveCostCenter();
	cfDsUnionBlank(ds_costCenter, "code", "code","");
	
}
	
//-------------------------------------------------------------------------
// Del Item
//-------------------------------------------------------------------------
function f_Del(){
    ds_costTotDtl.DeleteRow(ds_costTotDtl.RowPosition);      // 신규 추가건만 삭제 가능
}

//-------------------------------------------------------------------------
// Page Init
//-------------------------------------------------------------------------
function f_Init() {

	//f_Disable()
	deptCd.Enable = false;
//	docDiv.Enable = false;	 //전표구분
//	cfDsUnionBlank(ds_vat, "code", "name","");

}

//-------------------------------------------------------------------------
// 검색
//-------------------------------------------------------------------------
function f_RetrieveCostCenter() {

	var condition = "?";
 		condition += "&postDate=" + removeDash(document.all.postDate.value,"/");
 		
	//cost Center
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

<!-- Payment Arrange CUD TR -->
<OBJECT id=tr_cudValiData classid="<%=LGauceId.TR%>">
    <param name="KeyName"   value="toinb_dataid4">
    <param name="ServerIP"  value="">
</OBJECT>

<!-----------------------------------------------------------------------------
    D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-- Grid 용 Master DataSet-->
<object id="ds_costTotMst" 	classid="<%=LGauceId.DATASET%>" >
  <param name="SyncLoad"          value="true">
  <param name="ViewDeletedRow"    value="false">
</object>

<!-- Grid 용 Detail DataSet-->
<object id="ds_costTotDtl" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/> 
  <param name="ViewDeletedRow"    value="false"/>
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

<!-- Create Type combo DataSet -->
<object id="ds_createType"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
	<param name="DataID"          value="cm.cm.retrieveCommCodeCombo.gau?groupCd=2003&firstVal=Total">
</object>

<!-- Currency combo DataSet -->
<object id="ds_currencyCd"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
	<param name="DataID"          value="cm.cm.retrieveCommCodeCombo.gau?groupCd=2004">
</object>

<!-- cost Center 용 DataSet-->
<object id="ds_costCenter" classid="<%=LGauceId.DATASET%>" >
  	<param name="SyncLoad"          value="true"> 
</object>

<!-- SPGL Combo 용 DataSet-->
<object id="ds_spgl" classid="<%=LGauceId.DATASET%>" >
  	<param name="SyncLoad"          value="true"> 
</object>

<!-- Type combo DataSet -->
<object id="ds_docDiv"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
	<param name="DataID"          value="cm.cm.retrieveCommCodeCombo.gau?groupCd=2013">
</object>

<!-- Vat combo DataSet -->
<object id="ds_vat"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
	<param name="DataID"          value="fi.ar.retrieveCostTotLedgerValidationVatVCombo.gau">
</object>

<!-- Vat combo DataSet   원천세 계정 리스트-->
<object id="ds_checkAccount" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
	<param name="DataID"          value="cm.cm.retrieveCheckAccountList.gau">
</object>

<!-- 2016 01 14 VAT Check from table -->
<object id="ds_checkSapVatAccount" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
	<param name="DataID"          value="cm.cm.retrieveSapVatAcctCdList.gau?type=v">
</object>

<!-- 기간비용 계정 정보 목록 -->
<object id="ds_checkPeriodCostAccount" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
	<param name="DataID"          value="cm.cm.retrieveCommCodeCombo.gau?groupCd=PCST">
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
  
  //alert(ds_costTotMst.DataHeader);
  
</script>

<script language=JavaScript for=ds_costTotMst event=OnLoadError()>
  cfShowErrMsg(ds_costTotMst);
  //mode = "";
</script>

<!-- Cost Total Validation Detail 조회 DataSet -->
<script language=JavaScript for=ds_costTotDtl event=OnLoadCompleted(rowCnt)>
  cfFillGridNoDataMsg(gr_costTotDtl,"gridColLineCnt=2");//no data found   
</script>

<script language=JavaScript for=ds_costTotDtl event=OnLoadError()>
  cfShowErrMsg(ds_costTotDtl);
</script>

<script language="javascript"  for=ds_costTotMst event=OnRowPosChanged(row)>

	//Detail Dataset Clear
  	ds_costTotDtl.ClearData();

	if ( row > 0 ) {

	    var condition = "?";
		condition += "&companyCd="+ds_costTotMst.NameValue(row,"companyCd");
		condition += "&deptCd="+ds_costTotMst.NameValue(row,"deptCd");
		condition += "&docYm="+ds_costTotMst.NameValue(row,"docYm");
		condition += "&docSeq="+ds_costTotMst.NameValue(row,"docSeq");
		ds_costTotDtl.DataID = "fi.ar.retrieveCostTotLedgerDtlValidation.gau"+condition;
		ds_costTotDtl.Reset();

		// Cost Center Retrieve
		f_RetrieveCostCenter();
		cfDsUnionBlank(ds_costCenter, "code", "name","");				
	}

</script>

<script language=JavaScript for=DataSetID event=OnColumnChanged(row,colid)>

</script>

<!-- 저장 TR -->
<script language=JavaScript for=tr_cudData event=OnSuccess()>
	mode = "";
	alert("<%= msgSucProcess %>");
	f_Retrieve();
	ds_costTotMst.RowPosition = g_Pos;
	
</script>

<script language=JavaScript for=tr_cudData event=OnFail()>
	if(tr_cudData.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
        window.parent.location.href = "/index.jsp";    
   	}
   
   	if ( tr_cudData.ErrorMsg.indexOf("simpleMsg")) {
		var cnt = 12 + tr_cudData.ErrorMsg.indexOf("simpleMsg");
		alert(tr_cudData.ErrorMsg.substring(cnt, tr_cudData.ErrorMsg.length));
   	} else {
   		alert("Error Code : " + tr_cudData.ErrorCode + "\n" + "Error Message : " + tr_cudData.ErrorMsg + "\n");  
	}
</script>

<!-- 저장 TR -->
<script language=JavaScript for=tr_cudValiData event=OnSuccess()>
	mode = "";
	alert("<%= msgSucProcess %>");
	f_Retrieve();
</script>

<script language=JavaScript for=tr_cudValiData event=OnFail()>
	if(tr_cudValiData.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
        window.parent.location.href = "/index.jsp";    
   	}
   
   	if ( tr_cudValiData.ErrorMsg.indexOf("simpleMsg")) {
		var cnt = 12 + tr_cudValiData.ErrorMsg.indexOf("simpleMsg");
		alert(tr_cudValiData.ErrorMsg.substring(cnt, tr_cudValiData.ErrorMsg.length));
   	} else {
   		alert("Error Code : " + tr_cudValiData.ErrorCode + "\n" + "Error Message : " + tr_cudValiData.ErrorMsg + "\n");  
	}
</script>

<script language=JavaScript for="ds_costTotDtl" event=OnRowPosChanged(row)>
	
	if(row>0){

		var special = ds_costTotDtl.NameValue(row,"sp");
		var groupCode = "";

		if ( special == "D") groupCode = "2009";
		if ( special == "K") groupCode = "2010";

		if ( special != "S") { 
			var v_url = new cfURI();
			v_url.Add("groupCd",groupCode);
			v_url.SetPage("cm.cm.retrieveCommCodeCombo.gau");		
			ds_spgl.DataId = v_url.GetURI(); 
			ds_spgl.Reset();

		}
		cfDsUnionBlank(ds_spgl, "code", "name","");

	}

	if (ds_costTotDtl.NameValue(row,"sp") == "K" ||
	    ds_costTotDtl.NameValue(row,"sp") == "D" || 
        (ds_costTotDtl.NameValue(row,"sp") == "S" && ds_costTotDtl.NameValue(row,"checkDuedate") == "Y")){
		gr_costTotDtl.ColumnProp("dueDate", "Edit") = "RealNumeric";
	} else {
		gr_costTotDtl.ColumnProp("dueDate", "Edit") = "none";
	}
	
	var pcaCnt = 0; // 기간비용계정 수
	
	// 선택한 계정코드가 기간비용 계정 인지 유무 체크
	for( var k=1; k <= ds_checkPeriodCostAccount.CountRow; k++ ) {
		if(ds_checkPeriodCostAccount.NameValue(k , "code") == ds_costTotDtl.NameValue(row,"sapAcctCd")){
			pcaCnt++;
		}
	}
	
	// 기간비용시작일자, 기간비용종료일자 날짜팝업 활성화
	if(pcaCnt > 0){
		gr_costTotDtl.ColumnProp("periodCostFrom", "Edit") = "RealNumeric";
		gr_costTotDtl.ColumnProp("periodCostTo", "Edit") = "RealNumeric";
	
	// 기간비용시작일자, 기간비용종료일자 날짜팝업 비활성화
	}else{
		ds_costTotDtl.NameValue(row,"periodCostFrom") = "";
		gr_costTotDtl.ColumnProp("periodCostFrom", "Edit") = "none";
		ds_costTotDtl.NameValue(row,"periodCostTo") = "";
		gr_costTotDtl.ColumnProp("periodCostTo", "Edit") = "none";
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

<script language="javascript"  for=gr_costTotDtl event=OnColumnPosChanged(row,colid)>
    
    // SEARCH 버튼  DISPLAY
    if (colid.toLowerCase() == "sapacctcd") cfSetSearchGridBtn(gr_costTotDtl);
    if (colid.toLowerCase() == "sapacctcnm")  cfSetSearchGridBtn(gr_costTotDtl);
    if (colid.toLowerCase() == "sapacctvnm")  cfSetSearchGridBtn(gr_costTotDtl);
    if (colid.toLowerCase() == "duedate")   cfSetCalendarGridBtn(gr_costTotDtl);
    if (colid.toLowerCase() == "intordernm")  cfSetSearchGridBtn(gr_costTotDtl);
    if (colid.toLowerCase() == "periodcostfrom") cfSetCalendarGridBtn(gr_costTotDtl);
    if (colid.toLowerCase() == "periodcostto") cfSetCalendarGridBtn(gr_costTotDtl);

	if (colid.toLowerCase() == "spglno") {
		var special = ds_costTotDtl.NameValue(row,"sp");
		var groupCode = "";

		ds_spgl.ClearAll();
		if ( special == "D") groupCode = "2009";
		if ( special == "K") groupCode = "2010";

		if ( special != "S") { 
			var v_url = new cfURI();
			v_url.Add("groupCd",groupCode);
			v_url.SetPage("cm.cm.retrieveCommCodeCombo.gau");		
			ds_spgl.DataId = v_url.GetURI(); 
			ds_spgl.Reset();

			cfDsUnionBlank(ds_spgl, "code", "name","");

		}
		
	}
	
	if (ds_costTotDtl.NameValue(row,"sp") == "K" ||
	    ds_costTotDtl.NameValue(row,"sp") == "D" || 
        (ds_costTotDtl.NameValue(row,"sp") == "S" && ds_costTotDtl.NameValue(row,"checkDuedate") == "Y")){
		gr_costTotDtl.ColumnProp("dueDate", "Edit") = "RealNumeric";
	} else {
		gr_costTotDtl.ColumnProp("dueDate", "Edit") = "none";
	}	
	
</script>

<script language="javascript"  for=gr_costTotDtl event=OnPopup(Row,Colid,data)>
    if ( Colid == "sapAcctCd") {
		openSapAccountCodeListGridWin(Row, ds_costTotDtl)
    }

    if ( Colid == "sapAcctCNm") {
    	openVendorSapListGridWin(Row, ds_costTotDtl, "sapAcctC", "sapAcctCNm");
    }
    
    if ( Colid == "sapAcctVNm") {
    	openVendorSapListGridWin(Row, ds_costTotDtl, "sapAcctV", "sapAcctVNm");
    }    
    
 	// I/O 코드 조회 팝업 호출
	if ( Colid == "intOrderNm") {
		
		openInternalOrderCodeListGridWin(Row, ds_costTotDtl, "intOrder", "intOrderNm");
	}
    
//    ds_costTotDtl.Namevalue(Row,"costCenter")    = "11100";

 	if ( Colid == "dueDate") {
	 	h_date.value ="";
		gf_calendarExClean(h_date); 
		ds_costTotDtl.NameValue(Row,"dueDate") =funcReplaceStrAll(h_date.value,"/","");	
	}
	
	var pcaCnt = 0; // 기간비용계정 수
	
	// 선택한 계정코드가 기간비용 계정 인지 유무 체크
	for( var k=1; k <= ds_checkPeriodCostAccount.CountRow; k++ ) {
		if(ds_checkPeriodCostAccount.NameValue(k , "code") == ds_costTotDtl.NameValue(Row,"sapAcctCd")){
			pcaCnt++;
		}
	}
	
	// 기간비용시작일자, 기간비용종료일자 날짜팝업 활성화
	if(pcaCnt > 0){
		gr_costTotDtl.ColumnProp("periodCostFrom", "Edit") = "RealNumeric";
		gr_costTotDtl.ColumnProp("periodCostTo", "Edit") = "RealNumeric";
	
	// 기간비용시작일자, 기간비용종료일자 날짜팝업 비활성화
	}else{
		ds_costTotDtl.NameValue(Row,"periodCostFrom") = "";
		gr_costTotDtl.ColumnProp("periodCostFrom", "Edit") = "none";
		ds_costTotDtl.NameValue(Row,"periodCostTo") = "";
		gr_costTotDtl.ColumnProp("periodCostTo", "Edit") = "none";
	}
	
	// 기간비용시작일자 날짜 팝업 셋팅
	if ( Colid == "periodCostFrom") {
	 	h_date.value ="";
		gf_calendarExClean(h_date); 
		ds_costTotDtl.NameValue(Row,"periodCostFrom") =funcReplaceStrAll(h_date.value,"/","");		 	
	}
	
	// 기간비용종료일자 날짜 팝업 셋팅
	if ( Colid == "periodCostTo") {
	 	h_date.value ="";
		gf_calendarExClean(h_date); 
		ds_costTotDtl.NameValue(Row,"periodCostTo") =funcReplaceStrAll(h_date.value,"/","");		 	
	}
 	
</script>

<script language=JavaScript for=deptCd event=OnSelChange2()>
     for ( var i = 1; i <= ds_costTotDtl.CountRow; i++) {
		ds_costTotDtl.Namevalue(i,"deptCd") = deptCd.ValueOfIndex("code",deptCd.Index);
     }
</script>

<script language=JavaScript for=gr_costTotDtl event=OnCloseUp(row,colid)>

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
							<col width="14%"/>
							<col width="40%"/>
							<col width="18%"/>
							<col width=""/>							
						</colgroup>
						<tr>																	
							<th><%= columnData.getString("create_date") %></th>
							<td>
								<input type="text" id="orderDateFrom" value="<%= prevDate %>" 	 onblur="valiDate(this);" style="width:60px;"/>&nbsp;<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(orderDateFrom);" style="cursor:hand"/> ~ 
								<input type="text" id="orderDateTo"   value="<%= currentDate %>" onblur="valiDate(this);" style="width:60px;"/>&nbsp;<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(orderDateTo);" style="cursor:hand"/>
							</td>
							<th><%= columnData.getString("vali_success") %></th>
							<td>
								<object id="valiSuccessYn"  classid="<%=LGauceId.LUXECOMBO%>" align="absmiddle" width="70">
									<param name=CBData				value="^--Total--,Y^Pass,N^Fail">
									<param name=CBDataColumns		value="code,name">
									<param name=SearchColumn		value="name">
									<param name=ListExprFormat		value="name^0^40,name^0^30">
								    <param name=index           	value=0>
							   	</object>
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

	<div class="sub_stitle"> <p><%= columnData.getString("sub1_title") %></p> </div>     	

	<!-- 그리드 S -->	
    <div>
	<object id="gr_costTotMst" classid="<%=LGauceId.GRID %>" style="width:100%;height:160px;" class="comn"
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
				<C> id=chk	          name="<%= columnData.getString("chk") %>" 		                     width="40"	  Edit="true"  {IF(returnMsg="","White","Red")}  EditStyle=CheckBox	HeadAlign=center HeadCheck=false HeadCheckShow=true  </c>
                <C> id=valiSuccessYn  name="<%= columnData.getString("vali_success_yn") %>"  align="center"  width="70"   Edit="none"   show="false"  </C>
                <C> id=valiSuccessNm  name="<%= columnData.getString("vali_success_yn") %>"  align="center"  width="70"   Edit="none"   show="true"   </C>                
                <C> id=docSeq      	  name="<%= columnData.getString("doc_seq") %>"     	 align="center"  width="90"   Edit="none"   show="true"   </C>                
                <C> id=companyCd   	  name="<%= columnData.getString("company_cd") %>"     	 align="center"  width="70"   Edit="none"   show="false"  </C>
                <C> id=deptCd      	  name="<%= columnData.getString("company_cd") %>"     	 align="center"  width="90"   Edit="none"   show="false"   </C>
                <C> id=deptNm      	  name="<%= columnData.getString("dept_nm") %>"     	 align="left"    width="70"   Edit="none"   show="false"  </C>
                <C> id=docYm       	  name="<%= columnData.getString("doc_ym") %>"     		 align="center"  width="70"   Edit="none"   show="true"  sumtext="Total"    </C>                
                <C> id=amount      	  name="<%= columnData.getString("amount") %>"     		 align="right"   width="120"  Edit="none"   show="true"  sumtext="@sum", sumbgcolor="#ECE6DE" sumcolor="#666666" DisplayFormat ="#,###.00"  </C>
                <C> id=docType     	  name="<%= columnData.getString("doc_type") %>"     	 align="center"  width="70"   Edit="none"   show="false"  </C>
                <C> id=currencyCd  	  name="<%= columnData.getString("currency_cd") %>"      align="center"  width="60"   Edit="none"   show="true"   </C>
                <C> id=createDate  	  name="<%= columnData.getString("create_date") %>"      align="center"  width="80"   Edit="none"   show="true"  Mask="XXXX/XX/XX"  </C>
                <C> id=docDate     	  name="<%= columnData.getString("doc_date") %>"     	 align="center"  width="80"   Edit="none"   show="true"   </C>
                <C> id=postDate    	  name="<%= columnData.getString("post_date") %>"     	 align="center"  width="80"   Edit="none"   show="true"   </C>
                <C> id=docDiv 	      name="<%= columnData.getString("doc_div") %>"          align="left"    width="100"  Edit="none"   show="false"  </C>
                <C> id=docDivNm       name="<%= columnData.getString("doc_div") %>"          align="left"    width="100"  Edit="none"   show="false"  </C>
                <C> id=errorMsg 	  name="<%= columnData.getString("error_msg") %>"        align="left"    width="230"  Edit="none"   show="true"   </C>
	      '>
	</object>
 	</div>


    <!-- 그리드 E -->	
	<div class="sub_stitle"> <p> <%= columnData.getString("sub2_title") %> </p> </div> 
	<!-- 그리드 S -->	
    <div id="output_board_area">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board" >
		<colgroup>
	        <col width="20%"/>
	        <col width="30%"/>
	        <col width="20%"/>
	        <col width="30%"/>
		</colgroup>    
	    <tr>
			<object id="deptCd"  classid="<%=LGauceId.LUXECOMBO%>" align="absmiddle" width="120" style="display:none">
				<param name="ComboDataID"       value="ds_deptCode">
				<param name="ListCount"     	value="10">
				<param name="BindColumn"    	value="code">
			    <param name=SyncComboData       value="true">
				<param name=ListExprFormat		value="name^0^100,code^0^50">
				<param name=index           	value=0>
			</object>
		  <th><%= columnData.getString("doc_seq") %></th>
		  <td><input type="text" id="docSeq" 	style="width:50px;" maxlength="10" readonly class="txtField_read"></td>
		  <th><%= columnData.getString("currency_cd") %></th>
          <td>
			<object id="currencyCd"  classid="<%=LGauceId.LUXECOMBO%>" align="absmiddle" width="100">
				<param name="ComboDataID"       value="ds_currencyCd">
				<param name="ListCount"     	value="10">
				<param name="BindColumn"    	value="code">
			    <param name=WantSelChgEvent	    value=true>
				<param name=ListExprFormat		value="name^0^70,code^0^50">
				<param name=index           	value=-1>
			</object>
		  </td>	
		  
		</tr>
	    <tr>
		  <th><%= columnData.getString("doc_date") %></th>
		  <td><input type="text" id="docDate" 	style="width:70px;" maxlength="10" >
		      <img id=docDateIcon src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(docDate, postDate);" style="cursor:hand"/></td>									
		  <th><%= columnData.getString("post_date") %></th>
		  <td><input type="text" id="postDate" 	style="width:70px;" maxlength="10" >
		      <img id=postDateIcon src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(postDate);" style="cursor:hand"/>
		  </td>
		  
<%-- Type Class 사용하지 않아 주석 처리함.		  
		  <th><%= columnData.getString("doc_div") %></th>
          <td>
			<object id="docDiv"  classid="<%=LGauceId.LUXECOMBO%>" align="absmiddle" width="100">
				<param name="ComboDataID"       value="ds_docDiv">
				<param name="ListCount"     	value="10">
				<param name="BindColumn"    	value="code">
				<param name=ListExprFormat		value="name^0^100,code^0^50">
				<param name=index           	value=0>
				<param name=WantSelChgEvent	    value=true>
			</object>
		  </td>
--%>		  
		</tr>
	  </table>
	</div>

	<object id=bd_costTot classid="<%=LGauceId.BIND%>">
		<param name=DataID value=ds_costTotMst>
		<param name=BindInfo 
			value='
                <C> Col=companyCd       Ctrl=companyCd      Param=value  </C>
                <C> Col=deptCd          Ctrl=deptCd         Param=BindColVal  </C>
                <C> Col=docYm           Ctrl=docYm          Param=value  </C>
                <C> Col=docSeq          Ctrl=docSeq         Param=value  </C>
                <C> Col=docDate         Ctrl=docDate        Param=value  </C>
                <C> Col=postDate        Ctrl=postDate       Param=value  </C>
                <C> Col=currencyCd      Ctrl=currencyCd     Param=BindColVal  </C>
                <C> Col=docDiv      	Ctrl=docDiv     	Param=BindColVal </C>
	  		'>
	</object>

    <div class="sub_stitle"> <p><%= columnData.getString("sub3_title") %></p>
    	<p class="rightbtn"> 
          <span class="sbtn_r sbtn_l">
          <input type="button" id=Save    onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="<%= btnAddRow %>" onclick="f_Add();"/></span> 
          <span class="sbtn_r sbtn_l"> 
          <input type="button" id=Del     onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="<%= btnDelRow %>" onclick="f_Del();"/></span>
        </p>
	</div>

	<!-- 그리드 S -->	
    <div>
	<object id="gr_costTotDtl" classid="<%=LGauceId.GRID %>" style="width:100%;height:160px;" class="comn">
		<param Name="DataID" 			value="ds_costTotDtl">
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
			value='
           		<C> id=seq            name="seq"         align="center"   width="40"    Edit="none"   	     Value={CurRow} </C>
                <C> id=companyCd      name="<%= columnData.getString("company_cd") %>"        align="center"   width="70"    Edit="none"  	     show="false" </C>
                <C> id=deptCd         name="<%= columnData.getString("dept_cd") %>"     	  align="center"   width="70"    Edit="none"   	     show="false" </C>
                <C> id=docYm          name="<%= columnData.getString("doc_ym") %>"     	      align="center"   width="70"    Edit="none"   	     show="false" </C>
                <C> id=docSeq         name="<%= columnData.getString("doc_seq") %>"     	  align="center"   width="80"    Edit="none"   	     show="false" sort="true"</C>
                <C> id=docNum         name="<%= columnData.getString("doc_num") %>"     	  align="center"   width="80"    Edit="none"   	     show="false" sort="true"</C>
                <C> id=sapAcctCd      name="<%= columnData.getString("acct_cd") %>"     	  align="center"   width="57"    Edit="AlphaNum"     show="true" EditStyle=PopupFix</C>
                <C> id=sapAcctNm      name="<%= columnData.getString("acct_nm") %>"           align="left"     width="215"   Edit="none"   	     show="true" sumtext="Total" </C>
                <C> id=debitAmt       name="<%= columnData.getString("debit_amt") %>"         align="right"    width="110"   EDIT="RealNumeric"  Edit={IF(creditAmt = 0, "true","false")}   show="true" sumtext="@sum", sumbgcolor="#ECE6DE" sumcolor="#666666" </C>
                <C> id=creditAmt      name="<%= columnData.getString("credit_amt") %>"        align="right"    width="110"   EDIT="RealNumeric"  Edit={IF(debitAmt  = 0, "true","false")}   show="true" sumtext="@sum", sumbgcolor="#ECE6DE" sumcolor="#666666"</C>
                <C> id=vat            name="Tax Code"     	      align="left"     width="110"   Edit="AlphaNum"     show="true" Data="ds_vat:code:name" Editstyle="Lookup"</C>
                <C> id=base           name="<%= columnData.getString("base") %>"     	      align="right"    width="80"    Edit="RealNumeric"  show="false"  </C>
                <C> id=sapAcctV       name="<%= columnData.getString("sap_acct_v") %>"        align="center"   width="100"                       show="false" </C>
                <C> id=sapAcctVNm     name="<%= columnData.getString("sap_acct_v") %>"        align="center"   width="130"   Edit="AlphaNum"     show="true"  EditStyle=PopupFix  </C>
                <C> id=sapAcctC       name="<%= columnData.getString("sap_acct_c") %>"        align="center"   width="100"                       show="false" </C>
                <C> id=sapAcctCNm     name="<%= columnData.getString("sap_acct_c") %>"        align="center"   width="130"   Edit="AlphaNum"     show="true"  EditStyle=PopupFix  </C>
                <C> id=costCenter     name="<%= columnData.getString("cost_center") %>"       align="left"     width="180"   Edit="AlphaNum"     show="true"  Data="ds_costCenter:code:name"  EditStyle="LookUp"</C>                
                <C> id=intOrder       name="<%= columnData.getString("order") %>"             align="left"     width="100"                       show="false" </C>                
                <C> id=intOrderNm     name="<%= columnData.getString("order") %>"     	      align="center"   width="160"    Edit="AlphaNum"     show="true"  EditStyle=PopupFix  </C>
                <C> id=docDesc        name="<%= columnData.getString("doc_desc") %>"          align="left"     width="200"   Edit="true"         show="true"  </C>
                <C> id=dueDate        name="<%= columnData.getString("due_date") %>"     	  align="center"   width="100"   Edit="AlphaNum"     show="true"  Mask="XXXX/XX/XX"    Editstyle="Popup"</C>
                <C> id=errorMsg       name="<%= columnData.getString("error_msg") %>"         align="left"     width="230"   Edit="none"         show="true"  BgColor={IF(returnMsg="","White","Red")} </C>                                                                
                <C> id=code           name="<%= columnData.getString("code") %>"              align="center"   width="70"    Edit="AlphaEtc"     show="false" </C>
                <C> id=rate           name="<%= columnData.getString("rate") %>"              align="right"    width="70"    Edit="RealNumeric"  show="false" </C>
                <C> id=spglNo         name="<%= columnData.getString("spgl_no") %>"     	  align="center"   width="80"    Edit="AlphaNum"     show="true"  Data="ds_spgl:code:name"  Editstyle="Lookup" ListWidth=210  ShowEditStyle=True</C>                                                
                <C> id=sp             name="<%= columnData.getString("sp") %>"                align="center"   width="70"    Edit="none"   	     show="false" </C>
                <C> id=chkyn          name="<%= columnData.getString("chk_yn") %>"            align="center"   width="70"    Edit="none"   	     show="false" </C>
                <C> id=checkDuedate   name="<%= columnData.getString("check_duedate") %>"     align="center"   width="110"   Edit="none"   	     show="false" </C>
                <C> id=acctSapCd      name="<%= columnData.getString("sap_acct_cd") %>"       align="center"   width="70"    Edit="none"   	     show="false" </C>
                <C> id=periodCostFrom name="Period From"  align="center"   width="100"   Edit="RealNumeric"  show="true"   Mask="XXXX/XX/XX" editstyle="Popup"  </C>
                <C> id=periodCostTo   name="Period To"    align="center"   width="100"   Edit="RealNumeric"  show="true"   Mask="XXXX/XX/XX" editstyle="Popup"  </C>
	      '>
	</object>
 	</div>
      
	<!-- 버튼 S -->	
    <div id="btn_area">
    	<p class="b_right">
    		<span class="btn_r btn_l"><input type="button" onClick="f_Save();" 			onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#444'" value="<%= btnSave %>"/></span>
    		<span class="btn_r btn_l"><input type="button" onClick="f_Delete();" 		onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#444'" value="<%= btnDel %>"/></span>
    		<span class="btn_r btn_l"><input type="button" onClick="f_Validation();" 	onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#444'" value="<%= btnValidation %>"/></span>
    		<span class="btn_r btn_l"><input type="button" onClick="f_Transfer();" 		onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#444'" value="<%= btnConfirm %>"/></span>    					
    	</p>
   	</div>
    <!-- 버튼 E -->
        
    
    <div class="pad_t5"></div>

<!--  script src="/debug_utf8.js"></script-->

        	  
</div>
<input type="hidden" id="h_date"/>
</body>
</html>
