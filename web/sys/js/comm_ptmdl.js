/*************************************************************************
* 노태훈 추가
2010.07.23
**************************************************************************/ 	
/**
 * Description : 년/월 만 입력 
 */ 	 

function OpenCalendarM(obj)
{
	//Modal창을 띄운다.
	var txt = null;
	
	if(typeof(obj) == "object")	{
		txt = obj;
	}
	else{
		txt = GetObj(obj);
	}
	
	var args = new Array();
	args[0] = txt.value;
	
	var d       = new Date();
	var date    = d.getDate()        + "";
	var month   = (d.getMonth() + 1) + "";
	
	
	if(month < 10) month = "0" + month;
	
	// 일자 입력형식이 아닌 경우(ex) alphabet ) 오늘일자 넣기    2009.11.18 jdi
	if( args[0] == "" || isNaN(removeChar(args[0], "/"))) {  
		args[0] = d.getFullYear() + "/" + month ;
	}else{ 
		args[0]=args[0]+  "/" + date;
	} 
	var url = "/jsp/cm/lo/calendarM.htm";
	ShowModal(url, args, 250,150);    

	// 일자 미선택 후 창닫기시 이전일자에 "/" 넣기 2009.10.22 jdi 
	if(args[0].indexOf('/')==-1){
		args[0] = args[0].substring(0,4) + "/" + args[0].substring(4,6) ;
	}else { 
		args[0] = args[0].substring(0,4) + args[0].substring(4,7) ;
	}
	
	if(args[0] != null && args[0] != 'undefined' && args[0] != "") {
		txt.value =args[0] ;
	} 
    return args;
} 	 
/*설명 : 달력 호출하고 클릭한 값 입력하기
//수정 : 미선택후 팝업 닫을 경우 공백 입력 가능
//       (GAUCE GRID의 POPFIX속성 사용할 경우 입력된 
//        날짜를 클리어 하기 위한 메소드)
*/
function gf_calendarMExClean(obj)
{
	//Modal창을 띄운다.
	var txt = null;
	
	if(typeof(obj) == "object")	{
		txt = obj;
	}
	else{
		txt = GetObj(obj);
	}
	
	var args = new Array();
	args[0] = txt.value;
	
	var d       = new Date();
	var date    = d.getDate()        + "";
	var month   = (d.getMonth() + 1) + "";
	
	
	if(month < 10) month = "0" + month;
	
	// 일자 입력형식이 아닌 경우(ex) alphabet ) 오늘일자 넣기    2009.11.18 jdi
	if( args[0] == "" || isNaN(removeChar(args[0], "/"))) {  
		args[0] = d.getFullYear() + "/" + month ;
	}else{ 
		args[0]=args[0]+  "/" + date;
	} 
	var url = "/jsp/cm/lo/calendarM.htm";
	ShowModal(url, args, 250,150);    

	// 일자 미선택 후 창닫기시 이전일자에 "/" 넣기 2009.10.22 jdi 
	if(args[0].indexOf('/')==-1){
		args[0] = args[0].substring(0,4) + "/" + args[0].substring(4,6) ;
		args[0] = "";
		txt.value = "";
	}else { 
		args[0] = args[0].substring(0,4) + args[0].substring(4,7) ;
	}
	
	if(args[0] != null && args[0] != 'undefined' && args[0] != "") {
		txt.value =args[0] ;
	} 
    return args;
} 

/**
 * Description : 폼 submit Get방식을 위한 URI를 생성하기 위해 사용하기 위한 class
 */
function cfURI()
{
    this.page = "";
    this.parameters = new Array();
    this.SetPage    = cfURI_SetPage;
    this.Add        = cfURI_Add;
    this.Clear      = cfURI_Clear;
    this.GetURI     = cfURI_GetURI;
    this.GetParameters     = cfURI_GetParameters;
}

/**
 * Description : Submit 하기 위한 대상 페이지 지정
 */
function cfURI_SetPage(page)
{
    this.page = page;
}

/**
 * Description : URI에 포함될 파라메타를 추가한다
 */
function cfURI_Add(name,val)
{
    this.parameters[this.parameters.length] = name+"="+val;
}

/**
 * Description : URI 얻기
 */
function cfURI_GetURI()
{
    return this.page + "?" + this.parameters.join("&");
}

/**
 * Description : 파라메타 문자열 얻기
 */
function cfURI_GetParameters()
{
    return this.parameters.join(",");
}

/**
 * Description : 멤버 변수 초기화
 */
function cfURI_Clear()
{
    this.page = "";
    this.parameters = new Array();
}

/**
 * Description : Fast Search  
 */
function On_Apply(args1, kcode) {
 
    if(kcode != 8 && kcode != 13 && kcode != 27 && kcode != 33 && kcode != 34 && kcode != 35 &&
        kcode != 36 && kcode != 37 && kcode != 38 && kcode != 39 && kcode != 40 && kcode != 45 &&
        kcode != 46 && kcode != undefined)
        {
        
            setTimeout(args1+".ShowSearchCol()");
        }
}

/**
 * 데이터셋의 최 상단에 'BLANK' 값 Insert
 */
function cfUnionBlank(oTargetDataSet, oTargetLuxeCombo, codeColumn, nameColumn ,nameValue) {
    if(nameValue == "undifined"){
    	nameValue="";
    }    
    oTargetDataSet.InsertRow(1);
    oTargetDataSet.NameValue(1, codeColumn) = "";
    oTargetDataSet.NameValue(1, nameColumn) = nameValue; 
    oTargetLuxeCombo.Index=0;
}

/**
 * 데이터셋의 최 상단에 'BLANK' 값 Insert
 */
function cfDsUnionBlank(oTargetDataSet,codeColumn, nameColumn,nameValue) {
    if(nameValue == "undifined"){
    	nameValue="";
    }
    oTargetDataSet.InsertRow(1);
    oTargetDataSet.NameValue(1, codeColumn) = "";
    oTargetDataSet.NameValue(1, nameColumn) = nameValue;
}

/**
 * 데이터셋의 Y,N 값 자동 세팅
 * 최상단 공백 추가시 BLANK 파라미터 추가
 * ex) cfAddYn(ds명,컬럼명,"BLANK")형식으로 입력시 사용 가능
 * 불필요시 그냥 codeBlank에 값 필요없이
 * ex) cfAddYn(ds명,컬럼명)형식으로 입력시 사용 가능
 */
function cfAddYn(oTargetDataSet,codeColumn,codeBlank) {
    if(codeBlank == "undifined"){
    	codeBlank="";
    }
	var strHeader  = codeColumn+":STRING(2),name:STRING(10)";
    oTargetDataSet.SetDataHeader(strHeader);

    
    if(codeBlank =="BLANK" ){
	    oTargetDataSet.AddRow();
    	oTargetDataSet.NameValue(oTargetDataSet.RowPosition, codeColumn) = "";    
    	oTargetDataSet.NameValue(oTargetDataSet.RowPosition, "name") = "--Total--"; 
    }
    oTargetDataSet.AddRow();
    oTargetDataSet.NameValue(oTargetDataSet.RowPosition, codeColumn) = "Y"; 
    oTargetDataSet.NameValue(oTargetDataSet.RowPosition, "name") = "Yes";
    
    oTargetDataSet.AddRow();
    oTargetDataSet.NameValue(oTargetDataSet.RowPosition, codeColumn) = "N"; 
    oTargetDataSet.NameValue(oTargetDataSet.RowPosition, "name") = "No";
}

