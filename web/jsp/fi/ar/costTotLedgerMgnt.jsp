<%--
/*
 *********************************************************************************************
 * @source  : costTotLedgerMgnt.jsp
 * @desc    : cost Total Ledger Excel Upload
 *--------------------------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -------------------------------------------------------------
 * 1.0  2010/09/13   mskim       Init
 * 1.1  2015/11/27   hckim       Cost Price Detail 그리드 I/O 필드 팝업기능 추가 및 저장 수정시
 *                               유효성 체크 기능 추가
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
<title>Cost Total Ledger Mgnt</title>
<%@ include file="/include/head.jsp" %>

<%
	String prevDate	   = LDateUtils.getDate("yyyy/MM/") +"01"; 
	String currentDate = LDateUtils.getDate("yyyy/MM/dd");                        // currentDate

    String msgWarnRetrieve    = source.getMessage("dev.warn.com.retrieve");   	  // please first retrieve!
	String msgSave            = source.getMessage("dev.cfm.com.save");    		  // Are you sure to save?
	String msgDelete          = source.getMessage("dev.cfm.com.delete");          // Are you sure to Delete?
    String msgCompDebitCredit = source.getMessage("dev.msg.fi.diffDebitCredit");  // The debit and credit total are not right
    String msgSucProcess      = source.getMessage("dev.suc.com.process");    	  // successfully processed.
    String msgNoDataItem      = source.getMessage("dev.warn.com.noDataItem");     // The selected item does not exist.
    String msgMustReqMode     = source.getMessage("dev.msg.fi.condCheck");    	  // The selected condition must be Request Status.
	String msgNoNegativeNum	  = source.getMessage("dev.msg.fi.noNegativeNum");    // The negative number will not be able to input!
	String msgInfoChange      = source.getMessage("dev.inf.com.nochange");        // no data for change.
	String msgNoDelete        = source.getMessage("dev.inf.com.nodelete");        // no data for deleting.
	String msgChkCurrency     = source.getMessage("dev.warn.com.checkCurrency");  // The Currency IDR needs Integer Amount.
	String msgCheckEntryDate  = source.getMessage("dev.warn.com.checkEntryDate"); // Check searching condition.(Entry Date)
	String msgCheckDocDate    = source.getMessage("dev.warn.com.checkDocDate");   // Check searching condition.(Doc Date)		
%>

<script type="text/javascript">
parent.centerFrame.cols='220,*';	
	//저장 시 Rowposion
	var g_Pos =0;
	
	// 주의: 하단 그리드의 컬럼이 추가되는 경우, [strHeaderDtl], [gr_grid]를 동일하게 구성해야 합니다.
   var strHeaderDtl = "companyCd"     	 + ":STRING(4)"
                   + ",deptCd"       	 + ":STRING(4)"
                   + ",deptNm"       	 + ":STRING(100)"
                   + ",docYm"        	 + ":STRING(6)"
                   + ",docSeq"       	 + ":STRING(10)"
                   + ",amount"       	 + ":DECIMAL(13.2)"
                   + ",createType"   	 + ":STRING(1)"
                   + ",createTypeNm" 	 + ":STRING(100)"
                   + ",docType"      	 + ":STRING(1)"
                   + ",progStatus"   	 + ":STRING(2)"
                   + ",progStatusNm" 	 + ":STRING(100)"
                   + ",sapDocSeq"    	 + ":STRING(10)"
                   + ",sapCancelDocSeq"  + ":STRING(50)"
                   + ",currencyCd"  	 + ":STRING(3)"
                   + ",createDate"   	 + ":STRING(10)"
                   + ",docDate"      	 + ":STRING(10)"
                   + ",postDate"     	 + ":STRING(10)"
                   + ",successType"  	 + ":STRING(1)"
                   + ",workType"     	 + ":STRING(50)"
                   + ",postYm"       	 + ":STRING(50)"
                   + ",status"       	 + ":STRING(10)"
                   + ",attr2" 			 + ":STRING(50)"
                   + ",attr3" 			 + ":STRING(50)";

   var strBodyDtl = "companyCd"    	  + ":STRING(4)"
                 + ",deptCd"      	  + ":STRING(4)"
                 + ",docYm"       	  + ":STRING(6)"
                 + ",docSeq"      	  + ":STRING(10)"
                 + ",docNum"      	  + ":STRING(3)"
                 + ",sapAcctCd"   	  + ":STRING(10)"
                 + ",sapAcctNm"   	  + ":STRING(50)"
                 + ",debitAmt"    	  + ":DECIMAL(15.2)"
                 + ",creditAmt"   	  + ":DECIMAL(15.2)"
                 + ",vat"         	  + ":STRING(50)"
                 + ",base"        	  + ":DECIMAL(13.2)"
                 + ",type"        	  + ":STRING(50)"
                 + ",code"        	  + ":STRING(50)"
                 + ",rate"        	  + ":DECIMAL(3.1)"
                 + ",center"      	  + ":STRING(50)"                  
                 + ",priCenter"   	  + ":STRING(50)"
                 + ",intOrder"    	  + ":STRING(50)"
                 + ",intOrderNm"      + ":STRING(50)"
                 + ",docDesc"     	  + ":STRING(50)"
                 + ",spglNo"      	  + ":STRING(1)"
                 + ",sapAcctV"    	  + ":STRING(10)"
                 + ",sapAcctVNm"      + ":STRING(50)"
                 + ",sapAcctC"    	  + ":STRING(10)"
                 + ",sapAcctCNm"      + ":STRING(50)"
                 + ",returnMsg"   	  + ":STRING(100)"
                 + ",sp"          	  + ":STRING(1)"
                 + ",chkyn"       	  + ":STRING(10)"
                 + ",workCd" 		  + ":STRING(3)"
                 + ",workVendor" 	  + ":STRING(10)"
                 + ",workYm" 		  + ":STRING(6)"
                 + ",vatBaseAmount"   + ":DECIMAL(13.2)"
                 + ",dueDate" 		  + ":STRING(50)"
                 + ",workRentalType"  + ":STRING(100)"
                 + ",wasteCd"         + ":STRING(50)"                  
                 + ",attr12"		  + ":STRING(50)"
                 + ",attr13"		  + ":STRING(50)"
                 + ",attr14"		  + ":DECIMAL(13.3)"
                 + ",attr15"		  + ":STRING(50)"
                 + ",attr16"		  + ":DECIMAL(13.3)"
                 + ",loadGbn"		  + ":STRING(1)"    //처리구분 'N':add row추가작업시, 'P':popup으로 데이터 세팅시, 'U':기존 데이터 수정시
                 + ",periodCostFrom"  + ":STRING(50)"
                 + ",periodCostTo" 	  + ":STRING(50)";  

	var strHeaderBarge = "syskey"	      +":STRING(10)"
					   +",mvCd"	          +":STRING(10)"
					   +",bargeSeq"	      +":STRING(10)"
					   +",bargeCd"	      +":STRING(10)"
					   +",postDate"	      +":STRING(10)"
					   +",mvArrivalDate"  +":STRING(10)"
					   +",loadingQty"	  +":STRING(10)"
					   +",loadingDate"	  +":STRING(20)"
					   +",portStock"	  +":STRING(150)"
					   +",lngCd"	      +":STRING(4000)";
					
					
//-------------------------------------------------------------------------
// Cost Total Ledger Delete
//-------------------------------------------------------------------------	
function f_Delete(){
	var cont = 0;
	
	if (checkDelData()) {
		
		if (confirm('<%= msgDelete %>')) {
			mode = "process";
			
			ds_costTotDtl.UndoAll();
			
			var workType = "";
			var vendCd = "";
			var postYm = "";
			var workRentalType = "";
			var wasteCd = "";
			
			for(var i=1; i <= ds_costTotDtl.countRow; i++){
				//2010.09.30 공정계정체크
				for( var j=1,cnt=0; j <= ds_checkCostPriceAccount.CountRow; j++ ) {
					if( ds_costTotDtl.NameValue(i,"sapAcctCd") == ds_checkCostPriceAccount.NameValue( j , "acctCd" ) ) {
						cont++;
						workType 				= ds_costTotDtl.NameValue(i,"workCd");
						vendCd					= ds_costTotDtl.NameValue(i,"workVendor");
						postYm					= ds_costTotDtl.NameValue(i,"workYm");
						workRentalType 	= ds_costTotDtl.NameValue(i,"workRentalType");
						wasteCd					= ds_costTotDtl.NameValue(i,"wasteCd");
					}
				}
			}
			
			
		  	var param = "companyCd=" + ds_costTotMst.Namevalue(ds_costTotMst.RowPosition,"companyCd")
					   +",deptCd=" + ds_costTotMst.Namevalue(ds_costTotMst.RowPosition,"deptCd")
					   +",docYm=" + ds_costTotMst.Namevalue(ds_costTotMst.RowPosition,"docYm")
					   +",docSeq=" + ds_costTotMst.Namevalue(ds_costTotMst.RowPosition,"docSeq")
					   +",workType=" + workType
					   +",vendCd=" + vendCd
					   +",postYm=" + postYm
					   +",currencyCd=" + ds_costTotMst.Namevalue(ds_costTotMst.RowPosition,"currencyCd")
					   +",workRentalType="+workRentalType
					   +",wasteCd="+wasteCd;
				
			//alert(param);	   
			tr_cudData.Parameters = param;
			tr_cudData.KeyValue	= "JSP(I:IN_DS1=ds_costTotMst)";
			tr_cudData.Action   = "fi.ar.deleteCostTotLedgerMgnt.gau";
	 		tr_cudData.Post();//Cost Total Ledger Approval

	 	} 	
 	}
}

//-------------------------------------------------------------------------
// Master 삭제시 체크
//-------------------------------------------------------------------------
function checkDelData() {

	if(ds_costTotMst.CountRow == 0){
		alert('<%=source.getMessage("dev.warn.com.nonData","Cost Price Masster")%>');
		return false;
	}

	var RowStatus = ds_costTotMst.RowStatus(ds_costTotMst.RowPosition);
	if ( RowStatus == 1 ) {
    	ds_costTotMst.DeleteRow(ds_costTotMst.RowPosition);      // 신규 추가건만 삭제 가능
    	//ds_purchReqDtl.ClearAll();
    	return false;
    }
    
	var status = ds_costTotMst.NameValue(ds_costTotMst.RowPosition ,"progStatus");
	var attr2 = ds_costTotMst.NameValue(ds_costTotMst.RowPosition ,"attr2"); //임시전표 여부 체크
	if(status != "10"){
		alert('<%= msgMustReqMode %>');
		return false;
	}

	return true;
}

//-------------------------------------------------------------------------
// 저장
//-------------------------------------------------------------------------
function f_Save() {
	
	if(ds_costTotDtl.CountRow == 0) {
        alert("<%= msgWarnRetrieve %>");      // please first retrieve!
        return;
    }
	
	//2014 이전 데이터 입력 불가 처리(결산기간)  
	var docDt = ds_costTotMst.Namevalue(ds_costTotMst.RowPosition,"docDate");
	var postDt = ds_costTotMst.Namevalue(ds_costTotMst.RowPosition,"postDate");
	if(f_forbidBeforeDate('2014/01/01',postDt,'PostDate') == false){
		return;
	}

	// Save Data Check
	if (checkSaveData()) {

	    if(confirm("<%= msgSave %>")){     // Are you sure to save?
	    	
			if( ds_costTotMst.IsUpdated == false && ds_costTotDtl.IsUpdated == false && ds_bargeInf.IsUpdated == false  ) {
				alert("<%=msgInfoChange%>" );
				return;
		   	}else{
		   		ds_costTotMst.Namevalue(ds_costTotMst.RowPosition,"chkUpdate") = "T";
		   	}
	    	
			mode = "process";

			ds_costTotDtl.UseChangeInfo = "false";

		  	var param = "companyCd=" 	+ ds_costTotMst.Namevalue(ds_costTotMst.RowPosition,"companyCd")
		  				+",deptCd=" 	+ ds_costTotMst.Namevalue(ds_costTotMst.RowPosition,"deptCd")
		  				+",docDate=" 	+ removeDash(ds_costTotMst.Namevalue(ds_costTotMst.RowPosition,"docDate"),"/")
		  				+",createDate=" + removeDash(ds_costTotMst.Namevalue(ds_costTotMst.RowPosition,"createDate"),"/")
		  				+",currencyCd=" + ds_costTotMst.Namevalue(ds_costTotMst.RowPosition,"currencyCd")
		  	;

			g_Pos = ds_costTotMst.RowPosition;	 

			//tr_cudData.Parameters = param;
			tr_cudData.KeyValue	  = "JSP(I:IN_DS1=ds_costTotMst, I:IN_DS2=ds_costTotDtl, I:IN_DS3=ds_bargeInf)";
			tr_cudData.Action     = "fi.ar.cudCostTotLedgerMgnt.gau";
			tr_cudData.Post();
		}
	
	}

}

//-------------------------------------------------------------------------
// Master 승인 / 취소 시 필수 체크 사항
//-------------------------------------------------------------------------
function checkSaveData() {
	
	// 통화코드
	var currencyCd = ds_costTotMst.Namevalue(ds_costTotMst.RowPosition,"currencyCd");	
	
	if(ds_costTotDtl.CountRow == 0){
		alert('<%= msgNoDataItem %>');
			return false;
	}

	var status = ds_costTotMst.NameValue(ds_costTotMst.RowPosition ,"progStatus");
	var attr2 = ds_costTotMst.NameValue(ds_costTotMst.RowPosition ,"attr2");
	
	if(!(status == "10" || status == "40")){
		alert('<%= msgMustReqMode %>');
		return false;
	}

	//docDate postDate
	var docDate = removeDash(ds_costTotMst.NameValue(ds_costTotMst.RowPosition ,"docDate"),"/");
	var postDate = removeDash(ds_costTotMst.NameValue(ds_costTotMst.RowPosition ,"postDate"),"/");
	//substring
	if(docDate.length >= 8){
		docDate = docDate.substring(0,6);
	}
	if(postDate.length >= 8){
		postDate = postDate.substring(0,6);
	}
	
	//2010.11.01 Doc date 동일 년월에 관해 날짜만 수정 가능하게
	var docDateYm = ds_costTotMst.NameValue(ds_costTotMst.RowPosition ,"docDateYm");
	if(docDateYm != null && docDateYm != ""){
		if(docDateYm != docDate){
			alert('<%=source.getMessage("dev.fi.ar.costprice.chk.docdate")%>');
			return false;
		}
	}
		
	//임시전표인경우
	if(attr2 == "B"){
				
		//Doc Date(YYYYMM) != Post Date(YYYYMM) 경우 B일 수 없음	
		if(docDate != postDate){
			alert('<%=source.getMessage("dev.fi.ar.costprice.input.chk6", columnData.getString("doc_date"), columnData.getString("post_date"), columnData.getString("attr2"))%>');
			return false;
		}
		//Post Date(MM)이 12월일 경우 B일 수 없음
		if(postDate.substring(4,5) == "12"){
			alert('<%=source.getMessage("dev.fi.ar.costprice.input.chk5", columnData.getString("post_date"), columnData.getString("attr2"))%>');
			return false;
		}
	}
	
	var cont = 0;
	
	for(var i=1; i <= ds_costTotDtl.countRow; i++){
		
		var debitAmt      = ds_costTotDtl.NameValue(i,"debitAmt");
		var creditAmt     = ds_costTotDtl.NameValue(i,"creditAmt");
		var baseAmt       = ds_costTotDtl.NameValue(i,"base");												
		var sDotDebitAmt  = "0"; // debitAmt 소수점이하 초기값
		var sDotCreditAmt = "0"; // creditAmt 소수점이하 초기값
		var sDotBaseAmt   = "0"; // baseAmt 소수점이하 초기값
		
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
	    		
		//2010.09.30 공정계정체크
		for( var j=1,cnt=0; j <= ds_checkCostPriceAccount.CountRow; j++ ) {
			if( ds_costTotDtl.NameValue(i,"sapAcctCd") == ds_checkCostPriceAccount.NameValue( j , "acctCd" ) ) {
				cont++;
			}
		}
					
		//임시전표 인 경우에
		// 원천세 계정이 올 수 없다
		// 부가세 계정 코드를 선택할 수 없다.
		if(attr2 == "B"){
			
			for( var j=1,cnt=0; j <= ds_checkAccount.CountRow; j++ ) {
				if( ds_costTotDtl.NameValue(i,"sapAcctCd") == ds_checkAccount.NameValue( j , "acctCd" ) ) {
					alert('<%=source.getMessage("dev.fi.ar.costprice.input.chk", columnData.getString("attr2"))%>');
					ds_costTotDtl.RowPosition = i;
					gr_costTotDtl.SetColumn("sapAcctCd");
					return false;
				}
			}
		}
		
		//essential Field Check
		if(ds_costTotDtl.NameValue(i,"sapAcctCd") == ""){
			alert('<%=source.getMessage("dev.warn.com.input", columnData.getString("acct_cd"))%>');
			ds_costTotDtl.RowPosition = i;
			gr_costTotDtl.SetColumn("sapAcctCd");
			return false;
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
		
		//임시전표인 경우
		if(attr2 == "B"){
			if(ds_costTotDtl.NameValue(i,"vat") != ""){
				alert('<%=source.getMessage("dev.fi.ar.costprice.input.chk4", columnData.getString("attr2"), columnData.getString("vat"))%>');
				ds_costTotDtl.RowPosition = i;
				gr_costTotDtl.SetColumn("vat");
				return false;
			} 
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
			}
			
			//원천세 계정인 경우 입력 불가 2 Commcd 에 등록 되어 있는 것들로 검사
			for(var j=1; j <= ds_checkAccount.countRow; j++){
				var acctCd = ds_checkAccount.NameValue(j,"acctCd");
				
				//계정코드가원천세 계정코드인 경우
				if (sapAcctCd == acctCd){		
					
					//계정이 원천세 계정인 경우
					 if(ds_costTotDtl.NameValue(i,"vat")!= ""){
							alert("Account "+ds_costTotDtl.NameValue(i,"sapAcctCd")+ " is not required Tax");
							gr_costTotDtl.SetColumn("vat");
							return false;
					}																
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
			for( var j=1; j <= ds_checkAttrAccountAll.CountRow; j++ ) {
				if( sapAcctCd == ds_checkAttrAccountAll.NameValue( j , "acctSapCd" ) ) {
					if(ds_checkAttrAccountAll.NameValue( j , "chkDueDate" )=="Y"&&ds_costTotDtl.NameValue(i,"dueDate") == "") {
						alert('<%=source.getMessage("dev.warn.com.input", columnData.getString("attr11"))%>');
						ds_costTotDtl.RowPosition = i;
						gr_costTotDtl.SetColumn("dueDate");
						return false;
					}
				}
			}
			
		}else if(ds_costTotDtl.NameValue(i,"sp") == "D" || ds_costTotDtl.NameValue(i,"sp") == "K"){
			
			if(ds_costTotDtl.NameValue(i,"spglNo") != "") {
				if(ds_costTotDtl.NameValue(i,"dueDate") == "") {
					alert('<%=source.getMessage("dev.warn.com.input", columnData.getString("attr11"))%>');
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
			if(ds_costTotDtl.NameValue(i,"center") == "") {
				alert('<%=source.getMessage("dev.warn.com.input", columnData.getString("center").replaceAll(";", " "))%>');
				ds_costTotDtl.RowPosition = i;
				gr_costTotDtl.SetColumn("center");
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
			if(ds_costTotDtl.NameValue(i,"center") != "") {
				alert('<%=source.getMessage("dev.warn.com.notRequired", columnData.getString("center").replaceAll(";", " "))%>');
				ds_costTotDtl.RowPosition = i;
				gr_costTotDtl.SetColumn("center");
				return false;
			}
			
			// CIP & DEC 값이 없는 경우
			if(ds_costTotDtl.NameValue(i,"intOrderNm") == "") {
				alert('<%=source.getMessage("dev.warn.com.input", columnData.getString("order").replaceAll(";", " "))%>');
				ds_costTotDtl.RowPosition = i;
				gr_costTotDtl.SetColumn("intOrderNm");
				return false;
			}
						
		//9번대 계정 아닌데 IO 코드 있는 경우
		} else if (  accountCodeF != "9" && ds_costTotDtl.NameValue(i,"intOrderNm") != ""){
			alert("CIP / DEC cannot allowed on this account code\n" + accountCode+"");
			ds_costTotDtl.RowPosition = i;
			gr_costTotDtl.SetColumn("intOrderNm");
			return false;
		}										
						
		// Cost Price Detail 그리드 Data 저장/수정 시 - Cost Center, I/O 필드 정보 중 하나의 정보만 저장/수정 가능
		var center = ds_costTotDtl.NameValue(i,"center");
		var intOrder = ds_costTotDtl.NameValue(i,"intOrder");
		
		if ( center == "" && intOrder == "") {
			alert('<%=source.getMessage("dev.warn.com.inputIoCost")%>');			
			ds_costTotDtl.RowPosition = i;
			gr_costTotDtl.SetColumn("center");
			return false;
		}
		
		if ( center != "" && intOrder != "") {
			alert('<%=source.getMessage("dev.warn.com.chooseIoCost")%>');
			ds_costTotDtl.RowPosition = i;
			gr_costTotDtl.SetColumn("center");
			return false;
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
		
		// Sap Account Check
	    var msgStr = "Document Year Month:" + ds_cudDtlData.NameValue(i,"docYm") + " " + ds_cudDtlData.NameValue(i,"docSeq");
		var acctSapCd = ds_costTotDtl.NameValue(i,"acctSapCd");
		if ( acctSapCd == "" ) {
			alert('<%=source.getMessage("dev.warn.com.nonData", columnData.getString("sap_acct_cd"))%>');
			return false;
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
	
	if(attr2 == "B" && cont < 1){
		alert('<%=source.getMessage("dev.fi.ar.costprice.input.chk3", columnData.getString("attr2"))%>)%>');
		return false;
	}

	var debitAmt  = _fix(ds_costTotDtl.NameSum('debitAmt',0,0));
	
	var creditAmt = _fix(ds_costTotDtl.NameSum('creditAmt',0,0));
	
	if ( debitAmt != creditAmt) {
		alert("<%= msgCompDebitCredit %>");
		ds_costTotDtl.RowPosition = 1;
		gr_costTotDtl.SetColumn("debitAmt");		
		return false;
	}
	
	return true;
}


//-------------------------------------------------------------------------
// 검색 필수 체크
//-------------------------------------------------------------------------
function checkData() {
	
	var orderDateFrom = removeDash(document.all.orderDateFrom.value,"/");
	var orderDateTo   = removeDash(document.all.orderDateTo.value,"/");
	var docDateFrom   = removeDash(document.all.docDateFrom.value,"/");
	var docDateTo     = removeDash(document.all.docDateTo.value,"/");

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
   	
    // Entry Date 시작일자, 종료일자가 모두 있는 경우
	if(orderDateFrom != "" && orderDateTo != ""){
		
		// Entry Date 시작일자가 Entry Date 종료일자보다 클 경우
		if(Number(orderDateFrom) > Number(orderDateTo)){
			alert('<%= msgCheckEntryDate %>');
			return false;
		}
	}
    
	// Doc Date 시작일자, 종료일자가 모두 있는 경우
	if(docDateFrom != "" && docDateTo != ""){
		
		// Doc Date 시작일자가 Doc Date 종료일자보다 클 경우
		if(Number(docDateFrom) > Number(docDateTo)){
			alert('<%= msgCheckDocDate %>');
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
	 		condition += "&progStatus=" + progStatus.ValueOfIndex("code",progStatus.Index);
	 		condition += "&orderDateFrom=" + removeDash(document.all.orderDateFrom.value,"/");
	 		condition += "&orderDateTo=" + removeDash(document.all.orderDateTo.value,"/");
	 		condition += "&createType=" + createType.ValueOfIndex("code",createType.Index)
	 		condition += "&docDateFrom=" + removeDash(document.all.docDateFrom.value,"/");
	 		condition += "&docDateTo=" + removeDash(document.all.docDateTo.value,"/");;
	 		
//	 		alert(condition);
	
		ds_costTotMst.DataID = "fi.ar.retrieveCostTotLedgerMstMgnt.gau"+condition;
		ds_costTotMst.Reset();
		
	}
}

//-------------------------------------------------------------------------
// New Master Item
//-------------------------------------------------------------------------
function f_New(){

    if(ds_costTotMst.CountRow == 0) {
        cfHideNoDataMsg(gr_costTotMst);           // 최초 입력인 경우, 해당 건을 만들어주고 진행해야한다.
        ds_costTotMst.ClearAll();
        ds_costTotMst.setDataHeader( strHeaderDtl );
		cfSetSearchGridBtn(strHeaderDtl);
    }
    
     var cnt = 0;
     for ( var i = 1; i <= ds_costTotMst.CountRow; i++) {
	     if ( ds_costTotMst.Rowstatus(i) == 1 ) {
	     	cnt++;
	     }
     }
     
     if ( cnt == 0 ) {
	    ds_costTotMst.AddRow();
		ds_costTotMst.Namevalue(ds_costTotMst.RowPosition,"companyCd")  = '<%= g_companyCd %>';
		ds_costTotMst.Namevalue(ds_costTotMst.RowPosition,"deptCd")     = '<%= g_companyCd %>'
		ds_costTotMst.Namevalue(ds_costTotMst.RowPosition,"docDate")    = '<%= currentDate %>';
		ds_costTotMst.Namevalue(ds_costTotMst.RowPosition,"postDate")   = '<%= currentDate %>';
		ds_costTotMst.Namevalue(ds_costTotMst.RowPosition,"currencyCd") = 'MMK';
		ds_costTotMst.Namevalue(ds_costTotMst.RowPosition,"progStatus") = '10';
		document.all.attr2.index=0;
     	f_Enable();
     }
	 

}

//-------------------------------------------------------------------------
// Master Input Field Init
//-------------------------------------------------------------------------
function f_Enable() {
//	costPop.disabled              = false;
	//bargePop.disabled              = false;
	docDateIcon.disabled          = false;
	postDateIcon.disabled         = false;
	deptCd.Enable                 = true;
	currencyCd.Enable             = true;
	attr2.Enable             = true;
	document.all.docDateIcon.src  = "<%= images %>button/cal_icon.gif";
	document.all.postDateIcon.src = "<%= images %>button/cal_icon.gif";
	document.all.docDate.readOnly = false;
	document.all.postDate.readOnly = false;
}

function f_Enable2() {
//	bargePop.disabled              = false;
	docDateIcon.disabled          = false;
	postDateIcon.disabled         = false;
	document.all.docDateIcon.src  = "<%= images %>button/cal_icon.gif";
	document.all.postDateIcon.src = "<%= images %>button/cal_icon.gif";
	document.all.docDate.readOnly = false;
	document.all.postDate.readOnly = false;
	f_enableCurr();
	
	//docDateYm
}

function f_Disable() {

	//bargePop.disabled              = true;
//	costPop.disabled              = true;
	docDateIcon.disabled          = true;
	postDateIcon.disabled         = true;
	deptCd.Enable                 = false;
	currencyCd.Enable             = false;
	attr2.Enable             = false;
	document.all.docDate.readOnly = true;
	document.all.postDate.readOnly = true;
	document.all.docDateIcon.src  = "<%= images %>button/cal_icon2.gif";
	document.all.postDateIcon.src = "<%= images %>button/cal_icon2.gif";
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

	var status = ds_costTotMst.NameValue(ds_costTotMst.RowPosition ,"progStatus");
	var createType = ds_costTotMst.NameValue(ds_costTotMst.RowPosition,"createType");
	if ( status == "10" && createType != "2") {
		ds_costTotDtl.AddRow();
		ds_costTotDtl.Namevalue(ds_costTotDtl.RowPosition,"companyCd") = ds_costTotMst.Namevalue(ds_costTotMst.RowPosition,"companyCd");
		ds_costTotDtl.Namevalue(ds_costTotDtl.RowPosition,"deptCd")    = deptCd.ValueOfIndex("code",deptCd.Index);
		ds_costTotDtl.Namevalue(ds_costTotDtl.RowPosition,"docYm")     = ds_costTotMst.Namevalue(ds_costTotMst.RowPosition,"docYm");
		ds_costTotDtl.Namevalue(ds_costTotDtl.RowPosition,"docSeq")    = ds_costTotMst.Namevalue(ds_costTotMst.RowPosition,"docSeq");
		// to forbid manual inputting for an account codes
		ds_costTotDtl.Namevalue(ds_costTotDtl.RowPosition,"loadGbn")   = "N";		
	}

	// Cost Center Retrieve
	f_RetrieveCostCenter();
	cfDsUnionBlank(ds_costCenter, "code", "code","");

}

	
//-------------------------------------------------------------------------
// Del Item
//-------------------------------------------------------------------------
function f_Del(){
	var status = ds_costTotMst.NameValue(ds_costTotMst.RowPosition ,"progStatus");
	var createType = ds_costTotMst.NameValue(ds_costTotMst.RowPosition,"createType");
	if ( status == "10" && createType != "2") {
    	ds_costTotDtl.DeleteRow(ds_costTotDtl.RowPosition);      // 신규 추가건만 삭제 가능
    	f_enableCurr();
	}
}

function f_Barge_Del(){

	if(ds_bargeInf.RowPosition > 0){
   		ds_bargeInf.DeleteRow(ds_bargeInf.RowPosition);      // 신규 추가건만 삭제 가능
   	}else{
   		alert('<%= msgNoDelete%>');
   		return;
   	}
}

//-------------------------------------------------------------------------
// Page Init
//-------------------------------------------------------------------------
function f_Init() {

	f_Disable();
	//Y/N select box
	//cfDsUnionBlank(ds_vat, "code", "name","");
	//cfDsUnionBlank(ds_priCenter, "code", "name","");

}

//-------------------------------------------------------------------------
// 검색
//-------------------------------------------------------------------------
function f_RetrieveCostCenter() {

	var condition = "?";
 		condition += "&postDate=" + removeDash(document.all.postDate.value,"/");

	ds_costCenter.DataId="cm.cm.retrieveCommComboCostCenterList.gau"+condition;
	ds_costCenter.Reset();
}


//-------------------------------------------------------------------------
// Cost barge Search Popup
//-------------------------------------------------------------------------
var barge_param = "";
function f_bargePop() {


	if(ds_costTotDtl.CountRow == 0){
		alert('<%= msgNoDataItem %>');
		return false;
	}

    if(ds_bargeInf.CountRow>0){
        // 선택 & 창닫기
        //alert(ds_bargeInf.CountRow);
        for(i=1; i <= ds_bargeInf.CountRow; i++){
	        	barge_param += ds_bargeInf.NameValue( i, "lngCd" )+"%";
	    }
	    if(barge_param != ""){
			barge_param = "?barge_param="+barge_param;
		}
	}


	var win = f_bargeSearchPop();
	
	barge_param = "";
	
	if( win ){
		var result = win.lnc_cd.split('%');
		
		//if(ds_bargeInf.CountRow == 0) {
	        cfHideNoDataMsg(gr_bargeInf);           // 최초 입력인 경우, 해당 건을 만들어주고 진행해야한다.
	        ds_bargeInf.ClearAll();
	        ds_bargeInf.setDataHeader( strHeaderBarge );
			cfSetSearchGridBtn(strHeaderBarge);
	    //}
	    
		for(i=0; i < result.length; i++){
		
			//alert("result["+i+"] : "+result[i]);
			if(result[i] != ""){
				var result2 = result[i].split('*');				
				
				
				ds_bargeInf.AddRow();
				ds_bargeInf.NameValue(ds_bargeInf.RowPosition, "syskey") 			= result2[0];
				ds_bargeInf.Namevalue(ds_bargeInf.RowPosition, "mvCd")   				= result2[1];
				ds_bargeInf.Namevalue(ds_bargeInf.RowPosition, "bargeSeq")  		= result2[2];
				ds_bargeInf.Namevalue(ds_bargeInf.RowPosition, "bargeCd")  			= result2[3];
				ds_bargeInf.Namevalue(ds_bargeInf.RowPosition, "postDate")     		= result2[4];
				ds_bargeInf.Namevalue(ds_bargeInf.RowPosition, "mvArrivalDate")= result2[5];
				ds_bargeInf.NameValue(ds_bargeInf.RowPosition, "loadingQty")   	= result2[6];
				ds_bargeInf.Namevalue(ds_bargeInf.RowPosition, "loadingDate")    = result2[7];
				ds_bargeInf.NameValue(ds_bargeInf.RowPosition, "portStock")   	    = result2[8];
				ds_bargeInf.NameValue(ds_bargeInf.RowPosition, "lngCd")   	            = result[i];
				
			}
		}
	}
}


//-------------------------------------------------------------------------
// Cost Price Search Popup
//-------------------------------------------------------------------------
function f_costPop() {
	var createType = ds_costTotMst.NameValue(ds_costTotMst.RowPosition,"createType");
	if ( createType == "2") {
		return;
	}

	if ( ds_costTotMst.Rowstatus(ds_costTotMst.RowPosition) != '1' ) {
		alert('<%= msgNoDataItem %>');
		return;
	}

	if(ds_costTotDtl.CountRow == 0){
		alert('<%= msgNoDataItem %>');
		return false;
	}
	
	var win = f_costPriceSearchPop();
	if( win ){

		//Header
		ds_costTotMst.NameValue(ds_costTotMst.RowPosition, "currencyCd") = win.currencyCd;
		//Detail
		//ds_costTotDtl.Namevalue(ds_costTotDtl.RowPosition, "sapAcctV")   = win.vendCd;
		ds_costTotDtl.Namevalue(ds_costTotDtl.RowPosition, "debitAmt")   = win.totPay;
		ds_costTotDtl.Namevalue(ds_costTotDtl.RowPosition, "sapAcctCd")  = win.acctSapCd;
		ds_costTotDtl.Namevalue(ds_costTotDtl.RowPosition, "sapAcctNm")  = win.sapAcctNm;
		ds_costTotDtl.Namevalue(ds_costTotDtl.RowPosition, "sp")         = win.attr1;
		ds_costTotDtl.Namevalue(ds_costTotDtl.RowPosition, "chkyn")      = win.attr2;
		
		ds_costTotDtl.NameValue(ds_costTotDtl.RowPosition, "workCd")   			= win.workType;
		ds_costTotDtl.NameValue(ds_costTotDtl.RowPosition, "workVendor")     = win.vendCd;
		ds_costTotDtl.NameValue(ds_costTotDtl.RowPosition, "workYm")     		= removeDash(win.postYm,"/");
		ds_costTotDtl.NameValue(ds_costTotDtl.RowPosition, "workRentalType")     = win.type;
		ds_costTotDtl.NameValue(ds_costTotDtl.RowPosition, "wasteCd")     = win.wasteCd;
		
		ds_costTotDtl.NameValue(ds_costTotDtl.RowPosition, "attr12")     = win.attr12;
		ds_costTotDtl.NameValue(ds_costTotDtl.RowPosition, "attr13")     = win.attr13;
		ds_costTotDtl.NameValue(ds_costTotDtl.RowPosition, "attr14")     = win.attr14;
		ds_costTotDtl.NameValue(ds_costTotDtl.RowPosition, "attr15")     = win.attr15;
		ds_costTotDtl.NameValue(ds_costTotDtl.RowPosition, "attr16")     = win.attr16;
		currencyCd.Enable             = false;
		ds_costTotDtl.Namevalue(ds_costTotDtl.RowPosition,"center")    = "11100";
		
	    // to forbid manual inputting for an account codes
	    ds_costTotDtl.Namevalue(ds_costTotDtl.RowPosition,"loadGbn") = win.loadGbn;
	}

}

function f_enableCurr(){
	var cont=0;
	for(var i=1; i <= ds_costTotDtl.countRow; i++){
		for( var j=1,cnt=0; j <= ds_checkCostPriceAccount.CountRow; j++ ) {
			if( ds_costTotDtl.NameValue(i,"sapAcctCd") == ds_checkCostPriceAccount.NameValue( j , "acctCd" ) ) {
				cont++;
			}
		}
	}
	//공정코드가 한개라도 있을시 currency disable
	if(cont > 0){
		currencyCd.Enable             = false;
	}else{
		currencyCd.Enable             = true;
	}
}

//전표출력
function f_print(){
 
	    //window.showModalDialog('jsp/po/oc/preView.jsp',window,"dialogWidth:850px,dialogHeight:558px,left=" + (screen.width/2 - 821/2)+ ",top=" + (screen.height/2 - 558/2) +",scrollbars=yes,menubar=0,status=0,toolbar=0,location=0,directories=0,resizable=0")
    	window.open("jsp/fi/ar/docPrintWebPop.jsp?gubun=p","PreView","width=695,height=300,left=" + (screen.width/2 - 821/2)+ ",top=" + (screen.height/2 - 558/2) +",scrollbars=0,menubar=0,status=0,toolbar=0,location=0,directories=0,resizable=1");   	
}

function _fix(v) {
        v = Math.round(parseFloat(v) * 100).toString();
        while (v.length < 3) v = "0" + v;
        return  v.substring(0, v.length-2) + "." + v.substring(v.length-2, v.length);
} 

function f_excelDown(){
	if (checkData()) {
		var condition = "?";
	    	condition += "companyCd=<%= g_companyCd %>";
	    	condition += "&deptCd=<%=g_companyCd%>";
	 		condition += "&progStatus=" + progStatus.ValueOfIndex("code",progStatus.Index);
	 		condition += "&orderDateFrom=" + removeDash(document.all.orderDateFrom.value,"/");
	 		condition += "&orderDateTo=" + removeDash(document.all.orderDateTo.value,"/");
	 		condition += "&createType=" + createType.ValueOfIndex("code",createType.Index)
	 		condition += "&docDateFrom=" + removeDash(document.all.docDateFrom.value,"/");
	 		condition += "&docDateTo=" + removeDash(document.all.docDateTo.value,"/");;
	 		
	// 		alert(condition);
	
		ds_excelDown.DataID = "fi.ar.retrieveCostTotLedgerMstExcelList.gau"+condition;
		ds_excelDown.Reset();
		
	}
}

//-------------------------------------------------------------------------
//Excel Download
//-------------------------------------------------------------------------
function f_excel() {
	gf_excel(ds_excelDown,gr_excelDown,"<%=columnData.getString("page_title") %>","c:\\");
}

function f_dateValid(obj){
	if(obj.value != "")
		valiDate(obj);
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

<!-- Grid 용 Detail DataSet-->
<object id="ds_bargeInf" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/> 
  <param name="ViewDeletedRow"    value="false"/>
</object>

<!-- Hidden Grid 용 Detail DataSet-->
<object id="ds_excelDown" classid="<%=LGauceId.DATASET%>"/>
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

<!-- Type combo DataSet -->
<object id="ds_attr2"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
	<param name="DataID"          value="cm.cm.retrieveCommCodeCombo.gau?groupCd=2013">
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

<!-- Currency combo DataSet -->
<object id="ds_createType"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
	<param name="DataID"          value="cm.cm.retrieveCommCodeCombo.gau?groupCd=2003">
</object>

<!-- SPGL Combo 용 DataSet-->
<object id="ds_spgl" classid="<%=LGauceId.DATASET%>" >
  	<param name="SyncLoad"          value="true"> 
</object>

<!-- cost Center 용 DataSet-->
<object id="ds_costCenter" classid="<%=LGauceId.DATASET%>" >
  	<param name="SyncLoad"          value="true"> 
</object>

<!-- profit Center 용 DataSet-->
<!--object id="ds_priCenter" classid="<%--=LGauceId.DATASET--%>">
  	<param name="SyncLoad"        value="true"> 
	<param name="DataID"          value="cm.cm.retrieveCommComboCostCenterList.gau?postDate=">
</object-->

<!-- Vat combo DataSet -->
<object id="ds_vat"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
	<param name="DataID"          value="fi.ar.retrieveCostTotLedgerVatVCombo.gau">
</object>

<!-- Vat combo DataSet   원천세 계정 리스트-->
<object id="ds_checkAccount" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
	<param name="DataID"          value="cm.cm.retrieveCheckAccountList.gau">
</object>

<object id="ds_checkCostPriceAccount" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
	<param name="DataID"          value="cm.cm.retrieveCheckCostPriceAccountCodeList.gau">
</object>

<!-- 기간비용 계정 정보 목록 -->
<object id="ds_checkPeriodCostAccount" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
	<param name="DataID"          value="cm.cm.retrieveCommCodeCombo.gau?groupCd=PCST">
</object>

<object id="ds_checkSapVatAccount" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
	<param name="DataID"          value="cm.cm.retrieveSapVatAcctCdList.gau?type=v">
</object>

<object id="ds_checkAttrAccount" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
	<param name="DataID"          value="cm.cm.retrieveSapVatAcctCdList.gau?type=a">
</object>

<object id="ds_checkAttrAccountAll" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
	<param name="DataID"          value="cm.cm.retrieveSapVatAcctCdList.gau">
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
  gr_costTotMst.ColumnProp("deptCd", "SumText") = "Total";
  gr_costTotMst.ColumnProp("docSeq", "SumText") = "Cnt :"+rowCnt;
  gr_costTotMst.ColumnProp("amount", "SumText") = "@sum";
  gr_costTotMst.ViewSummary = "1";
  //alert(ds_costTotMst.DataHeader);
</script>

<script language=JavaScript for=ds_costTotMst event=OnLoadError()>
  cfShowErrMsg(ds_costTotMst);
  //mode = "";
</script>

<!-- Hub In Mgnt Detail 조회 DataSet -->
<script language=JavaScript for=ds_costTotDtl event=OnLoadCompleted(rowCnt)>
	cfFillGridNoDataMsg(gr_costTotDtl,"gridColLineCnt=2");//no data found   
  
		
	var RowStatus = ds_costTotMst.RowStatus(ds_costTotMst.RowPosition);
	var progStatus = ds_costTotMst.NameValue(ds_costTotMst.RowPositio,"progStatus");

	if ( RowStatus != 1 ) {

	    var condition = "?";
		condition += "&companyCd="+ds_costTotMst.NameValue(ds_costTotMst.RowPosition,"companyCd");
		condition += "&deptCd="+ds_costTotMst.NameValue(ds_costTotMst.RowPosition,"deptCd");
		condition += "&docYm="+ds_costTotMst.NameValue(ds_costTotMst.RowPosition,"docYm");
		condition += "&docSeq="+ds_costTotMst.NameValue(ds_costTotMst.RowPosition,"docSeq");
		ds_bargeInf.DataID = "fi.ar.retrieveCostTotLedgerBargeMgnt.gau"+condition;
		ds_bargeInf.Reset();
	}
	
	// Cost Center Retrieve
	f_RetrieveCostCenter();
	cfDsUnionBlank(ds_costCenter, "code", "name","");
  
  
</script>

<script language=JavaScript for=ds_costTotDtl event=OnLoadError()>
  cfShowErrMsg(ds_costTotDtl);
</script>

<script language=JavaScript for=ds_excelDown event=OnLoadCompleted(rowCnt)>
f_excel();
</script>

<script language="javascript"  for=ds_costTotMst event=OnRowPosChanged(row)>

	//Detail Dataset Clear
  	ds_costTotDtl.ClearData();
	ds_bargeInf.ClearData();
	
	
	
	if ( row > 0 ) {
		
		var RowStatus = ds_costTotMst.RowStatus(ds_costTotMst.RowPosition);
		var progStatus = ds_costTotMst.NameValue(row,"progStatus");
		
		if ( RowStatus != 1 ) {
		    var condition = "?";
			condition += "&companyCd="+ds_costTotMst.NameValue(row,"companyCd");
			condition += "&deptCd="+ds_costTotMst.NameValue(row,"deptCd");
			condition += "&docYm="+ds_costTotMst.NameValue(row,"docYm");
			condition += "&docSeq="+ds_costTotMst.NameValue(row,"docSeq");
			ds_costTotDtl.DataID = "fi.ar.retrieveCostTotLedgerDtlMgnt.gau"+condition;
			ds_costTotDtl.Reset();
		}
		
		// Cost Center Retrieve
		f_RetrieveCostCenter();
		cfDsUnionBlank(ds_costCenter, "code", "name","");
		/*
		if(ds_costTotMst.NameValue(row,"createType") == "2"){
			gr_costTotDtl.Editable = "FALSE" ;
		}else{
			gr_costTotDtl.Editable = "TRUE" ;
		}
		*/
		if ( RowStatus == 1 ) {
		  	f_Enable();
		  	//TODO:공정코드가 한개라도 존재시 currency가 disable되어야함.
		  	f_enableCurr();
	    } else if(progStatus == "10"){
	    	f_Enable2();
	    }else {
		  	f_Disable();
	    }
	    
	    
	    
	}

