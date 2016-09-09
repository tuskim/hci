/* ------------------------------------------------------------------------
 * @source  : RetrieveLimestoneProductionListCmd.java
 * @desc    : Limestone Production List 조회
 * ------------------------------------------------------------------------
 *
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2016.08.02   kjkim               Initial
 * ------------------------------------------------------------------------ */

package ps.lp.cmd;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ps.lp.biz.LimestoneProductionBiz;

import com.gauce.GauceDataSet;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import comm.util.LXssCollectionUtility;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.log.LLog;
import devonframework.bridge.gauce.command.LGauceCommandIF;
import devonframework.bridge.gauce.util.LGauceConverter;

public class RetrieveLimestoneProductionListCmd implements LGauceCommandIF {

    public void execute(HttpServletRequest req, HttpServletResponse res, GauceRequest gauceRequest, GauceResponse gauceResponse) throws Exception {
    	
    	
		LLog.debug.write("RetrieveLimestoneProductionListCmd --> Start");
		
    	
		LimestoneProductionBiz biz = new LimestoneProductionBiz();
		GauceDataSet 	dsGrid 	= new GauceDataSet("dsList");
	
		LData lData = null;
	
		lData	= LXssCollectionUtility.getData(req);
			
		HttpSession session = req.getSession();
		LData loginUser = (LData) session.getAttribute("loginUser");	
		lData.setString("lang", loginUser.getString("lang"));
		lData.setString("companyCd", loginUser.getString("companyCd"));
		
		gauceResponse.enableFirstRow( dsGrid );
		
	    LMultiData result = null;
	    if("prodDate".equals(lData.getString("sqlType"))) {
	    	result = biz.retrieveLimestoneProductionProdDate(lData);
	    } else {
	    	result = biz.retrieveLimestoneProductionList(lData);
	    }
	    
	    LGauceConverter.extractToGauceDataSet(result, dsGrid);
		dsGrid.flush();
		
		LLog.debug.write("RetrieveLimestoneProductionListCmd --> End");	
		
    }
    


    
}


