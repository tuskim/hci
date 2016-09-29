<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--
/*
*************************************************************************
* @source  : purchOrderReg.jsp
* @desc    : PO Send
*------------------------------------------------------------------------
* VER  DATE         AUTHOR      DESCRIPTION
* ---  -----------  ----------  -----------------------------------------
* 1.0  2010.09.13   임민수       init
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
	//권한 삭제 요청 2010.9.9 강병용 
	/*if(<%=columnData.getString("authType")%>){
		lc_purDept.enable="true";
	}*/
	f_setData();
}

function f_retrieve(){ 
	
	var param = "?";
	
	param += "&fromPoDate=" +  removeDash(document.all.fromPoDate.value, "/");
	param += "&toPoDate=" + removeDash(document.all.toPoDate.value, "/");
	param += "&fromPostDate=" +  removeDash(document.all.fromPostDate.value, "/");
	param += "&toPostDate=" + removeDash(document.all.toPostDate.value, "/");	
	param += "&poNo=" + document.all.poNo.value;

	ds_main.DataID = "/po.ir.retrieveInvoiceMstList.gau"+param;
	ds_main.Reset();
		
}

function f_setData(){
	ds_deliLoct.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2005";
	ds_deliLoct.Reset();
	
	ds_currCd.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2004";
	ds_currCd.Reset();	
	
	ds_purDept.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2001";
	ds_purDept.Reset();

	ds_purDept.RowPosition = ds_purDept.NameValueRow("code","<%=g_deptCd%>");
	
	ds_gridPurDept.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2001";
	ds_gridPurDept.Reset();
	//ds_purDept 값 복사	 
	//cfCopyDataSet(ds_purDept,ds_gridPurDept,"copyHeader=true");   
	
	ds_status.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2210";
	ds_status.Reset();
	
	ds_payTerm.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2206";
	ds_payTerm.Reset();			
 	
	ds_mater.DataId="po.oc.retrievePurchOrderRegMaterCombo.gau";
	ds_mater.Reset();	
	
	ds_vatCd.DataId="po.oc.retrievePurchOrderRegVatVCombo.gau?groupCd=2007";
	ds_vatCd.Reset();	 	
 	 
	ds_gridVendor.DataId="cm.cm.retrieveCommComboVendorList.gau";
	ds_gridVendor.Reset();	 	 
	
	ds_vendor.DataId="cm.cm.retrieveCommComboVendorList.gau";
	ds_vendor.Reset();	
	
	ds_currencyCd.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2004";
	ds_currencyCd.Reset();	

	ds_withTaxType.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2011";
	ds_withTaxType.Reset();	
	
	var strHeader  = "code:STRING(50),name:STRING(50)";
    ds_return.SetDataHeader(strHeader); 
    
    ds_return.AddRow();
    ds_return.NameValue(ds_return.RowPosition, "code") = ""; 
    ds_return.NameValue(ds_return.RowPosition, "name") = "";
    
    ds_return.AddRow();
    ds_return.NameValue(ds_return.RowPosition, "code") = "X"; 
    ds_return.NameValue(ds_return.RowPosition, "name") = "Return";	
	
 
	cfAddYn(ds_receiptClsYn,"code"); 
	document.all.grandTotal.text="0";
}

function f_cancel()
{
 	if(!ds_main.IsUpdated) {
		alert("<%=source.getMessage("dev.warn.com.chkHeaderCount")%>");
		return;
	}

 	if(ds_main.NameValue(ds_main.RowPosition, "postDate") > ds_main.NameValue(ds_main.RowPosition, "cancelPostDate")){
		alert("Cancel Posting Date should be a date later than Posting Date." );
		return;	
	}
 	
	if(ds_main.NameValue(ds_main.RowPosition, "status") != '03' ){
		alert("<%=source.getMessage("dev.msg.po.statusCheck", "IV Success" )%>" );
		return;	
	}

	
	if(confirm("<%=source.getMessage("dev.cfm.com.cancel")%>")){         
	    g_flug=true;	    
		msg ="<%=source.getMessage("dev.suc.com.cancel")%>";	 

		for(var i=1; i<=ds_detail.CountRow; i++){
			ds_detail.NameValue(i, "chk") = "T";
		}
		for(var i=1; i<=ds_tax.CountRow; i++){
			ds_tax.NameValue(i, "chk") = "T";
		}
		
		tr_cudMaster.KeyValue = "Servlet(I:IN_DS1=ds_main,I:IN_DS2=ds_detail,I:IN_DS3=ds_tax)";
		tr_cudMaster.Action   = "/po.ir.cudInvoiceCancel.gau?";
		tr_cudMaster.post();
				
	}
	
}
 