</script>

<script language=JavaScript for=DataSetID event=OnColumnChanged(row,colid)>

</script>

<!-- 저장 TR -->
<script language=JavaScript for=tr_cudData event=OnSuccess()>
	mode = "";
	f_Retrieve();
	alert("<%= msgSucProcess %>");
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

<script language=JavaScript for="ds_costTotDtl" event=OnRowPosChanged(row)>
	/*
		* 모든 계정에 부가세 선택 기능 추가
		 -> sap_account 테이블에 attr3에 값 셋팅
		 -> 부가세계정(1119310) : Y
		 -> 원천세계정() : N
		 
		 -> Y인경우만 필수 체크
		 -> N인경우 부가세코드 입력 불가
		 -> null인 경우 부가세코드 옵션
	*/
	
	var cnt = 0;
	//부가세 계정 갯수 만큼 현재 로우를 비교 조사
	for( var j=1; j <= ds_checkSapVatAccount.CountRow; j++ ) {
		//alert("1. 현재로우 계정코드"+ds_costTotDtl.NameValue(row,"sapAcctCd")+"\n2. SAP VAT계정코드"+ds_checkSapVatAccount.NameValue( j , "acctSapCd" )+"3. VAT계정코드 맞는지"+ds_checkSapVatAccount.NameValue( j , "attr3" ));
		
		//부가세입력 받거나 받지 말아야 할 리스트 && 부가세 받아야 하는 경우
		if( ds_costTotDtl.NameValue(row,"sapAcctCd")== ds_checkSapVatAccount.NameValue( j , "acctSapCd" ) && ds_checkSapVatAccount.NameValue( j , "attr3" ) == 'Y'  ){

			if(ds_costTotDtl.NameValue(row,"vat")== null || ds_costTotDtl.NameValue(row,"vat")== ""){
				alert(ds_costTotDtl.NameValue(row,"sapAcctCd") + "is VAT account. \n Check VAT code");
				gr_costTotDtl.SetColumn("vat");
			}
			if(ds_costTotDtl.NameValue(row,"base")== null || ds_costTotDtl.NameValue(row,"base")== ""){
				alert(ds_costTotDtl.NameValue(row,"sapAcctCd") + "is VAT account. \n Check VAT amount");
				gr_costTotDtl.SetColumn("base");
			}
			
		}
		
		//원천세 계정인 경우 입력 불가
		
		if( ds_costTotDtl.NameValue(row,"sapAcctCd")== ds_checkSapVatAccount.NameValue( j , "acctSapCd" ) && ds_checkSapVatAccount.NameValue( j , "attr3" ) == 'N') {
			//계정이 원천세 계정인 경우
			
			 if(ds_costTotDtl.NameValue(row,"vat")!= null || ds_costTotDtl.NameValue(row,"vat")!= ""){
					alert("Account "+ds_costTotDtl.NameValue(row,"sapAcctCd")+ "is not required VAT");
					gr_costTotDtl.SetColumn("vat");
			}
			if(ds_costTotDtl.NameValue(row,"base")!= null || ds_costTotDtl.NameValue(row,"base")!= ""){
					alert("Account "+ds_costTotDtl.NameValue(row,"sapAcctCd")+ "is not required VAT amount");
					gr_costTotDtl.SetColumn("base");
			}
				
		
			cnt ++;
			//VAT 부분 입력 받지 않도록 변경
		}
		
	}
			
	if(cnt > 0){
		gr_costTotDtl.ColumnProp("vatBaseAmount", "Edit") = "none";
		gr_costTotDtl.ColumnProp("vat", "Edit") = "none";
	}else{
		gr_costTotDtl.ColumnProp("vatBaseAmount", "Edit") = "RealNumeric";
		gr_costTotDtl.ColumnProp("vat", "Edit") = "true";
	}
			
	var cnt2=0;
	var sapAcctCd = ds_costTotDtl.NameValue(row,"sapAcctCd");
	for( var j=1; j <= ds_checkAttrAccountAll.CountRow; j++ ) {
		if( sapAcctCd == ds_checkAttrAccountAll.NameValue( j , "acctSapCd" ) ) {
			if((ds_checkAttrAccountAll.NameValue( j , "sp" )=="S"  &&ds_checkAttrAccountAll.NameValue( j , "chkDueDate" )=="Y") || ds_checkAttrAccountAll.NameValue( j , "sp" )=="K" || ds_checkAttrAccountAll.NameValue( j , "sp" )=="D") {
				cnt2++;
			}
		}
	}
	if(cnt2 > 0){
		gr_costTotDtl.ColumnProp("dueDate", "Edit") = "RealNumeric";
	}else{
		ds_costTotDtl.NameValue(row,"dueDate") = "";
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

<script language="javascript"  for=gr_costTotDtl event=OnColumnPosChanged(row,colid)>

	// SEARCH 버튼  DISPLAY
    if (colid.toLowerCase() == "sapacctcd") cfSetSearchGridBtn(gr_costTotDtl);    
    if (colid.toLowerCase() == "sapacctcnm") cfSetSearchGridBtn(gr_costTotDtl);
    if (colid.toLowerCase() == "sapacctvnm") cfSetSearchGridBtn(gr_costTotDtl);
    if (colid.toLowerCase() == "duedate") cfSetCalendarGridBtn(gr_costTotDtl);
    if (colid.toLowerCase() == "intordernm") cfSetSearchGridBtn(gr_costTotDtl);
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
		}
		
		cfDsUnionBlank(ds_spgl, "code", "name","");
	}

