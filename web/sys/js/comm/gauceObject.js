/* ------------------------------------------------------------------------
 * @source  : comm.js
 * @desc    : 상품기획 공통 자바스크립트
 * ------------------------------------------------------------------------
 *
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2008.09.12   김상우                           최초생성
 * ------------------------------------------------------------------------
 */

 /*********************************************************************************************
 *   함수리스트
 * - initComboStyle : LuxeCombo의 Style 및 기본적 PARAMETER SETTING
 * - initEmEdit     : Emedit의 스타일을 적용한다.
 * - initGrid       : Grid 초기 셋팅
 * - getLComboData  : 콤보 세팅을 위한 dataSet을 가져오는 함수
 * - getComboData   : 콤보의 데이터값을 갖어온다.(현재 Position)
 * - setComboData   : 콤보에 원하는 strValue에 해당하는 값으로 표시한다.
 * - setFocusGrid   : GRID의 원하는 컬럼에 포커스 주기.


 * - openExcel      : Excel Export 공통
 * - trCompleted    : Transaction 처리 후 성공/실패 메시지 처리
 * - blnCheckLen    : Component에서 Maxlength 체크
 * - blnGridCheckLen: Grid에서 Maxlength 체크
 * - showModal      : 팝업 호출
 * - addComboDataHeader : 콤보횽 DataSet 에 데이타를 디비와 관계없이 입력함 구조는 code, name 으로만 하고 해더를 선언함
 * - addComboData   : 콤보횽 DataSet 에 데이타를 디비와 관계없이 입력함 구조는 code, name 으로만 하고 해더를 선언하는 함수를 먼저 호출후 사용
 * - init_LCBYY     : 년도 만 생성
 *********************************************************************************************/

// GAUCE 4.0 Unicode ActiveX Component Class ID
var BIND        = "CLSID:2F98EA90-EAE1-4AB5-AE89-DA073D824589";
var DATASET     = "CLSID:AF989B7C-8AC3-40BC-B749-EB335BDFD190";
var EMEDIT      = "CLSID:D7779973-9954-464E-9708-DA774CA50E13";
var GRID        = "CLSID:71E7ACA0-EF63-4055-9894-229B056E9C31";
var IMGDATASET  = "CLSID:9F0AA341-1D10-4B18-B70B-6AA49CE7F5D6";
var INPUTFILE   = "CLSID:5C32688E-CEBE-419D-9C63-0704A2331EEC";
var LUXECOMBO   = "CLSID:BB4533A0-85E0-4657-9BF2-E8E7B100D47E";
var MENU        = "CLSID:31538FAB-8051-4CFA-ACA4-B2668718B6F8";
var RADIO       = "CLSID:F73C0958-D8FE-43A5-9BB0-0F651C5A2BCC";
var REPORT      = "CLSID:9683681E-FAD6-45F1-86B3-FD60C7101BC9";
var TAB         = "CLSID:90CAA259-71ED-42CB-BEB8-95281CCF9E58";
var TEXTAREA    = "CLSID:1455BE02-C41B-4115-B21C-32380507DC8F";
var TR          = "CLSID:223216F6-B9FE-406D-9ED6-143FCE3A07B8";
var TREEVIEW    = "CLSID:C1781C5C-0C32-40F2-8927-46FE4BCB5B8";

/**
* Colors
* 작 성 자 : 김상우
* 작 성 일 : 2008-09-18
* 개    요 : 그리드, 탭에 필요한 생상
* 사 용 법 :
*
*/
function Colors(){

    this.gridHeadLineColor       = "#D9D9D9";          //그리드헤드라인
    this.gridLineColor           = "#D9D9D9";          //그리드라인
    this.gridHeadBgColor         = "#EEEEF0"; //#ECE4D7//그리드헤드
    this.gridSumbgcolor          = "#CBC4B8"; //#CBC4B8//그리드총계
    this.gridFixedHeadBgColor    = "#EEEEF0";          //그리드 고정컬럼 헤드
    this.gridSubbgcolor          = "#D1E9E9";          //그리드소계
    this.gridGoupBgColor         = "#EEEEF0"; //#E4DBCD //C8D4D1 //그리드그룹헤드

    this.gridPKbgColor           = "#EEEEF0"; //#FEFFE2//그리드 PK칼럼
    this.gridHeadColor           = "#E4DBCD";          //필수입력 컬럼의 Head 글자색상
    this.gridNoEditColor         = "#F2FFFD";          //수정불가 컬럼의 바탕색상 입력프로그램과 같이 있을때 처리
    this.gridReadOnlyColor       = "#E3F2FC";          //입력수정프로그램중에 조회전용

    this.tabBackColor            = "#B05A82";          //Tab컨트롤( 백컬러 )
    this.tabDisableBackColor     = "#F7EEC6";          //Tab컨트롤( DISABLE BackColor )

    this.readOnlyBackColor       = "#DFE8F3";          //readOnly객체 배경색
    this.ReadOnlyForeColor       = "#000000";          //readOnly객체 글자색

    this.fontbgColor             = "#58595B";          //EmEDIT READONLY
}

