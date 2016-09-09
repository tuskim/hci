<%--
/* ------------------------------------------------------------------------
 * @source  : emailWrite.jsp
 * @desc    : Email Write
 * ------------------------------------------------------------------------
 *
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2009.11.27   jdi                 Initial
 * ------------------------------------------------------------------------ */
--%>

<%@ page contentType="text/html; charset=UTF-8" %>

<%@ page import="devonframework.bridge.gauce.LGauceId" %>
<%@ page import="devon.core.util.*" %> 
<%@ page import="java.text.SimpleDateFormat" %>

<%@ include file="/include/head.jsp" %>

<jsp:useBean id="resultData" class="devon.core.collection.LData" scope="request"/>

<%
	if(resultData != null) {
		String sMsg = resultData.getString("msg");
%>
	<script language="javascript">
		var sMsgValue = "<%=sMsg%>";
		
		if(sMsgValue != null && sMsgValue != "" && sMsgValue != 'null') alert(sMsgValue);
	</script>
<%
	}
%>

<%
    LData userInfo = (LData) session.getAttribute("loginUser");
    String session_txEmail   = userInfo.getString("txEmail");

    // message
    String msgConfirmProcessSend   = source.getMessage("dev.suc.po.process"         ,"Send");               // are you sure to [Send]?
    String msgSuccProcessSend      = source.getMessage("dev.suc.po.process.success" ,"Send");               // successfully [Send]!
    String msgWarnRequiredReceive  = source.getMessage("dev.warn.com.required"      ,"receive");            // required field. please fill [receive].
    String msgWarnRequiredSubject  = source.getMessage("dev.warn.com.required"      ,"subject");            // required field. please fill [subject].
    String msgWarnRequiredContent  = source.getMessage("dev.warn.com.required"      ,"content");            // required field. please fill [content].
    String msgWarnNonData          = source.getMessage("dev.warn.com.nonData"       ,"user of the E-mail"); // [user of the E-mail] information is not registered.
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>e-mail</title>
<script language="javascript">

    //-------------------------------------------------------------------------
    // Load
    //-------------------------------------------------------------------------
    function f_Onload() {

        if("<%=session_txEmail%>" == "") {
            document.sform.pic.disabled           = true;
            document.sform.Send.disabled          = true;
            document.sform.uploadfile.disabled    = true;

            document.sform.receive.readOnly       = true;
            document.sform.subject.readOnly       = true;
            document.sform.content.readOnly       = true;

            alert("<%=msgWarnNonData%>");   // [user of the E-mail] information is not registered.
        }
    }

    //-------------------------------------------------------------------------
    // Popup Member List
    //-------------------------------------------------------------------------
    function f_searchMemberList() {

        var result = "";
        var firstList = new Array ();

        var code            = "";
        var schValue        = "";

        var popupId         = "MemberList";
        var popupStr        = "/jsp/popup/pop_" + popupId + ".jsp";

        var code            = "?code="              + code;
        var popType         = "&popType="           + "Lgihub_" + popupId;
        var popupWidth      = "dialogWidth:"        + "600px";
        var popupHeight     = ";dialogHeight:"      + "460px";

        result = window.showModalDialog( popupStr + code + schValue + popType, popupId, popupWidth + popupHeight );

        if (result == -1 || result == null || result == "") {

            return;

        } else {

            document.sform.receive.value = result;
        }
    }

    //-------------------------------------------------------------------------
    // 메일 보내기
    //-------------------------------------------------------------------------
    function f_Send(){
    
    	var obj = document.sform;  

        var uploadfilePathArr               = new Array ();
        var uploadfile                      = document.all.uploadfile.value;

        if(uploadfile != "") {
            //--------------------- localFilePath START     - ie8 fakepath 대응 knana 2009/12/02
            uploadfilePathArr                   = uploadfile.split("\\");
            document.sform.uploadfileName.value   = uploadfilePathArr[uploadfilePathArr.length-1];
    
            var inputField  = document.getElementById("uploadfile");
            var source      = inputField.value;                    
            var ext         = source.substring( source.lastIndexOf(".") + 1, source.length ).toLowerCase();        
            
            var localfilepath;
    
            if (source.indexOf("\\fakepath\\") < 0) {
                localfilepath = source;
            } else {
                inputField.select();
                localfilepath = document.selection.createRange().text.toString();
                inputField.blur();
            }
            
            document.sform.localfilepath.value = localfilepath;
            //--------------------- localFilePath END
        }
        
        if (checkData()) {
        
            if(confirm("<%=msgConfirmProcessSend%>")){  // are you sure to [Send]?
            	obj.method = "post";
                obj.action = "email.sendEmailMgnt.dev";
                obj.submit();
            }
        }
    }

    //-------------------------------------------------------------------------
    //입력형태의 데이터 체크
    //-------------------------------------------------------------------------
    function checkData() {
        
        if("<%=session_txEmail%>" == "") {
            alert("<%=msgWarnNonData%>");           // [user of the E-mail] information is not registered.
            return false;
        }
        
        if(document.sform.receive.value == ""){
            alert("<%=msgWarnRequiredReceive%>");   // required field. please fill [receive].
            document.sform.receive.focus();
            return false;
        }

        if(document.sform.subject.value == ""){
            alert("<%=msgWarnRequiredSubject%>");   // required field. please fill [subject].
            document.sform.subject.focus();
            return false;
        }

        if(document.sform.content1.value == ""){
            alert("<%=msgWarnRequiredContent%>");   // required field. please fill [content].
            document.sform.content1.focus();
            return false;
        }

        return true;
    }

