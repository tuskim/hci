/*
 *------------------------------------------------------------------------------
 * RetrieveSafetyStockMgntCmd.java,v 1.0 2010/07/23 16:43:35 
 * 
 * PROJ : PIT-PAM 
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2010/07/23            최초 프로그램 작성
 *----------------------------------------------------------------------------
 */
package po.sr.biz;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LBizException;
import devon.core.exception.LException; 
import devon.core.exception.LSysException;
import devon.core.log.LLog;
import devonframework.persistent.autodao.LCommonDao;
import devonframework.persistent.autodao.LCompoundDao;

/**
 * <PRE>
 * Menu Mgnt 정보의 조회/추가/수정/삭제/ 업무를 처리하는 Biz 클래스.
 *
 * Database Tables : 
 * </PRE>
 * @author    CEH
 */
public class SafetyStockMgntBiz {
    /**
     * MenuMgnt 정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */ 
	
    /**
     *retrieveSafetyStockMgntList 저장하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     ** @exception LException 메소드 수행시 발생한 모든 에러.
     */	
    public LMultiData retrieveSafetyStockMgntList(LData inputData) throws LException {
        LMultiData list = null;

        try {
 
            LCommonDao dao = new LCommonDao("/po/sr/safetyStockMgntSql/retrieveSafetyStockMgntList", inputData);
 
            list = dao.executeQuery();
            
        } catch (LException le) {
            LLog.err.write(this.getClass().getName() + "." + "retrieveSafetyStockMgntList()" + "=>" + le.getMessage());
            throw new LBizException("cm.cm.com.retrieve");
        }
        return list;

    }
    
    
    /**
     *cudSafetyStockMgnt 저장하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     ** @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LData cudSafetyStockMgnt(LMultiData inputData, LData loginUser) throws LException {
        LCompoundDao dao = new LCompoundDao();
        LData result = new LData();
        int cnt = 0; 
		LLog.debug.println("cudSafetyStockMgnt inputData--------------- =>\n " + inputData.toString());
		
		String	getErrorCode = "0" ;
		String	getMessage	 = "Failed"; 	

        try{			

			dao.startTransaction();

			//LData   resultInfo 	= new LData();		// Seq 생성
			//LData   dataParam 	= new LData();
			//String  strCheck	= "";
	        //String msg 		    = "";
	        
			for(int i=0;i<inputData.getDataCount();i++) {
				
				LData cudlData = inputData.getLData(i);

				cudlData.setString("companyCd", loginUser.getString("companyCd"));
				cudlData.setString("userId",    loginUser.getString("userId"));
				
				if( "DEVON_CREATE_FILTER_VALUE".equals(cudlData.getString( "DEVON_CUD_FILTER_KEY")) ) {
					/*
					LLog.info.write("\n SQL -> "+"/po/sr/safetyStockMgntSql/retrieveSafetyStockMgntDup -------------> \n");

					resultInfo = dao.executeQueryForSingle("/po/sr/safetyStockMgntSql/retrieveSafetyStockMgntDup", cudlData);
					strCheck   = resultInfo.getString("dupchk");

					if ( strCheck.equals("T") ) { 
						msg += "getErrorCode : " + getErrorCode + "\r\n";
						//msg += "simpleMsg : Duplicate Part No ["+ progCd +"] \r\n";
						
						getMessage   = msg; 
						throw new Exception(msg);	
						
					} else {
					*/
			            dao.add ("/po/sr/safetyStockMgntSql/insertSafety", cudlData);            
			            cnt = dao.executeUpdate(); 		
						if(cnt > 0){
							getMessage = "OK";					
						}	
					
					//}
					
				} else if( "DEVON_UPDATE_FILTER_VALUE".equals(cudlData.getString( "DEVON_CUD_FILTER_KEY")) ) {
		            dao.add ("/po/sr/safetyStockMgntSql/updateSafety", cudlData);            
		            cnt = dao.executeUpdate();       	   
					if(cnt > 0){
						getMessage = "OK";					
					}				            
				} else if( "DEVON_DELETE_FILTER_VALUE".equals(cudlData.getString( "DEVON_CUD_FILTER_KEY")) ) {
		            //dao.add ("/po/sr/safetyStockMgntSql/deleteSafety", cudlData);            
		            //cnt = dao.executeUpdate(); 
		            	            
				}
				
			}
			
			dao.commit();
				
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "insertDtCommCodeMgnt()" + "=>" + se.getMessage());
			throw new LSysException(se.getMessage());
		}
		
		result.put("getErrorCode"	,getErrorCode);
		result.put("getMessage"	,getMessage);
		
		return result;
    }      
     
    public LMultiData retrieveSafetyStockMgntDup(LData inputData) throws LException {
        LMultiData list = null;

        try {
 
            LCommonDao dao = new LCommonDao("/po/sr/safetyStockMgntSql/retrieveSafetyStockMgntDup", inputData);
 
            list = dao.executeQuery();
            
        } catch (LException le) {
            LLog.err.write(this.getClass().getName() + "." + "retrieveSafetyStockMgntDup()" + "=>" + le.getMessage());
            throw new LBizException("cm.cm.com.retrieve");
        }
        return list;

    }    
    
    public LMultiData RetrieveStockList(LData inputData) throws LException {
        LMultiData list = null;

        try {
 
            LCommonDao dao = new LCommonDao("/po/sr/safetyStockMgntSql/retrieveStockList", inputData);
 
            list = dao.executeQuery();
            
        } catch (LException le) {
            LLog.err.write(this.getClass().getName() + "." + "retrieveSafetyStockMgntDup()" + "=>" + le.getMessage());
            throw new LBizException("cm.cm.com.retrieve");
        }
        return list;

    }    
    
    /**
     *cudSafetyStockMgnt 저장하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     ** @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LData cudSafetyStockMgntDel(LData inputData) throws LException {
        LCompoundDao dao = new LCompoundDao();
        LData result = new LData();
        int cnt = 0; 
		LLog.debug.println("cudSafetyStockMgnt inputData--------------- =>\n " + inputData.toString());
		
		String	getErrorCode = "0" ;
		String	getMessage	 = "Failed"; 	

        try{			

			dao.startTransaction(); 
            dao.add ("/po/sr/safetyStockMgntSql/deleteSafety", inputData);            
            cnt = dao.executeUpdate(); 		
			if(cnt > 0){
				getMessage = "OK";					
			} 
			
			dao.commit();
				
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "insertDtCommCodeMgnt()" + "=>" + se.getMessage());
			throw new LSysException(se.getMessage());
		}
		
		result.put("getErrorCode"	,getErrorCode);
		result.put("getMessage"	,getMessage);
		
		return result;
    }          
}