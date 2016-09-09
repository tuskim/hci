/* ------------------------------------------------------------------------
 * @source  : UserCUDGauCmd.java
 * @desc    : 사용자 저장,수정,삭제
 * ------------------------------------------------------------------------
 *
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2010.07.23                      Initial
 * 1.1  2014.04.14    한재우	  CSR:C20140414_23324
 * 1.2  2015.03.05     hskim	  CSR:C20150303_16909 관리자 로그 생성
 * 1.3  2015.04.20     hskim	  CSR:C20150417_55794 관리자 로그 Level 변경 (info -> Debug)
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
import comm.util.OneWaySecurityUtil;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.log.LLog;
import devonframework.bridge.gauce.command.LGauceCommandIF;
import devonframework.bridge.gauce.util.LGauceConverter;

public class CudUserMgntCmd implements LGauceCommandIF {

	private String validationMessage = "";
	
    public void execute(HttpServletRequest req, HttpServletResponse res, GauceRequest gauceRequest, GauceResponse gauceResponse) throws Exception {

    	LLog.info.write("\n CudUserMgntCmd --> Start \n");	
    	
    	UserMgntBiz biz = new UserMgntBiz();

		GauceDataSet 	dsParam = gauceRequest.getGauceDataSet("ds_param");
		GauceDataSet 	dsGrid 	= gauceRequest.getGauceDataSet("ds_grid");
		
		long getErrorCode = 0;
	
		if( dsGrid != null ) {
			// 사용자 관리
			LMultiData lmData 	= LGauceConverter.convertToLMultiDataWithJobType(dsGrid);
			
//			-------------------------------------- Session 종료시 처리 START
			HttpSession session = req.getSession(false);
			LData loginUser = new LData();
			
			if (session != null) loginUser = (LData)session.getAttribute("loginUser");
			if( loginUser.getString("userId") == null) {
				String getMessage = "Session is Terminated. You need to relogin!";
				gauceResponse.writeException("Error", "", "\n[Detail Msg]==>" + getMessage);
				return;
			}
			//-------------------------------------- Session 종료시 처리 END
			
			lmData.addLData(loginUser);
			
			OneWaySecurityUtil os = new OneWaySecurityUtil();
			for (int i = 0; i < lmData.getDataCount(); i++) {
				lmData.modifyString("userPw", i, os.encryptPassword("lgihci!"));
			}

			biz.userIf(lmData, req);

			// 2015.03.05 hskim CSR:C20150303_16909 관리자 로그 생성
			for (int i = 0; null != lmData && i < lmData.getDataCount(); i++) {
				LData rowData = lmData.getLData(i);

				// 등록
				if ("DEVON_CREATE_FILTER_VALUE".equals(rowData
						.getString("DEVON_CUD_FILTER_KEY"))) {
					if (loginUser.getString("authCd").equals("AD")) {

						String admLog = "\n";
						String currentTimeStr = new SimpleDateFormat(
								"yyyyMMddhhmmss").format(new java.util.Date());

						admLog = admLog + currentTimeStr + "|" // 현재시간
								+ "AuditLog" + "|" // Log 유형
								+ req.getHeader("Proxy-Client-IP") + "|" // IP
								+ loginUser.getString("userId") + "|" // 사용자 ID
								+ "Create" + "|" // 행위 구분
								+ "HCI 시스템" + "|" // 시스템
								+ "CudUserMgntCmd" + "|" // Command
								+ "userMgnt.jsp" // Return URL
						;

						LLog.debug.write(admLog);
					}
				}
				// 수정
				else if ("DEVON_UPDATE_FILTER_VALUE".equals(rowData
						.getString("DEVON_CUD_FILTER_KEY"))) {

					if (loginUser.getString("authCd").equals("AD")) {

						String admLog = "\n";
						String currentTimeStr = new SimpleDateFormat(
								"yyyyMMddhhmmss").format(new java.util.Date());

						admLog = admLog + currentTimeStr + "|" // 현재시간
								+ "AuditLog" + "|" // Log 유형
								+ req.getHeader("Proxy-Client-IP") + "|" // IP
								+ loginUser.getString("userId") + "|" // 사용자 ID
								+ "Modify" + "|" // 행위 구분
								+ "HCI 시스템" + "|" // 시스템
								+ "CudUserMgntCmd" + "|" // Command
								+ "userMgnt.jsp" // Return URL
						;

						LLog.debug.write(admLog);
					}
				}
			}
		}

		GauceDataSet gauDsRes = new GauceDataSet("ds_grid");
		LData lData = null;

		if (dsParam != null) {
			lData = LGauceConverter.convertToLDataWithJobType(dsParam);

		}

		gauceResponse.enableFirstRow(gauDsRes);
		LGauceConverter.extractToGauceDataSet(biz.retrieveUserList(lData),
				gauDsRes);
		gauDsRes.flush();

		LLog.info.println("\n CudUserMgntCmd --> End \n");
	}//패스워드	
}


