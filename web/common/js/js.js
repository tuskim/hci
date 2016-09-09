/* body */
function allblur() { 
for (i = 0; i < document.links.length; i++)
document.links[i].onfocus = document.links[i].blur;}

/* jumpMenu */
function MM_jumpMenu(targ,selObj,restore){ //v3.0
  eval(targ+".location='"+selObj.options[selObj.selectedIndex].value+"'");
  if (restore) selObj.selectedIndex=0;
}
/* table */
function cellOver(el) {
el.style.backgroundColor="#F7F9E7";
}
function cellOut(el){
el.style.backgroundColor="#FFFFFF";
}
function cellOut2(el){
el.style.backgroundColor="";
}
/* btn over */
   function changeImg() 
   { 
      var img_id = event.srcElement.id; 

      event.srcElement.src = "../images/" + img_id + "_on.gif"; 
   } 

   function restoreImg() 
   { 
      var img_id = event.srcElement.id; 
      event.srcElement.src = "../images/" + img_id + ".gif"; 
   } 
   
   function changeonImg() 
   { 
      var img_id = event.srcElement.id; 
      event.srcElement.src = "../images/" + img_id + "_on.gif"; 
   } 
   
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_nbGroup(event, grpName) { //v6.0
  var i,img,nbArr,args=MM_nbGroup.arguments;
  if (event == "init" && args.length > 2) {
    if ((img = MM_findObj(args[2])) != null && !img.MM_init) {
      img.MM_init = true; img.MM_up = args[3]; img.MM_dn = img.src;
      if ((nbArr = document[grpName]) == null) nbArr = document[grpName] = new Array();
      nbArr[nbArr.length] = img;
      for (i=4; i < args.length-1; i+=2) if ((img = MM_findObj(args[i])) != null) {
        if (!img.MM_up) img.MM_up = img.src;
        img.src = img.MM_dn = args[i+1];
        nbArr[nbArr.length] = img;
    } }
  } else if (event == "over") {
    document.MM_nbOver = nbArr = new Array();
    for (i=1; i < args.length-1; i+=3) if ((img = MM_findObj(args[i])) != null) {
      if (!img.MM_up) img.MM_up = img.src;
      img.src = (img.MM_dn && args[i+2]) ? args[i+2] : ((args[i+1])? args[i+1] : img.MM_up);
      nbArr[nbArr.length] = img;
    }
  } else if (event == "out" ) {
    for (i=0; i < document.MM_nbOver.length; i++) {
      img = document.MM_nbOver[i]; img.src = (img.MM_dn) ? img.MM_dn : img.MM_up; }
  } else if (event == "down") {
    nbArr = document[grpName];
    if (nbArr)
      for (i=0; i < nbArr.length; i++) { img=nbArr[i]; img.src = img.MM_up; img.MM_dn = 0; }
    document[grpName] = nbArr = new Array();
    for (i=2; i < args.length-1; i+=2) if ((img = MM_findObj(args[i])) != null) {
      if (!img.MM_up) img.MM_up = img.src;
      img.src = img.MM_dn = (args[i+1])? args[i+1] : img.MM_up;
      nbArr[nbArr.length] = img;
  } }
}

/* btn */
function btnOver(el) {
el.style.color="#0088D4";
}
function btnOut(el){
el.style.color="#2359A3";
}

function btnsOver(el) {
el.style.color="#000000";
}
function btnsOut(el){
el.style.color="#615C1C";
}

function seayOver(el) {
el.style.color="#000000";
}
function seayOut(el){
el.style.color="#FFFFFF";
}
function seaOver(el) {
el.style.color="#000000";
}
function seaOut(el){
el.style.color="#FFFFFF";
}
/* left_menu */
function js_menu(menuName, num) {
		if (eval(menuName + ".style.display != 'none'")) 
					js_menuhide(menuName, num);
		else js_menushow(menuName, num);			
}

function js_menushow(menuName, num) {
		eval(menuName + ".style.display = 'block'");
		eval("img" + num + ".src='../images/left_open.gif'");
}

function js_menuhide(menuName, num) {
		eval(menuName + ".style.display = 'none'");
		eval("img" + num + ".src='../images/left_close.gif'");
}
/* radio */
function MM_goToURL() { //v3.0
  var i, args=MM_goToURL.arguments; document.MM_returnValue = false;
  for (i=0; i<(args.length-1); i+=2) eval(args[i]+".location='"+args[i+1]+"'");
}