<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--
/*
*************************************************************************
* @source  : purchOrderReg.jsp
* @desc    : PO Send
*------------------------------------------------------------------------
* VER  DATE         AUTHOR      DESCRIPTION
* ---  -----------  ----------  -----------------------------------------
* 1.0  2010.07.21    노태훈       init
* 1.1  2015.02.13    hskim       CSR:C20150213_06194 원천세 기표 오류 수정
* ---  -----------  ----------  -----------------------------------------
* PT-PAM System
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

<title>PT-PAM System</title>
<%@ include file="/include/head.jsp" %>
<%
String prevDate	   = LDateUtils.getDate("yyyy/MM/") +"01"; 
String currentDate = LDateUtils.getDate("yyyy/MM/dd");          // currentDate
%> 
<script type="text/javascript">
parent.centerFrame.cols='220,*';
var g_flug =false; // Detail작업 flag
var g_msPos = 0;   // save후  focus 제정의 Row
var g_ddtPos = 0;  // save후  focus 제정의 Row
var g_appPos = 0;  // save후  focus 제정의 Row
var g_con1Pos = 0;  // save후  focus 제정의 Row
var g_con2Pos = 0;  // save후  focus 제정의 Row
var msg="";

/***************************************************************************************************/
/*초기 세팅
/***************************************************************************************************/
function init(){
	//권한 삭제 요청 2010.9.9 강병용 
	/*if(<%=columnData.getString("authType")%>){
		lc_purDept.enable="true";
	}*/
	f_setData(); 
}

// Ds 초기화
function f_setData(){
	ds_deliLoct.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2005";
	ds_deliLoct.Reset();
	
	ds_currCd.DataId="po.oc.retrievePurchOrderRegCurrList.gau";
	ds_currCd.Reset();	
	
	ds_purDept.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2001";
	ds_purDept.Reset();
	
	//ds_gridPurDept DataSet에 ds_purDept DataSet 내용을 복사
	ds_gridPurDept.SetDataHeader(ds_purDept.DataHeader);
	ds_gridPurDept.ImportData(ds_purDept.ExportData(1,ds_purDept.CountRow,false));
	
	ds_purDept.RowPosition = ds_purDept.NameValueRow("code","<%=g_deptCd%>");
	
	//ds_gridPurDept.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2001";
	//ds_gridPurDept.Reset();  
	
	ds_status.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2203";
	ds_status.Reset();
	
	//ds_poStatus DataSet에 ds_status DataSet 내용을 복사
	ds_poStatus.SetDataHeader(ds_status.DataHeader);
	ds_poStatus.ImportData(ds_status.ExportData(1,ds_status.CountRow,false));
	
	//ds_poStatus.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2203";
	//ds_poStatus.Reset();  
	
	cfUnionBlank(ds_poStatus,lc_postatus,"code","name","--Total--"); 
	
	ds_payTerm.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2206";
	ds_payTerm.Reset();			
 	
	ds_taxType.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2011";
	ds_taxType.Reset();		

	cfUnionBlank(ds_taxType,ds_taxType,"code","name"); 	 	
 	
	ds_mater.DataId="po.oc.retrievePurchOrderRegMaterCombo.gau";
	ds_mater.Reset();	
	
	ds_vatCd.DataId="po.oc.retrievePurchOrderRegVatVCombo.gau?groupCd=2007";
	ds_vatCd.Reset();	 	
 	 
	ds_gridVendor.DataId="cm.cm.retrieveCommComboVendorList.gau";
	ds_gridVendor.Reset();	 	 
	
	//ds_poStatus DataSet에 ds_status DataSet 내용을 복사
	ds_vendor.SetDataHeader(ds_gridVendor.DataHeader);
	ds_vendor.ImportData(ds_gridVendor.ExportData(1,ds_gridVendor.CountRow,false));
	
	//ds_vendor.DataId="cm.cm.retrieveCommComboVendorList.gau";
	//ds_vendor.Reset();	 
	
	ds_poType.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2018";
	ds_poType.Reset();	
	
	cfUnionBlank(ds_vendor,lc_vendor,"code","name","--Total--"); 	
 
	cfAddYn(ds_receiptClsYn,"code"); 
	cfAddYn(ds_ivClsYn,"code");
	
 	f_returnPoSet();
    
    //f_wtList();
    
    gr_tax.Editable="false";
    f_totalSet();
}

// return Po Grid ComboBox Set
function f_returnPoSet(){
	var strHeader  = "code:STRING(50),name:STRING(50)";
    ds_return.SetDataHeader(strHeader); 
    
    ds_return.AddRow();
    ds_return.NameValue(ds_return.RowPosition, "code") = ""; 
    ds_return.NameValue(ds_return.RowPosition, "name") = "";
    
    ds_return.AddRow();
    ds_return.NameValue(ds_return.RowPosition, "code") = "X"; 
    ds_return.NameValue(ds_return.RowPosition, "name") = "Return";	
}

//total Amount Grid/Ds 초기화    
function f_totalSet(){    
	var strHeader = "title1"    + ":STRING(20)"
					+",value1"  + ":DECIMAL(13.2)"
					+",title2"  + ":STRING(20)"						
					+",value2"  + ":DECIMAL(13.2)"
					+",title3"  + ":STRING(20)" 
					+",value3"  + ":DECIMAL(13.2)"; 
	ds_total.SetDataHeader(strHeader);
	gr_total.MultiRowSelect ="false";	
	gr_total.IgnoreSelectionColor ="false";
	
    gr_total.BorderStyle  = 0;
    gr_total.HeadBorder = 1;
    gr_total.HeadLineColor = "#d9e1ec";
    gr_total.LineColor = "#d9e1ec";
    gr_total.TitleHeight = 22;
    gr_total.RowHeight = 22;
    gr_total.IndWidth = 0;
    gr_total.style.borderStyle = "solid";
    gr_total.style.borderWidth = 1;
    gr_total.style.borderColor = "#d9e1ec";
    gr_total.style.fontSize    = "9pt";
    gr_total.style.fontFamily  = "굴림"
    gr_total.style.fontWeight  = "normal";
    gr_total.IndicatorBkColor  = "#EDEDE8";
    gr_total.IndicatorColBkColor = "#EDEDE8";  
    
	ds_total.AddRow();  
	ds_total.NameValue(ds_total.RowPosition,"title1")="<%=columnData.getString("sub_total") %>";
	ds_total.NameValue(ds_total.RowPosition,"value1")= 0;
	ds_total.NameValue(ds_total.RowPosition,"title2")="<%=columnData.getString("total") %>";
	ds_total.NameValue(ds_total.RowPosition,"value2")=0;
	ds_total.NameValue(ds_total.RowPosition,"title3")="<%=columnData.getString("grand_total") %>";
	ds_total.NameValue(ds_total.RowPosition,"value3")=0;    
}

/***************************************************************************************************/
/*조회
/***************************************************************************************************/

// Main 조회
function f_retrieve(){ 
	var v_url = new cfURI();
	v_url.Add("fromDate",encodeURIComponent(fromDate.value));
	v_url.Add("toDate"  ,encodeURIComponent(toDate.value));
	v_url.Add("deliLoct",ds_deliLoct.NameValue(ds_deliLoct.RowPosition,"code"));
	v_url.Add("vendCd",ds_vendor.NameValue(ds_vendor.RowPosition,"code"));			
	v_url.Add("purDept",ds_purDept.NameValue(ds_purDept.RowPosition,"code"));
	v_url.Add("pstatus",ds_poStatus.NameValue(ds_poStatus.RowPosition,"code"));	
	v_url.SetPage("po.oc.retrievePurchOrderRegMainList.gau");

	ds_main.DataId = v_url.GetURI();
	ds_main.Reset(); 
}

//Detail Item  조회
function f_retrieveDtl(){
	var v_url = new cfURI();
	v_url.Add("poNo",ds_main.NameValue(ds_main.RowPosition,"poNo")); 
	v_url.Add("poSeq",ds_main.NameValue(ds_main.RowPosition,"poSeq")); 			
	v_url.SetPage("po.oc.retrievePurchOrderRegDetailList.gau");
	ds_detail.DataId = v_url.GetURI();
	ds_detail.Reset(); 
}

//Vendor App  조회
function f_retrieveApp(){
	var v_url = new cfURI(); 
	v_url.Add("vendCd",ds_main.NameValue(ds_main.RowPosition,"vendCd")); 
	v_url.SetPage("po.oc.retrievePurchOrderRegAppList.gau");
	ds_approval.DataId = v_url.GetURI();
	ds_approval.Reset(); 
}

// WT LIST 조회
function f_wtList(_poNo){
	var v_url = new cfURI();
	v_url.Add("poNo",_poNo);   			
	v_url.SetPage("po.oc.retrievePurchOrderRegTaxList.gau");
	ds_tax.DataId = v_url.GetURI();
	ds_tax.Reset();  
 
}

// Total Amount 계산
function f_caculation(){

    var strSubTot=0; 
    var strGrandTot=0;
    var strVat=0;    
	for(var i=1;i<=ds_detail.CountRow; i++){
	
		strSubTot+=Number(ds_detail.NameValue(i,"amount"));	 
		strGrandTot+=Number(ds_detail.NameValue(i,"amount"))+Number(ds_detail.NameValue(i,"vatAmt"))+Number(ds_detail.NameValue(i,"tranTaxAmt"));	 
		
		/*
		if(ds_detail.NameValue(i,"vatCd")=="V1"){
			strVat+=(Number(ds_detail.NameValue(i,"qty"))*Number(ds_detail.NameValue(i,"price"))/100)*10;
		}else if(ds_detail.NameValue(i,"vatCd")=="V0"){
			strVat+=(Number(ds_detail.NameValue(i,"qty"))*Number(ds_detail.NameValue(i,"price"))/100)*0;
		} 
		*/	
	} 
 
 	ds_total.ClearData();
	ds_total.AddRow();  
	ds_total.NameValue(ds_total.RowPosition,"title1")="<%=columnData.getString("sub_total") %>";
	ds_total.NameValue(ds_total.RowPosition,"value1")=  funcRound(strSubTot,3) ;
	ds_total.NameValue(ds_total.RowPosition,"title2")="<%=columnData.getString("total") %>";
	ds_total.NameValue(ds_total.RowPosition,"value2")= funcRound(Number(strSubTot)-Number(ds_main.NameValue(ds_main.RowPosition,"discountAmt")),3) ;
	ds_total.NameValue(ds_total.RowPosition,"title3")="<%=columnData.getString("grand_total") %>";
	ds_total.NameValue(ds_total.RowPosition,"value3")= funcRound(Number(strGrandTot)-Number(ds_main.NameValue(ds_main.RowPosition,"discountAmt"))+Number(ds_tax.NameValue(1,"wtTaxAmt"))   ,3) ;
}


