/*
 *------------------------------------------------------------------------------
 * DailyProductionReportBiz.java,v 1.0 2010/08/19 17:30:35 
 * 
 * PROJ : PT-PAM
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2010/08/19   mskim   Init
 *----------------------------------------------------------------------------
 */

package ps.dp.biz;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LException;
import devon.core.exception.LSysException;
import devon.core.log.LLog;
import devonframework.persistent.autodao.LCommonDao;

/**
 * <PRE>
 * Daily Production Report 업무를 처리하는 Biz 클래스.
 * 
 * Database Tables :
 * </PRE>
 * 
 * @author CEH
 */
public class DailyProductionReportBiz {

	/**
	 * Daily Production Report 정보를 조회하는 메소드.
	 * 
	 * @param inputData
	 *            Command로 부턴 전달받은 input LDataProtocol
	 * 
	 * @return LMultiData 조회된 리스트 결과.
	 * @exception LException
	 *                메소드 수행시 발생한 모든 에러.
	 */
	public LMultiData retrieveDailyProductionReportMasterList(LData inputData) throws LException {

		LLog.debug.write("retrieveDailyProductionReportMasterList-----------> Start ");

		LCommonDao dao = new LCommonDao();
		try {
			return dao.executeQuery("ps/dp/dailyProductionReportSql/retrieveDailyProductionReportMasterList", inputData);
		} catch (Exception se) {
			LLog.err.println(this.getClass().getName() + "." + "retrieveDailyProductionReportMasterList------()" + "=>" + se.getMessage());
			throw new LSysException("ps.dp.retrieveDailyProductionReportMasterList", se);
		}
	}

}
