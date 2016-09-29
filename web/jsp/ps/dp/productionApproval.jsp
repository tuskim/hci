<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--
/*
*************************************************************************
* @source  : productionApproval.jsp
* @desc    : Production Approval
*------------------------------------------------------------------------
* VER  DATE         AUTHOR      DESCRIPTION
* ---  -----------  ----------  -----------------------------------------
* 1.0  2016.08.02    cspark       init
* ---  -----------  ----------  -----------------------------------------
* HCI System
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





<title>HCI System</title>
<%@ include file="/include/head.jsp" %>



<%
String currentDate = LDateUtils.getDate("yyyy/MM/dd");          // currentDate
%> 



<script type="text/javascript">
parent.centerFrame.cols='220,*';
var g_msg = "";

/***************************************************************************************************/
/*초기 세팅
/***************************************************************************************************/
function init() {
	f_retrieve();
}




/***************************************************************************************************/
/*조회
/***************************************************************************************************/

// Master 조회
function f_retrieve() { 
	f_retrieveProd01();
	f_retrieveProd02();
	f_retrieveProd03();
	f_retrieveProd04();
	f_retrieveProd05();
}

function f_retrieveProd01() { 
	///////////////////////////////////////////////////////////////////////
	// 검색조건
	var v_url = new cfURI();
	v_url.Add("toDate", encodeURIComponent(toDate.value));
	v_url.Add("listType", "f_retrieveProd01");
	///////////////////////////////////////////////////////////////////////

	v_url.SetPage("ps.dp.retrieveProductionApproval.gau");
	ds_prod01.DataId = v_url.GetURI();
	ds_prod01.Reset(); 
}

function f_retrieveProd02() { 
	///////////////////////////////////////////////////////////////////////
	// 검색조건
	var v_url = new cfURI();
	v_url.Add("toDate", encodeURIComponent(toDate.value));
	v_url.Add("listType", "f_retrieveProd02");
	///////////////////////////////////////////////////////////////////////

	v_url.SetPage("ps.dp.retrieveProductionApproval.gau");
	ds_prod02.DataId = v_url.GetURI();
	ds_prod02.Reset(); 
}

function f_retrieveProd03() { 
	///////////////////////////////////////////////////////////////////////
	// 검색조건
	var v_url = new cfURI();
	v_url.Add("toDate", encodeURIComponent(toDate.value));
	v_url.Add("listType", "f_retrieveProd03");
	///////////////////////////////////////////////////////////////////////

	v_url.SetPage("ps.dp.retrieveProductionApproval.gau");
	ds_prod03.DataId = v_url.GetURI();
	ds_prod03.Reset(); 
}

function f_retrieveProd04() { 
	///////////////////////////////////////////////////////////////////////
	// 검색조건
	var v_url = new cfURI();
	v_url.Add("toDate", encodeURIComponent(toDate.value));
	v_url.Add("listType", "f_retrieveProd04");
	///////////////////////////////////////////////////////////////////////

	v_url.SetPage("ps.dp.retrieveProductionApproval.gau");
	ds_prod04.DataId = v_url.GetURI();
	ds_prod04.Reset(); 
}

function f_retrieveProd05() { 
	///////////////////////////////////////////////////////////////////////
	// 검색조건
	var v_url = new cfURI();
	v_url.Add("toDate", encodeURIComponent(toDate.value));
	v_url.Add("listType", "f_retrieveProd05");
	///////////////////////////////////////////////////////////////////////

	v_url.SetPage("ps.dp.retrieveProductionApproval.gau");
	ds_prod05.DataId = v_url.GetURI();
	ds_prod05.Reset(); 
}





/***************************************************************************************************/
/*EX
/***************************************************************************************************/
function f_approval() {
	// 승인호출
	if(confirm("<%=source.getMessage("dev.cfm.com.approval")%>")){         
		g_msg ="<%=source.getMessage("dev.suc.com.approval")%>";	 

		//////////////////////////////////////////////////////////////////////////////////////////
		// cud 호출
		for(var i=1;i<=ds_prod01.CountRow; i++){
			ds_prod01.NameValue(i, "status") = "01"; // 01:approval, 00: reject(progress)
		} 
		for(var i=1;i<=ds_prod02.CountRow; i++){
			ds_prod02.NameValue(i, "status") = "01"; // 01:approval, 00: reject(progress)
		} 
		for(var i=1;i<=ds_prod03.CountRow; i++){
			ds_prod03.NameValue(i, "status") = "01"; // 01:approval, 00: reject(progress)
		} 
		for(var i=1;i<=ds_prod04.CountRow; i++){
			ds_prod04.NameValue(i, "status") = "01"; // 01:approval, 00: reject(progress)
		} 
		for(var i=1;i<=ds_prod05.CountRow; i++){
			ds_prod05.NameValue(i, "status") = "01"; // 01:approval, 00: reject(progress)
		} 
		
		tr_cudMaster.Action   = "ps.dp.cudProductionApprovalStatus.gau";		
		tr_cudMaster.post();
		//////////////////////////////////////////////////////////////////////////////////////////
	} 
}

