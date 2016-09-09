<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--
/*
*************************************************************************
* @source  : RentalUnitMgnt.jsp
* @desc    : Rental Unit List 관리 
*------------------------------------------------------------------------
* VER  DATE         AUTHOR      DESCRIPTION
* ---  -----------  ----------  -----------------------------------------
* 1.0  2010.09.07    임민수       init
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

<title>PT-MPP System</title>
<%@ include file="/include/head.jsp" %>
<%
String prevDate	   = LDateUtils.getDate("yyyy/MM/") +"01"; 
String currentDate = LDateUtils.getDate("yyyy/MM/dd");          // currentDate
%> 
<script type="text/javascript">

var g_msPos = 1; // 저장후 위치 지정 변수

function init(){

	f_setData();
	
}

function f_retrieve(){ 
	
	var param = "?";
	param += "&contractDateFrom=" + removeDash(document.all.srtDate.value, "/");
	param += "&contractDateTo=" + removeDash(document.all.endDate.value, "/");
	param += "&workLocation=" + document.all.lc_workLocation.bindColVal;
	param += "&unit=" + document.all.lc_unit.bindColVal;
	param += "&type=" + document.all.type.value;
	
	ds_main.DataID = "/cm.mu.retrieveRentalUnitMgntList.gau?"+param;
	ds_main.Reset();
}

function f_setData(){
	// y/n DS
	cfAddYn(ds_yn,"code"); 
    cfUnionBlank(ds_yn,ds_yn,"code","name");		
    
	//min Charge
	ds_minCharge.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2310";
	ds_minCharge.Reset();

	//measure
	ds_measure.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2309";
	ds_measure.Reset();

	//currency
	ds_currency.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2004";
	ds_currency.Reset();

	//condition
	ds_condition.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2308";
	ds_condition.Reset();

	//contract
	ds_contract.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2101";
	ds_contract.Reset();

	//unit
	ds_unit.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2307";
	ds_unit.Reset();

	//worklocation
	ds_workLocation.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2306";
	ds_workLocation.Reset();


}


function f_mainNew(){
	if(ds_main.CountRow<1){
		var strHeader =  "chk"               		+   ":STRING(50)"
						+",workCd"          		    +   ":STRING(50)"
						+",unitCate"               	+   ":STRING(50)"
						+",type"              		 	+   ":STRING(50)"
						+",contract"           		+   ":STRING(50)"
						+",owner"        			    +   ":STRING(50)"
						+",condition"      			+   ":STRING(50)"
						+",purpose"      			+   ":STRING(50)"
						+",rentPrice"      			+   ":DECIMAL(13.3)"
						+",currCd"      				+   ":STRING(50)"
						+",measure"     				+   ":STRING(50)"
						+",fromDate"    				+   ":STRING(50)"
						+",toDate"  					+   ":STRING(50)"
						+",minCharge"      			+   ":STRING(50)"
						+",minChargeHr"      		+   ":DECIMAL(13.3)"
						+",remark"      				+   ":STRING(50)"
						+",useYn"      				+   ":STRING(50)"
						+",companyCd"      		+   ":STRING(50)"
						+",typeSeq"      			+   ":STRING(50)";
		ds_main.SetDataHeader(strHeader);
	}
	
	ds_main.UndoAll();
	
	ds_main.AddRow();
	cfHideNoDataMsg(gr_main);//no data 메시지 숨기기
	ds_main.NameValue(ds_main.RowPosition, "chk") = "T";

}


function f_mainSave(){
	var chkTmp = "false";
	for(var i=0; i<=ds_main.CountRow; i++){
		if( "T" == ds_main.NameValue(i, "chk")){
			chkTmp = "true";
			
			if(	ds_main.NameValue(i, "useYn")  ==""){
				alert('<%=source.getMessage("dev.warn.com.required", "use Y/N") %>');			
				return;
			}
		} 
	}
	
	if( chkTmp == "false")
	{
		alert("Please Check Items to save");
		return;
	}




	if(confirm('<%=source.getMessage("dev.cfm.com.save") %>')){
		tr_cudMaster.KeyValue = "Servlet(I:IN_DS1=ds_main)";
		tr_cudMaster.Action   = "/cm.mu.cudRentalUnitMgnt.gau";
		tr_cudMaster.post();
	}

}

//-------------------------------------------------------------------------
//Excel Download
//-------------------------------------------------------------------------
function f_excel() {
	
	gf_excel(ds_main,gr_main,"<%=columnData.getString("page_title") %>","c:\\");
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
	<param name="ViewDeletedRow"    value="true">
</object>

<!-- y/n combo DataSet -->
<object id="ds_yn"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
</object>

<!-- work Location combo DataSet -->
<object id="ds_workLocation"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
</object>

<!-- unit combo DataSet -->
<object id="ds_unit"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
</object>

<!-- contract  combo DataSet -->
<object id="ds_contract"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
</object>

<!-- condition combo DataSet -->
<object id="ds_condition"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
</object>

<!-- currency combo DataSet -->
<object id="ds_currency"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
</object>

<!-- measure combo DataSet -->
<object id="ds_measure"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
</object>

<!-- min charge combo DataSet -->
<object id="ds_minCharge"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
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
  cfFillGridNoDataMsg(gr_main,"gridColLineCnt=4");//no data found   
</script> 


<!--Hidden 달력조회-->
<script language=JavaScript for=gr_main event=OnPopup(row,colid,data)>
 	
 	if ( colid == "fromDate") {
	 	h_date.value ="";
		gf_calendarExClean(h_date); 
		ds_main.NameValue(row,"fromDate") =funcReplaceStrAll(h_date.value,"/","");		 	
	}else if( colid == "toDate"){
	 	h_date.value ="";
		gf_calendarExClean(h_date); 
		ds_main.NameValue(row,"toDate") =funcReplaceStrAll(h_date.value,"/","");		 	
	
	}
</script>


<script language=JavaScript for=ds_workLocation event=OnLoadCompleted(rowCnt)>
	cfUnionBlank(ds_workLocation,lc_workLocation,"code","name","--Total--");
	cfUnionBlank(ds_unit,lc_unit,"code","name","--Total--");
</script>


<script language=JavaScript for=tr_cudMaster event=OnFail()>
	mode = "";
	if(tr_cudMaster.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
		window.parent.location.href = "/index.jsp";    
	}
	alert(tr_cudMaster.ErrorMsg);
//	f_retrieve();
    
</script>

<script language=JavaScript for=tr_cudMaster event=OnSuccess()>
	
	g_flug=false; 
	f_retrieve();
    ds_main.RowPosition    = g_msPos;
	alert("successfully saved.");
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
											<col width="24%"/>
											<col width="18%"/>
											<col width="15%"/>
											<col width="18%"/>
											<col width="15%"/>
											<col width="18%"/>
											<col width=""/>
									  </colgroup>
										<tr>											
											<th><%= columnData.getString("work_location") %> </th>
											<td><comment id="__NSID__"><object id="lc_workLocation"  classid="<%=LGauceId.LUXECOMBO%>" width="140">
												<param name="ComboDataID"       value="ds_workLocation"/>
												<param name="ListCount"     	value="10"/>
												<param name=SearchColumn		value="name"/>
												<param name="BindColumn"    	value="code"/>
												<param name=ListExprFormat		value="name^0^150,code^0^70"/>
												<param name=index           	value=0/>
												</object></comment><script>__WS__(__NSID__); </script>
											</td>

											<th><%= columnData.getString("unit") %> </th>
											<td><comment id="__NSID__"><object id="lc_unit"  classid="<%=LGauceId.LUXECOMBO%>" width="140">
												<param name="ComboDataID"       value="ds_unit"/>
												<param name="ListCount"     	value="10"/>
												<param name=SearchColumn		value="name"/>
												<param name="BindColumn"    	value="code"/>
												<param name=ListExprFormat		value="name^0^150,code^0^70"/>
												<param name=index           	value=0/>
												</object></comment><script>__WS__(__NSID__); </script>
											</td>


											<th><%= columnData.getString("type") %> </th>
											<td><input id="type" name="type" size="15"/></td>
										</tr>
										<tr>
											<th><%= columnData.getString("contract_period") %> </th>
											<td colspan="3"> 
											 <input id="srtDate" name="srtDate" type="text" style="width:60px;" value="" /> <img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(srtDate);" style="cursor:hand"/> ~ 
											 <input id="endDate" name="endDate" type="text" style="width:60px;" value="" /> <img src="<%= images %>button/cal_icon.gif" alt="Calendar Icon" onClick="javascript:OpenCalendar(endDate);" style="cursor:hand"/>
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

	<div class="sub_stitle"> <p><%=columnData.getString("sub_title1") %></p> 	
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
						<object id="gr_main" classid="<%=LGauceId.GRID %>" style="width:100%;height:300px;" class="comn">
							<param name="DataID"            value="ds_main"/> 
							<param name="Editable"          value="true"/>
							<param name="UsingOneClick"		value="1">
	 			            <param name="UrlImages"         value="<I>Type='PopupBotton', Url='/sys/images/button/cal_icon.gif', Fit='AutoFit', Flat='True'</I>">							
							<param name="Format"     value="
								<FC>id='chk'			Edit='true'       width='30'	  EditStyle=CheckBox	</FC>
	 							<FC>id='workCd'      name='<%=columnData.getString("work_location") %>'              width='100'  align='left' edit='true'       Data='ds_workLocation:code:name:code' editstyle='lookup' ListWidth=200    </FC>
								<FC>id='unitCate'   	name='<%=columnData.getString("unit") %>'               width='100' align='left' edit='true'    	Data='ds_unit:code:name:code' editstyle='lookup' ListWidth=200     </FC>
								<FC>id='type'   		name='<%=columnData.getString("type") %>'                   width='100' align='left'  edit='true'    </FC>
								<C>id='contract'     	name='<%=columnData.getString("contract_w_mge") %>'    width='110'  align='left' edit='true'   Data='ds_contract:code:name:code' editstyle='lookup' ListWidth=120       </C>
								<C>id='owner'  		name='<%=columnData.getString("unit_owner") %>'    		width='90'  align='left' edit='true'    Data='ds_contract:code:name:code' editstyle='lookup' ListWidth=120      </C>
								<C>id='condition'  	name='<%=columnData.getString("condition") %>'    			width='100'  align='left' edit='true'       Data='ds_condition:code:name:code' editstyle='lookup' ListWidth=120        </C>							
								<C>id='purpose'      	name='<%=columnData.getString("purpose") %>'        		width='100'  align='left' edit='true'   </C>							
								<C>id='rentPrice'      name='<%=columnData.getString("rental_price") %>'   		width='100'  align='right' edit='true'  dec='2' </C>							
								<C>id='currCd'      	name='<%=columnData.getString("currency") %>'        		width='80'  align='center' edit='true'   Data='ds_currency:code' editstyle='lookup' ListWidth=60     </C>							
								<C>id='measure'      name='<%=columnData.getString("measure") %>'        		width='80'  align='center' edit='true'  Data='ds_measure:code:name:code' editstyle='lookup' ListWidth=120      </C>							
								<G> name='<%=columnData.getString("contract_period") %>'
									<C>id='fromDate'    name='<%=columnData.getString("from") %>'    width='90'  align='center'  edit='true'  EditStyle='popUpFix' mask='XXXX/XX/XX'</C>												
									<C>id='toDate'  	  name='<%=columnData.getString("to") %>'       width='90'  align='center'  edit='true'  EditStyle='popUpFix' mask='XXXX/XX/XX'   </C>												
								</G>
								<C>id='minCharge'      name='<%=columnData.getString("min_charge") %>'        width='100'  align='left' edit='true'   Data='ds_minCharge:code:name:code' editstyle='lookup' ListWidth=160     </C>							
								<C>id='minChargeHr'   name='<%=columnData.getString("min_charge_hr") %>'     width='80'  align='right' edit='true'  decao='2' </C>							
								<C>id='remark'      	  name='<%=columnData.getString("remark") %>'        width='100'  align='left' edit='true'   </C>							
								<C>id='useYn'      	  name='<%=columnData.getString("useyn") %>'        width='60'  align='center' edit='true'  Data='ds_yn:code:name:code' editstyle='lookup' </C>							
								<C>id='companyCd'    show='false'   </C>	
								<C>id='typeSeq'      	  show='false'     </C>
								<C>id='bfType'      	  show='false'     </C>
							"/>
						</object>
						</comment><script>__WS__(__NSID__);</script>
					</td>
				</tr>
			</table>
		</div>

    	 <!-- 버튼 S -->	
          <div id="btn_area">
            <p class="b_right">
				<span class="btn_r">
               <input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="New" onclick="f_mainNew()"/></span>
				<span class="btn_r">
				<input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="Save" onclick="f_mainSave()"/></span> 
			</p>
        </div>
<!-- 버튼 E --> 
</div>
<input type="hidden" id="h_date"/> 

</body>
</html>

