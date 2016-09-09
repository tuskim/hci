<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--
/*
*************************************************************************
* @source  : purchOderMgnt.jsp
* @desc    : PO Send
*------------------------------------------------------------------------
* VER  DATE         AUTHOR      DESCRIPTION
* ---  -----------  ----------  -----------------------------------------
* 1.0  2010.07.21    노태훈       init
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
<%
String prevDate	   = LDateUtils.getDate("yyyy/MM/") +"01"; 
String currentDate = LDateUtils.getDate("yyyy/MM/dd");          // currentDate
%> 
<script type="text/javascript">
var g_Pos =0;
function init(){
	ds_deliLoct.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2005&firstVal=Total";
	ds_deliLoct.Reset();
	
	ds_materType.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2202";
	ds_materType.Reset();
	
	ds_poStatus.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2203&firstVal=Total";
	ds_poStatus.Reset();
	
	ds_payTerm.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2301";
	ds_payTerm.Reset();			
 	
	cfAddYn(ds_useYn,"code"); 
}

function f_retrieve(){ 
	var v_url = new cfURI();
	v_url.Add("poFromDate",encodeURIComponent(poFromDate.value));
	v_url.Add("poToDate"  ,encodeURIComponent(poToDate.value));
	v_url.Add("deliLoct",ds_deliLoct.NameValue(ds_deliLoct.RowPosition,"code"));
	v_url.Add("vendNm",encodeURIComponent(vend_nm.value));			
	v_url.Add("materType",ds_materType.NameValue(ds_materType.RowPosition,"code"));
	v_url.Add("status",ds_poStatus.NameValue(ds_poStatus.RowPosition,"code"));	
	v_url.SetPage("po.po.retrievePurchOrderMgntMainList.gau");
	ds_main.DataId = v_url.GetURI();
	ds_main.Reset();
}

function f_setData(){
}

function f_save()
{
	if(!ds_main.IsUpdated) {
		alert( '변경된 내용이 없습니다.' );
		return;
	}


	for(var i=1;i<=ds_main.CountRow;i++){
		if(ds_main.NameValue(i,"storageCd")==""){
			ds_main.RowPosition=i;
			alert('storge는 필수 입력입니다.' );
			return;
		}
		if(ds_main.NameValue(i,"materCd")==""){
			ds_main.RowPosition=i;
			alert('materCd는 필수 입력입니다.' );
			return;
		}		
		/*
		if(ds_main.RowStatus(i) == "1")	{
			ds_dup.DataID  = "/po.sr.retrieveSafetyStockMgntDup.gau?";
			ds_dup.DataID += "storageCd=" + ds_main.NameValue( i , "storageCd" );
			ds_dup.DataID += "&materCd=" + ds_main.NameValue( i , "materCd" );
			ds_dup.Reset();	 
			if(ds_dup.NameValue(1,"CNT") > 0){
				ds_main.RowPosition=i;	 
				alert("mater:["+ds_main.NameValue( i , "materNm" )+ "] 는 중복 값이 존재합니다" );
				return;
			}
		}		
		*/
		var v_chk = 0;
		var v_chk1 = ds_main.NameValue(i,"storageCd")+ds_main.NameValue(i,"materCd");
		for(var j=1;j<=ds_main.CountRow;j++){
			if(v_chk1 == ds_main.NameValue(j,"storageCd")+ds_main.NameValue(j,"materCd")){
				v_chk++;
				if(v_chk>1){
					ds_main.RowPosition = j;
					alert("mater:["+ds_main.NameValue( i , "materNm" )+ "] 는 중복 값이 존재합니다" );
					return;
				}
			}			
		}
	}

	//변경한 데이터가 있는지 체크한다.
	if(confirm("저장하시겠습니까?")){
		g_Pos = ds_main.RowPosition;	 
		tr_cudMaster.post();
	}
}

function f_addRow(){
	if(ds_approval.CountRow<1){
		var strHeader = "chk"     + ":STRING(50)"
				 	 + ",companyCd"   + ":STRING(50)"
					 + ",vendCd"      + ":STRING(50)"
					 + ",vendSeq"     + ":STRING(50)"
					 + ",vendPerson"  + ":STRING(50)"
					 + ",userNm"      + ":STRING(50)"
					 + ",emailAddr"   + ":STRING(50)"
					 + ",telNo"       + ":STRING(50)"
					 + ",faxNo"       + ":STRING(50)"
					 + ",mainYn"      + ":STRING(50)";
		ds_approval.SetDataHeader(strHeader);
	}
	ds_approval.AddRow();
	ds_approval.NameValue(ds_approval.RowPosition,"companyCd")= ds_main.NameValue(ds_main.RowPosition,"companyCd");
	ds_approval.NameValue(ds_approval.RowPosition,"vendCd")   = ds_main.NameValue(ds_main.RowPosition,"vendCd");
	ds_approval.NameValue(ds_approval.RowPosition,"vendSeq")  = ds_approval.CountRow;			
	ds_approval.NameValue(ds_approval.RowPosition,"mainYn")   = 'N';	
}