/***************************************************************************************************/
/*저장
/***************************************************************************************************/
// Save
function f_save()
{
	if(!ds_main.IsUpdated && !ds_detail.IsUpdated && !ds_tax.IsUpdated && !ds_approval.IsUpdated) {
		alert("<%=source.getMessage("dev.inf.com.nochange")%>");
		return;
	} 
	for(var i=1;i<=ds_main.CountRow;i++){
		if(ds_main.NameValue(i,"vendCd")==""){
			ds_main.RowPosition=i;
			gr_main.SetColumn("vendCd");
			alert("<%=source.getMessage("dev.warn.com.select",columnData.getString("vend_cd"))%>");
			return;
		} 	
		if(ds_main.NameValue(i,"deliLoct")==""){
			ds_main.RowPosition=i;
			gr_main.SetColumn("deliLoct");
			alert("<%=source.getMessage("dev.warn.com.select",columnData.getString("deli_loct"))%>");
			return;
		} 			
		if(ds_main.NameValue(i,"deliDate")==""){
			ds_main.RowPosition=i;
			gr_main.SetColumn("deliDate");
			alert("<%=source.getMessage("dev.warn.com.input",columnData.getString("deli_date"))%>");
			return;
		} 	
		var chkDateVal = true;
		if(ds_main.NameValue(i,"deliDate")!=""){
			chkDateVal = valiDate2(ds_main.NameValue(i,"deliDate"));
			if(chkDateVal == "F"){
				ds_main.RowPosition = i;
				gr_main.SetColumn("deliDate");
				return false;
			}
		}	
		if(ds_main.NameValue(i,"currencyCd")==""){
			ds_main.RowPosition=i;
			gr_main.SetColumn("currencyCd");
			alert("<%=source.getMessage("dev.warn.com.select",columnData.getString("currency_cd"))%>");
			return;
		} 
		
		if(ds_main.NameValue(i,"payTerm")==""){
			ds_main.RowPosition=i;
			gr_main.SetColumn("payTerm");
			alert("<%=source.getMessage("dev.warn.com.select",columnData.getString("pay_term"))%>");
			return;
		} 		
		
		if(ds_main.NameValue(i,"absgr")==""){
			ds_main.RowPosition=i;
			gr_main.SetColumn("absgr");
			alert("<%=source.getMessage("dev.warn.com.select","P/O Type")%>");
			return;
		} 
	}
		
	for(var j=1;j<=ds_detail.CountRow;j++){
		if(ds_detail.NameValue(j,"materCd")==""){
			ds_detail.RowPosition=j;
			gr_detail.SetColumn("materCd");
			alert("<%=source.getMessage("dev.warn.com.select",columnData.getString("mater_cd"))%>");
			return;
		}	
		if(ds_detail.NameValue(j,"qty")==""){
			ds_detail.RowPosition=j;
			gr_detail.SetColumn("qty");
			alert("<%=source.getMessage("dev.warn.com.input",columnData.getString("qty"))%>");
			return;
		}
		if(ds_detail.NameValue(j,"vatCd")==""){
			ds_detail.RowPosition=j;
			gr_detail.SetColumn("vatCd");
			alert("<%=source.getMessage("dev.warn.com.select",columnData.getString("plant_year"))%>");
			return;
		}			
		if(ds_detail.NameValue(j,"price")==""){
			ds_detail.RowPosition=j;
			gr_detail.SetColumn("price");
			alert("<%=source.getMessage("dev.warn.com.input",columnData.getString("price"))%>");
			return;
		}	
			
		if(Number(ds_detail.NameValue(j,"qty")) < 0){
			ds_detail.RowPosition=j;
			gr_detail.SetColumn("qty"); 
			alert("<%=source.getMessage("dev.warn.com.minus",columnData.getString("qty"))%>");
			return;
		}	
		
		if(Number(ds_detail.NameValue(j,"amount")) < 0){
			ds_detail.RowPosition=j;
			gr_detail.SetColumn("amount"); 
			alert("<%=source.getMessage("dev.warn.com.minus",columnData.getString("amount"))%>");
			return;
		}	
				
		if(Number(ds_detail.NameValue(j,"price")) < 0){
			ds_detail.RowPosition=j;
			gr_detail.SetColumn("price"); 
			alert("<%=source.getMessage("dev.warn.com.minus",columnData.getString("price"))%>");
			return;
		}		
 
		
		h_length.value = (Number(ds_detail.NameValue(j,"qty"))*Number(ds_detail.NameValue(j,"price"))*Number(ds_main.NameValue(ds_main.RowPosition,"currPer"))).toFixed(0);
	 	// sap에서 계산 하는것을 미리 계산하여 amount의 최대값을 체크한다
	    // 현재 sap은 14자리 까지 만들어간다.
		if(h_length.value.length > 13){
			ds_detail.RowPosition=j; 
			gr_detail.SetColumn("amount"); 
			alert("<%=source.getMessage("dev.msg.po.lengthLimit",columnData.getString("amount"))%>");
			return;
		}		
		
		h_length.value = (Number(ds_detail.NameValue(j,"tranTaxAmt"))*Number(ds_main.NameValue(ds_main.RowPosition,"currPer")));
		 
		if(h_length.value.length > 12){
			ds_detail.RowPosition=j; 
			gr_detail.SetColumn("tranTaxAmt"); 
			alert("<%=source.getMessage("dev.msg.po.lengthLimit",columnData.getString("tran_tax_amt"))%>");
			return;
		}				 						
	}	
	
	var countChk=0;
	for(var t=1;t<=ds_approval.CountRow;t++){
		if(ds_approval.NameValue(t,"vendPerson")==""){
			ds_approval.RowPosition=t;
			gr_approval.SetColumn("vendPerson");
			alert("<%=source.getMessage("dev.warn.com.input",columnData.getString("charge"))%>");
			return;
		}	 
		if(ds_approval.NameValue(t,"emailAddr")==""){
			ds_approval.RowPosition=t;
			gr_approval.SetColumn("emailAddr");
			alert("<%=source.getMessage("dev.warn.com.input",columnData.getString("e_mail"))%>");
			return;
		}	 		
		if(ds_approval.NameValue(t,"mainYn")=="T"){
			countChk++;
		}					
	}
	if(ds_approval.CountRow>0){
		if(countChk!=1){
			alert("<%=source.getMessage("dev.warn.com.select",columnData.getString("main_cd"))%>");
			return;
		}	
	}
	//변경한 데이터가 있는지 체크한다.
	if(confirm("<%=source.getMessage("dev.cfm.com.save")%>")){         
	    g_flug=true;	    
		msg ="<%=source.getMessage("dev.suc.com.save")%>";	 
		
		f_setCondition();
		tr_cudMaster.Action   = "po.oc.cudPurchOrderReg.gau?poNo="+ds_main.NameValue(ds_main.RowPosition,"poNo");		
		tr_cudMaster.post();
	} 
	
}

//소수점 두번째에서 잘라주는 스크립트
	function _fix(v) {
	        v = Math.round(parseFloat(v) * 100).toString();
	        while (v.length < 3) v = "0" + v;
	        return  v.substring(0, v.length-2) + "." + v.substring(v.length-2, v.length);
	} 
	
	
/***************************************************************************************************/
/*추가/및 삭제
/***************************************************************************************************/
// Main Add
function f_addRowMain(){ 
	if(ds_detail.IsUpdated || ds_approval.IsUpdated){
		if(!g_flug){
			alert("<%=source.getMessage("dev.warn.com.continue")%>");
			return;
		}
	}
 
	if(ds_main.CountRow<1){
		var strHeader =  "chk"               +   ":STRING(1)"
						+",companyCd"        +   ":STRING(4)"
						+",poNo"             +   ":STRING(10)"
						+",purDeptCd"        +   ":STRING(4)"
						+",purDeptNm"        +   ":STRING(50)"
						+",vendCd"           +   ":STRING(20)"
						+",vendNm"           +   ":STRING(50)"
						+",currencyCd"       +   ":STRING(20)"
						+",currencyNm"       +   ":STRING(50)"
						+",currType"         +   ":STRING(50)"
						+",currPer"          +   ":STRING(50)"
						+",deliLoct"         +   ":STRING(4)"
						+",deliLoctNm"       +   ":STRING(50)"
						+",payTerm"          +   ":STRING(50)"
						+",payTermNm"        +   ":STRING(50)"
						+",deliDate"         +   ":STRING(8)"
						+",emailSendDate"    +   ":STRING(8)"
						+",parvw"            +   ":STRING(2)"
						+",pernr"            +   ":STRING(10)"
						+",ekorg"            +   ":STRING(4)"
						+",absgr"            +   ":STRING(2)"
						+",pstatus"          +   ":STRING(2)" 					
						+",transDate"        +   ":STRING(8)"
						+",transTime"        +   ":STRING(6)"
						+",progStatusDate"   +   ":STRING(8)"
						+",progStatusTime"   +   ":STRING(6)"
						+",sapPoNo"          +   ":STRING(10)"
						+",sapRtnMsg"        +   ":STRING(80)"
						+",regid"            +   ":STRING(100)"
						+",regdate"          +   ":STRING(8)"
						+",regtime"          +   ":STRING(6)"
						+",purGroup"         +   ":STRING(3)"
						+",plantCd"          +   ":STRING(4)"
						+",sapIfStatus"      +   ":STRING(2)" 
						+",minusdiscount_amt"+   ":DECIMAL(11.2)"
						+",discountAmt"      +   ":DECIMAL(11.2)"
						+",poType"           +   ":STRING(80)"//attr2
						+",prNo"             +   ":STRING(100)"
						+",refNo"            +   ":STRING(100)" 
						+",ivClose"          +   ":STRING(80)"
						+",poFirstKey"       +   ":STRING(80)";
		ds_main.SetDataHeader(strHeader);
    	cfHideNoDataMsg(gr_main);		
	}
	ds_main.AddRow();  
	ds_main.NameValue(ds_main.RowPosition,"purDeptCd"      )=ds_purDept.NameValue(ds_purDept.RowPosition,"code");
	ds_main.NameValue(ds_main.RowPosition,"payTerm"        )=""; 
	ds_main.NameValue(ds_main.RowPosition,"pstatus"         )="01";	  
	ds_main.NameValue(ds_main.RowPosition,"discountAmt"    )="0";
	ds_main.NameValue(ds_main.RowPosition,"ivClose"    )="N";
	f_gridEditMode(ds_main.RowPosition);	
	f_addRowDetail();
	gr_main.SetColumn("purDeptCd");
	
}

