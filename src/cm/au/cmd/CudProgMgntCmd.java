/*
 *------------------------------------------------------------------------------
 * CudProgMgntCmd.java,v 1.0 2010/07/23 16:43:35 
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
public class CudProgMgntCmd implements LGauceCommandIF {
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
				
		LLog.debug.write("CudProgMgntCmd inputData--------------- Start \n");

		GauceDataSet userGds = gauceRequest.getGauceDataSet("IN_DS1");
		
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
	    	gauceResponse.writeException("Error", String.valueOf(getErrorCode), "\n[Detail Msg]==>" + getMessage);
	    	return;
	    }
	    //-------------------------------------- Session 종료시 처리 END
		
		LMultiData mData = LGauceConverter.convertToLMultiDataWithJobType(userGds);
		LLog.debug.println("CudProgMgntCmd inputData--------------- =>\n " + mData.toString());

		ProgMgntBiz biz = new ProgMgntBiz();
		resultData = biz.cudProgMgnt(mData, loginUser); 
		
		getErrorCode = resultData.getLong("getErrorCode");
		getMessage	 = resultData.getString("getMessage");
		
		 if (getErrorCode != 0 && getErrorCode != -999999) {             
             if (getMessage == null) getMessage = "";
             
             gauceResponse.writeException("Error", String.valueOf(getErrorCode), "\n[Detail Msg]==>" + getMessage);
         }
		 
		 //2015.03.05 hskim CSR:C20150303_16909 관리자 로그 생성
		 for( int i=0; null != mData && i < mData.getDataCount(); i++ ) {
			 LData	rowData = mData.getLData( i );

			 // 등록
			 if( "DEVON_CREATE_FILTER_VALUE".equals(rowData.getString( "DEVON_CUD_FILTER_KEY")) ) {
			 	if (loginUser.getString("authCd").equals("AD")) {
				    			  
			 		String admLog = "\n";
			 		String currentTimeStr = new SimpleDateFormat("yyyyMMddhhmmss").format(new java.util.Date());
				    				  
			 		admLog = admLog + currentTimeStr + "|"                         //현재시간 
			 		                   + "AuditLog" + "|"                                                //Log 유형
			 		                   + req.getHeader("Proxy-Client-IP") + "|"		//IP
			 		                   + loginUser.getString("userId") + "|"             //사용자 ID
			 		                   + "Create" + "|"                                                     //행위 구분
			 		                   + "HCI 시스템" + "|"                                      //시스템
			 		                   + "CudProgMgntCmd" + "|"                                      //Command
			 		                   + "progMgnt.jsp"                                           //Return URL
			 		                   ;
				    				  
			 		LLog.debug.write(admLog);
			 	}
			 }
			 // 수정
			 else if( "DEVON_UPDATE_FILTER_VALUE".equals(rowData.getString( "DEVON_CUD_FILTER_KEY")) ) {
				    			
			 	if (loginUser.getString("authCd").equals("AD")) {
					    			  
			 		String admLog = "\n";
			 		String currentTimeStr = new SimpleDateFormat("yyyyMMddhhmmss").format(new java.util.Date());
				   				  
			 		admLog = admLog + currentTimeStr + "|"                         //현재시간 
			 		                   + "AuditLog" + "|"                                                //Log 유형
			 		                   + req.getHeader("Proxy-Client-IP") + "|"		//IP
			 		                   + loginUser.getString("userId") + "|"             //사용자 ID
			 		                   + "Modify" + "|"                                                     //행위 구분
			 		                   + "HCI 시스템" + "|"                                      //시스템
			 		                   + "CudProgMgntCmd" + "|"                                      //Command
			 		                   + "progMgnt.jsp"                                           //Return URL
			 		                   ;
				    				  
			 		LLog.debug.write(admLog);
			 	}
			 }
		 }
		
		 LLog.debug.write("CudProgMgntCmd inputData--------------- End \n");

	}
}
