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
 Gauce obj  ����
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
 Gauce obj  event  ����
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
 UI  ����
---------------------------------------------------------------------------------------------------- --%>
</head>

<body id="all_bg" onload="onLoad();">

<div id="conts_box">
	<h2> <span> �����ڵ��� </span></h2>
	<!--�˻� S -->	
	 <div style="margin-top:-10px;"></div>
	 <fieldset class="boardSearch">
			<legend>�Խù� �˻�</legend> 
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
											<th>�з��ڵ�</th>
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
						 <dd class="btnseat1"> <img src="../sys/images/button/search_btn.gif" alt="�˻�" onclick="retrieve()" /> </dd>											
					</dl>
				</div>
		</fieldset>
      <!--�˻� E -->		
		
	
     <div class="sub_stitle"> <p>�����ڵ��� </p> </div>        	
		
 	<!-- �׸��� S -->	
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
   			            <C>id="companyCd"     name="�����ڵ�"            Edit="false"  width="100" align="center" sort=true  </c>
			            <C>id="groupCd"     name="�з��ڵ�"            Edit="false"  width="100" align="center" sort=true  </c>
			            <C>id="groupNm"    name="�з���"              Edit="false"  width="100" align="left" sort=true   </c>
			            <C>id="msRemark"    name="����"              Edit="false"  width="150" align="center" sort=true  </c>
			            <C>id="msRegnm"    name="�����"              Edit="false"  width="90" align="left" sort=true  </c>
			            <C>id="msRegdate"    name="�����"              Edit="false"  width="90" align="center" sort=true  Mask="XXXX/XX/XX"</c>
			            <C>id="msYn"    name="��뿩��"              Edit="false"  width="100" align="center" sort=true  </c>
			          '/>
			        </object>
			      </comment>
			      <script>__WS__(__NSID__);</script>
			    </td>
			  </tr>
			</table>
        </div>
        <!-- �׸��� E -->	
        <div class="sub_stitle"> <p>�����ڵ�з� </p></div>
        <!-- �׸��� S -->	
        <div id="output_board_area">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="output_board" >
                <colgroup>
                        <col width="13%"/>
                        <col width="30%"/>
                        <col width="13%"/>
                        <col width=""/>
              </colgroup>
                    <tr>
                        <th>�з��ڵ�</th>
                        <td><input type="text"  id="groupCd"  value="" readonly style="width:150px;" /></td>
                        <th>�з���</th>
                        <td><input type="text"  id="groupNm"  value="" style="width:150px;" /></td>
                    </tr>
                    <tr>
                        <th>�����</th>
                        <td><input type="text"  id="msRegdate"  value=""  readonly style="width:150px;" /></td>
                      <th>�����</th>
                        <td><input type="text"  id="msRegnm"  value=""  readonly style="width:150px;" /></td>
                    </tr>
                    <tr>
                        <th>������</th>
                        <td> <input type="text" id="msModdate" value="" readonly style="width:150px;" /></td>
                      <th>������</th>
                        <td><input type="text"  id="msModid" value="" readonly style="width:150px;" /></td>
                    </tr>
                    <tr>
                        <th>����</th>
                        <td colspan="3"> <input type="text"  id="msRemark" style="width:450px;" value="" /></td>
                    </tr>
            </table>
     </div>
      <!-- �׸��� E -->	
        
        <div class="sub_stitle"> 
         	<p>�����ڵ�</p>
            <p class="rightbtn"> 
            <span class="sbtn_r sbtn_l">
              <input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="���߰�" onclick="dtAddrow();"/></span> 
              <span class="sbtn_r sbtn_l"> 
              <input type="button" onfocus="blur();" onmouseover="this.style.color='#1b2e53'" onmouseout="this.style.color='#7b87a0'" value="�����" onclick="dtDelrow();"/></span>  		</p>
		</div>
        <!-- �׸��� S -->	
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
			            <C>id="code"    name="�ڵ�"              Edit="false"  width="150" align="center" sort=true  </c>
			            <C>id="name"    name="�ڵ��"              Edit="true"  width="90" align="left" sort=true  </c>
			            <C>id="attr1"    name="�Ӽ�1"              Edit="true"  width="90" align="left" sort=true  </c>
			            <C>id="attr2"    name="�Ӽ�2"              Edit="true"  width="90" align="left" sort=true  </c>
			            <C>id="attr3"    name="�Ӽ�3"              Edit="true"  width="90" align="left" sort=true  </c>
			            <C>id="useyn"    name="��뿩��"              Edit="false"  width="100" align="center" sort=true  </c>
			          '/>
			        </object>
			      </comment>
			      <script>__WS__(__NSID__);</script>
			    </td>
			  </tr>
			</table>
  	   </div>
  	 <!-- �׸��� E -->	
     <!-- ��ư S -->	
          <div id="btn_area">
            <p class="b_right">
                 <span class="btn_r btn_l">
                 <input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#444'" value="�ű�" onclick="msAddrow();"/></span> 
                    <span class="btn_r btn_l">
                    <input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#444'" value="����" onclick="save();"/></span> 
            </p>
        </div>
        <!-- ��ư E -->	
		<!-- �׸��� BIND -->
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
