/*
 *------------------------------------------------------------------------------
 * PurchOrderHistoryBiz.java,v 1.0 2010/08/19 17:30:35 
 * 
 * PROJ : PT-PAM
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2011/02/09   kangsoo   Init
 *----------------------------------------------------------------------------
 */

package po.oc.biz;
import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LBizException;
import devon.core.exception.LException;
import devon.core.log.LLog;
import devonframework.persistent.autodao.LCommonDao;



/**
 * <PRE>
 * P/O RegsiTration 업무를 처리하는 Biz 클래스.
 *
 * Database Tables : 
 * </PRE>
 * @author    CEH
 */
public class PurchOrderHistoryBiz {

	  /**
	 * P/O 입력현황 history 조회
	 * @param inputData 검색조건 입력 값
	 * @return  Stock movet Histroy 목록 조회
	 * @throws LException
	 */
	public LMultiData retrievePurchOrderHistoryList(LData inputData) throws LException {

		LMultiData resultData = null;
    try {
    	LCommonDao dao = new LCommonDao( "/po/oc/purchOrderHistorySql/retrievePurchOrderHistoryList",inputData );
    	resultData = dao.executeQuery();
    	
    } catch (Exception le ) {
    	LLog.err.write(this.getClass().getName()+"." +"retrievePurchOrderHistoryList()"+"=>"+le.getMessage());
        throw new LBizException("po.is.cmd.retrieve");
    }
    return resultData;
	} 
   
	
}
 
