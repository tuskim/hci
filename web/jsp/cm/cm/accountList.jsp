<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/include/doctype.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%--
/*
 *************************************************************************
 * @source  : accountList.jsp
 * @desc    : 농장계정 필수 항목 조회 
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  			       		 신규작성
 * ---  -----------  ----------  -----------------------------------------
 * PT-PAM 시스템
 * Copyright(c) 2006-2007 LG CNS,  All rights reserved.
 *************************************************************************
 */
--%>

<%@ page import="devon.core.collection.LMultiData"%>
<%@ page import="devon.core.collection.LData"%>
<%@ page import="java.util.Date"%>
<%@ include file="/include/head.jsp"%>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />


<head>


<script type="text/javascript">


//-------------------------------------------------------------------------
// 조회조건 입력 & 검색 
//-------------------------------------------------------------------------					
function keyLogin(evt){
   if ( evt.keyCode == 13 || evt == '^') {
   f_search();	
   }
}

function f_search(){
	var form = document.aForm;
				
	var paramHead = "acctCd:STRING(100), acctNm:STRING(100)";
	ds_param.setDataHeader(paramHead);
	ds_param.AddRow();
		   
	ds_param.NameValue( 1 , "acctCd" )	    = form.seekAcctCd.value;
	ds_param.NameValue( 1 , "acctNm" )	    = form.seekAcctNm.value;

	ds_grid.ClearAll();		   

	tr_master.Action   	= "/cm.cm.retrieveAccountMgnt.gau";
	tr_master.KeyValue 	= "SERVLET( I:ds_param=ds_param , O:ds_grid=ds_grid )";//조회
	tr_master.post();		
	
}	

//-------------------------------------------------------------------------
// excel
//-------------------------------------------------------------------------					   
function f_excel() {
	
	gf_excel(ds_grid,gr_grid,"<%=columnData.getString("page_title") %>","c\\");
}
			
</script>

<!-----------------------------------------------------------------------------
		   프로그램 전용 G A U C E   C O M P O N E N T' S   E V E N T S
------------------------------------------------------------------------------>

		
<!-----------------------------------------------------------------------------
		    프로그램 전용 D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- Grid 용 DataSet-->
<object id="ds_grid" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad" value="true">
	<param name="ViewDeletedRow" value="true">
</object>


<!-- 표준 공통  검색조건 파라메타   DataSet -->
<object id="ds_param" classid="<%=LGauceId.DATASET%>"> </object>

<!-- TR 조회용 -->
<OBJECT id="tr_master" classid="<%=LGauceId.TR%>">
	<param name="KeyName" value="toinb_dataid4">
</OBJECT>

</head>

<!-----------------------------------------------------------------------------
    화면영역 시작
------------------------------------------------------------------------------>
<body id="cent_bg">

<div id="conts_box">
<h2><span><%=columnData.getString("page_title") %></span></h2>
<!--검색 S -->

<fieldset class="boardSearch"><legend>게시물 검색</legend>
<div>
<dl>
	<dt><!--조회 영역 시작 -->
	<form name="aForm" style="margin:0px" >
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board2" >
		<colgroup>
			<col width="17%" />
			<col width="25%" />
			<col width="17%" />
			<col width="" />
		</colgroup>
		<tr>
			<th><%=columnData.getString("acct_cd") %> : </th>
			<td><input type="text" name="seekAcctCd" id="seekAcctCd" onkeydown="keyLogin(event)" size="15" class="input_Licon" maxlength="20"></td>
			<th><%=columnData.getString("acct_nm") %> : </th>
			<td><input type="text" name="seekAcctNm" id="seekAcctNm" onkeydown="keyLogin(event)" size="30" class="input_Licon" maxlength="100"></td>
	</table>
	</dt>
	<dd class="btnseat1">
	 <span class="search_btn_r search_btn_l">
     <input type="button" onfocus="blur();" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='#e2ebf7'" value="<%=btnSearch %>" onclick="f_search()"/></span> 
	 </dd>											
	</dl>
  </div>
</fieldset>
</form>


<!--조회영역 끝 --> <!--===================================================================-->

<!--검색 E -->
<div class="sub_stitle"> <p> <%=columnData.getString("sub1_title") %>  </p> 	
		<p class="rightbtn"> 
					<span class="excel_btn_r excel_btn_l">
	                <input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="<%=btnExcelDown %>" onclick="f_excel()"/>
	                </span> 
		</p>	
	</div>  
 	<!-- 그리드 S -->	
       <div> 
			<table width="100%" border="0" cellspacing="0" cellpadding="0" >
			  <tr>
			    <td>
			      <comment id="__NSID__">
			        <object id="gr_grid" classid="<%=LGauceId.GRID %>" width="100%" height="300px" class="comn">
			          <param name="DataID"              value="ds_grid">
			          <param name="Editable"            value="true">
			          <param name="UsingOneClick"       value="1">
			          <param name="TitleHeight"         value="30">
			        <param name="Format"
					value='
						   <c>id={currow}     										   align="center" 	width="35"     name="" 	</c> 
						   <c>id="acctSapCd"   	 	Edit="none"  		   			   align="center"  	width="108"     name="<%=columnData.getString("acct_cd") %>"    </c>
						   <c>id="acctNmEn"    		Edit="none"  				       align="left"  	width="220"    name="<%=columnData.getString("acct_nm_en") %>" </c>
						   <c>id="acctNmLo"    		Edit="none"    					   align="left"  	width="220"    name="<%=columnData.getString("acct_nm_lo") %>" </c>						  
						   <c>id="attr1"      		Edit="none"   	                   align="center"  	width="80"     name="<%=columnData.getString("attr1") %>"     	</c>
						   <c>id="useyn"   			Edit="none"                 	   align="center"  	width="80"     name="<%=columnData.getString("useyn")%>" 		</c>  
									          
						'>
		</object></comment> <script>__WS__(__NSID__);</script></td>
			  </tr>
			</table>
        </div>

<!--리스트 영역 끝 --> <!--  ===========================================================================-->   	

</body>
<script src="<%=xjos %>/xjos.js" language="JScript"/></script>
</html>



