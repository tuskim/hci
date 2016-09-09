/*
 *------------------------------------------------------------------------------
 * CudSalesConfirmSapSendCmd.java,v 1.0 2010/08/27 16:43:35 
 * 
 * PROJ : PT-PAM System.
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2012/10/28      Init
 *----------------------------------------------------------------------------
 */

package sd.sf.cmd;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import sd.sf.biz.CementSalesConfirmBiz;
import sd.sm.biz.CementSalesMgntBiz;

import com.gauce.GauceDataSet;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import comm.util.LXssCollectionUtility;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LException;
import devon.core.log.LLog;
import devonframework.bridge.gauce.command.LGauceCommandIF;
import devonframework.bridge.gauce.util.LGauceConverter;

/**
 * <PRE>
 * 
 * 
 * </PRE>
 * 
 * @author    
 * @see       
 */
public class CudCementSalesSapSendCmd implements LGauceCommandIF {
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
		
		LLog.debug.write("CudCementSalesSapSendCmd ------------ START");

		GauceDataSet saleConFirmList = gauceRequest.getGauceDataSet("IN_DS1");
		
		LData inputData = LXssCollectionUtility.getData(req);
		LLog.debug.write("CudCementSalesSapSendCmd inputData ---------------> =>\n " + inputData.toString());
		
		LData resultData = new LData();
	
		
		if(saleConFirmList == null )	return;
		
		//-------------------------------------- Session 종료시 처리 START
	    HttpSession session = req.getSession(false);
	    LData loginUser = new LData();
	    
	    if (session != null) loginUser = (LData)session.getAttribute("loginUser");
	    if( loginUser.getString("userId") == null) {
	    	String getMessage = "Session is Terminated. You need to relogin!";
	    	gauceResponse.writeException("Error","", getMessage);
	    	return;
	    }
	    //-------------------------------------- Session 종료시 처리 END

		LMultiData mData = LGauceConverter.convertToLMultiDataWithJobType(saleConFirmList);
		LLog.debug.write("CudCementSalesSapSendCmd HEADER 자료~~~~ ---------------> =>\n " + mData.toString());


		CementSalesConfirmBiz biz = new CementSalesConfirmBiz();
		resultData = biz.CudCementSalesSapSend(mData, loginUser);
		
		int returnStatus = resultData.getInt("returnStatus");
		String returnMsg = resultData.getString("returnMsg");
		String returnSapSeq = resultData.getString("returnSapSeq");

		
		if (returnStatus != 0 ) {        	
			if (returnStatus == 98765 ) {             
				gauceResponse.writeException("Error",99, returnMsg);
				return;
			}else{
			if (returnMsg == null) returnMsg = "";
			gauceResponse.writeException("Error", String.valueOf(returnStatus), "\n[Detail Msg]==>" + returnMsg);
			}
		}
	
		LLog.debug.write("CudCementSalesSapSendCmd ------------ END");
	
	}
}