//main Delele
function f_delRowMain(){
	if(ds_main.CountRow<1){
		alert("<%=source.getMessage("dev.inf.com.nodelete")%>");
		return;
	}
	if(ds_main.NameValue(ds_main.RowPosition,"pstatus")!="01")
	{
		alert("<%=source.getMessage("dev.msg.po.podel")%>");
		return;
	}
	if(confirm("<%=source.getMessage("dev.cfm.com.delete")%>")){
		if(ds_detail.RowPosition>0)	{
			ds_detail.DeleteAll();
		}	
		if(ds_main.RowPosition>0)	{
			ds_main.DeleteRow(ds_main.RowPosition);
		}
	
        f_setCondition();   
	    g_flug=true;	   		
		tr_cudMaster.Action   = "po.oc.cudPurchOrderReg.gau?poNo="+ds_main.NameValue(ds_main.RowPosition,"poNo");				
		msg="<%=source.getMessage("dev.suc.com.delete")%>";
		tr_cudMaster.post();	
	}
}

//Detail Add
function f_addRowDetail(){
	if(ds_main.NameValue(ds_main.RowPosition,"pstatus")!="01"){
		alert("<%=source.getMessage("dev.msg.po.statusAdd")%>");
		return;
	}
	if(ds_main.CountRow>0){
		if(ds_detail.CountRow<1){
			var strHeader =  "chk"               +    ":STRING(1)"
							+",companyCd"        +    ":STRING(4)"
							+",poNo"             +    ":STRING(10)"
							+",poSeq"            +    ":STRING(5)"
							+",materCd"          +    ":STRING(18)"
							+",materNm"          +    ":STRING(50)"
							+",poDesc"           +    ":STRING(100)"
							+",qty"              +    ":DECIMAL(10.3)"
							+",unit"             +    ":STRING(20)"
							+",vatCd"            +    ":STRING(20)" 
							+",vatAmt"           +    ":DECIMAL(13.2)"
							+",price"            +    ":DECIMAL(15.4)"
							+",amount"           +    ":DECIMAL(15.2)"
							+",tranTaxRate"      +    ":DECIMAL(5.2)"
							+",tranTaxAmt"       +    ":DECIMAL(15.2)"
							+",currencyCd"       +    ":STRING(50)"
							+",currType"         +    ":STRING(50)"
							+",receiptQty"       +    ":STRING(50)"
							+",receiptClsYn"     +    ":STRING(50)"
							+",pricePer"         +    ":DECIMAL(14)";
			ds_detail.SetDataHeader(strHeader);
		}		 
		ds_detail.AddRow();  
		ds_detail.NameValue(ds_detail.RowPosition,"materCd"      )="";  
		ds_detail.NameValue(ds_detail.RowPosition,"unit"         )="";
		ds_detail.NameValue(ds_detail.RowPosition,"vatCd"        )="";
		if(ds_main.NameValue(ds_main.RowPosition,"poType")=="X"){
			ds_detail.NameValue(ds_detail.RowPosition,"receiptClsYn" )="N"; 
		}else{
			ds_detail.NameValue(ds_detail.RowPosition,"receiptClsYn" )="N"; 
		}
		gr_detail.SetColumn("materNm");		
	}
}
//Detail Del
function f_delRowDetail(){
	if(ds_detail.CountRow==1){
		alert("<%=source.getMessage("dev.msg.po.itemchk")%>");
	} 
	if(ds_detail.CountRow>1){
		ds_detail.DeleteRow(ds_detail.RowPosition);
	}  
}

// Vendor App Add
function f_addRowApp(){ 
	if(ds_main.CountRow==0){
		return;
	}
	if(ds_main.NameValue(ds_main.RowPosition,"vendCd")==""){
		alert("<%=source.getMessage("dev.msg.po.selet",columnData.getString("vend_cd"))%>");
		return;
	}
	
	if(ds_approval.CountRow<1){
		var strHeader = "chk"          + ":STRING(1)" 
						+",companyCd"  + ":STRING(4)"
						+",vendCd"     + ":STRING(50)"
						+",vendType"   + ":STRING(50)"						
						+",vendSeq"    + ":STRING(4)"
						+",vendPerson" + ":STRING(50)" 
						+",emailAddr"  + ":STRING(50)"
						+",telNo"      + ":STRING(20)"
						+",faxNo"      + ":STRING(20)"
						+",mainYn"     + ":STRING(1)"; 
			ds_approval.SetDataHeader(strHeader);
	}				
	ds_approval.AddRow();   
	ds_approval.NameValue(ds_approval.RowPosition,"vendCd"      )=ds_main.NameValue(ds_main.RowPosition,"vendCd"); 
	var arow =ds_gridVendor.NameValueRow("code",ds_main.NameValue(ds_main.RowPosition,"vendCd"));
	ds_approval.NameValue(ds_approval.RowPosition,"vendType")     = ds_gridVendor.NameValue(arow,"vendType");		
	ds_approval.NameValue(ds_approval.RowPosition,"mainYn"      ) ="F";   
}

// Vendor App del
function f_delRowApp(){
	if(ds_approval.CountRow<1){
		alert("<%=source.getMessage("dev.inf.com.nodelete")%>");
	}

	if(ds_approval.RowPosition>0){
		ds_approval.DeleteRow(ds_approval.RowPosition);
	} 
}

/***************************************************************************************************/
/*EX
/***************************************************************************************************/

// 전송 구분:01=>Sap전송,03=>Sap Cancel
function f_sapSend(){
 
	if(ds_main.NameValue(ds_main.RowPosition,"poNo")==""){
		alert("<%=source.getMessage("dev.msg.po.savecontinue")%>");
		return;
	}	 
	if((ds_main.IsUpdated) || ds_detail.IsUpdated || ds_approval.IsUpdated){
 		alert("<%=source.getMessage("dev.warn.com.continue")%>");
		return;			 
 
	} 
	if(ds_main.NameValue(ds_main.RowPosition,"pstatus")=="01"){
		if(!confirm("<%=source.getMessage("dev.msg.po.sapsend")%>")){
			return;
		}	

		ds_main.NameValue(ds_main.RowPosition,"pstatus")="02";
		ds_detail.UseChangeInfo="false";
		f_setCondition();
		ds_main.NameValue(ds_main.RowPosition,"minusdiscountAmt") = (-1 * Number(ds_main.NameValue(ds_main.RowPosition,"discountAmt")));				
		tr_cudMaster.Action   = "po.oc.cudPurchOrderRegSapSend.gau?";		
		msg="<%=source.getMessage("dev.msg.po.sapsucess")%>";
		g_flug="true";
		tr_cudMaster.post();		
	}else{
		alert("<%=source.getMessage("dev.msg.po.cantsend")%>");
		return;
	}
} 

// 전송 구분:01=>Sap전송,03=>Sap Cancel
function f_sapCancel(){
	
	if(ds_main.NameValue(ds_main.RowPosition,"poNo")==""){
		alert("<%=source.getMessage("dev.msg.po.savecontinue")%>");
		return;
	}	
	if((ds_main.IsUpdated) || ds_detail.IsUpdated || ds_approval.IsUpdated){
 		alert("<%=source.getMessage("dev.warn.com.continue")%>"); 
		return false;			 
 
	} 
	if(ds_main.NameValue(ds_main.RowPosition,"pstatus")=="03"){
		if(!confirm("<%=source.getMessage("dev.msg.po.sapcancelcontinue")%>")){
			return;
		}	
		ds_main.NameValue(ds_main.RowPosition,"pstatus")="04";
		ds_detail.UseChangeInfo="false"; 
		ds_main.NameValue(ds_main.RowPosition,"minusdiscountAmt") = Number(-1) * Number(ds_main.NameValue(ds_main.RowPosition,"discountAmt"));
		f_setCondition();
		g_flug="true";
		tr_cudMaster.Action   = "po.oc.cudPurchOrderRegSapSend.gau?";		
		msg="<%=source.getMessage("dev.msg.po.sapcancel")%>";
		tr_cudMaster.post();		
	}else{
		alert("<%=source.getMessage("dev.msg.po.cantsend")%>");
		return;
	}
} 

//Mail 전송
function f_mailSend(){   
	//if(ds_main.NameValue(ds_main.RowPosition,"pstatus")!="03"){
		//alert("<%=source.getMessage("dev.msg.po.transfer")%>");
		//return;
	//}
	
	if((ds_main.IsUpdated) || ds_detail.IsUpdated || ds_approval.IsUpdated){
 		alert("<%=source.getMessage("dev.warn.com.continue")%>");
		return;			 
 
	} 	
	if(ds_approval.CountRow==0){
		alert("<%=source.getMessage("dev.msg.po.sendlist")%>");
		return;
	}
	if(ds_approval.NameValue(1,"mainYn")=="F"){
		alert("<%=source.getMessage("dev.msg.po.savecontinue")%>");
		return;
	}	
	
	var j =0;
	for(var i=1;i<=ds_approval.CountRow;i++){ 
		if(ds_approval.NameValue(i,"chk")=="T"){
			j++;
			if(j>1){
				continue;
			}
		}
	} 
	
	if(j==0){
		alert("<%=source.getMessage("dev.msg.po.sendlist")%>");
		return;		 
   	}
	    //window.showModalDialog('jsp/po/oc/preView.jsp',window,"dialogWidth:850px,dialogHeight:558px,left=" + (screen.width/2 - 821/2)+ ",top=" + (screen.height/2 - 558/2) +",scrollbars=yes,menubar=0,status=0,toolbar=0,location=0,directories=0,resizable=0")
    	window.open("jsp/po/oc/purchOrderRegPreView.jsp?gubun=s","PreView","width=842,height=558,left=" + (screen.width/2 - 821/2)+ ",top=" + (screen.height/2 - 558/2) +",scrollbars=yes,menubar=0,status=0,toolbar=0,location=0,directories=0,resizable=0");   	
} 

//Print
function f_print(){ 
	//if(ds_main.NameValue(ds_main.RowPosition,"pstatus")!="03"){
	//	alert("<%=source.getMessage("dev.msg.po.transfer")%>");
	//	return;
	//}   
	if((ds_main.IsUpdated) || ds_detail.IsUpdated || ds_approval.IsUpdated){
 		alert("<%=source.getMessage("dev.warn.com.continue")%>");
		return;			 
 
	} 	
	
	f_report_set(); 
	re_report.Preview();    	
}

