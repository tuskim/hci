/* ------------------------------------------------------------------------
 * @source  : DeleteConDocCmd.java
 * @desc    : ConDoc delete 
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

import comm.util.LXssCollectionUtility;

import devon.core.collection.LData;
import devon.core.exception.LException;
import devonframework.front.command.LCommandIF;
import devonframework.front.fileupload.LMultipartRequest;

/**
 * <PRE>
 * 
 * 
 * </PRE>
 * 
 * @author    ceh
 * @see       
 */
public class DeleteConDocCmd implements LCommandIF {
    /**
     * 
     *
     * @param req Http Request 객체.
     * @param res Http Response 객체.
     * @param gauceRequest 가우스 Request 객체.
     * @param gauceResponse 가우스 Response 객체.
     * @exception LException Commnad 단 이하의 모든 에러.
     */
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {

		LData inputData = LXssCollectionUtility.getData(req);

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
		ConDocBiz biz = new ConDocBiz();
			
		LMultipartRequest lmtpReq = new LMultipartRequest( req , "board" );
		inputData =  LXssCollectionUtility.getData( lmtpReq );
		biz.saveConDoc(inputData);//공지사항 삭제
		//biz.deleteConDocAttach(inputData);//첨부파일 삭제		
				
		LData resultMsg = new LData();
        
        resultMsg.setString("msg", "Success");
        
        req.setAttribute("inputData", inputData);
        req.setAttribute("resultMsg", resultMsg);	
		
    }
}
