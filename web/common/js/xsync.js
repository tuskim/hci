/**
 * @(#) xsyc.js version v1.20 build a 320
 *
 *  Copyright(저작권) Do Not Erase This Comment!!! (이 주석문을 지우지 말것)
 *
 *  Do Not re-distribute with-out permission. especially out-side of LG-CNS.
 *  허가 없이 재배포 해서는 안된다. 특히 LG-CNS의 외부로 유출을 하여서는 안된다.
 *
 * AUTHORS LIST       E-MAIL                   HOMEPAGE
 * TK Shin            tkyushin@lgcns.com       http://www.javatoy.net
 */
 
if (!devon) var devon = {};

devon.xSync = function (url, method) {
    this.url = url;
    this.method = method ? method : devon.xSync.options.method;
    this.request = devon.xSync.getRequest();
    this.async = devon.xSync.options.asyncMode;
		this.loadLabel = devon.xSync.createLoadingLabel();
    this.query = "";
    this.param = new Array();
}

devon.xSync.createLoadingLabel = function() {
	var oSpan =  document.createElement("span");
//	oSpan.style.display = "none";
  oSpan.style.position = "absolute";
  oSpan.style.left = "0px";
  oSpan.style.top = "0px";
  oSpan.style.backgroundColor = "yellow";
  oSpan.innerHTML ="loading...";	
  return document.body.appendChild(oSpan);
}

devon.xSync.options = {
  debug            : false,
  mute             : false,
  nullToInitialize : true,
  method           : "POST", //test for get style
  reqContentType   : "application/x-www-form-urlencoded",
  resContentType   : "application/xml",
  readyState       : {"UNINITIALIZED" : 0, "LOADING" : 1, "LOADED" : 2, "INTERACTIVE" : 3, "COMPLETE" : 4},
  asyncMode        : true,
  progressbar      : false //** todo **
}

devon.xSync.messages = {
	"ERR001"   : "Server commnuication failed.",
	"ERR002"   : "Browser doesn't support XMLHttpRequest!",
	"ERR003"   : "devon.xSync object is exhausted.\nMake another instance via new devon.xSync(url)",
	"ERR004"   : "Resoponse content-type is \"\"\nIt should be \"" + devon.xSync.options.resContentType +"\"",
	"ERR005"   : "Resoponse content-type dismatched\nIt should be \"" + devon.xSync.options.resContentType +"\"",
	"ERR006"   : "Resoponse is empty",
	"PREFIX"   : "devon.xSync",
	"POSTFIX"  : "Please consult site manager!",
	"SEP"      : "===========================================\n"
}
	
devon.xSync.isXMLHttp = function (arg) {
	if (!arg) return false;
	if (devon.xSync.isie()  && (arg instanceof ActiveXObject) && (typeof(arg.readyState) != 'undefined')) return true;
  if (devon.xSync.isff() && (arg instanceof XMLHttpRequest) && (typeof(arg.readyState) != 'undefined')) return true;
	return false;
}

devon.xSync.getXMLHttpStatus = function(request) {
	if (!(devon.xSync.isXMLHttp(request))) return "";
	var message = "XMLHttpRequest information\n";
	message += "status : " + request.status ;
	if (request.status == "12029") message += " (connection to the server failed)";
	if (request.status == "404") message += " (Not found)";
	message += "\nreadyState :" + request.readyState; 
	if (request.getAllResponseHeaders()) message += "\nheaders:\n" + request.getAllResponseHeaders();
	return message;
}

devon.xSync.isie = function() {
	return window.ActiveXObject ? true : false;
}

devon.xSync.isff = function() {
	return window.XMLHttpRequest ? true : false;
}

devon.xSync.getMessage = function (code) {
	var message =  devon.xSync.messages[code];
	return devon.xSync.messages[code] ? devon.xSync.messages[code] : code;
}

