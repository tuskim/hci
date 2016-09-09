<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/include/doctype.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%--
/*
 *************************************************************************
 * @source  : accountManage.jsp
 * @desc    : 농장계정 필수 항목 등록 
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

<%
	String msgInfoChange    = source.getMessage("dev.inf.com.nochange");    // no data for change.
	String msgSave            = source.getMessage("dev.cfm.com.save");      // Are you sure to save?
	String msgDelete          = source.getMessage("dev.cfm.com.delete");    // Are you sure to Delete?
	String msgContinue          = source.getMessage("dev.cfm.com.continue");  // Are you sure to Continue?

%>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />


<head>

<script type="text/javascript">

//-------------------------------------------------------------------------
// Y/N select box
//-------------------------------------------------------------------------	
function onLoad(){ 

	cfAddYn(ds_area,"area");
	cfAddYn(ds_div,"div");
	cfAddYn(ds_block,"block");
	cfAddYn(ds_year,"year");
	cfAddYn(ds_tm,"tm");
	cfAddYn(ds_useyn,"useyn");

}

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
//신규버튼 클릭시
//-------------------------------------------------------------------------	
				
function f_addRow() {

if(ds_grid.CountRow<1)	{
	var strHeader = "check:STRING(100), acctNmEn:STRING(100), acctNmLo:String(100),acctSapNmEn:STRING(100),"
			     	+ "area:STRING(100), div:STRING(100), block:STRING(100), year:STRING(100), tm:STRING(100),"
			     	+ "useyn:STRING(100), companyCd:STRING(100), acctSapCd:STRING(100), acctCd:STRING(100) ,acct:STRING(100)";
    	ds_grid.SetDataHeader(strHeader);
    	cfHideNoDataMsg(gr_grid);
	}
	
	for(var j=1;j<=ds_grid.CountRow;j++){
		if( f_isNull(ds_grid.NameValue( j,"acctCd" )) ){
			ds_grid.RowPosition= j ;		
			alert("<%=source.getMessage("dev.warn.com.input","'Account Code'")%>" );return;	
			return;
		
		}if(f_isNull(ds_grid.NameValue( j,"acctSapCd" ))){
			ds_grid.RowPosition= j ;
			alert("<%=source.getMessage("dev.warn.com.input","'SAP Account'")%>" );return;	
			return;
		}		
		
					
	}
	ds_grid.addrow();
	ds_grid.NameValue(ds_grid.RowPosition,"companyCd")= "<%=g_companyCd%>";
	ds_grid.NameValue(ds_grid.RowPosition,"useyn")= "Y";
	
	
}
		
//-------------------------------------------------------------------------
//저장버튼 클릭시
//-------------------------------------------------------------------------				

function f_process() {

	var form 	= document.aForm;	
    if( ds_grid.IsUpdated == false ) {
		alert("<%=msgInfoChange%>" );return;
   	}else{

   		var	checkedRow = 0;
		for( var i=1; i <= ds_grid.CountRow; i++ ) {
			if( "0" != ds_grid.RowStatus( i ) ) {
				
			
				checkedRow	= i;	
				ds_grid.RowPosition	= checkedRow;				
			
					if(!f_validate()){
						return;
						
					}		
			}
		}
	
		tr_cuMaster.Action   = "/cm.cm.cudAccountMgnt.gau";
		tr_cuMaster.KeyValue = "SERVLET( I:ds_grid=ds_grid, O:ds_grid=ds_grid )";
		tr_cuMaster.Post(); 

	}
}
		

//-------------------------------------------------------------------------
// validation
//-------------------------------------------------------------------------				
function f_validate(){
	var isOk = true;
	var	row		= ds_grid.RowPosition;
	
	//acctCd값 존재할때 중복체크				
	for(var a=1;a<=ds_grid.CountRow;a++){ 	
		var v_dtChk = 0;
		var v_acctCd = ds_grid.NameValue(a,"acctCd");
		
		if(	!f_isNull(v_acctCd)){	
		
			for(var aj=1;aj<=ds_grid.CountRow;aj++){
			
				if(v_acctCd == ds_grid.NameValue(aj,"acctCd")){
					v_dtChk++;
					if(v_dtChk>1){
						isOk = false;
			alert("<%=source.getMessage("dev.warn.com.dup","'Account Code'")%>" );
						return false;
					}
				}
			}			
		}			
	}	

    if(ds_grid.CountRow>0)	{
		if( f_isNull(ds_grid.NameValue( row , "acctCd" ))  ) {
			alert("<%=source.getMessage("dev.warn.com.input","'Account Code'")%>" );
				isOk = false;			
				return false;
		}else if( f_isNull(ds_grid.NameValue( row , "acctNmEn" ))&& f_isNull(ds_grid.NameValue( row , "acctNmLo" )) ) {
			alert("<%=source.getMessage("dev.warn.com.input","'Account Name'")%>" );
				isOk = false;			
				return false;
		}else if( f_isNull(ds_grid.NameValue( row , "acctSapCd" ))  ) {
			alert("<%=source.getMessage("dev.warn.com.input","'SAP Account'")%>" );
				isOk = false;			
				return false;
		}else if( f_isNull(ds_grid.NameValue( row , "area" ))  ) {
			alert("<%=source.getMessage("dev.warn.com.input","'Area'")%>" );
				isOk = false;			
				return false;
		}else if( f_isNull(ds_grid.NameValue( row , "div" ))  ) {
			alert("<%=source.getMessage("dev.warn.com.input","'Div'")%>" );
				isOk = false;			
				return false;
				return false;
		}else if( f_isNull(ds_grid.NameValue( row , "block" ))  ) {
			alert("<%=source.getMessage("dev.warn.com.input","'Block'")%>" );
				isOk = false;			
				return false;
				return false;
		}else if( f_isNull(ds_grid.NameValue( row , "year" ))  ) {
			alert("<%=source.getMessage("dev.warn.com.input","'Year'")%>" );
				isOk = false;			
				return false;
				return false;
		}else if( f_isNull(ds_grid.NameValue( row , "tm" ))  ) {
			alert("<%=source.getMessage("dev.warn.com.input","'TM TBM'")%>" );
				isOk = false;			
				return false;
		}else if( f_isNull(ds_grid.NameValue( row , "useyn" ))  ) {
			alert("<%=source.getMessage("dev.warn.com.input","'USE'")%>" );
				isOk = false;			
				return false;
		}
	}
	return isOk;	


}

//-------------------------------------------------------------------------
//해당 문자열이 널인지 점검
//-------------------------------------------------------------------------		
function f_isNull( asValue ) {
   	if (asValue == null || asValue == undefined || asValue.toString().replace(/ /g,"") == "") {
      	 return  true;
   	}
  	return false;
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
<!-- INSERT Tr 의 트렌젝션 실행 시 에러 여부 -->
<script language=JavaScript for=tr_cuMaster event=OnFail()>
    mode = "";
    if(tr_master.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
        window.parent.location.href = "/index.jsp";    
    }
    alert(tr_cuMaster.ErrorMsg);
</script>

<script language=JavaScript for=tr_cuMaster event=OnSuccess()>	
        alert("successfully saved.");
        f_search();
</script>

<script language=JavaScript for=ds_grid event=OnLoadStarted()>
  cfShowDSWaitMsg(gr_grid);//progress bar 보이기
  cfHideNoDataMsg(gr_grid);//no data 메시지 숨기기
  mode = "";
</script>

<!-- Hub In Header 조회 DataSet -->
<script language=JavaScript for=ds_grid event=OnLoadCompleted(rowCnt)>
  cfHideDSWaitMsg(gr_grid);//progress bar 숨기기
  cfFillGridNoDataMsg(gr_grid,"gridColLineCnt=2");//no data found   
  mode = "";
</script>
			
<script language=JavaScript for=gr_grid event=OnPopup(row,colid,data)>
 	if ( colid == "acctSapCd") {
		openAccountSapCodeListGridWin(row, ds_grid); 	
	} 	
</script>

<script language="javascript"  for=gr_grid event=OnColumnPosChanged(row,colid)>
    
    // SEARCH 버튼  DISPLAY    
    if (colid.toLowerCase() == "acctsapcd") cfSetSearchGridBtn(gr_grid);
    
</script>



<!-----------------------------------------------------------------------------
		    프로그램 전용 D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- Grid 용 DataSet-->
<object id="ds_grid" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad" value="true">
	<param name="ViewDeletedRow" value="true">
</object>

<object id="ds_area" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/>
  <param name="ViewDeletedRow"    value="true"/>
</object>

<object id="ds_div" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/>
  <param name="ViewDeletedRow"    value="true"/>
</object>


<object id="ds_block" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/>
  <param name="ViewDeletedRow"    value="true"/>
</object>

<object id="ds_year" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/>
  <param name="ViewDeletedRow"    value="true"/>
</object>

<object id="ds_tm" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/>
  <param name="ViewDeletedRow"    value="true"/>
</object>


<object id="ds_useyn" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/>
  <param name="ViewDeletedRow"    value="true"/>
</object>




<!-- 표준 공통  검색조건 파라메타   DataSet -->
<object id="ds_param" classid="<%=LGauceId.DATASET%>"> </object>

<!-- TR 조회용 -->
<OBJECT id="tr_master" classid="<%=LGauceId.TR%>">
	<param name="KeyName" value="toinb_dataid4">
</OBJECT>

<OBJECT id=tr_cuMaster classid="<%=LGauceId.TR%>">
	<param name="KeyName" value="toinb_dataid4">
</OBJECT>

</head>

<!-----------------------------------------------------------------------------
    화면영역 시작
------------------------------------------------------------------------------>
<body id="cent_bg" onload="onLoad();">

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
			<col width="20%" />
			<col width="25%" />
			<col width="20%" />
			<col width="" />
		</colgroup>
		<tr>
			<th><%=columnData.getString("acct_cd") %> : </th>
			<td><input type="text" name="seekAcctCd" id="seekAcctCd" onkeydown="keyLogin(event)" size="17" class="input_Licon"  maxlength="20"></td>
			<th><%=columnData.getString("acct_nm") %> : </th>
			<td><input type="text" name="seekAcctNm" id="seekAcctNm" onkeydown="keyLogin(event)" size="17" class="input_Licon"></td>
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

<!--검색 E -->&nbsp;&nbsp;&nbsp;&nbsp;
<div class="sub_stitle"> <p> <%=columnData.getString("sub1_title") %>  </p> 	
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
			        <object id="gr_grid" classid="<%=LGauceId.GRID %>" style="width:100%;height:310px" class="comn_status">
			          <param name="DataID"              value="ds_grid">
			          <param name="Editable"            value="true">
			          <param name="TitleHeight"         value="30">
			          <param name="UsingOneClick"       value="1">
			        <param name="Format"
					value='
						   <c>id="chk"     	Show="false"      EditStyle="CheckBox"     align="center" 	width="30"     name=" <%=columnData.getString("check") %>" 	</c> 
						   <c>id="acctCd"   	 	   					   			   align="center"  	width="100"    name="<%=columnData.getString("acct_cd") %>"    </c>
						   <c>id="acctNmEn"    			       					       align="left"  	width="200"    name="<%=columnData.getString("acct_nm_en") %>" </c>
						   <c>id="acctNmLo"    		         	   					   align="left"  	width="200"    name="<%=columnData.getString("acct_nm_lo") %>" </c>
						   <c>id="acctSapCd"    	EditStyle="popUpFix"   			   align="center" 	width="105"    name="<%=columnData.getString("acct_sap_cd") %>"</c> 		
						   <c>id="acctSapNmEn"  	Edit="none"   				  	   align="left"  	width="200"    name="<%=columnData.getString("acct_sap_nm_en") %>" 	</c> 		
						   <c>id="area"   	Data="ds_area:area"   EditStyle="Lookup"   align="center"  	width="60"     name="<%=columnData.getString("attr1") %>"     	</c>
						   <c>id="div"    	Data="ds_div:div"	    EditStyle="Lookup" align="center"  	width="60"     name="<%=columnData.getString("attr2") %>"     	</c>   		
						   <c>id="block"  	Data="ds_block:block" EditStyle="Lookup"   align="center"  	width="60"     name="<%=columnData.getString("attr3") %>"  	</c> 		
						   <c>id="year"   	Data="ds_year:year"  	EditStyle="Lookup"	align="center"   width="60"	   name="<%=columnData.getString("attr5") %>"   	</c>			    
						   <c>id="tm"     	Data="ds_tm:tm"		EditStyle="Lookup"	   align="center"  	width="60"     name="<%=columnData.getString("attr6") %>" 	edit={IF(aboutTm="0","true","false")} </c>
						   <c>id="useyn"  	Data="ds_useyn:useyn" EditStyle="Lookup"   align="center"  	width="60"     name="<%=columnData.getString("useyn")%>" 		</c>  
						   <c>id="companyCd"  	Show="false" 	Edit="none"  		   align="center"  	width="110"    name="법인코드"   </c>
						   <c>id="acctSapCd"  	Show="false" 	Edit="none"  		   align="center"  	width="110"    name="acctSapCd"  </c>
						   <c>id="acctCd"  		Show="false" 	Edit="none"  		   align="center"  	width="110"    name="acctCd"     </c>
						  
									          
						'>
		</object></comment> <script>__WS__(__NSID__);</script></td>
			  </tr>
			</table>
        </div>

<!--리스트 영역 끝 --> <!--  ===========================================================================-->   	
	
       <div id="btn_area">
			<p class="b_right">
				 <span class="btn_r btn_l">
			     <input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnNew %>" onclick="f_addRow();"/></span> 
 				 <span class="btn_r btn_l">
			     <input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnSave %>" onclick="f_process();"/></span> 

			</p>
		</div>
</body>
<script src="<%=xjos %>/xjos.js" language="JScript"/></script>
</html>



