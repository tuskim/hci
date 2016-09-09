/* ------------------------------------------------------------------------
 * @source  : RetrieveCPOStockListCmd.java
 * @desc    : CPO 재고자산 출고에서 사용할 재고현황 List
 * ------------------------------------------------------------------------
 *
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2012.10.04   이태경                   Initial
 * ------------------------------------------------------------------------ */
package rfc.cmd;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import sd.sm.biz.CementSalesMgntBiz;

import rfc.biz.RetrieveCurrentCementStockRFC;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataSet;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import comm.util.LXssCollectionUtility;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.log.LLog;
import devonframework.bridge.gauce.command.LGauceCommandIF;
import devonframework.bridge.gauce.util.LGauceConverter;

public class RetrieveCementStockListCmd implements LGauceCommandIF{

	public void execute(HttpServletRequest req, HttpServletResponse res, GauceRequest gauceRequest, GauceResponse gauceResponse) throws Exception {
		
		LLog.debug.write("RetrieveCementStockListCmd --> Start");
		GauceDataSet gds = new GauceDataSet();
 
		gauceResponse.enableFirstRow(gds);
		
		gds.addDataColumn( new GauceDataColumn( "materCd" , GauceDataColumn.TB_STRING  , 30  ) ); // Material Number
        gds.addDataColumn( new GauceDataColumn( "materNm" , GauceDataColumn.TB_STRING  , 100   ) ); // Material Name
        gds.addDataColumn( new GauceDataColumn( "currentQty" , GauceDataColumn.TB_DECIMAL  , 13, 3   ) ); // currentQty
        gds.addDataColumn( new GauceDataColumn( "unit" , GauceDataColumn.TB_STRING  , 30  ) ); // Unit
        gds.addDataColumn( new GauceDataColumn( "unitPrice" , GauceDataColumn.TB_DECIMAL  , 13, 2   ) ); // unitPrice
        gds.addDataColumn( new GauceDataColumn( "useyn" , GauceDataColumn.TB_STRING  , 1  ) ); // Use Y/N

		LData lData = LXssCollectionUtility.getData(req);
		
		long  getErrorCode = 0 ;
        String getMessage   = "";
        
//      -------------------------------------- Session 종료시 처리 START
	    HttpSession session = req.getSession(false);
	    LData loginUser = new LData();
	    
	    if (session != null) loginUser = (LData)session.getAttribute("loginUser");
	    if( loginUser.getString("userId") == null) {
	    	getMessage = "Session is Terminated. You need to relogin!";
	    	gauceResponse.writeException("Error", String.valueOf(getErrorCode), "\n[Detail Msg]==>" + getMessage);
	    	return;
	    }
	   
		loginUser = (LData) session.getAttribute("loginUser");	
		lData.setString("lang", loginUser.getString("lang"));
		lData.setString("companyCd", loginUser.getString("companyCd"));
		
		CementSalesMgntBiz tempBiz = new CementSalesMgntBiz();
		
		LMultiData resultTmp = tempBiz.retrieveCementStockModelList(lData);
		
		RetrieveCurrentCementStockRFC biz = new RetrieveCurrentCementStockRFC();
		
		LMultiData result = biz.getCementStockList(lData, resultTmp);
		
		LGauceConverter.convertToGauceDataSet(result,gds);

		gds.flush();
		
		LLog.debug.write("RetrieveCementStockListCmd --> END");
		
	}
}