devon.xSync.alert = function(arg, request) {
	if (devon.xSync.options.mute == true) return;
	var message = "";
	var code = "";
	var sep = devon.xSync.getMessage("SEP");
	if (typeof(arg) == "string") {
		message = devon.xSync.getMessage(arg);
		code = message == arg ? "ERR999" : arg;
		if (!message) message = arg;
	} else if (arg instanceof Error) {
		code =  "ERR" + ( arg.number & 0xFFFF);
		message = arg + "\n" + arg.description;
	} else {
		code = "EXCEPTION";
		message = arg;
	}
	
	if (request && devon.xSync.isXMLHttp(request)) {
		message += "\n" + sep + devon.xSync.getXMLHttpStatus(request);
	}
 	alert ("[" + code +"] on " + devon.xSync.messages["PREFIX"] +"\n" + sep + message + "\n" + sep +  devon.xSync.messages["POSTFIX"]);
}

devon.xSync.getRequest = function() {
  var request = null;
  if (devon.xSync.isie()) {
    try { request = new ActiveXObject('Msxml2.XMLHTTP'); } catch (e) {}
    if (!request) try { request = new ActiveXObject('Microsoft.XMLHTTP'); } catch (e) {}
  }
		
  if (!request && devon.xSync.isff())  {
    try { request = new XMLHttpRequest(); } catch (e) {}
  }
  
  if (request == null) devon.xSync.alert("ERR002");
  return request;
}

devon.xSync.prototype.fire = function() {
  if (!this.request) { return; }
  
  if (this.request.readyState != devon.xSync.options.readyState.UNINITIALIZED ) {
  	devon.xSync.alert("ERR003");
  	return;
  }
  try {
    var instance = this;

   	this.request.onreadystatechange = function() {
   		devon.xSync.onreadystatechange.call(instance);
   	}
    
    this.request.open(this.method, this.url, this.async);
    
    //** todo : check for more content-type
    //** todo : GET Method does not supporting.
    if (this.method == "POST") this.request.setRequestHeader('Content-Type', devon.xSync.options.reqContentType);
    
    //** spcial code for XecureWeb cipher
    if (document.XecureWeb)  {
      var path = getPath(this.url);
      var cipher = document.XecureWeb.BlockEnc(xgate_addr, path, this.query, "GET");
      this.request.send("q="+encodeURIComponent(cipher));
     } else {
      this.request.send(this.query);
     }

    if ( devon.xSync.isff() && !this.async) { // for fox sync mode call-back invoke
    	devon.xSync.onreadystatechange.call(instance);
    }
    
    } catch (e) { 
  	if (this.async || !devon.xSync.isie()) {
  		devon.xSync.alert(e, this.request);
  	}
  }
}

devon.xSync.onreadystatechange = function() {
  if (this.request.readyState == devon.xSync.options.readyState.COMPLETE) {
   	this.loadLabel.style.display = "none";
    if (this.request.status == 200 || this.request.status==0 ) {
      if (devon.xSync.options.debug) { alert (this.request.responseText); }
      this.callback.call(this);
    } else {
    	devon.xSync.alert("ERR001", this.request);
    }
  }
}

devon.xSync.prototype.callback  = function() {
	var contentType = this.request.getResponseHeader("Content-Type");
	if (contentType == null || contentType.indexOf(devon.xSync.options.resContentType) < 0) {
		var code = contentType == "" ? "ERR004" : "ERR005";
		if (devon.xSync.options.mute == true) return;
		devon.xSync.alert(code, this.request);
		if (contentType.indexOf("text/html") >= 0) {
			var oRemote = window.open("about:blank", "_blank");
			oRemote.document.write(this.request.responseText);
		}
		return;
	}
	
	var xmlDoc = this.request.responseXML.documentElement;
	
	if (xmlDoc == null) {
		devon.xSync.alert("ERR006", this.request);
		return;
	}
	
	var instance = this;
	var error = xmlDoc.getAttribute("error");
	if (error) {
		devon.xSync.alert(devon.xSync.getText(xmlDoc), this.request);
		return;
	}
	
  var until = xmlDoc.childNodes.length;
  var flag = true;
  
  for (var idx=0; idx < until; idx++) {
  	var peer = xmlDoc.childNodes[idx];
  	if (peer.nodeType != 1) continue;
  	if (devon.xSync.handler[peer.nodeName])  {
  		var json = devon.xSync.parse(peer);
  		if (json.onBeforeAction && devon.xSync.doAction(json.onBeforeAction, instance, json, instance, peer, xmlDoc) == false ) continue;
  		devon.xSync.handler[peer.nodeName].call(this, json, instance, peer, xmlDoc);
  		if (json.onAfterAction) devon.xSync.doAction(json.onAfterAction, instance, json, instance, peer, xmlDoc);
  	}
  }
  
  delete this.request;

}

