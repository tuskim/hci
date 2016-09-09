/* ------------------------------------------------------------------------
 * @source  : CommonUtil.java
 * @desc    : 공통적으로 사용하는 유틸클래스
 * ------------------------------------------------------------------------
 * LG CNS LTE(DevOn Test Environment)
 * Copyright(c) 2006 LG CNS,  All rights reserved.
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2008.09.12   김성진                            최초 작성
 * ------------------------------------------------------------------------ */
package comm.util;

public class CommonUtil {
	//콤보 selected
	public static String isSelected(String value1, String value2) {

		if (value1 == null || value2 == null) 
			return "";

		return value1.equals(value2) ? "SELECTED" : "";
	}
	// 변수값, 대체값 checkNull(title,"");
	public static String checkNull(String value1, String value2){
        String strTmp;
        if(value1 == null)
            strTmp = value2;
        else
            strTmp = value1;
        return strTmp;
    }
}
