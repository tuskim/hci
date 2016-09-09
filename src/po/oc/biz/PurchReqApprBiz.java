/*
 *------------------------------------------------------------------------------
 * PurchReqApprBiz.java,v 1.0 2010/08/19 17:30:35 
 * 
 * PROJ : PT-PAM
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2010/08/19   mskim   Init
 *----------------------------------------------------------------------------
 */

package po.oc.biz;

import devon.core.exception.LException;
import devon.core.exception.LSysException;
import devon.core.log.LLog;
import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devonframework.persistent.autodao.LCommonDao;
import devonframework.persistent.autodao.LCompoundDao;

/**
 * <PRE>
 * Purch Request Manage 업무를 처리하는 Biz 클래스.
 *
 * Database Tables : 
 * </PRE>
 * @author    CEH
 */
public class PurchReqApprBiz {

    
    /**
     * Purch Request Manage  정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrievePurchReqMstAppr(LData inputData) throws LException {    	
    	
    	LLog.debug.write("PurchReqApprBiz.retrievePurchReqMstAppr -----------> Start ");
    	
    	LCommonDao dao = new LCommonDao();
		try{			
			return dao.executeQuery("po/oc/purchReqApprSql/retrievePurchReqMstAppr", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrievePurchReqMstAppr------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		}
    }
	

    /**
     * Search Purch Request Manage Detail 정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrievePurchReqDtlAppr(LData inputData) throws LException {    	
    	
    	LLog.debug.write("PurchReqApprBiz.retrievePurchReqDtlAppr -----------> Start ");
    	
    	LCommonDao dao = new LCommonDao();
		try{			
			return dao.executeQuery("po/oc/purchReqApprSql/retrievePurchReqDtlAppr", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrievePurchReqDtlAppr------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		}
    }	


    /**
     * Purch Request Appoval Apply / Cancel 정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
	public LData updatePurchReqApprApply(LData inputData, LData loginUser) throws LException {
		
    	LLog.info.write("\n PurchReqApprBiz > updatePurchReqApprApply() ------------- Start \n");
    	
        LCompoundDao dao		= new LCompoundDao();
        String msg 				= "";
        
		long	getErrorCode	= 0 ;
		String	getMessage		= "";
		String	getStatus		= "";
	
		LData dataBox		    = new LData();
		
		try{
			
			inputData.setString("userId",    loginUser.getString("userId"));
			inputData.setString("companyCd", loginUser.getString("companyCd"));

			LLog.info.write("\n SQL -> po/oc/purchReqApprSql/updatePurchReqMstApprApply ---------------------- \n");

	        //1) Delete Purch Request Master Manage 
	        dao.add ("po/oc/purchReqApprSql/updatePurchReqMstApprApply", inputData ); 

			dao.commit();
			
		} catch (Exception se) {
			dao.rollback();
			getErrorCode = -99901;
			getMessage   = se.toString();
			getStatus    = "fail."+this.getClass().getName()+"."+"PurchReqApprBiz";
			LLog.err.write(this.getClass().getName()+"."+"PurchReqApprBiz()"+"=>" + msg);
		}

		LLog.info.write("\n PurchReqApprBiz > updatePurchReqAppr() ------------- END --> \n");
      
		getErrorCode = 0;
		dataBox.put("getErrorCode"	,getErrorCode + "" );
		dataBox.put("getMessage"	,getMessage);
		
		if(!getStatus.equals("")) dataBox.put("getStatus" ,getStatus ); //현 프로그램에서 에러
		return dataBox;
	}	

    /**
     * Save Purch Request Manage 정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     ** @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LData cudPurchReqAppr(LData inputData, LMultiData inDtlData,  LData loginUser) throws LException {

    	LCompoundDao dao = new LCompoundDao();
        LData result = new LData();
        //int cnt = 0;
        
		LLog.debug.write("PurchReqApprBiz.cudPurchReqDtlAppr inDtlData--------------- =>\n " + inDtlData.toString());
		
		String	getErrorCode = "0" ;
		String	getMessage	 = "";
        //String  getStatus    = "";		

        try{			

			dao.startTransaction();

			String  str_pr_no	= "";

			inputData.setString("comapnyCd",  loginUser.getString("companyCd"));
			inputData.setString("userId",     loginUser.getString("userId"));

			//Purch Request Manage Detail Update
			dao.add("po/oc/purchReqApprSql/updatePurchReqMstAppr", inputData);
			
			// Purchase Request Detail Manage
			for(int j=0;j<inDtlData.getDataCount();j++) {
				
				LData cudDtlData = inDtlData.getLData(j);
		    	String tr_Mode  = cudDtlData.getString("DEVON_CUD_FILTER_KEY");

				cudDtlData.setString("userId",    loginUser.getString("userId"));
				
				if( tr_Mode.equals("DEVON_UPDATE_FILTER_VALUE") ) {

					//Purch Request Manage Detail Update
					dao.add("po/oc/purchReqApprSql/updatePurchReqDtlAppr", cudDtlData);
				}
			
			}
			
			dao.executeUpdate();
			
			dao.commit();
				
		} catch (Exception se) {
			dao.rollback();

			LLog.err.println(  this.getClass().getName() + "." + "cudMenuAppr()" + "=>" + se.getMessage());
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
