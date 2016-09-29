/* ------------------------------------------------------------------------
 * @source  : CoalProductionBiz.java
 * @desc    : 채탄량 등록, 조회, SAP 입고, 취소 처리
 * ------------------------------------------------------------------------
 * PROJ : 투자사 시스템 표준안 개발
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2010.09.03  임민수                 Initial
 * ------------------------------------------------------------------------ */

package po.ir.biz;

import java.text.DecimalFormat;

import xi.GMM07;
import xi.GSD01;
import devon.core.collection.LData;
import devon.core.collection.LMetaData;
import devon.core.collection.LMultiData;
import devon.core.exception.LBizException;
import devon.core.exception.LException;
import devon.core.exception.LSysException;
import devon.core.log.LLog;
import devonframework.persistent.autodao.LCommonDao;
import devonframework.persistent.autodao.LCompoundDao;
import java.text.*;
public class InvoiceRegBiz {
	
	/**
     * 채탄량 입고 목록 조회
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveCoalProductionMasterList(LData inputData) throws LException {
        LMultiData list = null;

        try {        
 
            LCommonDao dao = new LCommonDao("/po/ir/InvoiceRegSql/retrieveCoalProductionMasterList", inputData);
            list = dao.executeQuery();
            
        } catch (LException le) {
            LLog.err.write(this.getClass().getName() + "." + "RetrievecodeCbList()" + "=>" + le.getMessage());
            throw new LBizException("cm.cm.com.retrieve");
        }
        return list;

    }

	/**
     * 채탄량 입고 목록 조회
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveCoalProductionDetailList(LData inputData) throws LException {
        LMultiData list = null;

        try {
 
            LCommonDao dao = new LCommonDao("/po/ir/InvoiceRegSql/retrieveCoalProductionDetailList", inputData);
            list = dao.executeQuery();
            
        } catch (LException le) {
            LLog.err.write(this.getClass().getName() + "." + "RetrievecodeCbList()" + "=>" + le.getMessage());
            throw new LBizException("cm.cm.com.retrieve");
        }
        return list;

    }



	public LMultiData retrieveTaxDataSetList(LData inputData) throws LBizException {
        LMultiData list = null;

        try {
 
            LCommonDao dao = new LCommonDao("/po/ir/InvoiceRegSql/retrieveTaxDataSetList", inputData);
            list = dao.executeQuery();
            
        } catch (LException le) {
            LLog.err.write(this.getClass().getName() + "." + "RetrievecodeCbList()" + "=>" + le.getMessage());
            throw new LBizException("cm.cm.com.retrieve");
        }
        return list;

	}

	public LMultiData retrievePoMstList(LData inputData) throws LBizException {
        LMultiData list = null;

        try {        
 
            LCommonDao dao = new LCommonDao("/po/ir/InvoiceRegSql/retrievePoMstList", inputData);
            list = dao.executeQuery();
            
        } catch (LException le) {
            LLog.err.write(this.getClass().getName() + "." + "RetrievecodeCbList()" + "=>" + le.getMessage());
            throw new LBizException("cm.cm.com.retrieve");
        }
        return list;
	}

	public LMultiData retrieveInvoiceMstList(LData inputData) throws LBizException {
        LMultiData list = null;

        try {        
 
            LCommonDao dao = new LCommonDao("/po/ir/InvoiceRegSql/retrieveInvoiceMstList", inputData);
            list = dao.executeQuery();
            
        } catch (LException le) {
            LLog.err.write(this.getClass().getName() + "." + "RetrievecodeCbList()" + "=>" + le.getMessage());
            throw new LBizException("cm.cm.com.retrieve");
        }
        return list;
	}

	public LMultiData retrievePoDtlList(LData inputData) throws LBizException {
        LMultiData list = null;

        try {        
 
            LCommonDao dao = new LCommonDao("/po/ir/InvoiceRegSql/retrievePoDtlList", inputData);
            list = dao.executeQuery();
            
            LMetaData metaData = list.getMetaData();
            metaData.setMetaString("amount"	,    "2|13|2");
            metaData.setMetaString("receiptQty"	,    "2|13|2");
            list.setMetaData(metaData);
            
        } catch (LException le) {
            LLog.err.write(this.getClass().getName() + "." + "RetrievecodeCbList()" + "=>" + le.getMessage());
            throw new LBizException("cm.cm.com.retrieve");
        }
        return list;
	}
	
	public LMultiData retrieveInvoiceDtlList(LData inputData) throws LBizException {
        LMultiData list = null;

        try {        
 
            LCommonDao dao = new LCommonDao("/po/ir/InvoiceRegSql/retrieveInvoiceDtlList", inputData);
            list = dao.executeQuery();
            
        } catch (LException le) {
            LLog.err.write(this.getClass().getName() + "." + "RetrievecodeCbList()" + "=>" + le.getMessage());
            throw new LBizException("cm.cm.com.retrieve");
        }
        return list;
	}

	public LMultiData retrieveInvoiceTaxList(LData inputData) throws LBizException {
        LMultiData list = null;

        try {        
 
            LCommonDao dao = new LCommonDao("/po/ir/InvoiceRegSql/retrieveInvoiceTaxList", inputData);
            list = dao.executeQuery();
            
        } catch (LException le) {
            LLog.err.write(this.getClass().getName() + "." + "RetrievecodeCbList()" + "=>" + le.getMessage());
            throw new LBizException("cm.cm.com.retrieve");
        }
        return list;
	}		
	
	/*
	 * 입고 등록 및 SAP 전송  Save
	 * 
	 */
	