function cfGender(oTargetDataSet,codeColumn,codeBlank) {
    if(codeBlank == "undifined"){
    	codeBlank="";
    }
	var strHeader  = codeColumn+":STRING(2),name:STRING(6)";
    oTargetDataSet.SetDataHeader(strHeader);

    if(codeBlank =="BLANK" ){
	    oTargetDataSet.AddRow();
    	oTargetDataSet.NameValue(oTargetDataSet.RowPosition, codeColumn) = "";    
    	oTargetDataSet.NameValue(oTargetDataSet.RowPosition, "name") = ""; 
    }
    oTargetDataSet.AddRow();
    oTargetDataSet.NameValue(oTargetDataSet.RowPosition, codeColumn) = "M"; 
    oTargetDataSet.NameValue(oTargetDataSet.RowPosition, "name") = "Male";
    
    oTargetDataSet.AddRow();
    oTargetDataSet.NameValue(oTargetDataSet.RowPosition, codeColumn) = "W"; 
    oTargetDataSet.NameValue(oTargetDataSet.RowPosition, "name") = "Female";
    oTargetDataSet.RowPosition=1;
}

/**
 * 
 */
function cfWinOpen(URL,winName,width,height)
{
    var w, strop
    strop = "width=" + width + ",height=" + height +
            ",left=" + (screen.width/2 - width/2) + ",top=" + (screen.height/2 - height/2) +
            ",scrollbars=0,menubar=0,status=0,toolbar=0,location=0,directories=0,resizable=0";
    window.open(URL,winName,strop);
}

/**
 * 
 */
function cfProgress(oDataSet)
{	
	rs_ds = new Progress();  
	rs_ds.submit(oDataSet, 280, 260);  
}

function cfTrProgress(oTr,oRetrive)
{	
	rs_tr = new Progress(); 
	rs_tr.setCallBack(oRetrive);
	rs_tr.submit(oTr, 280, 260);  
}

/**
 * 엑셀내려받기
 * p_dataset  : 엑셀 다운로드할 데이터셋 오브젝트 명
 * p_grid     : 엑셀 다운로드할 그리드 오브젝트 명
 * p_fileName : 확장자를 제거한 순수 파일이름
 * p_path     : 드라이버 명부터 하위폴더까지 적용 
   ex:)c:\\a
 */

function gf_excel(p_dataset,p_grid,p_fileName,p_path) {
 
	if(p_dataset.CountRow > 0) {
		var v_shtName = p_fileName;
	    var v_path = p_path;
	    var v_fileName = v_path+v_shtName+".xls";
		p_grid.SetExcelTitle(0, "");
	    p_grid.SetExcelTitle(1, "value:" + v_shtName + "; font-face:굴림체; font-size:15pt; font-color:black;font-bold; font-underline; bgcolor:white; align:center; skiprow:3;")
		p_grid.GridToExcel(v_shtName, v_fileName, 1);
	} else {
		alert("No Data");
	}
} 


/*******************************************************/
// Payment Term Search
/*******************************************************/
function openPayTermSearch(obj , row , payTermCd, val1 , val2) {
 
	var result ;

	result =  window.showModalDialog( "ps.sm.retrievePopPaymentTerm.dev?progCd=CM9999&payTermCd="+payTermCd,"PayTerm", "dialogWidth=550px;dialogHeight=375px");

    if (result == -1 || result == null || result == "") {
       // obj.NameValue(row,val1) = "";
       // obj.NameValue(row,val2 ) = "";
	} else {
		if(result != null)
		{	
			obj.NameValue(row,val1)  = result.payTermCd;
			obj.NameValue(row,val2)  = result.payTermNm;
			
			cfSetObjectValue("payTermCd",result.payTermCd);
			cfSetObjectValue("payTermNm",result.payTermNm);
		}
    }

}

//-------------------------------------------------------------------------
// Grid Account Popup
//-------------------------------------------------------------------------
function openAccountCodeListGridWin(row, acctGb, obj) {

    var result = "";
    var firstList = new Array ();

    var popupId       = "AccountCodeList";
    var popupStr      = "/jsp/cm/cd/pop_" + popupId + ".jsp";
    
    var acctCd        = "?acctCd="        + ""; //obj.NameValue(row,"acctCd");
    var acctGb        = "&acctGb="        + acctGb;	  //LOC:농장, SAP:SAP
    var tgOneSelect   = "&tgOneSelect="   + "T";                      // 한 건인 경우 자동선택
    var popType       = "&popType="       + "ptpam_" + popupId;
    var popupWidth    = "dialogWidth="    + "400px";
    var popupHeight   = ";dialogHeight="  + "375px";

    result = window.showModalDialog( popupStr + acctCd + acctGb + tgOneSelect + popType, popupId, popupWidth + popupHeight );
       
    if (result == -1 || result == null || result == "") {
        obj.NameValue(row,"acctCd")       = "";
        obj.NameValue(row,"acctNm")       = "";
        obj.NameValue(row,"sapAcctCd")    = "";
        obj.NameValue(row,"area")         = "";
        obj.NameValue(row,"div")          = "";
        obj.NameValue(row,"block")        = "";
        obj.NameValue(row,"block2")       = "";
        obj.NameValue(row,"year")         = "";
        obj.NameValue(row,"tm")           = "";
        obj.NameValue(row,"sp")           = "";
        obj.NameValue(row,"vatyn")        = "";
        obj.NameValue(row,"checkDuedate") = "";
        obj.NameValue(row,"vat")          = "";
        obj.NameValue(row,"vatAmt")       = "";
        obj.NameValue(row,"dueDate")      = "";
	} else {
        firstList = result.split(";");
        obj.NameValue(row,"acctCd")       = firstList[0];
        obj.NameValue(row,"acctNm")       = firstList[1];
        obj.NameValue(row,"sapAcctCd")    = firstList[2];
        obj.NameValue(row,"area")         = firstList[3];
        obj.NameValue(row,"div")          = firstList[4];
        obj.NameValue(row,"block")        = firstList[5];
        obj.NameValue(row,"block2")       = firstList[6];
        obj.NameValue(row,"year")         = firstList[7];
        obj.NameValue(row,"tm")           = firstList[8];
        obj.NameValue(row,"sp")           = firstList[9];
        obj.NameValue(row,"vatyn")        = firstList[10];
        obj.NameValue(row,"checkDuedate") = firstList[11];
        obj.NameValue(row,"vat")          = "";
        obj.NameValue(row,"vatAmt")       = "";
        obj.NameValue(row,"dueDate")      = "";
        obj.NameValue(row,"actvCd")      = firstList[12];
    }

}


