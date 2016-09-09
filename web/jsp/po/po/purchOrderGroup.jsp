<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--
/*
 *************************************************************************
 * @source  : purchOderGroup.jsp
 * @desc    : Vendor Grouping by P/R Page
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
var g_curr="";
function init(){
	f_setData();
}
 
function f_retrieve(){ 
	var v_url = new cfURI();
	v_url.Add("reqFromDate",encodeURIComponent(reqFromDate.value));
	v_url.Add("reqToDate"  ,encodeURIComponent(reqToDate.value));
	v_url.Add("vendNm",encodeURIComponent(vend_cd.value));
	v_url.Add("deliLoct",ds_deliLoct.NameValue(ds_deliLoct.RowPosition,"code"));
	v_url.Add("materType",ds_materType.NameValue(ds_materType.RowPosition,"code")); 	
	v_url.Add("prStatus",ds_prStatus.NameValue(ds_prStatus.RowPosition,"code")); 	
	v_url.SetPage("po.po.retrievePurchOrderGroup.gau");
	ds_main.DataId = v_url.GetURI(); 
	ds_main.Reset();
}

function f_setData(){
	//자제 구분
	ds_materType.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2202";
	ds_materType.Reset();
	
	//pr 상태
	ds_prStatus.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2201&firstVal=Total";
	ds_prStatus.Reset();	
	
	//긴급구분
	ds_urgent.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2204&firstVal=Total";
	ds_urgent.Reset();
	
	ds_deliLoct.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2005&firstVal=Total";
	ds_deliLoct.Reset();	
}

function f_setSaveData(){         			
var strHeader = "companyCd"       + ":STRING(50),"
            +"poNo"            + ":STRING(50),"
            +"materType"       + ":STRING(50),"
            +"purDeptCd"      + ":STRING(50),"
            +"vendCd"          + ":STRING(50),"
            +"currencyCd"      + ":STRING(50),"
            +"deliLoct"        + ":STRING(50),"
            +"poCreDate"      + ":STRING(50),"
            +"payTerm"         + ":STRING(50),"
            +"deliDate"        + ":STRING(50),"
            +"poSendDate"     + ":STRING(50),"
            +"parvw"            + ":STRING(50),"
            +"pernr"            + ":STRING(50),"
            +"bukrs"            + ":STRING(50),"
            +"absgr"            + ":STRING(50),"
            +"attr1"            + ":STRING(50),"
            +"attr2"            + ":STRING(50),"
            +"attr3"            + ":STRING(50),"
            +"attr4"            + ":STRING(50),"
            +"attr5"            + ":STRING(50),"
            +"attr6"            + ":STRING(50),"
            +"attr7"            + ":STRING(50),"
            +"attr8"            + ":STRING(50),"
            +"attr9"            + ":STRING(50),"
            +"attr10"           + ":STRING(50),"
            +"status"           + ":STRING(50),"
            +"transDate"       + ":STRING(50),"
            +"transTime"       + ":STRING(50),"
            +"progStatusDate" + ":STRING(50),"
            +"progStatusTime" + ":STRING(50),"
            +"sapPoNo"        + ":STRING(50),"
            +"sapRtnMsg"      + ":STRING(50)";
			        	    
	ds_save.SetDataHeader(strHeader);	
	for(var i=1; i<=ds_main.CountRow; i++){
		if(ds_main.NameValue(i,"chk")=="T"){
			ds_save.Addrow();
			ds_save.NameValue(ds_save.RowPosition,"companyCd"        ) = ds_main.NameValue(i,"companyCd");
			ds_save.NameValue(ds_save.RowPosition,"poNo"             ) = ds_main.NameValue(i,"poNo");       
			ds_save.NameValue(ds_save.RowPosition,"materType"        ) = ds_main.NameValue(i,"materType");  
			ds_save.NameValue(ds_save.RowPosition,"purDeptCd"       ) = ds_main.NameValue(i,"purDeptCd");          	
			ds_save.NameValue(ds_save.RowPosition,"vendCd"           ) = ds_main.NameValue(i,"vendCd")     
			ds_save.NameValue(ds_save.RowPosition,"currencyCd"       ) = ds_main.NameValue(i,"currencyCd"); 
			ds_save.NameValue(ds_save.RowPosition,"deliLoct"         ) = ds_main.NameValue(i,"deliLoct");   
			//ds_save.NameValue(ds_save.RowPosition,"poCreDate"     ) = "";
			//ds_save.NameValue(ds_save.RowPosition,"payTerm"        ) = "";
			ds_save.NameValue(ds_save.RowPosition,"deliReqDate"         ) = ds_main.NameValue(i,"deliReqDate");
			//ds_save.NameValue(ds_save.RowPosition,"poSendDate"    ) = "";
			ds_save.NameValue(ds_save.RowPosition,"parvw"             ) = "PE";
			//ds_save.NameValue(ds_save.RowPosition,"pernr"           ) = "";
			ds_save.NameValue(ds_save.RowPosition,"bukrs"             ) = "O100";
			ds_save.NameValue(ds_save.RowPosition,"absgr"             ) = "A7"
			//ds_save.NameValue(ds_save.RowPosition,"attr1"           ) = "";
			//ds_save.NameValue(ds_save.RowPosition,"attr2"           ) = "";
			//ds_save.NameValue(ds_save.RowPosition,"attr3"           ) = "";
			//ds_save.NameValue(ds_save.RowPosition,"attr4"           ) = "";
			//ds_save.NameValue(ds_save.RowPosition,"attr5"           ) = "";
			//ds_save.NameValue(ds_save.RowPosition,"attr6"           ) = "";
			//ds_save.NameValue(ds_save.RowPosition,"attr7"           ) = "";
			//ds_save.NameValue(ds_save.RowPosition,"attr8"           ) = "";
			//ds_save.NameValue(ds_save.RowPosition,"attr9"           ) = "";
			//ds_save.NameValue(ds_save.RowPosition,"attr10"          ) = "";
			//ds_save.NameValue(ds_save.RowPosition,"status"          ) = "01";
			//ds_save.NameValue(ds_save.RowPosition,"transDate"      ) = "";
			//ds_save.NameValue(ds_save.RowPosition,"transTime"      ) = "";
			//ds_save.NameValue(ds_save.RowPosition,"progStatusDate") = "";
			//ds_save.NameValue(ds_save.RowPosition,"progStatusTime") = "";
			break;
		}
	}
}

function f_save()
{
	if(!ds_main.IsUpdated) {
		alert( '변경된 내용이 없습니다.' );
		return;
	}
  
  	
	for(var i=1; i<=ds_main.CountRow; i++){
		if(ds_main.NameValue(i,"chk")=="T"){
			g_curr = ds_main.NameValue(i,"chkFlag");
			break;
		}
	}
	var msg="";
	for(var j=1; j<=ds_main.CountRow; j++){
		if(ds_main.NameValue(j,"chk")=="T"){
			if(g_curr != ds_main.NameValue(j,"chkFlag")){
				msg+=  j+": ";
			}
		}
	}
 
	alert(msg);
	if(msg!="")
		return; 
	//변경한 데이터가 있는지 체크한다.
	if(confirm("저장하시겠습니까?")){
		f_setSaveData();
		for(var j=1; j<=ds_main.CountRow;j++){ 
			if(ds_main.NameValue(j,"chk")=="T"){
				ds_main.UserStatus(j) =1;
			} 
			
		}	
        g_Pos = ds_main.RowPosition;	 
		tr_cudMaster.post();
	}
}

function f_addRow(){ 
}

function f_delRow(){ 
}
</script>
<!-----------------------------------------------------------------------------
  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- CUD TR -->
<!-- Payment Arrange CUD TR -->
<OBJECT id=tr_cudMaster classid="<%=LGauceId.TR%>">
    <param name="KeyName"   value="toinb_dataid4">
    <param name="KeyValue"  value="JSP(I:ds_save=ds_save,I:ds_main=ds_main)">
    <param name="ServerIP"  value="">
    <param name="Action"    value="po.po.cudPurchOrderGroup.gau">
</OBJECT>

<!-----------------------------------------------------------------------------
    D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-- Grid 용 DataSet-->
<object id="ds_main" classid="<%=LGauceId.DATASET%>" >
  	<param name="SyncLoad"          value="true">
  	<param name="ViewDeletedRow"    value="false">
</object>

<!-- Save 용 DataSet-->
<object id="ds_save" classid="<%=LGauceId.DATASET%>" >
  	<param name="SyncLoad"          value="true">
  	<param name="ViewDeletedRow"    value="false">
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
<object id="ds_prStatus" classid="<%=LGauceId.DATASET%>" >
  	<param name="SyncLoad"          value="true"> 
</object>

<!-- Grid lookup 용 DataSet-->
<object id="ds_urgent" classid="<%=LGauceId.DATASET%>" >
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

<script language=JavaScript for=gr_main event=OnCheckClick(row,colid,check)>
 	/*
 	gr_main.ReDraw="false";
 	var count = 0;
 	if(g_curr==""){ 
	 	g_curr= ds_main.NameValue(row,"chkFlag") ;
 		for(var a = 1; a<= ds_main.CountRow;a++){
 			if(ds_main.NameValue(a,"chkFlag")!=g_curr)	{
 			 	 ds_main.NameValue(a,"flag")="1";
		 	} 
	 	} 	 		   
 	}else {
 		for(var i = 1; i<= ds_main.CountRow;i++){
 			if(ds_main.NameValue(i,"chk")=="T")	{
 			 	count++; 
		 	} 
	 	} 
	 	if(count==1){
	 		g_curr= ds_main.NameValue(row,"chkFlag") ;
	 		for(var a = 1; a<= ds_main.CountRow;a++){
	 			if(ds_main.NameValue(a,"chkFlag")!=g_curr)	{
	 			 	 ds_main.NameValue(a,"flag")="1";
			 	} 
	 		} 	 	 		
	 	}else if(count==0){
	 		for(var a = 1; a<= ds_main.CountRow;a++){ 
	 			ds_main.NameValue(a,"flag")="0"; 
	 		} 	
	 	}	 	
 	}
 	
 	if(g_curr!=ds_main.NameValue(row,"chkFlag") ){
 		ds_main.NameValue(row,"chk")="F";
 	}*/
 	gr_main.ReDraw="true";
