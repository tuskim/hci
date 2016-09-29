<%--
/*
 *************************************************************************
 * @source  : costTotLedgerUpload.jsp
 * @desc    : cost Total List
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2010/08/30   mskim       Init
 * 1.1  2015/11/30   hckim       그리드 내 Internal Order 필드 추가
 *                               첨부파일 업로드시 Internal Order 필드 추가
 * ---  -----------  ----------  -----------------------------------------
 * PT-PAM System.
 * Copyright(c) 2006-2007 LG CNS,  All rights reserved.
 *************************************************************************
 */
--%>

<%@ page import="devon.core.util.*" %>
<jsp:useBean id="resultData" class="devon.core.collection.LMultiData" scope="request"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Cost Total Ledger Excel Upload</title>
<%@ include file="/include/head.jsp" %>

<%
	String currentDate = LDateUtils.getDate("yyyy/MM/dd");          // currentDate

	String msgSave            = source.getMessage("dev.cfm.com.save");    // Are you sure to save?
    String msgWarnRetrieve    = source.getMessage("dev.warn.com.retrieve");   // please first retrieve!
    String msgSucProcess      = source.getMessage("dev.suc.com.process");   // please first retrieve!

%>

<script type="text/javascript">


    // 주의: 하단 그리드의 컬럼이 추가되는 경우, [strHeaderDtl], [gr_commCodeMgnt]를 동일하게 구성해야 합니다.
    var strHeaderDtl = "docYm"         + ":STRING(6)"
    	             + ",docSeq"       + ":STRING(10)"                       
                     + ",docNum"       + ":STRING(3)"
                     + ",docDate"      + ":STRING(8)"
                     + ",postDate"     + ":STRING(8)"
                     + ",sapAcctCd"    + ":STRING(10)"
                     + ",acctNm"       + ":STRING(100)"
                     + ",debitAmt"     + ":STRING(100)"
                     + ",creditAmt"    + ":STRING(100)"
                     + ",currencyCd"   + ":STRING(3)"
                     + ",vat"          + ":STRING(50)"
                     + ",costCenter"   + ":STRING(50)"    
                     + ",intOrder"     + ":STRING(50)"             
                     + ",sapAcctV"     + ":STRING(10)"
                     + ",sapAcctC"     + ":STRING(10)"    
                     + ",docDesc"      + ":STRING(50)"
                     + ",spglNo"       + ":STRING(1)"         
                     + ",base"         + ":STRING(50)" 
                     + ",code"         + ":STRING(50)"
                     + ",rate"         + ":STRING(50)"
                     + ",createDate"   + ":STRING(8)"
                     + ",returnMsg "   + ":STRING(100)"
					 + ",companyCd"    + ":STRING(4)"
                     + ",deptCd"       + ":STRING(4)";
                      
//-------------------------------------------------------------------------
// 저장
//-------------------------------------------------------------------------
function f_Save() {
    
    if(ds_costTot.CountRow == 0) {
        alert("<%= msgWarnRetrieve %>");      // please first retrieve!
        return;
    }

   	if(document.all.createDate.value == "") {
		alert('<%=source.getMessage("dev.warn.com.input", columnData.getString("create_date"))%>');
		return;
	}

  	var param = "companyCd=<%= g_companyCd %>"  	
  		      +",deptCd=<%=g_companyCd%>" 	
  			  +",createDate=" + removeDash(document.all.createDate.value,"/")
  		  
  			  
    if(confirm("<%= msgSave %>")){     // Are you sure to save?
		mode = "process";
		tr_cudData.Parameters = param;
		tr_cudData.Post();
    }

}

