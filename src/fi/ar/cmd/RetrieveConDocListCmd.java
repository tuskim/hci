/* ------------------------------------------------------------------------
 * @source  : RetrieveConDocListCmd.java
 * @desc    : ConDoc List
 * ------------------------------------------------------------------------
 *
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2010.12.08                      Initial
 * ------------------------------------------------------------------------ */

 

package fi.ar.cmd;

import fi.ar.biz.ConDocBiz;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LException;
//import devon.core.log.LLog;
import devonframework.front.command.LCommandIF;
import devonframework.front.paging.LDefaultPageNavigation;

import comm.util.LXssCollectionUtility;

/**
 * <PRE>
 * 
 * 
 * </PRE>
 * 
 * @author    ceh
 * @see       
 */
public class RetrieveConDocListCmd implements LCommandIF {
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

		LData inputData = LXssCollectionUtility.getData(req);
		LMultiData result = null; 

		long  getErrorCode = 0 ;
        String getMessage   = "";
        
		//-------------------------------------- Session 종료시 처리 START
	    HttpSession session = req.getSession(false);
	    LData loginUser = new LData();
	    
	    if (session != null) loginUser = (LData)session.getAttribute("loginUser");
	    if( loginUser.getString("userId") == null) {
	    	getMessage = "Session is Terminated. You need to relogin!";
	    	 
	    	return;
	    }
	    //-------------------------------------- Session 종료시 처리 END
	    
	    //사용자iD 추가.`
	    inputData.setString("userId", loginUser.getString("userId"));
	    inputData.setString("lang",   loginUser.getString("lang"));
		inputData.setString("companyCd",loginUser.getString("companyCd"));		
		LDefaultPageNavigation pageNavigation = null; 
		ConDocBiz biz = new ConDocBiz(); 
		result = biz.retrieveConDocList(inputData);  
		pageNavigation = new LDefaultPageNavigation( inputData, result ); 
		req.setAttribute("pageNavigation", pageNavigation);
	    req.setAttribute("param", inputData); 
    } 
}
