<%--
/*
 *************************************************************************
 * @source  : docBarge.jsp
 * @desc    : doc-barge
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2011/08/01   jhj       Init
 * ---  -----------  ----------  -----------------------------------------
 * PT-PAM System.
 * Copyright(c) 2006-2007 LG CNS,  All rights reserved.
 *************************************************************************
 */
--%>

<%@ page import="devon.core.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="blendTrans(Duration=0.0)" http-equiv="Page-Enter" />
<meta content="blendTrans(Duration=0.0)" http-equiv="Page-Exit" />  
<title>Cost Total Ledger Mgnt</title>
<%@ include file="/include/head.jsp" %>

<%
	String prevDate	   = LDateUtils.getDate("yyyy/MM/") +"01"; 
	String currentDate = LDateUtils.getDate("yyyy/MM/dd");          // currentDate

    String msgWarnRetrieve    = source.getMessage("dev.warn.com.retrieve");   		// please first retrieve!
	String msgSave            = source.getMessage("dev.cfm.com.save");    			// Are you sure to save?
	String msgDelete          = source.getMessage("dev.cfm.com.delete");    		// Are you sure to Delete?
    String msgCompDebitCredit = source.getMessage("dev.msg.fi.diffDebitCredit");    // The debit and credit total are not right
    String msgSucProcess      = source.getMessage("dev.suc.com.process");    		// successfully processed.
    String msgNoDataItem      = source.getMessage("dev.warn.com.noDataItem");    	// The selected item does not exist.
    String msgMustReqMode     = source.getMessage("dev.msg.fi.condCheck");    		// The selected condition must be Request Status.
	String msgNoNegativeNum	  = source.getMessage("dev.msg.fi.noNegativeNum");    	// The negative number will not be able to input!
	String msgInfoChange    = source.getMessage("dev.inf.com.nochange");    // no data for change.
	String msgNoDelete      = source.getMessage("dev.inf.com.nodelete"); // no data for deleting.
    
%>

<script type="text/javascript">


//-------------------------------------------------------------------------
// 검색
//-------------------------------------------------------------------------
function f_Retrieve() {
		var condition = "?";
		    	condition += "flag="                			+ "1";
    	    	condition += "&companyCd=<%= g_companyCd %>";
				condition += "&docSeq="+document.all.docSeq.value;
				condition += "&docYm="+removeDash(document.all.docYm.value,"/");        
				condition += "&docDateFrom="+removeDash(document.all.docDateFrom.value,"/");  
				condition += "&docDateTo="+removeDash(document.all.docDateTo.value,"/");    
				condition += "&sapDocSeq="+document.all.sapDocSeq.value;
				condition += "&vendor="+ds_vendor.NameValue(ds_vendor.RowPosition,"code");//document.all.vendor.value                        
				condition += "&postDateFrom="+removeDash(document.all.postDateFrom.value,"/"); 
				condition += "&postDateTo="+removeDash(document.all.postDateTo.value,"/");	 
//	 		alert(condition);
	
		ds_costTotMst.DataID = "fi.ar.retrieveDocBargeList.gau"+condition;
		ds_costTotMst.Reset();
		
}

function f_setData(){ 
	ds_vendor.DataId="cm.cm.retrieveCommComboVendorList.gau";
	ds_vendor.Reset();
	cfUnionBlank(ds_vendor,lc_vendor,"code","name","--Total--"); 	
}

//-------------------------------------------------------------------------
// Page Init
//-------------------------------------------------------------------------
function init(){ 
	f_setData();
}

//-------------------------------------------------------------------------
// 검색
//-------------------------------------------------------------------------



//전표출력
//function f_print(){
 
	    //window.showModalDialog('jsp/po/oc/preView.jsp',window,"dialogWidth:850px,dialogHeight:558px,left=" + (screen.width/2 - 821/2)+ ",top=" + (screen.height/2 - 558/2) +",scrollbars=yes,menubar=0,status=0,toolbar=0,location=0,directories=0,resizable=0")
