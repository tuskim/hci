<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html xmlns="http://www.w3.org/1999/xhtml">
<%--
/*
 *************************************************************************
 * @source  : statementOfAccounts.jsp
 * @desc    : 월마감 결산 레포트
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2011.04.06   강수연    신규작성
 * ---  -----------  ----------  -----------------------------------------
 * PT-PAM 시스템
 * Copyright(c) 2006-2007 LG CNS,  All rights reserved.
 *************************************************************************
 */
--%> 
<%@ page import = "java.util.*" %>
<%@ page import = "java.lang.*" %>
<%@ page import="devon.core.util.*"%>
<%@ page import="comm.util.*" %>
<%@ include file="/include/head.jsp"%>
<%
	String prevDate	       = LDateUtils.getDate("yyyy/MM/") +"01"; 		 //조회시작 default 날짜
	String currentDate     = LDateUtils.getDate("yyyy/MM/dd");         	 //조회조건 현재 날짜	
	
	//조회조건 2달전날짜
	String docDate;
	if(Integer.parseInt(LDateUtils.getDate("MM"))==1){ 			 		//1월 ->11월
		docDate=Integer.parseInt(LDateUtils.getDate("yyyy"))-2 +"/11/01"; 
	}else if(Integer.parseInt(LDateUtils.getDate("MM"))==2){ 			//2월 ->12월
		docDate=Integer.parseInt(LDateUtils.getDate("yyyy"))-2 +"/12/01";  
	}else if(Integer.parseInt(LDateUtils.getDate("MM"))==12){			//12월->10월
		docDate=LDateUtils.getDate("yyyy/")+ (Integer.parseInt(LDateUtils.getDate("MM")) -2) +"/01"; 
	}else{																	
		docDate=LDateUtils.getDate("yyyy/0")+ (Integer.parseInt(LDateUtils.getDate("MM")) -2) +"/01"; 
	}
	
%>
<html>
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />  
<title>PIT PAM System</title> 
<head>

<script language="javascript">
var g_flug =false; // Detail작업 flag
var g_main3flag =true; // Detail작업 flag
var g_delFlag =false; // Detail작업 flag

//-------------------------------------------------------------------------
// 조회
//-------------------------------------------------------------------------
function onLoad(){
	//cost Center
	ds_costCenter.DataId="cm.cm.retrieveCommComboCostCenterList.gau?";
	ds_costCenter.Reset();

}

//전표 상태별 건수조회
function f_retrieve(){
	ds_main1.DataID  = "/fi.ar.retrieveDocClosingList.gau?";
    ds_main1.DataID += "deptCd=" 	  + ds_deptCd.nameValue(ds_deptCd.rowPosition,"code");
    ds_main1.DataID += "&docDateTo="   + encodeURIComponent(funcReplaceStrAll(docDateTo.value,"/",""));
    ds_main1.DataID += "&docDateFrom=" + encodeURIComponent(funcReplaceStrAll(docDateFrom.value,"/",""));
    ds_main1.DataID += "&postDateTo="  + encodeURIComponent(funcReplaceStrAll(postDateTo.value,"/",""));
    ds_main1.DataID += "&postDateFrom="+ encodeURIComponent(funcReplaceStrAll(postDateFrom.value,"/",""));
 	ds_main1.DataID += "&lang="		  +"<%=g_lang%>";	
	ds_main1.Reset();
	
	f_retrieve2();
	f_retrieve3();
	f_retrieve4();
	f_retrieve5();
	f_retrieve6();
}
//전표리스트 조회
function f_retrieve2(){
	ds_main2.DataID  = "/fi.ar.retrievestatementOfAccounts.gau?";
    ds_main2.DataID += "deptCd=" 	  + ds_deptCd.nameValue(ds_deptCd.rowPosition,"code");
    ds_main2.DataID += "&docDateTo="   + encodeURIComponent(funcReplaceStrAll(docDateTo.value,"/",""));
    ds_main2.DataID += "&docDateFrom=" + encodeURIComponent(funcReplaceStrAll(docDateFrom.value,"/",""));
    ds_main2.DataID += "&postDateTo="  + encodeURIComponent(funcReplaceStrAll(postDateTo.value,"/",""));
    ds_main2.DataID += "&postDateFrom="+ encodeURIComponent(funcReplaceStrAll(postDateFrom.value,"/",""));
 	ds_main2.DataID += "&lang="		  +"<%=g_lang%>";	
	ds_main2.Reset();
}

//PO 및 입고내역 조회
function f_retrieve3(){
	ds_main3.DataID  = "/fi.ar.retrievePoClosingList.gau?";
    ds_main3.DataID += "deptCd=" 	  + ds_deptCd.nameValue(ds_deptCd.rowPosition,"code");
    ds_main3.DataID += "&docDateTo="   + encodeURIComponent(funcReplaceStrAll(docDateTo.value,"/",""));
    ds_main3.DataID += "&docDateFrom=" + encodeURIComponent(funcReplaceStrAll(docDateFrom.value,"/",""));
    ds_main3.DataID += "&postDateTo="  + encodeURIComponent(funcReplaceStrAll(postDateTo.value,"/",""));
    ds_main3.DataID += "&postDateFrom="+ encodeURIComponent(funcReplaceStrAll(postDateFrom.value,"/",""));
 	ds_main3.DataID += "&lang="		  +"<%=g_lang%>";	
	ds_main3.Reset();
}

