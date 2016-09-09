<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--
/*
 *************************************************************************
 * @source  : ConDocUpdate.jsp
 * @desc    : 공지 수정 &등록
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2010.07.21 노태훈       신규작성
 * ---  -----------  ----------  -----------------------------------------
 * PT-PAM 시스템
 * Copyright(c) 2006-2007 LG CNS,  All rights reserved.
 *************************************************************************
 */
--%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/include/doctype.jsp" %>
<%@ include file="/include/head.jsp" %>
<%@ page import="devon.core.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="comm.util.DateUtil" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="devon.core.collection.LMultiData" %>

<jsp:useBean id="result" class="devon.core.collection.LData" scope="request"/>
<jsp:useBean id="param" class="devon.core.collection.LData" scope="request"/>
<jsp:useBean id="fileAttach" class="devon.core.collection.LMultiData" scope="request"/>
<jsp:useBean id="mgeUtil"  class="comm.util.Util"  scope="request" />

<% 

	String cudmode 			 	= param.getString("mode");
	String g_ntc_user_id   	= "";	
	String g_writer 	= "";	
	String g_writerNm 	= "";
	String g_regdate 				= "";
	String g_subject 				= "";
	String g_content 				= "";  
	String g_userIp 				= "";
	String g_docNo 						= mgeUtil.nullToString(request.getParameter("docNo"));
	String g_stDate 	    = "";
	String g_endDate 		= "";
	String g_title          = "";
	String g_btn1           = "";
	String g_curr           = "";
	String g_amount         = "";	
	String g_stEndDate         = "";
	if(g_docNo.equals("")) g_docNo = "";
		
	if(cudmode.equals("C")){
		g_ntc_user_id 			 = mgeUtil.nullToString(g_userId);
		//g_writer 			     = g_userNm;
		g_regdate 				 = mgeUtil.nullToString(result.getString("regdate"));
		g_userIp 				 = mgeUtil.nullToString(result.getString("userIp"));
		g_title                  = columnData.getString("page4_title");
		g_btn1                   = btnSave;
	}else{
		g_btn1                   = mgeUtil.nullToString(btnSave);		
		g_title                  = columnData.getString("page3_title");
		g_ntc_user_id 			 = mgeUtil.nullToString(result.getString("regid"));
		g_writer 		         = mgeUtil.nullToString(result.getString("writer"));
		g_writerNm 		         = mgeUtil.nullToString(result.getString("writerNm"));
		g_regdate 				 = mgeUtil.nullToString(result.getString("regdate"));
		g_subject 				 = mgeUtil.nullToString(result.getString("subject"));
		g_content 				 = mgeUtil.nullToString(result.getString("content"));
		g_userIp 				 = mgeUtil.nullToString(result.getString("userIp")); 	
		g_amount                 = mgeUtil.nullToString(result.getString("amount")); 	
		g_curr                   = mgeUtil.nullToString(result.getString("currencyCd")); 	
	} 
	g_amount                 = mgeUtil.nullToString(result.getString("amount")); 	
	g_stDate 			     = mgeUtil.nullToString(result.getString("stDate"));
	g_endDate 				 = mgeUtil.nullToString(result.getString("endDate"));
	g_stEndDate 			 = mgeUtil.nullToString(result.getString("stEndDate"));
	g_curr                   = mgeUtil.nullToString(result.getString("currencyCd")); 
	


	//첨부파일 count
	int attach_row_count = fileAttach.getDataCount();

%>

<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<meta content="blendTrans(Duration=0.0)" http-equiv="Page-Enter" />
<meta content="blendTrans(Duration=0.0)" http-equiv="Page-Exit" /> 
<title><%=g_title %></title> 
<script language="javascript">
parent.centerFrame.cols='220,*';
var no_docNo = "<%=g_docNo%>";
 