function checkData() {

   	if(document.all.createDate.value == "") {
		alert('<%=source.getMessage("dev.warn.com.input", columnData.getString("create_date"))%>');
		return false;
	}

	var docYm      = "";
	var docSeq     = "";
	var tempCredit = 0;
	var tempDebit  = 0;
	var chkList    = "";

	for(i=1; i<=ds_costTot.countRow; i++){
		
		var lastChk = (ds_costTot.countRow == i)?true:false;
		//alert(lastChk);
		if((ds_costTot.NameValue(i,"docYm") == ds_costTot.NameValue(i+1,"docYm")) || lastChk){
		
			chkList    = chkList + i + ";";

			tempCredit = tempCredit + parseFloat(ds_costTot.NameValue(i,"creditAmt"));
			tempDebit  = tempDebit  + parseFloat(ds_costTot.NameValue(i,"debitAmt"));
			//alert(" tempDebit:" + tempDebit +" tempCredit1:" + tempCredit);
			
			if((ds_costTot.NameValue(i,"docSeq") != ds_costTot.NameValue(i+1,"docSeq")) || lastChk ){

				docYm      = ds_costTot.NameValue(i,"docYm");
				docSeq     = ds_costTot.NameValue(i,"docSeq");
				
				if ( tempCredit != tempDebit ) {
					alert("Document No:" + docYm + " " + docSeq + " The Upload Data Debit and Credit are not right ");
					var arryList = chkList.split(";");
					for ( var j=0; j < arryList.length-1; j++ ) {
						var cnt = arryList[j];
						ds_costTot.RowMark(cnt) = 1;
					}
					
					ds_costTot.RowPosition = i;
					gr_excelUpload.Focus();
					
					return false;
				}
				
				chkList    = "";
				tempCredit = 0;
				tempDebit  = 0;
			
			} else {
			
				if(ds_costTot.NameValue(i,"currencyCd") != ds_costTot.NameValue(i+1,"currencyCd")){

					docYm  = ds_costTot.NameValue(i,"docYm");
					docSeq = ds_costTot.NameValue(i,"docSeq");
					alert("Document No:" + docYm + " " + docSeq + " The Upload Data Currecy Code are different ");
					
					var arryList = chkList.split(";");
					for ( var j=0; j < arryList.length-1; j++ ) {
						var cnt = arryList[j];
						ds_costTot.RowMark(cnt) = 1;
					}
					
					ds_costTot.RowPosition = i;
					gr_excelUpload.Focus();
					
					return false;
				}
			}
		}  // End If
	} // End For
	
	return true;
}


//-------------------------------------------------------------------------
// 검색
//-------------------------------------------------------------------------
function f_Retrieve() {

   	if(document.all.createDate.value == "") {
		alert('<%=source.getMessage("dev.warn.com.input", columnData.getString("create_date"))%>');
		return false;
	}
	
	var condition = "?";    	
		condition += "&deptCd=<%=g_companyCd%>" 
    	condition += "&createDate=" + removeDash(document.all.createDate.value,"/")

    ds_costTot.DataID = "fi.ar.retrieveCostTotLedgerUpload.gau"+condition;
	ds_costTot.Reset();

}


//엑셀 그리드 업로드
function SetDataHeader(obj){
    if( obj.CountColumn == 0 ) {
        obj.ClearAll();
		obj.setDataHeader(strHeaderDtl);
    }
}

function Fn_LoadExcelData(objFile){

    //cfHideDSWaitMsg(gr_excelUpload);
	//SetDataHeader(ds_costTot);
    cfHideNoDataMsg(gr_excelUpload);
    	
	ds_costTot.ClearAll();
	ds_costTot.setDataHeader(strHeaderDtl);
	
	//LoadExcelData 옵션처리
	var strExcelFileName = objFile.value; //파일이름
	
	var nStartRow = 0; //시작Row
	var nEndRow = 0; //끝Row
	var nReadType = 0; //읽기모드
	var nBlankCount = 3; //공백row개수
	var nLFTOCR = 0; //줄바꿈처리
	var nFireEvent = 1;//이벤트발생
	var nSheetIndex = 1; //Sheet Index 추가

	var stropt = strExcelFileName; //1st
	stropt += "," + nStartRow; //2nd
	stropt += "," + nEndRow; //3rd
	stropt += "," + nReadType; //4th
	stropt += "," + nBlankCount; //5th
	stropt += "," + nLFTOCR; //6th
	stropt += "," + nFireEvent; //7th
	stropt += "," + nSheetIndex //8th

	var obj = document.getElementById("ds_costTot");
	obj.Do("Excel.Application", stropt);

	ds_costTot.Do("Excel.Close");
	ds_costTot.DeleteRow( 1 );

	// File Input Box Inital	
	fileValueReset();

}

// 첨부파일부분 리셋!!
function fileValueReset(){
	var fileDiv = document.getElementById("fileDiv");
   	fileDiv.innerHTML = "<input name=\"attachFile\" type=\"file\" class=\"input_text\" size=\"52\" onchange=\"Fn_LoadExcelData(this);\">";
}

//샘플파일 다운로드
function f_sampleDown(){
	///data1/bea81/weblogic81/domains/ptmgedomain/applications/mge/devonhome/sample
	
	var fileReal = "";
	fileReal = "Cost Price Sample.xlsx";
	//filePath = "/data1/bea81/weblogic81/domains/ptmgedomain/applications/mge/devonhome/sample/";
	var fileName = "Cost Price Sample.xlsx";
	
	var frm = document.fileForm;
	frm.filename.value = fileName;
	frm.fileReal.value = fileReal;
	frm.fileFolder.value = "sample";
	frm.submit();
	
}
</script>

