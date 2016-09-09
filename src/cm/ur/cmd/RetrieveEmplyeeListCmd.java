/* ------------------------------------------------------------------------
 * @source  : RetrieveEmplyeeList.java
 * @desc    : 사원정보 조회
 * ------------------------------------------------------------------------
 *
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2010.09.01  hskim                   Initial
 * ------------------------------------------------------------------------ */

package cm.ur.cmd;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cm.ur.biz.UserMgntBiz;

import com.gauce.GauceDataSet;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import comm.util.LXssCollectionUtility;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.log.LLog;
import devonframework.bridge.gauce.command.LGauceCommandIF;
import devonframework.bridge.gauce.util.LGauceConverter;

public class RetrieveEmplyeeListCmd implements LGauceCommandIF {

    public void execute(HttpServletRequest req, HttpServletResponse res, GauceRequest gauceRequest, GauceResponse gauceResponse) throws Exception {
    	
    	
    	LLog.info.write("\n RetrieveEmplyeeListCmd --> Start \n");	
		
		//-------------------------------------- Session 종료시 처리 START
		HttpSession session = req.getSession(false);
		LData loginUser = new LData();
		
		if (session != null) loginUser = (LData)session.getAttribute("loginUser");
		if( loginUser.getString("userId") == null) {
			String getMessage = "Session is Terminated. You need to relogin!";
			gauceResponse.writeException("Error", "", "\n[Detail Msg]==>" + getMessage);
			return;
		}
		//-------------------------------------- Session 종료시 처리 END
		
		//search condition parameter
		LData inputData = LXssCollectionUtility.getData( req );
		
		inputData.setString("lang", loginUser.getString("lang"));
		inputData.setString("companyCd", loginUser.getString("companyCd"));
		
		GauceDataSet gds = new GauceDataSet();  
		gauceResponse.enableFirstRow(gds);

		UserMgntBiz biz = new UserMgntBiz();
		
		LMultiData resultData = new LMultiData();
		
		resultData = biz.retrieveEmplyoeeList(inputData);

		//result return
		LGauceConverter.extractToGauceDataSet(resultData, gds);
		gds.flush();
		
		LLog.info.write("\n RetrieveEmplyeeListCmd --> End \n");
   			
    }
    
}