// Reflush이후  Row  원복
function f_setCondition(){
    g_msPos = ds_main.RowPosition;
    g_ddtPos = ds_detail.RowPosition;		
    g_appPos = ds_approval.RowPosition;
} 

function f_gridEditMode(_row){
	if(ds_main.NameValue(_row,"pstatus")=="01"){
		var arow =ds_currCd.NameValueRow("code",ds_main.NameValue(_row,"currencyCd"));
		ds_main.NameValue(_row,"currType") = ds_currCd.NameValue(arow,"attr1"); 
		ds_main.NameValue(_row,"currPer") = ds_currCd.NameValue(arow,"attr2");
 
 		if(ds_main.NameValue(_row,"currType")=="N"){
	 		gr_main.ColumnProp('discountAmt', 'Edit') = "Numeric";
	 		gr_main.ColumnProp('discountAmt', 'dec') = "0";
	 		ds_main.NameValue(_row,"discountAmt") = fnMathRound(ds_main.NameValue(_row,"discountAmt"),0,'T');
	 		
	 		gr_detail.ColumnProp('vatAmt',      'Edit')  = "Numeric";
	 		gr_detail.ColumnProp('price',       'Edit')  = "true";
	 		gr_detail.ColumnProp('amount',      'Edit')  = "Numeric";
	 		//2010.10.18. 강부장님 RATE는 open
	 		//gr_detail.ColumnProp('tranTaxRate', 'Edit')  = "Numeric";
	 		gr_detail.ColumnProp('tranTaxRate', 'Edit')  = "true";
	 		gr_detail.ColumnProp('tranTaxAmt',  'Edit')  = "Numeric";
	 		gr_detail.ColumnProp('vatAmt',       'dec')   = "0";
	 		gr_detail.ColumnProp('price',       'Decao')   = "4";
	 		gr_detail.ColumnProp('amount',      'dec')   = "0";
	 		//gr_detail.ColumnProp('tranTaxRate', 'dec')   = "0";
	 		gr_detail.ColumnProp('tranTaxRate', 'dec')   = "2";
	 		gr_detail.ColumnProp('tranTaxAmt',  'dec')   = "0";	 
	 		gr_detail.ColumnProp('sapPrice',    'dec')   = "4"; 	 				
	 		
	 		//gr_tax.ColumnProp('wtRate',         'Edit')  = "Numeric";
	 		//2010.10.18. 강부장님 RATE는 open 
	 		gr_tax.ColumnProp('wtRate',         'Edit')  = "true";
	 		gr_tax.ColumnProp('wtCd',           'Edit')  = "true";
	 		gr_tax.ColumnProp('wtBaseAmt',      'Edit')  = "Numeric";
	 		gr_tax.ColumnProp('wtTaxAmt',       'Edit')  = "Numeric"; 
	 		
	 		//gr_tax.ColumnProp('wtRate',         'dec')   = "0";
	 		gr_tax.ColumnProp('wtRate',         'dec')   = "2";
	 		gr_tax.ColumnProp('wtBaseAmt',      'dec')   = "0";
	 		gr_tax.ColumnProp('wtTaxAmt',       'dec')   = "0";			
	 		
	 		gr_total.ColumnProp('value1',       'dec')   = "0";	 
	 		gr_total.ColumnProp('value2',       'dec')   = "0";	 
	 		gr_total.ColumnProp('value3',       'dec')   = "0";	 	
			for(var j=1; j<= ds_detail.CountRow;j++){		 
				ds_detail.NameValue(j,"currType") = ds_currCd.NameValue(arow,"attr1"); 
	 		} 
 		}else{
 			gr_main.ColumnProp('discountAmt', 'Edit') = "true";
 			gr_main.ColumnProp('discountAmt', 'dec') = "2";
 			
 			gr_detail.ColumnProp('vatAmt',       'Edit')  = "true";
	 		gr_detail.ColumnProp('price',       'Edit')  = "true";
	 		gr_detail.ColumnProp('amount',      'Edit')  = "true";
	 		gr_detail.ColumnProp('tranTaxRate', 'Edit')  = "true";
	 		gr_detail.ColumnProp('tranTaxAmt',  'Edit')  = "true";
	 		gr_detail.ColumnProp('vatAmt',       'Dec')   = "2";
	 		gr_detail.ColumnProp('price',       'Decao')   = "4";
	 		gr_detail.ColumnProp('amount',      'dec')   = "2";
	 		gr_detail.ColumnProp('tranTaxRate', 'dec')   = "2";
	 		gr_detail.ColumnProp('tranTaxAmt',  'dec')   = "2";	
	 		gr_detail.ColumnProp('sapPrice',    'dec')   = "4"; 
 			
	 		gr_tax.ColumnProp('wtRate',         'Edit')  = "true";
	 		gr_tax.ColumnProp('wtCd',           'Edit')  = "true";
	 		gr_tax.ColumnProp('wtBaseAmt',      'Edit')  = "true";
	 		gr_tax.ColumnProp('wtTaxAmt',       'Edit')  = "true"; 
	 		gr_tax.ColumnProp('wtRate',         'dec')   = "2";
	 		gr_tax.ColumnProp('wtBaseAmt',      'dec')   = "2";
	 		gr_tax.ColumnProp('wtTaxAmt',       'dec')   = "2";
	 		
	 		gr_total.ColumnProp('value1',       'dec')   = "3";	 
	 		gr_total.ColumnProp('value2',       'dec')   = "3";	 
	 		gr_total.ColumnProp('value3',       'dec')   = "3";		 		
			for(var j=1; j<= ds_detail.CountRow;j++){		 
				ds_detail.NameValue(j,"currType") = ds_currCd.NameValue(arow,"attr1"); 
	 		} 
 		}	
	}else{ 
		var arow =ds_currCd.NameValueRow("code",ds_main.NameValue(_row,"currencyCd"));
		ds_main.NameValue(_row,"currType") = ds_currCd.NameValue(arow,"attr1"); 
		ds_main.NameValue(_row,"currPer") = ds_currCd.NameValue(arow,"attr2");
 
 		if(ds_main.NameValue(_row,"currType")=="N"){ 
	 		gr_main.ColumnProp('discountAmt', 'dec') = "0";
	 		ds_main.NameValue(_row,"discountAmt") = fnMathRound(ds_main.NameValue(_row,"discountAmt"),0,'T');
	 		 
	 		//2010.10.18. 강부장님 RATE는 open 
	 		gr_detail.ColumnProp('vatAmt',       'dec')   = "0";
	 		gr_detail.ColumnProp('price',       'Decao')   = "4";
	 		gr_detail.ColumnProp('amount',      'dec')   = "0";
	 		//gr_detail.ColumnProp('tranTaxRate', 'dec')   = "0";
	 		gr_detail.ColumnProp('tranTaxRate', 'dec')   = "2";
	 		gr_detail.ColumnProp('tranTaxAmt',  'dec')   = "0";	 
	 		gr_detail.ColumnProp('sapPrice',    'dec')   = "4"; 	 				
	 		 
	 		//2010.10.18. 강부장님 RATE는 open  
	 		
	 		//gr_tax.ColumnProp('wtRate',         'dec')   = "0";
	 		gr_tax.ColumnProp('wtRate',         'dec')   = "2";
	 		gr_tax.ColumnProp('wtBaseAmt',      'dec')   = "0";
	 		gr_tax.ColumnProp('wtTaxAmt',       'dec')   = "0";			
	 		gr_tax.ColumnProp('wtCd',           'Edit')  = "true";
	 	
	 		gr_total.ColumnProp('value1',       'dec')   = "0";	 
	 		gr_total.ColumnProp('value2',       'dec')   = "0";	 
	 		gr_total.ColumnProp('value3',       'dec')   = "0";	 	
			for(var j=1; j<= ds_detail.CountRow;j++){		 
				ds_detail.NameValue(j,"currType") = ds_currCd.NameValue(arow,"attr1"); 
	 		} 
 		}else{ 
 			gr_main.ColumnProp('discountAmt', 'dec') = "2"; 
	 		gr_detail.ColumnProp('vatAmt',       'Dec')   = "2";
	 		gr_detail.ColumnProp('price',       'Decao')   = "4";
	 		gr_detail.ColumnProp('amount',      'dec')   = "2";
	 		gr_detail.ColumnProp('tranTaxRate', 'dec')   = "2";
	 		gr_detail.ColumnProp('tranTaxAmt',  'dec')   = "2";	
	 		gr_detail.ColumnProp('sapPrice',    'dec')   = "4"; 
 			 
	 		gr_tax.ColumnProp('wtRate',         'dec')   = "2";
	 		gr_tax.ColumnProp('wtBaseAmt',      'dec')   = "2";
	 		gr_tax.ColumnProp('wtTaxAmt',       'dec')   = "2";
	 		gr_tax.ColumnProp('wtCd',           'Edit')  = "true";
	 			 	
	 		gr_total.ColumnProp('value1',       'dec')   = "3";	 
	 		gr_total.ColumnProp('value2',       'dec')   = "3";	 
	 		gr_total.ColumnProp('value3',       'dec')   = "3";		 		
			for(var j=1; j<= ds_detail.CountRow;j++){		 
				ds_detail.NameValue(j,"currType") = ds_currCd.NameValue(arow,"attr1"); 
	 		} 
 		}	
	}	
	
	// 2015.2.13 hskim CSR:C20150213_06194
	//	if(ds_main.NameValue(_row,"pstatus")=="01" && ds_main.NameValue(_row,"currencyCd")=="IDR"){ 
	if(ds_main.NameValue(_row,"pstatus")=="01"){ 
		gr_tax.Editable="true"; 
	}else{
		gr_tax.Editable="false";
	}

}

