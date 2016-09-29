<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html xmlns="http://www.w3.org/1999/xhtml">
<%--
/*
 *************************************************************************
 * @source  : codeManage.jsp
 * @desc    : 공통 코드 등록
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
<%@ page import = "java.util.*" %>
<%@ page import = "java.lang.*" %>
<%@ page import="devon.core.util.*" %>
<%@ page import="comm.util.*"%>
<%@ include file="/include/head.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head> 
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title>PT-PAM System</title> 
<head>

<script language="javascript">
var g_flug =false; // Detail작업 flag
var g_msPos = 0;   // save후  focus 제정의 Row
var g_ddtPos = 0;  // save후  focus 제정의 Row

function init(){ 
	f_setData();
}

//-------------------------------------------------------------------------
// Set header
//-------------------------------------------------------------------------
function f_setData(){
	 
	cfAddYn(ds_msUseyn,"code");
	cfAddYn(ds_dtUseyn,"code"); 
	
}
//-------------------------------------------------------------------------
// 조회
//-------------------------------------------------------------------------
function f_retrieve(){ 
	ds_main.DataID  = "/cm.cm.retrieveCodeMgntList.gau?";
    ds_main.DataID += "group_cd=" + encodeURIComponent(i_cgroup.value);
    ds_main.DataID += "&group_nm=" + encodeURIComponent(i_ngroup.value); 
 	ds_main.Reset();
}
//-------------------------------------------------------------------------
// Master AddRow
//-------------------------------------------------------------------------
function f_msAddrow(){ 
	if(ds_main.CountRow<1)	{
	    var strHeader  = "CHK:STRING(50),companyCd:STRING(50),groupCd:STRING(50),";
	        strHeader += "groupNm:STRING(50),msRemark:STRING(500),msYn:STRING(50),msRegid:STRING(50),";
	        strHeader += "msRegnm:STRING(50),msRegdate:STRING(50),msModid:STRING(50),msModdate:STRING(50)";
    	ds_main.SetDataHeader(strHeader);
    	cfHideNoDataMsg(gd_main);
	}
	
	for(var j=1;j<=ds_main.CountRow;j++){
		if("" == ds_main.NameValue(j,"groupCd")){
			ds_main.RowPosition= j ;
			gd_main.SetColumn("groupCd");
			alert("<%=source.getMessage("dev.warn.com.input",columnData.getString("group_cd"))%>");
			return;
		}			
	}
	ds_main.addrow();
	ds_main.NameValue(ds_main.RowPosition,"CHK")= "1"; 
	ds_main.NameValue(ds_main.RowPosition,"msYn")= "Y";		
}
//-------------------------------------------------------------------------
// Detail AddRow
//-------------------------------------------------------------------------
function f_dtAddRow(){
	if(ds_main.CountRow>0)	{
		if(ds_main.NameValue(ds_main.RowPosition,"groupCd")=="" 
		    || ds_main.NameValue(ds_main.RowPosition,"groupCd")== null)	{
		    gd_main.SetColumn("groupCd");
			alert("<%=source.getMessage("dev.warn.com.input",columnData.getString("group_cd"))%>");
			return;
		}	
		ds_main2.addrow();
		ds_main2.NameValue(ds_main2.RowPosition,"CHK")= "1";  
		ds_main2.NameValue(ds_main2.RowPosition,"useyn")= "Y";					
	}
}
//-------------------------------------------------------------------------
// Detail DeleteRow
//-------------------------------------------------------------------------
function f_dtDelRow(){ 
	if(ds_main2.RowPosition>0){
		ds_main2.DeleteRow(ds_main2.RowPosition);
		/*if(confirm("삭제하시겠습니까?")){
			
	        g_msPos = ds_main.RowPosition;
	        g_ddtPos = ds_main2.RowPosition;		
		    g_flug=true;	    
			tr_cudMaster.KeyValue = "Servlet( I:IN_DS1 = ds_main,I:IN_DS2 = ds_main2 )";
			tr_cudMaster.Action   = "/cm.cm.cudCodeMgnt.gau"; 
			msg ="successfully Delete."; 	
			tr_cudMaster.post();			
		}*/
	}
}
//-------------------------------------------------------------------------
// Total Save
//-------------------------------------------------------------------------
function f_save()
{

	if(!ds_main.IsUpdated && !ds_main2.IsUpdated) {
		alert("<%=source.getMessage("dev.inf.com.nochange")%>");
		return;
	}
	
	
	for(var i=1;i<=ds_main.CountRow;i++){
		if(ds_main.NameValue(i,"groupCd")==""){
			ds_main.RowPosition=i;
			gd_main.SetColumn("groupCd");
			alert("<%=source.getMessage("dev.warn.com.input",columnData.getString("group_cd"))%>");
			return;
		}
		
		if(ds_main.RowStatus(i) == "1")	{
			ds_dup.DataID  = "/cm.cm.retrieveCodeMgntDupCnt.gau?";
		    ds_dup.DataID += "companyCd=" + ds_main.NameValue( i , "companyCd" );
		    ds_dup.DataID += "&groupCd=" + ds_main.NameValue( i , "groupCd" );
			ds_dup.Reset();	 
			if(ds_dup.NameValue(1,"CNT") > 0)
			{
				ds_main.RowPosition=i;	 
				gd_main.SetColumn("groupCd");
				alert("<%=source.getMessage("dev.warn.com.dup",columnData.getString("group_cd"))%>");				
				return;
			}
			 
		}		
	
		var v_msChk = 0;
		var v_groupcd = ds_main.NameValue(i,"groupCd");
		for(var j=1;j<=ds_main.CountRow;j++){
			if(v_groupcd == ds_main.NameValue(j,"groupCd")){
				v_msChk++;
				if(v_msChk>1)
				{
					ds_main.RowPosition = j;
					gd_main.SetColumn("groupCd");
					alert("<%=source.getMessage("dev.warn.com.dup",columnData.getString("group_cd"))%>");
					return;
				}
			}			
		}
	}
	
	for(var a=1;a<=ds_main2.CountRow;a++){ 
		ds_main2.NameValue(a,"groupCd")= ds_main.NameValue(ds_main.RowPosition,"groupCd"); 
		if(ds_main2.NameValue(a,"detailCd")==""){
			ds_main2.RowPosition=a;
			gd_detail.SetColumn("detailCd");
			alert("<%=source.getMessage("dev.warn.com.input",columnData.getString("detail_cd"))%>");
			return;
		}
		var v_dtChk = 0;
		var v_groupcd = ds_main2.NameValue(a,"detailCd");
		for(var aj=1;aj<=ds_main2.CountRow;aj++){
			if(v_groupcd == ds_main2.NameValue(aj,"detailCd")){
				v_dtChk++;
				if(v_dtChk>1){
					ds_main2.RowPosition = aj;
					gd_detail.SetColumn("detailCd");
					alert("<%=source.getMessage("dev.warn.com.dup",columnData.getString("detail_cd"))%>");
					return;
				}
			}			
		}			
	}		
		
	//변경한 데이터가 있는지 체크한다.
	if(confirm("<%=source.getMessage("dev.cfm.com.save")%>")){
        g_msPos = ds_main.NameValue(ds_main.RowPosition,"groupCd");
        g_ddtPos = ds_main2.NameValue(ds_main2.RowPosition,"detailCd");
	    g_flug=true;	    
		tr_cudMaster.KeyValue = "Servlet( I:IN_DS1 = ds_main,I:IN_DS2 = ds_main2 )";
		tr_cudMaster.Action   = "/cm.cm.cudCodeMgnt.gau"; 
		msg ="successfully saved."; 	
		tr_cudMaster.post();
	}
}
 

