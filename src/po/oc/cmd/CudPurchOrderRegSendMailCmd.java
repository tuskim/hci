/*
 *------------------------------------------------------------------------------
 * SendEmailMgntCmd.java,v 1.0 2010/07/23 16:43:35 
 * 
 * PROJ : PIT-PAM 
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2010/07/23            최초 프로그램 작성
 *----------------------------------------------------------------------------
 */

package po.oc.cmd;
 

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import po.oc.biz.PurchOrderRegBiz;
 
import comm.util.LXssCollectionUtility; 
import devon.core.collection.LData; 
import devon.core.exception.LException;
import devon.core.exception.LSysException;
import devon.core.log.LLog;

import devonframework.front.command.LCommandIF; 

/* ******************************
 * E-Mail Send
 * ******************************/
public class CudPurchOrderRegSendMailCmd implements LCommandIF {
    /**
     * @param req Http Request 객체.
     * @param res Http Response 객체.
     * @param gauceRequest 가우스 Request 객체.
     * @param gauceResponse 가우스 Response 객체.
     * @exception LException Commnad 단 이하의 모든 에러.
     */
	public void execute(HttpServletRequest req, HttpServletResponse res) throws LException {
		
		LLog.debug.println("CudPurchOrderRegSendMailCmd ------------ START");
		LData LError = new LData();
		try { 
			LData inputData = LXssCollectionUtility.getDataHtml(req);   
			//-------------------------------------- Session 종료시 처리 START
		    HttpSession session = req.getSession(false);
		    LData loginUser = new LData();
		    
		    if (session != null) loginUser = (LData)session.getAttribute("loginUser");
		    if( loginUser.getString("userId") == null) {
		    	LError.put("getErrorCode"	,"-9999");
		    	LError.put("getMessage"	,"Session is Terminated. You need to relogin!");
		    }else{
			    //-------------------------------------- Session 종료시 처리 END
	
			    //사용자iD 추가.`
			    inputData.setString("userId", loginUser.getString("userId"));
			    inputData.setString("userNm", loginUser.getString("userNm"));		    
			    inputData.setString("lang",   loginUser.getString("lang"));
				inputData.setString("companyCd",loginUser.getString("companyCd"));
				inputData.setString("email",loginUser.getString("email"));
				LLog.debug.println("CudPurchOrderRegSendMailCmd inputData    => " + inputData); 
			
				PurchOrderRegBiz biz = new PurchOrderRegBiz();
		        //LError 	 = biz.sendMail(inputData); 	
				LError 	 = biz.sendOnlyMail(inputData); 	
				//if(LError.get("getErrorCode").equals("0")){ 
					 //biz.cudPurchOrderRegUpdateSendDate(inputData);
				//}
		    }
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "CudPurchOrderRegSendMailCmd()" + "=>" + se.getMessage());
			throw new LSysException("po.oc", se);
		}
		
		req.setAttribute("resultData", LError);
        
		LLog.debug.println("CudPurchOrderRegSendMailCmd ------------ END");
    }
}