<!DOCTYPE html >
<html>
<%@ include file="/include/doctype.jsp"%>
<%--
/*
 **************************************************************************************
 * @source  : assetAcqRequestList.jsp
 * @desc    : 자산의 처리요청(취득, 매각, 폐기)을 조회하고 미처리 건을 삭제하는 화면
 *-------------------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  ------------------------------------------------------
 * 1.0  2015/12/21	 hckim		 Init      		 		  
 * ---  -----------  ----------  ------------------------------------------------------
 * Copyright(c) 2006-2007 LG CNS,  All rights reserved.
 **************************************************************************************
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
	String prevDate	            = LDateUtils.getDate("yyyy/MM/") +"01"; 
	String currentDate          = LDateUtils.getDate("yyyy/MM/dd");

	String msgWarnRetrieve      = source.getMessage("dev.warn.com.retrieve");         // please first retrieve!	
	String msgDelete            = source.getMessage("dev.cfm.com.delete");            // Are you sure to Delete?	
	String msgCheckStatus       = source.getMessage("dev.warn.com.checkStatusDel");   // Only 'Insert' status can be deleted.	
	String msgCheckRequestDate  = source.getMessage("dev.warn.com.checkRequestDate"); // Check searching condition.(Request date)
%> 

<head>

<script type="text/javascript">
parent.centerFrame.cols='220,*';
//-------------------------------------------------------------------------
// 초기값 셋팅	 	
//-------------------------------------------------------------------------		
function init(){
}

//-------------------------------------------------------------------------
// 조회조건 입력시 	 	
//-------------------------------------------------------------------------				
function keyDownSch(evt){
	if ( evt.keyCode == 13 || evt == '^') {
		f_search();	
	}
}

//-------------------------------------------------------------------------
// Search 버튼 클릭 시 - Requested Asset List 정보 조회
//-------------------------------------------------------------------------
function f_Retrieve() {
	
	if (checkData()) {

		var condition = "?";
	    	condition += "requestDateFrom=" + removeDash(document.all.requestDateFrom.value,"/");
	    	condition += "&requestDateTo=" + removeDash(document.all.requestDateTo.value,"/");
	    	condition += "&assetNm=" + document.all.assetNm.value;
	    	condition += "&requestType=" + requestType.ValueOfIndex("code",requestType.Index);    	
	    	condition += "&sapStatus=" + sapStatus.ValueOfIndex("code",sapStatus.Index);
	    	    	 		
		ds_grid.DataID = "fi.at.retrieveRequestedAssetList.gau"+condition;
		ds_grid.Reset();	
	}
}				   
		 
//-------------------------------------------------------------------------
//검색 필수 체크
//-------------------------------------------------------------------------
function checkData() {
	
	var requestDateFrom = removeDash(document.all.requestDateFrom.value,"/");
	var requestDateTo   = removeDash(document.all.requestDateTo.value,"/");
	
	// 요청 시작일자, 종료일자가 모두 있는 경우
	if(requestDateFrom != "" && requestDateTo != ""){
		
		// 요청시작일자가 요청종료일자보다 클 경우
		if(Number(requestDateFrom) > Number(requestDateTo)){
			alert('<%= msgCheckRequestDate %>');
			return false;
		}
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
		
//-------------------------------------------------------------------------
// 삭제버튼 클릭시
//-------------------------------------------------------------------------			
function f_Delete(){

	if(ds_grid.CountRow == 0) {
        alert("<%= msgWarnRetrieve %>"); // please first retrieve!
        return;
    }
	
	if (checkSaveData()) {

		if (confirm('<%= msgDelete %>')) {
			
			mode = "process";

			// 삭제할 Requested Asset 정보
		  	var param = "requestNo=" + document.deleteForm.requestNo.value			     							     
		  	         + ",companyCd=" + document.deleteForm.companyCd.value;					    
				     			
			tr_cudData.Parameters = param;		 
		  	tr_cudData.KeyValue	= "JSP(I:IN_DS1=ds_grid)";
			tr_cudData.Action = "fi.at.cudRequestedAsset.gau";			
	 		tr_cudData.Post();	 		
	 	} 	
 	}
}

//-------------------------------------------------------------------------
// validation (유효성 체크)
//-------------------------------------------------------------------------					
function checkSaveData() {
	
	var frm = document.deleteForm;
	
	var sapStatus = frm.sapStatus.value;  
	
	// SAP Status 값이 'R' 이 아닌 경우 ( R:Insert, P:Xi Load, S:SAP processed )
	if(sapStatus != "R"){ 		
		alert("<%= msgCheckStatus %>");		
		return;
	}
	
	return true;
}				

</script>


<!-----------------------------------------------------------------------------
		 D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- Grid  DataSet-->
<object id="ds_grid" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad" value="true">
	<param name="ViewDeletedRow" value="true">
</object>

<!-- Request Type combo 용 DataSet -->
<object id="ds_request_type" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad" value="true">
	<param name="DataID"   value="cm.cm.retrieveCommCodeCombo.gau?groupCd=ASRT&firstVal=Total">
</object>

<!-- Status combo 용 DataSet -->
<object id="ds_sap_status" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad" value="true">
	<param name="DataID"   value="cm.cm.retrieveCommCodeCombo.gau?groupCd=ASST&firstVal=Total">
</object>

<!-- 저장 DataSet -->
<object id="ds_cudMstData" classid="<%=LGauceId.DATASET%>"></object>

<!-----------------------------------------------------------------------------
  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- CUD TR -->
<OBJECT id=tr_cudData classid="<%=LGauceId.TR%>">
	<param name="KeyName" value="toinb_dataid4">
	<param name="ServerIP"  value="">
</OBJECT>

<!-----------------------------------------------------------------------------
	G A U C E   C O M P O N E N T' S   E V E N T S
------------------------------------------------------------------------------>
<script language=JavaScript for=ds_grid event=OnLoadStarted()>
	cfHideNoDataMsg(gr_grid);//no data 메시지 숨기기
  	cfShowDSWaitMsg(gr_grid);//progress bar 보이기
  	mode = "";
</script>

<script language=JavaScript for=ds_grid event=OnLoadCompleted(rowCnt)>
  	cfHideDSWaitMsg(gr_grid);//progress bar 숨기기
  	cfFillGridNoDataMsg(gr_grid,"gridColLineCnt=2");//no data found   
  	mode = "";
</script>

<script language=JavaScript for=ds_grid event=OnLoadError()>
  	cfShowErrMsg(ds_grid);
  	//mode = "";
</script>

<script language=JavaScript for=gr_grid event=OnClick(row,colid)>
	
	var form = document.fileDownForm;	
    var fileName = ds_grid.NameValue(row, "fileName");
	var fileUrl = ds_grid.NameValue(row, "fileUrl");
		
	// Attached File Row 클릭 시
	if(colid == "fileName"){

		var condition = "?";
			condition += "fileName=" + fileName;
			condition += "&fileUrl=" + fileUrl;
		
		form.action = "fi.at.assetAcqRequestDownloadFile.dev"+condition;						
		form.submit();
	}
	
</script>

<script language="javascript" for=ds_grid event=OnRowPosChanged(row)>

	var frm = document.deleteForm;
	
	// deleteForm - requestNo, sapStatus, companyCd 값 초기화
  	frm.requestNo.value = "";
  	frm.sapStatus.value = "";
  	frm.companyCd.value = "";

	if ( row > 0 ) {

		// deleteForm - 선택 row의 requestNo, sapStatus, companyCd 값 셋팅
		frm.requestNo.value = ds_grid.NameValue(row,"requestNo");
  		frm.sapStatus.value = ds_grid.NameValue(row,"sapStatus");
  		frm.companyCd.value = ds_grid.NameValue(row,"companyCd");
	}

</script>

<script language=JavaScript for=tr_cudData event=OnFail()>	
	mode = "";
    
	if(tr_cudData.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
        window.parent.location.href = "/index.jsp";    
    }	
	alert("Error Code : " + tr_cudData.ErrorCode + "\n" + "Error Message : " + tr_cudData.ErrorMsg + "\n");
</script>

<script language=JavaScript for=tr_cudData event=OnSuccess()>	
    alert("successfully saved.");
    f_Retrieve();
</script>

</head>

<body id="cent_bg" onload="init();">

<div id="conts_box">
	<h2><span><%=columnData.getString("page_title") %></span></h2>

	<!-- Requested Asset List 검색 영역 Start -->			
	<fieldset class="boardSearch">
		<div>
			<dl>
				<dt>
					<input type="hidden" id="personalId" name="personalId" value="" /> 
					<table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board2" >
						<colgroup>
							<col width="15%"/>
							<col width="40%"/>
							<col width="14%"/>
							<col width=""/>
						</colgroup>
						<tr>
							<th><%= columnData.getString("request_date") %></th>
							<td>
								<input type="text" id="requestDateFrom" value="<%= prevDate %>" onblur="valiDate(this);" style="width:60px;" readonly />
								<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(requestDateFrom);" style="cursor:hand"/> ~ 
								<input type="text" id="requestDateTo"   value="<%= currentDate %>" onblur="valiDate(this);" style="width:60px;" readonly />
								<img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(requestDateTo);" style="cursor:hand"/>								
							</td>
							<th><%=columnData.getString("asset_nm") %> </th>		
							<td><input id="assetNm" name="assetNm" type="text" style="width:140px;"  /></td>																		
						</tr>
						<tr>								
							<th><%=columnData.getString("request_type") %> </th>		
							<td>									
								<object id="requestType"  classid="<%=LGauceId.LUXECOMBO%>" width="150">
								    <param name="ComboDataID"       value="ds_request_type">
									<param name="ListCount"     	value="10">
									<param name="BindColumn"    	value="code">
									<param name="WantSelChgEvent"   value="TRUE">
								    <param name=ListExprFormat		value="name^0^90,code^0^70">
								    <param name=index           	value=0>
							   	</object>									
							</td>
							<th><%=columnData.getString("status") %> </th>		
							<td>									
								<object id="sapStatus"  classid="<%=LGauceId.LUXECOMBO%>" width="150">
								    <param name="ComboDataID"       value="ds_sap_status">
									<param name="ListCount"     	value="10">
									<param name="BindColumn"    	value="code">
									<param name="WantSelChgEvent"   value="TRUE">
								    <param name=ListExprFormat		value="name^0^90,code^0^70">
								    <param name=index           	value=0>
							   	</object>									
							</td>
						</tr>
					</table>
				</dt>              		  	   	 	
				<dd class="btnseat2"> 
				 	<span class="search_btn2_r search_btn2_l">
                		<input type="button" onfocus="blur();" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='#e2ebf7'" value="<%=btnSearch %>" onclick="f_Retrieve();"/>
                	</span> 
				</dd>
			</dl>
		</div>
	</fieldset>      		
	<!-- Requested Asset List 검색 영역 End -->

	<div style="height:30px;"></div>
	
	<!-- Requested Asset List GRID 영역 Start -->
	<div>
		<object id="gr_grid" classid="<%=LGauceId.GRID %>" style="width:100%;height:230px;" class="comn" dataName="payment request" validFeatures="ignoreStatus=no" validExp="">
			<param Name="DataID" 			value='ds_grid'>
	    	<Param name="AutoResizing"      value=true>	 
	    	<param name="Editable"          value=True>
	    	<Param NAME="TitleHeight"      	value="30">
	    	<param name="UsingOneClick"     value="1"/>
			<param Name='Format' value='
				<c>id="requestNo"      name="<%=columnData.getString("request_no") %>"    align="center"  width="120"  Edit="none"  show="true"   </c>
	        	<c>id="assetNm"        name="<%=columnData.getString("asset_nm") %>"      align="left"    width="150"  Edit="none"  show="true"   </c>	        		        	
	        	<c>id="requestTypeNm"  name="<%=columnData.getString("request_type") %>"  align="center"  width="90"   Edit="none"  show="true"   </c>	        	
	        	<c>id="sapStatusNm"    name="<%=columnData.getString("status") %>"        align="center"  width="90"   Edit="none"  show="true"   </c>	        		        										        					        	 	
	        	<c>id="amount"         name="<%=columnData.getString("acq_amount") %>"    align="right"   width="130"  Edit="none"  show="true"   </c> 		
	        	<c>id="currCd"         name="<%=columnData.getString("curr_cd") %>"       align="center"  width="60"   Edit="none"  show="true"   </c>   			        	
	        	<c>id="qty"            name="<%=columnData.getString("qty") %>"           align="center"  width="60"   Edit="none"  show="true"   </c> 			        				    				        					        		        	 
	        	<c>id="acqDate"        name="<%=columnData.getString("acq_date") %>"      align="center"  width="80"   Edit="none"  show="true"  Mask="XXXX/XX/XX"  </c>
	        	<c>id="assetDesc"      name="<%=columnData.getString("asset_desc") %>"    align="left"    width="110"  Edit="none"  show="true"   </c>	        	
	        	<c>id="costCenterNm"   name="<%=columnData.getString("cost_center") %>"   align="center"  width="110"  Edit="none"  show="true"   </c>
	        	<c>id="vendNm"         name="<%=columnData.getString("vend_cd") %>"       align="center"  width="110"  Edit="none"  show="true"   </c>	        	
	        	<c>id="assetNo"        name="<%=columnData.getString("asset_no") %>"      align="center"  width="110"  Edit="none"  show="true"   </c>
	        	<c>id="docNo"          name="<%=columnData.getString("doc_no") %>"        align="center"  width="110"  Edit="none"  show="true"   </c>
	        	<c>id="fileName"       name="<%=columnData.getString("file_name") %>"     align="left"    width="400"  Edit="none"  show="true"   </c>  
	        	<c>id="requestType"                                                       align="center"  width="90"   Edit="none"  show="false"  </c>
	        	<c>id="sapStatus"                                                         align="center"  width="150"  Edit="none"  show="false"  </c>
	        	<c>id="costCenter"                                                        align="center"  width="110"  Edit="none"  show="false"  </c>
	        	<c>id="vendCd"                                                            align="center"  width="110"  Edit="none"  show="false"  </c>
	        	<c>id="fileUrl"                                                           align="center"  width="110"  Edit="none"  show="false"  </c>
	        	<c>id="companyCd"                                                         align="center"  width="110"  Edit="none"  show="false"  </c>  '>	
	        </param>	      
		</object>
 	</div>	
	<!-- Requested Asset List GRID 영역 End -->
			
	<!-- 하단 버튼 영역 Start -->
	<div id="btn_area">
		<p class="b_right">
			<span class="btn_r btn_l"> 
				<input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnDel %>" onclick="javascript:f_Delete()" />
			</span>
		</p>
	</div>
	<!-- 하단 버튼 영역 End --> 	
	
	<!-- 파일 다운로드 form -->
	<form id="fileDownForm" name="fileDownForm" method="post"></form>
	
	<!-- Requested Asset 삭제 form -->
	<form id="deleteForm" name="deleteForm" method="post">
		<input type="hidden" id="requestNo" name="requestNo" />
		<input type="hidden" id="sapStatus" name="sapStatus" />
		<input type="hidden" id="companyCd" name="companyCd" />
	</form>
	
</div>	
</body>
</html>