function f_delRow(){
	if(ds_approval.CountRow<1){
		alert("삭제할 데이터가 없습니다.");
	}
	if(confirm("삭제하시겠습니까?")){
		if(ds_approval.RowPosition>0)	{
			ds_approval.DeleteRow(ds_approval.RowPosition);
		}
	}
}
</script>
<!-----------------------------------------------------------------------------
T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- CUD TR -->
<!-- Payment Arrange CUD TR -->
<OBJECT id=tr_cudMaster classid="<%=LGauceId.TR%>">
	<param name="KeyName"   value="toinb_dataid4">
	<param name="KeyValue"  value="JSP(I:ds_main=ds_main)">
	<param name="ServerIP"  value="">
	<param name="Action"    value="po.sr.cudSafetyStockMgnt.gau">
</OBJECT>

<!-----------------------------------------------------------------------------
D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-- Grid 용 DataSet-->
<object id="ds_main" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true">
	<param name="ViewDeletedRow"    value="false">
</object>

<!-- Grid 용 DataSet-->
<object id="ds_detail" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true">
	<param name="ViewDeletedRow"    value="false">
</object>

<!-- Grid 용 DataSet-->
<object id="ds_approval" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true">
	<param name="ViewDeletedRow"    value="false">
</object>

<!-- lx Combo 용 DataSet-->
<object id="ds_poStatus" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true"> 
</object>

<!-- lx Combo 용 DataSet-->
<object id="ds_materType" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true"> 
</object>

<!-- lx Combo 용 DataSet-->
<object id="ds_deliLoct" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true"> 
</object>

<!-- lx Combo 용 DataSet-->
<object id="ds_payTerm" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true"> 
</object>
 
<object id="ds_useYn" classid="<%=LGauceId.DATASET%>" >
	<param name="SyncLoad"          value="true">
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
  cfFillGridNoDataMsg(gr_main,"gridColLineCnt=2");//no data found   
</script>

<script language=JavaScript for=ds_payTerm event=OnLoadCompleted(rowCnt)> 
	cfUnionBlank(ds_payTerm,lc_payTerm,"code","name");
</script>


<script language=JavaScript for="ds_main" event=OnRowPosChanged(row)>
		ds_detail.ClearAll();
		if(row>0){
			var v_url = new cfURI();
			v_url.Add("poNo",ds_main.NameValue(ds_main.RowPosition,"poNo")); 
			v_url.SetPage("po.po.retrievePurchOrderMgntDetailList.gau");
			ds_detail.DataId = v_url.GetURI();
			ds_detail.Reset(); 
			
			var v_url = new cfURI();
			v_url.Add("vendCd",ds_main.NameValue(ds_main.RowPosition,"vendCd")); 
			v_url.SetPage("po.po.retrievePurchOrderMgntAppList.gau");
			ds_approval.DataId = v_url.GetURI();
			ds_approval.Reset(); 			
		}
</script>

<script language=JavaScript for=tr_cudMaster event=OnFail()>
	mode = "";
	if(tr_cudMaster.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
		window.parent.location.href = "/index.jsp";    
	}
	alert(tr_cudMaster.ErrorMsg);
</script>

<script language=JavaScript for=tr_cudMaster event=OnSuccess()>
	f_retrieve();
	ds_main.RowPosition = g_Pos; 			
	alert("successfully saved.");
</script>

<script language=JavaScript for=gr_main event=OnPopup(row,colid,data)>
	if ( colid == "materCd") {
		openMaterialCodeListGridWin(row, ds_main);
	}
</script>

</head>

