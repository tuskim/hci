/**
 * @type : intro
 * @desc : lafui.js는 프로젝트 전반에 걸쳐 전 시스템에서 공통으로 사용하는 자바 스크립트를 기술한
 * 자바스크립트 파일이다. 빈번히 사용되는 자바스크립트들이 화면마다 반복적으로 개발되지
 * 않도록 미리 정의되어 있어서 lafui.js를 업무화면에 import시키기만 하면 lafui.js에 정의되어
 * 있는 스크립트들에 대해서는 각 개발자가 별도로 개발할 필요가 없다.
 * lafui.js 소스는 2개의 영역으로 구성되었다.
 * <pre>
 *     1. 공통 메세지 영역   : 화면에 사용되는 공통된 메세지들을 선언한 영역
 *     2. 공통 스크립트 영역 : 화면에 사용되는 공통 스크립트들이 기술된 영역
 * </pre>
 * 함수 Naming Rule은 다음과 같다.
 * <pre>
 *     - cf  : common function
 *     - co  : common object
 *     - cov : common object for validation
 * </pre>
 * <font color=red>※주의사항</font>
 * <pre>
 *     - lafui.js를 import하는 html 화면에서는 object id를 지정할 때, 다음에 나열된 id는
 *       지정할 수 없습니다.
 *
 *       coTreeViewImageComnGIDS
 * </pre>
 * @version : 1.0
 * @change  :
 * <pre>
 *     <font color="blue">V1.0</font>
 *     -
  * </pre>
 */

/** 이 부분은 document로 generate되지 않습니다.
 * @JScript 참고자료
 * - isNaN : 다음은 모두 숫자로 본다. - "001", "0", "", null
 * - substr(index[, length]) -> index부터 끝까지 혹은 length갯수만큼.
 * - substring(start, end)  -> start index부터 end index전까지의 string
 * Date 오브젝트 생성자들 - dateObj = new Date()
 *                        - dateObj = new Date(dateVal)
 *                        - dateObj = new Date(year, month, date[, hours[, minutes[, seconds[,ms]]]])
 */


//----------------------------- 1. 공통 메세지 -------------------------------//
var MSG_COM_INF_001   = "성공적으로 저장하였습니다.";
var MSG_COM_INF_002   = "성공적으로 등록하였습니다.";
var MSG_COM_INF_003   = "성공적으로 수정하였습니다.";
var MSG_COM_INF_004   = "성공적으로 삭제하였습니다.";
var MSG_COM_INF_005   = "@님 안녕하세요?";
var MSG_COM_INF_008   =  "관리자에게 문의하십시오.";
var MSG_COM_INF_009   =  "성공적으로 출력되었습니다.";
var MSG_COM_INF_010   =  "@을(를) 성공적으로 저장하였습니다.";
var MSG_COM_INF_011   =  "@이(가) 삭제되었습니다.";
var MSG_COM_INF_012   =  "@을(를) 성공적으로 생성하였습니다.";
var MSG_COM_INF_013   =  "처리가 취소되었습니다.";
var MSG_COM_INF_007   =  "유효합니다.";
var MSG_COM_INF_015   =  "유효한 @입니다.";

var MSG_COM_CRM_001   = "저장하시겠습니까?";
var MSG_COM_CRM_002   = "등록하시겠습니까?";
var MSG_COM_CRM_003   = "수정하시겠습니까?";
var MSG_COM_CRM_004   = "삭제하시겠습니까?";
var MSG_COM_CRM_005   = "변경사항이 반영되지 않았습니다. 계속 하시겠습니까?";
var MSG_COM_CRM_006   =  "이미 존재하는 @ 입니다. 추가하시겠습니까?";
var MSG_COM_CRM_008   =  "@을(를) 삭제하시겠습니까?";
var MSG_COM_CRM_009   =  "@을(를) 생성하시겠습니까?";
var MSG_COM_CRM_010   =  "@을(를) 적용하시겠습니까?";
var MSG_COM_CRM_011   =  "취소하시겠습니까?";
var MSG_COM_CRM_013   =  "즉시 승인하시겠습니까?";

var MSG_COM_ERR_001   = "@은(는) 변경된 사항이 없습니다.";
var MSG_COM_ERR_002   = "@은(는) 필수 입력 항목입니다.";
var MSG_COM_ERR_003   = "해당되는 자료가 존재하지 않습니다.";
var MSG_COM_ERR_004   = "@은(는) 공백없이 입력하십시오.";
var MSG_COM_ERR_005   = "@은(는) @자리수만큼 입력하십시오.";
var MSG_COM_ERR_006   = "@은(는) @부터 @사이로 입력하십시오.";
var MSG_COM_ERR_007   = "@은(는) 숫자만을 입력하십시오.";
var MSG_COM_ERR_008   = "@은(는) 문자만을 입력하십시오.";
var MSG_COM_ERR_009   = "@은(는) 숫자와 문자만을 입력하십시오.(공백제외)";
var MSG_COM_ERR_010   = "@은(는) 숫자와 문자만을 입력하십시오.(공백포함)";
var MSG_COM_ERR_011   = "@은(는) @자 이상으로 입력하십시오.";
var MSG_COM_ERR_012   = "@은(는) @자 이하로 입력하십시오.";
var MSG_COM_ERR_013   = "@은(는) @ 이상으로 입력하십시오.";
var MSG_COM_ERR_014   = "@은(는) @ 이하로 입력하십시오.";
var MSG_COM_ERR_015   = "@은(는) 년도가 잘못되었습니다.";
var MSG_COM_ERR_016   = "@은(는) 유효한 주민등록번호가 아닙니다.";
var MSG_COM_ERR_017   = "@은(는) 유효한 사업자등록번호가 아닙니다.";
var MSG_COM_ERR_018   = "@은(는) 유효한 날짜가 아닙니다.";
var MSG_COM_ERR_019   = "@은(는) 월이 잘못되었습니다.";
var MSG_COM_ERR_020   = "@은(는) 일이 잘못되었습니다.";
var MSG_COM_ERR_021   = "@은(는) 시가 잘못되었습니다.";
var MSG_COM_ERR_022   = "@은(는) 분이 잘못되었습니다.";
var MSG_COM_ERR_023   = "@은(는) 초가 잘못되었습니다.";
var MSG_COM_ERR_025   = "@은(는) @년 @월 @일 이후이어야 합니다.";
var MSG_COM_ERR_024   = "@은(는) @년 @월 @일 이전이어야 합니다.";
var MSG_COM_ERR_026   = "@은(는) '@' 형식이어야 합니다.\n" +
                            "  - # : 문자 혹은 숫자\n" +
                            "  - h, H : 한글(H는 공백포함)\n" +
                            "  - A, Z : 문자(Z는 공백포함)\n" +
                            "  - 0, 9 : 숫자(9는 공백포함)";
var MSG_COM_ERR_027   =  "@은(는) @자리수만큼 입력하십시오. (한글은 @자리수)";
var MSG_COM_ERR_028   =  "@은(는) @자 이상으로 입력하십시오. (한글은 @자 이상)";
var MSG_COM_ERR_029   =  "@은(는) @자 이하로 입력하십시오. (한글은 @자 이하)";
var MSG_COM_ERR_030   =  "@은(는) ";
var MSG_COM_ERR_031   =  "@의 @번째 데이터에서 ";
var MSG_COM_ERR_032   =  "@은(는) 중복될 수 없습니다.";
var MSG_COM_ERR_033   =  "@은(는) 다음 문자가 올 수 없습니다.\n@";
var MSG_COM_ERR_034   =  "페이지 설정이 잘못되었습니다.";
var MSG_COM_ERR_035   =  "@페이지 이상은 출력할 수 없습니다";
var MSG_COM_ERR_036   =  "@은(는) 다음 문자만 올 수 있습니다.\n@";
var MSG_COM_ERR_037   =  "@은(는) 유효한 이메일 주소가 아닙니다.";
var MSG_COM_ERR_038   =  "유효한 @가 아닙니다."
var MSG_COM_ERR_039   =  "시작일자를 종료일자 이전으로 선택[입력]하여 주십시오.";
var MSG_COM_ERR_040   =  "패스워드가 일치하지 않습니다.";
var MSG_COM_ERR_041   =  "@은(는) @할 수 없습니다.";
var MSG_COM_ERR_042   =  "@은(는) 변경된 사항이 있습니다. \n변경사항을 저장 후 @을(를) 수행하십시오.";
var MSG_COM_ERR_043	  =  "유효하지 않는 @ 입니다.\n다시 입력하여주십시요";
var MSG_COM_ERR_045   =  "시작범위는 종료범위보다 작아야 합니다. :@";
var MSG_COM_ERR_046   =  "존재하지 않는 @입니다.";
var MSG_COM_ERR_047   =  "오류가 발생하였습니다.\n관리자에게 문의하십시오.";
var MSG_COM_ERR_048   =  "@은(는) @보다 작아야 합니다.";
var MSG_COM_ERR_049   =  "@이(가) 존재하지 않습니다.";
var MSG_COM_ERR_050   =  "오류가 발생하였습니다.\n처음부터 다시 시작하여 주십시오.";
var MSG_COM_ERR_051   =  "@을(를) 실패하였습니다.";
var MSG_COM_ERR_052   =  "해당조건의 @이(가) 존재하지 않습니다.";
var MSG_COM_ERR_053   =  "@이(가) 누락되었습니다.";
var MSG_COM_ERR_054   =  "@ 생성을 실패하였습니다.";
var MSG_COM_ERR_055   =  "@을(를) 확인하여 주십시오.";
var MSG_COM_ERR_056   =  "선택된 @이(가) 없습니다.";
var MSG_COM_ERR_057   =  "@은(는) @ 보다 큰 값으로 입력하십시오.";
var MSG_COM_ERR_058   =  "시작시간을 종료시간 이전으로 선택[입력]하여 주십시오.";
var MSG_COM_ERR_059   =  "@은(는) 정수부를 @자 이하로 입력하십시오.";
var MSG_COM_ERR_060   =  "@은(는) 소수부를 @자 이하로 입력하십시오."

var MSG_COM_WRN_001   =  "저장할 데이터가 존재하지 않습니다.\n먼저 @검색을 하십시오.";
var MSG_COM_WRN_002   =  "조회결과가 존재하지 않습니다.";
var MSG_COM_WRN_003   =  "@을(를) 입력하십시오.";
var MSG_COM_WRN_004   =  "삭제할 @이(가) 존재하지 않습니다.";
var MSG_COM_WRN_005   =  "'+' 버튼을 누른 후 입력하십시오.";
var MSG_COM_WRN_006   =  "'+'버튼을 누르신 후 @을(를) 입력하십시오.";
var MSG_COM_WRN_007   =  "@을(를) 선택하십시오.";
var MSG_COM_WRN_008   =  "검색한 데이터가 존재하지 않습니다.\n먼저 @검색을 하십시오.";
var MSG_COM_WRN_009   =  "출력할 @이(가) 없습니다.";
var MSG_COM_WRN_010   =  "@ 버튼을 이용하십시오.";
var MSG_COM_WRN_011   =  "이미 존재하는 @입니다.";
var MSG_COM_WRN_012   =  "@이(가) 반영되지 않았습니다.";
var MSG_COM_INF_016   =  "@이(가) 아닙니다.";

//----------------------------- 2. 공통 스크립트 -----------------------------//

// Global 변수선언
var GLB_MONTH_IN_YEAR       = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
var GLB_SHORT_MONTH_IN_YEAR = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
var GLB_DAY_IN_WEEK         = ["Sunday", "Monday", "Tuesday", "Wednesday","Thursday", "Friday", "Saturday"];
var GLB_SHORT_DAY_IN_WEEK   = ["Sun", "Mon", "Tue", "Wed","Thu", "Fri", "Sat"];
var GLB_DAYS_IN_MONTH       = [31,28,31,30,31,30,31,31,30,31,30,31];
var GLB_URL_COMMON_PAGE     = "/common/jsp/";   // common 디렉토리의 URL
var GLB_REPORT_MAXPAGE      = 50;  // 출력가능한 최대 페이지 수
var GLB_PAGE_PARAMS         = new coMap();
var GLB_FRAME_MAIN          = top.MainFrame;
var GLB_FRAME_MAIN_MENU     = (top.MainFrame == null) ? null : top.MainFrame.MenuFrame;
var GLB_FRAME_MAIN_BODY     = (top.MainFrame == null) ? null : top.MainFrame.BodyFrame;
var GLB_FRAME_SUB_BODY      = (GLB_FRAME_MAIN_BODY == null) ? null : GLB_FRAME_MAIN_BODY.SubBodyFrame;
var GLB_FRAME_MAIN_TAIL     = (top.MainFrame == null) ? null : top.MainFrame.TailFrame;
var GLB_FRAME_MAIN_NAVI     = (top.MainFrame == null) ? null : top.MainFrame.NaviFrame;
var GLB_FRAME_HIDDEN        = top.HiddenFrame;
var GLB_CALENDAR            = new Object();

//----------------------------- 3. 가우스 컴포넌트 클래스ID -----------------------------//

/* ********************************************************************************
 *                                  변수 선언
 * *******************************************************************************/
 var SEARCH_BTN   = "<I>Type='PopupBotton', Url='/sys/images/button/search_icon_2.gif', Fit='AutoFit', Flat='True'</I>";
 var CALENDAR_BTN = "<I>Type='PopupBotton', Url='/sys/images/button/btn_Gcalendar.gif', Fit='AutoFit', Flat='True'</I>";


/* ********************************************************************************
 *                                  변수 선언
 * *******************************************************************************/

/**
 * @type   : var
 * @access : private
 * @desc   : Key 형태로 변경이 안 되는 내용을 담은 오브젝트를 담는 배열<br>
 *           input이나 가우스 컴포넌트 중에서 objType 속성의 값을 "key"로 선언하면 오브젝트가 이 배열에 포함된다.<br>
 *           화면 처리 중에 readOnly 필드로, 배열 전체를 조작하여 사용자가 수정을 하지 못 하게 막거나 풀 수 있다.<br>
 * <br>
 * 화면 -
 * <pre>
 *     &lt;input type="text" id="txt_empNo" objType="key"&gt;
 * </pre>
 */
var key = new Array();


/**
 * @type   : var
 * @access : private
 * @desc   : 변경 가능한 내용을 담은 오브젝트를 담는 배열<br>
 *           input이나 가우스 컴포넌트 중에서 objType 속성의 값을 "data"로 선언하면 오브젝트가 이 배열에 포함된다.<br>
 *           화면 처리 중에 일반 입력 필드로, 배열 전체를 조작하여 사용자가 수정을 하지 못 하게 막거나 풀 수 있다.<br>
 * <br>
 * 화면 -
 * <pre>
 *     &lt;input type="text" id="txt_empTel" objType="data"&gt;
 * </pre>
 */
var data = new Array();


/**
 * @type   : var
 * @access : private
 * @desc   : 제어 가능한 버튼을 담는 배열<br>
 *           input이나 가우스 컴포넌트 중에서 objType 속성의 값을 "ctrlBtn"으로 선언하면 버튼이 이 배열에 포함된다.<br>
 *           배열 전체를 조작하여 한번에 disable시키거나  enable시킬 수 있다.<br>
 * <br>
 * 화면 -
 * <pre>
 *     &lt;input type="button" id="btn_save" objType="ctrlBtn"&gt;
 * </pre>
 */
var ctrlBtn = new Array();


/**
 * @type   : var
 * @access : private
 * @desc   : 필수 입력 사항을 담은 오브젝트를 담는 배열<br>
 *           input이나 가우스 컴포넌트 중에서 mandatory 속성의 값을 "true"로 선언하면 오브젝트가 이 배열에 포함된다.<br>
 *           신규나 수정 사항 입력 후에 필수 입력 항목에 대한 입력 여부를 손쉽게 확인할 수 있는 방법을 제공한다.<br>
 *           화면에 자동으로 필수입력항목 표시를 붙일 수도 있다.<br>
 * <br>
 * 화면 -
 * <pre>
 *     &lt;input type="text" name="txt_empTel" objType="data" mandatory="true"&gt;
 * </pre>
 */
var mandatory = new Array();


/**
 * @type   : var
 * @access : public
 * @desc   : 신규 정보를 입력하기 위한 버튼<br>
 *           업무 성격에 따라 버튼을 disable/enable하기 위해 저장한다.<br>
 * <br>
 * 화면 - 아래와 같이 type이 button이고, objType 속성을 bCreate로 선언한 오브젝트를 저장한다.
 * <pre>
 *     &lt;input type="button" value="신규" name="btn_create" objType="bCreate"&gt;
 * </pre>
 */
var bCreate;


/**
 * @type   : var
 * @access : public
 * @desc   : 조회 정보 수정 버튼<br>
 *           업무 성격에 따라 버튼을 disable/enable하기 위해 저장한다.<br>
 * <br>
 * 화면 - 아래와 같이 type이 button이고, objType 속성을 bUpdate로 선언한 오브젝트를 저장한다.
 * <pre>
 *     &lt;input type="button" value="수정" name="btn_update" objType="bUpdate"&gt;
 * </pre>
 */
var bUpdate;


/**
 * @type   : var
 * @access : public
 * @desc   : 입력 정보 저장 버튼<br>
 *           업무 성격에 따라 버튼을 disable/enable하기 위해 저장한다.<br>
 * <br>
 * 화면 - 아래와 같이 type이 button이고, objType 속성을 bSave로 선언한 오브젝트를 저장한다.
 * <pre>
 *     &lt;input type="button" value="저장" name="btn_save" objType="bSave"&gt;
 * </pre>
 */
var bSave;


/**
 * @type   : var
 * @access : public
 * @desc   : 조회 정보 삭제 버튼<br>
 *           업무 성격에 따라 버튼을 disable/enable하기 위해 저장한다.<br>
 * <br>
 * 화면 - 아래와 같이 type이 button이고, objType 속성을 bDelete로 선언한 오브젝트를 저장한다.
 * <pre>
 *     &lt;input type="button" value="저장" name="btn_delete" objType="bDelete"&gt;
 * </pre>
 */
var bDelete;


/**
 * @type   : var
 * @access : public
 * @desc   : 신규 정보를 입력하기 위한 버튼<br>
 *           업무 성격에 따라 버튼을 disable/enable하기 위해 저장한다.<br>
 * <br>
 * 화면 - 아래와 같이 type이 button이고, objType 속성을 bCreate2로 선언한 오브젝트를 저장한다.
 * <pre>
 *     &lt;input type="button" value="신규" name="btn_create2" objType="bCreate2"&gt;
 * </pre>
 */
var bCreate2;


/**
 * @type   : var
 * @access : public
 * @desc   : 조회 정보 수정 버튼<br>
 *           업무 성격에 따라 버튼을 disable/enable하기 위해 저장한다.<br>
 * <br>
 * 화면 - 아래와 같이 type이 button이고, objType 속성을 bUpdate2로 선언한 오브젝트를 저장한다.
 * <pre>
 *     &lt;input type="button" value="수정" name="btn_update2" objType="bUpdate2"&gt;
 * </pre>
 */
var bUpdate2;


/**
 * @type   : var
 * @access : public
 * @desc   : 입력 정보 저장 버튼<br>
 *           업무 성격에 따라 버튼을 disable/enable하기 위해 저장한다.<br>
 * <br>
 * 화면 - 아래와 같이 type이 button이고, objType 속성을 bSave2로 선언한 오브젝트를 저장한다.
 * <pre>
 *     &lt;input type="button" value="저장" name="btn_save2" objType="bSave2"&gt;
 * </pre>
 */
var bSave2;


/**
 * @type   : var
 * @access : public
 * @desc   : 조회 정보 삭제 버튼<br>
 *           업무 성격에 따라 버튼을 disable/enable하기 위해 저장한다.<br>
 * <br>
 * 화면 - 아래와 같이 type이 button이고, objType 속성을 bDelete2로 선언한 오브젝트를 저장한다.
 * <pre>
 *     &lt;input type="button" value="삭제" name="btn_delete2" objType="bDelete2"&gt;
 * </pre>
 */
var bDelete2;





/* ********************************************************************************
 *                                 이벤트 핸들링
 * *******************************************************************************/

/*
 * document의 상태가 변경될 때마다 발생하는 이벤트에 대한 처리를 하는데,
 * onreadystatechange 이벤트 중 document.readyState가 complete일 경우가
 * onLoad 바로 직전에 발생하므로, onLoad에 대한 이벤트 핸들링 시 발생하는
 * 충돌을 방지하기 위해서이다.
 */
document.onreadystatechange = beforeOnLoadProcess;



function __ShowEmbedObject(__ELEMENT_ID)
{
	document.write( __ELEMENT_ID.text );
	__ELEMENT_ID.id = "";
}

/* ********************************************************************************
 *                                  공통 함수
 * *******************************************************************************/

/**
 * @type   : function
 * @access : private
 * @desc   : document.readyState == "complete" 이벤트는 document의 load 끝난 후, onLoad 이벤트 바로 전에 발생한다.<br>
 *           1. 가우스 Grid 컴포넌트를 찾아 스타일을 적용한다.<br>
 *           2. key, data, mandatory로 정의된 오브젝트도 배열에 저장한다.<br>
 *              key 형태로 정의된 오브젝트는 key 배열에,<br>
 *              data 형태로 정의된 오브젝트는 data 배열에,<br>
 *              key와 mandatory 형태로 정의된 오브젝트는 key와 mandatory 배열에 동시에 저장된다.<br>
 * 화면 -<br>
 *    1. GAUCE Grid 컴포넌트에 class="comn" 속성을 입력해 comn 형태의 스타일을 적용시킨다.
 *    <pre>
 *      &lt;!-- Grid Component -->
 *      &lt;object id="gr_empList" classid="CLSID:71E7ACA0-EF63-4055-9894-229B056E9C31" class="comn" style="width:790;height:250px;"&gt;
 *    </pre>
 *
 *    2. key, data, mandatory로 정의된 오브젝트를 배열에 저장해 둔다.
 *       <pre>&lt;input type="text" id="txt_ab" objType="key"&gt;</pre> 는 key 배열에,
 *       <pre>&lt;input type="text" id="txt_cd" objType="data"&gt;</pre> 는 data 배열에,
 *       <pre>&lt;input type="text" id="txt_ab" objType="key" mandatory="true"&gt;</pre> 는 key와 mandatory 배열에 동시에 저장된다.
 * @author : 송동혁
 */
function beforeOnLoadProcess() {
	// 화면의 load가 완료되었을 때
	if (document.readyState == "complete") {
		for (i = 0; i < document.all.length; i++) {
			// GAUCE의 Grid 컴포넌트
			if (document.all[i].tagName.toUpperCase() == "OBJECT" &&
				document.all[i].classid.toUpperCase() == "CLSID:71E7ACA0-EF63-4055-9894-229B056E9C31") {
				if (document.all[i].className == "comn"){
					cfStyleGrid(document.all[i], "comn");
				}else if (document.all[i].className == "comnCS"){
					cfStyleGrid(document.all[i], "comnCS");
				}else if (document.all[i].className == "comn_status"){
					cfStyleGrid(document.all[i], "comn_status");	
				}				
			}

			// HTML의 INPUT 객체와 가우스 컴포넌트 중 objType이 key와 data인 것을 배열에 저장
			var curTagName = document.all[i].tagName.toUpperCase();
			if (curTagName == "INPUT" || curTagName == "SELECT" || curTagName == "OBJECT" || curTagName == "A") {
				if (document.all[i].objType == "key") {
					key[key.length] = document.all[i];
				}
				else if (document.all[i].objType == "data") {
					data[data.length] = document.all[i];
				}

				// objType이 mandatory(필수입력항목)인 것을 배열에 저장
				if (document.all[i].mandatory && document.all[i].mandatory == "true") {
					mandatory[mandatory.length] = document.all[i];

					// 뒤에 필수 입력항목 표시를 붙임
					//document.all[i].insertAdjacentHTML("afterEnd", "<font color=red><b>*</b></font>");
					//document.all[i].insertAdjacentHTML("afterEnd", "<img src='../images/required.gif' height=7 width=7 align=top>");
				}
			}

			// 버튼 저장
			if (curTagName == "INPUT" && document.all[i].type.toUpperCase() == "BUTTON") {
				// 제어 대상 버튼을 배열에 저장
				if (document.all[i].objType == "ctrlBtn") {
					ctrlBtn[ctrlBtn.length] = document.all[i];
				}

				switch (document.all[i].objType) {
					// 신규 버튼
					case 'bCreate':
						bCreate = document.all[i];
						break;
					// 수정 버튼
					case 'bUpdate':
						bUpdate = document.all[i];
						break;
					// 저장 버튼
					case 'bSave':
						bSave = document.all[i];
						break;
					// 삭제 버튼
					case 'bDelete':
						bDelete = document.all[i];
						break;
					// 신규 버튼2
					case 'bCreate2':
						bCreate2 = document.all[i];
						break;
					// 수정 버튼2
					case 'bUpdate2':
						bUpdate2 = document.all[i];
						break;
					// 저장 버튼2
					case 'bSave2':
						bSave2 = document.all[i];
						break;
					// 삭제 버튼2
					case 'bDelete2':
						bDelete2 = document.all[i];
						break;
				}
			}
		}
	}
}

/**
 * @type   : variable
 * @access : private
 * @desc   : 신규 입력을 위해 Bind에 연결된 DataSet에 DataSetHeader를 설정하기 위해 결과가 없는 조회를 실행한다.<br>
 *           이 때에 조회 결과가 없다는 메시지를 표시되지 않게 하기 위해, 신규 입력을 위한 조회일 경우 flag를 설정한다.<br>
 *           신규 입력을 위한 자바스크립트 함수에서 아래와 같이 flag를 설정한다.<br>
 * <pre>
 *     cfTurnCreateFlag(true);
 * </pre>
 *           그리고, DataSet의 OnLoadCompleted 이벤트 핸들러 함수에서 cfCheckCreateFlag()가 true이면 조회 건수가 0건이라도<br>
 *           별도의 메시지를 출력하도록 하지 않는다.
 * <pre>
 *     if (cfCheckCreateFlag() == false) {
 *       alert("조회된 데이터가 없습니다");
 *     } else {
 *       cfTurnCreateFlag(false);
 *     }
 * </pre>
 * @author : 송동혁
 */
var cvNew = false;

/**
 * @type   : function
 * @access : public
 * @desc   : 신규 입력을 위한 DataSet의 조회인지 flag를 설정한다.<br>
 *           신규 입력을 위한 조회가 끝났을 때 flag를 off시키기 위해서도 사용한다.<br>
 * <pre>
 *     cfTurnCreateFlag(true);
 * </pre>
 * @param  : boolean 신규 입력을 위한 조회 여부
 * @return : void
 * @author : 송동혁
 */
function cfTurnCreateFlag(onOff) {
	cvNew = onOff;
}

/**
 * @type   : function
 * @access : public
 * @desc   : 신규 입력을 위한 DataSet의 조회인지 flag를 조회한다.<br>
 * <pre>
 *     if (cfCheckCreateFlag() == true) {
 *       // do something;
 *     }
 * </pre>
 * @param  : void
 * @return : boolean 신규 입력을 위한 조회 여부
 * @author : 송동혁
 */
function cfCheckCreateFlag() {
	return cvNew;
}

/**
 * @type   : function
 * @access : public
 * @desc   : 필수 입력 항목(mandatory="true"로 선언된 오브젝트)의 입력 여부를 확인하여, 모두 입력되었으면 true, 아니면 false를 리턴한다.<br>
 *           주로 '저장' 버튼을 클릭했을 때, 필수 입력 항목에 대한 validation용으로 사용한다.<br>
 *
 * <pre>
 *     if (cfCheckMandatory() == false)
 *         return;
 * </pre>
 * 필수 입력항목이 빠졌을 경우 그 오브젝트에 focus가 가고, 에러 메시지가 alert로 나타난 후에 이후의 작업(예:저장)을 수행하지 않고 리턴한다.
 * @return : boolean 필수입력항목의 입력 여부
 * @author : 송동혁
 */
function cfCheckMandatory() {
	for (var i = 0; i < mandatory.length; i++) {
		if (mandatory[i].tagName.toUpperCase() == "INPUT") {
			if (mandatory[i].value == "") {
				mandatory[i].focus();
				alert("필수 입력 항목입니다");
				return false;
			}
		}
		else if (mandatory[i].tagName.toUpperCase() == "OBJECT") {
			// EMEdit, LuxeCombo, TextArea
			var clsid = mandatory[i].classid.toUpperCase();
			if (clsid == "CLSID:D7779973-9954-464E-9708-DA774CA50E13" ||
			    clsid == "CLSID:BB4533A0-85E0-4657-9BF2-E8E7B100D47E" ||
			    clsid == "CLSID:1455BE02-C41B-4115-B21C-32380507DC8F") {
				if (mandatory[i].Text == "") {
					alert("필수 입력 항목입니다");
					mandatory[i].Focus();
					return false;
				}
			}
		}
	}

	return true;
}


/**
 * @type   : function
 * @access : public
 * @desc   : DataSet, 컬럼ID, 컬럼Name을 인자로 넘겨, 필수입력필드의 입력여부를 체크하고, 모두 입력되었을 경우에는 true를,
 *           그렇지 않은 경우 false를 리턴한다. 여기서는 단순히 입력여부를 체크할 뿐, 데이터타입에 따른 별도의 처리는 하지 않는다.<br>
 * <pre>
 *   if (!cfCheckGridMandatoryCol(ds_code, ["cd", "cdNm"], ["코드", "코드명"]))
 *     return;
 * </pre>
 * 필수 입력필드가 빠졌을 경우 그 Row로 focus가 가고, 에러 메시지가 alert로 나타난 후에 이후의 작업(예:저장)을 수행하지 않고 리턴한다.
 * @sig    : ds, colArr, colNmArr
 * @param  : ds  필수입력 여부를 체크할 대상 DataSet
 * @param  : colArr  체크 대상 컬럼의 ID
 * @param  : colNmArr  체크 대상 컬럼의 Name
 * @return : boolean 필수입력항목의 입력 여부
 * @author : 송동혁
 */
  function cfCheckGridMandatoryCol(ds, colArr, colNmArr) {
    for (var i = 1; i <= ds.CountRow; i++) {
      var rowStat = ds.RowStatus(i);
      // 1:insert, 3:update
      if (rowStat == 1 || rowStat == 3) {
        for (var j = 0; j < colArr.length; j++) {
        	 // 체크 대상 컬럼에 내용이 입력되었는지 확인
          if (ds.NameValue(i, colArr[j]) == "" || ds.NameValue(i, colArr[j]) == null) {
            alert("'" + colNmArr[j] + "' 필드는 필수입력입니다");
            ds.RowPosition = i;
            return false;
          }
        }
      }
    }
    return true;
  }


/**
 * @type   : function
 * @access : public
 * @desc   : DataSet, 컬럼ID, 컬럼Name을 인자로 넘겨, DataSet 내에서 키필드의 중복여부를 체크하고, 중복이 없을 경우에는 true를,
 *           그렇지 않은 경우 false를 리턴한다.<br>
 * <pre>
 *  if (!cfCheckGridKeyColDup(ds_code, ["grpCd", "cd"], ["그룹코드", "코드"]))
 *    return;
 * </pre>
 * 키필드가 중복되었을 경우 그 Row로 focus가 가고, 에러 메시지가 alert로 나타난 후에 이후의 작업(예:저장)을 수행하지 않고 리턴한다.
 * @sig    : ds, colArr, colNmArr
 * @param  : ds  키 중복 여부를 체크할 대상 DataSet
 * @param  : colArr  키 컬럼의 ID
 * @param  : colNmArr  키 컬럼의 Name
 * @return : boolean 키 필드의 중복 여부(중복:false, 중복안됨:true);
 * @author : 송동혁
 */
function cfCheckGridKeyColDup(ds, colArr, colNmArr) {
	// 복사용 DataSet 만들기
	var tempDataSet = document.createElement("<OBJECT>");
	tempDataSet.classid = "CLSID:AF989B7C-8AC3-40BC-B749-EB335BDFD190";
	tempDataSet.id = "tempDS";
	document.body.insertAdjacentElement("beforeEnd", tempDataSet);

	// 복사용 DataSet에 데이터 넣기
	cfCopyDataSetKeyHeader(ds, tempDataSet, colArr);
	cfCopyDataSet(ds, tempDataSet, "copyHeader=no");

	// 원래 DataSet의 Row Num을 저장해 둔다.
	for (var j = 1; j <= tempDataSet.CountRow; j++) {
	  tempDataSet.NameValue(j, "rowNum") = j;
	}

	// DataSet의 Sort Expression을 생성한다.
	var sortExprStr = "";
	for (var i = 0; i < colArr.length; i++) {
	  sortExprStr = sortExprStr + "+" + colArr[i];
	}

	// Key 컬럼을 기준으로 정렬한다.
	tempDataSet.SortExpr = sortExprStr;
	tempDataSet.Sort();

	//alert(tempDataSet.ExportData(1, 10, true));

	// 첫번째 Row에서 맨끝에서 두번째 Row까지 루프 돌면서, 다음 Row와 비교
	for (var k = 1; k < tempDataSet.CountRow; k++) {
	  var l;
	  for (l = 0; l < colArr.length; l++) {
	    if (tempDataSet.NameValue(k, colArr[l]) != tempDataSet.NameValue(k+1, colArr[l]))
	      break;
	  }

	  if (l == colArr.length) {
      // Key 필드명을 합친다.
      var keyFields = "";
      for (var i = 0; i < colNmArr.length; i++) {
        if (i == 0)
          keyFields = keyFields + colNmArr[i];
        else
          keyFields = keyFields + "," + colNmArr[i];
      }

	    alert(tempDataSet.NameValue(k, "rowNum") + "행과 " + tempDataSet.NameValue(k+1, "rowNum") + "행의 키 필드(" + keyFields + ")가 중복되었습니다");
	    ds.RowPosition = tempDataSet.NameValue(k+1, "rowNum");
	    return false;
	  }
	}

	return true;
}


/**
 * @type   : function
 * @access : public
 * @desc   : Key와 Data 형태의 입력필드를 모두 enable(editable) 상태로 변경한다.
 * <pre>
 *     cfEnableKeyData();
 * </pre>
 * 주로 '신규' 입력 등의 작업에서 모든 입력필드를 입력 가능하게 만들기 위해 사용한다.
 * @author : 송동혁
 */
function cfEnableKeyData() {
	for (var i = 0; i < key.length; i++) {
		cfEnableObj(key[i], true);
	}
	for (var i = 0; i < data.length; i++) {
		cfEnableObj(data[i], true);
	}
}


/**
 * @type   : function
 * @access : public
 * @desc   : Key와 Data를 모두 disable(non-editable) 상태로 변경한다.
 * <pre>
 *     cfDisableKeyData();
 * </pre>
 * 주로 '조회'나 '저장' 등의 작업 후에 내용을 입력이나 수정 없이 확인만 가능하도록 하기 위해 사용한다.
 * @author : 송동혁
 */
function cfDisableKeyData() {
	for (var i = 0; i < key.length; i++) {
		cfEnableObj(key[i], false);
	}

	for (var i = 0; i < data.length; i++) {
		cfEnableObj(data[i], false);
	}
}


/**
 * @type   : function
 * @access : public
 * @desc   : Key는 disable(non-editable), Data는 enable(editable) 상태로 변경한다.
 * <pre>
 *     cfDisableKey();
 * </pre>
 * 주로 '수정' 버튼을 클릭했을 때, Key 필드를 제외한 나머지 내용만 변경 가능하도록 하기 위해 사용한다.
 * @author : 송동혁
 */
function cfDisableKey() {
	for (var i = 0; i < key.length; i++) {
		cfEnableObj(key[i], false);
	}

	for (var i = 0; i < data.length; i++) {
		cfEnableObj(data[i], true);
	}
}


/**
 * @type   : function
 * @access : public
 * @desc   : 모든 버튼을 enable(클릭가능) 상태로 변경한다.
 * <pre>
 *     cfEnableAllBtn();
 * </pre>
 * @author : 송동혁
 */
function cfEnableAllBtn() {
	// ctrlBtn 배열의 모든 버튼을 enable시킨다
	for (var i in ctrlBtn) {
    if (ctrlBtn[i] != null)
      ctrlBtn[i].disabled = false;
  }

	// 신규
	if (bCreate != null)
		bCreate.disabled = false;
	// 수정
	if (bUpdate != null)
		bUpdate.disabled = false;
	// 저장
	if (bSave != null)
		bSave.disabled = false;
	// 삭제
	if (bDelete != null)
		bDelete.disabled = false;

	// 신규
	if (bCreate2 != null)
		bCreate2.disabled = false;
	// 수정
	if (bUpdate2 != null)
		bUpdate2.disabled = false;
	// 저장
	if (bSave2 != null)
		bSave2.disabled = false;
	// 삭제
	if (bDelete2 != null)
		bDelete2.disabled = false;
}


/**
 * @type   : function
 * @access : public
 * @desc   : 모든 버튼을 disable(클릭불가) 상태로 변경한다.
 * <pre>
 *     cfDisableAllBtn();
 * </pre>
 * @author : 송동혁
 */
function cfDisableAllBtn() {
	// ctrlBtn 배열의 모든 버튼을 enable시킨다
	for (var i in ctrlBtn) {
    if (ctrlBtn[i] != null)
      ctrlBtn[i].disabled = true;
  }

	// 신규
	if (bCreate != null)
		bCreate.disabled = true;
	// 수정
	if (bUpdate != null)
		bUpdate.disabled = true;
	// 저장
	if (bSave != null)
		bSave.disabled = true;
	// 삭제
	if (bDelete != null)
		bDelete.disabled = true;

	// 신규
	if (bCreate2 != null)
		bCreate2.disabled = true;
	// 수정
	if (bUpdate2 != null)
		bUpdate2.disabled = true;
	// 저장
	if (bSave2 != null)
		bSave2.disabled = true;
	// 삭제
	if (bDelete2 != null)
		bDelete2.disabled = true;
}


/**
 * @type   : function
 * @access : public
 * @desc   : 지정한 버튼만 disable시키고, 그 외 나머지는 enable 상태로 변경한다.
 * <pre>
 *     cfDisableBtn([bUpdate, bDelete]);
 * </pre>
 * 주로 현재의 상태에서 클릭하면 안 되는 버튼을 disable시키기 위해 사용한다.<br>
 * 예) '신규' 버튼을 클릭했을 때는, '수정'과 '삭제' 버튼을 disable시키고 '저장' 버튼만 enable시킨다.
 * @sig    : btnArr
 * @param  : btnArr  disable 상태로 바꿀 버튼의 배열
 * @author : 송동혁
 */
function cfDisableBtn(btnArr) {
  cfEnableAllBtn();

  for (var i in btnArr) {
    if (btnArr[i] != null)
      btnArr[i].disabled = true;
  }
}


/**
 * @type   : function
 * @access : public
 * @desc   : 지정한 버튼만 disable시키고, 그 외 나머지는 원래 상태 그대로 있는다.
 * <pre>
 *     cfDisableBtnOnly([bUpdate, bDelete]);
 * </pre>
 * @sig    : btnArr
 * @param  : btnArr  disable 상태로 바꿀 버튼의 배열
 * @author : 송동혁
 */
function cfDisableBtnOnly(btnArr) {
  for (var i in btnArr) {
    if (btnArr[i] != null)
      btnArr[i].disabled = true;
  }
}


