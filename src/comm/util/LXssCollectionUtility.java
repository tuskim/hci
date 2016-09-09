/* ------------------------------------------------------------------------
 * @source  : LCollectionUtility의.java
 * @desc    : XSS Injection 방어
 * ------------------------------------------------------------------------
 *
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2010.07.24                      Initial
 * 1.1  2015.10.08   hskim              CSR:C20151005_87394 파일명 XSS 체크 로직 추가
 * ------------------------------------------------------------------------ */

package comm.util;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devonframework.front.fileupload.LFormInfo;
import devonframework.front.fileupload.LMultipartRequest;

/**
 * <pre>
 * XSS Injection을 방어 하기 위한 CollectionUtility 이다.
 * XSS Injection 방어 는 물론 기존에 LCollectionUtility의 기능인 Servlet을 통해 가져온 HttpServletRequeset를
 * 파싱하여 DevOn에서 제공하는 LData, LMultiData 형태로 바꿔준다.
 *
 * Method는 모두 static method로 구성되어 있다. 
 *
 * 이 LXssCollectionUtility 클래스는 DevOn 3.0 이상에서 동작한다.
 * </pre>
 * 
 * @since DevOn Framework 3.0
 * @version DevOn Framework 3.0
 * @author Corporate Asset팀, devon@lgcns.com<br>
 *         LG CNS Technical Service Division<br>
 *         작성 : 2008/08/07<br>
 * 
 */
public class LXssCollectionUtility {

    /**
     * 파라미터로 HttpServletRequest를 받아 FORM INPUT Data를 parsing하여 LData객체에 담아 return한다.
     * getParameterValues() 사용한다.
     * 
     * @param req javax.servlet.http.HttpServletRequest
     * @return LData Input data
     */

    public static LData getData(HttpServletRequest req){
        return getData(req, "");
    }

    /**
     * 파라미터로 HttpServletRequest를 받아 FORM INPUT Data를 parsing하여 LData객체에 담아 return한다.
     * getParameterValues() 사용한다. 
     * 
     * @param req javax.servlet.http.HttpServletRequest
     * @param allowTag 허용할 태그 리스트 예)allowTag = "p,br" 
     * @return
     */
    public static LData getData(HttpServletRequest req, String allowTag){
        LData data = new LData("REQUEST_DATA");
        Enumeration e = req.getParameterNames();
        while (e.hasMoreElements()) {
            String key = (String)e.nextElement();
            data.put(key, clearXSS(req.getParameter(key), allowTag));
        }
        return data;
    }

    /**
     * 파라미터로 LMultipartRequest를 받아 FORM INPUT Data를 parsing하여 LData객체에 담아 return한다.
     * LMultipartRequest개체의 getParameters() 사용한다. LData의 특성상 같은 이름의 form data가 존재하는 경우 최초의 form
     * data만이 access 가능하다.
     * 
     * @param mReq com.lgeds.laf.servlet.LMultipartRequest
     * @return LData Input data
     */
    public static LData getData(LMultipartRequest mReq){
        return getData(mReq, "");
    }

    /**
     * 파라미터로 LMultipartRequest를 받아 FORM INPUT Data를 parsing하여 LData객체에 담아 return한다.
     * LMultipartRequest개체의 getParameters() 사용한다. LData의 특성상 같은 이름의 form data가 존재하는 경우 최초의 form
     * data만이 access 가능하다.
     * 
     * @param mReq com.lgeds.laf.servlet.LMultipartRequest
     * @param allowTag 허용할 태그 리스트 예)allowTag = "p,br" 
     * @return
     */
    public static LData getData(LMultipartRequest mReq, String allowTag){
        LData data = new LData("REQUEST_DATA");
        List formData = mReq.getParameters();
        Iterator iter = formData.iterator();
        while (iter.hasNext()) {
            LFormInfo item = (LFormInfo)iter.next();
            String key = item.getFieldName();
            if (!data.containsKey(key)) data.put(key, clearXSS(item.getFieldValue(), allowTag));
        }
        return data;
    }

    /**
     * 파라미터로 HttpServletRequest를 받아 FORM INPUT Data를 parsing하여 LVectorBox객체에 담아 return한다.
     * getParameterValues() 사용한다.
     * 
     * @param req javax.servlet.http.HttpServletRequest
     * @return LVectorBox Input multi-data
     */
    public static LMultiData getMultiData(HttpServletRequest req){
        return getMultiData(req, "");
    }
    
    /**
     * 파라미터로 HttpServletRequest를 받아 FORM INPUT Data를 parsing하여 LVectorBox객체에 담아 return한다.
     * getParameterValues() 사용한다.
     * 
     * @param req javax.servlet.http.HttpServletRequest
     * @param allowTag 허용할 태그 리스트 예)allowTag = "p,br" 
     * @return
     */
    public static LMultiData getMultiData(HttpServletRequest req, String allowTag){
        LMultiData multiData = new LMultiData("requestbox");

        Enumeration e = req.getParameterNames();
        while (e.hasMoreElements()) {
            String key = (String)e.nextElement();
            String[] values = req.getParameterValues(key);
            ArrayList list = new ArrayList();
            for (int i = 0; i < values.length; i++) {
                list.add(clearXSS(values[i], allowTag));
            }
            multiData.put(key, list);
        }
        return multiData;
    }

