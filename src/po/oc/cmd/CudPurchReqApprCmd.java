/*
 *------------------------------------------------------------------------------
 * CudPurchReqApprCmd.java,v 1.0 2010/08/03 16:43:35 
 * 
 * PROJ : PT-PAM System.
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2010/08/20   mskim   Init
 *----------------------------------------------------------------------------
 */

package po.oc.cmd;

import po.oc.biz.PurchReqApprBiz;

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
public class CudPurchReqApprCmd implements LGauceCommandIF {
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
		
		LLog.debug.write("CudPurchReqApprCmd ------------ START");

		GauceDataSet purchDtlGds = gauceRequest.getGauceDataSet("IN_DS1");

		LData inputData = LXssCollectionUtility.getData(req);
		
		LData resultData = new LData();
		
		long   getErrorCode = 0 ;
        String getMessage   = "";
		
		if(purchDtlGds == null ) return;

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
		
		LMultiData mDtlData = LGauceConverter.convertToLMultiDataWithJobType(purchDtlGds);
		LLog.debug.write("CudPurchReqApprCmd1 inputData ---------------> =>\n " + mDtlData.toString());

		PurchReqApprBiz biz = new PurchReqApprBiz();
		resultData = biz.cudPurchReqAppr(inputData, mDtlData, loginUser);
		
		getErrorCode = resultData.getLong("getErrorCode");
		getMessage	 = resultData.getString("getMessage");

		if (getErrorCode != 0 && getErrorCode != -999999) {             
			if (getMessage == null) getMessage = "";
			gauceResponse.writeException("Error", String.valueOf(getErrorCode), "\n[Detail Msg]==>" + getMessage);
		}

		LLog.debug.write("CudPurchReqApprCmd ------------ END");
	
	}
}