/**
 * @type   : function
 * @access : public
 * @desc   : 지정한 버튼만 enable시키고, 그 외 나머지는 원래 상태 그대로 있는다.
 * <pre>
 *     cfEnableBtnOnly([bUpdate, bDelete]);
 * </pre>
 * @sig    : btnArr
 * @param  : btnArr  enable 상태로 바꿀 버튼의 배열
 * @author : 송동혁
 */
function cfEnableBtnOnly(btnArr) {
  for (var i in btnArr) {
    if (btnArr[i] != null)
      btnArr[i].disabled = false;
  }
}


/**
 * @type   : function
 * @access : public
 * @desc   : Object를 status 변수에 따라 enable하거나 disable 상태로 변경한다.
 * <pre>
 *     cfEnableObj(txt_empNo, true);
 * </pre>
 * 위와같이 사용했을 경우 txt_empNo라는 오브젝트를 enable 상태로 변경한다.
 * @sig    : ObjectItem, Status
 * @param  : ObjectItem required 상태변경 대상 오브젝트
 * @param  : Status required 목표상태
 * @author :
 */
function cfEnableObj(ObjectItem, Status) {
    switch (ObjectItem.tagName) {
        case 'INPUT':
        	var type = ObjectItem.type.toUpperCase();
            if(type == 'FILE' || type == 'BUTTON' || type == 'CHECKBOX' || type == 'IMAGE' || type == 'RADIO' || type == 'RESET' || type == 'SUBMIT'){
               ObjectItem.disabled = (!Status);
              if(Status==false) ObjectItem.className = 'input_text_dimmed';
              if(Status==true) ObjectItem.className = 'input_text';
               break;
            } else if (type == 'PASSWORD' || type == 'TEXT') {
              ObjectItem.contentEditable  = (Status);
              if(Status==false){
                   ObjectItem.className = 'input_text_dimmed';
              } else {
                   ObjectItem.className = 'input_text';
              }
              break;
            }
        case 'SELECT':
            ObjectItem.disabled = (!Status);
            break;
        case 'TEXTAREA':
            ObjectItem.readOnly = (!Status);
            break;
        case 'A':
            ObjectItem.disabled = (!Status);
            break;
        case 'OBJECT':
            switch (ObjectItem.attributes.classid.nodeValue.toUpperCase()) {
                case 'CLSID:71E7ACA0-EF63-4055-9894-229B056E9C31':  //GRID
                    ObjectItem.Editable = (Status);
                    break;
                case 'CLSID:5C32688E-CEBE-419D-9C63-0704A2331EEC': //INPUT-FILE
                    ObjectItem.Enable = (Status);
                    break;
                case 'CLSID:D7779973-9954-464E-9708-DA774CA50E13':  //EMEDIT
                    ObjectItem.ReadOnly = (!Status);
                    if(Status==false){
                    	ObjectItem.className = 'object_eme_dimmed';
                    }else{
                    	ObjectItem.className = 'object_eme';
                    }
                    break;
                case 'CLSID:BB4533A0-85E0-4657-9BF2-E8E7B100D47E':  //LUXCOMBO
                    ObjectItem.Enable = (Status);
                    if(Status==false){
                        ObjectItem.DisableBackColor  = '#FFFFFF';//#F9F9F9
                    }else{
                    }
                    break;
                case 'CLSID:F73C0958-D8FE-43A5-9BB0-0F651C5A2BCC':  //RADIO
                    ObjectItem.Enable = (Status);
                    break;
                case 'CLSID:1455BE02-C41B-4115-B21C-32380507DC8F':  //TextArea
                    ObjectItem.Enable = (Status);
                    break;
            }
    }
}


/**
 * @type   : function
 * @access : public
 * @desc   : 가우스 Grid의 Style을 정해진 Style로 바꾸어준다. Style과 관련된 내용은 디자인표준문서를 참고할 것.
 * <pre>
 *     cfStyleGrid(oDelivRsltGG, "comn", features);
 * </pre>
 * @sig    : oGrid, styleName[, features]
 * @param  : oGrid     required Grid 오브젝트
 * @param  : styleName required Grid의 style name. 현재는 "comn" 과 "comnCS" 만 있다.
 * @param  : features  optional 기타 속성을 정의하는 스트링. 속성종류는 아래와 같다.
 * <pre>
 *     indWidth  : Grid의 IndWidth 속성 지정.
 *     rowHeight : Grid의 RowHeight 속성 지정.
 *
 *     사용예) "indWidth=12,rowHeight=25"
 * </pre>
 * @author : 임재현
 * @ 수정 : LAF/UI 2005년 2월 1일
 */
