<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/include/doctype.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%--
/*
 *************************************************************************
 * @source  : blockHrInfoMgnt.jsp
 * @desc    :  Block별 hr 정보 등록
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
// Y/N select box
//-------------------------------------------------------------------------	
function onLoad(){ 

	cfAddYn(ds_useyn,"useyn");
	cfAddYn(ds_yn,"code","BLANK");
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
	var condition = "?";
	    condition += "divCd="   + seekDivYn.value;
	    condition += "&blockCd="+ seekBlockYn.value;
	    condition += "&yearCd=" + seekYearYn.value;
	 	condition += "&useyn="  + lx_yn.ValueOfIndex("code",lx_yn.Index);
  
	ds_grid.DataID = "/cm.cm.retrieveBlockHrInfoMgnt.gau" +condition;
	ds_grid.Reset();
	
	
}				   

//-------------------------------------------------------------------------
//저장버튼 클릭시
//-------------------------------------------------------------------------				

function f_process() {

	var form 	= document.aForm;	
    if( ds_grid.IsUpdated == false ) {
         alert( " no data for change~" );				
        return;
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
		tr_cuMaster.Action   = "/cm.cm.cudBlockHrInfoMgnt.gau";
		tr_cuMaster.KeyValue = "SERVLET( I:ds_grid=ds_grid, O:ds_grid=ds_grid )";
		tr_cuMaster.Post(); 
	}
}


//-------------------------------------------------------------------------
// null 체크
//-------------------------------------------------------------------------			
function f_isNull( asValue ) {
   	if (asValue == null || asValue == undefined || asValue.toString().replace(/ /g,"") == "") {
      	 return  true;
   	}
  	return false;
}			

//-------------------------------------------------------------------------
// validation
//-------------------------------------------------------------------------				
function f_validate(){
	var isOk = true;
	var	row		= ds_grid.RowPosition;
	var regExp = /^[0-9]+$/;
		for(var a=1;a<=ds_grid.CountRow;a++){ 	
		var v_dtChk = 0;
	
		if( !f_isNull(ds_grid.NameValue( row , "hr" )) ) {
	
			if( !regExp.test(ds_grid.NameValue( row , "hr" )) ) {
		        alert("숫자 형태로 입력하세요");
		        form.hr.focus();	
		         return	false;
		         
			}
			isOk = true;
		}else {
			alert("값을 입력하세요");
		    form.hr.focus();
		    return	false;
		}			
		}
	return isOk;	
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

<script language=JavaScript for="ds_yn" event="OnRowPosChanged(row)" 	>

</script>
<!-----------------------------------------------------------------------------
		    프로그램 전용 D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- Grid 용 DataSet-->
<object id="ds_grid" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad" value="true">
	<param name="ViewDeletedRow" value="true">
</object>


<object id="ds_useyn" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/>
  <param name="ViewDeletedRow"    value="true"/>
</object>

<!-- yn combo DataSet -->
<object id="ds_yn"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
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
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board2" >
		<colgroup>
			<col width="10%" />
			<col width="15%" />
			<col width="10%" />
			<col width="15%" />
			<col width="10%" />
			<col width="15%" />
			<col width="10%" />
			<col width="" />
		</colgroup>
		<tr>
			<th><%=columnData.getString("div_cd") %> : </th>
			<td><input type="text" name="seekDivYn" id="seekDivYn" onkeydown="keyLogin(event)" size="10" class="input_Licon"></td>
			<th><%=columnData.getString("block_cd") %> : </th>
			<td><input type="text" name="seekBlockYn" id="seekBlockYn" onkeydown="keyLogin(event)" size="10" class="input_Licon"></td>
			<th><%=columnData.getString("year_cd2") %> : </th>
			<td><input type="text" name="seekYearYn" id="seekYearYn" onkeydown="keyLogin(event)" size="10" class="input_Licon"></td>
			<th><%=columnData.getString("useyn") %> : </th>
			 
			<td><comment id="__NSID__"><object id="lx_yn"  classid="<%=LGauceId.LUXECOMBO%>" width="90">
			    <param name="ComboDataID"       value="ds_yn">
				<param name="ListCount"     	value="10">
				<param name=SearchColumn		value="name">
				<param name="BindColumn"    	value="code">
			    <param name=ListExprFormat		value="name^0^90">
			    <param name=WantSelChgEvent	value=true>
			    <param name=index           	value=0>
		   	</object></comment><script>__WS__(__NSID__); </script>
		   	</td>					
		 
			

	</table>
	</dt>
	<dd class="btnseat1">
	 <span class="search_btn_r search_btn_l">
     <input type="button" onfocus="blur();" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='#e2ebf7'" value="<%=btnSearch %>" onclick="f_search()"/></span> 
	 </dd>											
	</dl>
  </div>
</fieldset>
 


<!--조회영역 끝 --> <!--===================================================================-->

<!--검색 E -->
<div class="sub_stitle">
<p><%=columnData.getString("sub1_title") %></p>
</div>
	
 	<!-- 그리드 S -->	
       <div id="n_board_area"> 
			<table width="100%" border="0" cellspacing="0" cellpadding="0"  class="list">
			  <tr>
			    <td>
			      <comment id="__NSID__">
			        <object id="gr_grid" classid="<%=LGauceId.GRID %>"  width="100%" height="153px">
			          <param name="DataID"              value="ds_grid">
			          <param name="BorderStyle"         value="2">
			          <param name="RowHeight"           value="20">
			          <param name="IndWidth"            value="15">
			          <param name="Enable"              value="TRUE">
			          <param name="Editable"            value="true">
			          <param name="ColSizing"           value="TRUE">
			          <param name="DragDropEnable"      value="TRUE">
			          <param name="TitleHeight"         value="30"/>
			          <param name="UsingOneClick"       value="1">
					  <param name="SelectionColor"   VALUE="
			                                <SC>Type='FocusCurCol', BgColor='#FFE4C4', TextColor='#666666'</SC>
			                                <SC>Type='FocusCurRow', BgColor='#FFE4C4', TextColor='#666666'</SC>
			                                <SC>Type='FocusEditRow', BgColor='#FFE4C4', TextColor='#666666'</SC>
			          "/>
			        <param name="Format"
					value='
						   <c>id="chk"   Show="false"   EditStyle="CheckBox"  align="center"  width="50"   name=" <%=columnData.getString("chk") %>" 	</c> 
						   <c>id="materCd"   	 	   			Edit="none"	   	 align="left"  	 width="153"  name="<%=columnData.getString("mater_cd") %>" </c>
						   <c>id="areaCd"     					Edit="none"		 align="center"  width="80"   name="<%=columnData.getString("area_cd") %>"  </c>
						   <c>id="divCd"    	    			Edit="none" 	 align="center"  width="80"   name="<%=columnData.getString("div_cd") %>"   </c>   		
						   <c>id="blockCd"                     	Edit="none"	  	 align="center"  width="80"   name="<%=columnData.getString("block_cd") %>" </c> 		
						   <c>id="yearCd"   					Edit="none" 	 align="center"  width="80"	  name="<%=columnData.getString("year_cd") %>"  </c>			    
						   <c>id="useyn" Data="ds_useyn:useyn"  Edit="none"      align="center"  width="60"   name="<%=columnData.getString("useyn")%>"   EditStyle="Lookup"  </c>  
						   <c>id="hr"   	 	   					   			 align="right"   width="190"  name="<%=columnData.getString("hr") %>"       </c>
						   <c>id="companyCd"  	Show="false" 	Edit="none"  	 align="center"  width="10"  name="법인코드"   </c>
						   <c>id="materCd"  	Show="false" 	Edit="none"  	 align="center"  width="10"  name="materCd"  </c>
									          
						'>
		</object></comment> <script>__WS__(__NSID__);</script></td>
			  </tr>
			</table>
        </div>

<!--리스트 영역 끝 --> <!--  ===========================================================================-->   	
	
       <div id="btn_area">
			<p class="b_right">
 				 <span class="btn_r btn_l">
			     <input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="<%=btnSave %>" onclick="f_process();"/></span> 

			</p>
		</div>
</body>
</html>



