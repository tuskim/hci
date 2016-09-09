package fi.at.cmd;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import cm.ur.biz.UserMgntBiz;
import com.gauce.GauceDataSet;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import devon.core.collection.LData;
import devon.core.exception.LException;
import devon.core.log.LLog;
import devonframework.bridge.gauce.command.LGauceCommandIF;
import devonframework.bridge.gauce.util.LGauceConverter;
import devonframework.front.channel.LNavigationAlter;
import fi.at.biz.AssetBiz;

public class RetrieveAssetNoRequestCheckCmd implements LGauceCommandIF {

	/**
     * @param req Http Request 객체.
     * @param res Http Response 객체.
     * @param gauceRequest 가우스 Request 객체.
     * @param gauceResponse 가우스 Response 객체.
     * @exception LException Commnad 단 이하의 모든 에러.
     */
	public void execute(HttpServletRequest req, HttpServletResponse res, 
			GauceRequest gauceRequest, GauceResponse gauceResponse) throws LException {
		
		LLog.info.write("\n RetrieveAssetNoRequestCheckCmd --> Start \n");	
		
		GauceDataSet gsuDsReq = gauceRequest.getGauceDataSet("ds_param");
		GauceDataSet gauDsRes = new GauceDataSet("ds_assetNoCheckResult");
		
		LData lData = new LData();
		
		if(gsuDsReq != null) {
			lData = LGauceConverter.convertToLDataWithJobType(gsuDsReq);
		}
		
		//-------------------------------------- Session 종료시 처리 START
  		HttpSession session = req.getSession(false);
  		LData loginUser = new LData();
  		
  		long  getErrorCode = 0 ;
        String getMessage   = "";
  		
  		if (session != null) loginUser = (LData)session.getAttribute("loginUser");
  		if( loginUser.getString("userId") == null) {
  			getMessage = "Session is Terminated. You need to relogin!";
  			gauceResponse.writeException("Error", String.valueOf(getErrorCode), "\n[Detail Msg]==>" + getMessage);
  			LNavigationAlter.setReturnUrl(req, "/index.jsp");
  			return;
  		}
  		//-------------------------------------- Session 종료시 처리 END
	    
	    // Session 값 추가.
  		lData.setString("companyCd", loginUser.getString("companyCd"));
	    lData.setString("lang", 	 loginUser.getString("lang"));	 	
	    
	    LLog.info.write("===============  자산번호 - 매각, 폐기 신청 여부 (중복) 확인 Param  ================");
	    LLog.info.write("assetNo:"+lData.getString("assetNo"));
	    LLog.info.write("companyCd:"+lData.getString("companyCd"));
	    LLog.info.write("====================================================================================");

		AssetBiz biz = new AssetBiz();
		
		gauceResponse.enableFirstRow(gauDsRes);
		LGauceConverter.extractToGauceDataSet(biz.retrieveAssetNoRequestCheck(lData), gauDsRes);
		gauDsRes.flush();		
		
		LLog.info.write("\n RetrieveAssetNoRequestCheckCmd --> End \n");
	}
}
