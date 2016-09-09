/* ------------------------------------------------------------------------
 * @source  : RetrieveProdSalesHistoryCmd.java
 * @desc    : prodcutin & sales 입력현황조회
 * ------------------------------------------------------------------------
 *
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2011.02.09                     Initial
 * ------------------------------------------------------------------------ */

package fi.ar.cmd;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gauce.GauceDataSet;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import comm.util.LXssCollectionUtility;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.log.LLog;
import devonframework.bridge.gauce.command.LGauceCommandIF;
import devonframework.bridge.gauce.util.LGauceConverter;
import fi.ar.biz.ConDocHistoryBiz;

public class RetrieveConDocHistoryCmd  implements LGauceCommandIF {

    public void execute(HttpServletRequest req, HttpServletResponse res, GauceRequest gauceRequest, GauceResponse gauceResponse) throws Exception {
    	
    	
    	LLog.info.write("\n RetrieveConDocHistoryCmd --> Start \n");	
		
    	ConDocHistoryBiz biz = new ConDocHistoryBiz();
		GauceDataSet 	dsMain 	= new GauceDataSet("ds_main");
		GauceDataSet 	dsParam 	= gauceRequest.getGauceDataSet("ds_param");
	
		LData lData = null;


		if( null == dsParam ) {
			lData	= LXssCollectionUtility.getData(req);	
		}else{
			lData 	= LGauceConverter.convertToLDataWithJobType(dsParam);
		}

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
	
		lData.setString("lang", loginUser.getString("lang"));
		lData.setString("companyCd", loginUser.getString("companyCd"));

		LMultiData result = new LMultiData();
		result= biz.retrieveConDocHistory(lData);
		
		gauceResponse.enableFirstRow( dsMain );
		LGauceConverter.extractToGauceDataSet( result,dsMain );
		dsMain.flush();
		
		LLog.info.write("\n RetrieveConDocHistoryCmd --> End \n");
   			
    }
    
    
   
}


