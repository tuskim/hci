<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html xmlns="http://www.w3.org/1999/xhtml">
<%--
/*
 *************************************************************************
 * @source  : stockIssueHistory.jsp
 * @desc    : 출고 입력현황 조회
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2011.01.25   강수연    신규작성
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
	String msgInfoChange   = source.getMessage("dev.inf.com.nochange");  // no data for change.
	String msgSave         = source.getMessage("dev.cfm.com.save");      // Are you sure tosf30qsf save?
	String msgDelete       = source.getMessage("dev.cfm.com.delete");    // Are you sure to Delete?
	String msgContinue     = source.getMessage("dev.cfm.com.continue");  // Are you sure to Continue?
	String msgConfirm          = source.getMessage("dev.cfm.com.confirm");  // Are you sure to confirm?
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
	 ds_status.DataID ="cm.cm.retrieveCommCodeCombo.gau?groupCd=2208&firstVal=Total";ds_status.Reset();	   
	ds_location.DataId="/cm.cm.retrieveCommCodeCombo.gau?groupCd=2005&firstVal=Total";ds_location.Reset();
}

function f_retrieve(){

	ds_main.DataID  = "/rfc.cmd.retrieveStockIssueHistoryList.gau?";
    ds_main.DataID += "issueLoc=" 	  + ds_location.nameValue(ds_location.rowPosition,"code");
    ds_main.DataID += "&status=" 	  + ds_status.nameValue(ds_status.rowPosition,"code");
    ds_main.DataID += "&docDateTo="   + encodeURIComponent(docDateTo.value);
    ds_main.DataID += "&docDateFrom=" + encodeURIComponent(docDateFrom.value);
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
		var v_shtName = "stockIssueHistory";
	    var v_path = "c\\";
	    var v_fileName = v_path+v_shtName+".xls";
   
		gd_main.SetExcelTitle(0, "");
		gd_main.SetExcelTitle(1, "value:")
	    gd_main.SetExcelTitle(1, "value:Stock Issue History " + "; font-face:Book Antiqua; font-size:11pt;font-underline; font-color:black;font-bold; bgcolor:white; align:center;line-width:1pt; skiprow:0;")
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
<comment id="__NSID__"><object id="ds_status"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"          value="true">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>

<!-- 저장소 combo DataSet -->
<object id="ds_location"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"          value="true">
</object>

<!--grid DataSet -->
<object id="ds_main" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/>
  <param name="ViewDeletedRow"    value="true"/>
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
<script language=JavaScript for=ds_main event=OnLoadCompleted(rowCnt)>
	  cfHideDSWaitMsg(gd_main);//progress bar 숨기기
	  cfFillGridNoDataMsg(gd_main,"gridColLineCnt=2");//no data found   
	  mode = "";
</script>
<script language=JavaScript for=ds_main event=OnLoadStarted()>
	  cfShowDSWaitMsg(gd_main);//progress bar 보이기
	  cfHideNoDataMsg(gd_main);//no data 메시지 숨기기
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
					<col width="8%"/>
					<col width="12%"/>
					<col width="5%"/>
					<col width="14%"/>
					<col width=""/>
					</colgroup>
					<tr>	
						<th><%= columnData.getString("issue_loc") %> </th>
						<td><comment id="__NSID__"><object id="issue_loc"  classid="<%=LGauceId.LUXECOMBO%>" width="180">
							    <param name="ComboDataID"       value="ds_location">
								<param name="ListCount"     	value="10">
								<param name=SearchColumn		value="name">
								<param name="BindColumn"    	value="code">
							    <param name=ListExprFormat		value="name^0^140,code^0^70">
							    <param name=index           	value=0>
						   	</object></comment><script>__WS__(__NSID__); </script></td>	
						   	
						<th><%=columnData.getString("issue_date") %></th>
						<td><input type="text" 				 	value="<%= prevDate %>" 
								   id="docDateTo"    	 	name="docDateTo"   
								   onblur="valiDate(this);"  	style="width:65px;"/>&nbsp;
							<img   src="<%= images %>button/cal_icon.gif" 
								   alt="Calendar Icon" 
								   onClick="javascript:OpenCalendar(docDateTo);" 
								   style="cursor:hand"/>~&nbsp; 
							<input type="text" 					 value="<%= currentDate %>" 
								   id="docDateFrom" 		 name="docDateFrom"  
								   onblur="valiDate(this);"   	 style="width:65px;"/>&nbsp;
							<img   src="<%= images %>button/cal_icon.gif" 
								   alt="Calendar Icon" 
							       onClick="javascript:OpenCalendar(docDateFrom);" 
							       style="cursor:hand"/></td>						
					</tr> 	
					<tr>
					<th><%=columnData.getString("status") %> </th>
						<td><comment id="__NSID__"><object id="lx_customer" classid="<%=LGauceId.LUXECOMBO%>"  width="180px"/>
								 <param name=ComboDataID     value="ds_status"/>
								 <param name=Sort			value=false/>
								 <param name=ListExprFormat	value="name^0^140, code^0^70"/> 
								 <param name=BindColumn	    value="code"/>
								 <param name=SearchColumn	value=name/> 
								 <param name=DisableBackColor  value="#FFFFCC"/>
							 </object></comment><script>__WS__(__NSID__); </script></td>
				</tr>
			</table>
			</dt>              		  	   	 	
				<dd class="btnseat2"> 
					<span class="search_btn2_r search_btn2_l">
					<input type="button" onfocus="blur();" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='#e2ebf7'" value="<%=btnSearch%>" onclick="f_retrieve();"/></span> 
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
	          	    <C>id='issueNo' 	name='<%=columnData.getString("issue_no") %>' 	    sort='true'  width='103' align='center' Edit='none'  suppress='1'	 BGCOLOR={decode(term,'TRUE','#FFB6C1','FALSE','#FFFFFF')} </c>
		            <C>id='regdate'     name='<%=columnData.getString("regdate") %>'  	    sort='true'	 width='98'  align='center' Edit='none'  suppress='1' 	 BGCOLOR={decode(term,'TRUE','#FFB6C1','FALSE','#FFFFFF')} mask='XXXX/XX/XX'</c>           	
	            	<C>id='docDate'	 	name='<%=columnData.getString("issue_date") %>' 	sort='true'	 width='98'  align='center' Edit='none'  suppress='1' 	 BGCOLOR={decode(term,'TRUE','#FFB6C1','FALSE','#FFFFFF')} mask='XXXX/XX/XX'</c>
	            	<C>id='postingDate' name='<%=columnData.getString("posting_date") %>' 	sort='true'	 width='98'  align='center' Edit='none'  suppress='1' 	 BGCOLOR={decode(term,'TRUE','#FFB6C1','FALSE','#FFFFFF')} mask='XXXX/XX/XX'</c>
		            <C>id='status'      name='<%=columnData.getString("status") %>'  		sort='true'  width='140' align='left'   Edit='none' 				 BGCOLOR={decode(term,'TRUE','#FFB6C1','FALSE','#FFFFFF')} </c>            		            	
		            <C>id='materNm'     name='<%=columnData.getString("mater_nm") %>'  		sort='true'  width='200' align='left'   Edit='none' 			     BGCOLOR={decode(term,'TRUE','#FFB6C1','FALSE','#FFFFFF')} </c>            		            	
	            	<C>id='issueQty'    name='<%=columnData.getString("issue_qty") %>'  	sort='true'  width='110'  align='right' Edit='none' DEC='0'  		 BGCOLOR={decode(term,'TRUE','#FFB6C1','FALSE','#FFFFFF')} </c>    		            	            	
	            	<C>id='issueDesc'	name='<%=columnData.getString("issue_desc") %>'     sort='true'  width='200'  align='left'  Edit='none'  				 BGCOLOR={decode(term,'TRUE','#FFB6C1','FALSE','#FFFFFF')} </c>            	
	            	<C>id='message'		name='message'    									sort='true'  width='130'  align='center'  Edit='none'  				 BGCOLOR={decode(term,'TRUE','#FFB6C1','FALSE','#FFFFFF')} </c>            				  		
			  		<C>id='credateDocTerm'	 name='doc create term' show='false' </c>
					<C>id='term'		     name='term' 			show='false' </c>
			  
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
