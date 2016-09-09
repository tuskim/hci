<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html xmlns="http://www.w3.org/1999/xhtml">
<%--
/*
 *************************************************************************
 * @source  : customerCreditList.jsp
 * @desc    : customer credit list from SAP SD
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2015.11.04   JwHan       PAM 여신 한도 관리 C20151030_07129
 * ---  -----------  ----------  -----------------------------------------
 * PT-PAM system
 * Copyright(c) 2006-2015 LG CNS,  All rights reserved.
 *************************************************************************
 */
--%>
<%@ page import="java.util.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="devon.core.util.*"%>
<%@ page import="comm.util.*"%>
<%@ include file="/include/head.jsp"%>

<%
	String currentDate = LDateUtils.getDate("yyyy/MM/dd");                        // currentDate
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title>PT PAM System</title>
<head>
<script language="javascript">



/***************************************************************************************************/
/*Customer List
/***************************************************************************************************/
function onLoad(){
		
	//costomer
	ds_customer.DataID ="sd.sm.retrieveComboSalesCompanyList.gau"; 
	ds_customer.Reset();
}



/***************************************************************************************************/
/*Retrieve customer Credit Limit List        														   */
/***************************************************************************************************/
function f_retrieve(){
	ds_main.ClearAll();
	
	ds_main.DataID  = "/retrieveCustomerCreditList.gau?";
    ds_main.DataID += "companyCd=" 		   +"<%= g_companyCd %>";
    ds_main.DataID += "&customerCd=" 		   + ds_customer.NameValue(ds_customer.RowPosition,"code");
 	ds_main.DataID += "&lang="			   +"<%=g_lang%>";	
	ds_main.Reset();
	g_flug = false;
}


function f_excel() {
	gf_excel2(ds_main, gr_main,"<%= currentDate %>" ,"Customer Credit List","c:\\");
}

</script>

<!-----------------------------------------------------------------------------
  íë¡ê·¸ë¨ ì ì© D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- Grid ì© DataSet-->
<object id="ds_main" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad" value="true">
	<param name="ViewDeletedRow" value="false">
</object>

<!-- Grid ì© DataSet-->
<object id="ds_detail" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad" value="true">
	<param name="ViewDeletedRow" value="false">
</object>

<object id="ds_status" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad" value="true">
</object>
</comment>

<!-- lx Combo ì© DataSet-->
<object id="ds_currCd" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad" value="true">
</object>

<!-- lx Combo ì© DataSet-->
<object id="ds_storCd" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad" value="true">
</object>

<object id="ds_vatCd" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad" value="true">
</object>

<!-- lx Combo ì© DataSet-->
<object id="ds_payTerm" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad" value="true">
</object>

<!-- CUD TR -->
<OBJECT id=tr_cudMaster classid="<%=LGauceId.TR%>">
	<param name="KeyName" value="toinb_dataid4">
</OBJECT>
<!-- Delete TR -->
<OBJECT id=tr_dMaster classid="<%=LGauceId.TR%>">
	<param name="KeyName" value="toinb_dataid4">
</OBJECT>

<!-- sap send TR -->
<OBJECT id=tr_sendMaster classid="<%=LGauceId.TR%>">
	<param name="KeyName" value="toinb_dataid4">
</OBJECT>

<!-- sap send TR -->
<OBJECT id=tr_sapCandMaster classid="<%=LGauceId.TR%>">
	<param name="KeyName" value="toinb_dataid4">
</OBJECT>

<!-- costomer Combo ì© DataSet-->
<object id="ds_customer" classid="<%=LGauceId.DATASET%>" >
  	<param name="SyncLoad"          value="true">
</object> 

<!-----------------------------------------------------------------------------
		   íë¡ê·¸ë¨ ì ì© G A U C E   C O M P O N E N T' S   E V E N T S
------------------------------------------------------------------------------>
<!-- INSERT/UPDATE Tr ì í¸ë ì ì ì¤í ì -->
<script language=JavaScript for=tr_cudMaster event=OnFail()>
    mode = "";
    if(tr_cudMaster.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
        window.parent.location.href = "/index.jsp";    
    }
    if(tr_cudMaster.ErrorMsg.lastIndexOf("]") != -1) {
      var msgs= tr_cudMaster.ErrorMsg.substring(tr_cudMaster.ErrorMsg.lastIndexOf("]")+2,tr_cudMaster.ErrorMsg.length);
      alert(msgs);
      }  
</script>