function f_report_set(){
	var strHeader =  "addr1"             +    ":STRING(100)"
					+",addr2"            +    ":STRING(100)"
					+",addr3"            +    ":STRING(100)"
					+",addr4"            +    ":STRING(100)"
					+",addr5"            +    ":STRING(100)"
					+",addr6"            +    ":STRING(100)"
					+",vendNm"           +    ":STRING(100)"
					+",poNo"             +    ":STRING(100)"
					+",prNo"             +    ":STRING(100)"
					+",createDate"       +    ":STRING(100)"
					+",refNo"            +    ":STRING(100)"					 
					+",subTot"           +    ":STRING(100)"		
					+",discount"         +    ":STRING(100)"		
					+",tot"              +    ":STRING(100)"		
					+",tax"              +    ":STRING(100)"		
					+",vat"              +    ":STRING(100)"											
					+",taxAmount"        +    ":STRING(100)"		
					+",gTot"             +    ":STRING(100)";		
	ds_report_main.SetDataHeader(strHeader);			
	ds_report_main.AddRow();
	ds_report_main.NameValue(ds_report_main.RowPosition,"addr1")       = ds_main.NameValue(ds_main.RowPosition,"purDept1");
	ds_report_main.NameValue(ds_report_main.RowPosition,"addr2")       = ds_main.NameValue(ds_main.RowPosition,"purDept2");
	ds_report_main.NameValue(ds_report_main.RowPosition,"addr3")       = ds_main.NameValue(ds_main.RowPosition,"purDept3");		
	ds_report_main.NameValue(ds_report_main.RowPosition,"addr4")       = ds_main.NameValue(ds_main.RowPosition,"purDept4");
	ds_report_main.NameValue(ds_report_main.RowPosition,"addr5")       = ds_main.NameValue(ds_main.RowPosition,"purDept5");
	ds_report_main.NameValue(ds_report_main.RowPosition,"addr6")       = ds_main.NameValue(ds_main.RowPosition,"purDept6");
	ds_report_main.NameValue(ds_report_main.RowPosition,"vendNm")      = ds_main.NameValue(ds_main.RowPosition,"vendNm");
	ds_report_main.NameValue(ds_report_main.RowPosition,"poNo")        = ds_main.NameValue(ds_main.RowPosition,"poNo");
	ds_report_main.NameValue(ds_report_main.RowPosition,"prNo")        = ds_main.NameValue(ds_main.RowPosition,"prNo");
	ds_report_main.NameValue(ds_report_main.RowPosition,"createDate")  = ds_main.NameValue(ds_main.RowPosition,"insertSDate");
	ds_report_main.NameValue(ds_report_main.RowPosition,"refNo")       = ds_main.NameValue(ds_main.RowPosition,"refNo");
	
	var strSubTot = 0;
	var strTot = 0;
	var strTaxTot = 0;		
	var strVatTot = 0;	
	var strTaxAmount = ds_tax.NameValue(ds_tax.RowPosition,"wtTaxAmt");	
	var strGTot = 0;
	for(var j=1;j<=ds_detail.CountRow;j++){
		strSubTot = Number(strSubTot) + Number(ds_detail.NameValue(j,"amount"));
		strVatTot = Number(strVatTot) + Number(ds_detail.NameValue(j,"vatAmt"));
		strTaxTot = Number(strTaxTot) + Number(ds_detail.NameValue(j,"tranTaxAmt"));		
	}
	strTot = Number(strSubTot) - Number(ds_main.NameValue(ds_main.RowPosition,"discountAmt")); 
	ds_report_main.NameValue(ds_report_main.RowPosition,"subTot")      = setComma(strSubTot)=="0" ? "-" : setComma(strSubTot);
	ds_report_main.NameValue(ds_report_main.RowPosition,"discount")    = setComma(ds_main.NameValue(ds_main.RowPosition,"discountAmt"))=="0" ? "-" : setComma(ds_main.NameValue(ds_main.RowPosition,"discountAmt"));
	ds_report_main.NameValue(ds_report_main.RowPosition,"tot")         = setComma(strTot)=="0" ? "-" : setComma(strTot);
	ds_report_main.NameValue(ds_report_main.RowPosition,"tax")         = setComma(strTaxTot)=="0" ? "-" : setComma(strTaxTot);
	ds_report_main.NameValue(ds_report_main.RowPosition,"vat")         = setComma(strVatTot)=="0" ? "-" : setComma(strVatTot);
	ds_report_main.NameValue(ds_report_main.RowPosition,"taxAmount")   = setComma(strTaxAmount)=="0" ? "-" : setComma(strTaxAmount);
	ds_report_main.NameValue(ds_report_main.RowPosition,"gTot")        = setComma(Number(strTot)+Number(strTaxTot)+Number(strVatTot)+Number(strTaxAmount))=="0" ? "-" : setComma(Number(strTot)+Number(strTaxTot)+Number(strVatTot)+Number(strTaxAmount));

			
	var strdHeader =  "seqNo"            +    ":STRING(100)"
					+",partNo"           +    ":STRING(100)"
					+",desc"             +    ":STRING(100)"
					+",qty"              +    ":STRING(100)"
					+",priceDec"         +    ":STRING(100)"
					+",unit"             +    ":STRING(100)"
					+",unitPrice"        +    ":STRING(100)"
					+",amount"           +    ":STRING(100)";
				
	ds_report_dtl.SetDataHeader(strdHeader);
	for(var i=1;i<=ds_detail.CountRow;i++){ 
		ds_report_dtl.AddRow();		
		ds_report_dtl.NameValue(ds_report_dtl.RowPosition,"seqNo")       = i;
		ds_report_dtl.NameValue(ds_report_dtl.RowPosition,"partNo")      = ds_detail.NameValue(i,"materCd");
		ds_report_dtl.NameValue(ds_report_dtl.RowPosition,"desc")        = ds_detail.NameValue(i,"materNm");
		ds_report_dtl.NameValue(ds_report_dtl.RowPosition,"qty")         = setComma(ds_detail.NameValue(i,"qty"));
		if(ds_detail.NameValue(i,"currencyCd")=="MMK"){
			ds_report_dtl.NameValue(ds_report_dtl.RowPosition,"priceDec")    = "MMK";
		}else if(ds_detail.NameValue(i,"currencyCd")=="USD"){
			ds_report_dtl.NameValue(ds_report_dtl.RowPosition,"priceDec")    = "USD";
		}else{
			ds_report_dtl.NameValue(ds_report_dtl.RowPosition,"priceDec")    = "";
		}
		if(ds_detail.NameValue(i,"unit")=="L"){
			ds_report_dtl.NameValue(ds_report_dtl.RowPosition,"unit")        = "liter";
		}else{
			ds_report_dtl.NameValue(ds_report_dtl.RowPosition,"unit")        = ds_detail.NameValue(i,"unit");
		}
		
		ds_report_dtl.NameValue(ds_report_dtl.RowPosition,"unitPrice")   = setComma(ds_detail.NameValue(i,"price"));
		ds_report_dtl.NameValue(ds_report_dtl.RowPosition,"amount")      = setComma(ds_detail.NameValue(i,"amount"));		
	}						
    
    for(var t=1; t<=13; t++){
		ds_report_dtl.AddRow();
	}
	
	for(var s=ds_report_dtl.CountRow; s>14; s--){
		ds_report_dtl.DeleteRow(s);
	}	
}
</script>
<!-----------------------------------------------------------------------------
T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- CUD TR -->
<!-- Payment Arrange CUD TR -->
<OBJECT id=tr_cudMaster classid="<%=LGauceId.TR%>">
	<param name="KeyName"   value="toinb_dataid4"> 
	<param name="KeyValue"  value="JSP(I:ds_main=ds_main,I:ds_detail=ds_detail,I:ds_tax=ds_tax,I:ds_approval=ds_approval)">
	<param name="ServerIP"  value=""> 
</OBJECT>
 
<!-----------------------------------------------------------------------------
D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
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

<!-- Grid 용 DataSet-->
<object id="ds_approval" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true">
	<param name="ViewDeletedRow"    value="false">
</object>
 
<!-- lx Combo 용 DataSet-->
<object id="ds_poStatus" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true"> 
</object>

<!-- lx Combo 용 DataSet-->
<object id="ds_status" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true"> 
</object>

<!-- lx Combo 용 DataSet-->
<object id="ds_purDept" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true"> 
</object>

<!-- lx Combo 용 DataSet-->
<object id="ds_gridPurDept" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true"> 
</object>

<!-- lx Combo 용 DataSet-->
<object id="ds_deliLoct" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true"> 
</object>

<!-- lx Combo 용 DataSet-->
<object id="ds_payTerm" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true"> 
</object>

<!-- lx Combo 용 DataSet-->
<object id="ds_currCd" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true"> 
</object>
 
<object id="ds_useYn" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true">
</object>

<object id="ds_mater" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true">
</object>

<object id="ds_vatCd" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true">
</object>

<object id="ds_gridVendor" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true">
</object>

<object id="ds_vendor" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true">
</object>
 
<object id="ds_receiptClsYn" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true">
</object>

<object id="ds_ivClsYn" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true">
</object>

<!-- Grid 용 DataSet-->
<object id="ds_return" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true">
	<param name="ViewDeletedRow"    value="false">
</object>

<!-- Grid 용 DataSet-->
<object id="ds_tax" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true">
	<param name="ViewDeletedRow"    value="false">
</object>
<!-- Grid 용 DataSet-->
<object id="ds_taxType" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true">
	<param name="ViewDeletedRow"    value="false">
</object>
 
<object id="ds_total" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true">
	<param name="ViewDeletedRow"    value="false">
</object> 

<object id="ds_report_main" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true">
	<param name="ViewDeletedRow"    value="false">
</object> 

<object id="ds_report_dtl" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true">
	<param name="ViewDeletedRow"    value="false">
</object> 

<object id="ds_poType" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true">
	<param name="ViewDeletedRow"    value="false">
</object> 
  
<!-----------------------------------------------------------------------------
Dataset   E V E N T S
------------------------------------------------------------------------------>
<script language=JavaScript for=ds_main event=OnLoadStarted()>
  cfShowDSWaitMsg(gr_main);//progress bar 보이기
  cfHideNoDataMsg(gr_main);//no data 메시지 숨기기
</script>

<!-- Hub In Header 조회 DataSet -->
<script language=JavaScript for=ds_main event=OnLoadCompleted(rowCnt)>
  cfHideDSWaitMsg(gr_main);//progress bar 숨기기
  cfFillGridNoDataMsg(gr_main,"gridColLineCnt=2");//no data found   
</script> 

<script language=JavaScript for=ds_main event=CanRowPosChange(row)> 
	if(ds_main.IsUpdated ||ds_detail.IsUpdated|| ds_tax.IsUpdated || ds_approval.IsUpdated){
		if(!g_flug){	 
			alert("<%=source.getMessage("dev.warn.com.continue")%>");
			return false;			 
		}
	}  
</script>