</script> 

<%----------------------------------------------------------------------------------------------------
 Gauce obj  정의
---------------------------------------------------------------------------------------------------- --%>

<object id="ds_main" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/> 
</object>

<object id="ds_main2" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/> 
</object>

<object id="ds_main_temp" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/> 
</object>

<object id="ds_main2_temp" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/> 
</object>

<object id="ds_save" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/> 
</object>

<object id="ds_msUseyn" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/>
  <param name="ViewDeletedRow"    value="true"/>
</object>

<object id="ds_dtUseyn" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/>
  <param name="ViewDeletedRow"    value="true"/>
</object>

<object id="ds_dup" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/>
  <param name="ViewDeletedRow"    value="true"/>
</object>

<OBJECT id=tr_cudMaster classid="<%=LGauceId.TR%>">
    <param name="KeyName" value="toinb_dataid4">
</OBJECT>
<%----------------------------------------------------------------------------------------------------
 Gauce obj  event  정의
------------------------------------------------------------------------------------------------------%>
<script language=JavaScript for=ds_main event=OnLoadStarted()>
  cfShowDSWaitMsg(gd_main);//progress bar 보이기
  cfHideNoDataMsg(gd_main);//no data 메시지 숨기기
</script>

<!-- Hub In Header 조회 DataSet -->
<script language=JavaScript for=ds_main event=OnLoadCompleted(rowCnt)>
  cfHideDSWaitMsg(gd_main);//progress bar 숨기기
  cfFillGridNoDataMsg(gd_main,"gridColLineCnt=2");//no data found   
