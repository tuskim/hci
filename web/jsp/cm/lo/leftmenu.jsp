<%--
/*
 *************************************************************************
 * @source  : leftmenu.jsp
 * @desc    : subMenu  List
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2010.07.21 노태훈       신규작성
 * 1.1  2015.10.08 hskim    CSR:C20151005_87394 공지사항 조회 변경
 * ---  -----------  ----------  -----------------------------------------
 * PT-PAM 시스템
 * Copyright(c) 2006-2007 LG CNS,  All rights reserved.
 *************************************************************************
 */
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>PT-PAM System</title> 
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<%@ include file="/include/head.jsp" %>
<script type="text/javascript" src="/sys/js/comm/dui_slidemenu.js"></script>
<link type="text/css" rel="stylesheet" href="/sys/css/dui_slidemenu.css" />

<%
// page 이동을 위한 parm
String g_menuCd      = request.getParameter("h_menuCd")  == null?"":request.getParameter("h_menuCd");
String g_menuNm      = request.getParameter("h_menuNm")  == null?"":request.getParameter("h_menuNm");
String g_gubun       = request.getParameter("h_gubun")   == null?"":request.getParameter("h_gubun");
String g_seq         = request.getParameter("h_seq")     == null?"":request.getParameter("h_seq");
String p_useId       = request.getParameter("h_useId")   == null?"":request.getParameter("h_useId");
LMultiData LmainList = new LMultiData(); // 전체 메뉴
LMultiData Lmain     = new LMultiData(); // left menu
LmainList = (LMultiData) session.getAttribute("menuList");

//left mene 만 생성
int depth2Cnt = 0;
int depth3Cnt = 0;
for (int i = 0; i < LmainList.getDataCount(); i++) {
	// 2레벨 depth 이상이고 시작 프로그램CD가 넘어온 파라메터CD와 같을 경우
	int depth = LmainList.getInt("depth", i);
	if (1 < depth && LmainList.getString("rootProgCd", i).equals(g_menuCd)) {
		Lmain.add("depth",   LmainList.getString("depth",   i));
		Lmain.add("progCd",  LmainList.getString("progCd",  i));
		Lmain.add("progNm",  LmainList.getString("progNm",  i));
		Lmain.add("progUrl", LmainList.getString("progUrl", i));

		if (2 == depth) {
			depth2Cnt++;
		}
  	}
}   

boolean g_authType = false;
if (g_authCd.equals("AD") || p_useId.equals(g_userId)) {
	g_authType = true;
}
%>
<script language="JavaScript">
var _slideMenu;

function init() {
	var root = D$("LblockLeftMenu").getElementsByTagName("ul")[0];
	_slideMenu = dui.SlideMenu.makeSlideMenu(root);
	
	if("<%=g_gubun%>" =="LIST") {   
		// notice List 바로가기 & 메뉴클릭시  class 변경
		window.top.mainFrame.location.href = "/noticeList.dev?progCd=CM0007";
	
	}else if("<%=g_gubun%>" =="DETAIL") { 
		window.top.mainFrame.location.href = "/cm.nt.retrieveNoticeDetail.dev?progCd=CM0007&seq=" + "<%=g_seq%>";

	}else if("<%=g_gubun%>" =="USERCHANGE") {
		// user info change 바로가기& 메뉴클릭시  class 변경
		window.top.mainFrame.location.href = "/userInfoChange.dev?progCd=CM0002";
	
	} else { 
<%
// 최초 URL 페이지 호출
for (int i = 0; i < Lmain.getDataCount(); i++) {
	int depth      = Lmain.getInt("depth",      i);
	String progCd  = Lmain.getString("progCd",  i);
	String progNm  = Lmain.getString("progNm",  i);
	String progUrl = Lmain.getString("progUrl", i);
	
	if (progUrl != null) {
%>
		goMenu('<%=progCd %>', '<%=progUrl %>', '<%=progNm %>');
<%
		break;
	}
}
%>
	}
}

// 메뉴 권한 체크
function goMenu(code, menuUrl, remark) {
	var form = document.menuForm; 
	form.action = "/" + menuUrl + "?progCd=" + code;
	form.submit();
	
	cfSetCenterFrame();
}

//로그아웃
function logOut() {
	parent.document.location.href   = "/commLogoutUserCmd.dev";
	parent.document.location.target = "_top";
}

//사용자 정보변경
function changeUser() {
	window.parent.mainFrame.document.location.href = "/userInfoChange.dev?progCd=CM0002"; 
}
</script>
</head>


<body id="left_bg" onLoad="init()">
<div id="subleft_box">
	<div class="s_loginbox">
		<p><img src="/sys/images/button/bullet01.gif" alt="작은블릿" /><span class="blue b"><%=g_userNm%></span></p>
		<p>
			<span class="sbtn_r2">
				<input type="button" onfocus="blur();" onmouseover="this.style.color='#c52553'" onmouseout="this.style.color='#f0f0f0'" value="<%=btnLogOut%>"  onclick="logOut()"/>
				<input type="button" onfocus="blur();" onmouseover="this.style.color='#c52553'" onmouseout="this.style.color='#f0f0f0'" value="<%=btnLogInfo%>" onclick="changeUser();"/>
			</span>
		</p>
	</div>
	
	<div id="Lsidebar">
		<form name="menuForm" method="post" target="mainFrame">
			<input type="hidden" name="h_url" value="" />
	 		<input type="hidden" name="p_seq" value="" />
		</form>
		<h1><%=g_menuNm%></h1>
		<div id="LblockLeftMenu">
			<ul>
			<%
			boolean isDepth3Start = true;
			for (int i = 0; i < Lmain.getDataCount(); i++) {
				int depth       = Lmain.getInt("depth", i);
				String progCd   = Lmain.getString("progCd",   i);
				String progNm   = Lmain.getString("progNm",   i);
				String progUrl  = Lmain.getString("progUrl",  i);
				
				String className = "";
				if (2 == depth) {
					depth2Cnt--;
					depth3Cnt = 0;
					if (0 == i) {
						className = " class=\"Lfirst Lopen LhasChild\"";
					
					} else if (0 == depth2Cnt) {
						className = " class=\"Llast LhasChild\"";
			
					} else {
						className = " class=\"LhasChild\"";
					}
			%>
							<li<%=className%>><span><a href="#"><%=progNm%></a></span>
								<ul>
			<%
				} else { // 무조건 depth:3
					if (0 == depth3Cnt) {
						if (isDepth3Start) {
							className = " class=\"Lfirst Lcurrent\"";
							isDepth3Start = false;
						} else {
							className = " class=\"Lfirst\"";
						}
						depth3Cnt++;
			
					} else {
						if (i + 1 < Lmain.getDataCount()) {
							if (Lmain.getInt("depth", i + 1) < depth) {
								className = " class=\"Llast\"";
							}
						} else {
							className = " class=\"Llast\"";
						}
					}
			%>
									<li<%=className%>>
										<span class="tooltip"><a href="javascript:goMenu('<%=progCd %>', '<%=progUrl %>', '<%=progNm %>');"><%=progNm%></a></span>
									</li>
			<%
				}
				
				
				if (i + 1 < Lmain.getDataCount()) {
					if (Lmain.getInt("depth", i + 1) < depth) {
			%>
								</ul>
							</li>
			<%
					}
				} else {
			%>
								</ul>
							</li>
			<%
				}
			}
			%>
			</ul>
		</div><!-- END subMenu : LblockLeftMenu -->
	</div><!-- END sidebar : Lsidebar -->
</div>
</body>
</html>
