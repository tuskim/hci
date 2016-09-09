

package cm.ur.cmd;

import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cm.ur.biz.UserMgntBiz;

import comm.util.LXssCollectionUtility;
import comm.util.OneWaySecurityUtil;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LException;
import devon.core.log.LLog;
import devonframework.front.channel.LNavigationAlter;
import devonframework.front.command.LCommandIF;

public class PasswordChangeWhenLoginCmd implements LCommandIF {

	private String validationMessage = "";
	
	
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		long   getErrorCode = 0 ;
		String getMessage   = "";
		String returnUrl    = "";
		String validation   = "";
		
		//-------------------------------------- Session 종료시 처리 START
		HttpSession session = req.getSession(true);
		LData loginUser = new LData();
		
		if (session != null) loginUser = (LData)session.getAttribute("loginUser");
		if( loginUser.getString("userId") == null) {
		getMessage = "Session is Terminated. You need to relogin!";
		
		}
		//-------------------------------------- Session 종료시 처리 END
				
		try {
			LLog.info.write("\n PasswordChangeWhenLoginCmd --> Start \n");	
						
			LData passwordData = new LData();
			passwordData = LXssCollectionUtility.getData(req);
			LLog.info.println("session!!!"+ session.getAttribute("loginUser"));
		    
		    //개인정보 세팅;
		    String newPassword  = passwordData.getString("newPassword");
		    String newPasswordConfirm = passwordData.getString("newPasswordConfirm");
		    
		    //PASSWORD ONE WAY enCRYPTING
		    OneWaySecurityUtil os = new OneWaySecurityUtil();
		    String oneWayEncryptNewPassword = os.encryptPassword(newPassword);
		    LLog.info.println("receieved password = "+ oneWayEncryptNewPassword);
		    
		    // 기존패스워드와 동일할 경우
		    if(loginUser.getString("userPw").equals(oneWayEncryptNewPassword)){
		    	LLog.info.println("Password is not changed");
		    	validation = "01";
		    	loginUser.setString("pwValidation", validation);
		    	returnUrl = "pwchange.jsp";
		    	LNavigationAlter.setReturnUrl(req, returnUrl);
		    }
		    //암호 규칙을 따르지 않을 경우
		    else if(!checkPassword(newPassword) && !checkPassword(newPasswordConfirm)){
		    	LLog.info.println("Password rule invalidation");
		    	validation = "02";
		    	loginUser.setString("pwValidation", validation);
		    	returnUrl = "pwchange.jsp";
		    	LNavigationAlter.setReturnUrl(req, returnUrl);
		    }
		    
		    //두 패스워드가 동일한 경우
		    else if (!newPassword.equals(newPasswordConfirm)){
		    	LLog.info.println("Password and Password confirm is not same");
		    	validation = "03";
		    	loginUser.setString("pwValidation", validation);
		    	returnUrl = "pwchange.jsp";
		    	LNavigationAlter.setReturnUrl(req, returnUrl);
		    	
		    }
		    
		    //정상 입력
		    else{
		    //password update
		    loginUser.remove("userPw");
		    loginUser.set("userPw", oneWayEncryptNewPassword);
		    loginUser.setString("pwValidCode", "true");
		    UserMgntBiz biz = new UserMgntBiz();
		    LMultiData userData = new LMultiData();
		    userData.addLData(loginUser);
		    biz.userInfoUpdate(userData);
		    biz.updatePasswordChangedDate(userData);
		    validation ="99";
		    loginUser.setString("pwValidation", validation);
		    returnUrl = "pwchange.jsp";
		    LNavigationAlter.setReturnUrl(req, returnUrl);
		    
		    }

			LLog.info.write("\n PasswordChangeWhenLoginCmd --> End \n");
		} catch (Exception e) {
			throw new LException(e.getMessage());
		}
	} 
	
	
	
	 /**
	 * 영문자+숫자+10자리 이상,  영문자+숫자+특수문자+8자리 이상의 경우 true return
	 *  ( 영문 + 숫자 + 특수문자 = 8글자 이상 ) 
	 * @param password 
	 * @return boolean 
	 * private String validationMessate = ""; 
	 */
	private boolean checkPassword(String password){
		  
		   String regex_alpha = ".*[a-zA-Z]+.*";	//영문자 체크
		   String regex_number = ".*[0-9]+.*";	//숫자 체크
		   String regex_special = ".*\\W+.*";	//특수문자 체크
		   
		   if(password.length()<8){
			   validationMessage = "The length of Password have to more than 8";
			   return false;
		   }
		   		   
		   if(password.length()>=8 && 
		     Pattern.matches(regex_alpha , password) &&       // 영문자 포함체크
		     Pattern.matches(regex_number , password) &&     // 숫자 포함체크
		     Pattern.matches(regex_special , password) &&     // 특수문자 포함체크
		     sameWordCheck(password)&&                          // 동일문자 체크 ex)111, aaa
		     serialWordCheck(password)){                           // 연속문자 체크 ex)123, abc, 321
			   return true;
		   }else{
			   validationMessage = "Password have to be..\n" +
		   		"1. More than 8 characters\n" +
		   		"2. Character(s) + Number(s) + Special character(s)\n" +
		   		"3. Non sequancial character \t\tex) abc, 123\n" +
		   		"4. Not allowed continuous character \tex) aa, 55\n";
			   return false;
		   }
		  
	}

	private static boolean sameWordCheck(String password) {
		for(int i=0; i<password.length()-2; i++){
			if(password.charAt(i)==password.charAt(i+1) && password.charAt(i+1) == password.charAt(i+2)){
				return false;
			}
		}
		return true;
	}

	private static boolean serialWordCheck(String password) {
		for(int i=0; i<password.length()-2; i++){
			if( Math.abs(password.charAt(i+1) - password.charAt(i))  == Math.abs(password.charAt(i+2) - password.charAt(i+1)) && 
				Math.abs(password.charAt(i+1) - password.charAt(i)) == 1	){
				return false;
			}
		}
		return true;
	} 
	
 }

   