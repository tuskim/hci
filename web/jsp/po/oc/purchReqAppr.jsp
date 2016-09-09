<%--
/*
 *************************************************************************
 * @source  : purchReqAppr.jsp
 * @desc    : Purchase Request Manage
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2010/08/16   mskim       Init
 * ---  -----------  ----------  -----------------------------------------
 * PT-PAM System.
 * Copyright(c) 2006-2007 LG CNS,  All rights reserved.
 *************************************************************************
 */
--%>

<%@ page import="devon.core.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Purchase Request Manage</title>
<%@ include file="/include/head.jsp" %>

<%
	String prevDate	   = LDateUtils.getDate("yyyy/MM/") +"01"; 
	String currentDate = LDateUtils.getDate("yyyy/MM/dd");          // currentDate
%>

<script type="text/javascript">

	// 주의: 하단 그리드의 컬럼이 추가되는 경우, [strHeaderDtl], [gr_grid]를 동일하게 구성해야 합니다.
       var strHeader = "companyCd"     + ":STRING(4)"
                     + ",prNo"          + ":STRING(10)"
                     + ",reqDeptCd"     + ":STRING(4)"
                     + ",reqDeptNm"     + ":STRING(100)"
                     + ",requester"     + ":STRING(100)"
                     + ",purComment"    + ":STRING(100)"
                     + ",reqDate"       + ":STRING(10)"
                     + ",deliReqDate"   + ":STRING(10)"
                     + ",budget"        + ":DECIMAL(13.2)"
                     + ",amount"        + ":DECIMAL(13.2)"
                     + ",status"        + ":STRING(2)"
                     + ",statusNm"      + ":STRING(20)"
                     + ",purDeptCd"     + ":STRING(4)"
                     + ",gmoConid"      + ":STRING(100)"
                     + ",gmoCondate"    + ":STRING(8)"
                     + ",headConid"     + ":STRING(100)"
                     + ",headCondate"   + ":STRING(8)";

       var strBody   = "companyCd"     + ":STRING(4)"
                     + ",prNo"          + ":STRING(10)"
                     + ",prDetailNo"    + ":STRING(3)"
                     + ",materType"     + ":STRING(1)"
                     + ",materCd"       + ":STRING(18)"
                     + ",materNm"       + ":STRING(100)"
                     + ",urgentType"    + ":STRING(1)"
                     + ",vendCd"        + ":STRING(20)"
                     + ",vendNm"        + ":STRING(100)"
                     + ",prDesc"        + ":STRING(100)"
                     + ",unit"          + ":STRING(20)"
                     + ",qty"           + ":DECIMAL(13.2)"
                     + ",vatCd"         + ":STRING(20)"
                     + ",currencyCd"    + ":STRING(20)"
                     + ",price"         + ":DECIMAL(13.2)"
                     + ",amount"        + ":DECIMAL(13.2)"
                     + ",idrAmt"        + ":DECIMAL(13.2)"
                     + ",deliLoct"      + ":STRING(4)"
                     + ",poStatus"      + ":STRING(100)";


//-------------------------------------------------------------------------
// 검색
//-------------------------------------------------------------------------
function f_Retrieve() {

    if (checkData()) {

		var condition = "?";
	    	condition += "reqDeptCd=" + deptCd.ValueOfIndex("code",deptCd.Index);
	 		condition += "&prNo=" + document.all.prNoS.value;
	 		condition += "&status=" + statusS.ValueOfIndex("code",statusS.Index)
	 		condition += "&orderDateFrom=" + removeDash(document.all.orderDateFrom.value,"/");
	 		condition += "&orderDateTo=" + removeDash(document.all.orderDateTo.value,"/");
	 		
	 		//alert(condition);
		ds_purchReqMst.DataID = "po.oc.retrievePurchReqMstAppr.gau"+condition;
		ds_purchReqMst.Reset();
	}

}

