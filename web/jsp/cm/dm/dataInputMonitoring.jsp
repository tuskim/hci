<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html xmlns="http://www.w3.org/1999/xhtml">
<%--
/*
 *************************************************************************
 * @source  : dataInputMornitoring.jsp
 * @desc    : 데이타 입력 모니터링
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2011.02.10   mslim   신규작성
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
<%@ include file="/include/head.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head> 
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title>PT-PAM System</title> 
<head>

<% 

	String currentMonth   = LDateUtils.getDate("yyyy/MM");
%>


<style>
table{ border-spacing:0; border-collapse:collapse; }
:root table{ border-spacing:0; border-collapse:separate;  }
td,th {font-size:15px;line-height:22px; }
</style>


<script language="javascript">
var g_flug =false; // Detail작업 flag
var g_msPos = 0;   // save후  focus 제정의 Row
var g_ddtPos = 0;  // save후  focus 제정의 Row
var autoSend = false;

function init(){ 
	
	<%if(request.getParameter("send") != null){ %>
		alert('Successfully emailed');
	
	<%}%>
	
	cfAddYn(ds_gyn,"code");  
	
	f_retrieve_email_list();			// email 조회 
	
	<%if(request.getParameter("type") != null){ %>
		autoSend = true;		
		f_retrieve(); // 조회 후 데이터 세팅 및 이메일 전송
	<%}else{%> 
		autoSend = false;
		f_retrieve(); // 조회 후 데이터 세팅 및 이메일 전송		
	<%}%>
}

 
//-------------------------------------------------------------------------
// 조회
//-------------------------------------------------------------------------
function f_retrieve(){ 

	var month = removeDash(document.all.month.value, "/");
    
    	
	ds_main.DataID  = "/cm.dm.retrieveDataInputMonitoringList.gau?";
    ds_main.DataID += "month=" + month;
 	ds_main.Reset();

 	
}

function f_retrieve_email_list(){

	ds_email.DataID  = "/cm.dm.retrieveDataInputMonitoringEmailList.gau?";
 	ds_email.Reset();

}

function f_save(){
	
	tr_master.KeyValue = "Servlet(I:IN_DS1=ds_email)";
	tr_master.Action   = "/cm.dm.cudDataInputMonitoringEmailList.gau";
	tr_master.post();
		

}

function f_delete(){

	for(var i=ds_email.CountRow; i>=1; i--){
		if(ds_email.NameValue(i, "chk") == "T"){
			ds_email.DeleteRow(i);
		}
	}
	

	tr_master.KeyValue = "Servlet(I:IN_DS1=ds_email)";
	tr_master.Action   = "/cm.dm.cudDataInputMonitoringEmailList.gau";
	tr_master.post();


}

function f_add(){

	ds_email.addRow();
	ds_email.NameValue(ds_email.RowPosition, "useyn") = "Y";
	

}


// 데이타세팅 및 이메일 전송
function setData(){

<% 	int [][] board = (int[][])request.getAttribute("board"); %>

    var tbl=document.all.dataInputTable;

    var month1 = parseInt(document.all.month.value.substr(5,7),10)-2;
    var month2 = parseInt(document.all.month.value.substr(5,7),10)-1;
    var month3 = parseInt(document.all.month.value.substr(5,7),10);

	if(month1 <= 0)
		month1 += 12;
	if(month2 <= 0)
		month2 += 12;

    var monthName = [" ", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    month1 = monthName[month1];
    month2 = monthName[month2];
    month3 = monthName[month3];
    


		
    style="padding:10px;"
    var html= "" +
    ""+
    "<table  id='dataTable' style='border-spacing:0; border-collapse:collapse;  border:  1px gray; ' width = 720  height = 450   >	" +
"  		<colgroup> " + 
"   	<col width='22%'/> " +
"   	<col width='25%'/> " +
"       </colgroup>  " +
    "	<tr align='center' > " + 
    "  <td colspan='6'  style='border-width: 0pt;'> <font face='맑은 고딕' size=3> <B><U> PT.MPP System Input Report<B></U> </font>   </td> " + 
	"	</tr> <tr> <td style='line-height:14px; border-width: 0pt'> &nbsp;</td></tr>	" + 	
    "	<tr align='right' > " + 
    "  <td colspan='6'  style='border-width: 0pt; font-size:12px;'> <b> <%=LDateUtils.getDate("yyyy.MM.dd")  %> Report  </b> </td> " + 
	"	</tr> " + 
	"	<tr  align='center'> " +  
	"  <td style='border: 1px solid; font-size:14px; ' ><b> <font face='맑은 고딕' >Classcification 1</b></td> " + 
	"		<td style='border: 1px solid; font-size:14px;' ><b> <font face='맑은 고딕' >Classcification 2</b></td> " + 
	"		<td style='border: 1px solid; font-size:14px;' ><b> <font face='맑은 고딕' >Process</b></td> " + 
	"		<td style='border: 1px solid; font-size:14px;' > <b> <font face='맑은 고딕' > " +  month1  + "  </b> </td> " + 
	"		<td style='border: 1px solid; font-size:14px;' > <b> <font face='맑은 고딕' > " +  month2  + "  </b> </td> " + 
	"		<td style='border: 1px solid; font-size:14px;' > <b> <font face='맑은 고딕' >" +  month3  + "  </b> </td> " + 
	"	</tr> " + 
	"	<tr align='center'> " +  
	"		<td style='border: 1px solid; font-size:14px;' rowspan=8  > <font face='맑은 고딕' > Input Data Counts</td> " + 
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' > Accounting</td> " + 
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' > General Expenses</td> " + 
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(1, "dataInput1")	+ " ea</td>" +
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(1, "dataInput2")	+ " ea</td>" +
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(1, "dataInput3")	+ " ea</td>" +
	"	</tr>	" + 
	"	<tr align='center'> " +  
	"		<td style='border: 1px solid; font-size:14px;' rowspan=3 ><font face='맑은 고딕' >Purchase</td> " + 
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >Goods Receipt</td> " + 
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(2, "dataInput1")	+ " ea</td>" +
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(2, "dataInput2")	+ " ea</td>" +
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(2, "dataInput3")	+ " ea</td>" +
	"	</tr>	" +
	"	<tr align='center'> " +  
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >Goods Issue</td> " + 
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(3, "dataInput1")	+ " ea</td>" +
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(3, "dataInput2")	+ " ea</td>" +
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(3, "dataInput3")	+ " ea</td>" +
	"	</tr>	" +
	"	</tr>	" +
	"	<tr align='center'> " +  
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >Purchase Invoice</td> " + 
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(4, "dataInput1")	+ " ea</td>" +
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(4, "dataInput2")	+ " ea</td>" +
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(4, "dataInput3")	+ " ea</td>" +
	"	</tr>	" +
	"	<tr align='center'> " +  
	"		<td style='border: 1px solid; font-size:14px;' rowspan=3 ><font face='맑은 고딕' >Production</td> " + 
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >Waste Removal</td> " + 
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(5, "dataInput1")	+ " ea</td>" +
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(5, "dataInput2")	+ " ea</td>" +
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(5, "dataInput3")	+ " ea</td>" +
	"	</tr>	" +
	"	<tr align='center'> " +  
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >Coal Hauling</td> " + 
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(6, "dataInput1")	+ " ea</td>" +
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(6, "dataInput2")	+ " ea</td>" +
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(6, "dataInput3")	+ " ea</td>" +
	"	</tr>	" +
	"	<tr align='center'> " +  
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >Coal production</td> " + 
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(7, "dataInput1")	+ " ea</td>" +
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(7, "dataInput2")	+ " ea</td>" +
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(7, "dataInput3")	+ " ea</td>" +
	"	</tr>	" +
	"	<tr align='center'> " +  
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >Sales</td> " + 
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >Coal Sales</td> " + 
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(8, "dataInput1")	+ " ea</td>" +
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(8, "dataInput2")	+ " ea</td>" +
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(8, "dataInput3")	+ " ea</td>" +
	"	</tr>	" +
	"	<tr align='center'> " +  
	"		<td style='border: 1px solid; font-size:14px;' rowspan=8><font face='맑은 고딕' >Timely Input <br/>Ratio(%)</td> " + 
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' > Accounting</td> " + 
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >General Expenses</td> " + 
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(9, "dataInput1")	+ " %</td>" +
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(9, "dataInput2")	+ " %</td>" +
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(9, "dataInput3")	+ " %</td>" +
	"	</tr>	" + 
	"	<tr align='center'> " +  
	"		<td style='border: 1px solid; font-size:14px;' rowspan=3 ><font face='맑은 고딕' >Purchase</td> " + 
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >Goods Receipt</td> " + 
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(10, "dataInput1")	+ " %</td>" +
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(10, "dataInput2")	+ " %</td>" +
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(10, "dataInput3")	+ " %</td>" +
	"	</tr>	" +
	"	<tr align='center'> " +  
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >Goods Issue</td> " + 
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(11, "dataInput1")	+ " %</td>" +
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(11, "dataInput2")	+ " %</td>" +
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(11, "dataInput3")	+ " %</td>" +
	"	</tr>	" +
	"	</tr>	" +
	"	<tr align='center'> " +  
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >Purchase Invoice</td> " + 
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(12, "dataInput1")	+ " %</td>" +
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(12, "dataInput2")	+ " %</td>" +
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(12, "dataInput3")	+ " %</td>" +
	"	</tr>	" +
	"	<tr align='center'> " +  
	"		<td style='border: 1px solid; font-size:14px;' rowspan=3 ><font face='맑은 고딕' >Production</td> " + 
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >Waste Removal</td> " + 
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(13, "dataInput1")	+ " %</td>" +
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(13, "dataInput2")	+ " %</td>" +
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(13, "dataInput3")	+ " %</td>" +
	"	</tr>	" +
	"	<tr align='center'> " +  
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >Coal Hauling</td> " + 
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(14, "dataInput1")	+ " %</td>" +
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(14, "dataInput2")	+ " %</td>" +
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(14, "dataInput3")	+ " %</td>" +
	"	</tr>	" +
	"	<tr align='center'> " +  
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >Coal production</td> " + 
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(15, "dataInput1")	+ " %</td>" +
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(15, "dataInput2")	+ " %</td>" +
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(15, "dataInput3")	+ " %</td>" +
	"	</tr>	" +
	"	<tr align='center'> " +  
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >Sales</td> " + 
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >Coal Sales</td> " + 
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(16, "dataInput1")	+ " %</td>" +
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(16, "dataInput2")	+ " %</td>" +
	"		<td style='border: 1px solid; font-size:14px;'><font face='맑은 고딕' >" + ds_main.NameValue(16, "dataInput3")	+ " %</td>" +
	"	</tr>	" +
    "  <td  colspan='5'  style='border-width: 0pt; font-size:14px; '><font face='맑은 고딕' > * Timely Input Ratio(%) : Days of difference between document date and entry date is within 5 days.</td> " + 
	"	</tr> " + 
	" </table> <br/>" +
	"    ";
	
		
    tbl.innerHTML=html;

	if(autoSend){
		f_email();   // 이메일 전송

	}
}

function f_email(){

	sform.method = "post";
	sform.title.value = "PT MGE System Input Report ";
	sform.mailbody.value = sform.innerHTML;	
	sform.action         = "cm.dm.sendMail.dev"; 

	var emailList = "";
	for(var i=1; i<=ds_email.CountRow; i++){
		if(ds_email.NameValue(i, "useyn") == "Y"){
			emailList += ds_email.NameValue(i, "email");
			emailList += ",";
		}
	}
	
	sform.mainMail.value = emailList;	   // 수신 메일 주소  ( 콤마로 구분 ) 
	sform.submit();

	
}

function f_print(){
    	window.open("jsp/cm/dm/dataInputPreview.jsp?gubun=p","PreView","width=842,height=558,left=" + (screen.width/2 - 821/2)+ ",top=" + (screen.height/2 - 558/2) +",scrollbars=yes,menubar=0,status=0,toolbar=0,location=0,directories=0,resizable=0");   	

}



</script> 

<%----------------------------------------------------------------------------------------------------
 Gauce obj  정의
---------------------------------------------------------------------------------------------------- --%>

<object id="ds_main" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/> 
</object>

<object id="ds_email" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/> 
</object>

<object id="ds_gyn" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/> 
</object>

<OBJECT id=tr_master classid="<%=LGauceId.TR%>">
    <param name="KeyName" value="toinb_dataid4">
</OBJECT>
<%----------------------------------------------------------------------------------------------------
 Gauce obj  event  정의
------------------------------------------------------------------------------------------------------%>
 
<!-- Hub In Header 조회 DataSet -->
<script language=JavaScript for=ds_main event=OnLoadCompleted(rowCnt)>

	setData();

</script>

 
<script language=JavaScript for=tr_master event=OnSuccess()>
    alert("successfully processed.");
</script>
 
  
<%----------------------------------------------------------------------------------------------------
 Gauce obj  event TR  정의
------------------------------------------------------------------------------------------------------%> 
 
 
<%----------------------------------------------------------------------------------------------------
 UI  정의
---------------------------------------------------------------------------------------------------- --%>
</head>

<body id="cent_bg" onload="init();">
<div id="conts_box">
	<h2> <span> Data Input Monitoring </span></h2>
	<!--검색 S -->	 
	<fieldset class="boardSearch"> 
	<div>
		<dl>
			<dt> 
				<table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board2" />
					<colgroup>
						<col width="8%"/>
						<col width="19%"/> 
						<col width="13%"/> 
						<col width=""/>
					</colgroup>
					<tr>
						<th>Month</th>
				<td><input type="text"  name="month" id="month" onkeydown="keyLogin(event)" size="7" class="input_Licon" maxlength="100" value="<%= currentMonth%>">
						<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:Calendar_M(month);" style="cursor:hand"/>
				</td>

					</tr>
				</table>
			</dt>              		  	   	 	
			<dd class="btnseat1"> 
				<span class="search_btn_r search_btn_l">
					<input type="button" onfocus="blur();" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='#e2ebf7'" value="<%=btnSearch %>" onclick="f_retrieve();"/>
				</span> 
			</dd>						
		</dl>
	</div>
	</fieldset>

<form name="sform"  >


	<div id="dataInputTable" style="margin-left:1px";></div>
	<input type="hidden" name="mailbody"/>
	<input type="hidden" name="mainMail"/>
	<input type="hidden" name="refMail"/>
	<input type="hidden" name="poNo"/>
	<input type="hidden" name="title"/>

</form>

	<!-- 버튼 S -->	
	<div id="conts_box">
		<p class="b_right">
			<!-- 
			<span class="btn_r btn_l"> 
			<input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="Add" onclick="f_add();"/></span> 
			<span class="btn_r btn_l"> 
			<input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="Delete" onclick="f_delete();"/></span> 
			<span class="btn_r btn_l"> 
			<input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="Save" onclick="f_save();"/></span> 
			<span class="btn_r btn_l"> 
			 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

			<input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="Send E-Mail" onclick="f_email();"/></span> 
			 -->
			<span class="btn_r btn_l"> 
			<input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="Print" onclick="f_print();"/></span> 
		</p>
	</div>	
	<!-- 버튼 E -->  
</div>
</body>
<input type="hidden" name="h_lower" value="" />
<input type="hidden" name="h_upper" value="" /> 
<script src="<%=xjos %>/xjos.js" language="JScript"/></script>
</html>

