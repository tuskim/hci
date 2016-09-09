<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html xmlns="http://www.w3.org/1999/xhtml">
<%--
/*
 *************************************************************************
 * @source  : docPrint.jsp
 * @desc    : docPrint Test
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2010.09.29 노태훈       신규작성
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
<title>PT-MPP System</title> 
<head>
<%
	String year  	   = LDateUtils.getDate("yyyy"); 
	String prevDate	   = LDateUtils.getDate("yyyy/MM/") +"01"; 
	String currentDate = LDateUtils.getDate("yyyy/MM/dd");          // currentDate
%>
<script language="javascript"> 
 
function init(){  

	f_setData();			 							
}

function f_refresh(){
	location.reload();     
}
//-------------------------------------------------------------------------
// Set header
//-------------------------------------------------------------------------
function f_setData(){ 
	//cfCopyDataSet(opener.ds_attr2,ds_typeClass); 
	cfCopyDataSet(opener.ds_costTotMst,ds_main);
 
	gr_main.ReDraw="false"; 
	gr_main.ColumnProp("deptCd","name") = opener.gr_costTotMst.ColumnProp('deptCd','name');	
	gr_main.ColumnProp("deptNm","name") = opener.gr_costTotMst.ColumnProp('deptNm','name');	
	gr_main.ColumnProp("docSeq","name") = opener.gr_costTotMst.ColumnProp('docSeq','name');	
	gr_main.ColumnProp("docType","name") = opener.gr_costTotMst.ColumnProp('docType','name');
	gr_main.ColumnProp("amount","name") = opener.gr_costTotMst.ColumnProp('amount','name');	
	gr_main.ColumnProp("progStatus","name") = opener.gr_costTotMst.ColumnProp('progStatus','name');	
	gr_main.ColumnProp("progStatusNm","name") = opener.gr_costTotMst.ColumnProp('progStatusNm','name');	
	gr_main.ColumnProp("attr2","name") = opener.gr_costTotMst.ColumnProp('attr2','name');			
	gr_main.ColumnProp("sapDocSeq","name") = opener.gr_costTotMst.ColumnProp('sapDocSeq','name');		
	gr_main.ColumnProp("sapCancelDocSeq","name") = opener.gr_costTotMst.ColumnProp('sapCancelDocSeq','name');		
	gr_main.ColumnProp("currencyCd","name") = opener.gr_costTotMst.ColumnProp('currencyCd','name');		
	gr_main.ColumnProp("createDate","name") = opener.gr_costTotMst.ColumnProp('createDate','name');		
	gr_main.ColumnProp("docDate","name") = opener.gr_costTotMst.ColumnProp('docDate','name');		
	gr_main.ColumnProp("postDate","name") = opener.gr_costTotMst.ColumnProp('postDate','name');		
	gr_main.ColumnProp("successType","name") = opener.gr_costTotMst.ColumnProp('successType','name');		
	gr_main.ColumnProp("workType","name") = opener.gr_costTotMst.ColumnProp('workType','name');		
	gr_main.ColumnProp("vendCd","name") = opener.gr_costTotMst.ColumnProp('vendCd','name');			
	gr_main.ColumnProp("postYm","name") = opener.gr_costTotMst.ColumnProp('postYm','name');	
	gr_main.ReDraw="true";	
}

//-------------------------------------------------------------------------
// 전표 출력
//-------------------------------------------------------------------------
function f_report_page()
{  
	if(!ds_main.IsUpdated){
		alert("<%=source.getMessage("dev.msg.fi.selectOne")%>");
		return;
	}
    var strHeader  = "companyCd:STRING(200),deptCd:STRING(200),userId:STRING(200),docYm:STRING(200),docSeq:STRING(200),userNm:STRING(200),lang:STRING(200)";
   	ds_dummy.SetDataHeader(strHeader);
   	for(var i=1;i<=ds_main.CountRow;i++){
   		if(ds_main.NameValue(i,"chkUpdate")=="T"){   		
			ds_dummy.AddRow();
		   	ds_dummy.NameValue(ds_dummy.RowPosition,"docYm") = ds_main.NameValue(i,"docYm");
            ds_dummy.NameValue(ds_dummy.RowPosition,"docSeq") = ds_main.NameValue(i,"docSeq");
   		}
   	}
   	
	tr_cudPageReport.Action   = "/fi.ar.retrieveDocPrintWebPopListOutPut.gau";
	tr_cudPageReport.KeyValue = "Servlet(I:ds_dummy=ds_dummy,O:ds_report=ds_report )";	
	tr_cudPageReport.Post(); 	 
}
 
</script> 

<%----------------------------------------------------------------------------------------------------
 Gauce obj  정의
---------------------------------------------------------------------------------------------------- --%>

<object id="ds_main" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/> 
</object> 

<object id="ds_typeClass" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/> 
</object>  

<object id="ds_report" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/> 
</object> 

<object id="ds_dummy" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/> 
</object>  

<object id=tr_cudPageReport classid="<%=LGauceId.TR%>">
    <param name="KeyName" value="toinb_dataid4"> 
</object>
 
<%----------------------------------------------------------------------------------------------------
 Gauce obj  event  정의
------------------------------------------------------------------------------------------------------%>
<script language=JavaScript for=ds_main event=OnLoadStarted()>
  cfShowDSWaitMsg(gd_main);//progress bar 보이기
  cfHideNoDataMsg(gd_main);//no data 메시지 숨기기
</script>

<!-- Hub In Header 조회 DataSet -->
<script language=JavaScript for=ds_main event=OnLoadCompleted(rowCnt)>
  cfHideDSWaitMsg(gd_main);//progress bar 숨기기
  cfFillGridNoDataMsg(gd_main,"gridColLineCnt=2");//no data found   
</script>
 
<script language=JavaScript for="ds_main" event=OnRowPosChanged(row)>
	//opener.ds_costTotMst.RowPosition =row;
		 
</script>

<script language=JavaScript for=gd_main event=OnSetFocus()>
 
</script>

<script language=JavaScript for=ds_main event=OnColumnChanged(row,colid)>
 
</script>

<script language=JavaScript for=ds_main event=CanRowPosChange(row)> 
 
</script>


<script language="javascript"  for=gr_main event=OnHeadCheckClick(Col,Colid,bCheck)>
	gr_main.Redraw="false";
	if(bCheck == "0"){//uncheck
		for(var i=1; i <= ds_main.countRow; i++){
			ds_main.Namevalue(i,"chkUpdate") = "F";
		}
	}else{//check
		for(var i=1; i <= ds_main.countRow; i++){
			ds_main.NameValue(i,"chkUpdate") = "T";	
		}
	}
	gr_main.Redraw="true";	
</script> 
<%----------------------------------------------------------------------------------------------------
 Gauce obj  event TR  정의
------------------------------------------------------------------------------------------------------%> 
<script language=JavaScript for=tr_cudPageReport event=OnFail()> 	
    mode = "";
    if(tr_cudPageReport.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
        window.parent.location.href = "/index.jsp";    
    }
    
    alert(tr_cudPageReport.ErrorMsg);
</script>   
 
<script language=JavaScript for=tr_cudPageReport event=OnSuccess()> 
 
 	report_page.Preview(); 	 
</script> 
<%----------------------------------------------------------------------------------------------------
 UI  정의
---------------------------------------------------------------------------------------------------- --%>
</head>

<body onload="init();">

<div id="conts_box_pop">
	<h2> <span> Doc Print List For Web </span></h2>
	<!--검색 S -->	 

	<!-- 그리드 S -->	
	<object id="gr_main" classid="<%=LGauceId.GRID %>" style="width:100%;height:198px;" class="comn">
		<param Name="DataID" 			value='ds_main'>
	    <Param name="AutoResizing"      value=true>
	    <param name="ColSizing"         value=true> 
	    <Param name="SortView"          value="right"> 
	    <param name="Editable"          value=True>
	    <param name=ViewSummary         value="1">
	    <param name="UsingOneClick"     value=1> 
		<param Name='Format'
			value='
           		<C> id=chkUpdate         	 align="center"   width="23"    Edit="true	" HeadCheck=false  HeadCheckShow=true   Editstyle=check</C>
                <C> id=docSeq      		     align="center"   width="75"    Edit="none"   show="true" sort=true</C>  
                <C> id=progStatusNm 	     align="left"     width="100"    Edit="none"   show="true" sort=true</C> 
                <C> id=sapDocSeq   		     align="center"   width="105"   Edit="none"   show="true" sort=true</C> 
                <C> id=amount      		     align="right"    width="110"    Edit="none"   show="true"  sumtext="@sum", sumbgcolor="#ECE6DE" sumcolor="#666666" dec=2 </C>
                <C> id=currencyCd  		     align="center"   width="75"    Edit="none"   show="true" sort=true</C> 
                <C> id=docDate     		     align="center"   width="90"    Edit="none"   show="true" sort=true</C>
                <C> id=postDate    		     align="center"   width="100"    Edit="none"   show="true" sort=true</C> 
	      '>
	</object>

 	</div> 
	<!-- 그리드 E -->	
	<!-- 버튼 S -->	
	<div id="btn_area">
		<p class="b_right">
			<span class="btn_r btn_l"> 
			<input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnRefresh%>" onclick="f_refresh();"/></span> 		
			<span class="btn_r btn_l"> 
			<input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnSinglePrint%>" onclick="f_report_page();"/></span> 
		</p>
	</div>	
	<!-- 버튼 E -->  
</div>
<comment id="__NSID__">
<object id="report_page" classid="<%=LGauceId.REPORTS%>"> 
    <param name="DetailDataID"      value="ds_report">
    <param name="MasterDataID"      value="">    
    <param name="PaperSize"         value="A4">
    <param name="Landscape"         value="true">
    <param name="PrintSetupDlgFlag" value="true">
    <param name="SuppressColumns"   value="1:PageSkip,docYmSeq">	
    <param name="PageSkip"   value="true">
	<param name="format"
		value="
<B>id=Header ,left=0,top=0 ,right=2871 ,bottom=532 ,face='Tahoma' ,size=10 ,penwidth=1
	<X>left=2019 ,top=143 ,right=2257 ,bottom=180 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=2257 ,top=143 ,right=2495 ,bottom=180 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=2495 ,top=143 ,right=2733 ,bottom=180 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=2495 ,top=16 ,right=2733 ,bottom=53 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=2257 ,top=16 ,right=2495 ,bottom=53 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=2019 ,top=16 ,right=2257 ,bottom=53 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='' ,left=286 ,top=19 ,right=323 ,bottom=69 ,align='left' ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='USER-ID' ,left=87 ,top=19 ,right=286 ,bottom=69 ,align='left' ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='Run Date' ,left=87 ,top=69 ,right=286 ,bottom=119 ,align='left' ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='' ,left=286 ,top=69 ,right=323 ,bottom=119 ,align='left' ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='Run Time' ,left=87 ,top=116 ,right=286 ,bottom=167 ,align='left' ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='' ,left=286 ,top=116 ,right=323 ,bottom=167 ,align='left' ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<C>id='docSeq', left=320, top=164, right=751, bottom=220, align='left', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<T>id='' ,left=280 ,top=164 ,right=318 ,bottom=220 ,align='left' ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='Sap Doc No' ,left=87 ,top=217 ,right=286 ,bottom=270 ,align='left' ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='Web Doc No' ,left=87 ,top=164 ,right=286 ,bottom=220 ,align='left' ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='Department' ,left=87 ,top=267 ,right=286 ,bottom=323 ,align='left' ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='' ,left=283 ,top=217 ,right=320 ,bottom=270 ,align='left' ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='' ,left=283 ,top=267 ,right=320 ,bottom=323 ,align='left' ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<C>id='sapDocSeq', left=318, top=217, right=749, bottom=270, align='left', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<C>id='userDept', left=318, top=267, right=749, bottom=323, align='left', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<T>id='Page :' ,left=2474 ,top=270 ,right=2590 ,bottom=325 ,align='left' ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='#p  /  #t' ,left=2588 ,top=270 ,right=2733 ,bottom=325 ,align='left' ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<L> left=87 ,top=328 ,right=2736 ,bottom=328 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='Po No' ,left=90 ,top=333 ,right=397 ,bottom=384 ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='So No' ,left=90 ,top=381 ,right=397 ,bottom=431 ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Type' ,left=90 ,top=429 ,right=397 ,bottom=479 ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Internal Order' ,left=90 ,top=476 ,right=397 ,bottom=527 ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Vender/Customer' ,left=407 ,top=333 ,right=955 ,bottom=384 ,align='left' ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='Cucy' ,left=1278 ,top=333 ,right=1373 ,bottom=384 ,align='left' ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='Amount' ,left=1474 ,top=333 ,right=1701 ,bottom=384 ,align='right' ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='Baseline Date' ,left=1474 ,top=381 ,right=1701 ,bottom=431 ,align='right' ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='Due Date' ,left=1474 ,top=429 ,right=1701 ,bottom=479 ,align='right' ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='Quantity' ,left=1474 ,top=476 ,right=1701 ,bottom=527 ,align='right' ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='Account' ,left=1709 ,top=384 ,right=2241 ,bottom=434 ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Debit' ,left=1715 ,top=479 ,right=1969 ,bottom=529 ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1704 ,top=474 ,right=2244 ,bottom=474 </L>
	<T>id='Credit' ,left=1984 ,top=479 ,right=2236 ,bottom=529 ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1974 ,top=476 ,right=1974 ,bottom=532 </L>
	<T>id='Document Date' ,left=2318 ,top=331 ,right=2569 ,bottom=381 ,align='left' ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='Tot.Li' ,left=2566 ,top=333 ,right=2731 ,bottom=381 ,align='left' ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='Doc.No.' ,left=2566 ,top=378 ,right=2731 ,bottom=429 ,align='left' ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='Reverse' ,left=2566 ,top=426 ,right=2731 ,bottom=476 ,align='left' ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='Entry Date' ,left=2318 ,top=378 ,right=2569 ,bottom=429 ,align='left' ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='Posting Date' ,left=2318 ,top=426 ,right=2569 ,bottom=476 ,align='left' ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='LI' ,left=2249 ,top=392 ,right=2307 ,bottom=437 ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='PK' ,left=2249 ,top=458 ,right=2307 ,bottom=503 ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Total Amount' ,left=2318 ,top=474 ,right=2731 ,bottom=524 ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=87 ,top=532 ,right=2736 ,bottom=532 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='Unit' ,left=1278 ,top=476 ,right=1373 ,bottom=527 ,align='left' ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='Profit Center' ,left=407 ,top=429 ,right=958 ,bottom=479 ,align='left' ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='text' ,left=407 ,top=476 ,right=960 ,bottom=527 ,align='left' ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='Tax' ,left=955 ,top=386 ,right=1093 ,bottom=431 ,align='left' ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='Material' ,left=955 ,top=429 ,right=1093 ,bottom=479 ,align='left' ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<L> left=2244 ,top=328 ,right=2244 ,bottom=532 </L>
	<L> left=2736 ,top=328 ,right=2736 ,bottom=532 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1704 ,top=328 ,right=1704 ,bottom=532 </L>
	<L> left=2310 ,top=328 ,right=2310 ,bottom=532 </L>
	<L> left=397 ,top=331 ,right=397 ,bottom=532 </L>
	<L> left=87 ,top=328 ,right=87 ,bottom=532 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='runTime', left=320, top=116, right=751, bottom=167, align='left' ,mask='XX:XX:XX', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<C>id='runDate', left=320, top=69, right=751, bottom=119, align='left' ,mask='XXXX.XX.XX', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<C>id='userNm', left=320, top=19, right=751, bottom=69, align='left', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<C>id='docType', left=1148, top=138, right=1717, bottom=204</C>
	<T>id='Document List' ,left=1151 ,top=26 ,right=1720 ,bottom=116 ,face='Tahoma' ,size=22 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2019 ,top=143 ,right=2733 ,bottom=143 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2019 ,top=16 ,right=2019 ,bottom=267 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2019 ,top=267 ,right=2733 ,bottom=267 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2019 ,top=16 ,right=2733 ,bottom=16 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2019 ,top=53 ,right=2733 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2019 ,top=180 ,right=2733 ,bottom=180 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='M/DTR' ,left=2537 ,top=19 ,right=2704 ,bottom=50 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='Received' ,left=2058 ,top=146 ,right=2223 ,bottom=177 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='Assist ' ,left=2299 ,top=146 ,right=2463 ,bottom=177 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='MGR' ,left=2540 ,top=146 ,right=2701 ,bottom=177 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=2495 ,top=16 ,right=2495 ,bottom=267 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2257 ,top=16 ,right=2257 ,bottom=267 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2733 ,top=16 ,right=2733 ,bottom=267 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='Acct.Assist' ,left=2066 ,top=19 ,right=2228 ,bottom=50 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='Acct.MGR' ,left=2291 ,top=19 ,right=2455 ,bottom=50 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=201 ,face='Tahoma' ,size=10 ,penwidth=1
	<L> left=1974 ,top=143 ,right=1974 ,bottom=201 </L>
	<L> left=1704 ,top=0 ,right=1704 ,bottom=201 </L>
	<L> left=87 ,top=201 ,right=2310 ,bottom=201 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2736 ,top=0 ,right=2736 ,bottom=201 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2310 ,top=0 ,right=2310 ,bottom=201 </L>
	<L> left=2244 ,top=0 ,right=2244 ,bottom=201 </L>
	<L> left=87 ,top=0 ,right=87 ,bottom=201 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=397 ,top=0 ,right=397 ,bottom=201 </L>
	<C>id='totAmt', left=2315, top=148, right=2733, bottom=198, align='right', supplevel=1, face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2, Decao=2</C>
	<C>id='reverseWith', left=2516, top=101, right=2733, bottom=151, align='right', supplevel=1, face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2</C>
	<C>id='postDate', left=2315, top=101, right=2519, bottom=151, align='left', supplevel=1 ,mask='XXXX.XX.XX', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2</C>
	<C>id='cLocalAmt', left=1979, top=148, right=2241, bottom=198, align='right', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2, Decao=2</C>
	<C>id='dLocalAmt', left=1709, top=148, right=1971, bottom=198, align='right', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2, Decao=2</C>
	<L> left=1704 ,top=143 ,right=2244 ,bottom=143 </L>
	<C>id='dGlAccountDec', left=1709, top=53, right=2241, bottom=103, align='left', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='materialNo', left=950, top=101, right=1400, bottom=151, align='left', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2</C>
	<C>id='unit', left=1283, top=148, right=1400, bottom=198, align='left', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2</C>
	<C>id='qty', left=1397, top=148, right=1701, bottom=198, align='right', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2, Decao=2</C>
	<C>id='dueDate', left=1397, top=101, right=1701, bottom=151, align='right' ,mask='XXXX.XX.XX', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2</C>
	<C>id='cTaxCd', left=950, top=56, right=1400, bottom=103, align='left', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2</C>
	<C>id='baselineDate', left=1397, top=53, right=1701, bottom=103, align='right' ,mask='XXXX.XX.XX', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2</C>
	<C>id='docDesc', left=402, top=148, right=1286, bottom=198, align='left', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2</C>
	<C>id='costCenterNm', left=402, top=101, right=953, bottom=151, align='left', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2</C>
	<C>id='interOrder', left=93, top=148, right=394, bottom=198, face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='type', left=93, top=101, right=394, bottom=151, face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='soNo', left=93, top=53, right=394, bottom=103, face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='docDate', left=2315, top=5, right=2519, bottom=56, align='left', supplevel=1 ,mask='XXXX.XX.XX', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2</C>
	<C>id='totLiqty', left=2516, top=5, right=2733, bottom=56, align='right', supplevel=1, face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2, Decao=2</C>
	<L> left=2310 ,top=0 ,right=2736 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 ,supplevel=1 </L>
	<C>id='cVendorCustumer', left=402, top=5, right=1286, bottom=56, align='left', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2</C>
	<C>id='currencyCd', left=1283, top=5, right=1400, bottom=56, align='left', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2</C>
	<C>id='amount', left=1397, top=5, right=1701, bottom=56, align='right', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2, Decao=2</C>
	<C>id='dGlAccount', left=1709, top=5, right=2241, bottom=56, align='left', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=87 ,top=0 ,right=2312 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='poNo', left=93, top=5, right=394, bottom=56, face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cGlAccount', left=1709, top=5, right=2241, bottom=56, align='right', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cGlAccountDec', left=1709, top=53, right=2241, bottom=103, align='right', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='docNum', left=2249, top=53, right=2307, bottom=101, face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='postKey', left=2249, top=103, right=2307, bottom=148, face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='regdate', left=2315, top=53, right=2519, bottom=103, align='left', supplevel=1 ,mask='XXXX.XX.XX', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2</C>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2871 ,bottom=50 ,face='Tahoma' ,size=10 ,penwidth=1
	<C>id='debitQty', left=1709, top=5, right=1971, bottom=48, align='right', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Decao=2</C>
	<T>id='Total Amount' ,left=1463 ,top=5 ,right=1701 ,bottom=48 ,align='right' ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=2</T>
	<C>id='totLiqty', left=1151, top=5, right=1466, bottom=48, face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Decao=2</C>
	<T>id='Total LI Qy. : ' ,left=958 ,top=5 ,right=1151 ,bottom=48 ,align='left' ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=2</T>
	<T>id='1' ,left=614 ,top=5 ,right=960 ,bottom=48 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Total Doc.Qy :' ,left=405 ,top=5 ,right=616 ,bottom=48 ,align='left' ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=2</T>
	<C>id='creditQty', left=1979, top=5, right=2241, bottom=48, align='right', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Decao=2</C>
	<L> left=87 ,top=0 ,right=2736 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=87 ,top=0 ,right=87 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=87 ,top=50 ,right=2736 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2736 ,top=0 ,right=2736 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>




			        ">
	</object>
	</comment>
	<SCRIPT>__WS__(__NSID__);</SCRIPT>
</body> 
<script src="<%=xjos %>/xjos.js" language="JScript"/></script>
</html>