/**
* initComboStyle
* 작 성 자 : 김상우
* 작 성 일 : 2008-09-18
* 개    요 : LuxeCombo의 Style 및 기본적 PARAMETER SETTING
* 사 용 법 : initComboStyle(LC_DEAL_GUBN_S, ds_deal_gubn, "ETC_CODE^0^20,ETC_NAME^0^100", 1, PK/READ/NORMAL);
*            initComboStyle(LuxeCombo ID, Dataset Name, ExprForamt, SearchColumn Index, PK)
*/
function initComboStyle(objCombo, dataSetId, strExprFormat, intSearchColumn,  strType, strDsBindFlag){
  objCombo.ComboDataID      = dataSetId.id;
  objCombo.ListExprFormat   = strExprFormat;
  objCombo.FontSize         = "9";
  objCombo.FontName         = "굴림체";
  objCombo.ListCount        = 10;
  objCombo.SearchColumn     = strExprFormat.split(",")[intSearchColumn].split("^")[0];
  objCombo.BindColumn       = strExprFormat.split(",")[0].split("^")[0];
  objCombo.InheritColor   = true;
  objCombo.Sort             = false;

  if (strDsBindFlag != true){
    objCombo.SyncComboData    = false;
  }
  objCombo.WantSelChgEvent  = true;
  objCombo.DisableBackColor      = "#EDEDED";
  switch(strType){
    case "PK"   :
      objCombo.style.backgroundColor = "#D3EDFF";
      objCombo.style.color           = "#000000";
      objCombo.className             = "inputPKL";
      objCombo.Enable                = true;
      objCombo.DefaultString         = "==선택하세요==";
      break;
    case "READ" :
      objCombo.Enable                = false;
      objCombo.className             = "inputReadL";
      objCombo.DefaultString         = "";
      break;
    case "NORMAL" :
      objCombo.style.backgroundColor = "#FFFFFF";
      objCombo.style.color           = "#000000";
      objCombo.className             = "inputTL";
      objCombo.Enable                = true;
      /* objCombo.DefaultString         = "==선택하세요=="; */
      break;
    default :
      break;
  }
}

