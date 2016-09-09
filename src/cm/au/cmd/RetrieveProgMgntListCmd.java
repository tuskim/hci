/*
 *------------------------------------------------------------------------------
 * RetrieveProgMgntListCmd.java,v 1.0 2010/07/23 16:43:35 
 * 
 * PROJ : JIT-HUB 
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0 2010/07/23   mskim   최초 프로그램 작성
 * 1.1 2015/03/05   hskim    CSR:C20150303_16909 관리자 로그 생성
 * 1.2 2015/04/20   hskim    CSR:C20150417_55794 관리자 로그 Level 변경 (info -> Debug)
 *----------------------------------------------------------------------------
 */

package cm.au.cmd;

import java.text.SimpleDateFormat;

import cm.au.biz.ProgMgntBiz;

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
public class RetrieveProgMgntListCmd implements LGauceCommandIF {
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
		 
		LLog.debug.write("RetrieveProgMgntListCmd inputData--------------- Start \n");

		GauceDataSet gds = new GauceDataSet();  
		gauceResponse.enableFirstRow(gds);
		
		// Session
		HttpSession session = req.getSession(false);
		LData loginUser = new LData();
		LData inputData = LXssCollectionUtility.getData(req);

		if (session != null) loginUser = (LData)session.getAttribute("loginUser");			
		inputData.setString("userId", 	loginUser.getString("userId"));
		inputData.setString("lang", 	loginUser.getString("lang"));
		inputData.setString("companyCd",loginUser.getString("companyCd"));
		
		ProgMgntBiz biz = new ProgMgntBiz();
		LMultiData result = biz.retrieveProgMgntList(inputData);
		
	    LGauceConverter.extractToGauceDataSet(result, gds);
	    gds.flush(); 
	    
	    //2015.03.05 hskim CSR:C20150303_16909 관리자 로그 생성
		if (loginUser.getString("authCd").equals("AD")) {
		  
			String admLog = "\n";
			String currentTimeStr = new SimpleDateFormat("yyyyMMddhhmmss").format(new java.util.Date());
			  
			//inputData.setString("userIp", req.getHeader("Proxy-Client-IP"));//등록자 IP, Apache 기반
		    //inputData.setString("userIp", req.getRemoteAddr());//등록자 IP, WAS 기반
			  
			admLog = admLog + currentTimeStr + "|"                       //현재시간 
			                   + "AuditLog" + "|"                                              //Log 유형
			                   + req.getHeader("Proxy-Client-IP") + "|"	//IP
			                   + loginUser.getString("userId") + "|"           //사용자 ID
			                   + "Search" + "|"                                                   //행위 구분
			                   + "HCI 시스템" + "|"                                    //시스템
			                   + "RetrieveProgMgntListCmd" + "|"                       //Command
			                   + "progMgnt.jsp"                                         //Return URL
			                   ;
			  
			LLog.debug.write(admLog);
		}

		LLog.debug.write("RetrieveProgMgntListCmd inputData--------------- End \n");
	    
	}
}
