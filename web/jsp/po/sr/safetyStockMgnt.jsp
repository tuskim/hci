<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--
/*
 *************************************************************************
 * @source  : safetyStockMgnt.jsp
 * @desc    : MAin Page
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

<script type="text/javascript">
var g_msPos =0; // save후  focus 제정의 Row
var msg="";
function init(){
	ds_storage.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2005";
	ds_storage.Reset();
	ds_mater.DataId="po.oc.retrievePurchOrderRegMaterCombo.gau";
	ds_mater.Reset();
	ds_gmater.DataId="po.oc.retrievePurchOrderRegMaterCombo.gau";
	ds_gmater.Reset();		
	ds_main.DataId = "po.sr.retrieveSafetyStockMgnt.gau?storageCd=&materCd="	;
	ds_main.Reset();
}
//-------------------------------------------------------------------------
// inqury
//-------------------------------------------------------------------------
function f_retrieve(){ 
	ds_main.DataId = "po.sr.retrieveSafetyStockMgnt.gau?storageCd="+ds_storage.NameValue(ds_storage.RowPosition,"code")+"&materCd="+ds_mater.NameValue(ds_mater.RowPosition,"materCd")	;
	ds_main.Reset();
}

function f_setData(){
}
//-------------------------------------------------------------------------
// Save
//-------------------------------------------------------------------------
function f_save()
{

	if(!ds_main.IsUpdated) {
		alert("<%=source.getMessage("dev.inf.com.nosave")%>");
		return;
	}
	
	
	for(var i=1;i<=ds_main.CountRow;i++){
		if(Number(ds_main.NameValue(i,"stockQty")) < 0){
			ds_main.RowPosition =i;
			gr_main.SetColumn("stockQty");		
			alert("<%=source.getMessage("dev.warn.com.minus",columnData.getString("stock_qty"))%>");
			return ;
		}			
		if(ds_main.NameValue(i,"storageCd")==""){
			ds_main.RowPosition=i;
			gr_main.SetColumn("storageCd");
			return;
		}
		if(ds_main.NameValue(i,"materCd")==""){
			ds_main.RowPosition=i;
			gr_main.SetColumn("materCd");
			alert("<%=source.getMessage("dev.warn.com.select",columnData.getString("mater_cd"))%>");
			return;
		}		
 		/*
		if(ds_main.RowStatus(i) == "1")	{
			ds_dup.DataID  = "/po.sr.retrieveSafetyStockMgntDup.gau?";
		    ds_dup.DataID += "storageCd=" + ds_main.NameValue( i , "storageCd" );
		    ds_dup.DataID += "&materCd=" + ds_main.NameValue( i , "materCd" );
			ds_dup.Reset();	 
			if(ds_dup.NameValue(1,"CNT") > 0)
			{
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
				if(v_chk>1)
				{
					ds_main.RowPosition = j;
					gr_main.SetColumn("materCd");
					alert("<%=source.getMessage("dev.warn.com.dup",columnData.getString("mater_cd"))%>");
					return;
				}
			}			
		}
	}

	//변경한 데이터가 있는지 체크한다.
	if(confirm("<%=source.getMessage("dev.cfm.com.save")%>")){ 
		f_setCondition();
		msg ="<%=source.getMessage("dev.suc.com.save")%>";	 
		tr_cudMaster.post();
	}
}
//-------------------------------------------------------------------------
// AddRow
//-------------------------------------------------------------------------
function f_addRow(){
	if(ds_main.CountRow<1){
		 /*var strHeader = "chk"     + ":STRING(50)"
		                 + ",companyCd"  + ":STRING(50)"
		                 + ",storageCd"  + ":STRING(50)"
		                 + ",storageNm"  + ":STRING(50)"
		                 + ",materCd"  + ":STRING(50)"
		                 + ",materNm"  + ":STRING(50)"
		                 + ",unit"   + ":STRING(50)"
		                 + ",deptCd"     + ":STRING(50)"
		                 + ",deptNm"      + ":STRING(50)"
		                 + ",stockQty"     + ":DECIMAL(10.2)"
		                 + ",regid"    + ":STRING(50)";
		                 + ",regdate"    + ":STRING(50)";
		                 + ",regtime"    + ":STRING(50)";
		                 + ",modid"    + ":STRING(50)";
		                 + ",moddate"    + ":STRING(50)";
		                 + ",modtime"    + ":STRING(50)";
		ds_main.SetDataHeader(strHeader); */
	  	cfHideNoDataMsg(gr_main);//no data 메시지 숨기기		
	}
	ds_main.AddRow();
	ds_main.NameValue(ds_main.RowPosition,"storageCd")= ds_storage.NameValue(ds_storage.RowPosition,"code");
 
 
}
//-------------------------------------------------------------------------
// Delete
//-------------------------------------------------------------------------
function f_delRow(){
	if(ds_main.CountRow<1){
		alert("<%=source.getMessage("dev.inf.com.nodelete")%>");
	}
				
	if(confirm("<%=source.getMessage("dev.cfm.com.delete")%>")){
		if(ds_main.SysStatus(ds_main.RowPosition) =="1"){	
			ds_main.DeleteRow(ds_main.RowPosition);	 	 
		}else{
			var v_url = new cfURI(); 
			v_url.Add("storageCd",ds_main.NameValue(ds_main.RowPosition,"storageCd"));     
			v_url.Add("materCd",ds_main.NameValue(ds_main.RowPosition,"materCd"));  
			v_url.SetPage("po.sr.cudSafetyStockMgntDel.gau");
			ds_main.DeleteRow(ds_main.RowPosition);
			ds_delete.DataId = v_url.GetURI(); 
			ds_delete.Reset();		
		}		   
        msg   = "<%=source.getMessage("dev.suc.com.delete")%>";	 	
		alert(msg);
	}
}
 
