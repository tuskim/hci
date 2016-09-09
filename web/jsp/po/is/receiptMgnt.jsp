<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%--
/*
 *************************************************************************
 * @source  : receiptMgnt.jsp
 * @desc    : 입고 등록
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2010.08.04   최용락       신규작성
 * 1.1  2010.09.09   노태훈       Po No선택 기준 및  Close 관련 기능 개
 * ---  -----------  ----------  -----------------------------------------
 * PT-PAM 시스템
 * Copyright(c) 2006-2007 LG CNS,  All rights reserved.
 *************************************************************************
 */
--%> 
<%@ page import = "java.util.*" %>
<%@ page import = "java.lang.*" %>
<%@ page import="devon.core.util.*" %>
<%@ page import="comm.util.*"%>

<%	
	//LMessageSource source = new LMessageSource(new Locale(g_lang), "utf-8");
	//String btnSearch = source.getMessage("nomal.search");
	
	String prevDate	   = LDateUtils.getDate("yyyy/MM/") +"01"; 
	String currentDate = LDateUtils.getDate("yyyy/MM/dd");          // currentDate
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="Generator" content="" />
<meta name="Author" content="" />
<meta name="keywords" content="" />
<meta name="Description" content="" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<%@ include file="/include/head.jsp" %>

<title>Untitled Document</title>
<link rel="stylesheet" type="text/css" href="/sys/css/common.css" />
<link rel="stylesheet" type="text/css" href="/sys/css/sub_style.css" />
</head>
<script type="text/javascript">
//-------------------------------------------------------------------------
//콤보박스
//-------------------------------------------------------------------------					
function init(){
	ds_deptCode.DataId="/cm.cm.retrieveCommCodeCombo.gau?groupCd=2001&firstVal=Total";
	ds_deptCode.Reset();
	
	ds_location.DataId="/cm.cm.retrieveCommCodeCombo.gau?groupCd=2005&firstVal=Total";
	ds_location.Reset();

	ds_location_grid.DataId="/cm.cm.retrieveCommCodeCombo.gau?groupCd=2005";
	ds_location_grid.Reset();
	
	ds_cur.DataId="/cm.cm.retrieveCommCodeCombo.gau?groupCd=2004";
	ds_cur.Reset();
	
	ds_startPlace.DataId="/cm.cm.retrieveCommCodeCombo.gau?groupCd=2311";
	ds_startPlace.Reset();
	
	f_setData();

}

//-------------------------------------------------------------------------
// Set header
//-------------------------------------------------------------------------
function f_setData(){
	 
	cfAddYn(ds_msUseyn,"code");
	
}

//-------------------------------------------------------------------------
// 검색 버튼 클릭시 PO목록 조회
//-------------------------------------------------------------------------		
function f_search() {
	var frm = document.sForm;
	
	if(frm.srtDate.value == "" || frm.endDate.value == "")
	{
		alert("<%=source.getMessage("dev.warn.com.required", "Date")%>");
		return;
	}
			
	var param = "";

	param += "srtDate=" + removeDash(frm.srtDate.value, "/") + "&endDate=" + removeDash(frm.endDate.value, "/");
	param += "&sVendor=" + frm.sVendor.value + "&deptCd=" + ds_location.nameValue(ds_location.rowPosition,"code");

	ds_grid.DataID = "/po.is.receiptMgnt.retrievePoListGau.gau?"+param;
	ds_grid.Reset();
	
}  


