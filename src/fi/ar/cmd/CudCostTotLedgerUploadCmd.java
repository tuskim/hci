/*
 *------------------------------------------------------------------------------
 * CudCostTotLedgerUploadCmd.java,v 1.0 2010/07/23 16:43:35 
 * 
 * PROJ : PT-MGE System.
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2010/10/11   mskim   Init
 *----------------------------------------------------------------------------
 */

package fi.ar.cmd;

import fi.ar.biz.CostTotLedgerUploadBiz;

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
public class CudCostTotLedgerUploadCmd implements LGauceCommandIF {
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
		
		LLog.debug.write("CudCostTotLedgerUploadCmd ------------ START");

		GauceDataSet userGds = gauceRequest.getGauceDataSet("IN_DS1");
		LData inputData = LXssCollectionUtility.getData(req);
		//LLog.debug.write("CudCostTotLedgerUploadCmd1 inputData ---------------> =>\n " + inputData.toString());
		
		LData resultData = new LData();
		
		long   getErrorCode = 0 ;
        String getMessage   = "";
		
		if(userGds == null )
			return;

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
		
		LMultiData mData = LGauceConverter.convertToLMultiDataWithJobType(userGds);
		
		for(int i = 0; i < mData.getDataCount(); i++) {
			mData.modifyString("companyCd", i, loginUser.getString("companyCd"));
			mData.modifyString("deptCd", 	i, inputData.getString("deptCd"));
			mData.modifyString("createDate",i, inputData.getString("createDate"));
		}

		CostTotLedgerUploadBiz biz = new CostTotLedgerUploadBiz();
		resultData = biz.cudCostTotUpload(mData, loginUser); 
		 
		getErrorCode = resultData.getLong("getErrorCode");
		getMessage	 = resultData.getString("getMessage");

		if (getErrorCode != 0 && getErrorCode != -999999) {             
			if (getMessage == null) getMessage = "";
			gauceResponse.writeException("Error", String.valueOf(getErrorCode), "\n[Detail Msg]==>" + getMessage);
		}

		LLog.debug.write("CudCostTotLedgerUploadCmd ------------ END");
	
	}
}
