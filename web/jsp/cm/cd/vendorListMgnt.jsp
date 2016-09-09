<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--
/*
*************************************************************************
* @source  : vendorListMgnt.jsp
* @desc    : Vendor List 조회 및 수정
*------------------------------------------------------------------------
* VER  DATE         AUTHOR      DESCRIPTION
* ---  -----------  ----------  -----------------------------------------
* 1.0  2010.08.30    임민수       init
* ---  -----------  ----------  -----------------------------------------
* PT-PAM System
* Copyright(c) 2006-2007 LG CNS,  All rights reserved.
*************************************************************************
*/
--%> 
<%@ page import="devon.core.util.*" %> 
<jsp:useBean id="stringUtil" class="comm.util.StringUtil"             scope="request" />
<jsp:useBean id="lgiHubUtil" class="comm.util.Util"                   scope="request" />
<jsp:useBean id="noticeList" class="devon.core.collection.LMultiData" scope="request"/>
<jsp:useBean id="qnaList"    class="devon.core.collection.LMultiData" scope="request"/>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>   
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 

<title>PT-PAM System</title>
<%@ include file="/include/head.jsp" %>

<script type="text/javascript">
var msg="";
function init(){

	// TM/TBM 콤보 박스 데이터				
 
	cfAddYn(ds_yn,"code"); 
    cfUnionBlank(ds_yn,lc_useYn,"code","name","--Total--");		
	cfAddYn(ds_gyn,"code");  
	ds_country.DataId="/cm.cm.retrieveCommCodeCombo.gau?groupCd=1100";
	ds_country.Reset();
	
}

function f_retrieve(){ 
	
    var condition = "?";

    //if (!checkData()) return;
    condition += "&vendCd="  + document.all.vendCd.value;
    condition += "&vendNm="  + document.all.vendNm.value;
    condition += "&useyn="  + document.all.lc_useYn.bindColVal;

    ds_main.DataID = "retrieveVendorCodeListPopup.gau"+condition;
    ds_main.Reset();

}

function f_save(){
	//변경한 데이터가 있는지 체크한다.
	if(confirm("Do you want to save?")){
		var param = "?";
		
		param +="&companyCd=" + ds_main.NameValue(ds_main.RowPosition, "companyCd");
		param +="&vendCd=" + ds_main.NameValue(ds_main.RowPosition, "vendCd");
		
		tr_cudMaster.KeyValue = "Servlet(I:IN_DS1=ds_detail)";
		tr_cudMaster.Action   = "/VendorDetailMgnt.gau" + param;
		tr_cudMaster.post();
	}
	
}


function f_addRowApp(){ 
	// Seq 채번 
	var seq = "";
	if(ds_detail.CountRow > 0){
		seq = parseInt(ds_detail.NameValue(ds_detail.CountRow, "vendSeq"),10) + 1;
		
		for(var i=  seq.toString().length; i<4; i++){
			seq = '0' + seq;
		}
	
	}else
		seq = "0001";

	ds_detail.AddRow();   
	cfHideNoDataMsg(gr_detail);//no data 메시지 숨기기
	
	ds_detail.NameValue(ds_detail.RowPosition, "vendSeq") = seq;
	ds_detail.NameValue(ds_detail.RowPosition, "mainYn") = 'N';
	ds_detail.NameValue(ds_detail.RowPosition, "useYn") = 'Y';
	
	
}

function f_delRowApp(){
	if(ds_detail.CountRow<1){
		alert("삭제할 데이터가 없습니다.");
	}

	if(ds_detail.RowPosition>0){
		ds_detail.DeleteRow(ds_detail.RowPosition);
	}

}
//-------------------------------------------------------------------------
//Excel Download
//-------------------------------------------------------------------------			
function f_excel() {
	
	gf_excel(ds_main,gr_main,"<%=columnData.getString("page_title") %>","c\\");
}

