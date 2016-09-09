package comm.util;


import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Array;
import java.lang.reflect.Field;
import java.util.Enumeration;
import java.util.Vector;

import devon.core.log.LLog;


public final class DataUtil {
/******************************************************************************
*
*       숫자 관련 Util 함수들..
*
*******************************************************************************/
    public static int DEFAULT_DECIMALSIZE = 0;
    public static int ROUND_HALF_UP = 0;
    public static int ROUND_UP      = 1;
    public static int ROUND_DOWN    = 2;

    public static String DEFULT_STRUCTUR;
    public static String DEFULT_COMMA;

     static
    {
        try{
           // com.sns.jdf.conf.Config conf = new com.sns.jdf.conf.Configuration();

            //DEFAULT_DECIMALSIZE = Integer.parseInt(conf.get("com.sns.jdf.DEFAULT_DECIMALSIZED"));
           // DEFULT_STRUCTUR     = conf.get("com.sns.jdf.DEFAULT_SEPARATER");
            //DEFULT_COMMA        = conf.get("com.sns.jdf.DEFULT_COMMA");
        } catch(Exception e) {
            //com.sns.jdf.conf.Logger.err.println("DataUtil Exception. Failed create Configuration Object!  e : "+e.toString());
            //throw new com.sns.jdf.GeneralException(e);
        }
    }

/*****************************JDFUtil***************************************************/
        /**
     * Object[] 의 복제. Object의 Array 를 복제(clone)하여
     * 새로운 Instance를 만들어 줍니다.
     *
     * @param objects java.lang.Object[]
     * @return java.lang.Object[]
     *
     * @see clone(java.lang.Object)
     * @see clone(java.lang.Vector)
     */
    public static Object[] clone(Object[] objects)
    {
        int length = objects.length;
        Class c = objects.getClass().getComponentType();
        Object array = Array.newInstance(c, length);

        for(int i=0;i<length;i++){
            Array.set(array, i, clone(objects[i]));
        }
        return (Object[])array;
    }

    /**
     * Object 의 복제. 일반적으로 <code>java.lang.Object.clone()</code> 함수를
     * 를 사용하여 Object를 복제하면 Object내에 있는 Primitive type을 제외한 Object
     * field들은 복제가 되는 것이 아니라 같은 Object의 reference를
     * 갖게 된다.<br>
     * 그러나 이 Method를 사용하면 각 field의 동일한 Object를 새로 복제(clone)하여
     * 준다.
     *
     * @param object java.lang.Object
     * @return java.lang.Object
     *
     * @see clone(java.lang.Object[])
     * @see clone(java.lang.Vector)
     */
    public static Object clone(Object object)
    {
        Class c = object.getClass();
        Object newObject = null;
        try {
            newObject = c.newInstance();
        }
        catch(Exception e ){
            return null;
        }

        Field[] field = c.getFields();
        for (int i=0 ; i<field.length; i++) {
            try {
                Object f = field[i].get(object);
                field[i].set(newObject, f);
            }
            catch(Exception e){
            }
        }
        return newObject;
    }

    /**
     * Vector 의 복제. 일반적으로 Vector Object를 clone()을 하면
     * Vector내의 Element Object는 새로 생성되는 것이 아니라
     * 동일한 Object에 대한 reference만 새로 생성되기 때문에 같은 Element Object를
     * reference하는 Vector를 생성하게 된다. 그러나 이 method를 사용하면
     * Vector내의 모든 Element Object도 새로 복제하여 준다.
     *
     * @param objects java.util.Vector
     * @return java.util.Vector
     *
     * @see clone(java.lang.Object)
     * @see clone(java.lang.Object[])
     */
    public static Vector clone(Vector objects)
    {
        Vector newObjects = new Vector();
        Enumeration e = objects.elements();
        while(e.hasMoreElements()){
            Object o = e.nextElement();
            newObjects.addElement(DataUtil.clone(o));
        }
        return newObjects;
    }

    /**
     * Entity Class의 null string field 초기화.
     * <p>
     * Entity class 내에 있는 java.lang.String형의 field는 DB의 Column과
     * 밀접한 연관이 있는 경우가 많다. 이러한 Entity Field가 특히 GUI의 특정
     * TextFiled에 표현되어야 하는 경우도 많다. 만약 그 String Filed가 null일
     * 경우 일일이 검사를 한다는 것은 참으로 답답한 일이 아닐 수 없다.
     * <p>
     * 이 method는 여하한의 Object 내에 있는 모든 java.lang.String형의 field 변수 중
     * null 값으로 된 field를 길이가 0 인 blank string("")으로 초기화 시켜준다.
     * <p>
     *
     * <xmp>
     * Sample Code:
     * public java.util.Vector selectAll() throws Exception
     * {
     *  java.util.Vector list = new Vector();
     *  Statement stmt = null;
     *  ResultSet rs =null;
     *  try{
     *      stmt = conn.createStatement();
     *      String query = "select " +
     *          "id, " +
     *          "name, " +
     *          "desc " +
     *          "from THE10 " +
     *          "order by id ";
     *
     *      rs = stmt.executeQuery(query);
     *
     *      while ( rs.next() ) {
     *          AdminAuth entity = new AdminAuth();
     *          entity.id = rs.getString("id");
     *          entity.name = rs.getString("name");
     *          entity.desc = rs.getString("desc");
     *          fixNull(entity);
     *          list.addElement(entity);
     *      }
     *  }
     *  finally {
     *      try{rs.close();}catch(Exception e){}
     *      try{stmt.close();}catch(Exception e){}
     *  }
     *  return list;
     * }
     *</xmp
     *
     * @param java.lang.Object Object내의 public java.lang.String 형의
     *        member variable에만 영향을 준다.
     *
     * @see fixNullAll(java.lang.Object)
     * @see fixNullAndTrim(java.lang.Object)
     * @see fixNullAndTrimAll(java.lang.Object)
     * @author WonYoung Lee, wyounglee@lgeds.lg.co.kr
     */
    public static void fixNull(Object o)
    {
        if ( o == null ) return;

        Class c = o.getClass();
        if ( c.isPrimitive() ) return;

        Field[] fields = c.getFields();
        for (int i=0 ; i<fields.length; i++) {
            try {
                Object f = fields[i].get(o);
                Class fc = fields[i].getType();

                if ( fc.getName().equals("java.lang.String") ) {
                    if ( f == null ) fields[i].set(o, "");
                    else    fields[i].set(o, f);
                }
            }
            catch(Exception e){
            }
        }
    }

