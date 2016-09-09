/* ------------------------------------------------------------------------
 * @source  : RetrieveMaterialRequestCmd.java
 * @desc    : 신규 품목 마스터 등록 요청
 * ------------------------------------------------------------------------
 *
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2016.09.01                      Initial
 * ------------------------------------------------------------------------ */


package cm.cm.cmd;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cm.cm.biz.MaterRequestBiz;

import com.gauce.GauceDataSet;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import comm.util.LXssCollectionUtility;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.log.LLog;
import devonframework.bridge.gauce.command.LGauceCommandIF;
import devonframework.bridge.gauce.util.LGauceConverter;

public class RetrieveMaterialRequestCmd  implements LGauceCommandIF {

    public void execute(HttpServletRequest req, HttpServletResponse res, GauceRequest gauceRequest, GauceResponse gauceResponse) throws Exception {
    	
    	
    	LLog.info.write("\n RetrieveMaterialRequestCmd --> Start \n");	
    	
		
    	MaterRequestBiz  biz = new MaterRequestBiz();
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
		
	    LMultiData result = null;
	    if("new".equals(lData.getString("type"))) {
	    	result = biz.retrieveMaterialRequestAddRow(lData);
	    } else{
	    	result = biz.RetrieveMaterialRequestList(lData);
	    }
	    
	    LGauceConverter.extractToGauceDataSet(result, dsGrid);
		dsGrid.flush();
		
		LLog.info.write("\n RetrieveMaterialRequestCmd --> End \n");
    }
    
}