</script>
</head>

<body onload="f_Onload()">
<div id="content">
<form name="sform" enctype="multipart/form-data">
<table border=0 cellpadding=0 cellspacing=0 class="width100">
  <tr>
    <td id="wrap">
  	<!--- title start ------>		  
    <div id="title">e-mail</div>
    <!--- title end -------->
    <div class="h_10"></div>
	
    <!--- button start ----->
	
	<div id="Btn02"><a href="javascript:f_Send();"><span>Send</span></a></div>
	

  <!--- button end ------->
<div class="h_15"></div>
<div>

  <table class=board_blue>
	<colgroup>
	  <col width="20%">
	  <col width="80%">	  
	</colgroup>    
    <tr>
	  <th>Receive</th>
	  <td>
		<input style="width:300px" type="text" class="input_textfield_essential" name="receive" />
		<input type="hidden"    name="groupcd"/>
		<input type="hidden"    name="userid"/>
		<input type="hidden"    name="usernm"/>
		<input type="hidden"    name="uploadfileName"/>
		<input type="hidden"    name="localfilepath"/>
		<input type="hidden"    name="txemail"        value="<%=session_txEmail%>"/>
		&nbsp;<img src="<%=images%>button/btn_pic.gif" alt="P.I.C Add" name="pic" align="absmiddle" onClick="f_searchMemberList();" style="cursor:hand">
	  </td>			  
	</tr>	
    <tr>
	  <th>Subject</th>
	  <td>
		<input type="text" style="width:100%"  class="input_textfield_essential" name="subject" />
	</td>
	</tr>
    <tr>
	  <th>Content</th>
	  <td><textarea name="content1" class="input_textarea" rows="19" style="width:100%"></textarea></td>
	</tr>
    <tr>
	  <th>Attachment</th>
	  <td><font style="font-size:11px">AttachFile Quantity</font>&nbsp;<input name="uploadfile" type="file" class="input_textarea" style="width:300px;">&nbsp;
      <font style="color:#FF0000; font-size:11px">* Max Attach Size 5M</font></td>
	</tr>											
  </table>

</div>
<!--- input end -------> 
 </td>
</tr>					
</table>
</form>  
</div>

</BODY>
</HTML>
