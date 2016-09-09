<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--
/*
*************************************************************************
* @source  : preView.jsp
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
<script language="javascript">

function init(){ 
 	// 그리드
    var strSubTot=0; 
    var strVat=0;    
	for(var i=1;i<=opener.ds_detail.CountRow; i++){
		strSubTot=+Number(opener.ds_detail.NameValue(i,"qty"))*Number(opener.ds_detail.NameValue(i,"price"));	 
		
		if(opener.ds_detail.NameValue(i,"vatCd")=="V1"){
			strVat+=(Number(strSubTot)/100)*10;
		}else if(opener.ds_detail.NameValue(i,"vatCd")=="V0"){
			strVat+=(Number(strSubTot)/100)*0;
		}
				
		oRow = document.createElement('tr'); 
		oCel0 = document.createElement('td');
		oCel1 = document.createElement('td');
		oCel2 = document.createElement('td');
		oCel3 = document.createElement('td');
		oCel4 = document.createElement('td');
		oCel5 = document.createElement('td');     
		oCel6 = document.createElement('td'); 		   
		oRow.style.textAlign='center';
		oCel1.className ="al";
		oCel3.className ="ar";
		oCel4.className ="al";
		oCel5.className ="ar";
		oCel6.className ="ar"; 
		oRow.appendChild(oCel0);
		oRow.appendChild(oCel1);
		oRow.appendChild(oCel2);
		oRow.appendChild(oCel3);
		oRow.appendChild(oCel4);
		oRow.appendChild(oCel5); 
		oRow.appendChild(oCel6); 
		oCel0.innerHTML=opener.ds_detail.NameValue(i,"poSeq");
		oCel1.innerHTML=opener.ds_detail.NameValue(i,"materNm")+" - "+opener.ds_detail.NameValue(i,"poDesc");
		oCel2.innerHTML=opener.ds_detail.NameValue(i,"unit");
		oCel3.innerHTML=opener.ds_detail.NameValue(i,"qty");
		oCel4.innerHTML=opener.ds_detail.NameValue(i,"vatNm");
		oCel5.innerHTML=opener.ds_detail.NameValue(i,"price");
		oCel6.innerHTML=funcRound(Number(opener.ds_detail.NameValue(i,"qty"))*Number(opener.ds_detail.NameValue(i,"price")),3);
		document.getElementById('tbGrid').children(i).appendChild(oRow);	
	} 	 

	
	td_sub.innerText=funcRound(strSubTot,3);
	td_dis.innerText=opener.ds_main.NameValue(opener.ds_main.RowPosition,"discountAmt");
	td_Tot.innerText=funcRound(Number(strSubTot)-Number(opener.ds_main.NameValue(opener.ds_main.RowPosition,"discountAmt")),3);
	td_vat.innerText = funcRound(Number(strVat),3);
	td_gTot.innerText=funcRound(Number(strSubTot)-Number(opener.ds_main.NameValue(opener.ds_main.RowPosition,"discountAmt"))+Number(strVat),3);
	//상위 주소
	addr1.innerText = opener.ds_main.NameValue(opener.ds_main.RowPosition,"addr1");
	addr2.innerText = opener.ds_main.NameValue(opener.ds_main.RowPosition,"addr2");
	addr3.innerText = opener.ds_main.NameValue(opener.ds_main.RowPosition,"addr3");
	addr4.innerText = opener.ds_main.NameValue(opener.ds_main.RowPosition,"addr4");
	addr5.innerText = opener.ds_main.NameValue(opener.ds_main.RowPosition,"addr5");
	addr6.innerText = opener.ds_main.NameValue(opener.ds_main.RowPosition,"addr6");
	
	purDept1.innerText = opener.ds_main.NameValue(opener.ds_main.RowPosition,"purDept1");
	purDept2.innerText = opener.ds_main.NameValue(opener.ds_main.RowPosition,"purDept2");
	purDept3.innerText = opener.ds_main.NameValue(opener.ds_main.RowPosition,"purDept3");
	purDept4.innerText = opener.ds_main.NameValue(opener.ds_main.RowPosition,"purDept4");
	purDept5.innerText = opener.ds_main.NameValue(opener.ds_main.RowPosition,"purDept5");
	purDept6.innerText = opener.ds_main.NameValue(opener.ds_main.RowPosition,"purDept6");
	
	poNo.innerText = opener.ds_main.NameValue(opener.ds_main.RowPosition,"poNo");	
	vendNm.innerText = opener.ds_main.NameValue(opener.ds_main.RowPosition,"vendNm");		
	insertSDate.innerText = opener.ds_main.NameValue(opener.ds_main.RowPosition,"insertSDate");	
	deliSDate.innerText = opener.ds_main.NameValue(opener.ds_main.RowPosition,"deliSDate");
	sform.deliLoctNm.value = opener.ds_main.NameValue(opener.ds_main.RowPosition,"deliLoctNm");	
	sform.loctAddr.value = opener.ds_main.NameValue(opener.ds_main.RowPosition,"loctAddr");
	payTermNm.innerText = opener.ds_main.NameValue(opener.ds_main.RowPosition,"payTermNm");	
	CurrencyNm.innerText = opener.ds_main.NameValue(opener.ds_main.RowPosition,"CurrencyNm");
	
	var t=0; 
	var y=0;
	var x=0;	
	for(var j=1; j<=opener.ds_approval.CountRow;j++){
		if(opener.ds_approval.NameValue(j,"chk")=="T"){
			t++;
			if(t>1){
				User.innerText += ",  "; 
			} 
			User.innerText += opener.ds_approval.NameValue(j,"vendPerson");	
			if(opener.ds_approval.NameValue(j,"mainYn")=="T"){
				y++;
				if(y>1){ 
					sform.mainMail.value += ",";
				} 
				sform.mainMail.value +=opener.ds_approval.NameValue(j,"emailAddr");	
			}else{
				x++;
				if(x>1){ 
					sform.refMail.value += ",";
				}				 
				sform.refMail.value +=opener.ds_approval.NameValue(j,"emailAddr");	 
			}  
		}
	}		 
}

function f_print(){
	window.print();
}

function f_send(){
	sform.method = "post";
	sform.mailbody.value = sform.innerHTML;	
	sform.poNo.value     = opener.ds_main.NameValue(opener.ds_main.RowPosition,"poNo");
	sform.action         = "email.sendEmailMgnt.dev";
	sform.submit();
}
</script>
</head>

<body onload="init()">
<form name="sform">
<div id="orderwrap" >
	<div id="headtxt">
		<h2>PT.MEGA GLOBAL ORDER  </h2>
			<div class="h_left">
				<p id=addr1></p>
				<p id=addr2></p>
				<p id=addr3></p>
				<p id=addr4></p>
				<p id=addr5></p>
				<p id=addr6></p>
			</div>			
			<div class="h_right">
				<p id=purDept1 ></p>
				<p id=purDept2 ></p>
				<p id=purDept3 ></p>
				<p id=purDept4 ></p>
				<p id=purDept5 ></p>
				<p id=purDept6 ></p>				
			</div>
		</div>
		<div class="divideline"></div>
		
	<h1> PURCHASE ORDER<br/> <p id="poNo"> </p> </h1>
		<!-- S -->
	 	 <div id="searchbox_area">
	  		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board2">
	  				<colgroup>
	  						<col width="15%"/>
							<col width="2%"/>
	  						<col width=""/>
  						</colgroup>
					<tr>
						<th>Vendor</th>
						<td> <span class="fs11">:</span></td>
						<td id=vendNm></td>
					</tr>
					<tr>
						<th>User</th>
						<td> <span class="fs11">:</span></td>
						<td id=User></td>
					</tr>					
					<tr>
						<th>P/O Date</th>
						<td> <span class="fs11">:</span></td>
						<td id=insertSDate></td>
					</tr>
					<tr>
						<th>Delivery Date</th>
						<td> <span class="fs11">:</span></td>
						<td id=deliSDate></td>
					</tr>
					<tr>
						<th>Delivery To</th>
						<td> <span class="fs11">:</span></td>
						<td><input type="text"  id="deliLoctNm"  value="" style="width:150px;" readonly/> ~ <input type="text"  id="loctAddr" value="" style="width:450px;" readonly/></td>
					</tr>
					<tr>
						<th>Term of Payment</th>
						<td> <span class="fs11">:</span></td>
						<td id="payTermNm"></td>
					</tr>
					<tr>
						<th>Currency</th>
						<td> <span class="fs11">:</span></td>
						<td id="CurrencyNm"></td>
					</tr>					
  			</table>
  		</div>
	  <!-- E -->		
		<div class="pad_t10"></div>
		

			
		<!-- 그리드 S -->	
       <div id="d_listexp">
          <table width="100%" border="0" cellpadding="0" cellspacing="0" class="o_list" id="tbGrid">
              <colgroup>
                        <col width="12%"/>
                        <col width=""/>
						<col width="10%"/>						
                        <col width="15%"/>
						<col width="15%"/>                            
                        <col width="10%"/>
						<col width="15%"/>                    
           	 </colgroup>
                   <thead>
                        <tr>
                            <th>No. </th>
                         	<th>Nama Barang</th>
                         	<th>Unit</th>
							<th>Qty.</th>
							<th>Vat</th>							
							<th>Price</th>
							<th class="sect_none">Amount </th>
                        </tr>
         		   	</thead> 
       	  	 </table>  
			 <table width="100%" border="0" cellpadding="0" cellspacing="0" class="o_list" >
				  <colgroup>
							<col width=""/>
							<col width="43%"/>
							<col width="18%"/>                    
				 </colgroup>
                   <tbody>
                   		<tr>
                   				<td rowspan="5">&nbsp;</td>
                   				<td class="al b b_line">Sub Total</td>
                   				<td class="ar b b_line" id="td_sub"> </td>
                   				</tr>
                   		<tr>
                   				<td class="al b b_line">Discount</td>
                   				<td class="ar b b_line" id="td_dis"> </td>
                   				</tr>
                   		<tr>
                   				<td class="al b b_line">Total</td>
                   				<td class="ar b b_line" id="td_Tot"> </td>
                   				</tr>
                   		<tr>
                   				<td class="al b b_line">Vat</td>
                   				<td class="ar b b_line" id="td_vat"></td>
                   				</tr>
                   		<tr>
                   				<td class="al b b_line">Grand Total</td>
                   				<td class="ar b b_line" id="td_gTot"></td>
                   	    </tr>
                   		</tbody>
       	  	 </table>   
        </div>
        <!-- 그리드 E -->
	<!-- 버튼 S -->	
	<div id="btn_area">
		<p class="b_right">
			<span class="btn_r btn_l">
			<input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#444'" value="Print" onclick="f_print()"/>
			</span> 
			<span class="btn_r btn_l">
			<input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#444'" value="Send" onclick="f_send()"/>
			</span> 			
		</p>
	</div>

</div>
<input type="hidden" name="mailbody"/>
<input type="hidden" name="mainMail"/>
<input type="hidden" name="refMail"/>
<input type="hidden" name="poNo"/>
</form>
</body>
</html>
