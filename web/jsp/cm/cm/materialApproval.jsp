<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%--
/*
 *************************************************************************
 * @source  : materialApproval.jsp
 * @desc    : 신규 품목 마스터 등록 요청
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2016.09.01               신규작성
 * ---  -----------  ----------  -----------------------------------------
 * HCI 시스템
 * Copyright(c) 2006-2007 LG CNS,  All rights reserved.
 *************************************************************************
 */
--%>
<%@ page import="java.util.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="devon.core.util.*"%>
<%@ page import="comm.util.*"%>
<%@ include file="/include/head.jsp"%>
<%
	String prevDate = LDateUtils.getDate("yyyy/MM/") + "01"; //조회시작 default 날짜
	String currentDate = LDateUtils.getDate("yyyy/MM/dd"); //조회조건 현재 날짜

	String msgCancel = source.getMessage("dev.cfm.com.cancel"); // Are you sure to Continue?
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title>PIT PAM System</title>
<head>
<script language="javascript">
var g_flug =false; // Detail작업 flag
var g_msPos = 0;   // save후  focus 제정의 Row
var g_msg = "";

/***************************************************************************************************/
/*초기 세팅
/***************************************************************************************************/
function onLoad(){
	//Status
	ds_status.DataID ="cm.cm.retrieveCommCodeCombo.gau?groupCd=2016&firstVal=Total";
	ds_status.Reset();
	
	//Unit
	ds_unit.DataID = "cm.cm.retrieveCommCodeCombo.gau?groupCd=2017&firstVal=Select";
	ds_unit.Reset();
	
	f_Disable();
	
	f_retrieve();
}

 


/***************************************************************************************************/
/*버튼 클릭시
/***************************************************************************************************/
//Search 버튼 클릭
function f_retrieve(){
	ds_main.ClearAll();
	ds_main.DataID  = "/cm.cm.retrieveMaterialApproval.gau?";
	ds_main.DataID += "&requestType=20"
	ds_main.DataID += "&fromDate="   + encodeURIComponent(removeDash(fromDate.value,"/")); 
	ds_main.DataID += "&toDate="     + encodeURIComponent(removeDash(toDate.value,"/"));
	ds_main.DataID += "&materNmEn=" 	 + encodeURIComponent(_materNmEn.value);
	ds_main.DataID += "&status=" 	   + lxd_status.ValueOfIndex("code",lxd_status.Index);;
	ds_main.Reset();
	g_flug = false;
}


//Approval 버튼 클릭
function f_approval(){
	
    if(ds_main.NameValue(ds_main.RowPosition, "status") != '01'){
    	alert("<%=source.getMessage("dev.msg.ps.statusApprovalMaterial")%>");
        return;	
    }
	
	if(confirm("<%=source.getMessage("dev.cfm.com.approval")%>")){
		g_msg ="<%=source.getMessage("dev.suc.com.approval")%>";	 

		g_msPos  = ds_main.RowPosition;
		g_flug=true;
		
		ds_main.NameValue(ds_main.RowPosition, "status") = "02"; // 01:request, 02:approval, 03:canceled
		
		tr_cudMaster.KeyValue = "Servlet( I:IN_DS1 = ds_main)";
		tr_cudMaster.Action   = "/cm.cm.cudMaterialApproval.gau?cmdMode=f_approval";
		tr_cudMaster.post();
	}
}


function f_cancel(){
	
    if(ds_main.NameValue(ds_main.RowPosition, "status") != '02'){
    	alert("<%=source.getMessage("dev.msg.ps.statusCancelMaterial")%>");
        return;	
    }
    
    if(f_isNull(ds_main.NameValue(ds_main.RowPosition, "cancelMsg")) == true){
    	alert("Please input cancel reason first.");
        return;	
    }
    
	
	if(confirm("<%=source.getMessage("dev.cfm.com.cancel")%>")){
		g_msg ="<%=source.getMessage("dev.suc.com.cancel")%>";	 

		g_msPos  = ds_main.RowPosition;
		g_flug=true;
		
		ds_main.NameValue(ds_main.RowPosition, "status") = "03"; // 01:request, 02:approval, 03:canceled
		
		tr_cudMaster.KeyValue = "Servlet( I:IN_DS1 = ds_main)";
		tr_cudMaster.Action   = "/cm.cm.cudMaterialApproval.gau?cmdMode=f_cancel";
		tr_cudMaster.post();
	}
}

