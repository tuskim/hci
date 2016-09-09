<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%--
/*
 *************************************************************************
 * @source  : materialMgnt.jsp
 * @desc    : 품목 마스터 관리
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

	String msgInfoChange = source.getMessage("dev.inf.com.nochange"); // no data for change.
	String msgSave = source.getMessage("dev.cfm.com.save"); // Are you sure to save?
	String msgDelete = source.getMessage("dev.cfm.com.delete"); // Are you sure to Delete?
	String msgCancel = source.getMessage("dev.cfm.com.cancel"); // Are you sure to Continue?
	String msgContinue = source.getMessage("dev.cfm.com.continue"); // Are you sure to Continue?
	String msgApproval = source.getMessage("dev.cfm.com.approval"); // Are you sure to approval?
	String msgConfirm = source.getMessage("dev.cfm.com.confirm"); // Are you sure to confirm?
	String msgSAPsend = source.getMessage("dev.msg.po.sapsend"); // Are you sure to confirm?
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
/***************************************************************************************************/
/*초기 세팅
/***************************************************************************************************/
function onLoad(){
	//Status
	ds_status.DataID ="cm.cm.retrieveCommCodeCombo.gau?groupCd=2016&firstVal=Total";
	ds_status.Reset();
	
	//Unit
	ds_unit.DataID = "cm.cm.retrieveCommCodeCombo.gau?groupCd=2017&firstVal=Total";
	ds_unit.Reset();

	
	ds_requestType.DataID = "cm.cm.retrieveCommCodeCombo.gau?groupCd=2015&firstVal=Total";
	ds_requestType.Reset();
	
	f_Disable();
	f_requestType('10');
	
	document.all.materNm.readOnly = true;
	lxd_unitCd.Enable  = false;
	
}

//-------------------------------------------------------------------------
//-------------------------------------------------------------------------
//STATUS가 'Request'이면 입력 enable처리.
//-------------------------------------------------------------------------
function f_Enable(val){
	materCd.Enable     = true;
	materNm.Enable     = true;
	lxd_unitCd.Enable  = (val=="10"?true:false) ;
	document.all.materSearch.style.display  = (val=="10"?"none":"") ;
	document.getElementById("materCd").className = (val=="10"?"txtField_read":"") ;
	document.getElementById("materNm").className = (val=="30"?"txtField_read":"") ;
	document.all.materNm.readOnly = (val=="30"?true:false) ;
}

//-------------------------------------------------------------------------
//STATUS이 'Request'가 아니면 입력 Disable
//-------------------------------------------------------------------------
function f_Disable(val) {
	materCd.Enable     = false;
	materNm.Enable     = false;
	lxd_unitCd.Enable  = false;
	document.all.materSearch.style.display = "none";
	document.getElementById("materCd").className = "txtField_read";
	document.getElementById("materNm").className = "txtField_read";
	document.all.materNm.readOnly = true;
}

//-------------------------------------------------------------------------
//'Request Type' Radio Click 시 품목 코드 Enable/Disable
//-------------------------------------------------------------------------
function f_requestType(val){
	
  //Request Type:Create(10), Change(20), Delete(30)
	if(ds_main.CountRow == 0){
		document.getElementById("materCd").className = "txtField_read";
		document.getElementById("materNm").className = "txtField_read";
		document.all.materSearch.style.display = "none";
		document.all.materNm.readOnly = true;
		materCd.Enable     = false;
		materNm.Enable     = false;
		lxd_unitCd.Enable  = false;
	}else{
		document.getElementById("materCd").className = (val == "10"?"txtField_read":"");
		document.getElementById("materNm").className = (val == "30"?"txtField_read":"");
		document.all.materSearch.style.display = (val=="10"?"none":"");
		document.all.materNm.readOnly = (val=="30"?true:false) ;
		materCd.Enable     = (val=="20"?true:false) ;
		materNm.Enable     = (val=="30"?false:true) ;
		lxd_unitCd.Enable  = (val=="10"?true:false) ;
	}
	
	//Status:Request(01), Approval(02), Canceled(03) 
	var status = ds_main.NameValue(ds_main.rowPosition,"status");
  if(status == undefined ||status == "" ) status = "01";
	if(status == "01" ){
		materCd.value ="";
		materNm.value ="";
		lxd_unitCd.Index = 0;
		
		if(ds_main.CountRow>0){
			ds_main.NameValue(ds_main.RowPosition, "requestType") = val;
		}
		
	}
	
	
}


