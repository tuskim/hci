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
	    p_grid.SetExcelTitle(1, "value:" + v_shtName + "; font-face:굴림체; font-size:15pt; font-color:black;font-bold; font-underline; bgcolor:white; align:center;skiprow:3;")
		p_grid.GridToExcel(v_shtName, v_fileName, 1);
	} else {
		alert("No Data");
	}
} 

/**
 * 엑셀내려받기(출력일자 받아서 처리)
 * @param p_dataset
 * @param p_grid
 * @param p_fileName
 * @param p_path
 */
function gf_excel2(p_dataset,p_grid,p_yyyymmdd,p_fileName,p_path) {
	 
	if(p_dataset.CountRow > 0) {
		var v_shtName = p_fileName;
	    var v_path = p_path;
	    var v_fileName = v_path+v_shtName+".xls";
		p_grid.SetExcelTitle(0, "");
		p_grid.SetExcelTitle(1, "value:" + v_shtName + "; font-face:굴림체; font-size:15pt; font-color:black;font-bold; bgcolor:white; align:center;")
	    p_grid.SetExcelTitle(1, "value:Print Date         "  + p_yyyymmdd + "; font-face:굴림체; font-size:11pt; font-color:black;bgcolor:white; align:right;");
		
		p_grid.GridToExcel(v_shtName, v_fileName, 1);
	} else {
		alert("No Data");
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
        obj.NameValue(row,"acctCd")    = "";
        obj.NameValue(row,"acctNm")    = "";
        obj.NameValue(row,"acctSapCd") = "";
        obj.NameValue(row,"area")      = "";
        obj.NameValue(row,"div")       = "";
        obj.NameValue(row,"block")     = "";
        obj.NameValue(row,"block2")     = "";
        obj.NameValue(row,"year")      = "";
        obj.NameValue(row,"tm")        = "";
	} else {
        firstList = result.split(";");
        obj.NameValue(row,"acctCd")    = firstList[0];
        obj.NameValue(row,"acctNm")    = firstList[1];
        obj.NameValue(row,"acctSapCd") = firstList[2];
        obj.NameValue(row,"area")      = firstList[3];
        obj.NameValue(row,"div")       = firstList[4];
        obj.NameValue(row,"block")     = firstList[5];
        obj.NameValue(row,"block2")    = firstList[6];
        obj.NameValue(row,"year")      = firstList[7];
        obj.NameValue(row,"tm")        = firstList[8];
    }

}

