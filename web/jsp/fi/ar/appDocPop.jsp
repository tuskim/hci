<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html xmlns="http://www.w3.org/1999/xhtml">
<%--
/*
 *************************************************************************
 * @source  : appDocPop.jsp
 * @desc    : appDocPop Test
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
}
//-------------------------------------------------------------------------
// Set header
//-------------------------------------------------------------------------
function f_setData(){  
	gr_main.ReDraw="false"; 
	gr_main.ColumnProp("docNo","name") = opener.gr_costTotDtl.ColumnProp('docNo','name');	
	gr_main.ColumnProp("subject","name") = opener.gr_costTotDtl.ColumnProp('subject','name');	
	gr_main.ColumnProp("currencyNm","name") = opener.gr_costTotDtl.ColumnProp('currencyNm','name');	
	gr_main.ColumnProp("amount","name") = opener.gr_costTotDtl.ColumnProp('amount','name');
	gr_main.ColumnProp("stEndDate","name") = opener.gr_costTotDtl.ColumnProp('stDate','name');	
	gr_main.ColumnProp("regdate","name") = opener.gr_costTotDtl.ColumnProp('regdate','name');	
	gr_main.ColumnProp("writerNm","name") = opener.gr_costTotDtl.ColumnProp('writerNm','name');	 		 
	gr_main.ReDraw="true";	
}

function f_Retrieve(){

		ds_main.DataID = "fi.ar.retrieveConDocListPop.gau?docNo="+t_docNo.value+"&subject="+t_subject.value+"&writerNm="+t_writerNm.value;
		ds_main.Reset();
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
  cfShowDSWaitMsg(gr_main);//progress bar 보이기
  cfHideNoDataMsg(gr_main);//no data 메시지 숨기기
</script>

<!-- Hub In Header 조회 DataSet -->
<script language=JavaScript for=ds_main event=OnLoadCompleted(rowCnt)>
  cfHideDSWaitMsg(gr_main);//progress bar 숨기기
  cfFillGridNoDataMsg(gr_main,"gridColLineCnt=2");//no data found   
</script>
 
<script language=JavaScript for="ds_main" event=OnRowPosChanged(row)>
	if(ds_main.CountRow>0){
		content.value =ds_main.NameValue(ds_main.RowPosition,"content");
	}
		 
</script>

<script language=JavaScript for=gr_main event=OnSetFocus()>
 
</script>

<script language=JavaScript for=ds_main event=OnColumnChanged(row,colid)>
 
</script>

<script language=JavaScript for=ds_main event=CanRowPosChange(row)> 
 
</script>
 
<script language=JavaScript for=gr_main event=OnDblClick(row,colid)>
	opener.consultationDocNo.value = ds_main.NameValue(row, "docNo");
	self.close();

</script>
 
 
<%----------------------------------------------------------------------------------------------------
 Gauce obj  event TR  정의
------------------------------------------------------------------------------------------------------%> 
 
<%----------------------------------------------------------------------------------------------------
 UI  정의
---------------------------------------------------------------------------------------------------- --%>
</head>

<body onload="init();">
<div id="conts_box_pop">
	<h2> <span>Approval Doc List</span></h2> 
	<!--검색 S -->	
	 <fieldset class="boardSearch">
		<div>
				<dl>
				<dt> 
				<table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board2" >
					<colgroup>
						<col width="11%"/>
						<col width="20%"/>
						<col width="11%"/>
						<col width="20%"/>
						<col width="11%"/>						
						<col width=""/>
					</colgroup>
					<tr>
						<th> Doc No</th>
						<td><input type="text" style="width:100px;" id="t_docNo"   /></td>
						<th> Subject</th>
						<td><input type="text" style="width:100px;" id="t_subject" /></td>
						<th> Writer</th>
						<td><input type="text" style="width:100px;" id=t_writerNm   /></td>						
					</tr>
				</table>
				</dt>              		  	   	 	
					<dd class="btnseat1"> 
				 	  <span class="search_btn_r search_btn_l">
           			 	<input type="button" onfocus="blur();" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='#e2ebf7'" value="<%=btnSearch %>" onclick="javascript:f_Retrieve()"/></span> 
					</dd>	 									
				</dl>
		</div>
		</fieldset>
      <!--검색 E -->

	<div class="sub_stitle"> 
		<p>Approval Doc List</p>
 		
	</div>   	
	<!-- 그리드 S -->	
	<object id="gr_main" classid="<%=LGauceId.GRID %>" style="width:100%;height:102px;" class="comn">
		<param Name="DataID" 			value='ds_main'>
	    <Param name="AutoResizing"      value=true>
	    <param name="ColSizing"         value=true> 
	    <Param name="SortView"          value="right"> 
	    <param name="Editable"          value=True> 
		<param Name='Format'
			value='
				<C>id="NO"		              align=center     value={CurRow} width=30		</C>
           		<C> id=docNo         	      align="center"   width="75"    Edit="none"   show="true" sort=true</C>  
                <C> id=subject      	      align="left"     width="160"    Edit="none"   show="true" sort=true</C>  
                <C> id=currencyNm             align="center"   width="70"    Edit="none"   show="true" sort=true</C> 
                <C> id=amount                 align="rigjt"    width="100"    Edit="none"   show="true" sort=true</C>                 
                <C> id=stEndDate 	          align="center"     width="160"    Edit="none"   show="true" sort=true</C>  
                <C> id=regdate      		  align="center"    width="75"    Edit="none"   show="true" sort=true </C>
                <C> id=writerNm  		      align="center"   width="150"    Edit="none"   show="true" sort=true</C>                 
	      '>
	</object>

 	</div> 
    <div id="output_board_area">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board" > 	
     
			<tr>
				<th width=100 align="center">Content</th> 
				<td>
					<textarea name="content" id="content"  style="width:700px; height:50px;" readonly></textarea>
				</td>
			</tr> 	
		</table>
	</div>
  
</div> 

<comment id="__NSID__">
<object id="report_page" classid="<%=LGauceId.REPORTS%>"> 
    <param name="DetailDataID"      value="ds_main">
    <param name="MasterDataID"      value="">    
    <param name="PaperSize"         value="A4">
    <param name="Landscape"         value="true">
    <param name="PrintSetupDlgFlag" value="true"> 	 
	<param name="format"
		value="
<B>id=FHeader ,left=0,top=0 ,right=2000 ,bottom=196 ,face='Tahoma' ,size=10 ,penwidth=1
	<T>id='Approval Document Registration' ,left=45 ,top=42 ,right=1966 ,bottom=122 ,face='Arial' ,size=18 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=2286 ,face='Tahoma' ,size=10 ,penwidth=1
	<T>id='Doc No ' ,left=24 ,top=53 ,right=320 ,bottom=103 ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Currency' ,left=24 ,top=146 ,right=320 ,bottom=196 ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Date' ,left=648 ,top=53 ,right=945 ,bottom=103 ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Amount' ,left=648 ,top=146 ,right=945 ,bottom=196 ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='docNo', left=328, top=53, right=624, bottom=103, align='left', face='Arial', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<C>id='currencyNm', left=328, top=146, right=624, bottom=196, align='left', face='Arial', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<C>id='amount', left=953, top=146, right=1249, bottom=196, align='left', face='Arial', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<C>id='date', left=953, top=53, right=1249, bottom=103, align='left', face='Arial', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<C>id='subject', left=328, top=235, right=1966, bottom=286, align='left', face='Arial', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<T>id='Subject' ,left=24 ,top=235 ,right=320 ,bottom=286 ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='writerNm', left=1577, top=53, right=1969, bottom=103, align='left', face='Arial', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<C>id='stEndDate', left=1577, top=146, right=1966, bottom=196, align='left', face='Arial', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<L> left=16 ,top=122 ,right=1971 ,bottom=122 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=16 ,top=214 ,right=1971 ,bottom=214 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=16 ,top=302 ,right=1971 ,bottom=302 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=16 ,top=32 ,right=1971 ,bottom=32 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=323 ,top=32 ,right=323 ,bottom=302 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=635 ,top=32 ,right=635 ,bottom=214 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=947 ,top=32 ,right=947 ,bottom=214 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1259 ,top=32 ,right=1259 ,bottom=214 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1572 ,top=32 ,right=1572 ,bottom=214 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='Writer' ,left=1273 ,top=53 ,right=1569 ,bottom=103 ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Period' ,left=1273 ,top=146 ,right=1569 ,bottom=196 ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=16 ,top=32 ,right=16 ,bottom=302 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1971 ,top=32 ,right=1971 ,bottom=302 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=16 ,top=1416 ,right=1971 ,bottom=1416 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='content', left=328, top=331, right=1966, bottom=1408, align='left', face='Arial', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3, Multiline=true ,valign=top</C>
	<T>id='Contects' ,left=24 ,top=328 ,right=320 ,bottom=1405 ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1971 ,top=302 ,right=1971 ,bottom=1416 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=323 ,top=302 ,right=323 ,bottom=1416 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=16 ,top=302 ,right=16 ,bottom=1416 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
</B>
<B>id=Detail ,left=0,top=0 ,right=2000 ,bottom=1527 ,face='Tahoma' ,size=10 ,penwidth=1
	<L> left=16 ,top=1386 ,right=1971 ,bottom=1386 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
</B>

			        ">
	</object>
	</comment>
	<SCRIPT>__WS__(__NSID__);</SCRIPT>
</body> 
<script src="<%=xjos %>/xjos.js" language="JScript"/></script>
</html>

