/* ------------------------------------------------------------------------
 * @source  : commBiz.java
 * @desc    : 사용자 로그인/로그아웃 등 시스템 공통 비즈니스 로직 구현
 * ------------------------------------------------------------------------
 * PROJ : 투자사 시스템 표준안 개발
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2010.05.12  김현수                 Initial
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

public class CodeMgntBiz {
 
    /**
     * 공통코드 dt조회
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData RetrieveCodeMgntDtList(LData inputData) throws LException {
        LMultiData list = new LMultiData();

        try { 
            LCommonDao dao = new LCommonDao("/cm/cm/commCodeMgntSql/RetrieveCodeMgntDtList", inputData);
 
            list = dao.executeQuery();
            
        } catch (LException le) {
            LLog.err.write(this.getClass().getName() + "." + "RetrieveDtCbList()" + "=>" + le.getMessage());
            throw new LBizException("cm.cm.com.retrieve");
        }
        return list;

    }	    
    /**
     * 공통코드 조회
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData RetrievecommCodeMgntList(LData inputData) throws LException {
        LMultiData list = null;

        try {
 
            LCommonDao dao = new LCommonDao("/cm/cm/commCodeMgntSql/retrievecommCodeMgntList", inputData);
 
            list = dao.executeQuery();
            
        } catch (LException le) {
            LLog.err.write(this.getClass().getName() + "." + "RetrievecommCodeMgntList()" + "=>" + le.getMessage());
            throw new LBizException("cm.cm.com.retrieve");
        }
        return list;

    }
	    
	    /**
	     * 공통코드 등록/수정/삭제
	     *
	     * @param inputData Command로 부턴 전달받은 input LDataProtocol
	     * 
	     * @return LMultiData 조회된 리스트 결과.
	     * @exception LException 메소드 수행시 발생한 모든 에러.
	     */
	    
    public void insertMsCommCodeMgnt2(LMultiData inputData) throws LException {
        LCompoundDao dao = new LCompoundDao(); 
         
		String	getMessage			= "";  
        
		try{		
			
			//메뉴권한 삭제
			dao.setInsertQuery("/cm/cm/commCodeMgntSql/insertMsCommCodeMgnt"); 
			dao.addWithJobType(inputData);
			dao.executeUpdate();
								
			
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "insertMsCommCodeMgnt()" + "=>" + se.getMessage());
 
			getMessage = se.getMessage();
			throw new LSysException(getMessage,se);
        }
    }
    
    public void CudCodeMgnt(LMultiData inputm,LMultiData inputd ,LData inputData) throws LException {
		LCompoundDao dao = new LCompoundDao();
		dao.startTransaction();
    	try{ 
    		for(int i = 0 ; i < inputm.getDataCount() ; i++){
    			LData Lrow = new LData();
    			Lrow = inputm.getLData(i);
    			Lrow.set("userId", inputData.get("userId"));
    			Lrow.set("companyCd", inputData.get("companyCd"));
    			Lrow.set("lang", inputData.get("lang"));
    			CudMsCommCodeMgnt(Lrow,dao);
    		}    		
    		for(int j = 0 ; j< inputd.getDataCount() ; j++)	{
    			LData Lrow1 = new LData();
    			Lrow1= inputd.getLData(j); 
    			Lrow1.set("userId", inputData.get("userId"));
    			Lrow1.set("companyCd", inputData.get("companyCd"));
    			Lrow1.set("lang", inputData.get("lang"));    			
    			CudDtCommCodeMgnt(Lrow1,dao);
    		}	
    		
    		dao.commit(); 
        } catch ( LException e ) {
            e.getMessage();
            dao.rollback();
            throw e;
        }
    }
    
    public void CudMsCommCodeMgnt(LData inputData, LCompoundDao dao) throws LException {
    	int updateCnt = 0;
    	String s_txMode = inputData.getString("DEVON_CUD_FILTER_KEY");
		try{  
			if(s_txMode.equals("DEVON_DELETE_FILTER_VALUE")){ 
				
			}else if(s_txMode.equals("DEVON_UPDATE_FILTER_VALUE")){
	    		dao.add ("/cm/cm/commCodeMgntSql/updateMsCommCodeMgnt", inputData );
	    		updateCnt = dao.executeUpdate();				
			 
			}else if(s_txMode.equals("DEVON_CREATE_FILTER_VALUE")){
	    		dao.add ("/cm/cm/commCodeMgntSql/insertMsCommCodeMgnt", inputData );
	    		updateCnt = dao.executeUpdate();				 
			}
			
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "insertMsCommCodeMgnt()" + "=>" + se.getMessage());
			throw new LSysException(se.getMessage());
		}
    }    
    
    public void CudDtCommCodeMgnt(LData inputData, LCompoundDao dao) throws LException {
    	int updateCnt = 0;
    	String s_txMode = inputData.getString("DEVON_CUD_FILTER_KEY");
		try{  
			if(s_txMode.equals("DEVON_DELETE_FILTER_VALUE")){ 				
				dao.add ("/cm/cm/commCodeMgntSql/deleteDtCommCodeMgnt", inputData); 
				updateCnt = dao.executeUpdate();
			}else if(s_txMode.equals("DEVON_UPDATE_FILTER_VALUE")){
				dao.add ("/cm/cm/commCodeMgntSql/updateDtCommCodeMgnt", inputData); 
				updateCnt = dao.executeUpdate();
			}else if(s_txMode.equals("DEVON_CREATE_FILTER_VALUE")){
				dao.add ("/cm/cm/commCodeMgntSql/insertDtCommCodeMgnt", inputData); 
				updateCnt = dao.executeUpdate();
			} 
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "insertDtCommCodeMgnt()" + "=>" + se.getMessage());
			throw new LSysException(se.getMessage());
		}
    }      
   
    public LMultiData RetrieveDupCnt(LData inputData) throws LException {
        LMultiData list = new LMultiData();

        try {  
            LCommonDao dao = new LCommonDao("/cm/cm/commCodeMgntSql/RetrieveDupCnt", inputData);
            list = dao.executeQuery();
            
        } catch (LException le) {
            LLog.err.write(this.getClass().getName() + "." + "RetrieveDtCbList()" + "=>" + le.getMessage());
            throw new LBizException("cm.cm.com.RetrieveDupCnt");
        }
        return list;

    }

	
    public LMultiData retrieveCommCodeCombo(LData inputData) throws LException {    	
    	
    	LLog.debug.write("retrieveCommCodeCombo inputData==>\n"+inputData.toString());
    	LMultiData resultData = new LMultiData();
    	
    	LCommonDao dao = new LCommonDao();
		try{			
			resultData =  dao.executeQuery("cm/cm/commCodeMgntSql/retrieveCommCodeCombo", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveCommCodeCombo------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		}
		return resultData;
    }
    
    /**
	 * 농장계정 목록 
	 * @param inputData 검색조건 입력 값
	 * @return 사용자 목록 조회
	 * @throws LException
	 */
	public LMultiData retrieveAccountManage(LData inputData) throws LException {

		LMultiData resultData = null;

        try {
        	LCommonDao dao = new LCommonDao( "/cm/cm/commCodeMgntSql/retrieveAccountManage" , inputData );
        	resultData = dao.executeQuery();
        	
        	
        } catch (Exception le ) {
        	LLog.err.write(this.getClass().getName() + "." + "retrieveUserList()" + "=>" + le.getMessage());
            throw new LBizException("cm.ur.cmd.retrieve");
        }

        return resultData;
	}
 
    
    /**
	 * 농장계정 처리
	 * @param 	lData 입력받은 농장계정 정보
	 * @return
	 * @throws Exception
	 */
    public void accountManageCud( LMultiData  lmData, HttpServletRequest req ) throws LException {
    	LCompoundDao dao = new LCompoundDao();

        try {
        	dao.startTransaction();

        	for( int i=0; null != lmData && i < lmData.getDataCount(); i++ ) {
        		LData	lData = lmData.getLData( i );

		        // 등록
		    	if( "DEVON_CREATE_FILTER_VALUE".equals(lData.getString( "DEVON_CUD_FILTER_KEY")) ) {
		    		dao.add ( "/cm/cm/commCodeMgntSql/createAccount", lData );
		    	    dao.executeUpdate();

		    		}
		    	// 수정
		    	else if( "DEVON_UPDATE_FILTER_VALUE".equals(lData.getString( "DEVON_CUD_FILTER_KEY")) ) {
		    		dao.add ( "/cm/cm/commCodeMgntSql/updateAccount", lData );
		    		dao.executeUpdate();

		    	}
        	}
	        dao.commit();
	        
        } catch ( LException e ) {
            e.getMessage();
            dao.rollback();
            throw e;
        }
    }
    
    
    /**
	 * Block별 hr정보 목록
	 * @param inputData 검색조건 입력 값
	 * @return Block별 hr정보 조회
	 * @throws LException
	 */
	public LMultiData retrieveBlockHrInfoMgnt(LData inputData) throws LException {

		
		LMultiData resultData = new LMultiData();
    	LCommonDao dao = new LCommonDao();
		try{			
			resultData =  dao.executeQuery("/cm/cm/commCodeMgntSql/retrieveBlockHrInfoMgnt", inputData);
        	        	
        } catch (Exception le ) {
        	LLog.err.write(this.getClass().getName() + "." + "retrieveBlockHrInfoMgnt()" + "=>" + le.getMessage());
            throw new LBizException("cm.ur.cmd.retrieve");
        }

        return resultData;
	}
 
    
    /**
	 * Block별 hr정보 수정
	 * @param 	lData 입력받은 Block별 hr정보
	 * @return
	 * @throws Exception
	 */
    public void cudBlockHrInfoMgnt( LMultiData  lmData, HttpServletRequest req ) throws LException {
    	LCompoundDao dao = new LCompoundDao();

        try {
        	for( int i=0; null != lmData && i < lmData.getDataCount(); i++ ) {
        		LData	lData = lmData.getLData( i );

		    		dao.add ( "/cm/cm/commCodeMgntSql/cudBlockHrInfoMgnt", lData );
		    		dao.executeUpdate(); 	
		    	
        	}
        } catch ( LException e ) {
            e.getMessage();
            throw e;
        }
    }
    
    /**
	 * 자재관리 목록 조회 
	 * @param inputData 검색조건 입력 값
	 * @return Block별 hr정보 조회
	 * @throws LException
	 */
	public LMultiData retrieveMaterialMasterList (LData inputData) throws LException {

		
		LMultiData resultData = new LMultiData();
    	LCommonDao dao = new LCommonDao();
		try{			
			resultData =  dao.executeQuery("/cm/cm/commCodeMgntSql/retrieveMaterialMasterList", inputData);
        	        	
        } catch (Exception le ) {
        	LLog.err.write(this.getClass().getName() + "." + "retrieveMaterialMasterList()" + "=>" + le.getMessage());
            throw new LBizException("cm.ur.cmd.retrieve");
        }

        return resultData;
	}
	
    /**
	 * 공통 MATER CODE 목록 조회  
	 * @throws LException
	 */
	public LMultiData RetrieveCommComboMaterList (LData inputData) throws LException {

		
		LMultiData resultData = new LMultiData();
    	LCommonDao dao = new LCommonDao();
		try{			
			resultData =  dao.executeQuery("/cm/cm/commCodeMgntSql/retrieveCommComboMaterList", inputData);
        	        	
        } catch (Exception le ) {
        	LLog.err.write(this.getClass().getName() + "." + "CommComboMaterList()" + "=>" + le.getMessage());
            throw new LBizException("cm.ur.cmd.retrieve");
        }

        return resultData;
	}	
	
    /**
	 * 공통 VENDER CODE 목록 조회  
	 * @throws LException
	 */
	public LMultiData RetrieveCommComboVendorList (LData inputData) throws LException {

		
		LMultiData resultData = new LMultiData();
    	LCommonDao dao = new LCommonDao();
		try{			
			resultData =  dao.executeQuery("/cm/cm/commCodeMgntSql/retrieveCommComboVendorList", inputData);
        	        	
        } catch (Exception le ) {
        	LLog.err.write(this.getClass().getName() + "." + "CommComboVENDERList()" + "=>" + le.getMessage());
            throw new LBizException("cm.ur.cmd.retrieve");
        }

        return resultData;
	}		
    /**
	 *  자재관리 목록 수정
	 * @param 	lData 입력받은 Block별 ha정보
	 * @return
	 * @throws Exception
	 */
    public void cudMaterialMasterList( LMultiData  lmData, HttpServletRequest req ) throws LException {
    	LCompoundDao dao = new LCompoundDao();

        try {
        	for( int i=0; null != lmData && i < lmData.getDataCount(); i++ ) {
        		LData	lData = lmData.getLData( i );

		    		dao.add ( "/cm/cm/commCodeMgntSql/cudMaterialMasterListt", lData );
		    		dao.executeUpdate(); 	
		    	
        	}
        } catch ( LException e ) {
            e.getMessage();
            throw e;
        }
    }
    
    
    
    /**
	 * SAP 계정조회 
	 * @param inputData 검색조건 입력 값
	 * @return SAP 계정조회
	 * @throws LException
	 */
	public LMultiData retrieveSapAcctCd(LData inputData) throws LException {

		LMultiData resultData = null;

        try {
        	LCommonDao dao = new LCommonDao( "/cm/cm/commCodeMgntSql/retrieveSapAcctCd" , inputData );
        	resultData = dao.executeQuery();
        	
        } catch (Exception le ) {
        	LLog.err.write(this.getClass().getName() + "." + "retrieveEmplyoeeList()" + "=>" + le.getMessage());
            throw new LBizException("cm.ur.cmd.retrieve");
        }

        return resultData;
	}
	
	
    /**
	 * Cost Center 조회
	 * @param 	lData 입력받은 Block별 ha정보
	 * @return
	 * @throws Exception
	 */    
	public LMultiData RetrieveCommComboCostCenterList(LData inputData) throws LBizException {
		LMultiData resultData = new LMultiData();
    	LCommonDao dao = new LCommonDao();
		try{			
			resultData =  dao.executeQuery("/cm/cm/commCodeMgntSql/retrieveCommComboCostCenterList", inputData);
        	        	
        } catch (Exception le ) {
        	LLog.err.write(this.getClass().getName() + "." + "RetrieveCommComboCostCenterList()" + "=>" + le.getMessage());
            throw new LBizException("cm.ur.cmd.retrieve");
        }

        return resultData;
	}       

    /**
	 * Cost Center 조회
	 * @param 	lData 입력받은 Block별 ha정보
	 * @return
	 * @throws Exception
	 */    
	public LMultiData RetrieveCheckAccountList(LData inputData) throws LBizException {
		LMultiData resultData = new LMultiData();
    	LCommonDao dao = new LCommonDao();
		try{			
			resultData =  dao.executeQuery("/cm/cm/commCodeMgntSql/retrieveCheckAccountCode", inputData);
        	        	
        } catch (Exception le ) {
        	LLog.err.write(this.getClass().getName() + "." + "RetrieveCheckAccountList()" + "=>" + le.getMessage());
            throw new LBizException("cm.ur.cmd.retrieve");
        }

        return resultData;
	}    	
	
    /**
	 * Cost Center 조회
	 * @param 	lData 입력받은 Block별 ha정보
	 * @return
	 * @throws Exception
	 */    
	public LMultiData retrieveCheckCostPriceAccountCode(LData inputData) throws LBizException {
		LMultiData resultData = new LMultiData();
    	LCommonDao dao = new LCommonDao();
		try{			
			resultData =  dao.executeQuery("/cm/cm/commCodeMgntSql/retrieveCheckCostPriceAccountCode", inputData);
        	        	
        } catch (Exception le ) {
        	LLog.err.write(this.getClass().getName() + "." + "RetrieveCheckAccountList()" + "=>" + le.getMessage());
            throw new LBizException("cm.ur.cmd.retrieve");
        }

        return resultData;
	}   
	
    /**
	 * 부가세계정 조회
	 * @param 	lData 입력받은 Block별 ha정보
	 * @return
	 * @throws Exception
	 */    
	public LMultiData retrieveSapVatAcctCd(LData inputData) throws LBizException {
		LMultiData resultData = new LMultiData();
    	LCommonDao dao = new LCommonDao();
		try{			
			resultData =  dao.executeQuery("/cm/cm/commCodeMgntSql/retrieveSapVatAcctCd", inputData);
        	        	
        } catch (Exception le ) {
        	LLog.err.write(this.getClass().getName() + "." + "retrieveSapVatAcctCd()" + "=>" + le.getMessage());
            throw new LBizException("cm.ur.cmd.retrieve");
        }

        return resultData;
	}   
	
	public LMultiData retrieveCostPriceCodeCombo(LData inputData) throws LException {    	
    	
    	LLog.debug.write("retrieveCostPriceCodeCombo inputData==>\n"+inputData.toString());
    	LMultiData resultData = new LMultiData();
    	
    	LCommonDao dao = new LCommonDao();
		try{			
			resultData =  dao.executeQuery("cm/cm/commCodeMgntSql/retrieveCostPriceCodeCombo", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveCommCodeCombo------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		}
		return resultData;
    }
    
	
	/**
	 * 
	 * 20140708 추가
	 * 
	 * */
	public LMultiData retrieveCommDefaultDeptCd(LData inputData) throws LSysException {
    	LLog.debug.write("retrieveCommDefaultDeptCd inputData==>\n"+inputData.toString());
    	LMultiData resultData = new LMultiData();
    	
    	LCommonDao dao = new LCommonDao();
		try{			
			resultData =  dao.executeQuery("cm/cm/commCodeMgntSql/retrieveCommDefaultDeptCd", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveCommDefaultDeptCd------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		}
		return resultData;
	}	 
	
	
}