<script language=JavaScript for="ds_main" event=OnRowPosChanged(row)>
	ds_detail.ClearAll();
	ds_approval.ClearAll();
	if(row>0){
		f_retrieveDtl();
		f_retrieveApp();
		f_gridEditMode(row); 
		f_wtList(ds_main.NameValue(row,"poNo"));			
		f_caculation();	 

		ds_detail.ResetStatus();		
	}else{
		gr_tax.Editable="false";
	}
</script>

<script language=JavaScript for=ds_detail event=OnLoadCompleted(rowCnt)>
	for(var i=1; i<= ds_detail.CountRow;i++){		
		ds_detail.NameValue(i,'currencyCd') = ds_main.NameValue(ds_main.RowPosition,"currencyCd");  
	}		
	ds_detail.ResetStatus();
</script> 

<script language=JavaScript for="ds_detail" event=OnRowPosChanged(row)>  
	if(ds_main.NameValue(ds_main.RowPosition,"pstatus")=="01"){
		gr_detail.ColumnProp('materNm', 'Edit') = "true";
		gr_detail.ColumnProp('qty', 'Edit') = "true";
		gr_detail.ColumnProp('vatCd', 'Edit') = "true";
		gr_detail.ColumnProp('price', 'Edit') = "true";
		gr_detail.ColumnProp('poDesc', 'Edit') = "true"; 
		gr_detail.ColumnProp('vatAmt', 'Edit') = "true";
		gr_detail.ColumnProp('tranTaxRate', 'Edit') = "true";
		gr_detail.ColumnProp('tranTaxAmt', 'Edit') = "true";
		gr_detail.ColumnProp('poDesc', 'Edit') = "true";
		

		var arow =ds_currCd.NameValueRow("code",ds_main.NameValue(ds_main.RowPosition,"currencyCd"));
		ds_main.NameValue(ds_main.RowPosition,"currType") = ds_currCd.NameValue(arow,"attr1"); 
 		if(ds_main.NameValue(ds_main.RowPosition,"currType")=="N"){
	 		gr_detail.ColumnProp('price', 'Edit') = "true";
	 		gr_total.ColumnProp('value1', 'dec') = "0";		
	 		gr_total.ColumnProp('value2', 'dec') = "0";
	 		gr_total.ColumnProp('value3', 'dec') = "0";
			 
 		}else{
 			gr_detail.ColumnProp('price', 'Edit') = "true";
	 		gr_total.ColumnProp('value1', 'dec') = "3";		
	 		gr_total.ColumnProp('value2', 'dec') = "3";
	 		gr_total.ColumnProp('value3', 'dec') = "3"; 			 		
 		}	
	}else{
		gr_detail.ColumnProp('materNm', 'Edit') = "none";
		gr_detail.ColumnProp('amount', 'Edit') = "none";
		gr_detail.ColumnProp('qty', 'Edit') = "none";
		gr_detail.ColumnProp('vatCd', 'Edit') = "none";
		gr_detail.ColumnProp('price', 'Edit') = "none";
		gr_detail.ColumnProp('poDesc','Edit') = "none"; 
		gr_detail.ColumnProp('vatAmt', 'Edit') = "none";
		gr_detail.ColumnProp('tranTaxRate', 'Edit') = "none";
		gr_detail.ColumnProp('tranTaxAmt', 'Edit') = "none";
		gr_detail.ColumnProp('poDesc', 'Edit') = "none";		
	} 
</script>

<!-----------------------------------------------------------------------------
Grid   E V E N T S
------------------------------------------------------------------------------>
<!-- Main-------------------------------------------------------------------------------------->
<script language=JavaScript for=gr_main event=OnCloseUp(row,colid)>
	if(colid=="vendCd"){
		var strvendCd = ds_main.NameValue(row,"vendCd");  
		var v_url = new cfURI();
		v_url.Add("vendCd",strvendCd); 
		v_url.SetPage("po.oc.retrievePurchOrderRegAppList.gau");
		ds_approval.DataId = v_url.GetURI();
		ds_approval.Reset(); 	
		
	} 
	if(colid=="currencyCd"){
		f_gridEditMode(row);
		//ds_detail.ResetStatus();
		if(ds_main.NameValue(row,"currencyCd")!="IDR"){
			f_wtList("");
		}else{
			f_wtList(ds_main.NameValue(row,"poNo"));
		}
	} 	
	
	if(colid=="poType"){
		var arow =ds_return.NameValueRow("code",ds_main.NameValue(row,"poType"));
		gr_detail.Redraw="false";
		for(var i=1; i<=ds_detail.CountRow;i++){
			if(ds_return.NameValue(arow,"code")=="X"){

				ds_detail.NameValue(i,"receiptClsYn")= "N";	
			}else{

				ds_detail.NameValue(i,"receiptClsYn")= "N";	
			} 
		} 
		gr_detail.Redraw="true";
	} 	 			
</script>

<script language=JavaScript for=gr_main event=CanColumnPosChange(row,colid)>
	if(colid=="discountAmt" ){
		if(Number(ds_main.NameValue(row,colid)) < 0){
			alert("<%=source.getMessage("dev.warn.com.minus",columnData.getString("discount_amp"))%>");
			return false;
		}
	}
</script>

<script language=JavaScript for=gr_main event=OnPopup(row,colid,data)>
 	if ( colid == "deliDate") {
	 	h_date.value ="";
		gf_calendarExClean(h_date); 
		ds_main.NameValue(row,"deliDate") =funcReplaceStrAll(h_date.value,"/","");	 	
	}	
</script> 

<script language=JavaScript for=gr_main event=OnKeyUp(row,colid,keycode)>
	if(colid=="discountAmt"){
		f_caculation();
	}
</script> 

<!-- detail-------------------------------------------------------------------------------------->

<script language=JavaScript for=gr_detail event=OnPopup(row,colid,data)>
 	if ( colid == "materNm") {
		openMaterialCodeListGridConWin(row, ds_detail,"PO");
	}
</script> 

<script language=JavaScript for=gr_detail event=OnCloseUp(row,colid)>
	if(colid=="vatCd"){
		var arow =ds_vatCd.NameValueRow("code",ds_detail.NameValue(row,"vatCd"));
		ds_detail.NameValue(row,"vatNm") = ds_vatCd.NameValue(arow,"name"); 
		//f_caculation();
	} 	 
	
</script>

<script language=JavaScript for=gr_detail event=CanColumnPosChange(row,colid)>
	if(colid=="qty"){
		if(Number(ds_detail.NameValue(row,colid)) < 0){
			alert("<%=source.getMessage("dev.warn.com.minus",columnData.getString("qty"))%>");
			return false;
		}
	}		
	if(colid=="price"){
		if(Number(ds_detail.NameValue(row,colid)) < 0){
			alert("<%=source.getMessage("dev.warn.com.minus",columnData.getString("price"))%>");
			return false;
		}
	}		
</script>

<script language=JavaScript for=gr_detail event=OnKeyUp(row,colid,keycode) >
	if(colid=="amount" || colid=="vatAmt"|| colid=="tranTaxAmt"){
		f_caculation();
	} 
</script>   
 

<script language=JavaScript for=gr_tax event=OnKeyUp(row,colid,keycode) >
	if(colid=="wtTaxAmt"){
		f_caculation();
	} 
</script>     

<script language=JavaScript for=ds_detail event=OnColumnChanged(row,colid)>
	if(colid=="amount" || colid=="vatAmt"|| colid=="tranTaxAmt"){
		f_caculation();
	} 
</script>

<script language=JavaScript for=ds_tax event=OnColumnChanged(row,colid)>
	if(colid=="wtTaxAmt"){
		f_caculation();
	} 
</script>
<!-- Vendor approval-------------------------------------------------------------------------------------->

<script language=JavaScript for=gr_approval event=OnClick(row,colid)>
	if(colid=="mainYn"){ 
		for(var i=1;i<=ds_approval.CountRow;i++){
			ds_approval.NameValue(i,"mainYn") ="F";
		}
		ds_approval.NameValue(row,"mainYn") ="T";
		ds_approval.NameValue(row,"chk") ="T";
		
	}
</script>
<!-----------------------------------------------------------------------------
Tr   E V E N T S
------------------------------------------------------------------------------>

<script language=JavaScript for=tr_cudMaster event=OnFail()>
	mode = ""; 
    ds_detail.UseChangeInfo="true"; 
	if(tr_cudMaster.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
		window.parent.location.href = "/index.jsp";    
	}
	g_flug=false;  
	f_retrieve();
    ds_main.RowPosition    = g_msPos;
    ds_detail.RowPosition  = g_ddtPos;	
	gr_main.SetColumn("purDeptCd");
	gr_detail.SetColumn("materNm");   
	alert(tr_cudMaster.ErrorMsg);
</script>

<script language=JavaScript for=tr_cudMaster event=OnSuccess()>
	g_flug=false;  	
	ds_detail.UseChangeInfo="true"; 
	f_retrieve();
    ds_main.RowPosition    = g_msPos;
    ds_detail.RowPosition  = g_ddtPos;		
	gr_main.SetColumn("purDeptCd");
	gr_detail.SetColumn("materNm");    	
	alert(msg);
</script>  
 
</head>