function f_reject() {
	// 거절호출
	if(confirm("<%=source.getMessage("dev.cfm.com.reject")%>")){         
		g_msg ="<%=source.getMessage("dev.suc.com.reject")%>";	 
		
		//////////////////////////////////////////////////////////////////////////////////////////
		// cud 호출
		for(var i=1;i<=ds_prod01.CountRow; i++){
			ds_prod01.NameValue(i, "status") = "00"; // 01:approval, 00: reject(progress)
		} 
		for(var i=1;i<=ds_prod02.CountRow; i++){
			ds_prod02.NameValue(i, "status") = "00"; // 01:approval, 00: reject(progress)
		} 
		for(var i=1;i<=ds_prod03.CountRow; i++){
			ds_prod03.NameValue(i, "status") = "00"; // 01:approval, 00: reject(progress)
		} 
		for(var i=1;i<=ds_prod04.CountRow; i++){
			ds_prod04.NameValue(i, "status") = "00"; // 01:approval, 00: reject(progress)
		} 
		for(var i=1;i<=ds_prod05.CountRow; i++){
			ds_prod05.NameValue(i, "status") = "00"; // 01:approval, 00: reject(progress)
		} 

		tr_cudMaster.Action   = "ps.dp.cudProductionApprovalStatus.gau";		
		tr_cudMaster.post();
		//////////////////////////////////////////////////////////////////////////////////////////
	} 
}

</script>














 
 
<!-----------------------------------------------------------------------------
D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- Dataset Prod01 ---------------------------------------------------------------------------------->
<object id="ds_prod01" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true">
	<param name="ViewDeletedRow"    value="false">
</object>

<script language=JavaScript for=ds_prod01 event=OnLoadStarted()>
  cfShowDSWaitMsg(gr_prod01);//progress bar 보이기
  cfHideNoDataMsg(gr_prod01);//no data 메시지 숨기기
</script>

<script language=JavaScript for=ds_prod01 event=OnLoadCompleted(rowCnt)>
  cfHideDSWaitMsg(gr_prod01);//progress bar 숨기기
  cfFillGridNoDataMsg(gr_prod01,"gridColLineCnt=2");//no data found   
</script> 




<!-- Dataset Prod02 ---------------------------------------------------------------------------------->
<object id="ds_prod02" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true">
	<param name="ViewDeletedRow"    value="false">
</object>

<script language=JavaScript for=ds_prod02 event=OnLoadStarted()>
  cfShowDSWaitMsg(gr_prod02);//progress bar 보이기
  cfHideNoDataMsg(gr_prod02);//no data 메시지 숨기기
</script>

<script language=JavaScript for=ds_prod02 event=OnLoadCompleted(rowCnt)>
  cfHideDSWaitMsg(gr_prod02);//progress bar 숨기기
  cfFillGridNoDataMsg(gr_prod02,"gridColLineCnt=2");//no data found   
</script> 




<!-- Dataset Prod03 ---------------------------------------------------------------------------------->
<object id="ds_prod03" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true">
	<param name="ViewDeletedRow"    value="false">
</object>

<script language=JavaScript for=ds_prod03 event=OnLoadStarted()>
  cfShowDSWaitMsg(gr_prod03);//progress bar 보이기
  cfHideNoDataMsg(gr_prod03);//no data 메시지 숨기기
</script>

<script language=JavaScript for=ds_prod03 event=OnLoadCompleted(rowCnt)>
  cfHideDSWaitMsg(gr_prod03);//progress bar 숨기기
  cfFillGridNoDataMsg(gr_prod03,"gridColLineCnt=2");//no data found   
</script> 




<!-- Dataset Prod04 ---------------------------------------------------------------------------------->
<object id="ds_prod04" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true">
	<param name="ViewDeletedRow"    value="false">
</object>

<script language=JavaScript for=ds_prod04 event=OnLoadStarted()>
  cfShowDSWaitMsg(gr_prod04);//progress bar 보이기
  cfHideNoDataMsg(gr_prod04);//no data 메시지 숨기기