//-------------------------------------------------------------------------
// Account Popup No. Search
// sFlag : if  sFlag == s  then sOutputName1  else sFlag == b then sOutputName1,sOutputName2
// acctGb : LOC:농장, SAP:SAP
// sInputVenderCd : 초기 입력된 계정
// sOutputName1 : 입력될 input box name
// sOutputName2 : 입력될 input box name
//-------------------------------------------------------------------------
function openAccountCodeListSearch(sFlag,sAcctGb,sInputAcctCd,sOutputName1,sOutputName2) {
    var result = "";
    var firstList = new Array ();

    var popupId             = "AccountCodeList";
    var popupStr            = "cm.ac.popAccountCodeListPopUp.dev";

    var acctCd        = "?progCd=PS9999&acctCd="        + sInputAcctCd + "&acctGb="        + sAcctGb;	  //LOC:농장, SAP:SAP
    var popType             = "&popType="           + "ptmdl_" + popupId;
    var popupWidth          = "dialogWidth="        + "400px";
    var popupHeight         = ";dialogHeight="      + "375px";

    result = window.showModalDialog( popupStr + acctCd + popType, popupId, popupWidth + popupHeight );
    
    if (result == -1 || result == null || result == "") {
    	if (sFlag == "s") {
        	eval("document.all."+sOutputName1).value = "";  // 초기화
        } else if (sFlag == "b") {
        	eval("document.all."+sOutputName1).value = "";  // 초기화
    		eval("document.all."+sOutputName2).value = "";  // 초기화
        }
        return;
    } else {
	    firstList = result.split(";");
	    //firstList[0];
	    
    	if (sFlag == "s") {
	    	eval("document.all."+sOutputName1).value = firstList[0];
    	} else if (sFlag == "b") {
    		eval("document.all."+sOutputName1).value = firstList[0];
	    	eval("document.all."+sOutputName2).value = firstList[1];
	    }
    } 
}


//-------------------------------------------------------------------------
// Grid Material Popup
//-------------------------------------------------------------------------
function openMaterialCodeListGridWin(row, obj) {

    var result = "";
    var firstList = new Array ();

    var popupId             = "MaterialCodeList";
    var popupStr            = "/jsp/cm/cd/pop_" + popupId + ".jsp";

    var acctCd              = "?materCd="           + obj.NameValue(row,"materCd");
    var tgOneSelect         = "&tgOneSelect="       + "T";                      // 한 건인 경우 자동선택
    var popType             = "&popType="           + "ptpam_" + popupId;
    var popupWidth          = "dialogWidth="        + "400px";
    var popupHeight         = ";dialogHeight="      + "375px";

    result = window.showModalDialog( popupStr + acctCd + tgOneSelect + popType, popupId, popupWidth + popupHeight );

    if (result == -1 || result == null || result == "") {
    	obj.NameValue(row,"materCd") = "";
        obj.NameValue(row,"materNm") = "";
        obj.NameValue(row,"unit") = "";
	} else {
        firstList = result.split(";");
        obj.NameValue(row,"materCd") = firstList[0];
        obj.NameValue(row,"materNm") = firstList[1];
        obj.NameValue(row,"unit") = firstList[2];
    }
}      

//-------------------------------------------------------------------------
// Grid Material Popup
// 2011.08.17 hskim Model Name 추가
//-------------------------------------------------------------------------
function openMaterialCodeListGridConWin(row, obj,type) {
    if(type == "undifined"){
    	type="";
    }    
    var result = "";
    var firstList = new Array ();

    var popupId             = "MaterialCodeListCon";
    var popupStr            = "/jsp/cm/cd/pop_" + popupId + ".jsp"
	var acctCd              = "?materCd="           + obj.NameValue(row,"materCd");
    
    if(type!=""){
    	acctCd+="&type="              + type; 
    }  
    var tgOneSelect         = "&tgOneSelect="       + "T";                      // 한 건인 경우 자동선택
    var popType             = "&popType="           + "ptpam_" + popupId;
    var popupWidth          = "dialogWidth="        + "500px";
    var popupHeight         = ";dialogHeight="      + "468px";

    result = window.showModalDialog( popupStr + acctCd + tgOneSelect + popType, popupId, popupWidth + popupHeight );
    
    if (result == -1 || result == null || result == "") {
    	obj.NameValue(row,"materCd") = "";
        obj.NameValue(row,"materNm") = "";
        obj.NameValue(row,"modelNm") = "";
        obj.NameValue(row,"unit") = "";
	} else {
        firstList = result.split(";");
        obj.NameValue(row,"materCd") = firstList[0];
        obj.NameValue(row,"materNm") = firstList[1];
        obj.NameValue(row,"modelNm") = firstList[2];
        obj.NameValue(row,"unit") = firstList[3];
    }

}      
   

//-------------------------------------------------------------------------
// Grid Vendor Popup
//-------------------------------------------------------------------------
function openVendorCodeListGridWin(row, obj) {

    var result = "";
    var firstList = new Array ();

    var popupId             = "VendorCodeList";
    var popupStr            = "/jsp/cm/cd/pop_" + popupId + ".jsp";

    var vendCd              = "?vendCd="        + obj.NameValue(row,"vendCd");
    var tgOneSelect         = "&tgOneSelect="   + "T";                      // 한 건인 경우 자동선택
    var popType             = "&popType="       + "ptpam_" + popupId;
    var popupWidth          = "dialogWidth="    + "400px";
    var popupHeight         = ";dialogHeight="  + "375px";

    result = window.showModalDialog( popupStr + vendCd + tgOneSelect + popType, popupId, popupWidth + popupHeight );

    if (result == -1 || result == null || result == "") {
        obj.NameValue(row,"vendCd") = "";
        obj.NameValue(row,"vendNm") = "";
	} else {
        firstList = result.split(";");
        obj.NameValue(row,"vendCd") = firstList[0];
        obj.NameValue(row,"vendNm") = firstList[1];
    }

}


//-------------------------------------------------------------------------
// Grid Vendor Popup
//-------------------------------------------------------------------------
function openVendorSapListGridWin(row, obj, name) {

    var result = "";
    var firstList = new Array ();

    var popupId             = "VendorCodeList";
    var popupStr            = "/jsp/cm/cd/pop_" + popupId + ".jsp";

    var vendCd              = "?vendCd="        + obj.NameValue(row,"vendCd");
    var tgOneSelect         = "&tgOneSelect="   + "T";                      // 한 건인 경우 자동선택
    var popType             = "&popType="       + "ptpam_" + popupId;
    var popupWidth          = "dialogWidth="    + "400px";
    var popupHeight         = ";dialogHeight="  + "375px";

    result = window.showModalDialog( popupStr + vendCd + tgOneSelect + popType, popupId, popupWidth + popupHeight );

    if (result == -1 || result == null || result == "") {
        obj.NameValue(row,name) = "";
	} else {
        firstList = result.split(";");
        obj.NameValue(row,name) = firstList[0];
    }

}

   
//-------------------------------------------------------------------------
// Account Popup
//-------------------------------------------------------------------------
function openAccountCodeListWin(acctGb) {

    var result = "";
    var firstList = new Array ();

    var popupId       = "AccountCodeList";
    var popupStr      = "/jsp/cm/cd/pop_" + popupId + ".jsp";
    
    var acctCd        = "?acctCd="        + document.all.acctCd.value;
    var acctGb        = "&acctGb="        + acctGb; //LOC:농장, SAP:SAP
    var tgOneSelect   = "&tgOneSelect="   + "T";                      // 한 건인 경우 자동선택
    var popType       = "&popType="       + "ptpam_" + popupId;
    var popupWidth    = "dialogWidth="    + "400px";
    var popupHeight   = ";dialogHeight="  + "375px";

	result = window.showModalDialog( popupStr + acctCd + acctGb + tgOneSelect + popType, popupId, popupWidth + popupHeight );
       
    if (result == -1 || result == null || result == "") {
        document.all.acctCd.value = "";  // 초기화
        return;
    } else {
	    firstList = result.split(";");
    	document.all.acctCd.value = firstList[0];
    }

}
   
   
   
