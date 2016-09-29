<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--
/*
*************************************************************************
* @source  : purchOrderReg.jsp
* @desc    : PO Send
*------------------------------------------------------------------------
* VER  DATE         AUTHOR      DESCRIPTION
* ---  -----------  ----------  -----------------------------------------
* 1.0  2010.09.13    임민수       init
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

<title>PT-PAM System</title>
<%@ include file="/include/head.jsp" %>
<%
String prevDate	   = LDateUtils.getDate("yyyy/MM/") +"01"; 
String currentDate = LDateUtils.getDate("yyyy/MM/dd");          // currentDate
%> 
<script type="text/javascript">
var g_flug =false; // Detail작업 flag
var g_msPos = 0;   // save후  focus 제정의 Row
var g_ddtPos = 0;  // save후  focus 제정의 Row
var g_appPos = 0;  // save후  focus 제정의 Row
var g_con1Pos = 0;  // save후  focus 제정의 Row
var g_con2Pos = 0;  // save후  focus 제정의 Row
var msg="";
function init(){
	f_setData();
	
}

function f_retrieve(){ 
	
	var param = "?";
	
	param += "&fromDate=" +  removeDash(document.all.fromDate.value, "/");
	param += "&toDate=" + removeDash(document.all.toDate.value, "/");
	param += "&poNo=" + document.all.poNo.value;

	ds_main.DataID = "/po.ir.retrievePoMstList.gau"+param;
	ds_main.Reset();
		
}

function f_setData(){
	ds_deliLoct.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2005";
	ds_deliLoct.Reset();
	
	ds_currCd.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2004";
	ds_currCd.Reset();	
	
	//ds_currencyCd DataSet에 ds_currCd DataSet 내용을 복사
	ds_currencyCd.SetDataHeader(ds_currCd.DataHeader);
	ds_currencyCd.ImportData(ds_currCd.ExportData(1,ds_currCd.CountRow,false));
	
	//ds_currencyCd.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2004";
	//ds_currencyCd.Reset();	
	
	ds_purDept.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2001";
	ds_purDept.Reset();
	
	//ds_gridPurDept DataSet에 ds_purDept DataSet 내용을 복사
	ds_gridPurDept.SetDataHeader(ds_purDept.DataHeader);
	ds_gridPurDept.ImportData(ds_purDept.ExportData(1,ds_purDept.CountRow,false));
	
	ds_purDept.RowPosition = ds_purDept.NameValueRow("code","<%=g_deptCd%>");
	
	//ds_gridPurDept.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2001";
	//ds_gridPurDept.Reset();
	
	//ds_purDept 값 복사	 
	//cfCopyDataSet(ds_purDept,ds_gridPurDept,"copyHeader=true");   
	
	ds_status.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2203";
	ds_status.Reset();
	
	ds_payTerm.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2206";
	ds_payTerm.Reset();			
 	
	ds_mater.DataId="po.oc.retrievePurchOrderRegMaterCombo.gau";
	ds_mater.Reset();	
	
	ds_vatCd.DataId="po.oc.retrievePurchOrderRegVatVCombo.gau?groupCd=2007";
	ds_vatCd.Reset();	 	
 	 
	ds_gridVendor.DataId="cm.cm.retrieveCommComboVendorList.gau";
	ds_gridVendor.Reset();	
	
	//ds_vendor DataSet에 ds_purDept DataSet 내용을 복사
	ds_vendor.SetDataHeader(ds_gridVendor.DataHeader);
	ds_vendor.ImportData(ds_gridVendor.ExportData(1,ds_gridVendor.CountRow,false));
	
	//ds_vendor.DataId="cm.cm.retrieveCommComboVendorList.gau";
	//ds_vendor.Reset();	
	
	var strHeader  = "code:STRING(50),name:STRING(50)";
    ds_return.SetDataHeader(strHeader); 
    
    ds_return.AddRow();
    ds_return.NameValue(ds_return.RowPosition, "code") = ""; 
    ds_return.NameValue(ds_return.RowPosition, "name") = "";
    
    ds_return.AddRow();
    ds_return.NameValue(ds_return.RowPosition, "code") = "X"; 
    ds_return.NameValue(ds_return.RowPosition, "name") = "Return";	
	
	
	//ds_gridVendor 값 복사	 
	cfUnionBlank(ds_currencyCd,lc_currCd,"code","name"); 	
 
	cfAddYn(ds_receiptClsYn,"code"); 
}

function f_save()
{
	/*
	if(!ds_main.IsUpdated && !ds_detail.IsUpdated && !ds_taxGrid.IsUpdated) {
		alert("<%=source.getMessage("dev.inf.com.nochange")%>");
		return;
	}
	*/

	if(document.all.invoiceDate.value > document.all.postingDate.value){
 		alert("<%=source.getMessage("dev.msg.po.invoiceDateCheck")%>");
		return; 			
	}

	if(document.all.dueDate.value < document.all.postingDate.value){
 		alert("Due Date can\'t be smaller than Posting Date");
		return; 			
	}


	var sum = 0;
	var chkCountNum =0;
	/*
	for(var i=1; i<=ds_detail.CountRow; i++){
			sum += ds_detail.NameValue(i, "amount") ;
			chkCountNum++;
	}
	if(	chkCountNum < 1){
		alert("Please check item CheckBox.");
	}
	*/
	sum = document.all.itmAmount.text;

	for(var i=1; i<=ds_taxGrid.CountRow; i++){
		if(ds_taxGrid.NameValue(i,"chk") == "T" && ds_taxGrid.NameValue(i, "baseAmt") > sum){
			alert("<%=source.getMessage("dev.msg.ps.smallerThan", "Base Amount", "Amount")%>");
			ds_taxGrid.RowPosition = i;
			return;
		}
		/*
		else if(ds_taxGrid.NameValue(i,"chk") == "T" && ds_taxGrid.NameValue(i,"taxCode") == ""){
			alert("<%=source.getMessage("dev.warn.com.required", "W/Tax Code")%>");
			ds_taxGrid.RowPosition = i;
			gr_tax.setColumn("taxCode");
			return;
		}
		*/
	}


	if(confirm("<%=source.getMessage("dev.cfm.com.save")%>")){         
	    g_flug=true;	    
		msg ="<%=source.getMessage("dev.suc.com.save")%>";	 

		var param = "?";

		param += "&dueDate=" + removeDash(document.all.dueDate.value, "/");
		param += "&invoiceDate=" + removeDash(document.all.invoiceDate.value, "/");
		param += "&postingDate=" + removeDash(document.all.postingDate.value, "/");
		//param += "&amount=" + ds_detail.NameValue(ds_detail.RowPosition,"amount");
		param += "&amount=" + document.all.itmAmount.text;
		param += "&currency=" + document.all.lc_currCd.BindColVal;
		param += "&vatCd=" + document.all.lc_vatCd.BindColVal;
		param += "&vatAmt=" + document.all.vatAmt.text;
		param += "&tranTaxRate=" +ds_detail.NameValue(ds_detail.RowPosition,"tranTaxRate");
		param += "&tranTaxAmt=" + ds_detail.NameValue(ds_detail.RowPosition,"tranTaxAmt");
		
		ds_main.NameValue(ds_main.RowPosition, 'chk') = 'T';
		
		ds_detail.UseChangeInfo = "false";
		
		for(var i = 0; i <=ds_detail.CountRow; i++){
			ds_detail.NameValue(i , 'chk') = 'T';
		}
		
		tr_cudMaster.KeyValue = "Servlet(I:IN_DS1=ds_main,I:IN_DS2=ds_detail,I:IN_DS3=ds_taxGrid)";
		tr_cudMaster.Action   = "/po.ir.cudInvoiceSave.gau?"+param;
		tr_cudMaster.post();
				
	}
	
}