</script>

<script language=JavaScript for=ds_prod04 event=OnLoadCompleted(rowCnt)>
  cfHideDSWaitMsg(gr_prod04);//progress bar 숨기기
  cfFillGridNoDataMsg(gr_prod04,"gridColLineCnt=2");//no data found   
</script> 




<!-- Dataset Prod05 ---------------------------------------------------------------------------------->
<object id="ds_prod05" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true">
	<param name="ViewDeletedRow"    value="false">
</object>

<script language=JavaScript for=ds_prod05 event=OnLoadStarted()>
  cfShowDSWaitMsg(gr_prod05);//progress bar 보이기
  cfHideNoDataMsg(gr_prod05);//no data 메시지 숨기기
</script>

<script language=JavaScript for=ds_prod05 event=OnLoadCompleted(rowCnt)>
  cfHideDSWaitMsg(gr_prod05);//progress bar 숨기기
  cfFillGridNoDataMsg(gr_prod05,"gridColLineCnt=2");//no data found   
</script> 










<!-----------------------------------------------------------------------------
Grid   E V E N T S
------------------------------------------------------------------------------>
<!-- Grid Master-------------------------------------------------------------------------------------->
<script language=JavaScript for=gr_prod01 event=OnKeyUp(row,colid,keycode)>
</script> 




<!-----------------------------------------------------------------------------
T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- CUD TR -->
<!-- Payment Arrange CUD TR -->
<OBJECT id=tr_cudMaster classid="<%=LGauceId.TR%>">
	<param name="KeyName"   value="toinb_dataid4"> 
	<param name="KeyValue"  value="JSP(I:ds_prod01=ds_prod01,I:ds_prod02=ds_prod02,I:ds_prod03=ds_prod03,I:ds_prod04=ds_prod04,I:ds_prod05=ds_prod05)">
	<param name="ServerIP"  value=""> 
</OBJECT>
 
<script language=JavaScript for=tr_cudMaster event=OnSuccess()>
	f_retrieve(); // 재조회
	alert(g_msg);
</script>  

<script language=JavaScript for=tr_cudMaster event=OnFail()>
    if(tr_cudMaster.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
		window.parent.location.href = "/index.jsp";    
	}
    
	f_retrieve(); // 재조회
	alert(tr_cudMaster.ErrorMsg);
</script>
 
</head>

