//-------------------------------------------------------------------------
// 화면로딩시
//-------------------------------------------------------------------------
var start_image = 1;
var total_image = 1;
var max_image = 7;
var use_pds = 0;
var basic_button_write_file = "file";
function init(){  
	if(no_docNo==""){
		//document.sform.p_pop.style.display="";
		document.sform.p_new.style.display="none";
		document.sform.b_print.style.display="none";
	}else{
		//document.sform.p_pop.style.display="none";
		document.sform.p_new.style.display="";
		document.sform.b_print.style.display="";
	}
	document.sform.amount.value =setComma(document.sform.amount.value);
	//currency
	ds_currency.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2004";
	ds_currency.Reset();	
	cfUnionBlank(ds_currency,ds_currency,"code","name");
	
	ds_currency.RowPosition = ds_currency.NameValueRow("code","<%=g_curr%>");
}
// 신규등록
function f_Create(){  	
	//신규화면은 -1을 파람으로 보내 신규용처리를 함  
	document.sform.action  = "fi.ar.retrieveConDocUpdate.dev?progCd=FI0007&docNo=";    
	document.sform.submit();
}
function viewH(val1) {
	var tabid = this.document.all.uploadtable;
	var attach_files_num = <%=attach_row_count%>;
	this_idx = parseInt(val1);

	for (i=(3+attach_files_num); i < tabid.rows.length-1 ; i++){
		tabid.rows(i).style.display =  (i < (this_idx+2+attach_files_num) ? "":"none") ;
	}
}



//리스트 조회
function f_List() {
	document.sform.action = "conDocList.dev?progCd=FI0007";
	document.sform.submit();
}

//저장
function f_Save(){ 
	var obj = document.sform;  	
	var delCnt = 0;
	var delInfo = ""; 
<%if(attach_row_count == 1){%>  
			if(obj.delnum.checked){  
				delCnt  = delCnt + 1; 
				delInfo += obj.delnum.value + ","; 
			}	
<%}else if(attach_row_count > 0){%>
		
		for(var i=0; i < obj.delnum.length; i++ ){
			if(obj.delnum[i].checked == true){ 		
				delCnt  = delCnt + 1;
				delInfo += obj.delnum[i].value + ",";
			}
		}	
<%}%>
	obj.delCnt.value = delCnt;
	obj.delInfo.value = delInfo;  
	if(obj.subject.value == "") {
		alert("<%=source.getMessage("dev.warn.com.input",columnData.getString("subject"))%>"); 
		obj.subject.focus();
		return;
	} 
	
	if(obj.vendNm.value == "") {
		alert("<%=source.getMessage("dev.warn.com.input",columnData.getString("writer"))%>"); 
		obj.vendNm.focus();
		return;
	} 	
	 
	
	if(ds_currency.NameValue(ds_currency.RowPosition,"code") == "") {
		alert("<%=source.getMessage("dev.warn.com.input",columnData.getString("currency_cd"))%>"); 		
		return;
	} 	
	
	if(obj.amount.value == "0") {
		alert("<%=source.getMessage("dev.warn.com.input",columnData.getString("amount"))%>"); 
		obj.amount.focus();
		return;
	}else{
		var data = removeComma(obj.amount.value);
		if(isNaN(data)){
            alert("<%=source.getMessage("dev.fi.ar.appdoc.chk.number",columnData.getString("amount"))%>"); 
            obj.amount.focus();
        	return;	
		} 
	} 				
	
	ds_modifyChk.DataID = "fi.ar.retrieveConDocChk.gau?docNo="+document.sform.docNo.value;
	ds_modifyChk.Reset();
		
	if(ds_modifyChk.NameValue(1,"cnt")>0){
		alert("Already registered Cost Doc.");
		return;
	}
	
	obj.h_curr.value = ds_currency.NameValue(ds_currency.RowPosition,"code");
	obj.action = "fi.ar.cudConDoc.dev";
	obj.submit(); 
}
  
function f_Delete(){
	ds_modifyChk.DataID = "fi.ar.retrieveConDocChk.gau?docNo="+document.sform.docNo.value;
	ds_modifyChk.Reset();
		
	if(ds_modifyChk.NameValue(1,"cnt")>0){
		alert("<%=source.getMessage("dev.fi.ar.appdoc.chk.doc")%>");
		return;
	}
    document.sform.cudmode.value 	= "D";
	document.sform.action = "fi.ar.deleteConDoc.dev";
	document.sform.submit();
}  

function setCommaKeypress()
{
	document.sform.amount.value =setComma(document.sform.amount.value);
}
 