</script>

<script language="javascript"  for=gr_costTotDtl event=OnPopup(Row,Colid,data)>
    
    if ( Colid == "sapAcctCd") {
		openSapAccountCodeListGridWin(Row, ds_costTotDtl)
    	//openAccountCodeListGridWin(Row, 'LOC', ds_costTotDtl);
    }

    if ( Colid == "sapAcctCNm") {
    	openVendorSapListGridWin(Row, ds_costTotDtl, "sapAcctC", "sapAcctCNm");
    }
    
    // vendor 조회 팝업 호출
    if ( Colid == "sapAcctVNm") {    	
    	openVendorSapListGridWin(Row, ds_costTotDtl, "sapAcctV", "sapAcctVNm");
    }    
    
    // I/O 코드 조회 팝업 호출
	if ( Colid == "intOrderNm") {
		
		openInternalOrderCodeListGridWin(Row, ds_costTotDtl, "intOrder", "intOrderNm");
	}
    
	/*
		* 모든 계정에 부가세 선택 기능 추가
		 -> sap_account 테이블에 attr3에 값 셋팅
		 -> 부가세계정(1119310) : Y
		 -> 원천세계정() : N
		 
		 -> Y인경우만 필수 체크
		 -> N인경우 부가세코드 입력 불가
		 -> null인 경우 부가세코드 옵션
	*/
	var cnt = 0;
    for( var j=1; j <= ds_checkSapVatAccount.CountRow; j++ ) {
		if( ds_costTotDtl.NameValue(Row,"sapAcctCd") == ds_checkSapVatAccount.NameValue( j , "acctSapCd" ) && ds_checkSapVatAccount.NameValue( j , "attr3" ) == 'N') {
			cnt++;
		}
	}
	if(cnt > 0){
		gr_costTotDtl.ColumnProp("vatBaseAmount", "Edit") = "none";
		gr_costTotDtl.ColumnProp("vat", "Edit") = "none";
	}else{
		gr_costTotDtl.ColumnProp("vatBaseAmount", "Edit") = "RealNumeric";
		gr_costTotDtl.ColumnProp("vat", "Edit") = "true";
	}
	
	var cnt2=0;
	var sapAcctCd = ds_costTotDtl.NameValue(Row,"sapAcctCd");
	for( var j=1; j <= ds_checkAttrAccountAll.CountRow; j++ ) {
		if( sapAcctCd == ds_checkAttrAccountAll.NameValue( j , "acctSapCd" ) ) {
			if(ds_checkAttrAccountAll.NameValue( j , "chkDueDate" )=="Y" || ds_checkAttrAccountAll.NameValue( j , "sp" )=="K" || ds_checkAttrAccountAll.NameValue( j , "sp" )=="D") {
				cnt2++;
			}
		}
	}
	if(cnt2 > 0){
		gr_costTotDtl.ColumnProp("dueDate", "Edit") = "RealNumeric";
	}else{
		ds_costTotDtl.NameValue(Row,"dueDate") = "";
		gr_costTotDtl.ColumnProp("dueDate", "Edit") = "none";
	}
	
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


 <script language=JavaScript for=gr_costTotDtl event=OnExit(row,colid,olddata)>
	var dueDate = ds_costTotDtl.Namevalue(row,"dueDate");
	var tf = true;
 	if(colid == "dueDate" ){
	}