<body id="cent_bg" onload="init();">
<div id="conts_box">
	<h2> <span> <%=columnData.getString("page_title") %> </span></h2>
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
							<th>P/O Create Date </th>
							<td><input type="text" onblur="valiDate(this);" style="width:70px;" id="fromDate" value="<%= prevDate %>" />
								<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="" onclick="javascript:OpenCalendar(fromDate);" class="button_cal"/>
								~
								<input type="text" onblur="valiDate(this);" style="width:70px;" id="toDate" value="<%= currentDate %>" />
								<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="" onclick="javascript:OpenCalendar(toDate);" class="button_cal"/>
							</td> 
							<comment id="__NSID__"><object id="lc_purDept"  classid="<%=LGauceId.LUXECOMBO%>" width="180" style='display:none'>
								<param name="ComboDataID"       value="ds_purDept">
								<param name="ListCount"     	value="10">
								<param name=SearchColumn		value="name">
								<param name="BindColumn"    	value="code">
								<param name=ListExprFormat		value="name^0^180,code^0^70"> 
								<param name=index           	value=0>
								<param name=Enable           	value="true">
								</object></comment><script>__WS__(__NSID__); </script>
							<th><%=columnData.getString("vend_cd") %> </th>		
							<td><comment id="__NSID__"><object id="lc_vendor"  classid="<%=LGauceId.LUXECOMBO%>" width="150">
								<param name="ComboDataID"       value="ds_vendor">
								<param name="ListCount"     	value="10">
								<param name=SearchColumn		value="name">
								<param name="BindColumn"    	value="code">
								<param name=ListExprFormat		value="name^0^150,code^0^70"> 
								<param name=index           	value=0>
								</object></comment><script>__WS__(__NSID__); </script>
							</td>						
						</tr>
						<tr>
							<th><%=columnData.getString("status") %> </th>
							<td clospan="3"><comment id="__NSID__"><object id="lc_postatus"  classid="<%=LGauceId.LUXECOMBO%>" width="150">
								<param name="ComboDataID"       value="ds_poStatus">
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
				<dd class="btnseat2"> 
					<span class="search_btn2_r search_btn2_l">
					<input type="button" onfocus="blur();" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='#e2ebf7'" value="<%=btnSearch%>" onclick="f_retrieve();"/></span> 
				</dd>											
			</dl>
		</div>
	</fieldset>
	<!--검색 E -->		

	<div class="sub_stitle"> 
		<p> <%=columnData.getString("sub1_title") %> </p>
		<p class="rightbtn">		  
			<span class="sbtn_r sbtn_l"> 
			<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="<%=btnPrint %>" onclick="f_print();"/></span>  	 
		</p>			
	</div>    
	<!-- 그리드 S -->
		<div>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<comment id="__NSID__">
						<object id="gr_main" classid="<%=LGauceId.GRID %>" style="width:100%;height:136px;" class="comn">
							<param name="DataID"            value="ds_main"/> 
							<param name="Editable"          value="true"/>
							<Param name="AutoResizing"      value=true>
							<param name="TitleHeight"          value="35"/>
							<param name="UrlImages"         value="<I>Type='PopupBotton', Url='/sys/images/button/search_icon_2.gif', Fit='AutoFit', Flat='True'</I>">
							<param name="Format"            
							value="
							<FC>id='poNo'          name='WEB P/O No.'              width='90'  align='center'  edit='none'                                  </FC>
							<C>id='purDeptCd'      name='<%=columnData.getString("pur_dept_cd") %>'      show='false'  width='60'  align='center'   edit={IF(pstatus='01','true','false')}       Data='ds_gridpurDept:code:name:code' editstyle='lookup' ListWidth=200   </C>                  
							                  
							<C>id='prNo'           name='P/O No.(Manual)'              width='130'  align='left' edit={IF(pstatus='01','true','false')}
							<C>id='refNo'          name='<%=columnData.getString("ref_no") %>'             width='130'  align='left' edit={IF(pstatus='01','true','false')} 																												
							<C>id='vendCd'         name='<%=columnData.getString("vend_cd") %>'            width='170'  align='left'   edit={IF(pstatus='01','true','false')}       Data='ds_gridVendor:code:name:code' editstyle='lookup' ListWidth=200   </C>                  
							<C>id='absgr'          name='P/O Type'            width='80'  align='left'   edit={IF(pstatus='01','true','false')}       Data='ds_poType:code:name:code' editstyle='lookup' ListWidth=200   </C>
							<C>id='deliLoct'       name='<%=columnData.getString("deli_loct") %>'          width='80'  align='left'   edit={IF(pstatus='01','true','false')}       Data='ds_deliLoct:code:name:code' editstyle='lookup' ListWidth=200 </C>
							
							<C>id='deliDate'       name='<%=columnData.getString("deli_date") %>'          width='80'  align='center' edit={IF(pstatus='01','true','false')}       editstyle='Popup' mask='XXXX/XX/XX'  </C>
							<C>id='emailSendDate'  name='<%=columnData.getString("email_send_date") %>'    show='false' width='76'  align='center' edit='none'                                  mask='XXXX/XX/XX'  </C>							
							<C>id='currencyCd'     name='<%=columnData.getString("currency_cd") %>'        width='70'  align='center' edit={IF(pstatus='01','true','false')}       Data='ds_currCd:code:name:code'  editstyle='lookup' ListWidth=200</C>							
							<C>id='payTerm'        name='<%=columnData.getString("pay_term") %>'           width='110'  align='center' edit={IF(pstatus='01','true','false')}       Data='ds_payTerm:code:name:code' editstyle='lookup' ListWidth=200</C>		
							<C>id='discountAmt'    name='<%=columnData.getString("discount_amp") %>'       width='130'  align='right'  edit={IF(pstatus='01','true','false')}       </C>												
							
							<C>id='poType'         name='Return P/O'            show='true' width='70'  align='center'  edit={IF(pstatus='01','true','false')}       Data='ds_return:code:name:code' editstyle='lookup' ListWidth=80   </C>
							<C>id='regdate'        name='P/O Create;Date'           width='100'  align='center' edit='none'                                  mask='XXXX/XX/XX'  </C>
							<C>id='sapPoNo'        name='<%=columnData.getString("sap_po_no") %>'          width='80'  align='center' edit='none'                                  </C>
							<C>id='pstatus'        name='<%=columnData.getString("status") %>'             width='120'  align='center' edit='none'                                  Data='ds_status:code:name:code' editstyle='lookup' ListWidth=200</C>	
	                        <C>id='ivClose'        name='<%=columnData.getString("iv_close") %>'           show='false' width='40'   align='center' edit='none' EditStyle=Lookup  data='ds_ivClsYn:code:name:code'     </C>
	                        <C>id='sapRtnMsg'      name='<%=columnData.getString("sap_rtn_msg") %>'        width='400'  align='left'   edit='none'                                  </C> 					"/>
						</object>
						</comment><script>__WS__(__NSID__);</script>
					</td>
				</tr>
			</table>
		</div>

		<!-- 그리드 E -->
	    <div class="sub_stitle"> <p>P/O Material</p>
			<p class="rightbtn">
			    <span class="sbtn_r sbtn_l">
				<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="<%=btnAddRow%>" onclick="f_addRowDetail();"/></span> 
				<span class="sbtn_r sbtn_l"> 
				<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="<%=btnDelRow%>" onclick="f_delRowDetail();"/></span>  	 
			</p>
		</div>	
		<div>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<comment id="__NSID__">
						<object id="gr_detail" classid="<%=LGauceId.GRID %>" style="width:100%;height:130px;" class="comn">
							<param name="DataID"            value="ds_detail"/> 
							<param name="Editable"          value="true"/> 
							<Param name="AutoResizing"      value=true>
							<param name="ColSizing"         value=true>
							<Param name="DragDropEnable"    value=True>
							<param name="UrlImages"         value="<I>Type='PopupBotton', Url='/sys/images/button/search_icon_2.gif', Fit='AutoFit', Flat='True'</I>">	
							<param name="Format"              
							value="
							<FC>id='poSeq'          name='<%=columnData.getString("po_seq") %>'            width='42' align='center'    edit='none'   </FC>							            
							<C>id='materNm'         name='<%=columnData.getString("mater_cd") %>'          width='220' align='left'      editstyle='popupfix'  </C>
							<C>id='unit'            name='<%=columnData.getString("unit") %>'              width='30' align='center'    edit='none'   </C>
							<C>id='qty'             name='<%=columnData.getString("qty") %>'               width='100' align='right'     </C>							
							<C>id='price'           name='<%=columnData.getString("price") %>'             width='90' align='right'     </C>
							<C>id='amount'          name='<%=columnData.getString("amount") %>'            width='100' align='right'     dec='2'    </C>	
							<C>id='vatCd'           name='Tax Code'            width='110' align='left'      Data='ds_vatCd:code:name:code' editstyle='lookup' </C>
							<C>id='vatAmt'          name='Tax Amount'          width='90' align='right'     </C>
							<C>id='tranTaxRate'     name='<%=columnData.getString("tran_tax_rate") %>'     width='110' align='right'     show='false' </C>
							<C>id='tranTaxAmt'      name='<%=columnData.getString("tran_tax_amt") %>'      width='130' align='right'     show='false' </C>
							<C>id='poDesc'          name='<%=columnData.getString("pr_desc") %>'           width='200' align='left'      </C>
							<C>id='sapPrice'        name='<%=columnData.getString("sap_price") %>'         width='100' align='right'     edit='none'</C> 							
   						    <C>id='receiptClsYn'    name='<%=columnData.getString("receipt_cls_yn") %>'    width='47'  align='center'    edit={IF(qtyChk='T','true','false')} EditStyle=Lookup  data='ds_receiptClsYn:code:name:code'     </C>"/>
						</object>
						</comment><script>__WS__(__NSID__);</script>
					</td>
				</tr>
			</table>
		</div>
		<!-- 그리드 E -->
		<div>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<object id="gr_tax" classid="<%=LGauceId.GRID %>" style="width:100%;height:43px;" class="comn" style="display:none">
							<param name="DataID"            value="ds_tax"/> 
							<param name="Editable"          value="true"/>  
							<Param name="AutoResizing"      value=true>
							<param name="UrlImages"         value="<I>Type='PopupBotton', Url='/sys/images/button/search_icon_2.gif', Fit='AutoFit', Flat='True'</I>">	
							<param name="Format"              
							value="  
							<C>id='wtType'            name='<%=columnData.getString("wt_type") %>',    width='230' align='left'     EditStyle=Lookup  data='ds_taxType:code:name:code' ListWidth=210 </C>
							<C>id='wtCd'              name='<%=columnData.getString("wt_cd") %>'       width='120' align='center'    </C>
							<C>id='wtRate'            name='<%=columnData.getString("wt_rate") %>'     width='110' align='right'     </C>
							<C>id='wtBaseAmt'         name='<%=columnData.getString("wt_base_amt") %>' width='130' align='right'     </C>
							<C>id='wtTaxAmt'          name='<%=columnData.getString("wt_tax_amt") %>'  width='130' align='right'     </C>">
						</object>
					</td>
				</tr>
			</table>
		</div>				
		<!-- 그리드 E -->
	    <div class="sub_stitle"> <p><%= columnData.getString("sub5_title") %></p>
	    	<p class="rightbtn"></p>
		</div>	
		<div>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<comment id="__NSID__">
						<object id="gr_total" classid="<%=LGauceId.GRID %>" style="width:100%;height:21px;">
							<param name="DataID"            value="ds_total"/> 
							<param name="Editable"          value="true"/> 
							<param name="ViewHeader"        value="false">  
							
							<param name="UrlImages"         value="<I>Type='PopupBotton', Url='/sys/images/button/search_icon_2.gif', Fit='AutoFit', Flat='True'</I>">	
							<param name="Format"              
							value="  
							<C>id='title1',            name='title1',    width='70',  align='center',  edit='none', BgColor='#E4E9F2', Color='#6B778F' </C>
							<C>id='value1',            name='value1',    width='170', align='right',   edit='none' </C>
							<C>id='title2',            name='title2',    width='70',  align='center',  edit='none', BgColor='#E4E9F2' ,Color='#6B778F' </C>
							<C>id='value2',            name='value2',    width='170', align='right',   edit='none'</C>
							<C>id='title3',            name='title3',    width='100', align='center',  edit='none', BgColor='#E4E9F2' ,Color='#6B778F' </C>
							<C>id='value3',            name='value3',    width='179', align='right',   edit='none'</C>
							">
						</object>
						</comment><script>__WS__(__NSID__);</script>
					</td>
				</tr>
			</table>
		</div>			
		<!-- 그리드 E --> 
		<br>
		</br>
 
		<!-- 버튼 S -->	
		<div id="btn_area">
			<p class="b_right">
				<span class="btn_r btn_l"><input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnNew%>" onclick="f_addRowMain();"/></span> 
				<span class="btn_r btn_l"><input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnDel%>" onclick="f_delRowMain();"/></span>
				<span class="btn_r btn_l"><input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnSave%>" onclick="f_save()"/></span>
				<span>|</span>  								
				<span class="btn_r btn_l"><input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnSapSend%>" onclick="f_sapSend();"/></span>  
				<span class="btn_r btn_l"><input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnSapCancel%>" onclick="f_sapCancel();"/></span> 
			</p>
		</div>
