/*
 *------------------------------------------------------------------------------
 * RetrieveVendorDetailListCmd.java,v 1.0 2010/05/30 16:43:35 
 * Vendor Detail 조회 
 * 
 * PROJ : PT-PAM System
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2010/08/30   임민수   Init
 *----------------------------------------------------------------------------
 */
 

package cm.dm.cmd;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cm.dm.biz.DataInputMgntBiz;

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

public class CudDataInputMonitoringEmailListCmd implements LGauceCommandIF{
	
	/**
	 * Request 정보가 실제 수행되는 인터페이스 메소드
	 *
	 * @param req Http Request 객체.
	 * @param res Http Response 객체.
	 * @exception LException Commnad 단 이하의 모든 에러.
	 */
	public void execute(HttpServletRequest req, HttpServletResponse res, 
			             GauceRequest gauceRequest, GauceResponse gauceResponse) throws Exception {
	
		LLog.debug.write("CudDataInputMonitoringEmailListCmd inputData--------------- Start \n");
		
		LData headerData = LXssCollectionUtility.getData( req );
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
		
	    headerData.setString("companyCd", 	loginUser.getString("companyCd"));
	    headerData.setString("userId", 		loginUser.getString("userId"));
	    headerData.setString("lang", 		loginUser.getString("lang"));
	    	    
		LMultiData bodyData = LGauceConverter.convertToLMultiDataWithJobType(userGds);
		LLog.debug.println("CudDataInputMonitoringEmailListCmd inputData--------------- =>\n " + headerData.toString());
	
		DataInputMgntBiz biz = new DataInputMgntBiz();
		resultData = biz.cudRetrieveDataInputEmailList(bodyData, headerData);
		
		getErrorCode = resultData.getLong("getErrorCode");
		getMessage	 = resultData.getString("getMessage");
		
		 if (getErrorCode != 0 && getErrorCode != -999999) {             
	         if (getMessage == null) getMessage = "";
	         
	         gauceResponse.writeException("Error", String.valueOf(getErrorCode), "\n[Detail Msg]==>" + getMessage);
	     }
	
		 LLog.debug.write("CudDataInputMonitoringEmailListCmd inputData--------------- End \n");
	}
}