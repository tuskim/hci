/*
 *------------------------------------------------------------------------------
 * ProgMgntBiz.java,v 1.0 2010/07/23 16:43:35 
 * 
 * PROJ : PT-PAM
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2010/07/23   mskim   최초 프로그램 작성
 *----------------------------------------------------------------------------
 */

package cm.au.biz;

import devon.core.exception.LException;
import devon.core.exception.LSysException;
import devon.core.log.LLog;
import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devonframework.persistent.autodao.LCommonDao;
import devonframework.persistent.autodao.LCompoundDao;

/**
 * <PRE>
 * Prog Mgnt 정보의 조회/추가/수정/삭제/ 업무를 처리하는 Biz 클래스.
 *
 * Database Tables : 
 * </PRE>
 * @author    CEH
 */
public class ProgMgntBiz {
    /**
     * ProgMgnt 정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveProgMgntList(LData inputData) throws LException {    	
    	
    	LLog.debug.write("retrieveProgMgntList inputData==>\n"+inputData.toString());
    	LMultiData resultData = new LMultiData();
    	LMultiData resultData2 = new LMultiData();
    	LLog.info.write("");
    	String authGroup = "";
    	String tempStr = "";
    	
    	LCommonDao dao = new LCommonDao();
		try{			
			resultData  =  dao.executeQuery("cm/au/progMgntSql/retrieveProgMgntList", inputData);
			resultData2 =  dao.executeQuery("cm/au/progMgntSql/retrieveProgAuthorityList2", inputData);
			int row_count = resultData.getDataCount();
			int row_count2 = resultData2.getDataCount();
			
			if(row_count > 0){
				
				for (int idx = 0 ; idx < row_count ; idx ++) {
					authGroup = "";
					tempStr = "";

                    for (int i = 1 ; i < Long.parseLong(resultData.getString("depth",idx)) ; i ++) {
                        tempStr = tempStr + "     ";
                    }
                    
					resultData.modifyString("progNmKr", idx, tempStr + resultData.getString("progNmKr",idx));
					resultData.modifyString("progNmEn", idx, tempStr + resultData.getString("progNmEn",idx));
					resultData.modifyString("progNmLo", idx, tempStr + resultData.getString("progNmLo",idx));

					for (int j=0; j<row_count2; j++) {
	                    if (resultData.getString("progCd",idx).equals(resultData2.getString("progCd",j))) {
	                        authGroup = authGroup + resultData2.getString("authCd",j) + "|";
	                    }
	                }
					
					if (authGroup != null && authGroup.length() > 0) {
                        authGroup = authGroup.substring(0, authGroup.length() - 1);
                    }
								
			    	//LLog.debug.write("retrieveProgMgntList authGroup:" + authGroup);
					resultData.modifyString("authCd", idx, authGroup);
				}
		
			}

		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveProgMgntList------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		}
		return resultData;
    }
    
    /**
     * Prog Authority 정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveProgAuthorityList(LData inputData) throws LException {    	
    	
    	LLog.debug.write("retrieveProgAuthorityList inputData==>\n"+inputData.toString());
    	
    	LCommonDao dao = new LCommonDao();
		try{			
			return dao.executeQuery("cm/au/progMgntSql/retrieveProgAuthorityList", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveProgAuthorityList------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		}
    }
    
    /**
     *Prog Mgnt 저장하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     ** @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LData cudProgMgnt(LMultiData inputData, LData loginUser) throws LException {
        LCompoundDao dao = new LCompoundDao();
        LData result = new LData();
        int cnt = 0;
        
		LLog.debug.println("ProgMgntBiz.cudProgMgnt inputData--------------- =>\n " + inputData.toString());
		
		String	getErrorCode = "0" ;
		String	getMessage	 = "";
        String  getStatus    = "";		

        try{			

			dao.startTransaction();

			LData   resultInfo 	= new LData();		// Seq 생성
			//LData   dataParam 	= new LData();
			String  strCheck	= "";
	        String msg 		    = "";
	        
			for(int i=0;i<inputData.getDataCount();i++) {
				
				LData cudlData = inputData.getLData(i);

				cudlData.setString("companyCd", loginUser.getString("companyCd"));
				cudlData.setString("userId",    loginUser.getString("userId"));
				
				if( "DEVON_CREATE_FILTER_VALUE".equals(cudlData.getString( "DEVON_CUD_FILTER_KEY")) ) {

    				//dataParam.setString("cdVendor" , inputData.getString("cdVendor", 0));
					LLog.info.write("\n SQL -> /cm/au/progMgntSql/retrieveProgDuChk -------------> \n");

					resultInfo = dao.executeQueryForSingle("/cm/au/progMgntSql/retrieveProgDuChk", cudlData);
					strCheck   = resultInfo.getString("dupchk");

					if ( strCheck.equals("T") ) {
					
						String progCd = cudlData.getString("progCd");
						
						msg += "getErrorCode : " + getErrorCode + "\r\n";
						msg += "simpleMsg : Duplicate Part No ["+ progCd +"] \r\n";
						
						getMessage   = msg;
						getStatus    = "fail."+this.getClass().getName()+"."+"insertProgMgnt";
						throw new Exception(msg);	
						
					} else {
					
						cnt = progMgntCreate(cudlData, dao);
						
						if(cnt > 0){
							getMessage = "OK";					
						}	
					
					}
					
				} else if( "DEVON_UPDATE_FILTER_VALUE".equals(cudlData.getString( "DEVON_CUD_FILTER_KEY")) ) {
					cnt = progMgntUpdate(cudlData, dao);
					
					if(cnt > 0){
						getMessage = "OK";					
					}
				}
				
			}
			
			dao.commit();
				
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "cudProgMgnt()" + "=>" + se.getMessage());
			//throw new LSysException("pbf.err.com.save", se);
			getErrorCode = "-1403";
			getMessage = se.getMessage();
			throw new LSysException(getMessage,se);
        }
		
		result.put("getErrorCode"	,getErrorCode);
		result.put("getMessage"	,getMessage);
		
		return result;
    }

    
	/**
	 * <pre>Prog를 등록한다.</pre>
	 * 
     * @author 	mskim
     * @update
     * @since  		2010.07.27
	 * @param 		lData		LData
	 * @param   	dao			LCompoundDao
	 * @return	
	 * @throws 	LException
	 */    
    public int progMgntCreate( LData lData, LCompoundDao dao ) throws LException {
    	
    	int     cnt = 0;
		LData   resultData 	= new LData();		// Seq 생성
		String  strNewNoPo	= "";
    	
        try {
            dao.add ("/cm/au/progMgntSql/insertProgMgnt", lData );            
            cnt = dao.executeUpdate();
        } catch ( LException e ) {
            e.getMessage();
            throw e;
        }
        
        return cnt;
    }
    
