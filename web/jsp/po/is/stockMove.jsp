<%--
/*
 *************************************************************************
 * @source  : stockMove.jsp
 * @desc    : stokc Movement
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2010.08.24   mskim       신규작성
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
	//LMessageSource source = new LMessageSource(new Locale(g_lang), "utf-8");
	String currentDate = LDateUtils.getDate("yyyy/MM/dd");          // currentDate

	String msgSave        = source.getMessage("dev.cfm.com.save");    // Are you sure to save?
    String msgNoChance    = source.getMessage("dev.inf.com.nochange");   // no data for change
    String msgBiggerIssue = source.getMessage("dev.msg.po.biggerIssue");   // issue quantity is bigger then stock quantity!
    
%>

<script type="text/javascript">

//-------------------------------------------------------------------------
// 검색 버튼 클릭시 재고 조회
//-------------------------------------------------------------------------		
function f_Retrieve() {
	
	var param = "";

	var condition = "?";
		condition += "&issueLoc=" + issueLoc.ValueOfIndex("code",issueLoc.Index);
		condition += "&materCd=" + materCd.ValueOfIndex("code",materCd.Index);

	ds_grid.DataID = "rfc.cmd.retrieveStockMoveList.gau?"+condition;
	ds_grid.Reset();
	
	//alert(ds_grid.countrow);
}  

//-------------------------------------------------------------------------
// 품목찾기
//-------------------------------------------------------------------------	
function On_Apply() { 
    lc_mater.ShowSearchCol();
         
}

//-------------------------------------------------------------------------
// 출고등록
//-------------------------------------------------------------------------	
function f_save() {
 	
	//To Do 저장 validation check
	if (saveCheckData()) { 
	
		//변경한 데이터가 있는지 체크한다.
		if(confirm("<%= msgSave %>")){
			
			var param = "";
			//deptCd.ValueOfIndex("code",deptCd.Index);
			param += "issueLoc="  + issueLoc.ValueOfIndex("code",issueLoc.Index);
			param += "&receLoc="  + receLoc.ValueOfIndex("code",receLoc.Index);
			param += "&moveDate=" + removeDash(document.all.moveDate.value, "/");
			param += "&postingDate=" + removeDash(document.all.postingDate.value, "/");
			
			tr_master.KeyValue = "Servlet(I:IN_DS1=ds_grid)";
			tr_master.Action   = "po.is.cudStockMoveList.gau?"+param;
			tr_master.post();
		}
	}
}

function saveCheckData() {

 	if(!ds_grid.IsUpdated ) {
		alert( '<%= msgNoChance %>' );
		return false;
	}

	var isloc = issueLoc.ValueOfIndex("code",issueLoc.Index);
	var reloc  = receLoc.ValueOfIndex("code",receLoc.Index);

	if ( isloc == reloc ) {
		alert('<%= source.getMessage("dev.msg.po.diffLocation", "Issue Loc", "Receipt Loc") %>' );
			return false;
	} 
	
	var movDate  = removeDash(document.all.moveDate.value,"/");
	var postDate = removeDash(document.all.postingDate.value,"/");
	var currDate = removeDash("<%= currentDate %>","/");
	var currMon  = currDate.substring(0, 6);
	var postMon  = postDate.substring(0, 6);

	if ( postDate < movDate ) {
		alert('<%= source.getMessage("dev.msg.po.biggerMoveDate") %>' );
		return false;
	}
/*  post 월과 현재 월이 다를경우 체크 로직 제거 2010.11.05
	if ( currMon != postMon ) {
		alert('<%//= source.getMessage("dev.msg.po.chkSameMonth","posting","current"); %>');
		return false;
	}
*/	
	for(var i=1;i<=ds_grid.CountRow;i++){
		if(ds_grid.RowStatus(i) != 0 && ds_grid.NameValue(i,"stockQty")==""){
			ds_grid.RowPosition=i;
			alert('<%= source.getMessage("dev.warn.com.input","Move Qty")%>');
			return false;
		}
	}
	
	for(var i=1;i<=ds_grid.CountRow;i++){
		if(ds_grid.RowStatus(i) != 0 && ds_grid.NameValue(i,"stockQty")=="0"){
			ds_grid.RowPosition=i;
			alert("<%= source.getMessage("dev.msg.po.greaterZero","Stock Qty") %>" );
			return false;
		}
	}
	
	for(var i=1;i<=ds_grid.CountRow;i++){
		var stockQty = Number(ds_grid.NameValue(i,"stockQty"));
		var tranQty  = Number(ds_grid.NameValue(i,"tranQty"));

		if(ds_grid.RowStatus(i) != 0 && stockQty < tranQty){
			ds_grid.RowPosition=i;
			alert('<%= msgBiggerIssue %>' );
			return false;
		}
	}
	
	if(document.all.moveDate.value == ""){
		alert('<%=source.getMessage("dev.warn.com.input","Move Date")%>');
		document.all.moveDate.focus();
		return false;
	}
	
	return true;
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
<object id="ds_grid" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"    value="true">
	<param name="ViewDeletedRow" value="true">