//입출고, 생산판매 수량조회
function f_retrieve4(){
	ds_main4.DataID  = "/fi.ar.retrieveQtyClosing.gau?";
    ds_main4.DataID += "deptCd=" 	  + ds_deptCd.nameValue(ds_deptCd.rowPosition,"code");
    ds_main4.DataID += "&docDateTo="   + encodeURIComponent(funcReplaceStrAll(docDateTo.value,"/",""));
    ds_main4.DataID += "&docDateFrom=" + encodeURIComponent(funcReplaceStrAll(docDateFrom.value,"/",""));
    ds_main4.DataID += "&postDateTo="  + encodeURIComponent(funcReplaceStrAll(postDateTo.value,"/",""));
    ds_main4.DataID += "&postDateFrom="+ encodeURIComponent(funcReplaceStrAll(postDateFrom.value,"/",""));
 	ds_main4.DataID += "&lang="		  +"<%=g_lang%>";	
	ds_main4.Reset();
}

//출고내역 조회
function f_retrieve5(){
	ds_main5.DataID  = "/fi.ar.retrieveIssueClosing.gau?";
    ds_main5.DataID += "deptCd=" 	  + ds_deptCd.nameValue(ds_deptCd.rowPosition,"code");
    ds_main5.DataID += "&docDateTo="   + encodeURIComponent(funcReplaceStrAll(docDateTo.value,"/",""));
    ds_main5.DataID += "&docDateFrom=" + encodeURIComponent(funcReplaceStrAll(docDateFrom.value,"/",""));
    ds_main5.DataID += "&postDateTo="  + encodeURIComponent(funcReplaceStrAll(postDateTo.value,"/",""));
    ds_main5.DataID += "&postDateFrom="+ encodeURIComponent(funcReplaceStrAll(postDateFrom.value,"/",""));
 	ds_main5.DataID += "&lang="		  +"<%=g_lang%>";	
	ds_main5.Reset();
}

//석탄생산내역 조회
function f_retrieve6(){
	ds_main6.DataID  = "/fi.ar.retrieveCoalProdClosing.gau?";
    ds_main6.DataID += "deptCd=" 	  + ds_deptCd.nameValue(ds_deptCd.rowPosition,"code");
    ds_main6.DataID += "&postDateTo="  + encodeURIComponent(funcReplaceStrAll(postDateTo.value,"/",""));
    ds_main6.DataID += "&postDateFrom="+ encodeURIComponent(funcReplaceStrAll(postDateFrom.value,"/",""));
 	ds_main6.DataID += "&lang="		  +"<%=g_lang%>";	
	ds_main6.Reset();
}
//-------------------------------------------------------------------------
// excel
//-------------------------------------------------------------------------					   
//전표리스트
function f_excel() {
	if(ds_main2.CountRow > 0) {
		var v_shtName = "Document Closing List";
	    var v_path = "c\\";
	    var v_fileName = v_path+v_shtName+".xls";  
		gd_main2.SetExcelTitle(0, "");
		gd_main2.SetExcelTitle(1, "value:")
	    gd_main2.SetExcelTitle(1, "value:Document Closing List " + "; font-face:Book Antiqua; font-size:11pt;font-underline; font-color:black;font-bold; bgcolor:white; align:center;line-width:1pt; skiprow:0;")
	    gd_main2.SetExcelTitle(1, "value:")
		gd_main2.GridToExcel(v_shtName, v_fileName, 1);
	} else {
		alert("No Data.");
	}
		
}

//PO 및 입고내역
function f_excel2() {
	if(ds_main3.CountRow > 0) {
		var v_shtName = "P/O & Receipt List";
	    var v_path = "c\\";
	    var v_fileName = v_path+v_shtName+".xls";
   
		gd_main3.SetExcelTitle(0, "");
		gd_main3.SetExcelTitle(1, "value:")
	    gd_main3.SetExcelTitle(1, "value:P/O & Receipt List " + "; font-face:Book Antiqua; font-size:11pt;font-underline; font-color:black;font-bold; bgcolor:white; align:center;line-width:1pt; skiprow:0;")
	    gd_main3.SetExcelTitle(1, "value:")
		gd_main3.GridToExcel(v_shtName, v_fileName, 1);
	} else {
		alert("No Data.");
	}
}

//출고내역
function f_excel3() {
	if(ds_main5.CountRow > 0) {
		var v_shtName = "Issue List";
	    var v_path = "c\\";
	    var v_fileName = v_path+v_shtName+".xls";
   
		gd_main5.SetExcelTitle(0, "");
		gd_main5.SetExcelTitle(1, "value:")
	    gd_main5.SetExcelTitle(1, "value:Issue List " + "; font-face:Book Antiqua; font-size:11pt;font-underline; font-color:black;font-bold; bgcolor:white; align:center;line-width:1pt; skiprow:0;")
	    gd_main5.SetExcelTitle(1, "value:")
		gd_main5.GridToExcel(v_shtName, v_fileName, 1);
	} else {
		alert("No Data.");
	}
}
	