	public LData cudInvoice(LMultiData mDataMst, LMultiData mDataDtl, LMultiData mDataTax, LData inputData) throws LException {
       
		LLog.debug.write("cudInvoiceBiz inputData--------------- Start \n");
		
		LCompoundDao dao = new LCompoundDao();
        LCompoundDao dao2 = new LCompoundDao();        // SAP 성공시에만 입고 수량을 업데이트 하기위해 DAO를 따로 생성 
        
        LData result = new LData();
        LMultiData mDtlXi = new LMultiData();
        LMultiData mTaxXi = new LMultiData();
        
		String	getErrorCode = "0" ;
		String	getMessage	 = "Failed"; 	

		LData resultMsg		    = new LData();
		
		GMM07 gmm07 = new GMM07();
		int clsNoCnt = 0;
		DecimalFormat format = new DecimalFormat("0.####");
		
		
        try{			
        	dao.startTransaction();
        	dao2.startTransaction();
        	
        	for(int j=mDataDtl.getDataCount()-1 ;j>=0;j--) {
        		mDataDtl.modify("amount", j, format.format(mDataDtl.getDouble("amount",j)));
        		mDataDtl.modify("vatAmt", j, format.format(mDataDtl.getDouble("vatAmt",j)));
        		mDataDtl.modify("tranTaxAmt", j, format.format(mDataDtl.getDouble("tranTaxAmt",j)));
        		
        		LLog.info.println("mDataDtl--------------*************----------> :\n "+mDataDtl);
				LData cudlDataDtl = mDataDtl.getLData(j);
				
				if(!cudlDataDtl.getString("chk").equals("T") )
					continue;

				cudlDataDtl.setString("companyCd", inputData.getString("companyCd"));
				cudlDataDtl.setString("userId",    inputData.getString("userId"));

        	}
        	

         
		        // Master CUD - TB_IV_MASTER
				for(int i=0;i<mDataMst.getDataCount();i++) {
							
					LData cudlData = mDataMst.getLData(i);
					
					cudlData.setString("companyCd", inputData.getString("companyCd"));
					 		
					LData plantCd = dao.executeQueryForSingle("cm/cm/commCodeMgntSql/retrievePlant", inputData);
					LData ivSeq = dao.executeQueryForSingle("po/ir/InvoiceRegSql/retrieveIvSeq", cudlData);
					LData xmlNo = dao.executeQueryForSingle("cm/cm/commCodeMgntSql/retireveXmlDocNo", inputData);
					
					LLog.info.println(inputData);
					cudlData.setString("ivSeq",    ivSeq.getString("ivSeq"));	
					cudlData.setString("ivDate",    inputData.getString("invoiceDate"));
					cudlData.setString("postDate",    inputData.getString("postingDate"));
					cudlData.setString("dueDate",    inputData.getString("dueDate"));
					cudlData.setString("ivAmt",    format.format(inputData.getDouble("amount")));
					cudlData.setString("currencyCd",    inputData.getString("currency"));		
					cudlData.setString("vatAmt",    format.format(inputData.getDouble("vatAmt")));
					cudlData.setString("vatCd",    inputData.getString("vatCd"));
					cudlData.setString("plant",    plantCd.getString("plantCd"));
					cudlData.setString("storLoct",    "001B");
					cudlData.setString("status",    "00");    						// 00 - 입고 입력 
				    cudlData.setString("userId",    inputData.getString("userId"));
					cudlData.setString("zxmldocno", xmlNo.getString("zxmldocno"));  //xmldocno
					
					// Invoice Mst 생성 
					if( "DEVON_UPDATE_FILTER_VALUE".equals(cudlData.getString( "DEVON_CUD_FILTER_KEY")) ) {
						LLog.info.write("\n SQL ->  /po/ir/InvoiceRegSql/InsertInvoiceMst -------------> \n");
			            dao.add( "/po/ir/InvoiceRegSql/InsertInvoiceMst", cudlData);    
						dao.executeUpdate();
					} 
					
			        // Detail CUD
					for(int j=mDataDtl.getDataCount()-1 ;j>=0;j--) {
						
						LData cudlDataDtl = mDataDtl.getLData(j);
						 
						if(!cudlDataDtl.getString("chk").equals("T") )
							continue;
						
						cudlDataDtl.setString("companyCd", inputData.getString("companyCd"));
						cudlDataDtl.setString("userId",    inputData.getString("userId"));
						cudlDataDtl.setString("poNo",    cudlData.getString("poNo"));
						cudlDataDtl.setString("ivSeq",     ivSeq.getString("ivSeq"));
						//cudlDataDtl.setString("vatCd",     inputData.getString("vatCd"));  Line Item 별로 다르게 
						cudlDataDtl.setString("receiptQty",    cudlDataDtl.getString("qty"));
						cudlDataDtl.setString("attr1",    cudlDataDtl.getString("tranTaxAmt"));
	
						
						mDtlXi.addLData(cudlDataDtl);
						
						// TB_IV_ITEM 
						if( "DEVON_UPDATE_FILTER_VALUE".equals(cudlDataDtl.getString( "DEVON_CUD_FILTER_KEY")) || "DEVON_CREATE_FILTER_VALUE".equals(cudlDataDtl.getString( "DEVON_CUD_FILTER_KEY")) ) {
							LLog.info.write("\n SQL ->  /po/ir/InvoiceRegSql/InsertInvoiceDtl -------------> \n");
				            dao.add ("/po/ir/InvoiceRegSql/InsertInvoiceDtl", cudlDataDtl);
				            dao.executeUpdate();
				            
				           // dao2.add ("/po/ir/InvoiceRegSql/updatePoRecQty", cudlDataDtl);    
				           // dao2.executeUpdate();
						} 
					}
					
	
			        // Tax CUD
					for(int j=mDataTax.getDataCount()-1 ;j>=0;j--) {
						
						LLog.info.println("@@@@@@@@@@@@mDataTax@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ \n : "+mDataTax);
						mDataTax.modify("baseAmt", j, format.format(mDataTax.getDouble("baseAmt",j)));
						LData cudlDataTax = mDataTax.getLData(j);
						LData wtSeq= dao.executeQueryForSingle("po/ir/InvoiceRegSql/retrieveWtSeq", cudlData);
	
						if(!cudlDataTax.getString("chk").equals("T"))
							continue;
						
						cudlDataTax.setString("companyCd", inputData.getString("companyCd"));
						cudlDataTax.setString("userId",    inputData.getString("userId"));
						cudlDataTax.setString("poNo",    cudlData.getString("poNo"));
						cudlDataTax.setString("wtSeq",    wtSeq.getString("wtSeq"));
						cudlDataTax.setString("ivSeq",     ivSeq.getString("ivSeq"));
	
						mTaxXi.addLData(cudlDataTax);
						
						if( "DEVON_UPDATE_FILTER_VALUE".equals(cudlDataTax.getString( "DEVON_CUD_FILTER_KEY")) ) {
							LLog.info.write("\n SQL ->  /po/ir/InvoiceRegSql/InsertInvoiceTax -------------> \n");
				            dao.add ("/po/ir/InvoiceRegSql/InsertInvoiceTax", cudlDataTax);    
				            dao.executeUpdate();
						}
					}
					
					//TB_PO_MASTER 의 IV_CLOSE 해줌 
					cudlData.setString("stat", "Y");
					dao.add ("/po/ir/InvoiceRegSql/cudIvClose", cudlData ); 
					dao.executeUpdate();
						
					
					cudlData.setString("status", "01");  			// 01 : SAP 전송 
					
					resultMsg = gmm07.GMM07_out(cudlData, mDtlXi, mTaxXi);
					
					LLog.info.println("resultMsg" + resultMsg);
					
					cudlData.setString("sendStat", resultMsg.getString("returnType"));
					cudlData.setString("sendMsg", resultMsg.getString("returnText"));
					cudlData.setString("sapIvDoNo", resultMsg.getString("returnIvDocNo"));
					cudlData.setString("sapGrDoNo", resultMsg.getString("returnGrDocNo"));
					
					dao.add ("/po/ir/InvoiceRegSql/cudInvoiceAfterSapSuccess", cudlData ); 
					dao.executeUpdate();
					
					if (resultMsg.getString("returnType").equals("03")) {            // 전체 성공 
						dao.commit();
						dao2.commit();             // 입고 수량 변경
					} else{
						dao.rollback();
						dao2.rollback();
					}
				}	
			
	            if(!("03").equals(resultMsg.getString("returnType"))){  // GR, IV 둘다 성공이 아닐경우 에러 
	            	getErrorCode = resultMsg.getString("returnType");
	            	getMessage = resultMsg.getString("returnText");
	            	
	            }else{     // 03 -> GR, IV 둘다 성공
	            	getMessage = "OK";
	            }
            
		} catch (Exception se) {
			dao.rollback();
			dao2.rollback();
			LLog.err.println(  this.getClass().getName() + "." + "cudInvoice()" + "=>" + se.getMessage());
			//throw new LSysException("pbf.err.com.save", se);
			getErrorCode = "-1403";
			getMessage = se.getMessage();
			throw new LSysException(getMessage,se);
        }
		
		result.put("getErrorCode"	,getErrorCode);
		result.put("getMessage"	,getMessage);
		
		return result;
	}

