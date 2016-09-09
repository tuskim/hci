/* ------------------------------------------------------------------------
 * @source  : commLoginoutCmd.java
 * @desc    : 사용자 로그아웃
 * ------------------------------------------------------------------------
 * PROJ : 투자사 시스템 표준안 개발
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2010.05.12  김현수                 Initial
 * ------------------------------------------------------------------------ */

package cm.lo.login.cmd;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import devonframework.front.command.LCommandIF;

public class commLogoutUserCmd implements LCommandIF {
    public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
    	
    	HttpSession session = req.getSession(false);
    	
    	if(session != null) {
    		session.invalidate();
    	}
    }
}