//-------------------------------------------------------------------------
// FastSearch
//-------------------------------------------------------------------------
function On_Apply() { 
    lc_mater.ShowSearchCol();
         
}
//-------------------------------------------------------------------------
//Excel Download
//-------------------------------------------------------------------------			
function f_excel() {
	
	gf_excel(ds_main,gr_main,"<%=columnData.getString("page_title") %>","c\\");
}

function f_setCondition(){
    g_msPos = ds_main.RowPosition; 	 
	g_con1Pos=ds_storage.NameValueRow("code",ds_main.NameValue(ds_main.RowPosition,"storageCd"));
	g_con2Pos=ds_mater.NameValueRow("materCd",ds_main.NameValue(ds_main.RowPosition,"materCd"));   
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
<!-- lx Combo 용 DataSet-->
<object id="ds_storage" classid="<%=LGauceId.DATASET%>" >
  	<param name="SyncLoad"          value="true"> 
</object>
<!-- Grid lookup 용 DataSet-->
<object id="ds_lcstorage" classid="<%=LGauceId.DATASET%>" >
  	<param name="SyncLoad"          value="true">
	<param name="DataID"            value="cm.cm.retrieveCommCodeCombo.gau?groupCd=2005">
</object>
<!-- lx Combo 용 DataSet-->
<object id="ds_mater" classid="<%=LGauceId.DATASET%>" >
  	<param name="SyncLoad"          value="true"> 
</object>  
<!-- lx Combo 용 DataSet-->
<object id="ds_gmater" classid="<%=LGauceId.DATASET%>" >
  	<param name="SyncLoad"          value="true"> 
</object> 
<!-- 중복 체크 용 DataSet-->
<object id="ds_dup" classid="<%=LGauceId.DATASET%>" >
  	<param name="SyncLoad"          value="true">
</object>
<!-- 중복 체크 용 DataSet-->
<object id="ds_delete" classid="<%=LGauceId.DATASET%>" >
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
		ds_storage.RowPosition= g_con1Pos;
		//ds_mater.RowPosition= g_con2Pos; 	
		f_retrieve();
	    ds_main.RowPosition    = g_msPos; 	
		alert(msg);
</script>

<script language=JavaScript for=ds_storage event=OnLoadCompleted(rowCnt)>
    
</script>

<script language=JavaScript for=gr_main event=OnPopup(row,colid,data)>
 	if ( colid == "materCd") {
		openMaterialCodeListGridWin(row, ds_main);
		
	}
</script>

<script language=JavaScript for=ds_mater event=OnLoadCompleted(rowCnt)>
	cfUnionBlank(ds_mater,lc_mater,"materCd","materNm");
</script>
 

<script language=JavaScript for= lc_mater event=OnKeyDown(kcode)>
    if(kcode != 8 && kcode != 13 && kcode != 27 && kcode != 33 && kcode != 34 && kcode != 35 &&
        kcode != 36 && kcode != 37 && kcode != 38 && kcode != 39 && kcode != 40 && kcode != 45 &&
        kcode != 46 && kcode != "undefined") {	
    		setTimeout("On_Apply()", 1000);
   		}
</script>
<script language=JavaScript for=gr_main event=CanColumnPosChange(row,colid)>
		if(colid=="stockQty"){
			if(Number(ds_main.NameValue(row,colid)) < 0){
				alert("<%=source.getMessage("dev.warn.com.minus",columnData.getString("stock_qty"))%>");
				return false;
			}
		}
		
</script>
 
<script language=JavaScript for=gr_main event=OnCloseUp(row,colid)>
	if(colid=="materCd"){
		var arow =ds_gmater.NameValueRow("materCd",ds_main.NameValue(row,"materCd"));
		ds_main.NameValue(row,"unit") = ds_gmater.NameValue(arow,"unit");
		ds_main.NameValue(row,"materNm") = ds_gmater.NameValue(arow,"materNm");
	} 	
</script>
</head>

<body id="cent_bg" onload="init();">
<div id="conts_box">
	<h2> 
		<span> <%=columnData.getString("page_title") %> 
		</span>
	</h2>
	<!--검색 S -->	
	<fieldset class="boardSearch"> 
		<div>
			<dl>
				<dt> 
					<table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board2" >
						<colgroup>
							<col width="20%"/>
							<col width="25%"/>
							<col width="17%"/> 
							<col width=""/>
						</colgroup>
						<tr> 								
							<th><%=columnData.getString("storage_nm") %> </th>
							<td><comment id="__NSID__"><object id="lc_storag"  classid="<%=LGauceId.LUXECOMBO%>" width="150">
								<param name="ComboDataID"       value="ds_storage">
								<param name="ListCount"     	value="10">
								<param name=SearchColumn		value="name">
								<param name="BindColumn"    	value="code">
								<param name=ListExprFormat		value="name^0^90,code^0^70">
								<param name=index           	value=0>
								</object></comment><script>__WS__(__NSID__); </script>
							</td>			
							<th><%=columnData.getString("mater_nm") %> </th>
							<td><comment id="__NSID__"><object id="lc_mater"  classid="<%=LGauceId.LUXECOMBO%>" width="150">
								<param name="ComboDataID"       value="ds_mater">
								<param name="ListCount"     	value="10">
								<param name=SearchColumn		value="materNm">
								<param name="BindColumn"    	value="materCd">
								<param name=ListExprFormat		value="materNm^0^90,materCd^0^70">
								<param name=index           	value=0>
								<param name=ComboStyle  value="2">											    
								<param name=WantSelChgEvent	value=true>	
								</object></comment><script>__WS__(__NSID__); </script>
							</td>		
						</tr>
					</table>
				</dt>              		  	   	 	
				<dd class="btnseat1"> 
					<span class="search_btn_r search_btn_l">
						<input type="button" onfocus="blur();" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='#e2ebf7'" value="<%=btnSearch%>" onclick="f_retrieve();"/>
					</span> 
				</dd>											
			</dl>
		</div>
	</fieldset>
	<!--검색 E -->
	<div class="sub_stitle"> 
		<p> <%=columnData.getString("sub1_title") %>  </p> 
		<p class="rightbtn"> 
			<span class="excel_btn_r excel_btn_l">
				<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="<%=btnExcelDown %>" onclick="f_excel()"/>
			</span> 
		</p>	
	</div>     		
	<!-- 그리드 S -->	
	<div>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
					<comment id="__NSID__">
						<object id="gr_main" classid="<%=LGauceId.GRID %>" class="comn" style="width:100%;height:330px;">
							<param name="DataID"            value="ds_main"/> 
							<Param name="SortView"          value=right>
							<param name="Editable"          value=True>
							<param name="UsingOneClick"     value=1> 
							<param name="UrlImages"         value="<I>Type='PopupBotton', Url='/sys/images/button/search_icon_2.gif', Fit='AutoFit', Flat='True'</I>">
							<param name="Format"              value="
<C>id='storageCd'     name='<%=columnData.getString("storage_nm") %>'     width='150' align='left'    edit={IF(CHK=0,'false','true')}  Data='ds_lcstorage:code:name:code'  EditStyle=Lookup    </C>
<C>id='materCd'       name='<%=columnData.getString("mater_cd") %>'       width='150' align='center'  edit={IF(CHK=0,'false','true')}  Data='ds_gmater:materCd:materCd:materNm:unit' ListWidth=360 editstyle='lookup'  </C>
<C>id='materNm'       name='<%=columnData.getString("mater_nm") %>'       width='167' align='left'    edit='none'                                                                              </C>
<C>id='unit'          name='<%=columnData.getString("unit") %>'           width='100' align='center'  edit='none'                                                                              </C>
<C>id='stockQty'      name='<%=columnData.getString("stock_qty") %>'      width='160' align='right'   Decao=2                                           </C>"/>
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
				<input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnNew%>" onclick="f_addRow();"/></span>
			<span class="btn_r btn_l">
				<input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnDel%>" onclick="f_delRow();"/></span>
			<span class="btn_r btn_l">
				<input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnSave%>" onclick="f_save();"/></span>
		</p>
	</div>
	<!-- 버튼 E -->  
</div>
</body>
</html>