//해당 문자열이 널인지 점검
function f_isNull( asValue ) {
   	if (asValue == null || asValue == undefined || asValue.toString().replace(/ /g,"") == "" || asValue == 0 ) {
      	 return  true;
   	}
  	return false;
}


      


//-------------------------------------------------------------------------
//STATUS가 'Approval'이면 입력 enable처리.
//-------------------------------------------------------------------------
function f_Enable(){
}

//-------------------------------------------------------------------------
//STATUS이 'Approval'가 아니면 입력 Disable
//-------------------------------------------------------------------------
function f_Disable() {
}

</script>

<!-----------------------------------------------------------------------------
  프로그램 전용 D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- Grid 용 DataSet-->
<object id="ds_main" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad" value="true">
	<param name="ViewDeletedRow" value="false">
</object>

<object id="ds_mainTmp" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad" value="true">
</object>

<!-- lx Combo 용 DataSet-->
<object id="ds_status" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"    value="true">
	<%--
	<param name="DataID"      value="cm.cm.retrieveCommCodeCombo.gau?groupCd=2016&firstVal=Total">
	 --%>
</object>
</comment>

<!-- lx Combo 용 DataSet-->
<object id="ds_unit" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"    value="true">
	<%--
	<param name="DataID"      value="cm.cm.retrieveCommCodeCombo.gau?groupCd=2017&firstVal=Total">
	 --%>
</object>

<!-- CUD TR -->
<OBJECT id=tr_cudMaster classid="<%=LGauceId.TR%>">
	<param name="KeyName" value="toinb_dataid4">
</OBJECT>
<!-- Delete TR -->
<OBJECT id=tr_dMaster classid="<%=LGauceId.TR%>">
	<param name="KeyName" value="toinb_dataid4">
</OBJECT>

<!-----------------------------------------------------------------------------
		   프로그램 전용 G A U C E   C O M P O N E N T' S   E V E N T S
------------------------------------------------------------------------------>
<!-- INSERT/UPDATE Tr 의 트렌젝션 실행 시 -->
<script language=JavaScript for=tr_cudMaster event=OnSuccess()>	
  f_retrieve();
  ds_main.RowPosition = g_msPos;
  alert(g_msg);		
</script>

<script language=JavaScript for=tr_cudMaster event=OnFail()>
  mode = "";
    
  if(tr_cudMaster.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
    window.parent.location.href = "/index.jsp";    
  }
    
  if(tr_cudMaster.ErrorMsg.lastIndexOf("]") != -1) {
    var msgs= tr_cudMaster.ErrorMsg.substring(tr_cudMaster.ErrorMsg.lastIndexOf("]")+2,tr_cudMaster.ErrorMsg.length);
    alert(msgs);
  }  

  f_retrieve();
</script>


<!-- DELETE TR 의 트렌젝션 실행 시 -->
<script language=JavaScript for=tr_dMaster event=OnSuccess()>	       
  f_retrieve();
  
  if(ds_main.CountRow >0){ 
    ds_main.RowPosition = 1;
  }	
	
  alert("<%=source.getMessage("dev.suc.com.delete")%>" );
</script>
<script language=JavaScript for=tr_dMaster event=OnFail()>
  mode = "";
  
  if(tr_dMaster.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
    window.parent.location.href = "/index.jsp";    
  }
  
  alert(tr_dMaster.ErrorMsg);
</script>


