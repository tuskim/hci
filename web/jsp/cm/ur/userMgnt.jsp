<!DOCTYPE html >
<html>
<%@ include file="/include/doctype.jsp"%>
<%--
/*
 *************************************************************************
 * @source  : UserMgnt.jsp
 * @desc    : 사용자 관리 
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2016.08.02   hsim	     Init
 * ---  -----------  ----------  -----------------------------------------
 * HCI 프로젝트
 * Copyright(c) 2006-2007 LG CNS,  All rights reserved.
 *************************************************************************
 */
--%>
<%@ page import="devon.core.collection.LMultiData"%>
<%@ page import="devon.core.collection.LData"%>
<%@ page import="java.util.Date"%>
<%@ include file="/include/head.jsp"%>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="blendTrans(Duration=0.0)" http-equiv="Page-Enter" />
<meta content="blendTrans(Duration=0.0)" http-equiv="Page-Exit" />
<%@ page import="devon.core.util.*" %>
<%
	String prevDate	   = LDateUtils.getDate("yyyy/MM/") +"01"; 
	String currentDate = LDateUtils.getDate("yyyy/MM/dd");    		
	String msgInfoChange    = source.getMessage("dev.inf.com.nochange");    // no data for change.
	String msgSave            = source.getMessage("dev.cfm.com.save");      // Are you sure to save?
	String msgDelete          = source.getMessage("dev.cfm.com.delete");    // Are you sure to Delete?
	String msgContinue          = source.getMessage("dev.cfm.com.continue");  // Are you sure to Continue?
%> 
<head>
<script type="text/javascript">
parent.centerFrame.cols='220,*';
//-------------------------------------------------------------------------
//combobox	 	
//-------------------------------------------------------------------------		
function init(){
	 ds_dept.DataID ="cm.cm.retrieveCommComboCostCenterList.gau";
	 ds_dept.Reset();
	 ds_auth.DataID ="cm.cm.retrieveCommCodeCombo.gau?groupCd=1010";
	 ds_auth.Reset();	 
	 cfAddYn(ds_yn,"code");
	 cfGender(ds_gender,"code","BLANK");
}
function cfGender(oTargetDataSet,codeColumn,codeBlank) {
	if(codeBlank == "undifined"){
 		codeBlank="";
 	}
	var strHeader  = codeColumn+":STRING(2),name:STRING(6)";
 	oTargetDataSet.SetDataHeader(strHeader);
 	if(codeBlank =="BLANK" ){
		oTargetDataSet.AddRow();
 		oTargetDataSet.NameValue(oTargetDataSet.RowPosition, codeColumn) = "";    
 		oTargetDataSet.NameValue(oTargetDataSet.RowPosition, "name") = ""; 
	}
 oTargetDataSet.AddRow();
 oTargetDataSet.NameValue(oTargetDataSet.RowPosition, codeColumn) = "M"; 
 oTargetDataSet.NameValue(oTargetDataSet.RowPosition, "name") = "Male";
 oTargetDataSet.AddRow();
 oTargetDataSet.NameValue(oTargetDataSet.RowPosition, codeColumn) = "W"; 
 oTargetDataSet.NameValue(oTargetDataSet.RowPosition, "name") = "Female";
 oTargetDataSet.RowPosition=1;
}
//-------------------------------------------------------------------------
//조회조건 입력시 	 	
//-------------------------------------------------------------------------				
function keyLogin(evt){
	if ( evt.keyCode == 13 || evt == '^') {
		f_search();	
	}
}

//-------------------------------------------------------------------------
//검색 버튼 클릭시 사용자목록 조회
//-------------------------------------------------------------------------		
function f_search() {
	var form = document.aForm;
	var paramHead = "userId:STRING(100), usernm:STRING(100)";
	ds_param.setDataHeader(paramHead);
	ds_param.AddRow();
	ds_param.NameValue( 1 , "userId" )	    = form.seekUserId.value;
	ds_param.NameValue( 1 , "userNm" )	    = form.seekUserNm.value;
	ds_grid.ClearAll();
	tr_master.Action   	= "/cm.ur.retrieveUserMgnt.gau";
	tr_master.KeyValue 	= "SERVLET( I:ds_param=ds_param , O:ds_grid=ds_grid )";//조회
	tr_master.post();		
}				   

