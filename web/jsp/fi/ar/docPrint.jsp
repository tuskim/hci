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
<title>PT-PAM System</title> 
<head>
<%
	String year  	   = LDateUtils.getDate("yyyy"); 
	String prevDate	   = LDateUtils.getDate("yyyy/MM/") +"01"; 
	String currentDate = LDateUtils.getDate("yyyy/MM/dd");          // currentDate
	
	String progCd 	   = request.getParameter("progCd");
%>
<script language="javascript"> 

function init(){ 
	f_setData();
}

//-------------------------------------------------------------------------
// Set header
//-------------------------------------------------------------------------
function f_setData(){ 
	ds_vendor.DataId="cm.cm.retrieveCommComboVendorList.gau?firstVal=Total";
	ds_vendor.Reset();
	ds_customer.DataId="cm.cm.retrieveCommComboVendorList.gau?firstVal=Total";
	ds_customer.Reset();	
	ds_docType.DataId="fi.ar.retrieveDocTypeWebComboList.gau";
	ds_docType.Reset();	
	ds_currCd.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2004";
	ds_currCd.Reset();			 
	//cfUnionBlank(ds_vendor,lc_vendor,"code","name","--Total--"); 	
	cfUnionBlank(ds_docType,lc_docType,"code","name","--Total--"); 
	//cfUnionBlank(ds_customer,lc_customer,"code","name","--Total--");
	
	//iv document print 메뉴일 경우 doctype, RE로 고정 
	<% if("PO0017".equals(progCd)) { %>
	ds_docType.RowPosition = ds_docType.NamevalueRow("code","RE") ;
	lc_docType.Enable             = false;
	<% } %>
}
//-------------------------------------------------------------------------
// 조회
//-------------------------------------------------------------------------
function f_retrieve(){ 
	if(doc_year.value==""){
		alert("<%=source.getMessage("dev.warn.com.input",columnData.getString("docYear"))%>");
		return;
	}
	var v_url = new cfURI();
	v_url.Add("docYear",doc_year.value);
	v_url.Add("customer",ds_customer.NameValue(ds_customer.RowPosition,"code")); 
	v_url.Add("vendor",ds_vendor.NameValue(ds_vendor.RowPosition,"code")); 
	v_url.Add("docType",ds_docType.NameValue(ds_docType.RowPosition,"code")); 
	v_url.Add("postFromDate",postFromDate.value); 	 
	v_url.Add("postToDate",postToDate.value); 	 
	v_url.Add("docFromDate",docFromDate.value); 	 
	v_url.Add("docToDate",docToDate.value); 	 			
	v_url.SetPage("fi.ar.retrieveDocPrintList.gau");
	ds_main.DataId = v_url.GetURI();
	ds_main.Reset();  
}
//-------------------------------------------------------------------------
// AddRow
//-------------------------------------------------------------------------
function f_Add(){ 
 
}
 
//-------------------------------------------------------------------------
// DeleteRow
//-------------------------------------------------------------------------
function f_Del(){ 
 
}
//-------------------------------------------------------------------------
// Total Save
//-------------------------------------------------------------------------
function f_save()
{ 
	if(!ds_main.IsUpdated) {
		alert("<%=source.getMessage("dev.inf.com.nochange")%>");
		return;
	}
 	 
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
    var strHeader  = "fiscalYear:STRING(50),docNo:STRING(50)";
   	ds_dummy.SetDataHeader(strHeader);
   	for(var i=1;i<=ds_main.CountRow;i++){
   		if(ds_main.NameValue(i,"chk")=="T"){   		
			ds_dummy.AddRow();
		   	ds_dummy.NameValue(ds_dummy.RowPosition,"fiscalYear") = ds_main.NameValue(i,"fiscalYear");   	
	   		ds_dummy.NameValue(ds_dummy.RowPosition,"docNo")   = ds_main.NameValue(i,"docNo");   		   	
   		}
   	}
   	
	tr_cudPageReport.Action   = "/fi.ar.retrieveDocPrintListOutPut.gau";
	tr_cudPageReport.KeyValue = "Servlet(I:ds_dummy=ds_dummy,O:ds_report=ds_report )";	
	tr_cudPageReport.Post(); 	 
}