<!-- SAP SEND Tr ì í¸ë ì ì ì¤í ì -->
<script language=JavaScript for=tr_sendMaster event=OnFail()>
	    mode = "";
	    if(tr_sendMaster.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
	        window.parent.location.href = "/index.jsp";    
	    }
	    if(tr_sendMaster.ErrorMsg.lastIndexOf("]") != -1) {
      var msgs= tr_sendMaster.ErrorMsg.substring(tr_sendMaster.ErrorMsg.lastIndexOf("]")+2,tr_sendMaster.ErrorMsg.length);
      alert(msgs);
      } 
     f_retrieve();
</script>
<script language=JavaScript for=tr_sendMaster event=OnSuccess()>	
		f_retrieve();
		alert("<%=source.getMessage("dev.suc.com.sapSend")%>" );		
	    
</script>

<!-- SAP Cancle Tr ì í¸ë ì ì ì¤í ì -->
<script language=JavaScript for=tr_sapCandMaster event=OnFail()>
	    mode = "";
	    if(tr_sapCandMaster.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
	        window.parent.location.href = "/index.jsp";    
	    }
	    alert(tr_sapCandMaster.ErrorMsg);
     f_retrieve();
</script>
<script language=JavaScript for=tr_sapCandMaster event=OnSuccess()>	
        f_retrieve();
		alert("<%=source.getMessage("dev.suc.com.sapCancel")%>" );		
</script>

<script language=JavaScript for=tr_cudMaster event=OnSuccess()>	
     f_retrieve();
     ds_main.RowPosition = g_msPos;
     ds_detail.RowPosition= g_ddtPos;		
	 alert("<%=source.getMessage("dev.suc.com.save")%>" );		
</script>

<!-- DELETE Tr ì í¸ë ì ì ì¤í ì -->
<script language=JavaScript for=tr_dMaster event=OnFail()>
    mode = "";
    if(tr_dMaster.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
        window.parent.location.href = "/index.jsp";    
    }
    alert(tr_dMaster.ErrorMsg);
</script>
<script language=JavaScript for=tr_dMaster event=OnSuccess()>	       
     f_retrieve();
     if(ds_main.CountRow >0){ 
        ds_main.RowPosition = 1;
        ds_detail.RowPosition= 1;	
     }	
	alert("<%=source.getMessage("dev.suc.com.delete")%>" );
</script>

<!--grid DataSet -->
<script language=JavaScript for=ds_main event=OnLoadCompleted(rowCnt)>
	  cfHideDSWaitMsg(gr_main);//progress bar ì¨ê¸°ê¸°
	  cfFillGridNoDataMsg(gr_main,"gridColLineCnt=2");//no data found   
	  mode = "";
</script>
<script language=JavaScript for=ds_main event=OnLoadStarted()>
	  cfShowDSWaitMsg(gr_main);//progress bar ë³´ì´ê¸°
	  cfHideNoDataMsg(gr_main);//no data ë©ìì§ ì¨ê¸°ê¸°
	  mode = "";
</script>

<script language=JavaScript for="ds_main" event=OnRowPosChanged(row)>
 	var salesNo = ds_main.NameValue(row,"salesNo");
	if(row>0 && salesNo != "" ){
		ds_detail.DataID     = "/sd.sm.retrieveProdCPODetailSalesMgnt.gau?";
		ds_detail.DataID    += "salesDate="+funcReplaceStrAll(ds_main.NameValue(row,"salesDate"),"/","");
		ds_detail.DataID    += "&salesNo="+salesNo;
		ds_detail.DataID    += "&lang= "+"<%=g_lang%>";
		ds_detail.Reset();
		grandTotalQty.Text = ds_main.NameValue(ds_main.RowPosition,"grandTotalQty");
		grandTotalAmt.Text = ds_main.NameValue(ds_main.RowPosition,"grandTotalAmt");
		termsOfPayment.Enable = false;
		gr_detail.ColumnProp("salesQty", "Edit") = "none";
		gr_detail.ColumnProp("unitPrice", "Edit") = "none";
		gr_detail.ColumnProp("salesAmt", "Edit") = "none";
		
		
		
	}else if(row>0 && salesNo == "" ){
		ds_detail.ClearAll();
		f_addRowDetail();
		grandTotalQty.Text = 0;
		grandTotalAmt.Text = 0;
		termsOfPayment.Enable = true;
		gr_detail.ColumnProp("salesAmt", "Edit") = true;
		gr_detail.ColumnProp("unitPrice", "Edit") = true;
		gr_detail.ColumnProp("salesQty", "Edit") = true;

	}
	g_flug = false;
</script>

<script language=JavaScript for=ds_main event=CanRowPosChange(row)> 
	if(ds_detail.IsUpdated){
		if(!g_flug){	
			alert("<%=source.getMessage("dev.warn.com.continue")%>");
			return false;
		}
	}				
</script>

<!-----------------------------------------------------------------------------
  ì ì²´ ì²´í¬ë°ì¤ ì í/í´ì 
