/* ------------------------------------------------------------------------
 * @source  : RetrieveStockIssueListCmd.java
 * @desc    : 재고자산 출고에서 사용할 재고현황 List
 * ------------------------------------------------------------------------
 *
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2010.08.10   최용락                   Initial
 * ------------------------------------------------------------------------ */
package rfc.cmd;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
import rfc.biz.RetrieveCurrentStockRFC;

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

public class RetrieveStockIssueListCmd implements LGauceCommandIF{

	public void execute(HttpServletRequest req, HttpServletResponse res, GauceRequest gauceRequest, GauceResponse gauceResponse) throws Exception {
		
		LLog.debug.write("RetrieveStockIssueListCmd --> Start");
		GauceDataSet gds = new GauceDataSet();
 
		gauceResponse.enableFirstRow(gds);
		
		gds.addDataColumn( new GauceDataColumn( "materCd" , GauceDataColumn.TB_STRING  , 30  ) ); // Material Number
        gds.addDataColumn( new GauceDataColumn( "MAKTX" , GauceDataColumn.TB_STRING  , 100   ) ); // Storage location
        gds.addDataColumn( new GauceDataColumn( "MEINS" , GauceDataColumn.TB_STRING  , 30  ) ); // Batch Number
        gds.addDataColumn( new GauceDataColumn( "LABST" , GauceDataColumn.TB_DECIMAL  , 13, 2   ) ); // Actual quantity delivered (in sales units)
        gds.addDataColumn( new GauceDataColumn( "issueQty" , GauceDataColumn.TB_DECIMAL  , 13, 2   ) ); // Sales unit
        gds.addDataColumn( new GauceDataColumn( "desc"   , GauceDataColumn.TB_STRING  , 30   ) ); // 선택
        gds.addDataColumn( new GauceDataColumn( "areaCd"   , GauceDataColumn.TB_STRING  , 30   ) ); // 선택
        gds.addDataColumn( new GauceDataColumn( "divCd"   , GauceDataColumn.TB_STRING  , 30   ) ); // 선택
        gds.addDataColumn( new GauceDataColumn( "blockCd"   , GauceDataColumn.TB_STRING  , 30   ) ); // 선택
        gds.addDataColumn( new GauceDataColumn( "blockCd2"   , GauceDataColumn.TB_STRING  , 30   ) ); // 선택
        gds.addDataColumn( new GauceDataColumn( "yearCd"   , GauceDataColumn.TB_STRING  , 30   ) ); // 선택
        gds.addDataColumn( new GauceDataColumn( "tmTbm"   , GauceDataColumn.TB_STRING  , 30   ) ); // 선택
        gds.addDataColumn( new GauceDataColumn( "issueType"   , GauceDataColumn.TB_STRING  , 30   ) ); // 선택
        gds.addDataColumn( new GauceDataColumn( "costCenter"   , GauceDataColumn.TB_STRING  , 30   ) ); // 선택
        gds.addDataColumn( new GauceDataColumn( "attr1"   , GauceDataColumn.TB_STRING  , 30   ) ); // 선택
        gds.addDataColumn( new GauceDataColumn( "attr2"   , GauceDataColumn.TB_STRING  , 30   ) ); // 선택
        gds.addDataColumn( new GauceDataColumn( "chk" , GauceDataColumn.TB_STRING  , 2  ) ); // Check Field

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
		
		RetrieveCurrentStockRFC biz = new RetrieveCurrentStockRFC();
		
		LMultiData result = biz.getStockIssueList(lData);
		
		LGauceConverter.convertToGauceDataSet(result,gds);

		gds.flush();
		
		LLog.debug.write("RetrieveStockIssueListCmd --> END");
		
	}
}
