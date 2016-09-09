 
 <%@ include file="/include/head.jsp" %>
 
<html>
<head>
<script>
function init(){

	document.all.content2.innerHTML =  opener.document.all.sform.innerHTML;

	var table = document.getElementById("dataTable");
	table.setAttribute("align", "center");
	table.setAttribute("width", "720");
	
}

function f_print(){
	p_print.style.display="none";	

	window.print();
	p_print.style.display="";	
}


</script>

<style>
table{ border-spacing:0; border-collapse:collapse; }
:root table{ border-spacing:0; border-collapse:separate;  }
td,th {font-size:15px;line-height:22px; border: 1px solid;}
</style>



</head>
<body onload="init()">
 
	<div id= "content2">
	
	</div>
 
<div id="btn_area" align="right" style="width:100%">
	<p class="b_right" id="p_print" >
		<span class="btn_r btn_l" >
		<input type="button" onfocus="blur();" onmouseover="this.style.color='#cd1950'" onmouseout="this.style.color='#7d7f84'" value="Print" onclick="f_print()"/></span>  		
	</p>
</div>
			

</body>
</html>