devon.xSync.doAction  = function(execCmd, instance, param1, param2, param3, param4) {
	if (window[execCmd] && typeof(window[execCmd]) == "function") {
		var flag = window[execCmd].call(instance, param1, param2, param3, param4);
	}
	return flag;
}

devon.xSync.doAnchor  = function(href, target) {
  var oAnchor = document.createElement("A");
  oAnchor.href = href;
  if (target) oAnchor.target = target;
  document.body.insertBefore(oAnchor);
  oAnchor.click();
  delete oAnchor;	
}

devon.xSync.parse = function (xmlnode) {

	if (xmlnode.nodeType != 1) return null;
	var json = {};
	var until = xmlnode.attributes.length;
	for (var idx=0; idx < until; idx++) {
		var peer = xmlnode.attributes[idx];
		if (peer.nodeType != 2) continue;
		json[peer.nodeName] = devon.xSync.getText(peer);
	}
	
	json["$text"] = devon.xSync.getText(xmlnode);
	json["$name"] = xmlnode.nodeName;
	json["$nodes"] = new Array();
	
  var until = xmlnode.childNodes.length;
  var jsonLen = 0;
  
  for (var idx=0; idx < until; idx++) {
  	var peer =  xmlnode.childNodes[idx];
  	var parsed = devon.xSync.parse(peer);
  	if (!parsed) continue;

  	if (typeof(json[peer.nodeName]) == "undefined") {
  		 json[peer.nodeName] = new Array();
  		 json["$nodes"][json["$nodes"].length] = json[peer.nodeName];
  	}
  	json[peer.nodeName][json[peer.nodeName].length] = parsed;
  	
  }	
 
  
  json.toString = function() {
		return devon.xSync.getXml(xmlnode);
  }
  	
  return json;
}	

devon.xSync.getXml = function(oNode) {
	if (oNode.xml != undefined) {return oNode.xml;}
	else {
//		alert(oNode.nodeType);
//		var xml = "<" + oNode.tagName;
//		if (oNode.attributes) {
//			for (var idx=0; idx < oNode.attributes.length; idx++) {
//				xml += " " + oNode.attributes[idx].name + "=\"" + oNode.attributes[idx].value + "\"";
//			}
//		}
//		if (oNode.childNodes) {
//			xml += ">";
//			for (var idx=0; idx < oNode.childNodes.length; idx++) {
//				xml += devon.xSync.getXml(oNode.childNodes[idx]);
//			}
//			xml += "</" +oNode.tagName + ">";
//		} else {
//			xml += "/>";
//		}
		
	}
//	return xml;
}

devon.xSync.getText = function(oNode) {  
	var text = (oNode.text != undefined) ? oNode.text : oNode.textContent;
	if (text == "null" && devon.xSync.options.nullToInitialize == true) text = "";
	return text;
}

devon.xSync.handler = {};

devon.xSync.handler.select = function(json) {
	var otag = devon.xSync.$(json.id);
	if (!otag) {	
		devon.xSync.alert("HTML Tag not found for id \"" + json.id +  "\"");		
		return false;
	}
	var size = otag.length;
	if (json.clear == "true") {
  	for (var idx=0; idx < size ; idx++) otag.remove(0);	
	} else {
		var from = parseInt(json.clear);
		if ( from != "NaN") {
			for (var idx=from; idx < size ; idx++) otag.remove(from);	
		}
	}
	
	if (json.option) {
		var until = json.option.length;
		for (var idx=0; idx < until; idx++) {
   	 var option = new Option( json.option[idx].$text, json.option[idx].value );
   	 otag.options.add(option);
   	}			
	}
}

devon.xSync.handler.alert = function(json) {
	alert(json.$text);
}

