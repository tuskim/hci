/*
 *------------------------------------------------------------------------------
 * CudProductionApprovalStatusCmd.java,v 1.0 2010/08/03 16:43:35 
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

package ps.dp.cmd;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ps.dp.biz.ProductionApprovalBiz;

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
 * @author    ceh
 * @see       
 */
public class CudProductionApprovalStatusCmd implements LGauceCommandIF {
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
		
		LLog.debug.write("CudProductionApprovalStatusCmd ------------ START");
		
		

		long   getErrorCode = 0 ;
        String getMessage   = "";

        /////////////////////////////////////////////////////////////////////////////////
        // 세션체크
	    HttpSession session = req.getSession(false);
	    LData loginUser = new LData();
	    
	    if (session != null) loginUser = (LData)session.getAttribute("loginUser");
	    if( loginUser.getString("userId") == null) {
	    	getMessage = "Session is Terminated. You need to relogin!";
	    	gauceResponse.writeException("Error","", getMessage);
	    	return;
	    }
        /////////////////////////////////////////////////////////////////////////////////

	    
        /////////////////////////////////////////////////////////////////////////////////
        // 데이터체크
		LMultiData lmdProd01   = LGauceConverter.convertToLMultiDataWithJobType(gauceRequest.getGauceDataSet("ds_prod01"));
		LLog.debug.write("CudProductionApprovalCmd lmdProd01 ---------------> =>\n " + lmdProd01);

		LMultiData lmdProd02   = LGauceConverter.convertToLMultiDataWithJobType(gauceRequest.getGauceDataSet("ds_prod02"));
		LLog.debug.write("CudProductionApprovalCmd lmdProd02 ---------------> =>\n " + lmdProd02);
		
		LMultiData lmdProd03   = LGauceConverter.convertToLMultiDataWithJobType(gauceRequest.getGauceDataSet("ds_prod03"));
		LLog.debug.write("CudProductionApprovalCmd lmdProd03 ---------------> =>\n " + lmdProd03);
		
		LMultiData lmdProd04   = LGauceConverter.convertToLMultiDataWithJobType(gauceRequest.getGauceDataSet("ds_prod04"));
		LLog.debug.write("CudProductionApprovalCmd lmdProd04 ---------------> =>\n " + lmdProd04);
		
		LMultiData lmdProd05   = LGauceConverter.convertToLMultiDataWithJobType(gauceRequest.getGauceDataSet("ds_prod05"));
		LLog.debug.write("CudProductionApprovalCmd lmdProd05 ---------------> =>\n " + lmdProd05);
        /////////////////////////////////////////////////////////////////////////////////

		

        /////////////////////////////////////////////////////////////////////////////////
        // 비즈호출
		LData inputData = LXssCollectionUtility.getData(req); // 파라메터
		LData resultData = new LData();

		ProductionApprovalBiz biz = new ProductionApprovalBiz();
		resultData = biz.cudProductionApprovalStatus(lmdProd01, lmdProd02, lmdProd03, lmdProd04, lmdProd05, loginUser);
		
		getErrorCode = resultData.getLong("getErrorCode");
		getMessage	 = resultData.getString("getMessage");

		if (getErrorCode != 0 && getErrorCode != -999999) {             
			if (getMessage == null) getMessage = "";
			gauceResponse.writeException("Error", String.valueOf(getErrorCode), "\n[Detail Msg]==>" + getMessage);
		}
        /////////////////////////////////////////////////////////////////////////////////


		LLog.debug.write("CudProductionApprovalStatusCmd ------------ END");
	
	}
}
