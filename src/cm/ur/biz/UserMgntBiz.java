/* ------------------------------------------------------------------------
 * @source  : commBiz.java
 * @desc    : 사용자 로그인/로그아웃 등 시스템 공통 비즈니스 로직 구현
 * ------------------------------------------------------------------------
 * PROJ : 투자사 시스템 표준안 개발
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2010.05.12  김현수                 Initial
 * 1.1 2014.04.14    jwhan				CSR:C20140414_23324
 * 1.2  2014903       jwhan			     	  C20140825_97731
 * ------------------------------------------------------------------------ */

package cm.ur.biz;


import javax.servlet.http.HttpServletRequest;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LBizException;
import devon.core.exception.LException;
import devon.core.log.LLog;
import devonframework.persistent.autodao.LCommonDao;
import devonframework.persistent.autodao.LCompoundDao;


public class UserMgntBiz {

		/**
		 * 사용자 목록 조회
		 * @param inputData 검색조건 입력 값
		 * @return 사용자 목록 조회
		 * @throws LException
		 */
		public LMultiData retrieveUserList(LData inputData) throws LException {

			LMultiData resultData = null;
			
		
			
	        try {
	        	LCommonDao dao = new LCommonDao( "/cm/ur/userSql/retrieveUserList" , inputData );
	        	resultData = dao.executeQuery();
	        	
	        	
	        	
	        } catch (Exception le ) {
	        	LLog.err.write(this.getClass().getName() + "." + "retrieveUserList()" + "=>" + le.getMessage());
	            throw new LBizException("cm.ur.cmd.retrieve");
	        }

	        return resultData;
		}
		
		/**
		 * 사용자 처리를 담당
		 * @param 	lData 입력받은 사용자 정보
		 * @return
		 * @throws Exception
		 */
	    public void userIf( LMultiData  lmData, HttpServletRequest req ) throws LException {
	    	LCompoundDao 		dao 		= new LCompoundDao();

	        try {
	        	dao.startTransaction();

	        	for( int i=0; null != lmData && i < lmData.getDataCount(); i++ ) {
	        		LData	lData = lmData.getLData( i );

			        	// 등록
			    		if( "DEVON_CREATE_FILTER_VALUE".equals(lData.getString( "DEVON_CUD_FILTER_KEY")) ) {
			    			 dao.add ( "/cm/ur/userSql/CreateUser", lData );
			 	             dao.executeUpdate();
			    		}
			    		// 수정
			    		else if( "DEVON_UPDATE_FILTER_VALUE".equals(lData.getString( "DEVON_CUD_FILTER_KEY")) ) {
			    			  dao.add ( "/cm/ur/userSql/UpdateUser", lData );
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
		 * 사용자 ID가 존재하는지 체크
		 *
		 * @param 	lData 체크할 사용자 ID
		 * @return	결과정보
		 * @throws Exception
		 */
	    public LMultiData userIdCheck( LData lData ) throws LException {
	        LMultiData 	result 	= null;
	 

	        try {
	            LCommonDao dao = new LCommonDao( "/cm/ur/userSql/userIdCheck", lData );
	            result = dao.executeQuery();
	        } catch ( LException e ) {
	            e.getMessage();
	            throw e;
	        }
	        
	        return result;
	    }	
	  
	    /**
		 * 개인정보 수정 위한 정보 검색
		 * @param inputData 검색조건 입력 값
		 * @return 사용자 정보 조회
		 * @throws LException
		 */
		public LMultiData retreiveUserInfoChange(LData inputData) throws LException {

			LMultiData resultData = null;
		
	        try {
	        	LCommonDao dao = new LCommonDao( "/cm/ur/userSql/retrieveUserInfo" , inputData );
	        	resultData = dao.executeQuery(); 
	        	        	
	        } catch (Exception le ) {
	        	LLog.err.write(this.getClass().getName() + "." + "retreiveUserInfoChange()" + "=>" + le.getMessage());
	            throw new LBizException("cm.ur.cmd.retrieve");
	        }

	        return resultData;
		}

		
		/**
		 * 개인정보를 수정
		 * @param 	lData
		 * @return	결과정보
		 * @throws Exception
		 */
	    public void userInfoUpdate( LMultiData inputData) throws LException {
	        try {
	        	
	        	LData input = inputData.getLData(0);
	            LCommonDao dao=new LCommonDao("/cm/ur/userSql/userInfoUpdate", input );
	            dao.executeUpdate();
	            
	        } catch ( LException e ) {
	            e.getMessage();
	            throw e;
	        }
	    }
	    
	    /**
		 * 사용자 목록 조회
		 * @param inputData 검색조건 입력 값
		 * @return 사용자 목록 조회
		 * @throws LException
		 */
		public LMultiData retrieveEmplyoeeList(LData inputData) throws LException {

			LMultiData resultData = null;

	        try {
	        	LCommonDao dao = new LCommonDao( "/cm/ur/userSql/retrieveEmplyoeeList" , inputData );
	        	resultData = dao.executeQuery();
	        	
	        } catch (Exception le ) {
	        	LLog.err.write(this.getClass().getName() + "." + "retrieveEmplyoeeList()" + "=>" + le.getMessage());
	            throw new LBizException("cm.ur.cmd.retrieve");
	        }

	        return resultData;
		}

		
		/**
		 * 패스워드 변경일 업데이트
		 * 
		 * */
		public void updatePasswordChangedDate( LMultiData inputData ) throws LException{
			
			LData data = inputData.getLData(0);
			LCommonDao dao;
			try {
				dao = new LCommonDao("/cm/ur/userSql/updatePasswordChangedDate" , data );
				dao.executeUpdate();
			} catch (LException e) {
				// TODO Auto-generated catch block
				e.getMessage();
			}

			
		}		

		/**
		 * userMgnt.jsp     unblocking
		 * 
		 * */
		public void userUnblocking(LData inputData) throws LException {
		
			LCommonDao dao;
			
			try{
				dao = new LCommonDao("/cm/ur/userSql/userUnblocking" , inputData );
				dao.executeUpdate();
				
			}catch(LException e){
				e.getMessage();
			}
		
		}
		
		
		/**
		 * userMgnt.jsp     password Reset
		 * 
		 * */
		public void userPasswordReset(LData  inputData) throws LException{
			
			LCommonDao dao;
			
			try{
				dao = new LCommonDao("/cm/ur/userSql/userPasswordReset" , inputData );
				dao.executeUpdate();
				
			}catch(LException e){
				e.getMessage();
			}
			
		}

}

