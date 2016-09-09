/*
 *------------------------------------------------------------------------------
 * RetrievePurchOrderGroupCmd.java,v 1.0 2010/07/23 16:43:35 
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

package po.po.cmd;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import po.po.biz.PurchOrderMgntBiz;
  
import com.gauce.GauceDataSet;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import comm.util.LXssCollectionUtility;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.log.LLog;
import devonframework.bridge.gauce.command.LGauceCommandIF;
import devonframework.bridge.gauce.util.LGauceConverter;

public class RetrievePurchOrderMgntAppListCmd implements LGauceCommandIF {

    public void execute(HttpServletRequest req, HttpServletResponse res, GauceRequest gauceRequest, GauceResponse gauceResponse) throws Exception {
    	
    	
    	LLog.info.write("\n RetrievePurchOrderMgntAppListCmd --> Start \n");	
		GauceDataSet gds = new GauceDataSet();  
		gauceResponse.enableFirstRow(gds);  
		
		LData inputData = LXssCollectionUtility.getData(req);

		long  getErrorCode = 0 ;
        String getMessage   = "";
        
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
		inputData.setString("companyCd",loginUser.getString("companyCd"));
		inputData.setString("lang", 	loginUser.getString("lang"));
		PurchOrderMgntBiz   biz = new PurchOrderMgntBiz();
		LLog.info.println("inputData=>"+inputData);
		LMultiData result = biz.retrievePurchOrderMgntAppList(inputData);
		
	    LGauceConverter.extractToGauceDataSet(result, gds);
	    gds.flush(); 
		
		LLog.info.write("\n RetrievePurchOrderMgntAppListCmd --> End \n");
		
    }
    
}