/**
*initEmEdit(EmeEdit objEdit, String strFormat, editStyle)
* 작 성 자 : 김상우
* 작 성 일 : 2008-09-18
* 개    요 : EM edit의 스타일을 적용한다.
* 인 자 값 : edit-eme eidt오브젝트, parameters-속성파라미터, String editStyle-편집속성(PK/READ/NORMAL)
* 사용방법 : initEmEdit(edit, "YYYYMMDD", PK/READ/NORMAL);
             initEmEdit(edit, "YYYYMM", PK/READ/NORMAL);
             initEmEdit(edit, "NUMBER^10^2", PK/READ/NORMAL); --> 10,2의 소수점 체크
             initEmEdit(edit, "POST", PK/READ/NORMAL);
             initEmEdit(edit, "GEN^50", PK/READ/NORMAL);
             initEmEdit(edit, "##-#####-#####", PK/READ/NORMAL);
* return값 : void
**/
function initEmEdit(objEdit, strFormat,  blnEditStyle){
  var arrFormat            = new Array();
  objEdit.ClipMode         = "true";
  objEdit.MoveCaret        = "true";
  objEdit.PromptChar       = " ";
  objEdit.SelectAllOnClick = "true";
  objEdit.style.height     = "30px";
  objEdit.InheritColor     = "true";
  objEdit.Border           = "false";

  arrFormat = strFormat.toUpperCase().split("^");

  switch(arrFormat[0]){
    case 'YYYYMMDD' :
      objEdit.Alignment = 1;
      objEdit.Format = "YYYY/MM/DD";
      break;
    case 'YYYYMM' :
      objEdit.Alignment = 1;
      objEdit.Format = "YYYY/MM";
      break;
    case 'NUMBER' :
      objEdit.Alignment       = 2;
      objEdit.Numeric         = "true";
      objEdit.MaxLength       = parseInt(arrFormat[1]);
      objEdit.MaxDecimalPlace = parseInt(arrFormat[2]);
      objEdit.IsComma         = "true";
      break;
    case 'POST' :
      objEdit.Alignment = 1;
      objEdit.Format = "###-###";
      break;
    case 'GEN' :
      objEdit.Alignment    = 0;
      objEdit.GeneralEdit  = "true";
      objEdit.MaxLength    = arrFormat.length == 2 ? parseInt(arrFormat[1]) : 50;
      break;
    case 'KOR' :
      objEdit.Alignment    = 0;
      objEdit.GeneralEdit  = "true";
      objEdit.MaxLength    = parseInt(arrFormat[1]);
      break;
    default :
      objEdit.Alignment = 0;
      objEdit.GeneralEdit  = false;
      objEdit.Format = arrFormat[0]
      break;
  }

  objEdit.DisabledBackColor      = "#EDEDED";
  switch(blnEditStyle){
      case 'PK'   :
          objEdit.Enable                = true;
          objEdit.style.backgroundColor = "#D3EDFF";
          objEdit.style.color           = "#000000";
          objEdit.className             = "emedit_req"
          break;
      case 'READ' :
          objEdit.Enable                = false;
          objEdit.className             = "emedit_read";
          break;
      case 'NORMAL' :
          objEdit.Enable                = true;
          //objEdit.style.backgroundColor = "#FFFFFF";
          //objEdit.style.color           = "#000000";
          objEdit.className             = "emedit_text";
          break;
      default :
          objEdit.className             = "emedit_text";
          break;
  }
  //objEdit.style.marginTop = "3px";
  objEdit.style.height = "18px";
}

