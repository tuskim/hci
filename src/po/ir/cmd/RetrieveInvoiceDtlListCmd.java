/* ------------------------------------------------------------------------
 * @source  : RetrievePoListGauCmd.java
 * @desc    : 채탄량 목록 가져옴
 * ------------------------------------------------------------------------
 *
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2010.09.03   임민수                   Initial
 * ------------------------------------------------------------------------ */

package po.ir.cmd;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import po.ir.biz.InvoiceRegBiz;

import com.gauce.GauceDataSet;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import comm.util.LXssCollectionUtility;

import devon.core.collection.LData;
import devon.core.log.LLog;
import devonframework.bridge.gauce.command.LGauceCommandIF;
import devonframework.bridge.gauce.util.LGauceConverter;

public class RetrieveInvoiceDtlListCmd implements LGauceCommandIF {

    public void execute(HttpServletRequest req, HttpServletResponse res, GauceRequest gauceRequest, GauceResponse gauceResponse) throws Exception {
    	
    	
		LLog.debug.write("RetrieveInvoiceDtlListCmd --> Start");
		
    	
		InvoiceRegBiz biz = new InvoiceRegBiz();
		GauceDataSet 	dsGrid 	= new GauceDataSet("ds_detail");
	
		LData lData = null;
	
		lData	= LXssCollectionUtility.getData(req);
			
		HttpSession session = req.getSession();
		LData loginUser = (LData) session.getAttribute("loginUser");	
		lData.setString("lang", loginUser.getString("lang"));
		lData.setString("companyCd", loginUser.getString("companyCd"));
		
		gauceResponse.enableFirstRow( dsGrid );
		LGauceConverter.extractToGauceDataSet( biz.retrieveInvoiceDtlList(lData), dsGrid );
		dsGrid.flush();
		
		LLog.debug.write("RetrieveInvoiceDtlListCmd --> End");	
		
    }
    


    
}


