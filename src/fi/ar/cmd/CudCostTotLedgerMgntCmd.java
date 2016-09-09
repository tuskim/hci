/*
 *------------------------------------------------------------------------------
 * CudCostTotLedgerMgntCmd.java,v 1.0 2010/08/03 16:43:35 
 * 
 * PROJ : PT-PAM System.
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2010/08/03   mskim   Init
 *----------------------------------------------------------------------------
 */

package fi.ar.cmd;

import fi.ar.biz.CostTotLedgerMgntBiz;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gauce.GauceDataSet;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import comm.util.LXssCollectionUtility;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LException;
import devon.core.log.LLog;
import devonframework.bridge.gauce.util.LGauceConverter;
import devonframework.bridge.gauce.command.LGauceCommandIF;

/**
 * <PRE>
 * 
 * 
 * </PRE>
 * 
 * @author    ceh
 * @see       
 */
public class CudCostTotLedgerMgntCmd implements LGauceCommandIF {
    /**
     * 
     *
     * @param req Http Request 객체.
     * @param res Http Response 객체.
     * @param gauceRequest 가우스 Request 객체.
     * @param gauceResponse 가우스 Response 객체.
     * @exception LException Commnad 단 이하의 모든 에러.
     */
	public void execute(HttpServletRequest req, HttpServletResponse res, 
            GauceRequest gauceRequest, GauceResponse gauceResponse) throws LException {
		
		LLog.debug.write("CudCostTotLedgerMgntCmd ------------ START");

		GauceDataSet mstDataGds = gauceRequest.getGauceDataSet("IN_DS1");

		GauceDataSet dtlDataGds = gauceRequest.getGauceDataSet("IN_DS2");
		
		GauceDataSet bargeDataGds = gauceRequest.getGauceDataSet("IN_DS3");

		LData inputData = LXssCollectionUtility.getData(req);
		
		LData resultData = new LData();
		
		long   getErrorCode = 0 ;
        String getMessage   = "";
		
		if(mstDataGds == null && dtlDataGds == null) return;
  
		//-------------------------------------- Session 종료시 처리 START
	    HttpSession session = req.getSession(false);
	    LData loginUser = new LData();
	    
	    if (session != null) loginUser = (LData)session.getAttribute("loginUser");
	    if( loginUser.getString("userId") == null) {
	    	getMessage = "Session is Terminated. You need to relogin!";
	    	gauceResponse.writeException("Error","", getMessage);
	    	return;
	    }
	    //-------------------------------------- Session 종료시 처리 END
		
		LMultiData mMstData = LGauceConverter.convertToLMultiDataWithJobType(mstDataGds);
		LLog.debug.write("CudCostTotLedgerMgntCmd1 mMstData ---------------> =>\n " + mMstData.toString());

		LMultiData mDtlData = LGauceConverter.convertToLMultiDataWithJobType(dtlDataGds);
		LLog.debug.write("CudCostTotLedgerMgntCmd1 mDtlData ---------------> =>\n " + mDtlData.toString());

		LMultiData mBargeData = LGauceConverter.convertToLMultiDataWithJobType(bargeDataGds);
		LLog.debug.write("CudCostTotLedgerMgntCmd1 mBargeData ---------------> =>\n " + mBargeData.toString());
		
		//String docYm = inputData.getString("docDate").substring(0, 6);
		//inputData.setString("docYm", 	 docYm);
		//inputData.setString("postDate",  inputData.getString("docDate"));

		CostTotLedgerMgntBiz biz = new CostTotLedgerMgntBiz();
		resultData = biz.cudCostTotLedgerMgnt(mMstData, mDtlData, mBargeData, loginUser); 
		
		getErrorCode = resultData.getLong("getErrorCode");
		getMessage	 = resultData.getString("getMessage");

		if (getErrorCode != 0 && getErrorCode != -999999) {             
			if (getMessage == null) getMessage = "";
			gauceResponse.writeException("Error", String.valueOf(getErrorCode), "\n[Detail Msg]==>" + getMessage);
		}

		LLog.debug.write("CudCostTotLedgerMgntCmd ------------ END");
	
	}
}