    /**
     * 파라미터로 LMultipartRequest를 받아 FORM INPUT Data를 parsing하여 LData객체에 담아 return한다.
     * LMultipartRequest개체의 getParameters() 사용한다. LMultiData의 특성상 같은 이름의 form data가 존재하는 경우에도 모든
     * form data에 access 가능하다.
     * 
     * @param mReq LMultipartRequest
     * @return formdata가 해석된 LData
     */
    public static LMultiData getMultiData(LMultipartRequest mReq){
        return getMultiData(mReq, "");
    }

    /**
     * 파라미터로 LMultipartRequest를 받아 FORM INPUT Data를 parsing하여 LData객체에 담아 return한다.
     * LMultipartRequest개체의 getParameters() 사용한다. LMultiData의 특성상 같은 이름의 form data가 존재하는 경우에도 모든
     * form data에 access 가능하다.
     * 
     * @param mReq LMultipartRequest
     * @param allowTag 허용할 태그 리스트 예)allowTag = "p,br" 
     * @return
     */
    public static LMultiData getMultiData(LMultipartRequest mReq, String allowTag){

        LMultiData multiData = new LMultiData("REQUEST_DATA");
        List formData = mReq.getParameters();
        Iterator iter = formData.iterator();
        while (iter.hasNext()) {
            LFormInfo item = (LFormInfo)iter.next();
            String key = item.getFieldName();
            if (!multiData.containsKey(key)) {
                ArrayList list = new ArrayList();
                list.add(clearXSS(item.getFieldValue(), allowTag));
                multiData.put(key, list);
            } else {
                ArrayList list = (ArrayList)multiData.get(key);
                list.add(clearXSS(item.getFieldValue(), allowTag));
            }
        }
        return multiData;
    }

    /**
     * Cross Site Scripting을 방지하기 위한 필터링을 해주는 메소드이다.<BR>
     * 반드시 프로젝트에 상황에 맞게 변경하여 사용하기 바란다.<BR>
     *
     * @param str 필터링할 출력값
     * @param allowTag 허용할 태그 리스트 예)allowTag = "p,br"
     * @return str 필터링된 출력값
     */
    /**
     * Cross Site Scripting을 방지하기 위한 필터링을 해주는 메소드이다.<BR>
     * 반드시 프로젝트의 상황에 맞게 변경하여 사용하기 바란다.<BR>
     *
     * @param str 필터링할 출력값
     * @param allowTag 허용할 태그 리스트 예)allowTag = "p,br"
     * @return str 필터링된 출력값
     */
    public static String clearXSS(String str, String allowTag){
        if (str == null || str.length() == 0) { return str; }
    
        //허용되지 않은 태그를 변경해주는 로직   
        str = processReplace(str);  

        // 허용할 태그를 지정할 경우
        if (!allowTag.equals("")) {
            allowTag.replaceAll(" ", "");

            String[] st = allowTag.split(",");

            // 허용할 태그를 존재 여부를 검사하여 원상태로 변환
            for (int x = 0; x < st.length; x++) {
                str = str.replaceAll("&lt;" + st[x] + " ", "<" + st[x] + " ");
                str = str.replaceAll("&lt;" + st[x] + ">", "<" + st[x] + ">");
                str = str.replaceAll("&lt;/" + st[x], "</" + st[x]);
            }
        }
        return (str);
    }

    public static String processReplace(String value){  
    	StringBuffer sb = new StringBuffer();  
    	for (int idx = 0; idx < value.length(); idx++) {  
    		char c = value.charAt(idx);  
    		switch (c) {  
    		case '\0':  
    			break;  
    		case '<':  
    			sb.append("&lt;");  
    			break;  
    		case '>':  
    			sb.append("&gt;");  
    			break;  
    		case '&':  
    			sb.append("&#38;");  
    			break;  
    		case '#':  
    			sb.append("&#35;");  
    			break;  
    		case ';':  
    			sb.append("&#59;");  
    			break;  
    		case '"':  
    			sb.append("&#34;");  
    			break;  
    		case '\'':  
    			sb.append("&#39;");  
    			break;  
    		/*
    		case '(':  
    			sb.append("&#40;");  
    			break;  
    		case ')':  
    			sb.append("&#41;");  
    			break;
    		*/  
    		default:  
    			sb.append(c);  
    		}  
    	}  
    	return sb.toString();  
    }  
    public static LData getDataHtml(HttpServletRequest req){
        LData data = new LData("REQUEST_DATA");
        Enumeration e = req.getParameterNames();
        while (e.hasMoreElements()) {
            String key = (String)e.nextElement();
            data.put(key, req.getParameter(key));
        }
        return data;
    } 
    
    public static boolean checkXSS(String value){  
    	boolean checkXss = true;
    	for (int idx = 0; idx < value.length(); idx++) {  
    		char c = value.charAt(idx);  
    		switch (c) {  
    		case '<':  
    			checkXss = false;
    			return checkXss;
    		case '>':  
    			checkXss = false;
    			return checkXss;
    		case '&':  
    			checkXss = false;
    			return checkXss;
    		case '#':  
    			checkXss = false;
    			return checkXss; 
    		case ';':  
    			checkXss = false;
    			return checkXss;
    		case '"':  
    			checkXss = false;
    			return checkXss;
    		case '\'':  
    			checkXss = false;
    			return checkXss;
    		default:  
    			checkXss = true;
    		}  
    	}  
    	return checkXss; 
    }  
    
}
