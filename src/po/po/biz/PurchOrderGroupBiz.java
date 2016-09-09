/*
 *------------------------------------------------------------------------------
 * PurchOrderGroupBiz.java,v 1.0 2010/07/23 16:43:35 
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
package po.po.biz;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LBizException;
import devon.core.exception.LException; 
import devon.core.exception.LSysException;
import devon.core.log.LLog;
import devonframework.persistent.autodao.LCommonDao;
import devonframework.persistent.autodao.LCompoundDao;
import comm.util.StringUtil;
/**
 * <PRE>
 * Menu Mgnt 정보의 조회/추가/수정/삭제/ 업무를 처리하는 Biz 클래스.
 *
 * Database Tables : 
 * </PRE>
 * @author    CEH
 */
public class PurchOrderGroupBiz {
    /**
     * MenuMgnt 정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
	public String strSqlPath="po/po/purchOrderGroupSql";
	
    /**
     *retrievePurchOrderGroupList 저장하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     ** @exception LException 메소드 수행시 발생한 모든 에러.
     */	
    public LMultiData retrievePurchOrderGroupList(LData inputData) throws LException {
        LMultiData list = null;

        try {
 
            LCommonDao dao = new LCommonDao(strSqlPath+"/retrievePurchOrderGroupList", inputData);
 
            list = dao.executeQuery();
            
        } catch (LException le) {
            LLog.err.write(this.getClass().getName() + "." + "retrievePurchOrderGroupList()" + "=>" + le.getMessage());
            throw new LBizException("cm.cm.com.retrieve");
        }
        return list;

    }
    
    
    /**
     *cudPurchOrderGroup 저장하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     ** @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LData cudPurchOrderGroup(LMultiData inputMaster,LMultiData inputDetail, LData loginUser) throws LException {
        LCompoundDao dao = new LCompoundDao();
        LData LPONo = new LData();
        LData LPOSeq = new LData();
        LData result = new LData();
        int cnt = 0;
		String	getErrorCode = "0" ;
		String	getMessage	 = "OK"; 	
		StringUtil str = new StringUtil();
        try{			
			LData cudlMsData = inputMaster.getLData(0);
			cudlMsData.setString("companyCd", loginUser.getString("companyCd"));
			cudlMsData.setString("userId",    loginUser.getString("userId"));				

			dao.startTransaction(); 			
			LPONo = dao.executeQueryForSingle(strSqlPath+"/getPONo", cudlMsData);
			cudlMsData.set("poNo",    LPONo.get("poNo"));				
			if( "DEVON_CREATE_FILTER_VALUE".equals(cudlMsData.getString( "DEVON_CUD_FILTER_KEY")) ) { 
	            dao.add (strSqlPath+"/insertMSPurchOrderGroup", cudlMsData);          	
			} else if( "DEVON_UPDATE_FILTER_VALUE".equals(cudlMsData.getString( "DEVON_CUD_FILTER_KEY")) ) {
	            dao.add (strSqlPath+"/updateMSPurchOrderGroup", cudlMsData);       	   
			} else if( "DEVON_DELETE_FILTER_VALUE".equals(cudlMsData.getString( "DEVON_CUD_FILTER_KEY")) ) {
 
			}
			for(int j=0;j<inputDetail.getDataCount();j++) {
				LData cudlData = inputDetail.getLData(j);
				cudlData.setString("companyCd", loginUser.getString("companyCd"));
				cudlData.setString("userId",    loginUser.getString("userId"));
				if( "DEVON_CREATE_FILTER_VALUE".equals(cudlData.getString( "DEVON_CUD_FILTER_KEY")) ) {
					String strSeq = str.lPad(Integer.toString(j+1)+"0",4,"0");
					cudlData.set("poSeq", strSeq);		
					cudlData.set("poNo",    LPONo.get("poNo"));
		            dao.add (strSqlPath+"/mergeDTPurchOrderGroup", cudlData);   
	     
				} else if( "DEVON_UPDATE_FILTER_VALUE".equals(cudlData.getString( "DEVON_CUD_FILTER_KEY")) ) {	
		            dao.add (strSqlPath+"/mergeDTPurchOrderGroup", cudlData);    	   		            
				} else if( "DEVON_DELETE_FILTER_VALUE".equals(cudlData.getString( "DEVON_CUD_FILTER_KEY")) ) {
 
				}
				dao.add (strSqlPath+"/updatePRStatus", cudlData);
			} 		
			cnt = dao.executeUpdate(); 				
			if(cnt < 1){
				getMessage = "Failed";					
			}					
			dao.commit();
				
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "cudPurchOrderGroup()" + "=>" + se.getMessage());
			dao.rollback();
			throw new LSysException(se.getMessage());
		}
		
		result.put("getErrorCode"	,getErrorCode);
		result.put("getMessage"	,getMessage);
		
		return result;
    }      
 
    
    public LMultiData getPONo(LData inputData,LCompoundDao Dao) throws LException{

    	LMultiData resultData = null;

        try{    
        	LLog.info.println("aaaa");  
            resultData = Dao.executeQuery(strSqlPath+"/getPONo", inputData);
            LLog.info.println("-----------------"+resultData);

        }catch(LException e){
        }

        return resultData;
    }
    
    public LMultiData getPOSeq(LData inputData, LCompoundDao Dao) throws LException{

    	LMultiData resultData = null;

        try{    
        	LLog.info.println("bbbb==>"+inputData); 
            resultData = Dao.executeQuery(strSqlPath+"/getPOSeq", inputData);
            LLog.info.println("bbbb------------"+resultData);

        }catch(LException e){
        }

        return resultData;
    }
}