<%--
 *************************************************************************
 * @source  : pop_UserMgnt.jsp
 * @desc    : 사용자 Id search
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
<title>Employee List</title>
<%@ include file="/include/head.jsp" %>

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

    condition += "&pernr="  + document.all.pernr.value;
    condition += "&name="  + document.all.name.value;

    ds_grid.DataID = "cm.ur.RetrieveEmplyeeList.gau"+condition;
    ds_grid.Reset();
}

//-------------------------------------------------------------------------
// 선택 & 창닫기
//-------------------------------------------------------------------------
function f_select(row,colid) {

    if(row>0){
        var userId = document.userId.value;

        window.returnValue = userId + ";" 

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
		var pernr = ds_grid.NameValue(row, "pernr");
		var name = ds_grid.NameValue(row, "ename");
		
		window.returnValue = pernr + ";"  + name + ";" ;
        self.close(); 
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

    <div id="TopBoxImage">
        <p><img src="<%= images %>popup_mail/bg_boxTopL.gif" alt="���;'���̹���" /></p>
        <p class="place"><img src="<%= images %>popup_mail/bg_boxTopR.gif" alt="���;'���̹���" /></p>
    </div>

    <div id="ContentsBox">    
		<div id="TitleArea"><h1> Employee List </h1> </div>    
       
			 
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
							<th>Employee No.</th>
							<td><input type="text" id="pernr" style="width:100px;" /></td>
						</tr>
						<tr>
							<th>Name</th>
							<td><input type="text" id="name" style="width:100px;" /></td>
						</tr>
					</table>
				</dt>              		  	   	 	
				<dd class="btnseat3" style> 
					<span class="search_btn_r search_btn_l"><input type="button" onfocus="blur();" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='#e2ebf7'" value="Search" onclick="f_Retrieve();"/></span> 
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
			              <C> id="pernr"         name="Employee No."     align="center" Edit="none" width="120"  </C>
			              <C> id="ename"         name="Employee Name"     align="left"   Edit="none" width="200" </C>
			        '>
			</object>
		</div>


		 <!-- 버튼 S -->	
		<p class="rbtn">
			<span class="sbtn_r sbtn_l"><input type="button"  value="Close" onclick="javascript:window.close()" /></span>
		</p>
		
		</div>
		
		<!-- 팝업내용 E -->	
		</div>
		
        <div id="BottomBoxImage">
            <p><img src="<%= images %>popup_mail/bg_boxBottomL.gif" alt="���;'���̹���"/></p>
            <p class="place"><img src="<%= images %>popup_mail/bg_boxBottomR.gif" alt="���;'���̹���"/></p>
        </div>
    
    </div>        
      
</body>
</html>
