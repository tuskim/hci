<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--
/*
 *************************************************************************
 * @source  : stockList.jsp
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
 
function init(){ 
	ds_storage.DataId="cm.cm.retrieveCommCodeCombo.gau?groupCd=2005";
	ds_storage.Reset();
	ds_mater.DataId="po.oc.retrievePurchOrderRegMaterCombo.gau";
	ds_mater.Reset();	
}
//-------------------------------------------------------------------------
// inqury
//-------------------------------------------------------------------------
function f_retrieve(){ 
	ds_main.DataId = "po.sr.retrieveStockList.gau?storageCd="+ds_storage.NameValue(ds_storage.RowPosition,"code")+"&materCd="+ds_mater.NameValue(ds_mater.RowPosition,"materCd")	;
	ds_main.Reset();
}

function f_setData(){
}
//-------------------------------------------------------------------------
// Fast Search
//-------------------------------------------------------------------------
function On_Apply() { 
    lc_mater.ShowSearchCol();
         
}
//-------------------------------------------------------------------------
//Excel Download
//-------------------------------------------------------------------------
function f_excel() {
	
	gf_excel(ds_main,gr_main,"<%=columnData.getString("page_title") %>","c:\\");
}
</script>

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

<!-- lx Combo 용 DataSet-->
<object id="ds_mater" classid="<%=LGauceId.DATASET%>" >
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

</head>
<body id="cent_bg" onload="init();">
<div id="conts_box">	
	<h2><span><%=columnData.getString("page_title")%></span></h2>
	 <!--검색 S -->	
	 <fieldset class="boardSearch"> 
		<div>
			<dl>
				<dt> 
					<table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board2" >
						<colgroup>
							<col width="20%"/>
							<col width="25%"/>
							<col width="18%"/> 
							<col width=""/>
						</colgroup>
						<tr> 								
							<th><%=columnData.getString("storage_nm") %></th>
							<td><comment id="__NSID__"><object id="lc_storag"  classid="<%=LGauceId.LUXECOMBO%>" width="150">
								<param name="ComboDataID"       value="ds_storage">
								<param name="ListCount"     	value="10">
								<param name=SearchColumn		value="name">
								<param name="BindColumn"    	value="code">
								<param name=ListExprFormat		value="name^0^90,code^0^70">
								<param name=index           	value=0>
								<param name=WantSelChgEvent	value=true>	
								</object></comment><script>__WS__(__NSID__); </script></td>			
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
						<input type="button" onfocus="blur();" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='#e2ebf7'" value="<%=btnSearch %>" onclick="f_retrieve();"/>
					</span> 
				</dd>											
			</dl>
		</div>
	</fieldset>
	<!--검색 E -->
	<div class="sub_stitle"> 
		<p> <%=columnData.getString("sub1_title") %> </p>
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
							<param name="DataID"              value="ds_main"/>
							<param name="Format"              value="
<C>id='storageNm'     name='<%=columnData.getString("storage_nm") %>'  width='110' align='left'      </C>
<C>id='materCd'       name='<%=columnData.getString("mater_cd") %>'    width='110' align='center'    </C>
<C>id='materNm'       name='<%=columnData.getString("mater_nm") %>'    width='118' align='left'      </C>
<C>id='unit'          name='<%=columnData.getString("unit") %>'        width='80'  align='center'    </C>
<C>id='currentQty'    value={number(currentQty)}    name='<%=columnData.getString("current_qty") %>' width='100' align='right'      </C>			           
<C>id='stockQty'      value={number(stockQty)}      name='<%=columnData.getString("stock_qty") %>'   width='100' align='right'      </C>			           
<C>id='resultQty'     name='<%=columnData.getString("result_qty") %>'  width='110' align='right'   value={if(currentQty>stockQty,'▲ ' & DisplayFormat((currentQty-stockQty),'#,##0'),if(stockQty>currentQty,'▼ ' & DisplayFormat((currentQty-stockQty),'#,##0'),'■ ' & DisplayFormat((currentQty-stockQty),'#,##0')))} </C>"/>
						</object>
					</comment><script>__WS__(__NSID__);</script>
				</td>
			</tr>
		</table>
	</div>
	<!-- 그리드 E -->	
</div>
</body>
</html>

