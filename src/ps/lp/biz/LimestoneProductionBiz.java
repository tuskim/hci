/* ------------------------------------------------------------------------
 * @source  : LimestoneProductionBiz.java
 * @desc    : Limestone  등록, 조회, SAP 입고, 취소 처리
 * ------------------------------------------------------------------------
 * PROJ : 미얀마 시멘트 시스템 구축
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2016.08.02    kjkim               Initial
 * ------------------------------------------------------------------------ */

package ps.lp.biz;

import java.awt.event.InputEvent;

import xi.GMM14;


import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LBizException;
import devon.core.exception.LException;
import devon.core.exception.LSysException;
import devon.core.log.LLog;
import devonframework.persistent.autodao.LCommonDao;
import devonframework.persistent.autodao.LCompoundDao;

public class LimestoneProductionBiz {
	
	/**
     * Limestone Production List 목록 조회
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveLimestoneProductionList(LData inputData) throws LException {
        LMultiData list = null;

        try {        
 
            LCommonDao dao = new LCommonDao("/ps/lp/limestoneProductionSql/retrieveLimestoneProductionList", inputData);
            list = dao.executeQuery();
            
        } catch (LException le) {
            LLog.err.write(this.getClass().getName() + "." + "RetrievecodeCbList()" + "=>" + le.getMessage());
            throw new LBizException("cm.cm.com.retrieve");
        }
        return list;

    }

	/**
     * Limestone Production Excel List 목록 조회
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveLimestoneProductionExcelList(LData inputData) throws LException {
        LMultiData list = null;

        try {        
 
            LCommonDao dao = new LCommonDao("/ps/lp/limestoneProductionSql/retrieveLimestoneProductionExcelList", inputData);
            list = dao.executeQuery();
            
        } catch (LException le) {
            LLog.err.write(this.getClass().getName() + "." + "RetrievecodeCbList()" + "=>" + le.getMessage());
            throw new LBizException("cm.cm.com.retrieve");
        }
        return list;

    }


	/**
     * Result of Limestone 목록 조회
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveLimestoneProductionInfo(LData inputData) throws LException {
        LMultiData list = null;

        try {
 
            LCommonDao dao = new LCommonDao("/ps/lp/limestoneProductionSql/retrieveLimestoneProductionInfo", inputData);
            list = dao.executeQuery();
            
        } catch (LException le) {
            LLog.err.write(this.getClass().getName() + "." + "retrieveLimestoneProductionInfo()" + "=>" + le.getMessage());
            throw new LBizException("cm.cm.com.retrieve");
        }
        return list;

    }
    


	/**
     * Limestone Production Add Row 데이터 조회
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveLimestoneProductionAddRow(LData inputData) throws LException {
        LMultiData list = null;

        try {
        	
        	String sql = "";
        	
        	if(inputData.getString("dsType").equals("master")){
        		sql = "/ps/lp/limestoneProductionSql/retrieveLimestoneProductionAddMaster";
        	}else if(inputData.getString("dsType").equals("info")){
        		sql = "/ps/lp/limestoneProductionSql/retrieveLimestoneProductionAddResult";
        	}
            
            LCommonDao dao = new LCommonDao(sql, inputData);
            list = dao.executeQuery();
            
        } catch (LException le) {
            LLog.err.write(this.getClass().getName() + "." + "RetrievecodeCbList()" + "=>" + le.getMessage());
            throw new LBizException("cm.cm.com.retrieve");
        }
        return list;

    }
    
	/**
     * Limestone Production Date 조회
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveLimestoneProductionProdDate(LData inputData) throws LException {
        LMultiData list = null;

        try {        
 
            LCommonDao dao = new LCommonDao("/ps/lp/limestoneProductionSql/retrieveLimestoneProductionProdDate", inputData);
            list = dao.executeQuery();
            
        } catch (LException le) {
            LLog.err.write(this.getClass().getName() + "." + "RetrievecodeCbList()" + "=>" + le.getMessage());
            throw new LBizException("cm.cm.com.retrieve");
        }
        return list;

    }
    
    /**
     * Limestone 등록 및 수정
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LData cudLimestoneProductionRegMod(LMultiData mDataMst, LMultiData mDataInput, LData inputData) throws LException {
        LCompoundDao dao = new LCompoundDao();
        LData result = new LData();
        int cnt = 0;
        
		LLog.debug.println("cudLimestoneProduction mDataMaster--------------- =>\n " + mDataMst.toString());
		LLog.debug.println("cudLimestoneProduction mDataInput--------------- =>\n "  + mDataInput.toString());
		
		String	getErrorCode = "0" ;
		String	getMessage	 = "Failed"; 	

        try{			
	        // Master CUD
			for(int i=0;i<mDataMst.getDataCount();i++) {
				
				LData cudlData = mDataMst.getLData(i);
				
				cudlData.setString("companyCd", inputData.getString("companyCd"));
				cudlData.setString("userId",    inputData.getString("userId"));
				cudlData.setString("prodDate",   cudlData.getString("prodDate").replaceAll("/", ""));
				
				if( "DEVON_CREATE_FILTER_VALUE".equals(cudlData.getString( "DEVON_CUD_FILTER_KEY")) ) {
					LLog.info.write("\n SQL -> /ps/lp/limestoneProductionSql/insertLimestoneProdMaster -------------> \n");
		            dao.add ("/ps/lp/limestoneProductionSql/insertLimestoneProdMaster", cudlData);            
					
				} else if( "DEVON_UPDATE_FILTER_VALUE".equals(cudlData.getString( "DEVON_CUD_FILTER_KEY")) ) {
					LLog.info.write("\n SQL ->  /ps/lp/limestoneProductionSql/updateLimestoneProdMaster -------------> \n");
		            dao.add ("/ps/lp/limestoneProductionSql/updateLimestoneProdMaster", cudlData);    
					
				} else if( "DEVON_DELETE_FILTER_VALUE".equals(cudlData.getString( "DEVON_CUD_FILTER_KEY")) ) {
					LLog.info.write("\n SQL ->  /ps/lp/limestoneProductionSql/deleteLimestoneProdMaster -------------> \n");
		            dao.add ("/ps/lp/limestoneProductionSql/deleteLimestoneProdMaster", cudlData);               
            
				} 
			}
			
	        // INPUT CUD
			for(int i=0;i<mDataInput.getDataCount();i++) {
				
				LData cudlData = mDataInput.getLData(i);
				
				cudlData.setString("companyCd", inputData.getString("companyCd"));
				cudlData.setString("userId",    inputData.getString("userId"));
				
				if( "DEVON_CREATE_FILTER_VALUE".equals(cudlData.getString( "DEVON_CUD_FILTER_KEY")) ) {
					LLog.info.write("\n SQL -> /ps/lp/limestoneProductionSql/insertLimestoneProdInput -------------> \n");
		            dao.add ("/ps/lp/limestoneProductionSql/insertLimestoneProdInput", cudlData);            
					
				} else if( "DEVON_UPDATE_FILTER_VALUE".equals(cudlData.getString( "DEVON_CUD_FILTER_KEY")) ) {
					LLog.info.write("\n SQL ->  /ps/lp/limestoneProductionSql/updateLimestoneProdInput -------------> \n");
		            dao.add ("/ps/lp/limestoneProductionSql/updateLimestoneProdInput", cudlData);    
					
				}  
			}
			
            cnt = dao.executeUpdate(); 
            
			if(cnt > 0){
				getMessage = "OK";					
			}		
				
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "cudLimestoneProductionRegMod()" + "=>" + se.getMessage());
			getErrorCode = "-1403";
			getMessage = se.getMessage();
			throw new LSysException(getMessage,se);
        }
		
		result.put("getErrorCode"	,getErrorCode);
		result.put("getMessage"	,getMessage);
		
		return result;
    }
    
    
    
    /**
     * Limestone 삭제 (상태만 변경)
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */   
    public LData cudLimestoneProductionDelete(LMultiData mDataMst, LData inputData) throws LException {
        LCompoundDao dao = new LCompoundDao();
        LData result = new LData();
        int cnt = 0;
        
		LLog.debug.println("cudLimestoneProduction mDataMaster--------------- =>\n " + mDataMst.toString());
		
		String	getErrorCode = "0" ;
		String	getMessage	 = "Failed"; 	

        try{			
	        // Master CUD
			for(int i=0;i<mDataMst.getDataCount();i++) {
				
				LData cudlData = mDataMst.getLData(i);
				
				cudlData.setString("companyCd", inputData.getString("companyCd"));
				cudlData.setString("userId",    inputData.getString("userId"));
				
				if( "DEVON_DELETE_FILTER_VALUE".equals(cudlData.getString( "DEVON_CUD_FILTER_KEY")) ) {
					LLog.info.write("\n SQL ->  /ps/lp/limestoneProductionSql/deleteLimestoneProdMaster -------------> \n");
		            dao.add ("/ps/lp/limestoneProductionSql/deleteLimestoneProdMaster", cudlData);               
				} 
			}
			
			
            cnt = dao.executeUpdate(); 
            
			if(cnt > 0){
				getMessage = "OK";					
			}		
				
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "cudLimestoneProductionDelete()" + "=>" + se.getMessage());
			getErrorCode = "-1403";
			getMessage = se.getMessage();
			throw new LSysException(getMessage,se);
        }
		