function cfStyleGrid(oGrid, styleName, features) {
window.status = "cfStyleGrid";

  // 전체속성
  var gridBorderStyle;
  var borderStyle;  // html 스타일쉬트임.
  var borderWidth;  // html 스타일쉬트임.
  var borderColor;  // html 스타일쉬트임.
  var headBorder;
  var headLineColor;
  var lineColor;
  var titleHeight;
  var bgColor;
  var fontSize;
  var fontFamily;
  var fontWeight;
  var selectionColor;
  var indicatorBkColor;
  var indicatorColBkColor;

  var sumColor;
  var sumBgColor;
  var subColor;
  var subBgColor;
  var subpressBgColor;

  var color;
  var headAlign;
  var headColor;
  var headBgColor;

  // <C> 컬럼 속성
  var CColor;
  var CBgColor;

  // <FC> 컬럼 속성
  var FCColor;
  var FCBgColor;

  // 컬럼 헤드 레벨별 속성 정의
  var HeadColor1;
  var HeadBgColor1;
  var HeadColorF1;
  var HeadBgColorF1;

  var HeadColor2;
  var HeadBgColor2;
  var HeadColorF2;
  var HeadBgColorF2;

  var HeadColor3;
  var HeadBgColor3;
  var HeadColorF3;
  var HeadBgColorF3;


/******  편집영역1 시작  **************************/
/******  indWidth - 인디케이터 영역의 width  ******/
/******  rowHeight - 그리드 각 row의 height  ******/

  var featureNames  = ["indWidth", "rowHeight"];
  var featureValues = [0, 22];
  var featureTypes  = ["number", "number"];

/******  편집영역1 끝  ****************************/

  if (features != null) {
    cfParseFeature(features, featureNames, featureValues, featureTypes);
  }

  var indWidth = featureValues[0];
  var rowHeight = featureValues[1];


window.status = "start";
  // Grid Style 별 정의
  switch (styleName) {


/******  편집영역2 시작  **************************/
/******  그리드 스타일 정의  **********************/


// comn : Web Style

    case "comn":
      // Grid 속성
      gridBorderStyle  = 0;
      borderStyle      = "solid";
      borderWidth      = 0;
      borderColor      = "#DCE2EC";
      headBorder       = 0;
      headLineColor    = "#d0d8e5";
      lineColor        = "#DCE2EC";
      titleHeight      = 22;
      fontSize         = "9pt";
      fontFamily       = "굴림";
      fontWeight       = "normal";
      indicatorBkColor = "#E4E9F2";
      indicatorColBkColor = "#E4E9F2";


	  //선택된 셀, 행, 컬럼의 속성
	  //앞에 Focus가 붙은 타입에는 그리드가 비활성된 상태에서의 속성을 지정한다.
      					  //Editable 영역 컬럼 선택시

      selectionColor   = "<SC>Type='FocusEditCol', BgColor='#f8f3f0', TextColor='#000000'</SC>" +
                         "<SC>Type='EditCol', BgColor='#f8f3f0', TextColor='#000000'</SC>" +
						 //Editable 영역 행 선택시
                         "<SC>Type='FocusEditRow', BgColor='#f8f3f0', TextColor='#000000'</SC>" +
                         "<SC>Type='EditRow', BgColor='#f8f3f0', TextColor='#000000'</SC>" +
						 //non-Editable 영역 컬럼 선택시
                         "<SC>Type='FocusCurCol', BgColor='#f8f3f0', TextColor='#000000'</SC>" +
                         "<SC>Type='CurCol', BgColor='#f8f3f0', TextColor='#000000'</SC>" +
						 //non-Editable 영역 행 선택시
                         "<SC>Type='FocusCurRow', BgColor='#f8f3f0', TextColor='#000000'</SC>" +
                         "<SC>Type='CurRow', BgColor='#f8f3f0', TextColor='#000000'</SC>" +
						 //MultiSelect시 현재 커서가 있는 영역을 #E8F5FF 선택된 영역
                         "<SC>Type='FocusSelRow', BgColor='#f8f3f0', TextColor='#000000'</SC>" +
                         "<SC>Type='SelRow', BgColor='#f8f3f0', TextColor='#000000'</SC>";

      // 컬럼 공통 속성
      sumColor         = "#134176";
      sumBgColor       = "#D4DAE2";
      subColor         = "#464646";
      subBgColor       = "#D8D8D8";
      subpressBgColor  = "#FFFFFF";

      // 컬럼별 속성
      GColor           = "#555555";
	  GBgColor		   = "#FFFFFF"; //"{decode(currow-tointeger(currow/2)*2,0,'#EEEEEE',1,'#FFFFFF')}";
      CColor           = "#555555";
	  CBgColor		   = "{decode(currow-tointeger(currow/2)*2,0,'#FFFFFF',1,'#FFFFFF')}";
	  //CBgColor		   = "{decode(currow-tointeger(currow/2)*2,0,'#FFFFFF',1,'#FFFFFF')}";
      FCColor          = "#555555";
      FCBgColor        = "{decode(currow-tointeger(currow/2)*2,0,'#FFFFFF',1,'#F0F0F0')}"; //"#F0F0F0"
      //FCBgColor        = "{decode(currow-tointeger(currow/2)*2,0,'#FFFFFF',1,'#F0F0F0')}"; //"#F0F0F0"
      HeadColor1       = "#6B778F";

      //헤더 3종에 대해서 설정한 색깔
      HeadBgColor1     = "#E4E9F2";
      HeadColorF1      = "#6B778F";
      HeadBgColorF1    = "#E4E9F2";
      HeadColor2       = "#6B778F";
      HeadBgColor2     = "#E4E9F2";
      HeadColorF2      = "#6B778F";
      HeadBgColorF2    = "#E4E9F2";
      HeadColor3       = "#6B778F";
      HeadBgColor3     = "#E4E9F2";
      HeadColorF3      = "#6B778F";
      HeadBgColorF3    = "#E4E9F2";
      oGrid.IndWidth            = 0;
      break;

// comn : Web Style indwidth 사용

    case "comn_status":
      // Grid 속성
      gridBorderStyle  = 0;
      borderStyle      = "solid";
      borderWidth      = 0;
      borderColor      = "#DCE2EC";
      headBorder       = 0;
      headLineColor    = "#d0d8e5";
      lineColor        = "#DCE2EC";
      titleHeight      = 22;
      fontSize         = "9pt";
      fontFamily       = "굴림";
      fontWeight       = "normal";
      indicatorBkColor = "#E4E9F2";
      indicatorColBkColor = "#E4E9F2";


	  //선택된 셀, 행, 컬럼의 속성
	  //앞에 Focus가 붙은 타입에는 그리드가 비활성된 상태에서의 속성을 지정한다.
      					  //Editable 영역 컬럼 선택시

      selectionColor   = "<SC>Type='FocusEditCol', BgColor='#f8f3f0', TextColor='#000000'</SC>" +
                         "<SC>Type='EditCol', BgColor='#f8f3f0', TextColor='#000000'</SC>" +
						 //Editable 영역 행 선택시
                         "<SC>Type='FocusEditRow', BgColor='#f8f3f0', TextColor='#000000'</SC>" +
                         "<SC>Type='EditRow', BgColor='#f8f3f0', TextColor='#000000'</SC>" +
						 //non-Editable 영역 컬럼 선택시
                         "<SC>Type='FocusCurCol', BgColor='#f8f3f0', TextColor='#000000'</SC>" +
                         "<SC>Type='CurCol', BgColor='#f8f3f0', TextColor='#000000'</SC>" +
						 //non-Editable 영역 행 선택시
                         "<SC>Type='FocusCurRow', BgColor='#f8f3f0', TextColor='#000000'</SC>" +
                         "<SC>Type='CurRow', BgColor='#f8f3f0', TextColor='#000000'</SC>" +
						 //MultiSelect시 현재 커서가 있는 영역을 #E8F5FF 선택된 영역
                         "<SC>Type='FocusSelRow', BgColor='#f8f3f0', TextColor='#000000'</SC>" +
                         "<SC>Type='SelRow', BgColor='#f8f3f0', TextColor='#000000'</SC>";

      // 컬럼 공통 속성
      sumColor         = "#134176";
      sumBgColor       = "#D4DAE2";
      subColor         = "#464646";
      subBgColor       = "#D8D8D8";
      subpressBgColor  = "#FFFFFF";

      // 컬럼별 속성
      GColor           = "#555555";
	  GBgColor		   = "#FFFFFF"; //"{decode(currow-tointeger(currow/2)*2,0,'#EEEEEE',1,'#FFFFFF')}";
      CColor           = "#555555";
	  CBgColor		   = "{decode(currow-tointeger(currow/2)*2,0,'#FFFFFF',1,'#FFFFFF')}";
	  //CBgColor		   = "{decode(currow-tointeger(currow/2)*2,0,'#FFFFFF',1,'#FFFFFF')}";
      FCColor          = "#555555";
      FCBgColor        = "{decode(currow-tointeger(currow/2)*2,0,'#FFFFFF',1,'#F0F0F0')}"; //"#F0F0F0"
      //FCBgColor        = "{decode(currow-tointeger(currow/2)*2,0,'#FFFFFF',1,'#F0F0F0')}"; //"#F0F0F0"
      HeadColor1       = "#6B778F";

      //헤더 3종에 대해서 설정한 색깔
      HeadBgColor1     = "#E4E9F2";
      HeadColorF1      = "#6B778F";
      HeadBgColorF1    = "#E4E9F2";
      HeadColor2       = "#6B778F";
      HeadBgColor2     = "#E4E9F2";
      HeadColorF2      = "#6B778F";
      HeadBgColorF2    = "#E4E9F2";
      HeadColor3       = "#6B778F";
      HeadBgColor3     = "#E4E9F2";
      HeadColorF3      = "#6B778F";
      HeadBgColorF3    = "#E4E9F2"; 
      break;


// comnCS : CS Style

    case "comnCS":

window.status = "comnCS";
      // Grid 속성
      gridBorderStyle  = 0;
      borderStyle      = "solid";
      borderWidth      = 1;
      borderColor      = "#C0C0C0";
      headBorder       = 0;
      headLineColor    = "#C0C0C0";
      lineColor        = "#C0C0C0";
      titleHeight      = 22;
      fontSize         = "9pt";
      fontFamily       = "굴림";
      fontWeight       = "normal";
      indicatorBkColor = "#EDEDE8";
      indicatorColBkColor = "#EDEDE8";


	  //선택된 셀, 행, 컬럼의 속성
	  //앞에 Focus가 붙은 타입에는 그리드가 비활성된 상태에서의 속성을 지정한다.
      					  //Editable 영역 컬럼 선택시

      selectionColor   = "<SC>Type='FocusEditCol', BgColor='#FFFFFF', TextColor='#000000'</SC>" +
                         "<SC>Type='EditCol', BgColor='#FFE4C4', TextColor='#000000'</SC>" +
						 //Editable 영역 행 선택시
                         "<SC>Type='FocusEditRow', BgColor='#FFE4C4', TextColor='#000000'</SC>" +
                         "<SC>Type='EditRow', BgColor='#FFE4C4', TextColor='#000000'</SC>" +
						 //non-Editable 영역 컬럼 선택시
                         "<SC>Type='FocusCurCol', BgColor='#FFE4C4', TextColor='#000000'</SC>" +
                         "<SC>Type='CurCol', BgColor='#FFE4C4', TextColor='#000000'</SC>" +
						 //non-Editable 영역 행 선택시
                         "<SC>Type='FocusCurRow', BgColor='#FFE4C4', TextColor='#000000'</SC>" +
                         "<SC>Type='CurRow', BgColor='#FFE4C4', TextColor='#000000'</SC>" +
						 //MultiSelect시 현재 커서가 있는 영역을 제외한 선택된 영역
                         "<SC>Type='FocusSelRow', BgColor='#FFE4C4', TextColor='#000000'</SC>" +
                         "<SC>Type='SelRow', BgColor='#FFE4C4', TextColor='#000000'</SC>";

      // 컬럼 공통 속성
      sumColor         = "#134176";
      sumBgColor       = "#D4DAE2";
      subColor         = "#464646";
      subBgColor       = "#D8D8D8";
      subpressBgColor  = "#FFFFFF";

      // 컬럼별 속성
      GColor           = "#000000";
	  GBgColor		   = "#FFFFFF"; //"{decode(currow-tointeger(currow/2)*2,0,'#EEEEEE',1,'#FFFFFF')}";
      CColor           = "#000000";
	  CBgColor		   = "{decode(currow-tointeger(currow/2)*2,0,'#f5f5f5',1,'#FFFFFF')}";
      FCColor          = "#000000";
      FCBgColor        = "{decode(currow-tointeger(currow/2)*2,0,'#F0F0F0',1,'#FFFFFF')}"; //"#F0F0F0"
      HeadColor1       = "#000000";

      //헤더 3종에 대해서 설정한 색깔
      HeadBgColor1     = "#EDEDE8";
      HeadColorF1      = "#000000";
      HeadBgColorF1    = "#EDEDE8";
      HeadColor2       = "#000000";
      HeadBgColor2     = "#EDEDE8";
      HeadColorF2      = "#000000";
      HeadBgColorF2    = "#EDEDE8";
      HeadColor3       = "#000000";
      HeadBgColor3     = "#EDEDE8";
      HeadColorF3      = "#000000";
      HeadBgColorF3    = "#EDEDE8";

      break;
      
/******  편집영역2 끝 ****************************/

    default:
      return;
  }

  // Grid 속성 설정
  {
    oGrid.BorderStyle         = gridBorderStyle;
    oGrid.HeadBorder          = headBorder;
    oGrid.HeadLineColor       = headLineColor;
    oGrid.LineColor           = lineColor;
    //oGrid.TitleHeight = titleHeight;
    oGrid.RowHeight           = rowHeight;
    oGrid.style.borderStyle   = borderStyle;
    oGrid.style.borderWidth   = borderWidth;
    oGrid.style.borderColor   = borderColor;
    oGrid.style.fontSize      = fontSize;
    oGrid.style.fontFamily    = fontFamily;
    oGrid.style.fontWeight    = fontWeight;
    oGrid.IndicatorBkColor    = indicatorBkColor;
    oGrid.IndicatorColBkColor = indicatorColBkColor;
    oGrid.SelectionColor      = selectionColor;
    oGrid.HeadBorder          = 4;
    oGrid.DragMode  = "true"; 
    oGrid.ColSizing   = true;
    oGrid.DragDropEnable = "true";
    
    
  }

  var tagRE = /<(\/?(fc|c|g|fg|x|fx))>/i;
  var colAttrRE = /([\w_]+)\s*=\s*['"]?([^<'"\s,]+)/i;

  var gFormat = oGrid.Format;
  var newGFormat = "";
  var tagMatch;
  var tagName;
  var colAttrData;
  var colAttrMatch;
  var colAttrName;
  var colAttrValue;
  var insertStr;
  var gtagOpened = false;
  var xtagOpened = false;
  var headLevel = 1;

  if ( (gFormat.indexOf("<X>") != -1) || (gFormat.indexOf("<FX>") != -1) ) headLevel = 3;
  else if ( (gFormat.indexOf("<G>") != -1) || (gFormat.indexOf("<FG>") != -1) ) headLevel = 2;

  // Grid Format String 을 파싱하여 컬럼별로 Style 과 관련된 속성을 삽입한다.
  while ((tagMatch = gFormat.match(tagRE)) != null) {
    tagName = tagMatch[1].trim().toUpperCase();
    var style = "";
    var isSupress = false;
    insertStr = "";

    switch (tagName) {
      case "G" :
      case "FG" :
        gtagOpened = true;
        break;
      case "/G" :
      case "/FG" :
        gtagOpened = false;
        break;
      case "X" :
      case "FX" :
        xtagOpened = true;
        break;
      case "/X" :
      case "/FX" :
        xtagOpened = false;
        break;
    }

    if (tagName.indexOf("/") != -1) {
      newGFormat = newGFormat + gFormat.substring(0, tagMatch.lastIndex);
      gFormat = gFormat.substr(tagMatch.lastIndex);
      continue;
    }

    // 사용자가 지정한 컬럼 속성에 따른 처리
    colAttrData = gFormat.substring(tagMatch.lastIndex, gFormat.indexOf("<", tagMatch.lastIndex));

    while ( (colAttrMatch = colAttrData.match(colAttrRE)) != null) {
      colAttrName = colAttrMatch[1].toUpperCase();
      colAttrValue = colAttrMatch[2].toUpperCase();

      if (colAttrName == "STYLE") {
        if (colAttrValue == "TITLE") {
          style = "TITLE";
        } else if (colAttrValue == "REQUIRED") {
          style = "REQUIRED";
        }
      }

      if (colAttrName == "SUPPRESS") {
        isSupress = true;
      }

      colAttrData = colAttrData.substr(colAttrMatch.lastIndex);
    }

    switch (tagName) {
      case "G" :
        if (headLevel == 3) {
          if (xtagOpened) {
            if (gtagOpened) {
              headAlign = "Center";
              headColor = HeadColor1;
              headBgColor = HeadBgColor1;
            } else {
              headAlign = "Center";
              headColor = HeadColor2;
              headBgColor = HeadBgColor2;
            }
          } else {
            if (gtagOpened) {
              headAlign = "Center";
              headColor = HeadColor2;
              headBgColor = HeadBgColor2;
            } else {
              headAlign = "Center";
              headColor = HeadColor3;
              headBgColor = HeadBgColor3;
            }
          }
        } else if (headLevel == 2) {
          if (gtagOpened) {
            headAlign = "Center";
            headColor = HeadColor1;
            headBgColor = HeadBgColor1;
          } else {
            headAlign = "Center";
            headColor = HeadColor2;
            headBgColor = HeadBgColor2;
          }
        } else {
          headAlign = "Center";
          headColor = HeadColor1;
          headBgColor = HeadBgColor1;
        }

        if (isSupress) {
          insertStr = insertStr + " BgColor=" + subpressBgColor;
        } else {
          insertStr = insertStr + " BgColor=" + CBgColor;
        }

        insertStr = insertStr + " Color=" + CColor +
                    " SumColor=" + sumColor +
                    " SumBgColor=" + sumBgColor +
                    " SubColor=" + subColor +
                    " SubBgColor=" + subBgColor;
        break;

      case "FC" :
        if (headLevel == 3) {
          if (xtagOpened) {
            if (gtagOpened) {
              headAlign = "Center";
              headColor = HeadColorF1;
              headBgColor = HeadBgColorF1;
            } else {
              headAlign = "Center";
              headColor = HeadColorF2;
              headBgColor = HeadBgColorF2;
            }
          } else {
            if (gtagOpened) {
              headAlign = "Center";
              headColor = HeadColorF2;
              headBgColor = HeadBgColorF2;
            } else {
              headAlign = "Center";
              headColor = HeadColorF3;
              headBgColor = HeadBgColorF3;
            }
          }
        } else if (headLevel == 2) {
          if (gtagOpened) {
            headAlign = "Center";
            headColor = HeadColorF1;
            headBgColor = HeadBgColorF1;
          } else {
            headAlign = "Center";
            headColor = HeadColorF2;
            headBgColor = HeadBgColorF2;
          }
        } else {
          headAlign = "Center";
          headColor = HeadColor1;
          headBgColor = HeadBgColor1;
        }

        if (isSupress) {
          insertStr = insertStr + " BgColor=" + subpressBgColor;
        } else {
          insertStr = insertStr + " BgColor=" + CBgColor;
        }

        insertStr = insertStr + " Color=" + CColor +
                    " SumColor=" + sumColor +
                    " SumBgColor=" + sumBgColor +
                    " SubColor=" + subColor +
                    " SubBgColor=" + subBgColor;
        break;

      case "C" :
        if (headLevel == 3) {
          if (xtagOpened) {
            if (gtagOpened) {
              headAlign = "Center";
              headColor = HeadColor1;
              headBgColor = HeadBgColor1;
            } else {
              headAlign = "Center";
              headColor = HeadColor2;
              headBgColor = HeadBgColor2;
            }
          } else {
            if (gtagOpened) {
              headAlign = "Center";
              headColor = HeadColor2;
              headBgColor = HeadBgColor2;
            } else {
              headAlign = "Center";
              headColor = HeadColor3;
              headBgColor = HeadBgColor3;
            }
          }
        } else if (headLevel == 2) {
          if (gtagOpened) {
            headAlign = "Center";
            headColor = HeadColor1;
            headBgColor = HeadBgColor1;
          } else {
            headAlign = "Center";
            headColor = HeadColor2;
            headBgColor = HeadBgColor2;
          }
        } else {
          headAlign = "Center";
          headColor = HeadColor1;
          headBgColor = HeadBgColor1;
        }

        if (isSupress) {
          insertStr = insertStr + " BgColor=" + subpressBgColor;
        } else {
          insertStr = insertStr + " BgColor=" + CBgColor;
        }

        insertStr = insertStr + " Color=" + CColor +
                    " SumColor=" + sumColor +
                    " SumBgColor=" + sumBgColor +
                    " SubColor=" + subColor +
                    " SubBgColor=" + subBgColor;
        break;


      case "FG" :
        if (headLevel == 3) {
          if (xtagOpened) {
            headAlign = "Center";
            headColor= HeadColorF2;
            headBgColor= HeadBgColorF2;
          } else {
            headAlign = "Center";
            headColor = HeadColorF3;
            headBgColor = HeadBgColorF3;
          }
        }

        if (headLevel == 2) {
          headAlign = "Center";
          headColor= HeadColorF2;
          headBgColor= HeadBgColorF2;
        }

        break;

      case "X" :
        headAlign = "Center";
        headColor= HeadColor3;
        headBgColor= HeadBgColor3;
        break;

      case "FX" :
        headAlign = "Center";
        headColor= HeadColorF3;
        headBgColor= HeadBgColorF3;
        break;

      default :
        break;
    }


    // 사용자가 지정한 컬럼 속성에 따른 처리
    colAttrData = gFormat.substring(tagMatch.lastIndex, gFormat.indexOf("<", tagMatch.lastIndex));


/******  편집영역3 시작  **************************/
/******  그리드 헤더 타이틀 스타일 정의  **********/

    if (style == "TITLE") {
      headColor = "#FFFFFF";
      headBgColor = "#365981";
      headAlign = "Left";
    } else if (style == "REQUIRED") {
      headColor = "#1467E4";
    }
/******  편집영역3 끝  ****************************/


    // Grid의 Format 에 Style 관련 속성값들을 삽입한다.
    insertStr = insertStr +
              " HeadColor=" + headColor +
              " HeadBgColor=" + headBgColor +
              " HeadAlign=" + headAlign + " ";

    newGFormat = newGFormat + gFormat.substring(0, tagMatch.lastIndex) + insertStr;
    gFormat = gFormat.substr(tagMatch.lastIndex);
  }

  newGFormat = newGFormat + gFormat;
  oGrid.Format = newGFormat;
}


/**
 * @type   : function
 * @access : public
 * @desc   : 가우스 Tab의 Style을 정해진 Style로 바꾸어준다.
 * <pre>
 *     cfStyleTab(oDomRegiRecevGTab, "comn");
 * </pre>
 * @sig    : oTab, styleName
 * @param  : oTab required Tab 오브젝트
 * @param  : styleName required Tab의 style name. 현재는 "comn" 과 "comnOnTab" 만 있다.
 * @author : 임재현
 * @ 수정 : LAF/UI 2005년 2월 1일
 */
function cfStyleTab(oTab, styleName) {
	var backColor;
	var textColor;
	var disableBackColor;
	var disableTextColor;
	var divBorder;
	var divBackground;

/******  편집영역 시작  **************************/
/******  탭(색상) 스타일 정의  **********/

	switch (styleName) {
		case "comn" :
			backColor = "#F4F4F4";
			textColor = "#1E56C3";
			disableBackColor = "#CFCFCD";
			disableTextColor = "#222866";
			divBorder = "1 solid #808080"; // width style color
			divBackground = "#ffffff"; //20050406 KHS "#F4F4F4";     // color image repeat attachment position
			break;

		case "comn_status" :
			backColor = "#F4F4F4";
			textColor = "#1E56C3";
			disableBackColor = "#CFCFCD";
			disableTextColor = "#222866";
			divBorder = ""; // width style color
			divBackground = ""; //20050406 KHS "#F4F4F4";     // color image repeat attachment position
			break;

		case "comnOnTab" :
			backColor = "#F4F4F4";
			textColor = "#1E56C3";
			disableBackColor = "#CFCFCD";
			disableTextColor = "#222866";
			divBorder = ""; // width style color
			divBackground = ""; //20050406 KHS "#F4F4F4";     // color image repeat attachment position
			break;

		default :
			break;
	}
/******  편집영역 끝  ****************************/

	oTab.style.fontSize = "9pt";
	oTab.BackColor = backColor;
	oTab.TextColor = textColor;
	oTab.DisableBackColor = disableBackColor;
	oTab.DisableTextColor = disableTextColor;

  var tagRE = /<\s*(\/?(t))\s*>/i;
  var attrRE = /([\w_]+)\s*=\s*['"]?([^<'"\s,]+)/i;

  var tFormat = oTab.Format;
  var tagMatch;
  var tagName;
  var attrData;
  var attrMatch;
  var attrName;
  var attrValue;

  // Tab Format String 을 파싱하여 divid를 읽는다.
  while ((tagMatch = tFormat.match(tagRE)) != null) {
    tagName = tagMatch[1].trim().toUpperCase();

    if (tagName.indexOf("/") != -1) {
      tFormat = tFormat.substr(tagMatch.lastIndex);
      continue;
    }

    // 사용자가 지정한 컬럼 속성에 따른 처리
    attrData = tFormat.substring(tagMatch.lastIndex, tFormat.indexOf("<", tagMatch.lastIndex));

    while ( (attrMatch = attrData.match(attrRE)) != null) {
      attrName = attrMatch[1].toUpperCase();
      attrValue = attrMatch[2];

      if (attrName == "DIVID") {
      	document.all[attrValue].style.border = divBorder;
      	document.all[attrValue].style.background = divBackground;
      }

      attrData = attrData.substr(attrMatch.lastIndex);
    }

    tFormat = tFormat.substr(tagMatch.lastIndex);
  }
}

/**
 * @type   : function
 * @access : public
 * @desc   : 공통 Calendar(달력) 팝업 호출
 * <pre>
 *     cfOpenCalendar(document.all.ed_birthDate);
 * </pre>
 * @sig    : position
 * @param  : 객체 object(input type=text, gauce EMEdit 모두 가능)
 * @author : 송동혁
 * @ 수정 : LAF/UI 2005년 2월 1일
 */
 function cfOpenCalendar(position){
  //position.readOnly  : input type=text 체크
  //position.ReadOnly  : gauce EMEdit 체크
  if( position.readOnly == true || position.ReadOnly == true ) return;

  var returnValue = window.showModalDialog("/common/jsp/calendarFrame.jsp", "winCalendar", "scroll:no;status:no;help:no;dialogWidth:275px;dialogHeight:315px;border-color:#ADADAD");

  if(typeof(returnValue) != "undefined"){
  	 //input type= text 형일경우
	   if( typeof(position.value) != "undefined" )
			    position.value = returnValue;
			 //gauce EMEdit인 경우
		  else if( typeof(position.Text) != "undefined" )
			    position.Text = returnValue;
  }
}


/* ********************************************************************************
 *                            페이징 관련 함수
 * *******************************************************************************/
/**
 * @type   : function
 * @access : public
 * @desc   : 페이징 인덱스 생성
 * <pre>
 *     cfMakePagingIndex(gauceDataSetForPageIndex , callBackFunctionName);
 * </pre>
 * @sig    : position
 * @param  : gauceDataSetForPageIndex 페이징 정보에 쓰일 가우스 DataSet
 * @param  : callBackFunctionName 페이징 인덱스 계산후 호출될 function
 * @author : 차종호
 */

  function cfMakePagingIndex( gauceDataSetForPageIndex , callBackFunctionName  ) {

       var targetRow = gauceDataSetForPageIndex.NameValue(1, 'targetRow'); // 시작 ROW
	   var numOfRowPerPage = gauceDataSetForPageIndex.NameValue(1, 'NUMBER_OF_ROWS_OF_PAGE'); // 한페이지당 보여줄 개수
	   var numOfIndexPerPage = gauceDataSetForPageIndex.NameValue(1, 'NUMBER_OF_PAGES_OF_INDEX'); // 한페이지당 보여줄 개수
	   var currentPage = gauceDataSetForPageIndex.NameValue(1, 'currentPage'); // 현재 페이지
	   var totalPage = gauceDataSetForPageIndex.NameValue(1, 'totalPage'); // 전체 페이지
	   var totalRecords = gauceDataSetForPageIndex.NameValue(1, 'totalRecords'); // 전체 건수

    var subPageStart =  currentPage -  parseInt(numOfIndexPerPage/2)  ;

    var maxSubPageStart = totalPage - numOfIndexPerPage + 1  ;
    if ( maxSubPageStart <= subPageStart ) subPageStart = maxSubPageStart ;
    if ( subPageStart <= 0 ) subPageStart = 1 ;

    var subPageEnd = subPageStart + numOfIndexPerPage - 1 ;
    if ( subPageEnd > totalPage )  {
      subPageEnd = totalPage ;
    }

    // alert( "subPageStart:"+subPageStart+":subPageEnd:"+subPageEnd) ;
    var pagingStr = "";
  	 pagingStr += '<table width="100%" border="0" cellpadding="2" cellspacing="1">';
    pagingStr += '<tr>';
    pagingStr += '  <td align="center" class="pagenumber_td">';

    // 처음페이지 / 이전페이지로 이동
    if (currentPage > 1) {
      pagingStr += '  <a href="#" onClick="'+callBackFunctionName+'(1)">1 Page</a>';
      var previousPageTargetRow = ( currentPage - 1 -1 ) * numOfRowPerPage + 1 ;
      pagingStr += '  <a href="#" onClick="'+callBackFunctionName+'(' + previousPageTargetRow + ')">';
      pagingStr += '    <img src="/common../images/Content_pageprv.gif" width="20" height="16" align="absmiddle">';
      pagingStr += '  </a>';
    }

    // 페이지 인덱스
    for (var i = subPageStart; i <= subPageEnd; i++) {
      var pageTargetRow = ( i - 1 ) * numOfRowPerPage + 1;
      if (i != currentPage)
        pagingStr += '  <a href="#" onClick="'+callBackFunctionName+'(' + pageTargetRow + ')">&nbsp;' + i + '&nbsp;</a>';
      else
        pagingStr += '  &nbsp;[' + i + ']&nbsp;';
    }


    // 다음 / 마지막 페이지 링크
    if (currentPage < totalPage) {
      // 다음 10 페이지 중 첫번째 페이지
      var nextPageTargetRow = ( currentPage ) * numOfRowPerPage + 1 ;
      pagingStr += '  <a href="#" onClick="'+callBackFunctionName+'(' + nextPageTargetRow + ')">';
      pagingStr += '    <img src="../images/Content_pagenext.gif" width="20" height="16" align="absmiddle">';
      pagingStr += '  </a>';
      var lastPageTargetRow = ( totalPage - 1 ) * numOfRowPerPage + 1 ;
      pagingStr += '  <a href="#" onClick="'+callBackFunctionName+'(' + lastPageTargetRow + ')">' + totalPage + ' Page</a>';
    }

    pagingStr += '  </td>';
    pagingStr += '</tr>';
    pagingStr += '</table>';

    return pagingStr ;
  }

/**
 * @type   : function
 * @access : public
 * @desc   : 이동할 대상 페이지의 첫번째 ROW 를 설정한다.
 * <pre>
 *    cfSetTargetRow(gauceDataSetForPageIndex, targetRow)
 * </pre>
 * @sig    : position
 * @param  : gauceDataSetForPageIndex 페이징 정보에 쓰일 가우스 DataSet
 * @param  : targetRow 대상 페이지 첫번째 ROW
 * @author : 차종호
 */
  function cfSetTargetRow(gauceDataSetForPageIndex, targetRow) {
       var tempTargetRow = targetRow ;
       if ( gauceDataSetForPageIndex.CountColumn == 0 ) {
          tempTargetRow = 1 ;
       } else {
            if ( targetRow != null && targetRow != "" ) {
                tempTargetRow =  targetRow ;
            } else {
                tempTargetRow = gauceDataSetForPageIndex.NameValue( 1 , "targetRow" ) ;
            }
       }
       gauceDataSetForPageIndex.SetDataHeader("targetRow:INTEGER");
       gauceDataSetForPageIndex.AddRow();
       // alert( "tempTargetRow:"+tempTargetRow);
       gauceDataSetForPageIndex.NameValue( 1 , "targetRow" ) = tempTargetRow ;
  }

/* ********************************************************************************
 *                            파일업로드 관련 함수
 * *******************************************************************************/

  var FILE_UPLOAD_DATA_SET_ID  ;
  var CALL_BACK_FUNCTION_NAME =  "CALL_BACK_FUNCTION_NAME";

/**
 * @type   : function
 * @access : public
 * @desc   : 파일을 업로드 한다.
 * <pre>
 *    cfUploadFile( fileMultipartForm , dataSetID , callBackFunctionName )
 * </pre>
 * @sig    : position
 * @param  : fileMultipartForm 업로드 대상 파일을  정의한 MULTI-PART FORM
 * @param  : dataSetID 업로드된 파일 정보 저장에 쓰일 가우스 DataSet
 * @param  : callBackFunctionName 업로드후에 호출될 자바 스크립트 함수명
 * @param  : INIT_ITEM_LIST 업로드된 파일리스트 정보의 삭제 여부 - 디폴트 값은 삭제
 * @author : 차종호
 */
  function cfUploadFile( fileMultipartForm , dataSetID , callBackFunctionName , INIT_ITEM_LIST ) {

  		var actionStr =   "/DFileUpload?"+CALL_BACK_FUNCTION_NAME+"="+callBackFunctionName;
  		if ( cfUploadFile.arguments.length > 3 ) {
  			 if (  INIT_ITEM_LIST )
  			   actionStr += "&INIT_ITEM_LIST=TRUE" ;
			   else
			     actionStr += "&INIT_ITEM_LIST=FALSE" ;
  		} else {
  			 actionStr += "&INIT_ITEM_LIST=TRUE" ;
  		}
    FILE_UPLOAD_DATA_SET_ID =  dataSetID ;
    fileMultipartForm.action  =  actionStr ;
	   fileMultipartForm.method = "post";
	   fileMultipartForm.encType= "multipart/form-data";
    fileMultipartForm.target =  cfGetUploadFrame() ; // fileUpWindow ;
	   fileMultipartForm.submit();
  }

/**
 * @type   : function
 * @access : public
 * @desc   : 파일업로드를 수행할 내부 IFRAME 을 생성 및 반환한다.
 * <pre>
 *    cfGetUploadFrame()
 * </pre>
 * @sig    : position
 * @author : 차종호
 */
  function cfGetUploadFrame() {
  		var FRAMEWORK_INLINE_FRAME_FOR_FILE_UPLOAD = "FRAMEWORK_INLINE_FRAME_FOR_FILE_UPLOAD";
 	  var uploadInlineFrame = document.getElementById(FRAMEWORK_INLINE_FRAME_FOR_FILE_UPLOAD) ;
 	  if ( !uploadInlineFrame )  {
 	  	   uploadInlineFrame = document.createElement("<IFRAME MARGINHEIGHT=0 name='" + FRAMEWORK_INLINE_FRAME_FOR_FILE_UPLOAD + "' frameborder='no' scrolling='no' width='0' height='0'></IFRAME>");
        document.body.appendChild(uploadInlineFrame);
 	  }
 	  return  uploadInlineFrame.name  ;
  }

/**
 * @type   : function
 * @access : public
 * @desc   : 파일 업로드 정보 저장에 쓰일 가우스 DataSet 정보를 초기화한다.
 * <pre>
 *    cfInitUploadDataSet()
 * </pre>
 * @sig    : position
 * @author : 차종호
 */
  function cfInitUploadDataSet(){
	   FILE_UPLOAD_DATA_SET_ID.clearData();
	   var DsHeader = "fileId:STRING,fileName:STRING,filePath:STRING,fileSize:INTEGER";
	   FILE_UPLOAD_DATA_SET_ID.SetDataHeader(DsHeader);
	 }
 /**
 * @type   : function
 * @access : public
 * @desc   : 파일 업로드 정보를 가우스 DataSet 에 추가한다.
 * <pre>
 *    cfAddUploadDataSet(fileId , fileName, filePath , fileSize )
 * </pre>
 * @sig    : position
 * @param  : fileId 업로드 대상 파일의 HTML NAME
 * @param  : fileName 업로드된 파일명
 * @param  : filePath 업로드된 파일의 PATH
 * @param  : fileSize 업로드된 파일크기
 * @author : 차종호
 */
  function cfAddUploadDataSet(fileId , fileName, filePath , fileSize ){
	   FILE_UPLOAD_DATA_SET_ID.AddRow();
	   var newRecordIndex = FILE_UPLOAD_DATA_SET_ID.countrow ;
	   FILE_UPLOAD_DATA_SET_ID.NameValue( newRecordIndex, "fileId" ) = fileId ;
	   FILE_UPLOAD_DATA_SET_ID.NameValue( newRecordIndex, "fileName" ) = fileName ;
	   FILE_UPLOAD_DATA_SET_ID.NameValue( newRecordIndex, "filePath" ) = filePath ;
	   FILE_UPLOAD_DATA_SET_ID.NameValue( newRecordIndex, "fileSize" ) = fileSize ;
  }

/* ********************************************************************************
 *                            파일 다운로드 관련 함수
 * *******************************************************************************/

 /**
 * @type   : function
 * @access : public
 * @desc   : 파일 다운로드를 위한 FILE URL 정보를 반환한다.
 * <pre>
 *    cfGetFileURL( fileName , filePath )
 * </pre>
 * @sig    : position
 * @param  : fileName 다운로드할 파일명
 * @param  : filePath 다운로드할 파일의 PATH
 * @author : 차종호
 */
  function cfGetFileURL( fileName , filePath ) {
  	 return "/DFileDownload?FILE_NAME="+fileName+"&FILE_PATH="+filePath;
  }
   /**
 * @type   : function
 * @access : public
 * @desc   : 해당 파일을 다운로드 한다.
 * <pre>
 *    cfDownloadFile( fileName , filePath )
 * </pre>
 * @sig    : position
 * @param  : fileName 다운로드할 파일명
 * @param  : filePath 다운로드할 파일의 PATH
 * @author : 차종호
 */
  function cfDownloadFile(fileName , filePath ) {
   	var FILE_URL = cfGetFileURL( fileName , filePath );
  		var FRAMEWORK_INLINE_FRAME_FOR_FILE_DOWNLOAD = "FRAMEWORK_INLINE_FRAME_FOR_FILE_DOWNLOAD";
 	  var downloadInlineFrame = document.getElementById(FRAMEWORK_INLINE_FRAME_FOR_FILE_DOWNLOAD) ;
 	  if ( !downloadInlineFrame )  {
 	  	   downloadInlineFrame = document.createElement("<IFRAME MARGINHEIGHT=0 name='" + FRAMEWORK_INLINE_FRAME_FOR_FILE_DOWNLOAD + "' src='"+FILE_URL+"' frameborder='no' scrolling='no' width='0' height='0'></IFRAME>");
        document.body.appendChild(downloadInlineFrame);
 	  }  else {
 	  	  downloadInlineFrame.src = FILE_URL ;
 	  }
  }
 function cfTabMenuAdd( fileURL , tabTitle ) {
    top.tabFrame.menu_click(fileURL, tabTitle);
 }

/* ********************************************************************************
 *                              Prototype 함수
 * *******************************************************************************/

/**
 * @type   : prototype_function
 * @access : public
 * @desc   : 자바스크립트의 내장 객체인 String 객체에 simpleReplace 메소드를 추가한다. simpleReplace 메소드는
 *           스트링 내에 있는 특정 스트링을 다른 스트링으로 모두 변환한다. String 객체의 replace 메소드와 동일한
 *           기능을 하지만 간단한 스트링의 치환시에 보다 유용하게 사용할 수 있다.
 * <pre>
 *     var str = "abcde"
 *     str = str.simpleReplace("cd", "xx");
 * </pre>
 * 위의 예에서 str는 "abxxe"가 된다.
 * @sig    : oldStr, newStr
 * @param  : oldStr required 바뀌어야 될 기존의 스트링
 * @param  : newStr required 바뀌어질 새로운 스트링
 * @return : replaced String.
 * @author : 임재현
 */
String.prototype.simpleReplace = function(oldStr, newStr) {
	var rStr = oldStr;

	rStr = rStr.replace(/\\/g, "\\\\");
	rStr = rStr.replace(/\^/g, "\\^");
	rStr = rStr.replace(/\$/g, "\\$");
	rStr = rStr.replace(/\*/g, "\\*");
	rStr = rStr.replace(/\+/g, "\\+");
	rStr = rStr.replace(/\?/g, "\\?");
	rStr = rStr.replace(/\./g, "\\.");
	rStr = rStr.replace(/\(/g, "\\(");
	rStr = rStr.replace(/\)/g, "\\)");
	rStr = rStr.replace(/\|/g, "\\|");
	rStr = rStr.replace(/\,/g, "\\,");
	rStr = rStr.replace(/\{/g, "\\{");
	rStr = rStr.replace(/\}/g, "\\}");
	rStr = rStr.replace(/\[/g, "\\[");
	rStr = rStr.replace(/\]/g, "\\]");
	rStr = rStr.replace(/\-/g, "\\-");

  	var re = new RegExp(rStr, "g");
    return this.replace(re, newStr);
}

// alert("abcde\.()-fgh$$?J+".simpleReplace("\\", ""));

/**
 * @type   : prototype_function
 * @access : public
 * @desc   : 자바스크립트의 내장 객체인 String 객체에 trim 메소드를 추가한다. trim 메소드는 스트링의 앞과 뒤에
 *           있는 white space 를 제거한다.
 * <pre>
 *     var str = " abcde "
 *     str = str.trim();
 * </pre>
 * 위의 예에서 str는 "abede"가 된다.
 * @return : trimed String.
 * @author : 임재현
 */
String.prototype.trim = function() {
    return this.replace(/(^\s*)|(\s*$)/g, "");
}

/**
 * @type   : prototype_function
 * @access : public
 * @desc   : 자바스크립트의 내장 객체인 String 객체에 trimAll 메소드를 추가한다. trim 메소드는 스트링 내에
 *           있는 white space 를 모두 제거한다.
 * <pre>
 *     var str = " abc de "
 *     str = str.trimAll();
 * </pre>
 * 위의 예에서 str는 "abcde"가 된다.
 * @return : trimed String.
 * @author : 임재현
 */
String.prototype.trimAll = function() {
    return this.replace(/\s*/g, "");
}

// alert(" a b  d ".trimAll());

/**
 * @type   : prototype_function
 * @access : public
 * @desc   : 자바스크립트의 내장 객체인 String 객체에 cut 메소드를 추가한다. cut 메소드는 스트링의 특정 영역을
 *           잘라낸다.
 * <pre>
 *     var str = "abcde"
 *     str = str.cut(2, 2);
 * </pre>
 * 위의 예에서 str는 "abe"가 된다.
 * @sig    : start, length
 * @param  : start  required start index to cut
 * @param  : length required length to cut
 * @return : cutted String.
 * @author : 임재현
 */
String.prototype.cut = function(start, length) {
    return this.substring(0, start) + this.substr(start + length);
}

/**
 * @type   : prototype_function
 * @access : public
 * @desc   : 자바스크립트의 내장 객체인 String 객체에 insert 메소드를 추가한다. insert 메소드는 스트링의 특정 영역에
 *           주어진 스트링을 삽입한다.
 * <pre>
 *     var str = "abcde"
 *     str = str.insert(3, "xyz");
 * </pre>
 * 위의 예에서 str는 "abcxyzde"가 된다.
 * @sig    : start, length
 * @param  : index required 삽입할 위치. 해당 스트링의 index 바로 앞에 삽입된다. index는 0부터 시작.
 * @param  : str   required 삽입할 스트링.
 * @return : inserted String.
 * @author : 임재현
 */
String.prototype.insert = function(index, str) {
    return this.substring(0, index) + str + this.substr(index);
}

/**
 * @type   : prototype_function
 * @access : public
 * @desc   : String.split() 와 같지만 여러가지 옵션을 줄 수 있다.
 * <pre>
 *     option list
 *
 *     - i : ignored split
 *         구분자 문자 앞에 "\" 가 붙어있을 때는 구분자로 인식하지 않는다. ('\' 문자를 string으로 표현할 때는 "\\" 로 해야함)
 *             var str = "abc,de\\,fg"
 *             var strArr = str.advancedSplit(",", "i");
 *         위의 예에서 strArr[0]는 "abc", strArr[1]는 "de,fg"가 된다.
 *
 *     - t : trimed split
 *         split 후에 splited string 들을 trim 시킨다.
 *             var str = "abc,  de,fg"
 *             var strArr = str.advancedSplit(",", "t");
 *         위의 예에서 strArr[0]는 "abc", strArr[1]는 "de", strArr[2]는 "fg"가 된다.
 * </pre>
 * 옵션들은 복합적으로 사용될 수 있다.
 * <pre>
 *     var str = "abc,  de\\,fg"
 *     var strArr = str.advancedSplit(",", "it");
 * </pre>
 * 위의 예에서 strArr[0]는 "abc", strArr[1]는 "de,fg"가 된다.
 * @sig    : delim, options
 * @param  : delim   required delimenator
 * @param  : options required 옵션을 나타내는 문자들을 나열한 스트링
 * @return : splited string array.
 * @author : 임재현
 */
String.prototype.advancedSplit = function(delim, options) {
	if (options == null || options.trim() == "") {
		return this.split(delim);
	}

	var optionI = false;
	var optionT = false;

	options = options.trim().toUpperCase();

	for (var i = 0; i < options.length; i++) {
		if (options.charAt(i) == 'I') {
			optionI = true;
		} else if (options.charAt(i) == 'T') {
			optionT = true;
		}
	}

	var arr = new Array();
	var cnt = 0;
	var startIdx = 0;
	var delimIdx = -1;
	var str = this;
	var temp = 0;

	while ( (delimIdx = (str == null) ?
	         -1 : str.indexOf(delim, startIdx)
	        ) != -1
	      ) {

		if (optionI && str.substr(delimIdx - 1, 2) == '\\' + delim) {
			str = str.cut(delimIdx - 1, 1);
			startIdx = delimIdx;
			continue;
		}

		arr[cnt++] = optionT ? str.substring(0, delimIdx).trim() :
		                       str.substring(0, delimIdx);
		str = str.substr(delimIdx + 1);
		startIdx = 0;
	}

	arr[cnt] = (str == null) ? "" : str;

	return arr;
}

/*
var splitTestStr = "abc  , de\\,  fg , f d".advancedSplit(",", "it");
for (var i = 0; i < splitTestStr.length; i++) {
	alert("'" + splitTestStr[i] + "'");
}
*/

/**
 * @type   : prototype_function
 * @access : public
 * @desc   : 자바스크립트의 내장 객체인 String 객체에 toDate 메소드를 추가한다. toDate 메소드는 날짜를 표현하는
 *           스트링 값을 자바스크립트의 내장 객체인 Date 객체로 변환한다.
 * <pre>
 *     var date = "2002-03-05".toDate("YYYY-MM-DD")
 * </pre>
 * 위의 예에서 date 변수는 실제로 2002년 3월 5일을 표현하는 Date 오브젝트를 가르킨다.
 * @sig    : [pattern]
 * @param  : pattern optional Date를 표현하고 있는 현재의 String을 pattern으로 표현한다. (default : YYYYMMDD)
 * <pre>
 *     # syntex
 *
 *       YYYY : year(4자리)
 *       YY   : year(2자리)
 *       MM   : month in year(number)
 *       DD   : day in month
 *       HH   : hour in day (0~23)
 *       mm   : minute in hour
 *       ss   : second in minute
 *       SS   : millisecond in second
 *
 *     <font color=red>주의)</font> YYYY(YY)는 반드시 있어야 한다. YYYY(YY) 만 사용할 경우는 1월 1일을 기준으로
 *     하고 YYYY와 MM 만사용할 경우는 1일을 기준으로 한다.
 * </pre>
 * @return : 변환된 Date Object.
 * @author : 임재현
 */
String.prototype.toDate = function(pattern) {
	var index = -1;
	var year;
	var month;
	var day;
	var hour = 0;
	var min  = 0;
	var sec  = 0;
	var ms   = 0;
	var newDate;

	if (pattern == null) {
		pattern = "YYYYMMDD";
	}

	if ((index = pattern.indexOf("YYYY")) == -1 ) {
		index = pattern.indexOf("YY");
		year = "20" + this.substr(index, 2);
	} else {
		year = this.substr(index, 4);
	}

	if ((index = pattern.indexOf("MM")) != -1 ) {
		month = this.substr(index, 2);
	} else {
		month = 1;
	}

	if ((index = pattern.indexOf("DD")) != -1 ) {
		day = this.substr(index, 2);
	} else {
		day = 1;
	}

	if ((index = pattern.indexOf("HH")) != -1 ) {
		hour = this.substr(index, 2);
	}

	if ((index = pattern.indexOf("mm")) != -1 ) {
		min = this.substr(index, 2);
	}

	if ((index = pattern.indexOf("ss")) != -1 ) {
		sec = this.substr(index, 2);
	}

	if ((index = pattern.indexOf("SS")) != -1 ) {
		ms = this.substr(index, 2);
	}

	newDate = new Date(year, month - 1, day, hour, min, sec, ms);
	if (month > 12) {
		newDate.setFullYear(year + 1);
	} else {
		newDate.setFullYear(year);
	}

	return newDate;
}

/**
 * @type   : prototype_function
 * @object : Date
 * @access : public
 * @desc   : 자바스크립트의 내장 객체인 Date 객체에 format 메소드를 추가한다. format 메소드는 Date 객체가 가진 날짜를
 *           지정된 포멧의 스트링으로 변환한다.
 * <pre>
 *     var dateStr = new Date().format("YYYYMMDD");
 *
 *     참고 : Date 오브젝트 생성자들 - dateObj = new Date()
 *                                   - dateObj = new Date(dateVal)
 *                                   - dateObj = new Date(year, month, date[, hours[, minutes[, seconds[,ms]]]])
 * </pre>
 * 위의 예에서 오늘날짜가 2002년 3월 5일이라면 dateStr의 값은 "20020305"가 된다.
 * default pattern은 "YYYYMMDD"이다.
 * @sig    : [pattern]
 * @param  : pattern optional 변환하고자 하는 패턴 스트링. (default : YYYYMMDD)
 * <pre>
 *     # syntex
 *
 *       YYYY : hour in am/pm (1~12)
 *       MM   : month in year(number)
 *       MON  : month in year(text)  예) "January"
 *       mon  : short month in year(text)  예) "Jan"
 *       DD   : day in month
 *       DAY  : day in week  예) "Sunday"
 *       day  : short day in week  예) "Sun"
 *       hh   : hour in am/pm (1~12)
 *       HH   : hour in day (0~23)
 *       mm   : minute in hour
 *       ss   : second in minute
 *       SS   : millisecond in second
 *       a    : am/pm  예) "AM"
 * </pre>
 * @return : Date를 표현하는 변환된 String.
 * @author : 임재현
 */
Date.prototype.format = function(pattern) {
    var year      = this.getFullYear();
    var month     = this.getMonth() + 1;
    var day       = this.getDate();
    var dayInWeek = this.getDay();
    var hour24    = this.getHours();
    var ampm      = (hour24 < 12) ? "AM" : "PM";
    var hour12    = (hour24 > 12) ? (hour24 - 12) : hour24;
    var min       = this.getMinutes();
    var sec       = this.getSeconds();

    var YYYY = "" + year;
    var YY   = YYYY.substr(2);
    var MM   = (("" + month).length == 1) ? "0" + month : "" + month;
    var MON  = GLB_MONTH_IN_YEAR[month-1];
    var mon  = GLB_SHORT_MONTH_IN_YEAR[month-1];
    var DD   = (("" + day).length == 1) ? "0" + day : "" + day;
    var DAY  = GLB_DAY_IN_WEEK[dayInWeek];
    var day  = GLB_SHORT_DAY_IN_WEEK[dayInWeek];
    var HH   = (("" + hour24).length == 1) ? "0" + hour24 : "" + hour24;
    var hh   = (("" + hour12).length == 1) ? "0" + hour12 : "" + hour12;
    var mm   = (("" + min).length == 1) ? "0" + min : "" + min;
    var ss   = (("" + sec).length == 1) ? "0" + sec : "" + sec;
    var SS   = "" + this.getMilliseconds();

    var dateStr;
    var index = -1;

    if (typeof(pattern) == "undefined") {
    	dateStr = "YYYYMMDD";
    } else {
    	dateStr = pattern;
    }

	dateStr = dateStr.replace(/YYYY/g, YYYY);
	dateStr = dateStr.replace(/YY/g,   YY);
	dateStr = dateStr.replace(/MM/g,   MM);
	dateStr = dateStr.replace(/MON/g,  MON);
	dateStr = dateStr.replace(/mon/g,  mon);
	dateStr = dateStr.replace(/DD/g,   DD);
	dateStr = dateStr.replace(/DAY/g,  DAY);
	dateStr = dateStr.replace(/day/g,  day);
	dateStr = dateStr.replace(/hh/g,   hh);
	dateStr = dateStr.replace(/HH/g,   HH);
	dateStr = dateStr.replace(/mm/g,   mm);
	dateStr = dateStr.replace(/ss/g,   ss);
	dateStr = dateStr.replace(/(\s+)a/g, "$1" + ampm);

	return dateStr;
}

/**
 * @type   : prototype_function
 * @object : Date
 * @access : public
 * @desc   : 현재 Date 객체의 날짜보다 이후날짜를 가진 Date 객체를 리턴한다.
 *           예를 들어 내일 날짜를 얻으려면 다음과 같이 하면 된다.
 * <pre>
 *     var oneDayAfter = new Date.after(0, 0, 1);
 * </pre>
 * @sig    : [years[, months[, dates[, hours[, minutes[, seconds[, mss]]]]]]]
 * @param  : years   optional 이후 년수
 * @param  : months  optional 이후 월수
 * @param  : dates   optional 이후 일수
 * @param  : hours   optional 이후 시간수
 * @param  : minutes optional 이후 분수
 * @param  : seconds optional 이후 초수
 * @param  : mss     optional 이후 밀리초수
 * @return : 이후날짜를 표현하는 Date 객체
 * @author : 임재현
 */
Date.prototype.after = function(years, months, dates, hours, miniutes, seconds, mss) {
    if (years == null)    years    = 0;
    if (months == null)   months   = 0;
    if (dates == null)    dates    = 0;
    if (hours == null)    hours    = 0;
    if (miniutes == null) miniutes = 0;
    if (seconds == null)  seconds  = 0;
    if (mss == null)      mss      = 0;

	return new Date(this.getFullYear() + years,
	                this.getMonth() + months,
	                this.getDate() + dates,
	                this.getHours() + hours,
	                this.getMinutes() + miniutes,
	                this.getSeconds() + seconds,
	                this.getMilliseconds() + mss
	               );
}
// alert(new Date().after(1, 1, 1, 1, 1, 1).format("YYYYMMDD HHmmss"));

/**
 * @type   : prototype_function
 * @object : Date
 * @access : public
 * @desc   : 현재 Date 객체의 날짜보다 이전날짜를 가진 Date 객체를 리턴한다.
 *           예를 들어 어제 날짜를 얻으려면 다음과 같이 하면 된다.
 * <pre>
 *     var oneDayBefore = new Date.before(0, 0, 1);
 * </pre>
 * @sig    : [years[, months[, dates[, hours[, minutes[, seconds[, mss]]]]]]]
 * @param  : years   optional 이전으로 돌아갈 년수
 * @param  : months  optional 이전으로 돌아갈 월수
 * @param  : dates   optional 이전으로 돌아갈 일수
 * @param  : hours   optional 이전으로 돌아갈 시간수
 * @param  : minutes optional 이전으로 돌아갈 분수
 * @param  : seconds optional 이전으로 돌아갈 초수
 * @param  : mss     optional 이전으로 돌아갈 밀리초수
 * @return : 이전날짜를 표현하는 Date 객체
 * @author : 임재현
 */
Date.prototype.before = function(years, months, dates, hours, miniutes, seconds, mss) {
    if (years == null)    years    = 0;
    if (months == null)   months   = 0;
    if (dates == null)    dates    = 0;
    if (hours == null)    hours    = 0;
    if (miniutes == null) miniutes = 0;
    if (seconds == null)  seconds  = 0;
    if (mss == null)      mss      = 0;

	return new Date(this.getFullYear() - years,
	                this.getMonth() - months,
	                this.getDate() - dates,
	                this.getHours() - hours,
	                this.getMinutes() - miniutes,
	                this.getSeconds() - seconds,
	                this.getMilliseconds() - mss
	               );
}
//alert(new Date().before(1, 1, 1, 1, 1, 1).format("YYYYMMDD HHmmss"));

/**
 * @type   : function
 * @access : public
 * @desc   : 공통메세지에 정의된 메세지를 alert box로 보여준 후 리턴한다. cfGetMsg 참조.
 * @sig    : msgId[, paramArray]
 * @param  : msgId required lafui.js의 공통 메세지 영역에 선언된 메세지 ID
 * @param  : paramArray optional 메세지에서 '@' 문자와 치환될 데이터 Array. Array의 index와 메세지 내의 '@' 문자의 순서가 일치한다.
             치환될 데이터는 [] 사이에 콤마를 구분자로 하여 기술하면 Array 로 인식된다.
 * @return : 치환된 메세지 스트링
 * @author : 임재현
 */
function cfAlertMsg(msgId, paramArray) {
	if (cfIsNull(msgId)) {
		alert("존재하지 않는 메시지입니다.");
		return null;
	}

	var msg = new coMessage().getMsg(msgId, paramArray);
	alert(msg);
	return msg;
}

/**
 * @type   : function
 * @access : public
 * @desc   : 필드에 최대 자릿수를 입력한 후 지정된 다른 필드로 포커스가 자동으로 이동된다.<br>
 *           html의 <Input type="text"> 와 가우스 EMEdit에서 사용가능하다. <Input type="text"> 의 경우
 *           maxLength 속성이 지정되어 있어야 하며 EMEdit의 경우 MaxLength와 Format 속성중 하나가 반드시
 *           기술되어야 한다.<br>
 *           byte length(한글)은 지원하지 않는다.<br>
 *           오브젝트 선언시 onkeydown 이벤트에 다음과 같이 기술해 주어야만 한다.
 * <pre>
 *     주민번호
 *     &lt;input id="oSsn1" type="text" size="6" maxLength="6" onkeydown="cfAutoFocusNext(this, oSsn2)"&gt;-
 *     &lt;input id="oSsn2" type="text" size="7" maxLength="7"&gt;
 * </pre>
 * @sig    : oElement, oNextElement
 * @param  : oElement required 현재 입력필드
 * @param  : oNextElement required 자동으로 포커스가 이동될 필드
 * @author : 임재현
 */
/*
function cfAutoFocusNext(oElement, oNextElement) {
	if (event.keyCode == 8 ||   // backspace
	    event.keyCode == 37 ||  // left key
	    event.keyCode == 38 ||  // up key
	    event.keyCode == 39 ||  // right key
	    event.keyCode == 40 ||  // down key
	    event.keyCode == 46     // delete key
	   ) {
	   	return;
	}

	var value;
	var maxLength = 0;

	switch (cfGetElementType(oElement)) {
		case "TEXT" :
			value = oElement.value;
			maxLength = oElement.maxLength;

			if (value.length + 1 == maxLength) {
				oElement.value = oElement.value + String.fromCharCode(event.keyCode);
				event.returnValue = false;
				oNextElement.focus();
			}

			break;
		case "GE" :
			value = oElement.Text;

			if (cfIsNull(oElement.Format)) {
				maxLength = oElement.MaxLength;
			} else {
				for (var i = 0; i < oElement.Format.length; i++) {
					if (cfIsIn(oElement.Format.charAt(i), ['#', 'A', 'Z', '0', '9', 'Y', 'M', 'D'])) {
						maxLength++;
					}
				}
			}

			if (value.length + 1 == maxLength) {
				oElement.Text = oElement.Text + String.fromCharCode(event.keyCode);
				event.returnValue = false;
				oNextElement.focus();
			}

			break;
		default :
			return;
	}
}
*/

/**
 * @type   : function
 * @access : public
 * @desc   : 필드에 최대 자릿수를 입력한 후 지정된 다른 필드로 포커스가 자동으로 이동된다.<br>
 *           html의 <Input type="text"> 와 가우스 EMEdit에서 사용가능하다. <Input type="text"> 의 경우
 *           maxLength 속성이 지정되어 있어야 하며 EMEdit의 경우 MaxLength와 Format 속성중 하나가 반드시
 *           기술되어야 한다.<br>
 *           byte length(한글)은 지원하지 않는다.<br>
 *           오브젝트 선언시 onkeydown 이벤트에 다음과 같이 기술해 주어야만 한다.
 * <pre>
 *     주민번호
 *     &lt;input id="oSsn1" type="text" size="6" maxLength="6" onkeydown="cfAutoFocusNext(this, oSsn2)"&gt;-
 *     &lt;input id="oSsn2" type="text" size="7" maxLength="7"&gt;
 * </pre>
 * @sig    : oElement, oNextElement
 * @param  : oElement required 현재 입력필드
 * @param  : oNextElement required 자동으로 포커스가 이동될 필드
 * @author : 임재현
 */
/*
function cfAutoFocusBefore(oElement, oBeforeElement) {
	if (event.keyCode != 8) {
	   	return;
	}

	var value;

	switch (cfGetElementType(oElement)) {
		case "TEXT" :
			value = oElement.value;
			break;
		case "GE" :
			value = oElement.Text;
			break;
		default :
			return;
	}

	if (value.length == 1) {
		oElement.value = "";
		event.returnValue = false;
		oBeforeElement.focus();
	}
}
*/

/**
 * @type   : function
 * @access : public
 * @desc   : 화면명을 만들어주는 함수
 * @sig    : title, pageId[, features]
 * @param  : title  required 화면명
 * @param  : pageId required 도움말을 위한 화면 id. 화면의 파일명에서 ".html"을 제외한 스트링을 주면 된다. 이 파라미터는
 *                    차후 도움말을 띄우기 위한 파라미터로써 현재 도움말에 대해서는 정의된 것이 없음.
 * @param  : features optional 기타 속성을 정의하는 스트링. 속성종류는 아래와 같다.
 * <pre>
 *     windowType : 현재창의 형태 (0:기본창, 1:팝업창, 2:다이얼로그창). (default:0)
 *     width      : 화면 영역의 width. (default:638)
 *     height     : 화면 영역의 height. (default:500)
 *     showHelp   : 도움말버튼을 보여줄지 여부. (default:yes)<br>
 *     사용예) "width=300,height=300,showHelp=no"
 * </pre>
 * @author : 임재현
 */
 // ssoHelpPage 파라미터 추가 sso도움말.
function cfBuildBodyTitle(title, pageId, features, ssoHelpPage) {
	var featureNames  = ["windowType", "width", "height", "showHelp"];
	var featureValues = [0, 636, 498, true];
	var featureTypes  = ["number", "number", "number", "boolean"];

	if (features != null) {
		cfParseFeature(features, featureNames, featureValues, featureTypes);
	}

	var windowType  = featureValues[0];
	var width       = featureValues[1];
	var height      = featureValues[2];
	var showHelp    = featureValues[3];

	var marginTop    = 10;
	var marginLeft   = 10;
	var marginRight  = 18;
	var marginBottom = 8;

	var rightSizeBarLeft = width - marginRight;
	var bottomSizeBarTop = height - marginBottom;
	var helpWindowWidth = 620;
	var helpWindowHeight = 500;

	var sysCd = cfGetSysCdFromPageId(pageId);
	var subCd = pageId.substr(1, 2);
	var fncCd = pageId.substr(3, 3);

	if (ssoHelpPage == null)
	{
		var helpLink = "onclick=\"window.open('/" + sysCd + "/help/" + subCd + "/" + fncCd + "/help_" + pageId + ".html', 'helpWindow', " +
		               "'left=" + ((screen.availWidth - helpWindowWidth) / 2 - 7) + ",top=" + (screen.availHeight - helpWindowHeight) / 2 +
			           ",height=" + helpWindowHeight + ",width=" + helpWindowWidth + ",status=no,toolbar=no,menubar=no,location=no,scrollbars=yes')\"";
	} else {


		var helpLink = "onclick=\"window.open('/sso/dmshelps/help_" + pageId + ".html', 'helpWindow', " +
		               "'left=" + ((screen.availWidth - helpWindowWidth) / 2 - 7) + ",top=" + (screen.availHeight - helpWindowHeight) / 2 +
			           ",height=" + helpWindowHeight + ",width=" + helpWindowWidth + ",status=no,toolbar=no,menubar=no,location=no,scrollbars=yes')\"";
	}
	var helpAreaLeft = width - 72;
	var helpArea = "<img src='" + GLB_URL_COMMON_PAGE + "images/bullet_help.gif' style='cursor:hand;' hideFocus='true' border='0' " + helpLink + ">" +
	               "<span class='txtHelp' style='cursor:hand;' " + helpLink + ">도움말</span>";

	document.write("<div style='position:absolute; left:" + marginLeft + "; top:" + marginTop + "; '><img src='" + GLB_URL_COMMON_PAGE + "images/bullet_bodytitle.gif'><font class='txtTitleBody'>" + title + "</font></div>");

	// 도움말 버튼 작성
	if (showHelp) {
		if (windowType == 1) {
			document.write("<div style='width:52; position:absolute; left:" + (helpAreaLeft + 10) + "; top:" + marginTop + ";'>" + helpArea + "</div>");
		} else if (windowType == 2) {
			document.write("<div style='width:52; position:absolute; left:" + (helpAreaLeft + 4) + "; top:" + marginTop + ";'>" + helpArea + "</div>");
		} else {
			document.write("<div style='width:52; position:absolute; left:" + helpAreaLeft + "; top:" + marginTop + ";'>" + helpArea + "</div>");
		}
	}

	// 이 부분은 화면 여백과 사이즈를 표시하기 위한 부분으로 설계가 끝난 후 삭제 예정.
/*
	document.write("<table cellspacing='0' cellpadding='0' style='position:absolute; left:0; top:0;'><tr><td width='" + width + "' height='" + marginTop + "' bgcolor='#D6D6D6'></td></tr></table>");

	if (windowType == 1) {
		document.write("<table cellspacing='0' cellpadding='0' style='position:absolute; left:0; top:0;'><tr><td nowrap width='" + width + "' height='" + marginTop + "' bgcolor='#D6D6D6'></td></tr></table>");  // 북
		document.write("<div style='position:absolute; left:" + (rightSizeBarLeft + 10) + "; top:0;   width:" + (marginRight - 8) + ";  height:" + height + "; background-color:#D6D6D6;'></div>");               // 동
		document.write("<table cellspacing='0' cellpadding='0' style='position:absolute; left:0; top:" + bottomSizeBarTop + ";'><tr><td nowrap width='" + width + "' height='" + marginBottom + "' bgcolor='#D6D6D6'></td></tr></table>");  // 남
		document.write("<div style='position:absolute; left:0;   top:0;   width:" + marginLeft + ";  height:" + height + "; background-color:#D6D6D6;'></div>"); // 서

	} else if (windowType == 2) {
		document.write("<table cellspacing='0' cellpadding='0' style='position:absolute; left:0; top:0;'><tr><td nowrap width='" + (width - 6) + "' height='" + marginTop + "' bgcolor='#D6D6D6'></td></tr></table>");
		document.write("<div style='position:absolute; left:" + (rightSizeBarLeft + 4) + "; top:0;   width:" + (marginRight - 8) + ";  height:" + (height - 25) + "; background-color:#D6D6D6;'></div>");
		document.write("<table cellspacing='0' cellpadding='0' style='position:absolute; left:0; top:" + (bottomSizeBarTop - 25) + ";'><tr><td nowrap width='" + (width - 6) + "' height='" + marginBottom + "' bgcolor='#D6D6D6'></td></tr></table>");
		document.write("<div style='position:absolute; left:0;   top:0;   width:" + marginLeft + ";  height:" + (height - 25) + "; background-color:#D6D6D6;'></div>");

	} else {
		document.write("<table cellspacing='0' cellpadding='0' style='position:absolute; left:0; top:0;'><tr><td nowrap width='" + width + "' height='" + marginTop + "' bgcolor='#D6D6D6'></td></tr></table>");
		document.write("<div style='position:absolute; left:" + rightSizeBarLeft + "; top:0;   width:" + marginRight + ";  height:" + (height-5) + "; background-color:#D6D6D6;'></div>");
		document.write("<table cellspacing='0' cellpadding='0' style='position:absolute; left:0; top:" + bottomSizeBarTop + ";'><tr><td nowrap width='" + width + "' height='" + marginBottom + "' bgcolor='#D6D6D6'></td></tr></table>");
		document.write("<div style='position:absolute; left:0;   top:0;   width:" + marginLeft + ";  height:" + height + "; background-color:#D6D6D6;'></div>");
	}
*/

}

/**
 * @type   : function
 * @access : private
 * @desc   : 화면의 페이지 id로부터 시스템 코드 세자리를 알려준다.
 * @sig    : pageId
 * @param  : pageId required 페이지 id. 업무화면의 파일명에서 확장자를 제외한 파일명과 동일.
 * @author : 임재현
 */
function cfGetSysCdFromPageId(pageId) {
	switch (pageId.substr(0, 3)) {
		case "cgu" : return "cms"; break; case "cgv" : return "cms"; break;
		case "chg" : return "cms"; break; case "cju" : return "cms"; break;
		case "cjw" : return "cms"; break; case "ckj" : return "cms"; break;
		case "ctg" : return "cms"; break;

		case "ibn" : return "ici"; break; case "icm" : return "ici"; break;
		case "iom" : return "ici"; break; case "ipm" : return "ici"; break;

		case "iam" : return "iim"; break; case "idm" : return "iim"; break;
		case "ism" : return "iim"; break;

		case "obm" : return "oom"; break; case "ocs" : return "oom"; break;
		case "oor" : return "oom"; break; case "oos" : return "oom"; break;
		case "oqr" : return "oom"; break; case "oqs" : return "oom"; break;
		case "ovs" : return "oom"; break;

		case "obv" : return "oop"; break; case "oep" : return "oop"; break;
		case "omp" : return "oop"; break;

		case "rcc" : return "rrw"; break; case "rct" : return "rrw"; break;
		case "rnh" : return "rrw"; break; case "rrw" : return "rrw"; break;
		case "rst" : return "rrw"; break;

		case "rcl" : return "rsm"; break; case "rfd" : return "rsm"; break;
		case "rrd" : return "rsm"; break; case "rsl" : return "rsm"; break;

		case "sam" : return "sam"; break;
		case "tip" : return "tip"; break;
		case "trm" : return "trm"; break;
		case "ttm" : return "ttm"; break;
		case "ttr" : return "ttr"; break;
	}

	return null;
}

/**
 * @type   : function
 * @access : private
 * @desc   : 보고서 출력시에 첫페이와 마지막 페이지를 검색한다.
 * @sig    : oGDS, DataId, startPageNo, endPageNo
 * @param  : oGDS     - body내에 div 태그로 선언된 Header 영역 element
 * @param  : param    - 페이지를 읽어오기위한 검색조건. Grid의 DataSet의 첫번째 row의 param 컬럼에 있음.
 * @param  : startpageinfo   - 시작페이지 emedit object name
 * @param  : endageinfo      - 마지막페이지 emedit object name
 * @author : 조부구
 */
function cfChangeDataId(oGDS, DataId, startPageNo, endPageNo) {

	startPageNo = startPageNo.text;
	endPageNo   = endPageNo.text;

	//입력페이지정보에 대하여 error체크한다.
	pageperiod = endPageNo - startPageNo;

	if (pageperiod < 0 ){
		cfAlertMsg(MSG_COM_ERR_034);
		return -1;
	}
	else if (pageperiod >= GLB_REPORT_MAXPAGE){
		alert(GLB_REPORT_MAXPAGE +" 페이지 이상은 출력할 수 없습니다");
		return -1;
	}
	else if(page_cnt.innerText < endPageNo ){
		cfAlertMsg(MSG_COM_ERR_034);
		return -1;
	}

	var paramArray = DataId.split("&");
	var newDataId  = "";

	for (var i = 1; i < paramArray.length; i++) {
		if (paramArray[i].substr(0, 11) == "startPageNo") {
			paramArray[i] = "startPageNo=" + startPageNo;
		}
		if (paramArray[i].substr(0, 9) == "endPageNo") {
			paramArray[i] = "endPageNo=" + endPageNo;
		}
		newDataId = newDataId + "&" + paramArray[i];
	}

	newDataId = paramArray[0] + newDataId;
	oGDS.DataId = newDataId;
	oGDS.Reset();

}

/**
 * @type   : function
 * @access : private
 * @desc   : cfFillGridHeader에서 사용하는 함수. 해당 페이지의 데이터를 요청한다.
 * @sig    : oDataSet, action, parameter, pageNo
 * @param  : oDataSet  required body내에 div 태그로 선언된 Header 영역 element
 * @param  : action    required Grid의 DataId에 선언된 DataSet 오브젝트를 Reset()하기 위한 서블릿과 Command클래스.
 * @param  : parameter required 페이지를 읽어오기위한 검색조건. Grid의 DataSet의 첫번째 row의 param 컬럼에 있음.
 * @param  : pageNo    required 보여줄 페이지 번호
 * @author : 임재현
 */
function cfChangePage(oGridHeader, action, parameter, pageNo, confirmChangePage) {
	var oDataSet = document.all(document.all(oGridHeader.gridId).DataId);
	var oTR      = (oGridHeader.trId == null) ? null : document.all(oGridHeader.trId);

	if (oDataSet.isUpdated && !cfConfirmMsg(MSG_COM_CRM_005)) {
		return;
	}

	var paramArray = parameter.split("&");
	var newParameter = "";

	for (var i = 1; i < paramArray.length; i++) {
		if (paramArray[i].substr(0, 6) == "pageNo") {
			paramArray[i] = "pageNo=" + pageNo;
		}

		newParameter = newParameter + "&" + paramArray[i];
	}

	if (cfIsNull(oTR)) {
		oDataSet.DataId = action + newParameter;
		oDataSet.Reset();
	} else {
		oTR.Action = action + newParameter;
		oTR.Post();
	}
}

/**
 * @type   : function
 * @access : private
 * @desc   : cfFillGridHeader에서 사용하는 함수. 해당 페이지의 데이터를 요청한다. startpageno/endpageno로 데이터 reset처리
 * @sig    : oDataSet, action, parameter, pageNo
 * @param  : oDataSet  required body내에 div 태그로 선언된 Header 영역 element
 * @param  : action    required Grid의 DataId에 선언된 DataSet 오브젝트를 Reset()하기 위한 서블릿과 Command클래스.
 * @param  : parameter required 페이지를 읽어오기위한 검색조건. Grid의 DataSet의 첫번째 row의 param 컬럼에 있음.
 * @param  : startPageNo - 시작 페이지 번호
 * @author : 조부구
 */

 function cfChangePagePeriod(oDataSet, action, parameter, startPageNo, confirmChangePage) {
	if (oDataSet.isUpdated && !cfConfirmMsg(MSG_CONFIRM_CONTINUE_WITHOUT_APPLY)) {
		return;
	}

	var paramArray = parameter.split("&");
	var newParameter = "";

	for (var i = 1; i < paramArray.length; i++) {
		if (paramArray[i].substr(0, 11) == "startPageNo") {
			paramArray[i] = "startPageNo=" + startPageNo;
		}
		if (paramArray[i].substr(0, 9) == "endPageNo") {
			paramArray[i] = "endPageNo=" + startPageNo;
		}

		newParameter = newParameter + "&" + paramArray[i];
	}

	oDataSet.DataId = action + newParameter;
	oDataSet.Reset();
}

/**
 * @type   : function
 * @access : public
 * @desc   : 공통메세지에 정의된 메세지를 confirm box로 보여준 후 리턴한다. cfGetMsg 참조.
 * @sig    : msgId[, paramArray]
 * @param  : msgId      required lafui.js의 공통 메세지 영역에 선언된 메세지 ID
 * @param  : paramArray optional 메세지에서 '@' 문자와 치환될 스트링 Array. (Array의 index와
 *           메세지 내의 '@' 문자의 순서가 일치한다.)
 * @return : 치환된 메세지 스트링
 * @author : 임재현
 */
function cfConfirmMsg(msgId, paramArray) {
	if (cfIsNull(msgId)) {
		alert("존재하지 않는 메시지입니다.");
		return null;
	}

	return confirm(new coMessage().getMsg(msgId, paramArray));
}

/**
 * @type   : function
 * @access : public
 * @desc   : 가우스의 데이터셋 오브젝트 간에 데이터를 복사한다. 복사대상이 되는 데이터셋의 기존의 데이터는 모두 삭제된다.
 *           features 파라미터에서 copyHeader를 yes로 할 경우 DataSet의 컬럼정보까지 복사된다.
 * <pre>
 *    cfCopyDataSet(oDelivRsltOriginGDS, oDelivRsltCopiedGDS, "copyHeader=no");
 * </pre>
 * @sig    : oOriginDataSet, oTargetDataSet[, features]
 * @param  : oOriginDataSet required 원본 DataSet
 * @param  : oTargetDataSet required 복사되어질 DataSet
 * @param  : features       optional 기타 속성을 정의하는 스트링. 속성종류는 아래와 같다.
 * <pre>
 *     copyHeader  : Header를 복사할지 여부. (default:yes)
 *     resetStatus : 복사된 DataSet의 Status를 reset 할 지 여부. (default:yes)
 *     rowFrom     : 복사할 row의 시작 index. (default:1)
 *     rowCnt      : 복사할 row의 갯수 index. (default:DataSet.CountRow 의 값)
 *     사용예) "copyHeader=yes,rowFrom=1,rowCnt=2"  -> 1번 row 부터 3번 row까지 Header와 함께 복사함.
 * </pre>
 * @author : 임재현
 */
function cfCopyDataSet(oOriginDataSet, oTargetDataSet, features) {
	var featureNames  = ["copyHeader", "resetStatus", "rowFrom", "rowCnt"];
	var featureValues = [true, true, 1, oOriginDataSet.CountRow];
	var featureTypes  = ["boolean", "boolean", "number", "number"];

	if (features != null) {
		cfParseFeature(features, featureNames, featureValues, featureTypes);
	}

	var copyHeader  = featureValues[0];
	var resetStatus = featureValues[1];
	var rowFrom     = featureValues[2];
	var rowCnt      = featureValues[3];

	//if (copyHeader == true) {
	//	cfCopyDataSetHeader(oOriginDataSet, oTargetDataSet);
	//}
	
	if (oTargetDataSet.CountRow == 0) {
		cfCopyDataSetHeader(oOriginDataSet, oTargetDataSet);
	}

	//oTargetDataSet.ClearData();
	if (oOriginDataSet.CountRow > 0) {
		var temp = oTargetDataSet.dataid;  // importdata를 한 후 DataSet의 기존의 dataid 속성값이 지워지는 것을 방지.
		oTargetDataSet.ImportData(oOriginDataSet.ExportData(rowFrom, rowCnt, true));
		oTargetDataSet.dataid = temp;

		if (resetStatus == true) {
			oTargetDataSet.ResetStatus();
		}
	}
}

/**
 * @type   : function
 * @access : public
 * @desc   : 가우스의 데이터셋 오브젝트 간에 컬럼 헤더 정보를 복사한다.
 * <pre>
 *    cfCopyDataSet(oDelivRsltOriginGDS, oDelivRsltCopiedGDS);
 * </pre>
 * @sig    : oOriginDataSet, oTargetDataSet
 * @param  : oOriginDataSet required 원본 DataSet
 * @param  : oTargetDataSet required 복사되어질 DataSet
 * @author : 조부구
 */
function cfCopyDataSetHeader(oOriginDataSet, oTargetDataSet) {
	var DsHeader = "";
	var colId   = "";
	var colType = "";
	var colProp = "";
	var colSize = ""

	for (var i = 1; i <= oOriginDataSet.CountColumn; i++) {
 		colId   = oOriginDataSet.ColumnID(i);	     //column id
		colIndex= oOriginDataSet.ColumnIndex(colId);  //column id에 해당하는 index값
		colSize = oOriginDataSet.ColumnSize(colIndex);//column size

		/* column의 type 정의 코드

			Type  Description
			-----------------
			 1    String
			 2    Integer
			 3    Decimal
			 4    Date
			 5    URL
		*/

		//column type정의
		switch (oOriginDataSet.ColumnType(colIndex)){
		     case 1 :
		              colType = 'String';
		              break;
		     case 2 :
		              colType = 'Integer';
		              break;
		     case 3 :
		              colType = 'Decimal';
		              break;
		     case 4 :
		              colType = 'Date';
		              break;
		     case 5 :
		              colType = 'URL';
		              break;

		     default :
		              colType = "";
		              break;
		}

		/* column의 property 정의
			0 : Normal (Key = No)
			1 : Constant
			2 : Key (Normal, Sequence)
			3 : Sequence (Key = No) // 현재 의미없음.
		*/
		switch (oOriginDataSet.ColumnProp(i)) {
		     case 0 :
		              colProp = "NORMAL";
		              break;
		     case 1 :
		              colProp = "CONSTANT";
		              break;
		     case 2 :
		              colProp = "KEYVALUE";
		              break;
		     default :
		              colProp = "";
		              break;
		}

		//column id,column type,column size, column property
		DsHeader = DsHeader + colId + ":" + colType + "(" + colSize + ")" + ":" + colProp + ",";
	}

	DsHeader = DsHeader.substr(0, DsHeader.length - 1);
	oTargetDataSet.SetDataHeader(DsHeader);
}

/**
 * @type   : function
 * @access : public
 * @desc   : 가우스의 데이터셋 오브젝트 간에 키 컬럼의 헤더 정보만을 복사한다.
 * <pre>
 *    cfCopyDataSetKeyHeader(oDelivRsltOriginGDS, oDelivRsltCopiedGDS, ["grpCd", "cd"]);
 * </pre>
 * @sig    : oOriginDataSet, oTargetDataSet
 * @param  : oOriginDataSet required 원본 DataSet
 * @param  : oTargetDataSet required 복사되어질 DataSet
 * @author : 송동혁
 */
function cfCopyDataSetKeyHeader(oOriginDataSet, oTargetDataSet, keyColArr) {
  var DsHeader = "";
  var colId   = "";
  var colType = "";
  var colProp = "";
  var colSize = ""

  for (var i = 1; i <= oOriginDataSet.CountColumn; i++) {
   	colId   = oOriginDataSet.ColumnID(i);	     //column id

 	  colIndex= oOriginDataSet.ColumnIndex(colId);  //column id에 해당하는 index값
 	  colSize = oOriginDataSet.ColumnSize(colIndex);//column size

 	  var keyCol = false;
 	  for (var j = 0; j < keyColArr.length; j++) {
 	  	 if (colId == keyColArr[j])
 	  	   keyCol = true;
 	  }

 	  if (keyCol == false)
 	    continue;

    /* column의 type 정의 코드

    	Type  Description
    	-----------------
    	 1    String
 	  	 2    Integer
    	 3    Decimal
    	 4    Date
    	 5    URL
    */

 		 //column type정의
 		 switch (oOriginDataSet.ColumnType(colIndex)){
 		   case 1 :
 		            colType = 'String';
 		            break;
 		   case 2 :
 		            colType = 'Integer';
 		            break;
	 	   case 3 :
	 	            colType = 'Decimal';
	 	            break;
	 	   case 4 :
	 	            colType = 'Date';
	 	            break;
	 	   case 5 :
	 	            colType = 'URL';
	 	            break;
	 	   default :
	 	            colType = "";
	 	            break;
	 	 }

 	  // column의 property 정의
    colProp = "KEYVALUE";

    //column id,column type,column size, column property
    DsHeader = DsHeader + colId + ":" + colType + "(" + colSize + ")" + ":" + colProp + ",";
  }

  // 원래 Row Num을 저장하기 위한 컬럼 추가
  DsHeader = DsHeader + "rowNum:Integer(5):NORMAL";

  //DsHeader = DsHeader.substr(0, DsHeader.length - 1);
  oTargetDataSet.SetDataHeader(DsHeader);
}

/**
 * @type   : function
 * @access : public
 * @desc   : 가우스 Grid Object에서 선택(데이터셋의 데이터) 되어 있는 record를 복사하여
 			 붙여넣기(데이터셋에 Row를 추가)를 한다.
 * <pre>
 *    cfCopyRecord(oDataSet);
 * </pre>
 * @sig    : oDataSet
 * @param  : oDataSet required 복사/붙여넣기할 동일 데이터셋 이름
 * @author : 조부구
 */
function cfCopyRecord(oDataSet) {
		var tempdata = '';
		for (j=1;j<=oPgmRegGDS.countrow;j++){
			if (oPgmRegGDS.rowmark(j) == 1){
				tempdata += oPgmRegGDS.ExportData(j,1,true);
			}
		}
		oPgmRegGDS.Importdata(tempdata);
}

/**
 * @type   : function
 * @access : public
 * @desc   : Grid의 선택된 Row들을 삭제한다.
 * <pre>
 *     cfDeleteGridRow(oDomRegiRecevGG);
 * </pre>
 * 위의 예에서 oDomRegiRecevGDS 라는 id를 가진 Grid의 현재 선택된 Row들은 모두 삭제된다.<br><br>
 * <font color=red>
 * 기존의 cfDeleteGridRow 함수의 파라미터는 DataSet이었으나 Grid의 MultiRowSelect 속성이 false일 경우
 * 이 함수를 사용하면 마지막 row를 삭제할 때 Grid의 모든 row가 삭제되는 버그가 있었다. 따라서 파라미터가
 * Grid로 바뀌었다. 하지만 기존에 MultiRowSelect 속성이 true인 경우에는 문제가 없었으므로 궂이 소스변경을
 * 강요할 수 없다. 따라서 기존에 MultiRowSelect 속성이 true 이면서 파라미터를 DataSet으로 사용한 경우에는
 * 변경없이 동작되도록 작성되었다.
 * </font>
 * <<<삭제 대상:DeleteMarked()라는 메소드가 생김>>>
 * @sig    : oGrid
 * @param  : oGrid required Grid 오브젝트
 * @author : 임재현
 */
function cfDeleteGridRows(obj) {
	if (obj.attributes.classid == null) {
		return;
	}

	var oDataSet;
	var oGrid;

	switch (obj.attributes.classid.nodeValue.toUpperCase()) {
		case "CLSID:AF989B7C-8AC3-40BC-B749-EB335BDFD190": // DataSet Component
			oDataSet = obj;
			break;
		case "CLSID:71E7ACA0-EF63-4055-9894-229B056E9C31": // Grid Component
			oGrid    = obj;
			oDataSet = document.all(oGrid.DataID);
			break;
	}

	if (oGrid != null && oGrid.MultiRowSelect == false) {
		oDataSet.DeleteRow(oDataSet.RowPosition);
		return;
	} else {
		for (var i = oDataSet.CountRow; i > 0; i--) {
			if (oDataSet.RowMark(i)) {
				oDataSet.DeleteRow(i);
			}
		}
	}
}

/**
 * @type   : function
 * @access : public
 * @desc   : 자바스크립트의 숫자 앞에 지정된 자릿수만큼 zero character 를 삽입한다.
 * <pre>
 *     cfDigitalNumber(5, 123);
 * </pre>
 * 위와같이 사용했을 경우 "00123" 이라는 String을 리턴한다.
 * @sig    : length, number
 * @param  : length required 숫자를 표현하는 길이
 * @param  : number required 변환될 숫자
 * @return : 변환된 스트링
 * @author : 임재현
 */
function cfDigitalNumber(length, number) {
	var numStr = number + "";
	var zeroChars = "";

	for (var i = 0; i < (length - number.length); i++) {
		zeroChars = zeroChars + "0";
	}

	return (zeroChars + numStr);
}

/**
 * @type   : function
 * @access : public
 * @desc   : element를 disable 시킨다.
 * <pre>
 *     cfDisable(oRegistBtn);
 * </pre>
 * @sig    : oElement
 * @param  : oElement required disable 하고자 하는 element
 * @author : 임재현
 */
function cfDisable(obj) {
	if (cfIsNull(obj)) {
		return;
	}

	if (obj.length != null) {
		for (var i = 0; i < obj.length; i++) {
			cfProcessChildElement(obj[i], cfDisableElement);
		}
	} else {
		cfProcessChildElement(obj, cfDisableElement);
	}
}

/*
	- <input type=text> 의 경우 disable시에 글자색을 지정할 수 없다. 따라서 disable 대신 readOnly로 바꾼다.
	- EMEdit의 경우 역시 disable시에 글자색을 지정할 수 없다. 따라서 disable 대신 readOnly로 바꾼다.
	- 가우스 Radio는 ReadOnly가 없으며 Enable을 false로 설정하면 글자색을 바꿀 수가 없다. 글자색바꿈 포기.
	- <input type=checkbox> 의 경우 ReadOnly가 없으며 disabled를 true로 할 경우 box내부 색깔을 바꿀 수가 없다. box 색바꿈 포기.
	- 가우스 CodeCombo의 경우 InheritColor속성을 true로 하라고 가이드하였으며 InheritColor속성이 true일 경우, 배경색과
	  글자색을 모두 바꿀 수가 있다. 단, ReadOnly는 없으며 Enable을 false로 해야 한다. Enable이 false일 경우는 배경색과 글자색이
	  고정되어서 바꿀 수가 없다.
*/
function cfDisableElement(oElement, argArr) {
	switch (cfGetElementType(oElement)) {
		case "BUTTON" :
			oElement.disabled = true;

			if (oElement.className != null &&
			    (oElement.className.substr(0, 7) == "btnGrid" ||
			     oElement.className.substr(0, 7) == "btnIcon" ) &&
			   	oElement.currentStyle.backgroundImage.substr(oElement.currentStyle.backgroundImage.length - 15, 9) != "_disabled"
			   ) {
			   	oElement.style.backgroundImage =
			   		oElement.currentStyle.backgroundImage.substr(0, oElement.currentStyle.backgroundImage.length - 6) + "_disabled" +
			   		oElement.currentStyle.backgroundImage.substr(oElement.currentStyle.backgroundImage.length - 6);
			}

			break;

		case "CHECKBOX" :
		case "RADIO" :
		case "RESET" :
		case "SELECT" :
		case "SUBMIT" :
			oElement.disabled = true;
			break;

		case "FILE" :
		case "PASSWORD" :
		case "TEXT" :
		case "TEXTAREA" :
			oElement.readOnly = true;
			//oElement.style.color = "#454648";  // 일반 텍스트 기본색상
			oElement.style.color = "#808080";    // EMEdit Disable시 색상과 동일.
			oElement.style.backgroundColor = "#DEDEDE";  // HTML 오브젝트의 기본 disabled color.
			                                             // Text는 background가 하얀색으로 남는다. 따라서 스타일로 임의로 지정하였음.
			break;

		case "GE" :
//			oElement.ReadOnly = true;
//			oElement.ReadOnlyBackColor = "#DEDEDE";
//			oElement.ReadOnlyForeColor = "#454648";
			oElement.Enable = false;
			oElement.DisabledBackColor = "#DEDEDE";
			break;

		case "GCC" :
			oElement.Enable = false;
			break;

		case "GIF" :
		case "GRDO" :
		case "GTA" :
			oElement.Enable = false;
			break;

		default :
			break;
	}
}

/**
 * @type   : function
 * @access : public
 * @desc   : element를 enable 시킨다.
 * <pre>
 *     cfEnable(oRegistBtn);
 * </pre>
 * @sig    : oElement
 * @param  : oElement required enable 하고자 하는 element 혹은 element array
 * @author : 임재현
 */
function cfEnable(obj) {
	if (cfIsNull(obj)) {
		return;
	}

	if (obj.length != null) {
		for (var i = 0; i < obj.length; i++) {
			cfProcessChildElement(obj[i], cfEnableElement);
		}
	} else {
		cfProcessChildElement(obj, cfEnableElement);
	}
}

function cfEnableElement(oElement, argArr) {
	switch (cfGetElementType(oElement)) {
		case "BUTTON" :
			oElement.disabled = false;

			if (oElement.className != null &&
			    (oElement.className.substr(0, 7) == "btnGrid" ||
			     oElement.className.substr(0, 7) == "btnIcon"
			    )
			   ) {
			   	if (oElement.currentStyle.backgroundImage.substr(oElement.currentStyle.backgroundImage.length - 15, 9) == "_disabled") {
				   	oElement.style.backgroundImage =
				   		oElement.currentStyle.backgroundImage.cut(oElement.currentStyle.backgroundImage.length - 15, 9);
				}
			}

			break;

		case "CHECKBOX" :
		case "RADIO" :
		case "RESET" :
		case "SELECT" :
		case "SUBMIT" :
			oElement.disabled = false;
			break;

		case "FILE" :
		case "PASSWORD" :
		case "TEXT" :
		case "TEXTAREA" :
			oElement.readOnly = false;
			oElement.style.color = "#454648";
			oElement.style.backgroundColor = "";
			break;

		case "GE" :
//			oElement.ReadOnly = false;
			oElement.Enable = true;
			break;

		case "GCC" :
			oElement.Enable = true;
			break;

		case "GIF" :
		case "GRDO" :
		case "GTA" :
			oElement.Enable = true;
			break;

		default :
			break;
	}
}

/**
 * @type   : function
 * @access : public
 * @desc   : Grid에 대한 페이지 정보를 보여주는 Grid Header를 삽입한다. 이 함수는 페이징 기법을 사용할 경우 필요한 함수로써
 *           이 함수를 호출하면 페이징을 사용하는 Grid의 Header 부분에 페이징 정보가 자동으로 보여진다. 예를들어서 Grid 오브젝트의
 *           Header 오브젝트의 id 가 oDelivRsltGGHeader 라고 한다면, 다음과 같이 해당 Grid Header를 채울 수 있다.
 *           (페이징과 관련된 내용은 화면 개발 가이드 문서를 참조하기 바란다.)
 * <pre>
 * &lt;script language="javascript" for="oDelivRsltGDS" event="OnLoadCompleted()"&gt;
 *     cfFillGridHeader(oDelivRsltGGHeader, "pageLinkCnt=3");
 * &lt;/script&gt;
 * </pre>
 * @sig    : oGridHeader[, features]
 * @param  : oGridHeader required body내에 div 태그로 선언된 Grid Header 오브젝트
 * @param  : features    optional 기타 속성을 정의하는 스트링. 속성종류는 아래와 같다.
 * <pre>
 *     width        : Grid의 Width (default:608)
 *
 *     showTotal    : 총 조회건수 정보를 보여줄지의 여부. 조회건수 정보는 다음과 같은 형태로
 *                    브라우저에 보여진다. (default:yes)
 *
 *                    총건수:52
 *
 *     showPageInfo : "현재페이지번호/전체페이지수" 형태의 페이지 정보를 보여줄지의 여부.
 *                    페이지 정보는 다음과 같은 형태로 브라우저에 보여진다. (default:yes)
 *
 *                    페이지:1/7
 *
 *     pageLinkCnt  : Grid의 페이지 링크의 개수. 링크영역을 보여주지 않으려면 링크수를 0으로 하면 된다.
 *                    (검색된 페이지가 0일 경우에도 화면상에 나타나지 않는다.)
 *                    아래에 페이지 링크수가 3 일 경우의 예가 나와 있다.
 *                    (default:5)
 *
 *                    ◀[ 4 5 6 ]▶
 *
 *     confirmChangePage : 현재 페이지에 변경된 사항이 있으나 저장되지 않았을 경우에 Confirm Box를 띄울것인지의 여부.
 *                    (default:yes)
 * </pre>
 * @author : 임재현
 */
function cfFillGridHeader(oGridHeader, features) {
	var pageNo          = 0;
	var rsltCnt         = 0;
	var pageCnt         = 0;
	var pageStartLinkNo = 0;
	var pageEndLinkNo   = 0;
	var prevBtn         = "&nbsp;";
	var nextBtn         = "&nbsp;";
	var prevPageSetBtn  = "";
	var nextPageSetBtn  = "";
	var totalArea       = "&nbsp;";
	var pageInfoArea    = "&nbsp;";
	var pageLinkArea    = "&nbsp;";
	var action          = "";
	var parameter       = "";
	var oDataSet        = document.all(document.all(oGridHeader.gridId).DataId);
	var oTR             = (oGridHeader.trId == null) ? null : document.all(oGridHeader.trId);

	var featureNames  = ["width", "showTotal", "showPageInfo", "pageLinkCnt", "showPageBtn", "confirmChangePage"];
	var featureValues = [608, true, true, 5, true, true];
	var featureTypes  = ["number", "boolean", "boolean", "number", "boolean", "boolean"];

	if (features != null) {
		cfParseFeature(features, featureNames, featureValues, featureTypes);
	}

	var width             = featureValues[0];
	var showTotal         = featureValues[1];
	var showPageInfo      = featureValues[2];
	var pageLinkCnt       = featureValues[3];
	var showPageBtn       = featureValues[4];
	var confirmChangePage = featureValues[5];

	// 디자이너의 요구에 의해 페이지 이동 버튼은 표현되지 않음.
	showPageBtn = false;

	if (cfIsNull(oTR)) {
		// Transaction 을 통해 검색된 경우에는 검색 후 DataSet의 DataId가 지워지므로 Post 호출전에
		// cfSavePageParameter 함수를 통해 전역변수에 저장해 놓은 값을 이용해야 한다.
		if (cfIsNull(oDataSet.DataId) && !cfIsNull(GLB_PAGE_PARAMS.getValue(oDataSet.id))) {
			oDataSet.DataId = GLB_PAGE_PARAMS.getValue(oDataSet.id);
		}
	}

	var actionData = null;

	if (cfIsNull(oTR)) {
		actionData = (oDataSet.DataId == null) ? "" : oDataSet.DataId;
	} else {
		actionData = (oTR.Action == null) ? "" : oTR.Action;
	}

	// Parsing DataSet.DataId
	if (actionData.indexOf("&") == -1) {
		action = actionData;
		parameter = "";
	} else {
		action = actionData.substring(0, actionData.indexOf("&"));
		parameter = actionData.substr(actionData.indexOf("&"));
	}

	// pageInfo = cfGetPageInfo(oDataSet);
	pageNo   = Number(cfGetPageInfo(oDataSet, "pageNo", 0));
	rsltCnt  = Number(cfGetPageInfo(oDataSet, "rsltCnt", 0));
	pageCnt  = Number(cfGetPageInfo(oDataSet, "pageCnt", 0));

	if (showPageBtn) {
		if (pageNo > 1) {
			prevBtn = "<a style='cursor:hand;' onclick=\"javascript:cfChangePage(" + oGridHeader.id + ", '" + action + "', '" + parameter + "', " + (pageNo - 1) + ", " + confirmChangePage + ")\">◀ </a>";
		}

		if (pageNo < pageCnt) {
			nextBtn = "<a style='cursor:hand;' onclick=\"javascript:cfChangePage(" + oGridHeader.id + ", '" + action + "', '" + parameter + "', " + (pageNo + 1) + ", " + confirmChangePage + ")\">▶</a>";
		}
	}

	if ( !isNaN(pageLinkCnt) && (pageLinkCnt != 0) && (pageNo != 0) ) {
		pageStartLinkNo = Math.floor( Math.abs(pageNo - 1) / pageLinkCnt ) * pageLinkCnt + 1;

		if (pageStartLinkNo == 1) {
			prevPageSetBtn = "";
		} else {
			prevPageSetBtn = "<a style='font-size:9pt; font-family:굴림; text-decoration:none; color:#212863; cursor:hand;' " +
			                 "onclick=\"cfChangePage(" +
			                 oGridHeader.id + ", '" + action + "', '" + parameter + "', " + (pageStartLinkNo - pageLinkCnt) +
			                 ", " + confirmChangePage + ")\">" + "◀ " + "</a>";
		}

		if ((pageStartLinkNo + pageLinkCnt - 1) < pageCnt) {
			pageEndLinkNo = pageStartLinkNo + pageLinkCnt - 1;
			nextPageSetBtn = "<a style='font-size:9pt; font-family:굴림; text-decoration:none; color:#212863; cursor:hand;' " +
			                 "onclick=\"cfChangePage(" +
			                 oGridHeader.id + ", '" + action + "', '" + parameter + "', " + (pageStartLinkNo + pageLinkCnt) +
			                 ", " + confirmChangePage + ")\">" + " ▶" + "</a>";
		} else {
			pageEndLinkNo = pageCnt;
			nextPageSetBtn = "";
		}

		pageLinkArea = prevPageSetBtn + "<span style='font-size:9pt; font-family:굴림; color:#212863;'>[</span>";
		for (var i = pageStartLinkNo; i <= pageEndLinkNo; i++) {
			if (i != pageNo) {
				pageLinkArea = pageLinkArea + "<a style='font-size:9pt; font-family:굴림; text-decoration:none; color:#212863; cursor:hand;' " +
				               "onclick=\"cfChangePage(" +
				               oGridHeader.id + ", '" + action + "', '" + parameter + "', " + i +
				               ", " + confirmChangePage + ")\"> " + i + " </a>";
			} else {
				pageLinkArea = pageLinkArea + "<span style='font-size:9pt; font-family:굴림; color:#5C8BE0; font-weight:bold;'> " + i + " </span>";
			}
		}
		pageLinkArea = pageLinkArea + "<span style='font-size:9pt; font-family:굴림; color:#212863;'>]</span>" + nextPageSetBtn;
	}

	if (showTotal) {
		totalArea = "<span style='font-size:9pt; font-family:굴림; color:#212863;'>총건수: </span><span style='font-size:9pt; font-family:굴림; color:#5C8BE0; font-weight:bold'>"+ rsltCnt + "</span>";
	}

	if (showPageInfo) {
		pageInfoArea = "<span style='font-size:9pt; font-family:굴림; color:#212863;'>";
		if (showTotal == true) {
			pageInfoArea = pageInfoArea + "&nbsp;&nbsp;";
		}

		pageInfoArea = pageInfoArea +  "페이지: </span><span style='font-size:9pt; font-family:굴림; color:#5C8BE0; font-weight:bold;'>" + pageNo + "/" + pageCnt + "</span>";
	}

	oGridHeader.innerHTML = "<table cellpadding='0' cellspacing='0' width='" + width + "'>" +
	                        "    <tr>" +
	                        "        <td align='left' width='1%' nowrap>" + totalArea + pageInfoArea + "</td>" +
	                        "        <td align='center'>" + pageLinkArea + "</td>" +
	                        "        <td align='right' width='30'>" + prevBtn + nextBtn + "</td>" +
	                        "        </td>" +
                            "    </tr>" +
                            "</table>";
}

/**
 * @type   : function
 * @access : private
 * @desc   : Grid에 대한 페이지 정보를 보여주는 Grid Header를 삽입한다. 예를들어서, pageinfo인 페이징 정보가
 *           있고 Grid 오브젝트의 Header 오브젝트의 id 가
 *           oDelivRsltGGHeader 라고 한다면, 다음과 같이 해당 Grid Header를 채울 수 있다.
 * <pre>
 * &lt;script language="javascript" for="oDelivRsltGDS" event="OnLoadCompleted()"&gt;
 *     cfFillGridHeaderPage(oDelivRsltGGHeader, pageInfo);
  * &lt;/script&gt;
 * </pre>
 * @sig    : oHeader,pageInfo
 * @param  : oHeader  - body내에 div 태그로 선언된 Grid Header의 id
 * @param  : pageInfo - Gauce dataset에서 정의한 pageinfo column값, Grid header부분에 표현할 전체 Recoder 수와 page수
  * <pre>
 *     width        : Grid의 Width (default:300)
  * <pre>
 *  	총건수:52
 * </pre>
 *     showPageInfo : "전체페이지수" 형태의 페이지 정보를 보여줄지의 여부.
 *                    페이지 정보는 다음과 같은 형태로 브라우저에 보여진다. (default:5)
 * <pre>
 *  	페이지:7
 * </pre>
 * @author : 조부구
 */
function cfFillGridHeaderPage(oHeader,pageInfo) {


	var rsltCnt         = 0;
	var pageCnt         = 0;
	var totalArea       = "&nbsp;";
	var pageInfoArea    = "&nbsp;";
	var pageLinkArea    = "&nbsp;";

	var featureNames  = ["width", "showTotal", "showPageInfo", "pageLinkCnt", "showPageBtn"];
	var featureValues = [300, true, true, 5, true];
	var featureTypes  = ["number", "boolean", "boolean", "number", "boolean"];

	var width        = featureValues[0];
	var showTotal    = featureValues[1];
	var showPageInfo = featureValues[2];
	var pageLinkCnt  = featureValues[3];
	var showPageBtn  = featureValues[4];

	rsltCnt  = Number(cfFillPageInfo(pageInfo, "rsltCnt"));
	pageCnt  = Number(cfFillPageInfo(pageInfo, "pageCnt"));

	if (showTotal) {
		totalArea = "<span style='font-size:9pt; font-family:굴림; color:#212863;'>총건수: </span><span style='font-size:9pt; font-family:굴림; color:#5C8BE0; font-weight:bold'>"+ rsltCnt + "</span>";
	}

	if (showPageInfo) {
		pageInfoArea = "<span style='font-size:9pt; font-family:굴림; color:#212863;'>";
		if (showTotal == true) {
			pageInfoArea = pageInfoArea + "&nbsp;&nbsp;";
		}

		pageInfoArea = pageInfoArea +  "페이지: </span><span style='font-size:9pt; font-family:굴림; color:#5C8BE0; font-weight:bold;'>" +"</span>";
	}

	oHeader.innerHTML = "<table cellpadding='0' cellspacing='0' width='" + width + "'>" +
	                    "    <tr>" +
	                    "        <td align='left' width='1%' nowrap>" + totalArea +"</td>" +
	                    "        <td align='left'>"+pageInfoArea+"<font id='page_cnt' style='font-size:9pt; font-family:굴림; color:#5C8BE0; font-weight:bold;'><font></td>" +
                        "    </tr>" +
                        "</table>";
                        page_cnt.innerText = pageCnt;
}

/**
 * @type   : function
 * @access : public
 * @desc   : cfFillGridHeader함수 비슷하며 보고서를 위한 paging기능을 추가하였다.(page from - to형식으로 paramater를 받는다)
 			 Grid에 대한 페이지 정보를 보여주는 Grid Header를 삽입한다. 이 함수는 페이징 기법을 사용할 경우 필요한 함수로써
 *           이 함수를 호출하면 페이징을 사용하는 Grid의 Header 부분에 페이징 정보가 자동으로 보여진다. 예를들어서 Grid 오브젝트의
 *           Header 오브젝트의 id 가 oDelivRsltGGHeader 라고 한다면, 다음과 같이 해당 Grid Header를 채울 수 있다.
 *           (페이징과 관련된 내용은 화면 개발 가이드 문서를 참조하기 바란다.)
 * <pre>
 * &lt;script language="javascript" for="oDelivRsltGDS" event="OnLoadCompleted()"&gt;
 *     cfFillGridHeaderPeriod(oDelivRsltGGHeader, "pageLinkCnt=3");
 * &lt;/script&gt;
 * </pre>
 * @sig    : oGridHeader[, features]
 * @param  : oGridHeader required body내에 div 태그로 선언된 Grid Header 오브젝트
 * @param  : features    optional 기타 속성을 정의하는 스트링. 속성종류는 아래와 같다.
 * <pre>
 *     width        : Grid의 Width (default:608)
 *
 *     showTotal    : 총 조회건수 정보를 보여줄지의 여부. 조회건수 정보는 다음과 같은 형태로
 *                    브라우저에 보여진다. (default:yes)
 * <pre>
 *  	총건수:52
 * </pre>
 *     showPageInfo : "현재페이지번호/전체페이지수" 형태의 페이지 정보를 보여줄지의 여부.
 *                    페이지 정보는 다음과 같은 형태로 브라우저에 보여진다. (default:yes)
 * <pre>
 *  	페이지:1/7
 * </pre>
 *     pageLinkCnt  : Grid의 페이지 링크의 개수. 링크영역을 보여주지 않으려면 링크수를 0으로 하면 된다.
 *                    아래에 페이지 링크수가 3 일 경우의 예가 나와 있다.
 *                    (default:5)
 * <pre>
 *  	◀[ 4 5 6 ]▶
 * </pre>
 *     confirmChangePage : 현재 페이지에 변경된 사항이 있으나 저장되지 않았을 경우에 Confirm Box를 띄울것인지의 여부.
 *                    (default:yes)
 * @author : 조부구
 */
function cfFillGridHeaderPeriod(oGridHeader, features) {

	var startPageNo          = 0;
	var rsltCnt         = 0;
	var pageCnt         = 0;
	var pageStartLinkNo = 0;
	var pageEndLinkNo   = 0;
	var dataId          = "";
	var prevBtn         = "&nbsp;";
	var nextBtn         = "&nbsp;";
	var prevPageSetBtn  = "";
	var nextPageSetBtn  = "";
	var totalArea       = "&nbsp;";
	var pageInfoArea    = "&nbsp;";
	var pageLinkArea    = "&nbsp;";
	var action          = "";
	var parameter       = "";
	var oDataSet        = document.all(document.all(oGridHeader.gridId).DataId);

	var featureNames  = ["width", "showTotal", "showPageInfo", "pageLinkCnt", "showPageBtn", "confirmChangePage"];
	var featureValues = [608, true, true, 5, true, true];
	var featureTypes  = ["number", "boolean", "boolean", "number", "boolean", "boolean"];

	if (features != null) {
		cfParseFeature(features, featureNames, featureValues, featureTypes);
	}

	var width             = featureValues[0];
	var showTotal         = featureValues[1];
	var showPageInfo      = featureValues[2];
	var pageLinkCnt       = featureValues[3];
	var showPageBtn       = featureValues[4];
	var confirmChangePage = featureValues[5];

	// 디자이너의 요구에 의해 페이지 이동 버튼은 표현되지 않음.
	showPageBtn = false;

	if (oDataSet.DataId.indexOf("&") == -1) {
		action = oDataSet.DataId;
		parameter = "";
	} else {
		action = oDataSet.DataId.substring(0, oDataSet.DataId.indexOf("&"));
		parameter = oDataSet.DataId.substr(oDataSet.DataId.indexOf("&"));
	}

	dataId  = oDataSet.id;

	// pageInfo = cfGetPageInfo(oDataSet);
	startPageNo   = Number(cfGetPageInfo(oDataSet, "startPageNo", 0));
	rsltCnt  	  = Number(cfGetPageInfo(oDataSet, "rsltCnt", 0));
	pageCnt  	  = Number(cfGetPageInfo(oDataSet, "pageCnt", 0));


	if (showPageBtn) {
		if (startPageNo > 1) {
			prevBtn = "<a style='cursor:hand;' onclick=\"cfChangePage(" + dataId + ", '" + action + "', '" + parameter + "', " + (startPageNo - 1) + ", " + confirmChangePage + ")\">◀ </a>";
		}

		if (startPageNo < pageCnt) {
			nextBtn = "<a style='cursor:hand;' onclick=\"javascript:cfChangePage(" + dataId + ", '" + action + "', '" + parameter + "', " + (startPageNo + 1) + ", " + confirmChangePage + ")\">▶</a>";
		}
	}

	if ( !isNaN(pageLinkCnt) && (pageLinkCnt != 0) && (startPageNo != 0) ) {
		pageStartLinkNo = Math.floor( Math.abs(startPageNo - 1) / pageLinkCnt ) * pageLinkCnt + 1;

		if (pageStartLinkNo == 1) {
			prevPageSetBtn = "";
		} else {
			prevPageSetBtn = "<a style='font-size:9pt; font-family:굴림; text-decoration:none; color:#212863; cursor:hand;' " +
			                 "onclick=\"cfChangePagePeriod(" +
			                 dataId + ", '" + action + "', '" + parameter + "', " + (pageStartLinkNo - pageLinkCnt) +
			                 ", " + confirmChangePage + ")\">" + "◀ " + "</a>";
		}

		if ((pageStartLinkNo + pageLinkCnt - 1) < pageCnt) {
			pageEndLinkNo = pageStartLinkNo + pageLinkCnt - 1;
			nextPageSetBtn = "<a style='font-size:9pt; font-family:굴림; text-decoration:none; color:#212863; cursor:hand;' " +
			                 "onclick=\"cfChangePagePeriod(" +
			                 dataId + ", '" + action + "', '" + parameter + "', " + (pageStartLinkNo + pageLinkCnt) +
			                 ", " + confirmChangePage + ")\">" + " ▶" + "</a>";
		} else {
			pageEndLinkNo = pageCnt;
			nextPageSetBtn = "";
		}

		pageLinkArea = prevPageSetBtn + "<span style='font-size:9pt; font-family:굴림; color:#212863;'>[</span>";
		for (var i = pageStartLinkNo; i <= pageEndLinkNo; i++) {
			if (i != startPageNo) {
				pageLinkArea = pageLinkArea + "<a style='font-size:9pt; font-family:굴림; text-decoration:none; color:#212863; cursor:hand;' " +
				               "onclick=\"cfChangePagePeriod(" +
				               dataId + ", '" + action + "', '" + parameter + "', " + i +
				               ", " + confirmChangePage + ")\"> " + i + " </a>";
			} else {
				pageLinkArea = pageLinkArea + "<span style='font-size:9pt; font-family:굴림; color:#5C8BE0; font-weight:bold;'> " + i + " </span>";
			}
		}
		pageLinkArea = pageLinkArea + "<span style='font-size:9pt; font-family:굴림; color:#212863;'>]</span>" + nextPageSetBtn;
	}

	if (showTotal) {
		totalArea = "<span style='font-size:9pt; font-family:굴림; color:#212863;'>총건수: </span><span style='font-size:9pt; font-family:굴림; color:#5C8BE0; font-weight:bold'>"+ rsltCnt + "</span>";
	}

	if (showPageInfo) {
		pageInfoArea = "<span style='font-size:9pt; font-family:굴림; color:#212863;'>";
		if (showTotal == true) {
			pageInfoArea = pageInfoArea + "&nbsp;&nbsp;";
		}

		pageInfoArea = pageInfoArea +  "페이지: </span><span style='font-size:9pt; font-family:굴림; color:#5C8BE0; font-weight:bold;'>" + startPageNo + "/" + pageCnt + "</span>";
	}

	oGridHeader.innerHTML = "<table cellpadding='0' cellspacing='0' width='" + width + "'>" +
	                        "    <tr>" +
	                        "        <td align='left' width='1%' nowrap>" + totalArea + pageInfoArea + "</td>" +
	                        "        <td align='center'>" + pageLinkArea + "</td>" +
	                        "        <td align='right' width='30'>" + prevBtn + nextBtn + "</td>" +
	                        "        </td>" +
                            "    </tr>" +
                            "</table>";
}

/**
 * @type   : function
 * @access : public
 * @desc   : Grid의 DataId로 지정된 DataSet에 데이터가 0건일 경우에만 "데이터가 없습니다." 라는 메시지를 Grid상에 보여준다.
 *           데이터가 있을 경우에는 메시지가 보이지 않으며 기존에 이미 보여진 경우에는 메시지가 사라진다.<br>
 *           언제 호출하든지 상관없지만 보통 DataSet의 OnLoadCompleted 이벤트나 Transaction의 OnSuccess 이벤트에서 호출한다.
 * <pre>
 *     &lt;script language="javascript" for="oDelivRsltGDS" event="OnLoadCompleted()"&gt;
 *         cfFillGridHeader(oDelivRsltGGHeader, oDelivRsltGDS, "kpl.spl.common.svl.SplSVL", "kpl.spl.sb.fnc.cmd.RetrieveDelivRsltListCMD", "pageLinkCnt=3");
 *         <b>cfFillGridNoDataMsg(oDelivRsltGG, "gridColLineCnt=2");</b>
 *     &lt;/script&gt;
 * </pre>
 * @sig    : oGG[, features]
 * @param  : oGG      required Grid 오브젝트
 * @param  : features optional 기타 속성을 정의하는 스트링. 속성종류는 아래와 같다.
 * <pre>
 *     gridColLineCnt : Grid의 컬럼 줄의 수. 일반적으로는 한 줄이지만 Grid의 타이틀이 들어가면 2가 될 것이다. 기본값은 1이다.
 * </pre>
 * @author : 임재현
 */
 function cfFillGridNoDataMsg(oGG, features) {
	var oGDS = document.all(oGG.DataId);

	var featureNames  = ["gridColLineCnt","enforseHidden"];
	var featureValues = [1, false];
	var featureTypes  = ["number","boolean"];

	if (features != null) {
		cfParseFeature(features, featureNames, featureValues, featureTypes);
	}

	var gridColLineCnt = featureValues[0];
	var enforseHidden = featureValues[1];
	var oNoDataMsg = document.all(oGG.id + "NodataMsg");
	
	if (oGDS.CountRow == 0) {
	
		if ( oNoDataMsg == null ) {
			
	//		oNoDataMsg = document.createElement("<comment id='__NOSCRIPT_ID__'><OBJECT id=" 
	//					+ oGG.id + "NodataMsg></comment><SCRIPT>__ShowEmbedObject(__NOSCRIPT_ID__);</SCRIPT>");
			oNoDataMsg = document.createElement("<OBJECT id="+ oGG.id + "NodataMsg>");					
			var colHeight = 20;
			var msgWidth = 170;
			var marginTop = 10;
			
			oNoDataMsg.classid           = "CLSID:D7779973-9954-464E-9708-DA774CA50E13";
			oNoDataMsg.width             = msgWidth;
			oNoDataMsg.Numeric           = false;
			oNoDataMsg.Border            = false;
			oNoDataMsg.Enable            = false;
			oNoDataMsg.DisabledBackColor = "#FFFFFF";
			oNoDataMsg.Text              = "No Data Found.";
			oNoDataMsg.style.fontSize    = "9pt";
			oNoDataMsg.style.position    = "absolute";
			var curPos = findPos(oGG);
			oNoDataMsg.style.left        = Number(curPos[0]) + ((Number(curPos[2]) - msgWidth) / 2);
			oNoDataMsg.style.top         = Number(curPos[1]) + gridColLineCnt * colHeight + marginTop;
			oNoDataMsg.style.visibility = "visible";
	
			oComment = document.createElement("<comment id='__NOSCRIPT_ID__'>");
			oScript = "<SCRIPT>__ShowEmbedObject(__NOSCRIPT_ID__)";
			oNoDataMsg.insertAdjacentElement("beforeBegin", oComment);
			oComment.insertAdjacentHTML("AfterEnd", oScript);
			oGG.insertAdjacentElement("beforeBegin", oNoDataMsg);
			
	    } else {
			var colHeight = 20;
			var msgWidth = 170;
			var marginTop = 10;
			var curPos = findPos(oGG);
			oNoDataMsg.style.left        = Number(curPos[0]) + ((Number(curPos[2]) - msgWidth) / 2);
			oNoDataMsg.style.top         = Number(curPos[1]) + gridColLineCnt * colHeight + marginTop;
			oNoDataMsg.style.visibility = "visible";
	    }
	
		if(enforseHidden == true) {
			oNoDataMsg.style.visibility = "hidden";
		}
	} else {
	  	if ( oNoDataMsg != null ) {
	        oNoDataMsg.style.visibility = "hidden";
	    }
	}

}

/**
 * @type   : function
 * @access : private
 * @desc   : 보고서의 paging이 있는경우 전체 수량,페이징수량을 받는다.title에 내용표기를 위한 데이터.
 * <pre>
 *     cfFillPageInfo(pageInfo,paramName);
 * </pre>
 * @param  : pageInfo - 검색으로 이용된 페이지 정보, dataset에 정의되어 있는 pageinfo값
 * @param  : paramName- pageinfo에서 받고자 하는 전체row수량/ page수량 name을 준다.
   @author : 조부구
 */
function cfFillPageInfo(pageInfo,paramName){
		var paramArray = pageInfo.advancedSplit("&", "i");
		var paramPair;

		for (var i = 0; i < paramArray.length; i++) {
			paramPair = paramArray[i].advancedSplit("=", "i");

			if (paramPair[0].trim() == paramName.trim()) {
				return paramPair[1];
			}
		}
}

/**
 * @type   : function
 * @access : public
 * @desc   : 서버에서 현재시간을 읽어와서 자바스크립트의 Date 오브젝트로 변환한다.
 *           Date 오브젝트로부터 스트링 형태로 날짜 혹은 시간을 얻으려면 Date.format() 메소드를 참조할 것.
 * @return : Date 오브젝트
 * @author : 임재현
 */
function cfGetCurrentDate() {
	var dataSet;
	var dateString;

	if (document.all("coCurrentDateGDS") == null) {
		dataSet = document.createElement("<OBJECT>");
		dataSet.classid = "CLSID:AF989B7C-8AC3-40BC-B749-EB335BDFD190";
		dataSet.id = "coCurrentDateGDS";
		dataSet.SyncLoad = "true";
		dataSet.DataId = getDNS() + "/servlet/kpl.ici.common.svl.IciIntroSVL?cmd=kpl.common.util.cmd.CurrentDateCMD";

		// </head> 태그 직전에 DataSet 삽입
		for (var i = 0; i < document.all.length; i++) {
			if (document.all[i].tagName == "HEAD") {
				document.all[i].insertAdjacentElement("beforeEnd", dataSet);
				break;
			}
		}
	} else {
		dataSet = document.all("coCurrentDateGDS");
	}

	dataSet.Reset();
	dateString = dataSet.NameValue(1, "dateString");
	dataSet.clearData();

	if (cfIsNull(dateString)) {
		return null;
	}

	return new Date(dateString.substr(0, 4),
	                Number(dateString.substr(4, 2)) -1,
	                dateString.substr(6, 2),
	                dateString.substr(8, 2),
	                dateString.substr(10, 2),
	                dateString.substr(12, 2)
	               )
}

/**
 * @type   : function
 * @access : public
 * @desc   : Element의 type을 알려준다. 리턴되는 element type string은 다음과 같다.
 * <pre>
 *     BUTTON   : html button input tag
 *     CHECKBOX : html checkbox input tag
 *     FILE     : html file input tag
 *     HIDDEN   : html hidden input tag
 *     IMAGE    : html image input tag
 *     PASSWORD : html password input tag
 *     RADIO    : html radio input tag
 *     RESET    : html reset input tag
 *     SUBMIT   : html submit input tag
 *     TEXT     : html text input tag
 *     SELECT   : html select tag
 *     TEXTAREA : html textarea tag
 *     GCC      : 가우스 CodeCombo
 *     GRDO     : 가우스 Radio
 *     GTA      : 가우스 TextArea
 *     GIF      : 가우스 InputFile
 *     GE       : 가우스 EMEdit
 *     GDS      : 가우스 DataSet
 *     GTR      : 가우스 Transaction
 *     GCHT     : 가우스 Chart
 *     GID      : 가우스 ImageData
 *     GG       : 가우스 Grid
 *     GTB      : 가우스 Tab
 *     GTV      : 가우스 TreeView
 *     GM       : 가우스 Menu
 *     GB       : 가우스 Bind
 *     GRPT     : 가우스 Report
 *     GS       : 가우스 Scale
 *     null     : 기타
 * </pre>
 * @sig    : oElement
 * @param  : oElement required element
 * @return : element의 type을 표현하는 string
 * @author : 임재현
 */
function cfGetElementType(oElement) {
	if (oElement == null) {
		return null;
	}

	switch (oElement.tagName) {
		case "INPUT":
			switch (oElement.type) {
				case "button" :
					return "BUTTON";
				case "checkbox" :
					return "CHECKBOX";
				case "file" :
					return "FILE";
				case "hidden" :
					return "HIDDEN";
				case "image" :
					return "IMAGE";
				case "password" :
					return "PASSWORD";
				case "radio" :
					return "RADIO";
				case "reset" :
					return "RESET";
				case "submit" :
					return "SUBMIT";
				case "text" :
					return "TEXT";
				default :
					return null;
			}
		case "SELECT":
			return "SELECT"
		case "TEXTAREA":
			return "TEXTAREA"
		case "OBJECT":
			    switch (oElement.attributes.classid.nodeValue.toUpperCase()) {
				case "CLSID:FD4C6571-DD20-11D2-973D-00104B15E56F": // CodeCombo Component
					return "GCC"
				case "CLSID:F73C0958-D8FE-43A5-9BB0-0F651C5A2BCC": // Radio Component
					return "GRDO"
                case "CLSID:1455BE02-C41B-4115-B21C-32380507DC8F": // TextArea Component
					return "GTA"
				case "CLSID:5C32688E-CEBE-419D-9C63-0704A2331EEC": // InputFile Component
					return "GIF"
				case "CLSID:D7779973-9954-464E-9708-DA774CA50E13": // EMedit Component
					return "GE"
				case "CLSID:AF989B7C-8AC3-40BC-B749-EB335BDFD190": // DataSet Component
					return "GDS"
				case "CLSID:223216F6-B9FE-406D-9ED6-143FCE3A07B8": // Transaction Component
					return "GTR"
				case "CLSID:B5F6727A-DD38-11D2-973D-00104B15E56F": // Chart Component
					return "GCHT"
				case "CLSID:9F0AA341-1D10-4B18-B70B-6AA49CE7F5D6": // ImageData Component
					return "GID"
				case "CLSID:71E7ACA0-EF63-4055-9894-229B056E9C31": // Grid Component
					return "GG"
				case "CLSID:90CAA259-71ED-42CB-BEB8-95281CCF9E58": // Tab Component
					return "GTab"
				case "CLSID:C1781C5C-0C32-40F2-8927-46FE4BCB5B87": // TreeView Component
					return "GTree"
				case "CLSID:31538FAB-8051-4CFA-ACA4-B2668718B6F8": // Menu Component
					return "GM"
				case "CLSID:2F98EA90-EAE1-4AB5-AE89-DA073D824589": // Bind Component
					return "GB"
				case "CLSID:9683681E-FAD6-45F1-86B3-FD60C7101BC9": // Report Component
					return "GRPT"
				case "CLSID:8D6D8F1E-2567-4916-8036-50D3F7F01563": // Scale Component
					return "GS"
                default:
                	return null;
			}
		default :
			return null;
	}
}

/**
 * @type   : function
 * @access : public
 * @desc   : 스트링의 자릿수를 Byte 단위로 환산하여 알려준다. 영문, 숫자는 1Byte이고 한글은 2Byte이다.(자/모 중에 하나만 있는 글자도 2Byte이다.)
 * @sig    : value
 * @param  : value required 스트링
 * @return : 스트링의 길이
 * @author : 차종호
 */
function cfGetByteLength(value){
	var byteLength = 0;

	if (cfIsNull(value)) {
		return 0;
	}

	var c;

	for(var i = 0; i < value.length; i++) {
		c = escape(value.charAt(i));

		if (c.length == 1) {
			byteLength ++;
		} else if (c.indexOf("%u") != -1)  {
			byteLength += 2;
		} else if (c.indexOf("%") != -1)  {
			byteLength += c.length/3;
		}
	}

	return byteLength;
}

/**
 * @type   : function
 * @access : public
 * @desc   : 공통메세지에 정의된 메세지를 리턴한다.
 * <pre>
 * // 공통 메세지 영역
 * var MSG_NO_CHANGED        = "변경된 사항이 없습니다.";
 * var MSG_SUCCESS_LOGIN     = "@님 안녕하세요?";
 * ...
 * var message1 = cfGetMsg(MSG_NO_CHANGED);
 * var message2 = cfGetMsg(MSG_SUCCESS_LOGIN, ["홍길동"]);
 * </pre>
 * 위의 예에서 message2 의 값은 "홍길동님 안녕하세요?" 가 된다.
 * @sig    : msgId[, paramArray]
 * @param  : msgId      required lafui.js의 공통 메세지 영역에 선언된 메세지 ID
 * @param  : paramArray optional 메세지에서 '@' 문자와 치환될 데이터 Array. Array의 index와
 *           메세지 내의 '@' 문자의 순서가 일치한다. 치환될 데이터는 [] 사이에 콤마를 구분자로 하여 기술하면 Array 로 인식된다.
 * @return : 치환된 메세지 스트링
 * @author : 임재현
 */
function cfGetMsg(msgId, paramArray) {
	return new coMessage().getMsg(msgId, paramArray);
}

/**
 * @type   : function
 * @access : public
 * @desc   : 서버에서 클라이언트로 DataSet의 pageInfo 컬럼을 이용해 파라미터를 전달했을 경우 클라이언트에서 파라미터를 얻는 함수이다.
 *           서버에서 임의의 파라미터를 넣는 방법은 Paging을 사용할 때와 비슷하다.<br>
 * <pre>
 *           1. 임의의 파라미터를 넣으려는 DataSet에 pageInfo 컬럼을 추가한다.
 *              dataSet.MakeDataSetInfo("pageInfo", gauceDefine.TB_STRING);
 *
 *           2. pageInfo 데이터를 조립하여 DataSet의 첫번째 row의 pageInfo컬럼에 pageInfo 정보를 삽입한다.
 *              ...
 *              if (dataSet.rowcnt() > 0) {
 *                  rec = dataSet.getRow(1);
 *                  StringBuffer pageInfo = new StringBuffer();
 *                  pageInfo.append("&p1=").append(p1)
 *                          .append("&p2=").append(p2)
 *                          ...
 *                          .append("&pn=").append(pn);
 *
 *                  rec.setString("pageInfo", pageInfo.toString());
 *              }
 *              ...
 *
 *           4. 화면에서 cfGetPageInfo 함수를 이용해 값을 꺼낸다.
 *              cfGetPageInfo(oDelivGDS);
 *              cfGetPageInfo(oDelivGDS, "p1");
 *              cfGetPageInfo(oDelivGDS, "p1", "default value");
 * </pre>
 * @sig    : oDataSet[, paramName[, defaultValue]]
 * @param  : oDataSet     required pageInfo 가 들어있는 DataSet
 * @param  : paramName    optional pageInfo 중에서 얻고자 하는 파라미터의 이름
 * @param  : defaultValue optional paramName에 해당하는 파라미터가 존재하지 않을 경우 리턴되는 기본값.
 * @return : paramName이 없을 경우에는 pageInfo 스트링 전체를 리턴하고 paramName이 있을 경우는 해당 파라미터의 값을 리턴한다.
 * @author : 임재현
 */
function cfGetPageInfo(oDataSet, paramName, defaultValue) {
	var pageInfo;

	if (oDataSet.CountRow != 0) {
		if (cfIsNull(pageInfo = oDataSet.NameValue(1, "pageInfo"))) {
			for (var i = 2; i <= oDataSet.CountRow; i++) {
				if (!cfIsNull(oDataSet.NameValue(i, "pageInfo"))) {
					pageInfo = oDataSet.NameValue(i, "pageInfo");
					break;
				}
			}
		}
	}

	if (cfIsNull(paramName)) {
		return pageInfo;
	}

	if (cfIsNull(pageInfo)) {
		return defaultValue;
	}

	var paramArray = pageInfo.advancedSplit("&", "i");
	var paramPair;

	for (var i = 0; i < paramArray.length; i++) {
		paramPair = paramArray[i].advancedSplit("=", "it");

		if (paramPair[0] == paramName.trim()) {
			return paramPair[1];
		}
	}

	return defaultValue;
}

/**
 * @type   : function
 * @access : public
 * @desc   : 한번 검색된 DataSet의 DataId에 지정되어 있는 파라미터 스트링을 얻기 위한 함수. 주로 페이징을
 *           사용할 때 사용된다.
 * <pre>
 *    var action = getDNS() + "/servlet/kpl.spl.common.svl.SplSVL?cmd=kpl.spl.sb.fnc.cmd.RetrieveDelivRsltListCMD";
 *    var param  = "&delivYmd=" + oDelivYmd.Text +
 *        "&delivSeqCd=" + oDelivSeqCd.CodeValue +
 *        "&pageSize=8" +
 *        "&pageNo=1";
 *
 *    oDelivRsltGDS.DataId = action + param;
 *    oDelivRsltGDS.Reset();
 * </pre>
 * 위와 같이 DataId 를 작성하여 DataSet을 검색하였다고 하자. 이 때 oDelivYmd.Text 의 값은 "20020913" 이었고
 * oDelivSeqCd.CodeValue 의 값은 "001" 이었다고 할 경우, parameter 로 사용된 스트링 부분을
 * 다시 얻기 위해서는 아래와 같이 하면 된다.
 * <pre>
 *     var param = cfGetPageParameter(oDelivRsltGDS);
 * </pre>
 * 위에서 param 의 값은 "&delivYmd=20020913&delivSeqCd=001&pageSize=8&pageNo=1" 이 된다.
 * @sig    : oDataSet
 * @param  : oDataSet required parameter string을 얻고자 하는 DataSet 객체.
 * @author : 임재현
 */
function cfGetPageParameter(oDataSet) {
	if (oDataSet.DataId.indexOf("&") != -1) {
		return parameter = oDataSet.DataId.substr(oDataSet.DataId.indexOf("&"));
	}

	return "";
}

/**
 * @type   : function
 * @access : public
 * @desc   : popup에서 radio button 변경시 처리
 * @sig    : oTypeGR, oStartPageNo, oEndPageNo
 * @param  : oTypeGR - radio button object id
 * @param  : oStartPageNo - start page를 나타낼 emedit object id
 * @param  : oEndPageNo -  end page를 나타낼 emedit object id
 * @author : 조부구
 */
function cfGRadioChg(oTypeGR, oStartPageNo, oEndPageNo){
	if (oTypeGR.CodeValue =='1' ){
		oEndPageNo.ReadOnly   	= true;
		oStartPageNo.ReadOnly 	= true;
		oStartPageNo.text	= 1;
		oEndPageNo.text		= page_cnt.innerText;
	}
	else{
		oEndPageNo.ReadOnly   = false;
		oStartPageNo.ReadOnly = false;
	}
}

/**
 * @type   : function
 * @access : private
 * @desc   : Object를 초기화한다.
 * @sig    : obj[, iniVal]
 * @param  : parentObj required 초기화할 대상 오브젝트
 * @param  : iniVal    optional 초기값
 * @author : 김수호
 */
function cfIniObject(obj) {
	var	iniVal = "";

	switch (obj.tagName) {
		case "INPUT":
			switch (obj.type) {
				case "checkbox":
					obj.checked = 0;
					break;
				case "button" :
					break;
				case "image" :
					break;
				default :
					obj.value = "";
					break;
			}

			break;

		case "SELECT":
			obj.selectedIndex = 0;
			break;
		case "TEXTAREA":
			obj.value = "";
			break;

		case "OBJECT":
			switch (obj.attributes.classid.nodeValue.toUpperCase()) {
				case "CLSID:FD4C6571-DD20-11D2-973D-00104B15E56F": // CodeCombo Component
					obj.Index = 0;
                    break;
				case "CLSID:F73C0958-D8FE-43A5-9BB0-0F651C5A2BCC": // Radio Component
				case "CLSID:D7779973-9954-464E-9708-DA774CA50E13": // EMedit Component
                case "CLSID:1455BE02-C41B-4115-B21C-32380507DC8F": // TextArea Component
					obj.Text = "";
					break;
				case "CLSID:5C32688E-CEBE-419D-9C63-0704A2331EEC": // InputFile Component
                    break;
                default :
                	break;
			}
	}
}

/**
 * @type   : function
 * @access : public
 * @desc   : 사용자가 누른 key가 enter key 인지 여부를 알려준다.
 * <pre>
 *     function fncOnKeyPress() {
 *         ...
 *         if (cfIsEnterKey()) {
 *             ...
 *         }
 *     }
 *     ...
 *     &lt;input type="text" onkeypress="fncOnKeyPress()"&gt;
 * </pre>
 * @return : enter key 여부
 * @author : 임재현
 */
function cfIsEnterKey() {
	if (event.keyCode == 13) {
		return true;
	}

	return false;
}

/**
 * @type   : function
 * @access : public
 * @desc   : 값이 null 이거나 white space 문자로만 이루어진 경우 true를 리턴한다.
 * <pre>
 *     cfIsNull("  ");
 * </pre>
 * 위와같이 사용했을 경우 true를 리턴한다.
 * @sig    : value
 * @param  : value required 입력값
 * @return : boolean. null(혹은 white space) 여부
 * @author : 임재현
 */
function cfIsNull(value) {
	if (value == null ||
	    (typeof(value) == "string" && value.trim() == "")
	   ) {
		return true;
	}

	return false;
}

/**
 * @type   : function
 * @access : public
 * @desc   : 값이 지정된 그룹내에 존재하는지를 알려준다.
 * <pre>
 *     cfIsIn(3, [1, 2, 3]);                     // -> true
 *     cfIsIn(3, [4, 5, 6]);                     // -> false
 *     cfIsIn('F', ['A', 'B', 'F']);             // -> true
 *     cfIsIn('F', ['A', 'B', 'C']);             // -> false
 *     cfIsIn("lim", ["lim", "kim", "park"]);    // -> true
 *     cfIsIn("lim", ["lee", "kim", "park"]);    // -> false
 * </pre>
 * @sig    : value, valueArray
 * @param  : value      required 비교하고 싶은 값
 * @param  : valueArray required 비교하고 싶은 값에 대한 비교 대상이 되는 값들의 집합. array 타입이며 array
 *           내의 각 element의 데이터 타입은 value 파라미터의 타입과 일치해야 한다.
 * @return : boolean. 값이 지정된 그룹내에 존재하는지 여부.
 * @author : 임재현
 */
function cfIsIn(value, valueArray) {
	for (var i = 0; i < valueArray.length; i++) {
		if (value == valueArray[i]) {
			return true;
		}
	}

	return false;
}

/**
 * @type   : function
 * @access : public
 * @desc   : 페이지가 다른 페이지로부터 로드된 페이지인지 여부를 알려준다.
 * @sig    : pageId
 * @param  : pageId required 현재 페이지 id
 * @author : 임재현
 */
function cfIsNaviPage(pageId) {
	if (GLB_FRAME_MAIN_NAVI.receivePageId != null && GLB_FRAME_MAIN_NAVI.receivePageId == pageId) {
		return true;
	}

	return false;
}

/**
 * @type   : function
 * @access : public
 * @desc   : 페이지를 이동할 때 파라미터 및 DataSet을 전달하기 위한 함수.
 * <pre>
 *     in.html 페이지에서 out.html 로 페이지를 이동하면서 2개의 파라미터와 2개의 DataSet을 전달하고자 한다.
 *     전달할 파라미터는 param1과 param2이며 전달할 DataSet의 id는 각각 oPmanGDS 와 oDAreaGDS 이다.
 *     이 때 in.html 에서 수행해야 될 절차는 다음과 같다.
 *
 *         1. coParameterMap 객체를 생성한다. (coParameterMap 객체에 대한 설명은 document를 참조)
 *            var paramMap = new coParameterMap();
 *
 *         2. coParameterMap 객체에 전달할 파라미터 데이터를 채운다.
 *	          paramMap.put("param1", "paramvalue1");
 *            paramMap.put("param2", "paramvalue2");
 *
 *         3. cfNaviPageIn 함수를 호출한다.
 *            cfNaviPageIn("out.html", paramMap, "pman=oPmanGDS,dArea=oDAreaGDS");
 *
 *            <font color=red>
 *            ※주의 : 이 함수는 전체 화면에 대한 프레임 구조가 제대로 로드되어 있지 않으면에러가 난다.
 *                     따라서 에러가 날 경우 시스템 초기화면부터 제대로 로드된 상태인지 확인해 보기 바란다.
 *            </font>
 * </pre>
 * @sig    : receivePageId, paramMap[, dataSetKeyValue]
 * @param  : receivePageId   required 전달할 페이지의 id(.html을 제외한 파일명과 동일)
 * @param  : paramMap        required 전달할 파라미터를 담고 있는 coParameterMap 객체
 * @param  : dataSetKeyValue optional 전달할 DataSet에 대한 정보를 형식에 맞게 표현한 스트링.
 * <pre>
 *     형식 : "key=dataset_id, ..."
 *     예   : "pman=oPmanGDS,dArea=oDAreaGDS"
 * </pre>
 * @author : 임재현
 */
function cfNaviPageIn(receivePageId, paramMap, dataSetKeyValue) {
	// MainNaviFrame의 head element 찾기
	var head;
	for (var i = 0; i < GLB_FRAME_MAIN_NAVI.document.all.length; i++) {
		if (GLB_FRAME_MAIN_NAVI.document.all[i].tagName == "HEAD") {
			head = GLB_FRAME_MAIN_NAVI.document.all[i];
			break;
		}
	}

	// clear navigation data
	{
		// remove receivePageId
		GLB_FRAME_MAIN_NAVI.receivePageId = null;

		// remove parameterForm
		if (GLB_FRAME_MAIN_NAVI.parameterForm != null) {
			GLB_FRAME_MAIN_NAVI.document.body.removeChild(GLB_FRAME_MAIN_NAVI.parameterForm);
		}

		// MainNaviFrame의 head 내의 모든 DataSet 삭제
		for (var i = 0; i < head.children.length; i++) {
			if (head.children[i].tagName == "OBJECT" &&
			    head.children[i].attributes.classid.nodeValue.toUpperCase() == "CLSID:AF989B7C-8AC3-40BC-B749-EB335BDFD190" // DataSet Object
			   ) {
				head.removeChild(head.children[i]);
			}
		}
	}

	// initialize navigation data
	{
		// set receivePageId
		GLB_FRAME_MAIN_NAVI.receivePageId = receivePageId;

		// create parameterForm
		parameterForm = document.createElement("<FORM>");
		parameterForm.id = "parameterForm";
		GLB_FRAME_MAIN_NAVI.document.body.insertAdjacentElement("beforeEnd", parameterForm);
	}

	// MainNaviFrame 에 navigation을 위한 parameter 만들기
	if (paramMap != null) {
		var paramObj
		for (var i = 0; i < paramMap.size(); i++) {
			paramObj = document.createElement("<INPUT>");
			paramObj.name = paramMap.getNameAt(i);
			paramObj.value = paramMap.getValueAt(i);
			GLB_FRAME_MAIN_NAVI.parameterForm.insertAdjacentElement("beforeEnd", paramObj);
		}
	}

	if (!cfIsNull(dataSetKeyValue)) {
		var keyValueArray = dataSetKeyValue.split(",");
		var keyValuePair;
		var key;
		var value;
		var originDataSet;
		var dataSet;

		for (var i = 0; i < keyValueArray.length; i++) {
			keyValuePair = keyValueArray[i].trim().split("=");
			key = keyValuePair[0].trim();
			value = keyValuePair[1].trim();

			// 복사용 DataSet 만들기
			dataSet = document.createElement("<OBJECT>");
			dataSet.classid = "CLSID:AF989B7C-8AC3-40BC-B749-EB335BDFD190";
			dataSet.id = key;
			head.insertAdjacentElement("beforeEnd", dataSet);

			// 복사용 DataSet에 데이터 넣기
			originDataSet = document.all(value);
			cfCopyDataSet(originDataSet, dataSet);
		}
	}

	location.href = receivePageId + ".html";
}

/**
 * @type   : function
 * @access : public
 * @desc   : 페이지를 이동할 때 파라미터 및 DataSet을 전달받기 위한 함수. cfNaviPageIn 함수에 대한 설명을 다 이해하였다고 가정한다.
 * <pre>
 *     in.html 로부터 out.html 페이지로 이동하면서 2개의 파라미터와 2개의 DataSet을 전달하고자 한다. 전달할 파라미터는 param1과 param2이며
 *     전달할 DataSet의 id는 각각 oPmanGDS 와 oDAreaGDS 이다. 이 때 out.html에서 수행해야 될 절차는 다음과 같다.
 *
 *         1. 전달받아야 할 DataSet을 담는 DataSet이 선언되어 있어야 한다. 즉, in.html에서 전달되는 두 개의 DataSet(oPmanGDS, oDAreaGDS)을
 *            담을 수 있는 두 개의 DataSet이 선언되어 있어야 한다. (여기서는 oPmanOutGDS과 oDAreaOutGDS 라고 가정한다.)
 *
 *         2. body의 onload 이벤트 발생시 다음과 같이 처리해 준다.
 *            1) cfIsNaviPage 함수(document를 참조) 를 이용해서 현재 페이지가 다른 페이지를 통해 로드된 것인지,
 *               아니면 그냥 메뉴를 선택해서 로드된 것인지 확인한다.
 *
 *		         if (cfIsNaviPage("out")) {
 *                   ...
 *               }
 *
 *            2) 만일 다른 페이지(in.html)를 통해 로드된 것이라면 cfNaviPageOut 함수를 호출한다.
 *
 *               var paramMap = cfNaviPageOut("out", "pman=oPmanOutGDS,dArea=oDAreaOutGDS");
 *              (이 때, 두번째 파라미터의 key 값은(pman, dArea) in.html에서 사용한 key 값과 동일해야 한다.)
 *
 *            3) 만일 이전 페이지에서 파라미터를 넘겼다면 paramMap 변수에는 coParameterMap 객체(document 참조할것) 를 리턴받을 것이다.
 *               전달받은 파라미터는 paramMap 변수를 이용해서 사용하면 된다.
 *               또한 전달받은 DataSet은 1번에서 선언한 DataSet에 담겨있을 것이다.
 * </pre>
 * @sig    : pageId[, dataSetKeyValue]
 * @param  : pageId          required 현재 페이지의 id(.html을 제외한 파일명과 동일)
 * @param  : dataSetKeyValue optional 전달받는 DataSet에 대한 정보를 형식에 맞게 표현한 스트링.
 * <pre>
 *     형식 : "key=dataset_id, ..."
 *     예   : "pman=oPmanGDS,dArea=oDAreaGDS"
 *     <font color=red>※주의</font> : 이 때 key 값은 in.html에서 cfNaviPageIn 함수의 dataSetKeyValue 파라미터 작성시 사용했던 key와 동일해야 한다.
 * </pre>
 * @return : 넘겨받은 파라미터가 있을 경우 그 파라미터정보를 담고 있는 coParameter 객체가 리턴된다.
 * @author : 임재현
 */
function cfNaviPageOut(pageId, dataSetKeyValue) {
	if (GLB_FRAME_MAIN_NAVI.receivePageId == null || GLB_FRAME_MAIN_NAVI.receivePageId != pageId) {
		return null;
	}

	if (!cfIsNull(dataSetKeyValue)) {
		var keyValueArray = dataSetKeyValue.split(",");
		var keyValuePair;
		var key;
		var value;
		var originDataSet;
		var dataSet;

		for (var i = 0; i < keyValueArray.length; i++) {
			keyValuePair = keyValueArray[i].trim().split("=");
			key = keyValuePair[0].trim();
			value = keyValuePair[1].trim();

			// 복사용 DataSet에 데이터 넣기
			originDataSet = GLB_FRAME_MAIN_NAVI.document.all(key);
			cfCopyDataSet(originDataSet, document.all(value));
		}
	}

	// MainNaviFrame 으로부터 navigation을 위한 parameter 들을 읽어서 coParameterMap 객체로 만들기
	var paramMap = new coParameterMap();
	var parameters = GLB_FRAME_MAIN_NAVI.parameterForm.children;
	for (var i = 0; i < parameters.length; i++) {
		paramMap.put(parameters[i].name, parameters[i].value);
	}

	// clear navigation data
	{
		// remove parameterForm
		GLB_FRAME_MAIN_NAVI.document.body.removeChild(GLB_FRAME_MAIN_NAVI.parameterForm);

		// remove receivePageId
		GLB_FRAME_MAIN_NAVI.receivePageId = null;

		var head;

		// MainNaviFrame의 head element 찾기
		for (var i = 0; i < GLB_FRAME_MAIN_NAVI.document.all.length; i++) {
			if (GLB_FRAME_MAIN_NAVI.document.all[i].tagName == "HEAD") {
				head = GLB_FRAME_MAIN_NAVI.document.all[i];
				break;
			}
		}

		// MainNaviFrame의 head 내의 모든 DataSet 삭제
		for (var i = 0; i < head.children.length; i++) {
			if (head.children[i].tagName == "OBJECT" &&
			    head.children[i].attributes.classid.nodeValue.toUpperCase() == "CLSID:AF989B7C-8AC3-40BC-B749-EB335BDFD190" // DataSet Object
			   ) {
				head.removeChild(head.children[i]);
			}
		}
	}

	return paramMap;
}

/**
 * @type   : function
 * @access : public
 * @desc   : window.open으로 서브창을 띄울 때 서브창의 위치를 간단하게 지정할 수 있다.
 * @sig    : width, height, position, [sURL] [, sName] [, sFeatures] [, bReplace]
 * @param  : width - 서브창의 넓이
 * @param  : height - 서브창의 높이
 * @param  : position  - 서브창의 위치 (default : 5) <br><br>
 * <table border='1'>
 *     <tr>
 *         <td>1</td>
 *         <td>2</td>
 *         <td>3</td>
 *     </tr>
 *     <tr>
 *         <td>4</td>
 *         <td>5</td>
 *         <td>6</td>
 *     </tr>
 *     <tr>
 *         <td>7</td>
 *         <td>8</td>
 *         <td>9</td>
 *     </tr>
 * </table>
 * @param  : sURL      required window.open의 sURL 파라미터와 동일
 * @param  : sName     required window.open의 sName 파라미터와 동일
 * @param  : sFeatures required window.open의 sFeatures 파라미터와 동일
 * @param  : bReplace  required window.open의 bReplace 파라미터와 동일
 * @author : 임재현
 */
function cfOpen(width, height, position, sURL, sName, sFeatures, bReplace) {
	var left = 0;
	var top = 0;

/*
	var featureNames  = ["status", "menubar", "toolbar"];
	var featureValues = ["no", "no", "no"];
	var featureTypes  = ["boolean", "boolean", "boolean"];

	if (sFeatures != null) {
		cfParseFeature(sFeatures, featureNames, featureValues, featureTypes);
	}

	var status = featureValues[0];
	var menubar = featureValues[1];
	var toolbar = featureValues[2];
*/
	if (width != null && height != null) {
		width = width + 10; // window의 좌우 border 5px씩 감안.
		height = height + 29; // titlebar는 기본으로 감안.
/*
		if (status) {
			height = height + 20;
		}

		if (menubar) {
			height = height + 48;
		}

		if (toolbar) {
			height = height + 27;
		}
*/
		switch (position) {
			case 1 :
				left = 0;
				top = 0;
				break;

			case 2 :
				left = (screen.availWidth - width) / 2;
				top = 0;
				break;

			case 3 :
				left = screen.availWidth - width;
				top = 0;
				break;

			case 4 :
				left = 0;
				top = (screen.availHeight - height) / 2;
				break;

			case 5 :
				left = (screen.availWidth - width) / 2;
				top = (screen.availHeight - height) / 2;
				break;

			case 6 :
				left = screen.availWidth - width;
				top = (screen.availHeight - height) / 2;
				break;

			case 7 :
				left = 0;
				top = screen.availHeight - height;
				break;

			case 8 :
				left = (screen.availWidth - width) / 2;
				top = screen.availHeight - height;
				break;

			case 9 :
				left = screen.availWidth - width;
				top = screen.availHeight - height;
				break;

			default :
				left = (screen.availWidth - width) / 2;
				top = (screen.availHeight - height) / 2;
				break;
		}

		if (cfIsNull(sFeatures)) {
			sFeatures = sFeatures + "left=" + left + ",top=" + top;
		} else {
			sFeatures = sFeatures + ",left=" + left + ",top=" + top;
		}
	}

	window.open(sURL, sName, sFeatures, bReplace);
}

/**
 * @type   : function
 * @access : private
 * @desc   : features 스트링을 파싱하여 array에 셋팅하는 내부 함수
 * @sig    : features, fNameArray, fValueArray, fTypeArray
 * @param  : features    required features를 표현한 스트링
 * @param  : fNameArray  required 추출해야 할 feature의 이름에 대한 array
 * @param  : fValueArray required 추출해야 할 feature의 기본값에 대한 array
 * @param  : fTypeArray  required 추출해야 할 feature의 데이터타입에 대한 array
 * @author : 임재현
 */
function cfParseFeature(features, fNameArray, fValueArray, fTypeArray) {
	if (features == null) {
		return;
	}

	var featureArray = features.split(",");
	var featurePair;

	for (var i = 0; i < featureArray.length; i++) {
		featurePair = featureArray[i].trim().split("=");

		for (var j = 0; j < fNameArray.length; j++) {
			if (featurePair[0] == fNameArray[j]) {
				switch (fTypeArray[j]) {
					case "string" :
						fValueArray[j] = featurePair[1];
						break;
					case "number" :
						fValueArray[j] = Number(featurePair[1]);
						break;
					case "boolean" :
						if (featurePair[1].toUpperCase() == "YES" || featurePair[1].toUpperCase() == "TRUE" || featurePair[1] == "1") {
							fValueArray[j] = true;
						} else {
							fValueArray[j] = false;
						}
						break;
				}
			}
		}
	}
}

/**
 * @type   : function
 * @access : public
 * @desc   : 보고서 popup에서 전체 레코드수/페이지수, 출력가능 수량을 셋팅한다.
 * @sig    : oPagePrintMsg, oTypeGR, oStartPageNo, oEndPageNo
 * @param  : oPagePrintMsg - 총건수/페이지정보를 나타낼 div tag id
 * @param  : oTypeGR - radio button object id
 * @param  : oStartPageNo - start page를 나타낼 emedit object id
 * @param  : oEndPageNo -  end page를 나타낼 emedit object id
 * @author : 조부구
 */
function cfPrintPopupSetting(oPagePrintMsg, oTypeGR, oStartPageNo, oEndPageNo){

		oPagePrintMsg.innerHTML =
			"<table width='300' style='position:absolute; left:'30'; top:'170'; cellspacing='0' cellpadding='0'>"+
			"<tr><td align='left'><font id='oMaxPage' style='font-size:9pt; font-family:굴림; color:#5C8BE0; font-weight:bold;'><font></td>"+
			"<td><font  style='font-size:9pt; font-family:굴림; color:#212863; font-weight:bold;'><font>&nbsp페이지 이상은 출력할수 없습니다.</td></tr></table>";


		//oTypeGR : gauce radio button object id,oStartPageNo : gauce emedit startpage id, oEndPageNo : gauce emedit endpage id
		oMaxPage.innerText = GLB_REPORT_MAXPAGE; //페이지 출력시 주의 페이지 수량

		Parm = window.dialogArguments;

		DSDataid     = Parm.DataId;   //dataset dataid
		pageInfo     = Parm.PageInfo; //page

		cfFillGridHeaderPage(oRegistGGHeader,pageInfo);

		//page_cnt.innerText page수
		//GLB_REPORT_MAXPAGE  최대가능 page수
		if( page_cnt.innerText < GLB_REPORT_MAXPAGE ){
			//최대 페이지보다 실제 페이지가 작은경우 전체출력가능
			oTypeGR.CodeValue     = 1;
			oStartPageNo.text     = 1;
			oEndPageNo.text       = page_cnt.innerText;
			oEndPageNo.ReadOnly   = true;
			oStartPageNo.ReadOnly = true;
		}
		else{
			//최대 페이지보다 실제 페이지가 큰경우 부분출력가능
			oTypeGR.CodeValue = 2;
			oTypeGR.Enable    = false;
		}
}

/**
 * @type   : function
 * @access : private
 * @desc   : html상에서 parent element에 대한 child element 들에 대해 일괄적으로 동일한 함수를 수행시킨다.
 * @sig    : parentObj, fnc[, argArr]
 * @param  : parentObj required parent object
 * @param  : fnc required 각 input element 마다 수행시킬 함수 포인터
 * @param  : argArr optional 함수에 전달할 파라미터. 이 메소드를 통해 호출되는 함수는 무조건 두 개의 파라미터로만
 *           구성되어야 한다. 하나는 처리하려는 element, 나머지 하나는 처리시 필요한 파라미터들의 array 객체이다.
 * @author : 임재현
 */
function cfProcessChildElement(parentObj, fnc, argArr) {
	fnc(parentObj, argArr);

	if (parentObj.all == null) {
		return;
	}

	for (var i = 0; i < parentObj.all.length; i++) {
		fnc(parentObj.all[i], argArr);
	}
}

/**
 * @type   : function
 * @access : public
 * @desc   : 공통메세지에 정의된 메세지를 prompt box 로 보여준다. 만약 패스워드를 입력받는 prompt box를
 *           띄우면서 공통메세지에 정의된 메세지를 보여주고 싶다면 다음과 같이 하면 된다.
 * <pre>
 *     // 공통메세지 영역
 *     var MSG_INPUT_PASSWORD = "@님, 패스워드를 입력하십시오.";
 *     ...
 *     cfPromptMsg(MSG_INPUT_PASSWORD, ["홍길동"], "입력하세요.");
 * </pre>
 * @sig    : msgId[, paramArray[, defaultVal]]
 * @param  : msgId      required lafui.js의 공통 메세지 영역에 선언된 메세지 ID
 * @param  : paramArray optional 메세지에서 '@' 문자와 치환될 스트링 Array. (Array의 index와
 *           메세지 내의 '@' 문자의 순서가 일치한다.)
 * @param  : defaultVal optional prompt box 의 입력필드에 보여줄 기본값.
 * @return : 입력받은 String 혹은 Integer 타입의 패스워드 데이터
 * @author : 임재현
 */
function cfPromptMsg(msgId, paramArray, defaultVal) {
	if (cfIsNull(msgId)) {
		alert("존재하지 않는 메시지입니다.");
		return null;
	}

	return prompt(new coMessage().getMsg(msgId, paramArray), defaultVal);
}

/**
 * @type   : function
 * @access : public
 * @desc   : parent object (Div, Table, FieldSet 태그)에 속한 모든 child object의 값을 초기화한다.
 * @sig    : parentObj[, iniVal]
 * @param  : parentObj required 초기화할 부모 오브젝트
 * @param  : iniVal    optional 초기값
 * @author : 김수호
 */
function cfReset(parentObj, iniVal) {
	cfProcessChildElement(parentObj, cfIniObject);
}

/**
 * @type   : function
 * @access : public
 * @desc   : Paging 을 사용하는 DataSet을 Transaction 을 이용해서 조회해 올 경우에 조회된 후에도 Paging 이 제대로
 *           동작하기 위해서는 Transaction 수행 전에 해당 DataSet의 Paging에 필요한 파라미터들을 미리 저장해 두어야 한다.
 *           그 때 이 함수를 사용한다. 페이징과 관련된 설명은 화면개발가이드를 참고할 것.
 * <pre>
 *      예) oDelivRsltGTR 오브젝트를 통해 Transaction 처리를 하고자 할 때 Transaction을 통해 oDelivRsltGDS DataSet을 읽어오고,
 *          oDelivRsltGDS DataSet이 페이징을 사용해야 하는 경우 아래와 같이 파라미터를 Post() 전에 저장한다.
 *
 *      ...
 *      <b>
 *      var pageParam = getDNS() + "/servlet/kpl.spl.common.svl.SplSVL?cmd=kpl.spl.sb.fnc.cmd.RetrieveDelivRsltListCMD" +
 *                      "&delivYmd=" + oDelivYmd.Text +
 *                      "&delivSeqCd=" + oDelivSeqCd.CodeValue +
 *                      "&sortBy=" + oSortBy.CodeValue +
 *                      "&delivAreaCd=" + oDelivAreaCd.CodeValue +
 *                      "&pageSize=8" +
 *                      "&pageNo=1";
 *
 *      cfSavePageParameter(oDelivRsltGDS, pageParam);
 *      </b>
 *      oDelivRsltGTR.Post();
 * </pre>
 * @sig    : oDataSet, parameter
 * @param  : oDataSet required DataSet 오브젝트
 * @param  : parameter required DataSet의 Paging에 필요한 파라미터를 표현하는 스트링
 * @author : 임재현
 */
function cfSavePageParameter(oDataSet, parameter) {
	GLB_PAGE_PARAMS.put(oDataSet.id, parameter);
}

/**
 * @type   : function
 * @access : public
 * @desc   : Grid를 전체선택한다.
 * <pre>
 *     cfSelectAllGridRows(oDomRegiRecevGDS, oDomRegiRecevGG);
 * </pre>
 * 위의 예에서 oDomRegiRecevGDS 라는 id를 가진 DataSet의 데이터를 보여주는
 * oDomRegiRecevGG 라는 id를 가진 Grid 상에서 모든 Row들을 선택한다.
 * @sig    : dataSet, grid
 * @param  : dataSet required DataSet 오브젝트의 id
 * @param  : grid    required Grid 오브젝트
 * @author : 임재현
 */
function cfSelectAllGridRows(oDataSet, oGrid) {
	oDataSet.MarkAll();
	oGrid.Focus();
}

/**
 * @type   : function
 * @access : public
 * @desc   : 해당 화면에 대한 도움말 창을 띄운다.
 * @sig    : helpId
 * @param  : helpId required 도움말 화면의 아이디
 * @author : 송동혁
 */
function cfShowHelp(helpId) {
	alert("도움말 화면을 준비중입니다.");
}

/**
 * @type   : function
 * @access : public
 * @desc   : 해당 span에 그리드의 총건수를 표시한다.
 * @sig    : spanId, totalRows
 * @param  : spanId required 건수를 표시할 span
 * @param  : totalRows required 총건수
 * @author : 송동혁
 */
function cfShowTotalRows(spanId, totalRows) {
	totalRows = "" + totalRows;

	if (totalRows.length > 3) {
		totalRows = totalRows.substr(0, totalRows.length-3) + "," + totalRows.substr(totalRows.length-3);
	}

	spanId.innerHTML = "총 " + totalRows + "건";
}

/**
 * @type   : function
 * @access : public
 * @desc   : 공통으로 사용하는 에러메시지 창을 띄운다.
 * @sig    : obj
 * @param  : obj required 에러가 난 가우스 오브젝트(DataSet or Transaction 오브젝트중 하나)
 * @author : 임재현
 */
function cfShowError(obj) {
	var errObj = new Object();
	errObj.errCd = obj.ErrorCode;
	errObj.errMsg = obj.ErrorMsg;

	if (obj.ErrorMsg.indexOf("[ERROR") == -1) {
	   alert(obj.ErrorMsg);
	} else {
		window.showModalDialog(GLB_URL_COMMON_PAGE + "error.html", errObj, "dialogWidth:500px; dialogHeight:400px; help:no; status:no; scroll:no")
	}
}

/**
 * @type   : function
 * @access : public
 * @desc   : 가우스 Grid Object에 바인딩 되어 있는 Dataset의 데이터를 정렬(내림/오름차순)하고,
 * 			 Grid object의 컬럼명에 정렬방식에 따른 이미지를 보여준다. ▲(오름차순),▼(내림차순)
 * <pre>
 *    cfSortGrid(oGrid, SortFd);
 *
 * 사용예)
 *
 * 데이터셋의 onloadcompleted event가 발생했을때 그리드의 name에 sort칼럼 표시와
 * 데이터 셋의 정렬 칼럼에 의하여 오름/내림차순으로 데이터가 정렬된다.
 * 만약 가우스 Grid Object의 onclick event를 이용해서 정렬하는 경우는 onclick event가 발생 되었을때 함수를 호출하면된다.
 *
 * 1. Grid Object 선언
 *
 * &lt;object id="oSortGG" classid="CLSID:71E7ACA0-EF63-4055-9894-229B056E9C31"
 * 	 width="0" height="405" style="position:absolute; left:10; top:89"&gt;
 *   &lt;param name="DataID"    value="oSortGDS"&gt;
 *   &lt;param name="Format"    value='
 *  	&lt;c&gt; id="sortcolumn", name="소트"&lt;/c&gt; '&gt;
 *
 * 2. 데이터셋의 onloadcompletd event가 발생했을때 함수를 호출한다.
 *
 * oSortGG: grid Object id, + : 오름차순, sortcolumn : 정렬하고자 하는 데이터 셋의 칼럼
 * &lt;script language="javascript" for="oSortGDS" event="OnLoadCompleted()"&gt;
 * 	cfSortGrid(oSortGG, "+sortcolumn");
 * &lt;/script&gt;
 *
 * 3. 함수 호출이 끝나면 다음과 같이 처리 된다.
 *
 * "&lt;c&gt; id="sortcolumn", name="소트"&lt;/c&gt;"  ==> "&lt;c&gt; id="sortcolumn", name="▲소트"&lt;/c&gt;"
 * </pre>
 * @sig    : oGrid, SortFd
 * @param  : oGrid required 정렬 표시할 Grid object
 * @param  : SortFd required 정렬방식 +(오름차순),-(내림차순)와 정렬하려고 하는 데이터셋의 칼럼아이디를 같이 표현한다.
 *           +colid ==> colid에 해당하는 데이터를 오름 차순으로 정렬한다.
 * @author : 조부구
 */
function cfSortGrid(oGrid, SortFd){
	if (oGrid.tagName == "OBJECT" &&
	    oGrid.attributes.classid.nodeValue.toUpperCase() == "CLSID:AF989B7C-8AC3-40BC-B749-EB335BDFD190" // DataSet
	   ) {
	   	alert("cfSortGrid 함수의 파라미터가 변경되었습니다. 변경전에는 동작하지 않습니다.");
		return;
	}

	var oDataSet = document.all(oGrid.DataId);

	SortGb	  = SortFd.substring(0,1);
	ColId     = SortFd.substring(1,SortFd.length);
	Now_name  = oGrid.ColumnProp(ColId,"name");

	if (oDataSet.SortExpr != '' ){
		old_colid     = oDataSet.SortExpr.substring(1,oDataSet.SortExpr.length);
		old_sortgubn  = oDataSet.SortExpr.substring(0,1);
		old_name  = oGrid.ColumnProp(old_colid,"name").substring(0,1);

		if ( old_name == '▲' || old_name == '▼' ){
			if ( old_colid != ColId ) {
				ReName = oGrid.ColumnProp(old_colid,"name").substring(1,oGrid.ColumnProp(old_colid,"name").length);
				oGrid.ColumnProp(old_colid,"name") = ReName;
			}
			else {
				ReName = oGrid.ColumnProp(ColId,"name").substring(1,oGrid.ColumnProp(ColId,"name").length);
				oGrid.ColumnProp(old_colid,"name") = ReName;
				Now_name = ReName;
				if ( old_sortgubn == '+' ){
					SortGb = '-';
				}
				else {
					SortGb = '+';
				}
			}
		}
	}

	oDataSet.SortExpr = SortGb + ColId;
	oDataSet.Sort();

	SortGb = oDataSet.SortExpr.substring(0,1);
	var SortType = '';
	if (SortGb == '+' ){
		SortType = '▲';
	}
	else {
		SortType = '▼';
	}
	oGrid.ColumnProp(ColId,"name") = SortType + Now_name;
}

/**
 * @type   : function
 * @access : public
 * @desc   : Grid의 컬럼명을 클릭했을 때 데이터를 Sorting 해주는 함수이다. Grid의 id가 oDelivRsltGG 이고
 *           DataSet의 id가 oDelivRsltGDS 라면 다음과 같이 Grid의 OnClick 이벤트 스크립트에 기술해주면 된다.
 * <pre>
 * &lt;script language="javascript" for="oDelivRsltGG" event="OnClick(row, colid)"&gt;
 *     if (row == 0) {           // Grid 상에서 컬럼명 위에서 클릭했을 경우
 *         cfSortGrid(oDelivRsltGDS, colid);
 *     }
 * &lt;/script&gt;
 * </pre>
 * @sig    : oGDS, colid
 * @param  : oGDS  required Grid의 데이터로 사용되는 DataSet 오브젝트의 id
 * @param  : colid required Grid의 OnClick 이벤트 함수의 colid 파라미터
 * @author : 임재현
 */
/*
function cfSortGrid(oGDS, colid) {
	oGDS.SortExpr.substring(0,1) == "+" ?
		oGDS.SortExpr = "-" + colid:
		oGDS.SortExpr = "+" + colid;
	oGDS.Sort();
}
*/

/**
 * @type   : function
 * @access : public
 * @desc   : 가우스 Tree의 Style을 정해진 Style로 바꾸어준다.
 * <pre>
 *     cfStyleTreeView(oDomRegiGTree, "comn");
 * </pre>
 * @sig    : oTree, styleName
 * @param  : oTree     required Tree 오브젝트
 * @param  : styleName required Tree의 style name. 현재는 "comn" 과 "comnOnTab" 만 있다.
 * @author : 임재현
 */
function cfStyleTreeView(oTreeView, styleName) {
/*
	var iDataSet;
	var dateString;

	if (document.all("coTreeViewImageComnGIDS") == null) {
		iDataSet          = document.createElement("<OBJECT>");
		iDataSet.classid  = "CLSID:9F0AA341-1D10-4B18-B70B-6AA49CE7F5D6";
		iDataSet.id       = "coTreeViewImageComnGIDS";
		iDataSet.SyncLoad = "true";
		iDataSet.DataId   = "/common/csv/treeview_imagedata.csv";

		// </head> 태그 직전에 ImageDataSet 삽입
		for (var i = 0; i < document.all.length; i++) {
			if (document.all[i].tagName == "HEAD") {
				document.all[i].insertAdjacentElement("beforeEnd", iDataSet);
				break;
			}
		}
	} else {
		iDataSet = document.all("coTreeViewImageComnGIDS");
	}

	iDataSet.Reset();

	oTreeView.ImgDataID  = "coTreeViewImageComnGIDS";

	// TreeView에서 자식노드를 가지고 있고, 확장되지 않은 Item에서 사용할 이미지칼럼명을 지정한다.
	oTreeView.ImgCColumn = "ImgC";

	// TreeView에서 자식노드를 가지고 있지 않은 Item에 사용될 이미지칼럼명을 지정한다.
	oTreeView.ImgDColumn = "ImgD";

	// TreeView에서 자식노드를 가지고 있고, 확장된 Item에서 사용할 이미지칼럼명을 지정한다.
	oTreeView.ImgOColumn = "ImgO";
*/
	switch (styleName) {
		case "comn" :
			oTreeView.style.fontSize = "9pt";
			break;
			
		case "comn_status" :
			oTreeView.style.fontSize = "9pt";
			break;			

		case "comnOnTab" :
			oTreeView.style.fontSize = "9pt";
			break;

		default :
			break;
	}
}

/**
 * @type   : function
 * @access : public
 * @desc   : 화면상의 입력과 관련된 오브젝트에 대한 유효성 검사를 실시한다. 유효성 검사를 받는 오브젝트들은 "validExp" 라는
 *           속성값을 설정해야 한다. "validExp" 라는 속성은 원래 html 객체에는 정의되어 있지 않은 속성이지만 다른 속성들을
 *           설정하는 것과 같은 방법으로 설정하면 자동으로 해당 오브젝트의 속성으로 인식된다.<br><br>
 *           - 해당 오브젝트에 대한 child 오브젝트들까지도 검사한다. 예를들어, 검사받을 오브젝트들을 &lt;div&gt; 태그로 감싸고
 *             &lt;div&gt; 태그의 id를 파라미터로 준다면 &lt;div&gt; 태그내의 모든 오브젝트들이 자동으로 검사받게 된다. 또,
 *             &lt;table&gt;안에 입력필드들은 &lt;table&gt;의 id를 파라미터로 주면 된다.<br><br>
 *           - 입력값의 앞과 뒤의 공백은 유효성 검사를 하면서 자동으로 trim된다.
 * <pre>
 *    예1)
 *    ...
 *    function fncSave() {
 *        if (<b>cfValidate([oRecevInfo])</b>) {
 *            oDomRegiRecevGTR.post();
 *        }
 *    }
 *    ...
 *
 *    &lt;table <b>id="oRecevInfo"</b> ....&gt;
 *        ...
 *        &lt;object id="oRecevNo" classid="CLSID:D7779973-9954-464E-9708-DA774CA50E13" width="50" <b>validExp="접수번호:yes:length=6"</b>&gt;
 *            &lt;param name="Format"    value="000000"&gt;
 *        &lt;/object&gt;
 *        ...
 *    &lt;/table&gt;
 *    ...
 * </pre>
 * validExp 속성값은 정해진 형식에 맞게 작성되어야 하는데 형식은 오브젝트의 종류에 따라 두 가지로 나뉜다.<br>
 * <pre>
 *    1. 일반 오브젝트의 경우 (예1 참조)
 *        "item_name:필수여부:valid_expression"
 *
 *        - "item_name"에는 해당 항목에 대한 이름을 기술한다.
 *        - "필수여부"에는 해당 오브젝트가 필수 항목인지 여부를 yes|true|1 혹은 no|false|0 타입으로 기술한다.
 *        - "valid_expression" 은  cfValidateValue 함수의 설명을 참조하기 바란다.
 *        - 필수항목인지만 체크하려면 "valid_expression" 을 표기하지 않으면 된다.
 *          예)
 *          &lt;object id="oDelivYmd" classid="CLSID:D7779973-9954-464E-9708-DA774CA50E13" width="80" <b>validExp="배달일자:yes"</b>&gt;
 *              ...
 *			&lt;/object&gt;
 *        - validExp 내에 임의로 ",", ":", "=", "&", 문자를 사용하고자 한다면 "\\,", "\\:", "\\=", "\\&" 라고 표기해야 한다.<br>
 *
 *
 *    2. 가우스 Grid 오브젝트의 경우
 *        "column_id:item_name:필수여부[:valid_expression[:key]][,column_name:item_name:필수여부[:valid_expression[:key]]]..."
 *
 *        - column_id 에는  Grid와 연결된 DataSet의 실제 컬럼 id 를 적어준다.
 *
 *        - <font color=blue><b>dataName</b></font> 이라는 속성도 기술해 주어야 한다. dataName은 해당 DataSet
 *          을 표현하는 이름을 기술해 주면 된다.
 *
 *        - <font color=blue><b>validFeatures</b></font> 라는 속성은 필요에 따라 기술해 주어야 한다. validFeatures은 Grid Validation
 *          수행시에 필요한 수행조건을 기술해 주는 속성으로써 기술해 주지 않으면 기본 수행조건이 자동으로 적용된다.
 *          표현하는 형식은 <b>validFeatures="수행조건명1=수행조건값1,수행조건명2=수행조건값2, ... 수행조건명n=수행조건값n"</b> 이다.
 *          현재 사용가능한 수행조건은 다음과 같다.
 *
 *          ignoreStatus : 변경사항이 없는 Row 에 대해서도 validation을 수행할지 여부. (yes|true|1 or no|false|0)
 *
 *        예)
 *
 *        cfValidate([oDomRegiRecevGG]);
 *        ...
 *        &ltobject id="oDomRegiRecevGG" classid="CLSID:71E7ACA0-EF63-4055-9894-229B056E9C31"
 *           width="174" height="233" style="position:absolute; left:10; top:73;" <b>dataName="배달결과리스트"</b> <b>validFeatures="ignoreStatus=yes"</b>
 *         <b>validExp="regiNo:등기번호:yes:length=13:key,
 *                  sendPrsnZipNo:발송인우편번호:yes:length=6,
 *                  recPrsnZipNo:수취인우편번호:yes:length=6
 *                 "</b>
 *        &gt;
 *
 *        - 만약 item_name을 기술하지 않았을 경우에는 Grid의 column_id에 해당하는 컬럼의 컬럼명으로 자동으로 대체된다.
 *          예) validExp="regiNo::yes:length=13, ..."
 *
 *        - 만약 컬럼이 key컬럼일 경우에는 끝에 "key" 라고 명시해 준다. "key" 라고 명시해 주면 다른 Row와 데이터가 중복되었을 때
 *          에러를 발생시킨다. key컬럼이 여럿일 경우에는 key컬럼들을 묶어서 하나의 key로 인식하기 때문에 key컬럼중에 하나만
 *          중복이 되지 않아도 전체가 중복되지 않은 것으로 처리된다. key컬럼들을 믂어서 처리하지 않고 key컬럼별로 개별적인
 *          중복체크를 원할 경우에는 "singleKey" 라고 명시하면 된다.
 *          단, key를 명시해 줄 경우에는 valid_expression 을 반드시 기입해 주고 기입해 줄 내용이 없더라도
 *          ':' 을 삽입해야 한다.
 *          예) validExp="regiNo:등기번호:yes::key, ...
 *
 *        - 나머지는 1의 경우와 같다.
 * </pre>
 * @sig    : objArr
 * @param  : objectArr required 유효성검사를 하고자 하는 오브젝트들의 Array.
 * @return : boolean. 유효성 여부.
 * @author : 임재현
 */
function cfValidate(obj) {
	if (cfIsNull(obj)) {
		return;
	}

	var objArr;
	var oElement;
	var validYN = false;

	if (obj.length == null) {
		objArr = new Array(1);
		objArr[0] = obj;
	} else {
		objArr = obj;
	}

	for (var objArrIdx = 0; objArrIdx < objArr.length; objArrIdx++) {
		oElement = objArr[objArrIdx];

		switch (oElement.tagName) {
			case "TABLE":
			case "DIV":
			case "FIELDSET":
				for (var i = 0; i < oElement.all.length; i++) {
					if (!cfValidateElement(oElement.all[i])) {
						return false;
					}
				}

				break;

			default:
				if (!cfValidateElement(oElement)) {
					return false;
				}
		}
	}

	return true;
}

/**
 * @type   : function
 * @access : private
 * @desc   : 가우스와 html 의 모든 오브젝트에 대해 유효성 검사를 한다.
 * @sig    : oElement
 * @param  : oElement required 검사 대상 Element.
 * @return : boolean. 유효성 여부.
 * @author : 임재현
 */
function cfValidateElement(oElement) {
	if (oElement.tagName == "OBJECT" &&
	    oElement.attributes.classid.nodeValue.toUpperCase() == "CLSID:71E7ACA0-EF63-4055-9894-229B056E9C31"
	   ) {
		return cfValidateGrid(oElement);
	} else {
		return cfValidateItem(oElement);
	}
}


/**
 * @type   : function
 * @access : private
 * @desc   : 가우스 컴포넌트 중에서 DataSet을 제외한 모든 오브젝트와 html의 모든 오브젝트에 대해 유효성 검사를 한다.
 * @sig    : oElement
 * @param  : oElement required 검사 대상 Element.
 * @return : boolean. 유효성 여부.
 * @author : 임재현
 */
function cfValidateItem(oElement) {
	if (cfIsNull(oElement.validExp)) {
		return true;
	}

	var value;
	var itemValidExp = new covItemValidExp(oElement.validExp);

	switch (oElement.tagName) {
		case "INPUT":

		case "SELECT":

		case "TEXTAREA":
			oElement.value = oElement.value.trim();  // element의 값을 trim 시켜준다.
			value = oElement.value;
			break;

		case "OBJECT":
			switch (oElement.attributes.classid.nodeValue.toUpperCase()) {
				case "CLSID:FD4C6571-DD20-11D2-973D-00104B15E56F": // CodeCombo Component
				case "CLSID:F73C0958-D8FE-43A5-9BB0-0F651C5A2BCC": // Radio Component
					oElement.CodeValue = (oElement.CodeValue == null) ? null : oElement.CodeValue.trim();  // element의 값을 trim 시켜준다.
					value = oElement.CodeValue;
                    break;

                case "CLSID:1455BE02-C41B-4115-B21C-32380507DC8F": // TextArea Component
				case "CLSID:5C32688E-CEBE-419D-9C63-0704A2331EEC": // InputFile Component
				case "CLSID:D7779973-9954-464E-9708-DA774CA50E13": // EMedit Component
					oElement.Text = (oElement.Text == null) ? null : oElement.Text.trim();  // element의 값을 trim 시켜준다.
					value = oElement.Text;
                    break;

                default:
                	break;
			}

			break;

		default:
			return true;
	}

	if (!itemValidExp.validate(value)) {
		alert(new coMessage().getMsg(itemValidExp.errMsg, [itemValidExp.itemName]));

		if(oElement.enable != false && oElement.disabled!=true) {
			oElement.focus();
		}

		return false;
	}

	return true;
}

/**
 * @type   : function
 * @access : public
 * @desc   : 가우스의 Grid에 대해 유효성 검사를 한다. 유효성 검사를 위해서는 Grid의 DataId에 지정된 DataSet에 validExp 속성이
 *           지정되어 있어야 한다. 지정방법은 cfValidate 함수에 대한 설명을 참조하기 바란다. (내부적으로는 Grid를 검사하는 것이 아니라
 *           Grid의 DataId에 지정된 DataSet에 대한 유효성 검사이다.)
 * @sig    : oGrid[, row[, colId]]
 * @param  : oGrid required 검사 대상 Grid.
 * @param  : row   optional 검사하고자 하는 row 번호
 * @param  : colId optional 검사하고자 하는 컬럼의 id
 * @return : boolean. 유효성 여부.
 * @author : 임재현
 */
function cfValidateGrid(oGrid, row, colId) {
	if (cfIsNull(oGrid.validExp)) {
		return true;
	}

	var dataName = oGrid.dataName;
	var validFeatures = oGrid.validFeatures;
	var oDataSet = document.all(oGrid.DataId);
	var gridValidExp = new covGridValidExp(oGrid);
	var errMsg = "";

	var featureNames  = ["ignoreStatus"];
	var featureValues = [false];
	var featureTypes  = ["boolean"];

	if (validFeatures != null) {
		cfParseFeature(validFeatures, featureNames, featureValues, featureTypes);
	}

	var ignoreStatus = featureValues[0];

	if (!gridValidExp.validate(row, colId, ignoreStatus)) {
		alert(new coMessage().getMsg("@의 @번째 데이터에서 ", [dataName, String(gridValidExp.errRow)]) +
		      new coMessage().getMsg(gridValidExp.errMsg, [gridValidExp.errItemName])
		     );
//		oDataSet.RowPosition = gridValidExp.errRow;  // 이순간 또다시 CanRowPosChange 이벤트가 발생하여 무한루프에 빠진다.
        if (oGrid.MultiRowSelect == false) {  // Grid의 MultiRowSelect 속성이 false일 경우에는 RowMark, MarkRows가
        	oGrid.MultiRowSelect = true;      // 지정한 row에 제대로 Marking을 하지 못한다. 따라서...
    		oDataSet.ClearAllMark();
    		oDataSet.RowMark(gridValidExp.errRow) = 1;
    		oGrid.SetColumn(gridValidExp.errColId);
    		oGrid.Focus();
            oGrid.MultiRowSelect = false;
        } else {
    		oDataSet.ClearAllMark();
    		oDataSet.RowMark(gridValidExp.errRow) = 1;
    		oGrid.SetColumn(gridValidExp.errColId);
    		oGrid.Focus();
        }

		return false;
	}

	return true;
}

/**
 * @type   : function
 * @access : public
 * @desc   : 사용자의 입력값이 Byte로 환산된 최대길이를 넘을 경우 입력이 안되도록 하는 함수. <br>
 *           안타깝게도 Windows XP 환경에서는 한글에 대한 키이벤트가 발생하지 않아서 동작하지 않는다.<br>
 *           오브젝트 선언시 onkeydown 이벤트에 다음과 같이 기술해 주어야만 한다.
 * <pre>
 *     onkeydown="cfValidateMaxByteLength(this, max_byte_length)"
 *     (여기서 max_byte_length 자리에는 Byte로 환산시 최대길이를 숫자로 적어준다.)
 *
 *     예)
 *     &lt;input type="text" size="10" onkeydown="cfValidateMaxByteLength(this, 10)"&gt;
 * </pre>
 *           현재는 html의 text input, textarea 와 가우스의 EMEdit 에만 적용된다.
 * @sig    : oElement, length
 * @param  : oElement required 입력필드 객체
 * @param  : length   required max byte length
 * @author : 임재현
 */
function cfValidateMaxByteLength(oElement, length) {
	var value = "";

	if (event.keyCode == 8 ||   // backspace
	    event.keyCode == 35 ||  // end key
	    event.keyCode == 36 ||  // home key
	    event.keyCode == 37 ||  // left key
	    event.keyCode == 38 ||  // up key
	    event.keyCode == 39 ||  // right key
	    event.keyCode == 40 ||  // down key
	    event.keyCode == 46     // delete key
	   ) {
	   	return true;
	}

	switch (cfGetElementType(oElement)) {
		case "TEXT" :
		case "TEXTAREA" :
			value = oElement.value;
			break;

		case "GE" :
		case "GTA" :
			value = oElement.Text;
			break;

		default :
			return;
	}

	if (cfGetByteLength(value) > length ) {
  		oElement.blur();
		oElement.focus();
     	oElement.value = oElement.value.substr(0, oElement.value.length - 1);
		event.returnValue = false;
		return;
	}

	if (oElement.onkeyup == null) {
		oElement.onkeyup =
			function() {
				if (cfGetByteLength(oElement.value) > length) {
			    	oElement.blur();
			        oElement.focus();
			        oElement.value = oElement.value.substr(0, oElement.value.length - 1);
				}
			}
	}

	if (cfGetByteLength(value) == length ) {
       // 완성한글 : 0xAC00 <= c && c <= 0xD7A3
       // 자음 : 0x3131 <= c
       // 모음 : c <= 0x318E
		var c = value.charCodeAt(value.length - 1);

		if ( (0xAC00 <= c && c <= 0xD7A3) || (0x3131 <= c && c <= 0x318E) ) {
			event.returnValue = true;
    	} else {
			event.returnValue = false;
		}
	} else {
		event.returnValue = true;
	}
}

/**
 * @type   : function
 * @access : public
 * @desc   : 특정 값에 대한 유효성검사를 수행한다.
 * <pre>
 *     cfValidateValue(50, "minNumber=100");
 * </pre>
 * 위의 경우 50은 최소값 100을 넘지 않으므로 false가 리턴된다.<br>
 * 유효성 검사를 수행하기 위해서는 검사조건을 명시해야 하는데
 * 검사조건은 'valid expression' 이라고 불리우는 String 값으로 표현된다. valid expression에 대한 표기형식은
 * 다음과 같다.
 * <pre>
 *  	validator_name=valid_value[&validator_name=valid_value]..
 *
 *  	예) "minNumber=100"
 * </pre>
 * - validator_name은 검사유형을 의미하며 valid_value는 기준 값이 된다. <br>
 * - 검사항목은 하나 이상일 수 있으며 검사항목간에는 "&" 문자로 구분하여 필요한 만큼 나열하면 된다. <br>
 * - valid_value에 ",", ":", "=", "&", 문자를 사용하고자 한다면 "\\,", "\\:", "\\=", "\\&" 라고 표기해야 한다.<br>
 * - 위의 예에서는 "minNumber" (최소값)라는 유효성 검사항목을 명시하였고 minNumber 에대한 기준값으로 "100" 이 설정되어 있다.
 * 만일 100보다 작은 값을 입력했을 때는 100 이상의 값을 입력하라는 alert box가 뜨게 된다.
 * - validator_name은 미리 정의되어 있는 것만 사용할 수 있고 각 검사유형마다 valid_value의 형태도 다르다.(valid_value가 없는 것도 있다.)
 * 현재 정의된 검사유형은 다음과 같다.
 * <br><br>
 * <table border=1 style="border-collapse:collapse; border-width:1pt; border-style:solid; border-color:000000;">
 * 		<tr>
 * 			<td align="center" bgcolor="#CCCCFFF">검사유형</td>
 * 			<td align="center" bgcolor="#CCCCFFF">기준값 형태</td>
 * 			<td align="center" bgcolor="#CCCCFFF">설명</td>
 * 			<td align="center" bgcolor="#CCCCFFF">예</td>
 * 		</tr>
 * 		<tr>
 * 			<td>length</td>
 * 			<td>0보다 큰 정수</td>
 * 			<td>자릿수 검사. 입력값의 자릿수가 기준값과 일치하는지를 검사한다. 일반적으로 HTML에서는 한글, 영문, 숫자 모두 1자리씩 인식된다.</td>
 * 			<td>length=6</td>
 * 		</tr>
 * 		<tr>
 * 			<td>byteLength</td>
 * 			<td>0보다 큰 정수</td>
 * 			<td>Byte로 환산된 자릿수 검사. 입력값의 자릿수를 byte로 환산하여 자릿수가 기준값과 일치하는지를 검사한다.(숫자 및 영문은 1byte, 한글은 2byte이다.)</td>
 * 			<td>byteLength=6</td>
 * 		</tr>
 * 		<tr>
 * 			<td>minLength</td>
 * 			<td>0보다 큰 정수</td>
 * 			<td>최소자릿수 검사. 입력값의 자릿수가 기준값 이상이 되는지를 검사한다.</td>
 * 			<td>minLength=6</td>
 * 		</tr>
 * 		<tr>
 * 			<td>minByteLength</td>
 * 			<td>0보다 큰 정수</td>
 * 			<td>Byte로 환산된 최소자릿수 검사. 입력값의 자릿수를 byte로 환산하여 자릿수가 기준값 이상이 되는지를 검사한다.(숫자 및 영문은 1byte, 한글은 2byte이다.)</td>
 * 			<td>minByteLength=6</td>
 * 		</tr>
 * 		<tr>
 * 			<td>maxLength</td>
 * 			<td>0보다 큰 정수</td>
 * 			<td>최대자릿수 검사. 입력값의 자릿수가 기준값 이하가 되는지를 검사한다.</td>
 * 			<td>maxLength=6</td>
 * 		</tr>
 * 		<tr>
 * 			<td>maxByteLength</td>
 * 			<td>0보다 큰 정수</td>
 * 			<td>Byte로 환산된 최대자릿수 검사. 입력값의 자릿수를 byte로 환산하여 자릿수가 기준값 이하가 되는지를 검사한다.(숫자 및 영문은 1byte, 한글은 2byte이다.)</td>
 * 			<td>maxByteLength=6</td>
 * 		</tr>
 * 		<tr>
 * 			<td>number</td>
 * 			<td>None or decimal format string. decimal format string 형식은 "(정수자릿수.소수자릿수)" 이다.</td>
 * 			<td>숫자검사. 입력값이 숫자인지를 검사한다. 만일 입력값에 대한 decimal format을 지정하였을 때는 format에 맞는지도 검사한다.</td>
 * 			<td>number, number=(5.2)</td>
 * 		</tr>
 * 		<tr>
 * 			<td>minNumber</td>
 * 			<td>숫자</td>
 * 			<td>최소수 검사. 입력값이 최소한 기준값 이상이 되는지를 검사한다.</td>
 * 			<td>minNumber=100</td>
 * 		</tr>
 * 		<tr>
 * 			<td>maxNumber</td>
 * 			<td>숫자</td>
 * 			<td>최대수 검사. 입력값이 기준값 이하인지를 검사한다.</td>
 * 			<td>maxNumber=300</td>
 * 		</tr>
 * 		<tr>
 * 			<td>inNumber</td>
 * 			<td>"숫자~숫자" 형식으로 표기.</td>
 * 			<td>범위값 검사. 입력값이 기준이 되는 두 수와 같거나 혹은 두 수 사이에 존재하는 값인지를 검사한다.</td>
 * 			<td>inNumber=100~300</td>
 * 		</tr>
 * 		<tr>
 * 			<td>minDate</td>
 * 			<td>YYYYMMDD 형식의 날짜 스트링.</td>
 * 			<td>최소날짜 검사. 입력된 날짜가 기준날짜이거나 기준날짜 이후인지를 검사한다.</td>
 * 			<td>minDate=20020305</td>
 * 		</tr>
 * 		<tr>
 * 			<td>maxDate</td>
 * 			<td>YYYYMMDD 형식의 날짜 스트링. 예) maxDate=20020305</td>
 * 			<td>최대날짜 검사. 입력된 날짜가 기준날짜이거나 기준날짜 이전인지를 검사한다.</td>
 * 			<td>maxDate=20020305</td>
 * 		</tr>
 * 		<tr>
 * 			<td>format</td>
 * 			<td>format character들과 다른 문자들을 조합한 스트링.<br>
 * 				<table>
 * 					<tr>
 * 						<td><b>format character</b></td>
 * 						<td><b>desc</b></td>
 * 					</tr>
 * 					<tr>
 * 						<td>#</td>
 * 						<td>문자와 숫자</td>
 * 					</tr>
 * 					<tr>
 * 						<td>h, H</td>
 * 						<td>한글(H는 공백포함)</td>
 * 					</tr>
 * 					<tr>
 * 						<td>A, Z</td>
 * 						<td>문자(Z는 공백포함)</td>
 * 					</tr>
 * 					<tr>
 * 						<td>0, 9</td>
 * 						<td>숫자 (9는 공백포함)</td>
 * 					</tr>
 * 				</table>
 * 			</td>
 * 			<td>형식 검사. 입력된 값이 지정된 형식에 맞는지를 검사한다.</td>
 * 			<td>format=000-000</td>
 * 		</tr>
 * 		<tr>
 * 			<td>ssn</td>
 * 			<td>주민등록번호 13자리</td>
 * 			<td>주민등록번호 검사. 입력한 주민등록번호가 유효한지를 검사한다.</td>
 * 			<td>ssn</td>
 * 		</tr>
 * 		<tr>
 * 			<td>csn</td>
 * 			<td>사업자등록번호 10자리</td>
 * 			<td>사업자등록번호 검사. 입력한 사업자등록번호가 유효한지를 검사한다.
 *              (예, 2019009930)
 *          </td>
 * 			<td>csn</td>
 * 		</tr>
 * 		<tr>
 * 			<td>filterIn</td>
 * 			<td>필터링하여 얻고자 하는 스트링을 ";"문자를 구분자로 사용하여 나열한다.(단 ";" 문자를 필터링하고 싶을 땐 "\;"라고 표기한다.
 *          </td>
 * 			<td>입력값에 지정된 문자나 스트링 이외에 다른 값이 있는지를 검사한다. 하나도 없다면 유효하다.</td>
 * 			<td>filter=%;<;임재현;\\;;haha<br>(입력값 내에 "%","<","임재현",";","haha" 중에 하나라도 있는지 검사한다.)
 *          </td>
 * 		</tr>
 * 		<tr>
 * 			<td>filterOut</td>
 * 			<td>필터링하여 걸러내고 싶은 스트링을 ";"문자를 구분자로 사용하여 나열한다.(단 ";" 문자를 필터링하고 싶을 땐 "\;"라고 표기한다.
 *          </td>
 * 			<td>입력값에 지정된 문자나 스트링이 있는지를 검사한다. 하나도 없다면 유효하다.</td>
 * 			<td>filter=%;<;임재현;\\;;haha<br>(입력값 내에 "%","<","임재현",";","haha" 중에 하나라도 있는지 검사한다.)
 *          </td>
 * 		</tr>
 * 		<tr>
 * 			<td>email</td>
 * 			<td>이메일 주소</td>
 * 			<td>입력한 메일주소가 유효한 이메일 형식인지를 검사한다.</td>
 * 			<td>email</td>
 * 		</tr>
 * 		<tr>
 * 			<td>date</td>
 * 			<td>format character의 조합으로 이루어진 날자에 대한 패턴 스트링.<br>
 * 				<table>
 * 					<tr>
 * 						<td><b>format character</b></td>
 * 						<td><b>desc</b></td>
 * 					</tr>
 * 					<tr>
 * 						<td>YYYY</td>
 * 						<td>4자리 년도</td>
 * 					</tr>
 * 					<tr>
 * 						<td>YY</td>
 * 						<td>2자리 년도. 2000년 이후</td>
 * 					</tr>
 * 					<tr>
 * 						<td>MM</td>
 * 						<td>2자리 숫자의 달</td>
 * 					</tr>
 * 					<tr>
 * 						<td>DD</td>
 * 						<td>2자리 숫자의 일</td>
 * 					</tr>
 * 					<tr>
 * 						<td>hh</td>
 * 						<td>2자리 숫자의 시간. 12시 기준</td>
 * 					</tr>
 * 					<tr>
 * 						<td>HH</td>
 * 						<td>2자리 숫자의 시간. 24시 기준 </td>
 * 					</tr>
 * 					<tr>
 * 						<td>mm</td>
 * 						<td>2자리 숫자의 분</td>
 * 					</tr>
 * 					<tr>
 * 						<td>ss</td>
 * 						<td>2자리 숫자의 초</td>
 * 					</tr>
 * 				</table>
 * 			</td>
 * 			<td>날짜 검사. 입력된 스트링값을 날짜로 환산하여 유효한 날짜인지를 검사한다.</td>
 * 			<td>date=YYYYMMDD  일 때 입력값이 '20020328' 일 경우 -> 유효<br>
 *              date=YYYYMMDD  일 때 입력값이 '20020230' 일 경우 -> 오류<br>
 *              date=Today is YY-MM-DD' 일 때 입력값이 'Today is 02-03-28' 일 경우 -> 유효<br><br>
 * 				참고) format문자가 중복해서 나오더라도 처음 나온 문자에 대해서만 format문자로 인식된다.
 *                    YYYY와 YY, hh와 HH 도 중복으로 본다. 날짜는 년,월이 존재할 때만 정확히 체크하고
 *                    만일 년, 월이 없다면 1 ~ 31 사이인지만 체크한다.
 * 			</td>
 * 		</tr>
 * </table>
 * @sig    : value, validExp
 * @param  : value    required 검사 대상이 되는 값.
 * @param  : validExp required 사용자가 지정한 Valid Expression String.
 * @return : boolean. 유효성 여부.
 * @author : 임재현
 */
function cfValidateValue(value, validExp) {
	var valueValidExp = new covValueValidExp(validExp);

	if (!valueValidExp.validate(value)) {
		return false;
	}

	return true;
}

/**
 * @type   : function
 * @access : public
 * @desc   : Grid의 선택된 Row들을 취소한다.
 * <pre>
 *     cfUndoGridRows(oDomRegiRecevGG);
 * </pre>
 * 위의 예에서 oDomRegiRecevGG의 현재 선택된 row들은 모두 취소된다.<br><br>
 * <font color=red>
 * 기존의 cfUndoGridRows 함수의 파라미터는 DataSet이었으나 파라미터가 Grid로 바뀌었다.
 * 하지만 기존에 파라미터를 DataSet으로 사용한 경우에도 변경없이 동작되도록 작성되었다.
 * </font>
 * @sig    : oGrid
 * @param  : oGrid required Grid 오브젝트
 * @author : 임재현
 */
function cfUndoGridRows(obj) {
	if (obj.attributes.classid == null) {
		return;
	}

	var oDataSet;
	var oGrid;

	switch (obj.attributes.classid.nodeValue.toUpperCase()) {
		case "CLSID:AF989B7C-8AC3-40BC-B749-EB335BDFD190": // DataSet Component
			oDataSet = obj;
			break;
		case "CLSID:71E7ACA0-EF63-4055-9894-229B056E9C31": // Grid Component
			oGrid    = obj;
			oDataSet = document.all(oGrid.DataID);
			break;
	}

	if (oGrid != null && oGrid.MultiRowSelect == false) {
		oDataSet.Undo(oDataSet.RowPosition);
		return;
	} else {
		for (var i = oDataSet.CountRow; i > 0; i--) {
			if (oDataSet.RowMark(i)) {
				oDataSet.Undo(i);
			}
		}
	}
}

//---------------------------------------- 이하 객체선언 ------------------------------------------------------------------------------//

///////////////////////////// coMessage /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : 메세지를 관리하는 객체이다.
 * @author : 임재현
 */
function coMessage() {
	// method
	this.getMsg = coMessage_getMsg;
}

/**
 * @type   : method
 * @access : public
 * @object : coMessage
 * @desc   : 공통메세지에 정의된 메세지를 치환하여 알려준다.
 * @sig    : message[, paramArray]
 * @param  : message    required lafui.js의 공통 메세지 영역에 선언된 메세지 ID
 * @param  : paramArray optional 메세지에서 '@' 문자와 치환될 스트링 Array. (Array의 index와
 *           메세지 내의 '@' 문자의 순서가 일치한다.)
 * @return : 치환된 메세지 스트링
 */
function coMessage_getMsg(message, paramArray) {
	if (cfIsNull(message)) {
		return null;
	}

	var index = 0;
	var re = /@/g;
	var count = 0;

	if (paramArray == null) {
		return message;
	}

	while ( (index = message.indexOf("@", index)) != -1) {
		if (paramArray[count] == null) {
			paramArray[count] = "";
		}

		message = message.substr(0, index) + String(paramArray[count]) +
		          message.substring(index + 1);

		index = index + String(paramArray[count++]).length;
	}

	return message;
}

///////////////////////////// coGridColumn /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : Grid 에 선언된 컬럼정보를 담고있는 객체이다.
 * @author : 임재현
 */
function coGridColumn() {
	this.attrNames = new Array();
	this.attrValues = new Array();
	this.attrCnt = 0;

	// method
	this.hasAttribute = coGridColumn_hasAttribute;
	this.setAttribute = coGridColumn_setAttribute;
	this.getAttribute = coGridColumn_getAttribute
}

/**
 * @type   : method
 * @access : public
 * @object : coGridColumn
 * @desc   : 컬럼에 특정 속성이 정의되어 있는지 알려준다.
 * @sig    : attrName
 * @param  : attrName required 속성명
 * @return : 속성 존재여부
 */
function coGridColumn_hasAttribute(attrName) {
	for (var i = 0; i < this.attrCnt; i++) {
		if (attrName.toUpperCase() == this.attrNames[i].toUpperCase()) {
			return true;
		}
	}

	return false;
}

/**
 * @type   : method
 * @access : public
 * @object : coGridColumn
 * @desc   : 컬럼에 새로운 속성을 추가한다.
 * @sig    : attrName, attrValue
 * @param  : attrName required 속성명
 * @param  : attrValue required 속성값
 * @return : 속성 존재여부
 */
function coGridColumn_setAttribute(attrName, attrValue) {
	this.attrNames[this.attrCnt]  = attrName.toUpperCase();
	this.attrValues[this.attrCnt] = attrValue;
	this.attrCnt++;
}

/**
 * @type   : method
 * @access : public
 * @object : coGridColumn
 * @desc   : 컬럼의 특정 속성값을 알려준다.
 * @sig    : attrName
 * @param  : attrName required 속성명
 * @return : 속성값
 */
function coGridColumn_getAttribute(attrName) {
	for (var i = 0; i < this.attrCnt; i++) {
		if (this.attrNames[i] == attrName) {
			return this.attrValues[i];
		}
	}
}

///////////////////////////// coGridFormat /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : Grid Format을 파싱한 후 정보를 저장한다.
 * @author : 임재현
 */
function coGridFormat(format) {
	this.format = format;
	this.columns = new Array();

	// method
	this.existsColumn = coGridFormat_existsColumn;
	this.parse  = coGridFormat_parse;

	// initialize
	this.parse();
}

/**
 * @type   : method
 * @access : parse
 * @object : coGridFormat
 * @desc   : 파싱한다.
 */
function coGridFormat_parse() {
	var tagRE = /<(fc|c|g|fg|x|fx)>/i;
	var colAttrRE = /([\w_]+)\s*=\s*['"]?([^<'"\s,]+)/i;
	var gFormat = this.format;
	var tagMatch;
	var colAttrData;
	var colAttrMatch;
	var colAttrName;
	var colAttrValue;
	var colCnt = 0;

	while ((tagMatch = gFormat.match(tagRE)) != null) {
		this.columns[colCnt] = new coGridColumn();
		colAttrData = gFormat.substring(tagMatch.lastIndex, gFormat.indexOf("<", tagMatch.lastIndex));

		while ( (colAttrMatch = colAttrData.match(colAttrRE)) != null) {
			colAttrName = colAttrMatch[1].toUpperCase();
			colAttrValue = colAttrMatch[2];
			this.columns[colCnt].setAttribute(colAttrName, colAttrValue);
			colAttrData = colAttrData.substr(colAttrMatch.lastIndex);
		}

		gFormat = gFormat.substr(tagMatch.lastIndex);
		colCnt++;
	}
}

/**
 * @type   : method
 * @access : public
 * @object : coGridFormat
 * @desc   : Grid에 선언된 컬럼들 중에서 특정 colid를 가진 컬럼이 존재하는지를 알려준다.
 * @sig    : colId
 * @param  : colId required 속성명
 * @return : 컬럼 존재여부
 */
function coGridFormat_existsColumn(colId) {
	for (var i = 0; i < this.columns.length; i++) {
		if (this.columns[i].hasAttribute("ID") &&
		    this.columns[i].getAttribute("ID") == colId) {
			return true;
		}
	}

	return false;
}

///////////////////////////// coMap /////////////////////////////
/**
 * @type   : object
 * @access : public
 * @desc   : String parameter 에 대한 name과 value 쌍들을 가진 객체
 * @author : 임재현
 */
function coMap() {
	// fields

	this.names = new Array();
	this.values = new Array();
	this.count = 0;

	// methods
	this.getValue          = coMap_getValue;
	this.put               = coMap_put;
	this.getNameAt         = coMap_getNameAt;
	this.getValueAt        = coMap_getValueAt;
	this.size              = coMap_size;
	this.getMaxNameLength  = coMap_getMaxNameLength;
}

/**
 * @type   : method
 * @access : public
 * @object : coMap
 * @desc   : name에 맞는 파라미터값을 리턴한다.
 * @sig    : name
 * @param  : name required map의 name으로 사용할 값
 * @return : 파라미터값
 */
function coMap_getValue(name) {
	for (var i = 0; i < this.count; i++) {
		if (this.names[i] == name) {
			return this.values[i];
		}
	}

	return null;
}

/**
 * @type   : method
 * @access : public
 * @object : coMap
 * @desc   : 새로운 map을 추가한다. 같은 name가 존재할 경우 overwrite한다.
 * @sig    : name, value
 * @param  : name  required map의 name로 사용할 값
 * @param  : value required map의 value로 사용할 값
 * @return : 파라미터값
 */
function coMap_put(name, value) {
	for (var i = 0; i < this.count; i++) {
		if (this.names[i] == name) {
			this.values[i] = value;
			return;
		}
	}

	this.names[this.count] = name;
	this.values[this.count++] = value;
}

/**
 * @type   : method
 * @access : public
 * @object : coMap
 * @desc   : 지정된 index에 있는 map의 name을 알려준다.
 * @sig    : index
 * @param  : index - map의 index
 * @return : name
 */
function coMap_getNameAt(index) {
	return this.names[index];
}

/**
 * @type   : method
 * @access : public
 * @object : coMap
 * @desc   : 지정된 index에 있는 map의 value를 알려준다.
 * @sig    : index
 * @param  : index required map의 index
 * @return : value
 */
function coMap_getValueAt(index) {
	return this.values[index];
}

/**
 * @type   : method
 * @access : public
 * @object : coMap
 * @desc   : map의 name-value 쌍의 갯수를 알려준다.
 * @return : name-value 쌍의 갯수
 */
function coMap_size() {
	return this.count;
}

/**
 * @type   : method
 * @access : public
 * @object : coMap
 * @desc   : map 내의 name 값들을 String으로 환산하여 최대길이를 알려준다.
 * @return : max name length
 */
function coMap_getMaxNameLength() {
	var maxLength = 0;

	for (var i = 0; i < this.count; i++) {
		if (String(this.names[i]).length > maxLength) {
			maxLength = String(this.names[i]).length;
		}
	}

	return maxLength;
}

///////////////////////////// coParameterMap /////////////////////////////
/**
 * @type   : object
 * @access : public
 * @desc   : String parameter 에 대한 name과 value 쌍들을 가진 객체
 * @author : 임재현
 */
function coParameterMap() {
	// fields

	/**
	 * @type   : field
	 * @access : private
	 * @object : coParameterMap
	 * @desc   : 파라미터 이름을 담고있는 array
	 */
	this.names = new Array();

	/**
	 * @type   : field
	 * @access : private
	 * @object : coParameterMap
	 * @desc   : 파라미터 값을 담고있는 array
	 */
	this.values = new Array();

	/**
	 * @type   : field
	 * @access : private
	 * @object : coParameterMap
	 * @desc   : 파라미터의 개수
	 */
	this.count = 0;

	// methods
	this.getValue          = coParameterMap_getValue;
	this.put               = coParameterMap_put;
	this.getNameAt         = coParameterMap_getNameAt;
	this.getValueAt        = coParameterMap_getValueAt;
	this.size              = coParameterMap_size;
	this.getMaxNameLength  = coParameterMap_getMaxNameLength;
	this.getMaxValueLength = coParameterMap_getMaxValueLength;
}

/**
 * @type   : method
 * @access : public
 * @object : coParameterMap
 * @desc   : name에 맞는 파라미터값을 리턴한다.
 * @sig    : name
 * @param  : name required map의 name으로 사용할 값
 * @return : 파라미터값
 */
function coParameterMap_getValue(name) {
	for (var i = 0; i < this.count; i++) {
		if (this.names[i] == name) {
			return this.values[i];
		}
	}

	return null;
}

/**
 * @type   : method
 * @access : public
 * @object : coParameterMap
 * @desc   : 새로운 map을 추가한다. 같은 name가 존재할 경우 overwrite한다.
 * @sig    : name, value
 * @param  : name  required map의 name로 사용할 값
 * @param  : value required map의 value로 사용할 값
 * @return : 파라미터값
 */
function coParameterMap_put(name, value) {
	for (var i = 0; i < this.count; i++) {
		if (this.names[i] == name) {
			this.values[i] = value;
			return;
		}
	}

	this.names[this.count] = name;
	this.values[this.count++] = value;
}

/**
 * @type   : method
 * @access : public
 * @object : coParameterMap
 * @desc   : 지정된 index에 있는 map의 name을 알려준다.
 * @sig    : index
 * @param  : index required map의 index
 * @return : name
 */
function coParameterMap_getNameAt(index) {
	return this.names[index];
}

/**
 * @type   : method
 * @access : public
 * @object : coParameterMap
 * @desc   : 지정된 index에 있는 map의 value를 알려준다.
 * @sig    : index
 * @param  : index required map의 index
 * @return : value
 */
function coParameterMap_getValueAt(index) {
	return this.values[index];
}

/**
 * @type   : method
 * @access : public
 * @object : coParameterMap
 * @desc   : map의 name-value 쌍의 갯수를 알려준다.
 * @return : name-value 쌍의 갯수
 */
function coParameterMap_size() {
	return this.count;
}

/**
 * @type   : method
 * @access : public
 * @object : coParameterMap
 * @desc   : map 내의 name 값들을 String으로 환산하여 최대길이를 알려준다.
 * @return : max name length
 */
function coParameterMap_getMaxNameLength() {
	var maxLength = 0;

	for (var i = 0; i < this.count; i++) {
		if (String(this.names[i]).length > maxLength) {
			maxLength = String(this.names[i]).length;
		}
	}

	return maxLength;
}

/**
 * @type   : method
 * @access : public
 * @object : coParameterMap
 * @desc   : map 내의 value 값들을 String으로 환산하여 최대길이를 알려준다.
 * @return : max value length
 */
function coParameterMap_getMaxValueLength() {
	var maxLength = 0;

	for (var i = 0; i < this.count; i++) {
		if (String(this.values[i]).length > maxLength) {
			maxLength = String(this.values[i]).length;
		}
	}

	return maxLength;
}

//-------------------------- 유효성 검사를 위한 객체 선언 -----------------------------//
/*
 * @Validator 객체의 구조
 *   - 속성 : exception,   -> validity의 sub속성이다. validity가 true면 exception은 무조건 false이고
 *                            validity가 false인 경우 false의 원인이 exception인지 여부를 알려준다.
 *                            exception은 사용자 입력에 대한 실제 validation과는 무관한 에러를 의미한다.
 *                            true/false 중 하나.
 *            message,     -> 오류메세지를 담고 있다.
 *            validity,    -> 유효성검사결과를 담고 있다. true/false 중 하나.
 *            value        -> 유효성 검사 대상 값.
 *
 *   - 메소드 : validate() -> 유효성 검사를 수행한다.
 *                            유효할 경우, validity를 true로하고 true를 return하고
 *                            유효하지 않을 경우,  validity를 false로하고 false를 return하고
 *                            message에 오류메세지를 기술한다.
 *                            exception의 경우는 exception을 true로 하고 message에 메세지를 기술한다.
 *
 *   - 추가시 할일 :
 *     1) validator객체를 정의한다.
 *     2) covValidExp 객체의 getValidators 메소드에 validator객체를 등록한다.
 */

///////////////////////////// covValueValidExp /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : 유효성 검사에 대한 표현(expression)을 객체화 하였다.
 *             - expression 형식<br>
 *               항목이름:필수항목여부:유효성항목<br>
 *               예) "접수번호:yes:length=6"
 *             - 유효성 항목 형식
 *               유효성항목명=유효값[&유효성항목명=유효값]..
 *               예) "length=13&ssn"
 * @sig    : expression
 * @param  : expression required valid expression string.
 * @author : 임재현
 */
function covValueValidExp(expression) {
    // data;
    this.validItems = new Array();
    this.errMsg = "";

    // method
    this.init = covValueValidExp_init;
    this.parse = covValueValidExp_parse;
    this.validate = covValueValidExp_validate;

    // initialize
    this.init(expression);
}

/**
 * @type   : method
 * @access : private
 * @object : covValueValidExp
 * @desc   : 초기화를 수행한다.
 * @sig    : expression
 * @param  : expression required valid expression string.
 * @author : 임재현
 */
function covValueValidExp_init(expression) {
	this.parse(expression);
}

/**
 * @type   : method
 * @access : private
 * @object : covValueValidExp
 * @desc   : covValidExp 객체의 parse 메소드.
 *           valid expression을 parsing한다.
 * @sig    : expression
 * @param  : expression required valid expression string.
 */
function covValueValidExp_parse(expression) {
	if (cfIsNull(expression)) {
		return;
	}

	var validItemExps = expression.advancedSplit("&", "i");
	var validItem;

	for (var i = 0; i < validItemExps.length; i++) {
		validItemPair = validItemExps[i].trim().advancedSplit("=", "i");
		validItem = new Object();
		validItem.name  = validItemPair[0].trim();
		validItem.value = validItemPair[1];  // parsedExp[1] 은 존재하지 않을 수도 있지만 자바스크립트에서는
		this.validItems[i] = validItem;      // 이런 경우 "undefined" 라는 값을 리턴한다.
	}
}

/**
 * @type   : method
 * @access : private
 * @object : covValueValidExp
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value required 검사대상값
 */
function covValueValidExp_validate(value) {
	var validators = new Array();
	var count = 0;

	for (var i = 0; i < this.validItems.length; i++) {
		switch (this.validItems[i].name) {
			case "length" :
				validators[count++] = new covLengthValidator(this.validItems[i].value);
				break;

			case "byteLength" :
				validators[count++] = new covByteLengthValidator(this.validItems[i].value);
				break;

			case "minLength" :
				validators[count++] = new covMinLengthValidator(this.validItems[i].value);
				break;

			case "minByteLength" :
				validators[count++] = new covMinByteLengthValidator(this.validItems[i].value);
				break;

			case "maxLength" :
				validators[count++] = new covMaxLengthValidator(this.validItems[i].value);
				break;

			case "maxByteLength" :
				validators[count++] = new covMaxByteLengthValidator(this.validItems[i].value);
				break;

			case "number" :
				validators[count++] = new covNumberValidator(this.validItems[i].value);
				break;

			case "minNumber" :
				validators[count++] = new covMinNumberValidator(this.validItems[i].value);
				break;

			case "maxNumber" :
				validators[count++] = new covMaxNumberValidator(this.validItems[i].value);
				break;

			case "inNumber" :
				validators[count++] = new covInNumberValidator(this.validItems[i].value);
				break;

			case "minDate" :
				validators[count++] = new covMinDateValidator(this.validItems[i].value);
				break;

			case "maxDate" :
				validators[count++] = new covMaxDateValidator(this.validItems[i].value);
				break;

			case "format" :
				validators[count++] = new covFormatValidator(this.validItems[i].value);
				break;

			case "ssn" :
				validators[count++] = new covSsnValidator(this.validItems[i].value);
				break;

			case "csn" :
				validators[count++] = new covCsnValidator(this.validItems[i].value);
				break;

			case "filterIn" :
				validators[count++] = new covFilterInValidator(this.validItems[i].value);
				break;

			case "filterOut" :
				validators[count++] = new covFilterOutValidator(this.validItems[i].value);
				break;

			case "email" :
				validators[count++] = new covEmailValidator(this.validItems[i].value);
				break;

			case "date" :
				validators[count++] = new covDateValidator(this.validItems[i].value);
				break;

			default :
				break;
		}
	}

	for (var i = 0; i < validators.length; i++) {
		if (!validators[i].validate(value)) {
			this.errMsg = validators[i].message;
			return false;
		}
	}

	return true;
}

///////////////////////////// covItemValidExp /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : 유효성 검사에 대한 표현(expression)을 객체화 하였다.
 *             - expression 형식<br>
 *               항목이름:필수항목여부:유효성항목<br>
 *               예) "접수번호:yes:length=6"
 *             - 유효성 항목 형식
 *               유효성항목명=유효값[&유효성항목명=유효값]..
 *               예) "length=13&ssn"
 * @sig    : expression, itemName
 * @param  : expression required valid expression string.
 * @param  : itemName   required 아이템명
 * @author : 임재현
 */