/**
* initGrid()
* 작 성 자 : 김상우
* 작 성 일 : 2008-09-19
* 개     요 : Grid 초기 셋팅
* 사용방법 : initGrid(gridID,DataSetID, '<C>ID="F_NO"  name="번호" width=100 </C>')
*          arguments[0] -> GRID ID 명
*          arguments[1] -> DATASET ID 명
*          arguments[2] -> 컬럼 ( String 형태)
*/
function initGrid(aGrid,aDataID,aFormat){

    var colr = new Colors();

    aGrid.BorderStyle      = "2";
    aGrid.DataID           = aDataID;
    aGrid.SortView         = "Right";
    aGrid.HeadLineColor    = colr.gridHeadLineColor;
    aGrid.LineColor        = colr.gridLineColor;
    aGrid.FixedHeadBgColor = colr.gridFixedHeadBgColor;
    aGrid.ColSizing        = "true";
    aGrid.RowHeight        = "20";
    aGrid.IndWidth         = "15";
    aGrid.AllShowEdit      = "true"; //커서를 넣으면 edit모드로 변환
    aGrid.TranslateKeyDown = "1";  //enter가 옆컬럼으로 이동
    //aGrid.TargetEnterKey = "1";
    aGrid.FixSizing        = "true"; //고정컬럼의 사이즈 변경
    aGrid.UsingOneClick    = "1" ;   //checkBox 한번에 클릭
    aGrid.style.fontFamily = "굴림체";
    aGrid.style.fontSize   = "12px";

    aGrid.SelectionColor  = "<SC>Type='FocusEditCol',  BgColor='#A5BA8B',     TextColor='Black'</SC>"             // EDIT모드이면서 선택된 색상
    aGrid.SelectionColor += "<SC>Type='EditCol',       BgColor='#FEFB8D',     TextColor='Black'</SC>"             // EDIT모드이면서 선택된 색상
    aGrid.SelectionColor += "<SC>Type='FocusEditRow',  BgColor='#FEFB8D',     TextColor='Black'</SC>"             // EDIT모드이면서 선택된 색상
    aGrid.SelectionColor += "<SC>Type='EditRow',       BgColor='#FEFB8D',     TextColor='Black'</SC>"             // EDIT모드이면서 선택된 색상
    aGrid.SelectionColor += "<SC>Type='FocusCurCol',   BgColor='#FEFB8D',     TextColor='Black'</SC>"             // EDIT모드이면서 선택된 색상
    aGrid.SelectionColor += "<SC>Type='CurCol',        BgColor='#FEFB8D',     TextColor='Black'</SC>"             // EDIT모드이면서 선택된 색상
    aGrid.SelectionColor += "<SC>Type='FocusCurRow',   BgColor='#FEFB8D',     TextColor='Black'</SC>"             // EDIT모드가 아닐경우  선택된 색상
    aGrid.SelectionColor += "<SC>Type='CurRow',        BgColor='#FEFB8D',     TextColor='Black'</SC>"             // EDIT모드가 아닐경우 포커를 잃었을때
    aGrid.SelectionColor += "<SC>Type='FocusSelRow',   BgColor='#FEFB8D',     TextColor='Black'</SC>"             // EDIT모드가 아닐경우  선택된 색상
    aGrid.SelectionColor += "<SC>Type='SelRow',        BgColor='#FEFB8D',     TextColor='Black'</SC>"             // EDIT모드가 아닐경우 포커를 잃었을때

    var strFormat        = '';
    var strTemp          = '';
    var hdrProperties    = ' HeadBgColor="'+ colr.gridHeadBgColor + '"  headfontstyle="bold" ';
    var sumProperties    = ' SumText="총계" SubSumText="소계" ';
    var sumbgcolors      = ' Sumbgcolor="'+ colr.gridSumbgcolor + '" Subbgcolor="'+ colr.gridSubbgcolor + '" ';
    var groupProperties  = ' BgColor="'+ colr.gridGoupBgColor + '" headfontstyle="bold" ';
    var rMarginProperties= ' RightMargin=7 ';
    var PKProperties     = ' BgColor="'+ colr.gridPKbgColor + '" ';

    var HeadProperties   = ' BgColor="'+colr.gridPKbgColor+'"';
    //수정불가 변경
    var NoEditProperties   = ' BgColor="'+ colr.gridNoEditColor + '" Edit="none" ';
    var ReadOnlyProperties = ' BgColor="'+ colr.gridReadOnlyColor + '" Edit="none" ';

    strTemp   = aFormat.replace(/SUBSUMTITLE/gi,sumProperties);
    if (strTemp.indexOf("<G>") > -1 || strTemp.indexOf("<FG>")){
        aGrid.TitleHeight   = "20";
    }else{
        aGrid.TitleHeight   = "20";
    }

    strTemp   = strTemp.replace(/HEAD_NOTNULL/gi,HeadProperties);
    strTemp   = strTemp.replace(/NOEDIT/gi,NoEditProperties);
    strTemp   = strTemp.replace(/READONLY/gi,ReadOnlyProperties);

    strTemp   = strTemp.replace(/PKCOLUMN/gi,PKProperties);
    strTemp   = strTemp.replace(/R-MARGIN/gi,rMarginProperties);
    strTemp   = strTemp.replace(/<\/F>/gi, hdrProperties + sumbgcolors +"</F>");
    strTemp   = strTemp.replace(/<\/FC>/gi, hdrProperties + sumbgcolors +"</FC>");
    strTemp   = strTemp.replace(/<G>/gi,"<G>"+groupProperties);
    strTemp   = strTemp.replace(/<FG>/gi,"<FG>"+groupProperties);
    strTemp   = strTemp.replace(/<X>/gi,"<X>"+groupProperties);
    strTemp   = strTemp.replace(/<FC>/gi,"<FC>"+groupProperties);
    strFormat = strTemp.replace(/<\/C>/gi, hdrProperties + sumbgcolors +"</C>");

    aGrid.Format = strFormat;
}

