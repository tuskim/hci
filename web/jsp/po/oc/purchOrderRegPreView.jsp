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


<title>PT-MPP System</title>

<%@ include file="/include/head.jsp" %>
<jsp:useBean id="resultData" class="devon.core.collection.LData" scope="request"/>

<%
	if(resultData != null) {
		String sMsg = resultData.getString("getMessage");
%>
	<script language="javascript">
		var sMsgValue = "<%=sMsg%>";
		
		if(sMsgValue != null && sMsgValue != "" && sMsgValue != 'null') alert(sMsgValue);
		
	</script>
<%
	}
%>
<script language="javascript">
var gubun = "<%=request.getParameter("gubun")%>" ? "<%=request.getParameter("gubun")%>" : "p";
function init(){ 
	if(gubun=="p"){
		p_send.style.display="none";	
		p_print.style.display="";
	}else{
		p_print.style.display="none";	
		p_send.style.display="";	
	}
 	// 그리드
    var strSubTot=0; 
    var strVat=0;    
	for(var i=1;i<=opener.ds_detail.CountRow; i++){
 
		strSubTot+=Number(opener.ds_detail.NameValue(i,"qty"))*Number(opener.ds_detail.NameValue(i,"price"));	 
		if(opener.ds_detail.NameValue(i,"vatCd")=="V1"){
			strVat+=(Number(opener.ds_detail.NameValue(i,"qty"))*Number(opener.ds_detail.NameValue(i,"price"))/100)*10;
		}else if(opener.ds_detail.NameValue(i,"vatCd")=="V0"){
			strVat+=(Number(opener.ds_detail.NameValue(i,"qty"))*Number(opener.ds_detail.NameValue(i,"price"))/100)*0;
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
		oCel3.innerHTML=setComma(opener.ds_detail.NameValue(i,"qty"));
		oCel4.innerHTML=opener.ds_detail.NameValue(i,"vatNm");
		oCel5.innerHTML=setComma(opener.ds_detail.NameValue(i,"price"));
		oCel6.innerHTML=setComma(funcRound(Number(opener.ds_detail.NameValue(i,"qty"))*Number(opener.ds_detail.NameValue(i,"price")),3));
		document.getElementById('tbGrid').children(1).appendChild(oRow);	
	} 	 

	
	td_sub.innerText =setComma(funcRound(strSubTot,3));
	td_dis.innerText =setComma(opener.ds_main.NameValue(opener.ds_main.RowPosition,"discountAmt"));
	td_Tot.innerText =setComma(funcRound(Number(strSubTot)-Number(opener.ds_main.NameValue(opener.ds_main.RowPosition,"discountAmt")),3));
	td_vat.innerText =setComma(funcRound(Number(strVat),3));
	td_gTot.innerText=setComma(funcRound(Number(strSubTot)-Number(opener.ds_main.NameValue(opener.ds_main.RowPosition,"discountAmt"))+Number(strVat),3));
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
	
	poNo.innerText = "(P/O No: "+opener.ds_main.NameValue(opener.ds_main.RowPosition,"poNo")+")";	
	vendNm.innerText = opener.ds_main.NameValue(opener.ds_main.RowPosition,"vendNm");		
	insertSDate.innerText = opener.ds_main.NameValue(opener.ds_main.RowPosition,"insertSDate");	
	deliSDate.innerText = opener.ds_main.NameValue(opener.ds_main.RowPosition,"deliSDate");
	deliLoctNm.innerText = opener.ds_main.NameValue(opener.ds_main.RowPosition,"deliLoctNm")+"  -  "+opener.ds_main.NameValue(opener.ds_main.RowPosition,"loctAddr");		
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
	p_print.style.display="none";	

	window.print();
	p_print.style.display="";	
}

function f_send(){
	sform.method = "post";
	sform.title.value = "PURCHASE ORDER - Po No : "+opener.ds_main.NameValue(opener.ds_main.RowPosition,"poNo");
	sform.mailbody.value = sform.innerHTML;	
	sform.poNo.value     = opener.ds_main.NameValue(opener.ds_main.RowPosition,"poNo");
	sform.action         = "po.oc.cudPurchOrderRegSendMail.dev"; 
	sform.submit();
}
</script>

</head>

<body onload="init()">
<form name="sform"  >
   <style>
 

body{height:100%;margin:0; padding:0; font-size:13px;font-weight:normal; color:#000000; line-height:150px; font-family: Tahoma;
	*word-break:break-all;-ms-word-break:break-all;;}

div,h1,h2,h3,h4,h5,h6,ul,ol,li,dl,dt,dd,form,fieldse,p{margin:0;padding:0;font-size:13px;line-height:16px;color:#000000;list-style:none;font-weight:normal;font-family:Tahoma;}

fieldset,dl,dd,dt,img,blockquote{border:0; vertical-align:middle;}
address,em{font-style:normal;}
hr,legend,caption{display:none;}
button,label{cursor:pointer;_cursor /**/:hand;}
table{ border-spacing:0; border-collapse:collapse; border:0;}
:root table{ border-spacing:0; border-collapse:separate; border:0;}
td,th {font-size:13px;line-height:18px;;color:#000000;font-weight:normal;font-family:Tahoma;}

img {border:0}
hr {display:none; clear:both}
.b	{font-weight:normal;!important;}
/* basic end */



/* search2 */
#searchbox_area {width:100%; border:solid 2px #000000; overflow:hidden; background-color:#f5f4f4;}

	table.output_board2 {width::100%;}
		table.output_board2 th {padding:2px 5px 4px 12px; text-align:left;letter-spacing:-0.5px; color:#000000; font-weight:lighter; font-size:13px; font-family:Tahoma;font-weight:normal;}
		table.output_board2 th.lineb { border-bottom:solid 2px #000000}
		table.output_board2 th.required {background-image: url(../images/button/required.gif);background-repeat:no-repeat;background-position: 0 9px; }	
		table.output_board2 th.b_none {background:none;}
		table.output_board2 td {padding-left:2px;}
		table.output_board2 td.lineb {border-bottom:solid 2px #000000}


/* order */
div#orderwrap{position:relative; width:800px;border:solid 2px #222; padding:5px 10px 5px 10px;}
	div#orderwrap h1{ font-size:32px; color:#000; padding:10px 0 10px 0; text-align:center; text-decoration:underline; line-height:30px; }
	div#orderwrap h1 p{font-size:12px; font-weight:lighter;text-decoration:none; }

	
		div#headtxt{ margin:0; padding:0;}
			div#headtxt h2{font-size:20px; color:#000000; padding:5px 0 10px 5px; }
			
			div#headtxt .h_left{ float:left;}
				div#headtxt .h_left p{ font-size:13px; color:#000000; line-height:14px; font-family:Tahoma;}
			div#headtxt .h_right{ float:right;}
				div#headtxt .h_right p{ font-size:13px; color:#000000; line-height:14px; font-family:Tahoma;}
		
	.divideline{ clear:both; padding-top:5px; border-bottom: solid 2px #000000;;}
	

	div#orderwrap div#d_listexp{ clear:both; width:100%; margin:0; padding:0; }
		table.o_list {width:100%; background-color:#e4e9f2; border: solid 1px #000000; border-top:solid 2px #000000; border-left:solid 2px #000000;border-right:solid 2px #000000;}
		table.o_list th {height:17px;text-align:center; padding:4px 0 4px 0; border-top:solid 2px #000000; border-bottom:solid 2px #000000; border-left:solid 2px #000000; color:#000000; line-height:14px;font-size:13px;font-weight:normal;font-family:Tahoma; }
	
	
		table.o_list td {border-left:2px solid #000000; padding:3px 0 ; text-align:center; height:14px;color:#000000; background-color:#fff;}
		table.o_list td.b_line {border-left:2px solid #000000;border-bottom:2px solid #000000; padding:3px 0 ; text-align:center; height:14px;color:#000000; background-color:#fff;}
		table.o_list td.ar {text-align:right; padding-right:12px; color:#000000}
		table.o_list td.al {text-align:left; padding-left:12px;}          

   </style>
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
						<td id=deliLoctNm></td>
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
          <table width="100%" border="0" cellpadding="0" cellspacing="0" class="o_list" id="tbGrid" name="tbGrid">
              <colgroup>
                        <col width="5%"/>
                        <col width=""/>
						<col width="5%"/>						
                        <col width="11%"/>
						<col width="14%"/>                            
                        <col width="13%"/>
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
							<col width="25%"/>
							<col width="28%"/>                    
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


</div>
<input type="hidden" name="mailbody"/>
<input type="hidden" name="mainMail"/>
<input type="hidden" name="refMail"/>
<input type="hidden" name="poNo"/>
<input type="hidden" name="title"/>
</form>
<!-- 버튼 S -->	
<div id="btn_area" style="width:100%">
	<p class="b_right" id="p_print" style="display:none">
		<span class="btn_r btn_l" >
		<input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="Print" onclick="f_print()"/></span>  		
	</p>
	<p class="b_right" id="p_send" style="display:none"> 
		<span class="btn_r btn_l" >
		<input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="Send" onclick="f_send()"/></span> 			
	</p>		
</div>
</body>
</html>