function covItemValidExp(expression, itemName) {
    // data;
    this.itemName;
    this.required;
    this.valueValidExp;

    // method
    this.parse = covItemValidExp_parse;
    this.validate = covItemValidExp_validate;

    // initialize
    this.parse(expression, itemName);
}

/**
 * @type   : method
 * @access : public
 * @object : covItemValidExp
 * @desc   : valid expression을 parsing한다.
 * @sig    : expression, itemName
 * @param  : expression required valid expression string.
 * @param  : itemName   required 아이템명
 */
function covItemValidExp_parse(expression, itemName) {
	if (cfIsNull(expression)) {
		return;
	}

	var columns = expression.advancedSplit(":", "i");

	if (cfIsNull(columns[1])) {
		return;
	}

	if (cfIsNull(columns[0])) {
		if (!cfIsNull(itemName)) {
			this.itemName = itemName.trim();
		} else {
			return;
		}
	} else {
		this.itemName = columns[0].trim();
	}

	this.required = (columns[1].trim().toUpperCase() == "YES" ||
	                 columns[1].trim().toUpperCase() == "TRUE" ||
	                 columns[1].trim() == "1"
	                ) ? true : false;

	if ((columns[2]) != null) {
		this.valueValidExp = new covValueValidExp(columns[2].trim());
	}
}