//-------------------------------------------------------------------------
// 저장
//-------------------------------------------------------------------------
function f_Save() {
    
    if(ds_purchReqDtl.CountRow == 0) {
        alert("please P/R Detail first retrieve!");      // please first retrieve!
        return;
    }

	if (checkSaveData('SAVE')) {

		// Detail Grid esential Check
		if(!cfValidateGrid(ds_purchReqDtl, ds_purchReqDtl.RowPosition, ds_purchReqDtl.ColumnID(i))) return;
	    if(confirm("Are you sure to save?")){     // Are you sure to save?
			mode = "process";
			//tr_cudData.Parameters = param;
			tr_cudData.KeyValue	 = "JSP(I:IN_DS1=ds_purchReqMst,I:IN_DS2=ds_purchReqDtl)";
			tr_cudData.Action    = "po.oc.cudPurchReqAppr.gau";
			tr_cudData.Post();
		}
	
	}

}

//-------------------------------------------------------------------------
// Purch Request Approval
//-------------------------------------------------------------------------	
function f_Approval(){

	if (checkSaveData()) {

		if (confirm('Are you sure to Approval?')) {
			mode = "process";
		  	var param = "prNo=" + ds_purchReqMst.Namevalue(ds_purchReqMst.RowPosition,"prNo"); 
			tr_cudData.Parameters = param;
			tr_cudData.KeyValue	= "JSP(I:IN_DS1=ds_purchReqMst)";
			tr_cudData.Action   = "po.oc.cudDelPurchReqAppr.gau";
	 		tr_cudData.Post();//Cost Total Ledger Approval
	 	}
 	
 	}

}

//-------------------------------------------------------------------------
// Purch Request Cancel
//-------------------------------------------------------------------------	
function f_Cancel(){

	if (checkSaveData()) {

		if (confirm('Are you sure to Cancel?')) {
			mode = "process";
		  	var param = "prNo=" + ds_purchReqMst.Namevalue(ds_purchReqMst.RowPosition,"prNo"); 
			tr_cudData.Parameters = param;
			tr_cudData.KeyValue	= "JSP(I:IN_DS1=ds_purchReqMst)";
			tr_cudData.Action   = "po.oc.cudDelPurchReqAppr.gau";
	 		tr_cudData.Post();//Cost Total Ledger Approval
	 	}
 	
 	}

}

//-------------------------------------------------------------------------
// 검색 필수 체크
//-------------------------------------------------------------------------
function checkData() {

   	if(document.all.orderDateFrom.value == "") {
	    alert(" required field. please fill create Date! ");
	    document.all.orderDateFrom.focus();
		return false;
	}
	
   	if(document.all.orderDateTo.value == "") {
	    alert(" required field. please fill create Date! ");
	    document.all.orderDateTo.focus();
		return false;
	}
	return true;
}

//-------------------------------------------------------------------------
// Master 삭제시 체크
//-------------------------------------------------------------------------
function checkDelData() {

	if(ds_purchReqMst.CountRow == 0){
		alert('The selected item does not exist.');
		return false;
	}

	if(ds_purchReqDtl.CountRow == 0){
		alert('The selected P/R item does not exist.');
		return false;
	}

	var status = ds_purchReqMst.NameValue(ds_purchReqMst.RowPosition ,"status");
	if(status != "01" ){
		alert('The selected item does not Request Status condition.');
		return false;
	}
	
	for(var i=1; i <= ds_purchReqDtl.countRow; i++){
		if(ds_purchReqDtl.NameValue(i,"poStatus") != ""){
			alert('The selected item does PO Status Exist');
			ds_purchReqDtl.RowPosition = i;
			return false;
		}
	}

	return true;
}

