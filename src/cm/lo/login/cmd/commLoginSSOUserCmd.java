/* ------------------------------------------------------------------------
 * @source  : commLoginSSOUserCmd.java
 * @desc    : 사용자 SSO 로그인
 * ------------------------------------------------------------------------
 * PROJ : 투자사 시스템 표준안 개발
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2010.08.23  김현수                 Initial
 * ------------------------------------------------------------------------ */

package cm.lo.login.cmd;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cm.lo.login.biz.commBiz;

import devon.core.collection.LData;
import devon.core.log.LLog;
import devonframework.front.command.LCommandIF;
import devonframework.front.util.LCollectionUtility;

public class commLoginSSOUserCmd implements LCommandIF{

	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		LLog.debug.write("commLoginSSOUserCmd Start ---->");
		
		LData userInfo = LCollectionUtility.getData(req);
		LData loginUser = null;
		commBiz biz = new commBiz();
		
		loginUser = biz.retrieveSSOUserInfo(userInfo);
		
		HttpSession session = req.getSession();
		session.setAttribute("loginUser", loginUser); 
		
		LLog.debug.write("commLoginSSOUserCmd End ---->");
	}
}