function f_setSaveData(){         			
var strHeader = "poNo"       	+ ":STRING(50),"
                +"poSeq"        			+ ":STRING(50),"
	            +"vendCd"       			+ ":STRING(50),"
	            +"vendNm"       		+ ":STRING(50),"
	            +"materCd"      		+ ":STRING(50),"
	            +"materNm"      		+ ":STRING(50),"
	            +"purDeptCd"    		+ ":STRING(50),"
	            +"purDeptName"  	+ ":STRING(50),"
	            +"deliLoct"      			+ ":STRING(50),"
	            +"delivyPlaName" 	+ ":STRING(50),"
	            +"unit"         				+ ":STRING(50),"
	            +"qty"          				+ ":DECIMAL(13.2),"
	            +"preQty"       			+ ":DECIMAL(13.2),"
	            +"recQty"       			+ ":DECIMAL(13.2),"
	            +"clsYn"        			+ ":STRING(50),"
	            +"recDate"      			+ ":STRING(50),"
	            +"postDate"     			+ ":STRING(50),"
	            +"sapPoNo"      		+ ":STRING(50),"
	            +"carNo"      				+ ":STRING(50),"
	            +"sealNo"      			+ ":STRING(50),"
	            +"driverName"      	+ ":STRING(50),"
	            +"startPlace"      		+ ":STRING(50),"
	            +"deliDate"      			+ ":STRING(8),"
	            +"deliTime"      			+ ":STRING(4),"
	            +"currencyCd"      	+ ":STRING(3),"
	            +"costAmt"       		+ ":DECIMAL(15.2)"
	            ;
			        	    
	ds_save.SetDataHeader(strHeader);
	ds_save.ClearData();	
	for(var i=1; i<=ds_grid.CountRow; i++){
		if(ds_grid.NameValue(i,"chk")=="T"){
			
			ds_save.Addrow();
			ds_save.NameValue(ds_save.RowPosition,"poNo"       	  	) = ds_grid.NameValue(i, "poNo");
			ds_save.NameValue(ds_save.RowPosition,"poSeq"       	) = ds_grid.NameValue(i, "poSeq");
			ds_save.NameValue(ds_save.RowPosition,"vendCd"          ) = ds_grid.NameValue(i, "vendCd");
			ds_save.NameValue(ds_save.RowPosition,"vendNm"          ) = ds_grid.NameValue(i, "vendNm");
			ds_save.NameValue(ds_save.RowPosition,"materCd"         ) = ds_grid.NameValue(i, "materCd");
			ds_save.NameValue(ds_save.RowPosition,"materNm"         ) = ds_grid.NameValue(i, "materNm");
			ds_save.NameValue(ds_save.RowPosition,"purDeptCd"       ) = ds_grid.NameValue(i, "purDeptCd");
			ds_save.NameValue(ds_save.RowPosition,"purDeptName"     ) = ds_grid.NameValue(i, "purDeptName");
			ds_save.NameValue(ds_save.RowPosition,"deliLoct"        ) = ds_grid.NameValue(i, "deliLoct");
			ds_save.NameValue(ds_save.RowPosition,"delivyPlaName"   ) = ds_grid.NameValue(i, "delivyPlaName");
			ds_save.NameValue(ds_save.RowPosition,"unit"            ) = ds_grid.NameValue(i, "unit");
			ds_save.NameValue(ds_save.RowPosition,"qty"             ) = ds_grid.NameValue(i, "qty");
			ds_save.NameValue(ds_save.RowPosition,"preQty"          ) = ds_grid.NameValue(i, "preQty");
			ds_save.NameValue(ds_save.RowPosition,"recQty"          ) = ds_grid.NameValue(i, "recQty");

			var qty    = Number(ds_grid.NameValue(i, "qty"));
			var preQty = Number(ds_grid.NameValue(i, "preQty"));
			var recQty = Number(ds_grid.NameValue(i, "recQty"));
			
			if( preQty+recQty == qty ){
				ds_save.NameValue(ds_save.RowPosition,"clsYn"       ) = "Y";
			}else{
				ds_save.NameValue(ds_save.RowPosition,"clsYn"       ) = ds_grid.NameValue(i, "clsYn");
			}
			
			ds_save.NameValue(ds_save.RowPosition,"recDate"         ) = removeDash(document.all.recDate.value, "/");
			ds_save.NameValue(ds_save.RowPosition,"postDate"        ) = removeDash(document.all.postDate.value, "/");
			ds_save.NameValue(ds_save.RowPosition,"sapPoNo"         ) = ds_grid.NameValue(i, "sapPoNo");
			
			ds_save.NameValue(ds_save.RowPosition,"carNo"          ) = ds_grid.NameValue(i, "carNo");
			ds_save.NameValue(ds_save.RowPosition,"sealNo"          ) = ds_grid.NameValue(i, "sealNo");
			ds_save.NameValue(ds_save.RowPosition,"driverName"          ) = ds_grid.NameValue(i, "driverName");
			ds_save.NameValue(ds_save.RowPosition,"startPlace"          ) = ds_grid.NameValue(i, "startPlace");
			ds_save.NameValue(ds_save.RowPosition,"deliDate"          ) = ds_grid.NameValue(i, "deliDate");
			ds_save.NameValue(ds_save.RowPosition,"deliTime"          ) = ds_grid.NameValue(i, "deliTime");
			ds_save.NameValue(ds_save.RowPosition,"currencyCd"          ) = ds_grid.NameValue(i, "currencyCd");
			ds_save.NameValue(ds_save.RowPosition,"costAmt"          ) = ds_grid.NameValue(i, "costAmt");
		}
	}
}

