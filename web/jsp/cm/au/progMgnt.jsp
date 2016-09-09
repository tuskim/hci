<%--
/*
 *************************************************************************
 * @source  : progMgnt.jsp
 * @desc    : program Mgnt
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2010/07/23   mskim       최초 작성
 * ---  -----------  ----------  -----------------------------------------
 * JIT-HUB시스템
 * Copyright(c) 2006-2007 LG CNS,  All rights reserved.
 *************************************************************************
 */
--%>
<jsp:useBean id="resultData" class="devon.core.collection.LMultiData" scope="request"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Program Manage</title>
<%@ include file="/include/head.jsp" %>

<%
	resultData = (devon.core.collection.LMultiData)request.getAttribute("resultData");

	String msgSave = source.getMessage("dev.cfm.com.save");    // Are you sure to save?
%>

<script type="text/javascript">
var init = "";

// 주의: 하단 그리드의 컬럼이 추가되는 경우, [strHeaderDtl], [gr_custMgnt]를 동일하게 구성해야 합니다.
var strHeaderDtl = "progCd"     + ":STRING(10)"
                 + ",progNmKr"  + ":STRING(100)"
                 + ",progNmEn"  + ":STRING(100)"
                 + ",progNmLo"  + ":STRING(100)"
                 + ",progUpCd"  + ":STRING(10)"
                 + ",progUrl"   + ":STRING(30)"
                 + ",depth"     + ":STRING(1)"
                 + ",sort"      + ":STRING(3)"
                 + ",useyn"     + ":STRING(1)"
                 + ",remark"    + ":STRING(200)";

function f_Onload(){
	init = "onload";
	f_Retrieve();
}
  
//-------------------------------------------------------------------------
// 검색
//-------------------------------------------------------------------------
function f_Retrieve() {
  	var condition = "?";
  
    condition += "progNm=" + document.all.progNm.value;
    ///alert("condition:" + condition);

    ds_progMgnt.DataID = "cm.au.retrieveProgMgntList.gau"+condition;
    ds_progMgnt.Reset();
}  

//-------------------------------------------------------------------------
// New
//-------------------------------------------------------------------------
function f_New(){

	if(ds_progMgnt.CountRow == 0) {       // 최초 입력인 경우, 해당 건을 만들어주고 진행해야한다.

    	cfHideNoDataMsg(gr_progMgnt);

        ds_progMgnt.ClearAll();
        ds_progMgnt.setDataHeader( strHeaderDtl );
     }
     
     var cnt = 0;
     for ( var i = 1; i <= ds_progMgnt.CountRow; i++) {
	     if ( ds_progMgnt.Rowstatus(i) == 1 ) {
	     	cnt++;
	     }
     }
     
     if ( cnt == 0 ) {
     	ds_progMgnt.AddRow();
     	f_Init();
     }
     
     document.all.progCd.readOnly = false;
}

function f_Init() {
	document.all.progCd.value = "";
	document.all.progNmKr.value = "";
	document.all.progNmEn.value = "";
	document.all.progNmLo.value = "";
	document.all.progUpCd.value = "";
	document.all.progUrl.value = "";
	document.all.depth.value = "";
	document.all.sort.value = "";
	document.all.useyn[0].checked = true;
	document.all.remark.value = "";
}
  
