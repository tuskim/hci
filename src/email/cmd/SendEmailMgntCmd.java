/*
 *------------------------------------------------------------------------------
 * SendEmailMgntCmd.java,v 1.0 2010/07/23 16:43:35 
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

package email.cmd;
 

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
import comm.util.LXssCollectionUtility; 
import devon.core.collection.LData; 
import devon.core.exception.LException;
import devon.core.exception.LSysException;
import devon.core.log.LLog;
import email.biz.emailBiz;

import devonframework.front.command.LCommandIF;
import devonframework.front.fileupload.LFileInfo;
import devonframework.front.fileupload.LMultipartRequest;

/* ******************************
 * E-Mail Send
 * ******************************/
public class SendEmailMgntCmd implements LCommandIF {
    /**
     * @param req Http Request 객체.
     * @param res Http Response 객체.
     * @param gauceRequest 가우스 Request 객체.
     * @param gauceResponse 가우스 Response 객체.
     * @exception LException Commnad 단 이하의 모든 에러.
     */
	public void execute(HttpServletRequest req, HttpServletResponse res) throws LException {
		
		LLog.debug.println("SendEmailMgntCmd ------------ START");
		
		LData resultMsg = new LData();
        
		try { 
			LData inputData = LXssCollectionUtility.getData(req);
			
			LMultipartRequest multi = null;
			
			multi =  new LMultipartRequest(req, "email");	//, Long.parseLong(fileSize) * 1024 * 1024
			
			inputData = LXssCollectionUtility.getData(multi);
			
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
			LData dataBox = new LData();
		    //사용자iD 추가.`
		    inputData.setString("userId", loginUser.getString("userId"));
		    inputData.setString("lang",   loginUser.getString("lang"));
			inputData.setString("companyCd",loginUser.getString("companyCd"));
			inputData.setString("email",loginUser.getString("email"));
			LLog.debug.println("SendEmailMgntCmd inputData    => " + inputData);
			
			LLog.debug.println("SendEmailMgntCmd uploadfile    => " + inputData.getString("uploadfileName"));
			
			if(inputData.getString("uploadfileName") != null && inputData.getString("uploadfileName") != "") {
				
				//upload된 파일의 정보를 얻어온다.
		        LFileInfo lfifFileInfos[] = multi.getFileInfos( "uploadfile" ); 

	            LLog.debug.println("lfifFileInfos[0].getClientFileName() => " + lfifFileInfos[0].getClientFileName());
	            LLog.debug.println("lfifFileInfos[0].getServerPath()    => " + lfifFileInfos[0].getServerPath());
	            LLog.debug.println("lfifFileInfos[0].getFileName()    => " + lfifFileInfos[0].getFileName());
		
	            inputData.setString("uploadfile", lfifFileInfos[0].getServerPath());
	            inputData.setString("uploadfilename", lfifFileInfos[0].getFileName());
			} else {
	            inputData.setString("uploadfile", "");
	            inputData.setString("uploadfilename", "");	
			}
			
			LLog.debug.println("SendEmailMgntCmd inputData    => " + inputData);
		
	        emailBiz biz = new emailBiz();
			dataBox 	 = biz.sendOnlyMail(inputData); 
			String  getStatus    = "";
			getErrorCode = dataBox.getLong  ("getErrorCode");
			getMessage   = dataBox.getString("getMessage"  );
			getStatus    = dataBox.getString("getStatus"   );				
			
			if(getErrorCode != 0){
				String strOutErrMsg = getMessage;
				resultMsg.setString("msg", strOutErrMsg);
			} else {
				resultMsg.setString("msg", "Successfully Send");
			}
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "SendEmailMgntCmd()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		}
		
		req.setAttribute("resultData", resultMsg);
        
		LLog.debug.println("SendEmailMgntCmd ------------ END");
    }
}