<body id="cent_bg" onload="init();">
<div id="conts_box">
	<h2> <span> <%=columnData.getString("page_title") %> </span></h2>
	<!--검색 S -->	
	<fieldset class="boardSearch"> 
		<div>
			<dl>
				<dt> 
					<table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board2" >
						<colgroup>
							<col width="21%"/>
							<col width="37%"/>
							<col width="17%"/>
							<col width="14%"/>
							<col width="10%"/>
							<col width=""/>
						</colgroup>
						<tr>
							<th><%=columnData.getString("po_cre_date") %>  </th>
							<td><input type="text" style="width:60px;" id="poFromDate" value="<%= prevDate %>" />
								<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="" onclick="javascript:OpenCalendar(poFromDate);" class="button_cal"/>
								~
								<input type="text" style="width:60px;" id="poToDate" value="<%= currentDate %>" />
								<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="" onclick="javascript:OpenCalendar(poToDate);" class="button_cal"/></td>
							<th><%=columnData.getString("vend_cd") %> </th>
							<td colspan="3"><input type="text" style="width:75px;" id="vend_nm" value="" />
							</td>
						</tr>
						<tr>
							<th><%=columnData.getString("deli_loct") %>  </th>
							<td><comment id="__NSID__"><object id="lc_deliLoct"  classid="<%=LGauceId.LUXECOMBO%>" width="150">
								<param name="ComboDataID"       value="ds_deliLoct">
								<param name="ListCount"     	value="10">
								<param name=SearchColumn		value="name">
								<param name="BindColumn"    	value="code">
								<param name=ListExprFormat		value="name^0^90,code^0^70">
								<param name=index           	value=0>
								</object></comment><script>__WS__(__NSID__); </script>
							</td>
							<th><%=columnData.getString("mater_type") %></th>
							<td><comment id="__NSID__"><object id="lc_materType"  classid="<%=LGauceId.LUXECOMBO%>" width="80">
								<param name="ComboDataID"       value="ds_materType">
								<param name="ListCount"     	value="10">
								<param name=SearchColumn		value="name">
								<param name="BindColumn"    	value="code">
								<param name=ListExprFormat		value="name^0^90,code^0^70">
								<param name=Enable       		value="false">
								<param name=index           	value=0>
								</object></comment><script>__WS__(__NSID__); </script>
							</td>
							<th><%=columnData.getString("status") %> </th>
							<td><comment id="__NSID__"><object id="lc_postatus"  classid="<%=LGauceId.LUXECOMBO%>" width="90">
								<param name="ComboDataID"       value="ds_poStatus">
								<param name="ListCount"     	value="10">
								<param name=SearchColumn		value="name">
								<param name="BindColumn"    	value="code">
								<param name=ListExprFormat		value="name^0^100,code^0^70">
								<param name=index           	value=0>
								</object></comment><script>__WS__(__NSID__); </script>
							</td>
						</tr>
					</table>
				</dt>              		  	   	 	
				<dd class="btnseat2"> 
					<span class="search_btn2_r search_btn2_l">
					<input type="button" onfocus="blur();" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='#e2ebf7'" value="<%=btnSearch%>" onclick="f_retrieve();"/></span> 
				</dd>											
			</dl>
		</div>
	</fieldset>
	<!--검색 E -->		

	<div class="sub_stitle"> <p><%=columnData.getString("sub1_title") %></p>     </div>
	<!-- 그리드 S -->
		<div>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<comment id="__NSID__">
						<object id="gr_main" classid="<%=LGauceId.GRID %>" style="width:100%;height:250px;" class="comn">
							<param name="DataID"            value="ds_main"/> 
							<param name="UrlImages"         value="<I>Type='PopupBotton', Url='/sys/images/button/search_icon_2.gif', Fit='AutoFit', Flat='True'</I>">
							<param name="Format"            
							value="
							<C>id='poNo'         name='<%=columnData.getString("po_no") %>'        width='100'  align='center'                         </C>
							<C>id='vendNm'       name='<%=columnData.getString("vend_cd") %>'      width='110'  align='left'                           </C>
							<C>id='deliLoctNm'   name='<%=columnData.getString("deli_loct") %>'    width='100'  align='left'                           </C>
							<C>id='poCreDate'    name='<%=columnData.getString("po_cre_date") %>'  width='100'  align='center'      mask='XXXX/XX/XX'  </C>
							<C>id='poSendDate'   name='<%=columnData.getString("po_send_date") %>' width='100'  align='center'      mask='XXXX/XX/XX'  </C>
							<C>id='amountTot'    name='<%=columnData.getString("amount_tot") %>'   width='120'  align='right'       value={DisplayFormat(amount,'#,##0')}                   </C>
							<C>id='status'       name='<%=columnData.getString("status") %>'       width='100'  align='center'                         </C>	"/>
						</object>
						</comment><script>__WS__(__NSID__);</script>
					</td>
				</tr>
			</table>
		</div>
		<!-- 그리드 E -->
		<div class="sub_stitle"> <p><%=columnData.getString("sub2_title") %></p>     </div>
		<!-- 그리드 S -->
		<div>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<comment id="__NSID__">
						<object id="gr_detail" classid="<%=LGauceId.GRID %>" style="width:100%;height:250px;" class="comn">
							<param name="DataID"            value="ds_detail"/> 
							<param name="UrlImages"         value="<I>Type='PopupBotton', Url='/sys/images/button/search_icon_2.gif', Fit='AutoFit', Flat='True'</I>">
							<param name="Format"              
							value="							            
							<C>id='materNm'  name='<%=columnData.getString("mater_cd") %>' width='140'  align='left'      </C>
							<C>id='unit'     name='<%=columnData.getString("unit") %>'     width='100' align='center'    </C>
							<C>id='qty'      name='<%=columnData.getString("qty") %>'      width='110' align='right'  value={DisplayFormat(amount,'#,##0')}   </C>
							<C>id='vatCd'    name='<%=columnData.getString("vat_cd") %>'   width='100' align='center'    </C>
							<C>id='price'    name='<%=columnData.getString("price") %>'    width='110' align='right'  value={DisplayFormat(amount,'#,##0')}   </C>
							<C>id='amount'   name='<%=columnData.getString("amount") %>'   width='110' align='right'  value={DisplayFormat(amount,'#,##0')}   </C>	"/>
						</object>
						</comment><script>__WS__(__NSID__);</script>
					</td>
				</tr>
			</table>
		</div>
		<!-- 그리드 E -->
		<div class="sub_stitle"> 
			<dl>
				<dt> <%=columnData.getString("sub3_title") %>  </dt>								
				<dd> 
					<comment id="__NSID__">
					<object id="lc_payTerm"  classid="<%=LGauceId.LUXECOMBO%>" width="150">
						<param name="ComboDataID"       value="ds_payTerm">
						<param name="ListCount"     	value="10">
						<param name=SearchColumn		value="name">
						<param name="BindColumn"    	value="code">
						<param name=ListExprFormat		value="name^0^90,code^0^70">
						<param name=index           	value=0>
						<param name=ComboStyle          value="2">											    
						<param name=WantSelChgEvent	    value=true>	
					</object></comment><script>__WS__(__NSID__); </script>
				</dd>
			</dl>   				
			<p class="rightbtn"><span class="sbtn_r sbtn_l">
				<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="<%=btnAddRow%>" onclick="f_addRow();"/></span> 
				<span class="sbtn_r sbtn_l"> 
				<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="<%=btnDelRow%>" onclick="f_delRow();"/></span>  	 
			</p>
		</div>
		<!-- 그리드 S -->
		<div>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<comment id="__NSID__">
						<object id="gr_approval" classid="<%=LGauceId.GRID %>" style="width:100%;height:250px;" class="comn">
							<param name="DataID"            value="ds_approval"/> 
							<param name="Editable"          value="true"/>
							<param name="UrlImages"         value="<I>Type='PopupBotton', Url='/sys/images/button/search_icon_2.gif', Fit='AutoFit', Flat='True'</I>">
							<param name="Format"              
							value="
							<C>id='chk'       name='<%=columnData.getString("send") %>'     width='50'  align='center' edit='true'    </C>
							<C>id='userNm'    name='<%=columnData.getString("charge") %>'   width='110' align='left'   edit='true'    </C>
							<C>id='emailAddr' name='<%=columnData.getString("e_mail") %>'   width='150' align='left'   edit='true'    </C>
							<C>id='telNo'     name='<%=columnData.getString("tel_no") %>'   width='150' align='left'   edit='true'    </C>
							<C>id='faxNo'     name='<%=columnData.getString("fax_no") %>'   width='150' align='left'   edit='true'    </C>
							<C>id='mainYn'    name='<%=columnData.getString("main_cd") %>'  width='80'  align='center' edit='true' Data='ds_Useyn:code:name:code' editstyle='lookup'   </C>"/>
						</object>
						</comment>
						<script>__WS__(__NSID__);</script>
					</td>
				</tr>
			</table>
		</div>
		<!-- 그리드 E -->

	<!-- 버튼 S -->	
	<div id="btn_area">
		<p class="b_right">
			<span class="btn_r btn_l">
			<input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#444'" value="<%=btnCancel%>" onclick=""/>
			</span> 
			<span class="btn_r btn_l">
			<input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#444'" value="<%=btnSapSend%>" onclick=""/>
			</span> 

			<span class="btn_r btn_l">
			<input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#444'" value="<%=btnCancelReq%>" onclick=""/>
			</span> 
			<span class="btn_r btn_l">
			<input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#444'" value="<%=btnOrder%>" onclick=""/>
			</span> 		
			<span class="btn_r btn_l">
			<input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#444'" value="<%=btnSave%>" onclick=""/>
			</span> 
		</p>
	</div>
<!-- 버튼 E --> 
</div>
</body>
</html>

