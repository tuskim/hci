<%--
/*
 *************************************************************************
 * @source  : stockMoveCancel.jsp
 * @desc    : Stock Movement Sap Cancel
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2010.08.27   mskim       Init
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
	String prevDate	     = LDateUtils.getDate("yyyy/MM/") +"01"; 
	String currentDate   = LDateUtils.getDate("yyyy/MM/dd");          // currentDate

	String msgNoTransfer = source.getMessage("dev.msg.po.noTranster");    // The selected item does not transfer mode!
    String msgCancel     = source.getMessage("dev.cfm.com.cancel");    // Are you sure to Cancel?
    String msgCheckDate  = source.getMessage("dev.warn.com.checkDate");    // Check Date Format
%>

<script type="text/javascript">

//-------------------------------------------------------------------------
// 검색 버튼 클릭시 재고 조회
//-------------------------------------------------------------------------		
function f_Retrieve() {

	var orderDateFrom = removeDash(document.all.orderDateFrom.value,"/");
	var orderDateTo   = removeDash(document.all.orderDateTo.value,"/");
	var orderFrMon    = orderDateFrom.substring(0, 6);
	var orderToMon    = orderDateTo.substring(0, 6);

	if ( orderFrMon != orderToMon ) {
		alert('<%= source.getMessage("dev.msg.po.chkSameMonth","From Date","To Date") %>' );
		document.all.orderDateFrom.focus();
		return false;
	}
	
	var param = "";

	param += "issueLoc="  + issueLoc.ValueOfIndex("code",issueLoc.Index);
	param += "&receLoc="  + receLoc.ValueOfIndex("code",receLoc.Index);
	param += "&orderDateFrom=" + removeDash(document.all.orderDateFrom.value, "/");
	param += "&orderDateTo=" + removeDash(document.all.orderDateTo.value, "/");
	param += "&status="  + progStatus.ValueOfIndex("code",progStatus.Index);

	ds_stockMoveMst.DataID = "po.is.retrieveStockMoveCancelMst.gau?"+param;
	ds_stockMoveMst.Reset();
	
	//alert(ds_stockMoveMst.countrow);
}  

//-------------------------------------------------------------------------
// 출고등록
//-------------------------------------------------------------------------	
function f_sapCancel() {

	var status = ds_stockMoveMst.nameValue(ds_stockMoveMst.RowPosition,"status");
	if ( status != '03' ) {
		alert("<%= msgNoTransfer %>");
		return;
	}


	var currDate      = removeDash("<%= currentDate %>","/");
	var orderDateFrom = removeDash(document.all.orderDateFrom.value,"/");
	var currMon       = currDate.substring(0, 6);
	var orderFrMon    = orderDateFrom.substring(0, 6);

	if ( orderFrMon != currMon ) {
		alert('<%= source.getMessage("dev.msg.po.chkSameMonth","Posting Date","Current Date") %>' );
		document.all.orderDateFrom.focus();
		return false;
	}


	//변경한 데이터가 있는지 체크한다.
	if(confirm("<%= msgCancel %>")){
		
		ds_stockMoveDtl.UseChangeInfo = "false";

		var param = "";

		param += "companyCd=" + ds_stockMoveMst.nameValue(ds_stockMoveMst.RowPosition,"companyCd");
		param += "&tranNo=" + ds_stockMoveMst.nameValue(ds_stockMoveMst.RowPosition,"tranNo");
		param += "&sapDocNo=" + ds_stockMoveMst.nameValue(ds_stockMoveMst.RowPosition,"sapDocNo");
		
		tr_master.KeyValue = "Servlet(I:IN_DS1=ds_stockMoveDtl)";
		tr_master.Action   = "po.is.cudStockMoveCancel.gau?"+param;
		tr_master.post();
	}

}


</script>  

<!-----------------------------------------------------------------------------
  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<OBJECT id="tr_master" classid="<%=LGauceId.TR%>">
	<param name="KeyName" value="toinb_dataid4">
</OBJECT>

<!-----------------------------------------------------------------------------
    D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-- Grid 용 Master DataSet-->
<object id="ds_stockMoveMst" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"    		value="true">
	<param name="ViewDeletedRow" 	value="true">
</object>

<!-- Grid 용 Detail DataSet-->
<object id="ds_stockMoveDtl" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"    		value="true">
	<param name="ViewDeletedRow" 	value="true">
</object>

<!-- 입고/출고 저장소 combo DataSet -->
<object id="ds_issuelocation"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"  value="true">
	<param name="DataID"    value="cm.cm.retrieveCommCodeCombo.gau?groupCd=2005">
</object>

<!-- 입고/출고 저장소 combo DataSet -->
<object id="ds_recelocation"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"  value="true">
	<param name="DataID"    value="cm.cm.retrieveCommCodeCombo.gau?groupCd=2005&firstVal=Total">
</object>

<!-- status combo DataSet -->
<object id="ds_status"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"  value="true">
	<param name="DataID"    value="cm.cm.retrieveCommCodeCombo.gau?groupCd=2209&firstVal=Total">
</object>


<!-- lx Combo 용 DataSet-->
<object id="ds_mater"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
	<param name="DataID"          value="cm.cm.retrieveCommComboMaterList.gau?materType=3110">
</object>

<!-----------------------------------------------------------------------------
    G A U C E   C O M P O N E N T' S   E V E N T S
------------------------------------------------------------------------------>
<script language=JavaScript for=ds_stockMoveMst event=OnLoadStarted()>
  cfHideNoDataMsg(gr_stockMoveMst);//no data 메시지 숨기기
  cfShowDSWaitMsg(gr_stockMoveMst);//progress bar 보이기
  mode = "";
</script>

<!-- Hub In Header 조회 DataSet -->
<script language=JavaScript for=ds_stockMoveMst event=OnLoadCompleted(rowCnt)>
  cfHideDSWaitMsg(gr_stockMoveMst);//progress bar 숨기기
  cfFillGridNoDataMsg(gr_stockMoveMst,"gridColLineCnt=2");//no data found   
  mode = "";
</script>

<script language=JavaScript for=ds_stockMoveMst event=OnLoadError()>
  cfShowErrMsg(ds_stockMoveMst);
  //mode = "";
</script>

<!-- Hub In Confirm Detail 조회 DataSet -->
<script language=JavaScript for=ds_stockMoveDtl event=OnLoadCompleted(rowCnt)>
  cfFillGridNoDataMsg(gr_stockMoveDtl,"gridColLineCnt=2");//no data found   
</script>

<script language=JavaScript for=ds_stockMoveDtl event=OnLoadError()>
  cfShowErrMsg(ds_stockMoveDtl);
</script>

<script language=JavaScript for=tr_master event=OnSuccess()>
	f_Retrieve();			
    alert("successfully saved.");
</script>

<script language=JavaScript for=tr_master event=OnFail()>
    if(tr_master.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
        window.parent.location.href = "/index.jsp";    
    }
    
   	if ( tr_master.ErrorMsg.indexOf("simpleMsg")) {
		var cnt = 12 + tr_master.ErrorMsg.indexOf("simpleMsg");
		alert(tr_master.ErrorMsg.substring(cnt, tr_master.ErrorMsg.length));
   	}

</script>

<script language="javascript"  for=ds_stockMoveMst event=OnRowPosChanged(row)>

	//Detail Dataset Clear
  	ds_stockMoveDtl.ClearData();

	if ( row > 0 ) {

		var param = "";
		param += "tranNo="  + ds_stockMoveMst.NameValue(row,"tranNo");
		
		ds_stockMoveDtl.DataID = "po.is.retrieveStockMoveCancelDtl.gau?"+param;
		ds_stockMoveDtl.Reset();
	}

</script>

<script language=JavaScript for= materCd event=OnKeyDown(kcode)>
    if(kcode != 8 && kcode != 13 && kcode != 27 && kcode != 33 && kcode != 34 && kcode != 35 &&
        kcode != 36 && kcode != 37 && kcode != 38 && kcode != 39 && kcode != 40 && kcode != 45 &&
        kcode != 46 && kcode != undefined) {	
    		setTimeout("On_Apply()");
   		}
</script>
</head>

<body id="cent_bg">

<div id="conts_box">
	<h2> <span> <%= columnData.getString("page_title") %></span></h2>


	<!--검색 S -->	
	 <fieldset class="boardSearch">
		<div>
			 <dl>
				<dt> 
					<table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board2" >
						<colgroup>
							<col width="15%"/>
							<col width="35%"/>
							<col width="18%"/>
							<col width=""/>
						</colgroup>
						<tr>
							<th><%= columnData.getString("issue_loc") %></th>
							<td>

								<object id="issueLoc"  classid="<%=LGauceId.LUXECOMBO%>" align="absmiddle" width="120">
								    <param name="ComboDataID"       value="ds_issuelocation">
									<param name="ListCount"     	value="10">
									<param name=SyncComboData       value="false">
									<param name="BindColumn"    	value="code">
								    <param name=ListExprFormat		value="name^0^90,code^0^70">
								    <param name=index           	value=0>
							   	</object>
							</td>										
							<th><%= columnData.getString("rece_loc") %></th>
							<td>
								<object id="receLoc"  classid="<%=LGauceId.LUXECOMBO%>" align="absmiddle" width="120">
								    <param name="ComboDataID"       value="ds_recelocation">
									<param name="ListCount"     	value="10">
									<param name=SyncComboData       value="false">
									<param name="BindColumn"    	value="code">
									<param name="WantSelChgEvent"   value="TRUE">
								    <param name=ListExprFormat		value="name^0^90,code^0^70">
								    <param name=index           	value=0>
							   	</object>
							</td>
						</tr>
						<tr>
							<th><%= columnData.getString("posting_date") %></th>
							<td>
								<input type="text" id="orderDateFrom" value="<%= prevDate %>" 	 onblur="valiDate(this);"  style="width:60px;"/>&nbsp;<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(orderDateFrom);" style="cursor:hand"/> ~ 
								<input type="text" id="orderDateTo"   value="<%= currentDate %>" onblur="valiDate(this);"  style="width:60px;"/>&nbsp;<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(orderDateTo);" style="cursor:hand"/>
							</td>
							<th><%= columnData.getString("status") %></th>
							<td>
								<object id="progStatus"  classid="<%=LGauceId.LUXECOMBO%>" align="absmiddle" width="120">
								    <param name="ComboDataID"       value="ds_status">
									<param name="ListCount"     	value="10">
									<param name=SyncComboData       value="false">
									<param name="BindColumn"    	value="code">
									<param name="WantSelChgEvent"   value="TRUE">
								    <param name=ListExprFormat		value="name^0^90,code^0^70">
								    <param name=index           	value=0>
							   	</object>
							</td>						</tr>
					</table>
				 </dt>              		  	   	 	
				 <dd class="btnseat2"> 
				 	  <span class="search_btn2_r search_btn2_l">
                			  <input type="button" onfocus="blur();" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='#e2ebf7'" value="<%=btnSearch %>" onclick="f_Retrieve();"/></span> 
				 </dd>

			</dl>
		</div>
		</fieldset>
      <!--검색 E -->
      

      	<!-- 그리드 E -->	
		<div class="sub_stitle"> <p><%= columnData.getString("sub1_title") %> </p> </div>      	
 		
		<!--<div style="width:760px; overflow:auto;height:170px;" >	-->
		<!-- 그리드 S -->	
		<div id="n_board_area">
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="100%"><comment id="__NSID__"><object id="gr_stockMoveMst" classid="<%=LGauceId.GRID%>" class="comn" width="100%"	height="140px" class="B_list">
				<param name="DataID" value="ds_stockMoveMst">
				<param name="RowHeight" 	value="20">
				<param name="Enable" 		value="TRUE">
				<param name="ColSizing" 	value="true">
				<param name="SortView" 		value="Left">
				<Param Name="ColSelect" 	value="true">
				<param name="Format"
					value='
	           			<C>id=seq         		name="<%=columnData.getString("seq") %>"        		Edit="none"		align="center"   	width="30"  Value={CurRow} </C>
			            <C>id="companyCd"   	name="<%=columnData.getString("company_cd") %>" 		Edit="none"		align="center"  	width="110"  show="false"</C> 
			            <C>id="tranNo"      	name="<%=columnData.getString("tran_no") %>"	    	Edit="none"  	align="left"    	width="110"  show="false"</C>
			            <C>id="issueLocNm"  	name="<%=columnData.getString("issue_loc") %>" 	    	Edit="none"		align="left"  		width="110"  show="true"</C> 
			            <C>id="receLocNm"   	name="<%=columnData.getString("rece_loc") %>"	    	Edit="none"  	align="left"    	width="110"  show="true"</C>
			            <C>id="tranNo"    		name="<%=columnData.getString("tran_no") %>"    		Edit="none"   	align="center"  	width="80"   show="true"</C>
			            <C>id="postingDate" 	name="<%=columnData.getString("posting_date") %>"   	Edit="none"   	align="center"  	width="80"   show="true"</C>
			            <C>id="sapDocNo"    	name="<%=columnData.getString("sap_doc_no") %>"     	Edit="none"   	align="center"  	width="110"  show="true"</C>
			            <C>id="sapCancelDocNo"  name="<%=columnData.getString("sap_cancel_doc_no") %>"  Edit="none"   	align="center"  	width="110"  show="true"</C>
			            <C>id="statusNm"    	name="<%=columnData.getString("status") %>"       		Edit="none"   	align="left"  		width="90"   show="true"</C>
			            <C>id="sapRtnMsg"   	name="<%=columnData.getString("sap_rtn_msg") %>"    	Edit="none"   	align="left"  		width="80"   show="true"  BgColor={IF(sapRtnMsg="","White","Red")}</C>
				'>
			     </object></comment> <script>__WS__(__NSID__);</script>
		        </td>
		       </tr>
       	  	 </table>  
  		 </div>
        <!-- 그리드 E -->

      	
      	<!-- 그리드 E -->	
		<div class="sub_stitle"> <p><%= columnData.getString("sub2_title") %> </p> </div>      	
 		
		<!--<div style="width:760px; overflow:auto;height:170px;" >	-->
		<!-- 그리드 S -->	
       <div id="n_board_area">
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="100%"><comment id="__NSID__"><object id="gr_stockMoveDtl" classid="<%=LGauceId.GRID%>" class="comn" width="100%"	height="140px" class="B_list">
				<param name="DataID" value="ds_stockMoveDtl">
				<param name="RowHeight" 	value="20">
				<param name="Enable" 		value="TRUE">
				<param name="ColSizing" 	value="true">
				<param name="SortView" 		value="Left">
				<Param Name="ColSelect" 	value="true">
				<param name="Format"
					value='
	           			<C>id=seq         	name="<%=columnData.getString("seq") %>"        	Edit="none"		align="center"   	width="30"  Value={CurRow} </C>
			            <C>id="materCd"    	name="<%=columnData.getString("mater_cd") %>" 	    Edit="none"		align="center"  	width="110" </C> 
			            <C>id="materCd"     name="<%=columnData.getString("mater_nm") %>"	    Edit="none"  	align="left"    	width="120" Data="ds_mater:code:name:code" editstyle="lookup"</C>
			            <C>id="unit"    	name="<%=columnData.getString("unit") %>"    	    Edit="none"   	align="center"  	width="50" </C>
			            <C>id="tranQty"    	name="<%=columnData.getString("tran_qty") %>"       Edit="none"   	align="right"  		width="110" </C>
				'>
			     </object></comment> <script>__WS__(__NSID__);</script>
		        </td>
		       </tr>
       	  	 </table>  
  		 </div>
        <!-- 그리드 E -->

		<!-- </div>	 -->
		 <!-- 버튼 S -->	
          <div id="btn_area">
           	 <p class="b_right">
				<span class="btn_r btn_l">
                <input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnSapCancel%>" onclick="javascript:f_sapCancel();"/></span> 
            </p>
        </div>
        <!-- 버튼 E -->	

        	  
</div>
</body>
</html>