	/*
	 * 입고 취소 및 SAP 전송  Cancel
	 * 
	 */
	
	public LData cudInvoiceCancel(LMultiData mDataMst, LMultiData mDataDtl, LMultiData mDataTax, LData inputData) throws LException {
        LCompoundDao dao = new LCompoundDao();
        LCompoundDao dao2 = new LCompoundDao();        // SAP 성공시에만 입고 수량을 업데이트 하기위해 DAO를 따로 생성 
        
        LData result = new LData();
        
        LMultiData mDtlXi = new LMultiData();
        LMultiData mTaxXi = new LMultiData();
        
		String	getErrorCode = "0" ;
		String	getMessage	 = "Failed"; 	

		LData resultMsg		    = new LData();
		
		GMM07 gmm07 = new GMM07();
		DecimalFormat format = new DecimalFormat("0.####");
        try{			
        	dao.startTransaction();
        	dao2.startTransaction();

	        // Master CUD
			for(int i=0;i<mDataMst.getDataCount();i++) {
				
				LData cudlData = mDataMst.getLData(i);
				
				LData plantCd = dao.executeQueryForSingle("cm/cm/commCodeMgntSql/retrievePlant", inputData);
				LData xmlNo = dao.executeQueryForSingle("cm/cm/commCodeMgntSql/retireveXmlDocNo", inputData);
				
				cudlData.setString("plant",    plantCd.getString("plantCd"));
				cudlData.setString("zxmldocno", xmlNo.getString("zxmldocno")); //xmldocno
				cudlData.setString("storLoct",    "001B");
				cudlData.setString("sapPoNo",    cudlData.getString("sapIvDoNo"));
				
				cudlData.setString("ivAmt",    format.format(cudlData.getDouble("ivAmt")));
				cudlData.setString("vatAmt",    format.format(cudlData.getDouble("vatAmt")));
				cudlData.setString("postDate",    cudlData.getString("cancelPostDate"));
				LLog.info.println("postDate: " + cudlData.getString("postDate"));
				
		        // Detail CUD
				for(int j=mDataDtl.getDataCount()-1 ;j>=0;j--) {
					LData cudlDataDtl = mDataDtl.getLData(j);
					cudlDataDtl.setString("companyCd", inputData.getString("companyCd"));
					cudlDataDtl.setString("userId",    inputData.getString("userId"));
					cudlDataDtl.setString("poSeq",    cudlDataDtl.getString("itemSeq"));
					cudlDataDtl.setString("receiptQty",    cudlDataDtl.getString("ivQty"));
					cudlDataDtl.setString("amount",    cudlDataDtl.getString("amt"));
					cudlDataDtl.setString("attr1",    cudlDataDtl.getString("tranTaxAmt"));

					mDtlXi.addLData(cudlDataDtl);
					
		            // PO Detail 입고 수량 변경 (취소) 
		            dao2.add ("/po/ir/InvoiceRegSql/cancelPoRecQty", cudlDataDtl);    
		            dao2.executeUpdate();
		            
				}
		        // Tax CUD
				for(int j=mDataTax.getDataCount()-1 ;j>=0;j--) {
					LData cudlDataTax = mDataTax.getLData(j);

					cudlDataTax.setString("code",    cudlDataTax.getString("wtType"));
					cudlDataTax.setString("taxCode",    cudlDataTax.getString("wtCd"));
					cudlDataTax.setString("rate",    cudlDataTax.getString("wtRate"));
					cudlDataTax.setString("baseAmt",    format.format(cudlDataTax.getDouble("wtBaseAmt")));
					cudlDataTax.setString("taxAmt",    format.format(cudlDataTax.getDouble("wtTaxAmt")));
					
					mTaxXi.addLData(cudlDataTax);
					
				}
				
			    cudlData.setString("status", "04");  			// 04 : SAP 취소 전송 
			    cudlData.setString("cancelNo", "X");  			// X : 취소 요청  
				resultMsg = gmm07.GMM07_out(cudlData, mDtlXi, mTaxXi);
				
				LLog.info.println("resultMsg" + resultMsg);
				
				cudlData.setString("sendStat", resultMsg.getString("returnType"));
				cudlData.setString("sendMsg", resultMsg.getString("returnText"));
				cudlData.setString("sapIvDoNo", resultMsg.getString("returnIvDocNo"));
				cudlData.setString("sapGrDoNo", resultMsg.getString("returnGrDocNo"));

				
				if (resultMsg.getString("returnType").equals("99")){
					LLog.info.println("fail");
					cudlData.setString("sendStat", "03");                  // 취소 실패시 I/V성공 상태로 변경함
				}
				
				LLog.info.println("returnType: " + resultMsg.getString("returnType"));
				dao.add ("/po/ir/InvoiceRegSql/cudInvoiceAfterSapCancelSuccess", cudlData ); 
				dao.executeUpdate();
				
				if (resultMsg.getString("returnType").equals("06")) {            // 전체 성공 
					//취소 성공시 update
					LLog.info.println("all success");
					cudlData.setString("stat", "N");
					dao.add ("/po/ir/InvoiceRegSql/cudIvClose", cudlData ); 
					dao.executeUpdate();
					
					dao2.commit();             // 입고 수량 변경
					dao.commit(); 
				} else{
					dao2.rollback();
					dao.rollback();
				}
			}	
	            
	        if(!("06").equals(resultMsg.getString("returnType"))){  // GR, IV 둘다 성공이 아닐경우 에러 
	        	getErrorCode = resultMsg.getString("returnType");
	        	getMessage = resultMsg.getString("returnText");
	        	
	        }else{     // 06 -> GR, IV 둘다 취소 성공
	        	getMessage = "OK";
	        }			
				
		} catch (Exception se) {
			dao.rollback();
			dao2.rollback();
			LLog.err.println(  this.getClass().getName() + "." + "cudInvoiceCancel()" + "=>" + se.getMessage());
			//throw new LSysException("pbf.err.com.save", se);
			getErrorCode = "-1403";
			getMessage = se.getMessage();
			throw new LSysException(getMessage,se);
        }
		
		result.put("getErrorCode"	,getErrorCode);
		result.put("getMessage"	,getMessage);
		
		return result;
	}

	
	/*
	 * 입고 전송 및  취소 실패시 재전송 
	 * 
	 */
	