/**
* getLComboData(sysPart, comPart, dataSetId)
* 작 성 자 : 김상우
* 작 성 일 : 2008-09-19
* 개     요 : 코드  콤보 세팅을 위한 dataSet을 가져오는 함수
* 사용방법 : getLComboData(dataSetId, strTr, commgubun,ALLOPT,PARAM01,PARAM02,PARAM03,PARAM04,PARAM05)
    arguments[0] -> dateset
    arguments[1] -> tr
    arguments[2] -> 구분  // mile     : 마일스톤                      , domain  : 도메인 테이블(파라메타 1개는 필수임) , domainAll  : 도메인 테이블(파라메타 1개는 필수임) 전체 항목이 추가 되어있음
                           brand    : 브랜드                   , clotype : 복종                                           , repbrand : 대표브랜드    , item      : 품목        , year     : 제품연도
                           sson     : 시즌                    , sbsn    : 서브시즌                                     , color    : 칼라              , size     : 사이즈
                           curr     : 통화                    , unit    : 단위                                           , yrseason : 연도시즌        , areagbn  : 생산지분
                           sjgbn    : 상제구분              , marea   : 중분류 지역                                , zssbsn   : 시즌서브시즌 , yrseasonFS : 연도시즌(FS 없는것)
                           milebrand : 마일스톤별 브랜드     , branditem :  브랜드별 품목                       , brandItemAttr : 브랜드품목별 속성별(브랜드 필수(PARAM01), 품목은 선택(PARAM01) , 속성값필수(PARAM01))
                           zpdloc    : 지역 소분류(PARAM01[선택]에 중분류코드를 입력하면 중분류에 속항 국가만 나옴
                                               , PARAM02[선택]에는 생산지코드
                                               , PARAM03[선택]는 전체조회(Y/N))
                           userrole  ; 사용자 role 별로 사용자 ID/NAME 가져  , zmdt900 : 상품기획 공통코드 에이블에서 그룹별 코드 가져옴(PARAM01 항목은 필수임)
                           ssonFS     : 시즌(fs 가 없는 것)
    arguments[3] -> ALLOPT 전체 구분자 전체 인경우 'all'  그외 는 '' 사용자 저으이정의
    arguments[4] -> PARAM01 : 검색조건 파라메타(쿼리 WHERE에 사용할 변수)
    arguments[5] -> PARAM02 : 검색조건 파라메타(쿼리 WHERE에 사용할 변수)
    arguments[6] -> PARAM03 : 검색조건 파라메타(쿼리 WHERE에 사용할 변수)
    arguments[7] -> PARAM04 : 검색조건 파라메타(쿼리 WHERE에 사용할 변수)
    arguments[8] -> PARAM05 : 검색조건 파라메타(쿼리 WHERE에 사용할 변수)
* return값 : void
*/
function getLComboData(dataSetId, strTr, commgubun,ALLOPT,PARAM01,PARAM02,PARAM03,PARAM04,PARAM05) {

    ds_commparam.setDataHeader('GUBUN:STRING(40),ALLOPT:STRING(40),PARAM01:STRING(40),PARAM02:STRING(40),PARAM03:STRING(40),PARAM04:STRING(40),PARAM05:STRING(40)');

    ds_commparam.ClearData();
    ds_commparam.Addrow();
    ds_commparam.NameValue(1, "GUBUN")    = arguments[2];
    ds_commparam.NameValue(1, "ALLOPT")   = arguments[3];
    ds_commparam.NameValue(1, "PARAM01")  = arguments[4];
    ds_commparam.NameValue(1, "PARAM02")  = arguments[5];
    ds_commparam.NameValue(1, "PARAM03")  = arguments[6];
    ds_commparam.NameValue(1, "PARAM04")  = arguments[7];
    ds_commparam.NameValue(1, "PARAM05")  = arguments[8];

    eval(strTr).Action   = "/mdp/lgf.mdp.comm.commoncombo.getComboData.gau";
    eval(strTr).KeyValue = "SERVLET(I:ds_commparam=ds_commparam,O:ds_commcode="+dataSetId.id+")";
    eval(strTr).Post();
}

/**
* getComboData(objCombo, strColumnID)
* 작 성 자 : 김상우
* 작 성 일 : 2008-09-19
* 개    요 : 콤보의 데이터값을 갖어온다.(현재 Position)
* 사용방법 : getComboData(LC_STORE_CODE, “STORE_CODE”);
*            arguments[0] -> LuxeCombo Object;
*            arguments[1] -> LuxeCombo에 연동한 DataSet의 ColumnID
* return값 : String
*/
function getComboData(objCombo, strColumnID){
  var combo      = eval(objCombo);
  return combo.ValueOfIndex(strColumnID, combo.Index) ;
}

/**
* setComboData( ComboObject, String)
* 작 성 자 : 김상우
* 작 성 일 : 2008-09-19
* 개    요 : 콤보에 원하는 strValue에 해당하는 값으로 표시한다.
* 사용방법 : setComboData(LC_STORE_CODE, “07”);
*            arguments[0] -> LuxeCombo Object;
*            arguments[1] -> 셋팅을 원하는 value
* 주의사항   ListExprFormat에 셋팅되어 있는 첫번째 컬럼을 기준을 셋팅한다.
* return값 : void
*/
function setComboData(objCombo, strValue){
  var combo        = eval(objCombo);
  combo.BindColVal = strValue;
}

