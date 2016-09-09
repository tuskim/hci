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

public class CudReceiptSAPCancelCmd implements LGauceCommandIF {

	public void execute(HttpServletRequest req, HttpServletResponse res, 
	        GauceRequest gauceRequest, GauceResponse gauceResponse) throws Exception {
				
		LLog.debug.write("CudReceiptSAPCancelCmd inputData--------------- Start \n");
	
		GauceDataSet userGdsMst = gauceRequest.getGauceDataSet("IN_DS1");
		GauceDataSet userGdsDtl = gauceRequest.getGauceDataSet("IN_DS2");
		
		LData resultData = new LData();
		
		String getErrorCode = "";
	    String getMessage   = "";
		
		if(userGdsMst == null || userGdsDtl == null ){
			LLog.debug.write("CudReceiptSAPCancelCmd : DS_GRID   Null Point Error! \n");
			return;
		}
		
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
		
		LMultiData mDataMst = LGauceConverter.convertToLMultiDataWithJobType(userGdsMst);
		LMultiData mDataDtl = LGauceConverter.convertToLMultiDataWithJobType(userGdsDtl);
		LLog.debug.println("CudReceiptSAPCancelCmd inputData Mst--------------- =>\n " + mDataMst.toString());
		LLog.debug.println("CudReceiptSAPCancelCmd inputData Dtl --------------- =>\n " + mDataDtl.toString());
	
		ReceiptMgntBiz biz = new ReceiptMgntBiz();
		
		for(int i=0; i<mDataMst.getDataCount(); i++){
			if(mDataMst.getString("chk", i).equals("T")){			// 취소는 Single로 하므로 하나만 전달함
				resultData = biz.cudReceiptSAPCancel(mDataMst.getLData(i), mDataDtl, loginUser);		
			}
		}
		 
		getErrorCode = resultData.getString("getErrorCode");
		getMessage	 = resultData.getString("getMessage");
		
		 if (!getErrorCode.equals("0") && !getErrorCode.equals("-999999")) {             
	         if (getMessage == null) getMessage = "";
	         
	         gauceResponse.writeException("Error", String.valueOf(getErrorCode), "\n[Detail Msg]==>" + getMessage);
	     }
	
		 LLog.debug.write("CudReceiptSAPCancelCmd inputData--------------- End \n");
	
	}
}