/* ------------------------------------------------------------------------
 * @source  : RetrieveCustomerCreditListCmd.java
 * @desc    : 여신한도관리 List
 * ------------------------------------------------------------------------
 *
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2015.11.16   jwhan	            C20151030_07129 여신한도관리
 * ------------------------------------------------------------------------ */
package sd.sc.cmd;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import rfc.biz.RetrieveCustomerCreditLimitRFC;
import sd.sc.biz.CustomerCreditBiz;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataSet;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import comm.util.LXssCollectionUtility;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.log.LLog;
import devonframework.bridge.gauce.command.LGauceCommandIF;
import devonframework.bridge.gauce.util.LGauceConverter;

public class RetrieveCustomerCreditListCmd implements LGauceCommandIF{

	public void execute(HttpServletRequest req, HttpServletResponse res, GauceRequest gauceRequest, GauceResponse gauceResponse) throws Exception {
		
		LLog.debug.write("RetrieveVendorCreditListCmd --> Start");
		GauceDataSet gds = new GauceDataSet();
 
		gauceResponse.enableFirstRow(gds);
		
		gds.addDataColumn( new GauceDataColumn( "companyCd" , GauceDataColumn.TB_STRING  , 5  ) ); // Company
        gds.addDataColumn( new GauceDataColumn( "customerCd" , GauceDataColumn.TB_STRING  , 10   ) ); // Customer Code
        gds.addDataColumn( new GauceDataColumn( "customerNm" , GauceDataColumn.TB_STRING  , 100   ) ); // Customer Name
        gds.addDataColumn( new GauceDataColumn( "clAvailable" , GauceDataColumn.TB_DECIMAL  , 15,2  ) ); // 여신 잔액
        gds.addDataColumn( new GauceDataColumn( "cl" , GauceDataColumn.TB_DECIMAL  , 15, 2   ) ); // 여신 한도
        gds.addDataColumn( new GauceDataColumn( "clExposure" , GauceDataColumn.TB_DECIMAL  ,15, 2 ) ); // 여신 금액
        gds.addDataColumn( new GauceDataColumn( "SSOBL" , GauceDataColumn.TB_DECIMAL  ,15, 2 ) ); // 선수금
        gds.addDataColumn( new GauceDataColumn( "SKFOR" , GauceDataColumn.TB_DECIMAL  ,15, 2 ) ); // 채권(AR)
        gds.addDataColumn( new GauceDataColumn( "WAERS" , GauceDataColumn.TB_STRING  ,5 ) ); // 통화코드
        gds.addDataColumn( new GauceDataColumn( "OPEN_SALES" , GauceDataColumn.TB_DECIMAL  ,15,2 ) ); // Open Sales (Sales Value)
        gds.addDataColumn( new GauceDataColumn( "OPEN_SALES_WEB" , GauceDataColumn.TB_DECIMAL  ,15,2 ) ); // Open Sales (WEB)
        gds.addDataColumn( new GauceDataColumn( "DATAB" , GauceDataColumn.TB_STRING  ,10 ) ); // Start Date
        gds.addDataColumn( new GauceDataColumn( "DATBI" , GauceDataColumn.TB_STRING  ,10 ) ); // End Date

		
		
		LData lData = LXssCollectionUtility.getData(req);
		
		LLog.info.println("inputData from JSP  == \n"+lData);
		
		long  getErrorCode = 0 ;
        String getMessage   = "";
        
//      -------------------------------------- Session 종료시 처리 START
	    HttpSession session = req.getSession(false);
	    LData loginUser = new LData();
	    
	    if (session != null) loginUser = (LData)session.getAttribute("loginUser");
	    if( loginUser.getString("userId") == null) {
	    	getMessage = "Session is Terminated. You need to relogin!";
	    	gauceResponse.writeException("Error", String.valueOf(getErrorCode), "\n[Detail Msg]==>" + getMessage);
	    	
	    	return;
	    }
	   
		loginUser = (LData) session.getAttribute("loginUser");	
		lData.setString("lang", loginUser.getString("lang"));
		lData.setString("companyCd", loginUser.getString("companyCd"));
		
		
		//retreive list
		CustomerCreditBiz biz = new CustomerCreditBiz();
		LMultiData result = biz.retrieveCustomerCreditList(lData);
		
		//send to jsp
		LGauceConverter.convertToGauceDataSet(result,gds);
		gds.flush();
		
		LLog.debug.write("RetrieveVendorCreditListCmd --> END");
		
	}
}