/**
* setFocusGrid()
* 작 성 자 : 김상우
* 작 성 일 : 2008-09-19
* 개    요 :  GRID의 원하는 컬럼에 포커스 주기.
* 사용방법 : setFocusGrid(gridObjId, dataSetId, row, colId)
*            arguments[0] -> 이벤트 대상인  GRID의 아이디
*            arguments[1] -> GRID와 바인드 되어 있는 데이타셋의 아이디
*            arguments[2] -> 포커스 될 컬럼의  row 포지션
*            arguments[3] -> 포커스 될 컬럼의 아이디
* return값 : str
*/
function setFocusGrid(gridObjId, dataSetId,row,colId) {
    dataSetId.RowPosition = row;
    gridObjId.SetColumn(colId);
    gridObjId.Focus();
}

/**
* hasFocusObject()
* 작 성 자 : 김상우
* 작 성 일 : 2008-09-19
* 개    요 : Document에서 Focus를 갖고있는 GRID OBJECT 탐색
* return값 : Void
*/
function hasFocusObject(){
  var obj = document.body.all;
  for(var i=0, n=obj.length;i<n;i++) {

    if(obj.item(i) == null) continue;

    var strTagName = obj.item(i).tagName.toUpperCase();
    if (strTagName == "OBJECT") {
      if (obj.item(i).classid.toUpperCase() == GRID){
        if(obj.item(i).FocusState){
          LASTFOCUSEDOBJ = obj.item(i);
          return true;
        }
      }
    }
  }
  return false;
}

/**
* hasFocusObject()
* 작 성 자 : 김상우
* 작 성 일 : 2008-09-24
* 개    요 : Documents에서 원하느 grid의 원하는 row의 원하는 열에 포커스를 둔다.
* return값 : Void
*/
function setFocusGrid(gridObjId, dataSetId,row,colId) {
    dataSetId.RowPosition = row;
    gridObjId.SetColumn(colId);
    gridObjId.Focus();
}


/**
* addComboDataHeader()
* 작 성 자 : 김상우
* 작 성 일 : 2008-10-10
* 개    요 :  콤보횽 DataSet 에 데이타를 디비와 관계없이 입력함 구조는 code, name 으로만 하고 해더를 선언함
* return값 : Void
*/
function addComboDataHeader(dataSetId)
{
    dataSetId.setDataHeader('code:STRING(40),name:STRING(40)');

    dataSetId.ClearData();
    dataSetId.Addrow();
    dataSetId.NameValue(1,"code")=arguments[1];
    dataSetId.NameValue(1,"name")=arguments[2];
}

/**
* addComboData()
* 작 성 자 : 김상우
* 작 성 일 : 2008-10-10
* 개    요 :  콤보횽 DataSet 에 데이타를 디비와 관계없이 입력함 구조는 code, name 으로만 하고 해더를 선언하는 함수를 먼저 호출후 사용
* return값 : Void
*/
function addComboData(dataSetId)
{
    dataSetId.Addrow();
    dataSetId.NameValue(1,"code")=arguments[1];
    dataSetId.NameValue(1,"name")=arguments[2];
}

/**
* init_LCBYY()
* 작 성 자 : 김상우
* 작 성 일 : 2008-10-10
* 개    요 :  콤보횽 DataSet 에 데이타를 디비와 관계없이 입력함 구조는 code, name 으로만 하고 해더를 선언하는 함수를 먼저 호출후 사용
* return값 : Void
* 년도 생성
*/
function init_LCBYY(today_yy,obj_nm) {
    var countYY = parseInt(today_yy) - 2004;
    obj_nm.CBDATA +=  "''^==선택하세요=+,";
    for(var i=0;i<=countYY;i++){
        obj_nm.CBDATA += (parseInt(today_yy) + 2 - i) + "^" + (parseInt(today_yy) + 2 - i) + ",";
    }
}

