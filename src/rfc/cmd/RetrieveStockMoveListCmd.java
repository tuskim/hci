/* ------------------------------------------------------------------------
 * @source  : RetrieveStockMoveListCmd.java
 * @desc    : Stock Movment
 * ------------------------------------------------------------------------
 *
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2010.08.24   mskim                   Initial
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

public class RetrieveStockMoveListCmd implements LGauceCommandIF{

	public void execute(HttpServletRequest req, HttpServletResponse res, GauceRequest gauceRequest, GauceResponse gauceResponse) throws Exception {
		
		LLog.debug.write("RetrieveStockMoveListCmd -----> Start");
		
		GauceDataSet gds = new GauceDataSet();
 		gauceResponse.enableFirstRow(gds);
		
		gds.addDataColumn( new GauceDataColumn( "companyCd" , GauceDataColumn.TB_STRING  , 6  ) ); // 회사코드
        gds.addDataColumn( new GauceDataColumn( "userId" 	, GauceDataColumn.TB_STRING  , 20   ) ); // 사용자ID
        gds.addDataColumn( new GauceDataColumn( "tranNo" 	, GauceDataColumn.TB_STRING  , 10  ) ); // WEB 이동 번호 
        gds.addDataColumn( new GauceDataColumn( "materCd" 	, GauceDataColumn.TB_STRING  , 30  ) ); // 품목코드
        gds.addDataColumn( new GauceDataColumn( "materNm" 	, GauceDataColumn.TB_STRING  , 100   ) ); // 품목명
        gds.addDataColumn( new GauceDataColumn( "unit" 		, GauceDataColumn.TB_STRING  , 30  ) ); //  단위
        gds.addDataColumn( new GauceDataColumn( "stockQty" 	, GauceDataColumn.TB_STRING  , 20  ) ); // 재고수량
        gds.addDataColumn( new GauceDataColumn( "tranQty" 	, GauceDataColumn.TB_DECIMAL  , 15, 3  ) ); // 출고수량
        gds.addDataColumn( new GauceDataColumn( "remainQty" , GauceDataColumn.TB_DECIMAL  , 15, 3  ) ); // 출고잔량

		LData lData = LXssCollectionUtility.getData(req);
		
		long  getErrorCode = 0 ;
        String getMessage   = "";
        
        //-------------------------------------- Session 종료시 처리 START
	    HttpSession session = req.getSession(false);
	    LData loginUser = new LData();
	    if (session != null) loginUser = (LData)session.getAttribute("loginUser");
	    if( loginUser.getString("userId") == null) {
	    	getMessage = "Session is Terminated. You need to relogin!";
	    	gauceResponse.writeException("Error", String.valueOf(getErrorCode), "\n[Detail Msg]==>" + getMessage);
	    	return;
	    }
        //-------------------------------------- Session 종료시 처리 END
	   
		loginUser = (LData) session.getAttribute("loginUser");	
		lData.setString("companyCd", loginUser.getString("companyCd"));
		
		RetrieveCurrentStockRFC biz = new RetrieveCurrentStockRFC();
		
		LMultiData result = biz.getStockMoveList(lData);
		
		LGauceConverter.convertToGauceDataSet(result,gds);

		gds.flush();
		
		LLog.debug.write("RetrieveStockMoveListCmd --> END");
		
	}
}