<!-----------------------------------------------------------------------------
  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- CUD TR -->
<!-- Payment Arrange CUD TR -->
<OBJECT id=tr_cudData classid="<%=LGauceId.TR%>">
    <param name="KeyName"   value="toinb_dataid4">
    <param name="KeyValue"  value="JSP(I:IN_DS1=ds_costTot)">
    <param name="ServerIP"  value="">
    <param name="Action"    value="fi.ar.cudCostTotLedgerUpload.gau">
</OBJECT>

<!-----------------------------------------------------------------------------
    D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-- Grid 용 DataSet-->
<object id="ds_costTot" classid="<%=LGauceId.DATASET%>" >
  <param name="SyncLoad"          value="true">
  <param name="ViewDeletedRow"    value="true">
</object>

<!-- Dept combo DataSet -->
<object id="ds_deptCode"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
	<param name="DataID"          value="cm.cm.retrieveCommCodeCombo.gau?groupCd=2001">
</object>

<!-- Status combo DataSet -->
<object id="ds_statusCode"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
	<param name="DataID"          value="cm.cm.retrieveCommCodeCombo.gau?groupCd=2002&firstVal=Total">
</object>


<!-----------------------------------------------------------------------------
    G A U C E   C O M P O N E N T' S   E V E N T S
------------------------------------------------------------------------------>

<script language=JavaScript for=ds_costTot event=OnLoadCompleted(rowCnt)>
	
    mode = "";
    
    cfFillGridNoDataMsg(gr_excelUpload,"gridColLineCnt=2");
    cfHideDSWaitMsg(gr_excelUpload);
    
</script>

<script language=JavaScript for=ds_costTot event=OnLoadStarted()>
    cfHideNoDataMsg(gr_excelUpload);
    cfShowDSWaitMsg(gr_excelUpload);
</script>

<script language=JavaScript for=ds_costTot event=OnColumnChanged(row,colid)>

</script>

<!-- INSERT Tr 의 트렌젝션 실행 시 에러 여부 -->
<script language=JavaScript for=tr_cudData event=OnFail()>
    
    mode = "";
    if(tr_cudData.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
        window.parent.location.href = "/index.jsp";    
    }
    
   	if ( tr_cudData.ErrorMsg.indexOf("simpleMsg")) {
		var cnt = 12 + tr_cudData.ErrorMsg.indexOf("simpleMsg");
		alert(tr_cudData.ErrorMsg.substring(cnt, tr_cudData.ErrorMsg.length));
   	}
   	    
    //alert(tr_cudData.ErrorMsg);
</script>

<script language=JavaScript for=tr_cudData event=OnSuccess()>
    //mode = "";
    alert("<%= msgSucProcess %>");
    f_Retrieve();
</script>

<script language=JavaScript for=ds_costTot event=OnLoadError()>

  cfShowErrMsg(ds_costTot);

</script>

</head>

<body id="cent_bg">