<!-- 버튼 E --> 
</div>
<input type="hidden" id="h_length"/>
<input type="hidden" id="h_date"/>

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
<B>id=FHeader ,left=0,top=0 ,right=1999 ,bottom=1089 ,face='Tahoma' ,size=10 ,penwidth=1
	<X>left=5 ,top=465 ,right=707 ,bottom=820 ,border=true ,penstyle=solid ,penwidth=3</X>
	<X>left=5 ,top=840 ,right=1924 ,bottom=958 ,border=true ,penstyle=solid ,penwidth=3</X>
	<X>left=5 ,top=978 ,right=1924 ,bottom=1089 ,border=true ,penstyle=solid ,penwidth=3</X>
	<C>id='addr1', left=5, top=116, right=835, bottom=161, align='left', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<C>id='addr2', left=5, top=161, right=835, bottom=206, align='left', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<C>id='addr3', left=5, top=206, right=835, bottom=251, align='left', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<C>id='addr4', left=5, top=251, right=835, bottom=297, align='left', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<C>id='addr5', left=5, top=297, right=835, bottom=342, align='left', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<C>id='addr6', left=5, top=342, right=835, bottom=385, align='left', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<T>id='PURCHASE ORDER' ,left=1273 ,top=25 ,right=1778 ,bottom=91 ,align='left' ,face='Arial' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<C>id='prNo', left=1011, top=495, right=1471, bottom=546, align='left', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<C>id='poNo', left=1011, top=448, right=1471, bottom=498, align='left', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<L> left=1245 ,top=978 ,right=1245 ,bottom=1089 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1655 ,top=978 ,right=1655 ,bottom=1089 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1373 ,top=978 ,right=1373 ,bottom=1089 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=312 ,top=978 ,right=312 ,bottom=1089 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1278 ,top=840 ,right=1278 ,bottom=956 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=717 ,top=840 ,right=717 ,bottom=956 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='' ,left=1562 ,top=870 ,right=1592 ,bottom=923 ,align='left' ,face='Arial' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='' ,left=951 ,top=870 ,right=981 ,bottom=923 ,align='left' ,face='Arial' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='' ,left=239 ,top=870 ,right=269 ,bottom=923 ,align='left' ,face='Arial' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<C>id='refNo', left=981, top=727, right=1464, bottom=777, align='left', face='Arial', size=9, bold=false, underline=false, italic=true, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<C>id='createDate', left=1011, top=614, right=1471, bottom=664, align='left', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<T>id='' ,left=973 ,top=614 ,right=1006 ,bottom=666 ,align='left' ,face='Arial' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='' ,left=973 ,top=468 ,right=1006 ,bottom=521 ,align='left' ,face='Arial' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<L> left=83 ,top=978 ,right=83 ,bottom=1089 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='vendNm', left=101, top=470, right=689, bottom=521, align='left', face='Arial', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<T>id='TO :' ,left=15 ,top=470 ,right=101 ,bottom=521 ,align='left' ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=true ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='Date' ,left=749 ,top=614 ,right=966 ,bottom=666 ,align='left' ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=true ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='PO Number' ,left=749 ,top=468 ,right=971 ,bottom=521 ,align='left' ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=true ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='Terms of Payment' ,left=1283 ,top=870 ,right=1554 ,bottom=923 ,align='left' ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=true ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='Delivery Date' ,left=724 ,top=870 ,right=948 ,bottom=923 ,align='left' ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=true ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='Delivery to' ,left=13 ,top=870 ,right=234 ,bottom=923 ,align='left' ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=true ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='Material No.' ,left=88 ,top=1011 ,right=309 ,bottom=1061 ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Description' ,left=324 ,top=1011 ,right=978 ,bottom=1061 ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Qty' ,left=991 ,top=1011 ,right=1237 ,bottom=1061 ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Unit' ,left=1255 ,top=1011 ,right=1368 ,bottom=1061 ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Unit Price' ,left=1383 ,top=1011 ,right=1647 ,bottom=1061 ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Amount' ,left=1665 ,top=1011 ,right=1914 ,bottom=1061 ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='No' ,left=10 ,top=1011 ,right=78 ,bottom=1064 ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Ref. Pr No.' ,left=749 ,top=727 ,right=966 ,bottom=780 ,align='left' ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=true ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='Attn :' ,left=15 ,top=707 ,right=131 ,bottom=759 ,align='left' ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=true ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='HIGHLAND CEMENT INTERNATAIONAL' ,left=5 ,top=30 ,right=1013 ,bottom=108 ,align='left' ,face='Arial' ,size=15 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<L> left=983 ,top=978 ,right=983 ,bottom=1089 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
</B>

<A>id=Area1 ,left=0,top=0 ,right=2000 ,bottom=135
	<R>id='report_test_sub.sbt' ,left=0 ,top=0 ,right=1910 ,bottom=135 ,DetailDataID='ds_report_dtl'
		<B>id=default ,left=0,top=0 ,right=1999 ,bottom=45 ,face='Tahoma' ,size=10 ,penwidth=1
			<X>left=5 ,top=0 ,right=1924 ,bottom=45 ,border=true ,penstyle=solid ,penwidth=3</X>
			<C>id='partNo', left=86, top=5, right=307, bottom=45, face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='seqNo', left=10, top=5, right=78, bottom=45, face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='unit', left=1250, top=5, right=1366, bottom=45, face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='qty', left=991, top=5, right=1235, bottom=45, align='right', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='desc', left=319, top=5, right=976, bottom=45, align='left', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='amount', left=1660, top=5, right=1909, bottom=45, align='right', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
			<C>id='unitPrice', left=1446, top=5, right=1647, bottom=45, align='right', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='priceDec', left=1376, top=5, right=1446, bottom=45, face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=83 ,top=0 ,right=83 ,bottom=43 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<L> left=312 ,top=0 ,right=312 ,bottom=43 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<L> left=983 ,top=0 ,right=983 ,bottom=43 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<L> left=1245 ,top=0 ,right=1245 ,bottom=43 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<L> left=1373 ,top=0 ,right=1373 ,bottom=43 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
			<L> left=1655 ,top=0 ,right=1655 ,bottom=43 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		</B>
	</R>
</A>
<B>id=Footer ,left=0 ,top=1771 ,right=1999 ,bottom=2870 ,face='Tahoma' ,size=10 ,penwidth=1
	<X>left=983 ,top=0 ,right=1924 ,bottom=367 ,border=true ,penstyle=solid ,penwidth=3</X>
	<T>id='Prepared by,' ,left=297 ,top=523 ,right=556 ,bottom=576 ,face='Arial' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Approved by,' ,left=1335 ,top=523 ,right=1594 ,bottom=576 ,face='Arial' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='General Manager' ,left=1335 ,top=827 ,right=1594 ,bottom=880 ,face='Arial' ,size=9 ,bold=false ,underline=false ,italic=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=123 ,top=304 ,right=930 ,bottom=304 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=123 ,top=367 ,right=930 ,bottom=367 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=983 ,top=184 ,right=1921 ,bottom=184 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=983 ,top=304 ,right=1921 ,bottom=304 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=983 ,top=244 ,right=1921 ,bottom=244 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=983 ,top=123 ,right=1921 ,bottom=123 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=983 ,top=60 ,right=1921 ,bottom=60 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=123 ,top=63 ,right=930 ,bottom=63 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=123 ,top=244 ,right=930 ,bottom=244 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=123 ,top=184 ,right=930 ,bottom=184 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=123 ,top=123 ,right=930 ,bottom=123 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='Total' ,left=991 ,top=128 ,right=1159 ,bottom=181 ,align='left' ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Sub Total' ,left=991 ,top=5 ,right=1159 ,bottom=58 ,align='left' ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='taxAmount', left=1381, top=249, right=1919, bottom=302, align='right', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Decao=2</C>
	<C>id='tot', left=1381, top=128, right=1919, bottom=181, align='right', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Decao=2</C>
	<C>id='subTot', left=1381, top=5, right=1919, bottom=58, align='right', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Decao=2</C>
	<C>id='vat', left=1381, top=189, right=1919, bottom=241, align='right', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Decao=2</C>
	<C>id='discount', left=1484, top=65, right=1919, bottom=118, align='right', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Decao=2</C>
	<T>id='Discount' ,left=991 ,top=65 ,right=1137 ,bottom=118 ,align='left' ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Notes' ,left=0 ,top=15 ,right=123 ,bottom=68 ,align='left' ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Commerical Tax' ,left=991 ,top=189 ,right=1280 ,bottom=241 ,align='left' ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Withholidng Tax' ,left=991 ,top=249 ,right=1278 ,bottom=302 ,align='left' ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Grand Total' ,left=991 ,top=309 ,right=1197 ,bottom=362 ,align='left' ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='gTot', left=1381, top=309, right=1919, bottom=362, align='right', face='Arial', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Decao=2</C>
	<T>id='Purchasing Department' ,left=241 ,top=827 ,right=609 ,bottom=880 ,face='Arial' ,size=9 ,bold=false ,underline=false ,italic=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>

 ">
	</object>
	</comment>
	<SCRIPT>__WS__(__NSID__);</SCRIPT>
</body>
</html>
