/* ------------------------------------------------------------------------
 * @source  : UserRetrieveGauCmd.java
 * @desc    : 사용자목록을 가져옴
 * ------------------------------------------------------------------------
 *
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2009.06.23                      Initial
 * 1.1  2015.03.04   hskim                  CSR:C20150303_16909 관리자 로그 생성
 * 1.2  2015.04.20   hskim                  CSR:C20150417_55794 관리자 로그 Level 변경 (info -> Debug)
 * ------------------------------------------------------------------------ */

package cm.ur.cmd;


import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cm.ur.biz.UserMgntBiz;

import com.gauce.GauceDataSet;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import comm.util.LXssCollectionUtility;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.log.LLog;
import devonframework.bridge.gauce.command.LGauceCommandIF;
import devonframework.bridge.gauce.util.LGauceConverter;

public class RetrieveUserMgntCmd implements LGauceCommandIF {

    public void execute(HttpServletRequest req, HttpServletResponse res, GauceRequest gauceRequest, GauceResponse gauceResponse) throws Exception {
    	
    	
    	LLog.info.write("\n RetrieveUserMgntCmd --> Start \n");	
		
		UserMgntBiz   biz = new UserMgntBiz();
		GauceDataSet 	dsGrid 	= new GauceDataSet("ds_grid");
		GauceDataSet 	dsParam 	= gauceRequest.getGauceDataSet("ds_param");
	
		LData lData = null;


		if( null == dsParam ) {
			lData	= LXssCollectionUtility.getData(req);
			
		}else{
			lData 	= LGauceConverter.convertToLDataWithJobType(dsParam);
		}
    

		//-------------------------------------- Session 종료시 처리 START
		HttpSession session = req.getSession(false);
		LData loginUser = new LData();
		
		if (session != null) loginUser = (LData)session.getAttribute("loginUser");
		if( loginUser.getString("userId") == null) {
			String getMessage = "Session is Terminated. You need to relogin!";
			gauceResponse.writeException("Error", "", "\n[Detail Msg]==>" + getMessage);
			return;
		}
		
/*		 //password 암호화
		LLog.info.println("passowrd 일방향 암호화 시작");
        PasswordEncryptTypeChangeBiz bb = new PasswordEncryptTypeChangeBiz();
        bb.changePasswordEncryptType(loginUser);
        LLog.info.println("password 일방향 암호화 끝");*/
		//-------------------------------------- Session 종료시 처리 END
		lData.set("companyCd", loginUser.get("companyCd"));
		lData.set("lang", loginUser.get("lang"));

		
		
		LMultiData result = new LMultiData();
		result = biz.retrieveUserList(lData);

		
		gauceResponse.enableFirstRow( dsGrid );
		LGauceConverter.extractToGauceDataSet(result , dsGrid );
		dsGrid.flush();

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
			                   + "Search" + "|"                                                   //행위 구분
			                   + "HCI 시스템" + "|"                                    //시스템
			                   + "RetrieveUserMgntCmd" + "|"                       //Command
			                   + "userMgnt.jsp"                                         //Return URL
			                   ;
			  
			LLog.debug.write(admLog);
		}
		  
		
		LLog.info.write("\n RetrieveUserMgntCmd --> End \n");
   			
    }
    
}