//-------------------------------------------------------------------------
// Material Popup
//-------------------------------------------------------------------------
function openMaterialCodeListWin() {

    var result = "";
    var firstList = new Array ();

    var popupId             = "MaterialCodeList";
    var popupStr            = "/jsp/cm/cd/pop_" + popupId + ".jsp";

    var acctCd              = "?materCd="           + document.all.materCd.value;
    var tgOneSelect         = "&tgOneSelect="       + "T";                      // 한 건인 경우 자동선택
    var popType             = "&popType="           + "ptpam_" + popupId;
    var popupWidth          = "dialogWidth="        + "400px";
    var popupHeight         = ";dialogHeight="      + "375px";

    result = window.showModalDialog( popupStr + acctCd + tgOneSelect + popType, popupId, popupWidth + popupHeight );
    
    if (result == -1 || result == null || result == "") {
        document.all.materCd.value = "";  // 초기화
        return;
    } else {
	    firstList = result.split(";");
    	document.all.materCd.value = firstList[0];
    }

}      

//-------------------------------------------------------------------------
// Vendor Popup
//-------------------------------------------------------------------------
function openVendorCodeListWin() {

    var result = "";
    var firstList = new Array ();

    var popupId             = "VendorCodeList";
    var popupStr            = "/jsp/cm/cd/pop_" + popupId + ".jsp";

    var vendCd              = "?vendCd="            + document.all.vendCd.value;
    var tgOneSelect         = "&tgOneSelect="       + "T";                      // 한 건인 경우 자동선택
    var popType             = "&popType="           + "ptpam_" + popupId;
    var popupWidth          = "dialogWidth="        + "400px";
    var popupHeight         = ";dialogHeight="      + "375px";

    result = window.showModalDialog( popupStr + vendCd + tgOneSelect + popType, popupId, popupWidth + popupHeight );
    
    if (result == -1 || result == null || result == "") {
        document.all.vendCd.value = "";  // 초기화
        return;
    } else {
	    firstList = result.split(";");
    	document.all.vendCd.value = firstList[0];
    }

}
//-------------------------------------------------------------------------
// Id check Popup
//-------------------------------------------------------------------------
function openIdCheck(userId) {

    var result = "";
    var firstList = new Array ();

    var popupId       = "UserMgnt";
    var popupStr      = "/jsp/cm/ur/pop_" + popupId + ".jsp";
    
    var userId        = "?userId="        + document.all.userId.value;
    var tgOneSelect   = "&tgOneSelect="   + "T";                      // 한 건인 경우 자동선택
    var popType       = "&popType="       + "ptpam_" + popupId;
    var popupWidth    = "dialogWidth="    + "400px";
    var popupHeight   = ";dialogHeight="  + "375px";

	result = window.showModalDialog( popupStr + userId + tgOneSelect + popType, popupId, popupWidth + popupHeight );
       
    if (result == -1 || result == null || result == "") {
        document.all.acctCd.value = "";  // 초기화
        return;
    } else {
	    firstList = result.split(";");
    	document.all.userId.value = firstList[0];
    }

}
//-------------------------------------------------------------------------
// Emplyee No. Check
//-------------------------------------------------------------------------
function openEmployeeChk() {
    var result = "";
    var firstList = new Array ();

    var popupId       = "UserMgnt";
    var popupStr      = "/jsp/cm/ur/pop_" + popupId + ".jsp";
    
    var userId        = "?userId="        + document.all.userId.value;
    var tgOneSelect   = "&tgOneSelect="   + "T";                      // 한 건인 경우 자동선택
    var popType       = "&popType="       + "ptpam_" + popupId;
    var popupWidth    = "dialogWidth="    + "400px";
    var popupHeight   = ";dialogHeight="  + "435px";
    
	result = window.showModalDialog( popupStr + userId + tgOneSelect + popType, popupId, popupWidth + popupHeight );
       
    if (result == -1 || result == null || result == "") {
        document.all.userId.value = "";  // 초기화
        document.all.userNm.value = "";  // 초기화
        return;
    } else {
	    firstList = result.split(";");
    	document.all.userId.value = firstList[0];
    	document.all.userNm.value = firstList[1];
    }

}

//-------------------------------------------------------------------------
// Emplyee No. Search
// sFlag : if  sFlag == s  then sOutputName1  else sFlag == b then sOutputName1,sOutputName2
// sInputEmpNo : 초기 입력된 사번
// sOutputName1 : 입력될 input box name
// sOutputName2 : 입력될 input box name
//-------------------------------------------------------------------------
function openEmployeeSearch(sFlag,sInputEmpNo,sOutputName1,sOutputName2) {

    var result = "";
    var firstList = new Array ();

    var popupId       = "EmployMgnt";
    var popupStr      = "/jsp/cm/ur/pop_" + popupId + ".jsp";
    
    var empNo        = "?empNo="        + sInputEmpNo;
    var tgOneSelect   = "&tgOneSelect="   + "T";                      // 한 건인 경우 자동선택
    var popType       = "&popType="       + "ptpam_" + popupId;
    var popupWidth    = "dialogWidth="    + "400px";
    var popupHeight   = ";dialogHeight="  + "435px";
    
	result = window.showModalDialog( popupStr + empNo + tgOneSelect + popType, popupId, popupWidth + popupHeight );
    
    
    if (result == -1 || result == null || result == "") {
    	if (sFlag == "s") {
        	eval("document.all."+sOutputName1).value = "";  // 초기화
        } else if (sFlag == "b") {
        	eval("document.all."+sOutputName1).value = "";  // 초기화
    		eval("document.all."+sOutputName2).value = "";  // 초기화
        }
        return;
    } else {
	    firstList = result.split(";");
    	if (sFlag == "s") {
	    	eval("document.all."+sOutputName1).value = firstList[0];
    	} else if (sFlag == "b") {
    		eval("document.all."+sOutputName1).value = firstList[0];
	    	eval("document.all."+sOutputName2).value = firstList[1];
	    }
    }

}
// SAP Account Popup
//-------------------------------------------------------------------------
function openAccountSapCodeListGridWin(row, obj) {

    var result = "";
    var firstList = new Array ();

    var popupId             = "AccountMgnt";
    var popupStr            = "/jsp/cm/cd/pop_" + popupId + ".jsp";

    var sapAcctCd           = "?sapAcctCd="         + obj.NameValue(row,"sapAcctCd");
    var acctSapNmEn         = "?acctSapNmEn="       + obj.NameValue(row,"acctSapNmEn");
    var acctSapProp         = "?acctSapProp="       + obj.NameValue(row,"acctSapProp");
    var tgOneSelect         = "&tgOneSelect="       + "T";                      // 한 건인 경우 자동선택
    var popType             = "&popType="           + "ptpam_" + popupId;
    var popupWidth          = "dialogWidth="        + "400px";
    var popupHeight         = ";dialogHeight="      + "375px";

    result = window.showModalDialog( popupStr + sapAcctCd + tgOneSelect + popType, popupId, popupWidth + popupHeight );

    if (result == -1 || result == null || result == "") {
    	obj.NameValue(row,"acctSapCd") = "";
    	obj.NameValue(row,"acctSapNmEn") = "";
    	obj.NameValue(row,"acctSapProp") = "";
    	obj.NameValue(row,"attr9") = "";
	} else {
        firstList = result.split(";");
        obj.NameValue(row,"acctSapCd") = firstList[0];
        obj.NameValue(row,"acctSapNmEn") = firstList[1];
        obj.NameValue(row,"acctSapProp") = firstList[2];
 		obj.NameValue(row,"attr9") = firstList[3];
	     if(obj.NameValue(row,"acctSapCd").substring(0,1)=="9"){
	   	  obj.NameValue(row,"tm") = "Y";
	   	  obj.NameValue(row,"aboutTm") = "1";
        }else{
          obj.NameValue(row,"aboutTm") = "0";
        }

	}
}      