	public LData cudInvoiceRetry(LMultiData mDataMst, LMultiData mDataDtl, LMultiData mDataTax, LData inputData) throws LException {
        LCompoundDao dao = new LCompoundDao();
        LCompoundDao dao2 = new LCompoundDao();        // SAP 성공시에만 입고 수량을 업데이트 하기위해 DAO를 따로 생성 
        
        LData result = new LData();
        LMultiData mDtlXi = new LMultiData();
        LMultiData mTaxXi = new LMultiData();
        
		String	getErrorCode = "0" ;
		String	getMessage	 = "Failed"; 	

		LData resultMsg		    = new LData();
		
		GMM07 gmm07 = new GMM07();
		
        try{			
        	dao.startTransaction();
        	dao2.startTransaction();

	        // Master CUD
			for(int i=0;i<mDataMst.getDataCount();i++) {
				
				LData cudlData = mDataMst.getLData(i);
				
				LData plantCd = dao.executeQueryForSingle("cm/cm/commCodeMgntSql/retrievePlant", inputData);
				LData xmlNo = dao.executeQueryForSingle("cm/cm/commCodeMgntSql/retireveXmlDocNo", inputData);
				
				cudlData.setString("plant",    plantCd.getString("plantCd"));
				cudlData.setString("zxmldocno", xmlNo.getString("zxmldocno")); //xmldocno
				cudlData.setString("storLoct",    "001B");
				
		        // Detail CUD
				for(int j=mDataDtl.getDataCount()-1 ;j>=0;j--) {
					LData cudlDataDtl = mDataDtl.getLData(j);
					cudlDataDtl.setString("companyCd",   inputData.getString("companyCd"));
					cudlDataDtl.setString("userId",    		inputData.getString("userId"));
					cudlDataDtl.setString("poSeq",    		cudlDataDtl.getString("itemSeq"));
					cudlDataDtl.setString("receiptQty",     cudlDataDtl.getString("ivQty"));
					cudlDataDtl.setString("amount",    		cudlDataDtl.getString("amt"));
					mDtlXi.addLData(cudlDataDtl);
					
				}
		        // Tax CUD
				for(int j=mDataTax.getDataCount()-1 ;j>=0;j--) {
					LData cudlDataTax = mDataTax.getLData(j);

					cudlDataTax.setString("code",          cudlDataTax.getString("wtType"));
					cudlDataTax.setString("taxCode",      cudlDataTax.getString("wtCd"));
					cudlDataTax.setString("rate",    	 	cudlDataTax.getString("wtRate"));
					cudlDataTax.setString("baseAmt",       cudlDataTax.getString("wtBaseAmt"));
					cudlDataTax.setString("taxAmt",   		 cudlDataTax.getString("wtTaxAmt"));
					
					mTaxXi.addLData(cudlDataTax);
					
				}
				
				// 재시도 Type이 cancel이면 취소 관련 세팅함,,   cancel이 아니면  전송으로 세팅
				if(inputData.getString("retryType").equals("cancel")){
					cudlData.setString("sapPoNo",    cudlData.getString("sapIvDoNo"));
					cudlData.setString("status", "04");  			// 04 : SAP 취소 전송 
				    cudlData.setString("cancelNo", "X");  			// X : 취소 요청
				}else{
					cudlData.setString("status", "01");  			// 01 : SAP 전송 
					
				}
				
				resultMsg = gmm07.GMM07_out(cudlData, mDtlXi, mTaxXi);
				
				LLog.info.println("resultMsg" + resultMsg);
				
				cudlData.setString("sendStat", resultMsg.getString("returnType"));
				cudlData.setString("sendMsg", resultMsg.getString("returnText"));
				cudlData.setString("sapIvDoNo", resultMsg.getString("returnIvDocNo"));
				cudlData.setString("sapGrDoNo", resultMsg.getString("returnGrDocNo"));
				
				dao.add ("/po/ir/InvoiceRegSql/cudInvoiceAfterSapCancelSuccess", cudlData ); 
				dao.executeUpdate();
				
				if (resultMsg.getString("returnType").equals("06")) {            // 전체 성공 
					for(int j=mDataDtl.getDataCount()-1 ;j>=0;j--) {
						LData cudlDataDtl = mDataDtl.getLData(j);
						
			            // PO Detail 입고 수량 변경 (취소) 
			            dao2.add ("/po/ir/InvoiceRegSql/cancelPoRecQty", cudlDataDtl);    
			            dao2.executeUpdate();
					}					
					dao2.commit();             // 입고 수량 변경
					
				} else if (resultMsg.getString("returnType").equals("03")) {            // 전체 성공 
					for(int j=mDataDtl.getDataCount()-1 ;j>=0;j--) {
						LData cudlDataDtl = mDataDtl.getLData(j);
						
						if( "DEVON_UPDATE_FILTER_VALUE".equals(cudlDataDtl.getString( "DEVON_CUD_FILTER_KEY")) ) {
				            // PO Detail 입고 수량 변경 (확정) 
							cudlDataDtl.setString("poSeq",    inputData.getString("itemSeq"));
							cudlDataDtl.setString("receiptQty",    inputData.getString("ivQty"));
							cudlDataDtl.setString("amount",    inputData.getString("amt"));
				            
				            dao2.add ("/po/ir/InvoiceRegSql/updatePoRecQty", cudlDataDtl);    
				            dao2.executeUpdate();
						}
					}					
					dao2.commit();             // 입고 수량 변경
					
				} else {
					dao2.rollback();
				}
			}	
			
			dao.commit(); 
            
            if(!("06").equals(resultMsg.getString("returnType"))){  // GR, IV 둘다 성공이 아닐경우 에러 
            	getErrorCode = resultMsg.getString("returnType");
            	getMessage = resultMsg.getString("returnText");
            	
            }else{     // 06 -> GR, IV 둘다 취소 성공
            	getMessage = "OK";
            }					
				
		} catch (Exception se) {
			dao.rollback();
			dao2.rollback();
			LLog.err.println(  this.getClass().getName() + "." + "cudInvoiceCancel()" + "=>" + se.getMessage());
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