//-------------------------------------------------------------------------
// 입고등록
//-------------------------------------------------------------------------	
function f_save() {
	
	if(document.all.recDate.value == ""){ 
		alert("<%=source.getMessage("dev.warn.com.input",columnData.getString("rec_date"))%>");
		return;
	} 
	
	if(document.all.postDate.value == ""){
		alert("<%=source.getMessage("dev.warn.com.input",columnData.getString("post_date"))%>");
		return;
	}
	
	if(document.all.postDate.value < document.all.recDate.value){
		alert("<%=source.getMessage("dev.msg.po.postReceit")%>");
		return;
	}
	
	//체크박스
	var chkTmp = "false";
	for(var i=0; i<=ds_grid.CountRow; i++){
		if( "T" == ds_grid.NameValue(i, "chk")){
			chkTmp = "true";
		} 
	}
	
	if( chkTmp == "false")
	{
		alert("<%=source.getMessage("dev.inf.com.nosave")%>");
		return;
	}
	
	//체크된 건에 대해서 같은 po 동일번호 체크
	var tmp = "";
	for(var j=1; j<=ds_grid.CountRow; j++){
		if("T" == ds_grid.NameValue(j, "chk")){
			//alert("tmp===>"+tmp);alert("poNo===>"+ds_grid.NameValue(j, "poNo"));
		     if(j != 1 &&  tmp != "" && tmp != ds_grid.NameValue(j, "poNo")){
		     	alert("<%=source.getMessage("dev.msg.po.sameReceit",columnData.getString("po_no"))%>");
		     	return;
		     }
			 tmp = ds_grid.NameValue(j, "poNo");
		}
	}
	
	//체크된 건에 대해서 같은 location으로 가는지 체크
	var tmp = "";
	for(var j=1; j<=ds_grid.CountRow; j++){
		if("T" == ds_grid.NameValue(j, "chk")){
			//alert("tmp===>"+ tmp + " delivyPlaName===>"+ds_grid.NameValue(j, "delivyPlaName"));
		     if(j != 1 &&  tmp != "" && tmp != ds_grid.NameValue(j, "deliLoct")){
		     	alert("<%=source.getMessage("dev.msg.po.sameReceit",columnData.getString("deliy_pla"))%>");
		     	return;
		     }
			 tmp = ds_grid.NameValue(j, "deliLoct");
		}
	}
	
	//입고 수량 체크
	for(var k=1;k<=ds_grid.CountRow;k++){
		if("T" == ds_grid.NameValue(k, "chk")){
			var reqQty = ds_grid.NameValue(k,"qty");
			var preQty = ds_grid.NameValue(k,"preQty");
			var recQty = ds_grid.NameValue(k,"recQty");
			
			if(reqQty-preQty < recQty){
				ds_grid.RowPosition=k;
				alert("<%=source.getMessage("dev.msg.po.compare")%>");
				return;
			}
			
			if(recQty == 0 && "N" == ds_grid.NameValue(k,"clsYn"))
			{
				ds_grid.RowPosition=k; 
				alert("<%=source.getMessage("dev.warn.com.input",columnData.getString("clsYn"))%>");
				return;
			}
		}
	}
	
	if(confirm("<%=source.getMessage("dev.cfm.com.save")%>")){
		f_setSaveData();
		tr_master.KeyValue = "Servlet(I:IN_DS1=ds_save)";
		tr_master.Action   = "/po.is.cmd.cudReceiptMgntCmd.gau";
		tr_master.post();
	}
}