    /**
     * Entity Class의 재귀적인 null string field 초기화.
     * <p>
     * fixNull() 과 유사한 기능을 하는데, java.lang.String field 뿐만 아니라
     * Member 변수 중 Array, Object 가 있으면 재귀적으로 쫒아 가서 String형을
     * blank string("")으로 만들어 준다.<br>
     * 정상적인 String인 경우 trim()을 시켜준다.<br>
     * 만약 Array나, Vector가 null일 경우 Instance화는 하지 않는다.
     *
     * <p>
     * 재귀적으로 추적되는 만큼, 부모와 자식간에 서로 양방향 reference를 갖고 있으면
     * 절대 안된다. Stack Overflow를 내며 JVM을 내릴 것이다.
     *
     *
     * @param java.lang.Object Object내의 public String 형뿐만 아니라, Object[], Vector 등과
     *        같은 public Object형 Member Variable에 영향을 준다.
     *
     * @see fixNull(java.lang.Object)
     * @see fixNullAndTrim(java.lang.Object)
     * @see fixNullAndTrimAll(java.lang.Object)
     *
     * @author 김형기
     */
    public static void fixNullAll(Object o)
    {
        if ( o == null ) return;

        Class c = o.getClass();
        if ( c.isPrimitive() ) return;

        if( c.isArray() ) {
            int length = Array.getLength(o);
            for(int i=0; i<length ;i++){
                Object element = Array.get(o, i);
                fixNullAll(element);
            }
        }
        else {
            Field[] fields = c.getFields();
            for (int i=0 ; i<fields.length; i++) {
                try {
                    Object f = fields[i].get(o);
                    Class fc = fields[i].getType();
                    if ( fc.isPrimitive() ) continue;
                    if ( fc.getName().equals("java.lang.String") ) {
                        if ( f == null ) fields[i].set(o, "");
                        else    fields[i].set(o, f);
                    }
                    else if ( f != null ) {
                        fixNullAll(f);
                    }
                    else {} // Some Object, but it's null.
                }
                catch(Exception e) {
                }
            }
        }
    }

    /**
     * Entity Class의 null string field 초기화 &amp; trim().
     * <p>
     * Entity class 내에 있는 java.lang.String형의 field는 DB의 Column과
     * 밀접한 연관이 있는 경우가 많다. 이러한 Entity Field가 특히 GUI의 특정
     * TextFiled에 표현되어야 하는 경우도 많다. 만약 그 String Filed가 null일
     * 경우 일일이 검사를 한다는 것은 참으로 답답한 일이 아닐 수 없다.
     * <p>
     * 이 method는 여하한의 Object 내에 있는 모든 java.lang.String형의 field 변수 중
     * null 값으로 된 field를 길이가 0 인 blank string("")으로 초기화 시켜준다.
     * 만약 null이 아닌 정상적인 String이 대입되어 있으면 강제적으로 trim()를
     * 시켜준다.
     * <p>
     * 이 때 trim() 함수는 java.lang.String 의 trim()을 사용하지 않았다.
     *
     * <xmp>
     * Sample Code:
     * public java.util.Vector selectAll() throws Exception
     * {
     *  java.util.Vector list = new Vector();
     *  Statement stmt = null;
     *  ResultSet rs =null;
     *  try{
     *      stmt = conn.createStatement();
     *      String query = "select " +
     *          "id, " +
     *          "name, " +
     *          "desc " +
     *          "from THE10 " +
     *          "order by id ";
     *
     *      rs = stmt.executeQuery(query);
     *
     *      while ( rs.next() ) {
     *          AdminAuth entity = new AdminAuth();
     *          entity.id = rs.getString("id");
     *          entity.name = rs.getString("name");
     *          entity.desc = rs.getString("desc");
     *          fixNull(entity);
     *          list.addElement(entity);
     *      }
     *  }
     *  finally {
     *      try{rs.close();}catch(Exception e){}
     *      try{stmt.close();}catch(Exception e){}
     *  }
     *  return list;
     * }
     *</xmp
     *
     * @param java.lang.Object Object내의 public java.lang.String 형의
     *        member variable에만 영향을 준다.
     *
     * @see fixNull(java.lang.Object)
     * @see fixNullAll(java.lang.Object)
     * @see fixNullAndTrimAll(java.lang.Object)
     * @see trim(String)
     * @author WonYoung Lee, wyounglee@lgeds.lg.co.kr
     */
    public static void fixNullAndTrim(Object o)
    {
        if ( o == null ) return;

        Class c = o.getClass();
        if ( c.isPrimitive() ) return;

        Field[] fields = c.getFields();
        for (int i=0 ; i<fields.length; i++) {
            try {
                Object f = fields[i].get(o);
                Class fc = fields[i].getType();
                if ( fc.getName().equals("java.lang.String") ) {
                    if ( f == null ) fields[i].set(o, "");
                    else {
                        String item = DataUtil.trim( (String)f );
                        fields[i].set(o, item);
                    }
                }
            }
            catch(Exception e){
            }
        }
    }

    /**
     * Entity Class의 재귀적인 null string field 초기화  &amp; trim().
     * <p>
     * fixNull() 과 유사한 기능을 하는데, java.lang.String field 뿐만 아니라
     * Member 변수 중 Array, Object 가 있으면 재귀적으로 쫒아 가서 String형을
     * blank string("")으로 만들어 준다.<br>
     * 정상적인 String인 경우 trim()을 시켜준다.<br>
     * 만약 Array나, Vector가 null일 경우 Instance화는 하지 않는다.
     *
     * <p>
     * 재귀적으로 추적되는 만큼, 부모와 자식간에 서로 양방향 reference를 갖고 있으면
     * 절대 안된다. Stack Overflow를 내며 JVM을 내릴 것이다.
     *
     *
     * @param java.lang.Object Object내의 public String 형뿐만 아니라, Object[], Vector 등과
     *        같은 public Object형 Member Variable에 영향을 준다.
     *
     * @see fixNull(java.lang.Object)
     * @see fixNullAll(java.lang.Object)
     * @see fixNullAndTrim(java.lang.Object)
     * @see trim(String)
     *
     * @author 김형기, 이원영
     */
    public static void fixNullAndTrimAll(Object o)
    {
        if ( o == null ) return;

        Class c = o.getClass();
        if ( c.isPrimitive() ) return;

        if( c.isArray() ) {
            int length = Array.getLength(o);
            for(int i=0; i<length ;i++){
                Object element = Array.get(o, i);
                fixNullAndTrimAll(element);
            }
        }
        else {
            Field[] fields = c.getFields();
            for (int i=0 ; i<fields.length; i++) {
                try {
                    Object f = fields[i].get(o);
                    Class fc = fields[i].getType();
                    if ( fc.isPrimitive() ) continue;
                    if ( fc.getName().equals("java.lang.String") ) {
                        if ( f == null ) fields[i].set(o, "");
                        else {
                            String item = DataUtil.trim( (String)f );
                            fields[i].set(o, item);
                        }
                    }
                    else if ( f != null ) {
                        fixNullAndTrimAll(f);
                    }
                    else {} // Some Object, but it's null.
                }
                catch(Exception e) {
                }
            }
        }
    }