//석탄 생산내역
function f_excel4() {
	if(ds_main6.CountRow > 0) {
		var v_shtName = "Coal Prod List";
	    var v_path = "c\\";
	    var v_fileName = v_path+v_shtName+".xls";
   
		gd_main6.SetExcelTitle(0, "");
		gd_main6.SetExcelTitle(1, "value:")
	    gd_main6.SetExcelTitle(1, "value:Issue List " + "; font-face:Book Antiqua; font-size:11pt;font-underline; font-color:black;font-bold; bgcolor:white; align:center;line-width:1pt; skiprow:0;")
	    gd_main6.SetExcelTitle(1, "value:")
		gd_main6.GridToExcel(v_shtName, v_fileName, 1);
	} else {
		alert("No Data.");
	}				
}



function f_createFile(){
	<%
			String fileDate     = LDateUtils.getDate("yyyyMMddhhmmss");         	 //파일생성 일시	
	%>
		
    var filename = "C:\\Statement_of_accounts"+'<%=fileDate%>'+".xls";

	var j =0;
	var mainMail = "";
	for(var i=1;i<=ds_approval.CountRow;i++){ 
		if(ds_approval.NameValue(i,"chk")=="T"){
			if(ds_approval.NameValue(i, "emailAddr") != ""){
			alert(ds_approval.NameValue(i, "emailAddr"));
				mainMail = ds_approval.NameValue(i, "emailAddr")+",";
			}
		}
	} 
	

	if(mainMail == ""){
		alert("<%=source.getMessage("dev.msg.po.transfer")%>");
		return;
	}
	if(filename == ""){
		alert("<%=source.getMessage("dev.msg.po.transfer")%>");
		return;
	}
	gd_main6.GridToExcel("Coal Prod Closing"	, filename, 44); // 석탄생산 내역
	gd_main5.GridToExcel("Fuel issue List "		, filename, 44); // 출고 내역
	gd_main3.GridToExcel("P_O_Receipt List"	, filename, 44); // P/O 및 입고내역
	gd_main4.GridToExcel("Fuel_Coal Qty"			, filename, 44); // 수량
	gd_main2.GridToExcel("Doc List"					, filename, 44); // 전표리스트
	gd_main1.GridToExcel("Number of Docs"		, filename, 44); // 전표갯수
		
	var frm = document.fileForm;
	frm.filename.value = filename;
	frm.mainMail.value = mainMail;
	
	
	ds_approval.DataID  = "/fi.ar.cudStatementOfAccountsSendMail.gau?";
    ds_approval.DataID += "filename=" 	  + filename;
    ds_approval.DataID += "&mainMail="  + mainMail;
    ds_approval.DataID += "&totalDocs="          + ds_main1.nameValue(1,"statusAll");
    ds_approval.DataID += "&insert="                 + ds_main1.nameValue(1,"status10");
    ds_approval.DataID += "&confirm="              + ds_main1.nameValue(1,"status20");
    ds_approval.DataID += "&sapSended="        + ds_main1.nameValue(1,"status30");
    ds_approval.DataID += "&returnSap="          + ds_main1.nameValue(1,"status40");
    ds_approval.DataID += "&cancelRequest="  + ds_main1.nameValue(1,"status50");
    ds_approval.DataID += "&posting="               + ds_main1.nameValue(1,"status90");
	ds_approval.DataID += "&title="               + "MGE"+'<%=LDateUtils.getDate("MM")%>'+"월 마감내역";
    ds_approval.DataID += "&receiptQty="               + ds_main4.nameValue(1,"receiptQty");
    ds_approval.DataID += "&issueQty="                  + ds_main4.nameValue(1,"issueQty");
    ds_approval.DataID += "&colProdQty="               + ds_main4.nameValue(1,"coalProdQty");
	ds_approval.Reset();


}


//Mail 전송
function f_mailSend(){   
//	if(ds_main.NameValue(ds_main.RowPosition,"pstatus")!="03"){
//		alert("<%=source.getMessage("dev.msg.po.transfer")%>");
//		return;
//	}
	
//	if((ds_main.IsUpdated) || ds_detail.IsUpdated || ds_approval.IsUpdated){
//		alert("<%=source.getMessage("dev.warn.com.continue")%>");
//		return;			 
//
//	} 	

//	if(ds_approval.CountRow==0){
//		alert("<%=source.getMessage("dev.msg.po.sendlist")%>");
//		return;
//	}
//	if(ds_approval.NameValue(1,"mainYn")=="F"){
//		alert("<%=source.getMessage("dev.msg.po.savecontinue")%>");
//		return;
//	}	
	
	var j =0;
	var mainMail = "";
	for(var i=1;i<=ds_approval.CountRow;i++){ 
	
		mainMail = ds_approval.NameValue(i, "emailAddr")+",";
		if(ds_approval.NameValue(i,"chk")=="T"){
			j++;
			if(j>1){
				continue;
			}
		}
	} 
	
	if(j==0){
		alert("<%=source.getMessage("dev.msg.po.sendlist")%>");
		return;		 
   	}
	    //window.showModalDialog('jsp/po/oc/preView.jsp',window,"dialogWidth:850px,dialogHeight:558px,left=" + (screen.width/2 - 821/2)+ ",top=" + (screen.height/2 - 558/2) +",scrollbars=yes,menubar=0,status=0,toolbar=0,location=0,directories=0,resizable=0")
    	window.open("jsp/po/oc/purchOrderRegPreView.jsp?gubun=s","PreView","width=842,height=558,left=" + (screen.width/2 - 821/2)+ ",top=" + (screen.height/2 - 558/2) +",scrollbars=yes,menubar=0,status=0,toolbar=0,location=0,directories=0,resizable=0");   	
} 

