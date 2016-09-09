/**
 * 
 */
package comm.util;

/**
 * <PRE>
 * 	DB parameter 값을 위한 스트링 유틸
 * </PRE>
 *
 * @author    박대범
 * @version   2008. 09. 04
 * @see       SqlStringUtil
 */
public class SqlStringUtil {
    public SqlStringUtil() { }
    

    /**
     * <pre>
     *       일부 검색을 위해 단어의 앞뒤에 %문자를 더해주는 함수로서,
     *       null 이나 빈 문자열이 입력될 경우 전체 검색이 되게 하기위해 &quot;%&quot;를 리턴한다. 
     *       SQL의 LIKE 문을 사용할 경우 사용된다.
     * </pre>
     * 
     * @param word String
     */
    public static String makeLikeWord( String word ) {

        String likeWord = "%";

        if ( word != null ) {
            if ( !word.equals( "" ) ) {
                likeWord = "%" + word + "%";
            }
        }
        return likeWord;
    }

    /**
     * <pre>
     *       전달한 파라미터가 null일 경우 wild card 문자인 &quot;%&quot;를 리턴한다.
     *       null 이외의 경우에는 전달된 문자 그대로 return 함
     * </pre>
     * 
     * @param word String
     */
    public static String changeNullToWildCard( String word ) {

        String returnValue = word;

        if ( word == null || word.equals( "" ) ) {
            returnValue = "%";
        }
        return returnValue;
    }

    /**
     * <pre>
     *       전달한 파라미터가 null일 경우 ABC 주식회사가 다루는 년도의 최대값인 3999년 12월 31일에 
     *       서 하루를 뺀 '3999-12-30'을 리턴한다.   
     * </pre>
     * 
     * @param date String
     */
    public static String changeNullToMaxDate( String date ) {

        String returnValue = date;

        if ( date == null || date.equals( "" ) ) {
            returnValue = "3999-12-30";
        }

        return returnValue;
    }

    /**
     * <pre>
     *       전달한 파라미터가 null일 경우 ABC 주식회사가 다루는 년도의 최소값인 1900년 1월 1일에   
     *       해당하는 문자열 '1900-1-1' 을 리턴한다.
     *       
     * </pre>
     * 
     * @param date String
     */
    public static String changeNullToMinDate( String date ) {

        String returnValue = date;

        if ( date == null || date.equals( "" ) ) {
            returnValue = "1900-1-1";
        }

        return returnValue;
    }

    /**
     * <pre>
     *       전달한 파라미터가 null일 경우 문자열 "0"으로 변환한다.
     * </pre>
     * 
     * @param word String
     */
    public static String changeNullToStringZero( String word ) {

        String returnValue = word;

        if ( word == null || word.equals( "" ) ) {
            returnValue = "0";
        }

        return returnValue;
    }
}
