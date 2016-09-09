<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.lang.*" %>
<%@ page import="devon.core.util.*" %>
<%@ page import="comm.util.*"%>
<%@ include file="/include/head.jsp" %>
<head> 
<meta name="Generator" content="" />
<meta name="Author" content="" />
<meta name="keywords" content="" />
<meta name="Description" content="" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>Untitled Document</title>
<link rel="stylesheet" type="text/css" href="../sys/css/common.css" />
<link rel="stylesheet" type="text/css" href="../sys/css/sub_style.css" />
<head>

<script language="javascript">

function onLoad(){
	ds_group.DataID = "/cm.cm.commCodeMgnt.RetrieveMsCbList.gau";
	ds_group.Reset();
}

function retrieve(){
	ds_main.DataID    = "/cm.cm.commCodeMgnt.retrievecommCodeMgntList.gau?";
    ds_main.DataID += "group_cd=" + ds_group.NameValue( ds_group.RowPosition , "code" );
    ds_main.DataID += "&lang="+"<%=g_lang%>";	
	ds_main.Reset();
}

function msAddrow(){
	ds_main.addrow();
}

function dtAddrow(){
	if(ds_main.CountRow>0)	{
		ds_main2.addrow();
	}
}

function dtDelrow(){
	if(ds_main2.RowPostion>0)	{
		ds_main2.DeleteRow(ds_main2.RowPostion);
	}
}

</script> 

<%----------------------------------------------------------------------------------------------------
 Gauce obj  정의
---------------------------------------------------------------------------------------------------- --%>
  <object id="ds_group" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/>
  <param name="ViewDeletedRow"    value="true"/>
</object>

<object id="ds_main" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/>
  <param name="ViewDeletedRow"    value="true"/>
</object>

<object id="ds_main2" classid="<%=LGauceId.DATASET%>"/>
  <param name="SyncLoad"          value="true"/>
  <param name="ViewDeletedRow"    value="true"/>
</object>

<%----------------------------------------------------------------------------------------------------
 Gauce obj  event  정의
---------------------------------------------------------------------------------------------------- --%>

<script language=JavaScript for= "lc_cgroup" event=OnKeyDown(kcode)>
		On_Apply(lc_cgroup,kcode);
</script>

<script language=JavaScript for= "lc_ngroup" event=OnKeyDown(kcode)>
		On_Apply(lc_ngroup,kcode);
</script>

<script language=JavaScript for="ds_group" event=OnLoadCompleted(rowcnt)>
		cfUnionBlank(ds_group,lc_cgroup,"code","name");
</script>

<script language=JavaScript for="ds_detail" event=OnLoadCompleted(rowcnt)>
		cfUnionBlank(ds_detail,lc_cdetail,"code","name");
</script>

<script language=JavaScript for="ds_main" event=OnRowPosChanged(row)>
		if(row>0)
		{
			ds_main2.DataID    = "/cm.cm.commCodeMgnt.RetrieveDtCbList.gau?company_cd="+"<%=g_companyCd%>";
			ds_main2.DataID    += "&group_cd="+ds_main.NameValue(ds_main.RowPosition,"groupCd");
			ds_main2.DataID    += "&lang= "+"<%=g_lang%>";
			ds_main2.Reset();
		}
</script>


<%----------------------------------------------------------------------------------------------------
 UI  정의
---------------------------------------------------------------------------------------------------- --%>
</head>

<body id="all_bg" onload="onLoad();">