/**
 * @type   : method
 * @access : public
 * @object : covItemValidExp
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value required 검사할 값
 */
function covItemValidExp_validate(value) {
	// 표현식에 필수항목들(아이템명, 필수여부)을 기술하지 않을 경우는 표현식이 없다고 간주.
	if (cfIsNull(this.itemName) || cfIsNull(this.required)) {
		return true;
	}

	if (this.required && cfIsNull(value)) {
		this.errMsg = MSG_COM_ERR_002;
		return false;
	}

	if (!this.required && cfIsNull(value)) {
		return true;
	}

	if (this.valueValidExp == null) {
		return true;
	}

	if (!this.valueValidExp.validate(value)) {
		this.errMsg = this.valueValidExp.errMsg;
		return false;
	}

	return true;
}

///////////////////////////// covColumnValidExp /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : Grid의 컬럼 유효성 검사 표현식
 * @sig    : expression, oGrid
 * @param  : expression required valid expression string.
 * @param  : oGrid      required 검사대상 Grid 오브젝트
 * @author : 임재현
 */
function covColumnValidExp(expression, oGrid) {
    // data;
    this.colId;
    this.errMsg = "";
    this.errRow = -1;
    this.errItemName = "";
    this.itemValidExp;
    this.property = "NORMAL";  // NORMAL, KEY, SINGLEKEY 속성이 있다.

    // method
    this.parse    = covColumnValidExp_parse;
    this.validate = covColumnValidExp_validate;

    // initialize
    this.parse(expression, oGrid);
}

