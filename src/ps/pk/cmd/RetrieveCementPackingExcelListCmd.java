/*
 *------------------------------------------------------------------------------
 * RetrieveCementPackingExcelListCmd.java,v 1.0 2010/07/23 16:43:35 
 * 
 * PROJ : PT-PAM 
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2010/08/20   mskim   Init
 *----------------------------------------------------------------------------
 */

package ps.pk.cmd;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ps.pk.biz.CementPackingBiz;

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
 * @author    ceh
 * @see       
 */
public class RetrieveCementPackingExcelListCmd implements LGauceCommandIF  {
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
		 
		LLog.info.write("\n RetrieveCementPackingExcelListCmd --> Start \n");		

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
	    
	    //회사코드 추가.`
	    inputData.setString("companyCd", loginUser.getString("companyCd"));
	    inputData.setString("lang",      loginUser.getString("lang"));
	    
	    CementPackingBiz biz = new CementPackingBiz();
		LMultiData result = biz.retrieveCementPackingExcelList(inputData);
		
		LLog.info.write("\n RetrieveCementPackingExcelListCmd result:" + result.toString());		
		//req.setAttribute("resultData", result);

	    LGauceConverter.extractToGauceDataSet(result, gds);
	    gds.flush();
	    
		LLog.info.write("\n RetrieveCementPackingExcelListCmd --> End \n");		
		
    }
}