function f_retry()
{
 	if(!ds_main.IsUpdated) {
		alert( "<%=source.getMessage("dev.warn.com.chkHeaderCount")%>" );
		return;
	}

//	if(ds_main.NameValue(ds_main.RowPosition, "status") == '02'){
//		condition="save";
//		msg ="=source.getMessage("dev.suc.com.save")";       // 02 상태 재전송은 없앰,, 나중에 원복시 위해 주석 처리 (%= 추가 시켜야 함 )
//		
//	}else 
	
	var condition = "?";
	if(ds_main.NameValue(ds_main.RowPosition, "status") == '05' || ds_main.NameValue(ds_main.RowPosition, "status") == '99'){
		condition="cancel";
		msg ="<%=source.getMessage("dev.suc.com.cancel")%>";	 
		
	}else{
		alert("<%=source.getMessage("dev.msg.po.statusCheck", "GR Cancel Fail")%>" );
		return;	
	}


	if(confirm("<%=source.getMessage("dev.cfm.com.retry")%>")){         
	    g_flug=true;	    

		for(var i=1; i<=ds_detail.CountRow; i++){
			ds_detail.NameValue(i, "chk") = "T";
		}
		for(var i=1; i<=ds_tax.CountRow; i++){
			ds_tax.NameValue(i, "chk") = "T";
		}
		
		
		
		tr_cudMaster.KeyValue = "Servlet(I:IN_DS1=ds_main,I:IN_DS2=ds_detail,I:IN_DS3=ds_tax)";
		tr_cudMaster.Action   = "/po.ir.cudInvoiceRetry.gau?retryType=" + condition;
		tr_cudMaster.post();
				
	}
	
}

 function f_setAmt(){
 	var amt = 0;
 	var trTaxAmt = 0;
 	var taxAmt = 0;
 	
 	amt = ds_main.NameValue(ds_main.RowPosition, "ivAmt");
 	
 	for(var i=1; i<=ds_detail.CountRow; i++){
		trTaxAmt += ds_detail.NameValue(i, "tranTaxAmt");
	}
	if(ds_tax.CountRow > 0)
		taxAmt = ds_tax.NameValue(ds_tax.RowPosition, "wtTaxAmt")
 	document.all.grandTotal.text = amt + trTaxAmt + taxAmt;
 }
 
</script>
<!-----------------------------------------------------------------------------
T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- CUD TR -->
<!-- Payment Arrange CUD TR -->
<OBJECT id=tr_cudMaster classid="<%=LGauceId.TR%>">
	<param name="KeyName"   value="toinb_dataid4"> 
	<param name="KeyValue"  value="JSP(I:ds_main=ds_main,I:ds_detail=ds_detail,I:ds_approval=ds_approval)">
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

<object id="ds_tax" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true">
</object>

<object id="ds_withTaxType" classid="<%=LGauceId.DATASET%>" >
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
</script> 