    /**
     *
     * @param e java.lang.Throwable
     */
    public static String getStackTrace(Throwable e) {
        java.io.ByteArrayOutputStream bos = new java.io.ByteArrayOutputStream();
        java.io.PrintWriter writer = new java.io.PrintWriter(bos);
        e.printStackTrace(writer);
        writer.flush();
        return bos.toString();
    }

    /**
     * Remove special white space from both ends of this string.
     * <p>
     * All characters that have codes less than or equal to
     * <code>'&#92;u0020'</code> (the space character) are considered to be
     * white space.
     * <p>
     * java.lang.String의 trim()과 차이점은 일반적인 white space만 짜르는 것이
     * 아니라 위에서와 같은 특수한 blank도 짤라 준다.<br>
     * 이 소스는 IBM HOST와 데이타를 주고 받을 때 유용하게 사용했었다.
     * 일반적으로 많이 쓰이지는 않을 것이다.
     *
     * @param  java.lang.String
     * @return trimed string with white space removed
     *         from the front and end.
     * @author WonYoung Lee, wyounglee@lgeds.lg.co.kr
     */
     /** 중복되는 메서드이므로 주석처리 ** 상황에 맞춰서 아래의 소스와 밖구어 사용
    public static String trim(String s) {
        int st = 0;
        char[] val = s.toCharArray();
        int count = val.length;
        int len = count;

        while ((st < len) && ((val[st] <= ' ') || (val[st] == '　') ) )   st++;
        while ((st < len) && ((val[len - 1] <= ' ') || (val[len-1] == '　')))  len--;

        return ((st > 0) || (len < count)) ? s.substring(st, len) : s;
    }
    **/
    public static void changeNull(Object o, String st)
    {
        if ( o == null ) return;

        Class c = o.getClass();
        if ( c.isPrimitive() ) return;

        Field[] fields = c.getFields();
        for (int i=0 ; i<fields.length; i++) {
            try {
                Object f = fields[i].get(o);
                Class fc = fields[i].getType();

                if ( fc.getName().equals("java.lang.String") ) {
                    if ( f == null ) fields[i].set(o, st);
                    else    fields[i].set(o, f);
                }
            }
            catch(Exception e){
            }
        }
    }

    public static void changeNull(Object o)
    {
        changeNull(o, "&nbsp;");
    }

    public static void changeCharset(Object o, String cs1, String cs2)
    {
        if ( o == null ) return;

        Class c = o.getClass();
        if ( c.isPrimitive() ) return;

        Field[] fields = c.getFields();
        for (int i=0 ; i<fields.length; i++) {
            try {
                Object f = fields[i].get(o);
                Class fc = fields[i].getType();

                if ( fc.getName().equals("java.lang.String") ) {
                    if ( f != null )
                        fields[i].set(o, changeCharset((String)f, cs1, cs2));
                }
            }
            catch(Exception e){
            }
        }
    }

    public static String changeCharset( String st, String cs1, String cs2 )
    {
        String value = null;

        if (st == null ) return null;
        //if (st == null ) return "";

        value = new String(st);
        try {
            value = new String(new String(st.getBytes(cs1), cs2));
        }
        catch( UnsupportedEncodingException e ){
            value = new String(st);
        }
        return value;
    }

/**
 * YYYYMMDD 날짜형식을 구분자 g 로 나누어 반환한다.(예 putDateGubn('20001031','/') => 2000/10/31
 */
    public static String putDateGubn(String s, String g) {
    return (s.length() == 8) ? s.substring(0,4) + g + s.substring(4,6) + g + s.substring(6,8) : s;
    }

/**
 * 날짜형식을 구분자를 빼고 반환한다.(예 delDateGubn('2000/10/31') => 20001031
 */
    public static String delDateGubn(String s) {
    return (s.length() == 10) ? s.substring(0,4)  + s.substring(5,7) + s.substring(8,10) : s;
    }


    /******************************************DataUtil**********************************/
  /**
  * <pre>int num으로 넘어온 수를 DEFAULT_DECIMALSIZE=으로 반올림하는 메소드</pre>
  * @return banolim( num, DEFAULT_DECIMALSIZE )
  * @param num
  */
    public static int    banolim( int num    ){ return banolim( num, DEFAULT_DECIMALSIZE );    }
  /**
  * <pre>float num으로 넘어온 수를 DEFAULT_DECIMALSIZE=으로 반올림하는 메소드</pre>
  * @return banolim( num, DEFAULT_DECIMALSIZE )
  * @param num
  */
    public static float  banolim( float num  ){ return banolim( num, DEFAULT_DECIMALSIZE );    }
    /**
  * <pre>long num으로 넘어온 수를 DEFAULT_DECIMALSIZE=으로 반올림하는 메소드</pre>
  * @return banolim( num, DEFAULT_DECIMALSIZE )
  * @param num
  */
    public static long   banolim( long num   ){ return banolim( num, DEFAULT_DECIMALSIZE );    }
    /**
  * <pre>double num으로 넘어온 수를 DEFAULT_DECIMALSIZE=으로 반올림하는 메소드</pre>
  * @return banolim( num, DEFAULT_DECIMALSIZE )
  * @param num
  */
    public static double banolim( double num ){ return banolim( num, DEFAULT_DECIMALSIZE );    }
    /**
  * <pre>String num으로 넘어온 수를 DEFAULT_DECIMALSIZE=으로 반올림하는 메소드</pre>
  * @return banolim( num, DEFAULT_DECIMALSIZE )
  * @param num
  */
    public static String banolim( String num ){ return banolim( num, DEFAULT_DECIMALSIZE );    }
  /**
  * <pre>int num으로 넘어온 수를 int decimalsize으로 반올림하는 메소드</pre>
  * @return banolim( num, DEFAULT_DECIMALSIZE )
  * @param num
  */
    public static int    banolim( int num    , int decimalsize)
    {
        String _num = banolim( Integer.toString(num) , decimalsize );
        return Integer.parseInt(_num);
    }
    /**
  * <pre>String num으로 넘어온 수를 DEFAULT_DECIMALSIZE=으로 반올림하는 메소드</pre>
  * @return banolim( num, DEFAULT_DECIMALSIZE )
  * @param num
  */

    public static float  banolim( float num  , int decimalsize)
    {
        String _num = banolim( Float.toString(num) , decimalsize );
        return Float.parseFloat(_num);
    }
    public static long   banolim( long num   , int decimalsize)
    {
        String _num = banolim( Long.toString(num) , decimalsize );
        return Long.parseLong(_num);
    }
    public static double banolim( double num , int decimalsize)
    {
        String _num = banolim( doubleToString(num) , decimalsize );
        return Double.parseDouble(_num);
    }
    public static String banolim( String num , int decimalsize)
    {
        return roughCalculation( num , decimalsize , ROUND_HALF_UP );
    }

