/* ------------------------------------------------------------------------
 * @source  : IssueBiz.java
 * @desc    : 출고 조회 및 취소 요청
 * ------------------------------------------------------------------------
 * PROJ : 투자사 시스템 표준안 개발
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2010.08.25  임민수                 Initial
 * ------------------------------------------------------------------------ */

package po.is.biz;

import xi.GMM03;
import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LBizException;
import devon.core.exception.LException;
import devon.core.exception.LSysException;
import devon.core.log.LLog;
import devonframework.persistent.autodao.LCommonDao;
import devonframework.persistent.autodao.LCompoundDao;

public class IssueBiz {
	
	/**
     * 출고요청 목록 조회
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveIssueRequestList(LData inputData) throws LException {
        LMultiData list = null;

        try {
 
            LCommonDao dao = new LCommonDao("/po/is/stockIssueSql/retrieveIssueRequestList", inputData);
            list = dao.executeQuery();
            
        } catch (LException le) {
            LLog.err.write(this.getClass().getName() + "." + "RetrievecodeCbList()" + "=>" + le.getMessage());
            throw new LBizException("cm.cm.com.retrieve");
        }
        return list;

    }

    /**
     * 출고 내역 SAP Cancel
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @throws LException 
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    
	public LData stockIssueSapCancel(LMultiData mData, LData inputData) throws LException {

	        LCompoundDao dao = new LCompoundDao();
	        LData result = new LData();
	        int cnt = 0;
	        
			LLog.debug.println("stockIssueSapCancel mData--------------- =>\n " + mData.toString());
			
			String	getErrorCode = "0" ;
			String	getMessage	 = "Failed"; 	

	        try{			
	        	dao.startTransaction();

		        
				for(int i=0;i<mData.getDataCount();i++) {
					
					LData cudlData = mData.getLData(i);
					if(!cudlData.getString("chk").equals("T"))		// 체크되지 않으면 처리하지 않음
						continue;

		        	LMultiData resultList = dao.executeQuery("/po/is/stockIssueSql/retrieveMater", cudlData);
		        	if(resultList.getDataCount() ==0){   // 해당 Material이  Use No 인지 체크함 
		        		getMessage = cudlData.getString("materCd") + " Material is no use status";
		        		throw new LSysException(getMessage);
		        	}
		        	
					cudlData.setString("companyCd", inputData.getString("companyCd"));
					cudlData.setString("userId",    inputData.getString("userId"));
					
					LLog.info.write("\n SQL -> /po/is/stockIssueSql/stockIssueSapCancel -------------> \n");
		            dao.add ("/po/is/stockIssueSql/stockIssueSapCancel", cudlData);            
		            cnt = dao.executeUpdate();       	   
					if(cnt > 0){
						getMessage = "OK";					
					}				            

				}
		        GMM03 gmm03 = new GMM03();
		        inputData.setString("status", "04");					// 04 : 취소요청 
		        gmm03.GMM03_out(mData, inputData);   		// XI로 출고 내역 전송(비동기)
				
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
}