package comm.util;

/******************************************************************************
 *
 *    Program iD   : Util
 *
 *    Description  : ��~ Utility
 *
 *    TABLE ���  :
 *
 *    Entry Points :
 *
 *******************************************************************************
 *                                MODiFiCATiON LOG
 *
 *       DATE        AUTHORS         DESCRiPTiON
 *    ----------    ---------    ----------------------------------------------
 *    2007/10/04    �ں���          Initial Release
 *    2008/11/26	�̴��          String �� ���ĺ� �˻� �߰�
 *
 ********************************************************************************/

import java.awt.List;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;
import java.util.Properties;
import java.util.StringTokenizer;
import java.util.TimeZone;

import devon.core.log.LLog;

public class Util {

	//public static final String classPath = "/data1/bea103/domains/hcidomain/applications/hci/web/WEB-INF/"; // Production
	//public static final String classPath = "/data2/bea103/domains/hcidomain/applications/hci/web/WEB-INF/"; // Development
	public static final String classPath = "C:/DevOnStudio/workspace/hci/web/WEB-INF/"; // Local

	// ����� d�� �� passwd�� ��ȣȭ �ϱ� '�� parsing��.
	public static final String Ref = "`1234567890-=~!@#$%^&*()_+qwertyuiop[]QWERTYUIOP{}|asdfghjkl;ASDFGHJKL:zxcvbnm,./ZXCVBNM<>?";

	// ���ڸ޽���� Account ID
	public static final String DEPT_ID = "115601001000"; // ��ȭa

	public static final String MART_ID = "115601001002"; // �ž���

	// ���ڸ޽��� ȸ�ſ� TEL_NO
	public static final String DEPT_TEL = "0807275252"; // ��ȭa

	public static final String MART_TEL = "027286402"; // �ž���

	// ǥ������Ʈ
	public static final double POINT_RATE = 0.05;

	public static final int FILL_LEFT = 2;

	public static final int FILL_RIGHT = 1;

	// �6�ŬDB�� CHARSET; �˷��ִ� ����
	// 1: US7ASCII , 0 : �Ϲ�����ȯ��(KOR)
	// OutE(),InE() �Լ�� ����Ѵ�.
	public static final int DB_CHARSET = 1;

	/* OZ_REPORT��� ���� */
	// public static final String CONNECTION_SERVER = "165.244.237.213";
	// //ERP���߼����
	// public static final String CONNECTION_PORT = "9001"; //ERP���߼����
	// public static final String P_PATH_DETAIL =
	// "/usr/WebSphere/AppServer/installedApps/lgctstHRNetwork/capApp.ear/capApp.war/reports/";
	// //ERP���߼����
	// public static final String CODEBASE =
	// "http://165.244.237.213/ozviewer/ZTransferX.cab#version=1,0,1,7";
	// public static final String DOWNLOAD_SERVER =
	// "http://165.244.237.213/ozviewer/";
	// public static final String DOWNLOAD_PORT = "8084";
	// public static final String CSM_REPORTS = "ldms_reports/";
	// //ERP���߼����(xml���丮)
	public static final String CONNECTION_SERVER = "000.000.000.00"; // ERP������

	public static final String CONNECTION_PORT = "9002"; // ERP������

	public static final String P_PATH_DETAIL = "/appl/ldmsserver/capApp.ear/capApp.war/reports/"; // ERP������

	public static final String CODEBASE = "https://dev.dtdin.lgicorp.co.kr/jsp/oz30viewer/ztransferx.cab#version=1,0,2,2";

	public static final String DOWNLOAD_SERVER = "https://dev.ldms.lgicorp.co.kr/ozviewer/";

	public static final String DOWNLOAD_PORT = "";

	public static final String CSM_REPORTS = "ldms_reports/"; // ERP������(xml���丮)

	public Util() {
		super();
	}

	public String addDate(int offset) {
		// �Է¹�: ��¥�� ����8�� ��,�� �̵�
		int yyyy = 0, mm = 0, dd = 0;
		int ryyyy = 0, rmm = 0, rdd = 0;

		try {
			StringBuffer buf = new StringBuffer();
			java.util.Calendar endx_date = new GregorianCalendar();

			endx_date.add(endx_date.DATE, offset);

			ryyyy = endx_date.get(Calendar.YEAR);
			rmm = endx_date.get(Calendar.MONTH) + 1;
			rdd = endx_date.get(Calendar.DATE);

			buf.append(ryyyy);

			if (rmm <= 9) {
				buf.append('0');
			}

			buf.append(rmm);

			if (rdd <= 9) {
				buf.append('0');
			}

			buf.append(rdd);

			return buf.toString();

		} catch (Exception e) {
			e.printStackTrace(System.err);
			return null;
		}
	}

	/**
	 * int flag 1:���̵�,2:���̵� int offset :�̵���(��)��
	 */
	public String addDate(String date, int flag, int offset) {
		// �Է¹�: ��¥�� ����8�� ��,�� �̵�
		int yyyy = 0, mm = 0, dd = 1;
		int ryyyy = 0, rmm = 0, rdd = 0;
		try {
			StringBuffer buf = new StringBuffer();
			if (flag == 1 && date.length() != 6)
				return "";
			if (flag == 2 && date.length() != 8)
				return "";

			yyyy = Integer.parseInt(date.substring(0, 4));
			mm = Integer.parseInt(date.substring(4, 6)) - 1;

			if (flag != 1)
				dd = Integer.parseInt(date.substring(6, 8));

			java.util.Calendar endx_date = new GregorianCalendar(yyyy, mm, dd);
			// Date trialTime = new Date();
			// endx_date.setTime(trialTime);
			if (flag == 1) {
				endx_date.add(endx_date.MONTH, offset);
			} else {
				if (flag == 2) {
					endx_date.add(endx_date.DATE, offset);
				}
			}

			ryyyy = endx_date.get(Calendar.YEAR);
			rmm = endx_date.get(Calendar.MONTH) + 1;
			rdd = endx_date.get(Calendar.DATE);

			buf.append(ryyyy);

			if (rmm <= 9) {
				buf.append('0');
			}

			buf.append(rmm);

			if (flag == 2) {
				if (rdd <= 9)
					buf.append('0');
				buf.append(rdd);
			}

			return buf.toString();
		} catch (Exception e) {
			e.printStackTrace(System.err);
			return null;
		}

	}

	/**
	 * return add month to date strings
	 * 
	 * @param String
	 *            date string
	 * @param int
	 *            ���� ���
	 * @return int ��¥ ����� �°�, x���ϴ� ��¥�� �� ��� ���ϱ� ����� �߸� �Ǿ�ų�
	 *         x������ �ʴ� ��¥: java.text.ParseException �߻�
	 */
	public static String addMonths(String s, int month) throws Exception {
		return addMonths(s, month, "yyyyMMdd");
	}

	/**
	 * return add month to date strings with user defined format.
	 * 
	 * @param String
	 *            date string
	 * @param int
	 *            ���� ���
	 * @param format
	 *            string representation of the date format. For example,
	 *            "yyyy-MM-dd".
	 * @return int ��¥ ����� �°�, x���ϴ� ��¥�� �� ��� ���ϱ� ����� �߸� �Ǿ�ų�
	 *         x������ �ʴ� ��¥: java.text.ParseException �߻�
	 */

	public static String addMonths(String s, int addMonth, String format) throws Exception {
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(format, java.util.Locale.KOREA);
		java.util.Date date = check(s, format);

		java.text.SimpleDateFormat yearFormat = new java.text.SimpleDateFormat("yyyy", java.util.Locale.KOREA);

		java.text.SimpleDateFormat monthFormat = new java.text.SimpleDateFormat("MM", java.util.Locale.KOREA);

		java.text.SimpleDateFormat dayFormat = new java.text.SimpleDateFormat("dd", java.util.Locale.KOREA);

		int year = Integer.parseInt(yearFormat.format(date));
		int month = Integer.parseInt(monthFormat.format(date));
		int day = Integer.parseInt(dayFormat.format(date));

		month += addMonth;
		if (addMonth > 0) {
			while (month > 12) {
				month -= 12;
				year += 1;
			}

		} else {

			while (month <= 0) {
				month += 12;
				year -= 1;
			}

		}

		java.text.DecimalFormat fourDf = new java.text.DecimalFormat("0000");
		java.text.DecimalFormat twoDf = new java.text.DecimalFormat("00");
		String tempDate = String.valueOf(fourDf.format(year)) + String.valueOf(twoDf.format(month)) + String.valueOf(twoDf.format(day));

		java.util.Date targetDate = null;
		try {
			targetDate = check(tempDate, "yyyyMMdd");
		} catch (java.text.ParseException pe) {
			day = lastDay(year, month);
			tempDate = String.valueOf(fourDf.format(year)) + String.valueOf(twoDf.format(month)) + String.valueOf(twoDf.format(day));
			targetDate = check(tempDate, "yyyyMMdd");

		}

		return formatter.format(targetDate);

	}

	// �־��� ���̸�ŭ�� �־��� char �ٿ��� ����
	public String appendChar(String pString, char pChar, String offset, int len) {
		String retValue = "";
		char[] chr = new char[len];
		for (int i = 0; i < chr.length; i++) {
			chr[i] = pChar;
		}
		String strValue = new String(chr);

		if (offset.equals("H")) {
			retValue = strValue + pString;
		} else if (offset.equals("T")) {
			retValue = pString + strValue;
		}

		return retValue;
	}

	public String appendCharHead(String pString, char pChar, int len) {
		return appendChar(pString, pChar, "H", len);
	}

	public String appendCharTail(String pString, char pChar, int len) {
		return appendChar(pString, pChar, "T", len);
	}

	public static java.util.Date check(String s) throws java.text.ParseException {

		return check(s, "yyyyMMdd");
	}

	/**
	 * check date string validation with an user defined format.
	 * 
	 * @param s
	 *            date string you want to check.
	 * @param format
	 *            string representation of the date format. For example,
	 *            "yyyy-MM-dd".
	 * @return date java.util.Date
	 */

