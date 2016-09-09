/* ------------------------------------------------------------------------
 * @source  : UserRetrieveGauCmd.java
 * @desc    : 사용자목록을 가져옴
 * ------------------------------------------------------------------------
 *
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2009.06.23                      Initial
 * ------------------------------------------------------------------------ */


package cm.cm.cmd;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cm.cm.biz.CodeMgntBiz;

import com.gauce.GauceDataSet;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import comm.util.LXssCollectionUtility;

import devon.core.collection.LData;
import devon.core.log.LLog;
import devonframework.bridge.gauce.command.LGauceCommandIF;
import devonframework.bridge.gauce.util.LGauceConverter;

public class RetrieveMaterialMasterListCmd  implements LGauceCommandIF {

    public void execute(HttpServletRequest req, HttpServletResponse res, GauceRequest gauceRequest, GauceResponse gauceResponse) throws Exception {
    	
    	
    	LLog.info.write("\n RetrieveMaterialMasterListCmd --> Start \n");	
    	
		
		CodeMgntBiz  biz = new CodeMgntBiz();
		GauceDataSet 	dsGrid 	= new GauceDataSet("ds_grid");
	
		LData lData = null;
		lData	= LXssCollectionUtility.getData(req);
			
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
		

		gauceResponse.enableFirstRow( dsGrid );
		LGauceConverter.extractToGauceDataSet( biz.retrieveMaterialMasterList(lData), dsGrid );
		dsGrid.flush();
		
		LLog.info.write("\n RetrieveMaterialMasterListCmd --> End \n");
    }
    
}