<!--grid DataSet -->
<script language=JavaScript for=ds_main event=OnLoadCompleted(rowCnt)>
	cfHideDSWaitMsg(gr_main);//progress bar 숨기기
	cfFillGridNoDataMsg(gr_main,"gridColLineCnt=3");//no data found   
	mode = "";
</script>
<script language=JavaScript for=ds_main event=OnLoadStarted()>
	cfShowDSWaitMsg(gr_main);//progress bar 보이기
	cfHideNoDataMsg(gr_main);//no data 메시지 숨기기
	mode = "";
</script>

<script language=JavaScript for="ds_main" event=OnRowPosApprovald(row)>

  var status = ds_main.NameValue(ds_main.rowPosition,"status");
  
	if(status == "1" || status == ""){
		  f_Enable();
	}else{
		  f_Disable();
	}
	
	g_flug = false;
</script>

<script language=JavaScript for=ds_main event=CanRowPosApproval(row)> 

	if(ds_main.IsUpdated){
		if(!g_flug){	
			alert("<%=source.getMessage("dev.warn.com.continue")%>");
			return false;
		}
	}	
			
</script>
<!-----------------------------------------------------------------------------
    화면영역 시작
------------------------------------------------------------------------------>
</head>

<body id="cent_bg" onload="onLoad()">
	<div id="conts_box">
		<h2><span>Material Approval</span></h2>
		
		<!--검색 S -->
		<fieldset class="boardSearch">
			<div>
				<dl>
					<dt>
						<table width="100%" border="0" cellpadding="0" cellspacing="0"  class="output_board2" >
							<colgroup>
						      <col width="14%"/>
						      <col width="37%"/>
						      <col width="16%"/>
						      <col width="37%"/>
						  </colgroup>
						  <tr>
						    <th>Create Date</th>
						    <td>
						    	<input type="text" id="fromDate" name="fromDate" value="<%= prevDate %>" onblur="valiDate(this);" style="width:65px;" />&nbsp;
						    	<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(fromDate);" style="cursor:hand" /> ~&nbsp;
						    	<input type="text" id="toDate" name="toDate" value="<%= currentDate %>" onblur="valiDate(this);" style="width:65px;" />&nbsp;
						    	<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(toDate);" style="cursor:hand" />
						    </td>
						    <th>Material Name</th>
						    <td><input type="text" id="_materNmEn" style="width:200px;" maxlength="100" /></td>
						  </tr>
						  <tr>
						    <th>Status</th>
						    <td>
						    	<object id="lxd_status" classid="<%=LGauceId.LUXECOMBO%>"  width="90px">
						      	<param name=ComboDataID       value="ds_status"/>
						        <param name=Sort              value=false/>
						        <param name=ListExprFormat    value="name^0^110, code^0^50"/>
						        <param name=BindColumn        value="code"/>
						        <param name=SearchColumn      value=name/>
						        <param name=DisableBackColor  value="#FFFFCC"/>
						      </object>
						    </td>
						  </tr>
					  </table>
				  </dt>
				  <dd class="btnseat1"><span class="search_btn_r search_btn_l"><input type="button" onfocus="blur();" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='#e2ebf7'" value="Search" onclick="f_retrieve();" /></span></dd>
				</dl>
			</div>
		</fieldset>
	  <!--검색 E --><!--조회영역 끝 -->
	  
		<div class="sub_stitle">
			<p>Material Request List</p>
		</div>
		
		<!-- 그리드 S --> <!--==============================Sales List=====================================-->
		<div>
		  <table width="100%" border="0" cellspacing="0" cellpadding="0">
		    <tr>
		      <td>
		        <comment id="__NSID__">
		            <object id="gr_main" classid="<%=LGauceId.GRID %>" style="width:100%;height:280px" class="comn_status">
			            <param name="DataID"          value="ds_main">
			            <param name="Editable"        value="true">
			            <param name="SortView"        value="Left">
			            <param name="UrlImages"       value="<I>Type='PopupBotton', Url='/sys/images/button/cal_icon.gif', Fit='AutoFit', Flat='True'</I>">
			            <param name="UsingOneClick"   value="1">
			            <Param name="TitleHeight"     value="35">
			            <param name="Format"
			              value="
			                  <FC>id='requestNo'       	name='Request No.'      	width='120' align='center'  edit='none' </FC>
			                  <C>id='requestType'     	name='Approval Type'     	width='100' align='center'  edit='none' show='false'</C>
			                  <C>id='requestTypeNm'   	name='Request Type'     	width='120' align='center'  edit='none' </C>
			                  <C>id='materNmEn'        	name='Material Name'     	width='230' align='left'    edit='none' </C>
                        	  <C>id='unit'            	name='Unit'              	width='50'	align='center'  edit='none' Data='ds_unit:code:code'    EditStyle=Lookup</C>
			                  <C>id='status'          	name='Status'            	width='100' align='center'  edit='none' Data='ds_status:code:name'  EditStyle=Lookup</C>
			                  <C>id='materCd'         	name='Material Code'     	width='100' align='center'  edit='none' </C>
			                  <C>id='cancelMsg'       	name='cancelMsg'     		width='100' align='center'  edit='none' show='false' </C>
						      <C>id='sapMsg'   			name='SAP Message'          width='400' align='left'	Edit='none' show='true'      </C>
			            " />
		            </object> 
		        </comment><script>__WS__(__NSID__);</script>
		      </td>
		    </tr>
		  </table>
		</div>
		
		<div class="sub_stitle">
			<p>Material Request Information</p>
		</div>
		
		<!-- ==============================Material Approval Information=====================================-->
		<div id="output_board_area">
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board">
			  <colgroup>
			    <col width="20%" />
			    <col width="25%" />
			    <col width="20%" />
			    <col width="" />
			  </cogroup>
			  <tr>
			  	<th>Request No</th>
			  	<td><input type="text" id="requestNo" style="width:145px;" maxlength="9" class="txtField_read"/></td>
			  	<th>Request Type</th>
			  	<td>
			  		<input type="text"   id="requestTypeNm" style="width:145px;" maxlength="10" class="txtField_read" />
			  	</td>
			  </tr>
			  <tr>
			  	<th>Material Name</th>
			  	<td><input type="text" id="materNmEn" style="width:145px;" maxlength="100" class="txtField_read"/></td>
			  	<th>Unit</th>
			  	<td><input type="text" id="unit" style="width:145px;" maxlength="100" class="txtField_read"/></td>
			  </tr>
			  <tr>
			  	<th>Material Code</th>
			  	<td>
			  		<input type="text"   id="materCd" style="width:145px;" maxlength="10" class="txtField_read" />
			  	</td>
			  	<th>Cancel Reason</th>
			  	<td><input type="text" id="cancelMsg" style="width:220px;" maxlength="100" /></td>
			  </tr>
			</table>
		</div>
		
	<!-- 그리드 E --> 
		<object id=bd_main classid="<%=LGauceId.BIND%>">
		  <param name=DataID value=ds_main>
		  <param name=BindInfo
		    value='
					<C> Col=requestNo        	Ctrl=requestNo      	Param=value  </C>
					<C> Col=materCd          	Ctrl=materCd        	Param=value  </C>
					<C> Col=materNmEn          	Ctrl=materNmEn        	Param=value  </C>
					<C> Col=unit             	Ctrl=unit     			Param=value  </C>
					<C> Col=requestTypeNm       Ctrl=requestTypeNm     	Param=value  </C>
					<C> Col=cancelMsg       	Ctrl=cancelMsg     		Param=value  </C>
	        '>
		</object>
		
	
		<!-- 버튼 S -->
		<div id="btn_area">
	  	<p class="b_right">
	      <span class="btn_r btn_l"><input type="button" onClick="f_approval();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="Approval"/></span>
	      <span class="btn_r btn_l"><input type="button" onClick="f_cancel();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="Cancel"/></span>
			</p>
		</div>
	<!-- 버튼 E -->
	
	</div>
	
	
</body>
</html>