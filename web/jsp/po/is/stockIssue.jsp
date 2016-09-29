<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--
/*
 *************************************************************************
 * @source  : stockIssue.jsp
 * @desc    : 재고자산 출고등록
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2010.08.09   최용락       신규작성
 * 1.1  2010.08.25   임민수       수정
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
	
	String currentDate = LDateUtils.getDate("yyyy/MM/dd");          // currentDate
%>

<link rel="stylesheet" type="text/css" href="../sys/css/common.css" />
<link rel="stylesheet" type="text/css" href="../sys/css/sub_style.css" />
</head>
<script type="text/javascript">
parent.centerFrame.cols='220,*';
//-------------------------------------------------------------------------
//콤보박스
//-------------------------------------------------------------------------					
function init(){

	//저장소
	ds_location.DataId="/cm.cm.retrieveCommCodeCombo.gau?groupCd=2005&attr2Loc=MS";
	ds_location.Reset();
	
	//품목
	ds_mater.DataId="po.oc.retrievePurchOrderRegMaterCombo.gau?firstVal=Total";
	ds_mater.Reset();

	//vendor
	//ds_vendor.DataId="cm.cm.retrieveCommComboVendorList.gau";
	//ds_vendor.Reset();
	
	ds_vendor.DataId="cm.cm.retrieveCostPriceCodeCombo.gau?firstVal=Total";
	ds_vendor.Reset();
    
	//cost Center
	ds_costCenter.DataId="cm.cm.retrieveCommComboCostCenterList.gau?postDate=" + removeDash(document.all.postingdate.value,"/");
	ds_costCenter.Reset();
				
				    
}

function retrieveCostCenter(){
	//cost Center
	ds_costCenter.DataId="cm.cm.retrieveCommComboCostCenterList.gau?postDate=" + removeDash(document.all.postingdate.value,"/");
	ds_costCenter.Reset();

}

//-------------------------------------------------------------------------
// 검색 버튼 클릭시 재고 조회
//-------------------------------------------------------------------------		
function f_search() {
 
	
	var param = "";

	param += "issue_loc=" + ds_location.nameValue(ds_location.rowPosition,"code");
	param += "&materCd=" + ds_mater.nameValue(ds_mater.rowPosition,"materCd");

	ds_grid.DataID = "/rfc.cmd.retrieveStockIssueList.gau?"+param;
	ds_grid.Reset();
	ds_grid.redraw=false;
	
	/*
	var cnt = ds_grid.CountRow;
	for(var i=0; i<=ds_grid.CountRow; i++){
		if( "" == ds_grid.NameValue(i, "costCenter")){
			ds_grid.NameValue(i, "costCenter") = "11100";
		} 
	}
	*/
	
	ds_grid.redraw=true;
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
	//2014 데이터 입력 불가 처리(결산기간)  
	var postDt = document.all.postingdate.value;
	if(f_forbidBeforeDate('2014/01/01',postDt,'PostDate') == false ){
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
		alert("<%=source.getMessage("dev.warn.com.chkHeaderCount")%>");
		return;
	}

	var issueDate = document.all.issueDate.value;
	var postingdate = document.all.postingdate.value;
	
	if(issueDate == ""){
		alert('<%=source.getMessage("dev.warn.com.required", "Issue Date" ) %>');
		document.all.issueDate.focus();
		return;		
	}
	if(postingdate == ""){
		alert('<%=source.getMessage("dev.warn.com.required", "Posting Date" ) %>' );
		document.all.postingdate.focus();
		return;		
	}
	
	if( issueDate > postingdate){
		alert("<%=source.getMessage("dev.msg.po.issueDateCheck")%>");
		return;
	}
	
 	if(!ds_grid.IsUpdated ) {
		alert( '<%=source.getMessage("dev.inf.com.nochange" ) %>' );
		return;
	}
	
	
	for(var i=1;i<=ds_grid.CountRow;i++){
		if(ds_grid.NameValue(i,"chk") == "F")     // 체크되지 않으면 무시함
			continue;
			
		if(ds_grid.RowStatus(i) != 0 && ds_grid.NameValue(i,"issueQty")==""){
			ds_grid.RowPosition=i;
			alert('<%=source.getMessage("dev.warn.com.required", "Issue Qty" ) %>' );
			gr_grid.SetColumn("issueQty");
			return;
		<%--
		}else if(ds_grid.RowStatus(i) != 0 && ds_grid.NameValue(i,"costCenter")==""){
			ds_grid.RowPosition=i;
			alert('<%=source.getMessage("dev.warn.com.required", "Cost Center" ) %>' );
			gr_grid.SetColumn("costCenter");
			return;
		--%>
		
		//Description 필수 여부 삭제
		/*
		}
		else if(ds_grid.RowStatus(i) != 0 && ds_grid.NameValue(i,"attr1")=="" && ds_grid.NameValue(i,"attr2")==""){
			ds_grid.RowPosition=i;
			alert('<%=source.getMessage("dev.warn.com.required", "Description" ) %>' );
			gr_grid.SetColumn("attr2");
			return;
		*/
		
		}else 	if(ds_grid.RowStatus(i) != 0 && ds_grid.NameValue(i,"issueQty")=="0"){
			ds_grid.RowPosition=i;
			alert('<%=source.getMessage("dev.msg.ps.greaterZero", "issueQty" ) %>'  );     
			gr_grid.SetColumn("issueQty");
			return;
		}else 	if(ds_grid.RowStatus(i) != 0 && ds_grid.NameValue(i,"LABST") < ds_grid.NameValue(i,"issueQty")){
			ds_grid.RowPosition=i;
			alert("<%=source.getMessage("dev.msg.po.biggerIssue")%>");
			gr_grid.SetColumn("issueQty");       
			return;
		}
		
		//Data 저장/수정 시 - Cost Center, I/O 필드 정보 중 하나의 정보만 저장/수정 가능
		var center = ds_grid.NameValue(i,"costCenter");
		var intOrder = ds_grid.NameValue(i,"intOrder");
		
		if (ds_grid.RowStatus(i) != 0 &&  center == "" && intOrder == "") {
			alert('<%=source.getMessage("dev.warn.com.inputIoCost")%>');			
			ds_grid.RowPosition = i;
			ds_grid.SetColumn("costCenter");
			return;
		}
		
		if (ds_grid.RowStatus(i) != 0 &&  center != "" && intOrder != "") {
			alert('<%=source.getMessage("dev.warn.com.chooseIoCost")%>');
			ds_grid.RowPosition = i;
			ds_grid.SetColumn("costCenter");
			return;
		}
			
			
	}
	
	
	//To Do 저장 validation check
	
	//변경한 데이터가 있는지 체크한다.
	if(confirm('<%=source.getMessage("dev.cfm.com.save") %>')){
		
		var param = "";

		param += "issueLoc=" + ds_location.nameValue(ds_location.rowPosition,"code");
		param += "&issueDate=" + removeDash(issueDate, "/");
		param += "&postingDate=" + removeDash(postingdate, "/");
		
		tr_master.KeyValue = "Servlet(I:IN_DS1=ds_grid)";
		tr_master.Action   = "/po.is.cudStockIssueList.gau?"+param;
		tr_master.post();
	}
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

