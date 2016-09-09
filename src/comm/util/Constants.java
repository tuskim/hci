package comm.util;

public class Constants {


    /** 전역 메세지 유무 **/
    public static final String grobal_msg = null;

    /**
     *
     */
    public static final String SERVLET_ERROR_REQUEST_URI_KEY = "lte.servlet.error.request_uri";

    /**
     *
     */
    public static final String SERVLET_ERROR_EXCEPTION_KEY = "lte.servlet.error.exception";

    /**
     *
     */
    public static final String SERVLET_ERROR_CODE_KEY = "lte.servlet.error.code";

    /**
     * stopwatch Ű ���
     */
    public static final String SERVLET_STOPWATCH_KEY = "lte.servlet.stopwatch";

    /**
     * �޽��� ��� prefix
     */
    public static final String MSG_PREFIX = "dev.";

    /**
     * �޽��� ��� : ����(CUD) ����
     */
    public static final String MSG_SUCCESS_SAVE = MSG_PREFIX + "suc.com.save";

    /**
     * �޽��� ��� : vȸ ����
     */
    public static final String MSG_SUCCESS_SELECT = MSG_PREFIX + "suc.com.retrieve";

    /**
     * �޽��� ��� : ��f ����
     */
    public static final String MSG_SUCCESS_DELETE = MSG_PREFIX + "suc.com.delete";

    /**
     * �޽��� ��� : ����Ʈ ����
     */
    public static final String MSG_SUCCESS_UPDATE = MSG_PREFIX + "suc.com.update";

    /**
     * �޽��� ��� : �˻�� d���� ��=
     */
    public static final String MSG_INFO_NODATA = MSG_PREFIX + "inf.com.nodata";

    /**
     * �޽��� ��� : ������ d���� ��=
     */
    public static final String MSG_INFO_NOSAVE = MSG_PREFIX + "inf.com.nosave";

    /**
     * �޽��� ��� : vȸ �7�
     */
    public static final String MSG_ERROR_RETRIEVE = MSG_PREFIX + "err.com.retrieve";

    /**
     * �޽��� ��� : �� �7�
     */
    public static final String MSG_ERROR_CREATE = MSG_PREFIX + "err.com.create";

    /**
     * �޽��� ��� : ����Ʈ �7�
     */
    public static final String MSG_ERROR_UPDATE = MSG_PREFIX + "err.com.update";

    /**
     * �޽��� ��� : ��f �7�
     */
    public static final String MSG_ERROR_DELETE = MSG_PREFIX + "err.com.delete";

    /**
     * �޽��� ��� : ����(CUD) �7�
     */
    public static final String MSG_ERROR_SAVE = MSG_PREFIX + "err.com.save";

    /**
     * �޽��� ��� : �ߺ�Ű �7�
     */
    public static final String MSG_ERROR_DUPLICATE = MSG_PREFIX + "err.com.duplicate";

    /**
     * �޽��� ��� : �˼� ��� �7�
     */
    public static final String MSG_ERROR_DEFAULT = MSG_PREFIX + "err.com.desc";


    /**
     * 세션 관련 상수
     */
    public static final String SS_CLIENT    = "client";
    public static final String SS_USERID    = "userid";
    public static final String SS_USERNAME = "username";
    public static final String SS_EMAIL = "email";
    public static final String SS_STATE = "state";
    public static final String SS_DIVGUBUN = "divgubun";
    public static final String SS_SYSAUTH = "sysauth";
    public static final String SS_USESTDT = "usestdt";
    public static final String SS_USEEDDT = "useeddt";
    public static final String SS_CRNAM = "crnam";
    public static final String SS_CRDAT = "crdat";
    public static final String SS_CRTIM = "crtim";
    public static final String SS_CUNAM = "cunam";
    public static final String SS_CUDAT = "cudat";
    public static final String SS_CUYIM = "cuyim";

    public static final String SS_AUTH_LIST     = "authList";
    public static final String SS_MENU_LIST     = "menuList";
    public static final String SS_SELECTED_MENU_ID      = "selectedMenuId";
    public static final String SS_SELECTED_MENU_TITLE   = "selectedMenuTitle";
    public static final String SS_SKIN_COLOR    = "skinColor";

    // 업로드 이미지의 시작 경로
    public static final String UPFILE_BIDDING    = "bidding"   ; // bidding
    public static final String UPFILE_SR         = "sr"        ; // sr
    public static final String UPFILE_BL_CHECK   = "bl_check"  ; // check BL
    public static final String UPFILE_BL_CONFIRM = "bl_confirm"; // 확정 BL
    public static final String UPFILE_COST       = "cost"      ; // 운임/비용
    public static final String UPFILE_BOARD      = "board"     ; // 게시판
    public static final String UPFILE_ETC        = "etc"       ; // 기타
    //public static final String UPFILE_CI         = "/lils/devonhome/doc/ci" ; // 개발 통관 C/I
    //public static final String UPFILE_PL         = "/lils/devonhome/doc/pl" ; // 개발 통관 P/L
    public static final String UPFILE_CI         = "/data2/lils/doc/ci" ; // 운영 통관 C/I
    public static final String UPFILE_PL         = "/data2/lils/doc/pl" ; // 운영 통관 P/L
    
    // 범한 업체 코드
    public static final String PANTOS = "300416";
    
    // xml 경로
    public static String getXmlPath(String serverIp) throws Exception{

    	if ("203.247.133.181".equals(serverIp)){				//개발서버
    		return "/data2/bea81/weblogic81/domains/mgedomain/applications/mge/web/xml/";
    	} else if ("165.244.231.227".equals(serverIp))  {
    		return "/home/lgeds/weblogic/bea/domains/mgedomain/applications/mge/web/xml/";
    	} else if ("203.247.133.143".equals(serverIp)){		//운영서버
    		return "/data1/bea81/weblogic81/domains/mgedomain/applications/mge/web/xml/";
    	} else {													//로컬서버
    		return "C:/DevOnOffice/workspace/mge/web/xml/";
    	} 
    }
}