/**
* init_LCBYY()
* 작 성 자 : 김상우
* 작 성 일 : 2008-10-10
* 개    요 :  콤보횽 DataSet 에 데이타를 디비와 관계없이 입력함 구조는 code, name 으로만 하고 해더를 선언하는 함수를 먼저 호출후 사용
* return값 : Void
* 년도 생성
*/
function init_LCBMONTH(dataSetId) {
    var i = 0 ;
    var strHeader = "CODE:STRING(2)"
                  + ",NAME:STRING(20)"
                  + ",ZSSON:STRING(4)"
                  + ",ZSBSN1:STRING(4)"  // S/S F/W 용 T
                  + ",ZSBSN2:STRING(4)"  // F/S  용
                  ;
    dataSetId.setDataHeader(strHeader);

    dataSetId.ClearData();
    dataSetId.Addrow();
    i +=1 ;
    dataSetId.NameValue(i,"CODE")  = "";
    dataSetId.NameValue(i,"NAME")  = "==선택하세요=";
    dataSetId.NameValue(i,"ZSSON") = "";
    dataSetId.NameValue(i,"ZSBSN1") = "";
    dataSetId.NameValue(i,"ZSBSN2") = "";

    dataSetId.Addrow();
    i +=1 ;
    dataSetId.NameValue(i,"CODE")  = "**";
    dataSetId.NameValue(i,"NAME")  = "전체";
    dataSetId.NameValue(i,"ZSSON") = "";
    dataSetId.NameValue(i,"ZSBSN1") = "";
    dataSetId.NameValue(i,"ZSBSN2") = "";

    // 본
    dataSetId.Addrow(); // 2월
    i +=1 ;
    dataSetId.NameValue(i,"CODE")   = "02";
    dataSetId.NameValue(i,"NAME")   = "2월";
    dataSetId.NameValue(i,"ZSSON")  = "SS";
    dataSetId.NameValue(i,"ZSBSN1") = "A";
    dataSetId.NameValue(i,"ZSBSN2") = "E";

    dataSetId.Addrow(); // 3월
    i +=1 ;
    dataSetId.NameValue(i,"CODE")   = "03";
    dataSetId.NameValue(i,"NAME")   = "3월";
    dataSetId.NameValue(i,"ZSSON")  = "SS";
    dataSetId.NameValue(i,"ZSBSN1") = "A";
    dataSetId.NameValue(i,"ZSBSN2") = "E";

    dataSetId.Addrow(); // 4월
    i +=1 ;
    dataSetId.NameValue(i,"CODE")   = "04";
    dataSetId.NameValue(i,"NAME")   = "4월";
    dataSetId.NameValue(i,"ZSSON")  = "SS";
    dataSetId.NameValue(i,"ZSBSN1") = "A";
    dataSetId.NameValue(i,"ZSBSN2") = "E";

    // 여름
    dataSetId.Addrow(); // 5월
    i +=1 ;
    dataSetId.NameValue(i,"CODE")   = "05";
    dataSetId.NameValue(i,"NAME")   = "5월";
    dataSetId.NameValue(i,"ZSSON")  = "SS";
    dataSetId.NameValue(i,"ZSBSN1") = "B";
    dataSetId.NameValue(i,"ZSBSN2") = "E";

    dataSetId.Addrow(); // 6월
    i +=1 ;
    dataSetId.NameValue(i,"CODE")   = "06";
    dataSetId.NameValue(i,"NAME")   = "6월";
    dataSetId.NameValue(i,"ZSSON")  = "SS";
    dataSetId.NameValue(i,"ZSBSN1") = "B";
    dataSetId.NameValue(i,"ZSBSN2") = "E";

    dataSetId.Addrow(); // 7월
    i +=1 ;
    dataSetId.NameValue(i,"CODE")   = "07";
    dataSetId.NameValue(i,"NAME")   = "7월";
    dataSetId.NameValue(i,"ZSSON")  = "SS";
    dataSetId.NameValue(i,"ZSBSN1") = "B";
    dataSetId.NameValue(i,"ZSBSN2") = "E";

    // 가을
    dataSetId.Addrow(); // 8월
    i +=1 ;
    dataSetId.NameValue(i,"CODE")   = "08";
    dataSetId.NameValue(i,"NAME")   = "8월";
    dataSetId.NameValue(i,"ZSSON")  = "FW";
    dataSetId.NameValue(i,"ZSBSN1") = "C";
    dataSetId.NameValue(i,"ZSBSN2") = "F";

    dataSetId.Addrow(); // 9월
    i +=1 ;
    dataSetId.NameValue(i,"CODE")   = "09";
    dataSetId.NameValue(i,"NAME")   = "9월";
    dataSetId.NameValue(i,"ZSSON")  = "FW";
    dataSetId.NameValue(i,"ZSBSN1") = "C";
    dataSetId.NameValue(i,"ZSBSN2") = "F";

    dataSetId.Addrow(); // 10월
    i +=1 ;
    dataSetId.NameValue(i,"CODE")   = "10";
    dataSetId.NameValue(i,"NAME")   = "10월";
    dataSetId.NameValue(i,"ZSSON")  = "FW";
    dataSetId.NameValue(i,"ZSBSN1") = "C";
    dataSetId.NameValue(i,"ZSBSN2") = "F";

    // 가을
    dataSetId.Addrow(); // 11월
    i +=1 ;
    dataSetId.NameValue(i,"CODE")   = "11";
    dataSetId.NameValue(i,"NAME")   = "11월";
    dataSetId.NameValue(i,"ZSSON")  = "FW";
    dataSetId.NameValue(i,"ZSBSN1") = "D";
    dataSetId.NameValue(i,"ZSBSN2") = "F";

    dataSetId.Addrow(); // 12월
    i +=1 ;
    dataSetId.NameValue(i,"CODE")   = "12";
    dataSetId.NameValue(i,"NAME")   = "12월";
    dataSetId.NameValue(i,"ZSSON")  = "FW";
    dataSetId.NameValue(i,"ZSBSN1") = "D";
    dataSetId.NameValue(i,"ZSBSN2") = "F";

    dataSetId.Addrow(); // 1월
    i +=1 ;
    dataSetId.NameValue(i,"CODE")   = "01";
    dataSetId.NameValue(i,"NAME")   = "1월";
    dataSetId.NameValue(i,"ZSSON")  = "FW";
    dataSetId.NameValue(i,"ZSBSN1") = "D";
    dataSetId.NameValue(i,"ZSBSN2") = "F";

    dataSetId.Addrow(); // 1월
    i +=1 ;
    dataSetId.NameValue(i,"CODE")   = "00";
    dataSetId.NameValue(i,"NAME")   = "00";
    dataSetId.NameValue(i,"ZSSON")  = "";
    dataSetId.NameValue(i,"ZSBSN1") = "";
    dataSetId.NameValue(i,"ZSBSN2") = "";
}