//-------------------------------------------------------------------------
// Save
//-------------------------------------------------------------------------
function f_Save(){
   
   if(ds_progMgnt.CountRow == 0) return;
   
   if(!cfValidateGrid(gr_progMgnt, ds_progMgnt.RowPosition, ds_progMgnt.ColumnID(i))) return;
   
   ds_progAuthority.ClearAll();
   
   // 메뉴 권한 파라메타 데이타셋 설정하는 부분 시작
   if( ds_progAuthority.CountColumn == 0 ) {
    	var strHeader = "companyCd:STRING(4),"
    	               +"authCd:STRING(4),"
   					   +"progCd:STRING(10),"
   					   +"userId:STRING(10)";
   		ds_progAuthority.SetDataHeader(strHeader);
   	}

	//alert(ds_progAuthority.text);

    var chk_cd_group = "";

    if(document.all.authCd == null) {
        chk_cd_group = "";
    } else {
        
        var cbox = document.all.authCd;
        var cnt  = 0;
        if(cbox.length) {  // 여러 개일 경우
            for(var i = 0; i<cbox.length; i++) {
                if(cbox[i].checked == true) {
                	cnt++;
                    ds_progAuthority.AddRow();
					ds_progAuthority.NameValue(ds_progAuthority.RowPosition,"companyCd") = "<%=g_companyCd%>";
					ds_progAuthority.NameValue(ds_progAuthority.RowPosition,"authCd") = cbox[i].value;
					ds_progAuthority.NameValue(ds_progAuthority.RowPosition,"progCd") = ds_progMgnt.NameValue(ds_progMgnt.RowPosition,"progCd");
					ds_progAuthority.NameValue(ds_progAuthority.RowPosition,"userId") = "<%=g_userId%>";	
             	}    
        	}
    	} else {  // 한 개일 경우
        	if(cbox.checked == true) {
            	ds_progAuthority.AddRow();
				ds_progAuthority.NameValue(ds_progAuthority.RowPosition,"companyCd") = "<%=g_companyCd%>";
				ds_progAuthority.NameValue(ds_progAuthority.RowPosition,"authCd") = cbox[i].value;
				ds_progAuthority.NameValue(ds_progAuthority.RowPosition,"progCd") = ds_progMgnt.NameValue(ds_progMgnt.RowPosition,"progCd");
				ds_progAuthority.NameValue(ds_progAuthority.RowPosition,"userId") = "<%=g_userId%>";
          	} 
      	}    
  	}
  	
  	
  	if ( cnt == 0 ) {
		ds_progAuthority.AddRow();
		ds_progAuthority.NameValue(ds_progAuthority.RowPosition,"progCd") = ds_progMgnt.NameValue(ds_progMgnt.RowPosition,"progCd");
  	}
  	
 	//delete flag 셋팅   
	if(document.all.useyn[0].checked == true)
    	ds_progMgnt.NameValue(ds_progMgnt.RowPosition,"useyn") = "Y";
  	else
      	ds_progMgnt.NameValue(ds_progMgnt.RowPosition,"useyn") = "N";   
  
  	if (confirm('<%= msgSave %>')) {  
  		tr_cudData.Post();
  		tr_cudData2.Post();//메뉴권한 설정
  	}
  
}
 

</script>

<!-----------------------------------------------------------------------------
  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- Prog Mgnt CUD TR -->
<OBJECT id=tr_cudData classid="<%=LGauceId.TR%>">
	<param name="KeyName" 	value="toinb_dataid4">
	<param name="KeyValue" 	value="JSP(I:IN_DS1=ds_progMgnt)">
	<param name="ServerIP" 	value="">
	<param name="Action"	value="cm.au.cudProgMgnt.gau">
</OBJECT>

<!-- Prog Authority CUD TR -->
<OBJECT id=tr_cudData2 classid="<%=LGauceId.TR%>">
	<param name="KeyName" 	value="toinb_dataid4">
	<param name="KeyValue" 	value="JSP(I:IN_DS1=ds_progAuthority)">
	<param name="ServerIP" 	value="">
	<param name="Action"	value="cm.au.cudProgAuthority.gau">
</OBJECT>

<!-----------------------------------------------------------------------------
    D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- progMgnt DataSet -->
<object id="ds_progMgnt" classid="<%=LGauceId.DATASET%>">
	<param name=ViewDeletedRow value=true>
</object>

<!-- 메뉴권한 DataSet -->
<object id="ds_progAuthority" classid="<%=LGauceId.DATASET%>">
	<param name=ViewDeletedRow value=true>
</object>

<!-----------------------------------------------------------------------------
    G A U C E   C O M P O N E N T' S   E V E N T S
------------------------------------------------------------------------------>
<!-- 저장 TR -->
<script language=JavaScript for=tr_cudData event=OnSuccess()>
  alert("Success");
  f_Retrieve();
</script>

<script language=JavaScript for=tr_cudData event=OnFail()>
  if(tr_cudData.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
        window.parent.location.href = "/index.jsp";    
   }
   
  alert("Error Code : " + tr_cudData.ErrorCode + "\n" + "Error Message : " + tr_cudData.ErrorMsg + "\n");  
</script>


<script language=JavaScript for=ds_progMgnt event=OnLoadCompleted(rowCnt)>
  //cfFillGridNoDataMsg(gr_progMgnt,"gridColLineCnt=2");
</script>

<script language=JavaScript for=ds_progMgnt event=OnLoadError()>
  cfShowErrMsg(ds_progMgnt);
</script>