</script>

<script language=JavaScript for=ds_main2 event=OnLoadStarted()> 
</script>

<!-- Hub In Header 조회 DataSet -->
<script language=JavaScript for=ds_main2 event=OnLoadCompleted(rowCnt)> 
</script>

<script language=JavaScript for="ds_main" event=OnRowPosChanged(row)>
		ds_main2.ClearAll();
		if(row>0){
			
			ds_main2.DataID    = "/cm.cm.retrieveCodeMgntDtList.gau?";
			ds_main2.DataID    += "group_cd="+ds_main.NameValue(ds_main.RowPosition,"groupCd"); 
			ds_main2.Reset();
			//cfProgress(ds_main2,gd_detail);
		}
</script>

<script language=JavaScript for=gd_main event=OnSetFocus()>
 
</script>

<script language=JavaScript for=gd_detail event=CanColumnPosChange(row,colid)>

</script>

<script language=JavaScript for=ds_main2 event=OnColumnChanged(row,colid)>
	if(colid=="detailCd"){  

		h_lower.value = ds_main2.NameValue(row,"detailCd"); 
		lCase2Ucase(h_lower);  
		ds_main2.NameValue(row,"detailCd") = h_lower.value; 
	}
</script>

<script language=JavaScript for=ds_main event=OnColumnChanged(row,colid)>
	if(colid=="groupCd"){  

		h_lower.value = ds_main.NameValue(row,"groupCd"); 
		lCase2Ucase(h_lower);  
		ds_main.NameValue(row,"groupCd") = h_lower.value; 
	}
</script>

<script language=JavaScript for=ds_main event=CanRowPosChange(row)> 

		
		if(ds_main.IsUpdated){
			if(!g_flug){	 
				alert("<%=source.getMessage("dev.warn.com.continue")%>");
				return false;
			}
		}else if(ds_main2.IsUpdated){
			if(!g_flug){	 
				if(!confirm("<%=source.getMessage("dev.cfm.com.continue")%>")){
					return false;
				}
			}
		} 
</script>
<%----------------------------------------------------------------------------------------------------
 Gauce obj  event TR  정의
------------------------------------------------------------------------------------------------------%> 
<script language=JavaScript for=tr_cudMaster event=OnFail()>
		//ds_main.ClearAll();
		//ds_main2.ClearAll();
		//cfCopyDataSet(ds_main_temp,ds_main,"resetStatus=false");
		//cfCopyDataSet(ds_main2_temp,ds_main2,"resetStatus=false");	
    mode = "";
    if(tr_cudMaster.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
        window.parent.location.href = "/index.jsp";    
    }
    
    alert(tr_cudMaster.ErrorMsg);
