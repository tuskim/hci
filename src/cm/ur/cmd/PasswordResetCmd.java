package cm.ur.cmd;
/* ------------------------------------------------------------------------
 * @source  : passwordResetCmd.java
 * @desc    : userMgnt.jsp 에서 비밀번호 리셋하는 로직
 * ------------------------------------------------------------------------
 * 
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2014.09.03   Jwhan			    C20140825_97731
 * ------------------------------------------------------------------------ */
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cm.ur.biz.UserMgntBiz;

import comm.util.LXssCollectionUtility;

import devon.core.collection.LData;
import devon.core.log.LLog;
import devonframework.front.command.LCommandIF;

public class PasswordResetCmd  implements LCommandIF{

public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
    	LLog.info.write("unblocking --> Start");
    	UserMgntBiz biz = new UserMgntBiz();
    	
    	LData inputData = LXssCollectionUtility.getData(req);
    	
			// 사용자 관리

//			-------------------------------------- Session 종료시 처리 START
			HttpSession session = req.getSession(false);
			LData loginUser = new LData();
			
			if (session != null) loginUser = (LData)session.getAttribute("loginUser");
			if( loginUser.getString("userId") == null) {
				String getMessage = "Session is Terminated. You need to relogin!";
				return;
			}
			//-------------------------------------- Session 종료시 처리 END
			
			
			LLog.info.println("inputData\n"+inputData);
			biz.userPasswordReset(inputData);
			
			LLog.info.println("loginUser\n"+loginUser);
			LLog.info.println("============================");
			
			
			 LLog.info.write("unblocking --> End");
		}
}