</script>
<!-----------------------------------------------------------------------------
T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- CUD TR -->
<!-- Payment Arrange CUD TR -->
<OBJECT id=tr_cudMaster classid="<%=LGauceId.TR%>">
	<param name="KeyName"   value="toinb_dataid4"> 
	<param name="KeyValue"  value="JSP(I:ds_main=ds_main,I:ds_detail=ds_detail,I:ds_approval=ds_approval)">
	<param name="ServerIP"  value=""> 
</OBJECT>
 
<!-----------------------------------------------------------------------------
D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-- Grid 용 DataSet-->
<object id="ds_main" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true">
</object>

<!-- Grid 용 DataSet-->
<object id="ds_detail" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true">
	<param name="ViewDeletedRow"    value="false">
</object>

<!-- Yes/No Combo 용 DataSet-->
<object id="ds_yn" classid="<%=LGauceId.DATASET%>" >
  	<param name="SyncLoad"          value="true"> 
</object>

<object id="ds_gyn" classid="<%=LGauceId.DATASET%>" >
  	<param name="SyncLoad"          value="true"> 
</object>

<object id="ds_country" classid="<%=LGauceId.DATASET%>" >
  	<param name="SyncLoad"          value="false"> 
</object>


<!-----------------------------------------------------------------------------
G A U C E   C O M P O N E N T' S   E V E N T S
------------------------------------------------------------------------------>
<script language=JavaScript for=ds_main event=OnLoadStarted()>
  cfShowDSWaitMsg(gr_main);//progress bar 보이기
  cfHideNoDataMsg(gr_main);//no data 메시지 숨기기
</script>

<!-- Hub In Header 조회 DataSet -->
<script language=JavaScript for=ds_main event=OnLoadCompleted(rowCnt)>
  cfHideDSWaitMsg(gr_main);//progress bar 숨기기
  cfFillGridNoDataMsg(gr_main,"gridColLineCnt=2");  //no data found   
</script> 


<!-- Hub In Header 조회 DataSet -->
<script language=JavaScript for=ds_detail event=OnLoadCompleted(rowCnt)>
  cfHideDSWaitMsg(gr_detail);//progress bar 숨기기
  cfFillGridNoDataMsg(gr_detail,"gridColLineCnt=2");  //no data found   
</script> 

<script language=JavaScript for="ds_main" event=OnRowPosChanged(row)>
		
		ds_detail.ClearAll();
		if(row>0){
			var param = "?";
			param += "&companyCd="+ds_main.NameValue(ds_main.RowPosition, "companyCd");
			param += "&vendCd="+ds_main.NameValue(ds_main.RowPosition, "vendCd");
			
			ds_detail.DataID = "retrieveVendorDetailList.gau"+param;
			ds_detail.Reset();		
		}
		
</script>


<script language=JavaScript for=tr_cudMaster event=OnFail()>
	mode = "";
	if(tr_cudMaster.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
		window.parent.location.href = "/index.jsp";    
	}
	alert(tr_cudMaster.ErrorMsg);
	f_retrieve();
    
</script>

<script language=JavaScript for=tr_cudMaster event=OnSuccess()>
	
	g_flug=false; 
	f_retrieve();
	alert("Success");
</script> 

<script language=JavaScript for=gr_detail event=OnCloseUp(row,colid)>
	var cnt=0;
	
	if(colid =="mainYn" && ds_detail.NameValue(row, "mainYn") =="Y" ){
		for(var i=1; i<=ds_detail.CountRow; i++){
			if(ds_detail.NameValue(i, "mainYn") == "Y"){
				cnt++;
			}
		}
	}
	
	if(cnt>1){
		alert('Only one item can be Main ');
		ds_detail.NameValue(ds_detail.RowPosition, "mainYn") = "N";
	}

</script>
 

</head>

