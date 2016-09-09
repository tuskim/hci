<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/include/doctype.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%--
/*
 *************************************************************************
 * @source  : UserMgnt.jsp
 * @desc    : 개인정보 수정 
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  			       		 신규작성
 * 1.1  2014.04.14    JwHan	  	CSR:C20140414_23324
 * 1.2  2014.09.03    JwHan		C20140825_97731
 * 1.3  2014-12-15    JwHan      
 * 1.4  2016-04-05    hskim     CSR:C20160330_24662 가우스 Dataset 방식을 서블릿 방식으로 변경 (SSL)      
 * ---  -----------  ----------  -----------------------------------------
 * PT-PAM 시스템
 * Copyright(c) 2006-2007 LG CNS,  All rights reserved.
 *************************************************************************
 */
--%>

<%@ page import="devon.core.collection.LMultiData"%>
<%@ page import="devon.core.collection.LData"%>
<%@ page import="java.util.Date"%>
<%@ include file="/include/head.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="blendTrans(Duration=0.0)" http-equiv="Page-Enter" />
<meta content="blendTrans(Duration=0.0)" http-equiv="Page-Exit" />
<jsp:useBean class="devon.core.collection.LMultiData" id="result" scope="request"/>
<jsp:useBean class="devon.core.collection.LData" id="resultMsg" scope="request"/>

<%
		LData List = result.getLData(0);
		List.setNullToInitialize(true);
		
		String message = resultMsg.getString("message");
		
		System.out.println("message---------");
		System.out.println(message);
%>
<head>


<script type="text/javascript">
var message  = "<%=message%>";