//-------------------------------------------------------------------------
// Master 승인 / 취소 시 필수 체크 사항
//-------------------------------------------------------------------------
function checkSaveData() {

	var chk_cnt = 0;

	if(ds_purchReqMst.CountRow == 0){
		alert('The selected item does not exist.');
		return false;
	}

	if(ds_purchReqDtl.CountRow == 0){
		alert('The selected P/R Item does not exist.');
		return false;
	}

	var status = ds_purchReqMst.NameValue(ds_purchReqMst.RowPosition ,"status");
	if(status != "01" ){
		alert('The selected item does not Request Status condition.');
		return false;
	}
	
	var materCd = "";
	var idrAmt  = "";
	var prDesc  = "";
	
	for(var i=1; i <= ds_purchReqDtl.countRow; i++){

		if(ds_purchReqDtl.NameValue(i,"materType") == ""){
			alert('@ field must be inputted Material Type');
			ds_purchReqDtl.RowPosition = i;
			gr_purchReqDtl.SetColumn("materType");
			return false;
		}

		if(ds_purchReqDtl.NameValue(i,"materType") == "1"){
			materCd = ds_purchReqDtl.NameValue(i,"materCd");
			if ( materCd == "" ) {
				alert('@ field must be inputted Material');
				ds_purchReqDtl.RowPosition = i;
				gr_purchReqDtl.SetColumn("materCd");
				return false;
			}
		} else if (ds_purchReqDtl.NameValue(i,"materType") == "2") {
			prDesc = ds_purchReqDtl.NameValue(i,"prDesc");
			if ( prDesc == "" ) {
				alert('@ field must be inputted PR Description');
				ds_purchReqDtl.RowPosition = i;
				gr_purchReqDtl.SetColumn("prDesc");
				return false;
			}
		}

		if(ds_purchReqDtl.NameValue(i,"urgentType") == ""){
			alert('@ field must be inputted Urgent Type');
			ds_purchReqDtl.RowPosition = i;
			gr_purchReqDtl.SetColumn("urgentType");
			return false;
		}

		if(ds_purchReqDtl.NameValue(i,"qty") == 0.0){
			alert('@ field must be inputted Quantity');
			ds_purchReqDtl.RowPosition = i;
			gr_purchReqDtl.SetColumn("qty");
			return false;
		}

		if(ds_purchReqDtl.NameValue(i,"currencyCd") == ""){
			alert('@ field must be inputted Currency ');
			ds_purchReqDtl.RowPosition = i;
			gr_purchReqDtl.SetColumn("currencyCd");
			return false;
		}

		if(ds_purchReqDtl.NameValue(i,"price") == ""){
			alert('@ field must be inputted Price ');
			ds_purchReqDtl.RowPosition = i;
			gr_purchReqDtl.SetColumn("price");
			return false;
		}

		if(ds_purchReqDtl.NameValue(i,"currencyCd") == "USD"){
			idrAmt = ds_purchReqDtl.NameValue(i,"idrAmt");
			if ( idrAmt == "" ) {
				alert('@ field must be inputted IDR AMT ');
				ds_purchReqDtl.RowPosition = i;
				gr_purchReqDtl.SetColumn("idrAmt");
				return false;
			}
		}

		if(ds_purchReqDtl.NameValue(i,"deliLoct") == ""){
			alert('@ field must be inputted Delivery Location ');
			ds_purchReqDtl.RowPosition = i;
			gr_purchReqDtl.SetColumn("deliLoct");
			return false;
		}
		
	}

	return true;
}

</script>

<!-----------------------------------------------------------------------------
  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- CUD TR -->
<!-- Payment Arrange CUD TR -->
<OBJECT id=tr_cudData classid="<%=LGauceId.TR%>">
    <param name="KeyName"   value="toinb_dataid4">
    <!-- param name="KeyValue"  value="JSP(I:IN_DS1=ds_purchReqMst)"-->
    <param name="ServerIP"  value="">
</OBJECT>

<!-----------------------------------------------------------------------------
    D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-- Grid 용 Master DataSet-->
<object id="ds_purchReqMst" 	classid="<%=LGauceId.DATASET%>" >
  <param name="SyncLoad"          value="true">
  <param name="ViewDeletedRow"    value="true">
</object>

