/* ------------------------------------------------------------------------
 * @source  : commAuthenticationCmd.java
 * @desc    : 사용자 로그인 세션 및 권한 체크
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

import devon.core.collection.LData;
import devon.core.exception.LException;
import devon.core.log.LLog;
import devonframework.persistent.autodao.LCommonDao;

public class commAuthenticationCmd {
	
	private String userid;
	private String usernm;
	private String groupcd;
		
	public commAuthenticationCmd(HttpServletRequest req, HttpServletResponse res) {
		
		HttpSession session = req.getSession(true);
		
		if (session.getAttribute("loginUser") != null) {
			LData loginUser = (LData)session.getAttribute("loginUser");
			
			userid = loginUser.getString("userid");
			usernm = loginUser.getString("usernm");
			groupcd = loginUser.getString("groupcd");
		} else {
			userid = "";
			usernm = "";
			groupcd = "";
		}
		
	}
	
	public String getUserid() {
		
		return userid;
		
	}
	
	public String getUsernm() {
			
			return usernm;
			
		}
	
	public String getGroupcd() {
		
		return groupcd;
		
	}
	
	public LData getUserInfo(){
		LData userData = new LData();
		userData.setString("userid", userid);
		userData.setString("usernm", usernm);
		userData.setString("groupcd", groupcd);
		
		return userData;
	}
	
	public boolean checkAuthMember(){
		
		boolean check =false;
		
		if (userid != "" && usernm != "" && groupcd != "" ){
			
			check =  true;
		}else{
			
			check =  false;
		}
		
		return check;
	}
	
	public boolean checkAuthMenu(String menucd) throws LException	{

		boolean authMenuOk = false;
		LData menuData = null;
		LData loginUser = new LData();
		
		loginUser.setString("codecd", groupcd);
		loginUser.setString("menucd", menucd);
		
		try {
			
			LCommonDao userDao = new LCommonDao("/ma/ma10Sql/retrieveAuthMenu", loginUser);
			menuData = userDao.executeQueryForSingle();
			
			if (!menuData.isEmpty()) {
				authMenuOk = true;
			}
			
		} catch (Exception e) {
			LLog.err.println(e);
		} finally {				
	
		}
			
		return authMenuOk;       
	}

}
