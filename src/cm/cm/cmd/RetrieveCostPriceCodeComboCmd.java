/*
 *------------------------------------------------------------------------------
 * RetrieveLgeSiteComboGauCmd.java,v 1.0 2010/05/30 16:43:35 
 * 
 * PROJ : JIT-HUB 
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2010/07/29   mskim   Init
 *----------------------------------------------------------------------------
 */

package cm.cm.cmd;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cm.cm.biz.CodeMgntBiz;

import com.gauce.GauceDataSet;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import comm.util.LXssCollectionUtility;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LException;
import devonframework.bridge.gauce.command.LGauceCommandIF;
import devonframework.bridge.gauce.util.LGauceConverter;

/**
 * <PRE>
 * 
 * 
 * </PRE>
 * 
 * @author mskim
 * @see       
 */
public class RetrieveCostPriceCodeComboCmd implements LGauceCommandIF {
    /**
     * 
     *
     * @param req Http Request 객체.
     * @param res Http Response 객체.
     * @param gauceRequest 가우스 Request 객체.
     * @param gauceResponse 가우스 Response 객체.
     * @exception LException Commnad 단 이하의 모든 에러.
     */
	public void execute(HttpServletRequest req, HttpServletResponse res, GauceRequest gauceRequest, GauceResponse gauceResponse) throws LException {

		long   getErrorCode = 0 ;
        String getMessage   = "";
        
	    GauceDataSet gds = new GauceDataSet("ds_commCode");  
		gauceResponse.enableFirstRow(gds);
		LData inputData = LXssCollectionUtility.getData(req);

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
	    
		inputData.setString("companyCd", loginUser.getString("companyCd"));
		inputData.setString("lang",		 loginUser.getString("lang"));
	    
		CodeMgntBiz biz = new CodeMgntBiz();
		LMultiData result = biz.retrieveCostPriceCodeCombo(inputData);
		
	    LGauceConverter.extractToGauceDataSet(result, gds);  
	    gds.flush(); 

	}
}