<!-- Grid 용 Detail DataSet-->
<object id="ds_purchReqDtl" 	classid="<%=LGauceId.DATASET%>" >
  <param name="SyncLoad"          value="true">
  <param name="ViewDeletedRow"    value="true">
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
	<param name="DataID"          value="cm.cm.retrieveCommCodeCombo.gau?groupCd=2201&firstVal=Total">
</object>

<!-- Material combo DataSet -->
<object id="ds_mastaCode"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
	<param name="DataID"          value="cm.cm.retrieveCommCodeCombo.gau?groupCd=2202">
</object>

<!-- Currency combo DataSet -->
<object id="ds_curCode"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
	<param name="DataID"          value="cm.cm.retrieveCommCodeCombo.gau?groupCd=2004">
</object>

<!-- Delivery Location combo DataSet -->
<object id="ds_deliLocCode"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
	<param name="DataID"          value="cm.cm.retrieveCommCodeCombo.gau?groupCd=2005">
</object>

<!-- Urgent Type combo DataSet -->
<object id="ds_urgentTypeCode"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
	<param name="DataID"          value="cm.cm.retrieveCommCodeCombo.gau?groupCd=2204">
</object>

<!-- Vat combo DataSet -->
<object id="ds_vatCode"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
	<param name="DataID"          value="cm.cm.retrieveCommCodeCombo.gau?groupCd=2007">
</object>

<!-- Vat combo DataSet -->
<object id="ds_poStatusCode"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
	<param name="DataID"          value="cm.cm.retrieveCommCodeCombo.gau?groupCd=2203">
</object>

<!-----------------------------------------------------------------------------
    G A U C E   C O M P O N E N T' S   E V E N T S
------------------------------------------------------------------------------>
<script language=JavaScript for=ds_purchReqMst event=OnLoadStarted()>
  cfHideNoDataMsg(gr_purchReqMst);//no data 메시지 숨기기
  cfShowDSWaitMsg(gr_purchReqMst);//progress bar 보이기
  mode = "";
</script>

<!-- Hub In Header 조회 DataSet -->
<script language=JavaScript for=ds_purchReqMst event=OnLoadCompleted(rowCnt)>
  cfHideDSWaitMsg(gr_purchReqMst);//progress bar 숨기기
  cfFillGridNoDataMsg(gr_purchReqMst,"gridColLineCnt=2");//no data found   
  mode = "";
</script>

<script language=JavaScript for=ds_purchReqMst event=OnLoadError()>
  cfShowErrMsg(ds_purchReqMst);
  //mode = "";
</script>

<!-- Hub In Confirm Detail 조회 DataSet -->
<script language=JavaScript for=ds_purchReqDtl event=OnLoadCompleted(rowCnt)>
  cfFillGridNoDataMsg(gr_purchReqDtl,"gridColLineCnt=2");//no data found   
</script>

<script language=JavaScript for=ds_purchReqDtl event=OnLoadError()>
  cfShowErrMsg(ds_purchReqDtl);
</script>

<script language="javascript"  for=gr_purchReqMst event=OnCheckClick(row,colid,check)>

</script>

<script language="javascript"  for=ds_purchReqMst event=OnRowPosChanged(row)>

	//Detail Dataset Clear
  	ds_purchReqDtl.ClearData();
  
	if ( row > 0 ) {
	    var condition = "?";
		condition += "&companyCd="+ds_purchReqMst.NameValue(row,"companyCd");
		condition += "&prNo="+ds_purchReqMst.NameValue(row,"prNo");
		ds_purchReqDtl.DataID = "po.oc.retrievePurchReqDtlAppr.gau"+condition;
		ds_purchReqDtl.Append();
	}

</script>

<!-- 전체 체크박스 선택/해제 -->
<script language=JavaScript for=gr_purchReqMst event=OnHeadCheckClick(Col,Colid,bCheck)>

</script>

<script language=JavaScript for=gr_purchReqDtl event=OnClick(row,colid)>