function f_report_list()
{  
	if(!ds_main.IsUpdated){
		alert("<%=source.getMessage("dev.msg.fi.selectOne")%>");
		return;
	}
    var strHeader  = "fiscalYear:STRING(50),docNo:STRING(50)";
   	ds_dummy.SetDataHeader(strHeader);
   	for(var i=1;i<=ds_main.CountRow;i++){
   		if(ds_main.NameValue(i,"chk")=="T"){   		
			ds_dummy.AddRow();
		   	ds_dummy.NameValue(ds_dummy.RowPosition,"fiscalYear") = ds_main.NameValue(i,"fiscalYear");   	
	   		ds_dummy.NameValue(ds_dummy.RowPosition,"docNo")   = ds_main.NameValue(i,"docNo");   		   	
   		}
   	}
   	
	tr_cudListReport.Action   = "/fi.ar.retrieveDocPrintListOutPut.gau";
	tr_cudListReport.KeyValue = "Servlet(I:ds_dummy=ds_dummy,O:ds_report=ds_report )";	
	tr_cudListReport.Post();
	
}
 
</script> 

<%----------------------------------------------------------------------------------------------------
 Gauce obj  정의
---------------------------------------------------------------------------------------------------- --%>

<object id="ds_main" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/> 
</object> 

<object id="ds_customer" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/> 
</object> 

<object id="ds_docType" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/> 
</object> 

<object id="ds_vendor" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/> 
</object> 
 
<object id="ds_report" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/> 
</object>  

<object id="ds_currCd" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/> 
</object>   
 
<object id="ds_dummy" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/> 
</object>  

<object id=tr_cudPageReport classid="<%=LGauceId.TR%>">
    <param name="KeyName" value="toinb_dataid4"> 
</object>

<object id=tr_cudListReport classid="<%=LGauceId.TR%>">
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
		 
</script>

<script language=JavaScript for=gd_main event=OnSetFocus()>
 
</script>

<script language=JavaScript for=ds_main event=OnColumnChanged(row,colid)>
 
</script>

<script language=JavaScript for=ds_main event=CanRowPosChange(row)> 
 
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

<script language=JavaScript for=tr_cudListReport event=OnFail()> 	
    mode = "";
    if(tr_cudListReport.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
        window.parent.location.href = "/index.jsp";    
    }
    
    alert(tr_cudListReport.ErrorMsg);
</script> 

<script language=JavaScript for=tr_cudListReport event=OnSuccess()> 
 	report_list.Preview(); 	 
</script>
 
<script language=JavaScript for=tr_cudPageReport event=OnSuccess()> 
 	report_page.Preview(); 	 
</script> 
<%----------------------------------------------------------------------------------------------------
 UI  정의
---------------------------------------------------------------------------------------------------- --%>
</head>