<script language=JavaScript for="ds_main" event=OnRowPosChanged(row)>

		ds_detail.ClearAll();
		if(row>0){
			var v_url = new cfURI();
			v_url.Add("poNo",ds_main.NameValue(ds_main.RowPosition,"poNo")); 
			v_url.Add("seq",ds_main.NameValue(ds_main.RowPosition,"ivSeq")); 			
			v_url.SetPage("po.ir.retrieveInvoiceDtlList.gau");
			ds_detail.DataId = v_url.GetURI();
			ds_detail.Reset(); 

			v_url.SetPage("po.ir.retrieveInvoiceTaxList.gau");
			ds_tax.DataId=v_url.GetURI();
			ds_tax.Reset();	
			
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
 	if ( colid == "cancelPostDate") {
	 	h_date.value ="";
		gf_calendarExClean(h_date); 
		ds_main.NameValue(row,"cancelPostDate") = funcReplaceStrAll(h_date.value,"/","");		 	
 	}	
</script>

<script language=JavaScript for=gr_detail event=OnPopup(row,colid,data)>
 	if ( colid == "materNm") {
		openMaterialCodeListGridConWin(row, ds_detail,"PO");
		
	}
</script>
<!-- main 조건설정-->
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
		for(var i=1; i<= ds_detail.CountRow;i++){		
			ds_detail.NameValue(i,'currencyCd') = ds_main.NameValue(row,"currencyCd");  
 		}
 		if(ds_main.NameValue(row,"currencyCd")=="IDR"){
	 		gr_main.ColumnProp('discountAmt', 'Edit') = "Numeric";
	 		ds_main.NameValue(row,"discountAmt") = fnMathRound(ds_main.NameValue(row,"discountAmt"),0,'T');
	 		gr_detail.ColumnProp('price', 'Edit') = "Numeric";
			for(var j=1; j<= ds_detail.CountRow;j++){		
				ds_detail.NameValue(j,"price") = fnMathRound(ds_detail.NameValue(j,"price"),0,'T');
	 		}
 		}else if(ds_main.NameValue(row,"currencyCd")=="USD"){
 			gr_main.ColumnProp('discountAmt', 'Edit') = "true";
 			gr_detail.ColumnProp('price', 'Edit') = "true";
 		}
 		
	} 	
</script>
 
<!-- detail 조건설정-->
<script language=JavaScript for=gr_detail event=OnCloseUp(row,colid)>
/*
	if(colid=="materCd"){
		var arow =ds_mater.NameValueRow("materCd",ds_detail.NameValue(row,"materCd"));
		ds_detail.NameValue(row,"unit") = ds_mater.NameValue(arow,"unit");
		ds_detail.NameValue(row,"materNm") = ds_mater.NameValue(arow,"materNm");
	}
	*/
	if(colid=="vatCd"){
		var arow =ds_vatCd.NameValueRow("code",ds_detail.NameValue(row,"vatCd"));
		ds_detail.NameValue(row,"vatNm") = ds_vatCd.NameValue(arow,"name"); 
	} 	 
	
</script>

<script language=JavaScript for=gr_approval event=OnClick(row,colid)>
	if(colid=="mainYn"){ 
		for(var i=1;i<=ds_approval.CountRow;i++){
			ds_approval.NameValue(i,"mainYn") ="F";
		}
		ds_approval.NameValue(row,"mainYn") ="T";
		ds_approval.NameValue(row,"chk") ="T";
		
	}
</script>


<script language="javascript" for="gr_main" event="onClick( Row, Colid )">
	for(var i=1; i<=ds_main.CountRow; i++){
		ds_main.NameValue(i, "chk") = "F";
	}
	ds_main.NameValue(ds_main.RowPosition, "chk") = "T";
		

	if(Colid == "chk"){
		ds_main.NameValue(Row, "chk") = "T";
	}


</script>