</script>

<script language=JavaScript for=DataSetID event=OnColumnChanged(row,colid)>

</script>

<!-- 저장 TR -->
<script language=JavaScript for=tr_cudData event=OnSuccess()>
	mode = "";
	alert("Success");
	f_Retrieve();
</script>

<script language=JavaScript for=tr_cudData event=OnFail()>
  if(tr_cudData.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
        window.parent.location.href = "/index.jsp";    
   }
   mode = "";
   
  	alert("Error Code : " + tr_cudData.ErrorCode + "\n" + "Error Message : " + tr_cudData.ErrorMsg + "\n");  
</script>

<script language="javascript"  for=gr_purchReqDtl event=OnColumnPosChanged(row,colid)>
    
    // SEARCH 버튼  DISPLAY
    if (colid.toLowerCase() == "maternm") cfSetSearchGridBtn(gr_purchReqDtl);
    if (colid.toLowerCase() == "vendnm") cfSetSearchGridBtn(gr_purchReqDtl);
    
</script>

<script language=JavaScript for=ds_purchReqDtl event=OnColumnChanged(row,colid)>

	if ( colid == "qty" || colid == "price") {
		var qty   = ds_purchReqDtl.NameValue(row,"qty");
		var price = ds_purchReqDtl.NameValue(row,"price");
		ds_purchReqDtl.NameValue(row,"amount") = qty * price;
		
		var currencyCd = ds_purchReqDtl.NameValue(row,"currencyCd");
		if ( currencyCd == "IDR") {
			ds_purchReqDtl.NameValue(row,"idrAmt") = qty * price;
		} 
	}

</script>

<script language="javascript"  for=gr_purchReqDtl event=OnPopup(Row,Colid,data)>

    if ( Colid == "materNm") {
    	openMaterialCodeListGridWin(Row, ds_purchReqDtl);
    } else if ( Colid == "vendNm") {
    	openVendorCodeListGridWin(Row, ds_purchReqDtl);
    }

</script>



</head>

<body id="cent_bg">