<script language=JavaScript for=ds_progMgnt event=OnRowPosChanged(row)>

	var authCd = ds_progMgnt.Namevalue(row,"authCd");
	var arr = new Array();
	if(authCd != undefined) arr = authCd.split("|");

	for(i = 0 ; i < document.all.progCd.length ; i++){
		document.all.authCd[i].checked = false;
	}
	
	if(ds_progMgnt.NameValue(row,"useyn") == "Y"){
		document.all.useyn[0].checked = true;
	}else{
		document.all.useyn[1].checked = true;
	}
	
	for(i = 0 ; i < document.all.authCd.length ; i++){

		for(j = 0 ; j < arr.length ; j++){
			if (document.all.authCd[i].value == arr[j]){
				document.all.authCd[i].checked = true;
				break;
			} else {
				document.all.authCd[i].checked = false;
			}			
		}
	}
	
</script>
</head>
<!-----------------------------------------------------------------------------
    화면영역 시작
------------------------------------------------------------------------------>

<body id="cent_bg" onload="f_Onload()">

<div id="conts_box">
	<h2><span> Program Management </span></h2>

	 <!--검색 S -->	
	 <fieldset class="boardSearch">
		<div>
			 <dl>
				<dt> 
					<table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board2" >
						<colgroup>
							<col width="15%"/>
							<col width=""/>
						</colgroup>
						<tr>
							<th><%= columnData.getString("menu_nm") %></th>
							<td><input type="text" id="progNm" name="progNm" style="width:150px;" /></td>										
						</tr>
					</table>
				 </dt>              		  	   	 	
				 <dd class="btnseat1"> 
				 	  <span class="search_btn_r search_btn_l">
                	  <input type="button" onfocus="blur();" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='#e2ebf7'" value="<%=btnSearch %>" onclick="f_Retrieve();"/>
                	  </span> 
				 </dd>
			</dl>
		</div>
	</fieldset>
    <!--검색 E -->

	<div class="sub_stitle"> <p> Program List </p> </div>     	
	<!-- 그리드 S -->	
    <div id="n_board_area">

	<!--- gauss start ----->
	<div style="width:100%;">
	<comment id="__NSID__"><object id="gr_progMgnt" classid="<%=LGauceId.GRID %>" style="width:100%;height:150px;" class="comn"
		dataName="Prog Management"
	    validFeatures="ignoreStatus=no"
		validExp="">
		<param Name="DataID" value="ds_progMgnt">
		<Param Name="AutoResizing" 		value="true">
		<param name="ColSizing" 		value="true">
		<Param Name="DragDropEnable"	value="True">
		<param Name="AddSelectRows" 	value="True">
		<Param Name="SortView" 			value="right">
		<PARAM NAME="TitleHeight"      	VALUE="20">	
		<param Name="Editable" 			value="false">
		<param Name="Format"
			value='
	            <C>id=progCd    name="Program Code"    	align=center    width=120   sort=true </C>
	            <C>id=progNmKr  name="Program Name(KR)"   	align=left  	width=160  sort=true show=false</C>
	            <C>id=progNmEn  name="Program Name(EN)"   	align=left  	width=160  sort=true </C>
	            <C>id=progNmLo  name="Program Name(LO)"   	align=left  	width=160  sort=true </C>
	            <C>id=progUpCd  name="Upper Code"    align=center  	width=100  sort=true </C>
	            <C>id=progUrl   name="Program URL"    	align=left  	width=135  sort=true </C>
	            <C>id=depth     name="<%= columnData.getString("depth") %>"      	align=center  	width=60   sort=true </C>
	            <C>id=sort      name="<%= columnData.getString("sort") %>"          align=center  	width=50   sort=true </C>
				<C>id=useyn	    name="<%= columnData.getString("useyn") %>"	    	align=center    width=70   EditStyle=Combo Data="Y:Use,N:Delete" sort=true</C>
				<C>id=authCd	name="<%= columnData.getString("auth_cd") %>"	    align=center    width=90   show="true" sort=true</C>
				<C>id=remark	name="<%= columnData.getString("remark") %>"	    align=center    width=100  show="true" sort=true</C>
	      '>
	</object></comment> <script>__WS__(__NSID__); </script>
 	</div>

    <!-- 그리드 E -->	
	<div class="sub_stitle"> <p> Program Information </p> </div> 
	<!-- 그리드 S -->	
    <div id="output_board_area">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board" >
		<colgroup>
	        <col width="20%"/>
	        <col width="30%"/>
	        <col width="20%"/>
	        <col width=""/>
		</colgroup>    
	    <tr>
		  <th>Program Code</th>
		  <td><input type="text" id="progCd" 	style="width:150px;" maxlength="10" readonly></td>
		  <th>Program Name(KR)</th>
		  <td><input type="text" id="progNmKr" 	style="width:150px;" maxlength="33" required></td>  
		</tr>
	    <tr>
		  <th>Program Name(EN)</th>
		  <td><input type="text" id="progNmEn" 	style="width:150px;" maxlength="33" required></td>
		  <th>Program Name(LO)</th>
		  <td><input type="text" id="progNmLo" 	style="width:150px;" maxlength="33" required></td>  
		</tr>
	    <tr>
		  <th>Upper Code</th>
		  <td><input type="text" id="progUpCd" 	style="width:150px;" maxlength="10"></td>
		  <th>Program URL</th>
		  <td><input type="text" id="progUrl"   style="width:150px;" maxlength="100"></td>  
		</tr>
	    <tr>
		  <th><%= columnData.getString("depth") %></th>
		  <td><input type="text" id="depth" 	size="1" maxlength="1"></td>
		  <th><%= columnData.getString("sort") %></th>
		  <td><input type="text" id="sort" 		size="3" maxlength="3"></td>  
		</tr>
	    <tr>
		  <th>Use Y/N</th>
		  <td colspan="3"><input type="radio" name="useyn" value="N" checked class="radio">Use <input type="radio" name="useyn" value="Y" class="radio">UnUse</td>  
		</tr>
	    <tr>
		  <th>Remark</th>
		  <td colspan="3"><input type="text" name="remark" size="58"></td>  
		</tr>
	  </table>
	</div>

    <!-- 그리드 E -->	
	<div class="sub_stitle"><p> Program Authority </p> </div> 


	<!-- 그리드 S -->	
	 <fieldset class="boardSearch">
		<div>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
			<%
					System.out.println("resultData.getDataCount():" + resultData.getDataCount());
					int row_count = resultData.getDataCount();
					int cnt = 1;

					for (int idx=0; idx < row_count; idx++) {
			%>
						<td width="25%">
							<input type="checkbox" class="checkbox" name="authCd" value="<%=resultData.getString("detailCd",idx)%>">
							<%=resultData.getString("detailNm",idx)%>
						</td>
			<%
						if(cnt == 4){
							cnt = 1;
			%>
							</tr><tr>
			<%
						}else{
							cnt = cnt + 1;
						}
					}

					for (int j=cnt; j < 5; j++) {
			%>
						<td width="25%">&nbsp;</td>
			<%											
					}
			%>		
				</tr>
			</table>

		</div>
	</fieldset>
    <!--검색 E -->	
    <!-- 그리드 E -->	