//    	window.open("jsp/fi/ar/docPrintWebPop.jsp?gubun=p","PreView","width=695,height=300,left=" + (screen.width/2 - 821/2)+ ",top=" + (screen.height/2 - 558/2) +",scrollbars=0,menubar=0,status=0,toolbar=0,location=0,directories=0,resizable=1");   	
//}


function f_excelDown(){

		gr_costTotMst.SetExcelTitle(0, "");
		gr_costTotMst.SetExcelTitle(1, "value:Doc Barge List; font-face:±¼¸²u; font-size:30pt; font-color:black;font-bold; font-underline; bgcolor:white; align:center; line-color:red;line-width:2pt; skiprow:1;");
		//gr_costTotMst.SetExcelTitle(1, "value:(SubTitle); font-face:±¼¸²u; font-size:18pt; font-color:black; bgcolor:#99ffff; align:center; line-color:blue; line-width:1pt; skiprow:1;");
		//gr_costTotMst.SetExcelTitle(1, "value:2003/10/09; font-face:±¼¸²u; font-size:16pt; font-color:black;font-italic; bgcolor:#ff9999; align:right; line-color:red; line-width: 0.5pt; skiprow:2;");
		var lOption = 15;
 
		//alert("GridToExcel옵션값 : " + lOption);
		gr_costTotMst.GridToExcel("Doc_Barge_List", "C:\\Doc_Barge_List.xls", lOption);
//		ds_excelDown.DataID = "fi.ar.retrieveCostTotLedgerMstExcelList.gau"+condition;
//		ds_excelDown.Reset();

}

//-------------------------------------------------------------------------
//Excel Download
//-------------------------------------------------------------------------
function f_excel() {
	//gf_excel(ds_costTotMst,gr_costTotMst,"<%=columnData.getString("sub_title") %>","c:\\");
		ds_costTotMst.GridToExcel("sheet1", "C:\\test.xls", 15);
}

function f_dateValid(obj){
	if(obj.value != "")
		valiDate(obj);
}

</script>

<!-----------------------------------------------------------------------------
  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>


<!-----------------------------------------------------------------------------
    D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-- Grid 용 Master DataSet-->
<object id="ds_costTotMst" 	classid="<%=LGauceId.DATASET%>" >
  <param name="SyncLoad"          value="true">
  <param name="ViewDeletedRow"    value="false">
</object>

<object id="ds_vendor" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/> 
</object> 


<!-----------------------------------------------------------------------------
    G A U C E   C O M P O N E N T' S   E V E N T S
------------------------------------------------------------------------------>
<script language=JavaScript for=ds_costTotMst event=OnLoadStarted()>
  cfHideNoDataMsg(gr_costTotMst);//no data 메시지 숨기기
  cfShowDSWaitMsg(gr_costTotMst);//progress bar 보이기
  mode = "";
</script>

<!-- Hub In Header 조회 DataSet -->
<script language=JavaScript for=ds_costTotMst event=OnLoadCompleted(rowCnt)>
  cfHideDSWaitMsg(gr_costTotMst);//progress bar 숨기기
  cfFillGridNoDataMsg(gr_costTotMst,"gridColLineCnt=2");//no data found   
  mode = "";
  //gr_costTotMst.ColumnProp("deptCd", "SumText") = "Total";
  //gr_costTotMst.ColumnProp("docSeq", "SumText") = "Cnt :"+rowCnt;
  //gr_costTotMst.ColumnProp("amount", "SumText") = "@sum";
  gr_costTotMst.ViewSummary = "1";
  //alert(ds_costTotMst.DataHeader);
</script>



</head>

<body id="cent_bg" onload="init();">