</script>

<script language=JavaScript for=deptCd event=OnSelChange2()>
     for ( var i = 1; i <= ds_costTotDtl.CountRow; i++) {
		ds_costTotDtl.Namevalue(i,"deptCd") = deptCd.ValueOfIndex("code",deptCd.Index);
     }
</script>

<script language=JavaScript for=gr_costTotDtl event=OnCloseUp(row,colid)>
		
</script>

<script language=JavaScript for=attr2 event=OnSelChange2()>
var RowStatus = ds_costTotMst.RowStatus(ds_costTotMst.RowPosition);
if ( RowStatus == 1 ) {
	if(document.all.attr2.BindColVal == "C"){
		alert('<%=source.getMessage("dev.fi.ar.costprice.select")%>');
		document.all.attr2.index=0;
	}
}
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
							<col width="14%"/>
							<col width=""/>		
						</colgroup>						
						<tr>		
							<th><%= columnData.getString("create_date") %></th>
							<td>
								<input type="text" id="orderDateFrom" value="<%= prevDate %>" 		onblur="valiDate(this);" style="width:60px;"/>&nbsp;<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(orderDateFrom);" style="cursor:hand"/> ~ 
								<input type="text" id="orderDateTo"   value="<%= currentDate %>" 	onblur="valiDate(this);" style="width:60px;"/>&nbsp;<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(orderDateTo);" style="cursor:hand"/>
							</td>																												
							<th><%= columnData.getString("prog_status") %></th>
							<td>
								<object id="progStatus"  classid="<%=LGauceId.LUXECOMBO%>" align="absmiddle" width="110">
								    <param name="ComboDataID"       value="ds_statusCode">
									<param name="ListCount"     	value="10">
									<param name="BindColumn"    	value="code">
									<param name="WantSelChgEvent"   value="TRUE">
								    <param name=ListExprFormat		value="name^0^90,code^0^70">
								    <param name=index           	value=0>
							   	</object>
							</td>							
						</tr>
						<tr>														
							<th><%= columnData.getString("doc_date") %></th>
							<td>
								<input type="text" id="docDateFrom" value="<%= prevDate %>" 	onblur="f_dateValid(this);" style="width:60px;"/>&nbsp;<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(docDateFrom);" style="cursor:hand"/> ~ 
								<input type="text" id="docDateTo"   value="<%= currentDate %>" 	onblur="f_dateValid(this);" style="width:60px;"/>&nbsp;<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(docDateTo);" style="cursor:hand"/>
							</td>
							<th><%= columnData.getString("create_type") %></th>
							<td>
								<object id="createType"  classid="<%=LGauceId.LUXECOMBO%>" align="absmiddle" width="110">
								    <param name="ComboDataID"       value="ds_createType">
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
      <!--검색 E -->

	<div class="sub_stitle"> 
		<p> <%=columnData.getString("sub1_title") %> </p>
		<p class="rightbtn">
			