<object id=bd_progMgnt classid="<%=LGauceId.BIND%>">
	<param name=DataID value=ds_progMgnt>
	<param name=BindInfo 
		value='
			<C> Col=progCd    		Ctrl=progCd     	Param=value  </C>
			<C> Col=progNmKr        Ctrl=progNmKr     	Param=value  </C>
			<C> Col=progNmEn        Ctrl=progNmEn     	Param=value  </C>
			<C> Col=progNmLo        Ctrl=progNmLo     	Param=value  </C>
			<C> Col=progUrl  		Ctrl=progUrl 		Param=value  </C>
			<C> Col=sort  			Ctrl=sort 			Param=value  </C>
			<C> Col=depth  			Ctrl=depth 			Param=value  </C>
			<C> Col=progUpCd  		Ctrl=progUpCd 		Param=value  </C>
			<C> Col=sort  			Ctrl=sort 			Param=value  </C>
			<C> Col=remark 			Ctrl=remark			Param=value  </C>
  		'>
</object>


	<!-- 버튼 S -->	
    <div id="btn_area">
    	<p class="b_right">
    	<span class="btn_r btn_l"><input type="button" onClick="f_New();" 		onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%= btnNew %>"/></span>
    	<span class="btn_r btn_l"><input type="button" onClick="f_Save();" 	    onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%= btnSave %>"/></span>
    	</p>
   	</div>
    <!-- 버튼 E -->

    <div class="pad_t5"></div>

<script src="xjos/xjos.js" language="javascript"></script>


</BODY>
</HTML>
