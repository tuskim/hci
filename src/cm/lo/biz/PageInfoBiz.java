/* ------------------------------------------------------------------------
 * @source  : PageInfoBiz.java
 * @desc    : 공통으로 처리되는 비지니스 로직
 * ------------------------------------------------------------------------
 * PROJ : 투자사 시스템 표준안 개발
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -------------------------------------
 * 1.0  2010.08.03   mskim              Initial
 * ------------------------------------------------------------------------ */

package cm.lo.biz;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import comm.util.LXssCollectionUtility;

import devon.core.exception.LException;
import devon.core.exception.LSysException;
import devon.core.log.LLog;
import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devonframework.persistent.autodao.LCommonDao;
import devonframework.persistent.autodao.LCompoundDao;

/**
 * <PRE>
 * 공통으로  업무 처리를 위한  Biz 클래스.
 *
 * Database Tables : 
 * </PRE>
 * @author    CYR
 */

public class PageInfoBiz {
	
	/**
     * 화면에 필요한 필드명을 해당언어별로 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
/*
	public LData retrievePageColumnInfo(HttpServletRequest req, String progCd) throws LException{
		
		LMultiData resultData = new LMultiData();
		LData columnData = new LData();
		
				
		LCommonDao dao = new LCommonDao();
		try{			
			resultData  =  dao.executeQuery("comm/comm/getColumns", inputData);
			
			int row_count = resultData.getDataCount();
		   
			if(row_count > 0){
				//MultiData를 LData로 만듬
				for (int idx = 0 ; idx < row_count ; idx ++) {

					columnData.setString(resultData.getString("colCd",idx), resultData.getString("colNm",idx));
				}
				
			}

		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "getColumns------()" + "=>" + se.getMessage());
			throw new LSysException("getColumns", se);
		}
		return columnData;
    }
*/
	
    /**
     * Page Columns Name 정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LData retrievePageColumnInfo(LData inputData) throws LException {    	
    	
    	LLog.debug.write("retrievePageColumnInfo inputData==>\n"+inputData.toString());
    	LMultiData resultData = new LMultiData();
		LData      columnData = new LData();
    	
    	LCommonDao dao = new LCommonDao();
		try{			

			resultData =  dao.executeQuery("cm/lo/pageInfoSql/retrievePageColumnsInfo", inputData);

			int row_count = resultData.getDataCount();
		   
			if(row_count > 0){
				//MultiData를 LData로 만듬
				for (int idx = 0 ; idx < row_count ; idx ++) {
					columnData.setString(resultData.getString("colCd",idx), resultData.getString("colNm",idx));
				}
			}
		
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrievePageColumnInfo------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		}
		return columnData;
    }
    
    /**
     * Page 조회 회수 정보를 저장하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public void cudPageCount(LData inputData) throws LException {    	
    	
    	LLog.debug.write("cudPageCount inputData==>\n"+inputData.toString());
    	
    	LCommonDao dao = new LCommonDao();
		try{			

			dao.executeUpdate("cm/lo/pageInfoSql/cudProgramAccessHist", inputData);

		
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "cudPageCount------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		}
    }
    
}