------------------------------------------------------------------------------>
<script language=JavaScript for=gr_main event=OnHeadCheckClick(Col,Colid,bCheck)>
	if(bCheck == "0"){//uncheck
		for(var i=1; i <= ds_main.countRow; i++){
			ds_main.Namevalue(i,"chk") = "F";
			ds_main.resetStatus();
		}
	}else{//check
		for(var i=1; i <= ds_main.countRow; i++){
			ds_main.NameValue(i,"chk") = "T";	
		}
	}
</script>	



</head>
	<body id="cent_bg" onload="onLoad()">
		<div id="conts_box">
		<h2><span> <%=columnData.getString("page_title")%> </span></h2>
		
		<!--   Searching Condition  start -->
		<fieldset class="boardSearch">
		<div>
		<dl>
			<dt>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"	class="output_board2" >
				<colgroup>
					<col width="14%"/>
					<col width="20%"/>
					<col width="15%"/>
					<col width="38%"/>
					<col width="11%"/>
					<col width="20%"/>
				</colgroup>
					<tr>
						<th><%=columnData.getString("customer") %></th>
						<td><object id="lc_customer"  classid="<%=LGauceId.LUXECOMBO%>" width="100">
						<param name="ComboDataID"       value="ds_customer">
						<param name="ListCount"     	value="10">
						<param name=SearchColumn		value="name">
						<param name="BindColumn"    	value="code">
						<param name=ListExprFormat		value="name^0^210,code^0^70">
						<param name=index           	value=0>
						</object>
						</td>	
						
						
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
				</table>
			</dt>
			
				<dd class="btnseat1"> 
					<span class="search_btn_r search_btn_l">
					<input type="button" onfocus="blur();"  style="background-color:#213e74" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='#e2ebf7'" value="Search" onclick="f_retrieve();"/></span> 
				</dd>	
			
			
			</dl>
			
			
	
		</div>
		</fieldset>
		<!--  Searching condition end  -->


			<div class="sub_stitle">
			<p><%=columnData.getString("sub1_title")%></p>
			<p class="rightbtn"> 
		  	  <span class="excel_btn_r excel_btn_l">
		        <input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="<%=btnExcelDown %>" onclick="f_excel()"/>
		      </span>  
		    </p>
			</div>
			
			<!--==============================customer Credit List  Start =====================================-->
			<div>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td><comment id="__NSID__"> 
					<object id="gr_main" classid="<%=LGauceId.GRID %>" style="width:100%;height:350px" class="comn_status">
						<param name="DataID" value="ds_main">
						<param name="Editable" value="true">
						<param name="SortView" value="right">
						<param name="UrlImages" value="<I>Type='PopupBotton', Url='/sys/images/button/cal_icon.gif', Fit='AutoFit', Flat='True'</I>">
						<param name="UsingOneClick" value="1">
						<param name="Format"
							value="
						            	<C>id='customerCd' 		name='<%=columnData.getString("customerCode") %>' 		 width='120' align='center'   Edit='none' sort='true' </c>
						            	<C>id='customerNm' 		name='<%=columnData.getString("customerNm") %>' 		 width='200' align='left'   Edit='none' sort='true' </c>			            	
						            	<C>id='DATAB' 		name='Valid Date(From)' 		 width='120' align='center'   Edit='none' </c>			            	
						            	<C>id='DATBI' 		name='Valid Date(To)' 		 width='120' align='center'   Edit='none' </c>			            	
						            	<C>id='WAERS' 	name='Currency' 	width='70' align='center' Edit='none'  show='true'</c>
						            	<C>id='cl' 	name='Credit Limit' 	width='130' align='right' Edit='none'  show='true'</c>
						            	<C>id='SKFOR' 	name='A/R' 	width='130' align='right' Edit='none'  show='true'</c>
						            	<G>name='Open Sales'
						            	<C>id='OPEN_SALES_WEB' 	name='WEB' 	width='130' align='right' Edit='none'  show='true'</c>
						            	<C>id='OPEN_SALES' 	name='SAP' 	width='130' align='right' Edit='none'  show='true'</c>
						            	</G>
						            	<C>id='SSOBL' 	name='Advance Received' 	width='130' align='right' Edit='none'  show='true'</c>
						            	<C>id='clExposure' 	name='Credit Exposure' 	 	 	width='130' align='right' Edit='none' </c>
						            	<C>id='clAvailable' 	name='Credit Balance' 	 	 	width='130' align='right' Edit='none' </c>
						            	
								  " />
					</object> </comment> <script>__WS__(__NSID__);</script></td>
				</tr>
			</table>
			</div>
			
			<!-- ============== customer Credit List end ============= -->


		</div>
	</body>
</html>