// New
function f_addRowMain(){ 
	
	cfHideNoDataMsg(gr_main);//no data 메시지 숨기기
	  
	ds_main.UndoAll();// 빈 row는 1개만 가능하도록 처리
	  
	var reqType ="";
	if(document.all.reqType[0].checked == true){
		reqType ="10"; //Create
	}else if(document.all.reqType[1].checked == true){
		reqType ="20"; //Change
	}else{
		reqType ="30"; //Delete
	}
	
	var condition = "?";
	    condition += "companyCd=<%=g_companyCd %>";
	    condition += "&type=new";
	    condition += "&requestType="+reqType
	      
	ds_mainTmp.DataID = "cm.cm.retrieveMaterialRequest.gau"+condition;
	ds_mainTmp.Reset();
	  
	if(ds_main.CountRow<1){
		var strHeader = "requestNo"          + ":STRING(20)"
		              +",requestType"        + ":STRING(100)"
									+",materNm"            + ":STRING(100)"
									+",unit"               + ":STRING(20)"
									+",status"             + ":STRING(10)"
									+",materCd"            + ":STRING(20)"
									;
		ds_main.SetDataHeader(strHeader);
    cfHideNoDataMsg(gr_main);		
	}
	
	ds_main.AddRow(); 
	
	ds_main.NameValue(ds_main.RowPosition, "requestNo")   = ds_mainTmp.NameValue(1, "requestNo");
	ds_main.NameValue(ds_main.RowPosition, "requestType") = reqType;
	ds_main.NameValue(ds_main.RowPosition, "status")      = ds_mainTmp.NameValue(1, "status");
	
	document.all.materNm.readOnly = (reqType == "30"?true:false);
	
	document.all("reqType")[0].disabled = false;
	document.all("reqType")[1].disabled = false;
	document.all("reqType")[2].disabled = false;
}
 


/***************************************************************************************************/
/*버튼 클릭시
/***************************************************************************************************/
//Search 버튼 클릭
function f_retrieve(){
	ds_main.ClearAll();
	ds_main.DataID  = "/cm.cm.retrieveMaterialRequest.gau?";
  ds_main.DataID += "&fromDate="    + encodeURIComponent(removeDash(fromDate.value,"/")); 
  ds_main.DataID += "&toDate="      + encodeURIComponent(removeDash(toDate.value,"/"));
  ds_main.DataID += "&materNm=" 	  + encodeURIComponent(_materNm.value);
	ds_main.DataID += "&requestType=" + lxd_requestType.ValueOfIndex("code",lxd_requestType.Index);
	ds_main.DataID += "&status=" 	    + lxd_status.ValueOfIndex("code",lxd_status.Index);
	ds_main.Reset();
	g_flug = false;
}


//Request 버튼 클릭
function f_request(){
	var chkCountNo=0;
	
	if(!ds_main.IsUpdated) {
		alert("<%=msgInfoChange%>" );
		return;
	
	}else{	
	 	
		//'Request' Status 외에는 수정 및 삭제 불가.
		if(ds_main.NameValue(ds_main.RowPosition,"status") == "01"){
			if(f_vali()){
				if(confirm("<%=msgSave%>")){
					g_msPos  = ds_main.RowPosition;
					g_flug=true;
					tr_cudMaster.KeyValue = "Servlet( I:IN_DS1 = ds_main)";
					tr_cudMaster.Action   = "/cm.cm.cudMaterialRequest.gau?";
					tr_cudMaster.post();
				}
			}
		}else{
			alert("<%=source.getMessage("dev.msg.ps.statusSaveMaterial")%>");
			return;
		}
	 	
  }
}

//Delele
function f_delete(){
	var chkCountNo=0;
	
	if(ds_main.CountRow<1){
		alert("<%=source.getMessage("dev.inf.com.nodelete")%>");
		return;
	}
	
    //0:Normal, 1:Insert, 2:Delete, 3:Update, 4:Logical
  var rowStatus = ds_main.RowStatus(ds_main.RowPosition);
	if( rowStatus == '1'){
		//alert("Can't delete status.");
		ds_main.DeleteRow(ds_main.RowPosition)
		return;
	}
	
 	//'Request' Status 외에는 수정 및 삭제 불가.
 	if(ds_main.NameValue(ds_main.RowPosition,"status") == "01"){
		if(confirm("<%=source.getMessage("dev.cfm.com.delete")%>")){

			if(ds_main.RowPosition>0)	{
				ds_main.DeleteRow(ds_main.RowPosition);
			}
			
		  g_flug=true;
			tr_dMaster.KeyValue = "Servlet( I:IN_DS1 = ds_main )";
			tr_dMaster.Action   = "/cm.cm.cudMaterialRequest.gau?";
			tr_dMaster.post();
		}
	}else{
		alert("<%=source.getMessage("dev.msg.ps.statusDeleteMaterial")%>");
		return;
	}
 	
}

