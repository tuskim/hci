/*
 *------------------------------------------------------------------------------
 * RetrieveMainNoticeCmd.java,v 1.0 2010/05/30 16:43:35 
 * 
 * PROJ : JIT-HUB 
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2010/05/30   hani1005         최초 프로그램 작성
 *----------------------------------------------------------------------------
 */

package cm.cm.cmd;

import cm.cm.biz.CodeMgntBiz;
import comm.util.LXssCollectionUtility;

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
public class RetrieveCommComboVendorListCmd implements LGauceCommandIF {
    /**
     * 
     *
     * @param req Http Request 객체.
     * @param res Http Response 객체.
     * @param gauceRequest 가우스 Request 객체.
     * @param gauceResponse 가우스 Response 객체.
     * @exception LException Commnad 단 이하의 모든 에러.
     */
	public void execute(HttpServletRequest req, HttpServletResponse res, GauceRequest gauceRequest, GauceResponse gauceResponse) throws Exception { 
    	LLog.info.write("\n RetrieveCommComboVenderListCmd --> Start \n");	
 
		LData lData = null;
 
		lData	= LXssCollectionUtility.getData(req); 
		 //-------------------------------------- Session 종료시 처리 START
	    HttpSession session = req.getSession(false);
	    LData loginUser = new LData();
	    
	    if (session != null) loginUser = (LData)session.getAttribute("loginUser");
	    if( loginUser.getString("userId") == null) {
	    	String getMessage = "Session is Terminated. You need to relogin!";
	    	gauceResponse.writeException("Error", "", "\n[Detail Msg]==>" + getMessage);
	    	return;
	    }
	    //-------------------------------------- Session 종료시 처리 END
		
		
		lData.setString("lang", loginUser.getString("lang"));
		lData.setString("companyCd", loginUser.getString("companyCd"));
		CodeMgntBiz Biz = new CodeMgntBiz();
		LMultiData result = Biz.RetrieveCommComboVendorList(lData);
		GauceDataSet gds = new GauceDataSet();
		gauceResponse.enableFirstRow(gds);
		LGauceConverter.extractToGauceDataSet(result, gds);
		gds.flush();
		LLog.info.write("\n RetrieveCommComboVenderListCmd --> End \n");	
		
	}

}