function f_print(){
	ds_main.ClearData();
    var strHeader  = "companyCd:STRING(200),docNo:STRING(200),subject:STRING(200),content:STRING(5000),writerNm:STRING(200),stEndDate:STRING(200),currencyNm:STRING(200),amount:STRING(200),regdate:STRING(200)";
   	ds_main.SetDataHeader(strHeader);
   	ds_main.AddRow();
   	ds_main.NameValue(ds_main.RowPosition,"docNo") =document.sform.docNo.value;
   	ds_main.NameValue(ds_main.RowPosition,"subject") =document.sform.subject.value;
   	ds_main.NameValue(ds_main.RowPosition,"content") =document.sform.content.value;
   	ds_main.NameValue(ds_main.RowPosition,"writerNm") =document.sform.vendNm.value;
   	ds_main.NameValue(ds_main.RowPosition,"stEndDate") =document.sform.stEndDate.value;
   	ds_main.NameValue(ds_main.RowPosition,"currencyNm") =ds_currency.NameValue(ds_currency.RowPosition,"name");
   	ds_main.NameValue(ds_main.RowPosition,"amount") =document.sform.amount.value;
   	ds_main.NameValue(ds_main.RowPosition,"regdate") =document.sform.regdate.value;
    report_page.Preview(); 	 
}   
</script>
<!-----------------------------------------------------------------------------
D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<object id="ds_main"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
</object>
<!-- currency combo DataSet -->
<object id="ds_currency"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
</object>

<object id="ds_modifyChk"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
</object>

</head>
<body id="cent_bg" onload="init();">
	<div id="conts_box">
	<h2> <span> <%=columnData.getString("page_title2") %> </span></h2>
	<form name="sform" method="post" enctype="multipart/form-data">
		<input type="hidden" name="cudmode" value="<%=cudmode %>"/>
		<input type="hidden" name="regId" value="<%=g_ntc_user_id %>"/>  
		<input type="hidden" name="companyCd" value="<%=g_companyCd %>"/>
		<input type="hidden" name="userIp" value="<%=g_userIp %>"/>
		<input type="hidden" name="email" value="<%=g_email %>"/>  
		<input type="hidden" name="h_docNo" value="<%=g_docNo %>"/>
		<input type="hidden" name="vendCd" value="<%=g_writer %>"/>
		<input type="hidden" name="stEndDate" value="<%=g_stEndDate %>"/>
		<input type="hidden" name="h_curr" value=""/>
		<input type="hidden" name="delInfo"/>
		<input type="hidden" name="delCnt"/>
	<div class="sub_stitle"> 
		<p> <%=columnData.getString("sub_title2") %> </p>
		<p class="rightbtn">		   	 		
			<span class="sbtn_r sbtn_l"> 
			<input style="display:none" id="b_print" type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="<%=btnPrint %>" onclick="f_print();"/></span>  	 
		</p>			
	</div>    
