<!DOCTYPE html >
<html>
<%@ include file="/include/doctype.jsp"%>
<%--
/*
 *********************************************************************************
 * @source  : paymentRequestConfirm.jsp
 * @desc    : 출금 요청 승인 화면
 *--------------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -------------------------------------------------
 * 1.0  2015/12/07	 hckim		 Init      		 		  
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
	String prevDate	            = LDateUtils.getDate("yyyy/MM/") +"01"; 
	String currentDate          = LDateUtils.getDate("yyyy/MM/dd");
	String msgInfoChange        = source.getMessage("dev.inf.com.nochange");           // no data for change.
	String msgSave              = source.getMessage("dev.cfm.com.save");               // Are you sure to save?
	String msgDelete            = source.getMessage("dev.cfm.com.delete");             // Are you sure to Delete?
	String msgContinue          = source.getMessage("dev.cfm.com.continue");           // Are you sure to Continue?	
	String msgSelectRequestNo   = source.getMessage("dev.warn.com.selectRequestNo");   // Please select least one Request No.		
	String msgCheckRequestDate  = source.getMessage("dev.warn.com.checkRequestDate");  // Check searching condition.(Request date)		
%> 

<head>

<script type="text/javascript">
parent.centerFrame.cols='220,*';
//-------------------------------------------------------------------------
// 초기값 셋팅	 	
//-------------------------------------------------------------------------		
function init(){

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
// Search 버튼 클릭 시 Payment Request Confirm List 정보 조회
//-------------------------------------------------------------------------		
function f_Retrieve() {
	
	if (checkData()) {
		
		var condition = "?";
		    condition += "requestDateFrom=" + removeDash(document.all.requestDateFrom.value,"/");
		    condition += "&requestDateTo=" + removeDash(document.all.requestDateTo.value,"/");
		    condition += "&baselineDate=" + removeDash(document.all.baselineDate.value,"/");		   
		    condition += "&vendCd=" + sVendCd.ValueOfIndex("code",sVendCd.Index);	
		    condition += "&currCd=" + sCurrCd.ValueOfIndex("code",sCurrCd.Index);		
		
		ds_gridMst.DataID = "fi.tr.retrieveConfirmRequestList.gau"+condition;
		ds_gridMst.Reset();
	}
}

//-------------------------------------------------------------------------
// 검색 필수 체크
//-------------------------------------------------------------------------
function checkData() {
	
	var requestDateFrom = removeDash(document.all.requestDateFrom.value,"/");
	var requestDateTo   = removeDash(document.all.requestDateTo.value,"/");
	
	// 요청 시작일자, 종료일자가 모두 있는 경우
	if(requestDateFrom != "" && requestDateTo != ""){
		
		// 요청시작일자가 요청종료일자보다 클 경우
		if(Number(requestDateFrom) > Number(requestDateTo)){
			alert('<%= msgCheckRequestDate %>');
			return false;
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
		
//----------------------------------------------------------------------------------------------------------------
// Approval 버튼 클릭 시 (Status 변경 ( B[Request] -> D[Confirm] )), SAP 호출 (AP전표 상태를 D(승인)로 변경)
//----------------------------------------------------------------------------------------------------------------			
function f_UpdateStatus(){
	
	var chk_cnt = 0;
	
	for(var i=1; i <= ds_gridMst.countRow; i++){

		if(ds_gridMst.NameValue(i,"chk") == "T"){						
									
			chk_cnt = chk_cnt + 1;
		}				
	}

	if( chk_cnt == 0 ) {
		alert('<%= msgSelectRequestNo %>');
		return;
	}
	
	if (checkSaveData()) {

		//Dataset 저장		
		saveCudData();

		if (confirm('<%= msgContinue %>')) {
			
			mode = "process";								
					  			  
			tr_cudData.KeyValue	= "JSP(I:IN_DS1=ds_cudMstData)";
			tr_cudData.Action   = "fi.tr.cudPaymentRequestConfirmStatus.gau";			
	 		tr_cudData.Post();
	 	}
	
	}
}

//-----------------------------------------------------------------------------------------------------------
// Reject 버튼 클릭 시 - (Status 변경 ( B[Request] -> C[Reject] ), SAP 호출 (AP전표 상태를 C(반려)로 변경)
//-----------------------------------------------------------------------------------------------------------			
function f_RejectPaymentRequest(){
	
	var chk_cnt = 0;
	
	for(var i=1; i <= ds_gridMst.countRow; i++){

		if(ds_gridMst.NameValue(i,"chk") == "T"){														
										
			chk_cnt = chk_cnt + 1;
		}				
	}

	if( chk_cnt == 0 ) {
		alert('<%= msgSelectRequestNo %>');
		return;
	}
	
	if (checkSaveData()) {

		//Dataset 저장		
		saveCudData();

		if (confirm('<%= msgContinue %>')) {
			
			mode = "process";								
					  			  
			tr_cudData.KeyValue	= "JSP(I:IN_DS1=ds_cudMstData)";
			tr_cudData.Action   = "fi.tr.cudPaymentRequestReject.gau";			
	 		tr_cudData.Post();
	 	}
	
	}
}

//-------------------------------------------------------------------------
// validation (유효성 체크)
//-------------------------------------------------------------------------					
function checkSaveData() {
	
	return true;
}			

//-------------------------------------------------------------------------
// Approval, Reject 버튼 클릭 시 Parameter 데이타셋 저장
//-------------------------------------------------------------------------
function saveCudData() {

	//파라메타 데이타셋 설정하는 부분 시작
	if( ds_cudMstData.CountColumn == 0 ) {
		var strHeader = "companyCd:VARCHAR(50),"
			          + "requestNo:VARCHAR(50)";
		
		ds_cudMstData.SetDataHeader(strHeader);
	}

	ds_cudMstData.ClearData();
	
	for(var i=1; i <= ds_gridMst.countRow; i++){
		if(ds_gridMst.NameValue(i,"chk") == "T"){
			ds_cudMstData.AddRow();
			
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"companyCd") = ds_gridMst.NameValue(i,"companyCd");
			ds_cudMstData.NameValue(ds_cudMstData.RowPosition,"requestNo") = ds_gridMst.NameValue(i,"requestNo");
			
		}
	}
	
}				



</script>

<!-----------------------------------------------------------------------------
		 D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- Grid  DataSet-->
<object id="ds_gridMst" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad" value="true">
	<param name="ViewDeletedRow" value="true">
</object>

<!-- Grid 용 Detail DataSet-->
<object id="ds_gridDtl" classid="<%=LGauceId.DATASET%>" >
  	<param name="SyncLoad"       value="true">
  	<param name="ViewDeletedRow" value="true">
</object>

<!-- vendor Combo 용 DataSet-->
<object id="ds_vendor" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad" value="true">
	<param name="DataID"   value="cm.cm.retrieveCommComboVendorList.gau?firstVal=Total">
</object>

<!-- currency code combo 용 DataSet -->
<object id="ds_currencyCode" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad" value="true">
	<param name="DataID"   value="cm.cm.retrieveCommCodeCombo.gau?groupCd=2004&firstVal=Total">
</object>

<!-- payment method combo 용 DataSet -->
<object id="ds_paymentMethod" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad" value="true">
	<param name="DataID"   value="cm.cm.retrieveCommCodeCombo.gau?groupCd=TRPM&firstVal=Total">
</object>


<!-- 저장, 수정, 삭제 DataSet -->
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
<script language=JavaScript for=ds_gridMst event=OnLoadStarted()>
	cfHideNoDataMsg(gr_gridMst);//no data 메시지 숨기기
  	cfShowDSWaitMsg(gr_gridMst);//progress bar 보이기
  	mode = "";
</script>

<script language=JavaScript for=ds_gridMst event=OnLoadCompleted(rowCnt)>
  	cfHideDSWaitMsg(gr_gridMst);//progress bar 숨기기
  	cfFillGridNoDataMsg(gr_gridMst,"gridColLineCnt=2");//no data found   
  	mode = "";
</script>

<script language=JavaScript for=ds_gridMst event=OnLoadError()>
  	cfShowErrMsg(gr_gridMst);
  	mode = "";
</script>

<script language=javascript for=ds_gridMst event=OnRowPosChanged(row)>

	//Detail Dataset Clear
  	ds_gridDtl.ClearData();
	
	if ( row > 0 ) {
	    var condition = "?";
		condition += "&companyCd="+ds_gridMst.NameValue(row,"companyCd");
		condition += "&requestNo="+ds_gridMst.NameValue(row,"requestNo");		
		ds_gridDtl.DataID = "fi.tr.retrievePaymentApInvoiceList.gau"+condition;
		ds_gridDtl.Append();
	}

</script>

<script language=JavaScript for=tr_cudData event=OnFail()>
    mode = "";
    if(tr_cudData.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
        window.parent.location.href = "/index.jsp";    
    }
    alert(tr_cudData.ErrorMsg);
</script>

<script language=JavaScript for=tr_cudData event=OnSuccess()>	
    alert("successfully saved.");
    f_Retrieve();
</script>

<!-- 전체 체크박스 선택/해제 -->
<script language=JavaScript for=gr_gridMst event=OnHeadCheckClick(Col,Colid,bCheck)>

	// 전체 체크박스 해제
	if(bCheck == 0){

		for(var i=1; i <= ds_gridMst.countRow; i++){
			ds_gridMst.Namevalue(i,"chk") = "F";
		}
	
	// 전체 체크박스 선택
	}else{
	  
		for(var i=1; i <= ds_gridMst.countRow; i++){
			ds_gridMst.Namevalue(i,"chk") = "T";
		}				
	}
</script>

</head>

<body id="cent_bg" onload="init();">

<div id="conts_box">
	<h2><span><%=columnData.getString("page_title") %></span></h2>

	<!-- Payment Request Confirm 검색 영역 Start -->					
	<fieldset class="boardSearch">
		<div>
			<dl>
				<dt> 
					<table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board2" >
						<colgroup>
							<col width="15%"/>
							<col width="40%"/>
							<col width="12%"/>
							<col width=""/>
						</colgroup>
						<tr>
							<th><%= columnData.getString("request_date") %></th>
							<td>
								<input type="text" id="requestDateFrom" value="<%= prevDate %>" onblur="valiDate(this);" style="width:60px;" readonly />&nbsp;
								<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(requestDateFrom);" style="cursor:hand"/> ~ 
								<input type="text" id="requestDateTo"   value="<%= currentDate %>" onblur="valiDate(this);" style="width:60px;" readonly />&nbsp;
								<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(requestDateTo);" style="cursor:hand"/>								
							</td>										
							<th><%= columnData.getString("baseline_date") %></th>
							<td>
								<input type="text" id="baselineDate" style="width:60px;" readonly />&nbsp;
								<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(baselineDate);" style="cursor:hand"/>									
							</td>
						</tr>
						<tr>
							<th><%=columnData.getString("vend") %> </th>		
							<td>
								<comment id="__NSID__">
									<object id="sVendCd"  classid="<%=LGauceId.LUXECOMBO%>" width="150">
										<param name="ComboDataID"   value="ds_vendor">
										<param name="ListCount"     value="10">
										<param name=SearchColumn	value="name">
										<param name="BindColumn"    value="code">
										<param name=ListExprFormat	value="name^0^150,code^0^70"> 
										<param name=index           value=0>
									</object>
								</comment>
								<script>__WS__(__NSID__); </script>
							</td>
							<th><%=columnData.getString("curr_cd") %> </th>		
							<td>
								<comment id="__NSID__">
									<object id="sCurrCd"  classid="<%=LGauceId.LUXECOMBO%>" width="150">
									    <param name="ComboDataID"       value="ds_currencyCode">
										<param name="ListCount"     	value="10">
										<param name="BindColumn"    	value="code">
										<param name="WantSelChgEvent"   value="TRUE">
									    <param name=ListExprFormat		value="name^0^90,code^0^70">
									    <param name=index           	value=0>
								   	</object>
								</comment>
								<script>__WS__(__NSID__); </script>
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
	<!-- Payment Request Confirm 검색 영역 End -->

	<div class="sub_stitle">
		<p><%=columnData.getString("sub1_title") %></p>		
	</div>
 	
	<!-- Request List GRID 영역 Start -->
	<div>
		<object id="gr_gridMst" classid="<%=LGauceId.GRID %>" style="width:100%;height:200px;" class="comn" dataName="payment request" validFeatures="ignoreStatus=no" validExp="">
			<param Name="DataID" 			value='ds_gridMst'>
	    	<Param name="AutoResizing"      value=true>	 
	    	<param name="Editable"          value=True>
	    	<Param NAME="TitleHeight"      	value="30">
			<param Name='Format' value='
				<c>id="chk"    	         name="<%=columnData.getString("chk") %>"                                width="40"   Edit="true"  show="true"  {IF(returnMsg="","White","Red")}  EditStyle=CheckBox	HeadAlign=center HeadCheck=false HeadCheckShow=true  </c> 																					
				<c>id="requestNo"        name="<%=columnData.getString("request_no") %>"         align="left"    width="110"  Edit="none"  show="true"  </c>
	        	<c>id="requestDate"      name="<%=columnData.getString("request_date") %>"       align="center"  width="90"   Edit="none"  show="true"  Mask="XXXX/XX/XX"  </c>	        										        					        	 		
	        	<c>id="statusNm"  	     name="<%=columnData.getString("status") %>"             align="center"  width="110"  Edit="none"  show="true"  </c>	        	
	        	<c>id="vendCd"           name="<%=columnData.getString("vend_code") %>"          align="center"  width="105"  Edit="none"  show="true"  </c> 		
	        	<c>id="vendNm"           name="<%=columnData.getString("vend_name") %>"          align="left"    width="105"  Edit="none"  show="true"  </c>   		
	        	<c>id="totalAmount"  	 name="<%=columnData.getString("total_amount") %>"       align="center"  width="110"  Edit="none"  show="true"  </c>
	        	<c>id="currCd"  	     name="<%=columnData.getString("curr_cd") %>"            align="center"  width="110"  Edit="none"  show="true"  </c>
	        	<c>id="baselineDate"  	 name="<%=columnData.getString("baseline_date") %>"      align="center"  width="110"  Edit="none"  show="true"  Mask="XXXX/XX/XX"  </c>
	        	<c>id="sapRtnMsg"  	     name="<%=columnData.getString("sap_return_msg") %>"     align="center"  width="110"  Edit="none"  show="true"  </c>	        		        	
	        	<c>id="paymentMethodNm"  name="<%=columnData.getString("payment_method") %>"     align="left"    width="115"  Edit="none"  show="true"  </c> 		
	        	<c>id="partnerBankType"  name="<%=columnData.getString("partner_bank_type") %>"  align="left"    width="130"  Edit="none"  show="true"  </c>			    				        					        		        	 	        		        		        		        		        	
	        	<c>id="status"  	     name="<%=columnData.getString("status") %>"             align="center"  width="110"  Edit="none"  show="false" </c>
	        	<c>id="companyCd"  	                                                             align="center"  width="110"  Edit="none"  show="false" </c>
	        	<c>id="paymentMethod"    name="<%=columnData.getString("payment_method") %>"     align="left"    width="115"  Edit="none"  show="false" </c>  '>
	        	
	        </param>	      
		</object>
 	</div>	
	<!-- Request List GRID 영역 End -->
	
	<div class="sub_stitle">
		<p><%=columnData.getString("sub2_title") %></p>
	</div>
	
	<!-- Payment AP Invoice List 영역 Start -->
	<div>
		<object id="gr_gridDtl" classid="<%=LGauceId.GRID %>" style="width:100%;height:200px;" class="comn" dataName="payment request" validFeatures="ignoreStatus=no" validExp="">
			<param Name="DataID" 			value='ds_gridDtl'>
	    	<Param name="AutoResizing"      value=true>	 
	    	<param name="Editable"          value=True>
	    	<Param NAME="TitleHeight"      	value="30">
			<param Name='Format' value='				 																					
				<c>id="docNo"     name="<%=columnData.getString("doc_no") %>"     align="left"    width="110"  Edit="none"  show="true"  </c>
				<c>id="acctCd"    name="<%=columnData.getString("acct_cd") %>"    align="left"    width="105"  Edit="none"  show="true"  </c>   		
	        	<c>id="acctNm"    name="<%=columnData.getString("acct_nm") %>"    align="left" 	  width="115"  Edit="none"  show="true"  </c>
				<c>id="amount"    name="<%=columnData.getString("amount") %>"     align="left"    width="105"  Edit="none"  show="true"  </c>
				<c>id="docDesc"   name="<%=columnData.getString("doc_desc") %>"   align="center"  width="105"  Edit="none"  show="true"  </c>								
	        	<c>id="docDate"   name="<%=columnData.getString("doc_date") %>"   align="center"  width="95"   Edit="none"  show="true"  Mask="XXXX/XX/XX"  </c>	        										        					        	 		
	        	<c>id="postDate"  name="<%=columnData.getString("post_date") %>"  align="center"  width="100"  Edit="none"  show="true"  Mask="XXXX/XX/XX"  </c> 			        	 			        				    				        					        		        		        		        	
	        	<c>id="lineItem"  name="<%=columnData.getString("line_item") %>"  align="center"  width="90"   Edit="none"  show="false" </c>	        	
	        	<c>id="companyCd"                                                 align="center"  width="105"  Edit="none"  show="false" </c>
	        	<c>id="requestNo"                                                 align="center"  width="105"  Edit="none"  show="false" </c>
	        	<c>id="fiscalYear"                                                align="center"  width="105"  Edit="none"  show="false" </c>
	        	<c>id="baselineDate"                                              align="center"  width="105"  Edit="none"  show="false" </c>
	        	<c>id="paymentMethod"                                             align="center"  width="105"  Edit="none"  show="false" </c>
	        	<c>id="partnerBankType"                                           align="center"  width="105"  Edit="none"  show="false" </c>  '>	        	
	        </param>	      
		</object>		
	</div>
	<!-- Payment AP Invoice List 영역 End -->
			
	<!-- 하단 버튼 영역 Start -->
	<div id="btn_area">
		<p class="b_right">
			<span class="btn_r btn_l"> 
				<input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnApproval %>" onclick="f_UpdateStatus();" />
			</span>&nbsp;
			<span class="btn_r btn_l"> 
				<input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnReject %>" onclick="f_RejectPaymentRequest();" />
			</span>
		</p>
	</div>
	<!-- 하단 버튼 영역 End --> 	

</div>	
</body>
</html>