/**
 * @type   : method
 * @access : public
 * @object : covColumnValidExp
 * @desc   : valid expression을 parsing한다.
 * @sig    : expression, oGrid
 * @param  : expression required valid expression string.
 * @param  : oGrid      required 검사대상 Grid 오브젝트
 */
function covColumnValidExp_parse(expression, oGrid) {
	var index = -1;

	var expArr = expression.advancedSplit(":", "i");

	if (expArr.length < 3) {
		return;
	}

	var itemName = null;

	this.colId = expArr[0].trim();

	if (new coGridFormat(oGrid.Format).existsColumn(this.colId)) {
		itemName = oGrid.ColumnProp(this.colId, "Name");
	}

	this.itemValidExp = new covItemValidExp(expArr[1] + ":" + expArr[2] + ":" + expArr[3], itemName);
	if (!cfIsNull(expArr[4]) && expArr[4].toUpperCase().trim() == "KEY") {
		this.property = "KEY";
	} else if (!cfIsNull(expArr[4]) && expArr[4].toUpperCase().trim() == "SINGLEKEY") {
		this.property = "SINGLEKEY";
	}
}

/**
 * @type   : method
 * @access : public
 * @object : covColumnValidExp
 * @desc   : validation을 수행한다.
 * @sig    : oDataSet, row
 * @param  : oDataSet required 검사대상 DataSet
 * @param  : row required 검사대상 DataSet의 특정 row 번호
 */
