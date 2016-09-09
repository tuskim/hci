/* ------------------------------------------------------------------------
 * @source  : UserCUDGauCmd.java
 * @desc    : 사용자 개인정보 수정
 * ------------------------------------------------------------------------
 *
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0                        Initial
 * ------------------------------------------------------------------------ */

package cm.ur.cmd;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cm.ur.biz.UserMgntBiz;
import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.log.LLog;
import devonframework.front.command.LCommandIF;

public class RetreveUserInfoChangeCmd implements LCommandIF {

    public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
 
    
    	LLog.info.write("\n RetreveUserInfoChangeCmd --> Start \n");	
    
    	//사용자 정보
   		LData inputData = new LData();
   		LMultiData result = new LMultiData();	
   		
   		//-------------------------------------- Session 종료시 처리 START
		    HttpSession session = req.getSession(false);
		    LData loginUser = new LData();
		    
		    if (session != null) loginUser = (LData)session.getAttribute("loginUser");
		    if( loginUser.getString("userId") == null) {
		    	String getMessage = "Session is Terminated. You need to relogin!";
		    	return;
		    }
		 //-------------------------------------- Session 종료시 처리 END
		    
		inputData.setString("companyCd", loginUser.getString("companyCd"));
		inputData.setString("lang", 	 loginUser.getString("lang"));
   		inputData.setString("userId", loginUser.getString("userId"));
    
   		UserMgntBiz userMgntBiz = new UserMgntBiz();
   		result= userMgntBiz.retreiveUserInfoChange(inputData);
		
   		req.setAttribute("result", result);
   		
   	}	
 
}