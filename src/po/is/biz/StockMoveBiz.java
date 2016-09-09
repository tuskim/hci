/* ------------------------------------------------------------------------
 * @source  : StockMove.java
 * @desc    : stock Move Biz
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

public class StockMoveBiz {
	
	/**
     * 입고처리할 po list 조회
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData RetrievePoList(LData inputData) throws LException {
        LMultiData list = null;

        try {
 
            LCommonDao dao = new LCommonDao("/po/is/receiptMgntSql/RetrievePoList", inputData);
 
            list = dao.executeQuery();
            
        } catch (LException le) {
            LLog.err.write(this.getClass().getName() + "." + "RetrievecodeCbList()" + "=>" + le.getMessage());
            throw new LBizException("cm.cm.com.retrieve");
        }
        return list;

    }
    
    
     /**
     * 입고등록
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LData cudReceiptMgnt(LMultiData inputData, LData loginUser) throws LException {
        LCompoundDao dao = new LCompoundDao();
        LData result = new LData();
        int cnt = 0;
        
		LLog.debug.println("cudReceiptMgnt inputData--------------- =>\n " + inputData.toString());
		
		String	getErrorCode = "0" ;
		String	getMessage	 = "Failed"; 	

        try{			


			LData   resultInfo 	= new LData();		// Seq 생성
			//LData   dataParam 	= new LData();
			String  strCheck	= "";
	        String msg 		    = "";
	        
			for(int i=0;i<inputData.getDataCount();i++) {
				
				LData cudlData = inputData.getLData(i);

				cudlData.setString("companyCd", loginUser.getString("companyCd"));
				cudlData.setString("userId",    loginUser.getString("userId"));
				
				if( "DEVON_CREATE_FILTER_VALUE".equals(cudlData.getString( "DEVON_CUD_FILTER_KEY")) ) {
 
					LLog.info.write("\n SQL -> /po/is/receiptMgntSql/cudReceiptMgnt -------------> \n");
										
		            dao.add ("/po/is/receiptMgntSql/insertSafety", cudlData);            
		            cnt = dao.executeUpdate(); 		
					if(cnt > 0){
						getMessage = "OK";					
						
					}
					
				} else if( "DEVON_UPDATE_FILTER_VALUE".equals(cudlData.getString( "DEVON_CUD_FILTER_KEY")) ) {
					LLog.info.write("\n SQL -> /po/is/receiptMgntSql/cudReceiptMgnt -------------> \n");
		            dao.add ("/po/is/receiptMgntSql/insertReceiptMgnt", cudlData);            
		            cnt = dao.executeUpdate();       	   
					if(cnt > 0){
						getMessage = "OK";					
					}				            
				} else if( "DEVON_DELETE_FILTER_VALUE".equals(cudlData.getString( "DEVON_CUD_FILTER_KEY")) ) {
		            dao.add ("/po/is/receiptMgntSql/deleteSafety", cudlData);            
		            cnt = dao.executeUpdate(); 
		            
					if(cnt > 0){
						getMessage = "OK";					
					}		            
				}
				
			}
			
				
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "cudSafetyStockMgnt()" + "=>" + se.getMessage());
			//throw new LSysException("pbf.err.com.save", se);
			getErrorCode = "-1403";
			getMessage = se.getMessage();
			throw new LSysException(getMessage,se);
        }
		
		result.put("getErrorCode"	,getErrorCode);
		result.put("getMessage"	,getMessage);
		
		return result;
    } 
    
    

    
    
    
    
    
    /**
     * 이동등록
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LData saveStockMove(LData headerData, LMultiData bodyData, LData loginUser) throws LException {

    	LCompoundDao dao = new LCompoundDao();
        LCommonDao xdao	 = new LCommonDao();

    	LData result = new LData();
        int cnt = 0;
        int cnt2 = 0;
        
		LLog.debug.println("cudStockMove bodyData --------------- =>\n " + bodyData.toString());
		
		String getErrorCode = "0" ;
		String getMessage	= "Failed"; 	
		String getStatus	= "";

		LData  resultInfo = new LData();		// Seq 생성
		String tranNo	  = "";
		String yearMonth  = "";
		
		LData  resultMsg	= new LData();
		String strCheck	    = "";
        String msg 		    = "";

        LData cudlData      = null;

        try{			

			dao.startTransaction();
        	
			//---------------------- Data Gethering Start ----------------
			// Transmit No Search
			resultInfo = dao.executeQueryForSingle("/po/is/stockMoveSql/retrieveTranNo", headerData);
			yearMonth  = headerData.getString("moveDate").substring(0, 6);
			tranNo     = yearMonth + resultInfo.getString("tranNo");
			
			resultInfo = dao.executeQueryForSingle("/po/is/stockMoveSql/retrievePlantCode", headerData);
			String plantCode = resultInfo.getString("plantCode");
			
			headerData.setString("tranNo", 		tranNo);
			headerData.setString("postingDate", headerData.getString("postingDate"));
			headerData.setString("issuePlant",  plantCode);
			headerData.setString("recePlant",   plantCode);
			headerData.setString("status",      "02");		//Transfer Confirm(02)

			LLog.debug.println("cudStockMove headerData2222 ---tranNo \n " + tranNo);
			int bodyCnt = bodyData.getDataCount();
			
			for(int i=0;i< bodyCnt; i++) {
				
				cudlData = bodyData.getLData(i);

				bodyData.modifyString("companyCd", 	i, loginUser.getString("companyCd"));
				bodyData.modifyString("userId", 	i, loginUser.getString("userId"));
				bodyData.modifyString("tranNo", 	i, tranNo);
			}
	        //---------------------- Data Gethering End -----------------

			
	        //---------------------- Material Code Available Check -----------------
			for(int i=0;i< bodyData.getDataCount(); i++) {
				cudlData = bodyData.getLData(i);

				resultInfo = dao.executeQueryForSingle("/po/is/stockMoveSql/retrieveMaterialCheck", cudlData);

				String materCd  = cudlData.getString("materCd"); 
				String materNm  = cudlData.getString("materNm");
				String materChk = resultInfo.getString("materCheck");
				
				if ( materChk.equals("N")) {
					msg += "simpleMsg : The selected Material Code [ "+ materCd + " " + materNm + " ] does not use \r\n";
					throw new Exception(msg);
				}
			}
			
	        //---------------------- Retrieve Documnet No -----------------
			LData xmlNo = xdao.executeQueryForSingle("cm/cm/commCodeMgntSql/retireveXmlDocNo", loginUser);
        	
			//----------------------- Sap Transmit Start ------------------
			GMM05 gmm05 = new GMM05();
			resultMsg = gmm05.GMM05_out(xmlNo, headerData, bodyData);
	        //----------------------- Sap Transmit End --------------------
			
			
			// Transmit Complete.
			if (resultMsg.getString("returnType").equals("00")) {
				getErrorCode = "0";

				// Transfer Confirm Code Setup
				headerData.setString("status",      "03");	//Transfer Confirm(03)

				// Master / Detail Insert 
				insertStockMove( headerData, bodyData, loginUser, resultMsg, dao );

			} else {

				// Transmit Error.
				msg = "simpleMsg : " + resultMsg.getString("returnText");
				
				getMessage   = msg;
				getStatus    = "fail."+this.getClass().getName()+"."+"saveStockMove";
				
				throw new Exception(msg);
				
			}

			
			
			dao.commit();
			
		} catch (Exception se) {
			dao.rollback();

			LLog.err.write(  this.getClass().getName() + "." + "cudStockMove()" + "=>" + se.getMessage());
			//throw new LSysException("pbf.err.com.save", se);
			getErrorCode = "-1403";
			getMessage = se.getMessage();
			getStatus    = "fail."+this.getClass().getName()+"."+"stockMoveBiz";
			LLog.err.write(this.getClass().getName()+"."+"stockMoveBiz()"+"=>" + msg);
        }
		
		result.put("getErrorCode",	getErrorCode);
		result.put("getMessage",	getMessage);

		if(!getStatus.equals("")) result.put("getStatus" ,getStatus ); //현 프로그램에서 에러
		
		return result;
    }
    
    
    
    /**
     * 이동저장(DB)
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LData saveStockMoveDB(LData headerData, LMultiData bodyData, LData loginUser) throws LException {

    	LCompoundDao dao = new LCompoundDao();
        LCommonDao xdao	 = new LCommonDao();

    	LData result = new LData();
        int cnt = 0;
        int cnt2 = 0;
        
		LLog.debug.println("cudStockMove bodyData --------------- =>\n " + bodyData.toString());
		
		String getErrorCode = "0" ;
		String getMessage	= "Failed"; 	
		String getStatus	= "";

		LData  resultInfo = new LData();		// Seq 생성
		String tranNo	  = "";
		String yearMonth  = "";
		
		LData  resultMsg	= new LData();
		String strCheck	    = "";
        String msg 		    = "";

        LData cudlData      = null;

        try{			

			dao.startTransaction();
        	
			//---------------------- Data Gethering Start ----------------
			// Transmit No Search
			resultInfo = dao.executeQueryForSingle("/po/is/stockMoveSql/retrieveTranNo", headerData);
			yearMonth  = headerData.getString("moveDate").substring(0, 6);
			tranNo     = yearMonth + resultInfo.getString("tranNo");
			
			resultInfo = dao.executeQueryForSingle("/po/is/stockMoveSql/retrievePlantCode", headerData);
			String plantCode = resultInfo.getString("plantCode");
			
			headerData.setString("tranNo", 		tranNo);
			headerData.setString("postingDate", headerData.getString("postingDate"));
			headerData.setString("issuePlant",  plantCode);
			headerData.setString("recePlant",   plantCode);
			headerData.setString("status",      "02");		//Transfer Confirm(02)

			LLog.debug.println("cudStockMove headerData2222 ---tranNo \n " + tranNo);
			int bodyCnt = bodyData.getDataCount();
			
			for(int i=0;i< bodyCnt; i++) {
				
				cudlData = bodyData.getLData(i);

				bodyData.modifyString("companyCd", 	i, loginUser.getString("companyCd"));
				bodyData.modifyString("userId", 	i, loginUser.getString("userId"));
				bodyData.modifyString("tranNo", 	i, tranNo);
			}
	        //---------------------- Data Gethering End -----------------

			
	        //---------------------- Material Code Available Check -----------------
			for(int i=0;i< bodyData.getDataCount(); i++) {
				cudlData = bodyData.getLData(i);

				resultInfo = dao.executeQueryForSingle("/po/is/stockMoveSql/retrieveMaterialCheck", cudlData);

				String materCd  = cudlData.getString("materCd"); 
				String materNm  = cudlData.getString("materNm");
				String materChk = resultInfo.getString("materCheck");
				
				if ( materChk.equals("N")) {
					msg += "simpleMsg : The selected Material Code [ "+ materCd + " " + materNm + " ] does not use \r\n";
					throw new Exception(msg);
				}
			}
			
	        //---------------------- Retrieve Documnet No -----------------
			LData xmlNo = xdao.executeQueryForSingle("cm/cm/commCodeMgntSql/retireveXmlDocNo", loginUser);
        	
			//----------------------- Sap Transmit Start ------------------
	//		GMM05 gmm05 = new GMM05();
	//		resultMsg = gmm05.GMM05_out(xmlNo, headerData, bodyData);
	        //----------------------- Sap Transmit End --------------------
			
			
			// Transmit Complete.
				getErrorCode = "0";

				// Transfer Confirm Code Setup
				headerData.setString("status",      "01");	//Request(01)
				headerData.setString("requisitionStatus",      "10");	//Request(10)

				// Master / Detail Insert 
				insertStockMove( headerData, bodyData, loginUser, resultMsg, dao );

			
			dao.commit();
			
		} catch (Exception se) {
			dao.rollback();

			LLog.err.write(  this.getClass().getName() + "." + "cudStockMove()" + "=>" + se.getMessage());
			//throw new LSysException("pbf.err.com.save", se);
			getErrorCode = "-1403";
			getMessage = se.getMessage();
			getStatus    = "fail."+this.getClass().getName()+"."+"stockMoveBiz";
			LLog.err.write(this.getClass().getName()+"."+"stockMoveBiz()"+"=>" + msg);
        }
		
		result.put("getErrorCode",	getErrorCode);
		result.put("getMessage",	getMessage);

		if(!getStatus.equals("")) result.put("getStatus" ,getStatus ); //현 프로그램에서 에러
		
		return result;
    }


    
    
    
    
    
	/**
	 * <pre>Hub In Header를 수정한다.</pre>
	 * 
     * @author 	hani1005
     * @update
     * @since  	2010.04.26
	 * @param 	lData		LData
	 * @return	
	 * @throws 	LException
	 */
    public void insertStockMove( LData headerData, LMultiData bodyData, 
    		                      LData loginUser,  LData resultMsg, LCompoundDao dao ) throws Exception {
    	
    	try {        	

/*    		
    		LData  resultInfo = new LData();		// Seq 생성
			String tranNo	  = "";
			String yearMonth  = "";
			
			// Transmit No Search
			resultInfo = dao.executeQueryForSingle("fi/ar/costTotLedgerMgntSql/retrieveTranNo", resultInfo);
			yearMonth  = headerData.getString("moveDate").replaceAll("/", "").substring(0, 6);
			tranNo     = yearMonth + resultInfo.getString("tranNo");
			
			headerData.setString("tranNo", tranNo);
*/

    		headerData.setString("sapIfStatus", resultMsg.getString("returnType"));
			headerData.setString("sapRtnMsg",   resultMsg.getString("returnText"));
			headerData.setString("sapDocNo",    resultMsg.getString("returnDocNo"));

			LLog.debug.println("cudStockMove headerData22222 --------------- =>\n " + headerData.toString());

			dao.add ("/po/is/stockMoveSql/insertStockMoveMaster", headerData);            

            
			LLog.debug.println("cudStockMove bodyData33333 --------------- =>\n " + bodyData.toString());
            
			for(int i=0;i<bodyData.getDataCount();i++) {
				
				LLog.debug.println("cudStockMove headerData5555 --------------- =>\n ");
				LData cudlData = bodyData.getLData(i);
/*
				cudlData.setString("companyCd", loginUser.getString("companyCd"));
				cudlData.setString("userId",    loginUser.getString("userId"));
				cudlData.setString("tranNo", 	tranNo);
*/				
				String tx_Mode = cudlData.getString("DEVON_CUD_FILTER_KEY");
				
				if( tx_Mode.equals("DEVON_UPDATE_FILTER_VALUE")) {
					LLog.info.write("\n SQL -> /po/is/stockMoveSql/insertStockMoveDetail -------------> \n");
					
					//Stock Move Insert
		            dao.add ("/po/is/stockMoveSql/insertStockMoveDetail", cudlData);            
				}
				
			}
        	
            dao.executeUpdate();

        } catch ( Exception e ) {
			dao.rollback();
			LLog.err.write(  this.getClass().getName() + "." + "retrieveHubInHeader()" + "=>" + e.getMessage());
        }
    
    }    
    
    
    /**20140704 이하 메소드 추가*/
    
	public LData confirmStockMove(LData harderData, LMultiData bodyData, LData loginUser) throws LException {
    	LCompoundDao dao = new LCompoundDao();

    	LData result = new LData();
        
		LLog.debug.println("saveStockMoveQuantity bodyData --------------- =>\n " + bodyData.toString());
		
		String getErrorCode = "0" ;
		String getMessage	= "Failed"; 	
		String getStatus	= "";

        String msg 		    = "";


        try{			

			dao.startTransaction();
        	
			
	        //---------------------- Material Code Available Check -----------------
			for(int i=0;i< bodyData.getDataCount(); i++) {
				LData cudData = bodyData.getLData(i);
				
				cudData.setString("companyCd", loginUser.getString("companyCd"));
				cudData.setString("userId", loginUser.getString("userId"));

				dao.add ("/po/is/stockMoveSql/confirmStockMove", cudData);
			}

			
			dao.executeUpdate();
			dao.commit();
			
		} catch (Exception se) {
			dao.rollback();

			LLog.err.write(  this.getClass().getName() + "." + "confirmStockMove()" + "=>" + se.getMessage());
			//throw new LSysException("pbf.err.com.save", se);
			getErrorCode = "-1403";
			getMessage = se.getMessage();
			getStatus    = "fail."+this.getClass().getName()+"."+"stockMoveBiz";
			LLog.err.write(this.getClass().getName()+"."+"stockMoveBiz()"+"=>" + msg);
        }
		
		result.put("getErrorCode",	getErrorCode);
		result.put("getMessage",	getMessage);

		if(!getStatus.equals("")) result.put("getStatus" ,getStatus ); //현 프로그램에서 에러
		
		return result;
	}

	public LData rejectStockMove(LData harderData, LMultiData bodyData, LData loginUser) throws LException {
    	LCompoundDao dao = new LCompoundDao();

    	LData result = new LData();
        
		LLog.debug.println("rejectStockMove bodyData --------------- =>\n " + bodyData.toString());
		
		String getErrorCode = "0" ;
		String getMessage	= "Failed"; 	
		String getStatus	= "";
        String msg 		    = "";

        try{			

			dao.startTransaction();
			
	        //---------------------- Material Code Available Check -----------------
			for(int i=0;i< bodyData.getDataCount(); i++) {
				LData cudData = bodyData.getLData(i);
				
				cudData.setString("companyCd", loginUser.getString("companyCd"));
				cudData.setString("userId", loginUser.getString("userId"));

				dao.add ("/po/is/stockMoveSql/rejectStockMove", cudData);
			}

			
			dao.executeUpdate();
			dao.commit();
			
		} catch (Exception se) {
			dao.rollback();

			LLog.err.write(  this.getClass().getName() + "." + "rejectStockMove()" + "=>" + se.getMessage());
			//throw new LSysException("pbf.err.com.save", se);
			getErrorCode = "-1403";
			getMessage = se.getMessage();
			getStatus    = "fail."+this.getClass().getName()+"."+"stockMoveBiz";
			LLog.err.write(this.getClass().getName()+"."+"stockMoveBiz()"+"=>" + msg);
        }
		
		result.put("getErrorCode",	getErrorCode);
		result.put("getMessage",	getMessage);

		if(!getStatus.equals("")) result.put("getStatus" ,getStatus ); //현 프로그램에서 에러
		
		return result;
	}


	public LData sapSendStockMove(LData headerData, LMultiData bodyData, LData loginUser) throws LException {

    	LCompoundDao dao = new LCompoundDao();
        LCommonDao xdao	 = new LCommonDao();

    	LData result = new LData();
        
		LLog.debug.println("sapSendStockMove bodyData --------------- =>\n " + bodyData.toString());
		
		String getErrorCode = "0" ;
		String getMessage	= "Failed"; 	
		String getStatus	= "";

		LData  resultInfo = new LData();		// Seq 생성
		String tranNo	  = "";
		String yearMonth  = "";
		
		LData  resultMsg	= new LData();
        String msg 		    = "";

        LData cudlData      = null;

        try{			
        	
        	dao.startTransaction();
        	
			//---------------------- Data Gethering Start ----------------
			// Transmit No Search
			resultInfo = dao.executeQueryForSingle("/po/is/stockMoveSql/retrieveTranNo", headerData);
			yearMonth  = headerData.getString("moveDate").substring(0, 6);
			
			resultInfo = dao.executeQueryForSingle("/po/is/stockMoveSql/retrievePlantCode", headerData);
			String plantCode = resultInfo.getString("plantCode");
			
			headerData.setString("tranNo", 		headerData.getString("tranNo"));
			headerData.setString("postingDate", headerData.getString("postingDate"));
			headerData.setString("issuePlant",  plantCode);
			headerData.setString("recePlant",   plantCode);
			headerData.setString("status",      "02");		//Transfer Confirm(02)

			LLog.debug.println("sapSendStockMove headerData2222 ---tranNo \n " + tranNo);
			int bodyCnt = bodyData.getDataCount();
			
			for(int i=0;i< bodyCnt; i++) {
				
				bodyData.addString("userId", 	 loginUser.getString("userId"));
			}
	        //---------------------- Data Gethering End -----------------

			
	        //---------------------- Material Code Available Check -----------------
			for(int i=bodyData.getDataCount()-1 ; i>=0; i--) {
				cudlData = bodyData.getLData(i);
				if(cudlData.getString("tranQty").equals("0.0")){
					bodyData.removeRow(i);
				}

				resultInfo = dao.executeQueryForSingle("/po/is/stockMoveSql/retrieveMaterialCheck", cudlData);

				String materCd  = cudlData.getString("materCd"); 
				String materNm  = cudlData.getString("materNm");
				String materChk = resultInfo.getString("materCheck");
				
				if ( materChk.equals("N")) {
					msg += "simpleMsg : The selected Material Code [ "+ materCd + " " + materNm + " ] does not use \r\n";
					throw new Exception(msg);
				}
			}
			
	        //---------------------- Retrieve Documnet No -----------------
			LData xmlNo = xdao.executeQueryForSingle("cm/cm/commCodeMgntSql/retireveXmlDocNo", loginUser);
        	
			//----------------------- Sap Transmit Start ------------------
			GMM05 gmm05 = new GMM05();
			resultMsg = gmm05.GMM05_out(xmlNo, headerData, bodyData);
	        //----------------------- Sap Transmit End --------------------
			
			LLog.info.println("resultMsg!!! \n"+resultMsg);
			// Transmit Complete.
			if (resultMsg.getString("returnType").equals("00")) {
				getErrorCode = "0";

				// Transfer Confirm Code Setup
				headerData.setString("status",      "03");	//Transfer Confirm(03)
				headerData.setString("sapIfStatus", resultMsg.getString("returnType"));
				headerData.setString("sapRtnMsg",   resultMsg.getString("returnText"));
				headerData.setString("sapDocNo",    resultMsg.getString("returnDocNo"));
				
				// 상태 변경 
				dao.add ("/po/is/stockMoveSql/updateStatusStockMove", headerData);
				dao.executeUpdate();
			} else {

				// Transmit Error.
				msg = "simpleMsg : " + resultMsg.getString("returnText");
				
				getMessage   = msg;
				getStatus    = "fail."+this.getClass().getName()+"."+"saveStockMove";
				
				throw new Exception(msg);
				
			}
			
			dao.commit();
			
		} catch (Exception se) {

			dao.rollback();
			LLog.err.write(  this.getClass().getName() + "." + "sapSendStockMove()" + "=>" + se.getMessage());
			//throw new LSysException("pbf.err.com.save", se);
			getErrorCode = "-1403";
			getMessage = se.getMessage();
			getStatus    = "fail."+this.getClass().getName()+"."+"sapSendStockMove";
			LLog.err.write(this.getClass().getName()+"."+"sapSendStockMove()"+"=>" + msg);
        }
		
		result.put("getErrorCode",	getErrorCode);
		result.put("getMessage",	getMessage);

		if(!getStatus.equals("")) result.put("getStatus" ,getStatus ); //현 프로그램에서 에러
		
		return result;
	}	
    

	public LData saveStockMoveQuantity(LData harderData, LMultiData bodyData, LData loginUser) throws LException {
		
    	LCompoundDao dao = new LCompoundDao();

    	LData result = new LData();
        
		LLog.debug.println("saveStockMoveQuantity bodyData --------------- =>\n " + bodyData.toString());
		
		String getErrorCode = "0" ;
		String getMessage	= "Failed"; 	
		String getStatus	= "";

        String msg 		    = "";


        try{			

			dao.startTransaction();
        	
			
	        //---------------------- Material Code Available Check -----------------
			for(int i=0;i< bodyData.getDataCount(); i++) {
				LData cudData = bodyData.getLData(i);
				
				cudData.setString("companyCd", loginUser.getString("companyCd"));
				cudData.setString("userId", loginUser.getString("userId"));

				dao.add ("/po/is/stockMoveSql/saveStockMoveQuantity", cudData);
			}

			
			dao.executeUpdate();
			dao.commit();
			
		} catch (Exception se) {
			dao.rollback();

			LLog.err.write(  this.getClass().getName() + "." + "deleteStockMove()" + "=>" + se.getMessage());
			//throw new LSysException("pbf.err.com.save", se);
			getErrorCode = "-1403";
			getMessage = se.getMessage();
			getStatus    = "fail."+this.getClass().getName()+"."+"stockMoveBiz";
			LLog.err.write(this.getClass().getName()+"."+"stockMoveBiz()"+"=>" + msg);
        }
		
		result.put("getErrorCode",	getErrorCode);
		result.put("getMessage",	getMessage);

		if(!getStatus.equals("")) result.put("getStatus" ,getStatus ); //현 프로그램에서 에러
		
		return result;
	}

    
	
	public LData deleteStockMove(LData headerData, LMultiData bodyData, LData loginUser) throws LException {
		
    	LCompoundDao dao = new LCompoundDao();

    	LData result = new LData();
        
		LLog.debug.println("deleteStockMove bodyData --------------- =>\n " + bodyData.toString());
		
		String getErrorCode = "0" ;
		String getMessage	= "Failed"; 	
		String getStatus	= "";

        String msg 		    = "";

        try{			

			dao.startTransaction();
        	
			
	        //---------------------- Material Code Available Check -----------------
			for(int i=0;i< bodyData.getDataCount(); i++) {
				LData cudData = bodyData.getLData(i);
				
				cudData.setString("companyCd", loginUser.getString("companyCd"));
				cudData.setString("userId", loginUser.getString("userId"));

				dao.add ("/po/is/stockMoveSql/deleteStockMove", cudData);
			}

			
			dao.executeUpdate();
			dao.commit();
			
		} catch (Exception se) {
			dao.rollback();

			LLog.err.write(  this.getClass().getName() + "." + "deleteStockMove()" + "=>" + se.getMessage());
			//throw new LSysException("pbf.err.com.save", se);
			getErrorCode = "-1403";
			getMessage = se.getMessage();
			getStatus    = "fail."+this.getClass().getName()+"."+"stockMoveBiz";
			LLog.err.write(this.getClass().getName()+"."+"stockMoveBiz()"+"=>" + msg);
        }
		
		result.put("getErrorCode",	getErrorCode);
		result.put("getMessage",	getMessage);

		if(!getStatus.equals("")) result.put("getStatus" ,getStatus ); //현 프로그램에서 에러
		
		return result;
	}
	
	
}