   /*
    *  올림 함수들
    *
    */
    public static int    olim( int num    ){ return olim( num, DEFAULT_DECIMALSIZE );    }
    public static float  olim( float num  ){ return olim( num, DEFAULT_DECIMALSIZE );    }
    public static long   olim( long num   ){ return olim( num, DEFAULT_DECIMALSIZE );    }
    public static double olim( double num ){ return olim( num, DEFAULT_DECIMALSIZE );    }
    public static String olim( String num ){ return olim( num, DEFAULT_DECIMALSIZE );    }

    public static int    olim( int num    , int decimalsize)
    {
        String _num = olim( Integer.toString(num) , decimalsize );
        return Integer.parseInt(_num);
    }
    public static float  olim( float num  , int decimalsize)
    {
        String _num = olim( Float.toString(num) , decimalsize );
        return Float.parseFloat(_num);
    }
    public static long   olim( long num   , int decimalsize)
    {
        String _num = olim( Long.toString(num) , decimalsize );
        return Long.parseLong(_num);
    }
    public static double olim( double num , int decimalsize)
    {
        String _num = olim( doubleToString(num) , decimalsize );
        return Double.parseDouble(_num);
    }
    public static String olim( String num , int decimalsize)
    {
        return roughCalculation( num , decimalsize , ROUND_UP );
    }

   /*
    *  내림 함수들
    *
    */
    public static int    nelim( int num    ){ return nelim( num, DEFAULT_DECIMALSIZE );    }
    public static float  nelim( float num  ){ return nelim( num, DEFAULT_DECIMALSIZE );    }
    public static long   nelim( long num   ){ return nelim( num, DEFAULT_DECIMALSIZE );    }
    public static double nelim( double num ){ return nelim( num, DEFAULT_DECIMALSIZE );    }
    public static String nelim( String num ){ return nelim( num, DEFAULT_DECIMALSIZE );    }

    public static int    nelim( int num    , int decimalsize )
    {
        String _num = nelim( Integer.toString(num) , decimalsize );
        return Integer.parseInt(_num);
    }
    public static float  nelim( float num  , int decimalsize )
    {
        String _num = nelim( Float.toString(num) , decimalsize );
        return Float.parseFloat(_num);
    }
    public static long   nelim( long num   , int decimalsize )
    {
        String _num = nelim( Long.toString(num) , decimalsize );
        return Long.parseLong(_num);
    }
    public static double nelim( double num , int decimalsize )
    {
        String _num = nelim( doubleToString(num) , decimalsize );
        return Double.parseDouble(_num);
    }
    public static String nelim( String num , int decimalsize)
    {
        return roughCalculation( num , decimalsize , ROUND_DOWN );
    }

// 근사값 계산 (반올림/올림/내림)
/*
*   ex) roughCalculation( "12345.678" , -3, ROUND_HALF_UP )  ==> 12000
*   ex) roughCalculation( "12345.678" , -2, ROUND_HALF_UP )  ==> 12300
*   ex) roughCalculation( "12345.678" , -1, ROUND_HALF_UP )  ==> 12350
*   ex) roughCalculation( "12345.678" ,  0, ROUND_HALF_UP )  ==> 12346
*   ex) roughCalculation( "12345.678" ,  1, ROUND_HALF_UP )  ==> 12345.7
*   ex) roughCalculation( "12345.678" ,  2, ROUND_HALF_UP )  ==> 12345.68
*
*   ex) roughCalculation( "12399.999" ,  2, ROUND_HALF_UP )  ==> 12400.00
*
*
*/
    private static String  roughCalculation( String num , int decimalsize, int round_mode )
    {

        int sign = 1 ;
        String resultNum ="";

        if( num.charAt(0) == '-' ){
            sign = -1 ;
            num = num.substring(1);
        }

        int pointIndex = num.indexOf(".");
        if ( pointIndex == 0 )  num = "0" + num ;                   // ex) .1234

        if ( pointIndex == -1 ){                                        // 소수점이 없는 정수일경우

            //if( decimalsize >= -1 ){
            if( decimalsize > -1 ){
                resultNum = num ;
            }else{

                //resultNum = num.substring( 0, num.length() + decimalsize + 1 );
                resultNum = num.substring( 0, num.length() + decimalsize );
                int su = Integer.parseInt( String.valueOf( num.charAt( num.length() + decimalsize )) );

                String fixNum = "";
                //for(int i=-1; i>decimalsize ; i--){
                for(int i=0; i>decimalsize ; i--){
                    fixNum += "0";
                }

                if(( round_mode == ROUND_HALF_UP &&  su >= 5 ) || ( round_mode == ROUND_UP )){

                    resultNum = roundUp( resultNum ).concat( fixNum );
                }else{

                    resultNum = resultNum.concat( fixNum );
                }
            }
        }else{                                                          // 소수점이 있는 실수일경우


            if( decimalsize == 0 ){

                resultNum = num.substring( 0, pointIndex );
                int su = Integer.parseInt( String.valueOf( num.charAt( pointIndex + 1 )) ); // 소수첫째자리값

                if(( round_mode == ROUND_HALF_UP &&  su >= 5 ) || ( round_mode == ROUND_UP )){
                    resultNum = roundUp( resultNum );
                }
            }else if( decimalsize <= -1 ){

                if( pointIndex + decimalsize > 0 ){
                    resultNum = num.substring( 0, pointIndex + decimalsize );
                    int su = Integer.parseInt( String.valueOf( num.charAt( pointIndex + decimalsize )) ); // 소수첫째자리값

                        String fixNum = "";
                        for(int i=0; i>decimalsize ; i--){
                            fixNum += "0";
                        }

                        if(( round_mode == ROUND_HALF_UP &&  su >= 5 ) || ( round_mode == ROUND_UP )){
                            resultNum = roundUp( resultNum ).concat( fixNum );
                        }else{
                            resultNum = resultNum.concat( fixNum );
                        }
                }else{
                    resultNum = "1" ;
                    //Logger.err.println("DataUtil : ","Invalid Parameter: 반올림 자리수가 부적절합니다.");

                }
            }else{
                if( num.length() > pointIndex + decimalsize + 1 ){
                    resultNum = num.substring( 0, pointIndex + decimalsize + 1 );

                    int su = Integer.parseInt( String.valueOf( num.charAt( pointIndex + decimalsize + 1 )) );

                    if(( round_mode == ROUND_HALF_UP &&  su >= 5 ) || ( round_mode == ROUND_UP )){
                        resultNum = roundUp( resultNum );
                    }
               }else{
                    resultNum = num ;
               }
            }
        }

        if( sign == -1 ){
            resultNum = "-" + resultNum ;
        }

        return resultNum ;
    }