// Vendor App Add
function f_addRowApp(){ 
	if(ds_main1.CountRow==0){
		alert("<%=source.getMessage("dev.warn.com.continue")%>");
		return;
	}
	
	if(ds_approval.CountRow<1){
		var strHeader = "chk"          + ":STRING(1)" 
						+",companyCd"  + ":STRING(4)"
						+",vendCd"     + ":STRING(50)"
						+",vendType"   + ":STRING(50)"						
						+",vendSeq"    + ":STRING(4)"
						+",vendPerson" + ":STRING(50)" 
						+",emailAddr"  + ":STRING(50)"
						+",telNo"      + ":STRING(20)"
						+",faxNo"      + ":STRING(20)"; 
			ds_approval.SetDataHeader(strHeader);
	}				
	ds_approval.AddRow();   
//	ds_approval.NameValue(ds_approval.RowPosition,"vendCd"      )=ds_main.NameValue(ds_main.RowPosition,"vendCd"); 
//	var arow =ds_gridVendor.NameValueRow("code",ds_main.NameValue(ds_main.RowPosition,"vendCd"));
//	ds_approval.NameValue(ds_approval.RowPosition,"vendType")     = ds_gridVendor.NameValue(arow,"vendType");		
	ds_approval.NameValue(ds_approval.RowPosition,"mainYn"      ) ="F";   
}

// Vendor App del
function f_delRowApp(){
	if(ds_approval.CountRow<1){
		alert("<%=source.getMessage("dev.inf.com.nodelete")%>");
	}

	if(ds_approval.RowPosition>0){
		ds_approval.DeleteRow(ds_approval.RowPosition);
	} 
}


</script> 


<!-----------------------------------------------------------------------------
  프로그램 전용 D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!--combo DataSet -->
<object id="ds_deptCd"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
	<param name="DataID"          value="cm.cm.retrieveCommCodeCombo.gau?groupCd=2001">
</object>

<!-- Cost Center DataSet-->
<object id="ds_costCenter" classid="<%=LGauceId.DATASET%>" >
  	<param name="SyncLoad"          value="true"> 
</object>

<comment id="__NSID__"><object id="ds_status"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"          value="true">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>


<!--grid DataSet -->
<object id="ds_main1" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/>
  <param name="ViewDeletedRow"    value="true"/>
</object>
<object id="ds_main2" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/>
  <param name="ViewDeletedRow"    value="true"/>
</object>
<object id="ds_main3" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/>
  <param name="ViewDeletedRow"    value="true"/>
</object>
<object id="ds_main4" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/>
  <param name="ViewDeletedRow"    value="true"/>
</object>
<object id="ds_main5" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/>
  <param name="ViewDeletedRow"    value="true"/>
</object>
<object id="ds_main6" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/>
  <param name="ViewDeletedRow"    value="true"/>
</object>

<!-- CUD TR -->
<OBJECT id=tr_cudMaster classid="<%=LGauceId.TR%>">
	<param name="KeyName" value="toinb_dataid4">
</OBJECT>

<!-- Grid 용 DataSet-->
<object id="ds_approval" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true">
	<param name="ViewDeletedRow"    value="false">
</object>

<!-----------------------------------------------------------------------------
		   프로그램 전용 G A U C E   C O M P O N E N T' S   E V E N T S
------------------------------------------------------------------------------>
<!-- INSERT/UPDATE Tr 의 트렌젝션 실행 시 -->
<script language=JavaScript for=tr_cudMaster event=OnFail()>
    mode = "";
    if(tr_cudMaster.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
        window.parent.location.href = "/index.jsp";    
    }
    if(tr_cudMaster.ErrorMsg.lastIndexOf("]") != -1) {
      var msgs= tr_cudMaster.ErrorMsg.substring(tr_cudMaster.ErrorMsg.lastIndexOf("]")+2,tr_cudMaster.ErrorMsg.length);
      alert(msgs);
      }  
</script>
<script language=JavaScript for=tr_cudMaster event=OnSuccess()>	
        f_retrieve();
        ds_main.RowPosition = g_msPos;	
		alert("<%=source.getMessage("dev.suc.com.save")%>" );		
</script>

<!--grid DataSet -->
<script language=JavaScript for=ds_main1 event=OnLoadStarted()>
	  cfShowDSWaitMsg(gd_main1);//progress bar 보이기
	  cfHideNoDataMsg(gd_main1);//no data 메시지 숨기기
	  mode = "";
</script>
<script language=JavaScript for=ds_main1 event=OnLoadCompleted(rowcnt)>
      cfHideDSWaitMsg(gd_main1);//progress bar 숨기기
	  cfFillGridNoDataMsg(gd_main1,"gridColLineCnt=2");//no data found   
	  mode = "";
	  
</script>


 



<script language=JavaScript for=ds_main2 event=OnLoadStarted()>
	  cfShowDSWaitMsg(gd_main2);//progress bar 보이기
	  cfHideNoDataMsg(gd_main2);//no data 메시지 숨기기
	  mode = "";
</script>
<script language=JavaScript for=ds_main2 event=OnLoadCompleted(rowcnt)>
      cfHideDSWaitMsg(gd_main2);//progress bar 숨기기
	  cfFillGridNoDataMsg(gd_main2,"gridColLineCnt=2");//no data found   
	  mode = "";
