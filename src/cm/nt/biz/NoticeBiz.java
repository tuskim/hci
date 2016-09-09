/* ------------------------------------------------------------------------
 * @source  : NoticeBiz.java
 * @desc    : notice biz 
 * ------------------------------------------------------------------------
 *
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2010.07.24                      Initial
 * ------------------------------------------------------------------------ */


package cm.nt.biz;


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
 * Notice 정보의 조회/추가/수정/삭제/ 업무를 처리하는 Biz 클래스.
 *
 * Database Tables : 
 * </PRE>
 * @author    CEH
 */
public class NoticeBiz {
    /**
     * Notice리스트 정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveNoticeList(LData inputData) throws LException {      	
    	 
    	
    	LCommonDao dao = new LCommonDao();
		try{			 
			return dao.executeQueryForPage("cm/nt/noticeSql/retrieveNoticeList", inputData);			
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveNoticeList------()" + "=>" + se.getMessage());
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
    public LData retrieveNoticeUpdate(LData inputData) throws LException {
    	LData result = new LData();
        LCommonDao dao = new LCommonDao();
		try{ 

			//신규등록인 경우는 -1인 경우 신규등록으로 처리  Mode를 결과값에 넣어주어 나중 cud작업에 사용함
			if("-1".equals(inputData.getString("seq"))){
				inputData.setString("mode", "C");
				result = dao.executeQueryForSingle("cm/nt/noticeSql/retrieveNoticeDetailNew", inputData);
			}
			else{
				inputData.setString("mode", "U");
				result = dao.executeQueryForSingle("cm/nt/noticeSql/retrieveNoticeDetail",  inputData);
			}
			
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveNoticeUpdate()" + "=>" + se.getMessage());
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
    public LMultiData retrieveNoticeAttach(LData inputData) throws LException {      	
    	  
    	LCommonDao dao = new LCommonDao();
		try{			

			return dao.executeQuery("cm/nt/noticeSql/retrieveNoticeAttach", inputData);			
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveNoticeAttach------()" + "=>" + se.getMessage());
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
    public LData retrieveNoticeSeq(LData inputData) throws LException {      	
    	  
    	LCommonDao dao = new LCommonDao();
		try{			
			return dao.executeQueryForSingle("cm/nt/noticeSql/retrieveNoticeSeq", inputData);			
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveNoticeSeq------()" + "=>" + se.getMessage());
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
    public void updateNoticeHit(LData inputData)throws LException{
    	LCommonDao dao = new LCommonDao(); 
    	try{

    		dao.executeUpdate("cm/nt/noticeSql/updateNoticeHit", inputData);
    	}catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "updateNoticeHit()" + "=>" + se.getMessage());
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
    
    public void saveNotice(LData inputData) throws LException {    	
        LCommonDao dao = new LCommonDao();
        LData seqData = new LData();
		try{
	 
			if("C".equals(inputData.getString("cudmode"))){
				seqData = dao.executeQueryForSingle("cm/nt/noticeSql/retrieveNoticeSeq", inputData);
				inputData.setString("seq", seqData.getString("nextSeq"));
				inputData.setString("step", seqData.getString("nextStep")); 
				dao.executeUpdate("cm/nt/noticeSql/insertNotice", inputData);
			}else if("U".equals(inputData.getString("cudmode"))){
				dao.executeUpdate("cm/nt/noticeSql/updateNotice", inputData);
			}else if("D".equals(inputData.getString("cudmode"))){
				dao.executeUpdate("cm/nt/noticeSql/deleteNotice", inputData);
			}
			
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "saveNotice()" + "=>" + se.getMessage());
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
    public LData retrieveNoticeAttachSeq(LData inputData) throws LException {      	
    	 
    	LCommonDao dao = new LCommonDao();
		try{			
			return dao.executeQueryForSingle("cm/nt/noticeSql/retrieveNoticeAttachSeq", inputData);			
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveNoticeAttachSeq------()" + "=>" + se.getMessage());
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
    public void saveNoticeAttach(LData inputData) throws LException {    	
        LCommonDao dao = new LCommonDao();        
		try{			

			dao.executeUpdate("cm/nt/noticeSql/insertNoticeAttach", inputData);		
			
			System.out.println(inputData);
			
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "saveNoticeAttach()" + "=>" + se.getMessage());
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
    public void deleteNoticeAttach(LData inputData) throws LException {    	
        LCommonDao dao = new LCommonDao();        
		try{			
			
			dao.executeUpdate("cm/nt/noticeSql/deleteNoticeAttach", inputData);			
			
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "deleteNoticeAttach()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.save", se);
		}	

    }
    /**
     * Main Notice 정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveMainNotice(LData inputData) throws LException {
        LCommonDao dao = new LCommonDao();
        try{	
        	return dao.executeQuery("cm/nt/noticeSql/retrieveMainNoticeList", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveMainNotice------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		}	
    }
}