<div id="conts_box">
	<h2> <span> <%= columnData.getString("page_title") %> </span></h2>

	<!--검색 S -->		
	<fieldset class="boardSearch">
		<div>
			<dl>
				<dt> 
					<table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board2" >
						<colgroup>
							<col width="12%"/>							
							<col width=""/>
						</colgroup>
						<tr>																	
							<th><%= columnData.getString("create_date") %></th>
							<td><input type="text" id="createDate" value="<%= currentDate %>" onblur="valiDate(this);" style="width:60px;"/>&nbsp;<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(createDate);" style="cursor:hand"/></td>
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

	<div class="sub_stitle"> 
		<p> <%=columnData.getString("sub1_title") %> </p>
		<p class="rightbtn">		  
			<span class="sbtn_r sbtn_l"> 
			<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="<%=btnSamlpDown %>" onclick="f_sampleDown();"/></span>  	 
		</p>			
	</div>   	 	

	<!-- 그리드 S -->	
    <div>
	<object id="gr_excelUpload" classid="<%=LGauceId.GRID %>" style="width:100%;height:250px;" class="comn"
		dataName="Menu Management"
	    validFeatures="ignoreStatus=no"
		validExp="">
		<param Name="DataID" 			value="ds_costTot">
		<param name="ColSizing" 		value="true"> 
		<param name="MultiRowSelect"	value=true>
		<Param NAME="TitleHeight"      	value="30">
		<param Name="Format"
			value='
				<C> id=docYm       	name="<%= columnData.getString("doc_ym") %>" 	    align="center"   width="70"    Edit="none"   show="true"  </C>
				<C> id=docSeq      	name="<%= columnData.getString("doc_seq") %>" 	    align="center"   width="90"    Edit="none"   show="true"  </C>							            
	            <C> id=docDate     	name="<%= columnData.getString("doc_date") %>" 	    align="center"   width="80"    Edit="none"   show="true" Mask="XXXX/XX/XX"</C>
	            <C> id=postDate    	name="<%= columnData.getString("post_date") %>" 	align="center"   width="90"    Edit="none"   show="true" Mask="XXXX/XX/XX"  </C>
	            <C> id=sapAcctCd    name="<%= columnData.getString("acct_cd") %>" 	    align="center"   width="70"    Edit="none"   show="true"  </C>	            
	            <C> id=debitAmt    	name="<%= columnData.getString("debit_amt") %>" 	align="right"    width="100"   Edit="none"   show="true"  </C>
	            <C> id=creditAmt   	name="<%= columnData.getString("credit_amt") %>" 	align="right"    width="100"   Edit="none"   show="true"  </C>
	            <C> id=currencyCd  	name="<%= columnData.getString("currency_cd") %>" 	align="center"   width="70"    Edit="none"   show="true"  </C>	            	            
	            <C> id=vat      	name="Tax Code" 	    	align="center"     width="70"    Edit="none"   show="true"  </C>
	            <C> id=costCenter  	name="<%= columnData.getString("cost_center") %>" 	align="left"     width="120"   Edit="none"   show="true"  </C>
	            <C> id=intOrder     name="<%= columnData.getString("order") %>"     	align="center"   width="70"    Edit="none"   show="true"  </C>
	            <C> id=sapAcctV    	name="<%= columnData.getString("sap_acct_v") %>" 	align="left"     width="70"    Edit="none"   show="true"  </C>
	            <C> id=sapAcctC    	name="<%= columnData.getString("sap_acct_c") %>" 	align="left"     width="70"    Edit="none"   show="true"  </C>
	            <C> id=docDesc     	name="<%= columnData.getString("doc_desc") %>" 	    align="left"     width="180"   Edit="none"   show="true"  </C>
	            <C> id=spglNo      	name="<%= columnData.getString("spgl_no") %>" 	    align="left"     width="70"    Edit="none"   show="true"  </C>
	            <C> id=base      	name="<%= columnData.getString("base") %>" 	    	align="left"     width="70"    Edit="none"   show="false"  </C>
	            <C> id=acctNm      	name="<%= columnData.getString("acct_nm") %>" 	    align="left"     width="120"   Edit="none"   show="false" </C>
	            <C> id=docNum      	name="<%= columnData.getString("doc_num") %>" 	    align="center"   width="70"    Edit="none"   show="false" </C>	            	            	            	            	            	            	            	            	            	            
	            <C> id=code      	name="<%= columnData.getString("code") %>" 	    	align="left"     width="70"    Edit="none"   show="false" </C>
	            <C> id=rate      	name="<%= columnData.getString("rate") %>" 	    	align="left"     width="70"    Edit="none"   show="false" </C>
	            	            	            
	      '>
	</object>
 	</div>

    <div class="sub_stitle"> <p> <%= columnData.getString("sub2_title") %></p></div>
    <!-- 그리드 S -->	
	<div id="output_board_area">
    	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board" >
        	<colgroup>
            	<col width="16%"/>
            	<col width=""/>
         	</colgroup>
           	<tr>
           		<th><%= columnData.getString("attach_file") %></th>
           		<td>
					<div id="fileDiv">
					    <input name="attachFile" type="file" class="input_text" style="height:18px;" size="52" onchange="Fn_LoadExcelData(this);">
					</div>
           		</td>
    		</tr>   
        </table>
	</div>
    <!-- 그리드 E -->	
     
<form action="fi.ar.DownloadFile.dev" method="post" name="fileForm">
    <input type="hidden" name="filename" value="">
    <input type="hidden" name="fileReal" value="">
    <input type="hidden" name="fileFolder" value="">
</form>
      
	<!-- 버튼 S -->	
    <div id="btn_area">
    	<p class="b_right">
		<span class="btn_r btn_l">
            <input type="button" onClick="f_Save();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%= btnSave %>"/></span></p>
   	</div>
    <!-- 버튼 E -->
    
    <div class="pad_t5"></div>
        	  
</div>
</body>
</html>
