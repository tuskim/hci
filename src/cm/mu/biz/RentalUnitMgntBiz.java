/* ------------------------------------------------------------------------
 * @source  : RentalUnitMgntBiz.java
 * @desc    : Rantal List 조회 수정 
 * ------------------------------------------------------------------------
 * PROJ : 투자사 시스템 표준안 개발
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2010.09.07  임민수                 Initial
 * ------------------------------------------------------------------------ */

package cm.mu.biz;



import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LBizException;
import devon.core.exception.LException;
import devon.core.exception.LSysException;
import devon.core.log.LLog;
import devonframework.persistent.autodao.LCommonDao;
import devonframework.persistent.autodao.LCompoundDao;

public class RentalUnitMgntBiz {

	/**
     * Rental List 목록 조회
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveRentalUnitMgntList(LData inputData) throws LException {
        LMultiData list = null;

        try {        
 
            LCommonDao dao = new LCommonDao("/cm/mu/rentalUnitMgntSql/retrieveRentalUnitMgntList", inputData);
            list = dao.executeQuery();
            
        } catch (LException le) {
            LLog.err.write(this.getClass().getName() + "." + "RetrievecodeCbList()" + "=>" + le.getMessage());
            throw new LBizException("cm.cm.com.retrieve");
        }
        return list;

    }


    /**
     * Rental List CUD 
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    
    public LData cudRentalList(LMultiData mDataList, LData inputData) throws LException {
        LCompoundDao dao = new LCompoundDao();
        LData result = new LData();
        int cnt = 0;
        
		LLog.debug.println("cudRentalList mDataList--------------- =>\n " + mDataList.toString());
		
		String	getErrorCode = "0" ;
		String	getMessage	 = "Failed"; 	

        try{			

	        // Master CUD
			for(int i=0;i<mDataList.getDataCount();i++) {
				
				LData cudlData = mDataList.getLData(i);
				if(!cudlData.getString("chk").equals("T"))
					continue;
				
				cudlData.setString("companyCd", inputData.getString("companyCd"));
				cudlData.setString("userId",    inputData.getString("userId"));
				
				if( "DEVON_CREATE_FILTER_VALUE".equals(cudlData.getString( "DEVON_CUD_FILTER_KEY")) ) {
					LLog.info.write("\n SQL -> /cm/mu/rentalUnitMgntSql/rentalUnitMgntSql -------------> \n");
		            dao.add ("/cm/mu/rentalUnitMgntSql/insertRentalUnitMgnt", cudlData);            
					
				} else if( "DEVON_UPDATE_FILTER_VALUE".equals(cudlData.getString( "DEVON_CUD_FILTER_KEY")) ) {
					LLog.info.write("\n SQL ->  /cm/mu/rentalUnitMgntSql/rentalUnitMgntSql -------------> \n");
		            dao.add ("/cm/mu/rentalUnitMgntSql/updateRentalUnitMgnt", cudlData);    
					
				} 
			}
			
            cnt = dao.executeUpdate(); 
            
			if(cnt > 0){
				getMessage = "OK";					
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
}