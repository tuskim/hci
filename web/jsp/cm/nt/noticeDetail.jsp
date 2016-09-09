<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--
/*
 *************************************************************************
 * @source  : noticeDetail.jsp
 * @desc    : Notice 상세내역
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
<jsp:useBean id="resultData" class="devon.core.collection.LData"      scope="request"/>
<% 
    String cudmode = result.getString("cudmode");
%>

<html>
<head> 
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />  
<meta content="blendTrans(Duration=0.0)" http-equiv="Page-Enter" />
<meta content="blendTrans(Duration=0.0)" http-equiv="Page-Exit" />
<title><%=columnData.getString("page2_title") %></title> 
 
<script language="javascript">
parent.centerFrame.cols='220,*';
var seq = "<%=request.getParameter("seq")%>" ? "<%=request.getParameter("seq")%>" : -1; 
function f_OnLoad() {

}

//리스트 조회
function f_List() {
	document.sform.action = "noticeList.dev?progCd=CM0007";
	document.sform.submit();
}

</script>

<body id="cent_bg">
<form name="sform" method="post">
<input type="hidden" name="seq" value="<%=result.getString("seq") %>"/>
<input type="hidden" name="companyCd" value="<%=result.getString("companyCd") %>"/>
    <div id="conts_box">
	<h2> <span> <%=columnData.getString("page2_title") %> </span></h2>
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
                    <th><%=columnData.getString("subject")%></th>
                    	<td colspan="5" class="title"><%=result.getString("subject") %> </td>          
                    </tr>	
                    <tr>
                    <th><%=columnData.getString("regnm") %></th> 
                    	<td><input type="text" id="regNm"	name="regNm" style="width:100px;" class="txtField_read"value="<%=result.getString("regNm") %>" readonly /></td>
						<th><%=columnData.getString("regdate") %></th>
                        <td><%=result.getString("regdate") %> </td>                               
                        <th><%=columnData.getString("period") %></th>
                        <td><%=result.getString("bbsFromDate") %> ~ <%=result.getString("bbsToDate") %></td>
                    </tr>						  
					<tr>
                    	<td colspan="6"  style="padding:15px; line-height:20px;" >
                        <%=result.getString("content").replaceAll("\n", "<br>") %>
                        </td>
					</tr>
					<tr>
					<th> <%=columnData.getString("attachment") %> </th>
						<td colspan="5">  
						<%for(int i=0; i < fileAttach.getDataCount(); i++ ) {%>
						&nbsp;<img src="<%=images%>btn_file01.gif" align="absmiddle" alt="file" onClick="" style="cursor:hand; margin-right:3px;"/> <a href="cm.nt.DownloadFile.dev?filename=<%=URLEncoder.encode(fileAttach.getString("fileUrl", i),"UTF-8")%>&fileReal=<%=URLEncoder.encode(fileAttach.getString("fileNm", i),"UTF-8")%>"> <%=fileAttach.getString("fileNm",i) %></a>
					    <br>
						<%} %>
 			 			</td>                             
                	</tr>
       	  		</table>  
		    </div>
        	<!-- 그리드 E -->	
        	<!-- 버튼 S -->	
          	<div id="btn_area">
            	<p class="b_right">
            	<span class="btn_r btn_l">
				    <input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnList %>" onclick="javascript:f_List();"/>
				    </span>	
            	</p>
        	</div>
        	<!-- 버튼 E -->	
		</div>
</form>
</body>
</html>
