/**
 * @(#) xjos.js version v3.21 korean(엑조스3) build a 200
 *
 *  Copyright(저작권) Do Not Erase This Comment!!! (이 주석문을 지우지 말것)
 *  
 *  This xjos.js and xjos.css is used for making easy to validate form fields
 *  to develop enterprise web application.
 *  Some functionality does not works in Netscape, so use Internet Explorer is recommanded.
 *  for detailed function lists and references, see user's guide and developer's guide at http://www.lafj.net
 *  Do Not re-distribute with-out permission. especially out-side of LG-CNS.
 *  
 *  이 xjos.js 및 xjos.css는 DHTML과 J-스크립트를 이용하여 기업환경
 *  웹 응용프로그램에서의 폼 필드 유효성 검사를 쉽게 하는데 사용된다.
 *  일부기능은 넷스케이프에서 작동되지 않을수도 있으며 익스플로를 사용하는것을 권장한다.
 *  각 펑션등에 대한 자세한 설명은 http://www.lafj.net의 사용자 가이드 및 개발자 가이드를 참고하라.
 *  허가 없이 재배포 해서는 안된다. 특히 LG-CNS의 외부로 유출을 하여서는 안된다.
 *  
 * AUTHORS LIST       E-MAIL                   HOMEPAGE
 * SungJo Kim         javalife@korea.com       http://
 * Park Su hyun       shypark@lgcns.com        http://
 * TK Shin            lovemine@nownuri.net     http://www.lovemine.pe.kr
 */