//-------------------------------------------------------------------------
// Grid Sap Account Popup
//-------------------------------------------------------------------------
function openSapAccountCodeListGridWin(row, obj) {

    var result = "";
    var firstList = new Array ();

    var popupId       = "SapAccountCodeList";
    var popupStr      = "/jsp/cm/cd/pop_" + popupId + ".jsp";
    
    var acctCd        = "?acctCd="        + ""; //obj.NameValue(row,"acctCd");
    var acctGb        = "&acctGb="        + "SAP";
    var tgOneSelect   = "&tgOneSelect="   + "T";                      // 한 건인 경우 자동선택
    var popType       = "&popType="       + "ptpam_" + popupId;
    //var popupWidth    = "dialogWidth="    + "400px";
    //var popupHeight   = ";dialogHeight="  + "375px";

    var intLeft  = screen.width / 2 - 500 / 2;
    var intTop  = screen.height / 2 - 475 / 2;
	
	var aiScroll	= ( aiScroll == null ) ? "no" : aiScroll;
	var win	= ( win == null ) ? window : win;
    opt = "center:yes; help:no; status:no; scroll:no; resizable:no; menubar=no;location=no;";

    result = window.showModalDialog( popupStr + acctCd + acctGb + tgOneSelect + popType, '', "dialogWidth:550px;dialogHeight:445px;scroll:no" );

    if (result == -1 || result == null || result == "") {
        obj.NameValue(row, "sapAcctCd")    = "";
        obj.NameValue(row, "sapAcctNm")    = "";
        obj.NameValue(row, "sp")           = "";
        obj.NameValue(row, "chkyn")        = "";
        obj.NameValue(row, "checkDuedate") = "";
        obj.NameValue(row, "center")       = "";
        obj.NameValue(row, "dueDate")      = "";
        obj.NameValue(row, "periodCostFrom") = "";
        obj.NameValue(row, "periodCostTo")   = "";
	} else {
        firstList = result.split(";");
        obj.NameValue(row, "sapAcctCd")    = firstList[0];
        obj.NameValue(row, "sapAcctNm")    = firstList[1];
        obj.NameValue(row, "sp")           = firstList[2];
        obj.NameValue(row, "chkyn")        = firstList[3];
        obj.NameValue(row, "checkDuedate") = firstList[4];
        obj.NameValue(row, "center")       = "";
        obj.NameValue(row, "dueDate")      = "";
        obj.NameValue(row, "debitAmt")     = "";
        obj.NameValue(row, "creditAmt")    = "";
        obj.NameValue(row, "vat")          = "";
        obj.NameValue(row, "base")         = "";
        obj.NameValue(row, "type")         = "";
        obj.NameValue(row, "code")         = "";
        obj.NameValue(row, "rate")         = "";
        obj.NameValue(row, "intOrder")     = "";
        obj.NameValue(row, "intOrderNm")   = "";
        obj.NameValue(row, "docDesc")      = "";
        obj.NameValue(row, "spglNo")       = "";
        obj.NameValue(row, "sapAcctV")     = "";
        obj.NameValue(row, "sapAcctVNm")   = "";
        obj.NameValue(row, "sapAcctC")     = "";
        obj.NameValue(row, "sapAcctCNm")   = "";
        obj.NameValue(row, "returnMsg")    = "";
        obj.NameValue(row, "periodCostFrom") = "";
        obj.NameValue(row, "periodCostTo")   = "";
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
    var popupWidth          = "dialogWidth="        + "580px";
    var popupHeight         = ";dialogHeight="      + "480px";

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
    //var popupWidth          = "dialogWidth="    + "400px";
    //var popupHeight         = ";dialogHeight="  + "375px";

    var intLeft  = screen.width / 2 - 400 / 2;
    var intTop  = screen.height / 2 - 375 / 2;

	var aiScroll	= ( aiScroll == null ) ? "no" : aiScroll;
	var win	= ( win == null ) ? window : win;
    opt = "center:yes; help:no; status:no; scroll:no; resizable:no; menubar=no;location=no;";

    result = window.showModalDialog( popupStr + vendCd + tgOneSelect + popType, '', "dialogLeft:"+intLeft+"px;dialogTop:"+intTop+"px;dialogWidth:400px;dialogHeight:375px;"+opt + ";scroll:" + aiScroll  );

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
function openVendorCodeListWin(flag) {

    var result = "";
    var firstList = new Array ();

    var popupId             = "VendorCodeList";
 
    var popupStr            = "/jsp/cm/cd/pop_" + popupId + ".jsp";
    
    var vendCd              = "?vendCd="            + document.all.vendCd.value;
    var tgOneSelect         = "&tgOneSelect="       + "T";                      // 한 건인 경우 자동선택
    var popType             = "&popType="           + "ptpam_" + popupId;
    var popupWidth          = "dialogWidth="        + "400px";
    var popupHeight         = ";dialogHeight="      + "375px";
    var popgubun            = "";
    if(flag == "undifined"){
    	popgubun            = "";
    }else
    {    
    	//ConDocList일 경우
    	popgubun            = "&conDoc=Y";
	}


    result = window.showModalDialog( popupStr + vendCd + tgOneSelect + popType  + popgubun, popupId, popupWidth + popupHeight );
 
    if (result == -1 || result == null || result == "") {
        document.all.vendCd.value = "";  // 초기화
        return;
    } else { 
    	firstList = result.split(";");
    	if(flag== "undifined"){
		    
	    	document.all.vendCd.value = firstList[0];
    	}else{
    		//ConDocList에서 사용
    		document.all.vendCd.value = firstList[0];
    		document.all.vendNm.value = firstList[1];
    	}
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
	
	var intLeft  = screen.width / 2 - 400 / 2;
    var intTop  = screen.height / 2 - 375 / 2;

	var aiScroll	= ( aiScroll == null ) ? "no" : aiScroll;
	var win	= ( win == null ) ? window : win;
    opt = "center:yes; help:no; status:no; scroll:no; resizable:no; menubar=no;location=no;";

    result = window.showModalDialog( popupStr + userId + tgOneSelect + popType, '', "dialogLeft:2200px;dialogTop:"+intTop+"px;dialogWidth:495px;dialogHeight:368px;"+opt + ";scroll:" + aiScroll  );
	
       
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
// SAP Account Popup
//-------------------------------------------------------------------------
function openAccountSapCodeListGridWin(row, obj) {

    var result = "";
    var firstList = new Array ();

    var popupId             = "AccountMgnt";
    var popupStr            = "/jsp/cm/cd/pop_" + popupId + ".jsp";

    var sapAcctCd           = "?sapAcctCd="         + obj.NameValue(row,"sapAcctCd");
    var acctSapNmEn         = "?acctSapNmEn="       + obj.NameValue(row,"acctSapNmEn");
    var tgOneSelect         = "&tgOneSelect="       + "T";                      // 한 건인 경우 자동선택
    var popType             = "&popType="           + "ptpam_" + popupId;
    var popupWidth          = "dialogWidth="        + "400px";
    var popupHeight         = ";dialogHeight="      + "375px";

    result = window.showModalDialog( popupStr + sapAcctCd + tgOneSelect + popType, popupId, popupWidth + popupHeight );

    if (result == -1 || result == null || result == "") {
    	obj.NameValue(row,"acctSapCd") = "";
    	obj.NameValue(row,"acctSapNmEn") = "";
	} else {
        firstList = result.split(";");
        obj.NameValue(row,"acctSapCd") = firstList[0];
        obj.NameValue(row,"acctSapNmEn") = firstList[1];
 
	     if(obj.NameValue(row,"acctSapCd").substring(0,1)=="9"){
	   	  obj.NameValue(row,"tm") = "Y";
	   	  obj.NameValue(row,"aboutTm") = "1";
        }

	}
}    

//-------------------------------------------------------------------------
// Grid Vendor Popup
//-------------------------------------------------------------------------
function openVendorSapListGridWin(row, obj, name, name2) {

    var result = "";
    var firstList = new Array ();

    var popupId             = "VendorCodeList";
    var popupStr            = "/jsp/cm/cd/pop_" + popupId + ".jsp";

    var vendCd              = "?vendCd="        + obj.NameValue(row,"vendCd");
    var tgOneSelect         = "&tgOneSelect="   + "T";                      // 한 건인 경우 자동선택
    var popType             = "&popType="       + "ptpam_" + popupId;
    //var popupWidth          = "dialogWidth="    + "400px";
    //var popupHeight         = ";dialogHeight="  + "375px";

    var intLeft  = screen.width / 2 - 400 / 2;
    var intTop  = screen.height / 2 - 375 / 2;

	var aiScroll	= ( aiScroll == null ) ? "no" : aiScroll;
	var win	= ( win == null ) ? window : win;
    opt = "center:yes; help:no; status:no; scroll:no; resizable:no; menubar=no;location=no;";

    result = window.showModalDialog( popupStr + vendCd + tgOneSelect + popType, '', "dialogWidth:495px;dialogHeight:368px;"+opt + ";scroll:" + aiScroll  );

    if (result == -1 || result == null || result == "") {
        obj.NameValue(row,name) = "";
        obj.NameValue(row,name2) = "";
	} else {
        firstList = result.split(";");
        obj.NameValue(row,name) = firstList[0];
        obj.NameValue(row,name2) = firstList[1];
    }

}  

//-------------------------------------------------------------------------
// SAP Vendor Popup
//-------------------------------------------------------------------------
function openVendorSapListWin(gubun) {

	var result = "";
	var firstList = new Array ();

	var popupId             = "VendorCodeList";
	var popupStr            = "/jsp/cm/cd/pop_" + popupId + ".jsp";
	var tgOneSelect         = "?tgOneSelect="   + "T";                      // 한 건인 경우 자동선택
	var popType             = "&popType="       + "ptpam_" + popupId;

	var intLeft  = screen.width / 2 - 400 / 2;
	var intTop  = screen.height / 2 - 375 / 2;

	var aiScroll	= ( aiScroll == null ) ? "no" : aiScroll;
	var win	= ( win == null ) ? window : win;
	opt = "center:yes; help:no; status:no; scroll:no; resizable:no; menubar=no;location=no;";

	result = window.showModalDialog( popupStr + tgOneSelect + popType, '', "dialogLeft:2000px;dialogTop:"+intTop+"px;dialogWidth:495px;dialogHeight:368px;"+opt + ";scroll:" + aiScroll  );

	if (result == -1 || result == null || result == "") {
		// Asset (Vendor)
		if(gubun == "A"){
			// 초기화
			document.aForm.vendCd.value = "";
			document.aForm.vendNm.value = "";
		
		// Asset (Customer)
		}else if(gubun == "A2"){
			// 초기화
			document.saveForm.customerCd.value = "";
			document.saveForm.customerNm.value = "";
				
		// Payment
		}else{
			// 초기화
			document.all.sVendCd.value = "";
		}				
	} else {
		
		firstList = result.split(";");
		
		// Asset (Vendor)
		if(gubun == "A"){			
			document.aForm.vendCd.value = firstList[0];
			document.aForm.vendNm.value = firstList[1];
		
		// Asset (Customer)
		}else if(gubun == "A2"){
			document.saveForm.customerCd.value = firstList[0];
			document.saveForm.customerNm.value = firstList[1];
			
		// Payment
		}else{			
			document.all.sVendCd.value = firstList[0];
		}				
	}

}  

function valiDate(obj) {
	if(!cfValidateValue(removeDash(obj.value,"/"), "date=YYYYMMDD")) {
		alert("Check Date Format \n ex) 20100210");
		obj.focus();
		return;
	}
}

function valiDate2(date) {
	if(!cfValidateValue(removeDash(date,"/"), "date=YYYYMMDD")) {
		alert("Check Date Format \n ex) 20100210");
		return "F";
	}
}

function valiYM(yyyymm) {
	var mm = yyyymm.substring(yyyymm.length-2,yyyymm.length);
	if(yyyymm.length < 6){
		alert("Check Date Format \n ex) 201002");
		return "F";
	}
}

//2012.09.04 hskim 2012/08 오류
/*
function valiYM(yyyymm) {
	var mm = yyyymm.substring(yyyymm.length-2,yyyymm.length);
	if(yyyymm.length < 6 || (parseInt(mm) < 1 || parseInt(mm) > 12)){
		alert("Check Date Format \n ex) 201002");
		return "F";
	}
}
 */
 
 function f_costPriceSearchPop( aiScroll, win)
{	
	var url 	= "retrieveCostPriceSearchPopup.dev";
	var	param	="";

    var intLeft  = screen.width / 2 - 550 / 2;
    var intTop  = screen.height / 2 - 400 / 2;
	
	aiScroll	= ( aiScroll == null ) ? "no" : aiScroll;
	win	= ( win == null ) ? window : win;
    opt = "center:yes; help:no; status:no; scroll:no; resizable:no; menubar=no;location=no;";
    var returnValues = window.showModalDialog( url+param, '', "dialogLeft:"+intLeft+"px;dialogTop:"+intTop+"px;dialogWidth:550px;dialogHeight:400px;"+opt + ";scroll:" + aiScroll);

    return returnValues;
}

 
 function f_bargeSearchPop( aiScroll, win)
{	
	var url 	= "retrieveBargeSearchPopup.dev";
	var	param	="";
	
	if(barge_param !=""){
		param = barge_param;
		//alert(param);
	}
	
    var intLeft  = screen.width / 2 - 550 / 2;
    var intTop  = screen.height / 2 - 400 / 2;
	
	aiScroll	= ( aiScroll == null ) ? "no" : aiScroll;
	win	= ( win == null ) ? window : win;
    opt = "center:yes; help:no; status:no; scroll:no; resizable:no; menubar=no;location=no;";
    var returnValues = window.showModalDialog( url+param, '', "dialogLeft:"+intLeft+"px;dialogTop:"+intTop+"px;dialogWidth:850px;dialogHeight:400px;"+opt + ";scroll:" + aiScroll);

    return returnValues;
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

function f_forbidBeforeDate(settingDt, inputDt, msg){
    var settingVal = removeDash(settingDt,"/");
    var inputVal =  removeDash(inputDt,"/");
	if(inputDt < settingDt){
		if(msg != 'none'){
			alert('please put only the data after '+settingDt+' for '+msg+'!!');
		}
		return false;
	}
	return true;
}

//-------------------------------------------------------------------------
// Vendor Bank Account List Popup (그리드 호출)
//-------------------------------------------------------------------------
function openVendorBankAcctListGridWin(row, obj, name) {
	
	var result = "";
	var firstList = new Array ();

	var popupId             = "VendorBankAcctList";
	var popupStr            = "/jsp/tr/bc/pop_" + popupId + ".jsp";
	var vendCd              = "?vendCd="        + obj.NameValue(row, "customerCd");
	var tgOneSelect         = "&tgOneSelect="   + "T";                     
	var popType             = "&popType="       + "ptpam_" + popupId;

	var intLeft = screen.width / 2 - 650 / 2;
	var intTop  = screen.height / 2 - 300 / 2;	
	
	var aiScroll	= ( aiScroll == null ) ? "no" : aiScroll;
	var win	= ( win == null ) ? window : win;
	opt = "center:yes; help:no; status:no; scroll:no; resizable:no; menubar=no;location=no;";

	result = window.showModalDialog( popupStr + vendCd + tgOneSelect + popType, '', "dialogLeft:"+intLeft+"px;dialogTop:"+intTop+"px;dialogWidth:650px;dialogHeight:300px;"+opt + ";scroll:" + aiScroll  );

	if (result == -1 || result == null || result == "") {
		obj.NameValue(row,name) = "";
	} else {
		firstList = result.split(";");
		obj.NameValue(row,name) = firstList[0];
	}
}

//-------------------------------------------------------------------------
// Vendor Bank Account List Popup (버튼 호출)
//-------------------------------------------------------------------------
function openVendorBankAcctListWin() {

	var result = "";
	var firstList = new Array ();
	
	var popupId       = "VendorBankAcctList";
	var popupStr      = "/jsp/tr/bc/pop_" + popupId + ".jsp"; 
	var vendCd        = "?vendCd="        + document.all.vendCd.value;
	var tgOneSelect   = "&tgOneSelect="   + "T";
	var popType       = "&popType="       + "ptpam_" + popupId;
	
	var intLeft = screen.width / 2 - 500 / 2;
	var intTop  = screen.height / 2 - 300 / 2;	
	
	var aiScroll	= ( aiScroll == null ) ? "no" : aiScroll;
	var win	= ( win == null ) ? window : win;
	opt = "center:yes; help:no; status:no; scroll:no; resizable:no; menubar=no;location=no;";

	result = window.showModalDialog( popupStr + vendCd + tgOneSelect + popType, '', "dialogLeft:2000px;dialogTop:"+intTop+"px;dialogWidth:680px;dialogHeight:303px;"+opt + ";scroll:" + aiScroll  );
	    
	if (result == -1 || result == null || result == "") {
		document.all.partnerBankType.value = "";  // 초기화		
	    return;
	} else {
		firstList = result.split(";");
	 	document.all.partnerBankType.value = firstList[0];	 	
	}

}

//-------------------------------------------------------------------------
// Payment Bank Account List Popup (버튼 호출)
//-------------------------------------------------------------------------
function openPaymentBankAcctListWin() {

	var result = "";
	var firstList = new Array ();

	var popupId       = "PaymentBankAcctList";
	var popupStr      = "/jsp/tr/bc/pop_" + popupId + ".jsp"; 	
	var tgOneSelect   = "?tgOneSelect="   + "T";
	var popType       = "&popType="       + "ptpam_" + popupId;
	
	var intLeft = screen.width / 2 - 680 / 2;
	var intTop  = screen.height / 2 - 300 / 2;	
	
	var aiScroll	= ( aiScroll == null ) ? "no" : aiScroll;
	var win	= ( win == null ) ? window : win;
	opt = "center:yes; help:no; status:no; scroll:no; resizable:no; menubar=no;location=no;";

	result = window.showModalDialog( popupStr + tgOneSelect + popType, '', "dialogLeft:2000px;dialogTop:"+intTop+"px;dialogWidth:680px;dialogHeight:303px;"+opt + ";scroll:" + aiScroll  );
	    
	if (result == -1 || result == null || result == "") {
		document.all.sHouseBank.value = "";  // 초기화
		document.all.houseBankAcct.value = "";  // 초기화
		document.all.houseBankCurrCd.value = "";  // 초기화
	    return;
	} else {
		firstList = result.split(";");
	 	document.all.sHouseBank.value = firstList[0];
	 	document.all.houseBankAcct.value = firstList[1];
	 	document.all.houseBankCurrCd.value = firstList[2];
	}

}

//-------------------------------------------------------------------------
// Internal  List Popup (그리드 호출)
//-------------------------------------------------------------------------
function openInternalOrderCodeListGridWin(row, obj, name, name2) {
	
	var result = "";
	var firstList = new Array ();

	var popupId             = "IoList";
	var popupStr            = "/jsp/fi/at/pop_" + popupId + ".jsp";	
	var tgOneSelect         = "?tgOneSelect="   + "T";                     
	var popType             = "&popType="       + "ptpam_" + popupId;

	var intLeft = screen.width / 2 - 400 / 2;
	var intTop  = screen.height / 2 - 365 / 2;	
	
	var aiScroll	= ( aiScroll == null ) ? "no" : aiScroll;
	var win	= ( win == null ) ? window : win;
	opt = "center:yes; help:no; status:no; scroll:no; resizable:no; menubar=no;location=no;";

	result = window.showModalDialog( popupStr + tgOneSelect + popType, '', "dialogWidth:495px;dialogHeight:380px;"+opt + ";scroll:" + aiScroll  );

	if (result == -1 || result == null || result == "") {
		obj.NameValue(row,name) = "";
		obj.NameValue(row,name2) = "";
	} else {
		firstList = result.split(";");
		obj.NameValue(row,name) = firstList[0];
		obj.NameValue(row,name2) = firstList[1];
	}
}