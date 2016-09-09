/* ------------------------------------------------------------------------
 * @source  : RetrievePoListGauCmd.java
 * @desc    : P/O 목록 가져옴
 * ------------------------------------------------------------------------
 *
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2010.08.05   최용락                   Initial
 * 1.1  2011.08.29  김현수                 CSR:C20110823_49874
 * 1.2  2015.12.21  김현수                 CSR:C20151127_27284 REF NO 추가
 * ------------------------------------------------------------------------ */

package po.is.cmd;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import po.is.biz.ReceiptMgntBiz;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataSet;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import comm.util.LXssCollectionUtility;

import devon.core.collection.LData;
import devon.core.log.LLog;
import devonframework.bridge.gauce.command.LGauceCommandIF;
import devonframework.bridge.gauce.util.LGauceConverter;

public class RetrievePoListGauCmd implements LGauceCommandIF {

    public void execute(HttpServletRequest req, HttpServletResponse res, GauceRequest gauceRequest, GauceResponse gauceResponse) throws Exception {
    	
    	
		LLog.debug.write("RetrievePoListGauCmd --> Start");
		
    	
		ReceiptMgntBiz biz = new ReceiptMgntBiz();
		GauceDataSet 	dsGrid 	= new GauceDataSet("ds_grid");
		GauceDataSet 	dsParam 	= gauceRequest.getGauceDataSet("ds_param");
		
		gauceResponse.enableFirstRow(dsGrid);
		
		dsGrid.addDataColumn( new GauceDataColumn("chk"    		    , GauceDataColumn.TB_STRING, 50));
		dsGrid.addDataColumn( new GauceDataColumn("poNo"    		, GauceDataColumn.TB_STRING, 50));
		dsGrid.addDataColumn( new GauceDataColumn("referenceNo"  	, GauceDataColumn.TB_STRING, 50));
		dsGrid.addDataColumn( new GauceDataColumn("poSeq"    		, GauceDataColumn.TB_STRING, 50));
		dsGrid.addDataColumn( new GauceDataColumn("sapPoNo"    	    , GauceDataColumn.TB_STRING, 50));
		dsGrid.addDataColumn( new GauceDataColumn("vendCd"    		, GauceDataColumn.TB_STRING, 50));
		dsGrid.addDataColumn( new GauceDataColumn("vendNm"    		, GauceDataColumn.TB_STRING, 50));
		dsGrid.addDataColumn( new GauceDataColumn("materCd"    	    , GauceDataColumn.TB_STRING, 50));
		dsGrid.addDataColumn( new GauceDataColumn("materNm"    	    , GauceDataColumn.TB_STRING, 50));
		dsGrid.addDataColumn( new GauceDataColumn("modelNm"    	    , GauceDataColumn.TB_STRING, 50));
		dsGrid.addDataColumn( new GauceDataColumn("purDeptCd"       , GauceDataColumn.TB_STRING, 50));
		dsGrid.addDataColumn( new GauceDataColumn("purDeptName"     , GauceDataColumn.TB_STRING, 50));
		dsGrid.addDataColumn( new GauceDataColumn("deliLoct"    	, GauceDataColumn.TB_STRING, 50));
		dsGrid.addDataColumn( new GauceDataColumn("delivyPlaName"   , GauceDataColumn.TB_STRING, 50));
		dsGrid.addDataColumn( new GauceDataColumn("unit"    		, GauceDataColumn.TB_STRING, 50));
		dsGrid.addDataColumn( new GauceDataColumn("qty"    			, GauceDataColumn.TB_DECIMAL, 13,2));
		dsGrid.addDataColumn( new GauceDataColumn("preQty"    		, GauceDataColumn.TB_DECIMAL, 13,2));
		dsGrid.addDataColumn( new GauceDataColumn("recQty"    		, GauceDataColumn.TB_DECIMAL, 13,2));
		dsGrid.addDataColumn( new GauceDataColumn("clsYn"    		, GauceDataColumn.TB_STRING, 50));
	
		LData lData = null;
	
		if( null == dsParam ) {
			lData	= LXssCollectionUtility.getData(req);
			
		}else{
			lData 	= LGauceConverter.convertToLDataWithJobType(dsParam);
		}
		
		HttpSession session = req.getSession();
		LData loginUser = (LData) session.getAttribute("loginUser");	
		lData.setString("lang", loginUser.getString("lang"));
		lData.setString("companyCd", loginUser.getString("companyCd"));
		
		LGauceConverter.convertToGauceDataSet( biz.RetrievePoList(lData), dsGrid );
		dsGrid.flush();
		
		
    }
    


    
}


