<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--
/*
 *************************************************************************
 * @source  : stockIssueList.jsp
 * @desc    : 재고자산 출고 List 조회 및 취소 요청
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2010.08.25   임민수       신규작성
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

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="Generator" content="" />
<meta name="Author" content="" />
<meta name="keywords" content="" />
<meta name="Description" content="" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<%@ include file="/include/head.jsp" %>

<title>Untitled Document</title>
<%	
	//LMessageSource source = new LMessageSource(new Locale(g_lang), "utf-8");
	//String btnSearch = source.getMessage("nomal.search");
	String prevDate	   = LDateUtils.getDate("yyyy/MM/") +"01"; 
	String currentDate = LDateUtils.getDate("yyyy/MM/dd");          // currentDate
%>

<link rel="stylesheet" type="text/css" href="../sys/css/common.css" />
<link rel="stylesheet" type="text/css" href="../sys/css/sub_style.css" />
</head>
<script type="text/javascript">
//-------------------------------------------------------------------------
//콤보박스
//-------------------------------------------------------------------------					
function init(){
	//저장소
	ds_location.DataId="/cm.cm.retrieveCommCodeCombo.gau?groupCd=2005&attr2Loc=MS";
	ds_location.Reset();
	
	//상태 
	ds_statusCode.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2208";
	ds_statusCode.Reset();

	//vendor
	ds_vendor.DataId="cm.cm.retrieveCommComboVendorList.gau";
	ds_vendor.Reset();

	//cost Center
	ds_costCenter.DataId="cm.cm.retrieveCommComboCostCenterList.gau?";
	ds_costCenter.Reset();


				    
}
//-------------------------------------------------------------------------
// 검색 버튼 클릭시 재고 조회
//-------------------------------------------------------------------------		
function f_search() {
	var frm = document.sForm;
	
	var param = "";

	param += "issue_loc=" + ds_location.nameValue(ds_location.rowPosition,"code");
	param += "&vendorCd=" + ds_vendor.nameValue(ds_vendor.rowPosition,"code");
	param += "&status=" + ds_statusCode.nameValue(ds_statusCode.rowPosition,"code");
	param += "&posting_date_from=" + removeDash(frm.srtDate.value, "/");
	param += "&posting_date_to=" + removeDash(frm.endDate.value, "/");
	

	ds_grid.DataID = "/po.is.retrieveStockIssueRequestList.gau?"+param;
	ds_grid.Reset();
	
	//alert(ds_grid.countrow);
}  


//-------------------------------------------------------------------------
// 출고취소
//-------------------------------------------------------------------------	
function f_cancel() {
 	if(!ds_grid.IsUpdated) {
		alert("<%=source.getMessage("dev.warn.com.chkHeaderCount")%>");
		return;
	}
	for(var i=1;i<=ds_grid.CountRow;i++){
		if(ds_grid.RowStatus(i) != 0 && ds_grid.NameValue(i,"status")!="03"  && ds_grid.NameValue(i,"status")!="06" ){
			ds_grid.RowPosition=i;
			alert("<%=source.getMessage("dev.msg.po.statusCheck", "Transfer Confirm Or Cancel Fail")%>");       
			return;
		}
	}
	
	//To Do 저장 validation check
	for(var i=1; i<=ds_grid.CountRow; i++){
		
		if(ds_grid.NameValue(ds_grid.RowPosition,"cancelPostingDate") == ""){
			alert("Input the Cancel Posting Date!");
			return;
		}
		
		
		if(ds_grid.NameValue(ds_grid.RowPosition,"postingDate") > ds_grid.NameValue(ds_grid.RowPosition,"cancelPostingDate")  ){
			alert("Cancel Posting Date is required to be greater than Posting Date.")
			return;
		}
		
	}
	
	//변경한 데이터가 있는지 체크한다.
	if(confirm("<%=source.getMessage("dev.cfm.com.cancel") %>")){		
		tr_master.KeyValue = "Servlet(I:IN_DS1=ds_grid)";
		tr_master.Action   = "/po.is.cudStockIssueSAPCancel.gau";
		tr_master.post();
	}
}

function f_excel() {
	
	gf_excel(ds_grid,gr_grid,"<%=columnData.getString("page_title") %>","c:\\");
}

</script>  

<!-- TR 조회용 -->
<OBJECT id="tr_master" classid="<%=LGauceId.TR%>">
	<param name="KeyName" value="toinb_dataid4">
</OBJECT>

<!-- Grid 용 DataSet-->
<object id="ds_grid" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"    value="true">
	<param name="ViewDeletedRow" value="true">
</object>

<!-- 저장소 combo DataSet -->
<object id="ds_location"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"          value="true">
</object>

<!-- vendor 용 DataSet-->
<object id="ds_vendor" classid="<%=LGauceId.DATASET%>" >
  	<param name="SyncLoad"          value="true"> 
</object>

<!-- Cost Center용 DataSet-->
<object id="ds_costCenter" classid="<%=LGauceId.DATASET%>" >
  	<param name="SyncLoad"          value="true"> 
</object>

<!-- Status combo DataSet -->
<object id="ds_statusCode"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
</object>

<!-- 표준 공통  검색조건 파라메타   DataSet -->
<object id="ds_param" classid="<%=LGauceId.DATASET%>"> </object>

<%----------------------------------------------------------------------------------------------------
 Gauce obj  event  정의
------------------------------------------------------------------------------------------------------%>


<script language=JavaScript for=ds_grid event=OnLoadCompleted(rowCnt)>
    	//alert(rowCnt);
</script>

<!-- Hub In Header 조회 DataSet -->
<script language=JavaScript for=ds_grid event=OnLoadCompleted(rowCnt)>
  cfFillGridNoDataMsg(gr_grid,"gridColLineCnt=2");//no data found   
</script>


<script language=JavaScript for="ds_grid" event=OnRowPosChanged(row)>
		
		for(var i=1; i<=ds_grid.CountRow; i++){
			if(i != row)
				ds_grid.NameValue(i, "chk") = "F";
		}
		
		ds_grid.UndoAll();
		
</script>
		
<script language="javascript" for="gr_grid" event="onClick( Row, Colid )">
		if(Colid == "chk"){
			for(var i=1; i<=ds_grid.CountRow; i++){
				if(i != Row)
					ds_grid.NameValue(i, "chk") = "F";
			}
		}else{
			ds_grid.NameValue(ds_grid.RowPosition, "chk") = "T";
		}
</script>

<script language="javascript"  for=gr_grid event=OnPopup(Row,Colid,data)>
	  
		if (Colid == "cancelPostingDate" && ds_grid.NameValue(Row,"status") == "03") {
		 	h_date.value ="";
			gf_calendarExClean(h_date);
			ds_grid.NameValue(ds_grid.RowPosition,"cancelPostingDate") = funcReplaceStrAll(h_date.value,"/","");		 
		}	
	
</script>


<script language=JavaScript for=tr_master event=OnSuccess()>
		f_search();			
        alert("successfully saved.");
</script>

<script language=JavaScript for=tr_master event=OnFail()>
    
<!--    mode = "";-->
    if(tr_master.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
        window.parent.location.href = "/index.jsp";    
    }
    alert(tr_master.ErrorMsg);
    
</script>

<script language=JavaScript for=ds_vendor event=OnLoadCompleted(rowCnt)>
	cfUnionBlank(ds_vendor,lc_vendor,"code","name","--Total--"); 
</script>

<script language=JavaScript for=ds_statusCode event=OnLoadCompleted(rowCnt)>
	cfUnionBlank(ds_statusCode,st_mater,"code","name","--Total--"); 
</script>


<body id="cent_bg" onload="init();">
<div id="conts_box">
	<h2><span><%= columnData.getString("page_title2") %></span></h2>
	 <!-- 검색 S -->
	 <form name="sForm" style="margin:0px">	
		 <fieldset class="boardSearch">
				<div>
					 <dl>
						<dt> 
								<table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board2" >
									<colgroup>
											<col width="15%"/>
											<col width="35%"/>
											<col width="20%"/>
											<col width="30%"/>
											<col width="5%"/>
											<col width=""/>
									  </colgroup>
									   <tr>
											<th><%=columnData.getString("posting_date")  %> </th>
											<td> 
											 <input id="srtDate" name="srtDate" type="text" onblur="valiDate(this);" style="width:70px;" value="<%= prevDate %>" /> <img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(srtDate);" style="cursor:hand"/> ~ 
											 <input id="endDate" name="endDate" type="text"onblur="valiDate(this);"  style="width:70px;" value="<%= currentDate %>" /> <img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(endDate);" style="cursor:hand"/>
											</td>					
											<th>Storage Location</th>
											<td><comment id="__NSID__"><object id="issue_loc"  classid="<%=LGauceId.LUXECOMBO%>" width="150">
												    <param name="ComboDataID"       value="ds_location">
													<param name="ListCount"     	value="10">
													<param name=SearchColumn		value="name">
													<param name="BindColumn"    	value="code">
												    <param name=ListExprFormat		value="name^0^90,code^0^70">
												    <param name=index           	value=0>
											   	</object></comment><script>__WS__(__NSID__); </script></td>	
										</tr>
										<tr>
											<th><%= columnData.getString("status") %></th>
											<td colspan="3"><comment id="__NSID__"><object id="st_mater"  classid="<%=LGauceId.LUXECOMBO%>" width="150">
											    <param name="ComboDataID"       value="ds_statusCode">
												<param name="ListCount"     	value="10">
												<param name="BindColumn"    	value="code">
												<param name="WantSelChgEvent"   value="TRUE">
											    <param name=ListExprFormat		value="name^0^120,code^0^70">
											    <param name=index           	value=0> 
											</object></comment><script>__WS__(__NSID__); </script></td></td>
											
										</tr>
								</table>
								
						 </dt>  
						      		  	   	 
						<dd class="btnseat2"> 
							<span class="search_btn2_r search_btn2_l">
							<input type="button" onfocus="blur();" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='#e2ebf7'" value="<%=btnSearch%>" onclick="f_search();"/></span> 
						</dd>			
										      		  	   	 
					</dl>
				</div>
			</fieldset>
		</form>       
      <!-- 그리드 E -->	
		<div class="sub_stitle"> <p><%= columnData.getString("title_sub3") %> </p>
		 <p class="rightbtn"> 
					<span class="excel_btn_r excel_btn_l">
	                <input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="Excel Down" onclick="f_excel()"/>
	                </span> 
		 </p>
		</div>      	
 		
		<!-- 그리드 S -->	
       <div id="n_board_area">
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="100%"><object
				id="gr_grid" classid="<%=LGauceId.GRID%>" class="comn" width="100%"
				height="280px" class="B_list">
				<param name="DataID" value="ds_grid">
				<param name="BorderStyle" value="2">
				<param name="RowHeight" value="20">
				<param name="IndWidth" value="15">
				<param name="Enable" value="TRUE">
				<param name="Editable" value="TRUE">
				<param name="ColSizing" value="true">
				<param name="ViewDeletedRow" value="true">
				<param name="DragDropEnable" value="true">
				<param name="DisableNoHScroll" value="true">
				<param name="SortView" value="Left">
				<param name="UsingOneClick"		value="1">
				<Param Name="ColSelect" value="true">
				<Param name="AutoResizing"      value=true>
				<param name="TitleHeight"          value="35"/>
				 <param name=ViewSummary         value="1">
				<param name="ToolTip"
					value="use=true;header=true;alt=false;createtime=500;fontsize=9;color=#0f0f0f;edgecolor=green;">
	           
				<param name="Format"
					value='
						<fc>id="chk"					Edit="true"       width="30"	  EditStyle=CheckBox	</fc>
			            <fc>id="issueNo"    			Edit="none"		align="center"  	width="85"     name="<%=columnData.getString("issue_no") %>" 	   	</fc> 
			            <fc>id="materCd"     			Edit="none"  	align="center"    	width="85"     name="<%=columnData.getString("mater_cd") %>"		</fc>
			            <fc>id="materNm"     			Edit="none"  	align="left"    	width="140"     name="Material Name"	sumtext="Total"	</fc>
			            <c>id="unit"    				Edit="none"   	align="center"  	width="30"     name="<%=columnData.getString("unit") %>"    			</c>
			            <c>id="issueQty"    			Edit="none"   	align="right"  	width="90"     name="<%=columnData.getString("issue_qty") %>"  dec="2"  sumtext="@sum", sumbgcolor="#ECE6DE" sumcolor="#666666"	</c>
			            <c>id="postingDate"  			Edit="none"   	align="center"  	width="85"     name="<%=columnData.getString("posting_date") %>" 	 mask="XXXX/XX/XX" 	</c>
			            <C>id="cancelPostingDate"   name="Cancel Posting;Date"    width="90"  align="center" edit="RealNumeric"       mask="XXXX/XX/XX" editstyle="PopupFix"</C>
			            <c>id="issueLoc"   			    Edit="none"   	align="left"  		width="85"     name="<%=columnData.getString("issue_loc") %>" 		EditStyle="LookUp" 	Data="ds_location:code:name"	</c>
			            <c>id="costCenter"    		    Edit="none"   	align="left"  		width="130"     name="<%=columnData.getString("cost_center") %>" 	EditStyle="LookUp" 	Data="ds_costCenter:code:name:code" ListWidth=250 	show="false"</c>
			            <c>id="intOrder"   		    Edit="none"   	align="left"  		width="130"     name="Internal;Order" show="false"</c>
			            <c>id="intOrderNm"   		    Edit="none"   	align="left"  		width="130"     name="Internal;Order" </c>
			            <c>id="attr2"    	 			Edit="none"   	align="left"    	width="110"     name="<%=columnData.getString("issue_desc") %>" 	</c> 		
			            <c>id="sapDocNo"   			    Edit="none"   	align="center"       width="90"     name="<%=columnData.getString("sap_issue_no") %>"     	</c>
			            <c>id="sapCancelDocNo"   	    Edit="none"   	align="center"       width="95"     name="<%=columnData.getString("sap_cancel_issue_no") %>"     	</c>
			            <c>id="status"    				Edit="none"   	align="left"       width="120"     name="<%=columnData.getString("status") %>"     EditStyle="LookUp" 	Data="ds_statusCode:code:name"		</c>
			            <c>id="sapRtnMsg"   			Edit="none"   	align="left"       width="400"    name="<%=columnData.getString("return_msg") %>"     	</c>
			            
			            								
				'/>
			     </object>
		        </td>
		       </tr>
       	  	 </table>  
  		 </div>
        <!-- 그리드 E -->
        
		 <!-- 버튼 S -->	
          <div id="btn_area">
           	 <p class="b_right">
					<span class="btn_r btn_l">
                    <input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnSapCancel%>" onclick="javascript:f_cancel();"/></span> 
            </p>
        </div>
<!-- 버튼 E -->
</div>
<input type="hidden" id="h_date"/>
</body>
</html>