//Save validation Check
function f_vali(){
	var val_flag = true;

	//ds_main validation
	if( f_isNull(ds_main.NameValue( ds_main.rowPosition , "requestNo" ))){
		alert("<%=source.getMessage("dev.warn.com.input",columnData.getString("requestNo"))%>");
		return false;
	}
	if( f_isNull(ds_main.NameValue( ds_main.rowPosition , "materNm" ))){
		alert("<%=source.getMessage("dev.warn.com.input",columnData.getString("materNm"))%>");
		return false;
	}
	if( f_isNull(ds_main.NameValue( ds_main.rowPosition , "unit" ))){
		alert("<%=source.getMessage("dev.warn.com.input",columnData.getString("unit"))%>");
		return false;
	}
	
 	return val_flag;	
}

//해당 문자열이 널인지 점검
function f_isNull( asValue ) {
   	if (asValue == null || asValue == undefined || asValue.toString().replace(/ /g,"") == "" || asValue == 0 ) {
      	 return  true;
   	}
  	return false;
}

//Grid Material Popup
function openCementMaterialCodeListPopUp(row, obj,type) {
	var status = ds_main.NameValue(ds_main.rowPosition,"status");
	  
	if(status != "01"){
	  alert("Can't search material PopUp.");
	  return;
  }
	
  var result = "";
  var firstList = new Array ();
  //http://127.0.0.1:6200/jsp/cm/cd/pop_MaterialCodeListCon.jsp?materCd=&type=PO&tgOneSelect=T&popType=ptpam_MaterialCodeListCon
	var popupId             = "MaterialCodeListCon";
  var popupStr            = "/jsp/cm/cd/pop_" + popupId + ".jsp";
  
  type = "MA";
  
  if (type != "") {
	  popupStr = popupStr + "?type=" + type;
	  popupStr += "&tgOneSelect=T&popType=ptpam_MaterialCodeListCon";
  }
  
  //var tgOneSelect         = "&tgOneSelect="       + "T";                      // 한 건인 경우 자동선택
  var popupWidth          = "dialogWidth="        + "580px";
  var popupHeight         = ";dialogHeight="      + "470px";

  result = window.showModalDialog( popupStr , popupId, popupWidth + popupHeight );

  if (result == -1 || result == null || result == "") {

	//  ds_main.NameValue(ds_main.RowPosition,"materCd") = "";
	//  ds_main.NameValue(ds_main.RowPosition,"materNm") = "";
	 // ds_main.NameValue(ds_main.RowPosition,"unit") = "";
	} else {
    firstList = result.split(";");
    ds_main.NameValue(ds_main.RowPosition,"materCd")    = firstList[0];
    ds_main.NameValue(ds_main.RowPosition,"materNm")    = firstList[1];
    ds_main.NameValue(ds_main.RowPosition,"unit")       = firstList[2];
  }
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

<!-- lx Combo 용 DataSet-->
<object id="ds_requestType" classid="<%=LGauceId.DATASET%>">
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
	alert("<%=source.getMessage("dev.suc.com.save")%>" );		
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

<script language=JavaScript for="ds_main" event=OnRowPosChanged(row)>

  var status = ds_main.NameValue(ds_main.rowPosition,"status");
  var reqType = ds_main.NameValue(ds_main.rowPosition,"requestType");

  //New 일 경우 Dataset에 requestType이 존재 하지 않아서 재지정.
  if(status== ""){
		if(document.all.reqType[0].checked == true){
			reqType ="10"; //Create
		}else if(document.all.reqType[1].checked == true){
			reqType ="20"; //Change
		}else{
			reqType ="30"; //Delete
		}
  }

  if(reqType == "10"){
	  document.all.reqType[0].checked = true;
  }else if(reqType == "20"){
	  document.all.reqType[1].checked = true;
  }else{
	  document.all.reqType[2].checked = true;
  }
  
  //Status: ""(New), Request(01), Approval(02), Canceled(03) 
	if(status == "01" || status == ""){
		f_Enable(reqType);
	}else{
		f_Disable(reqType);
	}
	
	g_flug = false;
	
	document.all("reqType")[0].disabled = true;
	document.all("reqType")[1].disabled = true;
	document.all("reqType")[2].disabled = true;
	
</script>

<script language=JavaScript for=ds_main event=CanRowPosChange(row)> 

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
		<h2><span>Material Management</span></h2>
		
		<!--검색 S -->
		<fieldset class="boardSearch">
			<div>
				<dl>
					<dt>
						<table width="100%" border="0" cellpadding="0" cellspacing="0"  class="output_board2" >
							<colgroup>
						      <col width="110px"/>
						      <col width="275px"/>
						      <col width="110px"/>
						      <col width="100px"/>
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
						    <td><input type="text" id="_materNm" style="width:200px;" maxlength="100" /></td>
						  </tr>
						  <tr>
						    <th>Request Type</th>
						    <td>
						    	<object id="lxd_requestType" classid="<%=LGauceId.LUXECOMBO%>"  width="90px">
						      	<param name=ComboDataID       value="ds_requestType"/>
						        <param name=Sort              value=false/>
						        <param name=ListExprFormat    value="name^0^110, code^0^50"/>
						        <param name=BindColumn        value="code"/>
						        <param name=SearchColumn      value=name/>
						        <param name=DisableBackColor  value="#FFFFCC"/>
						      </object>
						    </td>
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
			                  <C>id='requestNo'       name='Request No.'       width='110'  align='center'  edit='none' </C>
			                  <C>id='requestType'     name='Request Type'      width='100'  align='center'  edit='none' Data='ds_requestType:code:name' EditStyle=Lookup</C>
			                  <C>id='materNm'         name='Material Name'     width='225'  align='left'    edit='none' </C>
                        	  <C>id='unit'            name='Unit'              width='60'  align='center'   edit='none' Data='ds_unit:code:code'    EditStyle=Lookup</C>
			                  <C>id='status'          name='Status'            width='110'  align='center'   edit='none' Data='ds_status:code:name'  EditStyle=Lookup</C>
			                  <C>id='materCd'         name='Material Code'     width='120'  align='center'  edit='none' </C>
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
		
		<!-- ==============================Material Request Information=====================================-->
		<div id="output_board_area">
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board">
			  <colgroup>
			    <col width="20%" />
			    <col width="30%" />
			    <col width="20%" />
			    <col width="30%" />
			  </cogroup>
			  <tr>
			  	<th>Request Type</th>
			  	<td colspan="3">
			  		<input type="radio" name="reqType" value="10" checked class="radio" onclick="f_requestType(this.value);">Create&nbsp;&nbsp;
			  		<input type="radio" name="reqType" value="20" class="radio" onclick="f_requestType(this.value);">Change&nbsp;&nbsp;
			  		<input type="radio" name="reqType" value="30" class="radio" onclick="f_requestType(this.value);">Delete
			  	</td>
			  </tr>
			  <tr>
			  	<th>Request No</th>
			  	<td><input type="text" id="requestNo" style="width:145px;" maxlength="9" readonly class="txtField_read" /></td>
			  	<th>Material Code</th>
			  	<td>
			  		<input type="text"   id="materCd" style="width:145px;" maxlength="10" readonly/>
				    <img id="materSearch" src="<%= images %>button/search_icon_2.gif" alt="customer search popup" onClick="javascript:openCementMaterialCodeListPopUp();" style="cursor:hand" />
			  	</td>
			  </tr>
			  <tr>
			  	<th>Material Name</th>
			  	<td><input type="text" id="materNm" style="width:145px;" maxlength="100" /></td>
			  	<th>Unit</th>
			    <td>
			      <object id="lxd_unitCd" classid="<%=LGauceId.LUXECOMBO%>" align="absmiddle" width="70">
				      <param name="ComboDataID"  value="ds_unit">
				      <param name="ListCount"    value="10">
				      <param name="ReadOnly"     value="true">
				      <param name="BindColumn"   value="code">
				      <param name="Enable"       value="true">
				      <%--
				      <param name=ListExprFormat value="name^0^160,code^0^80">
				       --%>
				      <param name=ListExprFormat value="code^0^60">
			      </object>
			    </td>
			  </tr>
			</table>
		</div>
		
	<!-- 그리드 E --> 
		<object id=bd_main classid="<%=LGauceId.BIND%>">
		  <param name=DataID value=ds_main>
		  <param name=BindInfo
		    value='
					<C> Col=requestNo        Ctrl=requestNo      Param=value  </C>
					<C> Col=materNm          Ctrl=materNm        Param=value  </C>
					<C> Col=materCd          Ctrl=materCd        Param=value  </C>
					<C> Col=unit             Ctrl=lxd_unitCd     Param=BindColVal  </C>
	        '>
		</object>
		
	
		<!-- 버튼 S -->
		<div id="btn_area">
	  	<p class="b_right">
	    	<span class="btn_r btn_l"><input type="button" onClick="f_addRowMain();"  onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="New"/></span>
	      <span class="btn_r btn_l"><input type="button" onClick="f_request();"        onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="Request"/></span>
	      <span class="btn_r btn_l"><input type="button" onClick="f_delete();"      onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="Delete"/></span>
			</p>
		</div>
	<!-- 버튼 E -->
	
	</div>
	
	
</body>
</html>