	public static java.util.Date check(String s, String format) throws java.text.ParseException {
		if (s == null)
			throw new java.text.ParseException("date string to check is null", 0);
		if (format == null)
			throw new java.text.ParseException("format string to check date is null", 0);
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(format, java.util.Locale.KOREA);
		java.util.Date date = null;
		try {
			date = formatter.parse(s);
		} catch (java.text.ParseException e) {
			/*
			 * throw new java.text.ParseException( e.getMessage() + " with
			 * format \"" + format + "\"", e.getErrorOffset() );
			 */
			throw new java.text.ParseException(" wrong date:\"" + s + "\" with format \"" + format + "\"", 0);
		}

		if (!formatter.format(date).equals(s))
			throw new java.text.ParseException("Out of bound date:\"" + s + "\" with format \"" + format + "\"", 0

			);

		return date;

	}

	public static String checkStrByte(String str, int size, byte byteChar, int direction) {
		String result = null;
		if (str == null)
			str = " ";

		byte[] bstr = str.getBytes();
		// if( bstr.length <= len ) return str;

		if (bstr.length < size) {
			byte[] temp = new byte[size - bstr.length];
			for (int i = 0; i < size - bstr.length; i++) {
				temp[i] = byteChar;
			}

			if (direction == 1)
				result = new String(bstr) + new String(temp);
			else
				result = new String(temp) + new String(bstr);

		} else {
			result = getSubstrStr(str, 0, size);
		}
		return result;
	}

	public static String checkStrByte(String str, int size, int direction) {
		String result = null;
		if (str == null)
			str = " ";

		byte[] bstr = str.getBytes();
		// if( bstr.length <= len ) return str;

		if (bstr.length < size) {
			byte[] temp = new byte[size - bstr.length];
			for (int i = 0; i < size - bstr.length; i++) {
				temp[i] = 32;
			}

			if (direction == 1)
				result = new String(bstr) + new String(temp);
			else
				result = new String(temp) + new String(bstr);

		} else {
			result = getSubstrStr(str, 0, size);
		}
		return result;
	}

	/**
	 * DESC : �ش����� ���� ��¥ ��n�1�
	 */
	public String checkString(String str) {
		if ((str.equals(null)) || (str.equals(""))) {
			return "";
		} else {
			str = str.trim();
			return str;
		}
	}

	public int convertInt(String str) {
		int retValue = 0;
		if (str.trim().equals(""))
			retValue = 0;
		else
			retValue = Integer.parseInt(str);

		return retValue;
	}