<div id="conts_box">
	<h2> <span><%= columnData.getString("sub_title") %></span></h2>

	<!--검색 S -->	
	 	<fieldset class="boardSearch">
	 	
			<div id="output_board_area">
				<table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board2" >
					<colgroup>
						<col width="13%"/>
						<col width="12%"/>
						<col width="9%"/>
						<col width="12%"/>
						<col width="13%"/>
						<col width="30%"/>
						<col width=""/>
					</colgroup>    
   					<tr>
  						<th><%= columnData.getString("doc_Seq") %></th>
       					<td>
							<input type="text" id="docSeq" 	style="width:70px;" maxlength="60">
 						</td>
						<th><%= columnData.getString("doc_Ym") %></th>
						<td>
							<input type="text" style="width:50px;" name = "docYm" value="<%= LDateUtils.getDate("yyyy/MM")%>" maxlength=7  onkeyPress="if ((event.keyCode<47) || (event.keyCode>57)) event.returnValue=false;"style="ime-mode:disabled" />  
	  						<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="" onclick="javascript:Calendar_M(docYm);" class="button_cal"/> 
						</td>
						<th><%= columnData.getString("doc_Date") %></th>
						<td>
								<input type="text" id="docDateFrom" value="<%= prevDate %>" 		onblur="valiDate(this);" style="width:65px;"/>&nbsp;<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(docDateFrom);" style="cursor:hand"/> ~ 
								<input type="text" id="docDateTo"   value="<%= currentDate %>" 	onblur="valiDate(this);" style="width:65px;"/>&nbsp;<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(docDateTo);" style="cursor:hand"/>
    					</td>
    					<td rowspan="2">
							<dd class="btnseat2" style> 
								<span class="search_btn2_r"><input type="button" onfocus="blur();" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='#e2ebf7'" value="Search" onclick="f_Retrieve();"/></span> 
							</dd>	
    					</td>
					</tr>
   					<tr>
  						<th><%= columnData.getString("sap_Doc_Seq") %></th>
       					<td>
							<input type="text" id="sapDocSeq" 	style="width:70px;" maxlength="70">
						</td>										
						<th><%= columnData.getString("vendor") %></th>
						<td>
								<comment id="__NSID__"><object id="lc_vendor"  classid="<%=LGauceId.LUXECOMBO%>" width="90">
								<param name="ComboDataID"       value="ds_vendor">
								<param name="ListCount"     	value="10">
								<param name=SearchColumn		value="name">
								<param name="BindColumn"    	value="code">
								<param name=ListExprFormat		value="name^0^150,code^0^70"> 
								<param name=index           	value=0>
								</object></comment><script>__WS__(__NSID__); </script>
						</td>
						<th><%= columnData.getString("post_Date") %></th>
       					<td>
								<input type="text" id="postDateFrom" value="<%= prevDate %>" 		onblur="valiDate(this);" style="width:65px;"/>&nbsp;<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(postDateFrom);" style="cursor:hand"/> ~ 
								<input type="text" id="postDateTo"   value="<%= currentDate %>" 	onblur="valiDate(this);" style="width:65px;"/>&nbsp;<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(postDateTo);" style="cursor:hand"/>
	  					</td>	
					</tr>
  				</table>
			</div>
	 	
	 </fieldset>
      <!--검색 E -->

	<div class="sub_stitle"> 
		<p> <%=columnData.getString("sub_title") %> </p>
		<p class="rightbtn">		
			<span class="excel_btn_r excel_btn_l">
             <input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="<%=btnExcelDown %>" onclick="f_excelDown()"/>
             </span>   
		</p>			
	</div>   	

	<!-- 그리드 S -->	
    <div>
	<object id="gr_costTotMst" classid="<%=LGauceId.GRID %>" style="width:100%;height:370px;" class="comn"
		dataName="Cost Total Ledger Mst"
	    validFeatures="ignoreStatus=no"
		validExp="">
		<param Name="DataID" 			value='ds_costTotMst'>
	    <Param name="AutoResizing"      value=true>
	    <param name="ColSizing"         value=true>
	    <Param name="DragDropEnable"    value=True>
	    <param name="AddSelectRows"     value=True>
	    <Param name="SortView"          value="right">
	    <param name="Editable"          value=True>
	    <param name="UsingOneClick"     value=1>
        <param name=ViewSummary         value="1">
		<param Name='Format'
			value='
           		<C> id=seq         				name="<%= columnData.getString("seq") %>"       	 	            align="center"   width="30"    Edit="none"   show="true"  suppress=3 </C>
                <C> id=companyCd   		name="<%= columnData.getString("company_Cd") %>"     	align="center"   width="80"    Edit="none"   show="false" suppress=3</C>
                <C> id=deptCd            	name="<%= columnData.getString("dept_Cd") %>"     		 	align="center"   width="60"    Edit="none"   show="false"  suppress=3</C>
                <C> id=docYm      			name="<%= columnData.getString("doc_Ym") %>"     		 	align="center"   width="55"    Edit="none"   show="true" suppress=3  Mask="XXXX/XX"</C>
                <C> id=docSeq      			name="<%= columnData.getString("doc_Seq") %>"     	     	align="center"   width="70"    Edit="none"   show="true" suppress=3</C>
                <C> id=sapDocSeq       	name="<%= columnData.getString("sap_Doc_Seq") %>"     	align="center"   width="80"    Edit="none"   show="true"  suppress=3</C>
                <C> id=docDate      		name="<%= columnData.getString("doc_Date") %>"     		align="center"   width="80"    Edit="none"   show="true"   suppress=3</C>
                <C> id=postDate      		name="<%= columnData.getString("post_Date") %>"     		align="center"   width="80"    Edit="none"   show="true" suppress=3</C>
                <C> id=amount  				name="<%= columnData.getString("amount") %>"     	 		align="right"      width="100"    Edit="none"   show="true"    suppress=3 sumbgcolor="#ECE6DE" sumcolor="#666666" DisplayFormat ="#,###.00" </C>
                <C> id=currencyCd     	name="<%= columnData.getString("currency_Cd") %>"     	align="center"   width="45"    Edit="none"   show="true"  suppress=3 </C>
                <C> id=vendor  				name="<%= columnData.getString("vendor") %>"     	 			align="left"         width="130"    Edit="none"   show="true"  suppress=3  EditStyle="LookUp" 	Data="ds_vendor:Code:NAME"</C>
                <C> id=seq2         			name="<%= columnData.getString("seq") %>"     					align="center"   width="30"    Edit="none"   show="true" </C>
                <C> id=syskey 				name="<%= columnData.getString("syskey") %>"      		 	align="center"   width="90"    Edit="none"  show="true" </C>
                <C> id=mvCd   				name="<%= columnData.getString("mv_Cd") %>"     	 			align="center"   width="78"   Edit="none"   show="true" </C>
                <C> id=bargeSeq  			name="<%= columnData.getString("barge_Seq") %>" 			align="center"   width="80"   Edit="none"   show="true" </C>
                <C> id=bargeCd  			name="<%= columnData.getString("barge_Cd") %>"     	 	align="center"   width="80"    Edit="none"   show="true"</C>
                <C> id=bargePostDate  name="<%= columnData.getString("post_Date") %>"     	      align="center" width="80"    Edit="none"   show="true"  Mask="XXXX/XX/XX"</C>
                <C> id=mvArrivalDate   name="<%= columnData.getString("mv_Arrival_Date") %>" align="center" width="80"    Edit="none"   show="true"  Mask="XXXX/XX/XX"</C>
                <C> id=loadingQty 			name="<%= columnData.getString("loading_Qty") %>"       	  align="right"    width="115"    Edit="none"   show="true" </C>
	      '>
	</object>
 	</div>
        
    

<!--script src="/debug_utf8.js"></script-->

        	  
</div>
<input type="hidden" id="h_date"/>
</body>
</html>