	/**
	 * <pre>Prog 를 수정한다.</pre>
	 * 
     * @author 	mskim
     * @update
     * @since  		2010.07.27
	 * @param 		lData		LData
	 * @param   	dao			LCompoundDao
	 * @return	
	 * @throws 	LException
	 */    
    public int progMgntUpdate( LData lData, LCompoundDao dao ) throws LException {
    	
    	int cnt = 0;
    	
        try {
        	
            dao.add ("/cm/au/progMgntSql/updateProgMgnt", lData);            
            cnt = dao.executeUpdate();
        } catch ( LException e ) {
            e.getMessage();
            throw e;
        }
        
        return cnt;
    }
    
   
    
    /**
     *Prog Authority 저장하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     ** @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LData cudProgAuthority(LMultiData inputData, LData loginUser) throws LException {
        LCompoundDao dao = new LCompoundDao();
        LCommonDao dao1 = new LCommonDao();
        int cnt = 0;
        
        LData result = new LData();
        
		String	getErrorCode = "0" ;
		String	getMessage	 = "";
        //String  getStatus    = "";		
        
        String progCd = inputData.getString("progCd", 0);
        String authCd = inputData.getString("authCd", 0);
        
		LLog.debug.write("CudProgAuthorityCmd authCd --------------->>>>>>>>>>>>:" + authCd);
        
        LData inputData2 = new LData();
        
        inputData2.setString("progCd", 	  progCd);       
        inputData2.setString("companyCd", loginUser.getString("companyCd"));

        
		try{		

			//메뉴권한 삭제
			dao1.executeUpdate("/cm/au/progMgntSql/deleteProgAuthority", inputData2);
            
			if ( !authCd.equals("") ) {
		    	//메뉴권한 등록
				dao.setInsertQuery("cm/au/progMgntSql/insertProgAuthority");
				dao.addWithJobType(inputData);
				dao.executeUpdate();
			}
			
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "cudProgAuthority()" + "=>" + se.getMessage());
			//throw new LSysException("pbf.err.com.save", se);
			getErrorCode = "-1403";
			getMessage = se.getMessage();
			throw new LSysException(getMessage,se);
        }
		
		result.put("getErrorCode"	,getErrorCode + "" );
		result.put("getMessage"		,getMessage);
		
		return result;
    }

	/**
	 * <pre>Prog 를 수정한다.</pre>
	 * 
     * @author 	mskim
     * @update
     * @since  		2010.07.27
	 * @param 		lData		LData
	 * @param   	dao			LCompoundDao
	 * @return	
	 * @throws 	LException
	 */    
    public int progAuthInsert( LData lData, LCompoundDao dao ) throws LException {
    	
    	int cnt = 0;
    	
        try {
            dao.add ("cm/au/progMgntSql/insertProgAuthority", lData);            
            cnt = dao.executeUpdate();
        } catch ( LException e ) {
            e.getMessage();
            throw e;
        }
        
        return cnt;
    }    
    
}
