<%--
 *************************************************************************
 * @source  : pop_CPOMaterialCodeList.jsp
 * @desc    : CPO matterial Sales Code List
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2012/10/04    이태경          	Init
 * ---  -----------  ----------  -----------------------------------------
 * PT-PAM System.
 * Copyright(c) 2006-2007 LG CNS,  All rights reserved.
 *************************************************************************
--%>

<%@ page import="devon.core.util.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Material Code List</title>
<%@ include file="/include/head.jsp"%>
<%
	String msgNotUse = source.getMessage("dev.warn.com.noUse"); // Not Use !
	String salesDate = (request.getParameter("salesDate") == null) ? LDateUtils.getDate("yyyy/MM/dd") : request.getParameter("salesDate");
%>

<script type="text/javascript">
//-------------------------------------------------------------------------
// Load
//-------------------------------------------------------------------------
var Stor_loc = "";
var mater_Type = "";
function f_Onload() { 
	lc_materType.enable="true";
	ds_materType.DataId="cm.cd.retrieveCementMaterialCombo.gau?groupCd=1102";
	ds_materType.Reset();
	ds_storCd.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2005&attr2=F";
	ds_storCd.Reset();		
} 
//-------------------------------------------------------------------------
// 검색
//-------------------------------------------------------------------------
function f_Retrieve() {
    var condition = "?";
    condition += "issue_loc="    + ds_storCd.NameValue(ds_storCd.RowPosition,"code");
    condition += "&materCd="    + document.all.materCd.value;
    condition += "&salesDate="    + <%=salesDate %>;
    condition += "&materType="  + ds_materType.NameValue(ds_materType.RowPosition,"code");
    ds_grid.DataID = "rfc.cmd.retrieveCementStockList.gau"+condition;
    ds_grid.Reset();
}

//-------------------------------------------------------------------------
// 선택 & 창닫기
//-------------------------------------------------------------------------
function f_select(row,colid) {

    var useyn    = ds_grid.NameValue(row , "useyn" );
    if ( useyn != "Y" ) {
		alert("<%= msgNotUse %>");
    	return;
    }
    
    if(row>0){
        var materCd = ds_grid.NameValue(row , "materCd" );
        var materNm = ds_grid.NameValue(row , "materNm" );
        var currentQty = ds_grid.NameValue(row , "currentQty" );
        var storLoc = Stor_loc;
        var materType = mater_Type;
        var unit = ds_grid.NameValue(row , "unit" );
        var unitPrice = ds_grid.NameValue(row , "unitPrice" );
        window.returnValue = materCd + ";" 
                           + materNm + ";" 
						   + storLoc   + ";"
                           + currentQty + ";"
                           + unit + ";"
                           + materType + ";"
                           + unitPrice + ";"
                           ;
       self.close(); 
    }
}

</script>

<!-----------------------------------------------------------------------------
  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- CUD TR -->

<!-----------------------------------------------------------------------------
    D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- ds_grid DataSet -->
<object id="ds_grid" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad" value="true">
</object>
<object id="ds_materType" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad" value="true">
</object>
<object id="ds_storCd" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad" value="true">
</object>

<!-----------------------------------------------------------------------------
    G A U C E   C O M P O N E N T' S   E V E N T S
------------------------------------------------------------------------------>

<script language=JavaScript for=ds_grid event=OnLoadStarted()>
    cfHideNoDataMsg(gr_grid);
    cfShowDSWaitMsg(gr_grid);
</script>

<!-- 그리드 더블클릭시 -->
<script language=JavaScript for=gr_grid event=OnDblClick(row,colid)>
    if(row>0){
        // 선택 & 창닫기
        f_select(row,colid);
    }
</script>

<script language=JavaScript for=ds_grid event=OnLoadCompleted(rowCnt)>

    cfFillGridNoDataMsg(gr_grid,"gridColLineCnt=2");
    cfHideDSWaitMsg(gr_grid);
    Stor_loc = ds_storCd.NameValue(ds_storCd.RowPosition,"code");
    mater_Type = ds_materType.NameValue(ds_materType.RowPosition,"code");
