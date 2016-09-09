<%--
/*
 *************************************************************************
 * @source  : tempCommPopup.jsp
 * @desc    : cost Total Ledger Excel Upload
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2010/08/03   mskim       Init
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
<title>Cost Total Ledger Excel Upload</title>
<%@ include file="/include/head.jsp" %>

<%
	String prevDate	   = LDateUtils.getDate("yyyy/MM/") +"01"; 
	String currentDate = LDateUtils.getDate("yyyy/MM/dd");          // currentDate
%>

<script type="text/javascript">

	// 주의: 하단 그리드의 컬럼이 추가되는 경우, [strHeaderDtl], [gr_grid]를 동일하게 구성해야 합니다.
	var strHeaderDtl = "chk"        + ":STRING(3)"
	                 + ",acctCd"   	+ ":STRING(100)"
	                 + ",acctNm"    + ":STRING(100)"
	                 + ",materCd"   + ":STRING(100)"
	                 + ",materNm"   + ":STRING(100)"
	                 + ",unit"      + ":STRING(100)"
	                 + ",vendCd"    + ":STRING(100)"
	                 + ",vendNm"    + ":STRING(100)";

    //-------------------------------------------------------------------------
	// Load
	//-------------------------------------------------------------------------
	function f_Onload() {
       f_Add();
	}

	//-------------------------------------------------------------------------
	// Add Item
	//-------------------------------------------------------------------------
	function f_Add(){

	    if(ds_grid.CountRow == 0) {
	
	        cfHideNoDataMsg(gr_grid);           // 최초 입력인 경우, 해당 건을 만들어주고 진행해야한다.

	        ds_grid.ClearAll();
	        ds_grid.setDataHeader( strHeaderDtl );
			
			cfSetSearchGridBtn(gr_grid);
	    }

	    ds_grid.AddRow();

	}
	
	
	//   --> /js/comm_ptpam.js 참고 하세요.
	
</script>


<!-----------------------------------------------------------------------------
    D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-- Grid 용 Master DataSet-->
<object id="ds_grid" 	classid="<%=LGauceId.DATASET%>" >
  <param name="SyncLoad"          value="true">
  <param name="ViewDeletedRow"    value="true">
</object>

<!-- 저장 DataSet -->
<object id=ds_cudData		classid="<%=LGauceId.DATASET%>"></object>

<!-- Dept combo DataSet -->
<object id="ds_deptCode"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
	<param name="DataID"          value="cm.cm.retrieveCommCodeCombo.gau?groupCd=2001">
</object>

<!-- Status combo DataSet -->
<object id="ds_statusCode"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
	<param name="DataID"          value="cm.cm.retrieveCommCodeCombo.gau?groupCd=2002&firstVal=Total">
</object>

<!-- Create Type combo DataSet -->
<object id="ds_createType"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
	<param name="DataID"          value="cm.cm.retrieveCommCodeCombo.gau?groupCd=2003&firstVal=Total">
</object>

<!-----------------------------------------------------------------------------
    G A U C E   C O M P O N E N T' S   E V E N T S
------------------------------------------------------------------------------>
<script language=JavaScript for=ds_costTotMst event=OnLoadStarted()>
  //cfHideNoDataMsg(gr_costTotMst);//no data 메시지 숨기기
  //cfShowDSWaitMsg(gr_costTotMst);//progress bar 보이기
  //mode = "";
</script>

<!-- Hub In Header 조회 DataSet -->
<script language=JavaScript for=ds_costTotMst event=OnLoadCompleted(rowCnt)>
  //cfHideDSWaitMsg(gr_costTotMst);//progress bar 숨기기
  //cfFillGridNoDataMsg(gr_costTotMst,"gridColLineCnt=2");//no data found   
  //mode = "";
</script>

<script language=JavaScript for=ds_costTotMst event=OnLoadError()>
  //cfShowErrMsg(ds_costTotMst);
  //mode = "";
</script>

<!-- Hub In Confirm Detail 조회 DataSet -->
<script language=JavaScript for=ds_costTotDtl event=OnLoadCompleted(rowCnt)>
  cfFillGridNoDataMsg(gr_costTotDtl,"gridColLineCnt=2");//no data found   
</script>

<script language=JavaScript for=ds_costTotDtl event=OnLoadError()>
  cfShowErrMsg(ds_costTotDtl);
</script>

<script language="javascript"  for=ds_costTotMst event=OnRowPosChanged(row)>

	//Detail Dataset Clear
  	ds_costTotDtl.ClearData();
  
	if ( row > 0 ) {
	    var condition = "?";
		condition += "&companyCd="+ds_costTotMst.NameValue(row,"companyCd");
		condition += "&deptCd="+ds_costTotMst.NameValue(row,"deptCd");
		condition += "&docYm="+ds_costTotMst.NameValue(row,"docYm");
		condition += "&docSeq="+ds_costTotMst.NameValue(row,"docSeq");
		ds_costTotDtl.DataID = "fi.ar.costTotLedgerConfirm.retrieveCostTotLedgerDtlConfirm.gau"+condition;
		ds_costTotDtl.Append();
	}

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

<script language="javascript"  for=gr_grid event=OnColumnPosChanged(row,colid)>
    
    // SEARCH 버튼  DISPLAY    
    if (colid.toLowerCase() == "vendCd") cfSetSearchGridBtn(gr_grid);
    else if (colid.toLowerCase() == "acctCd") cfSetCalendarGridBtn(gr_grid);
    else if (colid.toLowerCase() == "materCd") cfSetCalendarGridBtn(gr_grid);

</script>

<script language="javascript"  for=gr_grid event=OnPopup(Row,Colid,data)>

    if ( Colid == "acctCd") {
    	openAccountCodeListGridWin(Row, 'LOC', ds_grid);
    } else if ( Colid == "materCd") {
		openMaterialCodeListGridWin(Row, ds_grid);
    } else if ( Colid == "vendCd") {
    	openVendorCodeListGridWin(Row, ds_grid);
    }

</script>

</head>

<body id="cent_bg" onload="f_Onload()">

<div id="conts_box">
	<h2> <span> 임시 공통 팝업 </span></h2>

	<!--검색 S -->	
	 <fieldset class="boardSearch">
		<div>
			 <dl>
				<dt> 
					<table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board2" >
						<colgroup>
							<col width="15%"/>
							<col width="18%"/>
							<col width="15%"/>
							<col width="18%"/>
							<col width="15%"/>
							<col width=""/>
						</colgroup>
						<tr>
							<th>Dept Code</th>
							<td>

								<object id="deptCd"  classid="<%=LGauceId.LUXECOMBO%>" align="absmiddle" width="100">
								    <param name="ComboDataID"       value="ds_deptCode">
									<param name="ListCount"     	value="10">
									<param name="BindColumn"    	value="code">
								    <param name=ListExprFormat		value="name^0^90,code^0^70">
								    <param name=index           	value=0>
							   	</object>
							</td>										
							<th>Insert Type</th>
							<td>
								<object id="createType"  classid="<%=LGauceId.LUXECOMBO%>" align="absmiddle" width="100">
								    <param name="ComboDataID"       value="ds_createType">
									<param name="ListCount"     	value="10">
									<param name="BindColumn"    	value="code">
									<param name="WantSelChgEvent"   value="TRUE">
								    <param name=ListExprFormat		value="name^0^90,code^0^70">
								    <param name=index           	value=0>
							   	</object>
							</td>
							<th>Chk Status </th>
							<td>
								<object id="progStatus"  classid="<%=LGauceId.LUXECOMBO%>" align="absmiddle" width="100">
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
							<th>Account Code</th>
							<td><input type="text" id="acctCd"  style="width:60px;"/>&nbsp;<img src="<%= images %>button/search_icon_2.gif"  alt="Account Icon" onClick="javascript:openAccountCodeListWin('SAP');" style="cursor:hand"/></td>										
							<th>Material Code</th>
							<td><input type="text" id="materCd" style="width:60px;"/>&nbsp;<img src="<%= images %>button/search_icon_2.gif" alt="Material Icon" onClick="javascript:openMaterialCodeListWin(materCd);" style="cursor:hand"/></td>
							<th>Vendor List </th>
							<td><input type="text" id="vendCd"  style="width:60px;"/>&nbsp;<img src="<%= images %>button/search_icon_2.gif" alt="Vendor Icon"   onClick="javascript:openVendorCodeListWin(vendCd);" style="cursor:hand"/></td>										
						</tr>
						<tr>
							<th>Sap Account Code</th>
							<td><input type="text" id="vendCd"  style="width:60px;"/>&nbsp;<img src="<%= images %>button/search_icon_2.gif" alt="Vendor Icon"   onClick="javascript:openVendorCodeListWin(vendCd);" style="cursor:hand"/></td>										
							<th>Insert Date </th>
							<td colspan=3>
								<input type="text" id="orderDateFrom" value="<%= prevDate %>" 		style="width:60px;"/>&nbsp;<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(orderDateFrom);" style="cursor:hand"/> ~ 
								<input type="text" id="orderDateTo"   value="<%= currentDate %>" 	style="width:60px;"/>&nbsp;<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(orderDateTo);" style="cursor:hand"/>
							</td>
						</tr>
					</table>
				 </dt>              		  	   	 	
				 <dd class="btnseat2"> <img src="<%= images %>button/search_btn2.gif" alt="Inquery" onClick="javascript:f_Retrieve();" style="cursor:hand" /> </dd>											
			</dl>
		</div>
		</fieldset>
      <!--검색 E -->

	<div class="sub_stitle"> <p> 원장 확정 목록  </p> </div>     	
	<!-- 그리드 S -->	
    <div id="n_board_area">

	<object id="gr_grid" classid="<%=LGauceId.GRID %>" style="width:100%;height:250px;"
		dataName="Temp Common Pupup"
	    validFeatures="ignoreStatus=no"
		validExp="">
		<param Name="DataID" 			value='ds_grid'>
	    <Param name="AutoResizing"      value=true>
	    <param name="ColSizing"         value=true>
	    <Param name="DragDropEnable"    value=True>
	    <param name="AddSelectRows"     value=True>
	    <Param name="SortView"          value=right>
	    <param name="Editable"          value=True>
	    <param name="UsingOneClick"     value=1>
		<param Name='Format'
			value='
				<C> id=chk	        name="Chk" 		                         width="40"	    Edit="none"   EditStyle=CheckBox	HeadAlign=center HeadCheck=false HeadCheckShow=true </c>
                <C> id=acctCd  		name="Account Code"     align="center"   width="100"    Edit="true"   show="true" EditStyle=PopupFix</C>
                <C> id=acctNm    	name="Account Name"     align="left"     width="100"    Edit="none"   show="true" </C>
                <C> id=acctSapCd  	name="Sap Account Code"   align="center"   width="100"    Edit="true"   show="true" EditStyle=PopupFix</C>
                <C> id=acctSapNmEn  name="Sap Account Name"     align="left"     width="100"    Edit="none"   show="true" </C>
                <C> id=materCd  	name="Material Code"    align="center"   width="100"    Edit="true"   show="true" EditStyle=PopupFix</C>
                <C> id=materNm      name="Material Name"    align="left"     width="100"    Edit="none"   show="true" </C>
                <C> id=unit         name="Unit"             align="center"   width="50"     Edit="none"   show="true" </C>
                <C> id=vendCd   	name="Vendor Code"     	align="center"   width="100"    Edit="true"   show="true" EditStyle=PopupFix</C>
                <C> id=vendNm      	name="Vendor Name"     	align="left"     width="100"    Edit="none"   show="true" </C>
	      '>
	</object>
 	</div>

	<!-- 버튼 S -->	
    <div id="btn_area">
    	<p class="b_right">
    	<span class="btn_r btn_l"><input type="button" onClick="f_Cancel();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#444'" value="삭제"/></span>
    	<span class="btn_r btn_l"><input type="button" onClick="f_Approval();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#444'" value="승인"/></span>
    	<span class="btn_r btn_l"><input type="button" onClick="f_Approval();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#444'" value="SAP전송"/></span>
    	</p>
   	</div>
    <!-- 버튼 E -->
    
    <div class="pad_t5"></div>
        	  
</div>
</body>
</html>