</object>

<!-- 입고/출고 저장소 combo DataSet -->
<object id="ds_receLoc"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
	<param name="DataID"          value="cm.cm.retrieveCommCodeCombo.gau?groupCd=2005">
</object>

<!-- lx Combo 용 DataSet-->
<object id="ds_mater"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
	<param name="DataID"          value="cm.cm.retrieveCommComboMaterList.gau?materType=3110&firstVal=Total">
</object>


<%----------------------------------------------------------------------------------------------------
 Gauce obj  event  정의
------------------------------------------------------------------------------------------------------%>
<script language=JavaScript for=ds_grid event=OnLoadCompleted(rowCnt)>
    	//alert(rowCnt);
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
   	} else {
    	alert(tr_master.ErrorMsg);
	}
	
</script>

<script language=JavaScript for=ds_mater event=OnLoadCompleted(rowCnt)>

</script>

<script language=JavaScript for=materCd event=OnKeyDown(kcode)>
    if(kcode != 8 && kcode != 13 && kcode != 27 && kcode != 33 && kcode != 34 && kcode != 35 &&
        kcode != 36 && kcode != 37 && kcode != 38 && kcode != 39 && kcode != 40 && kcode != 45 &&
        kcode != 46 && kcode != undefined) {	
    		setTimeout("On_Apply()");
   	}
</script>

</head>

<body id="cent_bg" >

