/* ------------------------------------------------------------------------
 * @source  : CudReceiptMgntCmd.java
 * @desc    : 입고등록
 * ------------------------------------------------------------------------
 *
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2010.08.09   최용락                   Initial
 * ------------------------------------------------------------------------ */

package po.is.cmd;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import po.is.biz.ReceiptMgntBiz;

import com.gauce.GauceDataSet;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import comm.util.LXssCollectionUtility;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.log.LLog;
import devonframework.bridge.gauce.command.LGauceCommandIF;
import devonframework.bridge.gauce.util.LGauceConverter;

public class CudReceiptMgntCmd implements LGauceCommandIF {

	public void execute(HttpServletRequest req, HttpServletResponse res, 
	        GauceRequest gauceRequest, GauceResponse gauceResponse) throws Exception {
				
		LLog.debug.write("CudReceiptMgntCmd inputData--------------- Start \n");
	
		GauceDataSet userGds = gauceRequest.getGauceDataSet("IN_DS1");
		
		LData resultData = new LData();
		
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
		LLog.debug.println("CudProgMgntCmd inputData--------------- =>\n " + mData.toString());
	
		ReceiptMgntBiz biz = new ReceiptMgntBiz();
		resultData = biz.cudReceiptMgnt(mData, loginUser); 
		
		getErrorCode = resultData.getLong("getErrorCode");
		getMessage	 = resultData.getString("getMessage");
		
		 if (getErrorCode != 0 && getErrorCode != -999999) {             
	         if (getMessage == null) getMessage = "";
	         
	         gauceResponse.writeException("Error", String.valueOf(getErrorCode), "\n[Detail Msg]==>" + getMessage);
	     }
	
		 LLog.debug.write("CudSafetyStockMgntCmd inputData--------------- End \n");
	
	}
}