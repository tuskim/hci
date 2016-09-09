<%--
 *************************************************************************
 * @source  : pop_CustomerCodeList.jsp
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

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Delivery Code List</title>
<%@ include file="/include/head.jsp" %>

<%
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
    condition += "&vendCd="  + document.all.vendCd.value;
    condition += "&vendNm="  + document.all.vendNm.value;
    condition += "&useyn="  + 'Y';

    ds_grid.DataID = "retrieveVendorCodeListPopup.gau"+condition;
    ds_grid.Reset();
}

//-------------------------------------------------------------------------
// 선택 & 창닫기
//-------------------------------------------------------------------------
function f_select(row,colid) {

    var useyn = ds_grid.NameValue(row , "useyn" );
    if ( useyn != "Y" ) {
		alert("<%= msgNotUse %>");
    	return;
    }
    
    if(row>0){
        var vendCd = ds_grid.NameValue(row , "vendCd" );
        var vendNm = ds_grid.NameValue(row , "vendNm" );

        window.returnValue = vendCd + ";" 
                           + vendNm + ";" 
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
</head>

<body style="background-color:#34a8db;">
 
    <div id="pop_ContentsBox">    
		<div id="TitleArea2"><h1> Delivery Code List </h1> </div>    
       
			 
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
							<th>Delivery Code</th>
							<td><input type="text" id="vendCd" style="width:120px;" /></td>
						</tr>
						 <tr>
							<th>Delivery Name </th>
							<td><input type="text" id="vendNm" style="width:120px;" /></td>
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
			<object id="gr_grid" classid="<%=LGauceId.GRID %>" class="comn" style="width:100%;height:225px;"
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
			              <C> id="seq"            name="Seq"             align="center" Edit="none" width="35" Value={CurRow} </C>
			              <C> id="vendCd"         name="Code"     	     align="center" Edit="none" width="100"  </C>
			              <C> id="vendNm"         name="Name"     		 align="left"   Edit="none" width="200" </C>
			              <C> id="countryCd"      name="Country"    	 align="center" Edit="none" width="65"  </C>
			              <C> id="useyn"          name="Use Y/N"         align="center" Edit="none" width="65"  </C>
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
