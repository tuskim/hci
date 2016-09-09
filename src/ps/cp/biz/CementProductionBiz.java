/* ------------------------------------------------------------------------
 * @source  : CementProductionBiz.java
 * @desc    : Cement  등록, 조회, SAP 입고, 취소 처리
 * ------------------------------------------------------------------------
 * PROJ : 미얀마 시멘트 시스템 구축
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2016.08.02    kjkim               Initial
 * ------------------------------------------------------------------------ */

package ps.cp.biz;

import java.awt.event.InputEvent;

import xi.GMM11;
import xi.GSD01;
import xi.GSD03;


import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LBizException;
import devon.core.exception.LException;
import devon.core.exception.LSysException;
import devon.core.log.LLog;
import devonframework.persistent.autodao.LCommonDao;
import devonframework.persistent.autodao.LCompoundDao;

public class CementProductionBiz {
	
	/**
     * Cement Production List 목록 조회
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveCementProductionList(LData inputData) throws LException {
        LMultiData list = null;

        try {        
 
            LCommonDao dao = new LCommonDao("/ps/cp/cementProductionSql/retrieveCementProductionList", inputData);
            list = dao.executeQuery();
            
        } catch (LException le) {
            LLog.err.write(this.getClass().getName() + "." + "retrieveCementProductionList()" + "=>" + le.getMessage());
            throw new LBizException("cm.cm.com.retrieve");
        }
        return list;

    }

	/**
     * Cement Production Excel   조회
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData RetrieveCementProductionExcelList(LData inputData) throws LException {
        LMultiData list = null;

        try {        
 
            LCommonDao dao = new LCommonDao("/ps/cp/cementProductionSql/retrieveCementProductionExcelList", inputData);
            list = dao.executeQuery();
            
        } catch (LException le) {
            LLog.err.write(this.getClass().getName() + "." + "RetrieveCementProductionExcelList()" + "=>" + le.getMessage());
            throw new LBizException("cm.cm.com.retrieve");
        }
        return list;

    }
    
	/**
     * Use of Material for Cement 목록 조회
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveCementProductionMaterial(LData inputData) throws LException {
        LMultiData list = null;

        try {
 
            LCommonDao dao = new LCommonDao("/ps/cp/cementProductionSql/retrieveCementProductionMaterial", inputData);
            list = dao.executeQuery();
            
        } catch (LException le) {
            LLog.err.write(this.getClass().getName() + "." + "retrieveCementProductionMaterial()" + "=>" + le.getMessage());
            throw new LBizException("cm.cm.com.retrieve");
        }
        return list;

    }


	/**
     * Result of Cement 목록 조회
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveCementProductionResult(LData inputData) throws LException {
        LMultiData list = null;

        try {
 
            LCommonDao dao = new LCommonDao("/ps/cp/cementProductionSql/retrieveCementProductionResult", inputData);
            list = dao.executeQuery();
            
        } catch (LException le) {
            LLog.err.write(this.getClass().getName() + "." + "retrieveCementProductionResult()" + "=>" + le.getMessage());
            throw new LBizException("cm.cm.com.retrieve");
        }
        return list;

    }
    


	/**
     * Cement Production Add Row 데이터 조회
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveCementProductionAddRow(LData inputData) throws LException {
        LMultiData list = null;

        try {
        	
        	String sql = "";
        	
        	if(inputData.getString("dsType").equals("master")){
        		sql = "/ps/cp/cementProductionSql/retrieveCementProductionAddMaster";
        	}else if(inputData.getString("dsType").equals("use")){
        		sql = "/ps/cp/cementProductionSql/retrieveCementProductionAddUse";
        	}else if(inputData.getString("dsType").equals("result")){
        		sql = "/ps/cp/cementProductionSql/retrieveCementProductionAddResult";
        	}
            
            LCommonDao dao = new LCommonDao(sql, inputData);
            list = dao.executeQuery();
            
        } catch (LException le) {
            LLog.err.write(this.getClass().getName() + "." + "retrieveCementProductionAddRow()" + "=>" + le.getMessage());
            throw new LBizException("cm.cm.com.retrieve");
        }
        return list;

    }
    
	/**
     * Clinker Production Date 조회
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveCementProductionProdDate(LData inputData) throws LException {
        LMultiData list = null;

        try {        
 
            LCommonDao dao = new LCommonDao("/ps/cp/cementProductionSql/retrieveCementProductionProdDate", inputData);
            list = dao.executeQuery();
            
        } catch (LException le) {
            LLog.err.write(this.getClass().getName() + "." + "retrieveCementProductionProdDate()" + "=>" + le.getMessage());
            throw new LBizException("cm.cm.com.retrieve");
        }
        return list;

    }
    
    /**
     * CEMENT 등록 및 수정
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LData cudCementProductionRegMod(LMultiData mDataMst, LMultiData mDataOutput, LMultiData mDataInput, LData inputData) throws LException {
        LCompoundDao dao = new LCompoundDao();
        LData result = new LData();
        int cnt = 0;
        
		LLog.debug.println("cudCementProduction mDataMaster--------------- =>\n " + mDataMst.toString());
		LLog.debug.println("cudCementProduction mDataOutput--------------- =>\n " + mDataOutput.toString());
		LLog.debug.println("cudCementProduction mDataInput--------------- =>\n "  + mDataInput.toString());
		
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
					LLog.info.write("\n SQL -> /ps/cp/cementProductionSql/insertCementProdMaster -------------> \n");
		            dao.add ("/ps/cp/cementProductionSql/insertCementProdMaster", cudlData);            
					
				} else if( "DEVON_UPDATE_FILTER_VALUE".equals(cudlData.getString( "DEVON_CUD_FILTER_KEY")) ) {
					LLog.info.write("\n SQL ->  /ps/cp/cementProductionSql/updateCementProdMaster -------------> \n");
		            dao.add ("/ps/cp/cementProductionSql/updateCementProdMaster", cudlData);    
					
				} else if( "DEVON_DELETE_FILTER_VALUE".equals(cudlData.getString( "DEVON_CUD_FILTER_KEY")) ) {
					LLog.info.write("\n SQL ->  /ps/cp/cementProductionSql/deleteCementProdMaster -------------> \n");
		            dao.add ("/ps/cp/cementProductionSql/deleteCementProdMaster", cudlData);               
            
				} 
			}
			
	        // OUTPUT CUD
			for(int i=0;i<mDataOutput.getDataCount();i++) {
				
				LData cudlData = mDataOutput.getLData(i);
				
				cudlData.setString("companyCd", inputData.getString("companyCd"));
				cudlData.setString("userId",    inputData.getString("userId"));
				
				if( "DEVON_CREATE_FILTER_VALUE".equals(cudlData.getString( "DEVON_CUD_FILTER_KEY")) ) {
					LLog.info.write("\n SQL -> /ps/cp/cementProductionSql/insertCementProdOutput -------------> \n");
		            dao.add ("/ps/cp/cementProductionSql/insertCementProdOutput", cudlData);            
					
				} else if( "DEVON_UPDATE_FILTER_VALUE".equals(cudlData.getString( "DEVON_CUD_FILTER_KEY")) ) {
					LLog.info.write("\n SQL ->  /ps/cp/cementProductionSql/updateCementProdOutput -------------> \n");
		            dao.add ("/ps/cp/cementProductionSql/updateCementProdOutput", cudlData);    
					
				} else if( "DEVON_DELETE_FILTER_VALUE".equals(cudlData.getString( "DEVON_CUD_FILTER_KEY")) ) {
					LLog.info.write("\n SQL ->  /ps/cp/cementProductionSql/deleteCementProdOutput -------------> \n");
		            dao.add ("/ps/cp/cementProductionSql/deleteCementProdOutput", cudlData);    
					
				}
			}
			
	        // INPUT CUD
			for(int i=0;i<mDataInput.getDataCount();i++) {
				
				LData cudlData = mDataInput.getLData(i);
				
				cudlData.setString("companyCd", inputData.getString("companyCd"));
				cudlData.setString("userId",    inputData.getString("userId"));
				
				if( "DEVON_CREATE_FILTER_VALUE".equals(cudlData.getString( "DEVON_CUD_FILTER_KEY")) ) {
					LLog.info.write("\n SQL -> /ps/cp/cementProductionSql/insertCementProdInput -------------> \n");
		            dao.add ("/ps/cp/cementProductionSql/insertCementProdInput", cudlData);            
					
				} else if( "DEVON_UPDATE_FILTER_VALUE".equals(cudlData.getString( "DEVON_CUD_FILTER_KEY")) ) {
					LLog.info.write("\n SQL ->  /ps/cp/cementProductionSql/updateCementProdInput -------------> \n");
		            dao.add ("/ps/cp/cementProductionSql/updateCementProdInput", cudlData);    
					
				}  
			}
			
            cnt = dao.executeUpdate(); 
            
			if(cnt > 0){
				getMessage = "OK";					
			}		
				
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "cudCementProductionRegMod()" + "=>" + se.getMessage());
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
     * CEMENT 삭제 (상태만 변경)
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */   
    public LData cudCementProductionDelete(LMultiData mDataMst, LData inputData) throws LException {
        LCompoundDao dao = new LCompoundDao();
        LData result = new LData();
        int cnt = 0;
        
		LLog.debug.println("cudCementProduction mDataMaster--------------- =>\n " + mDataMst.toString());
		
		String	getErrorCode = "0" ;
		String	getMessage	 = "Failed"; 	

        try{			
	        // Master CUD
			for(int i=0;i<mDataMst.getDataCount();i++) {
				
				LData cudlData = mDataMst.getLData(i);
				
				cudlData.setString("companyCd", inputData.getString("companyCd"));
				cudlData.setString("userId",    inputData.getString("userId"));
				
				if( "DEVON_DELETE_FILTER_VALUE".equals(cudlData.getString( "DEVON_CUD_FILTER_KEY")) ) {
					LLog.info.write("\n SQL ->  /ps/cp/cementProductionSql/deleteCementProdMaster -------------> \n");
		            dao.add ("/ps/cp/cementProductionSql/deleteCementProdMaster", cudlData);               
				} 
			}
			
			
            cnt = dao.executeUpdate(); 
            
			if(cnt > 0){
				getMessage = "OK";					
			}		
				
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "cudCementProductionDelete()" + "=>" + se.getMessage());
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
     * CEMENT Approval (상태만 변경)
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */   
    public LData cudCementProductionApproval(LMultiData mDataMst, LData inputData) throws LException {
        LCompoundDao dao = new LCompoundDao();
        LData result = new LData();
        int cnt = 0;
        
		LLog.debug.println("cudCementProduction mDataMaster--------------- =>\n " + mDataMst.toString());
		
		String	getErrorCode = "0" ;
		String	getMessage	 = "Failed"; 	

        try{
	        // Master CUD
			for(int i=0;i<mDataMst.getDataCount();i++) {
				
				LData cudlData = mDataMst.getLData(i);
				
				cudlData.setString("companyCd", inputData.getString("companyCd"));
				cudlData.setString("userId",    inputData.getString("userId"));
				
				if( "DEVON_DELETE_FILTER_VALUE".equals(cudlData.getString( "DEVON_CUD_FILTER_KEY")) ) {
					LLog.info.write("\n SQL ->  /ps/cp/cementProductionSql/approvalCementProdMaster -------------> \n");
		            dao.add ("/ps/cp/cementProductionSql/approvalCementProdMaster", cudlData);               
				} 
			}
			
			
            cnt = dao.executeUpdate(); 
            
			if(cnt > 0){
				getMessage = "OK";					
			}		
				
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "cudCementProductionApproval()" + "=>" + se.getMessage());
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
     * CEMENT Reject (상태만 변경)
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */   
    public LData cudCementProductionReject(LMultiData mDataMst, LData inputData) throws LException {
        LCompoundDao dao = new LCompoundDao();
        LData result = new LData();
        int cnt = 0;
        
		LLog.debug.println("cudCementProduction mDataMaster--------------- =>\n " + mDataMst.toString());
		
		String	getErrorCode = "0" ;
		String	getMessage	 = "Failed"; 	

        try{			
	        // Master CUD
			for(int i=0;i<mDataMst.getDataCount();i++) {
				
				LData cudlData = mDataMst.getLData(i);
				
				cudlData.setString("companyCd", inputData.getString("companyCd"));
				cudlData.setString("userId",    inputData.getString("userId"));
				
				if( "DEVON_DELETE_FILTER_VALUE".equals(cudlData.getString( "DEVON_CUD_FILTER_KEY")) ) {
					LLog.info.write("\n SQL ->  /ps/cp/cementProductionSql/rejectCementProdMaster -------------> \n");
		            dao.add ("/ps/cp/cementProductionSql/rejectCementProdMaster", cudlData);               
				} 
			}
			
			
            cnt = dao.executeUpdate(); 
            
			if(cnt > 0){
				getMessage = "OK";					
			}		
				
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "cudCementProductionReject()" + "=>" + se.getMessage());
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
     * SAP SEND 전에 이전 공정에서 동일 생산일자 기준 SAP전송이 완료(STATUS:04) 상태조회
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData checkCementBeforeProductionStatus(LData inputData) throws LException {
        LMultiData list = null;

        try {        
 
            LCommonDao dao = new LCommonDao("/ps/cp/cementProductionSql/checkCementBeforeProductionStatus", inputData);
            list = dao.executeQuery();
            
        } catch (LException le) {
            LLog.err.write(this.getClass().getName() + "." + "checkCementBeforeProductionStatus()" + "=>" + le.getMessage());
            throw new LBizException("cm.cm.com.retrieve");
        }
        return list;

    }
    
    /**
     *  SAP send
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LData CudCementProductionSapSend(LMultiData headerData, LData loginUser) throws LException {
    	
    	LLog.info.write("\n Biz > CudCementProductionSapSend() ------------- Start \n");
    	
        LCompoundDao dao		= new LCompoundDao();
        LCommonDao xdao         = new LCommonDao();
        LCommonDao statusDao    = new LCommonDao();

        LData resultSap		    = new LData();
    	LData resultMsg		    = new LData();
    	LMultiData bodyData1    = new LMultiData();
    	LMultiData bodyData2	= new LMultiData();
    	
    	GMM11 gmm11 = new GMM11();
    	
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
    				 LData checkStatus = statusDao.executeQueryForSingle( "/ps/cp/cementProductionSql/checkSendingStatus" , header );
    				 LLog.info.write("SAP 전송할때의 status----->: " +checkStatus.getString("status"));								 
    				 if(checkStatus.getString("status").equals("01")){

    					LCommonDao commonDao = new LCommonDao( "/ps/cp/cementProductionSql/cudCementProductionOutputSapSend" , header );
    					bodyData1 = commonDao.executeQuery();
    					LCommonDao commonDao2 = new LCommonDao( "/ps/cp/cementProductionSql/cudCementProductionIputSapSend" , header );
    					bodyData2 = commonDao2.executeQuery();
    					
    					resultMsg = gmm11.GMM11_out(header, bodyData1, bodyData2);
    					
    					 //전송시 상태 02(sent)으로 변경
    					//statusDao = new LCommonDao( "/ps/cp/cementProductionSql/cudCementProductionSendingStatus" , header );
    					//statusDao.executeUpdate();

    					header.setString("returnStatus", resultMsg.getString("returnStatus"));
    					header.setString("returnMsg", resultMsg.getString("returnText"));
    					header.setString("fiscalYear", resultMsg.getString("returnMjahr"));
    					header.setString("returnType", resultMsg.getString("returnType"));
    					header.setString("returnSapGiNo", resultMsg.getString("returnSapGiNo"));
    					header.setString("returnSapGrNo", resultMsg.getString("returnSapGrNo"));

    					if (resultMsg.getString("returnType").equals("00")) {
    						dao.add ("/ps/cp/cementProductionSql/cudCementProductionAfterSapSuccess", header );
    					}else{
    						dao.add ("/ps/cp/cementProductionSql/cudCementProductionAfterSapError", header ); 
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
    	LMultiData bodyData1    = new LMultiData();
    	LMultiData bodyData2	= new LMultiData();
    	
    	GMM11 gmm11 = new GMM11();
    	
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
    				 LData checkStatus = statusDao.executeQueryForSingle( "/ps/cp/cementProductionSql/checkSendingStatus" , header );
    				 LLog.info.write("SAP 전송할때의 status----->: " +checkStatus.getString("status"));
    				 //progress(00), approval(01) 상태가 아니면 SAP Cancel 가능
    				 if(!checkStatus.getString("status").equals("00") && !checkStatus.getString("status").equals("01")){
    					
    					 //전송시 상태 02(sent)으로 변경
    					//statusDao = new LCommonDao( "/ps/cp/cementProductionSql/cudCementProductionSendingStatus" , header );
    					//statusDao.executeUpdate();
    					
     					LCommonDao commonDao = new LCommonDao( "/ps/cp/cementProductionSql/cudCementProductionOutputSapSend" , header );
     					bodyData1 = commonDao.executeQuery();
     					LCommonDao commonDao2 = new LCommonDao( "/ps/cp/cementProductionSql/cudCementProductionIputSapSend" , header );
     					bodyData2 = commonDao2.executeQuery();
    					
    					resultMsg = gmm11.GMM11_out(header, bodyData1, bodyData2);
    					
    					header.setString("returnStatus", resultMsg.getString("returnStatus"));
    					header.setString("returnMsg", resultMsg.getString("returnText"));
    					header.setString("returnType", resultMsg.getString("returnType"));
    					header.setString("returnSapGiNo", resultMsg.getString("returnSapGiNo"));
    					header.setString("returnSapGrNo", resultMsg.getString("returnSapGrNo"));

    					if (resultMsg.getString("returnType").equals("00")) {
    						dao.add ("/ps/cp/cementProductionSql/cudCementProductionAfterSapCancel", header );
    					}else{
    						dao.add ("/ps/cp/cementProductionSql/cudCementProductionAfterSapError", header ); 
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