/* ------------------------------------------------------------------------
 * @source  : commLoginUserCmd.java
 * @desc    : 사용자 로그인
 * ------------------------------------------------------------------------
 * PROJ : 투자사 시스템 표준안 개발
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2010.05.12  김현수                 Initial
 * 1.1  2014.04.14    한재우	  CSR:C20140414_23324
 * 1.2  2015.03.04     hskim	  CSR:C20150303_16909 관리자 로그 생성
 * 1.3  2015.04.20     hskim	  CSR:C20150417_55794 관리자 로그 Level 변경 (info -> Debug)
 * ------------------------------------------------------------------------ */

package cm.lo.login.cmd;

import java.net.InetAddress;
import java.text.SimpleDateFormat;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cm.lo.login.biz.commBiz;
import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.log.LLog;
import devonframework.front.channel.LNavigation;
import devonframework.front.channel.LNavigationAlter;
import devonframework.front.command.LCommandIF;


public class commLoginUserCmd implements LCommandIF {

	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
    	LLog.debug.write("commLoginUserCMD --> Start");
    	
    	
        //LData inputData = LXssCollectionUtility.getData(req);
		LData inputData =  new LData();
        Enumeration e = req.getParameterNames();
        while (e.hasMoreElements()) {
            String key = (String)e.nextElement();
            inputData.put(key, req.getParameter(key));
        }
		       
        inputData.setString("userIp", req.getHeader("Proxy-Client-IP"));//등록자 IP
        LData loginUser = null;
        LMultiData loginMenu = null;
        LMultiData xmlMenu = null;
        LMultiData menuList = null;
        String returnUrl = "";
        String pwValidation ;
        
        
        commBiz biz = new commBiz();
        loginUser = biz.retrieveUserInfo(inputData);
        String serverIP[] = InetAddress.getLocalHost().toString().split("/");
                
        loginUser.setString("lang", inputData.getString("lang"));
        loginUser.setString("serverIP", serverIP[serverIP.length -1]);
        
        
        String validation = loginUser.getString("validation");
        //9999(로그인 성공) 이 아닌경우
        if ( !validation.equals("9999") || validation == null) {
        	LLog.debug.write("\n\n************Login fail*************\nvalidation = "+validation+"\n");
			req.setAttribute("validation", loginUser);
			req.setAttribute("userid", loginUser.getString("userId"));
			req.setAttribute("userpw", loginUser.getString("userPw"));
			req.setAttribute("authcd", loginUser.getString("authCd"));
			req.setAttribute("usernm", loginUser.getString("userNm"));
			
			
			//아이디 존재 && 잘못 로그
			if(loginUser !=null  ){
				LLog.info.write(loginUser.getString("loginErrorCount"));
				req.setAttribute("loginErrorCount", loginUser.getString("loginErrorCount"));
			}
			
			LLog.info.write("$$$$$$$$$$$$$$$$$$   LoginUser   $$$$$$$$$$$$$$$$$$$$$$$\n"+loginUser);
        	returnUrl = "index.jsp";
        	LNavigationAlter.setReturnUrl(req, returnUrl);
		}
        //9999 로그인 성공
        else {
	          //비밀번호가 만료된 경우.
        	  if(biz.retrievePasswordBetween(loginUser).getInt(0) >=31){	
				    LLog.info.println("commLoginUserCmd.Login Success but, Password expired");
		        	pwValidation = "false";
				    returnUrl = "index.jsp";
				    LNavigationAlter.setReturnUrl(req, returnUrl);					
			  }else{
				  	pwValidation = "true";
			  }
			  LLog.debug.write("\n\n************Login Success*************\n\n");
			  HttpSession session = req.getSession(); 
			  loginMenu = biz.retrieveMenuInfo(inputData);    
   //		  로그인 시간 업데이트 , 로그인 실패 횟수 초기 20140303
              biz.lastLoginTimeUpdate(loginUser);
              
        	  loginUser.setString("pwValidCode", pwValidation );
        	  
        	  session.setAttribute("loginUser", loginUser);  
        	  session.setAttribute("menuList", loginMenu);
        	  
        	  //2015.03.04 hskim CSR:C20150303_16909 관리자 로그 생성
			  if (loginUser.getString("authCd").equals("AD")) {
			  
				  String admLog = "\n";
				  String currentTimeStr = new SimpleDateFormat("yyyyMMddhhmmss").format(new java.util.Date());
				  
				 //inputData.setString("userIp", req.getHeader("Proxy-Client-IP"));//등록자 IP, Apache 기반
			     //inputData.setString("userIp", req.getRemoteAddr());//등록자 IP, WAS 기반
				  
				  admLog = admLog + currentTimeStr + "|"                       //현재시간 
				                     + "AuditLog" + "|"                                              //Log 유형
				                     + req.getHeader("Proxy-Client-IP") + "|"	//IP
				                     + loginUser.getString("userId") + "|"           //사용자 ID
				                     + "Login" + "|"                                                   //행위 구분
				                     + "HCI 시스템" + "|"                                    //시스템
				                     + "commLoginUserCmd" + "|"                       //Command
				                     + "loginProcess.jsp"                                         //Return URL
				                     ;
				  
				  LLog.debug.write(admLog);
			  }
		}
        
        LLog.debug.write("commLoginUserCMD --> End");
    }
}