    private static String roundUp(String num)               // 마지막 숫자를 1 더한다
    {

        if( num.length() == 1 ){
            if( num.equals("9") ){
                return "10";
            }else{
                return Integer.toString( Integer.parseInt(num) + 1 );
            }
        }else{
            String str = num.substring(0, num.length()-1);
            String lastChar = num.substring(num.length()-1);

            if ( lastChar.equals("9") ){
                return roundUp(str)+"0" ;
            }else if( lastChar.equals(".") ){
                return roundUp(str)+"." ;
            }else{
                int digit = Integer.parseInt( lastChar );
                return str + String.valueOf( digit + 1 );
            }
        }
    }
/******************************************************************************
*
*       날짜 관련 Util 함수들..
*
*******************************************************************************/
/**
 * <pre> 현재날짜(20020115)를 구하는 메소드</pre>
 */
//  public static String getCurrentDate() throws GeneralException
//  {
//       CurrentDateRFC func = new CurrentDateRFC();
//       String sysdate = func.getCurrent();
//       return removeStructur(sysdate,"-");
//  }
/*  public static String getCurrentDate() throws GeneralException
    {
         java.text.SimpleDateFormat formatter  = new java.text.SimpleDateFormat ("yyyyMMdd");
         return formatter.format( new java.util.Date());
    }
*/
/**
 * <pre> 현재년도(2002)를 구하는 메소드</pre>
 */
    public static String getCurrentYear()
    {
         java.text.SimpleDateFormat formatter  = new java.text.SimpleDateFormat ("yyyy");
         return formatter.format( new java.util.Date());
    }
/**
 * <pre> 현재 달(01)을 구하는 메소드</pre>
 */
    public static String getCurrentMonth()
    {
         java.text.SimpleDateFormat formatter  = new java.text.SimpleDateFormat ("MM");
         return formatter.format( new java.util.Date());

    }



/**
 * <pre> 현재 날짜의 요일을 구하는 메소드</pre>
 */
    public static int getCurrentDay()
    {
        java.util.Calendar c = java.util.Calendar.getInstance();
        int d= c.get(java.util.Calendar.DAY_OF_WEEK);

        return d;
    }

/**
  * <pre>currenday로 넘어온 String형 날짜로 그 날짜의 요일을 구하는 메소드</pre>
  * @return java.lang.Integer
  * @param CurrentDay
  */
    public static int getDay(String CurrentDay)
    {
        int yyyy, mm, dd;
        yyyy    =Integer.parseInt(CurrentDay.substring(0,4));
        mm      =Integer.parseInt(CurrentDay.substring(4,6));
        dd      =Integer.parseInt(CurrentDay.substring(6,8));

        java.util.Calendar c = java.util.Calendar.getInstance();


        c.set(yyyy,mm-1,dd);
        int d= c.get(java.util.Calendar.DAY_OF_WEEK);


        return d;
    }

/**
  * <pre>현재의 시간을 구하는 메소드</pre>
  * @return java.lang.String
  */
    public static String getCurrentTime()
    {
        java.sql.Timestamp wdate = new java.sql.Timestamp(System.currentTimeMillis());
        String sDate    =wdate.toString();
        String temp     =sDate.substring(11,13)+sDate.substring(14,16)+sDate.substring(17,19);
        return temp;
    }
/**
  * <pre>currenday로 넘어온 String형 날짜와 int형으로 넘어온 기간으로 몇일 후 인지를 계산하는 메소드</pre>
  * @return java.lang.Integer
  * @param CurrentDay
  * @param interval
  */
    public static String getAfterDate(String currentDay, int interval)
    {
        int yyyy, mm, dd;
        int year,month,day;
        yyyy    =Integer.parseInt(currentDay.substring(0,4));
        mm      =Integer.parseInt(currentDay.substring(4,6));
        dd      =Integer.parseInt(currentDay.substring(6,8));

        java.util.Calendar c =  java.util.Calendar.getInstance();
        c.set(yyyy,mm-1,dd);
        c.add(java.util.Calendar.DATE, interval);

        year        =   c.get(java.util.Calendar.YEAR);
        month    = c.get(java.util.Calendar.MONTH);
        day     = c.get(java.util.Calendar.DATE);

        return checkDate(year,month,day,1);
    }

 /**
  * <pre>currenday로 넘어온 String형 날짜와 int형으로 넘어온 기간으로 몇달 후 인지를 계산하는 메소드</pre>
  * @return java.lang.Integer
  * @param CurrentDay
  * @param interval
  */
       public static String getAfterMonth(String currentDay, int interval)
    {
        int yyyy, mm, dd;
        int year,month,day;
        yyyy    =Integer.parseInt(currentDay.substring(0,4));
        mm      =Integer.parseInt(currentDay.substring(4,6));
        dd      =Integer.parseInt(currentDay.substring(6,8));

        java.util.Calendar c =  java.util.Calendar.getInstance();
        c.set(yyyy,mm-1,dd);
        c.add(java.util.Calendar.MONTH, interval);

        year        = c.get(java.util.Calendar.YEAR);
        month  = c.get(java.util.Calendar.MONTH);
        day     = c.get(java.util.Calendar.DATE);

        return checkDate(year,month,day,0);
    }

   /**
  * <pre>currenday로 넘어온 String형 날짜와 int형으로 넘어온 기간으로 몇년 후 인지를 계산하는 메소드</pre>
  * @return java.lang.Integer
  * @param CurrentDay
  * @param interval
  */
    public static String getAfterYear(String currentDay, int interval)
    {
        int yyyy, mm, dd;
        int year,month,day;
        yyyy    =Integer.parseInt(currentDay.substring(0,4));
        mm      =Integer.parseInt(currentDay.substring(4,6));
        dd      =Integer.parseInt(currentDay.substring(6,8));

        java.util.Calendar c =  java.util.Calendar.getInstance();
        c.set(yyyy,mm-1,dd);
        c.add(java.util.Calendar.YEAR, interval);

        year        = c.get(java.util.Calendar.YEAR);
        month  = c.get(java.util.Calendar.MONTH);
        day      = c.get(java.util.Calendar.DATE);

        return checkDate(year,month,day,0);
    }

/**
  * <pre>currenday로 넘어온 String형 날짜와 intervalday로 넘어온 String형날짜로 두 날짜의 차이를 계산하는 메소드</pre>
  * @return java.lang.Integer
  * @param CurrentDay
  * @param interval
  */
    public static int getBetween(String currentDay, String intervalDay)
    {

        int yyyy, mm, dd;
        int yyyy2,mm2,dd2;

        yyyy    =Integer.parseInt(currentDay.substring(0,4));
        mm      =Integer.parseInt(currentDay.substring(4,6));
        dd      =Integer.parseInt(currentDay.substring(6,8));

        yyyy2   =Integer.parseInt(intervalDay.substring(0,4));
        mm2     =Integer.parseInt(intervalDay.substring(4,6));
        dd2     =Integer.parseInt(intervalDay.substring(6,8));

        long d1,d2;

        java.util.Calendar c1 = java.util.Calendar.getInstance();
        java.util.Calendar c2 = java.util.Calendar.getInstance();

        c1.set(yyyy,mm-1,dd);
        c2.set(yyyy2,mm2-1,dd2);

        d1 = c1.getTime().getTime();
        d2 = c2.getTime().getTime();

        int days =(int)((d2-d1)/(1000*60*60*24));
        return days;
    }
/**
  * <pre>currenday로 넘어온 String형 날짜와 intervalday로 넘어온 String형날짜로 두 날짜의 차이를 계산하는 메소드</pre>
  * @return java.lang.Integer
  * @param CurrentDay
  * @param interval
  */

