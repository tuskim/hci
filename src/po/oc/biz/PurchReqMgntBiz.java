/*
 *------------------------------------------------------------------------------
 * PurchReqMgntBiz.java,v 1.0 2010/07/23 16:43:35 
 * 
 * PROJ : PT-PAM
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2010/08/16   mskim   Init
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
public class PurchReqMgntBiz {

    
    /**
     * Purch Request Manage  정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrievePurchReqMstMgnt(LData inputData) throws LException {    	
    	
    	LLog.debug.write("PurchReqMgntBiz.retrievePurchReqMstMgnt -----------> Start ");
    	
    	LCommonDao dao = new LCommonDao();
		try{			
			return dao.executeQuery("po/oc/purchReqMgntSql/retrievePurchReqMstMgnt", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrievePurchReqMstMgnt------()" + "=>" + se.getMessage());
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
    public LMultiData retrievePurchReqDtlMgnt(LData inputData) throws LException {    	
    	
    	LLog.debug.write("PurchReqMgntBiz.retrievePurchReqDtlMgnt -----------> Start ");
    	
    	LCommonDao dao = new LCommonDao();
		try{			
			return dao.executeQuery("po/oc/purchReqMgntSql/retrievePurchReqDtlMgnt", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrievePurchReqDtlMgnt------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		}
    }	

    
    /**
     * Purch Request Manage Delete 정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
	public LData deletePurchReqMgnt(LData inputData, LData loginUser) throws LException {
		
    	LLog.info.write("\n CostTotLedgerConfirmBiz > cudDelCostTotLedgerConfirm() ------------- Start \n");
    	
        LCompoundDao dao		= new LCompoundDao();
        String msg 				= "";
        
		long	getErrorCode	= 0 ;
		String	getMessage		= "";
		String	getStatus		= "";
	
		LData dataBox		    = new LData();
		
		try{
			
			dao.startTransaction();

			inputData.setString("userId",    loginUser.getString("userId"));
			inputData.setString("companyCd", loginUser.getString("companyCd"));

			LLog.info.write("\n SQL -> po/oc/purchReqMgntSql/deleteCostTotLedgerMstConfirm ---------------------- \n");

	        //1) Delete Purch Request Master Manage 
	        dao.add ("po/oc/purchReqMgntSql/deletePurchReqMstMgnt", inputData ); 

	        //2) Delete Purch Request Detail Manage 
	        dao.add ("po/oc/purchReqMgntSql/deletePurchReqAllDtlMgnt", inputData ); 
			dao.executeUpdate();
			
			dao.commit();
			
		} catch (Exception se) {
			dao.rollback();
			getErrorCode = -99901;
			getMessage   = se.toString();
			getStatus    = "fail."+this.getClass().getName()+"."+"PurchReqMgntBiz";
			LLog.err.write(this.getClass().getName()+"."+"PurchReqMgntBiz()"+"=>" + msg);
		}

		LLog.info.write("\n PurchReqMgntBiz > deletePurchReqMgnt() ------------- END --> \n");
      
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
    public LData cudPurchReqMgnt(LMultiData inMstData, LMultiData inDtlData, LData loginUser) throws LException {

    	LCompoundDao dao = new LCompoundDao();
        LData result = new LData();
        //int cnt = 0;
        
		LLog.debug.write("PurchReqMgntBiz.cudPurchReqDtlMgnt inputData--------------- =>\n " + inMstData.toString());
		
		String	getErrorCode = "0" ;
		String	getMessage	 = "";
        //String  getStatus    = "";		

        try{			

			dao.startTransaction();

			LData   resultInfo 	= new LData();		// Seq 생성
			String  str_pr_no	= "";
			
			// Purchase Request Master Manage
			for(int i=0;i<inMstData.getDataCount();i++) {
				
				LData cudMstData = inMstData.getLData(i);
		    	String tr_Mode  = cudMstData.getString("DEVON_CUD_FILTER_KEY");

		    	cudMstData.setString("userId",    loginUser.getString("userId"));
				
				if( tr_Mode.equals("DEVON_CREATE_FILTER_VALUE") ) {

					// New Pr No Create
					resultInfo = dao.executeQueryForSingle("po/oc/purchReqMgntSql/retrievePrNo", cudMstData);
					str_pr_no  = cudMstData.getString("reqDate").replaceAll("/", "").substring(0, 6) + resultInfo.getString("prNo");
			    	cudMstData.setString("prNo", str_pr_no);
					
					//Purch Request Manage Detail Insert
					dao.add("po/oc/purchReqMgntSql/insertPurchReqMstMgnt", cudMstData);
				
				} else if( tr_Mode.equals("DEVON_UPDATE_FILTER_VALUE") ) {

					//Purch Request Manage Detail Update
					dao.add("po/oc/purchReqMgntSql/updatePurchReqMstMgnt", cudMstData);
				}
			}

			// Purchase Request Detail Manage
			for(int j=0;j<inDtlData.getDataCount();j++) {
				
				LData cudDtlData = inDtlData.getLData(j);
		    	String tr_Mode  = cudDtlData.getString("DEVON_CUD_FILTER_KEY");

				cudDtlData.setString("userId",    loginUser.getString("userId"));
				
				if( tr_Mode.equals("DEVON_CREATE_FILTER_VALUE") ) {

					// New Pr No Setup
					if ( !str_pr_no.equals("")) {
						cudDtlData.setString("prNo", str_pr_no);
					}
					
					//Purch Request Manage Detail Insert
					dao.add("po/oc/purchReqMgntSql/insertPurchReqDtlMgnt", cudDtlData);
					
				} else if( tr_Mode.equals("DEVON_UPDATE_FILTER_VALUE") ) {

					//Purch Request Manage Detail Update
					dao.add("po/oc/purchReqMgntSql/updatePurchReqDtlMgnt", cudDtlData);

				} else if( tr_Mode.equals("DEVON_DELETE_FILTER_VALUE") ) {

					//Purch Request Manage Delete
					dao.add("po/oc/purchReqMgntSql/deletePurchReqDtlMgnt", cudDtlData);
				}
			
			}
			
			dao.executeUpdate();
			
			dao.commit();
				
		} catch (Exception se) {
			dao.rollback();

			LLog.err.println(  this.getClass().getName() + "." + "cudMenuMgnt()" + "=>" + se.getMessage());
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
