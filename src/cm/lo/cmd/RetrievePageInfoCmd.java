/*
 *------------------------------------------------------------------------------
 * RetrievePageInfoCmd.java,v 1.0 2010/05/30 16:43:35 
 * 
 * PROJ : JIT-HUB 
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2010/08/05   mskim   Init
 * 2015/10/08   hskim   CSR:C20151005_87394 세션 종료 시 메인 페이지 이동
 *----------------------------------------------------------------------------
 */
package cm.lo.cmd;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//import com.gauce.GauceDataSet;
//import com.gauce.io.GauceRequest;
//import com.gauce.io.GauceResponse;

import cm.lo.biz.PageInfoBiz;
import comm.util.LXssCollectionUtility;

import devon.core.collection.LData;
//import devon.core.collection.LMultiData;
import devon.core.exception.LException;
import devon.core.log.LLog;
import devonframework.front.command.LCommandIF;
//import devonframework.bridge.gauce.util.LGauceConverter;
import devonframework.front.channel.LNavigationAlter;

public class RetrievePageInfoCmd implements LCommandIF{

	
	public void execute(HttpServletRequest req, HttpServletResponse res) throws LException {
		 
		LLog.info.write("\n RetrievePageInfoCmd --> Start \n");		

		LData inputData = LXssCollectionUtility.getData(req);
		LLog.info.write("\n RetrievePageInfoCmd inputData:" + inputData.toString() + "\n");		

		long  getErrorCode = 0 ;
        String getMessage   = "";
        
		//-------------------------------------- Session 종료시 처리 START
	    HttpSession session = req.getSession(false);
	    LData loginUser = new LData();
	    
	    if (session != null) loginUser = (LData)session.getAttribute("loginUser");
	    if( loginUser.getString("userId") == null) {
	    	getMessage = "Session is Terminated. You need to relogin!";
	    	LNavigationAlter.setReturnUrl(req, "/index.jsp");
	    	return;
	    }
	    //-------------------------------------- Session 종료시 처리 END
	    
	    //사용자iD 추가.`
	    inputData.setString("companyCd", loginUser.getString("companyCd"));
	    inputData.setString("lang", 	 loginUser.getString("lang"));
	    inputData.setString("authCd", 	 loginUser.getString("authCd"));
	    inputData.setString("userId", 	 loginUser.getString("userId"));
	    
	    
	    //정상적 접근 확인
	    if (inputData.getString("progCd") == null) {
	    	String returnUrl = "/error/404.jsp";
	    	LNavigationAlter.setReturnUrl(req, returnUrl);
	    	return;
	    }
	    
	    //컬럼명 세팅
	    PageInfoBiz biz = new PageInfoBiz();
		LData result = biz.retrievePageColumnInfo(inputData);

		if(result.size()<1 ||result==null){
			req.setAttribute("validation", loginUser);
			req.setAttribute("userid", loginUser.getString("userId"));
			req.setAttribute("userpw", loginUser.getString("userPw"));
			req.setAttribute("authcd", loginUser.getString("authCd"));
			req.setAttribute("usernm", loginUser.getString("userNm"));
			
			String returnUrl = "/error/404.jsp";
	    	LNavigationAlter.setReturnUrl(req, returnUrl);
		}
   		//CommBiz commBiz = new CommBiz();
   		//LData colData = commBiz.getColumns(req, "CM0009_01");  //화면코드 
		
		biz.cudPageCount(inputData);

   		req.setAttribute("columnData", result );
		
	    //LGauceConverter.extractToGauceDataSet(result, gds);
	    //gds.flush();
	    
		LLog.info.write("\n RetrievePageInfoCmd --> End \n");		
		
    }	
	
}
