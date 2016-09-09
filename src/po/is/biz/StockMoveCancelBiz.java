/* ------------------------------------------------------------------------
 * @source  : StockMoveCancel.java
 * @desc    : Stock Move Cancel Biz
 * ------------------------------------------------------------------------
 * PROJ : PT-PAM
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2010.08.25   mskim              Initial
 * ------------------------------------------------------------------------ */

package po.is.biz;

import xi.GFI01;
import xi.GMM05;
import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LBizException;
import devon.core.exception.LException;
import devon.core.exception.LSysException;
import devon.core.log.LLog;
import devonframework.persistent.autodao.LCommonDao;
import devonframework.persistent.autodao.LCompoundDao;

public class StockMoveCancelBiz {
	
	/**
     * Request Movement Master List
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData RetrieveStockMoveMst(LData inputData) throws LException {
        LMultiData list = null;

        try {
 
            LCommonDao dao = new LCommonDao("/po/is/stockMoveCancelSql/retrieveStockMoveMst", inputData);
 
            list = dao.executeQuery();
            
        } catch (LException le) {
            LLog.err.write(this.getClass().getName() + "." + "RetrieveStockIssueList()" + "=>" + le.getMessage());
            throw new LBizException("cm.cm.com.retrieve");
        }
        return list;

    }

    
	/**
     * Request Movement Detail List
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData RetrieveStockMoveDtl(LData inputData) throws LException {
        LMultiData list = null;

        try {
 
            LCommonDao dao = new LCommonDao("/po/is/stockMoveCancelSql/retrieveStockMoveDtl", inputData);
 
            list = dao.executeQuery();
            
        } catch (LException le) {
            LLog.err.write(this.getClass().getName() + "." + "RetrieveStockIssueList()" + "=>" + le.getMessage());
            throw new LBizException("cm.cm.com.retrieve");
        }
        return list;

    }    
    
    /**
     * Stock Movement Sap Cancel
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LData saveStockMoveCancel(LData headerData, LMultiData bodyData, LData loginUser) throws LException {

    	LCompoundDao dao = new LCompoundDao();
        LCommonDao xdao	 = new LCommonDao();

    	LData result = new LData();

		LLog.debug.write("saveStockIssue headerData --------------- =>\n " + headerData.toString());

		LLog.debug.write("saveStockIssue bodyData --------------- =>\n " + bodyData.toString());

		String getErrorCode = "0" ;
		String getMessage	= "Failed"; 	
		String getStatus	= "";
		
		LData  resultMsg	= new LData();
        String msg 		    = "";

        try{			

			dao.startTransaction();

	        //---------------------- Material Code Available Check -----------------
			for(int i=0;i< bodyData.getDataCount(); i++) {
				LData cudlData = bodyData.getLData(i);

				LData resultInfo = dao.executeQueryForSingle("/po/is/stockMoveCancelSql/retrieveMaterialCheck", cudlData);

				String materCd  = cudlData.getString("materCd"); 
				//String materNm  = cudlData.getString("materNm");

				// Material available Check
				String materChk = resultInfo.getString("materCheck");
				
				if ( materChk.equals("N")) {
					msg += "simpleMsg : The selected Material Code [ "+ materCd + " ] does not use \r\n";
					throw new Exception(msg);
				}
			}
			
			// Sap Transmit Cancel Request (04)
			headerData.setString("status", "04");  

			LData xmlNo = xdao.executeQueryForSingle("cm/cm/commCodeMgntSql/retireveXmlDocNo", loginUser);
        	
			//----------------------- Sap Transmit Start ------------------
			GMM05 gmm05 = new GMM05();
			resultMsg = gmm05.GMM05_out(xmlNo, headerData, bodyData);
	        //----------------------- Sap Transmit End --------------------

			// Transmit Complete.
			if (resultMsg.getString("returnType").equals("00")) {
				getErrorCode = "0";

				headerData.setString("sapCancelDocNo",  resultMsg.getString("returnDocNo"));
				headerData.setString("status", 		    "05");  //Cancel Confirm (05)

			} else if (resultMsg.getString("returnType").equals("06")) {

				headerData.setString("sapRtnMsg",   resultMsg.getString("returnText"));
				headerData.setString("status", 		"06");  //Error

			} else {

				// Transmit Error.
				msg = "simpleMsg : " + resultMsg.getString("returnText");
				throw new Exception(msg);
			}

			dao.add ("/po/is/stockMoveCancelSql/updateStockMoveCancel", headerData);            
            
			dao.executeUpdate();
			
			dao.commit();			
			
			// Transmit Complete.
			if ( !resultMsg.getString("returnType").equals("00")) {

				// Transmit Error.
				msg = "simpleMsg : " + resultMsg.getString("returnText");
				
				getMessage   = msg;
				getStatus    = "fail."+this.getClass().getName()+"."+"StockMoveCancelBiz";
				
				throw new Exception(msg);

			}			
			
		} catch (Exception se) {
			dao.rollback();

			LLog.err.write(  this.getClass().getName() + "." + "StockMoveCancelBiz()" + "=>" + se.getMessage());
			getErrorCode = "-1403";
			getMessage = se.getMessage();
			getStatus    = "fail."+this.getClass().getName()+"."+"StockMoveCancelBiz";
			LLog.err.write(this.getClass().getName()+"."+"StockMoveCancelBiz()"+"=>" + msg);
        }
		
		result.put("getErrorCode",	getErrorCode);
		result.put("getMessage",	getMessage);

		if(!getStatus.equals("")) result.put("getStatus" ,getStatus ); //현 프로그램에서 에러
		
		return result;
    }
    
    
}