</script> 

<script language=JavaScript for=tr_cudMaster event=OnSuccess()>
		g_flug=false; 
		f_retrieve();
        ds_main.RowPosition = ds_main.NameValueRow("groupCd",g_msPos);
        ds_main2.RowPosition = ds_main2.NameValueRow("detailCd",g_ddtPos);			
        alert(msg);
</script>
 
<%----------------------------------------------------------------------------------------------------
 UI  정의
---------------------------------------------------------------------------------------------------- --%>
</head>

<body id="cent_bg" onload="init();">
<div id="conts_box">
	<h2> <span> Common Code Management </span></h2>
	<!--검색 S -->	 
	<fieldset class="boardSearch"> 
	<div>
		<dl>
			<dt> 
				<table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board2" />
					<colgroup>
						<col width="8%"/>
						<col width="19%"/> 
						<col width="15%"/> 
						<col width=""/>
					</colgroup>
					<tr>
						<th><%=columnData.getString("group_cd") %> </th>
						<td>
							<input type="text" style="width:70px;" id="i_cgroup" value="" maxvalue/>
						</td>
						<th><%=columnData.getString("group_nm") %> </th>
						<td>
							<input type="text" style="width:140px;" id="i_ngroup" value="" maxvalue/>
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
	<div class="sub_stitle"> <p><%=columnData.getString("sub1_title") %>  </p> </div>        	
	<!-- 그리드 S -->	
	<div> 
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
					<comment id="__NSID__">
						<object id="gd_main" classid="<%=LGauceId.GRID %>" class="comn" style="width:100%;height:132px"> 
							<param name="DataID"              value="ds_main"> 
							<param name="SortView"            value="Left"/>
							<param name="Editable"            value="true"> 
							<param name="MultiRowSelect"      value="false"/> 
							<param name="Format"              value="
							<C>id='NO'		   name=''				    value={CurRow} width=30		align=center BgColor='#EDF1F6' </c>
							<C>id='groupCd'    name='<%=columnData.getString("group_cd") %>'         EditLimitText=4 EditLimit=4   edit={IF(CHK=0,'false','true')}, width='64' align='center' sort=true  </c>
							<C>id='groupNm'    name='<%=columnData.getString("group_nm") %>'         EditLimitText=30  EditLimit=30    Edit='true'  width='180' align='left' sort=true    </c>
							<C>id='msRemark'   name='<%=columnData.getString("ms_remark") %>'        EditLimitText=100 EditLimit=100    Edit='true'  width='250' align='left' sort=true   </c>
							<C>id='msRegnm'    name='<%=columnData.getString("ms_regnm") %>'         Edit='none'    width='90' align='center' sort=true  </c>
							<C>id='msRegdate'  name='<%=columnData.getString("ms_regdate") %>'       Edit='none'  width='95' align='center'    Mask='XXXX/XX/XX' sort=true</c>
							<C>id='msYn'       name='<%=columnData.getString("ms_yn") %>'    Data='ds_msUseyn:code:name'    EditStyle=Lookup          Edit='true'  width='71' align='center'   </c>"/>
						</object>
					</comment><script>__WS__(__NSID__);</script>
				</td>
			</tr>
		</table>
	</div>
 
    <div class="sub_stitle"> <p><%= columnData.getString("sub2_title") %></p>
		<p class="rightbtn">
		    <span class="sbtn_r sbtn_l">
			<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="<%=btnAddRow%>" onclick="f_dtAddRow();"/></span> 
			<span class="sbtn_r sbtn_l"> 
			<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="<%=btnDelRow%>" onclick="f_dtDelRow();"/></span>  	 
		</p>
	</div>
	<!-- 그리드 S -->	
	<div>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
					<comment id="__NSID__">
						<object id="gd_detail" classid="<%=LGauceId.GRID %>" class="comn" style="width:100%;height:175px">
							<param name="DataID"              value="ds_main2"/> 
							<param name="Editable"            value="true"/>
							<param name="ViewDeletedRow"      value="true"/>
							<param name="SortView"            value="Left"/>
							<param name="MultiRowSelect"      value="false"/>
							<param name="Format"              value="
							<C>id='NO'		      name=''				    value={CurRow} width=30	BgColor='#EDF1F6'	align=center</C>
							<C>id='detailCd'      name='<%=columnData.getString("detail_cd") %>'           EditLimitText=10  EditLimit=10   edit='true' ,  width='64' align='center' sort=true   </C>
							<C>id='detailCdNmKr'  name='<%=columnData.getString("detail_cd_nm_kr") %>'     EditLimitText=30 EditLimit=30           Edit='true'  width='180' align='left' sort=true  </C>
							<C>id='detailCdNmEn'  name='<%=columnData.getString("detail_cd_nm_en") %>'     EditLimitText=30 EditLimit=30           Edit='true'  width='180' align='left' sort=true  </C>
							<C>id='detailCdNmLo'  name='<%=columnData.getString("detail_cd_nm_lo") %>'     EditLimitText=30 EditLimit=30 EditLimit=100           Edit='true'  width='170' align='left' sort=true show='false' </C>
							<C>id='sort'         name='<%=columnData.getString("sort") %>'               EditLimitText=20 EditLimit=20 Edit='true'  width='46' align='left'    </C>
							<C>id='attr1'         name='<%=columnData.getString("attr1") %>'               EditLimitText=20 EditLimit=20 Edit='true'  width='55' align='left'    </C>
							<C>id='attr2'         name='<%=columnData.getString("attr2") %>'               EditLimitText=20 EditLimit=20 Edit='true'  width='55' align='left'    </C>
							<C>id='attr3'         name='<%=columnData.getString("attr3") %>'               EditLimitText=20 EditLimit=20 Edit='true'  width='55' align='left'    </C>
							<C>id='attr4'         name='<%=columnData.getString("attr4") %>'               EditLimitText=20 EditLimit=20 Edit='true'  width='55' align='left'    </C>
							<C>id='attr5'         name='<%=columnData.getString("attr5") %>'               EditLimitText=20 EditLimit=20 Edit='true'  width='55' align='left'    </C>
							<C>id='attr6'         name='<%=columnData.getString("attr6") %>'               EditLimitText=20 EditLimit=20 Edit='true'  width='55' align='left'    </C>
							<C>id='attr7'         name='<%=columnData.getString("attr7") %>'               EditLimitText=20 EditLimit=20 Edit='true'  width='55' align='left'    </C>
							<C>id='attr8'         name='<%=columnData.getString("attr8") %>'               EditLimitText=20 EditLimit=20 Edit='true'  width='55' align='left'    </C>
							<C>id='attr9'         name='<%=columnData.getString("attr9") %>'               EditLimitText=20 EditLimit=20 Edit='true'  width='55' align='left'    </C>
							<C>id='attr10'         name='<%=columnData.getString("attr10") %>'             EditLimitText=20 EditLimit=20 Edit='true'  width='55' align='left'    </C>							
							<C>id='useyn'         name='<%=columnData.getString("useyn") %>'               EditStyle=Lookup Edit='true' data='ds_dtUseyn:code:name:code'  width='47' align='center'   </C>"/>
						</object>
					</comment><script>__WS__(__NSID__);</script>
				</td>
			</tr>
		</table>
	</div>
	<!-- 그리드 E -->	
	<!-- 버튼 S -->	 
	<div id="btn_area">
		<p class="b_right">
			<span class="btn_r btn_l"> 
			<input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnNew%>" onclick="f_msAddrow();"/></span> 
			<span class="btn_r btn_l"> 
			<input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnSave%>" onclick="f_save();"/></span>
		</p>
	</div>	
	<!-- 버튼 E -->  
</div>
	<!-- 버튼 E -->  
</div>
</body>
<input type="hidden" name="h_lower" value="" />
<input type="hidden" name="h_upper" value="" /> 
<script src="<%=xjos %>/xjos.js" language="JScript"/></script>
</html>