<%-- 사용하지 않음 주석처리 			
			<span class="sbtn_r sbtn_l"> 
			<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="<%=btnPrint %>" onclick="f_print();"/></span>
--%>			  	 
			<span class="excel_btn_r excel_btn_l">
             <input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="<%=btnExcelDown %>" onclick="f_excelDown()"/>
             </span>   
		</p>			
	</div>   	

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
	    <Param NAME="TitleHeight"      	value="30">
	    <param name="UsingOneClick"     value=1>
        <param name=ViewSummary         value="1">
		<param Name='Format'
			value='
           		<C> id=seq         		name="<%= columnData.getString("item_seq") %>"       	  align="center"   width="30"   Edit="none"  Value={CurRow} </C>
                <C> id=companyCd   		name="<%= columnData.getString("company_cd") %>"     	  align="center"   width="70"   Edit="none"  show="false"   </C>                
                <C> id=docYm       		name="<%= columnData.getString("doc_ym") %>"     		  align="center"   width="56"   Edit="none"  show="true"    </C>
                <C> id=docSeq      		name="<%= columnData.getString("doc_seq") %>"     		  align="center"   width="70"  Edit="none"  show="true"   </C>                
                <C> id=sapDocSeq   		name="<%= columnData.getString("sap_doc_seq") %>"     	  align="center"   width="90"   Edit="none"  show="true"   </C>
                <C> id=amount      		name="<%= columnData.getString("amount") %>"     		  align="right"    width="114"  Edit="none"  show="true"  sumbgcolor="#ECE6DE" sumcolor="#666666" DisplayFormat ="#,###.00"  </C>                
                <C> id=currencyCd  		name="<%= columnData.getString("currency_cd") %>"     	  align="center"   width="50"   Edit="none"  show="true"    </C>                                              
                <C> id=deptCd      		name="<%= columnData.getString("dept_cd") %>"     		  align="center"   width="40"   Edit="none"  show="false"   </C>
                <C> id=deptNm      		name="<%= columnData.getString("dept_nm") %>"     	      align="left"     width="70"   Edit="none"  show="false"   </C>
                <C> id=progStatusNm 	name="<%= columnData.getString("prog_status") %>"         align="left"     width="92"   Edit="none"  show="true"    </C>
                <C> id=createType      	name="<%= columnData.getString("create_type") %>"     	  align="center"   width="50"   Edit="none"  show="true"  EditStyle="LookUp"  Data="ds_createType:Code:NAME"  </C>
                <C> id=createDate  		name="<%= columnData.getString("create_date") %>"     	  align="center"   width="80"   Edit="none"  show="true"  Mask="XXXX/XX/XX"  </C>
                <C> id=docDate     		name="<%= columnData.getString("doc_date") %>"     	      align="center"   width="80"   Edit="none"  show="true"    </C>
                <C> id=postDate    		name="<%= columnData.getString("post_date") %>"     	  align="center"   width="80"   Edit="none"  show="true"    </C>                                
                <C> id=docType     		name="<%= columnData.getString("doc_type") %>"     	      align="center"   width="70"   Edit="none"  show="false"   </C>
                <C> id=progStatus  		name="<%= columnData.getString("prog_status") %>"     	  align="center"   width="70"   Edit="none"  show="false"   </C>                
                <C> id=attr2 			name="<%= columnData.getString("attr2") %>"      		  align="left"     width="74"   Edit="none"  show="false"  EditStyle="LookUp"  Data="ds_attr2:Code:NAME"  </C>                
                <C> id=sapCancelDocSeq  name="<%= columnData.getString("sap_cancel_doc_seq") %>"  align="center"   width="100"  Edit="none"  show="false"   </C>                                                
                <C> id=successType 		name="<%= columnData.getString("success_type") %>"        align="center"   width="70"   Edit="none"  show="false"   </C>
                <C> id=workType	    	name="<%= columnData.getString("work_type") %>"      	  align="center"   width="70"   Edit="none"  show="false"   </C>
                <C> id=vendCd 	    	name="<%= columnData.getString("vend_cd") %>"      		  align="center"   width="70"   Edit="none"  show="false"   </C>
                <C> id=postYm 	    	name="<%= columnData.getString("post_ym") %>"      		  align="center"   width="70"   Edit="none"  show="false"   </C>
                <C> id=docDateYm                                                                                                             show="false"   </C>
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
	      <object id="deptCd"  classid="<%=LGauceId.LUXECOMBO%>" align="absmiddle" width="120" style='display:none'>
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
				<param name=ListExprFormat		value="name^0^100,code^0^50">
				<param name=index           	value=0>
				<param name=WantSelChgEvent	    value=true>
			</object>
		  </td>
		</tr>
	    <tr>
		  <th><%= columnData.getString("doc_date") %></th>
		  <td><input type="text" id="docDate" 	style="width:70px;" maxlength="10" onblur="valiDate(this);">
		      <img id=docDateIcon src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(docDate, postDate);" style="cursor:hand"/></td>
		  <th><%= columnData.getString("post_date") %></th>
		  <td><input type="text" id="postDate" 	style="width:70px;" maxlength="10" onPropertyChange="f_RetrieveCostCenter();" onblur="f_dateValid(this);" >
		      <img id=postDateIcon src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(postDate);" style="cursor:hand"/>
		  </td>		
		  <object id="attr2"  classid="<%=LGauceId.LUXECOMBO%>" align="absmiddle" width="100" style="display:none">
				<param name="ComboDataID"       value="ds_attr2">
				<param name="ListCount"     	value="10">
				<param name="BindColumn"    	value="code">
				<param name=ListExprFormat		value="name^0^130,code^0^50">
				<param name=index           	value=0>
				<param name=WantSelChgEvent	    value=true>
			</object>								
		</tr>
	  </table>
	</div>

	<object id=bd_costTot classid="<%=LGauceId.BIND%>">
		<param name=DataID value=ds_costTotMst>
		<param name=BindInfo 
			value='
                <C> Col=companyCd    Ctrl=companyCd    Param=value      </C>
                <C> Col=deptCd       Ctrl=deptCd       Param=BindColVal </C>
                <C> Col=docYm        Ctrl=docYm        Param=value      </C>
                <C> Col=docSeq       Ctrl=docSeq       Param=value      </C>
                <C> Col=docDate      Ctrl=docDate      Param=value      </C>
                <C> Col=postDate     Ctrl=postDate     Param=value      </C>
                <C> Col=currencyCd   Ctrl=currencyCd   Param=BindColVal </C>
                <C> Col=attr2      	 Ctrl=attr2     	Param=BindColVal </C>
	  		'>
	</object>

    <div class="sub_stitle"> <p><%= columnData.getString("sub3_title") %></p>
    	<p class="rightbtn">
    	 
 <%-- 사용하지 않음 주석처리
          <span class="sbtn_r sbtn_l">
          <input type="button" id=costPop onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="<%= btnPriceSearch %>" onclick="f_costPop();"/></span>
