/* ------------------------------------------------------------------------
 * @source  : commBiz.java
 * @desc    : 사용자 로그인/로그아웃 등 시스템 공통 비즈니스 로직 구현
 * ------------------------------------------------------------------------
 * PROJ : 투자사 시스템 표준안 개발
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2010.05.12  김현수                 Initial
 * ------------------------------------------------------------------------ */

package po.is.biz;

import xi.GMM02;
import xi.GMM03;

import comm.util.Util;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LBizException;
import devon.core.exception.LException;
import devon.core.exception.LSysException;
import devon.core.log.LLog;
import devonframework.persistent.autodao.LCommonDao;
import devonframework.persistent.autodao.LCompoundDao;

public class ReceiptMgntBiz {
	
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
            LLog.err.write(this.getClass().getName() + "." + "RetrievePoList()" + "=>" + le.getMessage());
            throw new LBizException("cm.cm.com.retrieve");
        }
        return list;

    }
    
    
     /**
     * 입고등록
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LData 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LData cudReceiptMgnt(LMultiData inputData, LData loginUser) throws LException {
        LCompoundDao dao 	 = new LCompoundDao();
        LCommonDao   getRecNo= new LCommonDao();
        LCommonDao   getPlant= new LCommonDao();
        
        LData header = new LData();
        LData result = new LData();
        LData resultMsg	= new LData();		// 결과메세지
        int cnt = 0;
        
		LLog.debug.println("cudReceiptMgntBiz inputData--------------- =>\n " + inputData.toString());
		
		String	getErrorCode = "0" ;
		String	getMessage	 = "Failed"; 	
		dao.startTransaction();
        try{			


			LData   resultInfo 	= new LData();		// Seq 생성

			String  strCheck	= "";
	        String msg 		    = "";
	        int qtyChk	= 0;
	        
	        
	        //xi start
	        //header
			LData Header = inputData.getLData(0);
			
			Header.setString("companyCd", loginUser.getString("companyCd"));		//회사코드
			Header.setString("userId", loginUser.getString("userId"));				//userId
			
			//입고번호 채번
	        LData recNo = getRecNo.executeQueryForSingle("/po/is/receiptMgntSql/getReceiptNo", Header);
	        //PLANT 
	        LData plant = getPlant.executeQueryForSingle("/po/is/receiptMgntSql/getRlantCd", Header);
			
			Header.setString("zxmldocno", recNo.getString("xmldocno"));				//INTERFACE ID
			Header.setString("recNo",    	recNo.getString("recno"));				//입고번호
			Header.setString("recStatus", "02");									//STATUS(01. 입고등록, 02. SAP전송, 03.SAP전송완료, 04.취소요청, 05.취소완료, 99. 오류 )
			Header.setString("plantCd",   plant.getString("plantCd"));									//plant(O110. pam, M110. mge)	
 
			//body
			//입고 detail 셋팅
			LMultiData mdata = new LMultiData();
			LMultiData mdata2 = new LMultiData();
			for(int i=0; i < inputData.getDataCount(); i++ ){
				LData data = inputData.getLData(i);
				
				LLog.debug.println("\n\n\n\n\n"+data.toString()+"\n\n\n\n\n");
				data.setString("companyCd", loginUser.getString("companyCd"));
				data.setString("userId", loginUser.getString("userId"));
				data.setString("recNo",    	recNo.getString("recno"));
				
				float recQty = Float.parseFloat(data.getString("recQty"));
				
				//LLog.info.println("recQty==================>"+recQty);
				if( recQty > 0){				
					mdata.addLData(data);
					qtyChk++ ;
				}else{
					mdata2.addLData(data);
				}
			} 
			
			//sap에 넘길 데이터가 있는경우
			if(0 != qtyChk){
				GMM02 gmm02 = new GMM02();
				resultMsg = gmm02.GMM02_out(Header, mdata);
			
				//xi end
				
				//return 값 셋팅
				Header.setString("returnStatus",   resultMsg.getString("returnStatus"));
				Header.setString("returnMsg",      "Trans Msg - "+ resultMsg.getString("returnMsg"));
				Header.setString("returnSapSeq",   resultMsg.getString("returnSapSeq"));
				
	
				
				//sap 전송 성공인 경우 입고등록 후 po에 입고 수량 update
				if (resultMsg.getString("returnStatus").equals("00")) {
					
					Header.setString("recStat",   "03");
					//입고마스터
					dao.add ("/po/is/receiptMgntSql/insertReceiptMaster", Header);
					//입고상세
					dao.add ("/po/is/receiptMgntSql/insertReceiptDetail", mdata);
					//po상세(sap 전송데이터)
					dao.add ("/po/is/receiptMgntSql/updatePoRecQty", mdata);
					//po상세(sap 전송안한 데이터:close처리만 한 item)
					dao.add ("/po/is/receiptMgntSql/updatePoRecQty", mdata2);
					
				//sap 전송 오류인 경우 입고등록 시 오류 내역 insert	
				} else if (resultMsg.getString("returnStatus").equals("99")) {
					
					Header.setString("recStat",   "99");
					//입고마스터
					dao.add ("/po/is/receiptMgntSql/insertReceiptMaster", Header);
					//입고상세
					dao.add ("/po/is/receiptMgntSql/insertReceiptDetail", mdata);
					getErrorCode = resultMsg.getString("returnStatus");
					getMessage = resultMsg.getString("returnMsg");
				} else {
					Header.setString("recStat",   "99");
					//입고마스터
					dao.add ("/po/is/receiptMgntSql/insertReceiptMaster", Header);
					//입고상세
					dao.add ("/po/is/receiptMgntSql/insertReceiptDetail", mdata);
					getErrorCode = resultMsg.getString("returnStatus");
					getMessage = resultMsg.getString("returnMsg");	
				}
			//sap에 넘길 데이터가 없는 경우 (close 처리만 할경우)
			}else{
				//po상세
				dao.add ("/po/is/receiptMgntSql/updatePoRecQty", mdata2);
			}
	        cnt = dao.executeUpdate(); 		

	        if(cnt > 0){
	        	getMessage = "OK";	
	        }
				
	        dao.commit();
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "cudSafetyStockMgnt()" + "=>" + se.getMessage());
			//throw new LSysException("pbf.err.com.save", se);
			dao.rollback();
			getErrorCode = "-1403";
			getMessage = se.getMessage();
			throw new LSysException(getMessage,se);
        }
		
		result.put("getErrorCode"	,getErrorCode);
		result.put("getMessage"	,getMessage);
		
		return result;
    } 
    
    
    
    /**
     * 출고등록
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LData cudStockIssue(LMultiData mData, LData inputData) throws LException {
        LCompoundDao dao = new LCompoundDao();
        LData result = new LData();
        int cnt = 0;
        
		LLog.debug.println("cudStockIssue mData--------------- =>\n " + mData.toString());
		
		String	getErrorCode = "0" ;
		String	getMessage	 = "Failed"; 	

        try{			
        	dao.startTransaction();

			LData   resultInfo 	= new LData();		// Seq 생성
			String  strCheck	= "";
	        String msg 		    = "";

	        LData issueNo = dao.executeQueryForSingle("/po/is/stockIssueSql/retrieveIssueNo", null);
	        for(int i=0;i<mData.getDataCount();i++){
	        	
				
	        	LData cudlData = mData.getLData(i);
	        	if(!cudlData.getString("chk").equals("T"))		// 체크되지 않으면 처리하지 않음
					continue;
				
	        	LMultiData resultList = dao.executeQuery("/po/is/stockIssueSql/retrieveMater", cudlData);
	        	if(resultList.getDataCount() ==0){   // 해당 Material이  Use No 인지 체크함 
	        		getMessage = cudlData.getString("materCd") + " Material is no use status";
	        		throw new LSysException(getMessage);
	        	}
	        	
	        	
	        	// issueNo 조회 
	        	
		        LCommonDao dao_plant = new LCommonDao("/po/is/stockIssueSql/retrievePlant", inputData);
		        LData result_plant = dao_plant.executeQueryForSingle();
		        
		        mData.addString("plantCd", result_plant.getString("plant"));									//plant(O110. pam, M110. mge)	
				mData.addLData(issueNo);
				
	            issueNo.setInt("issueNo", Integer.parseInt(issueNo.getString("issueNo"))+1);
	        }
	        
	        GMM03 gmm03 = new GMM03();
	        inputData.setString("status", "02");					// 02 : 전송 
	        gmm03.GMM03_out(mData, inputData);   		// XI로 출고 내역 전송(비동기)
	        
			for(int i=0;i<mData.getDataCount();i++) {
				
				LData cudlData = mData.getLData(i);
				if(!cudlData.getString("chk").equals("T"))		// 체크되지 않으면 처리하지 않음
					continue;
				
				cudlData.setString("companyCd", inputData.getString("companyCd"));
				cudlData.setString("userId",    inputData.getString("userId"));
				cudlData.setString("issueDate",    inputData.getString("issueDate"));
				cudlData.setString("postingDate",    inputData.getString("postingDate"));
				cudlData.setString("issueLoc",    inputData.getString("issueLoc"));
				
				
				LLog.info.write("\n SQL -> /po/is/stockIssueSql/cudStockIssue -------------> \n");
	            dao.add ("/po/is/stockIssueSql/insertStockIssue", cudlData);            
	            cnt = dao.executeUpdate();       	   
				if(cnt > 0){
					getMessage = "OK";					
				}				            

			}
			
			dao.commit();	
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "cudStockIssue()" + "=>" + se.getMessage());
			//throw new LSysException("pbf.err.com.save", se);
			dao.rollback();
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
    public LData cudStockMove(LMultiData mData, LData inputData) throws LException {
        LCompoundDao dao = new LCompoundDao();
        LData result = new LData();
        int cnt = 0;
        int cnt2 = 0;
        
		LLog.debug.println("cudStockMove mData--------------- =>\n " + mData.toString());
		
		String	getErrorCode = "0" ;
		String	getMessage	 = "Failed"; 	

        try{			

			LData   resultInfo 	= new LData();		// Seq 생성
			//LData   dataParam 	= new LData();
			String  strCheck	= "";
	        String msg 		    = "";
	        
			for(int i=0;i<mData.getDataCount();i++) {
				
				LData cudlData = mData.getLData(i);
				
				cudlData.setString("companyCd", inputData.getString("companyCd"));
				cudlData.setString("userId",    inputData.getString("userId"));
				cudlData.setString("issueDate",    inputData.getString("issueDate"));
				cudlData.setString("issueLoc",    inputData.getString("issueLoc"));
				cudlData.setString("recLoc",    inputData.getString("recLoc"));
				
				if( "DEVON_CREATE_FILTER_VALUE".equals(cudlData.getString( "DEVON_CUD_FILTER_KEY")) ) {
 
					LLog.info.write("\n SQL -> /po/is/StockMoveSql/cudStockMove -------------> \n");

		            dao.add ("/po/is/StockMoveSql/insertStockMove", cudlData);            
		            cnt = dao.executeUpdate(); 		
					if(cnt > 0){
						getMessage = "OK";					
					
					}
					
				} else if( "DEVON_UPDATE_FILTER_VALUE".equals(cudlData.getString( "DEVON_CUD_FILTER_KEY")) ) {
					LLog.info.write("\n SQL -> /po/is/StockMoveSql/cudStockMove -------------> \n");
					//출고처리
		            dao.add ("/po/is/StockMoveSql/insertStockMoveIssue", cudlData);            
		            //입고처리
		            dao.add ("/po/is/StockMoveSql/insertStockMoveReceipt", cudlData);            
		            cnt = dao.executeUpdate();
					if(cnt > 0 ){
						getMessage = "OK";					
					}				            
				} else if( "DEVON_DELETE_FILTER_VALUE".equals(cudlData.getString( "DEVON_CUD_FILTER_KEY")) ) {
		            dao.add ("/po/is/StockMoveSql/deleteStockMove", cudlData);            
		            cnt = dao.executeUpdate(); 
		            
					if(cnt > 0){
						getMessage = "OK";					
					}		            
				}
				
			}
			
				
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "cudStockMove()" + "=>" + se.getMessage());
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
     * 입고 마스터 조회 
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @throws LBizException 
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
	public LMultiData retrieveReceiptMasterList(LData inputData) throws LBizException {
        LMultiData list = null;

        try {
 
            LCommonDao dao = new LCommonDao("/po/is/receiptMgntSql/retrieveReceiptMasterList", inputData);
 
            list = dao.executeQuery();
            
        } catch (LException le) {
            LLog.err.write(this.getClass().getName() + "." + "RetrievecodeCbList()" + "=>" + le.getMessage());
            throw new LBizException("cm.cm.com.retrieve");
        }
        return list;
	}

    /**
     * 입고 디테일 조회
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @throws LBizException 
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
	
	public LMultiData retrieveReceiptDetailList(LData inputData) throws LBizException {
        LMultiData list = null;

        try {
 
            LCommonDao dao = new LCommonDao("/po/is/receiptMgntSql/retrieveReceiptDetailList", inputData);
 
            list = dao.executeQuery();
            
        } catch (LException le) {
            LLog.err.write(this.getClass().getName() + "." + "RetrievecodeCbList()" + "=>" + le.getMessage());
            throw new LBizException("cm.cm.com.retrieve");
        }
        return list;
	}

	/**
     * 입고 SAP 취소
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @throws LSysException 
     * @throws LBizException 
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */	

	public LData cudReceiptSAPCancel(LData inputDataMst, LMultiData inputDataDtl, LData loginUser) throws LSysException {
        LCompoundDao dao 	 = new LCompoundDao();
        LCommonDao   getRecNo= new LCommonDao();
        
        LData header = new LData();
        LData result = new LData();
        LData resultMsg	= new LData();		// 결과메세지
        int cnt = 0;
        
		LLog.debug.println("cudReceiptMgntBiz inputDataMst--------------- =>\n " + inputDataMst.toString());
		LLog.debug.println("cudReceiptMgntBiz inputDataDtl--------------- =>\n " + inputDataDtl.toString());
		
		String	getErrorCode = "0" ;
		String	getMessage	 = "Failed"; 	

        try{			

			LData   resultInfo 	= new LData();		// Seq 생성
			Util util = new Util();
			
			String  strCheck	= "";
	        String msg 		    = "";
	        
	        // material중 No use 가 있으면 리턴 시킴
	        for(int i=0; i<inputDataDtl.getDataCount(); i++){
		    	LMultiData resultList = dao.executeQuery("/po/is/stockIssueSql/retrieveMater", inputDataDtl.getLData(i));
		    	if(resultList.getDataCount() ==0){   // 해당 Material이  Use No 인지 체크함 
		    		getMessage = inputDataDtl.getString("materCd",i) + " Material is no use status";
		    		throw new LSysException(getMessage);
		    	}
	        }
	        
	        //xi start
	        
			// plant값을 DB에서 가져오기
	        LCommonDao dao_plant = new LCommonDao("/po/is/stockIssueSql/retrievePlant", loginUser);
	        LData result_plant = dao_plant.executeQueryForSingle();
	        
	        inputDataMst.setString("recStatus", "04");
	        inputDataMst.setString("recDate",   inputDataMst.getString("receiptDate"));
	        inputDataMst.setString("postDate",   inputDataMst.getString("postingDate"));
	        inputDataMst.setString("recNo", 	inputDataMst.getString("receiptSeq"));
			inputDataMst.setString("zxmldocno", util.getPlainDateTime("yyyyMMddHHmmss"));			 //INTERFACE ID				
			inputDataMst.setString("plantCd", result_plant.getString("plant"));									//plant(O110. pam, M110. mge)	
			inputDataMst.setString("userId", loginUser.getString("userId"));				//USER ID
			GMM02 gmm02 = new GMM02();
			resultMsg = gmm02.GMM02_out(inputDataMst, null);
			//xi end
			
			//return 값 셋팅
			inputDataMst.setString("returnStatus",   resultMsg.getString("returnStatus"));
			inputDataMst.setString("returnMsg",      "Cancel MSG - "+ resultMsg.getString("returnMsg"));
			inputDataMst.setString("returnSapSeq",   resultMsg.getString("returnSapSeq"));
			
			//receipt Detail 세팅
			for(int i=0; i<inputDataDtl.getDataCount(); i++){
				inputDataDtl.addString("userId", loginUser.getString("userId"));
				inputDataDtl.addString("poNo", inputDataMst.getString("poNo"));
				inputDataDtl.addString("companyCd", inputDataMst.getString("companyCd"));
			}
			//sap 전송 성공인 경우 입고등록 후 po에 입고 수량 update
			if (resultMsg.getString("returnStatus").equals("00")) {
				
				inputDataMst.setString("recStat",   "05"); //취소완료 상태 
				//입고마스터
				dao.add ("/po/is/receiptMgntSql/updateReceiptMaster", inputDataMst);
				//po상세
				dao.add ("/po/is/receiptMgntSql/cancelPoRecQty", inputDataDtl);
				
			//sap 전송 오류인 경우 입고등록 시 오류 내역 insert	
			} else if (resultMsg.getString("returnStatus").equals("99")) {
				
				inputDataMst.setString("recStat",   "03"); //SAP 전송완료 상태
				//입고마스터
				dao.add ("/po/is/receiptMgntSql/updateReceiptMaster", inputDataMst);
				getErrorCode = resultMsg.getString("returnStatus");
				getMessage = resultMsg.getString("returnMsg");
			} else {
				inputDataMst.setString("recStat",   "03"); //SAP 전송완료 상태
				//입고마스터
				dao.add ("/po/is/receiptMgntSql/updateReceiptMaster", inputDataMst);
				getErrorCode = resultMsg.getString("returnStatus");
				getMessage = resultMsg.getString("returnMsg");	
			}
			                     
	        cnt = dao.executeUpdate(); 		

	        if(cnt > 0){
	        	getMessage = "OK";	
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
	 * 20140704 추가
	 * */
	public LMultiData retrieveMovingMaterialQty(LData inputData) throws LException {
        LMultiData list = null;

        try {
 
        	LCommonDao dao = new LCommonDao("/po/is/stockMoveSql/retrieveMovingMaterialQty", inputData);
            list = dao.executeQuery();
            
        } catch (LException le) {
            LLog.err.write(this.getClass().getName() + "." + "retrieveMovingMaterialQty()" + "=>" + le.getMessage());
            throw new LBizException("po.is.MovingMaterialQty.retrieve");
        }
        return list;
        
	}
	
}