<body id="cent_bg" onload="init();">
<div id="conts_box">
	<h2> <span> Production Approval </span></h2>
	<!--검색 S -->	
	<fieldset class="boardSearch"> 
		<div>
			<dl>
				<dt> 
					<table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board2" >
						<colgroup>
							<col width="18%"/>
							<col width=""/>
						</colgroup>
						<tr>
							<th>Production Date</th>
							<td>
								<input type="text" onblur="valiDate(this);" style="width:70px;" id="toDate" value="<%= currentDate %>" />
								<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="" onclick="javascript:OpenCalendar(toDate);" class="button_cal"/>
							</td> 
						</tr>
					</table>
				</dt>              		  	   	 	
				<dd class="btnseat1"> 
					<span class="search_btn_r search_btn_l">
						<input type="button" onfocus="blur();" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='#e2ebf7'" value="<%=btnSearch %>" onclick="f_retrieve();"/>
					</span> 
				</dd>						
			</dl>
		</div>
	</fieldset>
	<!--검색 E -->
	
	
	
			

	<div class="sub_stitle"> 
		<p>1. Limestone Production</p>
		<p class="rightbtn">
		</p>			
	</div>    
	<!-- 그리드 Master S -->
	<div>
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td>
					<comment id="__NSID__">
					<object id="gr_prod01" classid="<%=LGauceId.GRID %>" style="width:100%;height:56px;" class="comn">
						<param name="DataID"            value="ds_prod01"/> 
						<param name="Editable"          value="false"/>
						<Param name="AutoResizing"      value="true">
       					<param name="ViewSummary"       value="0"/>
				        <param name="TitleHeight"   	value="35">
						<param name="Format"            
							   value="
						    <C> id='syskey'    		name='Production No.'			align='center' 	width='95' 		Edit='none' show='true'</C>
						    <C> id='prodDate'    	name='Production Date'			align='center' 	width='95' 		Edit='none' show='true'	DisplayFormat ='XXXX/XX/XX'</C>
						    <C> id='materNm'     	name='Production Material' 		align='left'  	width='120' 	Edit='none' show='true'</C>
						    <C> id='prodQty'     	name='Production;Quantity(Ton)'	align='right'  	width='100' 	Edit='none' show='true'	DisplayFormat ='#,###.000'</C>
						    <C> id='statusNm'    	name='Status'					align='center' 	width='100' 	Edit='none' show='true'</C>
                        "/>
					</object>
					</comment><script>__WS__(__NSID__);</script>
				</td>
			</tr>
		</table>
	</div>
	<!-- 그리드 Master E -->




	<div class="sub_stitle"> 
		<p>2. Rawmix Production</p>
		<p class="rightbtn">
		</p>			
	</div>    
	<!-- 그리드 Master S -->
	<div>
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td>
					<comment id="__NSID__">
					<object id="gr_prod02" classid="<%=LGauceId.GRID %>" style="width:100%;height:125px;" class="comn">
						<param name="DataID"            value="ds_prod02"/> 
						<param name="Editable"          value="false"/>
						<Param name="AutoResizing"      value="true">
       					<param name="ViewSummary"       value="0"/>
				        <param name="TitleHeight"   	value="35">
						<param name="Format"            
							   value="
						    <C> id='syskey'    		name='Production No.'			align='center' 	width='95' 	Edit='none' show='true'	Suppress=1</C>
						    <C> id='prodDate'    	name='Production Date'			align='center' 	width='95' 	Edit='none' show='true'	Suppress=1	DisplayFormat ='XXXX/XX/XX'</C>
						    <C> id='materNm'     	name='Use Material'				align='left'  	width='120'	Edit='none' show='true'	SumText='Total'</C>
						    <C> id='useQty'     	name='Use Quantity' 			align='right'  	width='100'	Edit='none' show='true'	DisplayFormat ='#,###.000'	SumText='@sum'</C>
						    <C> id='useRate'     	name='Use Rate' 				align='right'  	width='70'	Edit='none' show='true'	DisplayFormat ='#,##0%'	SumText='@sum'</C>
						    <C> id='prodMaterNm'   	name='Production Material' 		align='left'  	width='120'	Edit='none' show='true'	Suppress=1</C>
						    <C> id='prodQty'     	name='Production;Quantity(Ton)' align='right'  	width='100'	Edit='none' show='true'	Suppress=1	DisplayFormat ='#,###.000'	SumText='@sum'</C>
						    <C> id='statusNm'    	name='Status'					align='center' 	width='90'	Edit='none' show='true'	Suppress=1</C>
                        "/>
					</object>
					</comment><script>__WS__(__NSID__);</script>
				</td>
			</tr>
		</table>
	</div>
	<!-- 그리드 Master E -->




	<div class="sub_stitle"> 
		<p>3. Clinker Production</p>
		<p class="rightbtn">
		</p>			
	</div>    
	<!-- 그리드 Master S -->
	<div>
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td>
					<comment id="__NSID__">
					<object id="gr_prod03" classid="<%=LGauceId.GRID %>" style="width:100%;height:66px;" class="comn">
						<param name="DataID"            value="ds_prod03"/> 
						<param name="Editable"          value="false"/>
						<Param name="AutoResizing"      value="true">
       					<param name="ViewSummary"       value="0"/>
						<param name="Format"            
							   value="
						    <C> id='syskey'    		name='Production No.'			align='center' 	width='95' 	Edit='none' show='true'	Suppress=1</C>
						    <C> id='prodDate'    	name='Production Date'			align='center' 	width='95' 	Edit='none' show='true'	Suppress=1	DisplayFormat ='XXXX/XX/XX'</C>
						    <C> id='materNm'     	name='Use Material'				align='left'  	width='120'	Edit='none' show='true'	SumText='Total'</C>
						    <C> id='useQty'     	name='Use Quantity' 			align='right'  	width='100'	Edit='none' show='true'	DisplayFormat ='#,###.000'	SumText='@sum'</C>
						    <C> id='prodMaterNm'   	name='Production Material' 		align='left'  	width='150'	Edit='none' show='true'	Suppress=1</C>
						    <C> id='prodQty'     	name='Production Quantity' 		align='right'  	width='130'	Edit='none' show='true'	Suppress=1	DisplayFormat ='#,###.000'	SumText='@sum'</C>
						    <C> id='statusNm'    	name='Status'					align='center' 	width='100'	Edit='none' show='true'	Suppress=1</C>
                        "/>
					</object>
					</comment><script>__WS__(__NSID__);</script>
				</td>
			</tr>
		</table>
	</div>
	<!-- 그리드 Master E -->




	<div class="sub_stitle"> 
		<p>4. Cement Production</p>
		<p class="rightbtn">
		</p>			
	</div>    
	<!-- 그리드 Master S -->
	<div>
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td>
					<comment id="__NSID__">
					<object id="gr_prod04" classid="<%=LGauceId.GRID %>" style="width:100%;height:110px;" class="comn">
						<param name="DataID"            value="ds_prod04"/> 
						<param name="Editable"          value="false"/>
						<Param name="AutoResizing"      value="true">
       					<param name="ViewSummary"       value="0"/>
						<param name="Format"            
							   value="
						    <C> id='syskey'    		name='Production No.'			align='center' 	width='95' 	Edit='none' show='true'	Suppress=1</C>
						    <C> id='prodDate'    	name='Production Date'			align='center' 	width='95' 	Edit='none' show='true'	Suppress=1	DisplayFormat ='XXXX/XX/XX'</C>
						    <C> id='materNm'     	name='Use Material'				align='left'  	width='100'	Edit='none' show='true'	SumText='Total'</C>
						    <C> id='useQty'     	name='Use Quantity' 			align='right'  	width='100'	Edit='none' show='true'	DisplayFormat ='#,###.000'	SumText='@sum'</C>
						    <C> id='useRate'     	name='Use Rate' 				align='right'  	width='60'	Edit='none' show='true'	DisplayFormat ='#,##0%'	SumText='@sum'</C>
						    <C> id='prodMaterNm'   	name='Production Material' 		align='left'  	width='120'	Edit='none' show='true'	Suppress=1</C>
						    <C> id='prodQty'     	name='Production Quantity' 		align='right'  	width='130'	Edit='none' show='true'	Suppress=1	DisplayFormat ='#,###.000'	SumText='@sum'</C>
						    <C> id='statusNm'    	name='Status'					align='center' 	width='90'	Edit='none' show='true'	Suppress=1</C>
                        "/>
					</object>
					</comment><script>__WS__(__NSID__);</script>
				</td>
			</tr>
		</table>
	</div>
	<!-- 그리드 Master E -->




	<div class="sub_stitle"> 
		<p>5. Cement Packing</p>
		<p class="rightbtn">
		</p>			
	</div>    
	<!-- 그리드 Master S -->
	<div>
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td>
					<comment id="__NSID__">
					<object id="gr_prod05" classid="<%=LGauceId.GRID %>" style="width:100%;height:46px;" class="comn">
						<param name="DataID"            value="ds_prod05"/> 
						<param name="Editable"          value="false"/>
						<Param name="AutoResizing"      value="true">
       					<param name="ViewSummary"       value="0"/>
						<param name="Format"            
							   value="
						    <C> id='syskey'    		name='Production No.'			align='center' 	width='95' 	Edit='none' show='true'	Suppress=1</C>
						    <C> id='prodDate'    	name='Production Date'			align='center' 	width='95' 	Edit='none' show='true'	Suppress=1	DisplayFormat ='XXXX/XX/XX'</C>
						    <C> id='materNm'     	name='Use Material'				align='left'  	width='120'	Edit='none' show='true'	SumText='Total'</C>
						    <C> id='useQty'     	name='Use Quantity' 			align='right'  	width='100'	Edit='none' show='true'	DisplayFormat ='#,###.000'	SumText='@sum'</C>
						    <C> id='prodMaterNm'   	name='Production Material' 		align='left'  	width='150'	Edit='none' show='true'	Suppress=1</C>
						    <C> id='prodQty'     	name='Production Quantity' 		align='right'  	width='130'	Edit='none' show='true'	Suppress=1	DisplayFormat ='#,###.000'	SumText='@sum'</C>
						    <C> id='statusNm'    	name='Status'					align='center' 	width='100'	Edit='none' show='true'	Suppress=1</C>
                        "/>
					</object>
					</comment><script>__WS__(__NSID__);</script>
				</td>
			</tr>
		</table>
	</div>
	<!-- 그리드 Master E -->
	
	
	
		<br>
		<!-- 버튼 S -->	
		<div id="btn_area">
			<p class="b_right">
<%
// 버튼 권한 처리
if(g_authCd.equals("AD") || g_authCd.equals("PDM")) {
%>
				<span class="btn_r btn_l"><input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnApproval%>" onclick="f_approval()"/></span>  								
				<span class="btn_r btn_l"><input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnReject%>" onclick="f_reject()"/></span>  								
<% 
}
%>
			</p>
		</div>
		<!-- 버튼 E --> 
	
	
	
</div>
</body>
</html>
