/* ------------------------------------------------------------------------
 * @source  : RetrieveReceiptListGauCmd.java
 * @desc    : 입고 목록 가져옴
 * ------------------------------------------------------------------------
 *
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2010.08.27   임민수                   Initial
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

public class RetrieveReceiptMstListGauCmd implements LGauceCommandIF {

    public void execute(HttpServletRequest req, HttpServletResponse res, GauceRequest gauceRequest, GauceResponse gauceResponse) throws Exception {
    	
    	
		LLog.info.write("\n RetrieveReceiptMstListGauCmd --> Start \n");		

		GauceDataSet gds = new GauceDataSet();
		gauceResponse.enableFirstRow(gds);
		
		LData inputData = LXssCollectionUtility.getData(req);

		long  getErrorCode = 0 ;
        String getMessage   = "";
        
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
	    
	    //회사코드 추가.`
	    inputData.setString("companyCd",loginUser.getString("companyCd"));
	    inputData.setString("lang",     loginUser.getString("lang"));
	    inputData.setString("deptCd", 	loginUser.getString("deptCd"));
	    
	    ReceiptMgntBiz biz = new ReceiptMgntBiz();
		LMultiData result = biz.retrieveReceiptMasterList(inputData);
		
		LLog.info.write("\n RetrieveReceiptMstListGauCmd result:" + result.toString());		

	    LGauceConverter.extractToGauceDataSet(result, gds);
	    gds.flush();
	    
		LLog.info.write("\n RetrieveReceiptMstListGauCmd --> End \n");		
		
		
    }
    


    
}


