<%--
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
--%>

<%@ page import="devon.core.util.*" %>
<jsp:useBean id="Util"  class="comm.util.Util"  scope="request" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>Account Code List</title>
<%@ include file="/include/head.jsp" %>

<%
	String acctCd = Util.nullToString(request.getParameter("acctCd"));
	String acctGb = Util.nullToString(request.getParameter("acctGb"));

    String msgNotUse = source.getMessage("dev.warn.com.noUse");   		// Not Use !
%>

<script type="text/javascript">
    //-------------------------------------------------------------------------
	// Load
	//-------------------------------------------------------------------------
	function f_Onload() {
	
	    f_bizTypeComboTotal();
	    f_Retrieve();
	}
//-------------------------------------------------------------------------
// 검색
//-------------------------------------------------------------------------
function f_Retrieve() {

    var condition = "?";

    //if (!checkData()) return;
    condition += "&acctCd="  + document.all.acctCd.value;
    condition += "&acctNm="  + document.all.acctNm.value.toUpperCase();
    condition += "&acctGb=<%= acctGb %>";

    ds_grid.DataID = "retrieveAccountCodeListPopup.gau"+condition;
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
        var acctCd    = ds_grid.NameValue(row , "code" );
        var acctNm    = ds_grid.NameValue(row , "name" );
        var acctSapCd = ds_grid.NameValue(row , "acctSapCd" );
        var area      = ds_grid.NameValue(row , "area" );
        var div       = ds_grid.NameValue(row , "div" );
        var block     = ds_grid.NameValue(row , "block" );
        var block2    = ds_grid.NameValue(row , "block2" );
        var year      = ds_grid.NameValue(row , "year" );
        var tm        = ds_grid.NameValue(row , "tm" );
        var sp        = ds_grid.NameValue(row , "sp" );

        window.returnValue = acctCd + ";" 
                           + acctNm + ";" 
                           + acctSapCd + ";" 
                           + area + ";" 
                           + div + ";" 
                           + block + ";" 
                           + block2 + ";" 
                           + year + ";" 
                           + tm + ";" 
                           + sp + ";" 

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

<body style="background-color:#34a8db;padding-left:5px;">

    <div id="pop_ContentsBox">    
		<div id="TitleArea2"><h1> Account Code List </h1> </div>    
       
			 
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
							<th>Account Code</th>
							<td><input type="text" id="acctCd" style="width:120px;" value="" /></td>
						</tr>
						 <tr>
							<th>Account Name </th>
							<td><input type="text" id="acctNm" style="width:120px;" value="" /></td>
						</tr>
					</table>
				</dt>              		  	   	 	
				<dd class="btnseat2" style> 
					<span class="search_btn2_r"><input type="button" onfocus="blur();" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='#e2ebf7'" value="Search" onclick="f_Retrieve();"/></span> 
				</dd>											
			</dl>
	 </div>
	 </fieldset>
     <!--�˻� E -->		
	
	<div class="pad_t5"></div>
		<!-- �׸��� S -->	
		<div id="n_board_area">
			<object id="gr_grid" classid="<%=LGauceId.GRID %>" class="comn" style="width:100%;height:200px;"
			      validFeatures="ignoreStatus=no"
			      validExp="">
			      <param name="DataID"            value="ds_grid">
			      <Param name="AutoResizing"      value=true>
			      <param name="ColSizing"         value=true>
			      <Param name="DragDropEnable"    value=True>
			      <param name="AddSelectRows"     value=True>
			      <Param name="SortView"          value="right">
			      <param name="TitleHeight"       value="40">
			      <param name="Editable"          value=false>
			      <param name="Format"
			        value='
			              <C> id="seq"           name="Seq"             align="center" Edit="none" width="35" Value={CurRow} </C>
			              <C> id="code"          name="Code"      		align="center" Edit="none" width="80" </C>
			              <C> id="name"          name="Name"      		align="left"   Edit="none" width="150"  </C>
			              <C> id="useyn"         name="Use Y/N"         align="center" Edit="none" width="60"  </C>
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
