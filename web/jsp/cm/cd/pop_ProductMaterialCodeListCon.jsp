<%--
 *************************************************************************
 * @source  : pop_MaterialCodeListCon.jsp
 * @desc    : cost Total Ledger Excel Upload
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2010/08/03               Init
 * ---  -----------  ----------  -----------------------------------------
 * PT-PAM System.
 * Copyright(c) 2006-2007 LG CNS,  All rights reserved.
 *************************************************************************
--%>

<%@ page import="devon.core.util.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>Material Code List</title>
<%@ include file="/include/head.jsp" %>
<%
	String msgNotUse = source.getMessage("dev.warn.com.noUse");   		// Not Use !
%>

<script type="text/javascript">
var gtype = "<%=request.getParameter("type")%>" ? "<%=request.getParameter("type")%>" : "";
    //-------------------------------------------------------------------------
	// Load
	//-------------------------------------------------------------------------
	function f_Onload() { 
		if (gtype=="SD") {
			lc_materType.enable="true";
			ds_materType.DataId="cm.cd.retrieveCementMaterialCombo.gau?groupCd=1102&firstVal=Total";
		}else {
			lc_materType.enable="true";
			ds_materType.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=1102&firstVal=Total";
		}
		ds_materType.Reset();	
	    f_Retrieve();
	}
//-------------------------------------------------------------------------
// 검색
//-------------------------------------------------------------------------
function f_Retrieve() {

    var condition = "?";

    //if (!checkData()) return;
    condition += "&materCd="    + document.all.materCd.value;
    condition += "&materNm="    + document.all.materNm.value;
    condition += "&materType="  + ds_materType.NameValue(ds_materType.RowPosition,"code");
    ds_grid.DataID = "retrieveProductMaterialCodeListPopupCon.gau"+condition;
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
        var unit    = ds_grid.NameValue(row , "unit" );

        window.returnValue = materCd + ";" 
                           + materNm + ";" 
                           + unit + ";" 
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
    <param name="SyncLoad"          value="true">
</object>
<object id="ds_materType" classid="<%=LGauceId.DATASET%>">
    <param name="SyncLoad"          value="true">
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

</script>

<script language=JavaScript for=gr_grid event=OnReturn(row,colid)>
    // 선택 & 창닫기
    f_select(row,colid);
</script>
</HEAD>

<body style="background-color:#34a8db;padding-left:5px;" onload="f_Onload()">
 

    <div id="pop_ContentsBox">    
		<div id="TitleArea2"><h1> Material Code List </h1> </div>    
       
			 
        <div id="ContentesArea">			    
	 	
	 	<fieldset class="boardSearch">
		<div>
			 <dl>
				<dt class="w400"> 
					<table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board2" >
						<colgroup>
							<col width="45%"/>
							<col width=""/>
						 </colgroup>
						 <tr>
							<th>Material Type </th> 
							<td><comment id="__NSID__"><object id="lc_materType"  classid="<%=LGauceId.LUXECOMBO%>" width="160">
								<param name="ComboDataID"       value="ds_materType">
								<param name="ListCount"     	value="10">
								<param name=SearchColumn		value="name">
								<param name="BindColumn"    	value="code">
								<param name=ListExprFormat		value="name^0^150,code^0^70"> 
								<param name=index           	value=0>
								</object></comment><script>__WS__(__NSID__); </script>
							</td>		
						</tr>						 
						 <tr>
							<th>Material Code</th>
							<td><input type="text" id="materCd" style="width:130px;" /></td>
						</tr>
						 <tr>
							<th>Material Name </th>
							<td><input type="text" id="materNm" style="width:130px;" /></td>
						</tr>
						
					</table>
				</dt>              		  	   	 	
				<dd class="btnseat2" style> 
					<span class="search_btn2_r"><input type="button" onfocus="blur();" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='#e2ebf7'" value="Search" onclick="f_Retrieve();"/></span> 
				</dd>											
			</dl>
	 </div>
	 </fieldset> 
	
	<div class="pad_t5"></div> 
		<div id="n_board_area">
			<object id="gr_grid" classid="<%=LGauceId.GRID %>" class="comn" style="width:100%;height:272px;"
			      validFeatures="ignoreStatus=no"
			      validExp="">
			      <param name="DataID"            value="ds_grid">
			      <Param name="AutoResizing"      value=true>
			      <param name="ColSizing"         value=true>
			      <Param name="DragDropEnable"    value=True>
			      <param name="AddSelectRows"     value=True>
			      <Param name="SortView"          value="right">
			      <param name="TitleHeight"       value="30">
			      <param name="Editable"          value=false>
			      <param name="Format"
			        value='
			              <FC> id="no"            name="No"            align="center" Edit="none" width="35" Value={CurRow} </FC>
			              <C> id="materCd"        name="Code"     		align="center" Edit="none" width="75" sort=true</C>
			              <C> id="materNm"        name="Name"     		align="left"   Edit="none" width="220" sort=true  </C>
			              <C> id="unit"           name="Unit"           align="center"   Edit="none" width="60" sort=true </C>
			              <C> id="materType"      name="Type"           align="center" Edit="none" width="60" sort=true </C> 
			              <C> id="useyn"          name="Use"        align="center" Edit="none" width="55" sort=true </C>
			        '>
			</object>
		</div>


		 <!-- 버튼 S -->	
		<p class="rbtn">
			<span class="sbtn_r"><input type="button"  value="Close" onclick="javascript:window.close()" /></span>
		</p>
		
		</div>
		
		<!-- 팝업내용 E -->	
		</div>
 
    
    </div>        
      
</body>
</html>