    private static String checkDate(int yyyy, int mm, int dd, int flag)
    {
        int nMonth[] = {31,28,31,30,31,30,31,31,30,31,30,31};
        int yMonth[] = {31,29,31,30,31,30,31,31,30,31,30,31};

        String year,month,day;

        mm++;

        if( (yyyy % 4) == 0 && ((yyyy % 100 ) != 0 || (yyyy % 400) == 0) )
        {
            if(dd > yMonth[mm-1]) {
                if(flag == 0){
                    dd = yMonth[mm-1];
                } else {
                    mm++;
                    dd = 1;
                }
            }
        }
        else
        {
            if(dd > nMonth[mm-1]) {
                if(flag == 0){
                    dd = nMonth[mm-1];
                } else {
                    mm++;
                    dd = 1;
                }
            }
        }

        if( mm == 13 ){
            mm = 1;
            yyyy++;
        }

        year         = Integer.toString(yyyy);
        month  = Integer.toString(mm);
        day     = Integer.toString(dd);

        for(int i = year.length(); i < 4; i++) {
            year = "0" + year;
        }
        for(int i = month.length(); i < 2; i++) {
            month = "0" + month;
        }
        for(int i = day.length(); i < 2; i++) {
            day = "0" + day;
        }

        return (year+month+day);

    }

    public static String getLastDay(String year, String month , int flag)
    {
        int nMonth[] = {31,28,31,30,31,30,31,31,30,31,30,31};
        int yMonth[] = {31,29,31,30,31,30,31,31,30,31,30,31};

        int yyyy = Integer.parseInt(year);
        int mm = Integer.parseInt(month);
        int dd = 1;

        if( (yyyy % 4) == 0 && ((yyyy % 100 ) != 0 || (yyyy % 400) == 0) ){
            dd = yMonth[mm-1];
        } else {
            dd = nMonth[mm-1];
        }

        String day = Integer.toString(dd);

        for(int i = year.length(); i < 4; i++) {
            year = "0" + year;
        }
        for(int i = month.length(); i < 2; i++) {
            month = "0" + month;
        }
        for(int i = day.length(); i < 2; i++) {
            day = "0" + day;
        }

        if( flag == 1 ){
            return year+month+day;
        } else if( flag == 2 ){
            return month+day;
        } else if( flag == 3 ){
            return day;
        } else {
            return year+month+day;
        }
    }

    public static String getLastDay(String year, String month ){ //defult 날짜
        return getLastDay( year, month , 3);
    }

  /**
  * <pre>currentTime으로 넘어온 String(hh:mm)형 시간과 intervalTime으로 넘어온 String(hh:mm)형 시간으로 두 시간의 차이를 계산하는 메소드</pre>
  * @param currentTime
  * @param intervalTime
  */
  public static double getBetweenTime(String currentTime, String intervalTime)
  {
    int hh1 = 0, mm1 = 0;
    int hh2 = 0, mm2 = 0;
    double d_hh = 0, d_mm = 0, interval_time = 0;

    hh1 =Integer.parseInt(currentTime.substring(0,2));
    mm1 =Integer.parseInt(currentTime.substring(3,5));

    hh2 =Integer.parseInt(intervalTime.substring(0,2));
    mm2 =Integer.parseInt(intervalTime.substring(3,5));

    d_hh = hh2 - hh1;
    d_mm = mm2 - mm1;

    if( d_hh < 0 ){
        d_hh = 24 + d_hh;
    }
    if( d_mm >= 0 ){
        d_mm = d_mm / 60;
    } else {
        d_hh = d_hh - 1;
        d_mm = (60 + d_mm) /60;
    }
    interval_time = d_hh + d_mm;

    return interval_time;
  }

/******************************************************************************
*
*       String 관련 Util 함수들..
*
*******************************************************************************/
/**
  * <pre>s로 넘어온 String형 문자의 공백을 제거하는 메소드</pre>
  * @return java.lang.String
  * @param s
  */
    public static String trim(String s)
    {
        return s.trim();
    }
/**
  * <pre>s로 넘어온 String형 문자의 왼쪽공백을 제거하는 메소드</pre>
  * @return java.lang.String
  * @param s
  */

    public static String ltrim(String s)
    {
        for(int i = 0; i < s.length(); i++) {
            if( s.charAt(i) != ' ' ) {
                return s.substring(i, s.length());
            }
        }
        return s;
    }
/**
  * <pre>s로 넘어온 String형 문자의 오른쪽공백을 제거하는 메소드</pre>
  * @return java.lang.String
  * @param s
  */
    public static String rtrim(String s)
    {
        for(int i = 0 ; i<s.length(); i++){
           if(s.charAt(s.length()-i-1)!= ' '){
                return s.substring(0,s.length()-i);
           }
        }
        return s;
    }
/**
  * <pre>String(a/b/g)를 String(abc)로변환하는  메소드</pre>
  * @return removeStructur(s,DEFULT_STRUCTUR)
  * @param s
  */
    public static String removeStructur(String s)
    {
        return removeStructur(s,DEFULT_STRUCTUR);
    }

/**
  * <pre>String(a,b,g)를 String(abc)로변환하는  메소드</pre>
  * @return removeStructur(s, DEFULT_COMMA)
  * @param s
  */
    public static String removeComma(String s)
    {
        return removeStructur(s, DEFULT_COMMA);
    }
/**
  * <pre>String(a,b,g)를 String(abc)로변환하는  메소드</pre>
  * @return removeStructur(s, DEFULT_COMMA)
  * @param s
  */
    public static String removeStructur(String s, String c)
    {
        StringBuffer sb = new StringBuffer();
        int i = 0;

        while (i<s.length()-c.length()){
            if(!(s.substring(i,i+c.length()).equals(c))){
                sb.append(String.valueOf(s.charAt(i)));
                i++;
            }else{
                i=i+c.length();
            }
        }
        sb.append(s.substring(i, s.length()));
        return sb.toString();
    }

