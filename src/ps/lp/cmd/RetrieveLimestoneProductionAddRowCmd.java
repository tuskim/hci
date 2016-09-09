/* ------------------------------------------------------------------------
 * @source  : RetrieveLimestoneProductionAddRowCmd.java
 * @desc    : [Add Row] New Data Search
 * ------------------------------------------------------------------------
 *
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2016.08.03   kjkim               Initial
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
import devon.core.log.LLog;
import devonframework.bridge.gauce.command.LGauceCommandIF;
import devonframework.bridge.gauce.util.LGauceConverter;

public class RetrieveLimestoneProductionAddRowCmd implements LGauceCommandIF {

    public void execute(HttpServletRequest req, HttpServletResponse res, GauceRequest gauceRequest, GauceResponse gauceResponse) throws Exception {
    	
    	
		LLog.debug.write("RetrieveLimestoneProductionAddRowCmd --> Start");
		
    	
		LimestoneProductionBiz biz = new LimestoneProductionBiz();
		GauceDataSet 	dsGrid 	= new GauceDataSet("dsList");
	
		LData lData = null;
	
		lData	= LXssCollectionUtility.getData(req);
			
		HttpSession session = req.getSession();
		LData loginUser = (LData) session.getAttribute("loginUser");	
		lData.setString("lang", loginUser.getString("lang"));
		lData.setString("companyCd", loginUser.getString("companyCd"));
		
		gauceResponse.enableFirstRow( dsGrid );
		
		LGauceConverter.extractToGauceDataSet( biz.retrieveLimestoneProductionAddRow(lData), dsGrid );
		
		dsGrid.flush();
		
		LLog.debug.write("RetrieveLimestoneProductionAddRowCmd --> End");	
		
    }
    


    
}


