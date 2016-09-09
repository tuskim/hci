/*
 *------------------------------------------------------------------------------
 * RetrieveCurrentStockRFC.java,v 1.0 2010/08/06 14:43:35 
 * 
 * PROJ : PT-PAM 
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2010/08/06   hskim   Init
 *----------------------------------------------------------------------------
 */

package rfc.biz;

import comm.util.SAPWrap;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LBizException;
import devon.core.exception.LException;
import devon.core.log.LLog;
import devonframework.persistent.autodao.LCommonDao;

/**
 * UXPCardCancelRFC
 */
public class PurchaseHistoryBiz extends SAPWrap {


	  /**
	 * Stock Issue history 조회
	 * @param inputData 검색조건 입력 값
	 * @return  Stock movet Histroy 목록 조회
	 * @throws LException
	 */
	public LMultiData retrieveStockIssueHistoryList(LData inputData) throws LException {

		LMultiData resultData = null;
        try {
        	LCommonDao dao = new LCommonDao( "/po/is/stockHistorySql/retrieveStockIssueHistoryList",inputData );
        	resultData = dao.executeQuery();
        	
        } catch (Exception le ) {
        	LLog.err.write(this.getClass().getName()+"." +"retrieveStockIssueHistoryList()"+"=>"+le.getMessage());
            throw new LBizException("po.is.cmd.retrieve");
        }
        return resultData;
	} 
	
	
	   /**
	 * Invoice history 조회
	 * @param inputData 검색조건 입력 값
	 * @return Invoice Histroy 목록 조회
	 * @throws LException
	 */
	public LMultiData retrieveInvoiceHistoryList(LData inputData) throws LException {

		LMultiData resultData = null;
        try {
        	LCommonDao dao = new LCommonDao( "/po/is/stockHistorySql/retrieveInvoiceHistoryList",inputData );
        	resultData = dao.executeQuery();
        	
        } catch (Exception le ) {
        	LLog.err.write(this.getClass().getName()+"." +"retrieveStockMoveHistoryList()"+"=>"+le.getMessage());
            throw new LBizException("po.is.cmd.retrieve");
        }
        return resultData;
	} 
    
	
 }