//-------------------------------------------------------------------------
//사용자 ID 변경시 
//-------------------------------------------------------------------------	
function f_changeUserId( obj ) {
	if( !obj.readOnly ) {
			document.getElementById("idCheck").value	= "N";
	}
}

//-------------------------------------------------------------------------
//아이디 중복체크
//-------------------------------------------------------------------------		
function f_userIdCheck() {
	var form = document.bForm;
	if( "1" == ds_grid.RowStatus( ds_grid.RowPosition ) ) {
		if( f_isNull(ds_grid.NameValue( ds_grid.RowPosition, "userId" )) ) {
			alert("<%=source.getMessage("dev.warn.com.input","'ID'")%>" );
			form.userId.focus();
			return false;
		}else if( ds_grid.NameValue( ds_grid.RowPosition, "userId" ).trim().length > form.userId.maxlength  ) {
			alert("<%=source.getMessage("dev.msg.cm.outOfRange")%>" );
			form.userId.focus();
			return false;
		}else{
			var paramHead = "userId:STRING(100)";
			ds_param.setDataHeader( "userId:STRING(100)" );
			ds_param.AddRow();
			ds_param.NameValue( 1 , "userId" )	    = ds_grid.NameValue( ds_grid.RowPosition, "userId" );
			tr_idCheckmaster.Action   	= "/cm.ur.retrieveUserIdCheck.gau";
			tr_idCheckmaster.KeyValue 	= "SERVLET( I:ds_param=ds_param, O:ds_temp=ds_temp )";//조회
			tr_idCheckmaster.post();		    			   
		}
	}
} 
//-------------------------------------------------------------------------
//사원정보 팝업
//-------------------------------------------------------------------------		
function f_openEmployeeChk() {
	if( "1" == ds_grid.RowStatus( ds_grid.RowPosition ) ) {
		openEmployeeChk();
	}
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
//신규버튼 클릭시
//-------------------------------------------------------------------------					
function f_addRow() {
	var form 	= document.bForm;
	var	row		= 0;
	var	flag	= false;
	if( ds_grid.CountColumn == 0 ) {
		ds_grid.SetDataHeader( f_setHeader() );
	}else{
		for( var i=1,cnt=0; i <= ds_grid.CountRow; i++ ) {			
			if( "1" == ds_grid.RowStatus( i ) ) {
				cnt++;
			}
			if( cnt == 1 ) {
				flag	= true;
			}
		}
	}
	if( flag ) {
		if( !form.userId.readOnly ) {
			form.userId.focus();
		}
		return;
	}else{
		ds_grid.UndoAll();
		ds_grid.AddRow();
		ds_grid.NameValue(ds_grid.RowPosition,"companyCd")= "<%=g_companyCd%>";	
	    ds_dept.DataID ="cm.cm.retrieveCommComboCostCenterList.gau";
	    ds_dept.Reset();
	    ds_auth.DataID ="cm.cm.retrieveCommCodeCombo.gau?groupCd=1010";
	    ds_auth.Reset();	 
	 	cfAddYn(ds_yn,"code");
	 	cfGender(ds_gender,"code","BLANK");		
		form.userId.readOnly	= false;
		form.userId.className	= "input_L";
		form.userId.focus();
	}
}
function f_setHeader() {
	var strHeader = "userId:STRING(100), userNm:STRING(100), detailDeptCd:STRING(100),"
	    		     + " business:STRING(100), authCd:STRING(100), email:STRING(100),deptCd:STRING(100),"
	        		 + " useyn:STRING(100), companyCd:STRING(100), systemId:STRING(100) ,detailAuthCd:String(100),";
	        		+ "position:STRING(100),loginErrorCount:STRING(100)";
	return strHeader;
}
//-------------------------------------------------------------------------
//저장버튼 클릭시
//-------------------------------------------------------------------------			
function f_process() {
	var form 	= document.bForm;

	 if( ds_grid.IsUpdated == false ) {
	
		alert("<%=msgInfoChange%>" );return;
	
	    return;
	}else{
		var	checkedRow = 0;
		for( var i=1; i <= ds_grid.CountRow; i++ ) {
			if( "0" != ds_grid.RowStatus( i ) ) {
				checkedRow	= i;	
				ds_grid.RowPosition	= checkedRow;				
				//var val = document.bForm.validate();--오작동
				if (true) {	//if(var)
					if(!f_validate()){
						return;
					}		
				}else{
					return;
				}
			}
		}
		alert("Are you sure to Save?");
		tr_cuMaster.Action   = "/cm.ur.cudUserMgnt.gau";
		tr_cuMaster.KeyValue = "SERVLET( I:ds_grid=ds_grid, O:ds_grid=ds_grid )";
		tr_cuMaster.Post();	
	}
}
//-------------------------------------------------------------------------
//입력전 신규버튼을 점검
//-------------------------------------------------------------------------					
function f_newCheck( evt, obj, gridNm ) {
	if( evt && evt.type ) {
		gridNm	= f_isNull( gridNm ) ? "ds_grid" : gridNm;
		obj		= ( document.getElementById(obj) != null && typeof(document.getElementById(obj)) == "object" ) ? document.getElementById(obj) : obj ;
		if( eval(gridNm+ ".RowPosition") == 0 ) {
			if( obj.tagName == "INPUT" ) {
				if(obj.type == "text" || obj.type == "password" ) {
					obj.value = "";
				}
			}else if( obj.tagName == "TEXTAREA" ) {
				obj.value 	= "";
			}else if( obj.tagName == "OBJECT" ) {
				obj.Index	= -1;
			}
			return false;
		}
	}
	return true;
}
//-------------------------------------------------------------------------
//validation
//-------------------------------------------------------------------------					
function f_validate() {
	var form 	= document.bForm;
	var	row		= ds_grid.RowPosition;
	if( f_isNull(ds_grid.NameValue( row , "useyn" )) ) {
			alert("<%=source.getMessage("dev.warn.com.input","'USE'")%>" );
		form.useyn.focus();
		return false;
	}
	if( "1" == ds_grid.RowStatus( ds_grid.RowPosition ) && "N" == document.getElementById("idCheck").value ) {
			alert("<%=source.getMessage("dev.msg.cm.checkId")%>" );
		form.userId.focus();
		return false;
	}	
	return true;
}						
function f_unblock(){
	//cm.ur.accountUnblocking
	var form 	= document.bForm;
	var	row		= ds_grid.RowPosition;
	var userId = ds_grid.NameValue( row , "userId" );
	var companyCd = "<%=g_companyCd%>";
	form.action   = "/cm.ur.accountUnblocking.dev?progCd=CM0001&companyCd="+companyCd+"&userId="+userId;
	form.submit();
}
function f_reset(){
	//cm.ur.passwordReset
	var form 	= document.bForm;
	var	row		= ds_grid.RowPosition;
	var userId = ds_grid.NameValue( row , "userId" );
	var companyCd = "<%=g_companyCd%>";
	form.action = "/cm.ur.passwordReset.dev?progCd=CM0001&companyCd="+companyCd+"&userId="+userId;
	form.submit();	
}
</script>
<!-----------------------------------------------------------------------------
		 D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- Grid 영역 DataSet-->
<object id="ds_grid" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad" value="true">
	<param name="ViewDeletedRow" value="true">
</object>
<object id="ds_temp" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad" value="true">
	<param name="ViewDeletedRow" value="true">
</object>
<object id="gds" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad" value="true">
	<param name="ViewDeletedRow" value="true">
</object>
<!--combo DataSet -->
<comment id="__NSID__"><object id="ds_dept"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"          value="true"> 
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
<comment id="__NSID__"><object id="ds_auth"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"          value="true"> 
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
<object id="ds_yn"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
</object>
<object id="ds_gender"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
</object>
<object id="ds_param" classid="<%=LGauceId.DATASET%>"> </object>
<OBJECT id="tr_master" classid="<%=LGauceId.TR%>">
	<param name="KeyName" value="toinb_dataid4">
</OBJECT>
<OBJECT id="tr_idCheckmaster" classid="<%=LGauceId.TR%>">
	<param name="KeyName" value="toinb_dataid4">
</OBJECT>
<!-- CU TR -->
<OBJECT id=tr_cuMaster classid="<%=LGauceId.TR%>">
	<param name="KeyName" value="toinb_dataid4">
</OBJECT>
<!-----------------------------------------------------------------------------
Gauce Component Event
------------------------------------------------------------------------------>
<script language=JavaScript for=tr_cuMaster event=OnFail()>
    mode = "";
    if(tr_master.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
        window.parent.location.href = "/index.jsp";    
    }
    alert(tr_cuMaster.ErrorMsg);
</script>
<script language=JavaScript for=tr_cuMaster event=OnSuccess()>	
        alert("successfully saved.");
        f_search();
</script>
<script language=JavaScript for="ds_auth" event=OnRowPosChanged(row)>
		ds_grid.nameValue(ds_grid.rowPosition,"detailAuthCd") =ds_auth.nameValue(ds_auth.rowPosition,"name");
</script>
<script language=JavaScript for="ds_dept" event=OnRowPosChanged(row)>
		ds_grid.nameValue(ds_grid.rowPosition,"detailDeptCd") =ds_dept.nameValue(ds_dept.rowPosition,"name");
</script>
<script language="javascript" for="ds_temp" event="onLoadCompleted(rowcnt)">
		if( ds_temp.CountRow > 0 ) {
			var form 	= document.bForm;
			if( "exist" == ds_temp.NameValue( ds_temp.RowPosition, "existCheck" ) ) {
				document.getElementById("idCheck").value	= "N";
				alert("userId already existed");
				form.userId.value	= "";
				form.userId.focus();
			}else{
				document.getElementById("idCheck").value	= "Y";
				alert("userId is available");
				form.userId.focus();
				}
			}
</script>
</head>
<body id="cent_bg" onload="init();f_search()">
<div id="conts_box">
<h2><span><%=columnData.getString("page_title") %></span></h2>

<fieldset class="boardSearch"><legend></legend>
<div>
<dl>
	<dt>
	<form name="aForm" style="margin:0px">
	<table width="100%" border="0" cellpadding="0" cellspacing="0"
		class="output_board2">
		<colgroup>
			<col width="10%" />
			<col width="25%" />
			<col width="10%" />
			<col width="" />
		</colgroup>
		<tr>
			<th class="lineb_none"><%=columnData.getString("user_id") %></th>
			<td class="lineb_none"><input type="text" name="seekUserId"
				id="seekUserId" onkeydown="keyLogin(event)" size="18"
				class="input_Licon"/></td>
			<th class="lineb_none"><%=columnData.getString("user_nm") %></th>
			<td class="lineb_none"><input type="text" name="seekUserNm"
				id="seekUserNm" onkeydown="keyLogin(event)" size="18"
				class="input_Licon"/>
			</td>
	</table>
	</dt>
	<dd class="btnseat1">
	 <span class="search_btn_r search_btn_l">
     <input type="button" onfocus="blur();" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='#e2ebf7'" value="<%=btnSearch %>" onclick="f_search()"/></span>
	 </dd>				
</dl>
</div>
</fieldset>
</form>
<div class="sub_stitle">
<p><%=columnData.getString("sub1_title") %></p>
</div>
<div>
<table width="768" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="768"><comment id="__NSID__"/>
		<object	id="gr_grid" classid="<%=LGauceId.GRID%>" style="width:755px;height:135px" class="comn">
			<param name="DataID" value="ds_grid"/>
			<param name="Editable" value="TRUE"/>
			<param name="Format"
				value='
						<c>id="userId"    	Show="ture"  Edit="none"  			align="center"  	width="90"     name="User ID" 	   	</c>
						<c>id="userNm"    			     Edit="none"   			align="left"  	width="120"     name="User Name"    	</c>
			            <c>id="deptCd"    	Show="false" Edit="none"   			align="center"  width="90"     name="deptCd" 	   	</c> 		
			            <c>id="detailDeptCd"    	     Edit="none"   			align="left"  	width="120"     name="Department" 	   	</c>		
			            <c>id="business"    			 Edit="none"   			align="left"  	width="130"     name="Job(Role)"     	</c>   		
			            <c>id="detailAuthCd"    		 Edit="none"   			align="left" 	width="110"     name="<%=columnData.getString("auth_cd") %>"  		</c> 		
			            <c>id="email"     			   	 Edit="none"  			align="left"    width="150"	   name="<%=columnData.getString("email") %>" show="false"	</c>			    
			            <C>id="loginErrorCount"			 Edit="none"			align="center"  width="107"	   name="Login Error Count" DECIMAL="#"</C>
			            <c>id="useyn"    				 Edit="none"   			align="center"  width="60"     name="<%=columnData.getString("useyn")%>" 		</c>       
			            <c>id="companyCd"  	Show="false" Edit="none"  			align="center"  width="110"    name="companyCd"  </c>
			            <c>id="systemId"  	Show="false" Edit="none"  			align="center"  width="110"    name="systemId"  </c>
						'></param>
		</object></comment> <script>__WS__(__NSID__);</script></td>
	</tr>
</table>
</div>
<div class="sub_stitle">
<p><%=columnData.getString("sub2_title") %></p>
</div>
<div id="output_board_area">
<form name="bForm" method="post" style="margin:0px" >
<input type="hidden" id = "idCheck"	name="idCheck" 	value="N"/>
<table width="100%" border="0" cellpadding="0" cellspacing="0"class="output_board">
	<colgroup>
		<col width="18%" />
		<col width="33%" />
		<col width="18%" />
		<col width="" />
	</colgroup>
	<tr>
		<th class="required"><%=columnData.getString("user_id") %></th>
		<td><input id="userId" name="userId" type="text" onKeyDown	= "f_changeUserId(this)" style="width:95px;" alt="ID" required readonly/>   
		&nbsp;<img src="<%= images %>button/search_icon_2.gif"  alt="Id Check" onClick="javascript:f_openEmployeeChk();" style="cursor:hand"/>
		<span class="sbtn_r sbtn_l">
            <input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'"  id="imgIdCheck" onmouseout="this.style.color='#7b87a0'" value="<%=btnIdCheck%>"onclick="f_userIdCheck()" /></span> 
		</td>
		<th class="">Account Unblocking</th>
		<td><input type="button" id="unblock" name="unblock" value = "Unblock"  style="height: 20px;width:80px" onclick="f_unblock();" /></td>
	</tr>
	<tr>
		<th class="required"><%=columnData.getString("user_nm") %></th>
		<td><input id="userNm" name="userNm" type="text" style="width:150px;" alt="ì±ëª" required /></td>
		<th class="">Password Reset</th>
		<td><input type="button" id="reset" name="reset" value = "Reset"  style="height: 20px;width:80px" onclick="f_reset();" /></td>
	</tr>
	<tr>
		<th class="required">Department</th>
		<td><comment id="__NSID__"><object id="lxOrgCd"  classid="<%=LGauceId.LUXECOMBO%>" width="160">
								    <param name="ComboDataID"       value="ds_dept">
									<param name="ListCount"     	value="10">
									<param name=SearchColumn		value="name">
									<param name="BindColumn"    	value="code">
								    <param name=ListExprFormat		value="name^0^160, code^0^60">
								    <param name=index           	value=0>
							   	</object></comment><script>__WS__(__NSID__); </script></td>
		<th class="required"><%=columnData.getString("auth_cd") %></th>
		<td><comment id="__NSID__"><object id="txMatkl2"  classid="<%=LGauceId.LUXECOMBO%>" width="160">
								    <param name="ComboDataID"       value="ds_auth">
									<param name="ListCount"     	value="10">
									<param name=SearchColumn		value="name">
									<param name="BindColumn"    	value="code">
								    <param name=ListExprFormat		value="name^0^100, code^0^60">
								    <param name=index           	value=0>
							   	</object></comment><script>__WS__(__NSID__); </script></td>
	</tr>
	<tr>	
		<th><%=columnData.getString("business") %></th>
		<td><input id="business" name="business" type="text" style="width:150px;" ></td>
		<th class="required"><%=columnData.getString("useyn") %></th>
		<td><comment id="__NSID__"><object id="lx_yn"  classid="<%=LGauceId.LUXECOMBO%>" width="80">
			    <param name="ComboDataID"       value="ds_yn">
				<param name="ListCount"     	value="10">
				<param name=SearchColumn		value="name">
				<param name="BindColumn"    	value="code">
			    <param name=ListExprFormat		value="name^0^90">
			    <param name=WantSelChgEvent	value=true>
			    <param name=index           	value=0>
		   	</object></comment><script>__WS__(__NSID__); </script>
		 </td>	
	</tr>
</table>
</div>
<div id="btn_area">
<p class="b_right">
<span class="btn_r btn_l">
	<input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnNew %>" onclick="javascript:f_addRow()" /></span> 
<span class="btn_r btn_l"> 
	<input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'"	value="<%=btnSave %>" onclick="javascript:f_process()" /></span></p>
</div>
<comment id="__NSID__">
<object id="bi_grid" classid="<%=LGauceId.BIND%>">
	<param name="DataID" value="ds_grid">
	<param name="BindInfo"
		value='
		            <C> Col=userId        	Ctrl=userId        Param=Value 		</C>
		            <C> Col=userNm        	Ctrl=userNm	 	   Param=Value 		</C>
		            <C> Col=deptCd 	       	Ctrl=lxOrgCd       Param=BindColVal	</C>          
		            <C> Col=authCd  		Ctrl=txMatkl2      Param=BindColVal </C>        
		            <C> Col=position        Ctrl=position      Param=Value 		</C>
		            <C> Col=useFromDate     Ctrl=useFromDate   Param=Value 	 	</C>
		            <C> Col=useToDate       Ctrl=useToDate     Param=Value 		</C>
		            <C> Col=business   		Ctrl=business      Param=Value 		</C>
		            <C> Col=email     		Ctrl=email         Param=Value 		</C>
		            <C> Col=birthday   		Ctrl=birthday	   Param=Value		</C>       
		            <C> Col=phone	  		Ctrl=phone  	   Param=Value 		</C>
		            <C> Col=mobile			Ctrl=mobile  	   Param=Value 		</C>
		            <C> Col=gender			Ctrl=lx_gender     Param=BindColVal </C>
		            <C> Col=addr1			Ctrl=addr1 	       Param=Value		</C>
		            <C> Col=useFromDate		Ctrl=useFromDate   Param=Value		</C>
		            <C> Col=useToDate		Ctrl=useToDate 	   Param=Value		</C>
		            <C> Col=addr2			Ctrl=addr2 	 	   Param=Value		</C>
		            <C> Col=useyn			Ctrl=lx_yn 	 	   Param=BindColVal	</C>
		        '/>
</object>
</comment>
<SCRIPT>__WS__(__NSID__);</SCRIPT>
<script src="xjos/xjos.js" language="JScript"></script>
</body>
</html>