<!-- 그리드 S -->	
		<div id="output_board_area">
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board" >
				<colgroup>
					<col width="14%"/>
					<col width="17%"/>   
					<col width="11%"/>
					<col width="11%"/> 
					<col width="11%"/>
					<col width=""/>
				</colgroup>

				<tr>
					<th><%=columnData.getString("doc_no") %></th>
					<td><input type="text" id="docNo"	name=docNo style="width:100px;" class="txtField_read" value="<%=g_docNo %>" readonly /></td>									
					
					<th><%=columnData.getString("date") %></th>
					<td><input type="text" id="regdate" name="regdate" style="width:100px;" class="txtField_read" value="<%=g_regdate%>" readonly /></td>                              					
					
					<th><%=columnData.getString("writer") %></th>
					<td><input type="text" id="vendNm"	name="vendNm" style="width:160px;" class="txtField_read" value="<%=g_writerNm %>" readonly />
					<input type="button" id=p_pop onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="" onclick="javascript:openVendorCodeListWin('Y');" class="buttonSearch"/>
					</td>					
				</tr>			
	
				<tr>                  
					<th><%=columnData.getString("currency_cd") %></th>
					<td>
 						<comment id="__NSID__"><object id="lc_currency"  classid="<%=LGauceId.LUXECOMBO%>" width="100">
						<param name="ComboDataID"       value="ds_currency"/>
						<param name="ListCount"     	value="10"/>
						<param name=SearchColumn		value="name"/>
						<param name="BindColumn"    	value="code"/> 
						<param name=ListExprFormat		value="code^0^70"/> 
						<param name=enable		value="true"/> 
						<param name=index           	value=0>
						</object></comment><script>__WS__(__NSID__); </script>					
					</td>				
					<th><%=columnData.getString("amount") %></th>
					<td><input type="text" id="amount"	name=amount style="width:100px;" class="input_text" value="<%=g_amount %>" onkeypress="setCommaKeypress()"/></td>					
					<th><%=columnData.getString("st_date") %></th> 
					<td><input type="text" id="stDate" name="stDate" value="<%=g_stDate%>" style="width:62px;"  class="txtField_read"  readonly required/>
					<a href="#">&nbsp;<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(stDate);" style="cursor:hand"/></a> ~ <input type="text" style="width:62px;" id="endDate" name="endDate" value="<%=g_endDate%>" class="txtField_read"  readonly required/>
					<a href="#">&nbsp;<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(endDate);" style="cursor:hand"/></a></td>									
																	
				</tr>		
				<tr>
					<th><%=columnData.getString("subject") %></th>
					<td colspan="5" class="title">  <input type="text" id="subject"	class="input_text" name=subject style="width:450px;" value="<%=g_subject %>" required/> </td>                             
				</tr>						  
				<tr>
					<th><%=columnData.getString("content") %></th> 
					<td colspan="5">
						<textarea name="content" id="content"  style="width:97%; height:200px;" required><%=g_content%></textarea>
					</td>
				</tr>
    			<tr>
	  				<th><%=columnData.getString("attachment") %></th>
	  				<td colspan="5">
						<table width="100%" id='uploadtable' class="tsearch_white">

		  <%
                    if (attach_row_count > 0){
                        for (int idx=0; idx < attach_row_count; idx++) {
                            out.println("<tr height='20'><td style=border:0;>Delete Required : ");
                            out.print("<INPUT TYPE='checkbox' class='check' NAME='delnum' value='");                            
                            out.print(fileAttach.getString("seqAttach",idx));
                            out.println("'>");
                            out.println("&nbsp<img src='"); 
                            out.println(images);
                            out.println("btn_file01.gif' style='vertical-align:middle' align='absmiddle' alt='file' onClick='' style='cursor:hand; margin-right:3px;'/> <a href='fi.ar.DownloadConDocFile.dev?filename=");
                            out.println(URLEncoder.encode(fileAttach.getString("fileUrl", idx),"UTF-8"));
                            out.println("&fileReal=");
                            out.println(URLEncoder.encode(fileAttach.getString("fileNm", idx),"UTF-8"));                            
                            out.println("'>");
                            out.println(fileAttach.getString("fileNm",idx));
                            out.println("</a>");
                            out.println("</td>");
                            out.println("</tr>");
                        }
                    }
                    %>
                                          
		  					<tr>
	            				<td height="22" style="border:0;">AttachFile Quantity
					                      
								  	<select name="uploadnum"  onchange="viewH(this.value);">
			                        <%
			                        for(int i=1;i<=10-attach_row_count;i++){
			                            out.println("<option value='" + i + "'>" + i + "</option>");
			                        }
			                        %>
                        
			  						</select>
                        
			 						 &nbsp;<span style="font-size:11px">* Select Attach File QTY. (Max Attach File QTY 10, <FONT COLOR="red">Max Upload Size 5M</FONT>)
 									</span>                      
								</td>
		  					</tr> 
		  					<tr>
            					 <td height="22" style="border:0;"><input name="uploadfile" type="file" class="input_text" style="width:300px"></td>
          					</tr>
                    			<% for(int i=0;i<11-attach_row_count;i++){ %>
                    
		  					<tr height="22" style='display:none'>
            					<td style="border:0;">
									<input name="uploadfile" type="file" class="input_text" style="width:300px" text="file"></td>
                    
		  					</tr>
                    			<% } %>
   		
						</table>			
		 			</td>
		 			
				</tr>		
  			</table>
		</div>
<!-- 그리드 E -->	
<!-- 버튼 S -->	
		<div id="btn_area">
			<p class="b_right">		 
				<span class="btn_r btn_l"><input style="display:none" id=p_new type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnWrite%>" onclick="javascript:f_Create();"/></span>  			
				<span class="btn_r btn_l"><input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=g_btn1%>" onclick="javascript:f_Save()"/></span> 
				<span class="btn_r btn_l"><input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnDel%>" onclick="javascript:f_Delete()"/></span> 
				<span class="btn_r btn_l"><input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnList%>" onclick="javascript:f_List();"/></span> 	
			</p>
		</div>
<!-- 버튼 E -->	 
	</form>
<iframe src="about:blank" width=0 height=0 frameborder='0' scrolling=no name='tgframe'></iframe>
</div>
<comment id="__NSID__">
<object id="report_page" classid="<%=LGauceId.REPORTS%>"> 
    <param name="DetailDataID"      value="ds_main">
    <param name="MasterDataID"      value="">    
	<PARAM NAME="PaperSize" VALUE="A4">
	<PARAM NAME="Landscape" VALUE="false">
	<PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PrintMargine" VALUE="false">
	<param name="EnableFontFace" value="true"> 	
	<param name="EnglishUI" value="true">  
	<param name="format"
		value="
