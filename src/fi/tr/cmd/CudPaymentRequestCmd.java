/*
 *------------------------------------------------------------------------------
 * CudPaymentRequestCmd.java 
 * 
 * PROJ : PT-MGE System.
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2015/12/08   hckim   Init
 *----------------------------------------------------------------------------
 */

package fi.tr.cmd;

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
import devonframework.bridge.gauce.command.LGauceCommandIF;
import devonframework.bridge.gauce.util.LGauceConverter;
import devonframework.front.channel.LNavigationAlter;
import fi.tr.biz.PaymentBiz;

public class CudPaymentRequestCmd implements LGauceCommandIF {

	/**
     * @param req Http Request 객체.
     * @param res Http Response 객체.
     * @param gauceRequest 가우스 Request 객체.
     * @param gauceResponse 가우스 Response 객체.
     * @exception LException Commnad 단 이하의 모든 에러.
     */
	public void execute(HttpServletRequest req, HttpServletResponse res, 
            GauceRequest gauceRequest, GauceResponse gauceResponse) throws LException {
		
		LLog.debug.write("CudPaymentRequestCmd --------------- START");

		GauceDataSet openApGds = gauceRequest.getGauceDataSet("IN_DS1");
		LData inputData        = LXssCollectionUtility.getData(req);
		
		LData resultData = new LData();
		
		long getErrorCode = 0 ;
        String getMessage = "";

        //-------------------------------------- Session 종료시 처리 START
  		HttpSession session = req.getSession(false);
  		LData loginUser = new LData();
  		
  		if (session != null) loginUser = (LData)session.getAttribute("loginUser");
  		if( loginUser.getString("userId") == null) {
  			getMessage = "Session is Terminated. You need to relogin!";
  			gauceResponse.writeException("Error", String.valueOf(getErrorCode), "\n[Detail Msg]==>" + getMessage);
  			LNavigationAlter.setReturnUrl(req, "/index.jsp");
  			return;
  		}
  		//-------------------------------------- Session 종료시 처리 END
  		
  		inputData.setString("companyCd", loginUser.getString("companyCd"));
	    inputData.setString("lang",      loginUser.getString("lang"));
	    inputData.setString("userId",    loginUser.getString("userId"));
	    
	    LLog.info.write("===================  Payment Request (Open AP List 정보) 저장 PARAM  ======================");
	    LLog.info.write("baselineDate    :" + inputData.getString("baselineDate"));
	    LLog.info.write("paymentMethod   :" + inputData.getString("paymentMethod"));	    
	    LLog.info.write("partnerBankType :" + inputData.getString("partnerBankType"));
	    LLog.info.write("houseBank       :" + inputData.getString("houseBank"));
	    LLog.info.write("houseBankAcct   :" + inputData.getString("houseBankAcct"));
	    LLog.info.write("companyCd       :" + inputData.getString("companyCd"));
	    LLog.info.write("lang            :" + inputData.getString("lang"));
	    LLog.info.write("userId          :" + inputData.getString("userId"));
	    LLog.info.write("===========================================================================================");
	    
	    LMultiData mData = LGauceConverter.convertToLMultiDataWithJobType(openApGds);
	    
	    LLog.debug.write("CudPaymentRequestCmd mData (Open AP List 원본 데이타) ---------------> =>\n " + mData.toString());
		
  		PaymentBiz biz = new PaymentBiz();
		resultData = biz.cudPaymentRequest(mData, inputData);
		
		getErrorCode = resultData.getLong("getErrorCode");
		getMessage	 = resultData.getString("getMessage");

		LLog.info.write("===================  Payment Request (Open AP List 정보) 저장 결과 MSG  ======================");
		LLog.info.write("getErrorCode :" + getErrorCode);
		LLog.info.write("getMessage   :" + getMessage);
		LLog.info.write("==============================================================================================");
		
		if (getErrorCode != 0 && getErrorCode != -999999) {
			if (getMessage == null) getMessage = "";
			gauceResponse.writeException("Error", String.valueOf(getErrorCode), "\n[Detail Msg]==>" + getMessage);
		}

		LLog.debug.write("CudPaymentRequestCmd --------------- END");
	
	}
}
