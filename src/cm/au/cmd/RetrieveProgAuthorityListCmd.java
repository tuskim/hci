/*
 *------------------------------------------------------------------------------
 * RetrieveProgAuthorityListCmd.java,v 1.0 2010/07/23 16:43:35 
 * 
 * PROJ : PT-PAM 
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2010/07/23   mskim    최초 프로그램 작성
 *----------------------------------------------------------------------------
 */

package cm.au.cmd;

import cm.au.biz.ProgMgntBiz;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//import com.gauce.io.GauceRequest;
//import com.gauce.io.GauceResponse;

import comm.util.LXssCollectionUtility;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LException;
import devon.core.log.LLog;
import devonframework.front.command.LCommandIF;
//import devonframework.bridge.gauce.command.LGauceCommandIF;

/**
 * <PRE>
 * 
 * 
 * </PRE>
 * 
 * @author    ceh
 * @see       
 */
public class RetrieveProgAuthorityListCmd implements LCommandIF  {
    /**
     * 
     *
     * @param req Http Request 객체.
     * @param res Http Response 객체.
     * @param gauceRequest 가우스 Request 객체.
     * @param gauceResponse 가우스 Response 객체.
     * @exception LException Commnad 단 이하의 모든 에러.
     */
	public void execute(HttpServletRequest req, HttpServletResponse res) throws LException {
		 
		LLog.debug.write("RetrieveProgAuthorityListCmd inputData--------------- Start \n");
		
		LData inputData = LXssCollectionUtility.getData(req);

		//long  getErrorCode = 0 ;
        String getMessage   = "";
        
		//-------------------------------------- Session 종료시 처리 START
	    HttpSession session = req.getSession(false);
	    LData loginUser = new LData();
	    
	    if (session != null) loginUser = (LData)session.getAttribute("loginUser");
	    if( loginUser.getString("userId") == null) {
	    	getMessage = "Session is Terminated. You need to relogin!";
	    	//gauceResponse.writeException("Error", String.valueOf(getErrorCode), "\n[Detail Msg]==>" + getMessage);
	    	return;
	    }
	    //-------------------------------------- Session 종료시 처리 END
		inputData.setString("companyCd", loginUser.getString("companyCd"));
		inputData.setString("lang",		 loginUser.getString("lang"));

		ProgMgntBiz biz = new ProgMgntBiz();
		LMultiData result = biz.retrieveProgAuthorityList(inputData);
		
		req.setAttribute("resultData", result);
		
		LLog.debug.write("RetrieveProgAuthorityListCmd inputData--------------- End \n");
    }
}