		result.put("getErrorCode"	,getErrorCode);
		result.put("getMessage"	,getMessage);
		
		return result;
    }
    

    /**
     * Limestone Approval (상태만 변경)
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */   
    public LData cudLimestoneProductionApproval(LMultiData mDataMst, LData inputData) throws LException {
        LCompoundDao dao = new LCompoundDao();
        LData result = new LData();
        int cnt = 0;
        
		LLog.debug.println("cudLimestoneProduction mDataMaster--------------- =>\n " + mDataMst.toString());
		
		String	getErrorCode = "0" ;
		String	getMessage	 = "Failed"; 	

        try{			
	        // Master CUD
			for(int i=0;i<mDataMst.getDataCount();i++) {
				
				LData cudlData = mDataMst.getLData(i);
				
				cudlData.setString("companyCd", inputData.getString("companyCd"));
				cudlData.setString("userId",    inputData.getString("userId"));
				
				if( "DEVON_DELETE_FILTER_VALUE".equals(cudlData.getString( "DEVON_CUD_FILTER_KEY")) ) {
					LLog.info.write("\n SQL ->  /ps/lp/limestoneProductionSql/approvalLimestoneProdMaster -------------> \n");
		            dao.add ("/ps/lp/limestoneProductionSql/approvalLimestoneProdMaster", cudlData);               
				} 
			}
			
			
            cnt = dao.executeUpdate(); 
            
			if(cnt > 0){
				getMessage = "OK";					
			}		
				
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "cudLimestoneProductionApproval()" + "=>" + se.getMessage());
			getErrorCode = "-1403";
			getMessage = se.getMessage();
			throw new LSysException(getMessage,se);
        }
		
		result.put("getErrorCode"	,getErrorCode);
		result.put("getMessage"	,getMessage);
		
		return result;
    }
    
    /**
     * Limestone Reject (상태만 변경)
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */   
    public LData cudLimestoneProductionReject(LMultiData mDataMst, LData inputData) throws LException {
        LCompoundDao dao = new LCompoundDao();
        LData result = new LData();
        int cnt = 0;
        
		LLog.debug.println("cudLimestoneProduction mDataMaster--------------- =>\n " + mDataMst.toString());
		
		String	getErrorCode = "0" ;
		String	getMessage	 = "Failed"; 	

        try{			
	        // Master CUD
			for(int i=0;i<mDataMst.getDataCount();i++) {
				
				LData cudlData = mDataMst.getLData(i);
				
				cudlData.setString("companyCd", inputData.getString("companyCd"));
				cudlData.setString("userId",    inputData.getString("userId"));
				
				if( "DEVON_DELETE_FILTER_VALUE".equals(cudlData.getString( "DEVON_CUD_FILTER_KEY")) ) {
					LLog.info.write("\n SQL ->  /ps/lp/limestoneProductionSql/rejectLimestoneProdMaster -------------> \n");
		            dao.add ("/ps/lp/limestoneProductionSql/rejectLimestoneProdMaster", cudlData);               
				} 
			}
			
			
            cnt = dao.executeUpdate(); 
            
			if(cnt > 0){
				getMessage = "OK";					
			}		
				
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "cudLimestoneProductionReject()" + "=>" + se.getMessage());
			//throw new LSysException("pbf.err.com.save", se);
			getErrorCode = "-1403";
			getMessage = se.getMessage();
			throw new LSysException(getMessage,se);
        }
		
		result.put("getErrorCode"	,getErrorCode);
		result.put("getMessage"	,getMessage);
		
		return result;
    }
    
    ////// Register END
    /**
     *  SAP send
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LData CudLimestoneProductionSapSend(LMultiData headerData, LData loginUser) throws LException {
    	
    	LLog.info.write("\n Biz > CudLimestoneProductionSapSend() ------------- Start \n");
    	
        LCompoundDao dao		= new LCompoundDao();
        LCommonDao xdao         = new LCommonDao();
        LCommonDao statusDao    = new LCommonDao();

        LData resultSap		    = new LData();
    	LData resultMsg		    = new LData();
    	LMultiData bodyData	= new LMultiData();
    	
    	GMM14 gmm14 = new GMM14();
    	
    	try{
    		
    		//xmldocno 채번
    		LData xmlNo = xdao.executeQueryForSingle("cm/cm/commCodeMgntSql/retireveXmlDocNo", loginUser);			
        	LLog.info.write("\n Biz > xmlNo() ------------- > "+xmlNo);
        
    		dao.startTransaction();
    		
    		for(int i=0; i<headerData.getDataCount(); i++) {
    		
    			LData header = headerData.getLData(i);
    			header.setString("userId", 	loginUser.getString("userId"));
    			header.setString("companyCd",loginUser.getString("companyCd"));
    			//header.setString("deptCd",loginUser.getString("deptCd"));
    			header.setString("zxmldocno", xmlNo.getString("zxmldocno")); //xmldocno
    			
    			if (headerData.getString("status", i).equals("01")) { //신규 전송 건
    				
    				header.setString("transDate", xmlNo.getString("transDate")); //send Date
    				header.setString("cancelType", ""); //send Date
    				header.setString("prodDate", header.getString("prodDate").replaceAll("/", ""));
    				header.setString("postDate", header.getString("postDate").replaceAll("/", ""));
    				
    				//전송시 상태 01(Progress)인지 재확인	
    				 LData checkStatus = statusDao.executeQueryForSingle( "/ps/lp/limestoneProductionSql/checkSendingStatus" , header );
    				 LLog.info.write("SAP 전송할때의 status----->: " +checkStatus.getString("status"));								 
    				 if(checkStatus.getString("status").equals("01")){

    					LCommonDao commonDao2 = new LCommonDao( "/ps/lp/limestoneProductionSql/cudLimestoneProductionIputSapSend" , header );
    					bodyData = commonDao2.executeQuery();
    					
    					resultMsg = gmm14.GMM14_out(header, bodyData);
    					
    					header.setString("returnStatus", resultMsg.getString("returnStatus"));
    					header.setString("returnMsg", resultMsg.getString("returnText"));
    					header.setString("fiscalYear", resultMsg.getString("returnMjahr"));
    					header.setString("returnType", resultMsg.getString("returnType"));
    					header.setString("returnSapGiNo", resultMsg.getString("returnSapGiNo"));
    					header.setString("returnSapGrNo", resultMsg.getString("returnSapGrNo"));

    					if (resultMsg.getString("returnType").equals("00")) {
    						dao.add ("/ps/lp/limestoneProductionSql/cudLimestoneProductionAfterSapSuccess", header );
    					}else{
    						dao.add ("/ps/lp/limestoneProductionSql/cudLimestoneProductionAfterSapError", header ); 
    					}
    					
    					dao.executeUpdate();			
    					dao.commit();
    					
    					// 전송결과 에러시
    					if("99".equals(resultMsg.getString("returnType"))) {
    						resultSap.setString("getErrorCode", "99");
    						resultSap.setString("getMessage", resultMsg.getString("returnText"));
    						return resultSap;
    					}
    					
    				 }else{ //전송시 상태01이 아닌경우
    					resultSap.setString("getErrorCode", "99");
    					resultSap.setString("getMessage", "Check status again. You Can send when the status is Progress.");		
    					return resultSap;
    				 }
    			}
    		}

    	} catch (Exception se) {
    		dao.rollback();
    		throw new LBizException("ps.cp.cmd.send - " + "I/F Connection Error");
    	}
    	
    	resultSap.setString("getErrorCode", "00");
    	resultSap.setString("getMessage", "Successfully Sent");		
    	return resultSap;
    }

    /**
     *  SAP Cancel
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LData CudCpoProductionSapCancel(LMultiData headerData, LData loginUser) throws LException {
    	
    	LLog.info.write("\n Biz > CudCpoProductionSapCancel() ------------- Start \n");
    	
        LCompoundDao dao		= new LCompoundDao();
        LCommonDao statusDao    = new LCommonDao();

        LData resultSap		    = new LData();
    	LData resultMsg		    = new LData();
    	LMultiData bodyData	= new LMultiData();
    	
    	GMM14 gmm14 = new GMM14();
    	
    	try{
    		
    		dao.startTransaction();
    		
    		for(int i=0; i<headerData.getDataCount(); i++) {
    		
    			LData header = headerData.getLData(i);
    			header.setString("userId", 	loginUser.getString("userId"));
    			header.setString("companyCd",loginUser.getString("companyCd"));
    			//header.setString("deptCd",loginUser.getString("deptCd"));
    			
    			if (!headerData.getString("status", i).equals("00") && !headerData.getString("status", i).equals("01")) { //신규 전송 건
    				
    				header.setString("cancelType", "X"); //send Date
    				header.setString("prodDate", header.getString("prodDate").replaceAll("/", ""));
    				header.setString("postDate", header.getString("postDate").replaceAll("/", ""));
    				
    				//취소시 상태 01(Progress) 재확인
    				 LData checkStatus = statusDao.executeQueryForSingle( "/ps/lp/limestoneProductionSql/checkSendingStatus" , header );
    				 LLog.info.write("SAP 전송할때의 status----->: " +checkStatus.getString("status"));
    				 //progress(00), approval(01) 상태가 아니면 SAP Cancel 가능
    				 if(!checkStatus.getString("status").equals("00") && !checkStatus.getString("status").equals("01")){
    					
     					LCommonDao commonDao2 = new LCommonDao( "/ps/lp/limestoneProductionSql/cudLimestoneProductionIputSapSend" , header );
     					bodyData = commonDao2.executeQuery();
    					
    					resultMsg = gmm14.GMM14_out(header, bodyData);
    					
    					header.setString("returnStatus", resultMsg.getString("returnStatus"));
    					header.setString("returnMsg", resultMsg.getString("returnText"));
    					header.setString("returnType", resultMsg.getString("returnType"));
    					header.setString("returnSapGiNo", resultMsg.getString("returnSapGiNo"));
    					header.setString("returnSapGrNo", resultMsg.getString("returnSapGrNo"));

    					if (resultMsg.getString("returnType").equals("00")) {
    						dao.add ("/ps/lp/limestoneProductionSql/cudLimestoneProductionAfterSapCancel", header );
    					}else{
    						dao.add ("/ps/lp/limestoneProductionSql/cudLimestoneProductionAfterSapError", header ); 
    					}
    					
    					dao.executeUpdate();
    					dao.commit();
    					
    					// 전송결과 에러시
    					if("99".equals(resultMsg.getString("returnType"))) {
    						resultSap.setString("getErrorCode", "99");
    						resultSap.setString("getMessage", resultMsg.getString("returnText"));
    						return resultSap;
    					}
    					
    				 }else{
    						resultSap.setString("getErrorCode", "99");
    						resultSap.setString("getMessage", "Check status again. You Can not Cancel when the status is Progress.");		
    						return resultSap;
    				 }
    			}else{
    				resultSap.setString("getErrorCode", "99");
    				resultSap.setString("getMessage", "Check status again. You Can not Cancel when the status is Progress.");		
    				return resultSap;
    			}
    		}

    	} catch (Exception se) {
    		dao.rollback();
    		throw new LBizException("ps.cp.cmd.send - " + "I/F Connection Error");
    	}

    	resultSap.setString("getErrorCode", "00");
    	resultSap.setString("getMessage", "Successfully Canceled");		
    	return resultSap;
    }
    
}