    public static String removeStructur(String s, String from, String to)
    {
        StringBuffer sb = new StringBuffer();
        int i = 0;

        while (i<s.length()-from.length()){
            if(!(s.substring(i,i+from.length()).equals(from))){
                sb.append(String.valueOf(s.charAt(i)));
                i++;
            }else{
                sb.append(to);
                i=i+from.length();
            }
        }
        sb.append(s.substring(i, s.length()));
        return sb.toString();
    }

/**
  * <pre>String(s)의 뒤에 int(leng)의 갯수만큼스페이스를 넣어주는  메소드</pre>
  * @ return fill(s, leng, " ")
  * @param s
  * @param leng
  */
    public static String fillSpace(String s, int leng)
    {
        return fill(s, leng, " ");
    }
/**
  * <pre>String(s)의 뒤에 int(leng)의 갯수만큼 0을 넣어주는  메소드</pre>
  * @ return fill(s, leng, "0")
  * @param s
  * @param leng
  */
    public static String fixZero(String s, int leng)
    {
        return fill(s, leng, "0");
    }
/**
  * <pre>String(s)의 뒤에 int(leng)의 갯수만큼 String(c)를 넣어주는  메소드</pre>
  * @  return st.toString()
  * @param s
  * @param leng
  * @param c
  */
    public static String fill(String s, int leng, String c)
    {
        StringBuffer st = new StringBuffer();
        st.append(s);
        for (int i=s.length() ; i<leng ; i++ ){
            st.append(c);
        }
        return st.toString();
    }
/**
  * <pre>String(s)의 앞에 int(leng)의 갯수만큼 스페이스를 넣어주는  메소드</pre>
  * @ return fillEnd(s, leng, " ")
  * @param s
  * @param leng
  * @param c
  */
    public static String fillEndSpace(String s, int leng)
    {
        return fillEnd(s, leng, " ");

    }
/**
  * <pre>String(s)의 앞에 int(leng)의 갯수만큼 0을 넣어주는  메소드</pre>
  * @ return fillEnd(s, leng, "0")
  * @param s
  * @param leng
  * @param c
  */
    public static String fixEndZero(String s, int leng)
    {
        return fillEnd(s, leng, "0");

    }
/**
  * <pre>String(s)의 앞에 int(leng)의 갯수만큼 String(c)를 넣어주는  메소드</pre>
  * @  return st.toString()
  * @param s
  * @param leng
  * @param c
  */
    public static String fillEnd(String s, int leng, String c)
    {
        StringBuffer st = new StringBuffer();
        for (int i=s.length() ; i<leng ; i++ ) {
            st.append(c);
        }
        st.append(s);
        return st.toString();
    }
/******************************************************************************
*
*       [추가] String 관련 Util 함수들.. by kim.sung.il
*           한글과 영문의 String을 Byte 수를 고려하여 잘라낸다..
*******************************************************************************/

    public static String frontCut(String str, int limit)
    {
        if (str == null || limit < 4) return str;

        int len = str.length();
        int cnt=0, index=len-1;
        while ( cnt < limit )
        {
            if (str.charAt(index--) < 256) // 1바이트 문자라면...
                cnt++;     // 길이 1 증가
            else {// 2바이트 문자라면...
                cnt += 2;  // 길이 2 증가
                if(cnt > limit){
                    LLog.info.println("1234567890-=");
                    index++;
                }
            }
        }

        if (index < len)
            str = str.substring(index+1);

        return str;
    }

    public static String endCut(String str, int limit)
    {
        if (str == null || limit < 4) return str;

        int len = str.length();
        int cnt=0, index=0;

        while (index < len && cnt < limit)
        {
            if (str.charAt(index++) < 256) // 1바이트 문자라면...
                cnt++;     // 길이 1 증가
            else {// 2바이트 문자라면...
                cnt += 2;  // 길이 2 증가
                if(cnt > limit){
                    LLog.info.println("1234567890-=");
                    index--;
                }
            }
       }

        if (index < len)
            str = str.substring(0, index);

        return str;
    }
    /*************************CharConversion*********************************/

    /**
     * 8859_1 --> KSC5601.
     * @return KSC5601
     * @param english : 8859_1
     */
    public static String E2K( String english )
    {
        String korean = null;

        if (english == null ) return null;

        try {
            korean = new String(new String(english.getBytes("8859_1"), "KSC5601"));
        }
        catch( UnsupportedEncodingException e ){
            korean = new String(english);
        }
        return korean;
    }

    /**
     * KSC5601 --> 8859_1.
     * @return 8859_1
     * @param korean : KSC5601
     */
    public static String K2E( String korean )
    {
        String english = null;

        if (korean == null ) return null;

        english = new String(korean);
        try {
            english = new String(new String(korean.getBytes("KSC5601"), "8859_1"));
        }
        catch( UnsupportedEncodingException e ){
            english = new String(korean);
        }
        return english;
    }

//////////////////////////////////////주민등록////////////////////////
 public static boolean isAvailable( double registry ){
        String registry1 = Double.toString( registry );
        LLog.info.println("regi"+registry1);
        return DataUtil.isAvailable( Double.toString( registry ) );

    }

    public static boolean isAvailable( String registry ){   // 하이푼(-)이 없는 registry만 들어온다 ex) "7701011844611"
        try{
            //자리수 체크
            String yyyy="";

            if( registry==null || registry.length() != 13 ) return false;

            int y  = Integer.parseInt( registry.substring(0,1) );
            int yy = Integer.parseInt( registry.substring(1,2) );
            int m  = Integer.parseInt( registry.substring(2,3) );
            int mm = Integer.parseInt( registry.substring(3,4) );
            int d  = Integer.parseInt( registry.substring(4,5) );
            int dd = Integer.parseInt( registry.substring(5,6) );

            int r1 = Integer.parseInt( registry.substring(6,7) );
            int r2 = Integer.parseInt( registry.substring(7,8) );
            int r3 = Integer.parseInt( registry.substring(8,9) );
            int r4 = Integer.parseInt( registry.substring(9,10) );
            int r5 = Integer.parseInt( registry.substring(10,11) );
            int r6 = Integer.parseInt( registry.substring(11,12) );
            int r7 = Integer.parseInt( registry.substring(12,13) );


            int sum = (y * 2)+(yy * 3)+(m * 4)+(mm * 5)+(d * 6)+(dd * 7)+(r1 * 8)+(r2 * 9)+(r3 * 2)+(r4 * 3)+(r5 * 4)+(r6 * 5);
            int check =  ( 11 - ( sum % 11 ) ) % 10 ;

           if( r7 != check ) return false;

            if( r1 == 1 || r1 == 2 ) {
                yyyy = "19"+ registry.substring(0, 6) ;

            }else if( r1 == 3 || r1 == 4 ) {
                yyyy = "20"+ registry.substring(0, 6) ;
            }else{
                return false;
            }

            //DataUtil.checkDate() 요걸 써야하나?
            return DataUtil.isDate(yyyy);

            }catch(Exception e){
            return false;
        }
    }

