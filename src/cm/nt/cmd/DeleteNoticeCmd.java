/* ------------------------------------------------------------------------
 * @source  : DeleteNoticeCmd.java
 * @desc    : notice delete 
 * ------------------------------------------------------------------------
 *
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2010.07.24                      Initial
 * ------------------------------------------------------------------------ */

 

package cm.nt.cmd;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cm.nt.biz.NoticeBiz;

import comm.util.LXssCollectionUtility;

import devon.core.collection.LData;
import devon.core.exception.LException;
import devon.core.log.LLog;
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
public class DeleteNoticeCmd implements LCommandIF {
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
		NoticeBiz biz = new NoticeBiz();
			
		
		String userIdInSession   = loginUser.getString("userId");
		String userIdInInputData = inputData.getString("userId");
		
		LLog.info.println("\nuserIdInSession"+userIdInSession);
		LLog.info.println("\n\nuserIdInInputData"+userIdInInputData);
		
		
		if(userIdInSession.equals(userIdInInputData)){
		
		LMultipartRequest lmtpReq = new LMultipartRequest( req , "board" );
		inputData =  LXssCollectionUtility.getData( lmtpReq );
		biz.saveNotice(inputData);//공지사항 삭제
		biz.deleteNoticeAttach(inputData);//첨부파일 삭제		
				
		LData resultMsg = new LData();
        
        resultMsg.setString("msg", "Success");
        
        req.setAttribute("inputData", inputData);
        req.setAttribute("resultMsg", resultMsg);	
		}
    }
}
