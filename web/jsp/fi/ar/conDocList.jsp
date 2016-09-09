<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--
/*
 *************************************************************************
 * @source  : ConDocList.jsp
 * @desc    : 게시판 리스트
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
<%@ include file="/include/head.jsp" %>
<%@ page import="devon.core.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="comm.util.DateUtil" %>
<%@ page import="devon.core.collection.LMultiData" %>

<jsp:useBean id="pageNavigation" class="devonframework.front.paging.LDefaultPageNavigation" scope="request" />
<jsp:useBean id="param" class="devon.core.collection.LData" scope="request"/>
<jsp:useBean id="ptmgeUtil"  class="comm.util.Util"  scope="request" />
<jsp:useBean id="stringUtil"  class="comm.util.StringUtil"  scope="request" />
<jsp:useBean id="resultData" class="devon.core.collection.LData"      scope="request"/> 
        
<% 
String g_docNo = request.getParameter("p_docNo");	
String g_authType = "false";
LMultiData mPageData = new LMultiData();
mPageData = (LMultiData)pageNavigation.getResultMultiData();	

String req_doc_no = ptmgeUtil.nullToString(param.getString("docNo"));
String req_subject = ptmgeUtil.nullToString(param.getString("subject"));
String req_writerNm = ptmgeUtil.nullToString(param.getString("writerNm"));

if(g_authCd.equals("AD")){
	g_authType="true";
}

 
%>
<html>
<head> 
<meta http-equiv="Pragma" content="no-cache"/>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<meta content="blendTrans(Duration=0.0)" http-equiv="Page-Enter" />
<meta content="blendTrans(Duration=0.0)" http-equiv="Page-Exit" />

<title><%=columnData.getString("page1_title") %></title> 
<script language="javascript">
function init() {
	 parent.centerFrame.cols='220,*';
 
} 
//리스트 조회
function f_Retrieve() {  
	document.sform.action = "conDocList.dev?progCd=FI0007&docNo="+sform.t_docNo.value+"&subject="+sform.t_subject.value+"&writerNm="+document.sform.t_writerNm.value;
	document.sform.submit();
}

// 상세화면 이동
function f_RetrieveDetail(p_company,p_useId,p_docNo){ 
	document.getElementById("companyCd").value 	= p_company;
	document.getElementById('docNo').value 		= p_docNo; 
	document.sform.action  = "fi.ar.retrieveConDocUpdate.dev?progCd=FI0007"; 
	/*
	if(p_company=="<%=g_companyCd%>" && p_useId=="<%=g_userId%>" ){
		document.sform.action  = "fi.ar.retrieveConDocUpdate.dev?progCd=FI0007"; 
	}else{ 
		if(<%=g_authType%>){
			document.sform.action  = "fi.ar.retrieveConDocUpdate.dev?progCd=FI0007"; 
		}else{
			document.sform.action = "fi.ar.retrieveConDocDetail.dev?progCd=FI0007";
		}
	}
	*/
	
	document.sform.submit();
}

// 신규등록
function f_Create(){  	
	//신규화면은 -1을 파람으로 보내 신규용처리를 함 
	document.getElementById("docNo").value 					= "";
	document.sform.action  = "fi.ar.retrieveConDocUpdate.dev?progCd=FI0007";    
	document.sform.submit();
}
</script>
</head>
<body id="cent_bg"onload="init()">
<!-- Start 검색폼(sform) -->
	<%=pageNavigation.showJavaScript()%>
	<form name="sform" method="post">
		<input type="hidden" name=companyCd id="companyCd" value=""/>
		<input type="hidden" name=docNo id="docNo" value=""/>
		<input type="hidden" name=g_docNo id="g_docNo" value=""/>	
	<%=pageNavigation.showHiddenParam()%>
		<div id="conts_box"  >
		<h2> <span>  <%=columnData.getString("page_title1") %> </span></h2>
<!--검색 S -->	
			<div style="margin-top:-10px;">
			</div>
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
						<th> <%=columnData.getString("doc_no") %> </th>
						<td><input type="text" style="width:100px;" id="t_docNo"  value="<%=req_doc_no %>"/></td>
						<th> <%=columnData.getString("subject") %> </th>
						<td><input type="text" style="width:100px;" id="t_subject"value="<%=req_subject %>"  /></td>
						<th> <%=columnData.getString("writer") %> </th>
						<td><input type="text" style="width:100px;" id=t_writerNm value="<%=req_writerNm %>" /></td>						
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
			<div class="sub_stitle"> <p><%=columnData.getString("sub_title1") %>  </p> </div> 
<!-- 그리드 S -->	 
			<div id="n_board_area">
				<table width="100%" border="0" cellpadding="0" cellspacing="0" class="list" >
					<colgroup>
						<col width="8%"/>
						<col width="10%"/>
						<col width=""/>
						<col width="22%"/>
						<col width="10%"/>
					</colgroup>
					<thead>
					<tr>
						<th>No. </th>
						<th> <%=columnData.getString("doc_no") %>   </th>
						<th> <%=columnData.getString("subject") %>    </th>
						<th> <%=columnData.getString("writer") %>    </th>
						<th> <%=columnData.getString("date") %>  </th> 
					</tr>
					</thead>
					<tbody>
					<%	
					pageNavigation.setImageSpec( "webPage" );
					for(int index=0;index < mPageData.getDataCount(); index++) {
						int subjectLength = 50;				
						String subject = mPageData.getString("subject",index);
						//게시판 제목 자르기
						subject = stringUtil.cropByte(subject, subjectLength, "...");                
						//첨부파일
						String imageStr = "";
						if (ptmgeUtil.nullToString(mPageData.getString("seqAttach",index)) != "")
							imageStr = "&nbsp;<img src='sys/images/button/btn_file01.gif' style='vertical-align:middle'>";
						%>
						<tr>
							<td><%=index+1 %></td>
							<td><%=mPageData.getString("docNo",index) %></td>
							<td class="title"><a href="javascript:f_RetrieveDetail('<%=mPageData.getString("companyCd",index)%>','<%=mPageData.getString("regid",index)%>','<%=mPageData.getString("docNo",index) %>')"><%=subject%></a><%=imageStr %></td>
							<td><%=mPageData.getString("writerNm",index) %></td>	    		
							<td><%=mPageData.getString("regdate",index) %></td>	    									    		
						</tr>
						<%
						} %>	
					</tbody>
				</table>  
			</div>
<!-- 그리드 E -->	
<!-- 페이징 시작	-->
			<%
			if(mPageData.getDataCount() > 0) {%>	  
			<div class='list_nevi_box'>
				<div class='paginate paginate-type2'> 
					<%=pageNavigation.showMoveBeforePage() %>
					<%=pageNavigation.showIndex() %>
					<%=pageNavigation.showMoveNextPage() %> 					
				</div>
			</div>
			<%
			} %>
<!--  페이징 끝	-->	
				
<!-- 버튼 S -->	
			<div id="btn_area">
				<p class="b_right"><span class="btn_r btn_l">
					<input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnWrite %>" onclick="javascript:f_Create();"/></span> 
				</p>
			</div> 	

<!-- 버튼 E -->	 
		</div>  
	</form>
	
</body>
<script src="/xjos/xjos.js" language="JScript"/></script>
</html>