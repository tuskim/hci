<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/include/doctype.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%--
/*
 *************************************************************************
 * @source  : materialMasterList.jsp
 * @desc    : 자재코드 필수항목 조회
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

	cfAddYn(ds_yn,"code","BLANK"); 
	document.aForm.lx_yn.Index=0;
	
	 ds_maType.DataID ="cm.cm.retrieveCommCodeCombo.gau?groupCd=1102&firstVal=Total";
	 ds_maType.Reset();
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
	    condition += "materCd=" + encodeURIComponent(document.aForm.seekMaterCd.value);
	    condition += "&materType=" + ds_maType.nameValue(ds_maType.rowPosition,"code");
	    
	 	condition += "&useyn=" +ds_yn.nameValue(ds_yn.rowPosition,"code");
  
	ds_grid.DataID = "/cm.cm.retrieveMaterialMasterList.gau" +condition;
	ds_grid.Reset();

}	
//-------------------------------------------------------------------------
// ha정보 수정 
//-------------------------------------------------------------------------	
function f_process(){

	for(var i=1;i<=ds_grid.CountRow;i++){
		if(ds_grid.NameValue(i,"ha") < 0 ){
			alert("<%=source.getMessage("dev.msg.ps.greaterZero","'ha'")%>" );return false;	
		}
	}
		tr_cuMaster.KeyValue = "Servlet(I:ds_grid=ds_grid, O:ds_grid=ds_grid )";
		tr_cuMaster.Action   = "/cm.cm.cudMaterialMasterList.gau";
		tr_cuMaster.post();

}

//-------------------------------------------------------------------------
//Excel Download
//-------------------------------------------------------------------------			
function f_excel() {
	
	gf_excel(ds_grid,gr_grid,"<%=columnData.getString("page_title") %>","c\\");
}

</script>
<!-----------------------------------------------------------------------------
		   프로그램 전용 G A U C E   C O M P O N E N T' S   E V E N T S
------------------------------------------------------------------------------>
<script language=JavaScript for="ds_yn" event="OnRowPosChanged(row)" 	>

</script>

<!-- INSERT Tr 의 트렌젝션 실행 시 에러 여부 -->
<script language=JavaScript for=tr_cuMaster event=OnFail()>
    mode = "";
    if(tr_master.ErrorMsg.indexOf("Session is Terminated. You need to relogin!") != -1) {
        window.parent.location.href = "/index.jsp";    
    }
    alert(tr_cuMaster.ErrorMsg);
</script>

<script language=JavaScript for=tr_cuMaster event=OnSuccess()>	
        f_search();
        alert("successfully saved.");
        
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
		
<!-----------------------------------------------------------------------------
		    프로그램 전용 D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- Grid 용 DataSet-->
<object id="ds_grid" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad" value="true">
	<param name="ViewDeletedRow" value="true">
</object>

<!-- yn combo DataSet -->
<object id="ds_yn"	classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad"        value="true">
</object>

<object id="ds_maType" classid="<%=LGauceId.DATASET%>">
	<param name="SyncLoad" value="true">
</object>
<!-- 표준 공통  검색조건 파라메타   DataSet -->
<object id="ds_param" classid="<%=LGauceId.DATASET%>"> </object>

<!-- TR 조회용 -->
<OBJECT id="tr_master" classid="<%=LGauceId.TR%>">
	<param name="KeyName" value="toinb_dataid4">
</OBJECT>

<OBJECT id="tr_cuMaster" classid="<%=LGauceId.TR%>">
	<param name="KeyName" value="toinb_dataid4">
</OBJECT>


</head>

<!-----------------------------------------------------------------------------
    화면영역 시작
------------------------------------------------------------------------------>
<body id="cent_bg" onload="onLoad()">

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
			<col width="10%" />
			<col width="12%" />
			<col width="10%" />
			<col width="15%" />
			<col width="5%" />
			<col width="5%" />
			<col width="" />
		</colgroup>
		<tr>
			<th><%=columnData.getString("mater_type") %> :</th>
			<td><comment id="__NSID__"><object id="lx_ma"  classid="<%=LGauceId.LUXECOMBO%>" width="115">
				<param name="ComboDataID"       value="ds_maType">
				<param name="ListCount"     	value="10">
				<param name=SearchColumn		value="name">
				<param name="BindColumn"    	value="code">
				<param name=ListExprFormat		value="name^0^135,code^0^50"> 
				<param name=index           	value=0>
				</object></comment><script>__WS__(__NSID__); </script>
			</td>	
			<th><%=columnData.getString("mater_cd") %> : </th>
			<td><input type="text" name="seekMaterCd" id="seekMaterCd" onkeydown="keyLogin(event)" size="20" class="input_Licon"  maxlength="20"></td>
			
			<th><%=columnData.getString("useyn") %> : </th> 
			<td><comment id="__NSID__"><object id="lx_yn"  classid="<%=LGauceId.LUXECOMBO%>" width="80">
			    <param name="ComboDataID"       value="ds_yn">
				<param name="ListCount"     	value="10">
				<param name=SearchColumn		value="name">
				<param name="BindColumn"    	value="code">
			    <param name=ListExprFormat		value="name^0^70">
			    <param name=WantSelChgEvent	value=true>
			     

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
</form>


<!--조회영역 끝 --> <!--===================================================================-->

<!--검색 E -->
<div class="sub_stitle">
<p><%=columnData.getString("page_title") %></p>
<p class="rightbtn"> 
			<span class="excel_btn_r excel_btn_l">
				<input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="<%=btnExcelDown %>" onclick="f_excel()"/>
			</span> 
		</p>
</div>
	
 	<!-- 그리드 S -->	
       <div> 
			<table width="100%" border="0" cellspacing="0" cellpadding="0"   >
			  <tr>
			    <td>
			      <comment id="__NSID__">
			        <object id="gr_grid" classid="<%=LGauceId.GRID %>" style="width:100%;height:450px"  class="comn_status">
			          <param name="DataID"              value="ds_grid">
			          <param name="Editable"            value="true">
			          <param name="TitleHeight"         value="30">
			          <param name="UsingOneClick"       value="1">
			        <param name="Format"
					value='
						
						   <c>id="materType"   	 	Edit="none"  		   			   align="left"  	width="135"     name="<%=columnData.getString("mater_type2") %>"    </c>
						   <c>id="materCd"   	 	Edit="none"  		   			   align="center"  	width="105"     name="<%=columnData.getString("mater_cd") %>"    </c>
						   <c>id="materNmEn"    	Edit="none"  				       align="left"  	width="190"    name="<%=columnData.getString("mater_nm_en") %>" </c>
						   <c>id="materNmLo"    	Edit="none"    					   align="left"  	width="190"    name="<%=columnData.getString("mater_nm_lo") %>" </c>	
						   <c>id="unit"      		Edit="none"  EditStyle="Lookup"	   align="center"  	width="50"     name="<%=columnData.getString("unit") %>"     	</c>
						   <c>id="useyn"   			Edit="none"  EditStyle="Lookup"	   align="center"  	width="55"     name="<%=columnData.getString("useyn")%>" 		</c>  
						   <c>id="companyCd"  		Edit="none"  Show="false"  		   align="center"  	width="50"    name="companyCd"   </c>
						   <c>id="materCd"  	 	Edit="none"  Show="false"  		   align="center"  	width="50"    name="materCd"  </c>
						   <c>id="materType2"  	 	Edit="none"  Show="false"  		   align="center"  	width="50"    name="materType"  </c>
						   
			          
						'>
		</object></comment> <script>__WS__(__NSID__);</script></td>
			  </tr>
			</table>
        </div>

<!--리스트 영역 끝 --> <!--  ===========================================================================-->   	
 		<div id="btn_area">
			<p class="b_right">
 				 <span class="btn_r btn_l">

			</p>
		</div>
</body>
</html>