<!-- lx Combo 용 DataSet-->
<object id="ds_mater" classid="<%=LGauceId.DATASET%>" >
  	<param name="SyncLoad"          value="true"> 
</object>

<!-- costCenter 용 DataSet-->
<object id="ds_costCenter" classid="<%=LGauceId.DATASET%>" >
  	<param name="SyncLoad"          value="true"> 
</object>

<!-- TM/TBM lx Combo 용 DataSet-->
<object id="ds_vendor" classid="<%=LGauceId.DATASET%>" >
  	<param name="SyncLoad"          value="false"> 
</object>

<!-- 표준 공통  검색조건 파라메타   DataSet -->
<object id="ds_param" classid="<%=LGauceId.DATASET%>"> </object>

<%----------------------------------------------------------------------------------------------------
 Gauce obj  event  정의
------------------------------------------------------------------------------------------------------%>
<script language=JavaScript for="ds_statusCode" event=OnRowPosChanged(row)>
		ds_grid.nameValue(ds_grid.rowPosition,"detailDeptCd") =ds_statusCode.nameValue(ds_statusCode.rowPosition,"detailDeptCd");
</script>

<script language=JavaScript for=ds_grid event=OnLoadCompleted(rowCnt)>
    	//alert(rowCnt);
</script>

<!-- Hub In Header 조회 DataSet -->
<script language=JavaScript for=ds_grid event=OnLoadCompleted(rowCnt)>
  cfFillGridNoDataMsg(gr_grid,"gridColLineCnt=2");//no data found   
