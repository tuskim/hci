package cm.cd.cmd;

/* ------------------------------------------------------------------------
 * @source  : VendorDetailMgntCmd.java
 * @desc    : Vendor Detail CUD
 * ------------------------------------------------------------------------
 *
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2010.08.30   임민수                   Initial
 * ------------------------------------------------------------------------ */


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cm.cd.biz.PopupBiz;

import com.gauce.GauceDataSet;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.log.LLog;
import devonframework.bridge.gauce.command.LGauceCommandIF;
import devonframework.bridge.gauce.util.LGauceConverter;

public class VendorDetailMgntCmd implements LGauceCommandIF {

	public void execute(HttpServletRequest req, HttpServletResponse res, 
	        GauceRequest gauceRequest, GauceResponse gauceResponse) throws Exception {
				
		LLog.debug.write("VendorDetailMgntCmd inputData--------------- Start \n");
	
		GauceDataSet userGdsMst = gauceRequest.getGauceDataSet("IN_DS1");
		
		
		String getErrorCode = "";
	    String getMessage   = "";
		
		if(userGdsMst == null ){
			LLog.debug.write("VendorDetailMgntCmd : DS_GRID   Null Point Error! \n");
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
		LLog.debug.println("VendorDetailMgntCmd inputData Mst--------------- =>\n " + mDataMst.toString());
	
		PopupBiz biz = new PopupBiz();
		
		biz.cudVendorDetail(mDataMst,  loginUser, req);		
		 
		 LLog.debug.write("VendorDetailMgntCmd inputData--------------- End \n");
	
	}
}