function f_excel() {
	
	gf_excel(ds_grid,gr_grid,"<%=columnData.getString("page_title") %>","c:\\");
}

//입고일자와 post일자 동기화
function setPostDate(){
	document.all.postDate.value = document.all.recDate.value;
}


</script>



<!-- TR 조회용 -->
<OBJECT id="tr_master" classid="<%=LGauceId.TR%>">
	<param name="KeyName" value="toinb_dataid4">
</OBJECT>
    
<!-- Grid 용 DataSet-->
<object id="ds_grid" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad" value="true">
	<param name="ViewDeletedRow" value="true">
</object>

<!-- Save 용 DataSet-->
<object id="ds_save" classid="<%=LGauceId.DATASET%>" >
  	<param name="SyncLoad"          value="true">
  	<param name="ViewDeletedRow"    value="false">
</object>

<!-- 사무소 combo DataSet -->
<object id="ds_deptCode"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"          value="true">
</object>

<!-- 저장소 combo DataSet -->
<object id="ds_location"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"          value="true">
</object>

<!-- grid 용 저장소 combo DataSet(total 없음) -->
<object id="ds_location_grid"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"          value="true">
</object>


<!-- yn -->
<object id="ds_msUseyn" classid="<%=LGauceId.DATASET%>">
  <param name="SyncLoad"          value="true">
  <param name="ViewDeletedRow"    value="true">
</object>

<object id="ds_cur" classid="<%=LGauceId.DATASET%>">
  <param name="SyncLoad"          value="true">
  <param name="ViewDeletedRow"    value="true">
</object>

<object id="ds_startPlace" classid="<%=LGauceId.DATASET%>">
  <param name="SyncLoad"          value="true">
  <param name="ViewDeletedRow"    value="true">
</object>

<!-- 표준 공통  검색조건 파라메타   DataSet -->
<object id="ds_param" classid="<%=LGauceId.DATASET%>"> </object>

<!-----------------------------------------------------------------------------
G A U C E   C O M P O N E N T' S   E V E N T S
------------------------------------------------------------------------------>
<script language=JavaScript for="ds_statusCode" event=OnRowPosChanged(row)>
		ds_grid.nameValue(ds_grid.rowPosition,"detailDeptCd") =ds_statusCode.nameValue(ds_statusCode.rowPosition,"detailDeptCd");
</script>

<script language=JavaScript for=tr_master event=OnSuccess()>
		f_search();			
        alert("successfully saved.");
</script>
<script language=JavaScript for=tr_master event=OnFail()>
    
    mode = "";
    if(tr_master.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
        window.parent.location.href = "/index.jsp";    
    }
    
    alert(tr_master.ErrorMsg);
</script>
<script language=JavaScript for=ds_grid event=OnLoadStarted()>
  cfShowDSWaitMsg(gr_grid);//progress bar 보이기
  cfHideNoDataMsg(gr_grid);//no data 메시지 숨기기
</script>

<!-- Hub In Header 조회 DataSet -->
<script language=JavaScript for=ds_grid event=OnLoadCompleted(rowCnt)>
  cfHideDSWaitMsg(gr_grid);//progress bar 숨기기
  cfFillGridNoDataMsg(gr_grid,"gridColLineCnt=2");//no data found   
</script> 
<!-- main 조건설정-->
<script language=JavaScript for=gr_grid event=OnCloseUp(row,colid)> 
	if(colid=="clsYn"){ 
		if(ds_grid.NameValue(row,colid) =="Y")
			ds_grid.NameValue(row,"recQty") = 0;
	} 	
</script> 

