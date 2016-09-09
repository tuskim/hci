/*
 *------------------------------------------------------------------------------
 * CostTotLedgerConfirmBiz.java,v 1.0 2010/07/23 16:43:35 
 * 
 * PROJ : PT-PAM
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2010/08/03   mskim   Init
 * 2015/11/30   hckim   Cost Price List Detail 정보를 조회하는 메소드. 추가
 *                      Internal Order 정보를 조회하는 메소드. 추가
 *----------------------------------------------------------------------------
 */

package fi.ar.biz;

import xi.GFI01;
import devon.core.exception.LException;
import devon.core.exception.LSysException;
import devon.core.log.LLog;
import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devonframework.persistent.autodao.LCommonDao;
import devonframework.persistent.autodao.LCompoundDao;

/**
 * <PRE>
 * Cost Total Ledger Confirm 업무를 처리하는 Biz 클래스.
 *
 * Database Tables : 
 * </PRE>
 * @author    CEH
 */
public class CostTotLedgerConfirmBiz {

    
    /**
     * Cost Total Ledger Master Confirm 정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveCostTotLedgerMstConfirm(LData inputData) throws LException {    	
    	
    	LLog.debug.write("CostTotLedgerConfirmBiz.retrieveCostTotLedgerMstConfirm -----------> Start ");
    	
    	LCommonDao dao = new LCommonDao();
		try{			
			return dao.executeQuery("fi/ar/costTotLedgerConfirmSql/retrieveCostTotLedgerMstConfirm", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveCostTotLedgerMstConfirm------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		}
    }

    
    /**
     * Cost Total Ledger Confirm Approval 정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
	public LData cudApprCostTotLedgerConfirm(LMultiData inputMstData, 
			                                  LData loginUser) throws LException {
		
    	LLog.info.write("\n CostTotLedgerConfirmBiz > cudApprCostTotLedgerConfirm() ------------- Start \n");
    	
        LCompoundDao dao  = new LCompoundDao();
        LCommonDao   dao1 = new LCommonDao();
        String msg 				= "";
        
		long	getErrorCode	= 0 ;
		String	getMessage		= "";
		String	getStatus		= "";
	
		LData dataBox		    = new LData();
		LData  resultInfo  = new LData();		// Seq 생성
		String docSeq      = "";
		
		try{

			dao.startTransaction();

			for(int i=0; i<inputMstData.getDataCount(); i++) {
				LData cudlData = inputMstData.getLData(i);
				cudlData.setString("userId", loginUser.getString("userId"));
				cudlData.setString("progStatus","20");   // Approval 20
				dao.add("fi/ar/costTotLedgerConfirmSql/updateCostTotLedgerMstConfirm", cudlData );   
				//approval 날짜입력
				dao.add("fi/ar/costTotLedgerConfirmSql/updateApprovalDate", cudlData );     
				
				//Type Class가 B일 경우
				if(cudlData.getString("attr2").equals("B")){
					resultInfo = dao1.executeQueryForSingle("fi/ar/costTotLedgerMgntSql/retrieveCostTotLedgerDocSeq", cudlData);
					docSeq     = resultInfo.getString("docSeq");
					cudlData.setString("docSeq2", docSeq);
	
					dao.add("fi/ar/costTotLedgerMgntSql/insertCostTotLedgerMstMgntC", cudlData);
					
					dao.add("fi/ar/costTotLedgerMgntSql/insertCostTotLedgerDtlMgntC", cudlData);
					
					//updateDocMaster
					dao.add("fi/ar/costTotLedgerMgntSql/updateDocMaster", cudlData);
				}
			}

			dao.executeUpdate();
			
			dao.commit();
			
			getErrorCode = 0;
		} catch (Exception se) {
			dao.rollback();
			
			getErrorCode = -99901;
			getMessage   = se.toString();
			getStatus    = "fail."+this.getClass().getName()+"."+"CostTotLedgerConfirmBiz";
			LLog.err.write(this.getClass().getName()+"."+"CostTotLedgerConfirmBiz()"+"=>" + msg);
		}

		LLog.info.write("\n CostTotLedgerConfirmBiz > cudApprCostTotLedgerConfirm() ------------- END  \n");
      
		dataBox.put("getErrorCode"	,getErrorCode + "" );
		dataBox.put("getMessage"	,getMessage);
		
		if(!getStatus.equals("")) dataBox.put("getStatus" ,getStatus ); //현 프로그램에서 에러
		return dataBox;
	}    

    /**
     * Cost Total Ledger Confirm Cancel Approval 정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
	public LData cudApprCostTotLedgerCancelConfirm(LMultiData inputData, LData loginUser) throws LException {
		
    	LLog.info.write("\n CostTotLedgerConfirmBiz > cudApprCostTotLedgerCancelConfirm() ------------- Start \n");
    	
        LCompoundDao dao		= new LCompoundDao();
        String msg 				= "";
        
		long	getErrorCode	= 0 ;
		String	getMessage		= "";
		String	getStatus		= "";
	
		LData dataBox		    = new LData();
		
		try{

			for(int i=0; i<inputData.getDataCount(); i++) {
				LData cudlData = inputData.getLData(i);
				cudlData.setString("userId", loginUser.getString("userId"));
				cudlData.setString("progStatus","10");   // Insert 10
	            
				LLog.info.write("\n fi/ar/costTotLedgerConfirmSql/updateCostTotLedgerMstConfirmC --------->  \n");
				dao.add ("fi/ar/costTotLedgerConfirmSql/updateCostTotLedgerMstConfirmC", cudlData );  
				//approval date삭제
				dao.add ("fi/ar/costTotLedgerConfirmSql/updateCostTotLedgerMstConfirmCancelApprovalDate", cudlData );            
				dao.executeUpdate();
			
				// Type Class가 B일 경우
				if(cudlData.getString("attr2").equals("B")){
					cudlData.setString("docSeq",cudlData.getString("attr3"));
					
					//1) Delete Cost Total Ledger Detail
			        dao.add ("fi/ar/costTotLedgerMgntSql/deleteCostTotLedgerAllDtlMgnt", cudlData );   
			        
					// 2) Delete Cost Total Ledger Master
			        dao.add ("fi/ar/costTotLedgerMgntSql/deleteCostTotLedgerMstMgnt", cudlData ); 
			        dao.executeUpdate();
				}
				
			}
			
		} catch (Exception se) {
			getErrorCode = -99901;
			getMessage   = se.toString();
			getStatus    = "fail."+this.getClass().getName()+"."+"CostTotLedgerConfirmBiz";
			LLog.err.write(this.getClass().getName()+"."+"CostTotLedgerConfirmBiz()"+"=>" + msg);
		}

		LLog.info.write("\n CostTotLedgerConfirmBiz > cudApprCostTotLedgerCancelConfirm() ------------- END  \n");
      
		getErrorCode = 0;
		dataBox.put("getErrorCode"	,getErrorCode + "" );
		dataBox.put("getMessage"	,getMessage);
		
		if(!getStatus.equals("")) dataBox.put("getStatus" ,getStatus ); //현 프로그램에서 에러
		return dataBox;
	}  
	
    /**
     * Cost Total Ledger Confirm Sap Approval 정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
public LData cudApprCostTotLedgerSapConfirm(LMultiData headerData, LData loginUser) throws LException {
		
    	LLog.info.write("\n CostTotLedgerConfirmBiz > cudApprCostTotLedgerConfirm() ------------- Start \n");
    	
        LCompoundDao dao		 = new LCompoundDao();
        LCommonDao xdao		     = new LCommonDao();
        String msg 				 = "";
        
		long	getErrorCode	 = -1403 ;
		String	getMessage		 = "";
		String	getStatus		 = "";
	
		LData dataBox		     = new LData();
		LData resultMsg		     = new LData();
		LMultiData newHeaderData = new LMultiData();
		LMultiData bodyData      = new LMultiData();
		LMultiData resultData    = new LMultiData();
		
		try{
			
			LData xmlNo = xdao.executeQueryForSingle("cm/cm/commCodeMgntSql/retireveXmlDocNo", loginUser);

			dao.startTransaction();

			for(int i=0; i<headerData.getDataCount(); i++) {
				LData rowData = headerData.getLData(i);
				rowData.setString("userId", 	loginUser.getString("userId"));
				rowData.setString("progStatus", "30"); //SAP Send Request
				rowData.setString("zxmldocno", 	xmlNo.getString("zxmldocno"));
				rowData.setString("attr4", 	rowData.getString("consultationDocNo") );
				newHeaderData.addLData(rowData);
				
				resultData = dao.executeQuery("fi/ar/costTotLedgerConfirmSql/retrieveApprCostTotLedgerAdd", rowData);

				bodyData.addLMultiData(resultData); 
				LData selectData		     = new LData();
				// Type Class가 B일 경우
				if(rowData.getString("attr2").equals("B")){
					selectData.setString("docSeq2",rowData.getString("attr3"));
					selectData.setString("docFlg","T");
					selectData.setString("companyCd", loginUser.getString("companyCd"));
					selectData.setString("deptCd", rowData.getString("deptCd"));
					selectData.setString("docYm", rowData.getString("docYm"));
					selectData.setString("lang", loginUser.getString("lang"));
					selectData.setString("orderDateFrom", rowData.getString("orderDateFrom"));
					selectData.setString("orderDateTo", rowData.getString("orderDateTo"));
					
					LData rowData2 = new LData();
					rowData2 = xdao.executeQueryForSingle("fi/ar/costTotLedgerMgntSql/retrieveCostTotLedgerMstMgntC", selectData);
					rowData2.setString("userId", 	loginUser.getString("userId"));
					rowData2.setString("progStatus", "30"); //SAP Send Request
					rowData2.setString("zxmldocno", 	xmlNo.getString("zxmldocno"));
					newHeaderData.addLData(rowData2);
					resultData = dao.executeQuery("fi/ar/costTotLedgerConfirmSql/retrieveApprCostTotLedgerAdd", rowData2);
					bodyData.addLMultiData(resultData);
				}
			}

			
			LLog.debug.write("cudApprCostTotLedgerSapConfirm bodyData -->" + bodyData);
			
			dao.add ("fi/ar/costTotLedgerConfirmSql/updateCostTotLedgerMstConfirm", newHeaderData );            
			dao.executeUpdate();
			
			GFI01 gfi01 = new GFI01();
			resultMsg = gfi01.GFI01_out(newHeaderData, bodyData);
			
			if (resultMsg.getString("returnType").equals("00")) {
				getErrorCode = 0;
				dao.commit();
			} else {
				dao.rollback();
			}
			
			getMessage = resultMsg.getString("returnText");
			
		} catch (Exception se) {
			dao.rollback();
			getErrorCode = -99901;
			getMessage   = se.toString();
			getStatus    = "fail."+this.getClass().getName()+"."+"CostTotLedgerConfirmBiz";
			LLog.err.write(this.getClass().getName()+"."+"CostTotLedgerConfirmBiz()"+"=>" + msg);
		}

		LLog.info.write("\n CostTotLedgerConfirmBiz > cudApprCostTotLedgerConfirm() ------------- END  \n");
		
		dataBox.put("getErrorCode"	,getErrorCode + "" );
		dataBox.put("getMessage"	,getMessage);
		
		if(!getStatus.equals("")) dataBox.put("getStatus" ,getStatus ); //현 프로그램에서 에러
		return dataBox;
	}
	
    /**
     * Cost Total Ledger Confirm Sap Cancel Approval 정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
	public LData cudApprCostTotLedgerSapCancelConfirm(LMultiData headerData, LData loginUser) throws LException {
		
    	LLog.info.write("\n CostTotLedgerConfirmBiz > cudApprCostTotLedgerSapCancelConfirm() ------------- Start \n");
    	
        LCompoundDao dao		= new LCompoundDao();
        LCommonDao xdao		= new LCommonDao();
        String msg 				= "";
        
		long	getErrorCode	=-1403 ;
		String	getMessage		= "";
		String	getStatus		= "";
	
		LData dataBox		    = new LData();
		LData resultMsg		    = new LData();
		LMultiData newHeaderData = new LMultiData();
		LMultiData bodyData     = new LMultiData();
		
		try{
			
			LData xmlNo = xdao.executeQueryForSingle("cm/cm/commCodeMgntSql/retireveXmlDocNo", loginUser);
			
			dao.startTransaction();
			
			for(int i=0; i<headerData.getDataCount(); i++) {
				LData rowData = headerData.getLData(i);
				rowData.setString("userId", loginUser.getString("userId"));
				rowData.setString("progStatus", "50"); //SAP Cancel Request
				rowData.setString("zfxmldocno", xmlNo.getString("zxmldocno"));
				newHeaderData.addLData(rowData);

				bodyData.addLMultiData(dao.executeQuery("fi/ar/costTotLedgerConfirmSql/retrieveApprCostTotLedgerAdd", rowData));
				
				LData selectData		     = new LData();
				// Type Class가 B일 경우
				if(rowData.getString("attr2").equals("B")){
					rowData.setString("docSeq",rowData.getString("attr3"));
					rowData.setString("docFlg","T");
					
					selectData.setString("docSeq2",rowData.getString("attr3"));
					selectData.setString("docFlg","T");
					selectData.setString("companyCd", loginUser.getString("companyCd"));
					selectData.setString("deptCd", rowData.getString("deptCd"));
					selectData.setString("docYm", rowData.getString("docYm"));
					selectData.setString("lang", loginUser.getString("lang"));
					
					LData rowData2 = new LData();
					rowData2 = xdao.executeQueryForSingle("fi/ar/costTotLedgerMgntSql/retrieveCostTotLedgerMstMgntC", selectData);
					rowData2.setString("userId", loginUser.getString("userId"));
					rowData2.setString("progStatus", "50"); //SAP Cancel Request
					rowData2.setString("zfxmldocno", xmlNo.getString("zxmldocno"));
					newHeaderData.addLData(rowData2);
					bodyData.addLMultiData(dao.executeQuery("fi/ar/costTotLedgerConfirmSql/retrieveApprCostTotLedgerAdd", rowData2));
				}
			}

			dao.add ("fi/ar/costTotLedgerConfirmSql/updateCostTotLedgerMstConfirm", newHeaderData );            
			dao.executeUpdate();
			
			GFI01 gfi01 = new GFI01();
			resultMsg = gfi01.GFI01_out(newHeaderData, bodyData);
			
			if (resultMsg.getString("returnType").equals("00")) {
				getErrorCode = 0;
				dao.commit();
			} else {
				dao.rollback();
			}
			
			getMessage = resultMsg.getString("returnText");
			
		} catch (Exception se) {
			dao.rollback();
			getErrorCode = -99901;
			getMessage   = se.toString();
			getStatus    = "fail."+this.getClass().getName()+"."+"CostTotLedgerConfirmBiz";
			LLog.info.write(this.getClass().getName()+"."+"CostTotLedgerConfirmBiz()"+"=>" + msg);
		}

		LLog.info.write("\n CostTotLedgerConfirmBiz > cudApprCostTotLedgerSapCancelConfirm() ------------- END  \n");
		
		dataBox.put("getErrorCode"	,getErrorCode + "" );
		dataBox.put("getMessage"	,getMessage);
		
		if(!getStatus.equals("")) dataBox.put("getStatus" ,getStatus ); //현 프로그램에서 에러
		return dataBox;
	}
	
	
    /**
     * Cost Total Ledger Detail Confirm 정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveCostTotLedgerDtlConfirm(LData inputData) throws LException {    	
    	
    	LLog.debug.write("CostTotLedgerConfirmBiz.retrieveCostTotLedgerDtlConfirm -----------> Start ");
    	
    	LCommonDao dao = new LCommonDao();
		try{			
			return dao.executeQuery("fi/ar/costTotLedgerConfirmSql/retrieveCostTotLedgerDtlConfirm", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveCostTotLedgerDtlConfirm------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		}
    }	

    
    /**
     * Cost Price List Detail 정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveApprCostTotLedgerAdd(LData rowData) throws LException {    	
    	
    	LLog.debug.write("CostTotLedgerConfirmBiz.retrieveApprCostTotLedgerAdd -----------> Start ");
    	
    	LCommonDao dao = new LCommonDao();
		try{			
			return dao.executeQuery("fi/ar/costTotLedgerConfirmSql/retrieveApprCostTotLedgerAdd", rowData);						
			
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveApprCostTotLedgerAdd------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		}
    }
    
    
    /**
     * Internal Order 정보를 조회하는 메소드.
     *
     * @param inputData 
     * 
     * @return LData 조회된 정보 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LData retrieveInternalOrderInfo(LData rowDtlData) throws LException {    	
    	    	
    	LData internalOrderInfo = new LData();    	
    	LCommonDao dao = new LCommonDao();
    	    	
		try{			
			internalOrderInfo = dao.executeQueryForSingle("fi/ar/costTotLedgerConfirmSql/retrieveInternalOrderInfo", rowDtlData);
			 					
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveInternalOrderInfo------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		}
		return internalOrderInfo;
    }
}
