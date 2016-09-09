/*
 *------------------------------------------------------------------------------
 * ConDocHistoryBiz.java,v 1.0 2010/10/06 16:43:35 
 * 
 * PROJ : PT-PAM
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2011/03/21  강수연   Init
 *----------------------------------------------------------------------------
 */

package fi.ar.biz;
import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LBizException;
import devon.core.exception.LException;
import devon.core.log.LLog;
import devonframework.persistent.autodao.LCommonDao;

/**
 * <PRE>
 * Document history List 업무를 처리하는 Biz 클래스.
 *
 * Database Tables : 
 * </PRE>
 * @author    CEH
 */
public class ConDocHistoryBiz {

 
	/**
	 * 품의서  Histroy 조회
	 * @param inputData 검색조건 입력 값
	 * @return Document Histroy 목록 조회
	 * @throws LException
	 */
	public LMultiData retrieveConDocHistory (LData inputData) throws LException {

		LMultiData resultData = null;
        try {
        	LCommonDao dao = new LCommonDao( "/fi/ar/conDocHistorySql/retrieveConDocHistory",inputData );
        	resultData = dao.executeQuery();
        	
        } catch (Exception le ) {
        	LLog.err.write(this.getClass().getName()+"." +"retrieveConDocHistory()"+"=>"+le.getMessage());
            throw new LBizException("fi.ar.cmd.retrieve");
        }
        return resultData;
	}
	  

}