function covColumnValidExp_validate(oDataSet, row) {
	if (oDataSet == null ||
	    oDataSet.tagName != "OBJECT" ||
	    oDataSet.attributes.classid.nodeValue.toUpperCase() !== "CLSID:AF989B7C-8AC3-40BC-B749-EB335BDFD190" ||
	    oDataSet.CountRow < 1
	   ) {
	   	return true;
	}

	var startIdx = 1;
	var endIdx = oDataSet.CountRow;
	var value;
	var rowYN = false;

	if (row != null) {
		startIdx = row;
		endIdx = row;
		rowYN = true;
	}

	for (var i = startIdx; i <= endIdx; i++) {
		value = (oDataSet.NameValue(i, this.colId) == null) ?
                 null : oDataSet.NameString(i, this.colId).trim();  // DataSet의 data를 trim 시킨다.

		if (this.itemValidExp != null && !this.itemValidExp.validate(value)) {
			this.errMsg = this.itemValidExp.errMsg;
			this.errRow = i;
			this.errItemName = this.itemValidExp.itemName;
			return false;
		}
	}

	return true;
}

///////////////////////////// covGridValidExp /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : Grid에 대한 유효성검사 표현식
 * @sig    : oGrid
 * @param  : oGrid required 검사대상 Grid
 * @author : 임재현
 */
function covGridValidExp(oGrid) {
    // data;
    this.oGrid = oGrid;
    this.columnValidExps = new Array();
	this.errMsg;
	this.errRow;
	this.errColId;
	this.errItemName = "";

    // method
    this.parse = covGridValidExp_parse;
    this.validate = covGridValidExp_validate;

    // initialize
    this.parse();
}

/**
 * @type   : method
 * @access : public
 * @object : covGridValidExp
 * @desc   : valid expression을 parsing한다.
 */
function covGridValidExp_parse() {
	if (cfIsNull(this.oGrid) || cfIsNull(this.oGrid.validExp)) {
		return;
	}

	var columns = this.oGrid.validExp.trim().advancedSplit(",", "it");

	for (var i = 0; i < columns.length; i++) {
    	this.columnValidExps[i] = new covColumnValidExp(columns[i], this.oGrid);
	}
}

/**
 * @type   : method
 * @access : public
 * @object : covGridValidExp
 * @desc   : validation을 수행한다.
 * @sig    : [row[, colId[, ignoreStatus]]]
 * @param  : row optional 검사대상 Grid의 특정 row 번호
 * @param  : colId optional 검사대상 Grid의 특정 컬럼의 id
 * @param  : ignoreStatus optional Grid 검사시 row status에 상관없이 모두 검사할 것인지의 여부.
 */
function covGridValidExp_validate(row, colId, ignoreStatus) {
	var oDataSet = document.all(this.oGrid.DataId);

	if (oDataSet == null ||
	    oDataSet.tagName != "OBJECT" ||
	    oDataSet.attributes.classid.nodeValue.toUpperCase() !== "CLSID:AF989B7C-8AC3-40BC-B749-EB335BDFD190" ||
	    oDataSet.CountRow < 1
	   ) {
	   	return true;
	}

	var startIdx;
	var endIdx;
	var nestedStartIdx;
	var nestedEndIdx;
	var keyColValidExps = new Array();
	var singleKeyColValidExps = new Array();

	// 키컬럼 추출
	var keyColCnt = 0;
	var singleKeyColCnt = 0;
	for (var i = 0; i < this.columnValidExps.length; i++) {
		if (this.columnValidExps[i].property == "KEY") {
			keyColValidExps[keyColCnt++] = this.columnValidExps[i];
		} else if (this.columnValidExps[i].property == "SINGLEKEY") {
			singleKeyColValidExps[singleKeyColCnt++] = this.columnValidExps[i];
		}
	}

	if (row != null) {
		startIdx = row;
		endIdx = row;
	} else {
		startIdx = 1;
		endIdx = oDataSet.CountRow - 1;
	}

	// 중복키 체크
	if (keyColValidExps.length > 0 || singleKeyColValidExps.length > 0) {
		var isEqual;

		for (var i = startIdx; i <= endIdx; i++) {

			if (row != null) {
				nestedStartIdx = 1;
			} else {
				nestedStartIdx = i + 1;
			}

			for (j = nestedStartIdx; j <= oDataSet.CountRow; j++) {
				if (i == j) {
					continue;
				}

				// 일반키컬럼 검사.
				{
					isEqual = true;
					for (var k = 0; k < keyColValidExps.length; k++) {
						if (oDataSet.NameValue(i, keyColValidExps[k].colId) !=
						    oDataSet.NameValue(j, keyColValidExps[k].colId)
						   ) {
						   	isEqual = false;
						   	break;
						}
					}

					if (isEqual) {
						this.errMsg = cfGetMsg(MSG_COM_ERR_032, ["@"]);

						if (row != null) {
							this.errRow = row;  // row를 지정하였을 때는 해당 row에 대한 error로 간주
						} else {
							this.errRow = j; // row지정이 없으면 중복된 두개의 데이터중 순서상 나중에 있는 row를 error로 간주
						}

						for (var k = 0; k < keyColValidExps.length; k++) {
							this.errItemName = this.errItemName + keyColValidExps[k].itemValidExp.itemName + ", ";
						}

						this.errItemName = this.errItemName.substring(0, this.errItemName.lastIndexOf(","));
						return false;
					}
				}

				// 싱글키컬럼 검사.
				for (var k = 0; k < singleKeyColValidExps.length; k++) {
					if (oDataSet.NameValue(i, singleKeyColValidExps[k].colId) ==
					    oDataSet.NameValue(j, singleKeyColValidExps[k].colId)
					   ) {
						this.errMsg = cfGetMsg(MSG_COM_ERR_032, ["@"]);

						if (row != null) {
							this.errRow = row;  // row를 지정하였을 때는 해당 row에 대한 error로 간주
						} else {
							this.errRow = j; // row지정이 없으면 중복된 두개의 데이터중 순서상 나중에 있는 row를 error로 간주
						}

						this.errItemName = singleKeyColValidExps[k].itemValidExp.itemName;
						return false;
					}
				}
			}
		}
	}

	if (row != null) {
		startIdx = row;
		endIdx = row;
	} else {
		startIdx = 1;
		endIdx = oDataSet.CountRow;
	}

	// validation 수행
	for (var i = startIdx; i <= endIdx; i++) {
		if (ignoreStatus || oDataSet.RowStatus(i) != 0) {
			for (var j = 0; j < this.columnValidExps.length; j++) {
				columnValidExp = this.columnValidExps[j];

				if (!columnValidExp.validate(oDataSet, i)) {
					this.errMsg = columnValidExp.errMsg;
					this.errRow = i;
					this.errColId = columnValidExp.colId;
					this.errItemName = columnValidExp.errItemName;
					return false;
				}
			}
		}
	}

	return true;
}

///////////////////////////// covLengthValidator /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : 'length' 항목에 대한 validator. 값이 지정된 길이를 가지고 있는지 검사한다.
 * @param  : length required 유효한 기준길이.
 * @author : 임재현
 */
function covLengthValidator(length) {
    // data;
    this.message = "";
    this.validity = false;
    this.length = length;

    // method
    this.validate = covLengthValidator_validate;
}

/**
 * @type   : method
 * @access : public
 * @object : covLengthValidator
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value   required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
 */
function covLengthValidator_validate(value) {
	if (value.length != this.length) {
		this.message = new coMessage().getMsg(MSG_COM_ERR_005, ["@", String(this.length)]);
		return false;
	}

	this.validity = true;
	return true;
}

///////////////////////////// covByteLengthValidator /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : 'byteLength' 항목에 대한 validator. 값이 지정된 byte단위의 길이를 가지고 있는지 검사한다.
 * @param  : length required 유효한 기준길이.
 * @author : 임재현
 */
function covByteLengthValidator(length) {
    // data;
    this.message = "";
    this.validity = false;
    this.length = length;

    // method
    this.validate = covByteLengthValidator_validate;
}

/**
 * @type   : method
 * @access : public
 * @object : covByteLengthValidator
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value   required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
 */
function covByteLengthValidator_validate(value) {
	if (cfGetByteLength(value) != this.length) {
		this.message = new coMessage().getMsg(MSG_COM_ERR_027, ["@", String(this.length), String(Math.floor(this.length / 2))]);
		return false;
	}

	this.validity = true;
	return true;
}

///////////////////////////// covMinLengthValidator /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : 'minLength' 항목에 대한 validator. 값이 지정된 길이 이상인지를 검사한다.
 * @sig    : length
 * @param  : length required 유효한 기준길이.
 * @author : 임재현
 */
function covMinLengthValidator(length) {
    // data;
    this.message = "";
    this.validity = false;
    this.length = length;

    // method
    this.validate = covMinLengthValidator_validate;
}

/**
 * @type   : method
 * @access : public
 * @object : covMinLengthValidator
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value   required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
 */
function covMinLengthValidator_validate(value) {
	if (value.length < this.length) {
		this.message = new coMessage().getMsg(MSG_COM_ERR_011, ["@", String(this.length)]);
		return false;
	}

	this.validity = true;
	return true;
}

///////////////////////////// covMinByteLengthValidator /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : 'minByteLength' 항목에 대한 validator. 값이 지정된 byte단위의 길이 이상인지를 검사한다.
 * @sig    : length
 * @param  : length required 유효한 기준길이.
 * @author : 임재현
 */
function covMinByteLengthValidator(length) {
    // data;
    this.message = "";
    this.validity = false;
    this.length = length;

    // method
    this.validate = covMinByteLengthValidator_validate;
}

/**
 * @type   : method
 * @access : public
 * @object : covMinByteLengthValidator
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value   required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
 */
function covMinByteLengthValidator_validate(value) {
	if (cfGetByteLength(value) < this.length) {
		this.message = new coMessage().getMsg(MSG_COM_ERR_028, ["@", String(this.length), String(Math.floor(this.length / 2))]);
		return false;
	}

	this.validity = true;
	return true;
}

///////////////////////////// covMaxLengthValidator /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : 'maxLength' 항목에 대한 validator. 값이 지정된 길이 이상인지를 검사한다.
 * @sig    : length
 * @param  : length required 유효한 기준길이.
 * @author : 임재현
 */
function covMaxLengthValidator(length) {
    // data;
    this.message = "";
    this.validity = false;
    this.length = length;

    // method
    this.validate = covMaxLengthValidator_validate;
}

/**
 * @type   : method
 * @access : public
 * @object : covMaxLengthValidator
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value   required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
 */
function covMaxLengthValidator_validate(value) {
	if (value.length > this.length) {
		this.message = new coMessage().getMsg(MSG_COM_ERR_012, ["@", String(this.length)]);
		return false;
	}

	this.validity = true;
	return true;
}

///////////////////////////// covMaxByteLengthValidator /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : 'maxByteLength' 항목에 대한 validator. 값이 지정된 byte단위의 길이 이하인지를 검사한다.
 * @sig    : length
 * @param  : length required 유효한 기준길이.
 * @author : 임재현
 */