--%>                
          <span class="sbtn_r sbtn_l">
          <input type="button" id=Save onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="<%= btnAddRow %>" onclick="f_Add();"/></span> 
          <span class="sbtn_r sbtn_l"> 
          <input type="button" id=Del onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="<%= btnDelRow %>" onclick="f_Del();"/></span>
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
           		<C> id=seq            name="seq"         align="center"  width="40"   Edit="none"   	   Value={CurRow} </C>
                <C> id=companyCd      name="<%= columnData.getString("company_cd") %>"        align="center"  width="70"   Edit="none"  	   show="false"   </C>
                <C> id=deptCd         name="<%= columnData.getString("dept_cd") %>"           align="center"  width="70"   Edit="none"   	   show="false"   </C>
                <C> id=docYm          name="<%= columnData.getString("doc_ym") %>"     	      align="center"  width="70"   Edit="none"   	   show="false"   </C>
                <C> id=docSeq         name="<%= columnData.getString("doc_seq") %>"           align="center"  width="70"   Edit="none"   	   show="false"   </C>
                <C> id=docNum         name="<%= columnData.getString("doc_num") %>"           align="center"  width="70"   Edit="none"   	   show="false"   </C>                
                <C> id=sapAcctCd      name="<%= columnData.getString("acct_cd") %>"           align="left"    width="57"   Edit="AlphaNum"     show="true"   EditStyle=PopupFix  </C>
                <C> id=sapAcctNm      name="<%= columnData.getString("acct_nm") %>"           align="left"    width="215"  Edit="none"   	   show="true"   sumtext="Total"  </C>
                <C> id=debitAmt       name="<%= columnData.getString("debit_amt") %>"         align="right"   width="110"  EDIT="RealNumeric"  Edit={IF(creditAmt = 0, "true","false")}   show="true" sumtext="@sum", sumbgcolor="#ECE6DE" sumcolor="#666666"  </C>
                <C> id=creditAmt      name="<%= columnData.getString("credit_amt") %>"        align="right"   width="110"  EDIT="RealNumeric"  Edit={IF(debitAmt  = 0, "true","false")}   show="true" sumtext="@sum", sumbgcolor="#ECE6DE" sumcolor="#666666"  </C>
                <C> id=vat            name="Tax Code"     	      align="left"    width="110"  Edit="AlphaNum"     show="true"   Data="ds_vat:code:name" Editstyle="Lookup"  </C>
                <C> id=base           name="<%= columnData.getString("base") %>"     	      align="right"   width="110"  Edit="RealNumeric"  show="false"   </C>                                
                <C> id=sapAcctV       name="<%= columnData.getString("sap_acct_v") %>"        align="center"  width="100"                      show="false"  </C>
                <C> id=sapAcctVNm     name="<%= columnData.getString("sap_acct_v") %>"        align="center"  width="130"  Edit="AlphaNum"     show="true"   EditStyle=PopupFix  </C>
                <C> id=sapAcctC       name="<%= columnData.getString("sap_acct_c") %>"        align="center"  width="100"                      show="false"  </C>
                <C> id=sapAcctCNm     name="<%= columnData.getString("sap_acct_c") %>"        align="center"  width="130"  Edit="AlphaNum"     show="true"   EditStyle=PopupFix  </C>
                <C> id=center         name="<%= columnData.getString("center") %>"     	      align="left"    width="170"  Edit="AlphaNum"     show="true"   Data="ds_costCenter:code:name"  EditStyle="LookUp"  </C>
                <C> id=intOrder       name="<%= columnData.getString("order") %>"     	      align="center"  width="70"                       show="false"  </C>
                <C> id=intOrderNm     name="<%= columnData.getString("order") %>"     	      align="left"  width="160"   Edit="AlphaNum"    show="true"   EditStyle=PopupFix  </C>
                <C> id=docDesc        name="<%= columnData.getString("doc_desc") %>"          align="left"    width="250"  Edit="true"         show="true"   </C>
                <C> id=dueDate        name="<%= columnData.getString("attr11") %>"            align="left"    width="100"  Edit="RealNumeric"  show="true"   Mask="XXXX/XX/XX" editstyle="Popup"  </C>
                <C> id=returnMsg      name="<%= columnData.getString("return_msg") %>"        align="center"  width="120"  Edit="none"         show="true"   BgColor={IF(returnMsg="","White","Red")}  </C>                
                <C> id=vatBaseAmount  name="<%= columnData.getString("attr10") %>"            align="left"    width="110"  Edit="RealNumeric"  show="false"  dec=2  </C>
                <C> id=type           name="<%= columnData.getString("type") %>"     	      align="center"  width="70"   Edit="AlphaEtc"     show="false"   </C>
                <C> id=code           name="<%= columnData.getString("code") %>"              align="center"  width="50"   Edit="AlphaEtc"     show="false"   </C>
                <C> id=rate           name="<%= columnData.getString("rate") %>"              align="right"   width="50"   Edit="RealNumeric"  show="false"   </C>                                
                <C> id=spglNo         name="<%= columnData.getString("spgl_no") %>"           align="center"  width="80"   Edit="AlphaNum"     show="true"   Data="ds_spgl:code:name"  Editstyle="Lookup" ListWidth=210  ShowEditStyle=True  </C>                                
                <C> id=sp             name="<%= columnData.getString("sp") %>"                align="center"  width="70"   Edit="none"   	   show="false"   </C>
                <C> id=chkyn          name="<%= columnData.getString("chk_yn") %>"            align="center"  width="70"   Edit="none"   	   show="false"   </C>
                <C> id=workCd                                                                                                                  show="false"   </C>
                <C> id=workVendor                                                                                                              show="false"   </C>
                <C> id=workYm                                                                                                                  show="false"   </C>
                <C> id=workRentalType                                                                                                          show="false"   </C>
                <C> id=wasteCd        name="wasteCd"                                                                                           show="false"   </C>
                <C> id=attr12		  name="Activity"	                                      align="center"  width="60"   Edit="true"         show="false"   </C>
                <C> id=attr13		  name="Unit"		                                      align="center"  width="60"   Edit="true"         show="false"   </C>
                <C> id=attr14		  name="Qty"	 	                                      align="right"   width="100"  Edit="true"         show="false"   </C>
                <C> id=attr15		  name="Unit"		                                      align="center"  width="60"   Edit="true"         show="false"   </C>
                <C> id=attr16		  name="Distance"	                                      align="right"   width="100"  Edit="true"         show="false"   </C>
                <C> id=periodCostFrom name="Period From"  align="center"  width="100"  Edit="RealNumeric"  show="true"   Mask="XXXX/XX/XX" editstyle="Popup"  </C>
                <C> id=periodCostTo   name="Period To"    align="center"  width="100"  Edit="RealNumeric"  show="true"   Mask="XXXX/XX/XX" editstyle="Popup"  </C>
	      '>
	</object>
 	</div>

    	
   	<!-- 그리드 S -->	
    <div>
	<object id="gr_bargeInf" classid="<%=LGauceId.GRID %>" style="width:0px;height:0px;" class="comn"><!-- width:100%;height:130px; -->
		<param Name="DataID" 			value="ds_bargeInf">
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
           		<C> id=seq              name="seq"  align="center"  Edit="none"      width="30"   Value={CurRow}  </C>
				<C> id="syskey"         name="MV Loading No"                            align="center"  Edit="none"      width="100"  </C>
				<C> id="mvCd"    		name="MV Name"      	                        align="left"    Edit="none"      width="100"  </C>
				<C> id="bargeSeq"    	name="Barge Loading No"   	                    align="center"  Edit="none"      width="120"  </C>
				<C> id="bargeCd"    	name="Barge Name"      		                    align="left"    Edit="none"      width="100"  </C>
				<C> id="postDate"  		name="Posting Date"      		                align="center"  Edit="AlphaNum"  show="true"  Mask="XXXX/XX/XX"  Edit="none" width="100"  </C>
				<C> id="mvArrivalDate"  name="Arrival Date"      	                    align="center"  Edit="AlphaNum"  show="true"  Mask="XXXX/XX/XX"  Edit="none" width="100"  </C>
				<C> id="loadingQty"     name="Actual Loading (MT)"                      align="right"   Edit="none"      width="140"  </C>
			    <C> id="loadingDate"    name=""                                         show=false      Edit="none"      width="100"  </C>
			    <C> id="portStock"      name=""                                         show=false      Edit="none"      width="100"  </C>
			    <C> id="lngCd"         	name="lng"                                                      Edit="none"      show=false   </C>
			    <C> id="companyCd"   	name=""                                                         Edit="none"      show=false   </C>
				<C> id="deptCd"      	name=""                                                         Edit="none"      show=false   </C>
				<C> id="docYm"       	name=""                                                         Edit="none"      show=false   </C>
				<C> id="docSeq"      	name=""                                         show=false      Edit="none"   </C>
				<C> id="bargeName"   	name=""                                         show=false      Edit="none"   </C>
				<C> id="regid"       	name=""                                         show=false      Edit="none"   </C>
				<C> id="regdate"     	name=""                                         show=false      Edit="none"   </C>
				<C> id="regtime"     	name=""                                         show=false      Edit="none"   </C>
				<C> id="modid"       	name=""                                         show=false      Edit="none"   </C>
				<C> id="moddate"     	name=""                                         show=false      Edit="none"   </C>
				<C> id="bargeList"   	name=""                                         show=false      Edit="none"   </C>
	      '>
	</object>
 	</div>
      
	<!-- 버튼 S -->	
    <div id="btn_area">
    	<p class="b_right">
    	<span class="btn_r btn_l"><input type="button" onClick="f_New();" 	 onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%= btnNew %>"/></span>    	
		<span class="btn_r btn_l"><input type="button" onClick="f_Save();" 	 onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%= btnSave %>"/></span>
		<span class="btn_r btn_l"><input type="button" onClick="f_Delete();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%= btnDel %>"/></span>
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
			<param Name="Editable" 			value="true">
	        <param name=ViewSummary         value="1">
			<param Name="Format"
				value='
	           		<C> id=seq           name="seq"        align="center"  width="30"   Edit="none"   	    Value={CurRow}  </C>
	                <C> id=sapDocSeq   	 name="<%= columnData.getString("sap_doc_seq") %>"     align="center"  width="100"  Edit="none"         show="true"     </C>
	                <C> id=docYm         name="<%= columnData.getString("doc_ym") %>"     	   align="center"  width="70"   Edit="none"   	    show="true"     </C>
	                <C> id=docSeq        name="<%= columnData.getString("doc_seq") %>"     	   align="center"  width="70"   Edit="none"   	    show="true"     </C>
	                <C> id=docNum        name="<%= columnData.getString("doc_num") %>"     	   align="center"  width="70"   Edit="none"   	    show="false"    </C>
	                <C> id=docDate       name="<%= columnData.getString("doc_date") %>"        align="center"  width="80"   Edit="none"         show="true"     </C>
	                <C> id=postDate      name="<%= columnData.getString("post_date") %>"       align="center"  width="80"   Edit="none"         show="true"     </C>
	                <C> id=sapAcctCd     name="<%= columnData.getString("acct_cd") %>"     	   align="left"    width="70"   Edit="AlphaNum"   	show="true" EditStyle=PopupFix  </C>
	                <C> id=sapAcctNm     name="<%= columnData.getString("acct_nm") %>"         align="left"    width="110"  Edit="none"   		show="true" sumtext="Total"     </C>
	                <C> id=debitAmt      name="<%= columnData.getString("debit_amt") %>"       align="right"   width="110"  EDIT="RealNumeric"  Edit={IF(creditAmt = 0, "true","false")}   show="true" sumtext="@sum", sumbgcolor="#ECE6DE" sumcolor="#666666"  </C>
	                <C> id=creditAmt     name="<%= columnData.getString("credit_amt") %>"      align="right"   width="110"  EDIT="RealNumeric"  Edit={IF(debitAmt  = 0, "true","false")}   show="true" sumtext="@sum", sumbgcolor="#ECE6DE" sumcolor="#666666"  </C>
	                <C> id=costCenter    name="<%= columnData.getString("center") %>"     	   align="left"    width="100"  Edit="AlphaNum"     show="true"  Data="ds_costCenter:code:name"  EditStyle="LookUp"  </C>
	                <C> id=docDesc       name="<%= columnData.getString("doc_desc") %>"        align="left"    width="100"  Edit="true"         show="true"     </C>
	                <C> id=currencyCd    name="<%= columnData.getString("currency_cd") %>"     align="center"  width="70"   Edit="none"         show="true"     </C>	                
	                <C> id=vat           name="<%= columnData.getString("vat") %>"     	       align="left"    width="110"  Edit="AlphaNum"     show="true" Data="ds_vat:code:name" Editstyle="Lookup"  </C>
	                <C> id=base          name="<%= columnData.getString("base") %>"     	   align="right"   width="80"   Edit="RealNumeric"  show="true"     </C>
	                <C> id=code          name="<%= columnData.getString("code") %>"            align="center"  width="50"   Edit="AlphaEtc"     show="false"     </C>
	                <C> id=rate          name="<%= columnData.getString("rate") %>"            align="right"   width="50"   Edit="RealNumeric"  show="false"     </C>
	                <C> id=spgl          name="<%= columnData.getString("spgl_no") %>"     	   align="center"  width="80"   Edit="AlphaNum"     show="true" Data="ds_spgl:code:name"  Editstyle="Lookup" ListWidth=90  ShowEditStyle=True  </C>
	                <C> id=vendor        name="<%= columnData.getString("sap_acct_v") %>"      align="center"  width="100"  Edit="AlphaNum"     show="true" show="true" EditStyle=PopupFix  </C>
	                <C> id=customer      name="<%= columnData.getString("sap_acct_c") %>"      align="center"  width="100"  Edit="AlphaNum"     show="true" show="true" EditStyle=PopupFix  </C>	                
	                <C> id=progStatusNm  name="<%= columnData.getString("prog_status_nm") %>"  align="left"    width="80"   Edit="none"         show="true"     </C>
	                <C> id=attr2 		 name="<%= columnData.getString("attr2") %>"      	   align="left"    width="120"  Edit="none"         EditStyle="LookUp" 	Data="ds_attr2:Code:NAME" show="false"  </C>	                
	                <C> id=dueDate       name="<%= columnData.getString("attr11") %>"          align="left"    width="100"  Edit="AlphaNum"     show="true" Mask="XXXX/XX/XX" editstyle="PopupFix"  </C>
		      '>
		</object>
    </div>        

<!--script src="/debug_utf8.js"></script-->

        	  
</div>
<input type="hidden" id="h_date"/>
</body>
</html>