<div id="conts_box">

	<h2> <span> <%= columnData.getString("page_title") %></span></h2>
	 <!--검색 S -->	
	<fieldset class="boardSearch">
		<div>
			 <dl>
				<dt> 
					<table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board2" >
						<colgroup>
							<col width="18%"/>
							<col width="30%"/>
							<col width="13%"/>
							<col width=""/>
						 </colgroup>
						 <tr>
							<th><%= columnData.getString("issue_loc") %> </th>
							<td><comment id="__NSID__"><object id="issueLoc"  classid="<%=LGauceId.LUXECOMBO%>" width="150">
								    <param name="ComboDataID"       value="ds_receLoc">
									<param name="ListCount"     	value="10">
									<param name=SearchColumn		value="name">
									<param name=SyncComboData       value="false">
									<param name="BindColumn"    	value="code">
								    <param name=ListExprFormat		value="name^0^90,code^0^70">
								    <param name=index           	value=0>
							   	</object></comment><script>__WS__(__NSID__); </script></td>
							<th><%= columnData.getString("mater") %> </th>
							<td><comment id="__NSID__"><object id="materCd"  classid="<%=LGauceId.LUXECOMBO%>" width="150">
								    <param name="ComboDataID"       value="ds_mater">
									<param name="ListCount"     	value="10">
									<param name=SearchColumn		value="name">
									<param name="BindColumn"    	value="code">
								    <param name=ListExprFormat		value="name^0^150,code^0^70">
								    <param name=index           	value=0>
								    <param name=ComboStyle  		value="2">											    
								    <param name=WantSelChgEvent	value=true>	
							</object></comment><script>__WS__(__NSID__); </script></td>
						</tr>
					</table>
				 </dt>              		  	   	 	
				 <dd class="btnseat1"> 
				 	 <span class="search_btn_r search_btn_l">
                			 <input type="button" onfocus="blur();" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='#e2ebf7'" value="<%=btnSearch %>" onclick="javascript:f_Retrieve();"/></span>  
				 </dd>										
			</dl>
		</div>
	</fieldset>
      <!--검색 E -->
	<div class="sub_stitle"> <p> <%= columnData.getString("title_sub1") %></p> </div>     	
	
	<!-- 그리드 S -->	
     <div>
         <table width="100%" border="0" cellspacing="0" cellpadding="0">
           <tr>
             <td width="100%"><comment id="__NSID__"><object id="gr_grid" classid="<%=LGauceId.GRID%>" class="comn_status" width="100%" height="180px">
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
           			<C>id=seq         	name="<%=columnData.getString("seq") %>"        Edit="none"		align="center"   	width="30"  Value={CurRow} </C>
		            <C>id=materCd    	name="<%=columnData.getString("mater_cd") %>" 	Edit="none"		align="center"  	width="90" </C> 
		            <C>id=materNm       name="<%=columnData.getString("mater_nm") %>"	Edit="none"  	align="left"    	width="150" </C>
		            <C>id=unit    		name="<%=columnData.getString("unit") %>"  		Edit="none"   	align="center"  	width="50" </C>
		            <C>id=stockQty   	name="<%=columnData.getString("stock_qty") %>"	Edit="none"   	align="right"  		width="100" </C>
		            <C>id=tranQty    	name="<%=columnData.getString("tran_qty") %>"	Edit="true" 	align="right"  		width="100" </C>
		            <C>id=remainQty    	name="<%=columnData.getString("remain_qty") %>"	Edit="true" 	align="right"  		width="100" Value={Number(stockQty) - tranQty} DEC=3</C>
				   '>
		     </object></comment> <script>__WS__(__NSID__);</script>
	        </td>
	       </tr>
      	 </table> 
 	</div>

    <!-- 그리드 E -->	
	<div class="sub_stitle"> <p> <%= columnData.getString("title_sub2") %> </p> </div> 

	<!-- 그리드 S -->	
     <div id="output_board_area">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board" >
            <colgroup>
				<col width="17%"/>
				<col width="18%"/>
				<col width="13%"/>
	            <col width=""/>
            </colgroup>
            <tr>
				<th><%= columnData.getString("rece_loc") %></th>
                <td><comment id="__NSID__"><object id="receLoc"  classid="<%=LGauceId.LUXECOMBO%>" width="130">
				    	<param name="ComboDataID"       value="ds_receLoc">
						<param name="ListCount"     	value="10">
						<param name=SearchColumn		value="name">
						<param name="BindColumn"    	value="code">
						<param name=SyncComboData       value="false">
						<param name=ListExprFormat		value="name^0^90,code^0^70">
						<param name=index           	value=0>
				   	</object></comment><script>__WS__(__NSID__); </script>
				</td>
				<th><%= columnData.getString("move_date") %></th>
                <td><input id="moveDate"    name="moveDate"    type="text" onblur="valiDate(this);" style="width:60px;" value="<%= currentDate %>" /> <img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(moveDate, postingDate);" style="cursor:hand"/> </td>
				<th><%= columnData.getString("posting_date") %></th>
                <td><input id="postingDate" name="postingDate" type="text" onblur="valiDate(this);" style="width:60px;" value="<%= currentDate %>" /> <img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(postingDate);" style="cursor:hand"/> </td>
            </tr>   
    	</table>
	</div>
    <!-- 그리드 E -->	

	<!-- 버튼 S -->	
    <div id="btn_area"><p class="b_right">
         <span class="btn_r btn_l"><input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#444'" value="<%=btnSave%>" onclick="javascript:f_save();"/></span></p>
    </div>
    <!-- 버튼 E -->


</div>
</body>
</html>