<script language=JavaScript for=gr_grid event=OnCheckClick(row,colid,check)>
	var tmp = "";
	var tmp2 = "";
	for(var j=1; j<=ds_grid.CountRow; j++){
		if("T" == ds_grid.NameValue(j, "chk")){
			//alert("tmp===>"+tmp);alert("poNo===>"+ds_grid.NameValue(j, "poNo"));
		     if(j != 1 &&  tmp != "" && tmp != ds_grid.NameValue(j, "poNo")){
		     	ds_grid.NameValue(ds_grid.RowPosition, "chk") ="F";
		     	alert("<%=source.getMessage("dev.msg.po.sameReceit",columnData.getString("po_no"))%>");
		     	return;
		     }else if(j != 1 &&  tmp2 != "" && tmp2 != ds_grid.NameValue(j, "deliLoct")){
				ds_grid.NameValue(ds_grid.RowPosition, "chk") ="F";		     
		     	alert("<%=source.getMessage("dev.msg.po.sameReceit",columnData.getString("deliy_pla"))%>");
		     	return;
		     }
			 tmp2 = ds_grid.NameValue(j, "deliLoct");		     
			 tmp = ds_grid.NameValue(j, "poNo");
		}
	}
  
</script>


<script language=JavaScript for=gr_grid event=OnPopup(row,colid,data)>
 	if ( colid == "deliDate") {
	 	h_date.value ="";
		gf_calendarExClean(h_date); 
		ds_grid.NameValue(row,"deliDate") =funcReplaceStrAll(h_date.value,"/","");	 	
	}
</script>

<body id="cent_bg" onload="javascript:init()">