<body id="cent_bg" onload="init();">
<div id="conts_box">
	<h2> <span> Business Partner List </span></h2>
	<!--검색 S -->	
	<fieldset class="boardSearch"> 
		<div>
			<dl>
				<dt> 
						<table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board2" >
					<colgroup>
						<col width="21%"/>
						<col width="14%"/> 
						<col width="21%"/> 
						<col width="25%"/> 
						<col width="10%"/> 
						<col width=""/>
					</colgroup>
					<tr>
							<th>Biz. Partner Code</th>
							<td><input type="text" id="vendCd" style="width:60px;" /></td>
							
							<th>Biz. Partner Name</th>
							<td><input type="text" id="vendNm" style="width:130px;" /></td>
							
							<th><%=columnData.getString("useyn") %></th>
							<td><comment id="__NSID__"><object id="lc_useYn"  classid="<%=LGauceId.LUXECOMBO%>" width="80">
								<param name="ComboDataID"       value="ds_yn">
								<param name="ListCount"     	value="10">
								<param name=SearchColumn		value="name">
								<param name="BindColumn"    	value="code">
								<param name=ListExprFormat		value="name^0^70,code^0^70">
								<param name=index           	value=0>
								</object></comment><script>__WS__(__NSID__); </script>
							</td>
							
					</tr>
				</table>
			</dt>              		  	   	 	
			<dd class="btnseat1"> 
				<span class="search_btn_r search_btn_l">
					<input type="button" onfocus="blur();" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='#e2ebf7'" value="<%=btnSearch %>" onclick="f_retrieve();"/>
				</span> 
			</dd>			
			
			</dl>
		</div>
	</fieldset>
	<!--검색 E -->		

	<div class="sub_stitle"> 
		<p> Business Partner List  </p> 
		<p class="rightbtn"> 
			<span class="excel_btn_r excel_btn_l">
				<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="<%=btnExcelDown %>" onclick="f_excel()"/>
			</span> 
		</p>	
	</div>  
	<!-- 그리드 S -->
		<div>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<comment id="__NSID__">
						<object id="gr_main" classid="<%=LGauceId.GRID %>" style="width:100%;height:350px;" class="comn">
							<param name="DataID"            value="ds_main"/> 
							<param name="Editable"          value="true"/>
							<param name="UsingOneClick"		value="1">
							<param name="Format"     value='
					              <C> id="seq"            name=""              align="center" Edit="none" width="30" Value={CurRow} </C>
					              <C> id="vendCd"         name="<%=columnData.getString("vend_cd") %>"      align="center" Edit="none" width="90"  </C>
					              <C> id="vendNm"         name="<%=columnData.getString("vend_nm") %>"      align="left"   Edit="none" width="200" </C>
					              <C> id="countryCd"      name="<%=columnData.getString("country") %>"     	 align="center" Edit="none" width="90"  Data="ds_country:code:name" editstyle="lookup"  </C>
					              <C> id="vendDesc"      name="<%=columnData.getString("desc") %>"     	 align="center" Edit="none" width="120"  </C>
					              <C> id="telNo"      name="<%=columnData.getString("tel") %>"     	 align="center" Edit="none" width="120"  </C>
					              <C> id="addr1"      name="<%=columnData.getString("addr1") %>"     	 align="left" Edit="none" width="150"  </C>
					              <C> id="addr2"      name="<%=columnData.getString("addr2") %>"     	 align="left" Edit="none" width="120"  </C>
					              <C> id="useyn"      name="<%=columnData.getString("useyn") %>"     	 align="center" Edit="none" width="70"  </C>
   							  	  <C>id="companyCd"      show="false"   </C>
							'/>
							
						</object>
						</comment><script>__WS__(__NSID__);</script>
					</td>
				</tr>
			</table>
		</div>

	<!-- 버튼 S -->	
	<div id="btn_area">
		<p class="b_right">
			<span class="btn_r btn_l">
			</span> 
		</p>
	</div>
<!-- 버튼 E --> 
</div>
<input type="hidden" id="h_deliDate"/>
</body>
</html>

