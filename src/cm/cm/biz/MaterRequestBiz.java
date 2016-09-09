/* ------------------------------------------------------------------------
 * @source  : MaterRequestBiz.java
 * @desc    : 신규 품목 마스터 등록 및 기 등록 품목에 대한 수정 요청 
 * ------------------------------------------------------------------------
 * PROJ : 미얀마 생산 시스템 구축
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2016.09.01                   Initial
 * ------------------------------------------------------------------------ */

package cm.cm.biz;

import javax.servlet.http.HttpServletRequest;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LBizException;
import devon.core.exception.LException;
import devon.core.exception.LSysException;
import devon.core.log.LLog;
import devonframework.persistent.autodao.LCommonDao;
import devonframework.persistent.autodao.LCompoundDao;

public class MaterRequestBiz {
 
    /**
     * Material Request List
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData RetrieveMaterialRequestList(LData inputData) throws LException {
        LMultiData list = new LMultiData();

        try { 
            LCommonDao dao = new LCommonDao("/cm/cm/materialRequestSql/retrieveMaterialRequestList", inputData);
 
            list = dao.executeQuery();
            
        } catch (LException le) {
            LLog.err.write(this.getClass().getName() + "." + "retrieveMaterialRequestList()" + "=>" + le.getMessage());
            throw new LBizException("cm.cm.com.retrieve");
        }
        return list;

    }	  
    

	/**
     * Clinker Production Add Row 데이터 조회
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveMaterialRequestAddRow(LData inputData) throws LException {
        LMultiData list = null;

        try {
        	
        	String sql = "/cm/cm/materialRequestSql/retrieveMaterialRequestAddRow";
            
            LCommonDao dao = new LCommonDao(sql, inputData);
            list = dao.executeQuery();
            
        } catch (LException le) {
            LLog.err.write(this.getClass().getName() + "." + "retrieveMaterialRequestAddRow()" + "=>" + le.getMessage());
            throw new LBizException("cm.cm.com.retrieve");
        }
        return list;

    }
    /**
     * 품목 마스터 등록/수정/삭제
     * @param inputData
     * @param dao
     * @throws LException
     */
    public LData CudMaterialRequest(LMultiData mData, LData inputData) throws LException {
    	int updateCnt = 0;
    	LCompoundDao dao = new LCompoundDao();
    	LData result = new LData();
		String	getErrorCode = "0" ;
		String	getMessage	 = "Failed"; 	
    	
		try{  
			
			for(int i=0;i<mData.getDataCount();i++) {
				
				LData cudlData = mData.getLData(i);
				
				cudlData.setString("companyCd", inputData.getString("companyCd"));
				cudlData.setString("userId",    inputData.getString("userId"));
				
				if( "DEVON_CREATE_FILTER_VALUE".equals(cudlData.getString( "DEVON_CUD_FILTER_KEY")) ) {
					LLog.info.write("\n SQL -> /cm/cm/materialRequestSql/insertMaterialRequest -------------> \n");
					dao.add ("/cm/cm/materialRequestSql/insertMaterialRequest", cudlData );    
					
				} else if( "DEVON_UPDATE_FILTER_VALUE".equals(cudlData.getString( "DEVON_CUD_FILTER_KEY")) ) {
					LLog.info.write("\n SQL ->  /cm/cm/materialRequestSql/updateMaterialRequest -------------> \n");
					dao.add ("/cm/cm/materialRequestSql/updateMaterialRequest", cudlData ); 
					
				} else if( "DEVON_DELETE_FILTER_VALUE".equals(cudlData.getString( "DEVON_CUD_FILTER_KEY")) ) {
					LLog.info.write("\n SQL ->  /cm/cm/materialRequestSql/deleteMaterialRequest -------------> \n");
					dao.add ("/cm/cm/materialRequestSql/deleteMaterialRequest", cudlData );         
            
				} 
			}
			
			updateCnt = dao.executeUpdate(); 
            
			if(updateCnt > 0){
				getMessage = "OK";					
			}
			
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "CudMaterialRequest()" + "=>" + se.getMessage());
			throw new LSysException(se.getMessage());
		}
		
		result.put("getErrorCode"	,getErrorCode);
		result.put("getMessage"	,getMessage);
		
		return result;
    }    
    	
}
