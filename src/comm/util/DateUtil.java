/**========================================================
 *@ProcessChain : ��� Ŭ������
 *@FileName : DateUtil.java ���ϸ�
 *@FileTitle : Ŭ������ ���� �ѱ۸�Ī
 *Open Issues : 
 *
 *Change History
 *    2009. 8. 30    ����ö    1.0    ���ʻ� 
 =========================================================*/
package comm.util;

//Java API
import java.util.Calendar;
import java.text.SimpleDateFormat;


/**
 * ����ý���(ZZ) : Utility ���
 * <BR>
 * <BR>
 * �?��wα׷����� ����ϴ� ���� ��¥�� ��n�4� Utility Ŭ����
 * <BR>
 * <p>Copyright(c) 2006 by MOGAHA(The Ministry of Government Administration and Home Affairs).
 *    All Rights reserved. </p>
 * @version 
 * @author ����ö
 */
public class DateUtil{
    ///////////////////////////////////////////////////////////////////////////
    //Data Member
    ///////////////////////////////////////////////////////////////////////////
    /** �⵵ */
    private  String year;    
    /** �� */
    private  String month;     
    /** �� */
    private  String day;    
    /** �ð� */
    private  String timeHH;   
    /** �� */
    private  String timeMI;
    /** �4� ��¥ - yyyyMMdd */
    private String today;
    /** ���� �� - yyyyMMddHHmm */
    private String currentDate;
    ///////////////////////////////////////////////////////////////////////////
    //Constructor
    ///////////////////////////////////////////////////////////////////////////
    /** DateUtil �⺻ ���� */
    public DateUtil(){

        Calendar cal = Calendar.getInstance();
        currentDate = new SimpleDateFormat("yyyyMMddHHmm").format(cal.getTime());

        try {
            this.year	= currentDate.substring(0,4);
            this.month	= currentDate.substring(4,6);
            this.day	= currentDate.substring(6,8);
            this.timeHH	= currentDate.substring(8,10);
            this.timeMI	= currentDate.substring(10);
            this.today 	= this.year + this.month + this.day;
        } catch(Exception e) {
        }
    }
    ///////////////////////////////////////////////////////////////////////////
    //Function Method
    ///////////////////////////////////////////////////////////////////////////
    /**
     * yyyy������ �⵵�� Return�ϴ� �޼ҵ�
     * @return yyyy������ �⵵ 
     */
    public  String getYear(){
        return year;
    }
    /**
     * MM ������ ��; Return�ϴ� �޼ҵ�
     * @return MM ������ ��
     */
    public  String getMonth(){
        return month;
    }
    /**
     * dd ������ �ϸ� Return�ϴ� �޼ҵ�
     * @return dd ������ ��
     */
    public  String getDay(){
        return day;
    }
    /**
     * HH������ �ð�; Return�ϴ� �޼ҵ�
     * @return HH������ �ð�
     */
    public  String getTimeHH(){
        return timeHH;
    }
    /**
     * mm������ ��; Return�ϴ� �޼ҵ�
     * @return mm������ ��
     */
    public  String getTimeMI(){
        return timeMI;
    }
    /**
     * yyyyMMddHHmm ������ ��¥�� Return�ϴ� �޼ҵ�
     * @return yyyyMMddHHmm ������ ��¥
     */
    public String getCurrentDate() {
        return this.currentDate;
    }
    /**
     * yyyyMMdd������ �4� ��¥�� Return�ϴ� �޼ҵ� 
     * @return yyyyMMdd������ �4� ��¥
     */
    public String getToday() {
        return this.today;
    }
	/******************************************************
    /*  설명        :   DB의 Date Format이 일정하지 않은 경우가 있으므로 예를 들어 1993, 199903, 19990305
 	/* 					즉 년도와 달만 나온 경우, 그리고 년도와 달 , 날짜가 함께 나온 경우의 쿼리 문의 어려움을
 	/*					해결하기 위한 메소드					                       
    /*  INPUT   	:   String, "-" "/" "."
    /*  OUTPUT  	:   제대로 된 Format의 Date String 
    /**********************************************************/
    public static String convertRightDateForm(String strDate, String bar){

    	String strResult = "";
    	strDate = strDate.trim();
    	
        if ( strDate.length() == 4 ){
        	strResult += strDate;
        }
        else if ( strDate.length() == 6 ){
        	strResult += strDate.substring(0, 4);
        	strResult += bar;
        	strResult += strDate.substring(4, 6);
        }
        else if ( strDate.length() == 8 ){
        	strResult += strDate.substring(0, 4);
        	strResult += bar;
        	strResult += strDate.substring(4, 6);
        	strResult += bar;
        	strResult += strDate.substring(6, 8);
        }

        return strResult;
    }
}//End of DateUtil.java
