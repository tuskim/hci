/* ------------------------------------------------------------------------
 * @source  : CudStockIssueListCmd.java
 * @desc    : 출고등록
 * ------------------------------------------------------------------------
 *
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2010.08.11   최용락                   Initial
 * ------------------------------------------------------------------------ */

package po.ir.cmd;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import po.ir.biz.InvoiceRegBiz;

import com.gauce.GauceDataSet;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import comm.util.LXssCollectionUtility;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.log.LLog;
import devonframework.bridge.gauce.command.LGauceCommandIF;
import devonframework.bridge.gauce.util.LGauceConverter;


public class CudInvoiceCancelCmd implements LGauceCommandIF {

	public void execute(HttpServletRequest req, HttpServletResponse res, 
	        GauceRequest gauceRequest, GauceResponse gauceResponse) throws Exception {
				
		LLog.debug.write("CudInvoiceCancelCmd inputData--------------- Start \n");
		
		GauceDataSet userGdsMst = gauceRequest.getGauceDataSet("IN_DS1");
		GauceDataSet userGdsDtl = gauceRequest.getGauceDataSet("IN_DS2");
		GauceDataSet userGdsTax = gauceRequest.getGauceDataSet("IN_DS3");
		
		LData resultData = new LData();
		
		String getErrorCode = "";
	    String getMessage   = "";
		
		if(userGdsMst == null || userGdsDtl == null ){
			LLog.debug.write("CudInvoiceCancelCmd : DS_GRID   Null Point Error! \n");
			return;
		}
		
		//-------------------------------------- Session 종료시 처리 START
	    HttpSession session = req.getSession(false);
	    LData loginUser = new LData();
		LData lData = LXssCollectionUtility.getData(req);
		
	    if (session != null) loginUser = (LData)session.getAttribute("loginUser");
	    lData.setString("lang", loginUser.getString("lang"));
		lData.setString("companyCd", loginUser.getString("companyCd"));
		lData.setString("userId", loginUser.getString("userId"));
			    
	    if( loginUser.getString("userId") == null) {
	    	getMessage = "Session is Terminated. You need to relogin!";
	    	gauceResponse.writeException("Error", String.valueOf(getErrorCode), "\n[Detail Msg]==>" + getMessage);
	    	return;
	    }
	    //-------------------------------------- Session 종료시 처리 END
		
		LMultiData mDataMst = LGauceConverter.convertToLMultiDataWithJobType(userGdsMst);
		LMultiData mDataDtl = LGauceConverter.convertToLMultiDataWithJobType(userGdsDtl);
		LMultiData mDataTax = LGauceConverter.convertToLMultiDataWithJobType(userGdsTax);
		LLog.debug.println("CudInvoiceCancelCmd inputData Mst--------------- =>\n " + mDataMst.toString());
		LLog.debug.println("CudInvoiceCancelCmd inputData Dtl --------------- =>\n " + mDataDtl.toString());
		LLog.debug.println("CudInvoiceCancelCmd inputData tax --------------- =>\n " + mDataTax.toString());
	
		InvoiceRegBiz biz = new InvoiceRegBiz();
		
		resultData = biz.cudInvoiceCancel(mDataMst, mDataDtl, mDataTax, lData);		
		 
		getErrorCode = resultData.getString("getErrorCode");
		getMessage	 = resultData.getString("getMessage");
		
		 if (!getErrorCode.equals("0") && !getErrorCode.equals("-999999")) {             
	         if (getMessage == null) getMessage = "";
	         
	         gauceResponse.writeException("Error", String.valueOf(getErrorCode), "\n[Detail Msg]==>" + getMessage);
	     }
	
		 LLog.debug.write("CudInvoiceCancelCmd inputData--------------- End \n");
	
	}
}