function calcFunc(){
	var sum = 0;
	for(var i=1; i<=ds_detail.CountRow; i++){
		sum += ds_detail.NameValue(i, "amount") ;
	}	
	
	//VAT AMOUNT계산
	if(lc_vatCd.BindColVal == "VM"){
		document.all.vatAmt.text = Math.round(parseFloat(sum) * 0.05);
		document.all.vatAmt.ReadOnly = false;
	}else{
		document.all.vatAmt.text = '0.00';
		document.all.vatAmt.ReadOnly = true;
	}
	
	//부가세와 합해진 AMOUNT
	document.all.itmAmount.text = sum + parseFloat(document.all.vatAmt.text);
	
	//Material 금액
	//document.all.itmAmount.text = sum;
				
}
 
 function setGrandTotal(amt, vatAmt, trTaxAmt, taxAmt){
 	//Grand Total = Amount + Vat Amount + Trans Tax Amount + Tax Amount
 	var total = amt + vatAmt + trTaxAmt+ taxAmt;
 	document.all.grandTotal.text = total;
 }
 
 function f_setAmt(){
 	var amt = 0;
 	var vatAmt = 0;
 	var trTaxAmt = 0;
 	var taxAmt = 0;
 	for(var i=1; i<=ds_detail.CountRow; i++){
		amt += ds_detail.NameValue(i, "amount");
		trTaxAmt += ds_detail.NameValue(i, "tranTaxAmt");
	}
	for(var i=1; i<=ds_taxGrid.CountRow; i++){
		if(ds_taxGrid.NameValue(i, "chk") == "T"){
			taxAmt = ds_taxGrid.NameValue(i, "taxAmt")
		}
	}
	
	vatAmt = parseFloat(document.all.vatAmt.text);
 	setGrandTotal(amt, vatAmt, trTaxAmt, taxAmt)
 }
 
 function f_sumItemAmount(){
 		var sum = 0;
		for(var i=1; i<=ds_detail.CountRow; i++){
			sum += ds_detail.NameValue(i, "amount") ;
		}		
		
		var tranTaxAmt = 0;
		for(var i=1; i<=ds_detail.CountRow; i++){
			tranTaxAmt = Number(ds_detail.NameValue(i,"tranTaxAmt"));	 
		}
		
		document.all.itmAmount.text = sum + parseFloat(document.all.vatAmt.text) + tranTaxAmt;
		
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
<OBJECT id=tr_cudMaster classid="<%=LGauceId.TR%>">
	<param name="KeyName"   value="toinb_dataid4"> 
	<param name="KeyValue"  value="JSP(I:ds_main=ds_main,I:ds_detail=ds_detail,I:ds_taxGrid=ds_taxGrid)">
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
<object id="ds_taxGrid" classid="<%=LGauceId.DATASET%>" >
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

<object id="ds_currencyCd" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true">
</object>
 
<object id="ds_receiptClsYn" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true">
</object>

<object id="ds_return" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true">
	<param name="ViewDeletedRow"    value="false">
</object>
<!-----------------------------------------------------------------------------
G A U C E   C O M P O N E N T' S   E V E N T S
------------------------------------------------------------------------------>
<script language=JavaScript for=ds_main event=OnLoadStarted()>
  cfShowDSWaitMsg(gr_main);//progress bar 보이기
  cfHideNoDataMsg(gr_main);//no data 메시지 숨기기
</script>

<!-- Hub In Header 조회 DataSet -->
<script language=JavaScript for=ds_main event=OnLoadCompleted(rowCnt)>
  cfHideDSWaitMsg(gr_main);//progress bar 숨기기
  cfFillGridNoDataMsg(gr_main,"gridColLineCnt=2");//no data found   
  
  document.all.vatAmt.text = "0";
  document.all.grandTotal.text = "0";
</script> 


<script language=JavaScript for=ds_taxGrid event=OnLoadCompleted(rowCnt)>
	for( var j=1,cnt=0; j <= ds_taxGrid.CountRow; j++ ) {
			if(ds_taxGrid.NameValue( j , "baseAmt" ) > 0 || ds_taxGrid.NameValue( j , "rate" ) > 0 || ds_taxGrid.NameValue( j , "taxAmt" ) > 0){
				ds_taxGrid.NameValue( j , "chk" ) = "T";
			}
	}
	f_setAmt();
</script> 

<script language=JavaScript for=ds_vatCd event=OnLoadCompleted(rowCnt)>
	cfUnionBlank(ds_vatCd,lc_vatCd,"code","name");
</script> 

<script language=JavaScript for="ds_main" event=OnRowPosChanged(row)>

		ds_detail.ClearAll();
		ds_taxGrid.ClearAll();
		document.all.vatAmt.text = "0";
		document.all.grandTotal.text = "0";
		if(row>0){
			var v_url = new cfURI();
			v_url.Add("poNo",ds_main.NameValue(ds_main.RowPosition,"poNo")); 
			v_url.Add("poSeq",ds_main.NameValue(ds_main.RowPosition,"poSeq")); 			
			v_url.SetPage("po.ir.retrievePoDtlList.gau");
			ds_detail.DataId = v_url.GetURI();
			ds_detail.Reset(); 
	

			// input Box 초기화 
			document.all.invoiceDate.value = '<%= currentDate %>';
			document.all.postingDate.value = '<%= currentDate %>';
			document.all.dueDate.value = '<%= currentDate %>';
			//document.all.itmAmount.text = "";
			document.all.lc_currCd.BindColVal = ds_main.NameValue(ds_main.RowPosition,"currencyCd");
			//document.all.lc_vatCd.BindColVal = "";
			//document.all.vatAmt.text = "";
			
			//Item 값 초기화
			for(var i=1; i<=ds_detail.CountRow; i++){
				//ds_detail.NameValue(i, "amount") = ds_detail.NameValue(i, "previousQty") * ds_detail.NameValue(i, "sapPrice");
				ds_detail.NameValue(row, "amount") = Math.round(ds_detail.NameValue(row, "amount")) ;
				//ds_detail.NameValue(i, "tranTaxAmt") = ds_detail.NameValue(i, "amount") * ds_detail.NameValue(i, "tranTaxRate");
				ds_detail.NameValue(row, "tranTaxAmt") = Math.round(ds_detail.NameValue(row, "tranTaxAmt")) ;
			}
			
			//통화가 MMK인 경우 amount 필드들 소수점 없앰,,  (반올림)
			if(document.all.lc_currCd.BindColVal == "MMK"){
				for(var i=1; i<=ds_detail.CountRow; i++){
					ds_detail.NameValue(i, "amount") = Math.round(ds_detail.NameValue(i, "amount")) ;
				
					//document.all.amount.MaxDecimalPlace = 0;
					document.all.vatAmt.MaxDecimalPlace = 0;
					//document.all.amount.text = "";
					//document.all.vatAmt.text = "";
				}
				//gr_detail.ColumnProp('amount','Dec')="0";
				gr_detail.ColumnProp('tranTaxAmt','Dec')="0";
				
				//TODO: 
				gr_tax.ColumnProp('taxAmt','Dec')="0";
				gr_tax.ColumnProp('baseAmt','Dec')="0";
			}else{
					//document.all.amount.MaxDecimalPlace = 3;
					document.all.vatAmt.MaxDecimalPlace = 3;
					//document.all.itmAmount.text = "0.000";
					//document.all.vatAmt.text = "0.000";

				gr_detail.ColumnProp('tranTaxAmt','Dec')="3";
				gr_detail.ColumnProp('amount','Dec')="2";
				gr_tax.ColumnProp('taxAmt','Dec')="0";
				gr_tax.ColumnProp('baseAmt','Dec')="3";
			}
		}
		
		calcFunc();
		f_setAmt();
			
</script>

<script language=JavaScript for=ds_detail event=OnLoadCompleted(rowCnt)>
		ds_taxGrid.DataId="po.ir.retrieveInvoiceTaxDataSet.gau?groupCd=2011&poNo="+ds_main.NameValue(ds_main.RowPosition,"poNo");
		ds_taxGrid.Reset();
		
		
</script> 

<script language=JavaScript for="ds_detail" event=OnRowPosChanged(row)>
	//ds_detail.NameValue(row, "amount") = ds_detail.NameValue(row, "previousQty") * ds_detail.NameValue(row, "sapPrice");
	//ds_detail.NameValue(row, "amount") = Math.round(ds_detail.NameValue(row, "amount")) ;
	//lc_vatCd
	for( var j=1,cnt=0; j <= ds_vatCd.CountRow; j++ ) {
		if( ds_detail.NameValue(row,"vatCd") == ds_vatCd.NameValue( j , "code" ) ) {
			
			document.all.lc_vatCd.BindColVal = ds_vatCd.NameValue( j , "code" ) ;
		}
	}
	var amtSum = 0;
	var strGrandTot = 0;
	for(var i=1; i<=ds_detail.CountRow; i++){
		amtSum += ds_detail.NameValue(i, "amount");
		strGrandTot+=Number(ds_detail.NameValue(i,"amount"))+Number(ds_detail.NameValue(i,"vatAmt"))+Number(ds_detail.NameValue(i,"tranTaxAmt"));	 
	}
	
	document.all.vatAmt.text = ds_detail.NameValue(row, "vatAmt");
	
	if(lc_vatCd.BindColVal == "VM"){
		document.all.vatAmt.ReadOnly = false;
	}else{
		document.all.vatAmt.text = '0.00';
		document.all.vatAmt.ReadOnly = true;
	}
	
	var tranTaxAmt = 0;
	for(var i=1; i<=ds_detail.CountRow; i++){
		tranTaxAmt = Number(ds_detail.NameValue(i,"tranTaxAmt"));	 
	}
		
	amtSum = amtSum +  parseFloat(document.all.vatAmt.text) +tranTaxAmt;
	document.all.itmAmount.text = amtSum;
</script>

 <script language=JavaScript for=gr_detail event=OnExit(row,colid,olddata)>
	var sum = 0;

	//MMK인경우 tran tax amount 자동계산 및 반올림
 	if(colid == "tranTaxRate" ){
 	
 		if(document.all.lc_currCd.BindColVal == "MMK"){
	 		//ds_detail.NameValue(row, "tranTaxAmt") = ds_detail.NameValue(row, "amount") * ds_detail.NameValue(row, "tranTaxRate") / 100;
			ds_detail.NameValue(row, "tranTaxAmt") = Math.round(ds_detail.NameValue(row, "tranTaxAmt")) ;
	
			}	
	}

 	if(colid == "amount"){
		//ds_detail.NameValue(row, "tranTaxAmt") = ds_detail.NameValue(row, "amount") * ds_detail.NameValue(row, "tranTaxRate") / 100;
		ds_detail.NameValue(ds_detail.RowPosition,"chk") = "T";	

		sum = 0;
		for(var i=1; i<=ds_detail.CountRow; i++){
			if(ds_detail.NameValue(i, "chk") == "T" ){
				sum += ds_detail.NameValue(i, "amount") ;
			}
		}	
		 	
	 	//ds_tax grid 설정
		for(var i=1; i<=ds_taxGrid.CountRow; i++){
			if(ds_taxGrid.NameValue(i, "chk") == "T"){
				ds_taxGrid.NameValue(i, "baseAmt") = sum;
				//ds_taxGrid.NameValue(i, "taxAmt") = ds_taxGrid.NameValue(i, "baseAmt") * ds_taxGrid.NameValue(i, "rate") / 100.0;
				//ds_taxGrid.NameValue(i, "taxAmt") = Math.round(ds_taxGrid.NameValue(i, "taxAmt")) ;
			}
		}
		
		var tranTaxAmt = 0;
		for(var i=1; i<=ds_detail.CountRow; i++){
			tranTaxAmt = Number(ds_detail.NameValue(i,"tranTaxAmt"));	 
		}
		
		document.all.itmAmount.text = sum + parseFloat(document.all.vatAmt.text) + tranTaxAmt;
	}		
	if(colid == "tranTaxAmt" || colid == "amount"){
		f_setAmt();
		f_sumItemAmount();
	}
</script>


<script language=JavaScript for=gr_tax event=OnExit(row,colid,olddata)>
	if(colid == "taxAmt"){
		f_setAmt();
	}
</script>

<script language="javascript" for="gr_detail" event="onClick( Row, Colid )">
	if(Colid == "tranR"){
	
	
	}
	
	/*
	if(Colid == "chk"){
		var sum = 0;
		for(var i=1; i<=ds_detail.CountRow; i++){
			sum += ds_detail.NameValue(i, "amount") ;
		}		
		
	
		//ds_tax grid 설정
		for(var i=1; i<=ds_taxGrid.CountRow; i++){
			if(ds_taxGrid.NameValue(i, "chk") == "T"){
				ds_taxGrid.NameValue(i, "baseAmt") = sum;
				//ds_taxGrid.NameValue(i, "taxAmt") = ds_taxGrid.NameValue(i, "baseAmt") * ds_taxGrid.NameValue(i, "rate") / 100.0;
				ds_detail.NameValue(Row, "taxAmt") = Math.round(ds_detail.NameValue(Row, "taxAmt")) ;
			}
		}
		
		//vat amount, amount 설정
		if(lc_vatCd.BindColVal == "VM"){
			document.all.vatAmt.text = parseFloat(sum) * 0.05;
			document.all.vatAmt.ReadOnly = false;
		}else{
			document.all.vatAmt.text = '0.00';
			document.all.vatAmt.ReadOnly = true;
		}
		
		document.all.itmAmount.text = sum + parseFloat(document.all.vatAmt.text);
		
				
	}
	*/

</script>


<script language="javascript" for="gr_tax" event="onClick( Row, Colid )">
	if(Colid == "chk"){     // 실제 체크 된거 인지 체크 필요 할차례 
		var sum = 0;
		for (var i = 1 ; i <= ds_taxGrid.CountRow ; i++ ) {
			if ( i == Row )  {
				ds_taxGrid.NameValue(i,"chk") = "T"; 
				ds_taxGrid.NameValue(i, "baseAmt") = sum;
				ds_taxGrid.NameValue(i, "taxAmt") = ds_taxGrid.NameValue(i, "baseAmt") * ds_taxGrid.NameValue(i, "rate") / 100.0;
				ds_taxGrid.NameValue(i, "taxAmt") = Math.round(ds_taxGrid.NameValue(i, "taxAmt")) ;
			}else {
				ds_taxGrid.NameValue(i,"chk") = "F"; 
				ds_taxGrid.NameValue(i, "baseAmt") = 0.000;
				ds_taxGrid.NameValue(i, "taxAmt") = 0.000;
			}
		}
	}

</script>

 <script language=JavaScript for=gr_tax event=OnExit(row,colid,olddata)>
 	/*
 	if(colid == "baseAmt" || colid == "rate"){
		ds_taxGrid.NameValue(row, "taxAmt") = ds_taxGrid.NameValue(row, "baseAmt") * ds_taxGrid.NameValue(row, "rate") / 100.0;
		ds_taxGrid.NameValue(row, "taxAmt") = Math.round(ds_taxGrid.NameValue(row, "taxAmt")) ;
 	}
 	*/
 	
 	if(colid == "taxAmt"){
		f_setAmt();
 	}

</script> 

<script language=JavaScript for=tr_cudMaster event=OnFail()>
	if(tr_cudMaster.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
		window.parent.location.href = "/index.jsp";    
	}
	alert(tr_cudMaster.ErrorMsg);
</script>

<script language=JavaScript for=tr_cudMaster event=OnSuccess()>
	g_flug=false; 
	alert(msg);
	f_retrieve();
</script> 
 
<script language=JavaScript for=gr_main event=OnPopup(row,colid,data)>
 	if ( colid == "deliDate") {
	 	h_date.value ="";
		gf_calendarExClean(h_date); 
		ds_main.NameValue(row,"deliDate") =funcReplaceStrAll(h_date.value,"/","");
	}	
</script>

<script language=JavaScript for=gr_detail event=OnPopup(row,colid,data)>
 	if ( colid == "materNm") {
		openMaterialCodeListGridConWin(row, ds_detail,"PO");
		
	}
</script>

<script language=JavaScript for=lc_vatCd event=OnSelChange()>
	calcFunc();
	f_setAmt();
</script>





<!-- main 조건설정-->

 
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
							<col width="12%"/>
							<col width="40%"/>
							<col width="12%"/>
							<col width=""/>
						</colgroup>
						<tr>
							<th>P/O Date </th>
							<td><input type="text" onblur="valiDate(this);" style="width:70px;" id="fromDate" value="<%= prevDate %>" />
								<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="" onclick="javascript:OpenCalendar(fromDate);" class="button_cal"/>
								~
								<input type="text" onblur="valiDate(this);" style="width:70px;" id="toDate" value="<%= currentDate %>" />
								<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="" onclick="javascript:OpenCalendar(toDate);" class="button_cal"/>
							</td> 
							<th>P/O No.</th>
							<td> <input id="poNo" name="poNo" size="17"></input>	</td>						
						</tr>
					</table>
				</dt>              		  	   	 	
					 <dd class="btnseat1"> 
					 	 <span class="search_btn_r search_btn_l">
                 			 <input type="button" onfocus="blur();" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='#e2ebf7'" value="<%=btnSearch %>" onclick="javascript:f_retrieve();"/></span> 
					 </dd>							
			</dl>
		</div>
	</fieldset>
	<!--검색 E -->		

	<div class="sub_stitle"> 
		<p> <%=columnData.getString("sub1_title") %> </p>
	</div>    
	<!-- 그리드 S -->
		<div>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<object id="gr_main" classid="<%=LGauceId.GRID %>" style="width:100%;height:123px;" class="comn">
							<param name="DataID"            value="ds_main"/> 
							<param name="Editable"          value="true"/>
							<Param name="AutoResizing"      value=true>
							<param name="TitleHeight"          value="30"/>
							<param name="UrlImages"         value="<I>Type='PopupBotton', Url='/sys/images/button/search_icon_2.gif', Fit='AutoFit', Flat='True'</I>">
							<param name="Format"            
							value="
							<FC>id='poNo'          name='P/O No.'              width='90'  align='center' edit='none'                                  </FC>
							<C>id='vendNm'         name='<%=columnData.getString("vend_cd") %>'            width='160'  align='left'   edit='none'       Data='ds_gridVendor:code:name:code' editstyle='lookup' ListWidth=200   </C>                  
							<C>id='delivyPlaName'  show='false' name='<%=columnData.getString("deli_loct") %>'          width='80'  align='left'   edit='none'       Data='ds_deliLoct:code:name:code' editstyle='lookup' ListWidth=200 </C>
							<C>id='regdate'        name='P/O Date'           width='90'  align='center' edit='none'                                  mask='XXXX/XX/XX'  </C>
							<C>id='deliDate'       name='<%=columnData.getString("deli_date") %>'          width='90'  align='center' edit='none'       editstyle='PopupFix' mask='XXXX/XX/XX'  </C>
							<C>id='currencyCd'     name='<%=columnData.getString("currency_cd") %>'        width='70'  align='center' edit='none'       Data='ds_currCd:code'  editstyle='lookup' </C>							
							<C>id='payTerm'        name='<%=columnData.getString("pay_term") %>'           width='120'  align='center' edit='none'       Data='ds_payTerm:code:name:code' editstyle='lookup' </C>		
							<C>id='absgr'          name='P/O Type'            width='80'  align='left'   edit='none'  show='true'    </C>
							<C>id='poType'         name='<%=columnData.getString("po_type") %>'            width='60'  align='left'   edit='none'  show='false'     Data='ds_return:code:name:code' editstyle='lookup' ListWidth=80  </C>
							<C>id='discountAmt'    name='Discount;Amount'       width='95'  align='right'  show='false' edit='none'       dec={if(currencyCd='MMK',0,3)}      </C>												
							<C>id='sapPoNo'        name='<%=columnData.getString("sap_po_no") %>'          width='90'  align='center' edit='none'                                  </C>					
							<C>id='chk'     show='false'                                  </C>					"/>
		             
						</object>
					</td>
				</tr>
			</table>
		</div>
		<!-- 그리드 E --><!--=======================header============================================-->
	    <div class="sub_stitle"> <p>Invoice Information</p>
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
		                        <th><%= columnData.getString("invoice_date") %></th>
		                        <td><input id="invoiceDate" name="invoiceDate"  type="text" onblur="valiDate(this);" style="width:70px;" onpropertychange="document.all.postingDate.value = document.all.invoiceDate.value;" value="<%= currentDate %>" /> <img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(invoiceDate);" style="cursor:hand"/>  </td>
		                        <th><%= columnData.getString("posting_date") %></th>
		                        <td><input id="postingDate" name="postingDate" type="text" onblur="valiDate(this);" style="width:70px;" value="<%= currentDate %>" /> <img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(postingDate);" style="cursor:hand"/>  </td>
							</tr>
							<tr>
		                        <th><%= columnData.getString("due_date") %></th>
		                        <td><input id="dueDate" name="dueDate" type="text" style="width:70px;" onblur="valiDate(this);"  value="<%= currentDate %>"/> <img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(dueDate);" style="cursor:hand"/>  </td>
		                        <th><%= columnData.getString("currency_cd") %></th>
      							<td>
	      							<comment id="__NSID__"><object id="lc_currCd"  classid="<%=LGauceId.LUXECOMBO%>" width="100">
									<param name="ComboDataID"       value="ds_currencyCd"/>
									<param name="ListCount"     	value="10"/>
									<param name=SearchColumn		value="name"/>
									<param name="BindColumn"    	value="code"/>
									<param name=ListExprFormat		value="code^0^70"/> 
									<param name=enable		value="true"/> 
									<param name=index           	value=0>
									</object></comment><script>__WS__(__NSID__); </script>
								</td>						
							</tr>
						
		            </table>
				</div>
			    
	    
		</div>	
		
		<!-- 그리드 E --> <!--=========================item==========================================--> 
	    <div class="sub_stitle"> <p>Invoice Material</p>
		</div>		
				
		<div>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<object id="gr_detail" classid="<%=LGauceId.GRID %>" style="width:100%;height:113px;" class="comn">
							<param name="DataID"            value="ds_detail"/> 
							<param name="Editable"          value="true"/>
						    <param name="UsingOneClick"     value=1>
						    <Param name="AutoResizing"      value=true>
							<param name="Format"              
							value="
							<C>id='poSeq'          name='<%=columnData.getString("po_seq") %>'            width='45' align='center'    edit='none'   </C>							            
							<C>id='materNm'         name='<%=columnData.getString("mater_cd") %>'          width='170' align='left'      edit='none' editstyle='popupfix'  </C>
							<C>id='unit'            name='<%=columnData.getString("unit") %>'              width='45' align='center'    edit='none'   </C>
							<C>id='qty'             name='<%=columnData.getString("po_qty") %>'               width='85' align='right'     edit='none'  </C>
							<C>id='previousQty'    name='Received Qty.'               width='95' align='right'     edit='none'  </C>
							<C>id='receiptQty'      name='Received Qty.'               width='85' align='right'    edit={IF( receiptClsYn='N','true','false')} dec='3' show='false' </C>
							<C>id='price'            name='<%=columnData.getString("price") %>'              width='105' align='right'    edit='none'   </C>
							<C>id='sapPrice'         name='<%=columnData.getString("net_price") %>'              width='95' align='right'    edit='none' show='false'  </C>
							<C>id='amount'          name='<%=columnData.getString("amount") %>'            width='115' align='right'     edit='true' dec='0'    </C>	
   						    <C>id='receiptClsYn'    name='<%=columnData.getString("receipt_cls_yn") %>'    width='47'  align='center'    edit='true' EditStyle=Lookup  data='ds_receiptClsYn:code:name:code'  show='false' </C>
   						    <C>id='materCd'   show='false' </C>  
   						    <C>id='vatCd'   name='Tax Code'  width='130' align='left'     edit='true'  EditStyle=Lookup data='ds_vatCd:code:name:code' ListWidth=140 </C>
   						    "/>
						
						</object>
					</td>	
				</tr>
			</table>
		</div>

	<!-- 그리드 E --><!--=======================VAT===========================================-->
	    <div class="sub_stitle"> <p>Commercial Tax</p>
			<!-- 그리드 S -->
		        <div id="output_board_area">
		            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board" >
		                <colgroup>
		                        <col width="20%"/>
		                        <col width="30%"/>
		                        <col width="20%"/>
		                        <col width=""/>
		              </colgroup>
		                     <tr>
		     		   <th>Tax Code</th>
    					<td>
    					<comment id="__NSID__"><object id="lc_vatCd"  classid="<%=LGauceId.LUXECOMBO%>" width="190">
						<param name="ComboDataID"       value="ds_vatCd">
						<param name="ListCount"     	value="10">
						<param name=SearchColumn		value="name">
						<param name="BindColumn"    	value="code">
						<param name=ListExprFormat		value="name^0^180,code^0^70"> 
						<param name=index           	value=0>
						</object></comment><script>__WS__(__NSID__); </script>
						</td>
                        <th>Tax Amount</th>
                        <td>
                        <object id=vatAmt name="vatAmt" class="input_text" classid="<%=LGauceId.EMEDIT%>"	 height=20 width=150  onBlur="f_setAmt();f_sumItemAmount()">
	          			<PARAM NAME="Border"   					VALUE="true"/>
	          			<PARAM NAME="ReadOnly"   				VALUE="false"/>
	          			<PARAM NAME="Alignment"     			VALUE="2">
	          			<PARAM NAME="Numeric" 					VALUE="true"/>
						<PARAM NAME="MaxDecimalPlace" 			VALUE="3"/>
						<PARAM NAME="VisibleMaxDecimal" 		VALUE="True"/>
						<PARAM NAME="VAlign" value="2"/>
						<PARAM NAME="ReadOnlyBackColor" value="#f1f1f1"/>
	            	</object>   
			     	 </td>
					</tr>   
		            </table>
				</div>
			    
	    
		</div>	
		
		<!-- 그리드 S -->
		<div>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<comment id="__NSID__">
						<object id="gr_tax" classid="<%=LGauceId.GRID %>" style="width:100%;height:60px;" class="comn" style="display:none">
							<param name="DataID"            value="ds_taxGrid"/> 
							<param name="Editable"          value="true"/>
						    <param name="UsingOneClick"     value=1>
							<param name="Format"              
							value="
							<C>id='chk'         width='40'  align='center'   edit='true',  Editstyle='check'    </C>
							<C>id='name'   name='<%=columnData.getString("w_tax_type") %>'   width='220' align='left'   edit='none'    </C>
							<C>id='taxCode'    name='<%=columnData.getString("w_tax_code") %>'   width='120' align='right'   edit='true'    </C>
							<C>id='rate'        name='<%=columnData.getString("rate") %>'   width='110' align='right'   edit='true'   decao='2' </C>
							<C>id='baseAmt'        name='<%=columnData.getString("base_amount") %>'   width='130' align='right'   edit='true'   </C>
							<C>id='taxAmt'       name='<%=columnData.getString("tax_amount") %>'  width='130'  align='right'   edit='true' dec='0' </C>
							<C>id='code'      show = 'false' </C>"/>
						</object>
						
		
						</comment>
						<script>__WS__(__NSID__);</script>
					</td>
				</tr>
			</table>
		</div>
				
		<!-- 그리드 E --><!--======================Amount============================================-->
	    <div class="sub_stitle"> <p>Total Amount</p>
			<!-- 그리드 S -->	
		        <div id="output_board_area">
		            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board" >
		                <colgroup>
		                        <col width="20%"/>
		                        <col width="80%"/>
		              </colgroup>
		                     <tr>
		                        <th><%= columnData.getString("grand_total") %></th>
		                        <td colspan="3">
                                 <object id=itmAmount name="itmAmount" class="input_text" classid="<%=LGauceId.EMEDIT%>"	height=20 width=150  >
			          			<PARAM NAME="Border"   					VALUE="true"/>
			          			<PARAM NAME="ReadOnly"   				VALUE="true"/>
			          			<PARAM NAME="Alignment"     			VALUE="2">
			          			<PARAM NAME="Numeric" 					VALUE="true"/>
								<PARAM NAME="MaxDecimalPlace" 			VALUE="3"/>
								<PARAM NAME="VisibleMaxDecimal" 		VALUE="True"/>
								<PARAM NAME="VAlign" value="2"/>
								<PARAM NAME="ReadOnlyBackColor" value="#f1f1f1"/>
			            		 </object>   
								</td>	
								<!-- 
								<th><%= columnData.getString("grand_total") %></th>
		                        <td>                                
								</td>
								 -->
								<object id=grandTotal name="grandTotal" class="input_text" classid="<%=LGauceId.EMEDIT%>"	height=20 width=114 style="display:none" >
			          			<PARAM NAME="Border"   					VALUE="true"/>
			          			<PARAM NAME="ReadOnly"   				VALUE="true"/>
			          			<PARAM NAME="Alignment"     			VALUE="2">
			          			<PARAM NAME="Numeric" 					VALUE="true"/>
								<PARAM NAME="MaxDecimalPlace" 			VALUE="3"/>
								<PARAM NAME="VisibleMaxDecimal" 		VALUE="True"/>
								<PARAM NAME="VAlign" value="2"/>
								<PARAM NAME="ReadOnlyBackColor" value="#f1f1f1"/>
			            		 </object>   					
							</tr>   
		            </table>
				</div>
		</div>	
		<!-- 버튼 S -->	<!--===================================================================-->
		<div id="btn_area">
			<p class="b_right">
				<span class="btn_r btn_l"> 
				<input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnSave%>" onclick="f_save()"/></span>  								
			</p>
		</div>
<!-- 버튼 E --> 
</div>
<input type="hidden" id="h_date"/>
</body>
</html>

