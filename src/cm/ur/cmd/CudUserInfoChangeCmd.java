/* ------------------------------------------------------------------------
 * @source  : UserInfoUpdateCmd.java
 * @desc    : 사용자 개인정보 수
 * ------------------------------------------------------------------------
 *
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2010.                    		 Initial
 * 1.1  2014.04.14    JwHan			      CSR:C20140414_23324
 * 1.2  2014903       jwhan			     	  C20140825_97731
 * ------------------------------------------------------------------------ */

package cm.ur.cmd;

import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cm.lo.login.biz.commBiz;
import cm.ur.biz.UserMgntBiz;

import com.gauce.GauceDataSet;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import comm.util.OneWaySecurityUtil;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LException;
import devon.core.log.LLog;
import devonframework.bridge.gauce.command.LGauceCommandIF;
import devonframework.bridge.gauce.util.LGauceConverter;

public class CudUserInfoChangeCmd implements  LGauceCommandIF {
    /**
     * 
     *
     * @param req Http Request 객체.
     * @param res Http Response 객체.
     * @param gauceRequest 가우스 Request 객체.
     * @param gauceResponse 가우스 Response 객체.
     * @exception LException Commnad 단 이하의 모든 에러.
     */
	private String validationMessage = "";
	
	
	public void execute(HttpServletRequest req, HttpServletResponse res, GauceRequest gauceRequest, GauceResponse gauceResponse) throws Exception {
		
		try {
			LLog.info.write("\n CudUserInfoChangeCmd --> Start \n");	
			
			GauceDataSet userGds = gauceRequest.getGauceDataSet("ds_save");
			
			long   getErrorCode = 0 ;
			String getMessage   = "";
			
			if(userGds == null )
				return;
			
			//-------------------------------------- Session 종료시 처리 START
			HttpSession session = req.getSession(false);
			LData loginUser = new LData();
		
			if (session != null) loginUser = (LData)session.getAttribute("loginUser");
			if( loginUser.getString("userId") == null) {
			getMessage = "Session is Terminated. You need to relogin!";
			gauceResponse.writeException("Error", String.valueOf(getErrorCode), "\n[Detail Msg]==>" + getMessage);
				return;
			}
			//-------------------------------------- Session 종료시 처리 END

			LMultiData mData = LGauceConverter.convertToLMultiDataWithJobType(userGds);

		    mData.addString("lang", loginUser.getString("lang"));
		    mData.addString("companyCd", loginUser.getString("companyCd"));
		   
		    
		    
		    //개인정보 세팅
		    String newPw  = mData.getString("newPw", 0);
		    String userPw = mData.getString("userPw", 0);
		    
		    //PASSWORD ONE WAY DECRYPTING
		    OneWaySecurityUtil os = new OneWaySecurityUtil();
		    String oneWayEncryptNewPw = os.encryptPassword(newPw);
		    String oneWayEncryptUserPw = os.encryptPassword(userPw);
		    
		    //4 가지 case    == > start
	    	if(newPw == null || newPw.equals(""))//신규 패스워드 없음
	    	{
	    		 if( !oneWayEncryptUserPw.equals(loginUser.getString("userPw")))//신규패스워드 없음, 기존 pw 와 다른 경우.
	    		 {  LLog.info.println("Case1. 신규 패스워드 입력 안함, 기존 PW와 다름");
			    	gauceResponse.writeException("Error", String.valueOf(getErrorCode), "\n " + "Check the current password");
					return;
				    	
	    		 }else{//신규패스워드 없음 기존 pw 와 동일한 경우
	    			 LLog.info.println("Case2. 신규 패스워드 입력 안함, 기존 PW와 동일");
	    			mData.modifyString("userPw", 0, oneWayEncryptUserPw );
					//개인정보 수정		    	

					UserMgntBiz userMgntBiz = new UserMgntBiz();
					LLog.info.println("userMgntBiz.userInfoUpdate(mData)  ==> mData"+ mData);
					userMgntBiz.userInfoUpdate(mData); 
	    		 }
	    	}else{
	    		
	    		 commBiz commbiz = new commBiz();
	    		 loginUser.setString("userid" , loginUser.getString("userId") );
	    		 String checkCurrentUser =commbiz.retrieveUserInfo(loginUser).getString("userPw");
	    		 
	    		 if( !oneWayEncryptUserPw.equals(checkCurrentUser))//신규패스워드 O , 기존 pw 와 다른 경우.
	    		 {	LLog.info.println("Case3. 신규 패스워드 입력 , 기존 PW와 다름");
	    			gauceResponse.writeException("Error", String.valueOf(getErrorCode), "\n " + "Check the current password");
					return;				    	
	    		 }else{//신규패스워드 O , 기존 pw 와 동
	    			 LLog.info.println("Case4. 신규 패스워드 입력 , 기존 PW와 동일");
				    // 패스워드 룰 체크
				    if(!checkPassword(newPw)){
						gauceResponse.writeException("Error", String.valueOf(getErrorCode), "\n " + validationMessage);
						return;
				    }else{	
						//개인정보 수정
				    	mData.modifyString("userPw", 0, oneWayEncryptNewPw);
				    	UserMgntBiz userMgntBiz = new UserMgntBiz();
						userMgntBiz.userInfoUpdate(mData);
						userMgntBiz.updatePasswordChangedDate(mData);
					 }
	    		 }		    	
		    }

			LLog.info.write("\n CudUserInfoChangeCmd --> End \n");
		} catch (Exception e) {
			throw new LException(e.getMessage());
		} 
	} 
	

	 /**
	  * 영문자+숫자+10자리 이상,  영문자+숫자+특수문자+8자리 이상의 경우 true return
	  *  ( 영문 + 숫자 + 특수문자 = 8글자 이상 ) 
	 * @param password 
	 * @return boolean
	 * 
	 * 
	 * private String validationMessate = "";
	 * 
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

   