var xa_option_table = new Array(
 new Array("X_ACTIVATE", true ),
 new Array("X_VALIDATION_ACTIVATE", true ),
 new Array("X_SUPPORT_HIDDEN_TYPE", false ),
 new Array("X_SHOW_ELAPS", false ),
 new Array("X_CSS_PLAINED", true),
 new Array("X_REQUIRED_IGNORE_WHITESPACE", true ),
 new Array("X_ERASE_VALUE_ON_DISABLE", true ),
 new Array("X_VALIDATE_ON_MASK", true ),
 new Array("X_VALIDATE_ON_HIDE", false ),
 new Array("X_VALIDATE_ON_READONLY", false ),
 new Array("X_ONSUBMIT_EVENT_ACTIVATE", true ),
 new Array("X_DYNAMIC_SEND_VALUE", true),
 new Array("X_ALLOW_MULTI_CREATE", false),
 new Array("X_DISABLE_SUBMIT_ON_SUBMIT", true),
 new Array("X_DISABLE_SUBMIT_TIMEOUT", 3000), //in MilliSeconds
 new Array("X_FOCUS_THIS_USE_TIME_OUT", true), //in MilliSeconds
 new Array("X_DISABLE_ON_HIDE", true),
 new Array("X_MAGIC_QUOTE_ON", false),
 new Array("X_COLOR_SET_USE_CSS", false),
 new Array("X_ESCAPE_ON", false),
 new Array("X_NEXT_FOCUS_ON_ENTER", false),
 new Array("X_SKIN_DIR", "../../bin/"),
 new Array("X_SPECIAL_CHAR", /(\(|\)|\[|\]|\{|\}|\<|\>|\"|\'|\`|\~|\$|\!|\#|\%|\^|\&|\@|\,|\.|\;|\:|\\|\/|\||\*|\=|\-|\?)*/g), // ( ) [ ] { } < > " ' ` ~ $ ! # % ^ & @ , . ; : \ / | * = - ?
 new Array("X_DELIMITER_CHAR", /(\,|\.|\/|\$|\^|\*|\(|\)|\+|\.|\?|\\|\{|\}|\||\[|\]|-|:)/g), // ,./$^*()+.?\{}|[]-:
 new Array("X_WHITE_SPACE_CHAR", /\s/g ),
 new Array("X_WHITE_SPACE_REGEXP", /^[\s]*$/ ),
 new Array("X_ALPHA_FILTER", "[a-zA-Z]" ),
 new Array("X_ALPHA_REGEXP", /^[a-zA-Z]+$/ ),
 new Array("X_NUM_FILTER", "[0-9]" ),
 new Array("X_NUM_REGEXP", /^[0-9]+$/ ),
 new Array("X_ALNUM_FILTER", "[A-Za-z0-9]" ),
 new Array("X_ALNUM_REGEXP", /^[A-Za-z0-9]+$/ ),
 new Array("X_INTEGER_FILTER", "[0-9\\-\\+]" ),
 new Array("X_INTEGER_REGEXP", /^(\+|\-|\d*)\d+$/ ),
 new Array("X_FLOAT_FILTER", "[0-9\\.\\-\\+]" ),
 new Array("X_FLOAT_REGEXP", /^(\-|\+|\d*)\d+(\.|\d)\d*$/ ),
 new Array("X_HEXA_FILTER", "[\\+\\-a-fA-F0-9]"),
 new Array("X_HEXA_REGEXP", /^(\+|\-|[a-fA-F0-9]*)[a-fA-F0-9]+$/),
 new Array("X_DATE_MASK", "9999/99/99"),
 new Array("X_PSN_MASK", "999999-9999999"),
 new Array("X_CSN_MASK", "999-99-99999"),
 new Array("X_DDD", "02,031,032,033,041,042,043,051,052,053,054,055,061,062,063,064,080,0502,0505"),
 new Array("X_HPD", "011,016,017,018,019,0130")
);
var xa_support_matrix = new Array(
 new Array("plain_box", 1, "xo_plain_box", "text,password,textarea,file,submit,button,reset"),
 new Array("enter_move_focus", 1, "xo_enter_move_focus", "text,password,radio,checkbox,select-one,select-multiple,file,button,reset"),
 new Array("required", 1, "xo_required", "text,password,textarea,radio,checkbox,file"),
 new Array("itemname", 2, "xo_item_name", "text,password,textarea,file,checkbox"),
 new Array("minlength", 2, "xo_min_length", "text,password,textarea,file"),
 new Array("maxbyte", 2, "xo_max_byte", "text,password,textarea,file"),
 new Array("minbyte", 2, "xo_min_byte", "text,password,textarea,file"),
 new Array("maxvalue", 2, "xo_max_value", "text,password"),
 new Array("minvalue", 2, "xo_min_value", "text,password"),
 new Array("filter", 2, "xo_filter", "text,password,textarea"),
 new Array("mask", 2, "xo_mask", "text"),
 new Array("alphabetic", 1, "xo_alphabetic", "text,password"),
 new Array("numeric", 1, "xo_numeric", "text,password"),
 new Array("alpha_numeric", 1, "xo_alpha_numeric", "text,password"),
 new Array("integer", 1, "xo_integer", "text,password"),
 new Array("float", 1, "xo_float", "text,password"),
 new Array("hexa", 0, "xo_hexa", "text,password"),
 new Array("money", 1, "xo_money", "text"),
 new Array("dollar", 1, "xo_dollar", "text"),
 new Array("date", 1, "xo_date", "text"),
 new Array("psn", 1, "xo_psn", "text,password"),
 new Array("csn", 1, "xo_csn", "text,password"),
 new Array("credit_card", 1, "xo_credit_card", "text,password"),
 new Array("email", 1, "xo_email", "text"),
 new Array("advanced_email", 1, "xo_advanced_email", "text"),
 new Array("domain", 1, "xo_domain", "text"),
 new Array("reg_exp", 2, "xo_reg_exp", "text,password"),
 new Array("ime", 2, "xo_ime", "text,password,textarea"),
 new Array("auto_focus", 1, "xo_auto_focus", "text,password"),
 new Array("trim", 3, "xo_trim", "text,password,textarea,file"),
 new Array("strip_special_char", 1, "xo_strip_special_char", "text,password,textarea"),
 new Array("strip_white_space", 1, "xo_strip_white_space", "text,password,textarea"),
 new Array("edit_align", 2, "xo_edit_align", "text,password,textarea"),
 new Array("is_value", 2, "xo_is_value", "text,password"),
 new Array("readonly_this", 1, "xo_readonly_this", "text,password,textarea"),
 new Array("focus_this", 1, "xo_focus_this", "text,password,textarea,radio,checkbox,select-one,select-multiple,file,submit,button,reset"),
 new Array("show_this", 1, "xo_show_this", "text,password,textarea,radio,checkbox,select-one,select-multiple,file,submit,button,reset"),
 new Array("hide_this", 1, "xo_hide_this", "text,password,textarea,radio,checkbox,select-one,select-multiple,file,submit,button,reset"),
 new Array("disable_this", 1, "xo_disable_this", "text,password,textarea,radio,checkbox,select-one,select-multiple,file,submit,button,reset"),
 new Array("enable_fields", 2, "xo_enable_fields", "text,password,textarea,radio,checkbox,select-one,select-multiple,file"),
 new Array("disable_fields", 2, "xo_disable_fields", "text,password,textarea,radio,checkbox,select-one,select-multiple,file"),
 new Array("show_fields", 2, "xo_show_fields", "text,password,textarea,radio,checkbox,select-one,select-multiple,file"),
 new Array("hide_fields", 2, "xo_hide_fields", "text,password,textarea,radio,checkbox,select-one,select-multiple,file"),
 new Array("status_bar", 2, "xo_status_bar", "text,password,textarea,radio,checkbox,select-one,select-multiple,file,submit,button,reset"),
 new Array("balloon", 2, "xo_balloon", "text,password,textarea,radio,checkbox,select-one,select-multiple,file,submit,button,reset"),
 new Array("send_value", 2, "xo_send_value", "submit"),
 new Array("lable", 1, "xo_lable", "text"),
 new Array("alter", 2, "xo_alter", "text,password,textarea,radio,checkbox,file"),
 new Array("sync", 2, "xo_sync", "text,password,radio,checkbox,select-one"),
 new Array("selected_duih", 1, "xo_selected_duih", "select-one,select-multiple"),
 new Array("ddd", 1, "xo_ddd", "text,select-one"),
 new Array("hpd", 1, "xo_hpd", "text,select-one")
);
var xa_messages_table = new Array(
 new Array("itemname", 0, "An error occured in input data : field [@].\n\n"),
 new Array("required", 0, "The field should not be empty. Please fill the field."),
 new Array("minlength", 0, "The length of the value is too short. \nIt should be more than @."),
 new Array("maxbyte", 0, "The length of the value is too long. \nIt should be less than @."),
 new Array("minbyte", 0, "The length of the value is too short. \nIt should be more than @."),
 new Array("maxbyte_utf8", 0, "The length of the value is too long. \nIt should be less than @."),
 new Array("minbyte_utf8", 0, "The length of the value is too short. \nIt should be more than @."),
 new Array("maxvalue", 0, "The value, [@] is too large. \nIt should be less than @."),
 new Array("minvalue", 0, "The value, [@] is too small. \nIt should be more than @."),
 new Array("alphabetic", 0, "It's not alphabetic. Please enter alphabet-only."),
 new Array("alpha_numeric", 0, "It's neither alphabetic nor numeric. Please enter alphanumeric-only."),
 new Array("numeric", 0, "It's not numeric. Please enter numeric-only."),
 new Array("money", 0, "It's not money-formatted. Please re-enter the value."),
 new Array("integer", 0, "It's not integer-formatted. Please re-enter the value."),
 new Array("float", 0, "It's not float-formatted. Please re-enter the value."),
 new Array("hexa", 0, "It's not hexa-formatted. Please re-enter the value."),
 new Array("is_value", 0, "xJos says :\nWrong usage of is_value() in [@]. \nCan't find an object such as [@]."),
 new Array("is_value", 1, "xJos says :\nWrong usage of is_value() in [@]. \nThere's no value in the object such as [@]."),
 new Array("is_value", 2, "[@]'s value does not match with [@]'s value."),
 new Array("mask", 0, "Invalid format. \nThe value should be matched with [@] format."),
 new Array("date", 0, "Please enter a valid date value."),
 new Array("psn", 0, "Please enter a valid Personal Registration Number."),
 new Array("csn", 0, "Please enter a valid Company Registration Number."),
 new Array("credit_card", 0, "Please enter a valid Credit Card Number."),
 new Array("email", 0, "Please enter a valid email address."),
 new Array("advanced_email", 0, "Please enter a valid email address."),
 new Array("advanced_email", 1, "Please enter a valid email address. \nThere is an invalid character in user name part."),
 new Array("advanced_email", 2, "Please enter a valid email address. \nThere is an invalid character in domain name part."),
 new Array("advanced_email", 3, "Please enter a valid email address. \nUser name is wrong."),
 new Array("advanced_email", 4, "Please enter a valid email address. \nIP address is wrong."),
 new Array("advanced_email", 5, "Please enter a valid email address. \nDomain name is wrong."),
 new Array("advanced_email", 6, "Please enter a valid email address. \nDomain name is not well-known."),
 new Array("advanced_email", 7, "Please enter a valid email address. \nThere's no host name."),
 new Array("domain", 0, "Please enter a valid domain address."),
 new Array("reg_exp", 0, "It doesn't match with regular expression. \nThe value should be suitable to @."),
 new Array("ddd", 0, "@ is not a right DDD prefix."),
 new Array("hpd", 0, "@ is not a right cellular phone prefix.")
);
function sm_trim() { return this.replace(/^\s*/ ,"").replace(/\s*$/ ,""); }
function sm_left_trim() { return this.replace(/^\s*/,""); }
function sm_right_trim() { return this.replace(/\s*$/,""); }
function sm_strip_white() { return this.replace(window.xGetOption("X_WHITE_SPACE_CHAR"),""); }
function sm_strip_special() { return this.replace(window.xGetOption("X_SPECIAL_CHAR"),""); }
function sm_set_magic_quote() { return this.replace(/\\/ig ,"\\\\").replace(/\'/ig ,"\\'").replace(/\"/ig ,"\\\"").replace(/\NUL/ig ,"\\NUL"); }
function sm_unset_magic_quote() { return this.replace(/\\\"/ig ,"\"").replace(/\\'/ig ,"\'").replace(/\\\\/ig ,"\\").replace(/\\NUL/ig ,"\NUL"); }
function sm_is_num (){ return (this.toString() && !/\D/.test(this)); }
function sm_get_byte() { var len = 0;
 for (var idx=0 ; idx < this.length ; idx++, len++) { if ( (this.charCodeAt(idx)<0) || (this.charCodeAt(idx)>127) ) len ++; //add extra length
 }
 return len;
}
function sm_get_url_composite_array(mainsep, subsep) { var my_array = new Array;
 var ss = this.split(mainsep);
 for(var idx=0; idx < ss.length ; idx++) { if ( ss[idx] == "" ) continue;
 var tt = ss[idx].split(subsep);
 my_array[idx] = new Array (tt[0], tt[1]);
 }
 return my_array;
}
function sm_substitute_at(substitute) { var target = this;
 var substituteArr = substitute.split(",");
 for (var idx=0; idx<substituteArr.length; idx++) { target = target.replace(/@/i, substituteArr[idx]);
 }
 return target;
}
String.prototype.trim = sm_trim;
String.prototype.lTrim = sm_left_trim;
String.prototype.rTrim = sm_right_trim;
String.prototype.stripWhite = sm_strip_white;
String.prototype.stripSpecial = sm_strip_special;
String.prototype.setMagicQuote = sm_set_magic_quote;
String.prototype.unsetMagicQuote = sm_unset_magic_quote;
String.prototype.isNum = sm_is_num;
String.prototype.getByte = sm_get_byte;
String.prototype.getUrlCompositeArray = sm_get_url_composite_array;
String.prototype.substituteAt = sm_substitute_at;
function am_has_value(key) { for (var idx=0 ; idx < this.length ; idx++) { if ( this[idx] == key ) return true;
 }
 return false;
}
function am_get_index(key) { for (var idx=0 ; idx < this.length ; idx++) { if ( this[idx] == key ) return idx;
 }
 return false;
}
function am_has_hash_value(key) { if ( !(this[0] instanceof Array) ) return false;
 for (var idx=0 ; idx < this.length ; idx++) { if (this[idx][0] == key) return true;
 }
 return false;
}
function am_get_hash_index(key) { if ( !(this[0] instanceof Array) ) return false;
 for (var idx=0 ; idx < this.length ; idx++) { if (this[idx][0] == key) return idx;
 }
 return false;
}
function am_get_hash_value(key, index) { if ( !(this[0] instanceof Array) ) return false;
 for (var idx=0 ; idx < this.length ; idx++) { if (this[idx][0] == key) return this[idx][index];
 }
 return false;
}
function am_get_composite_hash_index(key0, key1) { if ( !(this[0] instanceof Array) ) return false;
 for (var idx=0 ; idx < this.length ; idx++) { if (this[idx][0] == key0 && this[idx][1] == key1) return idx;
 }
 return false;
}
function am_get_composite_hash_value(key0, key1, index) { if ( !(this[0] instanceof Array) ) return false;
 for (var idx=0 ; idx < this.length ; idx++) { if (this[idx][0] == key0 && this[idx][1] == key1) return this[idx][index];
 }
 return false;
}
function am_get_url_composite_string(mainsep, subsep) { if ( !(this[0] instanceof Array) ) return false;
 var rtnStr = "";
 for(var idx=0; idx < this.length ; idx++) { rtnStr += this[idx].join(subsep);
 if ( (idx + 1)!= this.length ) rtnStr += mainsep;
 }
 return rtnStr;
}
function am_copy_to_form(formObj, names) { if ( !(this[0] instanceof Array) ) return false;
 if ( typeof(formObj) == 'string') return false;
 var namesArr = (names) ? names.split(",") : null;
 for (var idx=0 ; idx < this.length ; idx++) { if (namesArr) { for (var jdx=0; jdx < namesArr.length; jdx++) { if (this[idx][0] == namesArr[jdx])
 formObj.createHidden(this[idx][0], this[idx][1]);
 }
 }else { formObj.createHidden(this[idx][0], this[idx][1]);
 }
 }
 return ;
}
Array.prototype.hasValue = am_has_value;
Array.prototype.getIndex = am_get_index;
Array.prototype.hasHashValue = am_has_hash_value;
Array.prototype.getHashIndex = am_get_hash_index;
Array.prototype.getHashValue = am_get_hash_value;
Array.prototype.getCompositeHashIndex = am_get_composite_hash_index;
Array.prototype.getCompositeHashValue = am_get_composite_hash_value;
Array.prototype.getUrlCompositeString = am_get_url_composite_string;
Array.prototype.copyToForm = am_copy_to_form;
function pm_is_attribute(attr) { return ( this.getAttribute(attr) != null ) ? true : false; }
function pm_is_attribute_value(attr) { return ( this.getAttribute(attr) ) ? true : false; }
function pm_has_css(attr) { if (!this.isAttrValue("className")) return false;
 var classArr = this.getAttribute("className").split(" ");
 return classArr.hasValue(attr);
}
function pm_set_css(attr) { if (!this.isAttrValue("className")) { this.setAttribute("className", attr);
 return;
 }
 var classArr = this.getAttribute("className").split(" ");
 if (!classArr.hasValue(attr)) { classArr[classArr.length] = attr;
 this.setAttribute("className", classArr.join(" "));
 }
}
function pm_unset_css(attr) { if (!this.isAttrValue("className")) return;
 var classArr = this.getAttribute("className").split(" ");
 var newClassArr = new Array;
 for ( var idx=0; idx<classArr.length; idx++) { if ( classArr[idx] != attr ) newClassArr[newClassArr.length] = classArr[idx];
 }
 this.setAttribute("className", newClassArr.join(" "));
 delete newClassArr;
}
function em_initialize(parent) { //attribute
 this.parent = parent; //parentNode/form/parentElement
 this.xObject = new Array; //dynamically attached x object array
 this.oldValue = null;
 this.bgColor = this.style.backgroundColor;
 this.xFilter = "";
 this.xMask = "";
 this.impotence = false;
 this.alterObjs = new Array; //for altering validation
 //methods
 this.get = em_get;
 this.set = em_set;
 //this.has = em_has; //element의 중요 속성값이 주어진 값과 일치하는지를 검사한다.
 this.clear = em_clear;
 this.hasValue = em_has_value; //element의 value가 주어진 values중에 있는지 검사한다.
 this.getValue = em_get_value;
 this.setValue = em_set_value;
 this.store = em_store;
 this.restore = em_restore;
 this.getUnmasked = em_get_un_masked;
 this.setBgColor = em_set_bg_color;
 this.unsetBgColor = em_unset_bg_color;
 this.isAttribute = pm_is_attribute;
 this.isAttrValue = pm_is_attribute_value;
 this.hasCss = pm_has_css;
 this.setCss = pm_set_css;
 this.unsetCss = pm_unset_css;
 this.disable = em_disable;
 this.enable = em_enable;
 this.show = em_show;
 this.hide = em_hide;
 this.setReadOnly = em_set_readonly;
 this.unsetReadOnly = em_unset_readonly
 this.setCheck = em_set_check;
 this.unsetCheck = em_unset_check;
 this.callValueMethod = em_call_value_method;
 this.valueTrim = em_trim;
 this.leftTrim = em_left_trim;
 this.rightTrim = em_right_trim;
 this.stripWhite = em_strip_white;
 this.stripSpecial = em_strip_special;
 this.setMagicQuote = em_set_magic_quote;
 this.unsetMagicQuote = em_unset_magic_quote;
 this.setEscape = em_set_escape;
 this.unsetEscape = em_unset_escape;
 this.getNextFocus = em_get_next_focus;
 this.getPrevFocus = em_get_prev_focus;
 this.amIhide = em_am_i_hide;
 this.setFilter = em_set_filter;
 this.setMask = em_set_mask;
 this.masking = null;
 this.unMasking = null;
 this.createObject = em_create_object;
 this.attachX = em_attach_x_object;
 this.detachX = em_detach_x_object;
 this.validate = em_validate;
 this.alterValidate = em_alter_validate;
 this.alert = em_alert;
 //xjos engines method
 this.xFactory = em_x_facotry;
 this.addXObj = em_add_x_obj;
 this.clearX = em_clear_x;
 
 //binding events (delegate to xJos Object)
 this.eventHandler = em_event_handler;
 this.detachEvent("onkeypress", this.eventHandler);
 this.detachEvent("onkeyup", this.eventHandler);
 this.detachEvent("onkeydown", this.eventHandler);
 this.detachEvent("onfocus", this.eventHandler);
 this.detachEvent("onblur", this.eventHandler);
 this.detachEvent("onchange", this.eventHandler);
 this.detachEvent("onclick", this.eventHandler);
 this.detachEvent("onmouseover", this.eventHandler);
 this.detachEvent("onmouseout", this.eventHandler);
 this.attachEvent("onkeypress", this.eventHandler);
 this.attachEvent("onkeyup", this.eventHandler);
 this.attachEvent("onkeydown", this.eventHandler);
 this.attachEvent("onfocus", this.eventHandler);
 this.attachEvent("onblur", this.eventHandler);
 this.attachEvent("onchange", this.eventHandler);
 this.attachEvent("onclick", this.eventHandler);
 this.attachEvent("onmouseover", this.eventHandler);
 this.attachEvent("onmouseout", this.eventHandler);
 this.preventFocusHandler = ee_prevent_focus_handler;
 //initialize
 this.xFactory();
}
function em_get() { var rtnValue = null;
 switch (this.type) { case "text" : case "password" : case "textarea" :
 case "file" : case "hidden" :
 rtnValue = this.value;
 break;
 case "select-one" :
 rtnValue = this.selectedIndex
 break;
 case "select-multiple" :
 var selectedArr = new Array;
 for (var idx=0; idx<this.options.length; idx++) { if (this.options[idx].selected) { selectedArr[selectedArr.length] = idx;
 }
 }
 rtnValue = selectedArr;
 break;
 case "radio" : case "checkbox" :
 rtnValue = this.checked;
 break;
 }
 return rtnValue;
}
function em_set(setValue) { switch (this.type) { case "text" : case "password" : case "textarea" :
 case "file" : case "hidden" :
 this.value = setValue;
 break;
 case "select-one" :
 this.selectedIndex = setValue;
 break;
 case "select-multiple" :
 for (var idx=0; idx< setValue.length ; idx++) { this.options[setValue[idx]].selected = true;
 }
 break;
 case "radio" : case "checkbox" :
 this.checked = setValue;
 break;
 }
}
function em_clear() { switch (this.type) { case "text" : case "password" : case "textarea" :
 case "file" : case "hidden" :
 this.value = "";
 break;
 case "select-one" :
 this.selectedIndex = -1;
 break;
 case "select-multiple" :
 for (var idx=0; idx<this.options.length; idx++) { this.options[idx].selected = false;
 }
 break;
 case "radio" : case "checkbox" :
 this.checked = false;
 break;
 }
}
function em_has_value(values) { var valuesArr = new Array;
 var rtnValue = false;
 if (values) valuesArr = values.split(",");
 switch (this.type) { case "text" : case "password" : case "textarea" :
 case "file" : case "hidden" :
 if (values) { rtnValue = valuesArr.hasValue(this.value);
 } else { rtnValue = this.value.length > 0 ? true : false;
 }
 break;
 case "select-one" : case "select-multiple" :
 if (values) { for (var idx=0; idx<this.options.length; idx++) { if ( valuesArr.hasValue(this.options[idx].value) && this.options[idx].selected)
 rtnValue = true;
 }
 } else { if ( this.selectedIndex != -1 && this.options[this.selectedIndex].value != "") rtnValue = true;
 }
 break;
 case "radio" : case "checkbox" :
 if (values) { if (valuesArr.hasValue(this.value) && this.checked) rtnValue = true;
 } else { rtnValue = this.checked;
 }
 break;
 }
 return rtnValue;
}
function em_get_value() { var rtnValue = null;
 switch (this.type) { case "text" : case "password" : case "textarea" :
 case "file" : case "hidden" :
 rtnValue = this.value;
 break;
 case "select-one" :
 rtnValue = this.options[this.selectedIndex].value;
 break;
 case "select-multiple" :
 var selectedArr = new Array;
 for (var idx=0; idx<this.options.length; idx++) { if (this.options[idx].selected) { selectedArr[selectedArr.length] = this.options[idx].value;
 }
 }
 rtnValue = selectedArr;
 break;
 case "radio" : case "checkbox" :
 if (this.checked) rtnValue = this.value;
 break;
 }
 return rtnValue;
}
function em_set_value(setValue) { switch (this.type) { case "text" : case "password" : case "textarea" :
 case "file" : case "hidden" :
 this.value = setValue;
 break;
 case "select-one" :
 for (var idx=0; idx<this.options.length; idx++) { if (this.options[idx].value == setValue)
 this.selectedIndex = idx;
 }
 break;
 case "select-multiple" :
 for (var idx=0; idx<this.options.length; idx++) { if (setValue.hasValue(this.options[idx].value))
 this.options[idx].selected = true;
 }
 break;
 case "radio" : case "checkbox" :
 if (this.value == setValue) this.checked = true;
 break;
 }
}
function em_store() { this.oldValue = this.get();
}
function em_restore() { if (this.oldValue == null) return;
 this.set(this.oldValue);
 this.oldValue = null;
}
function em_set_bg_color(newColor, newCss) { if (window.xGetOption("X_COLOR_SET_USE_CSS")) this.setCss(newCss)
 else this.style.backgroundColor = newColor;
}
function em_unset_bg_color(oldCss) { if (window.xGetOption("X_COLOR_SET_USE_CSS")) this.unsetCss(oldCss)
 else this.style.backgroundColor = this.bgColor;
}
function em_disable() { if (this.getAttribute("disabled")) return;
 this.setAttribute("disabled",true);
 switch (this.type) { case "text" : case "password" : case "textarea" :
 case "file" : case "image" :
 case "select-one" : case "select-multiple" :
 case "radio" : case "checkbox" :
 if (window.xGetOption("X_ERASE_VALUE_ON_DISABLE")) { this.store(); this.clear();
 }
 this.setBgColor("#cccccc", "xjs_disable");
 break;
 case "button" : case "submit" : case "reset" :
 this.setBgColor("#cccccc", "xjs_disable");
 break;
 default :
 break;
 }
 this.impotence = true;
}
function em_enable() { if (!this.getAttribute("disabled")) return;
 this.removeAttribute("disabled");
 switch (this.type) { case "text" : case "password" : case "textarea" :
 case "file" : case "image" :
 case "select-one" : case "select-multiple" :
 case "radio" : case "checkbox" :
 if (window.xGetOption("X_ERASE_VALUE_ON_DISABLE")) { this.restore();
 }
 this.unsetBgColor("xjs_disable");
 break;
 case "button" : case "submit" : case "reset" :
 this.unsetBgColor("xjs_disable");
 break;
 }
 this.impotence = false;
}
function em_show() { // use this.style.visibility visible/hidden if postion blocked.
 if (this.hasCss("xjs_show")) return;
 if (window.xGetOption("X_DISABLE_ON_HIDE")) this.enable();
 this.unsetCss("xjs_hide");
 this.setCss("xjs_show");
}
function em_hide() { if (this.hasCss("xjs_hide")) return;
 this.unsetCss("xjs_show");
 this.setCss("xjs_hide");
 if ( window.xGetOption("X_DISABLE_ON_HIDE")) this.disable();
}
function em_set_readonly() { if ( this.readOnly || this.getAttribute("disabled") || this.hasCss("xjs_hide")) return;
 switch (this.type) { case "text" :
 case "password" :
 case "textarea" :
 this.readOnly = true;
 this.setBgColor("#FFFFCC", "xjs_readonly");
 this.detachEvent("onfocus", this.preventFocusHandler);
 this.attachEvent("onfocus", this.preventFocusHandler);
 break;
 }
}
function em_unset_readonly() { if ( !this.readOnly ) return;
 switch (this.type) { case "text" :
 case "password" :
 case "textarea" :
 this.readOnly = false;
 this.unsetBgColor("xjs_readonly");
 this.detachEvent("onfocus", this.preventFocusHandler);
 break;
 }
}
function em_set_check() { switch (this.type) { case "checkbox" :
 case "radio" :
 this.checked = true;
 break;
 }
}
function em_unset_check() { switch (this.type) { case "checkbox" :
 case "radio" :
 this.checked = false;
 break;
 }
}
function em_call_value_method(func) { if ( ( this.type != "button" && this.type != "submit" && this.type != "reset" ) && this.value)
 this.value = eval("this.value." + func + "()");
}
function em_trim() { this.callValueMethod("trim"); }
function em_left_trim() { this.callValueMethod("lTrim"); }
function em_right_trim() { this.callValueMethod("rTrim"); }
function em_strip_white() { this.callValueMethod("stripWhite"); }
function em_strip_special() { this.callValueMethod("stripSpecial"); }
function em_set_magic_quote() { this.callValueMethod("setMagicQuote"); }
function em_unset_magic_quote() { this.callValueMethod("unsetMagicQuote"); }
function em_set_escape() { if ( ( this.type != "button" && this.type != "submit" && this.type != "reset" ) && this.value)
 this.value = escape(this.value);
}
function em_unset_escape() { if ( ( this.type != "button" && this.type != "submit" && this.type != "reset" ) && this.value)
 this.value = unescape(this.value);
}
function em_get_next_focus(objname) { if (this.parent.elements.length == 1 && this==this.parent.elements[0]) return this;
 var selfIndex = 0;
 for (var idx=0; idx < this.parent.elements.length; idx++) { if (this.parent.elements[idx] == this) selfIndex = idx;
 }
 do { selfIndex ++;
 if (selfIndex >= this.parent.elements.length) selfIndex = 0;
 var focusObj = this.parent.elements[selfIndex];
 if ( focusObj == this) break;
 if (objname && focusObj.name && focusObj.name == objname) break;
 } while ( typeof(focusObj) == 'undefined' || focusObj.tagName == "OBJECT" ||
 ( focusObj.type && focusObj.type=='hidden') ||
 focusObj.readOnly ||
 ( focusObj.getAttribute && focusObj.getAttribute("disabled")) ||
 ( focusObj.amIhide && focusObj.amIhide()) ||
 ( objname && focusObj.name && focusObj.name != objname )
 );
 return focusObj;
}
function em_get_prev_focus(objname) { if (this.parent.elements.length == 1 && this==this.parent.elements[0]) return this;
 var selfIndex = 0;
 for (var idx=0; idx < this.parent.elements.length; idx++) { if (this.parent.elements[idx] == this) selfIndex = idx;
 }
 do { selfIndex --;
 if (selfIndex < 0 ) selfIndex = this.parent.elements.length - 1 ;
 var focusObj = this.parent.elements[selfIndex];
 if ( focusObj == this) break;
 if (objname && focusObj.name && focusObj.name == objname) break;
 } while ( typeof(focusObj) == 'undefined' || focusObj.tagName == "OBJECT" ||
 ( focusObj.type && focusObj.type=='hidden') ||
 focusObj.readOnly ||
 ( focusObj.getAttribute && focusObj.getAttribute("disabled")) ||
 ( focusObj.amIhide && focusObj.amIhide()) ||
 ( objname && focusObj.name && focusObj.name != objname )
 );
 return focusObj;
}
function em_am_i_hide() { 
 var oTest = this;
 do { if ( ( oTest.hasCss && oTest.hasCss("xjs_hide")) || 
 ( oTest.style && oTest.style.display =='none' ) ||
 ( oTest.currentStyle && oTest.currentStyle.display =='none' ) 
 ) return true;
 oTest = oTest.parentElement;
 } while (oTest);
 
 return false;
}
function em_set_filter(xObj, sFilter) { if (this.xFilter) return;
 this.xFilter = sFilter;
 xObj.onkeypress = xe_filter_on_key_press;
}
function em_set_mask(xObj, sMask, maskHdl, unMaskHdl) { if (this.xMask) return;
 if (sMask) this.xMask = sMask;
 this.masking = maskHdl;
 this.unMasking = unMaskHdl;
 xObj.onblur = this.masking;
 xObj.onfocus = this.unMasking;
}
function em_create_object(eleTag, compositeParam){ return this.form.createObject(eleTag, compositeParam, this);
}
function em_attach_x_object(xKey, xValue) { var config = xa_support_matrix.getHashIndex(xKey);
 if (!config || ( xa_support_matrix[config][1] == 0 ) || ((xa_support_matrix[config][1] == 2) && !xValue) ) return false;
 var supportTypes = xa_support_matrix[config][3].split(",");
 if(supportTypes.hasValue(this.type)) { if (xValue) this.setAttribute(xKey, xValue);
 else this.setAttribute(xKey);
 this.addXObj(xa_support_matrix[config][0], xa_support_matrix[config][2]);
 }
}
function em_detach_x_object(xKey) { if ( !this.xObject.length ) return false;
 var flag = false;
 var theXObj = null;
 for (var idx=0; idx < this.xObject.length && !theXObj ; idx++) { //is already bound? { if (this.xObject[idx].x_key == xKey) theXObj = this.xObject[idx];
 }
 if (!theXObj) return false;
 if (this.getAttribute(xKey)=="" || this.getAttribute(xKey)==null) this.removeAttribute(xKey);
 if (theXObj.css_style) this.unsetCss(theXObj.css_style);
 var newXObject = new Array;
 for (var idx=0; this.xObject.length > idx; idx++) { if ( this.xObject[idx].x_key != xKey ) { newXObject[newXObject.length] = this.xObject[idx];
 }
 delete this.xObject[idx];
 }
 this.xObject = newXObject;
 return ;
}
function em_validate(actionflag, evnt) { var flag = true;
 if ( !this.xObject || !this.xObject.length ) return true;
 if ( this.impotence || this.getAttribute("disabled")) return true;
 
 if (!window.xGetOption("X_VALIDATE_ON_HIDE") && this.amIhide()) return;
 if (!window.xGetOption("X_VALIDATE_ON_READONLY") && this.readOnly) return;
 if ( this.beforeValidation && eval(this.beforeValidation) == false ) flag = false;
 
 for ( var idx=0; flag && idx < this.xObject.length ; idx++ ) { if (this.xObject[idx].validate && this.xObject[idx].validate(actionflag, evnt) == false ) { flag = false; 
 break;
 }
 }
 if ( flag && this.afterValidation && eval(this.afterValidation) == false ) flag = false;
 if (flag) { this.unsetBgColor("xjs_error");
 } else { if (typeof(actionflag) == 'undefined' || actionflag == true) { if (window.xGetOption("X_SUPPORT_HIDDEN_TYPE") && this.type == 'hidden') { if (this.getNextFocus && this.getNextFocus()) this.getNextFocus().focus();
 } else { this.setBgColor("#EEFFB6", "xjs_error"); 
 if ( this.amIhide && !this.amIhide()) this.focus();
 }
 }
 }
 return flag;
}
function em_alert(alertFlag, message) { if (typeof(alertFlag) == 'undefined' || alertFlag == true ) { if (this.beforeAlert ) eval(this.beforeAlert);
 window.alert(message);
 }
}
function em_alter_validate(evnt) { if ( !this.alterObjs || !this.alterObjs.length ) return true;
 for ( var idx=0; idx < this.alterObjs.length ; idx++ ) { if (this.alterObjs[idx].validate && this.alterObjs[idx].validate(false, evnt) == true ) { return true;
 }
 }
 return false;
}
function em_get_un_masked() { if (!this.value) return "";
 if (!this.unMasking) return "";
 return this.value.replace(window.xGetOption("X_DELIMITER_CHAR"),"");
}
function em_x_facotry() { for (idx=0 ; idx<xa_support_matrix.length ; idx++) { //search matrix
 if (this.isAttribute(xa_support_matrix[idx][0])) { //if this has matrix[0] attribute
 if ((xa_support_matrix[idx][1] == 2) && !this.isAttrValue(xa_support_matrix[idx][0])) continue; // if attribute should have value but it is not
 this.addXObj(xa_support_matrix[idx][0], xa_support_matrix[idx][2]);
 }
 }
 if (window.xGetOption("X_CSS_PLAINED")) this.addXObj("plain_box", "xo_plain_box");
 if (window.xGetOption("X_NEXT_FOCUS_ON_ENTER")) this.addXObj("enter_move_focus", "xo_enter_move_focus");
}
function em_add_x_obj(xKey, xClass, param) { var flag = true;
 var idx = xa_support_matrix.getHashIndex(xKey);
 if (xa_support_matrix[idx][1] == 0) flag = false; //Not Used Skip;
 var supportTypes = xa_support_matrix[idx][3].split(",");
 if(!supportTypes.hasValue(this.type)) flag = false; //not support type.
 for (var idx=0; this.xObject.length > idx && flag; idx++) //is already bound?
 if (this.xObject[idx].x_key == xKey) flag = false;
 if (flag) { var xObj = eval("new " + xClass +"(this, param)");
 this.xObject[this.xObject.length] = xObj;
 if (xObj.initialize) xObj.initialize();
 }
 return flag;
}
function em_clear_x() { if ( !this.xObject.length ) return true;
 for(var idx=0; idx < this.xObject.length ; idx++)
 delete this.xObject[idx];
 
}
function em_event_handler() { var srcObj = window.event.srcElement;
 var type = window.event.type;
 for (var idx=0; srcObj.xObject && idx < srcObj.xObject.length; idx++) { if( eval(srcObj.xObject[idx]) && eval("srcObj.xObject[idx].on" + type)) 
 eval("srcObj.xObject[idx].on" + type + "(window.event)");
 }
 if ( type == 'focus' && ( srcObj.type == "text" || srcObj.type == "password" || srcObj.type == "textarea" || srcObj.type == "file" ) && srcObj.select) { srcObj.select();
 }
}
function ff_initialize() { this.impotence = false;
 this.sendValues = "";
 //Class - methods
 this.callObjMethod = fm_call_obj_method;
 this.applyAll = fm_apply_all;
 this.applyNamed = fm_apply_named;
 this.applyTyped = fm_apply_typed;
 this.methodWrapper = fm_method_wrapper;
 this.trim = fm_trim;
 this.lTrim = fm_left_trim;
 this.rTrim = fm_right_trim;
 this.stripWhite = fm_strip_white;
 this.stripSpecial = fm_strip_special;
 this.setMagicQuote = fm_set_magic_quote;
 this.unsetMagicQuote = fm_unset_magic_quote;
 this.setEscape = fm_set_escape;
 this.unsetEscape = fm_unset_escape;
 this.clear = fm_clear;
 this.disable = fm_disable;
 this.enable = fm_enable;
 this.show = fm_show;
 this.hide = fm_hide;
 this.setReadOnly = fm_set_readonly;
 this.unsetReadOnly = fm_unset_readonly
 this.setCheck = fm_set_check;
 this.unsetCheck = fm_unset_check;
 this.masking = fm_masking;
 this.unMasking = fm_unMasking;
 this.isAttribute = pm_is_attribute;
 this.isAttrValue = pm_is_attribute_value;
 this.hasCss = pm_has_css;
 this.setCss = pm_set_css;
 this.unsetCss = pm_unset_css;
 this.countValue = fm_count_value;
 this.validate = fm_validate;
 this.serveSubmit = fm_serve_submit;
 this.fireSubmit = fm_fire_submit;
 
 this.onSubmitHandler = fe_onsubmit;
 if (this.onsubmit) this._onSubmitHandler = this.onsubmit;
 this.onsubmit = this.onSubmitHandler;
 this.clearX = fm_clear_x;
 this.setSendValue = fm_set_send_value;
 this.createObject = fm_create_object;
 this.createHidden = fm_create_hidden_type;
 this.addHiddenFields = fm_add_hidden_fields;
 this.copyToArray = fm_copy_to_array;
 for(var idx=0; idx < this.elements.length ; idx++) { if (this.elements[idx].tagName == "OBJECT" ) continue;
 if (!window.xGetOption("X_SUPPORT_HIDDEN_TYPE") && this.elements[idx].type == 'hidden') continue;
 this.elements[idx].initialize = em_initialize;
 this.elements[idx].initialize(this);
 }
}
function fm_call_obj_method(obj, func) { if( eval("obj." + func)) eval("obj." + func + "()");
}
function fm_apply_all(func) { if (this.elements.length==0) return;
 if (typeof(func)!= "string" ) return;
 for (var idx=0; idx < this.elements.length ; idx++) { if (this.elements[idx].tagName == "OBJECT" ) continue;
 this.callObjMethod( this.elements[idx], func);
 }
}
function fm_apply_named(names, func) {//name could be name or names string
 if (this.elements.length==0) return;
 if (typeof(names)!= "string" ||typeof(func)!= "string" ) return;
 var namesArr = names.split(",");
 for (var idx=0; idx < this.elements.length; idx++) { if (this.elements[idx].tagName == "OBJECT" ) continue;
 for (var jdx=0; jdx < namesArr.length; jdx++) { if (this.elements[idx].name == namesArr[jdx]) { this.callObjMethod( this.elements[idx], func);
 }
 }
 }
}
function fm_apply_typed(types, func) {//name could be name or names string
 if (this.elements.length==0) return;
 if (typeof(types)!= "string" ||typeof(func)!= "string" ) return;
 var typesArr = types.split(",");
 for (var idx=0; idx < this.elements.length; idx++) { if (this.elements[idx].tagName == "OBJECT" ) continue;
 for (var jdx=0; jdx < typesArr.length; jdx++) { if (this.elements[idx].type == typesArr[jdx])
 this.callObjMethod( this.elements[idx], func);
 }
 }
}
function fm_method_wrapper(func, names) { (typeof(names)== "string") ? this.applyNamed(names, func) : this.applyAll(func);
}
function fm_trim(names) { this.methodWrapper('valueTrim', names); }
function fm_left_trim(names) { this.methodWrapper('leftTrim', names); }
function fm_right_trim(names) { this.methodWrapper('rightTrim', names); }
function fm_strip_white(names) { this.methodWrapper('stripWhite', names); }
function fm_strip_special(names) { this.methodWrapper('stripSpecial', names); }
function fm_set_magic_quote(names) { this.methodWrapper('setMagicQuote', names); }
function fm_unset_magic_quote(names) { this.methodWrapper('unsetMagicQuote', names); }
function fm_set_escape(names) { this.methodWrapper('setEscape', names); }
function fm_unset_escape(names) { this.methodWrapper('unsetEscape', names); }
function fm_clear(names) { this.methodWrapper('clear', names); }
function fm_disable(names) { this.methodWrapper('disable', names); }
function fm_enable(names) { this.methodWrapper('enable', names); }
function fm_show(names) { this.methodWrapper('show', names); }
function fm_hide(names) { this.methodWrapper('hide', names); }
function fm_set_readonly(names) { this.methodWrapper('setReadOnly', names); }
function fm_unset_readonly(names) { this.methodWrapper('unsetReadOnly', names); }
function fm_set_check(names) { this.methodWrapper('setCheck', names); }
function fm_unset_check(names) { this.methodWrapper('unsetCheck', names); }
function fm_masking(names) { this.methodWrapper('masking', names); }
function fm_unMasking(names) { this.methodWrapper('unMasking', names); }
function fm_count_value(names, values) {//name could be name or names string
 if (this.elements.length==0) return false;
 var namesArr = (names) ? names.split(",") : null ;
 var matchedCnt = 0;
 for (var idx=0; idx < this.elements.length; idx++) { if (this.elements[idx].tagName == "OBJECT" ) continue;
 if ( (! namesArr || namesArr.hasValue(this.elements[idx].name) ) && this.elements[idx].hasValue( values ) )
 matchedCnt ++;
 }
 return matchedCnt;
}
function fm_validate(actionflag, evnt) { for(var idx=0; idx < this.elements.length; idx++){ if (this.elements[idx].tagName == "OBJECT" ) continue;
 if (this.elements[idx].alterValidate && this.elements[idx].isAttrValue("alter") && this.elements[idx].alterValidate(evnt) == true ) continue;
 
 if (this.elements[idx].validate && this.elements[idx].validate(actionflag, evnt) == false ) { return false;
 }
 }
 return true;
}
function fm_serve_submit(evnt) { // this could be evet or normal call
 var flag = true;
 var srcObj = (evnt && evnt.type=='submit' ) ? evnt.srcElement : this;
 
 if ( srcObj.impotence ) flag = false;
 if ( flag && srcObj.beforeValidation) { if ( eval(srcObj.beforeValidation) == false ) flag = false;
 }
 if ( window.xGetOption("X_VALIDATION_ACTIVATE") && flag && srcObj.validate ) { flag = srcObj.validate(true, evnt);
 }
 if ( flag && srcObj.afterValidation) { if ( eval(srcObj.afterValidation) == false ) flag = false;
 }
 
 if ( flag && srcObj.isAttrValue("confirm") && !confirm(srcObj.getAttribute("confirm")) ) { flag = false;
 }
 if ( flag && srcObj.unMasking) srcObj.unMasking();
 if ( flag && window.xGetOption("X_MAGIC_QUOTE_ON")) srcObj.setMagicQuote();
 if ( flag && window.xGetOption("X_ESCAPE_ON")) srcObj.setEscape();
 if ( flag && window.xGetOption("X_DYNAMIC_SEND_VALUE") && srcObj.sendValues )
 srcObj.addHiddenFields(srcObj.sendValues)
 if ( flag && window.xGetOption("X_DISABLE_SUBMIT_ON_SUBMIT")) { this.impotence = true;
 this.applyTyped("submit,image", "disable");
 if (srcObj.name) setTimeout("document."+ srcObj.name + ".applyTyped('submit,image', 'enable')", window.xGetOption("X_DISABLE_SUBMIT_TIMEOUT"));
 if (srcObj.name) setTimeout("document."+ srcObj.name + ".impotence = false", window.xGetOption("X_DISABLE_SUBMIT_TIMEOUT"));
 if (srcObj.name) setTimeout("document."+ srcObj.name + ".applyAll('masking')", window.xGetOption("X_DISABLE_SUBMIT_TIMEOUT"));
 }
 return flag;
}
function fm_fire_submit() { // this is not a event call
 if ( this.serveSubmit() ) this.submit();
 else return false;
}
function fe_onsubmit() {//event call function
 if ( !window.xGetOption("X_ONSUBMIT_EVENT_ACTIVATE")) return;
 if ( window.event && window.event.returnValue==false ) return false;
 var srcObj = (window.event && window.event.type=='submit' ) ? window.event.srcElement : null;
 if (this._onSubmitHandler && this._onSubmitHandler() == false) { 
 //onSubmit ananoymouse function return false not user defined function
 window.event.returnValue = false;
 return false;
 }
 if (window.event && window.event.returnValue == false) return false;
 if ( srcObj && !srcObj.serveSubmit(window.event) ) { window.event.returnValue = false;
 return false;
 }
}
function fm_clear_x() { this.applyAll('clearX');
}
function fm_set_send_value(strValue) { this.sendValues = strValue;
}
function fm_create_object(eleTag, compositeParam, oSibling){ //,
 var pArray = compositeParam.getUrlCompositeArray("▶","=");
 var eleName = pArray.getHashValue("name", 1);
 if (!window.xGetOption("X_ALLOW_MULTI_CREATE" ) && eleName ) { //Not Allow create same name on this form
 var oElement = null;
 for(var idx=0; idx < this.elements.length ; idx++) { if ( this.elements[idx].name == eleName ) oElement = this.elements[idx];
 }
 if (oElement) { // there is already same name element exist.
 if ( oElement.getAttribute("value") != null && pArray.getHashValue("value", 1) )
 oElement.value = pArray.getHashValue("value", 1);
 //oElement.setValue(pArray.getHashValue("value", 1));
 return oElement;
 }
 }
 var oElement = document.createElement(eleTag);
 if ( eleTag== "input" || eleTag == "textarea" || eleTag == "select" ) { oElement.initialize = em_initialize; oElement.initialize(this);
 }
 for (var idx=0; idx < pArray.length; idx++ ) { oElement.setAttribute(pArray[idx][0], pArray[idx][1]);
 }
 (oSibling) ? this.insertBefore(oElement, oSibling) : this.insertBefore(oElement);
 return oElement;
}
function fm_create_hidden_type(eleName, eleValue){ if (!eleValue) eleValue = "";
 var strHiddenTagParam = "type=hidden▶name="+ eleName + "▶" + "value=" + eleValue;
 return this.createObject('input', strHiddenTagParam);
}
function fm_add_hidden_fields(strValues){ if (!strValues) return;
 var ssArray = strValues.getUrlCompositeArray("&","=");
 for (var idx=0; idx < ssArray.length; idx++ ) { this.createHidden(ssArray[idx][0], ssArray[idx][1]);
 }
}
function fm_copy_to_array(names) {//name could be name or names string
 if (this.elements.length==0) return;
 var namesArr = (names) ? names.split(",") : null;
 var rtnArr = new Array;
 for (var idx=0; idx < this.elements.length ; idx++) { 
 if (this.elements[idx].tagName == "OBJECT" ) continue;
 if ( this.elements[idx].type == "button" || this.elements[idx].type == "submit" || this.elements[idx].type == "reset" ) continue;
 if (!window.xGetOption("X_SUPPORT_HIDDEN_TYPE") && this.elements[idx].type == 'hidden') continue;
 if ( ( this.elements[idx].getValue && this.elements[idx].getValue() == null) && ( this.elements[idx].type == "radio" || this.elements[idx].type == "checkbox" ) ) continue;
 if (namesArr) { for (var jdx=0; jdx < namesArr.length; jdx++) { if (this.elements[idx].name == namesArr[jdx])
 rtnArr[rtnArr.length] = new Array ( this.elements[idx].name, this.elements[idx].getValue());
 }
 }else { rtnArr[rtnArr.length] = new Array ( this.elements[idx].name, this.elements[idx].getValue());
 }
 }
 return rtnArr;
}
function wm_get_option(optStr) { return xa_option_table.getHashValue(optStr, 1);
}
function wm_set_option(optStr, attr) { xa_option_table[xa_option_table.getHashIndex(optStr)][1]=attr;
}
function wm_put_option(keyStr, attr) { var newOption = new Array(keyStr, attr);
 xa_option_table[xa_option_table.length] = newOption;
}
function wm_get_url_param_to_array(urlparams) { if (document.URL.indexOf('?') == -1) return false; //there is no parameter using URL
 var urlParams = document.URL.substring(document.URL.indexOf('?')+1, document.URL.length);
 var rtnArr = unescape(urlParams.toString()).getUrlCompositeArray("&","=");
 if ( urlparams ) { var tmpParamArr = new Array;
 var paramArr = urlparams.split(",");
 for ( var idx = 0 ; idx < rtnArr.length ; idx++) { if ( paramArr.hasValue(rtnArr[idx][0]) ) { tmpParamArr[tmpParamArr.length] = rtnArr[idx];
 }
 }
 rtnArr = tmpParamArr;
 }
 return rtnArr;
}
function wm_get_xjos_status() { alert(this.xJosStatus);
}
function we_on_unload() { document.applyForms("clearX");
}
function we_on_load() { if ( window.xGetOption("X_MAGIC_QUOTE_ON")) document.applyForms("unsetMagicQuote");
 document.applyForms("masking");
 if ( window.xGetOption("X_ESCAPE_ON")) document.applyForms("unsetEscape");
}
function dm_apply_forms(func) { for ( var idx = 0 ; idx < this.forms.length ; idx++)
 if (eval("this.forms[idx]." + func)) eval("this.forms[idx]." + func + "()");
}
function initializeX() { this.xJosStatus = 'xJos are loaded but not activate';
 this.xGetOption = wm_get_option;
 this.xSetOption = wm_set_option;
 this.xPutOption = wm_put_option;
 this.getXjos = wm_get_xjos_status;
 this.getUrlParamToArray = wm_get_url_param_to_array;
 this.document.applyForms = dm_apply_forms;
 if ( !window.xGetOption("X_ACTIVATE") ) return ;
 this.xJosStatus = 'xJos are loaded and activate but not initialize';
 var start_x = new Date();
 for ( var idx = 0 ; idx < document.forms.length ; idx++) { document.forms[idx].initialize = ff_initialize;
 document.forms[idx].initialize();
 }
 this.detachEvent("onunload", we_on_unload );
 this.detachEvent("onload", we_on_load );
 this.attachEvent("onunload", we_on_unload );
 this.attachEvent("onload", we_on_load );
 var end_x = new Date();
 if (window.xGetOption("X_SHOW_ELAPS"))
 document.write(" xJos init elasp = " + (end_x - start_x) + " m/s<BR>");
 delete start_x; delete end_x;
 this.xJosStatus = 'xJos are successfully loaded / activate / initialized';
}
function pxm_initialize() { //initialize xObject code below
}
function pxm_get_message(msgIndex, params) { var message = "";
 message = xa_messages_table.getCompositeHashValue(this.x_key, msgIndex, 2);
 if (!message) return "xjos("+this.x_key+"->"+msgIndex+") 메세지가 정의되어 있지 않습니다.!!";
 if ( this.parent.isAttrValue(this.x_key + "_msg" )) { return (params) ? this.parent.getAttribute(this.x_key + "_msg" ).toString().substituteAt(params) :
 this.parent.getAttribute(this.x_key + "_msg" );
 }
 if (params) { if ( typeof(params) != String ) params = params.toString(10);
 message = message.substituteAt(params);
 }
 if (this.parent.itemname) { itemMessage = xa_messages_table.getHashValue("itemname", 2);
 if (itemMessage) { itemMessage = itemMessage.substituteAt(this.parent.itemname);
 message = itemMessage + message;
 }
 }
 return message;
}
function pxm_regexp_validate(alertflag, evnt) { var flag = true; //true when validation successful.
 if (!this.parent.value) return flag; //입력값 없는 경우는 Pass
 var regExp = window.xGetOption(this.regExpKey);
 if (!regExp.test(this.parent.value)) { this.parent.alert(alertflag, this.getMessage(0));
 flag = false;
 }
 return flag;
}
function ee_prevent_focus_handler(evnt) { var srcObj = evnt ? evnt.srcElement : window.event.srcElement;
 var focusObj = null;
 if (srcObj.getNextFocus ) { focusObj = srcObj.getNextFocus();
 if ( focusObj != srcObj ) focusObj.focus();
 } else if (srcObj.blur) srcObj.blur();
}
function ee_mask_un_masking(evnt) { var evntSrc = evnt ? evnt : window.event;
 var srcObj = ( evntSrc && evntSrc.type == 'focus' ) ? evntSrc.srcElement : this;
 if (!srcObj.value) return;
 srcObj.value = srcObj.value.replace(window.xGetOption("X_DELIMITER_CHAR"),"");
}
function ee_mask_masking(evnt) { var evntSrc = evnt ? evnt : window.event;
 var srcObj = ( evntSrc && evntSrc.type =='blur' ) ? evntSrc.srcElement : this;
 if (!srcObj.value) return;
 var sStr = srcObj.value.replace( window.xGetOption("X_DELIMITER_CHAR"),"");
 var mask = srcObj.xMask;
 var tStr = "";
 var jdx = 0;
 var tLen = sStr.length + 1;
 for(var idx=0; idx< sStr.length; idx++){ tStr += sStr.charAt(idx);
 jdx++;
 if (jdx < mask.length && mask.charAt(jdx)!="9") tStr += mask.charAt(jdx++);
 }
 srcObj.value = tStr;
}
function ee_money_masking(evnt) { var evntSrc = evnt ? evnt : window.event;
 var srcObj = ( evntSrc && evntSrc.type=='blur' ) ? evntSrc.srcElement : this;
 if (!srcObj.value) return;
 var sMoney = srcObj.value.replace( window.xGetOption("X_DELIMITER_CHAR"),"");
 var tMoney = "";
 var i;
 var j=0;
 var tLen =sMoney.length;
 if (tLen <= 3 ) return ;
 for(i=0;i<tLen;i++){ if (i!=0 && ( i % 3 == tLen % 3) ) tMoney += ",";
 if(i < tLen ) tMoney += sMoney.charAt(i);
 }
 srcObj.value = tMoney;
}
function ee_dollar_masking(evnt) { var evntSrc = evnt ? evnt : window.event;
 var srcObj = ( evntSrc && evntSrc.type=='blur' ) ? evntSrc.srcElement : this;
 if (!srcObj.value) return;
 var sMoney = srcObj.value.replace(window.xGetOption("X_DELIMITER_CHAR"),"");
 if ( sMoney.length <= 2 ) return sMoney;
 var fir_sMoney = sMoney.substr(0, sMoney.length - 2);
 var sec_sMoney = sMoney.substr(sMoney.length - 2, 2);
 var tMoney="";
 var i;
 var j=0;
 var tLen =fir_sMoney.length;
 if (fir_sMoney.length <= 3 ) { srcObj.value = fir_sMoney + "." + sec_sMoney;
 return;
 }
 for(i=0;i<tLen;i++){ if (i!=0 && ( i % 3 == tLen % 3) ) tMoney += ",";
 if(i < fir_sMoney.length ) tMoney += fir_sMoney.charAt(i);
 }
 srcObj.value = tMoney + "." + sec_sMoney;
}
function ee_dollar_un_masking(evnt) {//this event fired only by onfocus
 var evntSrc = evnt ? evnt : window.event;
 var srcObj = ( evntSrc && evntSrc.type=='focus' ) ? evntSrc.srcElement : this;
 if (!srcObj.value) return;
 var sMoney = srcObj.value.replace(window.xGetOption("X_DELIMITER_CHAR"),"");
 if ( sMoney.length <= 2 ) return sMoney;
 var fir_sMoney = sMoney.substr(0, sMoney.length - 2);
 var sec_sMoney = sMoney.substr(sMoney.length - 2, 2);
 srcObj.value = fir_sMoney + "." + sec_sMoney;
}
function xpm_duih_initialize() { switch (this.parent.type) { case "text" : case "password" : case "textarea" : case "file" :
 this.onblur = this.duiHandler ; break;
 case "select-one" : case "select-multiple" :
 this.onchange = this.duiHandler ; break;
 case "radio" : case "checkbox" :
 this.onclick = this.duiHandler; break;
 }
}
function xpe_dui_handler(evnt) { var normalCmdStr = "this.parent.parent." + this.normalCmd + "(this.x_value)";
 var reverseCmdStr = "this.parent.parent." + this.reverseCmd + "(this.x_value)";
 (this.parent.hasValue(this.x_ifvalues)) ? eval (normalCmdStr) : eval (reverseCmdStr);
}
function xDekPopup(initalStr) { document.writeln("<DIV ID='x_dek' CLASS='xjs_dek'>" + initalStr + "</DIV>");
 this.xoff = -2;
 this.yoff = -30;
 this.ypos = -1000;
 this.dek = x_dek.style;
 this.oldContent = "";
 this.xDekPopOnMouseMoveHandler = x_dek_popup_on_mouse_move;
 document.detachEvent("onmousemove", this.xDekPopOnMouseMoveHandler );
 document.attachEvent("onmousemove", this.xDekPopOnMouseMoveHandler );
 this.getSkin = x_dek_popup_get_skin;
 this.show = x_dek_popup_show;
 this.kill = x_dek_popup_kill;
 this.xa_ballon_skins = new Array (
 new Array("skin01", "bar01a.gif", "bar01b.gif", "bar01c.gif"),
 new Array("skin02", "bar02a.gif", "bar02b.gif", "bar02c.gif"),
 new Array("skin03", "bar03a.gif", "bar03b.gif", "bar03c.gif"),
 new Array("skin04", "bar04a.gif", "bar04b.gif", "bar04c.gif"),
 new Array("skin05", "bar05a.gif", "bar05b.gif", "bar05c.gif"),
 new Array("skin06", "bar06a.gif", "bar06b.gif", "bar06c.gif"),
 new Array("skin07", "bar07a.gif", "bar07b.gif", "bar07c.gif"),
 new Array("skin08", "bar08a.gif", "bar08b.gif", "bar08c.gif"),
 new Array("skin09", "bar09a.gif", "bar09b.gif", "bar09c.gif"),
 new Array("skin10", "bar10a.gif", "bar10b.gif", "bar10c.gif")
 );
}
function x_dek_popup_on_mouse_move(){ if ((window.event.x + window.x_dek.scrollWidth ) < document.body.scrollWidth )
 window.xdek.dek.left = window.event.x + document.body.scrollLeft + window.xdek.xoff;
 if ((window.event.y + window.x_dek.scrollHeight ) < document.body.scrollHeight )
 window.xdek.dek.top = window.event.y + document.body.scrollTop + window.xdek.ypos;
}
function x_dek_popup_show(msg, skin){ if ( this.dek.visibility == "visible" ) return;
 this.ypos = this.yoff;
 var content = this.getSkin(msg, skin);
 if ( content != this.oldContent ) { document.all("x_dek").innerHTML = content;
 this.oldContent = content;
 }
 this.dek.visibility="visible";
}
function x_dek_popup_kill(){ if (this.dek.visibility == "hidden" ) return;
 this.dek.ypos=-1000;
 this.dek.visibility="hidden";
}
function x_dek_popup_get_skin(content, skin) { var dir = window.xGetOption("X_SKIN_DIR");
 if (skin && this.xa_ballon_skins.getHashValue(skin,0) ) { content = "<table border='0' cellspacing='0' cellpadding='0' class='xjs_dek_skin'> " +
 "<tr><td align='right'><img src='"+ dir + this.xa_ballon_skins.getHashValue(skin,1) +"'></td>" +
 "<td background='"+ dir + this.xa_ballon_skins.getHashValue(skin,2) +"' nowrap>" +
 content +
 "</td>" +
 "<td ><img src='"+ dir + this.xa_ballon_skins.getHashValue(skin,3) +"'></td></tr>" +
 "</table>";
 } else { content = "<TABLE BORDER=1 CELLPADDING=2 CELLSPACING=0 class='xjs_dek_table' > " +
 "<TR><TD ALIGN=left nowrap>" +
 content +
 "</TD></TR>" +
 "</TABLE>";
 }
 return content;
}
function xo_plain_box(parent) { //constant data;
 this.parent = parent;
 this.x_key = "plain_box";
 //define css style
 switch(this.parent.type) { case "text" : case "password" :
 case "file" : case "textarea" :
 this.css_style = "xjs_flat_box";
 break;
 case "button" : case "reset" : case "submit" :
 this.css_style = "xjs_flat_button";
 break;
 }
 this.parent.setCss(this.css_style);
}
function xo_required(parent) { //constant data;
 this.parent = parent;
 this.x_key = "required";
 this.css_style = "xjs_required";
 this.parent.setCss(this.css_style);
 this.validate = xm_required_validate;
 this.getMessage = pxm_get_message;
}
function xm_required_validate(alertflag, evnt) { var flag = true; //true when validation successful.
 var regExp_whiteSpace = /^[\s]*$/;
 if (!this.parent.value)
 flag = false;
 if(flag && window.xGetOption("X_REQUIRED_IGNORE_WHITESPACE") && window.xGetOption("X_WHITE_SPACE_REGEXP").test(this.parent.value)) { this.parent.value = this.parent.value.replace(window.xGetOption("X_WHITE_SPACE_CHAR"),"");
 flag = false;
 }
 if (flag && this.parent.type == "checkbox" && !this.parent.checked )
 flag = false;
 if (flag && this.parent.type == "radio" && !this.parent.checked )
 flag = false;
 if (!flag) { this.parent.alert(alertflag, this.getMessage(0));
 }
 return flag;
}
function xo_item_name(parent) { //constant data;
 this.parent = parent;
 this.x_key = "itemname";
 this.x_value = parent.getAttribute(this.x_key);
 this.parent.itemname = this.x_value;
}
function xo_min_length(parent) { this.parent = parent;
 this.x_key = "minlength";
 this.x_value = parent.getAttribute(this.x_key);
 this.validate = xm_min_length_validate;
 this.getMessage = pxm_get_message;
}
function xm_min_length_validate(alertflag, evnt) { var flag = true; //true when validation successful.
 if (!this.parent.value) return flag; //입력값 없는 경우는 Pass
 if (this.parent.value.length < this.x_value ) { this.parent.alert(alertflag, this.getMessage(0, this.x_value));
 flag = false;
 }
 return flag;
}
function xo_max_byte(parent) { this.parent = parent;
 this.x_key = "maxbyte";
 this.x_value = parent.getAttribute(this.x_key);
 this.validate = xm_max_byte_validate;
 this.getMessage = pxm_get_message;
}
function xm_max_byte_validate(alertflag, evnt) { var flag = true; //true when validation successful.
 if (!this.parent.value) return flag; //입력값 없는 경우는 Pass
 if (this.parent.value.getByte() > this.x_value ) { this.parent.alert(alertflag, this.getMessage(0, this.x_value));
 flag = false;
 }
 return flag;
}
function xo_min_byte(parent) { this.parent = parent;
 this.x_key = "minbyte";
 this.x_value = parent.getAttribute(this.x_key);
 this.validate = xm_min_byte_validate;
 this.getMessage = pxm_get_message;
}
function xm_min_byte_validate(alertflag, evnt) { var flag = true; //true when validation successful.
 if (!this.parent.value) return flag; //입력값 없는 경우는 Pass
 if (this.parent.value.getByte() < this.x_value ) { this.parent.alert(alertflag, this.getMessage(0, this.x_value));
 flag = false;
 }
 return flag;
}
function xo_max_value(parent) { this.parent = parent;
 this.x_key = "maxvalue";
 this.x_value = parent.getAttribute(this.x_key);
 this.validate = xm_max_value_validate;
 this.getMessage = pxm_get_message;
}
function xm_max_value_validate(alertflag, evnt) { var flag = true; //true when validation successful.
 if (!this.parent.value) return flag; //입력값 없는 경우는 Pass
 var tsTarget = parseFloat(this.parent.value);
 if (tsTarget > this.x_value ) { this.parent.alert(alertflag, this.getMessage(0, parseFloat(this.parent.value) + "," + this.x_value ));
 flag = false;
 }
 return flag;
}
function xo_min_value(parent) { this.parent = parent;
 this.x_key = "minvalue";
 this.x_value = parent.getAttribute(this.x_key);
 this.validate = xm_min_value_validate;
 this.getMessage = pxm_get_message;
}
function xm_min_value_validate(alertflag, evnt) { var flag = true; //true when validation successful.
 if (!this.parent.value) return flag; //입력값 없는 경우는 Pass
 var tsTarget = parseFloat(this.parent.value);
 if (tsTarget < this.x_value ) { this.parent.alert(alertflag, this.getMessage(0, parseFloat(this.parent.value) + "," + this.x_value));
 flag = false;
 }
 return flag;
}
function xo_enter_move_focus(parent) { //constant data;
 this.parent = parent;
 this.x_key = "enter_move_focus";
 this.onkeypress = xe_enter_move_focus_on_key_press;
}
function xe_enter_move_focus_on_key_press(evnt) { var evntSrc = evnt ? evnt : window.event;
 var sKey = String.fromCharCode(evntSrc.keyCode);
 // 키값이 Enter일때, 다음으로 focus 시킨다.
 if ( sKey == "\r" ) { var nextObj = this.parent.getNextFocus();
 if ( nextObj.focus ) nextObj.focus();
 evntSrc.returnValue = false;
 }
}
function xo_filter(parent, defaultFilter) { //constant data;
 this.parent = parent;
 this.x_key = "filter";
 this.x_value = (defaultFilter) ?
 defaultFilter : parent.getAttribute(this.x_key) ;
 this.parent.setFilter(this, this.x_value);
}
function xe_filter_on_key_press(evnt) { var evntSrc = evnt ? evnt : window.event;
 if (this.parent.xFilter) { var sKey = String.fromCharCode(evntSrc.keyCode);
 var re = new RegExp(this.parent.xFilter);
 // Enter는 키검사를 하지 않는다.
 if(sKey!="\r" && !re.test(sKey)) evntSrc.returnValue=false;
 delete re;
 }
}
function xo_mask(parent, defaultMask) { //constant data;
 this.parent = parent;
 this.x_key = "mask";
 this.x_value = (defaultMask) ?
 defaultMask : parent.getAttribute(this.x_key) ;
 this.parent.setMask(this, this.x_value, ee_mask_masking, ee_mask_un_masking);
 if ( window.xGetOption("X_VALIDATE_ON_MASK")) { this.getMessage = pxm_get_message;
 this.validate = xm_mask_validate;
 }
}
function xm_mask_validate(alertflag, evnt) { var flag = true; //true when validation successful.
 if (!this.parent.value) return flag;
 if (!this.parent.xMask) return flag;
 if (this.parent.unMasking && this.parent.masking) { this.parent.unMasking(); this.parent.masking();
 }
 //Validation Logic for Mask..
 var sPattern=this.parent.xMask.replace(window.xGetOption("X_DELIMITER_CHAR"),"\\$1");
 sPattern=sPattern.replace(/9/g ,"\\d");
 var re=new RegExp("^"+sPattern+"$");
 if(!re.test(this.parent.value)) { flag = false;
 this.parent.alert(alertflag, this.getMessage(0, this.parent.xMask));
 }
 delete re;
 return flag;
}
function xo_alphabetic(parent) { this.parent = parent;
 this.x_key = "alphabetic";
 this.regExpKey = "X_ALPHA_REGEXP"; // /^[a-zA-Z]+$/;
 this.validate = pxm_regexp_validate;
 this.getMessage = pxm_get_message;
 this.parent.setFilter(this, window.xGetOption("X_ALPHA_FILTER"));
}
function xo_numeric(parent) { this.parent = parent;
 this.x_key = "numeric";
 this.regExpKey = "X_NUM_REGEXP"; // /^[0-9]+$/;
 this.validate = pxm_regexp_validate;
 this.getMessage = pxm_get_message;
 this.parent.setFilter(this, window.xGetOption("X_NUM_FILTER"));
}
function xo_alpha_numeric(parent) { this.parent = parent;
 this.x_key = "alpha_numeric";
 this.regExpKey = "X_ALNUM_REGEXP"; // /^[A-Za-z0-9]+$/;
 this.validate = pxm_regexp_validate;
 this.getMessage = pxm_get_message;
 this.parent.setFilter(this, window.xGetOption("X_ALNUM_FILTER"));
}
function xo_integer(parent) { this.parent = parent;
 this.x_key = "integer";
 this.validate = xm_integer_validate;
 this.getMessage = pxm_get_message;
 this.parent.setFilter(this, window.xGetOption("X_INTEGER_FILTER"));
}
function xm_integer_validate(alertflag, evnt)
{ var flag = true; //true when validation successful.
 if (!this.parent.value) return flag; //입력값 없는 경우는 Pass
 var tsTarget = this.parent.value;
 var regExp = window.xGetOption("X_INTEGER_REGEXP"); // /^(\+|\-|\d*)\d+$/
 if (!regExp.test(tsTarget)) { this.parent.alert(alertflag, this.getMessage(0));
 flag = false;
 }
 this.parent.value = parseInt(tsTarget);
 if ( this.parent.value == "NaN" ) this.parent.value = "";
 return flag;
}
function xo_float(parent) { this.parent = parent;
 this.x_key = "float";
 this.parent.setFilter(this, window.xGetOption("X_FLOAT_FILTER"));
 this.getMessage = pxm_get_message;
 this.validate = xm_float_validate;
}
function xm_float_validate(alertflag, evnt)
{ var flag = true; //true when validation successful.
 if (!this.parent.value) return flag; //입력값 없는 경우는 Pass
 var tsTarget = this.parent.value;
 var regExp1 = window.xGetOption("X_INTEGER_REGEXP"); // /^(\+|\-|\d*)\d+$/
 var regExp2 = window.xGetOption("X_FLOAT_REGEXP"); // /^(\-|\+|\d*)\d+(\.|\d)\d*$/
 if(!regExp1.test(tsTarget) && !regExp2.test(tsTarget)) { this.parent.alert(alertflag, this.getMessage(0));
 flag = false;
 }
 this.parent.value = parseFloat(tsTarget);
 if ( this.parent.value == "NaN" ) this.parent.value = "";
 return flag;
}
function xo_hexa(parent) { this.parent = parent;
 this.x_key = "hexa";
 this.validate = xm_hexa_validate;
 this.getMessage = pxm_get_message;
 this.parent.setFilter(this, window.xGetOption("X_HEXA_FILTER"));
}
function xm_hexa_validate(alertflag, evnt)
{ var flag = true; //true when validation successful.
 if (!this.parent.value) return flag; //입력값 없는 경우는 Pass
 var tsTarget = this.parent.value;
 var regExp = window.xGetOption("X_HEXA_REGEXP"); // /^[a-fA-F0-9]+$/
 if(!regExp.test(tsTarget)) { this.parent.alert(alertflag, this.getMessage(0));
 flag = false;
 }
 this.parent.value = parseInt(tsTarget, 16).toString(16);
 if ( this.parent.value == "NaN" ) this.parent.value = "";
 return flag;
}
function xo_money(parent) { //constant data;
 this.parent = parent;
 this.x_key = "money";
 this.x_value = parent.getAttribute(this.x_key);
 this.parent.setMask(this, "", ee_money_masking, ee_mask_un_masking);
 this.parent.setFilter(this, window.xGetOption("X_NUM_FILTER"));
}
function xo_dollar(parent) { //constant data;
 this.parent = parent;
 this.x_key = "dollar";
 this.x_value = parent.getAttribute(this.x_key);
 this.parent.setMask(this, "", ee_dollar_masking, ee_mask_un_masking);
 this.parent.setFilter(this, window.xGetOption("X_NUM_FILTER"));
}
function xo_date(parent) { //constant data;
 this.parent = parent;
 this.x_key = "date";
 if ( !this.parent.isAttrValue("mask") )
 this.parent.addXObj("mask", "xo_mask", window.xGetOption("X_DATE_MASK"));
 if ( !this.parent.isAttrValue("filter") )
 this.parent.setFilter(this, window.xGetOption("X_NUM_FILTER"));
 this.getMessage = pxm_get_message;
 this.validate = xm_date_validate;
}
function xm_date_validate(alertflag, evnt)
{ var flag = true; //true when validation successful.
 if (!this.parent.value) return flag; //입력값 없는 경우는 Pass
 //Validation Logic for Date..
 var iYear = null;
 var iMonth = null;
 var iDay = null;
 var iDaysInMonth = null;
 var sDate=this.parent.value.replace(window.xGetOption("X_DELIMITER_CHAR"),"");
 var sFormat="YYYYMMDD"; //아직까지 YYYYMMDD의 형태만 지원한다. --;
 var aDaysInMonth=new Array(31,28,31,30,31,30,31,31,30,31,30,31);
 if ( sDate.length != 8 ) flag = false ;
 if (flag) { iYear = eval(sDate.substr(0,4));
 iMonth = eval(sDate.substr(4,2));
 iDay = eval(sDate.substr(6,2));
 if ( !iYear.toString().isNum() || !iMonth.toString().isNum() || !iDay.toString().isNum() )
 flag = false ;
 }
 if (flag) { iDaysInMonth = (iMonth != 2) ? aDaysInMonth[iMonth-1] : (( iYear%4 == 0 && iYear%100 != 0 || iYear % 400==0 ) ? 29 : 28 );
 if( iDay==null || iMonth==null || iYear==null || iMonth > 12 || iMonth < 1 || iDay < 1 || iDay > iDaysInMonth )
 flag = false ;
 }
 if(!flag) { this.parent.alert(alertflag, this.getMessage(0));
 }
 delete aDaysInMonth;
 return flag;
}
function xo_psn(parent) { //constant data;
 this.parent = parent;
 this.x_key = "psn";
 if ( !this.parent.isAttrValue("mask") )
 this.parent.addXObj("mask", "xo_mask", window.xGetOption("X_PSN_MASK"));
 this.parent.setFilter(this, window.xGetOption("X_NUM_FILTER"));
 this.getMessage = pxm_get_message;
 this.validate = xm_psn_validate;
}
function xm_psn_validate(alertflag, evnt) { var flag = true; //true when validation successful.
 if (!this.parent.value) return flag; //입력값 없는 경우는 Pass
 var sum = 0;
 var psNumber = this.parent.value.replace(window.xGetOption("X_DELIMITER_CHAR"),"");
 for (idx = 0, jdx=2; jdx < 10; idx++, jdx++) { sum = sum + ( psNumber.charAt(idx) * jdx );
 }
 for (idx = 8, jdx=2; jdx < 6; idx++, jdx++) { sum = sum + ( psNumber.charAt(idx) * jdx );
 }
 var nam = sum % 11;
 var checkDigit = 11 - nam ;
 checkDigit = (checkDigit >= 10 ) ? checkDigit-10:checkDigit;
 if ( !psNumber.toString().isNum() || psNumber.charAt(12) != checkDigit) { flag = false;
 this.parent.alert(alertflag, this.getMessage(0));
 }
 return flag;
}
function xo_csn(parent) { //constant data;
 this.parent = parent;
 this.x_key = "csn";
 if ( !this.parent.isAttrValue("mask") )
 this.parent.addXObj("mask", "xo_mask", window.xGetOption("X_CSN_MASK"));
 this.parent.setFilter(this, window.xGetOption("X_NUM_FILTER"));
 this.getMessage = pxm_get_message;
 this.validate = xm_csn_validate;
}
function xm_csn_validate(alertflag, evnt) { var flag = true; //true when validation successful.
 if (!this.parent.value) return flag; //입력값 없는 경우는 Pass
 var sum = 0;
 var csNumber = this.parent.value.replace(window.xGetOption("X_DELIMITER_CHAR"),"");
 var checkArray = new Array(1,3,7,1,3,7,1,3,5);
 for(idx=0 ; idx < 9 ; idx++)
 sum += csNumber.charAt(idx) * checkArray[idx];
 sum = sum + ((csNumber.charAt(8) * 5 ) / 10);
 var nam = Math.floor(sum) % 10;
 var checkDigit = ( nam == 0 ) ? 0 : 10 - nam;
 if ( !csNumber.toString().isNum() || csNumber.charAt(9) != checkDigit) { flag = false;
 this.parent.alert(alertflag, this.getMessage(0));
 }
 delete checkArray;
 return flag;
}
function xo_credit_card(parent) { //constant data;
 this.parent = parent;
 this.x_key = "credit_card";
 this.parent.setFilter(this, window.xGetOption("X_NUM_FILTER"));
 this.getMessage = pxm_get_message;
 this.validate = xm_credit_card_validate;
}
function xm_credit_card_validate(alertflag, evnt) { var flag = true; //true when validation successful.
 if (!this.parent.value) return flag; //입력값 없는 경우는 Pass
 var tsTarget = this.parent.value.replace(window.xGetOption("X_DELIMITER_CHAR"),"");
 var sum = 0;
 var mul = 1;
 var len = tsTarget.length;
 // Encoding only works on cards with less than 19 digits
 if (len.length > 19)
 flag = false;
 var digit = null;
 var tproduct = null;
 for (var idx = 0; idx < len; idx++) { digit = tsTarget.substring(len-idx-1,len-idx);
 tproduct = parseInt(digit ,10)*mul;
 if (tproduct >= 10) sum += (tproduct % 10) + 1;
 else sum += tproduct;
 if (mul == 1) mul++;
 else mul--;
 }
 if ((sum % 10) != 0)
 flag = false;
 if (!flag ) { this.parent.alert(alertflag, this.getMessage(0));
 flag = false;
 }
 return flag;
}
function xo_email(parent) { //constant data;
 this.parent = parent;
 this.x_key = "email";
 this.getMessage = pxm_get_message;
 this.validate = xm_email_validate;
}
function xm_email_validate(alertflag, evnt) { //this core script from http://tech.irt.org/articles/js049/index.htm
 //customize by TKshin.
 var flag = true; //true when validation successful.
 if (!this.parent.value) return flag; //입력값 없는 경우는 Pass
 var regExpEmail = /^\w+((-|\.)\w+)*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z]{2,4}$/;
 if (!regExpEmail.test(this.parent.value)) { this.parent.alert(alertflag, this.getMessage(0));
 flag = false;
 }
 return flag;
}
function xo_advanced_email(parent) { //constant data;
 this.parent = parent;
 this.x_key = "advanced_email";
 this.getMessage = pxm_get_message;
 this.validate = xm_advanced_email_validate;
}
function xm_advanced_email_validate(alertflag, evnt) { //this core script from http://javascript.internet.com/forms/email-address-validation.html
 var flag = true; //true when validation successful.
 if (!this.parent.value) return flag; //입력값 없는 경우는 Pass
 //Validation Logic for email
 var checkTLD=1; //wether check well-known domain & two-letter contry domain
 var knownDomsPat=/^(com|net|org|edu|int|mil|gov|arpa|biz|aero|name|coop|info|pro|museum)$/;
 var emailPat=/^(.+)@(.+)$/;
 var specialChars="\\(\\)><@,;:\\\\\\\"\\.\\[\\]";
 var validChars="\[^\\s" + specialChars + "\]";
 var quotedUser="(\"[^\"]*\")";
 var ipDomainPat=/^\[(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})\]$/;
 var atom=validChars + '+';
 var word="(" + atom + "|" + quotedUser + ")";
 var userPat=new RegExp("^" + word + "(\\." + word + ")*$");
 var domainPat=new RegExp("^" + atom + "(\\." + atom +")*$");
 var tsTarget = this.parent.value;
 var matchArray = tsTarget.match(emailPat);
 if (!matchArray) { this.parent.alert(alertflag, this.getMessage(0));
 return false;
 }
 var user=matchArray[1];
 var domain=matchArray[2];
 for (i=0; i<user.length; i++)
 if (user.charCodeAt(i)>127) { this.parent.alert(alertflag, this.getMessage(1));
 return false;
 }
 for (i=0; i<domain.length; i++)
 if (domain.charCodeAt(i)>127) { this.parent.alert(alertflag, this.getMessage(2));
 return false;
 }
 if (!user.match(userPat)) { // user is not valid
 this.parent.alert(alertflag, this.getMessage(3));
 return false;
 }
 // IP Address형태의 Email 체크 E.g. joe@[123.124.233.4] is a legal e-mail address */
 var IPArray=domain.match(ipDomainPat);
 if (IPArray) { for (var i=1;i<=4;i++)
 if (IPArray[i]>255) { this.parent.alert(alertflag, this.getMessage(4));
 return false;
 }
 return true;
 }
 // symbolic 형태의 Domain name 체크
 var atomPat=new RegExp("^" + atom + "$");
 var domArr=domain.split(".");
 var len=domArr.length;
 for (i=0;i<len;i++)
 if (domArr[i].search(atomPat)==-1) { this.parent.alert(alertflag, this.getMessage(5));
 return false;
 }
 // TLD 체크
 if (checkTLD && domArr[domArr.length-1].length!=2 && domArr[domArr.length-1].search(knownDomsPat)==-1) { this.parent.alert(alertflag, this.getMessage(6));
 return false;
 }
 if (len<2) { this.parent.alert(alertflag, this.getMessage(7));
 return false;
 }
 delete userPat; delete domainPat; delete atomPat;
 return true;
}
function xo_domain(parent) { //constant data;
 this.parent = parent;
 this.x_key = "domain";
 this.getMessage = pxm_get_message;
 this.validate = xm_domain_validate;
}
function xm_domain_validate(alertflag, evnt) { var flag = true; //true when validation successful.
 if (!this.parent.value) return flag; //입력값 없는 경우는 Pass
 var regExpDomain = /^[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z]{2,4}$/;
 if(!regExpDomain.test(this.parent.value)) { this.parent.alert(alertflag, this.getMessage(0, this.x_value));
 flag = false;
 }
 return flag;
}
function xo_reg_exp(parent) { this.parent = parent;
 this.x_key = "reg_exp";
 this.x_value = parent.getAttribute(this.x_key);
 this.getMessage = pxm_get_message;
 this.validate = xm_reg_exp_validate;
}
function xm_reg_exp_validate(alertflag, evnt) { var flag = true; //true when validation successful.
 if (!this.parent.value) return flag; //입력값 없는 경우는 Pass
 var tsTarget = this.parent.value;
 var regularExpression =new RegExp(this.x_value);
 if (!regularExpression.test(tsTarget)) { this.parent.alert(alertflag, this.getMessage(0, this.x_value)); //regularExpression.source
 flag = false;
 }
 delete regularExpression;
 return flag;
}
function xo_ime(parent) { //constant data;
 this.parent = parent;
 this.x_key = "ime";
 this.x_value = parent.getAttribute(this.x_key);
 //define css style
 switch(this.x_value) { case "kor" :
 this.css_style = "xjs_imeKor"; break;
 case "eng" :
 this.css_style = "xjs_imeEng"; break;
 case "engOnly" :
 this.css_style = "xjs_imeDis"; break;
 }
 this.parent.setCss(this.css_style);
}
function xo_auto_focus(parent) { //constant data;
 this.parent = parent;
 this.x_key = "auto_focus";
 this.onkeyup = xe_auto_focus_on_key_up;
}
function xe_auto_focus_on_key_up(evnt) { var evntSrc = evnt ? evnt : window.event;
 if ( evntSrc.keyCode !=9 && evntSrc.keyCode !=16 && this.parent.value.length >= this.parent.getAttribute("maxlength") ) { var nextItem = this.parent.getNextFocus();
 nextItem.focus();
 }
}
function xo_trim(parent) { this.parent = parent;
 this.x_key = "trim";
 this.x_value = parent.getAttribute(this.x_key);
 this.onblur = xe_trim_on_blur;
}
function xe_trim_on_blur(evnt) { if (!this.parent.value) return ; //입력값 없는 경우는 Pass
 switch (this.x_value) { case "left" : tsTarget = this.parent.value.lTrim(); break;
 case "right" : tsTarget = this.parent.value.rTrim(); break;
 default : tsTarget = this.parent.value.trim(); break;
 }
 this.parent.value = tsTarget;
}
function xo_strip_special_char(parent) { this.parent = parent;
 this.x_key = "strip_special_char";
 this.x_value = parent.getAttribute(this.x_key);
 this.onblur = xe_strip_special_char_on_blur;
}
function xe_strip_special_char_on_blur(evnt) { if (!this.parent.value) return ; //입력값 없는 경우는 Pass
 this.parent.value = this.parent.value.stripSpecial();
}
function xo_strip_white_space(parent) { this.parent = parent;
 this.x_key = "strip_white_space";
 this.x_value = parent.getAttribute(this.x_key);
 this.onblur = xe_strip_white_space_on_blur;
}
function xe_strip_white_space_on_blur(evnt) { if (!this.parent.value) return ; //입력값 없는 경우는 Pass
 this.parent.value = this.parent.value.stripWhite();
}
function xo_edit_align(parent) { //constant data;
 this.parent = parent;
 this.x_key = "edit_align";
 this.x_value = parent.getAttribute(this.x_key);
 //define css style
 switch(this.x_value) { case "right" :
 this.css_style = "xjs_right";
 break;
 case "center" :
 this.css_style = "xjs_center";
 break;
 case "left" :
 defalut :
 this.css_style = "xjs_left";
 break;
 }
 this.parent.setCss(this.css_style);
}
function xo_is_value(parent) { //constant data;
 this.parent = parent;
 this.x_key = "is_value";
 this.x_value = parent.getAttribute(this.x_key);
 this.validate = xm_is_value_validate;
 this.getMessage = pxm_get_message;
}
function xm_is_value_validate(alertflag, evnt) { var flag = true; //true when validation successful.
 var errFlag = true;
 var evalStr = "";
 if ( this.x_value.indexOf(".") == -1 ) { evalStr = "this.parent.form." + this.x_value;
 if (typeof(eval(evalStr)) != 'undefined' ) errFlag = false;
 } else { var evalStrArr = this.x_value.split(".");
 if (evalStrArr.length == 3 ) { var eStr1 = "window." + evalStrArr[0];
 var eStr2 = eStr1 + "." + evalStrArr[1];
 var eStr3 = eStr2 + "." + evalStrArr[2];
 if (( typeof(eval(eStr1)) != 'undefined') && (typeof(eval(eStr2)) != 'undefined') && ( typeof(eval(eStr3)) != 'undefined') ) { evalStr = eStr3; errFlag = false;
 }
 }
 }
 if (errFlag) { this.parent.alert(alertflag, this.getMessage(0, this.parent.name + "," + this.x_value ));
 return false;
 }
 var compateItem = eval(evalStr);
 if (compateItem && typeof(compateItem.value) == 'undefined') { this.parent.alert(alertflag, this.getMessage(1, this.parent.name + "," + this.x_value ));
 flag = false;
 }
 if (flag && this.parent.value != compateItem.value) { var item1 = this.parent.isAttrValue("itemname") ? this.parent.getAttribute("itemname") : this.parent.name;
 var item2 = compateItem.isAttrValue("itemname") ? compateItem.getAttribute("itemname") : compateItem.name;
 this.parent.alert(alertflag, this.getMessage(2, item1 +","+ item2));
 flag=false;
 }
 return flag;
}
function xo_focus_this(parent) { this.parent = parent;
 this.x_key = "focus_this";
 if (!this.parent.form.name || !window.xGetOption("X_FOCUS_THIS_USE_TIME_OUT"))
 this.parent.focus();
 else { var parentId = this.parent.sourceIndex;
 window.setTimeout("document.all["+parentId+"].focus()", 30); 
 }
}
function xo_show_this(parent) { this.parent = parent;
 this.x_key = "show_this";
 this.parent.show();
}
function xo_hide_this(parent) { this.parent = parent;
 this.x_key = "hide_this";
 this.parent.hide();
}
function xo_disable_this(parent) { this.parent = parent;
 this.x_key = "disable_this";
 this.parent.disable();
}
function xo_readonly_this(parent) { this.parent = parent;
 this.x_key = "readonly_this";
 this.parent.setReadOnly();
}
function xo_enable_fields(parent) { this.parent = parent;
 this.x_key = "enable_fields";
 this.x_value = parent.getAttribute(this.x_key);
 this.x_ifvalues = parent.isAttrValue("enable_values") ? parent.getAttribute("enable_values") : null ;
 this.normalCmd = "enable";
 this.reverseCmd = "disable";
 this.initialize = xpm_duih_initialize;
 this.duiHandler = xpe_dui_handler;
}
function xo_disable_fields(parent) { this.parent = parent;
 this.x_key = "disable_fields";
 this.x_value = parent.getAttribute(this.x_key);
 this.x_ifvalues = parent.isAttrValue("disable_values") ? parent.getAttribute("disable_values") : null ;
 this.normalCmd = "disable";
 this.reverseCmd = "enable";
 this.initialize = xpm_duih_initialize;
 this.duiHandler = xpe_dui_handler;
}
function xo_show_fields(parent) { this.parent = parent;
 this.x_key = "show_fields";
 this.x_value = parent.getAttribute(this.x_key);
 this.x_ifvalues = parent.isAttrValue("show_values") ? parent.getAttribute("show_values") : null ;
 this.normalCmd = "show";
 this.reverseCmd = "hide";
 this.initialize = xpm_duih_initialize;
 this.duiHandler = xpe_dui_handler;
}
function xo_hide_fields(parent) { this.parent = parent;
 this.x_key = "hide_fields";
 this.x_value = parent.getAttribute(this.x_key);
 this.x_ifvalues = parent.isAttrValue("hide_values") ? parent.getAttribute("hide_values") : null ;
 this.normalCmd = "hide";
 this.reverseCmd = "show";
 this.initialize = xpm_duih_initialize;
 this.duiHandler = xpe_dui_handler;
}
function xo_status_bar(parent) { this.parent = parent;
 this.x_key = "status_bar";
 this.x_value = parent.getAttribute(this.x_key);
 this.show = xpe_status_bar_show;
 this.kill = xpe_status_bar_kill;
 this.onfocus = this.show;
 this.onmouseover = this.show;
 this.onblur = this.kill;
 this.onmouseout = this.kill;
}
function xpe_status_bar_show(evnt) { window.status = this.x_value ;
}
function xpe_status_bar_kill(evnt) { window.status = "" ;
}
function xo_balloon(parent) { this.parent = parent;
 this.x_key = "balloon";
 this.x_value = parent.getAttribute(this.x_key);
 this.x_skin = parent.isAttrValue("balloon_skin") ? parent.getAttribute("balloon_skin") : null;
 ( window.xdek ) ? "" : window.xdek = new xDekPopup(this.x_value); //get only one instance;
 this.show = xe_balloon_show;
 this.kill = xe_balloon_kill;
 this.onmouseover = this.show;
 this.onmouseout = this.kill;
}
function xe_balloon_show(evnt) { if (window.xdek) window.xdek.show(this.x_value, this.x_skin);
}
function xe_balloon_kill(evnt) { if (window.xdek) window.xdek.kill();
}
function xo_send_value(parent) { this.parent = parent;
 this.x_key = "send_value";
 this.x_value = parent.getAttribute(this.x_key);
 this.onclick = xe_send_value_on_click;
}
function xe_send_value_on_click(evnt) { this.parent.form.setSendValue(this.x_value);
}
function xo_lable(parent) { this.parent = parent;
 this.x_key = "lable";
 this.css_style = "xjs_lable";
 this.onfocus = parent.preventFocusHandler;
 this.parent.setCss(this.css_style);
}
function xo_alter(parent) { this.parent = parent;
 this.x_key = "alter";
 this.x_value = parent.getAttribute(this.x_key);
 if (typeof(this.x_value)!= "string" ) return;
 var os = new Array;
 var namesArr = this.x_value.split(",");
 for (var idx=0; idx < namesArr.length; idx++) { var o = eval("this.parent.parent." + namesArr[idx]);
 if (o && o.length) { for (var jdx=0; jdx < o.length; jdx++) this.parent.alterObjs[this.parent.alterObjs.length++] = o[jdx];
 } else if ( typeof(o) == "object" ) { this.parent.alterObjs[this.parent.alterObjs.length++] = o;
 }
 }
}
function xo_sync(parent) { this.parent = parent;
 this.x_key = "sync";
 this.x_value = parent.getAttribute(this.x_key);
 if (typeof(this.x_value)!= "string" ) return;
 
 this.syncObjs = new Array;
 this.syncHandler = xe_sync_handler;
 this.initialize = xm_sync_initialize;
}
function xm_sync_initialize(){ var os = new Array;
 var namesArr = this.x_value.split(",");
 for (var idx=0; idx < namesArr.length; idx++) { var o = eval("this.parent.parent." + namesArr[idx]);
 
 if (o && o.length && o.type != "select-one") { for (var jdx=0; jdx < o.length; jdx++) this.syncObjs[this.syncObjs.length++] = o[jdx];
 } else if ( typeof(o) == "object" ) { this.syncObjs[this.syncObjs.length++] = o;
 }
 }
 switch (this.parent.type) { case "text" : case "password" : 
 this.onkeyup = this.syncHandler;
 break;
 case "select-one" : case "hidden" :
 this.onchange = this.syncHandler;
 break;
 case "radio" : case "checkbox" :
 this.onclick = this.syncHandler;
 break;
 } 
}
function xe_sync_handler(evnt){ for (var idx=0; idx < this.syncObjs.length; idx++) { if (this.syncObjs[idx].type == "checkbox" && this.syncObjs[idx].clear) this.syncObjs[idx].clear();
 if (this.parent.getValue && this.syncObjs[idx].setValue) this.syncObjs[idx].setValue(this.parent.getValue());
 }
}
function xo_selected_duih(parent) { this.parent = parent;
 this.x_key = "selected_duih";
 this.selectedDuiHandler = xe_selected_duih_on_change;
 this.onchange = this.selectedDuiHandler;
}
function xe_selected_duih_on_change(evnt) { var oOptions = this.parent.options;
 var oOption = null;
 for (var idx=0; idx <oOptions.length; idx++) { oOption = oOptions[idx];
 if (oOption.selected == true) { 
 if (oOption.selected_show) eval("this.parent.parent.show(oOption.selected_show)");
 if (oOption.selected_hide) eval("this.parent.parent.hide(oOption.selected_hide)");
 if (oOption.selected_enable) eval("this.parent.parent.enable(oOption.selected_enable)");
 if (oOption.selected_disable) eval("this.parent.parent.disable(oOption.selected_disable)");
 if (oOption.selected_set_read_only) eval("this.parent.parent.setReadOnly(oOption.selected_set_read_only)");
 if (oOption.selected_unset_read_only) eval("this.parent.parent.unsetReadOnly(oOption.selected_unset_read_only)");
 }
 
 }
}
function xo_ddd(parent) { //constant data;
 this.parent = parent;
 this.x_key = "ddd";
 this.validate = xm_ddd_validate;
 this.getMessage = pxm_get_message;
 this.parent.setFilter(this, window.xGetOption("X_NUM_FILTER"));
 
}
function xm_ddd_validate(alertflag, evnt) { var flag = true; //true when validation successful.
 var dddArray = window.xGetOption("X_DDD").split(",");
 if (!this.parent.value) return true;
 
 if(!dddArray.hasValue(this.parent.value)) { flag = false;
 this.parent.alert(alertflag, this.getMessage(0, this.parent.value));
 }
 return flag;
}
function xo_hpd(parent) { //constant data;
 this.parent = parent;
 this.x_key = "hpd";
 this.validate = xm_hpd_validate;
 this.getMessage = pxm_get_message;
 this.parent.setFilter(this, window.xGetOption("X_NUM_FILTER"));
}
function xm_hpd_validate(alertflag, evnt) { var flag = true; //true when validation successful.
 var hpdArray = window.xGetOption("X_HPD").split(",");
 if (!this.parent.value) return true;
 
 if(!hpdArray.hasValue(this.parent.value)) { flag = false;
 this.parent.alert(alertflag, this.getMessage(0, this.parent.value));
 }
 return flag;
}
initializeX();