/**
* openExcel(objGrid, strTitle, blnSupp)
* 작 성 자 : 김상우
* 작 성 일 : 2008-11-27
* 개    요 : Excel Export 공통
* 인 자 값 : objGrid  : Grid Object
          strTitle : 파일명 또는 제목
* return값 : Void
*/

function openExcel(objGrid, strTitle, blnSupp){
    var obj = new Array();
    var dataset = eval(objGrid.DataID);
    if (dataset.CountRow == 0){
    showMessage( Information , Ok , 'LGFUSER-1000' , 'EXCEL로 저장할 내용이 없습니다.<br>조회 후 작업해야 합니다.' , 'POPUP' );
    return false;
    }
    obj.push(objGrid);
    obj.push(strTitle);

    if (blnSupp == false) {
      obj.push(false);
    } else {
      obj.push(true);
  }
    var h = ie7 == true ? "200" : "230";
    return window.showModalDialog("/mdp/jsp/comm/excel.jsp", obj,"dialogWidth:430px;dialogHeight:" + h + "px;scroll:no;resizable:no;help:no;unadorned:yes;center:yes;status:no");
}

/**
* openExcel(strTitle)
* 작 성 자 : 우병룡
* 작 성 일 : 2009-04-23
* 개    요 : Excel Export 팝업
* 인 자 값 : objGrid  : Grid Object
          strTitle : 파일명 또는 제목
* return값 : Void
*/

function openExcelPop(strTitle){
    var grArr = new Array();
    var idx = 0;

    for (i = 0; i < document.all.length; i++) {
        var obj = document.all(i);

        if(obj.id != "" && obj.id.substring(0,2)=="gr"){ //그리드
            grArr[idx] = obj.id;
            idx++;
        }
    }

    if(grArr.length >0){
        var winSize    =  300;
        var heightSize =  100;
        var condition = "";

        condition += "?strTitle="+strTitle;
        for(var i=0; i<grArr.length; i++){
            condition += "&grArr=" + grArr[i];
        }

        win = window.open("/mdp/jsp/comm/excelpop.jsp" + condition, "", "width=" + winSize + ",height=" + heightSize + ",toolbar=no,menubar=no,location=no,scollbars=yes,status=no,resizable=yes");
        win.focus();
    }
    else{
        showMessage( Information , Ok , 'LGFUSER-1000' , '엑셀 출력 대상 목록이 존재하지 않습니다.' , 'POPUP' );
    }
}

    function __WS__(__NSID__)
    {
      document.write( __NSID__.innerHTML );
      __NSID__.id = "";
    }