<script language=JavaScript for=ds_tax event=OnLoadCompleted(rowCnt)>
	f_setAmt();
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
							<th>P/O Date </th>
							<td><input type="text"  style="width:70px;" id="fromPoDate" value="<%= prevDate %>" />
								<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="" onclick="javascript:OpenCalendar(fromPoDate);" class="button_cal"/>
								~
								<input type="text"  style="width:70px;" id="toPoDate" value="<%= currentDate %>" />
								<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="" onclick="javascript:OpenCalendar(toPoDate);" class="button_cal"/>
							</td> 
							<th>P/O No.</th>
							<td> <input id="poNo" name="poNo" size="17"></input>	</td>						

						</tr>
						<tr>
							<th>Posting Date </th>
							<td><input type="text"  style="width:70px;" id="fromPostDate" value="" />
								<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="" onclick="javascript:OpenCalendar(fromPostDate);" class="button_cal"/>
								~
								<input type="text"  style="width:70px;" id="toPostDate" value="" />
								<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="" onclick="javascript:OpenCalendar(toPostDate);" class="button_cal"/>
							</td> 
							<td>
							</td>
							<td>
							</td>						
						</tr>
					</table>
				</dt>              		  	   	 	
					 <dd class="btnseat2"> 
					 	 <span class="search_btn2_r search_btn2_l">
                 			 <input type="button" onfocus="blur();" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='#e2ebf7'" value="<%=btnSearch %>" onclick="javascript:f_retrieve();"/></span> 
					 </dd>									
			</dl>
		</div>
	</fieldset>
	<!--검색 E -->		

	<div class="sub_stitle"> 
		<p> Invoice List </p>
	</div>    
	<!-- 그리드 S -->
		<div>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<object id="gr_main" classid="<%=LGauceId.GRID %>" style="width:100%;height:150px;" class="comn">
							<param name="DataID"            value="ds_main"/> 
							<param name="Editable"          value="true"/>
							<Param name="AutoResizing"      value=true>
							<param name="UrlImages"         value="<I>Type='PopupBotton', Url='/sys/images/button/search_icon_2.gif', Fit='AutoFit', Flat='True'</I>">
							<param name="Format"            
							value="
							<FC>id='chk'         width='25'  align='center'   edit='true',  Editstyle='check'    </FC>				            							
							<FC>id='poNo'          name='P/O No.'              width='85'  align='center' edit='none'                                  </FC>
							<C>id='sapPoNo'        name='SAP P/O No.'          width='85'  align='center' edit='none'                                  </C>					
							<C>id='ivSeq'         name='<%=columnData.getString("po_seq") %>'            width='30'  align='center'   edit='none'       </C>                  
							<C>id='regdate'         name='P/O Date'            width='85'  align='center'   edit='none'  mask='XXXX/XX/XX' </C>                  
							<C>id='ivDate'         name='<%=columnData.getString("invoice_date") %>'            width='85'  align='center'   edit='none'  mask='XXXX/XX/XX' </C>                  
							<C>id='postDate'       name='<%=columnData.getString("posting_date") %>'          width='85'  align='center'   edit='none'   mask='XXXX/XX/XX' </C>
							<C>id='cancelPostDate'       name='Cancel;Posting Date'          width='85'  align='center'   edit='Any' Editstyle='PopupFix'  mask='XXXX/XX/XX' </C>
							<C>id='ivAmt'        name='<%=columnData.getString("amount") %>'           width='110'  align='right' edit='none'         </C>
							<C>id='currencyCd'       name='<%=columnData.getString("currency_cd") %>'          width='45'  align='center' edit='none' Data='ds_currCd:code:name:code'  editstyle='lookup'      editstyle='PopupFix'  </C>
							<C>id='vatCd'     name='Tax Code'        width='100'  align='left' edit='none'       Data='ds_vatCd:code:name:code'  editstyle='lookup' </C>							
							<C>id='vatAmt'        name='Tax Amount'           width='90'  align='right' edit='none'       </C>		
							<C>id='status'    name='<%=columnData.getString("status") %>'       width='110'  align='left'  edit='none'     Data='ds_status:code:name:code'  editstyle='lookup'    </C>												
							<C>id='sapIvDoNo'    name='<%=columnData.getString("invoice_doc_no") %>'       width='90'  align='center'  edit='none'           </C>												
							<C>id='sapCancelIvDoNo'    name='<%=columnData.getString("invoice_cancel_doc_no") %>'       width='105'  align='center'  edit='none'          </C>												
							<G> name='<%=columnData.getString("invoice_creation") %>'
								<C>id='sendDate'    name='Date'           width='76'  align='center' edit=none 	 mask='XXXX/XX/XX'</C>		
								<C>id='sendStat'    name='Success'       width='80'  align='left'  edit='none'   Data='ds_status:code:name:code'  editstyle='lookup'      </C>												
								<C>id='sendMsg'    name='Cause'     	 width='200'  align='left'  edit='none'        </C>												
							</G>
							<G> name='<%=columnData.getString("invoice_cancel") %>'
								<C>id='cancelDate'    name='Date'       	width='76'  align='center'  edit='none'   mask='XXXX/XX/XX'     </C>												
								<C>id='cancelStat'    name='Success'       width='120'  align='left'  edit='none'   Data='ds_status:code:name:code'  editstyle='lookup'      </C>												
								<C>id='cancelMsg'    name='Cause'       width='200'  align='left'  edit='none'        </C>												
							</G>
							<C>id='chk'     show='false'                                  </C>					"/>
		             
						</object>
					</td>
				</tr>
			</table>
		</div>
		
		<!-- 그리드 E --> 
	    <div class="sub_stitle"> <p>Invoice Material</p>
		</div>		
				
		<div>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<object id="gr_detail" classid="<%=LGauceId.GRID %>" style="width:100%;height:90px;" class="comn">
							<param name="DataID"            value="ds_detail"/> 
							<param name="Editable"          value="false"/>
						    <param name="UsingOneClick"     value=1>
						    <Param name="AutoResizing"      value=true>
							<param name="Format"              
							value="
							<C>id='itemSeq'          name='<%=columnData.getString("po_seq") %>'            width='60' align='center'    edit='none'   </C>							            
							<C>id='materNm'         name='<%=columnData.getString("mater_cd") %>'          width='150' align='left'      edit='true'   </C>
							<C>id='unit'            name='<%=columnData.getString("unit") %>'              width='30' align='center'    edit='none'   </C>
							<C>id='qty'             name='<%=columnData.getString("po_qty") %>'               width='130' align='right'     edit='true'  </C>
							<C>id='ivQty'      name='<%=columnData.getString("receipt_qty") %>'               width='130' align='right'     edit='true' dec='2' </C>
							<C>id='amt'          name='<%=columnData.getString("amount") %>'            width='130' align='right'     edit='true' dec='3'    </C>	
							<C>id='vatCd'           name='Tax Code'            width='120' align='left'      edit='true' Data='ds_vatCd:code:name:code' editstyle='lookup' </C> 
							<C>id='companyCd'           show='false' </C> 
							<C>id='poNo'           show='false' </C> 
							<C>id='ivSeq'           show='false' </C> 
							<C>id='chk'           show='false' </C> 
							<C>id='materCd'           show='false' </C>  "/>
						</object>
						
					</td>	
				</tr>
			</table>
		</div>

		<!-- 그리드 S -->
		<div>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<object id="gr_approval" classid="<%=LGauceId.GRID %>" style="width:100%;height:50px;" class="comn" style="display:none">
							<param name="DataID"            value="ds_tax"/> 
							<param name="Editable"          value="false"/>
							<Param name="AutoResizing"      value=true>
						    <param name="UsingOneClick"     value=1>
							<param name="Format"              
							value="
							<C>id='wtType'   name='<%=columnData.getString("w_tax_type") %>'   width='165' align='left'   edit='true'  Data='ds_withTaxType:code:name:code' editstyle='lookup'   </C>
							<C>id='wtCd'    name='<%=columnData.getString("w_tax_code") %>'   width='150' align='right'   edit='true'    </C>
							<C>id='wtRate'        name='<%=columnData.getString("rate") %>'   width='110' align='right'   edit='true'   decao='2' </C>
							<C>id='wtBaseAmt'        name='<%=columnData.getString("base_amount") %>'   width='130' align='right'   edit='true'    </C>
							<C>id='wtTaxAmt'       name='<%=columnData.getString("tax_amount") %>'  width='130'  align='right'   edit='true' </C>
							<C>id='companyCd'      show = 'false' </C>
							<C>id='poNo'      show = 'false' </C>
							<C>id='ivSeq'      show = 'false' </C>
							<C>id='wtSeq'      show = 'false' </C> 
							<C>id='chk'      show = 'false' </C>"/>
						</object>
						
						</comment>
					</td>
				</tr>
			</table>
		</div>
		<!-- 그리드 E -->
		
		<div class="sub_stitle"> <p>Total Amount</p>
			<!-- 그리드 S -->	
		        <div id="output_board_area">
		            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board" >
		                <colgroup>
		                        <col width="15%"/>
		                        <col width=""/>
		              </colgroup>
		                     <tr>
								<th><%= columnData.getString("grand_total") %></th>
		                        <td>
                                 <object id=grandTotal name="grandTotal" class="input_text" classid="<%=LGauceId.EMEDIT%>"	height=20 width=114  >
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
							</tr>   
		            </table>
				</div>
		</div>	
 
		<!-- 버튼 S -->	
		<div id="btn_area">
			<p class="b_right">
				<span class="btn_r btn_l"> 
					<input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnCancel%>" onclick="f_cancel()"/>
				</span>  								
			</p>
		</div>
<!-- 버튼 E --> 
</div>
<input type="hidden" id="h_date"/>
</body>
</html>

