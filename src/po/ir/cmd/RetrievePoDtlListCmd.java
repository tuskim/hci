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
import com.gauce.GauceDataSet;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import comm.util.LXssCollectionUtility;

import devon.core.collection.LData;
import devon.core.log.LLog;
import devonframework.bridge.gauce.command.LGauceCommandIF;
import devonframework.bridge.gauce.util.LGauceConverter;

public class RetrievePoDtlListCmd implements LGauceCommandIF {

    public void execute(HttpServletRequest req, HttpServletResponse res, GauceRequest gauceRequest, GauceResponse gauceResponse) throws Exception {
    	
    	
		LLog.debug.write("RetrievePoDtlListCmd --> Start");
		
    	
		InvoiceRegBiz biz = new InvoiceRegBiz();
		GauceDataSet 	dsGrid 	= new GauceDataSet("ds_detail");
	
		LData lData = null;
	
		lData	= LXssCollectionUtility.getData(req);
			
		HttpSession session = req.getSession();
		LData loginUser = (LData) session.getAttribute("loginUser");	
		lData.setString("lang", loginUser.getString("lang"));
		lData.setString("companyCd", loginUser.getString("companyCd"));
		
		gauceResponse.enableFirstRow( dsGrid );
		dsGrid.addDataColumn( new GauceDataColumn( "chk"       				, GauceDataColumn.TB_STRING   , 1     ) ); //
		dsGrid.addDataColumn( new GauceDataColumn( "companyCd"      , GauceDataColumn.TB_STRING   , 4     ) ); //
        dsGrid.addDataColumn( new GauceDataColumn( "poNo"          		, GauceDataColumn.TB_STRING   , 10     ) ); //
        dsGrid.addDataColumn( new GauceDataColumn( "poSeq"          		, GauceDataColumn.TB_STRING   , 5   ) ); //
        dsGrid.addDataColumn( new GauceDataColumn( "materCd"           	, GauceDataColumn.TB_STRING   , 18     ) ); //
        dsGrid.addDataColumn( new GauceDataColumn( "materNm"         	, GauceDataColumn.TB_STRING   , 100    ) ); //
        dsGrid.addDataColumn( new GauceDataColumn( "qty"          			, GauceDataColumn.TB_DECIMAL  , 10, 3 ) ); //
        dsGrid.addDataColumn( new GauceDataColumn( "unit"      				, GauceDataColumn.TB_STRING   , 20     ) ); //
        dsGrid.addDataColumn( new GauceDataColumn( "vatCd"    				, GauceDataColumn.TB_STRING   , 20   ) ); //
        dsGrid.addDataColumn( new GauceDataColumn( "vatNm"         		, GauceDataColumn.TB_STRING   , 100    ) ); //
        dsGrid.addDataColumn( new GauceDataColumn( "price"          			, GauceDataColumn.TB_DECIMAL  , 11, 4 ) ); //
        dsGrid.addDataColumn( new GauceDataColumn( "sapPrice"          	, GauceDataColumn.TB_DECIMAL  , 11, 4 ) ); //
        dsGrid.addDataColumn( new GauceDataColumn( "amount"          	, GauceDataColumn.TB_DECIMAL  , 13, 2 ) ); //
        dsGrid.addDataColumn( new GauceDataColumn( "currencyCd"    	, GauceDataColumn.TB_STRING   , 20   ) ); //
        dsGrid.addDataColumn( new GauceDataColumn( "previousQty" 	, GauceDataColumn.TB_DECIMAL  , 13, 2 ) ); //
        dsGrid.addDataColumn( new GauceDataColumn( "receiptQty"		, GauceDataColumn.TB_DECIMAL  , 13, 2 ) ); //
        dsGrid.addDataColumn( new GauceDataColumn( "vatAmt"				, GauceDataColumn.TB_DECIMAL  , 13, 2 ) ); //
        dsGrid.addDataColumn( new GauceDataColumn( "receiptClsYn"     , GauceDataColumn.TB_STRING   , 1     ) ); //
        dsGrid.addDataColumn( new GauceDataColumn( "tranTaxRate"		, GauceDataColumn.TB_DECIMAL  , 5, 2 ) ); //
        dsGrid.addDataColumn( new GauceDataColumn( "tranTaxAmt"		, GauceDataColumn.TB_DECIMAL  , 15, 2 ) ); //
        dsGrid.addDataColumn( new GauceDataColumn( "ivClose"          	, GauceDataColumn.TB_STRING   , 1    ) ); //
        
		LGauceConverter.convertToGauceDataSet( biz.retrievePoDtlList(lData), dsGrid );
		dsGrid.flush();
		
		LLog.debug.write("RetrievePoDtlListCmd --> End");	
		
    }
    


    
}