<div id="conts_box">
	<h2> <span> <%= columnData.getString("page_title") %>  </span></h2>
	 <!--검색 S -->	

	 <fieldset class="boardSearch">
	    <form name="sForm" style="margin:0px">
			<legend><%=columnData.getString("page_title")  %></legend> 
				<div>
					 <dl>
						<dt> 
							<table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board2" >
									<colgroup>
											<col width="20%"/>
											<col width="35%"/>
											<col width="9%"/>
											<col width="35%"/>
											<col width="5%"/>
											<col width=""/>
									  </colgroup>
									   <tr>
											<th><%=columnData.getString("po_date")  %> </th>
											<td> 
											 <input id="srtDate" name="srtDate" type="text" style="width:70px;" value="<%= prevDate %>" onblur="valiDate(this);"/> <img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(srtDate);" style="cursor:hand"/> ~ 
											 <input id="endDate" name="endDate" type="text" style="width:70px;" value="<%= currentDate %>" onblur="valiDate(this);"/> <img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(endDate);" style="cursor:hand"/>
											</td>					
											<th><%=columnData.getString("vendor")  %></th>
											<td><input id="sVendor" name="sVendor" type="text" style="width:100px;" value="" /></td>
										</tr>
										<tr>
											<th><%=columnData.getString("locat")  %>  </th>
											<td colspan="5"><comment id="__NSID__"><object id="slocation"  classid="<%=LGauceId.LUXECOMBO%>" width="150">
												    <param name="ComboDataID"       value="ds_location">
													<param name="ListCount"     	value="10">
													<param name=SearchColumn		value="name">
													<param name="BindColumn"    	value="code">
												    <param name=ListExprFormat		value="name^0^90,code^0^70">
												    <param name=index           	value=0>
											   	</object></comment><script>__WS__(__NSID__); </script></td>
										</tr>
								</table>
						 </dt>              		 
					 <dd class="btnseat2"> 
					 	  <span class="search_btn2_r search_btn2_l">
	                			  <input type="button" onfocus="blur();" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='#e2ebf7'" value="<%=btnSearch %>" onclick="javascript:f_search();"/></span> 
					 </dd>						  	   	 	 								
					</dl>
				</div>
		     </form>
		</fieldset>
      <!--검색 E -->	

     <div class="sub_stitle"> <p> <%=columnData.getString("po_list")  %> </p> 
		<p class="rightbtn"> 
					<span class="excel_btn_r excel_btn_l">
	                <input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="Excel Down" onclick="f_excel()"/>
	                </span> 
		</p>
		<dl>
				<dt> <%=columnData.getString("rec_date")  %> </dt>								
				<dd> <input id="recDate" name="recDate" type="text" style="width:70px;" value="<%= currentDate %>" onblur="valiDate(this);"/> <input name="Button24" type="button" class="button_cal" value=" " onClick="javascript:OpenCalendar(recDate, postDate);"/> </dd>&nbsp;&nbsp;
				<dt> <%=columnData.getString("post_date")  %> </dt>								
				<dd> <input id="postDate" name="postDate" type="text" style="width:70px;" value="<%= currentDate %>" onblur="valiDate(this);"/> <input name="Button24" type="button" class="button_cal" value=" " onClick="javascript:OpenCalendar(postDate);"/> </dd>
		</dl>		
     </div>        	
		
 	  <!-- <div style="width:760px; overflow:auto;height:130px; " > -->
	  <!-- 그리드 S -->	
	  
       <div id="n_board_area">
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="100%">
              <object id="gr_grid" classid="<%=LGauceId.GRID%>" class="comn" width="100%"
				height="300px" class="B_list">
				<param name="DataID" value="ds_grid">
				<param name="Editable" value="TRUE">
				<param name=UsingOneClick  value="1">
				<Param name="AutoResizing"      value=true>
				<param name="ColSizing"         value=true>
				<Param name="DragDropEnable"    value=True>
				<param name="TitleHeight"          value="35"/>
				<param name="ToolTip"
					value="use=true;header=true;alt=false;createtime=500;fontsize=9;color=#0f0f0f;edgecolor=green;">
	
				<param name="Format"
					value='
							            <fc>id="chk"    		Show="ture"  Edit="true"  			align="center"  	width="30"     EditStyle="check" 	   	</fc> 
							            <fc>id="poNo"    		Show="ture"  Edit="none"  			align="left"  	width="80"     name="<%=columnData.getString("po_no") %>" 	   	</fc> 
							            <fc>id="poSeq"    		Show="false"  Edit="none"  			align="left"  	width="90"     name="" 	   	</fc> 
							            <fc>id="vendCd"    		Show="false" Edit="none"   			align="left"  	width="90"     name=""    	</fc>
							            <fc>id="vendNm"    				     Edit="none"   			align="left"  	width="120"     name="<%=columnData.getString("vendor") %>"    	</fc>
							            <fc>id="materCd"    	Show="false" Edit="none"   			align="center"  width="90"     name="" 		</fc>
							            <fc>id="materNm"    		 	     Edit="none"   			align="left"  	width="140"     name="<%=columnData.getString("mater") %>" 		</fc>
							            <c>id="purDeptCd"    	Show="false" Edit="none"   			align="left"    width="90"     name="" 	   	</c>
							            <c>id="purDeptName"    	Show="false" Edit="none"   			align="left"    width="60"     name="<%=columnData.getString("req_office") %>" 	   	</c> 		
							            <c>id="deliLoct"    	     	  Edit={decode(chk,"T","false","true")}   		Data="ds_location_grid:code:name"    EditStyle="Lookup"	 align="left"  	width="90"     name="<%=columnData.getString("deliy_pla") %>" 	   	</c>		
							            <c>id="unit"    			 		 Edit="none"   			align="center"  width="30"     name="<%=columnData.getString("unit") %>"     	</c>
							            <c>id="qty"    			 		 	 Edit="none"   			align="right"  	width="90"     name="P/O Qty"     	</c>   		
							            <c>id="preQty"    		 			 Edit="none"   			align="right" 	width="90"     name="<%=columnData.getString("pre_qty") %>"  		</c>
							            <c>id="recQty"    	  		 Edit={decode(qty,preQty,"false",decode(clsYn,"N","true","false"))}      	align="right"  	width="90"     name="<%=columnData.getString("rec_qty") %>"     	</c>
							            <c>id="clsYn"    			 	     Edit="true"  			align="center"   Data="ds_msUseyn:code:name"    EditStyle="Lookup"	width="40"     name="<%=columnData.getString("close_yn") %>"     	</c> 		
										'/>
			     </object>
		        </td>
		       </tr>
       	  	 </table>  
		<!--</div>  -->
        <!-- 그리드 E -->
		</div>	
        <!-- 버튼 S -->	
          <div id="btn_area">
            <p class="b_right"><span class="btn_r btn_l">
                    <input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnSave %>" onclick="javascript:f_save();"/></span> 
            </p>
        </div>
        <!-- 버튼 E -->	


        	  
</div> 
<input type="hidden" id="h_date"/>
</body>

</html>