<div id="conts_box">
	<h2> <span><%= columnData.getString("page_title") %></span></h2>

	<!--검색 S -->	
	 <fieldset class="boardSearch">
		<div>
			 <dl>
				<dt> 
					<table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board2" >
						<colgroup>
							<col width="15%"/>
							<col width="22%"/>
							<col width="13%"/>
							<col width="15%"/>
							<col width="18%"/>
							<col width=""/>
						</colgroup>
						<tr>
							<th><%= columnData.getString("req_dept_nm1") %></th>
							<td>

								<object id="deptCd"  classid="<%=LGauceId.LUXECOMBO%>" align="absmiddle" width="100">
								    <param name="ComboDataID"       value="ds_deptCode">
									<param name="ListCount"     	value="10">
									<param name=SyncComboData       value="false">
									<param name="BindColumn"    	value="code">
									<param name=SyncComboData       value="false">
								    <param name=ListExprFormat		value="name^0^90,code^0^70">
								    <param name=index           	value=0>
							   	</object>
							</td>										
							<th><%= columnData.getString("pr_no") %></th>
							<td>
								<input type="text" id="prNoS" style="width:60px;"/>
							</td>
							<th><%= columnData.getString("status") %></th>
							<td>
								<object id="statusS"  classid="<%=LGauceId.LUXECOMBO%>" align="absmiddle" width="100">
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
							<th><%= columnData.getString("req_date") %></th>
							<td colspan=5>
								<input type="text" id="orderDateFrom" value="<%= prevDate %>" 		style="width:60px;"/>&nbsp;<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(orderDateFrom);" style="cursor:hand"/> ~ 
								<input type="text" id="orderDateTo"   value="<%= currentDate %>" 	style="width:60px;"/>&nbsp;<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(orderDateTo);" style="cursor:hand"/>
							</td>
						</tr>
					</table>
				 </dt>              		  	   	 	
				 <dd class="btnseat2"> 
				 	  <span class="search_btn2_r search_btn2_l">
                			  <input type="button" onfocus="blur();" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='#e2ebf7'" value="<%=btnSearch %>" onclick="f_Retrieve();"/></span> 
				 </dd>

			</dl>
		</div>
		</fieldset>
      <!--검색 E -->

	<div class="sub_stitle"> <p><%= columnData.getString("sub1_title") %></p> </div>     	
	<!-- 그리드 S -->	
    <div>

	<object id="gr_purchReqMst" classid="<%=LGauceId.GRID %>" style="width:100%;height:130px;"
		dataName="Purch Request Mst" class="comn"
	    validFeatures="ignoreStatus=no"
		validExp="">
		<param Name="DataID" 			value='ds_purchReqMst'>
	    <Param name="AutoResizing"      value=true>
	    <param name="ColSizing"         value=true>
	    <Param name="DragDropEnable"    value=True>
	    <param name="AddSelectRows"     value=True>
	    <Param name="SortView"          value="right">
		<PARAM Name="TitleHeight"      	value="30">
	    <param name="Editable"          value=True>
	    <param name="UsingOneClick"     value=1>
		<param Name='Format'
			value='
           		<C> id=seq         		name="<%= columnData.getString("seq") %>"            align="center"   width="30"    Edit="none"   Value={CurRow} </C>
                <C> id=companyCd      	name="<%= columnData.getString("company_cd") %>"     align="center"   width="70"    Edit="none"   show="false"  </C> 
                <C> id=prNo           	name="<%= columnData.getString("pr_no") %>"          align="center"   width="100"    Edit="none"   show="true"   </C>
                <C> id=reqDeptCd      	name="<%= columnData.getString("req_dept_cd") %>"    align="center"   width="70"    Edit="none"   show="false"  </C>
                <C> id=reqDeptNm     	name="<%= columnData.getString("req_dept_nm2") %>"   align="left"   width="100"    Edit="none"   show="true"   </C>
                <C> id=requester        name="<%= columnData.getString("requester") %>"      align="left"   width="70"    Edit="none"   show="true"  </C>
                <C> id=purComment      	name="<%= columnData.getString("pur_comment") %>"    align="left"   width="100"    Edit="none"   show="true"   </C>
                <C> id=reqDate         	name="<%= columnData.getString("req_date") %>"       align="center"   width="100"    Edit="none"   show="true"   </C>
                <C> id=deliReqDate    	name="<%= columnData.getString("deli_req_date1") %>" align="center"   width="100"    Edit="none"   show="true"   </C>
                <C> id=idrAmt           name="<%= columnData.getString("idr_amt2") %>"       align="right"   width="100"    Edit="none"   show="true"   </C>
                <C> id=budget           name="<%= columnData.getString("budget") %>"         align="right"   width="100"    Edit="none"   show="true"   </C>
                <C> id=purDeptCd        name="<%= columnData.getString("pur_dept_cd") %>"    align="right"   width="100"    Edit="true"   show="true"  EditStyle=Lookup ListWidth=130 Data="ds_deptCode:code:name:code" LookupDisplay="name" ListLine="true" </C>
                <C> id=status           name="<%= columnData.getString("status") %>"         align="center"   width="100"    Edit="none"   show="false"   </C>
                <C> id=statusNm         name="<%= columnData.getString("status_nm") %>"      align="left"   width="100"    Edit="none"   show="true"   </C>
                <C> id=purDeptCd      	name="<%= columnData.getString("pur_dept_cd") %>"    align="center"   width="70"    Edit="none"   show="false"  </C>
	      '>
	</object>
 	</div>


    <!-- 그리드 E -->	
	<div class="sub_stitle"> <p> <%= columnData.getString("sub2_title") %> </p> </div> 
	<!-- 그리드 S -->	
    <div id="output_board_area">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board" >
		<colgroup>
	        <col width="15%"/>
	        <col width="20%"/>
	        <col width="15%"/>
	        <col width="20%"/>
	        <col width="15%"/>
	        <col width=""/>
		</colgroup>    
	    <tr>
		  <th><%= columnData.getString("pr_no") %></th>
		  <td><input type="text" id="prNo" 	style="width:100px;" maxlength="10" readonly class="txtField_read"></td>
		  <th><%= columnData.getString("req_dept_cd") %></th>
		  <td><input type="text" id="prNo" 	style="width:100px;" maxlength="10" readonly class="txtField_read"></td>
		  <th><%= columnData.getString("pur_dept_cd") %></th>
		  <td>
			<object id="purDeptCd"  classid="<%=LGauceId.LUXECOMBO%>" align="absmiddle" width="100">
			    <param name="ComboDataID"       value="ds_deptCode">
				<param name="ListCount"     	value="10">
				<param name="BindColumn"    	value="code">
				<param name=SyncComboData       value="false">
				<param name=Enable              value="true">
			    <param name=ListExprFormat		value="name^0^90,code^0^70">
			    <param name=index           	value=0>
		   	</object>
		  </td>
		</tr>
	    <tr>
		  <th><%= columnData.getString("pur_comment") %></th>
		  <td colspan="5"><input type="text" id="purComment" style="width:200px;" maxlength=30></td>  
		</tr>
	  </table>
	</div>

	<object id=bd_purchAppr classid="<%=LGauceId.BIND%>">
		<param name=DataID value=ds_purchReqMst>
		<param name=BindInfo 
			value='
                <C> Col=companyCd       Ctrl=companyCd      Param=value  </C>
                <C> Col=prNo            Ctrl=prNo           Param=value  </C>
                <C> Col=reqDeptNm       Ctrl=reqDeptNm      Param=value  </C>
                <C> Col=purComment      Ctrl=purComment     Param=value  </C>
                <C> Col=purDeptCd       Ctrl=purDeptCd      Param=BindColVal </C>
	  		'>
	</object>

    <div class="sub_stitle"> <p><%= columnData.getString("sub3_title") %></p>
    	<p class="rightbtn"> 
          <span class="sbtn_r sbtn_l">
          <input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="<%= btnAddRow %>" onclick="f_Add();"/></span> 
          <span class="sbtn_r sbtn_l"> 
          <input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="<%= btnDelRow %>" onclick="f_Del();"/></span>
        </p>
	</div>

	<!-- 그리드 S -->	
    <div>

	<object id="gr_purchReqDtl" classid="<%=LGauceId.GRID %>" style="width:100%;height:130px;"
		dataName="Purch Request Dtl" class="comn"
	    validFeatures="ignoreStatus=no"
		validExp="companyCd::yes:maxlength=4:key
				  ,materType::yes:maxlength=1:key
				  ,materCd::yes:maxlength=18:key">
		<param Name="DataID" 			value="ds_purchReqDtl">
		<Param Name="AutoResizing" 		value="true">
		<param name="ColSizing" 		value="true">
		<Param Name="DragDropEnable"	value="True">
		<param Name="AddSelectRows" 	value="True">
		<Param NAME="Sort"              value="true">
		<Param Name="SortView" 			value="right">
		<param name="UsingOneClick" 	value="1">
		<param Name="Editable" 			value="true">
		<param Name="Format"
			value='
           		<C> id=seq         	name="<%= columnData.getString("seq") %>"      		align="center"  width="30"    Edit="none"   Value={CurRow} </C>
                <C> id=companyCd    name="<%= columnData.getString("company_cd") %>"    align="center"  width="70"    Edit="none"   show="false"  </C>
                <C> id=prNo         name="<%= columnData.getString("pr_no") %>"         align="center"  width="70"    Edit="none"   show="false"  </C>
                <C> id=prDetailNo   name="<%= columnData.getString("pr_detail_no") %>"  align="center"  width="70"    Edit="none"   show="false"  </C>
                <C> id=materType  	name="<%= columnData.getString("mater_type") %>"    align="left"    width="100"   Edit="true"   show="true"  EditStyle=Lookup ListWidth=80 Data="ds_mastaCode:code:name:code" LookupDisplay="name" ListLine="true"</C>
                <C> id=materCd      name="<%= columnData.getString("mater_cd") %>"      align="center"  width="70"    Edit="none"   show="false"  </C>
                <C> id=materNm  	name="<%= columnData.getString("mater_nm") %>"    	align="left"   	width="100"   Edit="true"   show="true"  EditStyle=PopupFix</C>
                <C> id=urgentType  	name="<%= columnData.getString("urgent_type") %>"  	align="left"    width="100"   Edit="true"   show="true"  EditStyle=Lookup ListWidth=80 Data="ds_urgentTypeCode:code:name:code" LookupDisplay="name" ListLine="true" </C>
                <C> id=vendCd       name="<%= columnData.getString("vend_cd") %>"     	align="center"  width="100"   Edit="true"   show="false"  </C>
                <C> id=vendNm       name="<%= columnData.getString("vend_nm") %>"     	align="left"   	width="100"   Edit="true"   show="true"  EditStyle=PopupFix</C>
                <C> id=prDesc       name="<%= columnData.getString("pr_desc") %>"       align="left"   	width="70"    Edit="true"   show="true"  </C>
                <C> id=unit         name="<%= columnData.getString("unit") %>"          align="left"   	width="50"    Edit="none"   show="true"  </C>
                <C> id=qty          name="<%= columnData.getString("qty") %>"           align="right"   width="70"    Edit="true"   show="true"  </C>
                <C> id=vatCd        name="<%= columnData.getString("vat_cd") %>"        align="left"   	width="120"   Edit="true"   show="true"  EditStyle=Lookup ListWidth=130 Data="ds_vatCode:code:name:code" LookupDisplay="name" ListLine="true" </C>
                <C> id=currencyCd   name="<%= columnData.getString("currency_cd") %>"   align="left"  	width="50"    Edit="true"   show="true"  EditStyle=Lookup ListWidth=80 Data="ds_curCode:code:name:code"  LookupDisplay="name" ListLine="true" </C>
                <C> id=price        name="<%= columnData.getString("price") %>"         align="right"   width="100"   Edit="true"   show="true"  </C>
                <C> id=amount       name="<%= columnData.getString("amount") %>"        align="right"   width="100"   Edit="true"   show="true"  </C>
                <C> id=idrAmt       name="<%= columnData.getString("idr_amt") %>"       align="right"   width="100"   Edit="true"   show="true"  </C>
                <C> id=poStatus     name="<%= columnData.getString("po_status") %>"     align="left"    width="100"   Edit="none"   show="true"  EditStyle=Lookup ListWidth=130 Data="ds_poStatusCode:code:name:code" LookupDisplay="name" ListLine="true"</C>
                <C> id=deliLoct     name="<%= columnData.getString("deli_loct") %>"     align="left"    width="100"   Edit="true"   show="true"  EditStyle=Lookup ListWidth=130 Data="ds_deliLocCode:code:name:code"  LookupDisplay="name" ListLine="true"</C>
	      '>
	</object>
 	</div>
      
	<!-- 버튼 S -->	
    <div id="btn_area">
    	<p class="b_right">
    	<span class="btn_r btn_l"><input type="button" onClick="f_Approval();" 	onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%= btnApproval %>"/></span>
    	<span class="btn_r btn_l"><input type="button" onClick="f_Cancel();" 	onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%= btnCancel %>"/></span>
		<span class="btn_r btn_l"><input type="button" onClick="f_Save();" 		onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%= btnSave %>"/></span>
    	</p>
   	</div>
    <!-- 버튼 E -->
        
    
    <div class="pad_t5"></div>

<!--script src="/debug_utf8.js"></script-->

        	  
</div>
</body>
</html>
