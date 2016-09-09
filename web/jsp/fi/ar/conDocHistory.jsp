<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html xmlns="http://www.w3.org/1999/xhtml">
<%--
/*
 *************************************************************************
 * @source  : docHistory.jsp
 * @desc    : document 입력현황 조회
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2011.03.21   강수연    신규작성
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

}

function f_retrieve(){

	ds_main.DataID  = "/fi.ar.retrieveConDocHistoryList.gau?";
    ds_main.DataID += "conDocNo=" 	  + encodeURIComponent(conDocNo.value);
    ds_main.DataID += "&writer=" 	  + encodeURIComponent(writer.value);
    ds_main.DataID += "&regDateTo="   + encodeURIComponent(regDateTo.value);
    ds_main.DataID += "&regDateFrom=" + encodeURIComponent(regDateFrom.value);
 	ds_main.DataID += "&lang="		  +"<%=g_lang%>";	
	ds_main.Reset();
	
}

//-------------------------------------------------------------------------
//해당 문자열이 널인지 점검
//-------------------------------------------------------------------------		
function f_isNull( asValue ) {
   	if (asValue == null || asValue == undefined || asValue.toString().replace(/ /g,"") == "") {
      	 return  true;
   	}
  	return false;
}	

//-------------------------------------------------------------------------
// excel
//-------------------------------------------------------------------------					   
function f_excel() {

	if(ds_main.CountRow > 0) {
		var v_shtName = "approvalDocHistory";
	    var v_path = "c\\";
	    var v_fileName = v_path+v_shtName+".xls";
   
		gd_main.SetExcelTitle(0, "");
		gd_main.SetExcelTitle(1, "value:")
	    gd_main.SetExcelTitle(1, "value:Approval Doc History " + "; font-face:Book Antiqua; font-size:11pt;font-underline; font-color:black;font-bold; bgcolor:white; align:center;line-width:1pt; skiprow:0;")
	    gd_main.SetExcelTitle(1, "value:")
		gd_main.GridToExcel(v_shtName, v_fileName, 1);
	} else {
		alert("No Data");
	}
		
}

</script> 


<!-----------------------------------------------------------------------------
  프로그램 전용 D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!--combo DataSet -->

<!--grid DataSet -->
<object id="ds_main" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/>
  <param name="ViewDeletedRow"    value="true"/>
  <param name="SubsumExpr"        value="1:conDocNo:amount:currencyCd:docCurrencyCd">
</object>


<!-- CUD TR -->
<OBJECT id=tr_cudMaster classid="<%=LGauceId.TR%>">
	<param name="KeyName" value="toinb_dataid4">
</OBJECT>

 


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

<script language=JavaScript for=ds_main event=OnLoadStarted()>
	  cfShowDSWaitMsg(gd_main);//progress bar 보이기
	  cfHideNoDataMsg(gd_main);//no data 메시지 숨기기
	  mode = "";
</script>

<script language=JavaScript for=ds_main event=OnLoadCompleted(rowcnt)>
      cfHideDSWaitMsg(gd_main);//progress bar 숨기기
	  cfFillGridNoDataMsg(gd_main,"gridColLineCnt=2");//no data found   
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
					<col width="7%"/>
					<col width="8%"/>
					<col width="10%"/>
					<col width="13%"/>
					<col width=""/>
					</colgroup>
					<tr>	
						<th><%=columnData.getString("con_doc_no") %> </th>
						<td><input type="text" style="width:100px;" id="conDocNo"/></td>
						
						<th><%=columnData.getString("con_doc_regdate") %> </th>
						<td><input type="text" id="regDateTo" name="regDateTo" value="<%= prevDate %>"  onblur="valiDate(this);"  style="width:65px;"/>&nbsp;
							<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(regDateTo);" style="cursor:hand"/> 
							~&nbsp;<input type="text" id="regDateFrom" name="regDateFrom"  value="<%= currentDate %>" onblur="valiDate(this);"   style="width:65px;"/>&nbsp;
							<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(regDateFrom);" style="cursor:hand"/> 
					    </td>		
					</tr>
					<tr>	
					    <th><%=columnData.getString("writer") %> </th>
						<td><input type="text" style="width:100px;" id="writer"/></td>				
					</tr> 	
			</table>
			</dt>              		  	   	 	
			 <dd class="btnseat2"> 
				 	  <span class="search_btn2_r search_btn2_l">
                	  <input type="button" onfocus="blur();" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='#e2ebf7'" value="<%=btnSearch %>" onclick="f_retrieve();"/></span> 
			</dd>
			</dl>
			</div>
		</fieldset>
     <!--검색 E --><!--조회영역 끝 --> <!--===================================================================-->
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
	        <object id="gd_main" classid="<%=LGauceId.GRID %>" style="width:100%;height:320px" class="comn_status">
	          <param name="DataID"              value="ds_main">
	          <param name="Editable"            value="true">
	          <param name="TitleHeight"         value="30"> 
	          <param name="UsingOneClick"       value="1">
	          <param name="SortView" 			value="Left">
	          <param name="Format"              value="												
	          	    <C>id='conDocNo' 	 	 name='<%=columnData.getString("con_doc_no") %>'    sort='true'	 width='112' align='center'  Edit='none'  suppress='1'</c> 
		            <C>id='subject'      	 name='<%=columnData.getString("subject") %>'  	    sort='true'  width='230' align='left'  Edit='none'  suppress='1' </c>            	
	            	<C>id='writerNm'		 name='<%=columnData.getString("writer") %>' 		sort='true'	 width='100' align='center'  Edit='none'  suppress='1' </c> 
	            	<C>id='stDate' 			 name='<%=columnData.getString("st_date") %>' 	   	sort='true'	 width='96' align='center'  Edit='none' mask='XXXX/XX/XX' 	suppress='1' </c> 
	            	<C>id='endDate' 	 	 name='<%=columnData.getString("end_date") %>' 		sort='true'	 width='96' align='center'  Edit='none' mask='XXXX/XX/XX' 	suppress='1' </c> 
	            	<C>id='amount'     		 name='<%=columnData.getString("con_doc_amount") %>'  sort='true'  width='110' align='right'   Edit='none' 		  		    suppress='1' </c> 		            	            	
		            <C>id='currencyCd'   	 name='<%=columnData.getString("currency_cd") %>'  	sort='true'  width='60'  align='center'  Edit='none' suppress='1'  </c>          		            		
					
					<C>id='docSeq'	 		 name='<%=columnData.getString("doc_seq") %>'		sort='true' width='96'  align='center' Edit='none'</c>
					<C>id='docYm'		     name='<%=columnData.getString("doc_ym") %>' 		sort='true'	width='96'  align='center' Edit='none'</c>
					<C>id='docAmount' 	     name='<%=columnData.getString("doc_amount") %>'   	sort='true' width='110'  align='right'  Edit='none'</c>         	
					<C>id='docCurrencyCd'	 name='<%=columnData.getString("currency_cd") %>'   sort='true' width='60'   align='center' Edit='none'</c>         						            						
					<C>id='docDate'		 	 name='<%=columnData.getString("doc_date") %>'   	sort='true' width='96'  align='center' Edit='none' mask='XXXX/XX/XX' </c>         	
					<C>id='postDate'		 name='<%=columnData.getString("post_date") %>'   	sort='true' width='96'  align='center' Edit='none' mask='XXXX/XX/XX' </c>         	
					<C>id='progStatus'		 name='<%=columnData.getString("prog_status") %>'   sort='true' width='96'  align='center'</c>         			
			  "/>
	        </object>
	      </comment>
	      <script>__WS__(__NSID__);</script>
	    </td>
	  </tr>
	</table>
   </div>

  	 <!-- 그리드 E --> <!--===================================================================--> 	

</div>
</body>
<input type="hidden" id="h_date"/>
<script src="<%=xjos %>/xjos.js" language="JScript"/></script>
</html>