function covMaxByteLengthValidator(length) {
    // data;
    this.message = "";
    this.validity = false;
    this.length = length;

    // method
    this.validate = covMaxByteLengthValidator_validate;
}

/**
 * @type   : method
 * @access : public
 * @object : covMaxByteLengthValidator
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value   required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
 */
function covMaxByteLengthValidator_validate(value) {
	if (cfGetByteLength(value) > this.length) {
		this.message = new coMessage().getMsg(MSG_COM_ERR_029, ["@", String(this.length), String(Math.floor(this.length / 2))]);
		return false;
	}

	this.validity = true;
	return true;
}

///////////////////////////// covNumberValidator /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : 'number' 항목에 대한 validator. 값이 숫자인지를 검사한다. 또한 format을 지정하였을 경우에는 format에 맞는지 검사한다.
 * <pre>
 *     "number" 로 지정시 : 숫자인지 체크
 *     "number=(5.2)" 로 지정시 : 숫자이면서 정수부 5자리 이하, 소수부 2자리 이하인지를 체크
 * </pre>
 * @author : 임재현
 */
function covNumberValidator(format) {
    // data;
	re = /\(\s*(\d+)\s*.\s*(\d+)\s*\)/;
	this.iLength;
	this.dLength;

	this.message = "";
	this.validity = false;

    // method
    this.validate = covNumberValidator_validate;

	// initialize
	{
		if (cfIsNull(format)) {
			return;
		}

		r = format.match(re);

		if (r == null) {
			return;
		}

		this.iLength = Number(r[1]);
		this.dLength = Number(r[2]);
	}
}

/**
 * @type   : method
 * @access : public
 * @object : covNumberValidator
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value   required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
 */
function covNumberValidator_validate(value) {
	if (isNaN(value)) {
		this.message = new coMessage().getMsg(MSG_COM_ERR_007, ["@"]);
		return false;
	} else if (!cfIsNull(this.iLength)) {
		var strValue = String(value);
		var idx = strValue.indexOf('.');
		var iNumStr = strValue.substr(0, idx);
		var dNumStr = strValue.substr(idx + 1);

		if (iNumStr.length > this.iLength) {
			this.message = new coMessage().getMsg(MSG_COM_ERR_059, ["@", String(this.iLength)]);
			return false;
		} else if (dNumStr.length > this.dLength) {
			this.message = new coMessage().getMsg(MSG_COM_ERR_060, ["@", String(this.dLength)]);
			return false;
		}
	}

	this.validity = true;
	return true;
}

///////////////////////////// covMinNumberValidator /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : 'minNumber' 항목에 대한 validator. 값이 지정된 최소값을 넘는지를 검사한다.
 * @sig    : minNumber
 * @param  : minNumber required 유효한 기준 최소값.
 * @author : 임재현
 */
function covMinNumberValidator(minNumber) {
    // data;
    this.message = "";
    this.validity = false;
    this.minNumber = minNumber;

    // method
    this.validate = covMinNumberValidator_validate;
}

/**
 * @type   : method
 * @access : public
 * @object : covMinNumberValidator
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value   required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
 */
function covMinNumberValidator_validate(value) {
	// 기준값이 숫자가 아닌경우 무조건 true;
	if (isNaN(this.minNumber)) {
		this.validity = true;
		return true;
	}

	if (isNaN(value)) {
		this.message = new coMessage().getMsg(MSG_COM_ERR_007, ["@"]);
		return false;
	}

	this.minNumber = Number(this.minNumber);
	value          = Number(value);

	if (value < this.minNumber) {
		this.message = new coMessage().getMsg(MSG_COM_ERR_013, ["@", String(this.minNumber)]);
		return false;
	}

	this.validity = true;
	return true;
}

///////////////////////////// covMaxNumberValidator /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : 'maxNumber' 항목에 대한 validator. 값이 지정된 최대값을 넘지 않는지를 검사한다.
 * @sig    : maxNumber
 * @param  : maxNumber 유효한 기준 최대값.
 * @author : 임재현
 */
function covMaxNumberValidator(maxNumber) {
    // data;
    this.message = "";
    this.validity = false;
    this.maxNumber = (maxNumber == null) ? "" : maxNumber.trim();

    // method
    this.validate = covMaxNumberValidator_validate;
}

/**
 * @type   : method
 * @access : public
 * @object : covMaxNumberValidator
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value   required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
 */
function covMaxNumberValidator_validate(value) {
	// 기준값이 숫자가 아닌경우 무조건 true;
	if (isNaN(this.maxNumber)) {
		this.validity = true;
		return true;
	}

	if (isNaN(value)) {
		this.message = new coMessage().getMsg(MSG_COM_ERR_007, ["@"]);
		return false;
	}

	this.maxNumber = Number(this.maxNumber);
	value          = Number(value);

	if (value > this.maxNumber) {
		this.message = new coMessage().getMsg(MSG_COM_ERR_014, ["@", String(this.maxNumber)]);
		return false;
	}

	this.validity = true;
	return true;
}


///////////////////////////// covInNumberValidator /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : 'inNumber' 항목에 대한 validator. 값이 지정된 범위 내의 값인지를 검사한다.
 * @sig    : inNumber
 * @param  : inNumber required 숫자의 범위를 나타내는 스트링. 예) "1~100"
 * @author : 임재현
 */
function covInNumberValidator(inNumber) {
    // data;
    this.message = "";
    this.validity = false;
    this.minNumber;
    this.maxNumber;

    // method
    this.validate = covInNumberValidator_validate;

    // initialize
	this.minNumber = inNumber.substring(0, inNumber.indexOf("~"));
	this.maxNumber = inNumber.substr(inNumber.indexOf("~") + 1);

	this.minNumber = (this.minNumber == null) ? "" : this.minNumber.trim();
	this.maxNumber = (this.maxNumber == null) ? "" : this.maxNumber.trim();
}

/**
 * @type   : method
 * @access : public
 * @object : covInNumberValidator
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value   required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
 */
function covInNumberValidator_validate(value) {
	// 기준값이 숫자가 아닌경우 무조건 true;
	if (isNaN(this.minNumber) || isNaN(this.maxNumber)) {
		this.validity = true;
		return true;
	}

	if (isNaN(value)) {
		this.message = new coMessage().getMsg(MSG_COM_ERR_007, ["@"]);
		return false;
	}

	this.minNumber = Number(this.minNumber);
	this.maxNumber = Number(this.maxNumber);
	value     = Number(value);

	if (value < this.minNumber || value > this.maxNumber) {
		this.message = new coMessage().getMsg(MSG_COM_ERR_006, ["@", String(this.minNumber), String(this.maxNumber)]);
		return false;
	}

	this.validity = true;
	return true;
}

///////////////////////////// covMinDateValidator /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : 'minDate' 항목에 대한 validator. 값이 지정된 날짜를 넘는지를 검사한다.
 *           'YYYYMMDD' 형식으로 날짜를 표기해야 한다.
 *             예) minDate=20020315
 * @sig    : minDate
 * @param  : minDate required 유효한 기준 최소값.
 * @author : 임재현
 */
function covMinDateValidator(minDate) {
    // data;
    this.message = "";
    this.validity = false;
    this.minDate = minDate;

    // method
    this.validate = covMinDateValidator_validate;
}

/**
 * @type   : method
 * @access : public
 * @object : covMinDateValidator
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value   required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
 */
function covMinDateValidator_validate(value) {
	if (!(new covDateValidator("YYYYMMDD").validate(value))) {
		this.message = new coMessage().getMsg(MSG_COM_ERR_018, ["@"]);
		return false;
	}

	if (value < this.minDate) {
		var msgParams = new Array(4);
		msgParams[0] = "@";
		msgParams[1] = this.minDate.substring(0,4);
		msgParams[2] = this.minDate.substring(4,5) == "0" ? this.minDate.substring(5,6) : this.minDate.substring(4,6);
		msgParams[3] = this.minDate.substring(6,7) == "0" ? this.minDate.substring(7,8) : this.minDate.substring(6,8)
		this.message = new coMessage().getMsg(MSG_COM_ERR_025, msgParams);
		return false;
	}

	this.validity = true;
	return true;
}

///////////////////////////// covMaxDateValidator /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : 'maxDate' 항목에 대한 validator. 값이 지정된 최대값을 넘지 않는지를 검사한다.
 * @sig    : maxDate
 * @param  : maxDate required 유효한 최대날짜값.
 * @author : 임재현
 */
function covMaxDateValidator(maxDate) {
    // data;
    this.message = "";
    this.validity = false;
    this.maxDate = maxDate;

    // method
    this.validate = covMaxDateValidator_validate;
}

/**
 * @type   : method
 * @access : public
 * @object : covMaxDateValidator
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value   required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
 */
function covMaxDateValidator_validate(value) {
	if (!(new covDateValidator("YYYYMMDD").validate(value))) {
		this.message = new coMessage().getMsg(MSG_COM_ERR_018, ["@"]);
		return false;
	}

	if (value > this.maxDate) {
		var msgParams = new Array(4);
		msgParams[0] = "@";
		msgParams[1] = this.maxDate.substring(0,4);
		msgParams[2] = this.maxDate.substring(4,5) == "0" ? this.maxDate.substring(5,6) : this.maxDate.substring(4,6);
		msgParams[3] = this.maxDate.substring(6,7) == "0" ? this.maxDate.substring(7,8) : this.maxDate.substring(6,8)
		this.message = new coMessage().getMsg(MSG_COM_ERR_024, msgParams);
		return false;
	}

	this.validity = true;
	return true;
}

///////////////////////////// covFormatValidator /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : 'format' 항목에 대한 validator. 값이 마스크로 표현된 형식과 일치하는지 검사한다.
 *             - format characters
 *               #    : 문자와 숫자
 *               h, H : 한글 (H는 공백포함)
 *               A, Z : 문자 (Z는 공백포함)
 *               0, 9 : 숫자 (9는 공백포함)
 * @sig    : format
 * @param  : format required 포멧 스트링.
 * @author : 임재현
 */
function covFormatValidator(format) {
    // data;
    this.message  = "";
    this.validity = false;
    this.format   = format

    // method
    this.validate = covFormatValidator_validate;
}

/**
 * @type   : method
 * @access : public
 * @object : covFormatValidator
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
 */
function covFormatValidator_validate(value) {
	if (value.length != this.format.length) {
		this.message = new coMessage().getMsg(MSG_COM_ERR_026, ["@", this.format]);
		return false;
	}

	for (var i = 0; i < this.format.length; i++) {
		switch(this.format.charAt(i)) {
			case 'h' :
				var cCode = value.charCodeAt(i);
				if ( (value.charAt(i) == " ") ||
				     !((0xAC00 <= cCode && cCode <= 0xD7A3) || (0x3131 <= cCode && cCode <= 0x318E))
				   ) {
					this.message = new coMessage().getMsg(MSG_COM_ERR_026, ["@", this.format]);
					return false;
				}
				break;

			case 'H' :
				var cCode = value.charCodeAt(i);
				if ( (value.charAt(i) != " ") &&
				     !((0xAC00 <= cCode && cCode <= 0xD7A3) || (0x3131 <= cCode && cCode <= 0x318E))
				   ) {
					this.message = new coMessage().getMsg(MSG_COM_ERR_026, ["@", this.format]);
					return false;
				}
				break;

			case '0' :
				if (isNaN(value.charAt(i)) || value.charAt(i) == " ") {
					this.message = new coMessage().getMsg(MSG_COM_ERR_026, ["@", this.format]);
					return false;
				}
				break;

			case '9' :
				if (isNaN(value.charAt(i))) {
					if (value.charAt(i) != " ") {
						this.message = new coMessage().getMsg(MSG_COM_ERR_026, ["@", this.format]);
						return false;
					}
				}
				break;

			case 'A' :
				if ( (value.charAt(i) == " ") || !isNaN(value.charAt(i)) ) {
					this.message = new coMessage().getMsg(MSG_COM_ERR_026, ["@", this.format]);
					return false;
				}
				break;

			case 'Z' :
				if ( (value.charAt(i) != " ") && !isNaN(value.charAt(i)) ) {
					this.message = new coMessage().getMsg(MSG_COM_ERR_026, ["@", this.format]);
					return false;
				}
				break;

			case '#' :
				break;

			default :
				if (value.charAt(i) != this.format.charAt(i)) {
					this.message = new coMessage().getMsg(MSG_COM_ERR_026, ["@", this.format]);
					return false;
				}
				break;
		}
	}

	this.validity = true;
	return true;
}

///////////////////////////// covSsnValidator /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : 'ssn' 항목에 대한 validator. 입력된 주민등록번호가 유효한지 검사한다.
 * @author : 임재현
 */
function covSsnValidator() {
    // data;
    this.message = "";
    this.validity = false;

    // method
    this.validate = covSsnValidator_validate;
}

/**
 * @type   : method
 * @access : public
 * @object : covSsnValidator
 * @desc   : validation을 수행한다.
 * @sig    : ssn
 * @param  : ssn required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
 */
function covSsnValidator_validate(ssn) {
	if ( ssn == null || ssn.trim().length != 13 || isNaN(ssn) )  {
		this.message = new coMessage().getMsg(MSG_COM_ERR_016, ["@"]);
		return false;
	}

	var jNum1 = ssn.substr(0, 6);
	var jNum2 = ssn.substr(6);

	/*
	  잘못된 생년월일을 검사합니다.
	  2000년도부터 성구별 번호가 바뀌었으므로 구별수가 2보다 작다면
	  1900년도 생이되고 2보다 크다면 2000년도 이후 출생이 됩니다.
	  단 1800년도 생은 계산에서 제외합니다.
	*/
	bYear = (jNum2.charAt(0) <= "2") ? "19" : "20";

	// 주민번호의 앞에서 2자리를 이어서 4자리의 생년을 저장합니다.
	bYear += jNum1.substr(0, 2);

	// 달을 구합니다. 1을 뺀것은 자바스크립트에서는 1월을 0으로 표기하기 때문입니다.
	bMonth = jNum1.substr(2, 2) - 1;

	bDate = jNum1.substr(4, 2);

	bSum = new Date(bYear, bMonth, bDate);

	// 생년월일의 타당성을 검사하여 거짓이 있을시 에러메세지를 나타냄
	if ( bSum.getYear() % 100 != jNum1.substr(0, 2) || bSum.getMonth() != bMonth || bSum.getDate() != bDate) {
		this.message = new coMessage().getMsg(MSG_COM_ERR_016, ["@"]);
		return false;
	}

	total = 0;
	temp = new Array(13);

	for (i = 1; i <= 6; i++) {
		temp[i] = jNum1.charAt(i-1);
	}

	for (i = 7; i <= 13; i++) {
		temp[i] = jNum2.charAt(i-7);
	}

	for (i = 1; i <= 12; i++) {
		k = i + 1;

		// 각 수와 곱할 수를 뽑아냅니다. 곱수가 만일 10보다 크거나 같다면 계산식에 의해 2로 다시 시작하게 됩니다.
		if(k >= 10) k = k % 10 + 2;

		// 각 자리수와 계산수를 곱한값을 변수 total에 누적합산시킵니다.
		total = total + (temp[i] * k);
	}

	// 마지막 계산식을 변수 last_num에 대입합니다.
	last_num = (11- (total % 11)) % 10;

	// laster_num이 주민번호의마지막수와 같은면 참을 틀리면 거짓을 반환합니다.
	if(last_num != temp[13]) {
		this.message = new coMessage().getMsg(MSG_COM_ERR_016, ["@"]);
		return false;
	}

	this.validity = true;
	return true;
}

///////////////////////////// covCsnValidator /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : 'csn' 항목에 대한 validator. 입력된 사업자등록번호가 유효한지 검사한다.
 * @author : 임재현
 */
function covCsnValidator() {
    // data;
    this.message = "";
    this.validity = false;

    // method
    this.validate = covCsnValidator_validate;
}

/**
 * @type   : method
 * @access : public
 * @object : covCsnValidator
 * @desc   : validation을 수행한다.
 * @sig    : csn
 * @param  : csn required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
 */
function covCsnValidator_validate(csn) {
	if ( csn == null || csn.length != 10 || isNaN(csn) )  {
		this.message = new coMessage().getMsg(MSG_COM_ERR_017, ["@"]);
		return false;
	}

	var sum = 0;
	var nam = 0;
	var checkDigit = -1;
	var checkArray = [1,3,7,1,3,7,1,3,5];

	for(i=0 ; i < 9 ; i++)
	  sum += csn.charAt(i) * checkArray[i];

	sum = sum + ((csn.charAt(8) * 5 ) / 10);

	nam = Math.floor(sum) % 10;

	checkDigit = ( nam == 0 ) ? 0 : 10 - nam;

	if ( csn.charAt(9) != checkDigit) {
		this.message = new coMessage().getMsg(MSG_COM_ERR_017, ["@"]);
		return false;
	}

	this.validity = true;
	return true;
}

///////////////////////////// covFilterInValidator /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : 지정된 문자 이외에 다른 문자가 들어있을 경우 유효하지 않은 것으로 판단한다.
 *           특정 문자들에 대한 특수문자가 아래에 나와있다.<br>
 * <pre>
 *         ;    - \;
 *         한글 - \h
 *         영문 - \a
 *         숫자 - \n
 * </pre>
 * @sig    : fStr
 * @param  : fStr required filter에 대한 표현
 * @author : 임재현
 */
function covFilterInValidator(fStr) {
    // data;
    this.message = "";
    this.validity = false;
    this.fStrArr = fStr.advancedSplit(";", "i");

    for (var i = 0; i < this.fStrArr.length; i++) {
    	if (this.fStrArr[i] == "\\h") {
    		this.fStrArr[i] = "한글";
    	} else if (this.fStrArr[i] == "\\a") {
    		this.fStrArr[i] = "영문";
    	} else if (this.fStrArr[i] == "\\n") {
    		this.fStrArr[i] = "숫자";
    	}
    }

    // method
    this.validate = covFilterInValidator_validate;
}

/**
 * @type   : method
 * @access : public
 * @object : covFilterInValidator
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
 */
function covFilterInValidator_validate(value) {
	var isIn = false;
	var c
	var cCode;

	for (var i = 0; i < value.length; i++) {
		isIn = false;
		c = value.charAt(i);
		cCode = value.charCodeAt(i);

		for (var j = 0; j < this.fStrArr.length; j++) {
			if (this.fStrArr[j] == "한글" &&
			    ((0xAC00 <= cCode && cCode <= 0xD7A3) || (0x3131 <= cCode && cCode <= 0x318E))
			   ) {
				isIn = true;
			} else if ( this.fStrArr[j] == "영문" &&
			            ((0x61 <= cCode && cCode <= 0x7A) || (0x41 <= cCode && cCode <= 0x5A))
			          ) {
				isIn = true;
			} else if (this.fStrArr[j] == "숫자" && !isNaN(c)) {
				isIn = true;
			} else if (this.fStrArr[j] == c) {
				isIn = true;
			}
		}

		if (!isIn) {
			this.message = new coMessage().getMsg(MSG_COM_ERR_036, ["@", this.fStrArr.toString()]);
			return false;
		}
	}

	this.validity = true;
	return true;
}

///////////////////////////// covFilterOutValidator /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : 지정된 스트링들이 들어있을 경우 유효하지 않은것으로 판단한다.
 *           분리자는 ";"를 사용한다. ";" 혹은 ";"문자가 들어간 스트링을 필터링하려 할 경우는
 *           "\\;"라고 표기해야 한다.
 * @sig    : fStr
 * @param  : fStr required filter에 대한 표현
 * @author : 임재현
 */
function covFilterOutValidator(fStr) {
    // data;
    this.message = "";
    this.validity = false;
    this.fStrArr = fStr.advancedSplit(";", "i");

    // method
    this.validate = covFilterOutValidator_validate;
}

/**
 * @type   : method
 * @access : public
 * @object : covFilterValidator
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
 */
function covFilterOutValidator_validate(value) {
	for (var i = 0; i < this.fStrArr.length; i++) {
		if (value.indexOf(this.fStrArr[i]) != -1) {
			this.message = new coMessage().getMsg(MSG_COM_ERR_033, ["@", this.fStrArr.toString()]);
			return false;
		}
	}

	this.validity = true;
	return true;
}

///////////////////////////// covEmailValidator /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : 입력값이 email 형식에 적합한지를 검사한다.
 * @author : 임재현
 */
function covEmailValidator() {
    // data;
    this.message = "";
    this.validity = false;

    // method
    this.validate = covEmailValidator_validate;
}

/**
 * @type   : method
 * @access : public
 * @object : covEmailValidator
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value required 유효성 검사 대상값.
 * @return : boolean. 유효성 여부.
 */
function covEmailValidator_validate(value) {
	var format = /^((\w|[\-\.])+)@((\w|[\-\.])+)\.([A-Za-z]+)$/;

	if (value.search(format) == -1) {
		this.message = new coMessage().getMsg(MSG_COM_ERR_037, ["@"]);
		return false;
	}

	this.validity = true;
	return true;
}

///////////////////////////// covDateValidator /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : 값이 Date형식인지를 검사한다.
 *
 *            format문자 :  YYYY,  -> 4자리 년도
 *                          YY,    -> 2자리 년도. 2000년 이후.
 *                          MM,    -> 2자리 숫자의 달.
 *                          DD,    -> 2자리 숫자의 일.
 *                          hh,    -> 2자리 숫자의 시간. 12시 기준
 *                          HH,    -> 2자리 숫자의 시간. 24시 기준
 *                          mm,    -> 2자리 숫자의 분.
 *                          ss     -> 2자리 숫자의 초.
 *
 *            예)
 *                'YYYYMMDD' -> '20020328'
 *                'YYYY/MM/DD' -> '2002/03/28'
 *                'Today : YY-MM-DD' -> 'Today : 02-03-28'
 *
 *            참고)
 *                  format문자가 중복해서 나오더라도 처음 나온 문자에 대해서만
 *                  format문자로 인식된다. YYYY와 YY, hh와 HH 도 중복으로 본다.
 *                  날짜는 년,월이 존재할 때만 정확히 체크하고 만일 년, 월이 없다면
 *                  1 ~ 31 사이인지만 체크한다.
 *
 * @sig    : dateExp
 * @param  : dateExp required Date Format expression.
 *             예) 2002년 3월 12일 -> "YYYY-MM-DD"(Date Format Expression) -> "2002-03-12"
 * @author : 임재현
 */
function covDateValidator(dateExp) {
    // data;
    this.message = "";
    this.validity = false;
    this.dateExp = dateExp;
    this.year = null;
    this.month = null;

    // method
    this.validate = covDateValidator_validate;
    this.checkLength = covDateValidator_checkLength;
    this.checkYear = covDateValidator_checkYear;
    this.checkMonth = covDateValidator_checkMonth;
    this.checkDay = covDateValidator_checkDay;
    this.checkHour = covDateValidator_checkHour;
    this.checkMin = covDateValidator_checkMin;
    this.checkSec = covDateValidator_checkSec;
    this.checkRest = covDateValidator_checkRest;
}

/**
 * @type   : method
 * @access : public
 * @object : covDateValidator
 * @desc   : validation을 수행한다.
 * @sig    : value
 * @param  : value   required 검사대상이 되는 Date 스트링 값.
 * @return : boolean - 유효성 여부
 */
function covDateValidator_validate(value) {
	this.value = value;
	
	if ( this.checkLength(value) &&
		 this.checkYear(value) &&
		 this.checkMonth(value) &&
		 this.checkDay(value) &&
		 this.checkHour(value) &&
		 this.checkMin(value) &&
		 this.checkSec(value) &&
		 this.checkRest(value)
	   ) {
		this.validity = true;
		return true;
	} else {
		this.validity = false;
		return false;
	}
}

function covDateValidator_checkLength() {
	if (this.value.length == this.dateExp.length) {
		return true;
	} else {
		this.message = new coMessage().getMsg(MSG_COM_ERR_005, ["@", String(this.dateExp.length)]);
		return false;
	}
}

function covDateValidator_checkYear() {
	var index = -1;

	if ( (index = this.dateExp.indexOf("YYYY")) != -1 ) {
		subValue = this.value.substr(index, 4);
		if ( !isNaN(subValue) &&
			 (subValue > 0)
		   ) {
			this.dateExp = this.dateExp.cut(index, 4);
			this.value = this.value.cut(index, 4);
			this.year = subValue;
			return true;
		} else {
			this.message = new coMessage().getMsg(MSG_COM_ERR_015, ["@"]);
			return false;
		}
	}

	if ( (index = this.dateExp.indexOf("YY")) != -1 ) {
		subValue = "20" + this.value.substr(index, 2);
		if ( !isNaN(subValue) &&
			 (subValue > 0)
		   ) {
			this.dateExp = this.dateExp.cut(index, 2);
			this.value = this.value.cut(index, 2);
			this.year = subValue;
			return true;
		} else {
			this.message = new coMessage().getMsg(MSG_COM_ERR_015, ["@"]);
			return false;
		}
	}

	return true;
}

function covDateValidator_checkMonth() {
	var index = -1;

	if ( (index = this.dateExp.indexOf("MM")) != -1 ) {
		subValue = this.value.substr(index, 2);
		if ( !isNaN(subValue) &&
		     (subValue > 0) &&
		     (subValue <= 12)
		   ) {
			this.dateExp = this.dateExp.cut(index, 2);
			this.value = this.value.cut(index, 2);
			this.month = subValue;
			return true;
		} else {
			this.message = new coMessage().getMsg(MSG_COM_ERR_019, ["@"]);
			return false;
		}
	}

	return true;
}

function covDateValidator_checkDay() {
	var index = -1;
	var days = 0;

	if ( (index = this.dateExp.indexOf("DD")) != -1 ) {
		if ( (this.year != null) && (this.month != null) ) {
			days = (this.month != 2) ? GLB_DAYS_IN_MONTH[this.month-1] : (( (this.year % 4) == 0 && (this.year % 100) != 0 || (this.year % 400) == 0 ) ? 29 : 28 );
		} else {
			days = 31;
		}

		subValue = this.value.substr(index, 2);
		if ( (!isNaN(subValue)) &&
		     (subValue > 0) &&
		     (subValue <= days)
		   ) {
			this.dateExp = this.dateExp.cut(index, 2);
			this.value = this.value.cut(index, 2);
			return true;
		} else {
			this.message = new coMessage().getMsg(MSG_COM_ERR_020, ["@"]);
			return false;
		}
	}

	return true;
}

function covDateValidator_checkHour() {
	var index = -1;

	if ( (index = this.dateExp.indexOf("hh")) != -1 ) {
		subValue = this.value.substr(index, 2);
		if ( !isNaN(subValue) &&
		     (subValue >= 0) &&
		     (subValue <= 12)
		   ) {
			this.dateExp = this.dateExp.cut(index, 2);
			this.value = this.value.cut(index, 2);
			return true;
		} else {
			this.message = new coMessage().getMsg(MSG_COM_ERR_021, ["@"]);
			return false;
		}
	}

	if ( (index = this.dateExp.indexOf("HH")) != -1 ) {
		subValue = this.value.substr(index, 2);
		if ( !isNaN(subValue) &&
		     (subValue >= 0) &&
		     (subValue < 24)
		   ) {
			this.dateExp = this.dateExp.cut(index, 2);
			this.value = this.value.cut(index, 2);
			return true;
		} else {
			this.message = new coMessage().getMsg(MSG_COM_ERR_021, ["@"]);
			return false;
		}
	}

	return true;
}

function covDateValidator_checkMin() {
	var index = -1;

	if ( (index = this.dateExp.indexOf("mm")) != -1 ) {
		subValue = this.value.substr(index, 2);
		if ( !isNaN(subValue) &&
		     (subValue >= 0) &&
		     (subValue < 60 )
		   ) {
			this.dateExp = this.dateExp.cut(index, 2);
			this.value = this.value.cut(index, 2);
			this.month = subValue;
			return true;
		} else {
			this.message = new coMessage().getMsg(MSG_COM_ERR_022, ["@"]);
			return false;
		}
	}

	return true;
}

function covDateValidator_checkSec() {
	var index = -1;

	if ( (index = this.dateExp.indexOf("ss")) != -1 ) {
		subValue = this.value.substr(index, 2);
		if ( (!isNaN(subValue)) &&
		     (subValue >= 0) &&
		     (subValue < 60 )
		   ) {
			this.dateExp = this.dateExp.cut(index, 2);
			this.value = this.value.cut(index, 2);
			this.month = subValue;
			return true;
		} else {
			this.message = new coMessage().getMsg(MSG_COM_ERR_023, ["@"]);
			return false;
		}
	}

	return true;
}

function covDateValidator_checkRest() {
	if (this.value == this.dateExp) {
		return true;
	}

	return false;
}


///////////////////////////// covNullValidator /////////////////////////////
/**
 * @type   : object
 * @access : private
 * @desc   : 무조건 valid한 결과를 가진 validator.
 * @author : 임재현
 */
function covNullValidator() {
    // data;
    this.message = "";
    this.validity = true;

    // method
    this.validate = covNullValidator_validate;
}

/**
 * @type   : method
 * @access : public
 * @object : covNullValidator
 * @desc   : validation을 수행한다.
 * @return : boolean - 무조건 true.
 */
function covNullValidator_validate() {
	this.message = new coMessage().getMsg(MSG_COM_INF_007);
	return true;
}



var GLB_CALENDAR = new Object();

function cfIsNull(value) {
	if (value == null ||
	    (typeof(value) == "string" && value.trim() == "")
	   ) {
		return true;
	}

	return false;
}

function cfShowCalendar(oItem, month, year, format) {
	if( oItem == null | oItem.ReadOnly ){
	    alert("검색 모드에서는 날짜 입력 윈도우를 사용할 수 없습니다.");
	    return;
	}

	var currDate = new Date();
	if (cfIsNull(month)) {
		month = currDate.getMonth() + 1;
	}
	if (cfIsNull(year)) {
		year = currDate.getFullYear();
	}
	if (cfIsNull(format)) {
		format = "YYYYMMDD";
	}
	if (oItem.tagName == "OBJECT" &&
	    oItem.attributes.classid.nodeValue.toUpperCase() == "CLSID:71E7ACA0-EF63-4055-9894-229B056E9C31" // Grid
	   ) {
		GLB_CALENDAR.eventSrc = oItem;
	} else {
		GLB_CALENDAR.eventSrc = event.srcElement;
	}
	GLB_CALENDAR.oItem = oItem.id;
	GLB_CALENDAR.month = month;
	GLB_CALENDAR.year = year;
	GLB_CALENDAR.format = format;
	var dwn = document.createElement("DOWNLOAD");
	dwn.style.behavior="url(#default#download)";
	dwn.startDownload("/mdp/jsp/common/calendar/calendar.html", cfOnDoneDownLoadCalendar);
}

function cfOnDoneDownLoadCalendar(src) {
	GLB_CALENDAR.popup = window.createPopup();
  GLB_CALENDAR.popup.document.write(src);
	GLB_CALENDAR.popup.document.body.style.border = "solid black 1px";
  GLB_CALENDAR.popup.document.body.style.overflow= "hidden";
	GLB_CALENDAR.popup.document.all("oItem").value = GLB_CALENDAR.oItem;
	GLB_CALENDAR.popup.document.all("oMonth").value = GLB_CALENDAR.month - 1;
	GLB_CALENDAR.popup.document.all("oYear").value = GLB_CALENDAR.year;
	GLB_CALENDAR.popup.document.all("oFormat").value = GLB_CALENDAR.format;
	GLB_CALENDAR.popup.document.all("oRefreshBtn").fireEvent("onclick");
  GLB_CALENDAR.popup.show(0, 18, 192, 204, GLB_CALENDAR.eventSrc);
}

function cfStatusMessage(message) {
    window.status = message;
}


/* ********************************************************************************
 *                                  2008/09/12 추가
 * *******************************************************************************/
function __WS__(__NSID__)
{
	document.write( __NSID__.innerHTML );
	__NSID__.id = "";
}

function cfShowErrMsg(obj) {
  
  var msg = "";
  var msgType = "";
  var realMsg = "";

  if ( obj.ErrorCode == 0 ) // Request Cancel 처리
	return;

  if (obj.classid != null && obj.classid.toUpperCase() == "CLSID:223216F6-B9FE-406D-9ED6-143FCE3A07B8") {
    var errorMsg = obj.ErrorMsg;
    
    msgType = errorMsg.substring(errorMsg.lastIndexOf("[ERROR")+7,errorMsg.lastIndexOf("]"));
    realMsg = errorMsg.substring(errorMsg.lastIndexOf("]")+2,errorMsg.length);
  	realMsg = realMsg.replace("/n", "\n");
    msg += "데이터 처리 에러  발생!!!\n\n";
    if ( msgType == "SYS" ) {
      msg += "[SYS ERROR] : \n";
      msg += realMsg;
    } else if ( msgType == "BIZ" ) {
//      msg += "[BIZ ERROR] : \n";
//      msg += realMsg;
		msg = realMsg;
    } else if ( msgType == "AUTH" ) {
      msg += "[AUTH ERROR] : \n";
      msg += realMsg;
    } else if ( msgType == "ERROR" ) {
      msg += "[ERROR] : \n";
      msg += realMsg;
    } else {
      msg += obj.ErrorMsg;
    }
  } else if (obj.classid != null && obj.classid.toUpperCase() == "CLSID:AF989B7C-8AC3-40BC-B749-EB335BDFD190") {
    var errorMsg = obj.ErrorMsg;
    msgType = errorMsg.substring(errorMsg.lastIndexOf("[ERROR")+7,errorMsg.lastIndexOf("]"));
    realMsg = errorMsg.substring(errorMsg.lastIndexOf("]")+2,errorMsg.length);

    msg += "데이터 로드 에러 발생!!!\n\n";
    if ( msgType == "SYS" ) {
      msg += "[SYS ERROR] : \n";
      msg += realMsg;
    } else if ( msgType == "BIZ" ) {
      //msg += "[BIZ ERROR] : \n";
      //msg += realMsg;
      msg = realMsg;
    } else if ( msgType == "AUTH" ) {
      msg += "[AUTH ERROR] : \n";
      msg += realMsg;
    } else if ( msgType == "ERROR" ) {
      msg += "[ERROR] : \n";
      msg += realMsg;
    } else {
      msg += obj.ErrorMsg;
    }
  } else {
    msg = obj;
  }
  
  
  var ReqExp = "/SESSON_ERROR/";
  if(obj.ErrorMsg.search(ReqExp) != -1) {
	alert("Your Session is Terminated. You need to relogin!.");
	window.top.location.href = '/index.jsp';
  } else {
	alert(msg);
  }
  
  
  //if ( msgType == "AUTH" )
  //  top.location.href = "/jsp/pbf/commmon/security/login.jsp";
}


function cfHideNoDataMsg(gr) {
	if (document.all(gr.id+"NodataMsg") != null) {
		document.all(gr.id+"NodataMsg").style.visibility = "hidden";
	}
}


// 2009.11.05
/**
 * @type   : function
 * @access : public
 * @desc   : DataSet에 데이터를 로딩하는 동안 그리드에 대기 메시지 표시한다.<br>
 *           DataSet의 OnLoadStarted 이벤트에서 호출한다.
 * <pre>
 *     cfShowDSWaitMsg(gridID);
 * </pre>
 * @sig    : gridID
 * @param  : 가우스 Grid 오브젝트의 ID
 * @author : 송동혁 
 */
function cfShowDSWaitMsg(gr) {
	// 메시지 프레임의 크기
	//var msgWidth = 252;
	//var msgHeight = 26;
	var msgWidth = 291;// 이미지 가로 + 32
	var msgHeight = 51;// 이미지 세로 + 7
	var grWidth;
	
	// Grid의 width를 얻는 과정
	var tempWidthStr = gr.style.width;
	if (tempWidthStr.indexOf("px") != -1) {
		tempWidthStr = tempWidthStr.substr(0, tempWidthStr.indexOf("px"))
	}
	else if (tempWidthStr.indexOf("PX") != -1) {
		tempWidthStr = tempWidthStr.substr(0, tempWidthStr.indexOf("PX"))
	}
	
	grWidth = Number(tempWidthStr);
	
	// Grid의 width가 msgWidth보다 작으면 msgWidth를 Grid의 width로 변경한다
	if (grWidth < msgWidth) {
		msgWidth = grWidth - 10;
	}
	
	// Grid에 대해 만들어진 메시지 iframe이 없으면
	if (document.all(gr.id+"WaitMsg") == null) {
		//document.body.insertAdjacentHTML("beforeEnd", "<IFRAME id='" + gr.id + "WaitMsg' style='position:absolute; left:0px; top:5px; width:" + msgWidth + "; height:26' frameborder='0' src='/ptpam/sys/images/progress_bar.gif' scrolling='no'></IFRAME>");
		document.body.insertAdjacentHTML("beforeEnd", "<IFRAME id='" + gr.id + "WaitMsg' style='position:absolute; left:0px; top:5px; width:" + msgWidth + "; height:51' frameborder='0' src='/sys/images/loading.gif' scrolling='no'></IFRAME>");
	}

	// 그리드 오브젝트의 좌표
	var gridLeft   = gr.getBoundingClientRect().left;
	var gridRight  = gr.getBoundingClientRect().right;
	var gridTop    = gr.getBoundingClientRect().top;
	var gridBottom = gr.getBoundingClientRect().bottom;
	
	var leftCoor = gridLeft + (gridRight - gridLeft - msgWidth) / 2;
	var topCoor  = gridTop + (gridBottom - gridTop - msgHeight) / 2;

	document.all(gr.id+"WaitMsg").style.left = leftCoor;
	document.all(gr.id+"WaitMsg").style.top = topCoor;
	document.all(gr.id+"WaitMsg").style.visibility = "visible";
}


function findPos(obj) {
	var curleft = curtop = curwidth = curheight = 0;
	if (obj.offsetParent) {
		curleft = obj.offsetLeft;
		curtop = obj.offsetTop;
		curwidth = obj.offsetWidth;
		curheight = obj.offsetHeight;
		
		while (obj = obj.offsetParent) {
			curleft += obj.offsetLeft;
			curtop += obj.offsetTop;
		}
	}
	return [curleft,curtop,curwidth,curheight];
}

/**
 * @type   : function
 * @access : public
 * @desc   : DataSet에 데이터를 로딩하는 동안 그리드에 표시된 대기 메시지(cfShowDSWaitMsg 함수를 이용해서 띄운)를 숨긴다.<br>
 *           DataSet의 OnLoadCompleted 이벤트에서 호출한다.
 * <pre>

 *     cfShowDSWaitMsg(gridID);
 * </pre>
 * @sig    : gridID
 * @param  : 가우스 Grid 오브젝트의 ID
 * @author : 송동혁 
 */
function cfHideDSWaitMsg(gr) {
	if (document.all(gr.id+"WaitMsg") != null) {
		document.all(gr.id+"WaitMsg").style.visibility = "hidden";
	}
}


/**
 * @type   : function
 * @access : public
 * @desc   : 그리드 팝업 버튼을 돋보기로 지정한다.
 * @sig    : oGrid
 * @param  : oGrid required 그리드 아이드
 */
function cfSetSearchGridBtn(oGrid) {

	oGrid.UrlImages=SEARCH_BTN;
}

/**
 * @type   : function
 * @access : public
 * @desc   : 그리드 팝업 버튼을 캘린더로 지정한다.
 * @sig    : oGrid
 * @param  : oGrid required 그리드 아이드
 */
function cfSetCalendarGridBtn(oGrid) {
	oGrid.UrlImages=CALENDAR_BTN;
}