function valiDate(obj) {
    
    if(obj.value == "") return;
	if(!cfValidateValue(removeDash(obj.value,"/"), "date=YYYYMMDD")) {
		alert("Check Date Format");
		obj.focus();
		return;
	}
}

function valiDateYYYYMM(obj) {
    
    if(obj.value == "") return;
	if(!cfValidateValue(removeDash(obj.value,"/"), "date=YYYYMM")) {
		alert("Check Date Format");
		obj.focus();
		return;
	}
}

//-------------------------------------------------------------------------
// 그리드에 TM  Area Div Block1, Block2, 에 값이 있으면 그 값이 존재하는 하위 리스트를 뽑기위한 함수
//-------------------------------------------------------------------------
function checkMaterialValue(row, i, obj){
	var areaCheck = true;
	var divCheck = true;
	var block1Check = true;
	var block2Check = true;

	if(obj.NameValue(row, "areaCd") != ""){
		areaCheck = false;
		if(ds_materInfo.NameValue(i, "areaCd") == obj.NameValue(row, "areaCd") ){
			areaCheck = true;
		}
	}
	if(obj.NameValue(row, "divCd") != ""){
		divCheck = false;
		if(ds_materInfo.NameValue(i, "divCd") == obj.NameValue(row, "divCd") ){
			divCheck = true;
		}
	}
	if(obj.NameValue(row, "blockCd") != ""){
		block1Check = false;
		if(ds_materInfo.NameValue(i, "blockCd") == obj.NameValue(row, "blockCd") ){
			block1Check = true;
		}
	}
	if(obj.NameValue(row, "blockCd2") != ""){
		block2Check = false;
		if(ds_materInfo.NameValue(i, "blockCd2") == obj.NameValue(row, "blockCd2") ){
			block2Check = true;
		}
	}		
	
	if(areaCheck && divCheck && block1Check && block2Check)
		return true;
	else
		return false;
}

//------------------------------------------------------------------------
// Material콤보 (Area, Division, Block1, Block2, Year)  DataSet Setting
//-------------------------------------------------------------------------
function setMaterialComboData(dataSet, codeName, row, obj){
	if(codeName == "areaCd"){
		obj.NameValue(row, "areaCd")   = "";
		obj.NameValue(row, "divCd")     = "";
		obj.NameValue(row, "blockCd")  = "";
		obj.NameValue(row, "blockCd2") = "";
		obj.NameValue(row, "yearCd") = "";
		
		ds_division.ClearData();
		ds_block1.ClearData();
		ds_block2.ClearData();
		ds_year.ClearData();
		
	}else if(codeName == "divCd"){
		obj.NameValue(row, "divCd")     = "";
		obj.NameValue(row, "blockCd")  = "";
		obj.NameValue(row, "blockCd2") = "";		
		obj.NameValue(row, "yearCd") = "";			

		ds_block1.ClearData();
		ds_block2.ClearData();
		ds_year.ClearData();

	}else if(codeName == "blockCd"){
		obj.NameValue(row, "blockCd")  = "";
		obj.NameValue(row, "blockCd2") = "";			
		obj.NameValue(row, "yearCd") = "";			

		ds_block2.ClearData();
		ds_year.ClearData();

	}else if(codeName == "blockCd2"){
		obj.NameValue(row, "blockCd2") = "";			
		obj.NameValue(row, "yearCd") = "";				

		ds_year.ClearData();

	}else {
		obj.NameValue(row, "yearCd") = "";				

	}
		
	var isExist = false;

	if(obj.NameValue(row, "tmTbm") == "A"){       			// TM
		for(var i=1; i<=ds_materInfo.CountRow; i++){
			if(ds_materInfo.NameValue(i, "materType") == "7920" && checkMaterialValue(row,i,obj) ){
				isExist = false;
				//같은 데이타가 중복되면 막음
				for(var j=1; j<=ds_area.CountRow; j++){    
					if(dataSet.NameValue(j, "code") == ds_materInfo.NameValue(i, codeName)){ 
						isExist = true;
					}
				}
				if(!isExist){
					dataSet.AddRow();
				    dataSet.NameValue(dataSet.CountRow, "code") = ds_materInfo.NameValue(i, codeName);	
				}
			}
		}
	    
	}else if(obj.NameValue(row, "tmTbm") == "B"){   		// TBM
		for(var i=1; i<=ds_materInfo.CountRow; i++){
			if((ds_materInfo.NameValue(i, "materType") == "9100" || ds_materInfo.NameValue(i, "materType") == "9200") && checkMaterialValue(row,i, obj)){
				isExist = false;
				//같은 데이타가 중복되면 막음
				for(var j=1; j<=dataSet.CountRow; j++){    
					if(dataSet.NameValue(j, "code") == ds_materInfo.NameValue(i, codeName)){ 
						isExist = true;
					}
				}
				if(!isExist){
					dataSet.AddRow();
				    dataSet.NameValue(dataSet.CountRow, "code") = ds_materInfo.NameValue(i, codeName);	
				}
			}
		}		
	}else {         														// 3Type 모두 
		for(var i=1; i<=ds_materInfo.CountRow; i++){
			if(checkMaterialValue(row,i, obj)){
				isExist = false;
				//같은 데이타가 중복되면 막음
				for(var j=1; j<=dataSet.CountRow; j++){    
					if(dataSet.NameValue(j, "code") == ds_materInfo.NameValue(i, codeName)){ 
						isExist = true;
					}
				}
				if(!isExist){
					dataSet.AddRow();
				    dataSet.NameValue(dataSet.CountRow, "code") = ds_materInfo.NameValue(i, codeName);	
				}
			}
		}
	}		
	

    
	if(dataSet.CountRow == 0){
		dataSet.AddRow();
		dataSet.NameValue(dataSet.CountRow, "code") = "";	
	}
		
}
 
function ShowModal(url, param, w, h, isCenter)
{
	//화면 상단 중앙에 띄울지 여부.
	if(isCenter == null)
		isCenter = false;
		
	if(w == null)
		w = '500';
	if(h == null)
		h = '400';
	//공통함수, event발생한 좌표 x,y	
	EventCoord(isCenter,w);	
	//alert(x + '|' + y);
	var result;
	//_openedModal = true;
	result = window.showModalDialog(url, param,'dialogWidth=' + w + 'px;dialogHeight=' + h + 'px;status=no;help=no;scroll=no;dialogleft=' + x + 'px;dialogtop=' + y + 'px;');
	//_openedModal = false;
	if(result == null || result == undefined)
	{
		result = '';
	}
	
	return result;		
}