</script>
<script language=JavaScript for=ds_main3 event=OnLoadStarted()>
	  cfShowDSWaitMsg(gd_main3);//progress bar 보이기
	  cfHideNoDataMsg(gd_main3);//no data 메시지 숨기기
	  mode = "";
</script>
<script language=JavaScript for=ds_main3 event=OnLoadCompleted(rowcnt)>
      cfHideDSWaitMsg(gd_main3);//progress bar 숨기기
	  cfFillGridNoDataMsg(gd_main3,"gridColLineCnt=3");//no data found   
	  mode = "";
</script>	
<!-----------------------------------------------------------------------------
  화면영역 시작
------------------------------------------------------------------------------>
</head>

<body id="cent_bg" onload="onLoad();">

<div id="conts_box">
	<h2> <span> <%=columnData.getString("page_title") %>  </span></h2>
	<!--검색 S -->	 
	 <fieldset class="boardSearch"> 
		<div>
			<dl>
			<dt> 
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board2" />
					<colgroup> 
					<col width="5%"/>
					<col width="13%"/>
					<col width="5%"/>
					<col width="15%"/>
					<col width=""/>
					</colgroup>
					<tr>		
						<th><%=columnData.getString("doc_date") %></th>
						<td><input type="text" 				 	value="<%= docDate %>" 
								   id="docDateTo"    	 		name="docDateTo"   
								   onblur="valiDate(this);"  	style="width:65px;"/>&nbsp;
							<img   src="<%= images %>button/cal_icon.gif" 
								   alt="Calendar Icon" 
								   onClick="javascript:OpenCalendar(docDateTo);" 
								   style="cursor:hand"/>~&nbsp; 
							<input type="text" 					 value="<%= currentDate %>" 
								   id="docDateFrom" 		 	 name="docDateFrom"  
								   onblur="valiDate(this);"   	 style="width:65px;"/>&nbsp;
							<img   src="<%= images %>button/cal_icon.gif" 
								   alt="Calendar Icon" 
							       onClick="javascript:OpenCalendar(docDateFrom);" 
							       style="cursor:hand"/></td>
						      
					 	<th><%=columnData.getString("post_date") %></th>
						<td><input type="text" 				 	value="<%= prevDate %>" 
								   id="postDateTo"    	 	name="postDateTo"   
								   onblur="valiDate(this);"  	style="width:65px;"/>&nbsp;
							<img   src="<%= images %>button/cal_icon.gif" 
								   alt="Calendar Icon" 
								   onClick="javascript:OpenCalendar(postDateTo);" 
								   style="cursor:hand"/>~&nbsp; 
							<input type="text" 					 value="<%= currentDate %>" 
								   id="postDateFrom" 			 name="postDateFrom"  
								   onblur="valiDate(this);"   	 style="width:65px;"/>&nbsp;
							<img   src="<%= images %>button/cal_icon.gif" 
								   alt="Calendar Icon" 
							       onClick="javascript:OpenCalendar(postDateFrom);" 
							       style="cursor:hand"/></td>						       					  
					</tr> 	
			</table>
			</dt>              		  	   	 	
		    <dd class="btnseat1">
			 <span class="search_btn_r search_btn_l">
              <input type="button" onfocus="blur();" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='#e2ebf7'" value="<%=btnSearch %>" onclick="f_retrieve();"/></span> 
			 </dd>						
			</dl>
			</div>
		</fieldset>

    <!-- 상태별 전표갯수==============================================================================-->
     <div class="sub_stitle"> <p><%=columnData.getString("sub_title") %>  </p></div>
     <div> 
	<table width="100%" border="0" cellspacing="0" cellpadding="0" >
	  <tr>
	    <td>
	      <comment id="__NSID__">
	        <object id="gd_main1" classid="<%=LGauceId.GRID %>" style="width:100%;height:60px" class="comn_status">
	          <param name="DataID"              value="ds_main1">
	          <param name="Editable"            value="false">
	          <param name="TitleHeight"         value="25"> 
	          <param name="UsingOneClick"       value="1">
	          <param name="SortView" 			value="Left">
	          <param name="Format"              value='												
                <C> id=statusAll	name="Total Docs"     	align="center"   width="105"  </C>
                <C> id=status10	 	name="Insert"     	 	align="center"   width="105"  </C>
                <C> id=status20 	name="Confirm"     		align="center"   width="105"  </C>
                <C> id=status30 	name="SAP sended"     	align="center"   width="105"  </C>
                <C> id=status40 	name="Return SAP"      	align="center"   width="105"  </C>
                <C> id=status50 	name="Cancel Request"   align="center"   width="105"  </C>
                <C> id=status90 	name="Posting"    		align="center"   width="105"  </C>
			  '/>
	        </object>
	      </comment>
	      <script>__WS__(__NSID__);</script>
	    </td>
	  </tr>
	</table>
   </div>
  
    <!-- 체크해야할 전표리스트 조회================================================================-->    
       <div class="sub_stitle"> <p><%=columnData.getString("sub1_title") %>  </p>
   		<p class="rightbtn"> 
			<span class="excel_btn_r excel_btn_l">
            <input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="<%=btnExcelDown %>" onclick="f_excel()"/>
            </span> 
		</p>	
    </div>  	
   <div> 
	<table width="100%" border="0" cellspacing="0" cellpadding="0" >
	  <tr>
	    <td>
	      <comment id="__NSID__">
	        <object id="gd_main2" classid="<%=LGauceId.GRID %>" style="width:100%;height:108px" class="comn_status">
	          <param name="DataID"              value="ds_main2">
	          <param name="Editable"            value="false">
	          <param name="TitleHeight"         value="25"> 
	          <param name="UsingOneClick"       value="1">
	          <param name="SortView" 			value="Left">
	          <param name="Format"              value='												
           		<C> id=seq        		name="<%= columnData.getString("seq") %>"       	 align="center"   width="30"    Value={CurRow} </C>
                <C> id=progStatusNm    	name="<%= columnData.getString("progStatusNm") %>"   align="center"   width="90"    </C>			
                <C> id=docYm	      	name="<%= columnData.getString("docYm") %>"    	 	 align="center"   width="80"    </C>             
                <C> id=docNum       	name="<%= columnData.getString("docSeq") %>"     	 align="center"   width="90"    </C>             
                <C> id=docDate     		name="<%= columnData.getString("docDate") %>"  		 align="center"   width="100"    Mask="XXXX/XX/XX"</C>             
                <C> id=sapAcctCd     	name="<%= columnData.getString("sapAcctCd") %>"      align="center"   width="80"    </C>
                <C> id=sapAcctNm       	name="<%= columnData.getString("sapAcctNm") %>"      align="center"   width="120"   </C>
                <C> id=debitAmt      	name="<%= columnData.getString("debitAmt") %>"     	 align="right"    width="120"   DisplayFormat ="#,###.00"</C>
                <C> id=creditAmt      	name="<%= columnData.getString("creditAmt") %>"      align="right"    width="120"   DisplayFormat ="#,###.00" </C>
                <C> id=costCenter   	name="<%= columnData.getString("costCenter") %>"     align="center"   width="120"   </C>
                <C> id=docDesc   		name="<%= columnData.getString("docDesc") %>"     	 align="left"     width="180"   </C>
                <C> id=currencyCd  		name="<%= columnData.getString("currencyCd") %>"  	 align="center"   width="80"    </C>
                <C> id=PostDate    		name="<%= columnData.getString("postDate") %>"       align="center"   width="100"    Mask="XXXX/XX/XX"</C>
                <C> id=vat   			name="<%= columnData.getString("vat") %>"    	 	 align="center"   width="90"    </C>
                <C> id=base      		name="<%= columnData.getString("base") %>"     	 	 align="center"   width="90"    </C>
                <C> id=code    			name="<%= columnData.getString("code") %>"     	 	 align="center"   width="90"    </C>			
                <C> id=rate    			name="<%= columnData.getString("rate") %>"     	 	 align="center"   width="90"    </C>			
                <C> id=spgl    			name="<%= columnData.getString("spgl") %>"     	 	 align="center"   width="90"    </C>			
                <C> id=vendor    		name="<%= columnData.getString("vendor") %>"     	 align="center"   width="90"    </C>			
                <C> id=customer    		name="<%= columnData.getString("customer") %>"     	 align="center"   width="90"    </C>			
                <C> id=attr2     		name="<%= columnData.getString("attr2") %>"     	 align="center"   width="90"    </C>			
                <C> id=sapDocSeq    	name="<%= columnData.getString("sapDocSeq") %>"      align="center"   width="90"    </C>			
                <C> id=dueDate    		name="<%= columnData.getString("dueDate") %>"     	 align="center"   width="100"    Mask="XXXX/XX/XX"</C>			
			  '/>
	        </object>
	      </comment>
	      <script>__WS__(__NSID__);</script>
	    </td>
	  </tr>
	</table>
   </div>
   
  <!-- 수량 ==============================================================================-->
     <div class="sub_stitle"> <p><%=columnData.getString("sub3_title") %>  </p></div>
     <div> 
	<table width="100%" border="0" cellspacing="0" cellpadding="0" >
	  <tr>
	    <td>
	      <comment id="__NSID__">
	        <object id="gd_main4" classid="<%=LGauceId.GRID %>" style="width:100%;height:60px" class="comn_status">
	          <param name="DataID"              value="ds_main4">
	          <param name="Editable"            value="false">
	          <param name="TitleHeight"         value="25"> 
	          <param name="UsingOneClick"       value="1">
	          <param name="SortView" 			value="Left">
	          <param name="Format"              value='												
                <C> id=receiptQty 	name="<%= columnData.getString("receiptQty2") %>"      	align="right"   width="125"  DisplayFormat ="#,###.00"</C>
                <C> id=issueQty	 	name="<%= columnData.getString("issueQty") %>"    		align="right"   width="125"  DisplayFormat ="#,###.00"</C>
                <C> id=coalProdQty 	name="<%= columnData.getString("coalProdQty") %>"       align="right"   width="135"  DisplayFormat ="#,###.00"</C>
			  '/>
	        </object>
	      </comment>
	      <script>__WS__(__NSID__);</script>
	    </td>
	  </tr>
	</table>
   </div>
    <!-- P/O 및 입고내역 ========================================================================-->  			
   <div class="sub_stitle"> <p><%=columnData.getString("sub2_title") %>  </p>
   		<p class="rightbtn"> 
			<span class="excel_btn_r excel_btn_l">
            <input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="<%=btnExcelDown %>" onclick="f_excel2()"/>
            </span> 
		</p>	
    </div> 
   <div> 
	<table width="100%" border="0" cellspacing="0" cellpadding="0" >
	  <tr>
	    <td>
	      <comment id="__NSID__">
	        <object id="gd_main3" classid="<%=LGauceId.GRID %>" style="width:100%;height:144px" class="comn_status">
	          <param name="DataID"              value="ds_main3">
	          <param name="Editable"            value="false">
	          <param name="TitleHeight"         value="20"> 
	          <param name="UsingOneClick"       value="1">
	          <param name=SuppressOption 	    value="1">
	          <param name=ViewSummary           value="1">
	          <param name="SortView" 			value="Left">
	          <param name="Format"              value='			
	            <C> id=seq        		name="<%= columnData.getString("seq") %>"       	 align="center"   width="30"    Value={CurRow} </C>									
           		<C> id=poNo        		name="<%= columnData.getString("poNo") %>"       	 align="center"   width="100"    suppress="1"  </C>
                <C> id=regdate    		name="<%= columnData.getString("regDate") %>"   	 align="center"   width="100"    suppress="1" Mask="XXXX/XX/XX"</C>			
                <C> id=docDate	      	name="<%= columnData.getString("docDate") %>"    	 align="center"   width="100"    suppress="1" Mask="XXXX/XX/XX"</C>             
                <C> id=deliDate       	name="<%= columnData.getString("deliDate") %>"     	 align="center"   width="100"    suppress="1" Mask="XXXX/XX/XX"</C>             
                <C> id=status     		name="<%= columnData.getString("status") %>"  		 align="center"   width="120"    suppress="1"</C>             
                <C> id=materNm       	name="<%= columnData.getString("materNm") %>"        align="center"   width="150"    suppress="1"</C>
                <C> id=poQty      		name="<%= columnData.getString("poQty") %>"     	 align="right"    width="120"    suppress="1" DisplayFormat ="#,###.00" </C>
                <g>name="<%=columnData.getString("receipt_list") %>"  
               	 	<C> id=receiptSeq     	name="<%= columnData.getString("seq") %>"     		 align="center"   width="40"   </C>
               	 	<C> id=receiptQty      	name="<%= columnData.getString("receiptQty") %>"     align="right"    width="120"   DisplayFormat ="#,###.00" sumtext="@sum"</C>
                	<C> id=receiptRegdate   name="<%= columnData.getString("regDate") %>" 		 align="center"   width="100"   Mask="XXXX/XX/XX"</C>
                	<C> id=receiptDate   	name="<%= columnData.getString("docDate") %>"   	 align="center"   width="100"   Mask="XXXX/XX/XX"</C>
                	<C> id=receiptPostingDate 	name="<%= columnData.getString("postDate") %>"   align="center"   width="100"   Mask="XXXX/XX/XX"  </C>
			  </g>
			  '/>
	        </object>
	      </comment>
	      <script>__WS__(__NSID__);</script>
	    </td>
	  </tr>
	</table>
   </div>
   

  <!-- 출고 내역 ==============================================================================-->
       <div class="sub_stitle"> <p><%=columnData.getString("sub4_title") %>  </p>
   		<p class="rightbtn"> 
			<span class="excel_btn_r excel_btn_l">
            <input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="<%=btnExcelDown %>" onclick="f_excel3()"/>
            </span> 
		</p>	
    </div> 
     <div> 
	<table width="100%" border="0" cellspacing="0" cellpadding="0" >
	  <tr>
	    <td>
	      <comment id="__NSID__">
	        <object id="gd_main5" classid="<%=LGauceId.GRID %>" style="width:100%;height:131px" class="comn_status">
	          <param name="DataID"              value="ds_main5">
	          <param name="Editable"            value="false">
	          <param name="TitleHeight"         value="25"> 
	          <param name="UsingOneClick"       value="1">
	          <param name="ViewSummary"         value="1">
	          <param name="SortView" 			value="Left">
	          <param name="Format"              value='												
                <C> id=seq 		 	 name="<%= columnData.getString("seq") %>"  align="center"   width="40"    Value={CurRow}</C>
                <C> id=issueNo		 name="<%= columnData.getString("issueNo") %>"      align="center"   width="125"  </C>
                <C> id=materNm 	 	 name="<%= columnData.getString("materNm") %>"   	align="center"   width="150"  </C>
                <C> id=unit 		 name="<%= columnData.getString("unit") %>"   		align="center"   width="50"   </C>
                <C> id=issueQty 	 name="<%= columnData.getString("issueQty") %>" 	align="right"    width="125"  DisplayFormat ="#,###.00" sumtext="@sum"</C>
                <C> id=issueDate 	 name="<%= columnData.getString("issue_date") %>"   align="center"   width="100"  Mask="XXXX/XX/XX" </C>
                <C> id=costCenter 	 name="<%= columnData.getString("cost_center") %>"  align="center"   width="125"  EditStyle="LookUp" 	Data="ds_costCenter:code:name:code" ListWidth=250 </C>
                <C> id=postingDate 	 name="<%= columnData.getString("postDate") %>" 	align="center"   width="100"  Mask="XXXX/XX/XX" </C>
                <C> id=werks 	 	 name="<%= columnData.getString("werks") %>"   		align="center"   width="125"  show="false" </C>
                <C> id=sapDocNo 	 name="<%= columnData.getString("sapDocNo") %>"   	align="center"   width="125"  show="false"</C>
                <C> id=status 	 	 name="<%= columnData.getString("status") %>"   	align="center"   width="125"  </C>
                <C> id=vendor 	 	 name="<%= columnData.getString("vendor") %>"   	align="center"   width="125"  show="false"</C>
                <C> id=description 	 name="<%= columnData.getString("docDesc") %>"  	align="center"   width="125"  </C>  
			  '/>
	        </object>
	      </comment>
	      <script>__WS__(__NSID__);</script>
	    </td>
	  </tr>
	</table>
   </div>	

