/*
 *------------------------------------------------------------------------------
 * $Id: AssetBiz.java
 * 
 * PROJ : LGI-Hub System
 * Copyright 2010 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2015.11.27           Init
 *----------------------------------------------------------------------------
 */

package fi.at.biz;

import java.util.Vector;
import xi.GFI10;
import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LException;
import devon.core.exception.LSysException;
import devon.core.log.LLog;
import devonframework.persistent.autodao.LCommonDao;
import devonframework.persistent.autodao.LCompoundDao;

public class AssetBiz {

	/**
     * Internal Order Code List 정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
	public LMultiData retrieveInternalOrderCodeListPopup(LData inputData) throws LException {

		LLog.info.write("\n AssetBiz > retrieveInternalOrderCodeListPopup() -------> Start \n");
		
        LCommonDao dao = new LCommonDao();
        
		try{
			return dao.executeQuery("/fi/at/assetSql/retrieveInternalOrderCodeListPopup", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveInternalOrderCodeListPopup------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		} 
    }
	
	/**
     * 자산요청번호 정보를 조회하는 메소드. (GAM)
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LData retrieveMdAssetRequestNo(LData inputData) throws LException {      	
    	  
    	LCommonDao dao = new LCommonDao();
    	
		try{			
			return dao.executeQueryForSingle("/fi/at/assetSql/retrieveMdAssetRequestNo", inputData);			
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveMdAssetRequestNo------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		}
    }
    
    /**
     * 자산요청번호 정보를 조회하는 메소드. (BNE)
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LData retrieveUaAssetRequestNo(LData inputData) throws LException {      	
    	  
    	LCommonDao dao = new LCommonDao();
    	
		try{			
			return dao.executeQueryForSingle("/fi/at/assetSql/retrieveUaAssetRequestNo", inputData);			
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveUaAssetRequestNo------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		}
    }
    
    /**
     * Request Information (자산 취득 요청 정보) 저장
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LData cudAssetInfo(LData inputData) throws LException {
		
    	LLog.info.write("\n AssetBiz > cudAssetInfo() ------------- Start \n");
    	
        LCompoundDao dao = new LCompoundDao();
        LData result     = new LData();
        
        String getErrorCode = "0" ;
		String getMessage	= "Failed";
		
		try{
									
			dao.startTransaction();																		
															
			// 자산 취득 요청 정보 저장
			dao.add ("/fi/at/assetSql/insertAssetInfo", inputData);				
			dao.executeUpdate();      
	            							
			getMessage = "Ok";
			
			dao.commit();	
			
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "cudAssetInfo()" + "=>" + se.getMessage());			
			dao.rollback();
			getErrorCode = "-1403";
			getMessage = "Error(cudAssetInfo) Please ask to system manager";						  
        }
		
		result.put("getErrorCode", getErrorCode);
		result.put("getMessage", getMessage);
		
		return result;
    }
    
    /**
     * Requested Asset List (요청된 자산취득 목록) 정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveRequestedAssetList(LData inputData) throws LException {    	
    	
    	LLog.debug.write("AssetBiz.retrieveRequestedAssetList -----------> Start ");
    	
    	LCommonDao dao = new LCommonDao();
		try{			
			return dao.executeQuery("fi/at/assetSql/retrieveRequestedAssetList", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveRequestedAssetList------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		}
    }

    
    /**
     * Requested Asset 정보 삭제
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LData cudRequestedAssetInfo(LData inputData) throws LException {
		
    	LLog.info.write("\n AssetBiz > cudRequestedAssetInfo() ------------- Start \n");
    	
        LCompoundDao dao  = new LCompoundDao();
        LData result      = new LData();        
        
        String getErrorCode = "0" ;
		String getMessage	= "Failed";
		
		try{
									
			dao.startTransaction();																																																											
            				
			// Requested Asset 정보 삭제
			dao.add ("/fi/at/assetSql/updateRequestedAssetInfo", inputData);				
			dao.executeUpdate();      	            																		
												
			getMessage = "Ok";			
			dao.commit();
																													
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "cudRequestedAssetInfo()" + "=>" + se.getMessage());			
			dao.rollback();
			getErrorCode = "-1403";
			getMessage = se.getMessage();		
        }
		
		result.put("getErrorCode", getErrorCode);
		result.put("getMessage", getMessage);
		
		return result;
    }
    
    /**
     * Asset List 화면 - Current Asset List 정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveCurrentAssetList(LData inputData) throws LException {	
		
		LLog.info.write("AssetBiz.retrieveCurrentAssetList ------------- Start ");
         
		String getMessage		= "";  
		LData resultMsg		    = new LData();  
		LMultiData resultDtlMsg = new LMultiData();
		
		try{
 
			GFI10 gfi10 = new GFI10();
			Vector oResultMsg = gfi10.GFI10_out(inputData);
 
			resultMsg =(LData) oResultMsg.get(0);			
			resultDtlMsg =(LMultiData) oResultMsg.get(1);						
			
			LLog.info.write("resultMsg:"+resultMsg);
			LLog.info.write("resultDtlMsg:"+resultDtlMsg);
			
			if(resultMsg.size()!=0){
				if (resultMsg.getString("returnType").equals("0")) {
					getMessage = resultMsg.getString("returnText");
					LLog.err.println(  this.getClass().getName() + "." + "retrieveCurrentAssetList1-returnType::" +resultMsg.getString("returnType")+"=>\n" + getMessage);			
				} else {  
					getMessage = resultMsg.getString("returnText");
					LLog.err.println(  this.getClass().getName() + "." + "retrieveCurrentAssetList3-returnType:: "+resultMsg.getString("returnType")+"=>\n" + getMessage);					 
				}
			}else{
				LLog.err.println(  this.getClass().getName() + "." + "retrieveCurrentAssetList No Return Date");
			}
			 
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveCurrentAssetList Exceiption------()" + "=>" + se.getMessage());
			throw new LSysException("fi.at.biz.retrieveCurrentAssetList Exceiption", se); 
		} 
		
		return resultDtlMsg;						
		
    }
    
    /**
     * 자산 매각 요청 정보 저장
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LData cudAssetDisposalInfo(LData inputData) throws LException {
		
    	LLog.info.write("\n AssetBiz > cudAssetDisposalInfo() ------------- Start \n");
    	
        LCompoundDao dao = new LCompoundDao();
        LData result     = new LData();
        
        String getErrorCode = "0" ;
		String getMessage	= "Failed";
		
		try{
									
			dao.startTransaction();																		
															
			// 자산 매각 요청 정보 저장
			dao.add ("/fi/at/assetSql/insertAssetDisposalInfo", inputData);				
			dao.executeUpdate();      
	            							
			getMessage = "Ok";
			
			dao.commit();	
			
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "cudAssetDisposalInfo()" + "=>" + se.getMessage());			
			dao.rollback();
			getErrorCode = "-1403";
			getMessage = "Error(cudAssetInfo) Please ask to system manager";						  
        }
		
		result.put("getErrorCode", getErrorCode);
		result.put("getMessage", getMessage);
		
		return result;
    }
    
    /**
     * 자산번호 - 매각, 폐기 요청 여부(중복) 확인
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveAssetNoRequestCheck(LData inputData) throws LException {
        
    	LMultiData 	result 	= null;
 
        try {
            LCommonDao dao = new LCommonDao("/fi/at/assetSql/retrieveAssetNoRequestCheck", inputData);
            result = dao.executeQuery();
        } catch ( LException e ) {
            e.getMessage();
            throw e;
        }
        
        return result;
    }
    
    /**
     * 자산 폐기 요청 정보 저장
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LData cudAssetRetirementInfo(LData inputData) throws LException {
		
    	LLog.info.write("\n AssetBiz > cudAssetRetirementInfo() ------------- Start \n");
    	
        LCompoundDao dao = new LCompoundDao();
        LData result     = new LData();
        
        String getErrorCode = "0" ;
		String getMessage	= "Failed";
		
		try{
									
			dao.startTransaction();																		
															
			// 자산 폐기 요청 정보 저장
			dao.add ("/fi/at/assetSql/insertAssetRetirementInfo", inputData);				
			dao.executeUpdate();      
	            							
			getMessage = "Ok";
			
			dao.commit();	
			
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "cudAssetRetirementInfo()" + "=>" + se.getMessage());			
			dao.rollback();
			getErrorCode = "-1403";
			getMessage = "Error(cudAssetInfo) Please ask to system manager";						  
        }
		
		result.put("getErrorCode", getErrorCode);
		result.put("getMessage", getMessage);
		
		return result;
    }
}