//-------------------------------------------------------------------------
// Customer No. Search
// sFlag : if  sFlag == s  then sOutputName1  else sFlag == b then sOutputName1,sOutputName2
// sInputCustomerCd : 초기 입력된 거래처
// sOutputName1 : 입력될 input box name
// sOutputName2 : 입력될 input box name
//-------------------------------------------------------------------------
function openCustomerSearch(sFlag,sInputCustomerCd,sOutputName1,sOutputName2) {

    var result = "";
    var firstList = new Array ();

    var popupId             = "CustomerCodeList";
    var popupStr            = "/jsp/cm/cd/pop_" + popupId + ".jsp";

    var customerCd      = "?CustomerCd="            + sInputCustomerCd;
    var tgOneSelect      = "&tgOneSelect="       + "T";                      // 한 건인 경우 자동선택
    var popType             = "&popType="           + "ptpam_" + popupId;
    var popupWidth       = "dialogWidth="        + "460px";
    var popupHeight      = ";dialogHeight="      + "375px";
         
    result = window.showModalDialog( popupStr + customerCd + tgOneSelect + popType, popupId, popupWidth + popupHeight );
    
    if (result == -1 || result == null || result == "") {
    	if (sFlag == "s") {
        	eval("document.all."+sOutputName1).value = "";  // 초기화
        } else if (sFlag == "b") {
        	eval("document.all."+sOutputName1).value = "";  // 초기화
    		eval("document.all."+sOutputName2).value = "";  // 초기화
        }
        return;
    } else {
	    firstList = result.split(";");
	    firstList[0];
	    
	    
    	if (sFlag == "s") {
	    	eval("document.all."+sOutputName1).value = firstList[0];
    	} else if (sFlag == "b") {
    		eval("document.all."+sOutputName1).value = firstList[0];
	    	eval("document.all."+sOutputName2).value = firstList[1];
	    }
    } 
}

//-------------------------------------------------------------------------
// Vender No. Search
// sFlag : if  sFlag == s  then sOutputName1  else sFlag == b then sOutputName1,sOutputName2
// sInputVenderCd : 초기 입력된 거래처
// sOutputName1 : 입력될 input box name
// sOutputName2 : 입력될 input box name
//-------------------------------------------------------------------------
function openVenderSearch(sFlag,sInputVenderCd,sOutputName1,sOutputName2,sCreditYn,sVendType) {
    var result = "";
    var firstList = new Array ();

    var popupId             = "VendorCodeList";
    var popupStr            = "";

    var vendCd              = "po.comm.popVendorCodeListPopUp.dev?progCd=PS9999&vendCd="            + sInputVenderCd;
    if(sCreditYn==null || sCreditYn=='' ){
    	vendCd +="&creditYn=";
    }else{
    	vendCd +="&creditYn="+sCreditYn; 
    }
    
     if(sVendType==null || sVendType=='' ){
    	vendCd +="&vendType=";
    }else{
    	vendCd +="&vendType="+sVendType; 
    }
       
    var tgOneSelect         = "&tgOneSelect="       + "T";                      // 한 건인 경우 자동선택
    var popType             = "";
    var popupWidth          = "dialogWidth="        + "460px";
    var popupHeight         = ";dialogHeight="      + "375px";

    result = window.showModalDialog( popupStr + vendCd + tgOneSelect + popType, popupId, popupWidth + popupHeight );
    
    if (result == -1 || result == null || result == "") {
    	if (sFlag == "s") {
        	eval("document.all."+sOutputName1).value = "";  // 초기화
        } else if (sFlag == "b") {
        	eval("document.all."+sOutputName1).value = "";  // 초기화
    		eval("document.all."+sOutputName2).value = "";  // 초기화
        }
        return;
    } else {
	    firstList = result.split(";");
	    //firstList[0];
	    
    	if (sFlag == "s") {
	    	eval("document.all."+sOutputName1).value = firstList[0];
    	} else if (sFlag == "b") {
    		eval("document.all."+sOutputName1).value = firstList[0];
	    	eval("document.all."+sOutputName2).value = firstList[1];
	    }
    } 
}

//-------------------------------------------------------------------------
// Equipment No. Search
// sFlag : if  sFlag == s  then sOutputName1  else sFlag == b then sOutputName1,sOutputName2
// sequipGroup : 장비구분
// sOutputName1 : 입력될 input box name
// sOutputName2 : 입력될 input box name
//-------------------------------------------------------------------------
function openEquipmentSearch(sFlag,sEquipGroup,sOutputName1,sOutputName2) {

    var result = "";
    var firstList = new Array ();

    var popupId          = "EquipmentCodeList";
    var popupStr         = "";

    var EquipmentCd      = "po.comm.popEquipmentCodeListPopUp.dev?progCd=PS9999&equipGroup="        + sEquipGroup;
    var tgOneSelect      = "&tgOneSelect="       + "T";                      // 한 건인 경우 자동선택
    var popType          = "";
    var popupWidth       = "dialogWidth="        + "460px";
    var popupHeight      = ";dialogHeight="      + "375px";
         
    result = window.showModalDialog( popupStr + EquipmentCd + tgOneSelect + popType, popupId, popupWidth + popupHeight );
    
    if (result == -1 || result == null || result == "") {
    	if (sFlag == "s") {
        	eval("document.all."+sOutputName1).value = "";  // 초기화
        } else if (sFlag == "b") {
        	eval("document.all."+sOutputName1).value = "";  // 초기화
    		eval("document.all."+sOutputName2).value = "";  // 초기화
        }
        return;
    } else {
	    firstList = result.split(";");
	    //firstList[0];
	    
    	if (sFlag == "s") {
	    	eval("document.all."+sOutputName1).value = firstList[0];
    	} else if (sFlag == "b") {
    		eval("document.all."+sOutputName1).value = firstList[0];
	    	eval("document.all."+sOutputName2).value = firstList[1];
	    }
    } 
}

//-------------------------------------------------------------------------
// Equipment No. Search
// row : Grid의 Row
// obj : Grid Object
// sEquipGroup  : 장비구분
// sOutputName1 : 입력될 input box name
// sOutputName2 : 입력될 input box name
//-------------------------------------------------------------------------
function openEquipmentSearchInGrid(row,obj,sEquipGroup,sOutputName1,sOutputName2) {

    var result = "";
    var firstList = new Array ();

    var popupId          = "EquipmentCodeList";
    var popupStr         = "";

    var EquipmentCd      = "po.comm.popEquipmentCodeListPopUp.dev?progCd=PS9999&equipGroup="        + sEquipGroup;
    var tgOneSelect      = "&tgOneSelect="       + "T";                      // 한 건인 경우 자동선택
    var popType          = "";
    var popupWidth       = "dialogWidth="        + "460px";
    var popupHeight      = ";dialogHeight="      + "375px";
         
    result = window.showModalDialog( popupStr + EquipmentCd + tgOneSelect + popType, popupId, popupWidth + popupHeight );
    
    if (result == -1 || result == null || result == "") {
    	obj.NameValue(row,sOutputName1) = "";
        obj.NameValue(row,sOutputName2) = "";
	} else {
        firstList = result.split(";");
        obj.NameValue(row,sOutputName1) = firstList[0];
        obj.NameValue(row,sOutputName2) = firstList[1];
    }
}

//-------------------------------------------------------------------------
// Material Popup2(mater Type 포함)
//-------------------------------------------------------------------------

