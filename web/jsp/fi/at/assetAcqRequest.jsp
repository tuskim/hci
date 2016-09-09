<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html >
<%--
/*
 *************************************************************************
 * @source  : assetAcqRequest.jsp
 * @desc    : 자산 마스터 등록 요청 화면 
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2015/12/21	 hckim		 신규작성
 * ---  -----------  ----------  -----------------------------------------
 * PT-GAM 시스템
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

<%    
	String msgSave = source.getMessage("dev.cfm.com.save");                  // Are you sure to save?
	String msgCheckNumber = source.getMessage("dev.warn.com.checkNumber");   // Numbers only.		
	String magCheckAmount = source.getMessage("dev.warn.com.checkAmount");   // Round off the numbers to the nearest thousandth.
	String msgChkCurrency = source.getMessage("dev.warn.com.checkCurrency"); // The Currency IDR needs Integer Amount.
%>

<head>

<script type="text/javascript">
parent.centerFrame.cols='220,*';

String.prototype.trim = function() { 
	return this.replace(/(^\s*)|(\s*$)/g, ""); 
}

String.prototype.replaceAll = function(va,re) { 
	
	var reValue = this; 
	
	while(reValue.search(va)  > -1){
		reValue = reValue.replace(va,re);
	} 
		 	
	return reValue; 
} 

//-------------------------------------------------------------------------
// 초기값 셋팅
//-------------------------------------------------------------------------	
function init(){  			
}

//-------------------------------------------------------------------------
// 저장버튼 클릭시 
//-------------------------------------------------------------------------				
function f_save(){	
	
	var form = document.aForm;
					
	if (checkSaveData()) {

		var condition = "?";
			condition += "assetNm=" + form.assetNm.value;
			condition += "&qty=" + form.qty.value;
			condition += "&amount=" + removeDash(form.amount.value,",");
			condition += "&currCd=" + form.currCd.ValueOfIndex("code",form.currCd.Index);
			condition += "&acqDate=" + removeDash(form.acqDate.value,"/");
			condition += "&vendCd=" + form.vendCd.value;
			condition += "&assetDesc=" + form.assetDesc.value;
			condition += "&unit=" + form.unit.ValueOfIndex("code",form.unit.Index);
			condition += "&costCenter=" + form.costCenter.ValueOfIndex("code",form.costCenter.Index);
	
		if (confirm('<%= msgSave %>')) {
			form.action = "fi.at.cudAssetAcqRequest.dev"+condition;
			form.submit();
		}

	}
}			

//-------------------------------------------------------------------------
// validation (유효성 체크)
//-------------------------------------------------------------------------					
function checkSaveData() {
	
	var form = document.aForm;
	
	var assetNm    = form.assetNm.value;
	var qty        = form.qty.value;
	var amount     = form.amount.value;
	var sDotAmt    = "0"; // amount 소수점이하 초기값
	var currCd     = form.currCd.ValueOfIndex("code",form.currCd.Index);
	var unit       = form.unit.ValueOfIndex("code",form.unit.Index);
	var acqDate    = form.acqDate.value;
	var fileUpload = form.fileUpload.value;
	
	// 자산명 값이 없는 경우
	if(f_isNull(assetNm)){
		alert("<%=source.getMessage("dev.warn.com.input", columnData.getString("asset_nm"))%>" );
		form.assetNm.focus();
		return;
	}
	
	// 취득일자 값이 없는 경우
	if(f_isNull(acqDate)){
		alert("<%=source.getMessage("dev.warn.com.select", columnData.getString("acq_date"))%>" );
		form.acqDate.focus();
		return;
	}
	
	// 취득가액이 없는 경우
	if(f_isNull(amount)){
		alert("<%=source.getMessage("dev.warn.com.input", columnData.getString("acq_amount"))%>" );
		form.amount.focus();
		return;
	}
	
	// 통화코드 값이 선택되지 않는 경우
	if(f_isNull(currCd)){
		alert("<%=source.getMessage("dev.warn.com.select", columnData.getString("curr_cd"))%>" );
		form.currCd.focus();
		return;
	}
	
	// 취득가액 소수점 값이 있는 경우
	if(String(amount).indexOf(".", 0) != -1){
		sDotAmt = removeDash(String(amount).substring(String(amount).indexOf(".", 0), String(amount).length),".");	
	}
	
	// Currency : IDR (Indonesia) 인 경우 취득가액(Amount) 소수점 입력 여부 체크
	if(Number(sDotAmt) > 0){
		alert("<%=msgChkCurrency%>");			
		form.amount.focus();			
		return false;				
	}
	
	// 수량 값이 없는 경우
	if(f_isNull(qty)){
		alert("<%=source.getMessage("dev.warn.com.input", columnData.getString("qty"))%>" );
		form.qty.focus();
		return;
	}
	
	// 단위 값이 선택되지 않는 경우
	if(f_isNull(unit)){
		alert("<%=source.getMessage("dev.warn.com.select", columnData.getString("unit"))%>" );
		form.unit.focus();
		return;
	}
	
	// 첨부파일이 없는 경우
	if(f_isNull(fileUpload)){
		alert("<%=source.getMessage("dev.warn.com.select", columnData.getString("file_upload"))%>" );
		form.fileUpload.focus();
		return;
	}		
		
	return true;
}
	
//-------------------------------------------------------------------------
// 해당 문자열이 널인지 점검
//-------------------------------------------------------------------------		
function f_isNull( asValue ) {
   	if (asValue == null || asValue == undefined || asValue.toString().replace(/ /g,"") == "") {
      	 return  true;
   	}
  	return false;
}	

// ------------------------------------------------------------------------ 
//  1000 단위마다 Comma(,) 찍기 
// ------------------------------------------------------------------------ 
function toCurrencyChange(obj) { 
	
	if(!isCurrency(obj.value)) { 
		alert("<%= msgCheckNumber %>"); 
		obj.value = ""; 
		obj.focus(); 
		return; 
	} 
	
	var lastValue = obj.value.replaceAll(",",""); 
	
	if(lastValue.length > 3){
		obj.value = toCurrencyString(lastValue);		
	}  
}

// ------------------------------------------------------------------------ 
//  숫자, ',', '.'만 입력 
// ------------------------------------------------------------------------ 
function isCurrency(string) { 
	
	var replPatrn = /[\d\,\.]/g; 

	if (string.trim().replace(replPatrn, "").length == 0){
		return true;
	}else{
		return false; 
	}
} 

// ------------------------------------------------------------------------ 
//  1000 단위마다 Comma(,) 찍기 
// ------------------------------------------------------------------------ 
function toCurrencyString(strCurrency) { 
	
	var frm = document.aForm;
	strCurrency += ""; 
	var isMinus = false; 
	var isDot   = false; 
	var sSecond = "";      //정수의 문자열 
	var sDot    = "";      //소수점이하의 문자열 

	if(strCurrency.charAt(0) == '-') { 
		strCurrency = strCurrency.substring(1); isMinus = true; 
	} 
	
	if(strCurrency.indexOf(".", 0) > 0) { 
		
		sSecond = strCurrency.substr(0, strCurrency.indexOf(".", 0)); 
		sDot = strCurrency.substring(strCurrency.indexOf(".", 0), strCurrency.length); 
		isDot = true; 
		
		var len = sDot.length - 1; 
		
		if (len > 2) { 
			
			alert("<%= magCheckAmount %>"); 
			
			sDot = sDot.substr(0, sDot.length - 1);
			
			// 취득가액 소수 둘째짜리 까지 셋팅
			frm.amount.value = toCurrencyString(sSecond + sDot);
			
			inField.focus(); 
			
			return false; 
			 
		}
		
		strCurrency = sSecond; 
	} 
	
	strlen  = strCurrency.length; 
	cntLoop = Math.floor(strlen / 3); 
	rem     = strlen % 3; 
	
	if(rem == 0) { 
		rem = 3; cntLoop--; 
	}
	
	result = strCurrency.substr(0, rem); 
	
	for(ipos = 0 ; ipos < cntLoop ; ipos++) {
		result += "," + strCurrency.substr(3 * ipos + rem , 3);
	}
		 
	if (isMinus){
		result = "-" + result; 
	}
	
	if(isDot){
		result = result + sDot; 
	}
	
	return result; 
}

//====================================
// 숫자만 입력 가능
//====================================
function onlyNumber(event){
	
	var key = window.event ? event.keyCode : event.which;
	
	if( (event.shiftKey == false) && ( (key > 47 && key < 58) || (key > 95 && key < 106) 
			|| key == 35 || key == 36 || key == 37 || key == 39
			|| key == 8  || key == 46 )   
	){
		return true;
	}else{
		
		alert("<%= msgCheckNumber %>");
		
		return false;
	}
}	

//-------------------------------------------------------------------------
// Vendor 조회 팝업
//-------------------------------------------------------------------------		
function f_openVendorPop() {	
	
	openVendorSapListWin('A');		
}

</script>

<!-----------------------------------------------------------------------------
	프로그램 전용 D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- currency code combo 용 DataSet -->
<object id="ds_currencyCode" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad" value="true">
	<param name="DataID"   value="cm.cm.retrieveCommCodeCombo.gau?groupCd=2004&firstVal=Select">
</object>

<!-- cost center Combo 용 DataSet-->
<object id="ds_cost_center" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad" value="true">
	<param name="DataID"   value="cm.cm.retrieveCommComboCostCenterList.gau?firstVal=Select">
</object>

<!-- unit combo 용 DataSet -->
<object id="ds_unit" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad" value="true">
	<param name="DataID"   value="cm.cm.retrieveCommCodeCombo.gau?groupCd=UNIT&firstVal=Select">
</object>

</head>
<!-----------------------------------------------------------------------------
   화면영역 시작
------------------------------------------------------------------------------>
<body id="cent_bg" onload="init()">

	<div id="conts_box">
		<h2><span><%=columnData.getString("page_title") %></span></h2>        
        
        <!-- 그리드 S -->	
        <div id="output_board_area">
        	<form name="aForm" method="post" enctype="multipart/form-data">
            	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board" >
                	<colgroup>
                        <col width="20%"/>
                        <col width="28%"/>
                        <col width="20%"/>
                        <col width=""/>
              		</colgroup>
                    <tr>
                    	<th class="required"><%=columnData.getString("asset_nm") %></th>
                    	<td><input id="assetNm" name="assetNm" type="text" style="width:180px;" /></td>
                    	<th class="required"><%=columnData.getString("acq_date") %></th>
                    	<td>
							<input type="text" id="acqDate" onblur="valiDate(this);" style="width:60px;" />
							<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(acqDate);" style="cursor:hand"/>									
						</td>                    	
                    </tr>
                    <tr>		
                    	<th class="required"><%=columnData.getString("acq_amount") %></th>
                    	<td><input id="amount" name="amount" type="text" style="width:180px;" onkeyup="javascript:toCurrencyChange(this)" /></td>
                    	<th class="required"><%=columnData.getString("curr_cd") %></th>                    		
						<td>									
							<object id="currCd"  classid="<%=LGauceId.LUXECOMBO%>" width="150">
							    <param name="ComboDataID"       value="ds_currencyCode">
								<param name="ListCount"     	value="10">
								<param name="BindColumn"    	value="code">
								<param name="WantSelChgEvent"   value="TRUE">
							    <param name=ListExprFormat		value="name^0^90,code^0^70">
							    <param name=index           	value=0>
						   	</object>									
						</td>
                   	</tr>
                    <tr>                        
                    	<th class="required"><%=columnData.getString("qty") %></th>
                    	<td><input id="qty" name="qty" type="text" style="width:180px;" onkeydown="return onlyNumber(event)" maxlength="9" /></td>                    	                    	
                    	<th class="required"><%=columnData.getString("unit") %> </th>		
						<td>									
							<object id="unit" classid="<%=LGauceId.LUXECOMBO%>" width="150">
								<param name="ComboDataID"   value="ds_unit">
								<param name="ListCount"     value="10">
								<param name=SearchColumn	value="name">
								<param name="BindColumn"    value="code">
								<param name=SyncComboData   value="false">
								<param name=ListExprFormat	value="name^0^150,code^0^70"> 
								<param name=index           value=0>
							</object>									
						</td>
                    </tr>
                    <tr>                        
                    	<th><%=columnData.getString("cost_center") %></th>
                    	<td>									
							<object id="costCenter" classid="<%=LGauceId.LUXECOMBO%>" width="150">
								<param name="ComboDataID"   value="ds_cost_center">
								<param name="ListCount"     value="10">
								<param name=SearchColumn	value="name">
								<param name="BindColumn"    value="code">
								<param name=SyncComboData   value="false">
								<param name=ListExprFormat	value="name^0^150,code^0^70"> 
								<param name=index           value=0>
							</object>									
						</td>                    	                    	
                    	<th><%=columnData.getString("vend_cd") %> </th>		
						<td>
							<input type="hidden" id="vendCd" name="vendCd" />
							<input type="text" id="vendNm" name="vendNm" style="width:138px;" readonly />&nbsp;
				  			<img src="<%= images %>button/search_icon_2.gif"  onClick="javascript:f_openVendorPop();" style="cursor:hand"/>
				  		</td>
                    </tr>
                    <tr>
                        <th><%=columnData.getString("asset_desc") %></th>
                        <td colspan="3"><input type="text" id="assetDesc" name="assetDesc" style="width:345px;" maxlength="200" /></td>
                    </tr>
                    <tr>
                        <th class="required"><%=columnData.getString("file_upload") %></th>
                        <td colspan="3"><input name="fileUpload" type="file" class="input_text" style="width:355px;height:18px;" text="file"></td>
                    </tr>                    
            	</table>
         	</form>
		</div>
		<!-- 그리드 E -->	
        
        <!-- 버튼 S -->	
        <div id="btn_area">
        	<p class="b_right">
        		<span class="btn_r btn_l">
                	<input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnSave %>" onclick="f_save()"/>
                </span> 
            </p>
        </div>
        <!-- 버튼 E -->	
		<div class="pad_t10"></div>
	</div>		
</body>
</html>
