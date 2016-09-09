/* ------------------------------------------------------------------------
 * @source  : AccountManageCUDGauCmd.java
 * @desc    : 농장계정 필수 항목 등록
 * ------------------------------------------------------------------------
 *
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2010.08.                      Initial
 * ------------------------------------------------------------------------ */

package cm.cm.cmd;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cm.cm.biz.CodeMgntBiz;

import com.gauce.GauceDataSet;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.log.LLog;
import devonframework.bridge.gauce.command.LGauceCommandIF;
import devonframework.bridge.gauce.util.LGauceConverter;

public class CudAccountMgntCmd implements LGauceCommandIF {

    public void execute(HttpServletRequest req, HttpServletResponse res, GauceRequest gauceRequest, GauceResponse gauceResponse) throws Exception {

    	LLog.info.write("\n AccountManageCUDGauCmd --> Start \n");	
    	
    	CodeMgntBiz  biz = new CodeMgntBiz();

		GauceDataSet 	dsParam = gauceRequest.getGauceDataSet("ds_param");
		GauceDataSet 	dsGrid 	= gauceRequest.getGauceDataSet("ds_grid");

		if( dsGrid != null ) {
		
			LMultiData lmData 	= LGauceConverter.convertToLMultiDataWithJobType(dsGrid);
			
			setUserID(req, lmData, "DEVON_CUD_FILTER_KEY");
		
		
			biz.accountManageCud( lmData, req );
		} 
		GauceDataSet 	gauDsRes 	= new GauceDataSet("ds_grid");
		LData lData = null;

		if(dsParam != null) {
			lData 	= LGauceConverter.convertToLDataWithJobType(dsParam);
		
		} 

    
		LLog.info.write("\n AccountManageCUDGauCmd --> End \n");
    }

    
    private void setUserID(HttpServletRequest req, LMultiData lmData, String keyName) {

    	int rowCount = lmData.containsKey(keyName) ? lmData.getDataCount(keyName) : lmData.getDataCount();

    	
		 //-------------------------------------- Session 종료시 처리 START
	    HttpSession session = req.getSession(false);
	    LData loginUser = new LData();
	    
	    if (session != null) loginUser = (LData)session.getAttribute("loginUser");
	    if( loginUser.getString("userId") == null) {
	    	String getMessage = "Session is Terminated. You need to relogin!";
	    	return;
	    }
	    //-------------------------------------- Session 종료시 처리 END
		
	String userId = loginUser.getString("userId");
    	for (int i = 0; i < rowCount && i < 5000; i++) {
			lmData.add("userId", userId);
		}
    }
}