//-------------------------------------------------------------------------
// Grid Material Popup
//-------------------------------------------------------------------------
function openMaterialCodeListGridWin(row, obj) {

    var result = "";
    var firstList = new Array ();

    var popupId             = "MaterialCodeList";
    var popupStr            = "/jsp/cm/cd/pop_" + popupId + ".jsp";

    var acctCd              = "?materCd="           + obj.NameValue(row,"materCd");
    var tgOneSelect         = "&tgOneSelect="       + "T";                      // 한 건인 경우 자동선택
    var popType             = "&popType="           + "ptpam_" + popupId;
    var popupWidth          = "dialogWidth="        + "400px";
    var popupHeight         = ";dialogHeight="      + "375px";

    result = window.showModalDialog( popupStr + acctCd + tgOneSelect + popType, popupId, popupWidth + popupHeight );

    if (result == -1 || result == null || result == "") {
    	obj.NameValue(row,"materCd") = "";
        obj.NameValue(row,"materNm") = "";
        obj.NameValue(row,"unit") = "";
	} else {
        firstList = result.split(";");
        obj.NameValue(row,"materCd") = firstList[0];
        obj.NameValue(row,"materNm") = firstList[1];
        obj.NameValue(row,"unit") = firstList[2];
    }
}  

//-------------------------------------------------------------------------
// Material No. Search
// row : Grid의 Row
// obj : Grid Object
// sMaterType : 자재구분
// sOutputName1 : 입력될 input box name
// sOutputName2 : 입력될 input box name
//-------------------------------------------------------------------------
function openMaterialSearch(row,obj,sMaterType,sOutputName1,sOutputName2) {

    var result = "";
    var firstList = new Array ();

    var popupId             = "MaterialCodeList";
    var popupStr            = "";
    var acctCd              = "po.comm.popMaterialCodeListPopUp.dev?progCd=PS9999&materType="         + sMaterType;
    var tgOneSelect         = "&tgOneSelect="       + "T";                      // 한 건인 경우 자동선택
    var popType             = "";
    var popupWidth          = "dialogWidth="        + "460px";
    var popupHeight         = ";dialogHeight="      + "360px";

    result = window.showModalDialog( popupStr + acctCd + tgOneSelect + popType, popupId, popupWidth + popupHeight );
 
    if (result == -1 || result == null || result == "") {
    	obj.NameValue(row,sOutputName1) = "";
        obj.NameValue(row,sOutputName2) = "";
        obj.NameValue(row,"unit") = "";
        obj.NameValue(row,"materType") = "";
	} else {
        firstList = result.split(";");
        //obj.NameValue(row,"materCd") = firstList[0];
        //obj.NameValue(row,"materNm") = firstList[1];
        
        obj.NameValue(row,sOutputName1) = firstList[0];
        obj.NameValue(row,sOutputName2) = firstList[1];
        obj.NameValue(row,"unit") = firstList[2];
        obj.NameValue(row,"materType") = firstList[3];
    }
    
}  

//-------------------------------------------------------------------------
// Stock Material No. Search
// sFlag : if  sFlag == s  then sOutputName1  else sFlag == b then sOutputName1,sOutputName2
// sWarehouseCd : 창고코드
// sMaterType : 자재구분
// sOutputName1 : 입력될 input box name
// sOutputName2 : 입력될 input box name
//-------------------------------------------------------------------------
function openStockMaterialSearch(row,obj,sWarehouseCd,sStockYm,sMaterType,sOutputName1,sOutputName2) {
 
    var result = "";
    var firstList = new Array ();

    var popupId             = "StockMaterialCodeList";
    var popupStr            = "";

    var acctCd              = "po.comm.popStockMaterialCodeListPopUp.dev?progCd=PS9999&materType="     + sMaterType + "&warehouseCd="+sWarehouseCd + "&stockYm="+sStockYm;
    var tgOneSelect         = "&tgOneSelect="   + "T";// 한 건인 경우 자동선택
    var popType             = "";
    var popupWidth          = "dialogWidth="    + "460px";
    var popupHeight         = ";dialogHeight="  + "375px";

    result = window.showModalDialog( popupStr + acctCd + tgOneSelect + popType, popupId, popupWidth + popupHeight );
 
    if (result == -1 || result == null || result == "") {
    	obj.NameValue(row,sOutputName1) = "";
        obj.NameValue(row,sOutputName2) = "";
        obj.NameValue(row,"unit") = "";
	} else {
        firstList = result.split(";");
        //obj.NameValue(row,"materCd") = firstList[0];
        //obj.NameValue(row,"materNm") = firstList[1];
        
        obj.NameValue(row,sOutputName1) = firstList[0];
        obj.NameValue(row,sOutputName2) = firstList[1];
        obj.NameValue(row,"stockQty") = firstList[2];
        obj.NameValue(row,"unit") = firstList[3];
    }
    
}  

//-------------------------------------------------------------------------
// Petak Search
// sFlag : if  sFlag == s  then sOutputName1  else sFlag == b then sOutputName1,sOutputName2
// sOutputName1 : 입력될 input box name
// sOutputName2 : 입력될 input box name
//-------------------------------------------------------------------------
function openPetakSearch(sFlag,codeType,sOutputName1,sOutputName2,sOutputName3,row,obj) {

    var result = "";
    var firstList = new Array ();

    var popupId          = "PetakList";
    var popupStr         = "";

    var popupUrl         = "po.comm.popPetakListPopUp.dev?progCd=PS9999&codeType="+codeType+"&";
    var tgOneSelect      = "tgOneSelect="       + "T";   // 한 건인 경우 자동선택
    var popType          = "";
    
    var popupWidth       = "dialogWidth="       + "460px";
    var popupHeight      = ";dialogHeight="     + "375px";
         
    result = window.showModalDialog( popupStr + popupUrl + tgOneSelect + popType, popupId, popupWidth + popupHeight );
    
    if (result == -1 || result == null || result == "") {
    	if (sFlag == "s") {
        	eval("document.all."+sOutputName1).value = "";  // 초기화
        } else if (sFlag == "b") {
        	eval("document.all."+sOutputName1).value = "";  // 초기화
    		eval("document.all."+sOutputName2).value = "";  // 초기화
	    	
		    if(sOutputName3 !=null){
		        obj.NameValue(row,sOutputName3) = firstList[2];
		    } 
	    }
        return;
    } else {
	    firstList = result.split(";");
	    //firstList[0];
	    
    	if (sFlag == "s") {
	    	eval("document.all."+sOutputName1).value = firstList[0];
    	} else if (sFlag == "b") {
    		eval("document.all."+sOutputName1).value = firstList[0];
	    	eval("document.all."+sOutputName2).value = firstList[1];
	    	
		    if(sOutputName3 !=null){
		        eval("document.all."+sOutputName3).value = firstList[2];
		    } 
	    }
    } 
    
    if(obj !=null && row!=null){
        obj.NameValue(row,sOutputName1) = firstList[0];
        obj.NameValue(row,sOutputName2) = firstList[1];
     
	    if(sOutputName3 !=null && row!=null){
	        obj.NameValue(row,sOutputName3) = firstList[2];
	    } 
    }
}

