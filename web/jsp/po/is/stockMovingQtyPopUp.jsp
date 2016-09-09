<%--
/*
 *************************************************************************
 * @source  : stockMovingQtyPopUp.jsp
 * @desc    : stokc Movement
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2010.11.11   mslim       신규작성
 * ---  -----------  ----------  -----------------------------------------
 * PT-PAM 시스템
 * Copyright(c) 2006-2007 LG CNS,  All rights reserved.
 *************************************************************************
 */
--%>
<%@ page import="devon.core.util.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Stock Movement Registration</title>
<%@ include file="/include/head.jsp" %>

<%	
%>

<script type="text/javascript">

function init(){
	gr_grid.ReDraw="false"; 
	gr_grid.ColumnProp("receLocNm","name") = opener.gr_grid.ColumnProp('storLoct','name');	 
	gr_grid.ColumnProp("tranNo","name") = opener.gr_grid.ColumnProp('moveNo','name');	 
	gr_grid.ColumnProp("moveDate","name") = opener.gr_grid.ColumnProp('moveDate','name');	
	gr_grid.ColumnProp("materCd","name") = opener.gr_grid.ColumnProp('materCd','name');	
	gr_grid.ColumnProp("materNm","name") = opener.gr_grid.ColumnProp('materNm','name');
	gr_grid.ColumnProp("unit","name") = opener.gr_grid.ColumnProp('unit','name');	 
	gr_grid.ColumnProp("requestMoveQty","name") = opener.gr_grid.ColumnProp('requestMoveQty','name');
	gr_grid.ColumnProp("statusNm","name") =opener.gr_grid.ColumnProp('status','name');		
	gr_grid.ReDraw="true";	
		
	f_Retrieve();
	
		            
}


//-------------------------------------------------------------------------
// 검색 버튼 클릭시 재고 조회
//-------------------------------------------------------------------------		
function f_Retrieve() {
	
	var param = "";

	var condition = "?";
		condition += "&issueLoc=" + '<%=request.getParameter("issueLoct")%>';
		condition += "&materCd=" + '<%=request.getParameter("materCd")%>';

	ds_grid.DataID = "po.is.retrieveMovingQty.gau?"+condition;
	ds_grid.Reset();
	
}  


</script>  


<!-----------------------------------------------------------------------------
    D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<object id="ds_grid" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"    value="true">
	<param name="ViewDeletedRow" value="true">
</object>

<script language=JavaScript for=ds_grid event=OnLoadCompleted(rowCnt)>
  cfFillGridNoDataMsg(gr_grid,"gridColLineCnt=2");//no data found   
  
     gr_grid.ColumnProp("receLocNm", "SumText") = "Total";
	 gr_grid.columnProp("requestMoveQty", "SumText") = "@sum";
	 gr_grid.ViewSummary = "1";
  
</script>



<%----------------------------------------------------------------------------------------------------
 Gauce obj  event  정의
------------------------------------------------------------------------------------------------------%>


</head>

<body  onload = "init()" >

<div id="output_board_area">

	<!-- 그리드 S -->	
     <div>
         <table width="100%" border="0" cellspacing="0" cellpadding="0">
           <tr>
             <td width="100%"><comment id="__NSID__"><object id="gr_grid" classid="<%=LGauceId.GRID%>" class="comn_status" width="100%" height="300px">
				<param name="DataID" 		 value="ds_grid">
				<param name="RowHeight" 	 value="20">
				<param name="Enable" 		 value="TRUE">
				<param name="Editable" 		 value="TRUE">
				<param name="ColSizing" 	 value="true">
				<param name="IndWidth" 	     value="15">
				<param name="SortView" 		 value="Left">
				<Param Name="ColSelect" 	 value="true">
				<param name="Format"
				  value='
		            <C>id=receLocNm    Edit="none"		align="center"  	width="130"  suppress="2"</C> 
		            <C>id=tranNo     		Edit="none"		align="center"  	width="90" suppress="1"</C> 
		            <C>id=moveDate    	Edit="none"		align="center"  	width="90" suppress="2" mask="XXXX/XX/XX"</C> 
		            <C>id=materCd    	 	Edit="none"		align="center"  	width="90" </C> 
		            <C>id=materNm     	Edit="none"  	align="left"    	width="150" </C>
		            <C>id=unit    	 		Edit="none"   	align="center"  	width="50" </C>
		            <C>id=requestMoveQty    	Edit="none"   	align="right"  		width="110" DisplayFormat ="#,###.000"</C>
		            <C>id=statusNm    	 	Edit="true" 	align="right"  		width="100"  </C>
				   '>
				   
		             
		     </object></comment> <script>__WS__(__NSID__);</script>
	        </td>
	       </tr>
      	 </table> 
 	</div>


</div>
</body>
</html>