</script>

<script language=JavaScript for=ds_grid event=OnLoadCompleted(rowCnt)>
  cfFillGridNoDataMsg(gr_grid,"gridColLineCnt=2");//no data found   
  
     gr_grid.ColumnProp("materCd", "SumText") = "Total";
	 gr_grid.columnProp("LABST", "SumText") = "@sum";
	 gr_grid.columnProp("issueQty", "SumText") = "@sum";
	 gr_grid.ViewSummary = "1";
  
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

<script language=JavaScript for=ds_mater event=OnLoadCompleted(rowCnt)>
	//cfUnionBlank(ds_mater,lc_mater,"materCd","materNm");
</script>

<script language=JavaScript for=ds_vendor event=OnLoadCompleted(rowCnt)>
	cfUnionBlank(ds_vendor,lc_mater,"code","name");
</script>

<script language=JavaScript for=gr_grid event=OnExit(row,colid,olddata)>
	if(ds_grid.NameValue(ds_grid.RowPosition,colid) != olddata ){
		ds_grid.NameValue(ds_grid.RowPosition,"chk") = "T";	
	}
</script>

<script language=JavaScript for=gr_grid event=OnPopup(row,colid,data)>
  if ( colid == "intOrderNm") {
	  openInternalOrderCodeListGridWin(row, ds_grid, "intOrder", "intOrderNm");
  }
</script>

<script language=JavaScript for= lc_mater event=OnKeyDown(kcode)>
    if(kcode != 8 && kcode != 13 && kcode != 27 && kcode != 33 && kcode != 34 && kcode != 35 &&
        kcode != 36 && kcode != 37 && kcode != 38 && kcode != 39 && kcode != 40 && kcode != 45 &&
        kcode != 46 && kcode != "undefined") {	
    		setTimeout("On_Apply()", 1000);
   		}
</script>