//-------------------------------------------------------------------------
// Port Search
// sFlag : if  sFlag == s  then sOutputName1  else sFlag == b then sOutputName1,sOutputName2
// sOutputName1 : 입력될 input box name
// sOutputName2 : 입력될 input box name
// sOutputName3 : 입력될 input box name
//-------------------------------------------------------------------------
function openPortSearch(sFlag,polCntryCd,sOutputName1,sOutputName2,sOutputName3) {

    var result = "";
    var firstList = new Array ();

    var popupId          = "PortList";
    var popupStr         = "";

    var cntryCd          = "po.comm.popPortListPopUp.dev?progCd=PS9999&cntryCd="+polCntryCd;
    var tgOneSelect      = "&tgOneSelect="      + "T";   // 한 건인 경우 자동선택
    var popType          = "";
    var popupWidth       = "dialogWidth="       + "460px";
    var popupHeight      = ";dialogHeight="     + "375px";
         
    result = window.showModalDialog( popupStr + cntryCd + tgOneSelect + popType, popupId, popupWidth + popupHeight );
    
    if (result == -1 || result == null || result == "") {
    	if (sFlag == "s") {
        	eval("document.all."+sOutputName1).value = "";  // 초기화
        } else if (sFlag == "b") {
        	eval("document.all."+sOutputName1).value = "";  // 초기화
    		eval("document.all."+sOutputName2).value = "";  // 초기화
    		eval("document.all."+sOutputName3).value = "";  // 초기화
        }
        return;
    } else {
	    firstList = result.split(";");
	    //firstList[0];
	    
    	if (sFlag == "s") {
	    	eval("document.all."+sOutputName1).value = firstList[0];
    	} else if (sFlag == "b") {
    		eval("document.all."+sOutputName1).value = firstList[0];
	    	eval("document.all."+sOutputName2).value = firstList[1];
	    	eval("document.all."+sOutputName3).value = firstList[2];
	    }
    } 
}
//----------------------------------------------
// Round Precision(소숫점 반올림)
//----------------------------------------------
function roundPrecision(val, precision)
{
   var result = 0;
   var p = 1;
   
   if(precision==0){
	   result = Math.round(val);
   }else{	   

	   for(i=1;i<=precision;i++){
	        p = p * 10	
	   }
	   result= (Math.round(val*p))/p;
   }	   
 
   return result;
}

//----------------------------------------------
// 물류마감 및 회계 마감 여부 조회
//----------------------------------------------
function retrieveISUserClosing(closeYm,closeType)
{
    var condition  =   'closeYm=' + closeYm
                     +'&closeType='+ closeType
                     ;
    
    var returnFlag = true;
    //alert(condition);
    ds_isUserClosing.DataId="/po.is.retrieveUserCloseing.gau?"+condition;
    ds_isUserClosing.Reset();
    
   // alert(ds_isUserClosing.Text);
    //alert(ds_isUserClosing.ExportData(1, ds_isUserClosing.CountRow, true));
        
    if(ds_isUserClosing.CountRow > 0)
    {//alert(ds_isUserClosing.CountRow);
    //alert(ds_isUserClosing.NameValue(1,'closeYn'));
        if(ds_isUserClosing.NameValue(1,'closeYn') == 'Y' || ds_isUserClosing.NameValue(1,'closeYn') == '')
        {
            returnFlag = true;
        }
        else
        {
            returnFlag = false;        
        }
    }
   
    return returnFlag;
}

//----------------------------------------------
// 전표 마감 여부 조회
//----------------------------------------------
function retrieveACCUserClosing(closeYm,closeType)
{
    var condition  =   'closeYm=' + closeYm
                     +'&closeType='+ closeType
                     ;
    
    var returnFlag = true;
    ds_isUserClosing.DataId="/po.is.retrieveUserCloseing.gau?"+condition;
    ds_isUserClosing.Reset();
    
    //alert(ds_isUserClosing.ExportData(1, ds_isUserClosing.CountRow, true));
        
    if(ds_isUserClosing.CountRow > 0)
    {//alert(ds_isUserClosing.CountRow);
    //alert(ds_isUserClosing.NameValue(1,'closeYn'));
        if(ds_isUserClosing.NameValue(1,'closeYnAcc') == 'Y' || ds_isUserClosing.NameValue(1,'closeYnAcc') == '')
        {
            returnFlag = true;
        }
        else
        {
            returnFlag = false;        
        }
    }
   
    return returnFlag;
}

//----------------------------------------------
// 회계 마감 여부 조회
//----------------------------------------------
function retrieveMGRUserClosing(closeYm,closeType)
{
    var condition  =   'closeYm=' + closeYm
                     +'&closeType='+ closeType
                     ;
    
    var returnFlag = true;
    //alert(condition);
    ds_isUserClosing.DataId="/po.is.retrieveUserCloseing.gau?"+condition;
    ds_isUserClosing.Reset();
    
   // alert(ds_isUserClosing.Text);
    //alert(ds_isUserClosing.ExportData(1, ds_isUserClosing.CountRow, true));
        
    if(ds_isUserClosing.CountRow > 0)
    {//alert(ds_isUserClosing.CountRow);
    //alert(ds_isUserClosing.NameValue(1,'closeYn'));
        if(ds_isUserClosing.NameValue(1,'closeYnMgr') == 'Y' || ds_isUserClosing.NameValue(1,'closeYnMgr') == '')
        {
            returnFlag = true;
        }
        else
        {
            returnFlag = false;        
        }
    }
   
    return returnFlag;
}


//-------------------------------------------------------------------------
//   함수명     : f_chgComboCodeData
//   설명       : 콤보데이타형식으로 변경처리한다.
//   주요내용   :
//   return Type: 없음
//   return 값  : 없음
//-------------------------------------------------------------------------
function f_chgComboCodeData(comboDataSet)
{
    var code_Value="";
    for(idx=1; idx<=comboDataSet.CountRow; idx++)
    {
        code_Value = code_Value+comboDataSet.NameValue(idx,"code")+":";
        code_Value = code_Value+comboDataSet.NameValue(idx,"name")+",";
    }

    if(code_Value.length > 0)
    {
       code_Value = code_Value.substr(0,code_Value.length-1);
    }
    return code_Value;
}

/**
 * 2012.07.13 정재균 추가
 * 파라미터로 받은 object의 type에 따라 값을 리턴
 */
function cfGetObjectValue(o)
{
	var _CLASS_ID_LUXECOMBO = "CLSID:BB4533A0-85E0-4657-9BF2-E8E7B100D47E";
	var _CLASS_ID_EMEDIT = "CLSID:D7779973-9954-464E-9708-DA774CA50E13";
	var _CLASS_ID_RADIO = "CLSID:F73C0958-D8FE-43A5-9BB0-0F651C5A2BCC"

	var returnValue = "";
	var obj = null;
	if(typeof(o)=="object") obj = o;
	if(typeof(o)=="string") obj = document.getElementById(o);
	
	if( typeof(obj.value) != "undefined" )
		returnValue = obj.value;
	//gauce EMEdit인 경우
	//else if( typeof(obj.Text) != "undefined" )
	else if( obj.classid == _CLASS_ID_EMEDIT )
		returnValue = obj.Text;
    //gauce Radio 인 경우
	//else if( typeof(obj.CodeValue) != "undefined" )
	else if( obj.classid == _CLASS_ID_RADIO )
		returnValue = obj.CodeValue;
	//gauce Combo 인 경우
	//else if( typeof(obj.BindColVal) != "undefined" )
	else if( obj.classid == _CLASS_ID_LUXECOMBO )
		returnValue = obj.BindColVal;
	
	return returnValue;
}
/*******************************************************/
// Payment Term Search
/*******************************************************/
function cfPayTermSearch( payTermCd ) {
 
	var result ;

	result =  window.showModalDialog( "ps.sm.retrievePopPaymentTerm.dev?progCd=CM9999&payTermCd="+payTermCd,"PayTerm", "dialogWidth=550px;dialogHeight=375px");

	return result;

}