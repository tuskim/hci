/**
 * 
 */
package comm.util;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.StringTokenizer;

import devon.core.log.LLog;

/**
 * @author Kim.Byung.Chul
 */

public class StringUtil {
	
	/*********************************************************************
	 * 한글 인코딩
	 **********************************************************************/
	public static String toKorean(String str){
		try{
			return new String(str.getBytes("8859_1"),"euc-kr"); 
		}catch(Exception e){
			return null;
		}
	}	
	
	
	
	
	public static String kor(String s){
		if(s == null || s.length() == 0) return "";

		String s1;

		try{
			s1 = new String(s.getBytes("ISO-8859-1"), "KSC5601");
		}catch(UnsupportedEncodingException unsupportedencodingexception){
			s1 = "";
		}

		return s1;
	}
	
		
	
	/*********************************************************************
	 * 스플릿 - 배열반환
	 **********************************************************************/	
	public static String[] strSplit(String str, int arrNum, String gubun){		

		String[] strArr = null;
		String[] returnStrArr = new String[arrNum];
		StringTokenizer st = null;
		int len;
	
		if(str.length() > 0){
			st = new StringTokenizer(str, gubun);
            
			len     = st.countTokens();
			strArr  = new String[len];
			for(int i=0 ; i<len ; i++){
				strArr[i] = (String) st.nextElement();
			}		
		}
		
		for(int i = 0 ; i < arrNum ; i++){
			if( i <= strArr.length){
				returnStrArr[i] = strArr[i].trim();
				
			}else{
				returnStrArr[i] = "";
			}
		}
		
		return returnStrArr;
	}
	
	/*********************************************************************
	 * 스플릿 - ArrayList 반환
	 **********************************************************************/	
	public static ArrayList strSplit(String str, String gubun){
		ArrayList list = new ArrayList();

		StringTokenizer st = new StringTokenizer(str, gubun);

		while (st.hasMoreTokens())
			list.add(st.nextToken());

		return list;
	}

	
	
	
	/*********************************************************************
	 * 스트링(날자형태) 값을 날자형 스트링으로 변환 ("20050701" --> "2005-07-01")
	 **********************************************************************/	
	public static String ReplaceDateToString(String str, String bar){		
	
		String returnStr = "";
		
		if (str.length() == 8){
			returnStr = str.substring(0, 4) + bar + str.substring(4, 6) + bar + str.substring(6, 8); 			
		}else{
			returnStr = "잘못된 값";
		}		
		return returnStr;
	}
	
	
	
	/*********************************************************************
	 * 숫자(날자형태) 값을 날자형 스트링으로 변환 (20050701 --> "2005-07-01")
	 **********************************************************************/	
	public static String ReplaceDateToString(int num, String bar){		
	
		String str = "";
		String returnStr = "";
		
		str = Integer.toString(num);
		
		if (str.length() == 8){
			returnStr = str.substring(0, 4) + bar + str.substring(4, 6) + bar + str.substring(6, 8);  			
		}else{
			returnStr = "잘못된 값";
		}		
		return returnStr;
	}
	
	
	/*********************************************************************
	 * null값을 "" 값으로 변환
	 **********************************************************************/
	public static String chknull(String s){
		if(s == null || s.equals("null")){
			s = "";			
		}		
		return s;
	}
	

	
	
	
	
	/******************************************************denial/
	/*	설명	    :	chknull 의 Integer 버전, 입력받은 스트링의 Null 체크후 Integer 값으로 바꿀 필요가 있을때
	/*	INPUT	:	스트링, Null 이나 ""일때의 기본 Integer 값
	/*	OUTPUT	:	Integer
	/**********************************************************/
	public static int chknull(String s, int defaultval){
		if(s == null || s.equals("null")){
			return defaultval;			
		}else{
			return Integer.parseInt(s);
		}				
	}
	
	public static long chknull(String s, long defaultval){
		if(s == null || s.equals("null")){
			return defaultval;			
		}else{
			return Long.parseLong(s);
		}				
	}


	
	/**
	*	일정길이만큼 문자열을 자르고 나머지는 다른 문자열로 바꿈
	*
	*	@param	str		원본 문자열
	*	@param	i		자를 길이
	*	@param	trail	바꿀 문자열
	*	@return	완성된 문자열
	*/
	public static String cropByte(String str, int i, String trail){
		if (str == null) return "";
		String tmp = str;
		int slen = 0, blen = 0;
		char c;
		if(tmp.getBytes().length > i)
		{
			while (blen+1 < i)
			{
				c = tmp.charAt(slen);
				blen++;
				slen++;
				if ( c  > 127 ) blen++;  //2-byte character..
			}
			tmp = tmp.substring(0, slen) + trail;
		}

		return tmp;
	}
	
	
	/****************************************************************************************
	 * 문자열의 좌변에 지정된 문자열을 원하는 지정된 길이이만큼 붙여준다 ("123", 5, "0"  --> "00123")
	 *****************************************************************************************/	
	public static String lPad(String s, int size, String txt){
		int len = size - s.length();

		if (len <= 0) return s;

		String tmp = "";

		for (int i = 0; i < len; i++)
			tmp += txt;

		return tmp + s;
	}
	
	
	
	
	/****************************************************************************************
	 * 문자열의 좌변에 지정된 문자열을 원하는 지정된 길이이만큼 붙여준다 ("123", 5, "0"  --> "00123")
	 *****************************************************************************************/	
	public static String rPad(String s, int size, String txt){
		int len = size - s.length();

		if (len <= 0) return s;

		String tmp = s;

		for (int i = 0; i < len; i++)
			tmp += txt;

		return tmp;
	}

	public static String toBR(String contents)
	{
		int len = contents.length();
		int linenum = 0;
		int i = 0;
		for(i = 0; i < len; i++)
			if(contents.charAt(i) == '\n')
				linenum++;

		StringBuffer result = new StringBuffer(len + linenum * 3);
		for(i = 0; i < len; i++)
			if(contents.charAt(i) == '\n')
				result.append("<br>");
			else
				result.append(contents.charAt(i));

		return result.toString();
	}
	
	public static String commaSetting(String Source){
		String sReturn = "";
		String sTemp = Source.trim();
		boolean point = false;
		int i = 0;
		int j = 0;
		if(sTemp.indexOf(".") != -1){
			i = sTemp.indexOf(".")-1;
			point = true;
		}else{
			i = (sTemp.length()-1);
		}
 
		for( ; i>=0; i--){
			if((j%3 == 0) && (j!=0)){
				sReturn =  sTemp.substring(i, i+1) + "," + sReturn;
			}else{
				sReturn = sTemp.substring(i, i+1) + sReturn;
			}

			j++;
		}
		return sReturn;
	}
	
}