</script>

<script language=JavaScript for=gr_main event=CanColumnPosChange(row,colid)>

</script>

<script language="javascript"  for=gr_main event=OnHeadCheckClick(Col,Colid,bCheck)>
	if(Colid=="chk"){	
		if(bCheck==1){
			bCheck="T";
		}else{
			bCheck="F";
		} 
		gr_main.Redraw="false";
		for(var i=1;i<=ds_main.CountRow;i++){
			if(ds_main.NameValue(i,"poNo")==""){			
				ds_main.NameValue(i,"chk") = bCheck;
			}
		}
		gr_main.Redraw="true";
	}	
</script>


</head>

<body id="cent_bg" onload="init();">

<div id="conts_box">
<h2> <span> <%=columnData.getString("page_title")%> </span></h2>
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
							<th><%=columnData.getString("reqdate") %> </th>
							<td> <input type="text" style="width:60px;" id="reqFromDate" value="<%= prevDate %>" />
								<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="" onclick="javascript:OpenCalendar(reqFromDate);" class="button_cal"/> ~ <input type="text" style="width:60px;" id="reqToDate" value="<%= currentDate %>" />
								<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="" onclick="javascript:OpenCalendar(reqToDate);" class="button_cal"/> </td>					
							<th><%=columnData.getString("vend_nm") %>  </th>
							<td colspan="3"><input type="text" style="width:75px;" id="vend_cd" value="" /></td>							
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
							<td><comment id="__NSID__"><object id="lc_prStatus"  classid="<%=LGauceId.LUXECOMBO%>" width="90">
								<param name="ComboDataID"       value="ds_prStatus">
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
						<input type="button" onfocus="blur();" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='#e2ebf7'" value="<%=btnSearch %>" onclick="f_retrieve()"/></span> 
				</dd>											
			</dl>
		</div>
	</fieldset>
	<!--검색 E -->	
	<div class="sub_stitle"> <p><%=columnData.getString("sub_title")%></p> </div>        	
	<!-- 그리드 S -->	
	<div>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
					<comment id="__NSID__">
						<object id="gr_main" classid="<%=LGauceId.GRID %>" style="width:100%;height:288px;" class="comn">
							<param name="DataID"            value="ds_main"/> 
							<param name="UrlImages"         value="<I>Type='PopupBotton', Url='/sys/images/button/search_icon_2.gif', Fit='AutoFit', Flat='True'</I>">
							<param name="TitleHeight"       value="30">
							<param name="editable"          value="true">
							<param name=UsingOneClick       value="1">
							<param name="Format"            
							value="
									<C>id='NO'		      name='No.'				    value={CurRow} width=30	BgColor='#EDF1F6'	align=center                                                 </C>
									<C>id='chk'           name=''  edit={IF(flag=0,'true','false')}          width='30'  align='center'  edit='true' EditStyle='CheckBox', HeadAlign=center HeadCheck=false, headCheckShow='true' </C>
									<C>id='prNo'          name='<%=columnData.getString("pr_no") %>'         width='85'  align='center'  edit='none'                                                              </C>
									<C>id='poNo'          name='<%=columnData.getString("po_no") %>'         width='85'  align='center'  edit='true'                                                              </C>
									<C>id='vendNm'        name='<%=columnData.getString("vend_nm") %>'       width='75'  align='left'    edit='none'                                                              </C>
									<C>id='deliLoctNm'    name='<%=columnData.getString("deli_lost_nm") %>'  width='80'  align='left'    edit='none'                                                              </C>
									<C>id='currencyNm'    name='<%=columnData.getString("currency_nm") %>'   width='57'  align='center'  edit='none'                                                              </C>		
									<C>id='materNm'       name='<%=columnData.getString("mater_nm") %>'      width='75'  align='center'  edit='none'                                                              </C>
									<C>id='urgentType'    name='<%=columnData.getString("urgent_type") %>'   width='90'  align='center'  edit={IF(poNo='','false','true')} EditStyle=Lookup Edit='true' data='ds_urgent:code:name:code' </C>
									<C>id='unit'          name='<%=columnData.getString("unit") %>'          width='50'  align='center'  edit='none'                                                              </C>
									<C>id='qty'           name='<%=columnData.getString("qty") %>'           width='85'  align='right'   edit='none' value={DisplayFormat(amount,'#,##0')}                        </C>
									<C>id='price'         name='<%=columnData.getString("price") %>'         width='110' align='right'   edit='none' value={DisplayFormat(amount,'#,##0')}                        </C>
									<C>id='amount'        name='<%=columnData.getString("amount") %>'        width='110' align='right'   edit='none' value={DisplayFormat(amount,'#,##0')}                        </C>
									<C>id='vatCd'         name='<%=columnData.getString("vat_cd") %>'        width='80'  align='center'  edit='none'                                                              </C>
									<C>id='reqDeptNm'     name='<%=columnData.getString("req_dept_nm") %>'   width='120' align='left'    edit='none'                                                              </C>			           
									<C>id='reqDate'       name='<%=columnData.getString("req_date") %>'      width='93'  align='center'  edit='none' Mask='XXXX/XX/XX'                                            </C>
									<C>id='deliReqDate'   name='<%=columnData.getString("deli_req_date")%>'  width='93'  align='center'  edit='none' Mask='XXXX/XX/XX'                                            </C>
									"/>
						</object>
					</comment><script>__WS__(__NSID__);</script>
				</td>
			</tr>
		</table>
	</div>	  
	<!-- 그리드 E -->
	<!-- 버튼 S -->	
	<div id="btn_area">
		<p class="b_right"><span class="btn_r btn_l">
			<input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#444'" value="<%=btnSave%>" onclick="f_save();"/></span> 
		</p>
	</div>
	<!-- 버튼 E -->	
</div>
</body>
</html>