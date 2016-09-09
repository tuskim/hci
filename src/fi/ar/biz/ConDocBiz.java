/* ------------------------------------------------------------------------
 * @source  : ConDocBiz.java
 * @desc    : ConDoc biz 
 * ------------------------------------------------------------------------
 *
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2010.12.08                      Initial
 * ------------------------------------------------------------------------ */


package fi.ar.biz;


//import comm.util.Util;
//import comm.util.ConstantUtil;

import devon.core.exception.LException;
import devon.core.exception.LSysException;
import devon.core.log.LLog;
import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devonframework.persistent.autodao.LCommonDao;
//import devonframework.persistent.autodao.LCompoundDao;

/**
 * <PRE>
 * ConDoc 정보의 조회/추가/수정/삭제/ 업무를 처리하는 Biz 클래스.
 *
 * Database Tables : 
 * </PRE>
 * @author    CEH
 */
public class ConDocBiz {
    /**
     * ConDoc리스트 정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveConDocList(LData inputData) throws LException {      	
    	 
    	
    	LCommonDao dao = new LCommonDao();
		try{			 
			return dao.executeQueryForPage("fi/ar/conDocSql/retrieveConDocList", inputData);			
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveConDocList------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		}
    }
    
    
    /**
     * 공지사항 세부정보를 조회하는 메소드.(수정/신규용) 가우스
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LData retrieveConDocUpdate(LData inputData) throws LException {
    	LData result = new LData();
        LCommonDao dao = new LCommonDao();
		try{ 

			//신규등록인 경우는 -1인 경우 신규등록으로 처리  Mode를 결과값에 넣어주어 나중 cud작업에 사용함
			if("".equals(inputData.getString("docNo"))){
				inputData.setString("mode", "C");
				result = dao.executeQueryForSingle("fi/ar/conDocSql/retrieveConDocDetailNew", inputData);
			}
			else{
				inputData.setString("mode", "U");
				result = dao.executeQueryForSingle("fi/ar/conDocSql/retrieveConDocDetail",  inputData);
			}
			
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveConDocUpdate()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		}
		
		return result;

    }
    
    /**
     * 첨부파일  정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveConDocAttach(LData inputData) throws LException {      	
    	  
    	LCommonDao dao = new LCommonDao();
		try{			

			return dao.executeQuery("fi/ar/conDocSql/retrieveConDocAttach", inputData);			
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveConDocAttach------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		}
    }
    
    /**
     * 시퀀스 정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LData retrieveConDocSeq(LData inputData) throws LException {      	
    	  
    	LCommonDao dao = new LCommonDao();
		try{			
			return dao.executeQueryForSingle("fi/ar/conDocSql/retrieveConDocSeq", inputData);			
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveConDocSeq------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		}
    }
    
    /**
     * 공지사항 조회수 update
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public void updateConDocHit(LData inputData)throws LException{
    	LCommonDao dao = new LCommonDao(); 
    	try{

    		dao.executeUpdate("fi/ar/conDocSql/updateConDocHit", inputData);
    	}catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "updateConDocHit()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.save", se);
		}	
    }
    
    /**
     * 공지사항 등록/수정/삭제
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    
    public void saveConDoc(LData inputData) throws LException {    	
        LCommonDao dao = new LCommonDao();
        LData seqData = new LData();
		try{
			LLog.info.println(inputData);
			if("C".equals(inputData.getString("cudmode"))){
				seqData = dao.executeQueryForSingle("fi/ar/conDocSql/retrieveConDocSeq", inputData);
				inputData.setString("docNo", seqData.getString("nextSeq")); 
				dao.executeUpdate("fi/ar/conDocSql/insertConDoc", inputData);
			}else if("U".equals(inputData.getString("cudmode"))){
				dao.executeUpdate("fi/ar/conDocSql/updateConDoc", inputData);
			}else if("D".equals(inputData.getString("cudmode"))){
				dao.executeUpdate("fi/ar/conDocSql/deleteConDoc", inputData);
			}
			
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "saveConDoc()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.save", se);
		}	

    }
    
    /**
     * 첨부파일 시퀀스 정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LData retrieveConDocAttachSeq(LData inputData) throws LException {      	
    	 
    	LCommonDao dao = new LCommonDao();
		try{			
			return dao.executeQueryForSingle("fi/ar/conDocSql/retrieveConDocAttachSeq", inputData);			
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveConDocAttachSeq------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		}
    }
    
    /**
     * 첨부파일 등록
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public void saveConDocAttach(LData inputData) throws LException {    	
        LCommonDao dao = new LCommonDao();        
		try{			

			dao.executeUpdate("fi/ar/conDocSql/insertConDocAttach", inputData);			
			
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "saveConDocAttach()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.save", se);
		}	

    }
    
    /**
     * 첨부파일 삭제
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public void deleteConDocAttach(LData inputData) throws LException {    	
        LCommonDao dao = new LCommonDao();        
		try{			
			
			dao.executeUpdate("fi/ar/conDocSql/deleteConDocAttach", inputData);			
			
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "deleteConDocAttach()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.save", se);
		}	

    }
    /**
     * Main ConDoc 정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveMainConDoc(LData inputData) throws LException {
        LCommonDao dao = new LCommonDao();
        try{	
        	return dao.executeQuery("fi/ar/conDocSql/retrieveMainconDocList", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveMainconDoc------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		}	
    }
    
    /**
     * PopUp ConDoc 정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveConDocListPop(LData inputData) throws LException {
        LCommonDao dao = new LCommonDao();
        try{	
        	return dao.executeQuery("fi/ar/conDocSql/retrieveConDocList", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveMainconDoc------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		}	
    }    
    
    /**
     * App Con Doc List 삭제 및 수정 전 전표 확인
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveConDocChk(LData inputData) throws LException {
        LCommonDao dao = new LCommonDao();
        try{	
        	return dao.executeQuery("fi/ar/conDocSql/retrieveConDocChk", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveConDocChk------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		}	
    }    
}




