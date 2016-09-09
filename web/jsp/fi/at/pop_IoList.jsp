<%--
 *************************************************************************
 * @source  : pop_IoList.jsp
 * @desc    : I/O 코드 조회 팝업
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2015/11/26               Init
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
<title>Internal Order Code List</title>
<%@ include file="/include/head.jsp" %>

<%
	String msgNotUse = source.getMessage("dev.warn.com.noUse");   		// Not Use !	
%>

<script type="text/javascript">

//-------------------------------------------------------------------------
// Load
//-------------------------------------------------------------------------
function f_Onload() {	
	
//	f_Retrieve();
}

//-------------------------------------------------------------------------
// 검색
//-------------------------------------------------------------------------
function f_Retrieve() {

    var condition = "?";

    condition += "&ioCd="  + document.all.ioCd.value;
    condition += "&ioName="  + document.all.ioName.value;

    ds_grid.DataID = "retrieveInternalOrderCodeListPopup.gau"+condition;
    ds_grid.Reset();
}

//-------------------------------------------------------------------------
// 선택 & 창닫기
//-------------------------------------------------------------------------
function f_select(row,colid) {
        
    if(row>0){
        var ioCd = ds_grid.NameValue(row , "ioCd" );
        var ioNm = ds_grid.NameValue(row , "ioName" );
        
        window.returnValue = ioCd + ";" 
                           + ioNm + ";" 
                           ;                
        self.close(); 
    }
}

</script>

<!-----------------------------------------------------------------------------
    D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- ds_grid DataSet -->
<object id="ds_grid" classid="<%=LGauceId.DATASET%>">
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
    if(row > 0){
        // 선택 & 창닫기
        f_select(row, colid);
    }
</script>

<script language=JavaScript for=ds_grid event=OnLoadCompleted(rowCnt)>
    cfFillGridNoDataMsg(gr_grid,"gridColLineCnt=2");
    cfHideDSWaitMsg(gr_grid);
</script>

<script language=JavaScript for=gr_grid event=OnReturn(row,colid)>
    // 선택 & 창닫기
    f_select(row, colid);
</script>
</head>

<body style="background-color:#34a8db;padding-left:0px;" onload="f_Onload();"> 
    <div id="pop_ContentsBox">    
		<div id="TitleArea2"><h1> Index of CIP & DEC Code List </h1></div>    
       			 
        <div id="ContentesArea">	
         		    	 	
	 		<fieldset class="boardSearch">
				<div>
			 		<dl>
						<dt class="w400"> 
							<table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board2" >
								<colgroup>
									<col width="25%"/>
									<col width=""/>
								 </colgroup>
								 <tr>
									<th>Index</th>
									<td><input type="text" id="ioCd" style="width:120px;" value="" /></td>
								</tr>
								 <tr>
									<th>Name</th>
									<td><input type="text" id="ioName" style="width:120px;" value="" /></td>
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
				<object id="gr_grid" classid="<%=LGauceId.GRID %>" class="comn" style="width:100%;height:200px;" validFeatures="ignoreStatus=no" validExp="">
			     	<param name="DataID"            value="ds_grid">
			      	<Param name="AutoResizing"      value=true>
			      	<param name="ColSizing"         value=true>
			      	<Param name="DragDropEnable"    value=True>
			      	<param name="AddSelectRows"     value=True>
			      	<Param name="SortView"          value="right">
			    	<param name="TitleHeight"       value="40">
			      	<param name="Editable"          value=false>
			      	<param name="Format" value='
			      		<C> id="seq"     name="seq"    align="center"  Edit="none"  width="40"   </C>
			        	<C> id="ioCd"    name="Index"  align="center"  Edit="none"  width="82"   </C>
			            <C> id="ioName"  name="Name"   align="left"    Edit="none"  width="230"  </C>
			            <C> id="ioType"  name="Type"   align="center"  Edit="none"  width="70"   </C> '>
				</object>
			</div>

		 	<!-- 버튼 S -->	
			<p class="rbtn">
				<span class="sbtn_r"><input type="button"  value="Close" onclick="javascript:window.close()" /></span>
			</p>					
		</div>					
	</div>              
</body>
</html>