<!-- 석탄생산 내역 ==============================================================================-->
       <div class="sub_stitle"> <p><%=columnData.getString("sub5_title") %>  </p>
   		<p class="rightbtn"> 
			<span class="excel_btn_r excel_btn_l">
            <input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="<%=btnExcelDown %>" onclick="f_excel4()"/>
            </span> 
		</p>	
    </div> 
     <div> 
	<table width="100%" border="0" cellspacing="0" cellpadding="0" >
	  <tr>
	    <td>
	      <comment id="__NSID__">
	        <object id="gd_main6" classid="<%=LGauceId.GRID %>" style="width:100%;height:132px" class="comn_status">
	          <param name="DataID"              value="ds_main6">
	          <param name="Editable"            value="false">
	          <param name="TitleHeight"         value="28"> 
	          <param name="UsingOneClick"       value="1">
	          <param name="ViewSummary"         value="1">
	          <param name="SortView" 			value="Left">
	          <param name="Format"              value='												
                <C> id=seq 		 	 	name="<%= columnData.getString("seq") %>"  			align="center"   width="40"    Value={CurRow}</C>
                <C> id=syskey		 	name="<%= columnData.getString("syskey") %>"        align="center"   width="125"  </C>
                <C> id=productDate 	 	name="<%= columnData.getString("productDate") %>"   align="center"   width="100"  Mask="XXXX/XX/XX" </C>
                <C> id=postDate 		name="<%= columnData.getString("postDate") %>"      align="center"   width="100"   Mask="XXXX/XX/XX" </C>
                <C> id=coalQty 	 		name="<%= columnData.getString("coalQty") %>" 		align="right"    width="125"  DisplayFormat ="#,###.00" sumtext="@sum" </C>
                <C> id=wasteRemovQty 	name="<%= columnData.getString("wasteRemovQty") %>" align="right"   width="125"  DisplayFormat ="#,###.00" sumtext="@sum" </C>
                <C> id=status 	 		name="<%= columnData.getString("status") %>"   		align="center"   width="125"  </C>
                <C> id=sapSeq 	 	 	name="<%= columnData.getString("sapSeq") %>"   		align="center"   width="125"  </C>
			  '/>
	        </object>
	      </comment>
	      <script>__WS__(__NSID__);</script>
	    </td>
	  </tr>
	</table>
   </div>
  	 <!-- 그리드 E --> <!--===================================================================--> 	
					
		<!-- 그리드 E --> 
	    <div class="sub_stitle"> <p>Mail</p>
			<p class="rightbtn">
			    <span class="sbtn_r sbtn_l">
				<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="<%=btnAddRow%>" onclick="f_addRowApp();"/></span> 
				<span class="sbtn_r sbtn_l"> 
				<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="<%=btnDelRow%>" onclick="f_delRowApp();"/></span>  	 
			</p>
		</div>	
		<!-- 그리드 S -->
		<div>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<comment id="__NSID__">
						<object id="gr_approval" classid="<%=LGauceId.GRID %>" style="width:100%;height:66px;" class="comn">
							<param name="DataID"            value="ds_approval"/> 
							<param name="Editable"          value="true"/>
						    <param name="UsingOneClick"     value=1>
							<param name="UrlImages"         value="<I>Type='PopupBotton', Url='/sys/images/button/search_icon_2.gif', Fit='AutoFit', Flat='True'</I>">
							<param name="Format"              
							value="
							<C>id='chk'                  name='<%=columnData.getString("send") %>'       width='50'  align='center'    edit={decode(mainYn,'T','false','true')},  Editstyle='check'    </C>
							<C>id='vendPerson'   name='<%=columnData.getString("charge") %>'   width='150' align='center'   edit='true'    </C>
							<C>id='emailAddr'      name='<%=columnData.getString("e_mail") %>'   width='160' align='left'         edit='true'    </C>
							<C>id='telNo'               name='<%=columnData.getString("tel_no") %>'    width='153' align='left'         edit='true'    </C>
							<C>id='faxNo'              name='<%=columnData.getString("fax_no") %>'   width='150' align='left'         edit='true'    </C>
							"/>
						</object>
						</comment>
						<script>__WS__(__NSID__);</script>
					</td>
				</tr>
			</table>
		</div>
		
		<!-- 버튼 S -->	
		<div id="btn_area">
			<p class="b_right">
				<span class="btn_r btn_l"> 
				<input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnPoSend%>" onclick="f_createFile();"/></span> 		
			</p>
		</div>
		<form action="fi.ar.cudStatementOfAccountsSendMail.dev" method="post" name="fileForm">
		    <input type="hidden" name="filename" value="">
		    <input type="hidden" name="fileReal" value="">
		    <input type="hidden" name="fileFolder" value="">
		    <input type="hidden" name="mainMail" value="">
		</form>
		

		
		
		
		
		
		
</div>
</body>

</html> 	 