<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--
/*
*************************************************************************
* @source  : receiptList.jsp
* @desc    : 입고 조회 및 취소
*------------------------------------------------------------------------
* VER  DATE         AUTHOR      DESCRIPTION
* ---  -----------  ----------  -----------------------------------------
* 1.0  2010.08.27    임민수       init
* 1.1  2011.08.29    hskim        CSR:C20110823_49874
* 1.2  2015.12.21    hskim        CSR:C20151127_27284 REF NO 추가
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
var msg="";
function init(){

	f_setData();
	
}

function f_retrieve(){ 
	
	var param = "?";
	param += "&postingDateFrom=" + removeDash(document.all.srtDate.value, "/");
	param += "&postingDateTo=" + removeDash(document.all.endDate.value, "/");
	param += "&issue_loc=" + document.all.issue_loc.BindColVal;
	param += "&vendor=" + document.all.lc_vendor.BindColVal;
	param += "&status=" + document.all.st_mater.BindColVal;
	param += "&schPoNo=" + document.all.schPoNo.value;
	
	ds_main.DataID = "/po.is.receiptMgnt.retrieveReceiptMstListGau.gau?"+param;
	ds_main.Reset();
}

function f_setData(){
	//상태 
	ds_statusCode.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2207";
	ds_statusCode.Reset();
	
	//저장소
	ds_location.DataId="/cm.cm.retrieveCommCodeCombo.gau?groupCd=2005";
	ds_location.Reset();
	
	//vendor
	ds_vendor.DataId="cm.cm.retrieveCommComboVendorList.gau";
	ds_vendor.Reset();

	//Office
	ds_purDept.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2001";
	ds_purDept.Reset();	
}


// 전송 구분:01=>Sap전송,03=>Sap Cancel
function f_sapCancel(){
	
	if(ds_main.NameValue(ds_main.RowPosition,"status")=="03" ){    // test 위함
		if(!confirm('<%=source.getMessage("dev.msg.po.sapcancelcontinue" ) %>')){
			return;
		}	
		for(var i=1; i<=ds_detail.CountRow; i++){
			ds_detail.NameValue(i, "chk") = "T";          // 취소시 detail의 데이타 내용을 PO_Detail 에서 감소 시켜야줘야 하기 때문에 데이타 내용을 넣기 위해 chk를 T로 변경
		}
		
		tr_cudMaster.KeyValue = "Servlet(I:IN_DS1=ds_main, I:IN_DS2=ds_detail)";
		tr_cudMaster.Action   = "/po.is.cmd.cudReceiptSAPCancelCmd.gau";
		tr_cudMaster.post();
		
	}else{
		alert("<%=source.getMessage("dev.msg.po.transfer" ) %>"); 
		return; 
	}
} 

//-------------------------------------------------------------------------
// excel
//-------------------------------------------------------------------------					   
function f_excelDown(){

	if (ds_main.CountRow > 0) {

		var condition = "?";
	 		condition += "issueLoc="  + document.all.issue_loc.BindColVal;
			condition += "&postingDateFrom=" + removeDash(document.all.srtDate.value, "/");
			condition += "&postingDateTo=" + removeDash(document.all.endDate.value, "/");
			condition += "&vendor=" + document.all.lc_vendor.BindColVal;
			condition += "&status="  + document.all.st_mater.BindColVal;
			condition += "&schPoNo=" + document.all.schPoNo.value;

		ds_excelDown.DataID = "po.is.retrieveReceiptExcelDownList.gau"+condition;
		ds_excelDown.Reset();	
	}else {
		alert("No data");
	}
}

function f_excel() {
	gf_excel(ds_excelDown,gr_excelDown,"<%=columnData.getString("page_title") %>","c:\\");
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
</object>

<!-- Grid 용 DataSet-->
<object id="ds_detail" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true">
	<param name="ViewDeletedRow"    value="false">
</object>

<!-- 저장소 combo DataSet -->
<object id="ds_location"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"          value="true">
</object>

<!-- Status combo DataSet -->
<object id="ds_statusCode"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
</object>

<object id="ds_vendor" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true">
</object>
	
<object id="ds_purDept" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true">
</object>

<!-- Hidden Grid 용 Detail DataSet-->
<object id="ds_excelDown" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/> 
  <param name="ViewDeletedRow"    value="false"/>
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

<script language=JavaScript for=ds_statusCode event=OnLoadCompleted(rowCnt)>
	cfUnionBlank(ds_statusCode,st_mater,"code","name","--Total--"); 
</script>

<script language=JavaScript for=ds_vendor event=OnLoadCompleted(rowCnt)>
	cfUnionBlank(ds_vendor,lc_vendor,"code","name","--Total--"); 
</script>

<script language=JavaScript for="ds_main" event=OnRowPosChanged(row)>
		
		ds_detail.ClearAll();
		if(row>0){
			var param = "";
			param += "companyCd="+ds_main.NameValue(ds_main.RowPosition, "companyCd");
			param += "&poNo="+ds_main.NameValue(ds_main.RowPosition, "poNo");
			param += "&receiptSeq="+ds_main.NameValue(ds_main.RowPosition, "receiptSeq");
			
			ds_detail.DataID = "/po.is.receiptMgnt.retrieveReceiptDtlListGau.gau?"+param;
			ds_detail.Reset();		
		}
		
		
		
</script>

<script language="javascript" for="gr_main" event="onClick( Row, Colid )">

		if(Colid == "chk"){
			for(var i=1; i<=ds_main.CountRow; i++){
				if(i != Row)
					ds_main.NameValue(i, "chk") = "F";
			}
			//ds_main.NameValue(ds_main.RowPosition, "chk") = "T";
		}else{
			//ds_main.UndoAll();
			ds_main.NameValue(ds_main.RowPosition, "chk") = "T";
		
		}
		
</script>

<script language="javascript"  for=gr_main event=OnPopup(Row,Colid,data)>
    
	// 기간비용시작일자 날짜 팝업 셋팅
	if ( Colid == "postingDate") {
		
	 	h_date.value ="";
		gf_calendarExClean(h_date);
		
		ds_main.NameValue(ds_main.RowPosition,"postingDate") = funcReplaceStrAll(h_date.value,"/","");		 
	}
	
</script>



<script language=JavaScript for=tr_cudMaster event=OnFail()>
	mode = "";
	if(tr_cudMaster.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
		window.parent.location.href = "/index.jsp";    
	}
	alert(tr_cudMaster.ErrorMsg);
	f_retrieve();
    
</script>

<script language=JavaScript for=tr_cudMaster event=OnSuccess()>
	
	g_flug=false; 
	f_retrieve();
    ds_main.RowPosition    = g_msPos;
    ds_detail.RowPosition  = g_ddtPos;			
	alert("successfully saved.");
</script> 

<!-- Excel Download Grid Load -->
<script language=JavaScript for=ds_excelDown event=OnLoadCompleted(rowCnt)>
f_excel();
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
								<col width="15%"/>
								<col width="40%"/>
								<col width="20%"/>
								<col width="25%"/>
							  </colgroup>
							   <tr>
									<th>Receipt Date</th>
									<td> 
									 <input id="srtDate" name="srtDate" type="text" onblur="valiDate(this);" style="width:60px;" value="<%= prevDate %>" /> <img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(srtDate);" style="cursor:hand"/> ~ 
									 <input id="endDate" name="endDate" type="text" onblur="valiDate(this);" style="width:60px;" value="<%= currentDate %>" /> <img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(endDate);" style="cursor:hand"/>
									</td>					
									<th>Storage Location </th>
									<td><comment id="__NSID__"><object id="issue_loc"  classid="<%=LGauceId.LUXECOMBO%>" width="100">
										    <param name="ComboDataID"       value="ds_location"/>
											<param name="ListCount"     	value="10"/>
											<param name=SearchColumn		value="name"/>
											<param name="BindColumn"    	value="code"/>
										    <param name=ListExprFormat		value="name^0^90,code^0^70"/>
										    <param name=index           	value=0/>
									   	</object></comment><script>__WS__(__NSID__); </script>
									 </td>
								</tr>
								<tr>
									<th><%=columnData.getString("vendor") %> </th>		
									<td><comment id="__NSID__"><object id="lc_vendor"  classid="<%=LGauceId.LUXECOMBO%>" width="180">
										<param name="ComboDataID"       value="ds_vendor"/>
										<param name="ListCount"     	value="10"/>
										<param name=SearchColumn		value="name"/>
										<param name="BindColumn"    	value="code"/>
										<param name=ListExprFormat		value="name^0^175,code^0^70"/> 
										<param name=index           	value=0/>
										</object></comment><script>__WS__(__NSID__); </script>
									</td>		
									<th><%= columnData.getString("status") %></th>
									<td><comment id="__NSID__"><object id="st_mater"  classid="<%=LGauceId.LUXECOMBO%>" width="100">
									    <param name="ComboDataID"       value="ds_statusCode"/>
										<param name="ListCount"     	value="10"/>
										<param name="BindColumn"    	value="code"/>
										<param name="WantSelChgEvent"   value="TRUE"/>
									    <param name=ListExprFormat		value="name^0^90,code^0^70"/>
									    <param name=index           	value=0/> 
									</object></comment><script>__WS__(__NSID__); </script></td></td>
									
								</tr>
								<tr>
									<th><%=columnData.getString("po_no") %></th>
									<td clospan="3"><input id="schPoNo" name="schPoNo" type="text" style="width:100px;"  /> </td>
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
	
	<div class="sub_stitle"> <p><%=columnData.getString("sub_title1") %></p>     
		<p class="rightbtn"> 
			<span class="excel_btn_r excel_btn_l">
            <input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="<%=btnExcelDown %>" onclick="javascript:f_excelDown();"/>
            </span> 
		</p>	
	</div>
	<!-- 그리드 S -->
		<div>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<comment id="__NSID__">
						<object id="gr_main" classid="<%=LGauceId.GRID %>" style="width:100%;height:220px;" class="comn">
							<param name="DataID"            value="ds_main"/> 
							<param name="Editable"          value="true"/>
							<param name="TitleHeight"          value="30"/>
							<param name="UsingOneClick"		value="1">
							<param name="Format"     value='
								<FC>id="chk"			Edit="true"       width="30"	  EditStyle=CheckBox	</FC>
	 							<FC>id="poNo"          name="<%=columnData.getString("po_no") %>"              width="90"  align="center" edit="none"                                  </FC>
	 							<FC>id="prNo"          name="P/O NO.(Manual)"              width="135"  align="left" edit="none"                                  </FC>
								<C>id="sapPoNo"      name="SAP P/O No."        width="90"  align="center" edit=none        </C>							
								<FC>id="receiptSeq"   name="<%=columnData.getString("seq") %>"            width="40"  align="center" edit="none"     </FC>                  
								<C>id="purDeptCd"     name="Office"       show="false"   width="80"  align="left" edit="none"        Data="ds_purDept:code:name:code" editstyle="lookup" ListWidth=200 </C>
								<C>id="deliLoct"        name="<%=columnData.getString("locat") %>"           width="90"  align="left" edit="none"   EditStyle="LookUp" 	Data="ds_location:code:name"	</C>
								<C>id="postingDate"   name="<%=columnData.getString("post_date") %>"    width="90"  align="center" edit="RealNumeric"       mask="XXXX/XX/XX" editstyle="Popup"  </C>
								<C>id="vendCd"  		 name="<%=columnData.getString("vendor") %>"    	width="170"  align="left" edit="none"       EditStyle="LookUp" 	Data="ds_vendor:code:name"                            </C>							
								<C>id="sapReceiptNo"  name="SAP Receipt No."        width="130"  align="center" edit=none        </C>							
								<C>id="sapCancelReceiptNo"  name="SAP Cancel No."        width="130"  align="center" edit=none        </C>							
								<C>id="status"          name="<%=columnData.getString("status") %>"           width="150"  align="center" edit=none       EditStyle="LookUp" 	Data="ds_statusCode:code:name"		 </C>		
								<C>id="sapRtnMsg"    name="<%=columnData.getString("return_msg") %>"       width="380"  align="left"  edit="none"        </C>												
								<C>id="companyCd"    show="false"   </C>	
							'/>
							
						</object>
						</comment><script>__WS__(__NSID__);</script>
					</td>
				</tr>
			</table>
		</div>
		<!-- 그리드 E -->
	    <div class="sub_stitle"> <p><%= columnData.getString("sub_title2") %></p>
		</div>	
		<div>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<comment id="__NSID__">
						<object id="gr_detail" classid="<%=LGauceId.GRID %>" style="width:100%;height:150px;" class="comn">
							<param name="DataID"            value="ds_detail"/> 
							<param name="Editable"          value="true"/>
							<param name="Format"              
							value='
	 							<C>id="poSeq"          name="<%=columnData.getString("po_seq") %>"              width="100"  align="center" edit="none"                                  </C>
								<C>id="materCd"        name="<%=columnData.getString("mater_no") %>"            width="110"  align="center" edit={IF(pstatus="01","true","false")}       Data="ds_gridVendor:code:name:code" editstyle="lookup" ListWidth=200   </C>                  
								<C>id="materNm"      name="<%=columnData.getString("mater_nm") %>"          width="240"  align="left" edit={IF(pstatus="01","true","false")}       Data="ds_deliLoct:code:name:code" editstyle="lookup" ListWidth=200 </C>
								<C>id="unit"        name="<%=columnData.getString("unit") %>"           width="100"  align="center" edit="none"                                </C>
								<C>id="receiptQty"       name="<%=columnData.getString("rec_qty") %>"          width="100"  align="center" edit={IF(pstatus="01","true","false")}       </C>
								<C>id="chk"      show="false"</C>
								'/>
						</object>
						</comment><script>__WS__(__NSID__);</script>
					</td>
				</tr>
			</table>
		</div>

	<!-- 버튼 S -->	
	<div id="btn_area">
		<p class="b_right">
			<span class="btn_r btn_l">
			<input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnSapCancel%>" onclick="f_sapCancel();"/>
			</span> 
		</p>
	</div>
<!-- 버튼 E --> 

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
		    <param name=SuppressOption 	    value="1">
			<param Name="Editable" 			value="true">
	        <param name=ViewSummary         value="1">
	        <param name=SubsumExpr			value="1:tranNo">
			<param Name="Format"
				value='
			            <FC>id="poNo"          name="<%=columnData.getString("po_no") %>"              width="100"  align="center" edit="none"                                  </FC>
								<C>id="sapPoNo"      name="<%=columnData.getString("sap_po_no") %>"        width="100"  align="center" edit=none        </C>							
								<FC>id="receiptSeq"   name="<%=columnData.getString("seq") %>"            width="80"  align="center" edit="none"     </FC>                  
								<C>id="purDeptCd"     name="<%=columnData.getString("pur_dept_cd") %>"          width="130"  align="left" edit="none"        Data="ds_purDept:code:name:code" editstyle="lookup" ListWidth=200 </C>
								<C>id="deliLoct"        name="<%=columnData.getString("locat") %>"           width="180"  align="left" edit="none"   EditStyle="LookUp" 	Data="ds_location:code:name"	</C>
								<C>id="postingDate"   name="<%=columnData.getString("post_date") %>"    width="90"  align="center" edit="none"       mask="XXXX/XX/XX"   </C>
								<C>id="vendCd"  		 name="<%=columnData.getString("vendor") %>"    	width="200"  align="left" edit="none"       EditStyle="LookUp" 	Data="ds_vendor:code:name"                            </C>							
								<C>id="sapReceiptNo"  name="<%=columnData.getString("sap_req_no") %>"        width="130"  align="center" edit=none        </C>							
								<C>id="sapCancelReceiptNo"  name="<%=columnData.getString("sap_cancel_req_no") %>"        width="130"  align="center" edit=none        </C>							
								<C>id="status"          name="<%=columnData.getString("status") %>"           width="150"  align="center" edit=none       EditStyle="LookUp" 	Data="ds_statusCode:code:name"		 </C>		
								<C>id="sapRtnMsg"    name="<%=columnData.getString("return_msg") %>"       width="380"  align="left"  edit="none"        </C>												

	           			<C>id="poSeq"          name="<%=columnData.getString("po_seq") %>"              width="100"  align="center" edit="none"                                  </C>
								<C>id="materCd"        name="<%=columnData.getString("mater_no") %>"            width="110"  align="center" edit={IF(pstatus="01","true","false")}       Data="ds_gridVendor:code:name:code" editstyle="lookup" ListWidth=200   </C>                  
								<C>id="materNm"      name="<%=columnData.getString("mater_nm") %>"          width="240"  align="left" edit={IF(pstatus="01","true","false")}       Data="ds_deliLoct:code:name:code" editstyle="lookup" ListWidth=200 </C>
								<C>id="modelNm"      name="<%=columnData.getString("model_nm") %>"          width="80"  align="left" edit={IF(pstatus="01","true","false")}       Data="ds_deliLoct:code:name:code" editstyle="lookup" ListWidth=200 </C>
								<C>id="unit"        name="<%=columnData.getString("unit") %>"           width="100"  align="center" edit="none"                                </C>
								<C>id="receiptQty"       name="<%=columnData.getString("rec_qty") %>"          width="100"  align="center" edit={IF(pstatus="01","true","false")}       </C>
		      '>
		</object>
    </div>
</div>
<input type="hidden" id="h_deliDate"/>
<input type="hidden" id="h_date"/>
</body>
</html>