<body id="cent_bg" onload="init();">
<div id="conts_box">
	<h2><span><%= columnData.getString("page_title") %></span></h2>
	 <!-- 검색 S -->
 
		 <fieldset class="boardSearch">
				<div>
					 <dl>
						<dt> 
							<table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board2" >
									<colgroup>
											<col width="20%"/>
											<col width="25%"/>
											<col width="15%"/>
											<col width=""/>
									  </colgroup>
										<tr>											
											<th><%= columnData.getString("issue_loc") %> </th>
											<td><comment id="__NSID__"><object id="issue_loc"  classid="<%=LGauceId.LUXECOMBO%>" width="150">
												    <param name="ComboDataID"       value="ds_location">
													<param name="ListCount"     	value="10">
													<param name=SearchColumn		value="name">
													<param name="BindColumn"    	value="code">
												    <param name=ListExprFormat		value="name^0^90,code^0^70">
												    <param name=index           	value=0>
											   	</object></comment><script>__WS__(__NSID__); </script></td>								
											<th><%= columnData.getString("mater") %> </th>
											<td><comment id="__NSID__"><object id="lc_mater"  classid="<%=LGauceId.LUXECOMBO%>" width="180">
											    <param name="ComboDataID"       value="ds_mater">
												<param name="ListCount"     	value="10">
												<param name=SearchColumn		value="materNm">
												<param name="BindColumn"    	value="materCd">
											    <param name=ListExprFormat		value="materNm^0^180,materCd^0^70">
											    <param name=index           	value=0>
											    <param name=ComboStyle  value="2">											    
											    <param name=WantSelChgEvent	value=true>	
											</object></comment><script>__WS__(__NSID__); </script></td>
										</tr>
								</table>
						 </dt>  
						      		  	   	 	
						 <dd class="btnseat1"> 
						 	 <span class="search_btn_r search_btn_l">
                  			 <input type="button" onfocus="blur();" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='#e2ebf7'" value="<%=btnSearch %>" onclick="javascript:f_search();"/></span> 
						 </dd>											
					</dl>
				</div>
			</fieldset>
  
      <!-- 검색 E -->
		<div class="sub_stitle"> <p><%= columnData.getString("title_sub3") %></p> </div>      	
	<!-- 그리드 S -->	
        <div id="output_board_area">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board" >
                <colgroup>
                        <col width="15%"/>
                        <col width=""/>
              </colgroup>
                     <tr>
                        <th><%= columnData.getString("issue_date") %></th>
                        <td><input id="issueDate" name="issueDate"  type="text" onblur="valiDate(this);" style="width:70px;" onpropertychange="document.all.postingdate.value = document.all.issueDate.value;" value="<%= currentDate %>" /> <img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(issueDate);" style="cursor:hand"/>  </td>
                        
                        <th><%= columnData.getString("posting_date") %></th>
                        <td><input id="postingdate" name="postingdate" type="text" onblur="valiDate(this);" style="width:70px;" value="<%= currentDate %>" onpropertychange="retrieveCostCenter()"  /> <img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(postingdate);" style="cursor:hand"/>  </td>
                        
					</tr>   
            </table>
		</div>
      <!-- 그리드 E 
		<div class="sub_stitle"> <p><%= columnData.getString("title_sub2") %> </p> </div>      	
		-->		
		<br/> 		
		<!-- 그리드 S -->	
       <div id="n_board_area">
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="100%"><object
				id="gr_grid" classid="<%=LGauceId.GRID%>" class="comn" width="100%"
				height="280px" class="B_list">
				<param name="DataID" value="ds_grid"/>
				<param name="BorderStyle" value="2"/>
				<param name="RowHeight" value="20"/>
				<param name="IndWidth" value="15"/>
				<param name="Enable" value="TRUE"/>
				<param name="Editable" value="TRUE"/>
				<param name="ColSizing" value="true"/>
				<param name="ViewDeletedRow" value="true"/>
				<param name="DragDropEnable" value="true"/>
				<param name="DisableNoHScroll" value="true"/>
				<param name="SortView" value="Left"/>
				<param name="UsingOneClick"		value="1"/>
				<param name="ColSelect"  value="true"/>
				<Param name="AutoResizing"      value=true>
				<param name="ToolTip"
					value="use=true;header=true;alt=false;createtime=500;fontsize=9;color=#0f0f0f;edgecolor=green;"/>
	           
				<param name="Format"
					value='
						<fc>id="chk"			Edit="true"       width="30"	  EditStyle=CheckBox	</fc>
			            <fc>id="materCd"    	Edit="none"		align="center"  	width="90"     name="<%=columnData.getString("mater_cd") %>" 	   	</fc> 
			            <fc>id="MAKTX"      Edit="none"  	align="left"    	width="150"     name="<%=columnData.getString("mater_nm") %>"		</fc>
			            <fc>id="MEINS"    	Edit="none"   	align="center"  	width="40"     name="<%=columnData.getString("unit") %>"    	</fc>
			            <fc>id="LABST"    	Edit="none"   	align="right"  		width="90"     name="<%=columnData.getString("curr_qty") %>"  dec="2"  	</fc>
			            <c>id="issueQty"   Edit="true"   	align="right"  		width="80"     name="<%=columnData.getString("issue_qty") %>" 	dec="2"	</c>
			            <c>id="costCenter"    	Edit="true"   	align="left"  		width="200"     name="<%=columnData.getString("cost_center") %>" 	EditStyle="LookUp" 	 Searchlookup=true  Data="ds_costCenter:code:name:code" ListWidth=230 show="false"</c>
                  <c>id=intOrder       name="Internal Order"     	      align="center"  width="70"  show="false"  </c>
                  <c>id=intOrderNm     name="Internal Order"     	      align="left"  width="160"   Edit="AlphaNum"    show="true"   EditStyle=PopupFix  </c>
			            <c>id="attr1"    	show="false" Edit="true"   	align="left"  		width="140"     name="<%=columnData.getString("vendor") %>" 	 EditStyle="LookUp" 	Data="ds_vendor:code:name:code"	ListWidth=270  	</c>
			            <c>id="attr2"    	Edit="true"   	align="left"  		width="120"     name="<%=columnData.getString("issue_desc") %>" 		</c>
			            
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
                    <input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnSave%>" onclick="javascript:f_save();"/></span> 
            </p>
        </div>
<!-- 버튼 E -->
</div>
</body>
</html>