devon.xSync.handler.LData = function(json) {}

devon.xSync.handler.LMultiData = function(json) {}

devon.xSync.handler.string = function(json) {}

devon.xSync.handler.innerHTML = function(json) {
	if (!json.cell) return;
	for (var idx=0; idx<json.cell.length; idx++) {
		var oCell = devon.xSync.$(json.cell[idx].id);
		try {
		if (oCell) oCell.innerHTML = json.cell[idx].$text;
		} catch (e) {}
	}
}

devon.xSync.handler.outerHTML = function(json) {
	if (!json.cell) return;
	for (var idx=0; idx<json.cell.length; idx++) {
		var oCell = devon.xSync.$(json.cell[idx].id);
		try {
		if (oCell) oCell.outerHTML = json.cell[idx].$text;
		} catch (e) {}
	}
}

devon.xSync.handler.inputSetter = function(json) {
	var oform = devon.xSync.$(json.id);
	if (!oform) {	
		devon.xSync.alert("HTML Tag not found for id \"" + json.id +  "\"");		
		return false;
	}
	
	if (!json.cell) return;
	for (var idx=0; idx<json.cell.length; idx++) {
		var oInput = oform[json.cell[idx].id];
		if (!oInput) continue;
			devon.xSync.setInputValue(oInput, json.cell[idx].$text);
	}
}

devon.xSync.setInputValue = function(oInput, value) {
	if (!oInput) return;
	var tagName = oInput.tagName;
	if (!tagName && oInput.length) {
			for (var idx=0; idx<oInput.length; idx++) {
				devon.xSync.setInputValue(oInput[idx], value);
			}		
	} else if (tagName == "INPUT" ||  tagName == "SELECT" || tagName == "TEXTAREA") {
		  switch (oInput.type) {
		    case "text" :  case "hidden" : case "password" : case "textarea" : 
		    case "select-one" : case "select-multiple" :
		      oInput.value = value;
		    break;
		    case "radio" :  case "checkbox" :
		    
//		    if (oInput.value == value) alert(oInput.value + ":" + value + ":" + 'matched');
		      oInput.checked = (oInput.value == value) ? true : false;
		    break;		
		  }
	} else {
		
	}
}
	
devon.xSync.$ = function(id) { 
	 
	if (arguments.length == 1 && typeof(id) == "string" ) return document.getElementById(id);
	
  var elements = new Array();
  for (var i = 0; i < arguments.length; i++) {
    var element = arguments[i];
    if (typeof element == 'string') { 
    	element = document.getElementById(element);
    }
    elements[elements.length] = element;
  }

  return elements;	
}

/* 
	todo : addQuery object
	- single tag (input, textarea, select
	- form tag (all inputs)
	- encodeURIComponent should be implemented for supporting less then IE 5.5
*/

devon.xSync.prototype.addQuery = function(name, value) {
  if (this.query) this.query += "&";
  this.query += encodeURIComponent(name) + "=" + encodeURIComponent(value);
}

/*

devon.xSync.handler.trIncreaser = function(json) {
	var sourceTable = devon.xSync.$(json.sid);
	var targetTable = devon.xSync.$(json.tid);

	if (json.clear) {
		var size = targetTable.tBodies[0].rows.length;
  	for (var idx=1; idx < size ; idx++) targetTable.tBodies[0].deleteRow(1);	
	}

	if (!json.tr) return;
	for (var idx=0; idx<json.tr.length; idx++) {
		var oTr = devon.xSync.cloneRow(sourceTable, targetTable);
		for (var jdx=0; jdx < oTr.cells.length; jdx++) {
			var tr = json.tr[idx];
			var td = tr[oTr.cells[jdx].id];
			oTr.cells[jdx].innerHTML = td[0].$text;//;
		}
	}
}

devon.xSync.cloneRow = function(osTable, otTable) {
	var oTR = osTable.tBodies[0].rows[0];
	var oNewTR = oTR.cloneNode(true);
	otTable.tBodies[0].appendChild(oNewTR);
//	if (xjosEnable == true) xjosiate(oNewTR);
	return oNewTR;
}

*/