if (message != "null") {
	alert(message);	
}
//-------------------------------------------------------------------------
// 저장버튼 클릭시 
//-------------------------------------------------------------------------				
function f_update(){	


	
		var val = document.aForm.validate();
			
			if(val) {		
				if(!f_validate())
					return;		
			}else{
				return;	
			}
		var form = document.aForm;
		
		form.submit();
		
		/*
		ds_save.ClearAll();			
		var paramHead = "userId:STRING(100),userPw:STRING(100),newPw:STRING(100),userNm:STRING(100),"
					   +"deptCd:STRING(100),business:STRING(100), email:STRING(100);"
						
		ds_save.setDataHeader(paramHead);
		ds_save.AddRow();
	
		ds_save.NameValue( 1 , "userId" )	    = form.userId.value;
		ds_save.NameValue( 1 , "userPw" )	    = form.userPw.value;
		ds_save.NameValue( 1 , "newPw" )	    = form.newPw.value;
		ds_save.NameValue( 1 , "userNm" )	    = form.userNm.value;
		ds_save.NameValue( 1 , "deptCd" )	    = form.deptCd.value;
		ds_save.NameValue( 1 , "business" )	    = form.business.value;
		ds_save.NameValue( 1 , "email" )	    = form.email.value;

		
		if(form.gender[0].checked){
			ds_save.NameValue( 1 , "gender" )	= form.gender[0].value;
		}else{
			ds_save.NameValue( 1 , "gender" )	= form.gender[1].value;
		}
					
		tr_master.Action   	= "/cm.ur.cudUserInfoChange.gau";
		tr_master.KeyValue 	= "SERVLET(I:ds_save=ds_save)";
		tr_master.post();	
		*/

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
//validation
//-------------------------------------------------------------------------					
function f_validate() {
	var form 	= document.aForm;
				
	var newPw  = form.newPw.value;
	var newPw2 = form.newPw2.value;

	var userPw = form.userPw.value;
	if(f_isNull(userPw)){
		alert("Please input current password");
		form.userPw.focus();
		return false;
	}
	if( userPw == newPw || userPw == newPw2 ){
	
		alert("Password should be changed");
		form.newPw.focus();
		return false;
	}
	
	if(newPw.length > 0 && newPw.length < 8) {
		 alert("Password have to be more than 8 Characters");
		 form.newPw.focus();
		 return	false;
	}
	
	if(newPw2.length > 0 && newPw2.length < 8) {
		 alert("Check the new password confirm" );
		 form.newPw2.focus();
		 return	false;
	}
	
	
	if( !f_isNull(newPw) ){
		
		if(f_isNull(newPw2) ){
			alert("<%=source.getMessage("dev.warn.com.input","'new Password Check'")%>" );return;	
			 form.newPw2.focus();
			   return false;
		}else{	 
	 	
		if( newPw != newPw2){
			alert("<%=source.getMessage("dev.msg.cm.checkPassword")%>" );
		    form.newPw.focus();
		    return	false;
			}
		}
	}	
	return true;
	
					
		
}	
//-------------------------------------------------------------------------
// combo, select
//-------------------------------------------------------------------------	
function init(){  
	 parent.centerFrame.cols='220,*';

	 ds_dept.DataID ="cm.cm.retrieveCommCodeCombo.gau?groupCd=2001";
	 ds_dept.Reset();
	
	var gen = "<%=result.getLData(0).getString("gender") %>";
	
	if(gen == "M") {
		document.aForm.gender[0].checked = true;
		document.aForm.gender[1].checked = false;
	}else if(gen == "W"){
		document.aForm.gender[0].checked = false; 
		document.aForm.gender[1].checked = true; 
	}
	
	lxdept.Enable             = false;
	
}

</script>

<!-----------------------------------------------------------------------------
  프로그램 전용 D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- Dept combo DataSet -->
<comment id="__NSID__"><object id="ds_dept"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"          value="true">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>

<object id="ds_save" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad" value="true">
	<param name="ViewDeletedRow" value="true">
</object>


<!-- TR 조회용 -->
<OBJECT id="tr_master" classid="<%=LGauceId.TR%>">
	<param name="KeyName" value="toinb_dataid4">
</OBJECT>
<!-----------------------------------------------------------------------------
		   프로그램 전용 G A U C E   C O M P O N E N T' S   E V E N T S
------------------------------------------------------------------------------>
<script language=JavaScript for=ds_dept event=OnLoadCompleted(rowcnt)>
	ds_dept.RowPosition= ds_dept.nameValueRow("code","<%=result.getLData(0).getString("deptCd") %>");
</script>

<script language=JavaScript for=ds_dept event=OnRowPosChanged(row)>
	if(ds_dept.rowPosition >0){
	document.aForm.deptCd.value= ds_dept.nameValue(ds_dept.rowPosition,"code");
	}
</script>

<!-- INSERT Tr 의 트렌젝션 실행 시 에러 여부 -->
<script language=JavaScript for=tr_master event=OnFail()>
    mode = "";
    if(tr_master.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
        window.parent.location.href = "/index.jsp";    
    }
    alert(tr_master.ErrorMsg);
</script>

<script language=JavaScript for=tr_master event=OnSuccess()>	
        alert("successfully saved.");
</script>

</head>
<!-----------------------------------------------------------------------------
   화면영역 시작
------------------------------------------------------------------------------>
<body id="cent_bg" onload="init()">

<div id="conts_box">
	<h2><span><%=columnData.getString("page_title") %></span></h2>

        <div class="sub_stitle"> <p><%=columnData.getString("page_title") %></p></div>
        <!-- 그리드 S -->	

        <div id="output_board_area">
            <!-- 
        	<form name="aForm" method="post" style="margin:0px" action="https://hci.lgi.co.kr/cm.ur.cudUserInfoChangeDev.dev?progCd=CM0002">
        	 -->
        	<form name="aForm" method="post" style="margin:0px" action="cm.ur.cudUserInfoChangeDev.dev?progCd=CM0002">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board" >
                <colgroup>
                        <col width="20%"/>
                        <col width="32%"/>
                        <col width="20%"/>
                        <col width=""/>
              </colgroup>
                    <tr>
                    	<th class="required"><%=columnData.getString("user_id") %></th>
                    	<td colspan="3"><input id="userId" name="userId" type="text" style="width:140px;" value="<%=List.getString("userId") %>" required readonly class="txtField_read" /></td>
                    </tr>
                    <tr>		
                    	<th class="required"><%=columnData.getString("user_pw") %></th>
                    	<td colspan="3"><input type="password" id=userPw name="userPw" style="width:135px;" value="" required/>
                   	</tr>
                    <tr>
                        <th class="required"><%=columnData.getString("new_pw") %></th>
                        <td colspan="3"><input type="password" id="newPw" name="newPw" style="width:135px;" /></td>
                    </tr>
                    <tr>
                        <th class="required"><%=columnData.getString("new_pw2") %></th>
                        <td colspan="3"><input type="password" id="newPw2" name="newPw2" style="width:135px;" /></td>
                    </tr>
                    <tr>
                        <th class="required"><%=columnData.getString("user_nm") %></th>
                        <td colspan="3"><input type="text" style="width:135px;" id="userNm" name="userNm" value="<%=List.getString("userNm") %>" class="txtField_read" required	readonly/> </td>
                    </tr>
                    <tr>
						<th><%=columnData.getString("dept_cd") %></th>
						<td colspan="3"><comment id="__NSID__"><object id="lxdept" classid="<%=LGauceId.LUXECOMBO%>"  width="145px" readonly>
											    <param name=ComboDataID     value="ds_dept"/>
												<param name=Sort			value=false/>
												<param name=ListExprFormat	value="name^0^90, code^0^70"/> 
												<param name=BindColumn	    value="code"/>
												<param name=SearchColumn	value=name/> 
												<!-- 
												<param name=DisableBackColor  value="#FFFFCC"/>
												 -->
												<param name=Enable          value="false"/>
										       </object></comment><script>__WS__(__NSID__); </script>
							   	<input type="hidden"id="deptCd" name="deptCd" value="<%=List.getString("deptCd") %>" />
							   	</td>
					</tr>
					<tr>
						<th><%=columnData.getString("business") %></th>
						<td colspan="3"><input type="text" style="width:135px;" id="business" name="business" value="<%=List.getString("business") %>" /> </td>
					</tr>
              </table>
         </form>
		</div>
		
		
      <!-- 그리드 E -->	
        <!-- 버튼 S -->	
          <div id="btn_area">
            <p class="b_right"><span class="btn_r btn_l">
                    <input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnSave %>" onclick="f_update()"/></span> 
            </p>
        </div>
        <!-- 버튼 E -->	
		<div class="pad_t10"></div></div>
<script src="xjos/xjos.js" language="JScript"></script>		
</body>
</html>
