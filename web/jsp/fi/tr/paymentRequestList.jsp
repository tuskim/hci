<!DOCTYPE html >
<html>
<%@ include file="/include/doctype.jsp"%>
<%--
/*
 *********************************************************************************
 * @source  : paymentRequestList.jsp
 * @desc    : 출금 요청 리스트 화면
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
	String msgRequest           = source.getMessage("dev.cfm.com.request");            // Are you sure to request?
	String msgSelectRequestNo   = source.getMessage("dev.warn.com.selectRequestNo");   // Please select least one Request No.		
	String msgCheckRequestDate  = source.getMessage("dev.warn.com.checkRequestDate");  // Check searching condition.(Request date)
	String msgCheckStatusReq    = source.getMessage("dev.warn.com.checkStatusReq");    // Only 'Insert' status can be requested.
	String msgCheckStatusDel    = source.getMessage("dev.warn.com.checkStatusDel");    // Only 'Insert' status can be deleted.
	String msgCheckSapReturnMsg = source.getMessage("dev.warn.com.checkSapReturnMsg"); // SAP sending error, please check the message.
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
// Search 버튼 클릭 시 Payment Request List 정보 조회
//-------------------------------------------------------------------------		
function f_Retrieve() {
	
	if (checkData()) {
		
		var condition = "?";
		    condition += "requestDateFrom=" + removeDash(document.all.requestDateFrom.value,"/");
		    condition += "&requestDateTo=" + removeDash(document.all.requestDateTo.value,"/");
		    condition += "&baselineDate=" + removeDash(document.all.baselineDate.value,"/");
		    condition += "&status=" + sStatusCd.ValueOfIndex("code",sStatusCd.Index);
		    condition += "&vendCd=" + document.all.sVendCd.value;	
		    condition += "&currCd=" + sCurrCd.ValueOfIndex("code",sCurrCd.Index);		
		
		ds_gridMst.DataID = "fi.tr.retrieveRequestList.gau"+condition;
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


//-------------------------------------------------------------------------
// Request 버튼 클릭 시 (Status 변경 ( I[Insert] -> B[Request] ))
//-------------------------------------------------------------------------			
function f_UpdateStatus(){
	
	var chk_cnt = 0;
	
	for(var i=1; i <= ds_gridMst.countRow; i++){

		if(ds_gridMst.NameValue(i,"chk") == "T"){
			
			var status = ds_gridMst.NameValue(i,"status");       // Staust 정보 (I:Insert, C:Reject, B:Request, D:Confirm)
			var sapRtnMsg = ds_gridMst.NameValue(i,"sapRtnMsg"); // SAP Return Msg
						
			// Status 정보가 I(Insert)가 아닌경우
			if(status != "I"){
				alert("<%=msgCheckStatusReq%>");
				return;
			}
	
			// SAP Return Msg : Success 가 아닌경우
			if(sapRtnMsg != "Success"){
				alert("<%= msgCheckSapReturnMsg %>");
				return;
			}
									
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

		if (confirm('<%= msgRequest %>')) {
			
			mode = "process";								
					  			  
			tr_cudData.KeyValue	= "JSP(I:IN_DS1=ds_cudMstData)";
			tr_cudData.Action   = "fi.tr.cudPaymentRequestStatus.gau";			
	 		tr_cudData.Post();
	 	}
	
	}
}

//---------------------------------------------------------------------------------------------------
// Delete 버튼 클릭 시 - Request List 정보 삭제, SAP 호출 (AP전표 상태를 R(요청자 삭제시)로 변경)
//---------------------------------------------------------------------------------------------------			
function f_DeletePaymentRequest(){
	
	var chk_cnt = 0;
	
	for(var i=1; i <= ds_gridMst.countRow; i++){

		if(ds_gridMst.NameValue(i,"chk") == "T"){
			
			var status = ds_gridMst.NameValue(i,"status");       // Staust 정보 (I:Insert, C:Reject, B:Request, D:Confirm)
						
			// Status 정보가 I(Insert)가 아닌경우
			if(status != "I"){
				alert("<%=msgCheckStatusDel%>");
				return;
			}
										
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

		if (confirm('<%= msgDelete %>')) {
			
			mode = "process";								
					  			  
			tr_cudData.KeyValue	= "JSP(I:IN_DS1=ds_cudMstData)";
			tr_cudData.Action   = "fi.tr.cudPaymentRequestDelete.gau";			
	 		tr_cudData.Post();
	 	}
	
	}
}

//-------------------------------------------------------------------------
// Print 버튼 클릭 - 전표 출력
//-------------------------------------------------------------------------
function f_print(){  
	
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

	//Dataset 저장		
	saveCudData();																		  			  		 			
	
	tr_cudPageReport.Action   = "fi.tr.retrievePaymentRequestListPrint.gau";
	tr_cudPageReport.KeyValue = "Servlet(I:IN_DS1=ds_cudMstData, O:ds_report=ds_report)";	
	tr_cudPageReport.Post(); 	 
}

//-------------------------------------------------------------------------
//validation (유효성 체크)
//-------------------------------------------------------------------------					
function checkSaveData() {
	
	return true;
}			

//-------------------------------------------------------------------------
// Request, Delete 버튼 클릭 시 Parameter 데이타셋 저장
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

//-------------------------------------------------------------------------
//Vendor 조회 팝업
//-------------------------------------------------------------------------		
function f_openVendorPop() {	
	
	openVendorSapListWin();		
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

<!-- currency code combo 용 DataSet -->
<object id="ds_currencyCode" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad" value="true">
	<param name="DataID"   value="cm.cm.retrieveCommCodeCombo.gau?groupCd=2004&firstVal=Total">
</object>

<!-- Status combo 용 DataSet -->
<object id="ds_statusCode" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad" value="true">
	<param name="DataID"   value="cm.cm.retrieveCommCodeCombo.gau?groupCd=PMRS">
</object>

<!-- 저장, 수정, 삭제 DataSet -->
<object id="ds_cudMstData" classid="<%=LGauceId.DATASET%>"></object>

<!-- Print 출력용 DataSet -->
<object id="ds_report" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad" value="true"/> 
</object>

<!-----------------------------------------------------------------------------
  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- CUD TR -->
<OBJECT id=tr_cudData classid="<%=LGauceId.TR%>">
	<param name="KeyName" value="toinb_dataid4">
	<param name="ServerIP"  value="">
</OBJECT>

<!-- CUD Report -->
<object id=tr_cudPageReport classid="<%=LGauceId.TR%>">
    <param name="KeyName" value="toinb_dataid4"> 
</object>

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

<script language=JavaScript for=tr_cudPageReport event=OnFail()> 	
    mode = "";
    if(tr_cudPageReport.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
        window.parent.location.href = "/index.jsp";    
    }
    
    alert(tr_cudPageReport.ErrorMsg);
</script>   
 
<script language=JavaScript for=tr_cudPageReport event=OnSuccess()> 
 	report_page.Preview(); 	 
</script>

</head>

<body id="cent_bg" onload="init();">

<div id="conts_box">
	<h2><span><%=columnData.getString("page_title") %></span></h2>

	<!-- Payment Request List 검색 영역 Start -->
					
	<fieldset class="boardSearch">
		<div>
			<dl>
				<dt> 
					<table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board2" >
						<colgroup>
							<col width="15%"/>
							<col width="34%"/>
							<col width="11%"/>
							<col width="17%"/>
							<col width="9%"/>
							<col width=""/>
						</colgroup>
						<tr>
							<th><%= columnData.getString("request_date") %></th>
							<td>
								<input type="text" id="requestDateFrom" value="<%= prevDate %>" onblur="valiDate(this);" style="width:60px;" readonly />
								<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(requestDateFrom);" style="cursor:hand"/> ~ 
								<input type="text" id="requestDateTo"   value="<%= currentDate %>" onblur="valiDate(this);" style="width:60px;" readonly />
								<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(requestDateTo);" style="cursor:hand"/>								
							</td>										
							<th><%= columnData.getString("baseline_date") %></th>
							<td>
								<input type="text" id="baselineDate" style="width:60px;" readonly />
								<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(baselineDate);" style="cursor:hand"/>									
							</td>
							<th><%=columnData.getString("status") %></th>
							<td>
								<comment id="__NSID__">
									<object id="sStatusCd"  classid="<%=LGauceId.LUXECOMBO%>" width="95">
									    <param name="ComboDataID"       value="ds_statusCode">
										<param name="ListCount"     	value="10">
										<param name="BindColumn"    	value="code">
										<param name="WantSelChgEvent"   value="TRUE">
									    <param name=ListExprFormat		value="name^0^90,code^0^70">
									    <param name=index           	value=2>
								   	</object>
								</comment>
								<script>__WS__(__NSID__); </script>
							</td>
						</tr>
						<tr>
							<th><%=columnData.getString("vend") %> </th>		
							<td>
								<input type="text" id="sVendCd" name="sVendCd" style="width:60px;" />&nbsp;
					  			<img src="<%= images %>button/search_icon_2.gif"  onClick="javascript:f_openVendorPop();" style="cursor:hand"/>
					  		</td>														
							<th><%=columnData.getString("curr_cd") %> </th>		
							<td>
								<comment id="__NSID__">
									<object id="sCurrCd"  classid="<%=LGauceId.LUXECOMBO%>" width="95">
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
	<!-- Payment Request List 검색 영역 End -->

	<div class="sub_stitle">
		<p><%=columnData.getString("sub1_title") %></p>
		<p class="rightbtn">			 		
			<span class="sbtn_r sbtn_l"> 
				<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="<%=btnPrint %>" onclick="f_print();"/>
			</span>			  	 			   
		</p>
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
				<c>id="requestNo"        name="<%=columnData.getString("request_no") %>"         align="center"  width="110"  Edit="none"  show="true"  </c>
	        	<c>id="requestDate"      name="<%=columnData.getString("request_date") %>"       align="center"  width="90"   Edit="none"  show="true"  Mask="XXXX/XX/XX"  </c>	        										        					        	 		
	        	<c>id="statusNm"  	     name="<%=columnData.getString("status") %>"             align="center"  width="80"   Edit="none"  show="true"  </c>	        	
	        	<c>id="vendCd"           name="<%=columnData.getString("vend_code") %>"          align="center"  width="80"   Edit="none"  show="true"  </c> 		
	        	<c>id="vendNm"           name="<%=columnData.getString("vend_name") %>"          align="left"    width="170"  Edit="none"  show="true"  </c>   		
	        	<c>id="totalAmount"  	 name="<%=columnData.getString("total_amount") %>"       align="right"   width="110"  Edit="none"  show="true"  </c>
	        	<c>id="currCd"  	     name="<%=columnData.getString("curr_cd") %>"            align="center"  width="80"   Edit="none"  show="true"  </c>
	        	<c>id="baselineDate"  	 name="<%=columnData.getString("baseline_date") %>"      align="center"  width="90"   Edit="none"  show="true"  Mask="XXXX/XX/XX"  </c>
	        	<c>id="sapRtnMsg"  	     name="<%=columnData.getString("sap_return_msg") %>"     align="left"    width="320"  Edit="none"  show="true"  </c>	        	
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
				<c>id="docNo"     name="<%=columnData.getString("doc_no") %>"     align="center"  width="100"  Edit="none"  show="true"  </c>
				<c>id="acctCd"    name="<%=columnData.getString("acct_cd") %>"    align="center"  width="80"   Edit="none"  show="true"  </c>   		
	        	<c>id="acctNm"    name="<%=columnData.getString("acct_nm") %>"    align="left" 	  width="205"  Edit="none"  show="true"  </c>
				<c>id="amount"    name="<%=columnData.getString("amount") %>"     align="right"   width="140"  Edit="none"  show="true"  </c>
				<c>id="docDesc"   name="<%=columnData.getString("doc_desc") %>"   align="left"    width="120"  Edit="none"  show="true"  </c>								
	        	<c>id="docDate"   name="<%=columnData.getString("doc_date") %>"   align="center"  width="90"   Edit="none"  show="true"  Mask="XXXX/XX/XX"  </c>	        										        					        	 		
	        	<c>id="postDate"  name="<%=columnData.getString("post_date") %>"  align="center"  width="90"   Edit="none"  show="true"  Mask="XXXX/XX/XX"  </c> 			        	 			        				    				        					        		        		        		        	
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
<%--  Payment Request Confirm 사용하지 않음으로 해서 주석처리 2016/01/08  hckim 		
			<span class="btn_r btn_l"> 
				<input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnRequest %>" onclick="f_UpdateStatus();" />
			</span>&nbsp;
--%>			
			<span class="btn_r btn_l"> 
				<input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnCancel %>" onclick="f_DeletePaymentRequest();" />
			</span>
		</p>
	</div>
	<!-- 하단 버튼 영역 End --> 
	
	<!-- Print 화면 영역 Start -->
	<comment id="__NSID__">
	
		<object id="report_page" classid=<%=LGauceId.REPORTS%>>
			 
		 	<param name="DetailDataID"      value="ds_report">
			<param name="MasterDataID"      value="">    
			<param name="PaperSize"         value="A4">
			<param name=PreviewZoom		  	value="100" />
			<param name="Landscape"         value="false">
			<param name="EnglishUI"         value="true">
			<param name="PrintSetupDlgFlag" value="true">
			<param name="SuppressColumns"   value="1:PageSkip,requestNo">	
			<param name="PageSkip"          value="true">
		 	<param name=Format			    value="	 		 
		 		 		
		 		<B>id=Header ,left=0,top=0 ,right=2000 ,bottom=1984 ,face='Tahoma' ,size=10 ,penwidth=1
					<T>id='Payment Request' ,left=484 ,top=11 ,right=1413 ,bottom=156 ,face='Tahoma' ,size=19 ,bold=true ,underline=true ,italic=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
					<T>id='Fin. And' ,left=976 ,top=476 ,right=1124 ,bottom=537</T>
					<L> left=966 ,top=471 ,right=1942 ,bottom=471 </L>
					<T>id='Biz.' ,left=976 ,top=349 ,right=1124 ,bottom=468</T>
					<L> left=966 ,top=265 ,right=1939 ,bottom=265 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
					<L> left=968 ,top=344 ,right=1942 ,bottom=344 </L>
					<T>id='S.MGR' ,left=1630 ,top=275 ,right=1778 ,bottom=336</T>
					<T>id='MGR' ,left=1468 ,top=275 ,right=1617 ,bottom=336</T>
					<T>id='A.M' ,left=1304 ,top=275 ,right=1453 ,bottom=336</T>
					<T>id='By' ,left=1140 ,top=275 ,right=1289 ,bottom=336</T>
					<T>id='Class' ,left=974 ,top=275 ,right=1122 ,bottom=336</T>
					<L> left=966 ,top=611 ,right=1939 ,bottom=611 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
					<L> left=1783 ,top=265 ,right=1783 ,bottom=611 </L>
					<L> left=966 ,top=265 ,right=966 ,bottom=611 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
					<L> left=1622 ,top=265 ,right=1622 ,bottom=611 </L>
					<L> left=1130 ,top=265 ,right=1130 ,bottom=611 </L>
					<L> left=1296 ,top=265 ,right=1296 ,bottom=611 </L>
					<T>id='Acc.' ,left=979 ,top=542 ,right=1127 ,bottom=603</T>
					<L> left=45 ,top=786 ,right=45 ,bottom=1984 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
					<L> left=325 ,top=786 ,right=325 ,bottom=1984 </L>
					<C>id='bankAcct', left=339, top=1664, right=1934, bottom=1744</C>
					<T>id='Description' ,left=61 ,top=1886 ,right=320 ,bottom=1969</T>
					<T>id='House bank' ,left=58 ,top=1775 ,right=318 ,bottom=1857</T>
					<T>id='Bank A/C' ,left=58 ,top=1662 ,right=318 ,bottom=1744</T>
					<T>id='Bank code' ,left=556 ,top=1548 ,right=984 ,bottom=1630</T>
					<T>id='Swift' ,left=58 ,top=1548 ,right=318 ,bottom=1630</T>
					<C>id='bankCode', left=1005, top=1550, right=1934, bottom=1630</C>
					<C>id='paymentType', left=1511, top=1431, right=1934, bottom=1513</C>
					<C>id='exchRate', left=1005, top=1434, right=1267, bottom=1516</C>
					<T>id='Ex. Rate' ,left=556 ,top=1434 ,right=984 ,bottom=1516</T>
					<L> left=325 ,top=1307 ,right=1947 ,bottom=1307 </L>
					<T>id='Invoice No.' ,left=58 ,top=897 ,right=318 ,bottom=979</T>
					<T>id='Payment Terms' ,left=58 ,top=1434 ,right=318 ,bottom=1516</T>
					<T>id='Total Amount' ,left=61 ,top=1207 ,right=318 ,bottom=1410</T>
					<T>id='Street / Town' ,left=61 ,top=1103 ,right=318 ,bottom=1185</T>
					<T>id='Vendor' ,left=58 ,top=1000 ,right=318 ,bottom=1082</T>
					<T>id='Personnel' ,left=58 ,top=794 ,right=318 ,bottom=876</T>
					<T>id='Local' ,left=339 ,top=1323 ,right=534 ,bottom=1405</T>
					<T>id='Foreign' ,left=339 ,top=1212 ,right=532 ,bottom=1294</T>
					<C>id='vendAddr', left=336, top=1103, right=1265, bottom=1183</C>
					<C>id='vendor', left=339, top=1000, right=1265, bottom=1080</C>
					<C>id='personnel', left=336, top=794, right=982, bottom=876</C>
					<T>id='Type' ,left=1289 ,top=1476 ,right=1495 ,bottom=1521</T>
					<T>id='Payment' ,left=1289 ,top=1426 ,right=1495 ,bottom=1471</T>
					<L> left=1500 ,top=1418 ,right=1500 ,bottom=1529 </L>
					<T>id='Country' ,left=1289 ,top=1103 ,right=1487 ,bottom=1185</T>
					<L> left=1278 ,top=1418 ,right=1278 ,bottom=1529 </L>
					<L> left=992 ,top=1199 ,right=992 ,bottom=1646 </L>
					<L> left=542 ,top=1196 ,right=542 ,bottom=1643 </L>
					<C>id='exchTotalAmount', left=1003, top=1323, right=1931, bottom=1402</C>
					<C>id='totalAmount', left=1005, top=1214, right=1934, bottom=1294</C>
					<C>id='exchCurrCd', left=556, top=1323, right=984, bottom=1405</C>
					<C>id='mstCurrCd', left=553, top=1212, right=982, bottom=1294</C>
					<C>id='country', left=1505, top=1103, right=1934, bottom=1185</C>
					<C>id='paymentMethod', left=1505, top=997, right=1934, bottom=1082</C>
					<T>id='Method' ,left=1281 ,top=1042 ,right=1487 ,bottom=1087</T>
					<T>id='Payment' ,left=1281 ,top=992 ,right=1487 ,bottom=1037</T>
					<T>id='Shipment Date' ,left=1003 ,top=894 ,right=1267 ,bottom=976</T>
					<C>id='baselineDate', left=1289, top=794, right=1934, bottom=876</C>
					<T>id='Baseline Date' ,left=1003 ,top=794 ,right=1265 ,bottom=876</T>
					<L> left=1275 ,top=783 ,right=1275 ,bottom=1196 </L>
					<L> left=45 ,top=884 ,right=1945 ,bottom=884 </L>
					<L> left=48 ,top=1984 ,right=1947 ,bottom=1984 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
					<L> left=45 ,top=1871 ,right=1945 ,bottom=1871 </L>
					<L> left=45 ,top=1757 ,right=1945 ,bottom=1757 </L>
					<L> left=45 ,top=1643 ,right=1945 ,bottom=1643 </L>
					<L> left=45 ,top=1529 ,right=1945 ,bottom=1529 </L>
					<L> left=45 ,top=1416 ,right=1945 ,bottom=1416 </L>
					<L> left=45 ,top=1196 ,right=1945 ,bottom=1196 </L>
					<L> left=45 ,top=1090 ,right=1945 ,bottom=1090 </L>
					<L> left=45 ,top=987 ,right=1945 ,bottom=987 </L>
					<L> left=45 ,top=783 ,right=1945 ,bottom=783 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
					<T>id='MD' ,left=1794 ,top=275 ,right=1926 ,bottom=336</T>
					<L> left=1461 ,top=265 ,right=1461 ,bottom=611 </L>
					<L> left=1939 ,top=267 ,right=1939 ,bottom=614 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
					<L> left=1947 ,top=783 ,right=1947 ,bottom=1982 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
					<L> left=990 ,top=783 ,right=990 ,bottom=987 </L>
					<T>id='Request No :' ,left=74 ,top=706 ,right=318 ,bottom=773 ,align='right', MargineX=3</T>
					<T>id='Request Date :' ,left=1453 ,top=706 ,right=1717 ,bottom=773 ,align='right', MargineX=3</T>
					<C>id='RequestDate', left=1720, top=706, right=1931, bottom=773, align='left', MargineX=3</C>
					<C>id='requestNo', left=320, top=706, right=611, bottom=773, align='left', MargineX=3</C>
					<L> left=1495 ,top=990 ,right=1495 ,bottom=1199 </L>
					<C>id='houseBank', left=339, top=1778, right=1934, bottom=1857</C>
				</B>
				<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=103 ,face='Tahoma' ,size=10 ,penwidth=1
					<L> left=1945 ,top=0 ,right=1945 ,bottom=103 </L>
					<L> left=1640 ,top=0 ,right=1640 ,bottom=103 </L>
					<L> left=1365 ,top=0 ,right=1365 ,bottom=103 </L>
					<L> left=905 ,top=0 ,right=905 ,bottom=103 </L>
					<T>id='PO No.' ,left=58 ,top=11 ,right=280 ,bottom=93</T>
					<T>id='SO No.' ,left=304 ,top=11 ,right=564 ,bottom=93</T>
					<T>id='Item' ,left=587 ,top=11 ,right=894 ,bottom=93</T>
					<T>id='Request Amt' ,left=918 ,top=11 ,right=1357 ,bottom=93</T>
					<T>id='Inv. No. (Vendor)' ,left=1651 ,top=11 ,right=1937 ,bottom=93</T>
					<T>id='Doc. No.' ,left=1378 ,top=11 ,right=1635 ,bottom=93</T>
					<L> left=48 ,top=103 ,right=1947 ,bottom=103 </L>
					<L> left=45 ,top=0 ,right=45 ,bottom=103 </L>
					<L> left=291 ,top=0 ,right=291 ,bottom=103 </L>
					<L> left=574 ,top=0 ,right=574 ,bottom=103 </L>
					<L> left=48 ,top=0 ,right=1947 ,bottom=0 </L>
				</B>
				<B>id=Default ,left=0,top=0 ,right=2000 ,bottom=109 ,face='Tahoma' ,size=10 ,penwidth=1
					<L> left=48 ,top=106 ,right=1947 ,bottom=106 </L>
					<L> left=1945 ,top=5 ,right=1945 ,bottom=108 </L>
					<L> left=1640 ,top=3 ,right=1640 ,bottom=106 </L>
					<L> left=905 ,top=3 ,right=905 ,bottom=106 </L>
					<L> left=291 ,top=3 ,right=291 ,bottom=106 </L>
					<C>id='docNo', left=1376, top=19, right=1630, bottom=95</C>
					<C>id='amount', left=1050, top=19, right=1352, bottom=95, align='right', MargineX=3</C>
					<C>id='currCd', left=915, top=19, right=1037, bottom=95</C>
					<L> left=45 ,top=3 ,right=45 ,bottom=106 </L>
					<L> left=574 ,top=5 ,right=574 ,bottom=108 </L>
					<L> left=1365 ,top=3 ,right=1365 ,bottom=106 </L>
				</B>		
			"/>
		</object>
	</comment>
	<SCRIPT>__WS__(__NSID__);</SCRIPT>
	<!-- Print 화면 영역 End -->
</div>

</body>
</html>