	// =��; ���8�� ��ȯ
	// �Ķ���� day�� ��¥ 8�ڸ� ��) "20001022"
	// yunweol�� 1�� ���� "0"�̸� ���, "1"�̸� 1�� (1�� �ڵ�8�� ���ϴ� ��: ��°�
	// ���4ϴ�. 1���� ��� =���� ��¥�� ���8�δ� 2���� ���1� �����Դϴ�.)
	public String conveSolar(String day, String yunweol) {
		String lunar[] = { "1212122322121", "1212121221220", "1121121222120", "2112132122122", "2112112121220", "2121211212120", "2212321121212", "2122121121210", "2122121212120", "1232122121212", "1212121221220", "1121123221222", "1121121212220", "1212112121220", "2121231212121", "2221211212120", "1221212121210", "2123221212121", "2121212212120", "1211212232212", "1211212122210", "2121121212220", "1212132112212", "2212112112210", "2212211212120", "1221412121212", "1212122121210", "2112212122120", "1231212122212", "1211212122210", "2121123122122", "2121121122120", "2212112112120", "2212231212112", "2122121212120", "1212122121210", "2132122122121", "2112121222120", "1211212322122", "1211211221220", "2121121121220", "2122132112122", "1221212121120", "2121221212110", "2122321221212",
				"1121212212210", "2112121221220", "1231211221222", "1211211212220", "1221123121221", "2221121121210", "2221212112120", "1221241212112", "1212212212120", "1121212212210", "2114121212221", "2112112122210", "2211211412212", "2211211212120", "2212121121210", "2212214112121", "2122122121120", "1212122122120", "1121412122122", "1121121222120", "2112112122120", "2231211212122", "2121211212120", "2212121321212", "2122121121210", "2122121212120", "1212142121212", "1211221221220", "1121121221220", "2114112121222", "1212112121220", "2121211232122", "1221211212120", "1221212121210", "2121223212121", "2121212212120", "1211212212210", "2121321212221", "2121121212220", "1212112112210", "2223211211221", "2212211212120", "1221212321212", "1212122121210", "2112212122120", "1211232122212",
				"1211212122210", "2121121122210", "2212312112212", "2212112112120", "2212121232112", "2122121212110", "2212122121210", "2112124122121", "2112121221220", "1211211221220", "2121321122122", "2121121121220", "2122112112322", "1221212112120", "1221221212110", "2122123221212", "1121212212210", "2112121221220", "1211231212222", "1211211212220", "1221121121220", "1223212112121", "2221212112120", "1221221232112", "1212212122120", "1121212212210", "2112132212221", "2112112122210", "2211211212210", "2221321121212", "2212121121210", "2212212112120", "1232212121212", "1212122122120", "1121212322122", "1121121222120", "2112112122120", "2211231212122", "2121211212120", "2122121121210", "2124212112121", "2122121212120", "1212121223212", "1211212221220", "1121121221220", "2112132121222",
				"1212112121220", "2121211212120", "2122321121212", "1221212121210", "2121221212120", "1232121221212", "1211212212210", "2121123212221", "2121121212220", "1212112112220", "1221231211221", "2212211211220", "1212212121210", "2123212212121", "2112122122120", "1211212322212", "1211212122210", "2121121122120", "2212114112122", "2212112112120", "2212121211210", "2212232121211", "2122122121210", "2112122122120", "1231212122212", "1211211221220", "2121121321222", "2121121121220", "2122112112120", "2122141211212", "1221221212110", "2121221221210", "2114121221221" };

		int lday[] = { 31, 0, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
		int m1 = -1;
		int td = 0;
		int n2 = 0;
		int m2 = 0;
		int y = 0;
		int w2 = 0;
		;
		int syear = 0;
		int smonth = 0;
		int sday = 0;
		int syear1 = 0;
		int smonth1 = 0;
		int sday1 = 0;
		int youn = 0;
		String tt = "0";
		int ty = 0;
		String year = null;
		String month = null;
		String luday = null;

		syear = Integer.parseInt(day.substring(0, 4));
		smonth = Integer.parseInt(day.substring(4, 6));
		sday = Integer.parseInt(day.substring(6));

		try {
			if (syear != 1881) {
				m1 = syear - 1882;

				for (int i = 0; i <= m1; i++) {
					for (int j = 0; j <= 12; j++) {
						tt = lunar[i].substring(j, 1 + j);
						ty = Integer.parseInt(tt);
						td = td + ty;
					}

					if (Integer.parseInt(lunar[i].substring(12, 13)) == 0) {
						td += 336;
					} else {
						td += 362;
					}
				}

			}

			m1++;
			n2 = smonth - 1;
			m2 = -1;

			while (true) {
				m2++;
				if (Integer.parseInt(lunar[m1].substring(m2, 1 + m2)) > 2) {
					td += 26 + Integer.parseInt(lunar[m1].substring(m2, 1 + m2));
					n2++;
				} else {
					if (m2 == n2) {
						break;
					} else {
						td += 28 + Integer.parseInt(lunar[m1].substring(m2, 1 + m2));
					}
				}
			}
			// 1���� ���
			if (yunweol.equals("1")) {
				td += 28 + Integer.parseInt(lunar[m1].substring(m2, 1 + m2));
			}

			td += sday + 29;
			m1 = 1880;
			while (true) {
				m1++;
				if ((m1 / 400. - (int) (m1 / 400)) * 400 == 0 || (m1 / 100. - (int) (m1 / 100)) * 100 != 0 && (m1 / 4. - (int) (m1 / 4)) * 4 == 0) {
					m2 = 366;
				} else {
					m2 = 365;
				}

				if (td < m2) {
					break;
				}

				td -= m2;
			}
			syear1 = m1;
			lday[1] = m2 - 337;
			m1 = 0;

			while (true) {
				m1++;
				if (td <= lday[m1 - 1]) {
					break;
				}

				td -= lday[m1 - 1];
			}

			smonth1 = m1;
			sday1 = td;
			y = syear1 - 1;
			td = y * 365 + (int) (y / 4) - (int) (y / 100) + (int) (y / 400);
			if ((syear1 / 400. - (int) (syear1 / 400)) * 400 == 0 || (syear1 / 100. - (int) (syear1 / 100)) * 100 != 0 && (syear1 / 4. - (int) (syear1 / 4)) * 4 == 0) {
				lday[1] = 29;
			} else {
				lday[1] = 28;
			}

			for (int i = 0; i <= smonth1 - 2; i++) {
				td += lday[i];
			}

			td += sday1;
			w2 = td;
			while (true) {
				if (w2 < 7) {
					break;
				}

				w2 -= 7;
			}
			year = Integer.toString(syear1);
			if (smonth1 < 10) {
				month = "0" + Integer.toString(smonth1);
			} else {
				month = Integer.toString(smonth1);
			}
			if (sday1 < 10) {
				luday = "0" + Integer.toString(sday1);
			} else {
				luday = Integer.toString(sday1);
			}
		} catch (Exception e) {

			LLog.info.println("conveSolar Exception =  " + e.getMessage());
			LLog.info.println(" ��� ��ȯ�� �����߽4ϴ�.!!!");
		}

		return year + month + luday;
	}

	/* ���ڹ��ڿ� õ��' ���� 3�ڸ� �� */
	public String cut3Str(String numb) {
		int point = 0;
		if (numb == null || numb.equals("")) {
			return "0";
		}
		try {
			if (Long.parseLong(numb) == 0) {
				return "0";
			}
		} catch (NumberFormatException ex) {
			ex.printStackTrace();
			LLog.info.println("���ڰ� �ƴ� ");
			return "0";
		}
		point = numb.indexOf(".");
		if (point > 0) {
			numb = numb.substring(0, point);
		}
		if (numb.length() < 4) {
			return "0";
		}
		numb = numb.substring(0, numb.length() - 3);
		return numb;
	}

	public String cutSosu(String numb, int cut_position) {
		String head = "";
		String tail = "";
		int point = 0;
		String result_sosu = "";
		float fnumb = 0;
		try {
			if (numb.indexOf("E") != -1) {
				java.math.BigDecimal bd = new java.math.BigDecimal(Double.parseDouble(numb));
				numb = bd.toString();
			}
		} catch (Exception ex) {
			ex.printStackTrace();

		}

		try {
			if (Float.parseFloat(numb) == 0 && cut_position == 0) {
				return "0";
			}

		} catch (NumberFormatException ex) {
			ex.printStackTrace();
			LLog.info.println("���ڰ� �ƴ� ");
			return numb;
		}
		point = numb.indexOf(".");

		if (point == -1) {
			return numb;
		}

		head = numb.substring(0, point);
		tail = numb.substring(point);
		StringBuffer sb_tail = new StringBuffer();
		if (cut_position == 0) {
			return head;
		} else {
			sb_tail.append(tail);
			if (tail.length() < cut_position + 1) {
				for (int i = 0; i < cut_position + 1 - tail.length(); i++) {
					sb_tail.append("0");
				}

			}
			result_sosu = sb_tail.toString().substring(0, cut_position + 1);
			StringBuffer sb = new StringBuffer();
			sb.append(head);
			sb.append(result_sosu);
			// LLog.info.println("sb.toString():"+sb.toString());
			return sb.toString();
		}

	}

	public String divide1000(double value) {
		String retValue = "0";

		if (value == 0.0d)
			return retValue;
		else {
			retValue = roundBigDec(value / 1000, 0);
		}

		return retValue;
	}

	public String divideUnit(double value, double unit) {
		String retValue = "0";

		if (value == 0.0d || unit == 0.0d)
			return retValue;
		else {
			retValue = roundBigDec(value / unit, 0);
		}

		return retValue;
	}

	public String divideUnit(double value, double unit, int seq) {
		String retValue = "0";

		if (value == 0.0d || unit == 0.0d)
			return retValue;
		else {
			retValue = roundBigDec(value / unit, seq);
		}

		return retValue;
	}

	public String divideUnit(String value, double unit, int seq) {
		String retValue = "0";

		if (value == null || value.equals(""))
			return "0";
		if (unit == 0.0d)
			return retValue;
		else {
			retValue = roundBigDec(Double.valueOf(value).doubleValue() / unit, seq);
		}

		return retValue;
	}

	public double divideUnitDouble(double value, double unit) {
		double retValue = 0;

		if (value == 0.0d || unit == 0.0d)
			return retValue;
		else {
			retValue = value / unit;
		}

		return retValue;
	}

	/*
	 * DBMS�� CharacterSet�� USASCII�̹Ƿ� DB�� ���� ��n�� ���� ��ȯ�� �ʿ��ϴ�.
	 * Oracle8.1.6���Ŀ��� �ذ�� ��f�̹Ƿ� DBMS��׷��̵� �Ŀ��� �޾ƿ� �Ķ���͸� �״��
	 * �����ϴ� ���8�� ��ġ�� �� Method�� ���� ������ �wα׷� ��d: ���ʿ��ϴ�.
	 * 
	 * �ں��� ��d--- single qut dubble qut ��ȥ DATA�� �Է��� ���
	 */
	// JVM <--- DB
	public static String OutE(String s) throws Exception {
		String t = "";
		// if (english == null ) return null;
		if (s == null)
			return "";
		try {
			if (DB_CHARSET == 1) {
				t = new String(s.getBytes("ISO-8859-1"), "KSC5601");
				t = replace(t, "'", "&rsquo;");
				t = replace(t, "\"", "&quot");

			} else {
				s = replace(t, "'", "&rsquo;");// &#039
				s = replace(t, "\"", "&quot");

				return s;
			}
		} catch (UnsupportedEncodingException e) {
			throw e;
		}

		return t;
	}

	/*
	 * DBMS�� CharacterSet�� USASCII�̹Ƿ� DBȣ��� vȸv��,�Է°�,��d���� ��ȯ�� �ʿ��ϴ�.
	 * Oracle8.1.6���Ŀ��� �ذ�� ��f�̹Ƿ� DBMS��׷��̵� �Ŀ��� �޾ƿ� �Ķ���͸� �״��
	 * �����ϴ� ���8�� ��ġ�� �� Method�� ���� ������ �wα׷� ��d: ���ʿ��ϴ�.
	 * 
	 * DATA�� DB���� �о�� �����ֱ� �� ���.
	 */
	// JVM --> DB
	public static String InE(String s) throws Exception {
		String t = "";
		// if (korean == null ) return null;
		if (s == null)
			return "";
		try {
			if (DB_CHARSET == 1) {

				t = new String(s.getBytes("KSC5601"), "ISO-8859-1");
			} else {

				return s;
			}

		} catch (UnsupportedEncodingException e) {
			throw e;
		}
		return t;
	}

	/**
	 * DESC : ���ڵ� ���� (0000000000000 => 000-0000-000000) 2004-07-02 ��ö��
	 * 2004-07-29 ��μ� (7�ڸ� �̻��� ��� �� 7�ڸ� ������ �ܿ� ó��
	 */
	public String getBarCode(String barCode) {
		String result = "";
		if (barCode == null)
			return result;
		else if (barCode.length() <= 3)
			return barCode;
		else if (barCode.length() < 8) {
			StringBuffer newCode = new StringBuffer(barCode);
			newCode.insert(3, '-');
			result = newCode.toString();
		} else {
			StringBuffer newCode = new StringBuffer(barCode);
			// if (barCode.length() == 13) {
			newCode.insert(7, '-');
			newCode.insert(3, '-');
			// }
			result = newCode.toString();
		}
		return result;
	}

	/**
	 * ���ڸ� �ݰ����ڷ� ��ȯ�Ѵ�.
	 */
	public java.lang.String getCodeConv(byte[] bstr) {

		String sBuf = "";
		if (bstr.length == 0)
			return sBuf;

		byte newbyte[] = new byte[bstr.length];

		int k = 0, i = 0;
		int asciiByte = 0;
		while (i < bstr.length) {

			asciiByte = bstr[i] + 256;
			if (!(asciiByte >= 161 && asciiByte <= 163) && bstr[i] < 0) {
				newbyte[k++] = bstr[i];
				i++;
				newbyte[k++] = bstr[i];
			} else {
				switch (asciiByte) {
				case 163:
					newbyte[k] = (byte) (128 + bstr[i + 1]);
					i++;
					break;
				case 161:
					newbyte[k] = 32;
					i++;
					break;
				case 162:
					newbyte[k] = 126;
					i++;
					break;
				default:
					newbyte[k] = bstr[i];
				}
				k++;
			}
			i++;
		}

		sBuf = new String(newbyte);

		return sBuf;
	}

	/**
	 * ���ڸ� �ݰ����ڷ� ��ȯ�Ѵ�.
	 */
	public java.lang.String getCodeConv(String str) {

		if (str == null || str.trim().equals(""))
			return str;

		byte[] bstr = str.getBytes();

		return getCodeConv(bstr);
	}

	public Properties getConfigEnv(String name) throws Exception {
		InputStream in = new FileInputStream(new File(classPath + "hci_xi_config.property"));
		Properties prop = new Properties();
		prop.load(in);
		in.close();
		return prop;
	}

	public Properties getConfigEnvLog(String name) throws Exception {
		InputStream in = new FileInputStream(new File(classPath + "config_xi_log.properties"));
		Properties prop = new Properties();
		prop.load(in);
		in.close();
		return prop;
	}

	/**
	 * CR��; <br>
	 * �±׷� ��ȯ
	 */
	public String getCrToBr(String data) {
		int pos = 0;
		String result = data;

		while ((pos = result.indexOf("\n")) != -1) {
			String left = result.substring(0, pos - 1);
			String right = result.substring(pos + 1, result.length());
			result = left + "<br>" + right;
		}
		return result;
	}

	/**
	 * parse���� 'ġ��; ����
	 */
	public int getCton(char chr) {

		return (Ref.indexOf(chr));
	}

	/**
	 * DESC : �?��ȣ ���� (0000000000 => 0000-000-000) 2004-09-14 ��ö��
	 */
	public String getCustNo(String custNo) {
		String result = "";
		if (custNo == null)
			return result;
		else if (custNo.length() <= 4)
			return custNo;
		else if (custNo.length() < 8) {
			StringBuffer newCode = new StringBuffer(custNo);
			newCode.insert(4, '-');
			result = newCode.toString();
		} else {
			StringBuffer newCode = new StringBuffer(custNo);
			newCode.insert(7, '-');
			newCode.insert(4, '-');
			result = newCode.toString();
		}
		return result;
	}

	/**
	 * DESC : ���糯¥ ��n�1� (���:YYYY/MM/DD)
	 */
	public String getDate() {
		return getDate(getPlainDate());
	}

	public String getDate(int flag, int offset) {

		try {
			StringBuffer buf = new StringBuffer();
			String[] ids = java.util.TimeZone.getAvailableIDs(-8 * 60 * 60 * 1000);
			// if no ids were returned, something is wrong. get out.
			if (ids.length == 0)
				return null;
			java.util.SimpleTimeZone pdt = new java.util.SimpleTimeZone(-8 * 60 * 60 * 1000, ids[0]);
			// set up rules for daylight savings time
			pdt.setStartRule(java.util.Calendar.APRIL, 1, java.util.Calendar.SUNDAY, 2 * 60 * 60 * 1000);
			pdt.setEndRule(java.util.Calendar.OCTOBER, -1, java.util.Calendar.SUNDAY, 2 * 60 * 60 * 1000);
			// create a GregorianCalendar with the Pacific Daylight time zone
			// and the current date and time
			java.util.Calendar endx_date = new GregorianCalendar(pdt);
			java.util.Date trialTime = new java.util.Date();
			endx_date.setTime(trialTime);
			if (flag == 1) {
				// ���� ���ڰ� 6�� ���� ��8�� ������� 2���� ���; ���
				if (Integer.parseInt(getPlainDate().substring(6, 8)) > 1 && Integer.parseInt(getPlainDate().substring(6, 8)) < 6)
					offset = offset - 1;
				// ���� ���ڰ� 1���̰� USA �ð��� ���� 4�� �����̸�
				else if (Integer.parseInt(getPlainDate().substring(6, 8)) == 1 && Integer.parseInt(getPlainDateTime().substring(8, 10)) > 16) {
					offset = offset - 1;
				}
				endx_date.add(java.util.Calendar.MONTH, offset);
			} else if (flag == 2) {
				endx_date.add(java.util.Calendar.DATE, offset);
			}
			buf.append(endx_date.get(endx_date.YEAR));
			if (endx_date.get(endx_date.MONTH) < 9)
				buf.append('0');
			buf.append(endx_date.get(endx_date.MONTH) + 1);
			if (endx_date.get(endx_date.DATE) <= 9)
				buf.append('0');
			buf.append(endx_date.get(endx_date.DATE));
			return buf.toString();
		} catch (Exception e) {
			e.printStackTrace(System.err);
			return null;
		}
	}

	/**
	 * DESC : ��¥��� ���� (YYYYMMDD => YYYY/MM/DD)
	 */
	public String getDate(String date) {
		String result = "";
		if (date == null)
			return result;
		else if (date.length() < 4)
			return date;
		else if (date.length() < 6) {
			StringBuffer newDate = new StringBuffer(date);
			if (date.length() == 4)
				newDate.insert(2, '/');
			result = newDate.toString();
		} else if (!date.equals("")) {
			StringBuffer newDate = new StringBuffer(date);
			if (date.length() == 8)
				newDate.insert(6, '/');
			newDate.insert(4, '/');
			result = newDate.toString();
		}

		if (date.length() > 11) {
			StringBuffer newDate = new StringBuffer(date);
			newDate.insert(10, ':');
			newDate.insert(8, ' ');
			newDate.insert(6, '/');
			newDate.insert(4, '/');
			result = newDate.toString();
		}
		return result;
	}

	public String getDate(String date, int flag, int offset) {// 2001.11.24
																// ����ö �߰�
		// �Է¹�: ��¥�� ����8�� ��,�� �̵�
		int yyyy = 0, mm = 0, dd = 15;

		try {
			StringBuffer buf = new StringBuffer();
			yyyy = Integer.parseInt(date.substring(0, 4));
			mm = Integer.parseInt(date.substring(4, 6));
			if (date.length() == 8)
				dd = Integer.parseInt(date.substring(6, 8));

			java.util.Calendar endx_date = new GregorianCalendar(yyyy, mm - 1, dd);

			if (flag == 1) { // for month
				endx_date.add(java.util.Calendar.MONTH, offset);
			} else if (flag == 2) { // for day
				endx_date.add(java.util.Calendar.DATE, offset);
			} else if (flag == 3) {
				endx_date.add(java.util.Calendar.YEAR, offset);
			}

			// year
			buf.append(endx_date.get(endx_date.YEAR));

			if (endx_date.get(endx_date.MONTH) < 9)
				buf.append('0');

			// month
			buf.append(endx_date.get(endx_date.MONTH) + 1);

			if (date.length() >= 8) {
				if (endx_date.get(endx_date.DATE) <= 9)
					buf.append('0');
				// day
				buf.append(endx_date.get(endx_date.DATE));
			}

			return buf.toString();
		} catch (Exception e) {
			e.printStackTrace(System.err);
			return null;
		}
	}

	/**
	 * ��¥��� ���� �ۼ� ��¥: (2003-06-11 ���� 6:38:24)
	 * 
	 * @return java.lang.String
	 * @param date
	 *            java.lang.String
	 * @param gubun
	 *            java.lang.String
	 */
	public String getDate(String date, String gubun) {
		String result = "";
		if (date.length() < 6)
			return date;
		else if (date == null)
			return result;
		if (!date.equals("")) {
			StringBuffer newDate = new StringBuffer(date);
			if (date.length() == 8)
				newDate.insert(6, '/');
			newDate.insert(4, '/');
			result = newDate.toString();
		}
		return result;
	}

	/**
	 * DESC : �Է¹�: Datetime ��ĺ�ȯ
	 */
	public String getDatetime(String datetime, int index) {
		String result = "";
		if (!datetime.equals("")) {
			StringBuffer newDatetime = new StringBuffer(datetime);
			if (index == 0) {
				newDatetime.insert(10, ':');
				newDatetime.insert(8, ' ');
				newDatetime.insert(6, '/');
				newDatetime.insert(4, '/');
			} else if (index == 1) {
				newDatetime.insert(12, " ��");
				newDatetime.insert(10, " �� ");
				newDatetime.insert(8, " �� ");
				newDatetime.insert(6, " �� ");
				newDatetime.insert(4, " �� ");
			}

			result = newDatetime.toString();
		}
		return result;
	}

	/**
	 * DESC : v���ڵ� ���� (0000000000 => 00-00-00-00-00) 2003-08-04 dd��
	 */
	public String getDeptCode(String deptCode) {
		String result = "";
		if (deptCode.length() < 10)
			return deptCode;
		else if (deptCode == null)
			return result;
		if (!deptCode.equals("")) {
			StringBuffer newCode = new StringBuffer(deptCode);
			if (deptCode.length() == 10) {
				newCode.insert(8, '-');
				newCode.insert(6, '-');
				newCode.insert(4, '-');
				newCode.insert(2, '-');
			}
			result = newCode.toString();
		}
		return result;
	}

	/**
	 * DESC : pString�� ���̿� len; ���Ͽ� ���ڶ�ŭ pString�տ� '0'; ä���. 2004-06-09
	 * ��ö��
	 */
	public String getDigits(String pString, int len) {
		String result = "";
		if (pString.length() == len)
			return pString;
		else if (pString == null)
			return result;
		if (pString.length() < len) {
			result = appendCharHead(pString, '0', len - pString.length());
		}
		return result;
	}

	/**
	 * DESC : pString�� ���̿� len; ���Ͽ� ���ڶ�ŭ pString�տ� ' '; ä���. 2007-10-19
	 * �ڹ�d
	 */
	public String getspace(String pString, int len) {
		String result = "";
		if (pString.length() == len)
			return pString;
		else if (pString == null)
			return result;
		if (pString.length() < len) {
			result = appendCharTail(pString, ' ', len - pString.length());
		}
		return result;
	}

	// �̹���� ���� ��; ���Ѵ�.
	public int getEndDay() {
		Locale lc = new Locale("Locale.KOREAN", "Locale.KOREA");
		TimeZone tz = (TimeZone) TimeZone.getTimeZone("JST");
		Calendar today;
		int endDay;
		today = Calendar.getInstance(tz, lc);
		today.set(today.get(Calendar.YEAR), today.get(Calendar.MONTH), 1);
		endDay = today.getActualMaximum(Calendar.DAY_OF_MONTH);
		return endDay;
	}

	// �ش� ���� ���� ��; ���Ѵ�.
	public int getEndDay(String yyyymm) {
		Locale lc = new Locale("Locale.KOREAN", "Locale.KOREA");
		TimeZone tz = (TimeZone) TimeZone.getTimeZone("JST");
		Calendar today;
		int endDay;
		today = Calendar.getInstance(tz, lc);
		today.set(Integer.parseInt(yyyymm.substring(0, 4)), Integer.parseInt(yyyymm.substring(4)) - 1, 1);
		// today.set(today.get(Calendar.YEAR), today.get(Calendar.MONTH), 1);
		endDay = today.getActualMaximum(Calendar.DAY_OF_MONTH);
		return endDay;
	}

	public static Properties getEnvironment(String name) throws Exception {
		InputStream in = ClassLoader.getSystemResourceAsStream(name);
		Properties prop = new Properties();
		prop.load(in);
		in.close();
		return prop;
	}

	/**
	 * ���� ��¥�� ���� ����� ��d���8�� ������ Yong hee (mindpool@empal.com)
	 * 
	 * @param check
	 * @return
	 */

	public static String getFormatDate(String check) {
		java.util.Date date = new java.util.Date();
		GregorianCalendar calendar = new GregorianCalendar();
		calendar.setTime(date);
		SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat datetime = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");
		SimpleDateFormat yyyy = new SimpleDateFormat("yyyy");
		SimpleDateFormat yy = new SimpleDateFormat("yy");
		SimpleDateFormat mm = new SimpleDateFormat("MM");
		SimpleDateFormat dd = new SimpleDateFormat("dd");
		SimpleDateFormat HH = new SimpleDateFormat("HH");
		SimpleDateFormat mi = new SimpleDateFormat("mm");
		SimpleDateFormat ss = new SimpleDateFormat("ss");
		SimpleDateFormat ms = new SimpleDateFormat("SSS");

		String strdate = simpleDate.format(date);
		String strdatetime = datetime.format(date);
		String lYear = yyyy.format(date);
		String sYear = yy.format(date);
		String month = mm.format(date);
		String day = dd.format(date);
		String hour = HH.format(date);
		String minute = mi.format(date);
		String second = ss.format(date);
		String milisecond = ms.format(date);

		if (check.equals("yyyy"))
			return lYear;
		else if (check.equals("yy"))
			return sYear;
		else if (check.equals("mm"))
			return month;
		else if (check.equals("dd"))
			return day;
		else if (check.equals("hh"))
			return hour;
		else if (check.equals("mi"))
			return minute;
		else if (check.equals("ss"))
			return second;
		else if (check.equals("ms"))
			return milisecond;
		else if (check.equals("date"))
			return strdate;
		else if (check.equals("yyyymmdd"))
			return lYear + month + day;
		else if (check.equals("yyyymm"))
			return lYear + month;
		else if (check.equals("yymmdd"))
			return sYear + month + day;
		else if (check.equals("yymm"))
			return sYear + month;
		else if (check.equals("hhmiss"))
			return hour + minute + second;
		else if (check.equals("datetime"))
			return strdatetime;
		else if (check.equals("total"))
			return lYear + month + day + hour + minute + second + milisecond;
		else
			return "";
	}

	/**
	 * parse������ 'ġ�� �ش��ϴ� ���ڸ� ����
	 */
	public char getNtoc(int idx) {

		return (Ref.charAt(idx));
	}

	/**
	 * DESC : ��ȭ��ȣ ���� (00000000000 => 000-0000-0000) 2004-07-28 ��ö��
	 */
	public String getPhone_no(String phoneNo) {
		String result = "";
		if (phoneNo.length() < 11)
			return phoneNo;
		else if (phoneNo == null || phoneNo.trim().equals(""))
			return result;
		if (!phoneNo.trim().equals("")) {
			String no1 = "";
			String no2 = "";
			String no3 = "";

			if (phoneNo.length() == 11) {
				no1 = phoneNo.substring(0, 3);
				no1 = replace(no1, "00", "0") + "-";
				no2 = phoneNo.substring(3, 7);
				no2 = "" + Long.parseLong(no2) + "-";
				no3 = phoneNo.substring(7);
				// no3 = "" + Long.parseLong(no3);
			}

			result = no1 + no2 + no3;
		}
		return result;
	}

	/**
	 * DESC : System date�� YYYYMMDD ���·� ����
	 */
	public String getPlainDate() {
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMdd");
		java.util.Date currentDate_1 = new java.util.Date();
		String date = formatter.format(currentDate_1);
		return date;
	}

	/**
	 * DESC : System datetime; YYYYMMDDHHMM ���·� ����
	 */
	public String getPlainDateTime() {
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMddHHmm");
		java.util.Date currentDate_1 = new java.util.Date();
		String date = formatter.format(currentDate_1);
		return date;
	}

	public String getPlainDateTime2() {
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMddHHmmss");
		java.util.Date currentDate_1 = new java.util.Date();
		String date = formatter.format(currentDate_1);
		return date;
	}

	/**
	 * DESC : System datetime; dateFormat ���·� ����
	 */
	public String getPlainDateTime(String dateFormat) {
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(dateFormat);
		java.util.Date currentDate_1 = new java.util.Date();
		String date = formatter.format(currentDate_1);
		return date;
	}

	/**
	 * config.properties���� ��~ ȯ�溯�� ��n�1�'�� �޼ҵ� �ۼ� ��¥: (2004-08-06 ����
	 * 1:20:24)
	 * 
	 * @return java.lang.String
	 * @param name
	 *            java.lang.String
	 */
	public String getProp(String name) {
		String value = "";
		try {

			Properties prop = getConfigEnv("hci_xi_config.property");

			value = prop.getProperty(name);

		} catch (Exception e) {
			LLog.info.println(e);
			return null;
		}
		return value;
	}

	public String getPropLog(String name) {
		String value = "";
		try {

			Properties prop_log = getConfigEnvLog("config_xi_log.properties");

			value = prop_log.getProperty(name);

		} catch (Exception e) {
			LLog.info.println(e);
			return null;
		}
		return value;
	}

	/**
	 * Decode�ϰ��� �ϴ� pwssward�� �Է¹޾� decode�Ͽ� �����Ѵ�.
	 */
	public String getPwdDecode(String pwd, int CipherVal) {

		StringBuffer buf = new StringBuffer("");

		int i = 0;
		char chr = ' ';
		int Conv = 0;
		int Cipher = 0;
		char CipherChr = ' ';
		for (i = 0; i < pwd.length(); i++) {

			chr = pwd.charAt(i);

			Conv = getCton(chr);
			Cipher = Conv ^ CipherVal;
			CipherChr = getNtoc(Cipher);

			buf.append(CipherChr);
		}
		LLog.info.println(buf.toString());
		return buf.toString();
	}

	/**
	 * DESC : �ֹι�ȣ ���� (0000000000000 => 000000-0000000) 2004-07-28 ��ö��
	 */
	public String getResi_no(String resiNo) {
		String result = "";
		if (resiNo.length() < 13)
			return resiNo;
		else if (resiNo == null)
			return result;
		if (!resiNo.equals("")) {
			StringBuffer newCode = new StringBuffer(resiNo);
			if (resiNo.length() == 13) {
				newCode.insert(6, '-');
			}
			result = newCode.toString();
		}
		return result;
	}

	/**
	 * DESC : �ֹι�ȣ ���� (0000000000000 => 000000-*******) 2007-12-30 ���ȣ
	 */
	public String getResi_no_2(String resiNo) {
		String result = "";
		if (resiNo.length() < 13)
			return resiNo;
		else if (resiNo == null)
			return result;
		if (!resiNo.equals("")) {
			StringBuffer newCode = new StringBuffer(resiNo);
			if (resiNo.length() == 13) {
				newCode.replace(7, 13, "*******");
				newCode.insert(6, '-');
			}
			result = newCode.toString();
		}
		return result;
	}

	/**
	 * DESC : SMS��ۿ� ��ȭ��ȣ ���� (00000000000,000-0000-0000 => 00000000000)
	 * 2004-09-04 Ȳ����
	 */
	public String getSmsPhone_no(String phoneNo) {
		String result = "";
		if (phoneNo == null)
			return result;

		if (!phoneNo.equals("") && phoneNo.length() > 9) {
			String no1 = "";
			String no2 = "";
			String no3 = "";
			phoneNo = removeChar(phoneNo, "-");

			if (phoneNo.length() == 11) {
				no1 = phoneNo.substring(0, 3);
				no1 = replace(no1, "00", "0");
				no2 = phoneNo.substring(3, 7);
				no2 = "" + Long.parseLong(no2);
				no3 = phoneNo.substring(7);
				result = no1 + no2 + no3;
			} else {
				result = phoneNo;
			}

		}
		return result;
	}

	/**
	 * ���ڿ�; len��ŭ �߶� String8�� �����Ѵ�. byte�� ��ȯ�Ͽ� �ѱ��� �߸��� len-1��
	 * �Ͽ� String�� �����Ѵ�.
	 */
	public java.lang.String getSubstrStr(String str, int len) {

		if (str == null || str.trim().equals(""))
			return str;

		byte[] bstr = str.getBytes();
		if (bstr.length <= len)
			return str;

		byte newbyte[] = new byte[len + 1];

		int k = 0;
		for (int i = 0; i < len; i++) {
			if (bstr[i] < 0)
				k++;
		}
		if (k % 2 == 1)
			len--;

		System.arraycopy(bstr, 0, newbyte, 0, len);

		String sBuf = new String(newbyte);

		return sBuf;
	}

	public static String getSubstrStr(String str, int start, int len) {

		// StringBuffer buf = new StringBuffer("");
		if (str == null || str.trim().equals(""))
			return str;

		byte[] bstr = str.getBytes();
		if (bstr.length <= len)
			return str;

		byte newbyte[] = new byte[len];

		int k = 0;
		for (int i = 0; i < len; i++) {
			if (bstr[i] < 0)
				k++;
		}
		if (k % 2 == 1)
			len--;

		System.arraycopy(bstr, start, newbyte, 0, len);

		String sBuf = new String(newbyte);

		return sBuf.trim();
	}

	/*
	 * �������ڿ� trim; f���Ѵ�.
	 */
	public static String getSubstrStr2(String str, int start, int len) {

		// StringBuffer buf = new StringBuffer("");
		if (str == null || str.trim().equals(""))
			return str;

		byte[] bstr = str.getBytes();
		if (bstr.length <= len)
			return str;

		byte newbyte[] = new byte[len];

		int k = 0;
		for (int i = 0; i < len; i++) {
			if (bstr[i] < 0)
				k++;
		}
		if (k % 2 == 1)
			len--;

		System.arraycopy(bstr, start, newbyte, 0, len);

		String sBuf = new String(newbyte);

		return sBuf;
	}

	/**
	 * DESC : ���º�ȯ ( hhmmss => hh:mm:ss )
	 */
	public String getTime(String time) {
		String result = "";
		if (time.length() != 6)
			return time;
		else if (time == null)
			return result;
		if (!time.equals("")) {
			StringBuffer newTime = new StringBuffer(time);
			newTime.insert(4, ':');
			newTime.insert(2, ':');
			result = newTime.toString();
		}

		return result;
	}

	public String getTime2() {
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("HH:mm:ss");
		java.util.Date currentTime_1 = new java.util.Date();
		String time = formatter.format(currentTime_1);
		return time;
	}

	/**
	 * �ش� ���ڿ�; ��ū8�� �����Ͽ� List ��ü�� �����ϴ� �Լ�
	 * 
	 * @param s
	 *            ��ũ�������� �ش� ���ڿ�
	 * @param delimiter
	 *            delimiter(������ )
	 * @return List : ��ū List
	 */
	public List getToken(String s, char delimiter) {
		List lst = new List();
		String token;
		int from = 0, to = 0;

		for (int i = 0; i < s.length();) {
			to = s.indexOf(delimiter, from);
			if (to < 0) {
				token = s.substring(from);
				lst.add(token);
				break;
			}

			token = s.substring(from, to);
			lst.add(token);
			from = to + 1;
			i = i + token.length() + 1;
		}
		return lst;
	}

	/**
	 * DESC : ��¥��� ���� (YYYYMM => YYYY/MM)
	 */
	public String getYearMonth(String date) {
		String result = "";

		if (date.length() != 6)
			return date;
		else if (date == null)
			return result;

		if (!date.equals("")) {
			StringBuffer newDate = new StringBuffer(date);
			newDate.insert(4, '/');
			result = newDate.toString();
		}

		return result;
	}

	private static int lastDay(int year, int month) throws java.text.ParseException {

		int day = 0;
		switch (month) {
		case 1:
		case 3:
		case 5:
		case 7:
		case 8:
		case 10:
		case 12:
			day = 31;
			break;
		case 2:
			if ((year % 4) == 0) {

				if ((year % 100) == 0 && (year % 400) != 0) {
					day = 28;
				} else {
					day = 29;
				}
			} else {
				day = 28;
			}
			break;
		default:
			day = 30;
		}
		return day;
	}

	public String likeDeptCode(String dept_code) {

		String dept[] = new String[5];
		String rtn = "";

		if (dept_code.equals("") || dept_code.length() < 10) {
			rtn = dept_code;
		} else {
			dept[0] = dept_code.substring(0, 2);
			dept[1] = dept_code.substring(2, 4);
			dept[2] = dept_code.substring(4, 6);
			dept[3] = dept_code.substring(6, 8);
			dept[4] = dept_code.substring(8, 10);

			if (dept[4].equals("00"))
				dept[4] = "";
			if (dept[3].equals("00"))
				dept[3] = "";
			if (dept[2].equals("00"))
				dept[2] = "";
			if (dept[1].equals("00"))
				dept[1] = "";
			if (dept[0].equals("00"))
				dept[0] = "";

			rtn = dept[0] + dept[1] + dept[2] + dept[3] + dept[4];
		}

		// LLog.info.println("dept_code="+ dept_code);
		// LLog.info.println("dept_code="+ dept_code.length());

		return rtn;
	}

	public String likeDeptCode2(String dept_code) {

		String dept[] = new String[5];
		String rtn = "";

		if (dept_code.equals("") || dept_code.length() < 10) {
			rtn = dept_code;
		} else {
			dept[0] = dept_code.substring(0, 2);
			dept[1] = dept_code.substring(2, 4);
			dept[2] = dept_code.substring(4, 6);
			dept[3] = dept_code.substring(6, 8);
			dept[4] = dept_code.substring(8, 10);

			if (dept[4].equals("00")) {
				dept[4] = "";
				if (dept[3].equals("00")) {
					dept[3] = "";
					if (dept[2].equals("00")) {
						dept[2] = "";
						if (dept[1].equals("00")) {
							dept[1] = "";
							if (dept[0].equals("00"))
								dept[0] = "";
						}
					}
				}
			}

			rtn = dept[0] + dept[1] + dept[2] + dept[3] + dept[4];
		}

		// LLog.info.println("dept_code="+ dept_code);
		// LLog.info.println("dept_code="+ dept_code.length());

		return rtn;
	}

	/**
	 * ��� -> =�� ��ȯ �ۼ� ��¥: (2002-10-23 ���� 10:39:39)
	 * 
	 * @param solarDate
	 *            java.lang.String : �Է¹�: ��� �����
	 * @return lunaryymmdd java.lang.String : =�� �����
	 */
	public String lunarCalendar(String solarDate) {
		String lunaryy = "", lunarmm = "", lunardd = "";
		int lunarYear, lunarMonth, lunarDate;
		if (solarDate.length() != 8)
			return solarDate;
		int[][] matchTable = {
		// 1881
				{ 1, 2, 1, 2, 1, 2, 2, 3, 2, 2, 1, 2, 1 }, { 1, 2, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 0 }, { 1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 1, 2, 0 }, { 2, 1, 1, 2, 1, 3, 2, 1, 2, 2, 1, 2, 2 }, { 2, 1, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 0 }, { 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 0 }, { 2, 2, 1, 2, 3, 2, 1, 1, 2, 1, 2, 1, 2 }, { 2, 1, 2, 2, 1, 2, 1, 1, 2, 1, 2, 1, 0 }, { 2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 0 }, { 1, 2, 3, 2, 1, 2, 2, 1, 2, 1, 2, 1, 2 },
				// 1891
				{ 1, 2, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 0 }, { 1, 1, 2, 1, 1, 2, 3, 2, 2, 1, 2, 2, 2 }, { 1, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 0 }, { 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 0 }, { 2, 1, 2, 1, 2, 3, 1, 2, 1, 2, 1, 2, 1 }, { 2, 2, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 0 }, { 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 0 }, { 2, 1, 2, 3, 2, 2, 1, 2, 1, 2, 1, 2, 1 }, { 2, 1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 0 }, { 1, 2, 1, 1, 2, 1, 2, 2, 3, 2, 2, 1, 2 },
				// 1901
				{ 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1, 0 }, { 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 0 }, { 1, 2, 1, 2, 1, 3, 2, 1, 1, 2, 2, 1, 2 }, { 2, 2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 0 }, { 2, 2, 1, 2, 2, 1, 1, 2, 1, 2, 1, 2, 0 }, { 1, 2, 2, 1, 4, 1, 2, 1, 2, 1, 2, 1, 2 }, { 1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1, 0 }, { 2, 1, 1, 2, 2, 1, 2, 1, 2, 2, 1, 2, 0 }, { 1, 2, 3, 1, 2, 1, 2, 1, 2, 2, 2, 1, 2 }, { 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1, 0 },
				// 1911
				{ 2, 1, 2, 1, 1, 2, 3, 1, 2, 2, 1, 2, 2 }, { 2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2, 0 }, { 2, 2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 0 }, { 2, 2, 1, 2, 2, 3, 1, 2, 1, 2, 1, 1, 2 }, { 2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 0 }, { 1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1, 0 }, { 2, 1, 3, 2, 1, 2, 2, 1, 2, 2, 1, 2, 1 }, { 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1, 2, 0 }, { 1, 2, 1, 1, 2, 1, 2, 3, 2, 2, 1, 2, 2 }, { 1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2, 2, 0 },
				// 1921
				{ 2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 0 }, { 2, 1, 2, 2, 1, 3, 2, 1, 1, 2, 1, 2, 2 }, { 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 1, 2, 0 }, { 2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1, 1, 0 }, { 2, 1, 2, 2, 3, 2, 1, 2, 2, 1, 2, 1, 2 }, { 1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1, 0 }, { 2, 1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 0 }, { 1, 2, 3, 1, 2, 1, 1, 2, 2, 1, 2, 2, 2 }, { 1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 0 }, { 1, 2, 2, 1, 1, 2, 3, 1, 2, 1, 2, 2, 1 },
				// 1931
				{ 2, 2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 1, 0 }, { 2, 2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 0 }, { 1, 2, 2, 1, 2, 4, 1, 2, 1, 2, 1, 1, 2 }, { 1, 2, 1, 2, 2, 1, 2, 2, 1, 2, 1, 2, 0 }, { 1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1, 0 }, { 2, 1, 1, 4, 1, 2, 1, 2, 1, 2, 2, 2, 1 }, { 2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 1, 0 }, { 2, 2, 1, 1, 2, 1, 1, 4, 1, 2, 2, 1, 2 }, { 2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 1, 2, 0 }, { 2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 0 },
				// 1941
				{ 2, 2, 1, 2, 2, 1, 4, 1, 1, 2, 1, 2, 1 }, { 2, 1, 2, 2, 1, 2, 2, 1, 2, 1, 1, 2, 0 }, { 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1, 2, 0 }, { 1, 1, 2, 1, 4, 1, 2, 1, 2, 2, 1, 2, 2 }, { 1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 1, 2, 0 }, { 2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 1, 2, 0 }, { 2, 2, 3, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2 }, { 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 0 }, { 2, 2, 1, 2, 1, 2, 1, 3, 2, 1, 2, 1, 2 }, { 2, 1, 2, 2, 1, 2, 1, 1, 2, 1, 2, 1, 0 },
				// 1951
				{ 2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 0 }, { 1, 2, 1, 2, 1, 4, 2, 1, 2, 1, 2, 1, 2 }, { 1, 2, 1, 1, 2, 2, 1, 2, 2, 1, 2, 2, 0 }, { 1, 1, 2, 1, 1, 2, 1, 2, 2, 1, 2, 2, 0 }, { 2, 1, 1, 4, 1, 1, 2, 1, 2, 1, 2, 2, 2 }, { 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 0 }, { 2, 1, 2, 1, 2, 1, 1, 2, 3, 2, 1, 2, 2 }, { 1, 2, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 0 }, { 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 0 }, { 2, 1, 2, 1, 2, 2, 3, 2, 1, 2, 1, 2, 1 },
				// 1961
				{ 2, 1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 0 }, { 1, 2, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1, 0 }, { 2, 1, 2, 1, 3, 2, 1, 2, 1, 2, 2, 2, 1 }, { 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 0 }, { 1, 2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 0 }, { 2, 2, 2, 3, 2, 1, 1, 2, 1, 1, 2, 2, 1 }, { 2, 2, 1, 2, 2, 1, 1, 2, 1, 2, 1, 2, 0 }, { 1, 2, 2, 1, 2, 1, 2, 3, 2, 1, 2, 1, 2 }, { 1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1, 0 }, { 2, 1, 1, 2, 2, 1, 2, 1, 2, 2, 1, 2, 0 },
				// 1971
				{ 1, 2, 1, 1, 2, 3, 2, 1, 2, 2, 2, 1, 2 }, { 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1, 0 }, { 2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 2, 1, 0 }, { 2, 2, 1, 2, 3, 1, 2, 1, 1, 2, 2, 1, 2 }, { 2, 2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 0 }, { 2, 2, 1, 2, 1, 2, 1, 2, 3, 2, 1, 1, 2 }, { 2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 1, 0 }, { 2, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1, 0 }, { 2, 1, 1, 2, 1, 2, 4, 1, 2, 2, 1, 2, 1 }, { 2, 1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 0 },
				// 1981
				{ 1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2, 2, 0 }, { 2, 1, 2, 1, 3, 2, 1, 1, 2, 2, 1, 2, 2 }, { 2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 0 }, { 2, 1, 2, 2, 1, 1, 2, 1, 1, 2, 3, 2, 2 }, { 1, 2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 0 }, { 1, 2, 2, 1, 2, 2, 1, 2, 1, 2, 1, 1, 0 }, { 2, 1, 2, 2, 1, 2, 3, 2, 2, 1, 2, 1, 2 }, { 1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1, 0 }, { 2, 1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 0 }, { 1, 2, 1, 1, 2, 3, 1, 2, 1, 2, 2, 2, 2 },
				// 1991
				{ 1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 0 }, { 1, 2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 0 }, { 1, 2, 2, 3, 2, 1, 2, 1, 1, 2, 1, 2, 1 }, { 2, 2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 0 }, { 1, 2, 2, 1, 2, 2, 1, 2, 3, 2, 1, 1, 2 }, { 1, 2, 1, 2, 2, 1, 2, 1, 2, 2, 1, 2, 0 }, { 1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1, 0 }, { 2, 1, 1, 2, 1, 3, 2, 2, 1, 2, 2, 2, 1 }, { 2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 1, 0 }, { 2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 1, 0 },
				// 2001
				{ 2, 2, 2, 1, 3, 2, 1, 1, 2, 1, 2, 1, 2 }, { 2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 0 }, { 2, 2, 1, 2, 2, 1, 2, 1, 1, 2, 1, 2, 0 }, { 1, 2, 3, 2, 2, 1, 2, 1, 2, 2, 1, 1, 2 }, { 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1, 2, 0 }, { 1, 1, 2, 1, 2, 1, 2, 3, 2, 2, 1, 2, 2 }, { 1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 1, 2, 0 }, { 2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 1, 2, 0 }, { 2, 2, 1, 1, 2, 3, 1, 2, 1, 2, 1, 2, 2 }, { 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 0 },
				// 2011
				{ 2, 1, 2, 2, 1, 2, 1, 1, 2, 1, 2, 1, 0 }, { 2, 1, 2, 4, 2, 1, 2, 1, 1, 2, 1, 2, 1 }, { 2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 0 }, { 1, 2, 1, 2, 1, 2, 1, 2, 2, 3, 2, 1, 2 }, { 1, 2, 1, 1, 2, 1, 2, 2, 2, 1, 2, 2, 0 }, { 1, 1, 2, 1, 1, 2, 1, 2, 2, 1, 2, 2, 0 }, { 2, 1, 1, 2, 1, 3, 2, 1, 2, 1, 2, 2, 2 }, { 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 0 }, { 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 0 }, { 2, 1, 2, 2, 3, 2, 1, 1, 2, 1, 2, 1, 2 },
				// 2021
				{ 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 0 }, { 2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 0 }, { 1, 2, 3, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2 }, { 1, 2, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1, 0 }, { 2, 1, 2, 1, 1, 2, 3, 2, 1, 2, 2, 2, 1 }, { 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 0 }, { 1, 2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 2, 0 }, { 1, 2, 2, 1, 2, 3, 1, 2, 1, 1, 2, 2, 1 }, { 2, 2, 1, 2, 2, 1, 1, 2, 1, 1, 2, 2, 0 }, { 1, 2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 0 },
				// 2031
				{ 2, 1, 2, 3, 2, 1, 2, 2, 1, 2, 1, 2, 1 }, { 2, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1, 2, 0 }, { 1, 2, 1, 1, 2, 1, 2, 3, 2, 2, 2, 1, 2 }, { 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1, 0 }, { 2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2, 0 }, { 2, 2, 1, 2, 1, 1, 4, 1, 1, 2, 1, 2, 2 }, { 2, 2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 0 }, { 2, 2, 1, 2, 1, 2, 1, 2, 1, 1, 2, 1, 0 }, { 2, 2, 1, 2, 2, 3, 2, 1, 2, 1, 2, 1, 1 }, { 2, 1, 2, 2, 1, 2, 2, 1, 2, 1, 2, 1, 0 },
				// 2041
				{ 2, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1, 2, 0 }, { 1, 2, 3, 1, 2, 1, 2, 1, 2, 2, 2, 1, 2 }, { 1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2, 2, 0 } };

		int lunarMonthDay[] = { 31, 0, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
		boolean leap;
		int year, month, date;
		year = Integer.parseInt(solarDate.substring(0, 4));
		month = Integer.parseInt(solarDate.substring(4, 6));
		date = Integer.parseInt(solarDate.substring(6));
		try {
			int[] dt = new int[163];
			int td1, td2, k11, td, td0, t1, t2, jcount, m2, m1, m0, w, ti1, tj1;
			for (int i = 0; i < matchTable.length; i++) {
				dt[i] = 0;
				for (int j = 0; j < 12; j++) {
					if (matchTable[i][j] % 2 == 1) {
						dt[i] += 29;
					} else {
						dt[i] += 30;
					}
				}
				if (matchTable[i][12] == 0) {
					dt[i] += 0;
				} else if ((matchTable[i][12] % 2) == 1) {
					dt[i] += 29;
				} else {
					dt[i] += 30;
				}
			}

			td1 = 1880 * 365 + (int) ((double) 1880 / (double) 4) - (int) ((double) 1880 / (double) 100) + (int) ((double) 1880 / (double) 400) + 30;
			k11 = year - 1;
			td2 = k11 * 365 + (int) ((double) k11 / (double) 4) - (int) ((double) k11 / (double) 100) + (int) ((double) k11 / (double) 400);

			if ((year % 400 == 0) || (year % 100 != 0) & (year % 4 == 0)) {
				lunarMonthDay[1] = 29;
			} else {
				lunarMonthDay[1] = 28;
			}

			for (int i = 0; i < month - 1; i++) {
				td2 += lunarMonthDay[i];
			}

			td2 += date;
			td = td2 - td1 + 1;
			td0 = dt[0];
			t1 = 0;
			for (t1 = 0; t1 < 163; t1++) {
				if (td <= td0) {
					break;
				}
				td0 += dt[t1 + 1];
			}

			lunarYear = t1 + 1881;

			td0 -= dt[t1];
			td -= td0;
			jcount = 12;

			if (matchTable[t1][12] != 0) {
				jcount = 13;
			}

			m2 = 0;
			t2 = 0;
			for (t2 = 0; t2 < jcount; t2++) {
				if (matchTable[t1][t2] <= 2) {
					m2++;
					m1 = matchTable[t1][t2] + 28;
				} else {
					m1 = matchTable[t1][t2] + 26;
				}
				if (td <= m1) {
					break;
				}
				td -= m1;
			}
			m0 = t2;
			lunarMonth = m2;
			lunarDate = td;
			w = td2 % 7;
			t1 = (int) ((td2 + 4) % 10);
			t2 = (int) ((td2 + 2) % 12);
			ti1 = (lunarYear + 6) % 10;
			tj1 = (lunarYear + 8) % 12;

			if (matchTable[lunarYear - 1881][12] > 2 & matchTable[lunarYear - 1881][m0] > 2) {
				leap = true;
			}
			lunaryy = String.valueOf(lunarYear);
			lunarmm = String.valueOf(lunarMonth);
			lunardd = String.valueOf(lunarDate);
			if (lunarmm.length() < 2)
				lunarmm = "0" + lunarmm;
			if (lunardd.length() < 2)
				lunardd = "0" + lunardd;
			// LLog.info.println("*****"+lunaryy + ":"+lunarmm + ":"+ lunardd);
		} catch (Exception e) {
			LLog.info.println("***lunarCalendar :" + e);
		}
		return lunaryy + lunarmm + lunardd;
	}

	// ������ üũ�Ͽ� ���̸� "0" ���� (request.getParameter�� ����ϸ� �t�)
	public String nullToDecimal(double value) {
		if (value == 0.0)
			return "0";
		else
			return String.valueOf(new java.math.BigDecimal(value));
	}

	// ������ üũ�Ͽ� ���̸� "0" ���� (request.getParameter�� ����ϸ� �t�)
	public String nullToDecimal(String str) {
		if (str == null || str.equals(""))
			return "0";
		else
			return str;

	}

	// ������ üũ�Ͽ� ���̸� "0" ���� (request.getParameter�� ����ϸ� �t�)
	public String nullToDecimal(java.math.BigDecimal value) {
		if (value == null)
			return "0";
		else
			return String.valueOf(value);

	}

	// ������ üũ�Ͽ� ���̸� ""���� (request.getParameter�� ����ϸ� �t�)
	public String nullToString(String str) {
		if (str == null)
			return "";
		else
			return str;

	}

	public String nullToNA(String str) {
		if (str == null)
			return "N/A";
		else
			return str;
	}

	public String nullToN(String str) {
		if (str == null)
			return "N";
		else
			return str;
	}

	public String removeChar(String str, String deli) {

		String result = "";

		if (str == null || str.equals(""))
			return result;

		if (!str.equals("")) {
			StringTokenizer st = new StringTokenizer(str, deli);
			StringBuffer buffer = new StringBuffer();
			for (; st.hasMoreTokens(); buffer.append(st.nextToken()))
				;
			result = buffer.toString();
		}

		return result;

	}

	/**
	 * ���ڿ� ���� Ưd�� ���ڿ�; ��� ��d�� �ٸ� ���ڿ��� �ٲ۴�. �� String �� null ��
	 * ��쿡�� null ; ��ȯ�Ѵ�. StringBuffer �� �̿��Ͽ�8�Ƿ� ������ String ; �̿��� ��
	 * ���� ����� �ӵ��� ���. (�� 50 ~ 60 ��)
	 * 
	 * ��� ��: <BR>
	 * 
	 * 1. �Խ��ǿ��� HTML �±װ� �� ����� �ҷx�
	 * 
	 * String str = "
	 * <TD>HTML Tag Free Test</TD>"; str = replace(str, "&", "&amp;"); str =
	 * replace(str, "<", "&lt;");
	 * 
	 * 2. ' �� ���ѵ� ��; DB �� ��;�x�
	 * 
	 * String str2 = "I don't know."; str2 = replace(str2, "'", "''");
	 * 
	 * @param String
	 *            src �� String
	 * @param String
	 *            oldstr �� String ���� �ٲٱ� �� ���ڿ�
	 * @param String
	 *            newstr �ٲ� �� ���ڿ�
	 * @return String ġȯ�� ���� ���ڿ�
	 * 
	 * @date 2003/07/25
	 * @author ��ö��
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

	/**
	 * DESC : Blank ��� &nbsp;�� ��ȯ
	 */
	public String replaceString(String str) {
		StringBuffer buf = new StringBuffer();
		/* 2007.10.01 ��d : str.length() -1 => str.length() */
		for (int i = 0; i < str.length(); i++) {
			if (str.charAt(i) != ' ') {
				buf.append(str.charAt(i));
			} else {
				buf.append("&nbsp;");
			}
		}
		return buf.toString();
	}

	/**
	 * DESC : �ø��� ����ϰ� �Ҽ�a ���� �ڸ��� �����.
	 */
	public String roundBigDec(double value, int seq) {
		double upvalue = 0; // �ø���

		if (seq == 0)
			upvalue = 0.5;
		else if (seq == 1)
			upvalue = 0.05;
		else if (seq == 2)
			upvalue = 0.005;
		else if (seq == 3)
			upvalue = 0.0005;
		else if (seq == 4)
			upvalue = 0.00005;
		else if (seq == 5)
			upvalue = 0.000005;
		else if (seq == 6)
			upvalue = 0.0000005;
		else
			upvalue = 0;
		// ---
		java.math.BigDecimal newValue = null;
		if (value < 0)
			newValue = new java.math.BigDecimal(value - upvalue);
		else
			newValue = new java.math.BigDecimal(value + upvalue);
		// ---
		String result = String.valueOf(newValue);
		int pos = result.indexOf(".");

		if (pos < 0)
			return result;
		else if (seq == 0) {
			result = result.substring(0, pos + seq);
		} else {
			result = result.substring(0, pos + seq + 1);
		}

		return result;
	}

	/**
	 * DESC : ������Ŀ� �޸�(,) ����ֱ� ( ��. 123456.78 -> 123,456.78 )
	 */
	public String setComma(double number, boolean flag, int seq) {
		return setComma((flag) ? setFloor(number, seq) : String.valueOf(number));
	}

	/**
	 * DESC : ������Ŀ� �޸�(,) ����ֱ� ( ��. 123456.78 -> 123,456.78 )
	 */
	public String setComma(String number) {
		String result = "";
		String tail = "";
		boolean flag = false;

		if (number.equals(""))
			return result;
		int pts = number.indexOf(".");
		if (pts > 0) {
			tail = number.substring(pts);
			number = number.substring(0, pts);
		}

		if (Long.parseLong(number) < 0) {
			number = String.valueOf(Long.parseLong(number) * (-1));
			flag = true;
		}
		int len = number.length();
		if (!number.equals("")) {
			StringBuffer buffer = new StringBuffer(number);
			for (int i = len - 3; i > 0; i -= 3)
				buffer.insert(i, ',');
			if (pts > 0)
				result = buffer.toString() + tail;
			else
				result = buffer.toString();
			if (flag)
				result = "-" + result;
		}

		return result;
	}

	/**
	 * DESC : ������Ŀ� �޸�(,) ����ֱ� ( ��. 123456.78 -> 123,456.78 ) flag :
	 */
	public String setComma(String number, boolean flag, int seq) {

		return setComma((flag) ? setFloor(number, seq) : number);
	}

	public String setCommaDouble(double number) {
		return setComma(number + "");
	}

	public String setCommaFloat(String number) {
		String result = "";
		String tail = "";
		boolean flag = false;
		if (number.equals(""))
			return result;
		int pts = number.indexOf(".");

		if (pts > 0) {
			tail = number.substring(pts);
			number = number.substring(0, pts);
		}

		if (Long.parseLong(number) < 0) {
			number = String.valueOf(Long.parseLong(number) * (-1));
			flag = true;
		}

		int len = number.length();
		if (!number.equals("")) {
			StringBuffer buffer = new StringBuffer(number);
			for (int i = len - 3; i > 0; i -= 3)
				buffer.insert(i, ',');
			if (pts > 0)
				result = buffer.toString() + tail;
			else
				result = buffer.toString();
			if (flag)
				result = "-" + result;
		}

		return result;
	}

	public String setCommaFloat(String number, int Length) {
		String result = "";
		String tail = "";
		boolean flag = false;
		if (number.equals(""))
			return result;
		int pts = number.indexOf(".");

		if (pts > 0) {
			tail = number.substring(pts);
			number = number.substring(0, pts);
		}

		if (Long.parseLong(number) < 0) {
			number = String.valueOf(Long.parseLong(number) * (-1));
			flag = true;
		}

		int len = number.length();
		if (!number.equals("")) {
			StringBuffer buffer = new StringBuffer(number);
			for (int i = len - 3; i > 0; i -= 3)
				buffer.insert(i, ',');
			if (pts > 0)
				result = buffer.toString() + tail;
			else
				result = buffer.toString();
			if (flag)
				result = "-" + result;

		}

		if (Length > 0) {
			result += ".";
			for (int i = 0; i < Length; i++) {
				result += "0";
			}

		}

		return result;
	}

	public String setCommaInt(int number) {
		return setComma(number + "");
	}

	public String setCommaLong(long number) {
		return setComma(number + "");
	}

	public String setFloor(double value) {

		return setFloor(String.valueOf(value));
	}

	public String setFloor(double value, int seq) {

		return setFloor(roundBigDec(value, seq));
	}

	public String setFloor(String str) {

		int pos = 0;
		String buf = "";
		String temp = "";
		if (str.equals("") || str.toString() == null)
			return "";

		pos = str.indexOf(".");

		if (pos < 0)
			return str;

		buf = str.substring(pos + 1, str.length());

		int i = 0;

		for (i = buf.length(); i > 0; i--) {
			if (buf.charAt(i - 1) != '0')
				break;
		}

		if (i > 0)
			buf = buf.substring(0, i);
		long lvalue = Long.parseLong(buf);
		if (lvalue > 0)
			temp = "." + buf;
		return str.substring(0, pos) + temp;
	}

	public String setFloor(String value, int seq) {

		return setFloor(roundBigDec(Double.valueOf(value).doubleValue(), seq));
	}

	/*
	 * Desc : ���2 �Ҽ� 2° �ڸ����� ����.
	 */
	public String setPercent(double arg1, double arg2) {

		double arg3 = 0;

		if (arg1 != 0)
			arg3 = ((arg2 - arg1) / arg1) * 100;
		else
			arg3 = 0;

		return roundBigDec(arg3, 2);
	}

	/*
	 * Desc : ���2 �Ҽ� seq° �ڸ����� ����.
	 */
	public String setPercent(double arg1, double arg2, int seq) {

		double arg3 = 0;

		if (arg1 != 0)
			arg3 = ((arg2 - arg1) / arg1) * 100;
		else
			arg3 = 0;

		return roundBigDec(arg3, seq);
	}

	/*
	 * Desc : ���2 �Ҽ� 2° �ڸ����� ����.
	 */
	public String setPercent1(double arg1, double arg2) {

		double arg3 = 0;

		if (arg1 != 0)
			arg3 = (arg2 / arg1) * 100;
		else
			arg3 = 0;

		return roundBigDec(arg3, 2);
	}

	/*
	 * Desc : ���2 �Ҽ� seq° �ڸ����� ����.
	 */
	public String setPercent1(double arg1, double arg2, int seq) {

		double arg3 = 0;

		if (arg1 != 0)
			arg3 = (arg2 / arg1) * 100;
		else
			arg3 = 0;

		return roundBigDec(arg3, seq);
	}

	public String toEng(String s) {
		s = s.trim();
		try {
			if (s != null)
				return (new String(s.getBytes("KSC5601"), "8859_1"));
			return s;
		} catch (UnsupportedEncodingException e) {
			return "Encoding Error";
		}
	}

	/*
	 * Webg030d.jsp ���̺�col�� ����CHECK 0 �� ����.
	 */

	public String toHide(String strDate, int val) {
		if (!strDate.equals("")) {
			return setCommaInt(val);
		} else {
			return "";
		}
	}

	/*
	 * Webg030d.jsp ���̺�col�� ����CHECK 0 �� ����.
	 */
	public String toHide(String strDate, String val) {
		if (!strDate.equals("")) {
			return val;
		} else {
			return "";
		}
	}

	public String toKSC5601(String s) {
		s = s.trim();
		try {
			if (s != null)
				return (new String(s.getBytes("8859_1"), "KSC5601"));
			return s;

		} catch (UnsupportedEncodingException e) {
			return "Encoding Error";
		}
	}

	/*
	 * Desc : ���� ���� '0'�̸�ȭ�鿡 Display���� �ʱ� '��...
	 */
	public String zeroHide(String arg1) {

		String retValue = "";

		if (arg1.equals("0") || arg1.equals("0.0") || arg1.equals("0.00"))
			retValue = "";
		else
			retValue = arg1;

		return retValue;
	}

	/*
	 * 
	 * @�γ��� ������ �ð�; ����Ͽ� long type�� �� ��'�� �����Ѵ�. @begin input type
	 * Timestamp ���۳�¥ @end input type Timestamp ~�ᳯ�� @return java.lang.Long
	 */

	public long diffOfMinutes(Timestamp begin, Timestamp end) {
		return (end.getTime() - begin.getTime()) / (1000);
	}

	/*
	 * 
	 * @�γ��� ������ �ð�; ����Ͽ� long type�� �� ��'�� �����Ѵ�. @begin input type
	 * String ���۳�¥ @end input type String ~�ᳯ�� @dateTextType datetype
	 * ��)yyyymmdd , yyyy-MM-dd HH:mm:ss @return java.lang.Long
	 */

	public long diffOfMinutes(String begin, String end, String dateTextType) throws Exception {
		SimpleDateFormat formatter = new SimpleDateFormat(dateTextType);
		Date beginDate = formatter.parse(begin);
		Date endDate = formatter.parse(end);
		// LLog.info.println(endDate.getTime());
		// LLog.info.println(beginDate.getTime());
		return (endDate.getTime() - beginDate.getTime()) / (1000);
	}

	// ä���� �ʿ��� ���̺��, �ڸ��� �Է��ϸ� �ڵ� ä���� �ȴ�.
	// _tableName : ä��; �� ���̺�� , _numLength : �ʿ��� ����

	/*
	 * 
	 * @�Էµ� ���ڿ��� ���̸� ���� �Ѵ�. @return int
	 */

	public static int getTextLength(String in_Str) {

		if (in_Str == null)
			return 0;
		byte[] byteStr = in_Str.getBytes();

		return byteStr.length;
	}

	/*
	 * 2008.04/28 �ں��� @�Էµ� ���ڿ��� ���̸� ���� �Ѵ�. @�ѱ�: 2byte��� �Ͽ�
	 * �����Ѵ�. @byte type8�� ��=8�� �ѱ�2,�׿� 1 ... @return int
	 */
	public static int getTextLengthKor2(String in_Str) {
		if (in_Str == null)
			return 0;
		int strlen = 0;
		for (int j = 0; j < in_Str.length(); j++) {
			char c = in_Str.charAt(j);
			if (c < 0xac00 || 0xd7a3 < c) {
				strlen++;
			} else
				strlen += 2; // �ѱ�
		}
		return strlen;
	}

	/*
	 * 2008.04/28 �ں��� @�Էµ� ���ڿ�; ����8�� �Էµ� ������ ��ŭ String; �߶�
	 * �����Ѵ�. @�ѱ� 2byte�� ����Ͽ� ���� @return int @param in_Str : �Է¹޴� ���ڿ�
	 * @param in_len : ���ϵɹ��ڿ� length
	 */
	public static String getCutText(String in_Str, int in_len) {
		int strlen = 0;
		String retStr = "";
		if (in_Str == null)
			return "";
		for (int j = 0; j < in_Str.length(); j++) {
			char c = in_Str.charAt(j);
			if (c < 0xac00 || 0xd7a3 < c) {
				if (j == in_len)
					break;
				strlen++;
				retStr = retStr + c;
			} else if (j == in_len)
				break;
			strlen += 2; // �ѱ�
			retStr = retStr + c;
		}
		return retStr;
	}

	/**
	 * 2008.11.07 String ���� ���ĺ��� ���ԵǾ� �ִ��� �˻� �� ���°�(boolean);
	 * �����Ѵ�. by �̴��
	 * 
	 * @param cust_nm
	 * @return
	 */
	public static boolean alphabet_check(String cust_nm) {

		boolean state = true;

		int length = cust_nm.length();

		for (int i = 0; i < length; i++) {
			char ch = cust_nm.charAt(i);

			if ((ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z')) {
				state = false;
			}
		}
		return state;
	}
}