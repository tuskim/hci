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

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import comm.util.LXssCollectionUtility;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.log.LLog;
import devonframework.bridge.gauce.command.LGauceCommandIF;

public class RetrieveInvoiceTaxDataSetCmd implements LGauceCommandIF {

    public void execute(HttpServletRequest req, HttpServletResponse res, GauceRequest gauceRequest, GauceResponse gauceResponse) throws Exception {
    	
    	
		LLog.debug.write("RetrieveInvoiceTaxDataSetCmd --> Start");

		LData lData = LXssCollectionUtility.getData(req);;
		
		HttpSession session = req.getSession();
		LData loginUser = (LData) session.getAttribute("loginUser");	
		lData.setString("lang", loginUser.getString("lang"));
		lData.setString("companyCd", loginUser.getString("companyCd"));
		
		InvoiceRegBiz biz = new InvoiceRegBiz();
		
		GauceDataSet 	gauDsRes 	= new GauceDataSet();
		gauceResponse.enableFirstRow( gauDsRes );
		
		gauDsRes.addDataColumn(new GauceDataColumn("chk", 	GauceDataColumn.TB_STRING,  1 ));
		gauDsRes.addDataColumn(new GauceDataColumn("name", 	GauceDataColumn.TB_STRING,  50 ));
		gauDsRes.addDataColumn(new GauceDataColumn("code", 	GauceDataColumn.TB_STRING,  30 ));
		gauDsRes.addDataColumn(new GauceDataColumn("taxCode", 	GauceDataColumn.TB_STRING,  30));
		gauDsRes.addDataColumn(new GauceDataColumn("rate", 	GauceDataColumn.TB_DECIMAL,  10, 2 ));
		gauDsRes.addDataColumn(new GauceDataColumn("baseAmt", GauceDataColumn.TB_DECIMAL,  13, 2 ));
		gauDsRes.addDataColumn(new GauceDataColumn("taxAmt", GauceDataColumn.TB_DECIMAL,  13, 2 ));
		
		LMultiData resultList = biz.retrieveTaxDataSetList(lData);
		
		LLog.debug.println("-----------------------------"+resultList.toString());
		GauceDataRow row = null;
		
		for(int idx = 0 ; idx < resultList.getDataCount() ; idx++)
		{
			
			row = gauDsRes.newDataRow();
			
			row.addColumnValue("F");
			row.addColumnValue(resultList.getString("name", idx));
			row.addColumnValue(resultList.getString("code", idx));
			row.addColumnValue(resultList.getString("taxCode", idx));
			row.addColumnValue(resultList.getString("rate", idx));
			row.addColumnValue(resultList.getString("baseAmt", idx));
			row.addColumnValue(resultList.getString("taxAmt", idx));
			
			gauDsRes.addDataRow(row);
			
		}
		
		gauDsRes.flush();

    	LLog.debug.write("RetrieveInvoiceTaxDataSetCmd --> End");		
		
    }
    
}