</script>

<script language=JavaScript for=gr_grid event=OnReturn(row,colid)>
    // 선택 & 창닫기
    f_select(row,colid);
</script>
</HEAD>

<body style="background-color:#34a8db;" onload="f_Onload()">


<div id="pop_ContentsBox">
<div id="TitleArea2">
<h1>Material Code List</h1>
</div>


<div id="ContentesArea">

<fieldset class="boardSearch">
<div>
<dl>
	<dt class="w400">
	<table width="100%" border="0" cellpadding="0" cellspacing="0"
		class="output_board2">
		<colgroup>
			<col width="45%" />
			<col width="" />
		</colgroup>
		<tr>
			<th>Material Type</th>
			<td><comment id="__NSID__"><object id="lc_materType"
				classid="<%=LGauceId.LUXECOMBO%>" width="150">
				<param name="ComboDataID" value="ds_materType">
				<param name="ListCount" value="10">
				<param name=SearchColumn value="name">
				<param name="BindColumn" value="code">
				<param name=ListExprFormat value="name^0^150,code^0^70">
				<param name=index value=0>
			</object></comment><script>__WS__(__NSID__); </script></td>
		</tr>
		<tr>
			<th>Storage Location Type</th>
			<td><comment id="__NSID__"><object id="stroCd"
				classid="<%=LGauceId.LUXECOMBO%>" width="150">
				<param name="ComboDataID" value="ds_storCd">
				<param name="ListCount" value="10">
				<param name=SearchColumn value="name">
				<param name="BindColumn" value="code">
				<param name=ListExprFormat value="name^0^150,code^0^70">
				<param name=index value=0>
			</object></comment><script>__WS__(__NSID__); </script></td>
		</tr>
		<tr>
			<th>Material Code</th>
			<td><input type="text" id="materCd" style="width:120px;" /></td>
		</tr>
	</table>
	</dt>
	<dd class="btnseat2"><span class="search_btn2_r"><input
		type="button" onfocus="blur();" onmouseover="this.style.color='#fff'"
		onmouseout="this.style.color='#e2ebf7'" value="Search"
		onclick="f_Retrieve();" /></span></dd>
</dl>
</div>
</fieldset>

<div class="pad_t5"></div>
<div id="n_board_area"><object id="gr_grid"
	classid="<%=LGauceId.GRID %>" class="comn"
	style="width:100%;height:255px;" validFeatures="ignoreStatus=no"
	validExp="">
	<param name="DataID" value="ds_grid">
	<Param name="AutoResizing" value=true>
	<param name="ColSizing" value=true>
	<Param name="DragDropEnable" value=True>
	<param name="AddSelectRows" value=True>
	<Param name="SortView" value="right">
	<param name="TitleHeight" value="40">
	<param name="Editable" value=false>
	<param name="Format"
		value='
			              <FC> id="no"            name="No"            align="center" Edit="none" width="35" Value={CurRow} </FC>
			              <C> id="materCd"        name="Code"     		align="center" Edit="none" width="70" sort=true</C>
			              <C> id="materNm"        name="Name"     		align="left"   Edit="none" width="130" sort=true  </C>
                          <c> id="currentQty"    name="Current;Quantity" Edit="none"   	align="right"  	width="80" dec="3"  	</c>
			              <C> id="unit"           name="Unit"           align="center"   Edit="none" width="35" </C>
                          <c> id="unitPrice"    name="Unit Price" Edit="none"   	align="right"  	width="70" dec="2"  	</c>
			              <C> id="useyn"          name="Use"        align="center" Edit="none" width="50" sort=true </C>
			        '>
</object></div>


<!-- 버튼 S -->
<p class="rbtn"><span class="sbtn_r"><input type="button"
	value="Close" onclick="javascript:window.close()" /></span></p>

</div>
<!-- 팝업내용 E -->
</div>
</body>
</html>