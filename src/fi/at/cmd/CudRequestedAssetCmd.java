/*
 *------------------------------------------------------------------------------
 * CudRequestedAssetCmd.java 
 * 
 * PROJ : PT-GAM System.
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2015/12/28   hckim   Init
 *----------------------------------------------------------------------------
 */

package fi.at.cmd;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import comm.util.LXssCollectionUtility;
import devon.core.collection.LData;
import devon.core.exception.LException;
import devon.core.log.LLog;
import devonframework.bridge.gauce.command.LGauceCommandIF;
import devonframework.front.channel.LNavigationAlter;
import fi.at.biz.AssetBiz;

public class CudRequestedAssetCmd implements LGauceCommandIF {

	/**
     * @param req Http Request 객체.
     * @param res Http Response 객체.
     * @param gauceRequest 가우스 Request 객체.
     * @param gauceResponse 가우스 Response 객체.
     * @exception LException Commnad 단 이하의 모든 에러.
     */
	public void execute(HttpServletRequest req, HttpServletResponse res, 
            GauceRequest gauceRequest, GauceResponse gauceResponse) throws LException {
		
		LLog.debug.write("CudRequestedAssetCmd --------------- START");

		LData inputData = LXssCollectionUtility.getData(req);
		
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
  		
  		inputData.setString("userId", loginUser.getString("userId"));  // 로그인 사용자 ID
  		inputData.setString("delYn",  "Y");                            // 삭제유무
  		
  		LLog.info.write("===================  Requested Asset 삭제 정보 PARAM  ======================");
		LLog.info.write("requestNo :" + inputData.getString("requestNo"));
		LLog.info.write("companyCd :" + inputData.getString("companyCd"));
		LLog.info.write("userId    :" + inputData.getString("userId"));
		LLog.info.write("delYn     :" + inputData.getString("delYn"));
		LLog.info.write("============================================================================");
  		
  		AssetBiz biz = new AssetBiz();
  		
  		// Requested Asset 정보 삭제
		resultData = biz.cudRequestedAssetInfo(inputData);
		
		getErrorCode = resultData.getLong("getErrorCode");
		getMessage	 = resultData.getString("getMessage");

		LLog.info.write("===================  Requested Asset 정보 삭제 결과 MSG  ======================");
		LLog.info.write("getErrorCode :" + getErrorCode);
		LLog.info.write("getMessage   :" + getMessage);
		LLog.info.write("===============================================================================");
		
		if (getErrorCode != 0 && getErrorCode != -999999) {
			if (getMessage == null) getMessage = "";
			gauceResponse.writeException("Error", String.valueOf(getErrorCode), "\n[Detail Msg]==>" + getMessage);
		}

		LLog.debug.write("CudRequestedAssetCmd --------------- END");
	
	}
}
