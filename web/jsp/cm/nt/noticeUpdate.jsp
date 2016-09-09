<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--
/*
 *************************************************************************
 * @source  : noticeUpdate.jsp
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
<jsp:useBean id="vmiHubUtil"  class="comm.util.Util"  scope="request" />

<% 

	String cudmode 			 	= param.getString("mode");
	String g_ntc_user_id   	= "";	
	String g_ntc_user_nm 	= "";	
	String g_regdate 				= "";
	String g_subject 				= "";
	String g_content 				= "";  
	String g_userIp 				= "";
	String g_seq 						= vmiHubUtil.nullToString(request.getParameter("seq"));
	String g_bbsFromDate 	= "";
	String g_bbsToDate 		= "";
	String g_title          = "";
	String g_btn1           = "";
	if(g_seq.equals("")) g_seq = "-1";
		
	if(cudmode.equals("C")){
		g_ntc_user_id 			 = g_userId;
		g_ntc_user_nm 			 = g_userNm;
		g_regdate 				 = result.getString("regdate");
		g_userIp 				 = result.getString("userIp");
		g_title                  = columnData.getString("page4_title");
		g_btn1                   = btnSave;
	}else{
		g_btn1                   = btnSave;		
		g_title                  = columnData.getString("page3_title");
		g_ntc_user_id 			 = result.getString("regid");
		g_ntc_user_nm 		     = result.getString("regNm");
		g_regdate 				 = result.getString("regdate");
		g_subject 				 = result.getString("subject");
		g_content 				 = result.getString("content");
		g_userIp 				 = result.getString("userIp");
	} 
	
	g_bbsFromDate 			     = result.getString("bbsFromDate");
	g_bbsToDate 				 = result.getString("bbsToDate");
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
var no_seq = "<%=request.getParameter("p_seq")%>" ? "<%=request.getParameter("p_seq")%>" : -1;
//-------------------------------------------------------------------------
// 화면로딩시
//-------------------------------------------------------------------------
var start_image = 1;
var total_image = 1;
var max_image = 7;
var use_pds = 0;
var basic_button_write_file = "file";
function f_OnLoad() {

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
	document.sform.action = "noticeList.dev?progCd=CM0007";
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
		alert("<%=source.getMessage("dev.warn.com.dup",columnData.getString("subject"))%>"); 
		return;
	} 
	
	obj.action = "cm.nt.cudNotice.dev";
	obj.submit(); 
}
  
function f_Delete(){
	document.all.cudmode.value = "D";
    //document.getElementById("cudmode").value 	= "D";
	document.sform.action = "cm.nt.deleteNotice.dev";
	document.sform.submit();
}  
 
</script>

</head>
<body id="cent_bg">
	<div id="conts_box">
	<h2> <span> <%=g_title %> </span></h2>
	<form name="sform" method="post" enctype="multipart/form-data">
		<input type="hidden" name="cudmode" value="<%=cudmode %>"/>
		<input type="hidden" name="regId" value="<%=g_ntc_user_id %>"/>  
		<input type="hidden" name="companyCd" value="<%=g_companyCd %>"/>
		<input type="hidden" name="userIp" value="<%=g_userIp %>"/>
		<input type="hidden" name="email" value="<%=g_email %>"/>  
		<input type="hidden" name="seq" value="<%=g_seq %>"/>
		<input type="hidden" name="delInfo"/>
		<input type="hidden" name="delCnt"/>
<!-- 그리드 S -->	
		<div id="output_board_area">
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board" >
				<colgroup>
					<col width="12%"/>
					<col width="17%"/>   
					<col width="11%"/>
					<col width="17%"/> 
					<col width="11%"/>
					<col width=""/>
				</colgroup>
				<tr>
					<th><%=columnData.getString("subject") %></th>
					<td colspan="5" class="title">  <input type="text" id="subject"	class="input_text" name="subject" style="width:450px;" value="<%=g_subject %>" required/> </td>                             
				</tr>
				<tr>
					<th><%=columnData.getString("regnm") %></th>
					<td><input type="text" id="regNm"	name="regNm" style="width:100px;" class="txtField_read"value="<%=g_ntc_user_nm %>" readonly /></td>
					
					<th><%=columnData.getString("regdate") %></th>
					<td><input type="text" id="regdate" name="regdate" style="width:100px;" class="txtField_read" value="<%=g_regdate%>" readonly /></td>                              
					<th><%=columnData.getString("period") %></th> 
					<td><input type="text" id="bbsFromDate" name="bbsFromDate" value="<%=g_bbsFromDate%>" style="width:62px;"  class="txtField_read"  readonly required/>
					<a href="#">&nbsp;<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(bbsFromDate);" style="cursor:hand"/></a> ~ <input type="text" style="width:62px;" id="bbsToDate" name="bbsToDate" value="<%=g_bbsToDate%>" class="txtField_read"  readonly required/>
					<a href="#">&nbsp;<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(bbsToDate);" style="cursor:hand"/></a></td>
				</tr>				  
				<tr>
					<td colspan="6">
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
                            out.println("btn_file01.gif' style='vertical-align:middle' align='absmiddle' alt='file' onClick='' style='cursor:hand; margin-right:3px;'/> <a href='cm.nt.DownloadFile.dev?filename=");
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
                    			<% for(int i=0;i<9-attach_row_count;i++){ %>
                    
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
				<span class="btn_r btn_l"><input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=g_btn1%>" onclick="javascript:f_Save()"/></span> 
				<span class="btn_r btn_l"><input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnDel%>" onclick="javascript:f_Delete()"/></span> 
				<span class="btn_r btn_l"><input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnList%>" onclick="javascript:f_List();"/></span> 	
			</p>
		</div>
<!-- 버튼 E -->	 
	</form>
<iframe src="about:blank" width=0 height=0 frameborder='0' scrolling=No name='tgframe'></iframe>
</div>

</BODY>
</HTML>