<div id="conts_box">
	<h2> <span> 공통코드등록 </span></h2>
	<!--검색 S -->	
	 <div style="margin-top:-10px;"></div>
	 <fieldset class="boardSearch">
			<legend>게시물 검색</legend> 
				<div>
					 <dl>
						<dt> 
							<table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board2" />
									<colgroup>
											<col width="12%"/>
											<col width="16%"/> 
											<col width=""/>
									  </colgroup>
									   <tr>
											<th>분류코드</th>
											<td>
												<object id="lc_cgroup" classid="<%=LGauceId.LUXECOMBO%>"  width="90"/>
											    <param name=ComboDataID     value="ds_group"/>
												<param name=Sort			value=false/>
												<param name=ListExprFormat	value="code^0^50,name^0^200"/> 
												<param name=BindColumn	    value="code"/>
												<param name=SearchColumn	value=code/> 
												<param name=ComboStyle		value=2>
												<param name=DisableBackColor  value="#FFFFCC"/>
										       </object>
											</td>
											<td>
												<object id="lc_ngroup" classid="<%=LGauceId.LUXECOMBO%>"  width="90"/>
											    <param name=ComboDataID     value="ds_group"/>
												<param name=Sort			value=false/>
												<param name=ListExprFormat	value="name^0^200,code^2^50"/> 
												<param name=BindColumn	    value="name"/>
												<param name=SearchColumn	value=name/> 
												<param name=ComboStyle		value=2>
												<param name=DisableBackColor  value="#FFFFCC"/>
										       </object>
											</td>
									   </tr>
								</table>
						 </dt>              		  	   	 	
						 <dd class="btnseat1"> <img src="../sys/images/button/search_btn.gif" alt="검색" onclick="retrieve()" /> </dd>											
					</dl>
				</div>
		</fieldset>
      <!--검색 E -->		
		
	
     <div class="sub_stitle"> <p>공통코드목록 </p> </div>        	
		
 	<!-- 그리드 S -->	
       <div id="n_board_area"> 
			<table width="100%" border="0" cellspacing="0" cellpadding="0"  class="list">
			  <tr>
			    <td>
			      <comment id="__NSID__">
			        <object id="gd_main" classid="<%=LGauceId.GRID %>" class="comn" width="100%" height="80px">
			          <param name="DataID"              value="ds_main"/>
			          <param name="BorderStyle"         value="2"/>
			          <param name="RowHeight"           value="20"/>
			          <param name="IndWidth"            value="15"/>
			          <param name="Enable"              value="TRUE"/>
			          <param name="Editable"            value="false"/>
			      	  <param name="ViewDeletedRow"      value="true"/>
				      <param name="ColSizing"  value="true"/>
			          <param name="ColSelect"           value="false"/>
			          <param name="DragDropEnable"      value="true"/>
			          <param name="DisableNoHScroll"    value="true"/>
			          <param name="SortView"            value="Left"/>
			          <param name="MultiRowSelect"      value="true"/>
					  <param name="SelectionColor"   VALUE="
			                                <SC>Type='FocusCurCol', BgColor='#FFE4C4', TextColor='#666666'</SC>
			                                <SC>Type='FocusCurRow', BgColor='#FFE4C4', TextColor='#666666'</SC>
			                                <SC>Type='FocusEditRow', BgColor='#FFE4C4', TextColor='#666666'</SC>
			          "/>
			          <param name="Format"              value='
   			            <C>id="NO"		  name="No."				    value={CurRow} width=30		align=center</c>
   			            <C>id="companyCd"     name="법인코드"            Edit="false"  width="100" align="center" sort=true  </c>
			            <C>id="groupCd"     name="분류코드"            Edit="false"  width="100" align="center" sort=true  </c>
			            <C>id="groupNm"    name="분류명"              Edit="false"  width="100" align="left" sort=true   </c>
			            <C>id="msRemark"    name="설명"              Edit="false"  width="150" align="center" sort=true  </c>
			            <C>id="msRegnm"    name="등록자"              Edit="false"  width="90" align="left" sort=true  </c>
			            <C>id="msRegdate"    name="등록일"              Edit="false"  width="90" align="center" sort=true  Mask="XXXX/XX/XX"</c>
			            <C>id="msYn"    name="사용여부"              Edit="false"  width="100" align="center" sort=true  </c>
			          '/>
			        </object>
			      </comment>
			      <script>__WS__(__NSID__);</script>
			    </td>
			  </tr>
			</table>
        </div>
        <!-- 그리드 E -->	
        <div class="sub_stitle"> <p>공통코드분류 </p></div>
        <!-- 그리드 S -->	
        <div id="output_board_area">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board" >
                <colgroup>
                        <col width="13%"/>
                        <col width="30%"/>
                        <col width="13%"/>
                        <col width=""/>
              </colgroup>
                    <tr>
                        <th>분류코드</th>
                        <td><input type="text"  id="groupCd"  value="" readonly style="width:150px;" /></td>
                        <th>분류명</th>
                        <td><input type="text"  id="groupNm"  value="" style="width:150px;" /></td>
                    </tr>
                    <tr>
                        <th>등록일</th>
                        <td><input type="text"  id="msRegdate"  value=""  readonly style="width:150px;" /></td>
                      <th>등록자</th>
                        <td><input type="text"  id="msRegnm"  value=""  readonly style="width:150px;" /></td>
                    </tr>
                    <tr>
                        <th>수정일</th>
                        <td> <input type="text" id="msModdate" value="" readonly style="width:150px;" /></td>
                      <th>수정자</th>
                        <td><input type="text"  id="msModid" value="" readonly style="width:150px;" /></td>
                    </tr>
                    <tr>
                        <th>설명</th>
                        <td colspan="3"> <input type="text"  id="msRemark" style="width:450px;" value="" /></td>
                    </tr>
            </table>
     </div>
      <!-- 그리드 E -->	
        
        <div class="sub_stitle"> 
         	<p>공통코드</p>
            <p class="rightbtn"> 
            <span class="sbtn_r sbtn_l">
              <input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="행추가" onclick="dtAddrow();"/></span> 
              <span class="sbtn_r sbtn_l"> 
              <input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="행삭제" onclick="dtDelrow();"/></span>  		</p>
		</div>
        <!-- 그리드 S -->	
     	<div id="n_board_area">
			<table width="100%" border="0" cellspacing="0" cellpadding="0"  class="list">
			  <tr>
			    <td>
			      <comment id="__NSID__">
			        <object id="gd_detail" classid="<%=LGauceId.GRID %>" class="comn" width="100%" height="140px">
			          <param name="DataID"              value="ds_main2"/>
			          <param name="BorderStyle"         value="2"/>
			          <param name="RowHeight"           value="20"/>
			          <param name="IndWidth"            value="15"/>
			          <param name="Enable"              value="TRUE"/>
			          <param name="Editable"            value="false"/>
			      	  <param name="ViewDeletedRow"      value="true"/>
				      <param name="ColSizing"  value="true"/>
			          <param name="ColSelect"           value="true"/>
			          <param name="DragDropEnable"      value="true"/>
			          <param name="DisableNoHScroll"    value="true"/>
			          <param name="SortView"            value="Left"/>
			          <param name="MultiRowSelect"      value="true"/>
					  <param name="SelectionColor"   VALUE="
			                                <SC>Type='FocusCurCol', BgColor='#FFE4C4', TextColor='#666666'</SC>
			                                <SC>Type='FocusCurRow', BgColor='#FFE4C4', TextColor='#666666'</SC>
			                                <SC>Type='FocusEditRow', BgColor='#FFE4C4', TextColor='#666666'</SC>
			          "/>
			          <param name="Format"              value='
			            <C>id="NO"		  name="No."				    value={CurRow} width=30		align=right</c>
			            <C>id="code"    name="코드"              Edit="false"  width="150" align="center" sort=true  </c>
			            <C>id="name"    name="코드명"              Edit="true"  width="90" align="left" sort=true  </c>
			            <C>id="attr1"    name="속성1"              Edit="true"  width="90" align="left" sort=true  </c>
			            <C>id="attr2"    name="속성2"              Edit="true"  width="90" align="left" sort=true  </c>
			            <C>id="attr3"    name="속성3"              Edit="true"  width="90" align="left" sort=true  </c>
			            <C>id="useyn"    name="사용여부"              Edit="false"  width="100" align="center" sort=true  </c>
			          '/>
			        </object>
			      </comment>
			      <script>__WS__(__NSID__);</script>
			    </td>
			  </tr>
			</table>
  	   </div>
  	 <!-- 그리드 E -->	
     <!-- 버튼 S -->	
          <div id="btn_area">
            <p class="b_right">
                 <span class="btn_r btn_l">
                 <input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#444'" value="신규" onclick="msAddrow();"/></span> 
                    <span class="btn_r btn_l">
                    <input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#444'" value="저장" onclick="save();"/></span> 
            </p>
        </div>
        <!-- 버튼 E -->	
		<!-- 그리드 BIND -->
		<object id=mxBind classid="<%=LGauceId.BIND%>">
		  <param name=DataID    value=ds_main>
		  <param name=BindInfo  value='
		                <C> Col=groupCd         Ctrl=groupCd        Param=Value </C>
		                <C> Col=groupNm        Ctrl=groupNm       Param=Value </C>
		                <C> Col=msRegdate        Ctrl=msRegdate        Param=Value </C>
		                <C> Col=msRegnm        Ctrl=msRegnm       Param=Value </C>
		                <C> Col=msModdate         Ctrl=msModdate        Param=Value </C>
		                <C> Col=msModid      Ctrl=msModid     Param=Value </C>
		                <C> Col=msRemark      Ctrl=msRemark     Param=Value </C>\
		  '>
		</object>        
</div>
</body>
<script src="<%=xjos %>/xjos.js" language="JScript"/></script>
</html>
