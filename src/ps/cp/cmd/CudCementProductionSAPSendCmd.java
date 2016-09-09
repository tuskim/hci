/* ------------------------------------------------------------------------
 * @source  : CudCementProductionSAPSendCmd.java
 * @desc    : Cement Production SAP Send
 * ------------------------------------------------------------------------
 *
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2016.08.02   kjkim               Initial
 * ------------------------------------------------------------------------ */

package ps.cp.cmd;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ps.cp.biz.CementProductionBiz;

import com.gauce.GauceDataSet;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import comm.util.LXssCollectionUtility;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LException;
import devon.core.log.LLog;
import devonframework.bridge.gauce.command.LGauceCommandIF;
import devonframework.bridge.gauce.util.LGauceConverter;


public class CudCementProductionSAPSendCmd implements LGauceCommandIF {

    /**
     * 
     *
     * @param req Http Request 객체.
     * @param res Http Response 객체.
     * @param gauceRequest 가우스 Request 객체.
     * @param gauceResponse 가우스 Response 객체.
     * @exception LException Commnad 단 이하의 모든 에러.
     */
	public void execute(HttpServletRequest req, HttpServletResponse res, 
            GauceRequest gauceRequest, GauceResponse gauceResponse) throws LException {
		
		LLog.debug.write("CudCementProductionSAPSendCmd ------------ START");

		GauceDataSet ds_master = gauceRequest.getGauceDataSet("IN_DS1");
		
		LData inputData = LXssCollectionUtility.getData(req);
		LLog.debug.write("CudCementProductionSAPSendCmd inputData ---------------> =>\n " + inputData.toString());
		
		LData resultData = new LData();
		long   getErrorCode = 0 ;
		String getMessage   = "";
	
		
		if(ds_master == null )	return;
		
		//-------------------------------------- Session 종료시 처리 START
	    HttpSession session = req.getSession(false);
	    LData loginUser = new LData();
	    
	    if (session != null) loginUser = (LData)session.getAttribute("loginUser");
	    if( loginUser.getString("userId") == null) {
	    	getMessage = "Session is Terminated. You need to relogin!";
	    	gauceResponse.writeException("Error","", getMessage);
	    	return;
	    }
	    //-------------------------------------- Session 종료시 처리 END

		LMultiData mData = LGauceConverter.convertToLMultiDataWithJobType(ds_master);
		LLog.debug.write("CudCementProductionSAPSendCmd HEADER 자료~~~~ ---------------> =>\n " + mData.toString());

		CementProductionBiz biz = new CementProductionBiz();
		resultData = biz.CudCementProductionSapSend(mData, loginUser);
		
		getErrorCode = resultData.getLong("getErrorCode");
		getMessage	 = resultData.getString("getMessage");
		
		 if (getErrorCode != 00 && getErrorCode != -999999) {             
             if (getMessage == null) getMessage = "";
             
             gauceResponse.writeException("Error", String.valueOf(getErrorCode), "\n[Detail Msg]==>" + getMessage);
         }
		
		LLog.debug.write("CudCementProductionSAPSendCmd ------------ END");
	
	}
}