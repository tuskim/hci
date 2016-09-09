/* ------------------------------------------------------------------------
 * @source  : RetrieveClinkerProductionListCmd.java
 * @desc    : Clinker Production List 조회
 * ------------------------------------------------------------------------
 *
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2016.08.02   kjkim               Initial
 * ------------------------------------------------------------------------ */

package ps.cp.cmd;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ps.cp.biz.ClinkerProductionBiz;

import com.gauce.GauceDataSet;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import comm.util.LXssCollectionUtility;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.log.LLog;
import devonframework.bridge.gauce.command.LGauceCommandIF;
import devonframework.bridge.gauce.util.LGauceConverter;

public class RetrieveClinkerProductionListCmd implements LGauceCommandIF {

    public void execute(HttpServletRequest req, HttpServletResponse res, GauceRequest gauceRequest, GauceResponse gauceResponse) throws Exception {
    	
    	
		LLog.debug.write("RetrieveClinkerProductionListCmd --> Start");
		
    	
		ClinkerProductionBiz biz = new ClinkerProductionBiz();
		GauceDataSet 	dsGrid 	= new GauceDataSet("ds_clinkerProductList");
	
		LData lData = null;
	
		lData	= LXssCollectionUtility.getData(req);
			
		HttpSession session = req.getSession();
		LData loginUser = (LData) session.getAttribute("loginUser");	
		lData.setString("lang", loginUser.getString("lang"));
		lData.setString("companyCd", loginUser.getString("companyCd"));
		
		gauceResponse.enableFirstRow( dsGrid );
		
	    LMultiData result = null;
	    if("prodDate".equals(lData.getString("sqlType"))) {
	    	result = biz.retrieveClinkerProductionProdDate(lData);
	    } else if("beforeStep".equals(lData.getString("beforeStepStatus"))) {
		    result = biz.checkClinkerBeforeProductionStatus(lData);
	    } else {
	    	result = biz.retrieveClinkerProductionList(lData);
	    }
	    
	    LGauceConverter.extractToGauceDataSet(result, dsGrid);
		dsGrid.flush();
		
		LLog.debug.write("RetrieveClinkerProductionListCmd --> End");	
		
    }
    


    
}