<B>id=FHeader ,left=0,top=0 ,right=2000 ,bottom=815 ,face='Tahoma' ,size=10 ,penwidth=1
	<T>id='Approval Document Registration' ,left=225 ,top=106 ,right=1667 ,bottom=196 ,face='Tahoma' ,size=22 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=1304 ,top=307 ,right=1543 ,bottom=344 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1066 ,top=307 ,right=1304 ,bottom=344 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=1781 ,top=307 ,right=1781 ,bottom=558 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1304 ,top=307 ,right=1304 ,bottom=558 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1543 ,top=307 ,right=1543 ,bottom=558 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<X>left=1543 ,top=434 ,right=1781 ,bottom=471 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1304 ,top=434 ,right=1543 ,bottom=471 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1066 ,top=434 ,right=1304 ,bottom=471 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1543 ,top=307 ,right=1781 ,bottom=344 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=1066 ,top=471 ,right=1781 ,bottom=471 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1066 ,top=344 ,right=1781 ,bottom=344 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1066 ,top=307 ,right=1781 ,bottom=307 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1066 ,top=558 ,right=1781 ,bottom=558 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1066 ,top=307 ,right=1066 ,bottom=558 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1066 ,top=434 ,right=1781 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='Acct.Assist' ,left=1114 ,top=310 ,right=1275 ,bottom=341 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='Acct.MGR' ,left=1339 ,top=310 ,right=1503 ,bottom=341 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='M/DTR' ,left=1585 ,top=310 ,right=1752 ,bottom=341 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='MGR' ,left=1588 ,top=437 ,right=1749 ,bottom=468 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='Assist ' ,left=1347 ,top=437 ,right=1511 ,bottom=468 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='Received' ,left=1106 ,top=437 ,right=1270 ,bottom=468 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<C>id='docNo', left=294, top=574, right=725, bottom=624, align='left', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<T>id=':' ,left=233 ,top=574 ,right=270 ,bottom=624 ,face='Arial' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Doc No' ,left=87 ,top=574 ,right=220 ,bottom=624 ,align='left' ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<C>id='regdate', left=294, top=667, right=725, bottom=717, align='left', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<T>id=':' ,left=233 ,top=667 ,right=270 ,bottom=717 ,face='Arial' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Date' ,left=87 ,top=667 ,right=220 ,bottom=717 ,align='left' ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='Writer' ,left=87 ,top=759 ,right=220 ,bottom=810 ,align='left' ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id=':' ,left=233 ,top=759 ,right=270 ,bottom=810 ,face='Arial' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='writerNm', left=294, top=759, right=725, bottom=810, align='left', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=1672 ,face='Tahoma' ,size=10 ,penwidth=1
	<L> left=87 ,top=82 ,right=1791 ,bottom=82 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=87 ,top=16 ,right=1791 ,bottom=16 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=87 ,top=151 ,right=1791 ,bottom=151 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='Period' ,left=95 ,top=24 ,right=228 ,bottom=74 ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='stEndDate', left=246, top=24, right=677, bottom=74, align='left', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<T>id='Currency' ,left=701 ,top=24 ,right=833 ,bottom=74 ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='currencyNm', left=857, top=24, right=1130, bottom=74, face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='amount', left=1310, top=24, right=1786, bottom=74, align='right', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3, Decao=0</C>
	<T>id='Amount' ,left=1154 ,top=24 ,right=1286 ,bottom=74 ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=87 ,top=1659 ,right=1791 ,bottom=1659 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=87 ,top=16 ,right=87 ,bottom=1659 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=233 ,top=16 ,right=233 ,bottom=1659 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='Subject' ,left=95 ,top=90 ,right=228 ,bottom=140 ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='subject', left=246, top=90, right=1786, bottom=140, align='left', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<L> left=1791 ,top=16 ,right=1791 ,bottom=1659 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=688 ,top=16 ,right=688 ,bottom=82 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=844 ,top=16 ,right=844 ,bottom=82 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1299 ,top=16 ,right=1299 ,bottom=82 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1140 ,top=16 ,right=1140 ,bottom=82 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='Content' ,left=95 ,top=156 ,right=228 ,bottom=1635 ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='content', left=246, top=159, right=1786, bottom=1638, align='left', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3, Multiline=true ,valign=top ,CRFlag=true</C>
</B>

			        ">
	</object>
	</comment>
	<SCRIPT>__WS__(__NSID__);</SCRIPT>
</BODY>
</HTML>