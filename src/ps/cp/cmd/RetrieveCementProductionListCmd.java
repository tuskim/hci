/* ------------------------------------------------------------------------
 * @source  : RetrieveCementProductionListCmd.java
 * @desc    : Cement Production List 조회
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

import ps.cp.biz.CementProductionBiz;

import com.gauce.GauceDataSet;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import comm.util.LXssCollectionUtility;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LException;
import devon.core.log.LLog;
import devonframework.bridge.gauce.command.LGauceCommandIF;
import devonframework.bridge.gauce.util.LGauceConverter;

public class RetrieveCementProductionListCmd implements LGauceCommandIF {
    /**
     * 
     *
     * @param req Http Request 객체.
     * @param res Http Response 객체.
     * @param gauceRequest 가우스 Request 객체.
     * @param gauceResponse 가우스 Response 객체.
     * @exception LException Commnad 단 이하의 모든 에러.
     */
    public void execute(HttpServletRequest req, HttpServletResponse res, GauceRequest gauceRequest, GauceResponse gauceResponse) throws Exception {
    	
    	
		LLog.debug.write("RetrieveCementProductionListCmd --> Start");
		
    	
		CementProductionBiz biz = new CementProductionBiz();
		GauceDataSet 	dsGrid 	= new GauceDataSet("ds_List");
	
		LData lData = null;
	
		lData	= LXssCollectionUtility.getData(req);
			
		HttpSession session = req.getSession();
		LData loginUser = (LData) session.getAttribute("loginUser");	
		lData.setString("lang", loginUser.getString("lang"));
		lData.setString("companyCd", loginUser.getString("companyCd"));
		
		gauceResponse.enableFirstRow( dsGrid );
		
	    LMultiData result = null;
		
	    if("prodDate".equals(lData.getString("sqlType"))) {
	    	result = biz.retrieveCementProductionProdDate(lData);
	    } else if("beforeStep".equals(lData.getString("beforeStepStatus"))) {
		    result = biz.checkCementBeforeProductionStatus(lData);
	    } else {
	    	result = biz.retrieveCementProductionList(lData);
	    }
	    
		LGauceConverter.extractToGauceDataSet(result, dsGrid);
		dsGrid.flush();
		
		LLog.debug.write("RetrieveCementProductionListCmd --> End");	
		
    }
    


    
}