    public static boolean isDate( String date ){

        if( date==null || !(date.length() == 8 || date.length() == 10) ) return false;

        if( date.length() == 10 ){
            date = date.substring(0,4) + date.substring(5,7) + date.substring(8,10);
        }

        for( int i = 0; i < date.length(); i++){
            if( !('0' <= date.charAt(i) && date.charAt(i) <= '9') ) return false;
        }

        return DataUtil.isDate( Integer.parseInt(date.substring(0,4)), Integer.parseInt(date.substring(4,6)),Integer.parseInt(date.substring(6,8)) );

    }


     private static boolean isDate( int yyyy, int mm, int dd ){

        int nMonth[] = {31,28,31,30,31,30,31,31,30,31,30,31};
        int yMonth[] = {31,29,31,30,31,30,31,31,30,31,30,31};

        if( mm <= 0 || mm > 12 ) return false;

        if( (yyyy % 4) == 0 && ((yyyy % 100 ) != 0 || (yyyy % 400) == 0) ) { // 윤달일때
            if(dd > yMonth[mm-1]) return false;
        } else {
            if(dd > nMonth[mm-1]) return false;
        }

        return true;
    }

 	public static boolean isMonth( String date ){
 		
		if( date==null || date.length() != 6 ) return false;
	
	    for( int i = 0; i < date.length(); i++){
	        if( !('0' <= date.charAt(i) && date.charAt(i) <= '9') ) return false;
	    }
	
	    int _month = Integer.parseInt(date.substring(4,6));
        if( _month <= 0 || _month > 12 ) return false;

        return true;
	
	}
 	
    // 남녀 체크
    public static boolean isMan( double registry ){
        return DataUtil.isMan( Double.toString( registry ) );
    }
    public static boolean isMan( String registry ){

        if(registry.substring(6, 7).equals("1") || registry.substring(6,7).equals("3")){
            return true;
        }else{
            return false;
            }

    }

    // 생일 가져오기
    public static String getBirthday( double registry ){
        return DataUtil.getBirthday( Double.toString( registry ) );
    }
    public static String getBirthday( String registry ){

        String birthday    = registry.substring(0, 6);

        char reg = registry.charAt(6);

        if( reg == '-' ) {
            reg = registry.charAt(7);
        }

        if( reg == '1' || reg == '2'){
            birthday = "19" + birthday;
        } else {
            birthday = "20" + birthday;
        }

        return birthday;
    }

    // 하이푼(-) 넣코 빼기
    public static String addSeparate( double registry ){
        return DataUtil.addSeparate( Double.toString( registry ) );
    }

    //주민번호
    public static String addSeparate( String registry ){
        if(registry==null || registry.length() != 13){
            return registry;
        }
        return ( registry.substring(0, 6)+"-"+registry.substring(6) );
    }

    //날짜포맷
    public static String addSeparateDate( String src ){
        if(src==null || src.length() != 8){
            return src;
        }
        return ( src.substring(0,4)+"-"+src.substring(4,6)+"-"+src.substring(6,8));
    }

    public static String removeSeparate( String registry ){
        return ( registry.substring(0, 6)+registry.substring(7) );
    }

// 반올림,내림,올림 등의 함수에서 내부적으로 호출한다
// 1.5E7  ==> 15000000
    private static String doubleToString(double num){
        java.text.DecimalFormat df = new java.text.DecimalFormat("####.####");
        return df.format(num).toString();
    }

    /**
     * Null 대체 ex) nvl(str,"&nbsp;");
     */
    public static String nvl(String str, String nvlStr) {
        if (str == null || str.equals("") || str.equals("null"))
            return nvlStr;
        else
            return str;
    }

    /*
    파일 읽기
    <p>
    사용법
    <p>
    가능      readFile("c:\\","autoexec.bat")
    <p>
    가능      readFile("c:\\osdk\\sam001\\htdocs\\","Ws_ftp.log")
    <p>
    불가능    readFile("\\","Ws_ftp.log")
    <p>
    불가능    readFile("/","Ws_ftp.log")
    <p>
    한 라인씩읽어 \n붙이기
     Query문 읽기
    */
    public String readFile(String path,String fileName)

    {
        String path_file =  "";

        if ( path.endsWith( System.getProperty("file.separator") ))

            path_file = path+fileName;
        else
            path_file = path+System.getProperty("file.separator")+fileName;

        StringBuffer ta= new StringBuffer();

        try
        {
            FileReader fr = new FileReader(path_file);

            BufferedReader br = new BufferedReader(fr);

            String line;

            while ((line = br.readLine()) != null)

            {
                ta.append(line+"\n");//nt에서 ftp.bat의 line마다 command를 실행할때 문제 발생
                //ta.append(line);//win98의 sql문은 안됨
            }
        }
        catch (IOException e)
        {
            ta.append("Problems reading file"+e.getMessage());
        }
        return String.valueOf(ta).toString();
    }



    public String replace2(String src, String old, String replacement) {
       int i = src.indexOf(old);
       StringBuffer r = new StringBuffer();
       if (i == -1) return src;
       r.append(src.substring(0,i) + replacement);
       if (i + old.length() < src.length())
         r.append(replace(src.substring(i + old.length(), src.length()), old, replacement));
       return r.toString();
    }

    /**
     * 문자열 내의 특정한 문자열을 모두 지정한 다른 문자열로 바꾼다.
     * 원본 String 이 null 일 경우에는 null 을 반환한다.
     * StringBuffer 를 이용하였으므로 이전의 String 을 이용한 것 보다
     * 월등히 속도가 빠르다. (약 50 ~ 60 배)
     *
     * 사용 예: <BR>
     *
     *   1. 게시판에서 HTML 태그가 안 먹히게 할려면
     *
     *      String str = "<TD>HTML Tag Free Test</TD>";
     *      str = replace(str, "&", "&amp;");
     *      str = replace(str, "<", "&lt;");
     *
     *   2. ' 가 포한된 글을 DB 에 넣을려면
     *
     *      String str2 = "I don't know.";
     *      str2 = replace(str2, "'", "''");
     *
     * @param   String src       원본 String
     * @param   String oldstr    원본 String 내의 바꾸기 전 문자열
     * @param   String newstr    바꾼 후 문자열
     * @return  String           치환이 끝난 문자열
     *
     * @date    2003/07/25
     * @author  kwon
     */
    public static String replace(String src, String oldstr, String newstr) {

        if (src == null)
            return null;

        StringBuffer dest = new StringBuffer("");
        int len = oldstr.length();
        int srclen = src.length();
        int pos = 0;
        int oldpos = 0;

        while ((pos = src.indexOf(oldstr, oldpos)) >= 0) {
            dest.append(src.substring(oldpos, pos));
            dest.append(newstr);
            oldpos = pos + len;
        }

        if (oldpos < srclen)
            dest.append(src.substring(oldpos, srclen));

        return dest.toString();
    } 

}