<body id="cent_bg" onload="init();">
<div id="conts_box">
	<h2> <span> <%=columnData.getString("page_title") %>  </span></h2>
	<!--검색 S -->	 
	<fieldset class="boardSearch"> 
	<div>
		<dl>
			<dt> 
				<table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board2" />
	  				<colgroup>
						<col width="11%"/>
						<col width="15%"/>
						<col width="11%"/>
						<col width="15%"/>						
						<col width="12%"/>
						<col width=""/>	 
					</colgroup>
	  				<tr>
  						<th><%=columnData.getString("docYear") %>  </th>
  						<td><input type="text" style="width:80px;" id="doc_year" value="<%= year%>" maxlength="4"/>
						</td>	
  						<th><%=columnData.getString("vendor") %>  </th>
  						<td><comment id="__NSID__"><object id="lc_vendor"  classid="<%=LGauceId.LUXECOMBO%>" width="90">
							<param name="ComboDataID"       value="ds_vendor">
							<param name="ListCount"     	value="10">
							<param name=SearchColumn		value="name">
							<param name="BindColumn"    	value="code">
							<param name=ListExprFormat		value="name^0^150,code^0^70"> 
							<param name=index           	value=0>
							</object></comment><script>__WS__(__NSID__); </script>
						</td>									
  						<th><%=columnData.getString("docDate") %> </th>
  						<td> <input type="text" style="width:70px;" id="docFromDate" value="<%= prevDate %>"  onblur="valiDate(this);"/>
							<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="" onclick="javascript:OpenCalendar(docFromDate);" class="button_cal"/> ~ <input type="text" style="width:70px;" id="docToDate" value="<%= currentDate %>" onblur="valiDate(this);" />
							<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="" onclick="javascript:OpenCalendar(docToDate);" class="button_cal"/> </td>	
						
					</tr> 
	  				<tr>
  						<th><%=columnData.getString("docType") %>  </th>
  						<td><comment id="__NSID__"><object id="lc_docType"  classid="<%=LGauceId.LUXECOMBO%>" width="90">
							<param name="ComboDataID"       value="ds_docType">
							<param name="ListCount"     	value="10">
							<param name=SearchColumn		value="name">
							<param name="BindColumn"    	value="code">
							<param name=ListExprFormat		value="name^0^150,code^0^70"> 
							<param name=index           	value=0>
							</object></comment><script>__WS__(__NSID__); </script>
						</td>		

  						<th><%=columnData.getString("customer") %>  </th>
  						<td><comment id="__NSID__"><object id="lc_customer"  classid="<%=LGauceId.LUXECOMBO%>" width="90">
							<param name="ComboDataID"       value="ds_customer">
							<param name="ListCount"     	value="10">
							<param name=SearchColumn		value="name">
							<param name="BindColumn"    	value="code">
							<param name=ListExprFormat		value="name^0^150,code^0^70"> 
							<param name=index           	value=0>
							</object></comment><script>__WS__(__NSID__); </script>
						</td>	
						<th><%=columnData.getString("postDate") %> </th>
  						<td> <input type="text" style="width:70px;" id="postFromDate" value="""/>
							<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="" onclick="javascript:OpenCalendar(postFromDate);" class="button_cal"/> ~ <input type="text" style="width:70px;" id="postToDate" value=""/>
							<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="" onclick="javascript:OpenCalendar(postToDate);" class="button_cal"/> </td>														
					</tr>   										
				</table>
			</dt>              		  	   	 	
			<dd class="btnseat2"> 
				<span class="search_btn2_r search_btn2_l">
					<input type="button" onfocus="blur();" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='#e2ebf7'" value="<%=btnSearch %>" onclick="f_retrieve();"/>
				</span> 
			</dd>						
		</dl>
	</div>
	</fieldset>
	<!--검색 E -->		
	<div class="sub_stitle"> <p><%=columnData.getString("sub1_title") %>  </p> </div>        	
	<!-- 그리드 S -->	
	<div> 
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
					<comment id="__NSID__">
						<object id="gd_main" classid="<%=LGauceId.GRID %>" class="comn" style="width:100%;height:282px">			        >
							<param name="DataID"              value="ds_main"> 
							<param name="Editable"            value="true"> 
							<param name="MultiRowSelect"      value="false"/> 
							<param name="SortView"            value="Left"/>	
						    <param name="UsingOneClick"       value="1"/>													
							<param name="Format"              value=" 
							<C>id='chk'		     name='' editstyle='checkbox' width='30'	        Edit='true'	align=center </c>							 
							<C>id='docType'      name='<%=columnData.getString("docType") %>'       Edit='none'  width='80' align='center'   </c>
							<C>id='docNo'        name='<%=columnData.getString("docNo") %>'         Edit='none'  width='80' align='center'   </c> 
							<C>id='docDate'      name='<%=columnData.getString("docDate") %>'       Edit='none'  width='80' align='center' mask='XXXX/XX/XX'  </c>
							<C>id='postDate'     name='<%=columnData.getString("postDate") %>'      Edit='none'  width='80' align='center' mask='XXXX/XX/XX'  </c>							
							<C>id='curr'         name='<%=columnData.getString("curr") %>'          editstyle='lookup' Data='ds_currCd:code:name:code' Edit='none' ListWidth=200 width='80' align='center'   </c>
							<C>id='docAmt'       name='<%=columnData.getString("docAmt") %>'        Edit='none'  width='120' align='right'  decao=2 </c>
							<C>id='localAmt'     name='<%=columnData.getString("localAmt") %>'      Edit='none'  width='120' align='right'  decao=2 </c>
							<C>id='headerDesc'   name='<%=columnData.getString("headerDesc") %>'    Edit='none'  width='200' align='left'   </c>
							<C>id='reverseWith'  name='<%=columnData.getString("ReverseWith") %>'   Edit='none'  width='80' align='center'   </c>
							<C>id='taxCd'        name='<%=columnData.getString("taxCd") %>'         Edit='none'  width='80' align='center'   </c>
							<C>id='customer'     name='<%=columnData.getString("customer") %>'      Edit='none'  width='100' align='left'   </c>
							<C>id='vendor'       name='<%=columnData.getString("vendor") %>'        editstyle='lookup' data='ds_vendor:code:name:code'  Edit='none' ListWidth=200  width='100' align='left'   </c>		 
							"/>
						</object>
					</comment><script>__WS__(__NSID__);</script>
				</td>
			</tr>
		</table>
	</div>
 
	<!-- 그리드 E -->	
	<!-- 버튼 S -->	
	<div id="btn_area">
		<p class="b_right">
			<span class="btn_r btn_l"> 
			<input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnSinglePrint%>" onclick="f_report_page();"/></span> 
			<span class="btn_r btn_l"> 
			<input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnListPrint%>" onclick="f_report_list();"/></span>
		</p>
	</div>	
	<!-- 버튼 E -->  
</div>
<comment id="__NSID__">
<object id="report_page" classid="<%=LGauceId.REPORTS%>">
	<param name="DetailDataID" value="ds_report">
	<PARAM NAME="PaperSize" VALUE="A4">
	<PARAM NAME="Landscape" VALUE="true">
	<PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PrintMargine" VALUE="false">
	<param name="EnableFontFace" value="true">
    <param name="SuppressColumns"   value="1:PageSkip,docNo">	
	<param name="EnglishUI" value="true"> 
	<param name="format"
		value="
<B>id=Header ,left=0,top=0 ,right=2871 ,bottom=532 ,face='Tahoma' ,size=10 ,penwidth=1
	<T>id='' ,left=286 ,top=19 ,right=323 ,bottom=69 ,align='left' ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='USER-ID' ,left=87 ,top=19 ,right=286 ,bottom=69 ,align='left' ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='Department' ,left=87 ,top=267 ,right=286 ,bottom=323 ,align='left' ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='' ,left=283 ,top=267 ,right=320 ,bottom=323 ,align='left' ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<C>id='deptCd', left=318, top=267, right=749, bottom=323, align='left', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
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
	<T>id='Document Date' ,left=2320 ,top=331 ,right=2572 ,bottom=381 ,align='left' ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='Tot.Li' ,left=2566 ,top=333 ,right=2731 ,bottom=381 ,align='left' ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='Sap Doc.No.' ,left=2529 ,top=378 ,right=2731 ,bottom=429 ,align='left' ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='Reverse' ,left=2566 ,top=426 ,right=2731 ,bottom=476 ,align='left' ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='Web Doc No.' ,left=2318 ,top=378 ,right=2532 ,bottom=429 ,align='left' ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
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
	<C>id='userNm', left=320, top=19, right=751, bottom=69, align='left', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<T>id='' ,left=286 ,top=169 ,right=323 ,bottom=220 ,align='left' ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<C>id='runTime', left=320, top=169, right=751, bottom=220, align='left' ,mask='XX:XX:XX', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<T>id='Run Time' ,left=87 ,top=169 ,right=286 ,bottom=220 ,align='left' ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<C>id='runDate', left=320, top=95, right=751, bottom=146, align='left' ,mask='XXXX.XX.XX', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<T>id='' ,left=286 ,top=95 ,right=323 ,bottom=146 ,align='left' ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='Run Date' ,left=87 ,top=95 ,right=286 ,bottom=146 ,align='left' ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<X>left=2021 ,top=26 ,right=2741 ,bottom=265 ,border=true ,penstyle=solid ,penwidth=2</X>
	<L> left=2500 ,top=26 ,right=2500 ,bottom=262 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2262 ,top=26 ,right=2262 ,bottom=262 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2021 ,top=130 ,right=2738 ,bottom=130 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='Assist' ,left=2066 ,top=53 ,right=2217 ,bottom=103 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='MGR' ,left=2305 ,top=53 ,right=2455 ,bottom=103 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='M/DTR' ,left=2545 ,top=53 ,right=2696 ,bottom=103 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='cDocType', left=979, top=164, right=1929, bottom=230</C>
	<T>id='Document List' ,left=982 ,top=53 ,right=1929 ,bottom=143 ,face='Tahoma' ,size=22 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
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
	<C>id='docNo', left=2516, top=53, right=2733, bottom=103, align='right', supplevel=1, face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2</C>
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
	<C>id='text', left=402, top=148, right=1286, bottom=198, align='left', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2</C>
	<C>id='cProfitCenter', left=402, top=101, right=953, bottom=151, align='left', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2</C>
	<C>id='interOrder', left=93, top=148, right=394, bottom=198, face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='type', left=93, top=101, right=394, bottom=151, face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='soNo', left=93, top=53, right=394, bottom=103, face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='totLineItem', left=2516, top=5, right=2733, bottom=56, align='right', supplevel=1, face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2</C>
	<L> left=2310 ,top=0 ,right=2736 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 ,supplevel=1 </L>
	<C>id='cVendorCustumer', left=402, top=5, right=1286, bottom=56, align='left', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2</C>
	<C>id='curr', left=1283, top=5, right=1400, bottom=56, align='left', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2</C>
	<C>id='docAmt', left=1397, top=5, right=1701, bottom=56, align='right', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2, Decao=2</C>
	<C>id='dGlAccount', left=1709, top=5, right=2241, bottom=56, align='left', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=87 ,top=0 ,right=2312 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='poNo', left=93, top=5, right=394, bottom=56, face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cGlAccount', left=1709, top=5, right=2241, bottom=56, align='right', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cGlAccountDec', left=1709, top=53, right=2241, bottom=103, align='right', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='lineItemCnt', left=2249, top=53, right=2307, bottom=101, face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='postKey', left=2249, top=103, right=2307, bottom=148, face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='docDate', left=2315, top=5, right=2519, bottom=56, align='left', supplevel=1 ,mask='XXXX.XX.XX', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2</C>
	<C>id='webDoc', left=2312, top=53, right=2516, bottom=103, align='right', supplevel=1, face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2</C>
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
</B>


			        ">
	</object>
	</comment>
	<SCRIPT>__WS__(__NSID__);</SCRIPT>


<comment id="__NSID__">
<object id="report_list" classid="<%=LGauceId.REPORTS%>">
	<param name="MasterDataID", value="ds_report"> 
	<param name="DetailDataID", value="ds_report">
	<PARAM NAME="PaperSize" VALUE="A4">
	<PARAM NAME="Landscape" VALUE="true">
	<PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PrintMargine" VALUE="false">
	<param name="EnableFontFace" value="true"> 
	<param name="EnglishUI" value="true">  
	<param name="format"
		value="
<B>id=FHeader ,left=0,top=0 ,right=2871 ,bottom=532 ,face='Tahoma' ,size=10 ,penwidth=1
	<T>id='' ,left=286 ,top=19 ,right=323 ,bottom=69 ,align='left' ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='USER-ID' ,left=87 ,top=19 ,right=286 ,bottom=69 ,align='left' ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='Department' ,left=87 ,top=267 ,right=286 ,bottom=323 ,align='left' ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='' ,left=283 ,top=267 ,right=320 ,bottom=323 ,align='left' ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<C>id='deptCd', left=318, top=267, right=749, bottom=323, align='left', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
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
	<T>id='Document Date' ,left=2320 ,top=331 ,right=2572 ,bottom=381 ,align='left' ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='Tot.Li' ,left=2566 ,top=333 ,right=2731 ,bottom=381 ,align='left' ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='Sap Doc.No.' ,left=2529 ,top=378 ,right=2731 ,bottom=429 ,align='left' ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='Reverse' ,left=2566 ,top=426 ,right=2731 ,bottom=476 ,align='left' ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='Web Doc No.' ,left=2318 ,top=378 ,right=2532 ,bottom=429 ,align='left' ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
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
	<C>id='userNm', left=320, top=19, right=751, bottom=69, align='left', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<T>id='' ,left=286 ,top=169 ,right=323 ,bottom=220 ,align='left' ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<C>id='runTime', left=320, top=169, right=751, bottom=220, align='left' ,mask='XX:XX:XX', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<T>id='Run Time' ,left=87 ,top=169 ,right=286 ,bottom=220 ,align='left' ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<C>id='runDate', left=320, top=95, right=751, bottom=146, align='left' ,mask='XXXX.XX.XX', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<T>id='' ,left=286 ,top=95 ,right=323 ,bottom=146 ,align='left' ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='Run Date' ,left=87 ,top=95 ,right=286 ,bottom=146 ,align='left' ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<X>left=2021 ,top=26 ,right=2738 ,bottom=265 ,border=true ,penstyle=solid ,penwidth=2</X>
	<L> left=2260 ,top=26 ,right=2260 ,bottom=262 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2021 ,top=130 ,right=2736 ,bottom=130 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='Assist' ,left=2066 ,top=53 ,right=2217 ,bottom=103 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='MGR' ,left=2305 ,top=53 ,right=2455 ,bottom=103 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='M/DTR' ,left=2545 ,top=53 ,right=2696 ,bottom=103 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2500 ,top=26 ,right=2500 ,bottom=262 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='Document List' ,left=982 ,top=26 ,right=1929 ,bottom=116 ,face='Tahoma' ,size=22 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='cDocType', left=979, top=138, right=1929, bottom=204</C>
</B>
<A>id=Area1 ,left=0,top=0 ,right=2871 ,bottom=127
	<R>id='report_test_sub.sbt' ,left=85 ,top=0 ,right=2736 ,bottom=127 ,SuppressColumns='1:docNo'
		<B>id=default ,left=0,top=0 ,right=2871 ,bottom=201 ,face='Tahoma' ,size=10 ,penwidth=1
			<C>id='webDoc', left=2228, top=53, right=2432, bottom=103, align='right', supplevel=1, face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2</C>
			<C>id='dGlAccountDec', left=1625, top=53, right=2156, bottom=103, align='left', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='dGlAccount', left=1625, top=5, right=2156, bottom=56, align='left', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=1889 ,top=143 ,right=1889 ,bottom=201 </L>
			<L> left=1619 ,top=0 ,right=1619 ,bottom=201 </L>
			<L> left=0 ,top=201 ,right=2223 ,bottom=201 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=2651 ,top=0 ,right=2651 ,bottom=201 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=2225 ,top=0 ,right=2225 ,bottom=201 </L>
			<L> left=2159 ,top=0 ,right=2159 ,bottom=201 </L>
			<L> left=0 ,top=0 ,right=0 ,bottom=201 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=312 ,top=0 ,right=312 ,bottom=201 </L>
			<C>id='totAmt', left=2230, top=148, right=2648, bottom=198, align='right', supplevel=1, face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2, Decao=2</C>
			<C>id='reverseWith', left=2432, top=101, right=2648, bottom=151, align='right', supplevel=1, face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2</C>
			<C>id='postDate', left=2230, top=101, right=2434, bottom=151, align='left', supplevel=1 ,mask='XXXX.XX.XX', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2</C>
			<C>id='docNo', left=2432, top=53, right=2648, bottom=103, align='right', supplevel=1, face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2</C>
			<C>id='cLocalAmt', left=1894, top=148, right=2156, bottom=198, align='right', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2, Decao=2</C>
			<C>id='dLocalAmt', left=1625, top=148, right=1886, bottom=198, align='right', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2, Decao=2</C>
			<L> left=1619 ,top=143 ,right=2159 ,bottom=143 </L>
			<C>id='cGlAccountDec', left=1625, top=53, right=2156, bottom=103, align='right', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='materialNo', left=865, top=101, right=1315, bottom=151, align='left', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2</C>
			<C>id='unit', left=1199, top=148, right=1315, bottom=198, align='left', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2</C>
			<C>id='qty', left=1312, top=148, right=1617, bottom=198, align='right', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2, Decao=2</C>
			<C>id='dueDate', left=1312, top=101, right=1617, bottom=151, align='right' ,mask='XXXX.XX.XX', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2</C>
			<C>id='cTaxCd', left=865, top=56, right=1315, bottom=103, align='left', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2</C>
			<C>id='baselineDate', left=1312, top=53, right=1617, bottom=103, align='right' ,mask='XXXX.XX.XX', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2</C>
			<C>id='text', left=318, top=148, right=1201, bottom=198, align='left', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2</C>
			<C>id='cProfitCenter', left=318, top=101, right=868, bottom=151, align='left', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2</C>
			<C>id='interOrder', left=8, top=148, right=310, bottom=198, face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='type', left=8, top=101, right=310, bottom=151, face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='soNo', left=8, top=53, right=310, bottom=103, face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='docDate', left=2230, top=5, right=2434, bottom=56, align='left', supplevel=1 ,mask='XXXX.XX.XX', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2</C>
			<C>id='totLineItem', left=2432, top=5, right=2648, bottom=56, align='right', supplevel=1, face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2</C>
			<L> left=2225 ,top=0 ,right=2651 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 ,supplevel=1 </L>
			<C>id='cVendorCustumer', left=318, top=5, right=1201, bottom=56, align='left', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2</C>
			<C>id='postKey', left=2164, top=122, right=2223, bottom=172, face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='lineItemCnt', left=2164, top=61, right=2223, bottom=111, face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='curr', left=1199, top=5, right=1315, bottom=56, align='left', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2</C>
			<C>id='docAmt', left=1312, top=5, right=1617, bottom=56, align='right', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=2, Decao=2</C>
			<C>id='cGlAccount', left=1625, top=5, right=2156, bottom=56, align='right', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=3 ,top=0 ,right=2225 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<C>id='poNo', left=8, top=5, right=310, bottom=56, face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		</B>
		<B>id=LDFooter ,left=0,top=0 ,right=2871 ,bottom=58 ,face='Tahoma' ,size=10 ,penwidth=1
			<C>id='totDocQty', left=529, top=5, right=876, bottom=56, face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Decao=2</C>
			<T>id='Total Doc.Qy :' ,left=320 ,top=5 ,right=532 ,bottom=56 ,align='left' ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=2</T>
			<T>id='Total LI Qy. : ' ,left=873 ,top=5 ,right=1066 ,bottom=56 ,align='left' ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=2</T>
			<L> left=0 ,top=0 ,right=2651 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=0 ,top=0 ,right=0 ,bottom=58 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<S>id='Count' ,left=1077 ,top=5 ,right=1307 ,bottom=56 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Decao=2</S>
			<T>id='Total Amount' ,left=1371 ,top=5 ,right=1609 ,bottom=56 ,align='right' ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=2</T>
			<S>id='{Sum(dTotLocalAmt)}' ,left=1630 ,top=5 ,right=1892 ,bottom=56 ,align='right' ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=2, Decao=2</S>
			<S>id='{Sum(cTotLocalAmt)}' ,left=1889 ,top=5 ,right=2151 ,bottom=56 ,align='right' ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=2, Decao=2</S>
			<L> left=0 ,top=58 ,right=2651 ,bottom=58 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
		</B>
	</R>
</A>

			        ">
	</object>
	</comment> 
	<SCRIPT>__WS__(__NSID__);</SCRIPT>
  
</body> 
<script src="<%=xjos %>/xjos.js" language="JScript"/></script>
</html>

