/*
 *------------------------------------------------------------------------------
 * PaymentBiz.java 
 * 
 * PROJ : PT-PAM
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2015/12/07   hckim   Init
 *----------------------------------------------------------------------------
 */

package fi.tr.biz;

import java.util.Vector;
import xi.GFI06;
import xi.GFI07;
import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LException;
import devon.core.exception.LSysException;
import devon.core.log.LLog;
import devonframework.persistent.autodao.LCommonDao;
import devonframework.persistent.autodao.LCompoundDao;

/**
 * <PRE>
 * Payment Request 업무를 처리하는 Biz 클래스.
 *
 * Database Tables : 
 * </PRE>
 * @author    hckim
 */
public class PaymentBiz {
 
    
    /**
     * Payment Request 화면 - Open AP List 정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveOpenApList(LData inputData) throws LException {	
		
		LLog.info.write("PaymentBiz.retrieveOpenApList ------------- Start ");
         
		String getMessage		= "";  
		LData resultMsg		    = new LData();  
		LMultiData resultDtlMsg = new LMultiData();
		
		try{
 
			GFI06 gfi06 = new GFI06();
			Vector oResultMsg = gfi06.GFI06_out(inputData);
 
			resultMsg =(LData) oResultMsg.get(0);			
			resultDtlMsg =(LMultiData) oResultMsg.get(1);						
			
			LLog.info.write("resultMsg:"+resultMsg);
			LLog.info.write("resultDtlMsg:"+resultDtlMsg);
			
			if(resultMsg.size()!=0){
				if (resultMsg.getString("returnType").equals("0")) {
					getMessage = resultMsg.getString("returnText");
					LLog.err.println(  this.getClass().getName() + "." + "retrieveOpenApList1-returnType::" +resultMsg.getString("returnType")+"=>\n" + getMessage);			
				} else {  
					getMessage = resultMsg.getString("returnText");
					LLog.err.println(  this.getClass().getName() + "." + "retrieveOpenApList2-returnType:: "+resultMsg.getString("returnType")+"=>\n" + getMessage);					 
				}
			}else{
				LLog.err.println(  this.getClass().getName() + "." + "retrieveOpenApList No Return Date");
			}
			 
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveOpenApList Exceiption------()" + "=>" + se.getMessage());
			throw new LSysException("fi.tr.biz.retrieveOpenApList Exceiption", se); 
		} 
		
		return resultDtlMsg;						
		
    }
    
    /**
     * Payment Request (Open AP List 정보, Payment Information 정보) 정보 저장, SAP 상태코드 값 변경을 위해 SAP 호출
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LData cudPaymentRequest(LMultiData mData, LData inputData) throws LException {
		
    	LLog.info.write("\n PaymentBiz > cudPaymentRequest() ------------- Start \n");
    	
        LCompoundDao dao = new LCompoundDao();
        LData result     = new LData();
        
        String getErrorCode = "0" ;
		String getMessage	= "Failed";
		LData requestNo = null;
		LMultiData mDtlXi = new LMultiData(); // SAP 보내는 정보
		LData mstInputData = new LData();     // 출금요청 마스터 등록 정보
		LData resultMsg	= new LData();        // SAP 결과 메시지 정보
		int totalAmount = 0;                  // 총금액 (Foreign)
		int exchTotalAmount = 0;              // 총금액 (Local)
		
		try{
									
			dao.startTransaction();
			
			requestNo = dao.executeQueryForSingle("/fi/tr/paymentSql/retrievePaymentRequestNo", inputData);				
			
			for(int i=0;i<mData.getDataCount();i++){
			
				LData cudlData = mData.getLData(i);
				
				cudlData.setString("baselineDate", inputData.getString("baselineDate"));        // Due Date
				cudlData.setString("paymentMethod", inputData.getString("paymentMethod"));      // Payment Method
				cudlData.setString("partnerBankType", inputData.getString("partnerBankType"));  // Partner Bank Type
				cudlData.setString("houseBank", inputData.getString("houseBank"));              // House Bank
				
				if("GA00".equals(inputData.getString("companyCd"))){
					cudlData.setString("paymentBlock", "B");                                        // Payment block (AP 전표의 출금요청상태 default = R, 요청=B , 승인 =D , 요청자 삭제시 = R , 반려 = C)
	
				}else{
					cudlData.setString("paymentBlock", "");                                        // GAM 법인은 승인완료 = ""
				
				}
				
				cudlData.setString("requestNo", requestNo.getString("requestNo"));              // Request No
				cudlData.setString("companyCd", inputData.getString("companyCd"));              // 법인코드
				cudlData.setString("userId", inputData.getString("userId"));                    // 등록자ID
				
				// 출금요청(mData) DATA - Request No, inputData 정보 담기		        		                                               
				mDtlXi.addLData(cudlData);
				
				// 총금액(Foreign) 계산
				totalAmount += cudlData.getInt("amount");
				
				// 총금액(Local) 계산
				exchTotalAmount += cudlData.getInt("exchAmount");
				
				// 출금요청 마스터 저장 정보 셋팅
				if(i == 0){
					mstInputData.setString("companyCd", inputData.getString("companyCd"));             // 법인코드					
					mstInputData.setString("requestNo", requestNo.getString("requestNo"));             // 요청번호
					mstInputData.setString("sapRequestNo", cudlData.getString("sapRequestNo"));        // SAP 출금요청번호					
					mstInputData.setString("vendCd", cudlData.getString("vendCd"));                    // 고객사
					mstInputData.setString("paymentMethod", inputData.getString("paymentMethod"));     // 출금방법 (화면입력)					
					mstInputData.setString("partnerBankType", inputData.getString("partnerBankType")); // 파트너 뱅크 타입 (화면입력)
					mstInputData.setString("houseBank", inputData.getString("houseBank"));             // 하우스뱅크
					mstInputData.setString("houseBankAcct", inputData.getString("houseBankAcct"));     // 하우스뱅크 계좌번호
					mstInputData.setString("baselineDate", inputData.getString("baselineDate"));       // 출금일 (화면입력)
					mstInputData.setString("currCd", cudlData.getString("currCd"));                    // 통화코드					
					mstInputData.setString("delYn", "N");                                              // 삭제유무
					mstInputData.setString("sapStatus", cudlData.getString("sapStatus"));              // SAP STATUS
					mstInputData.setString("exchCurrCd", cudlData.getString("exchCurrCd"));            // Local 통화코드
				}
			}
			
			LLog.info.write("SAP 호출 (mDtlXi) ---------------> =>\n " + mDtlXi.toString());
									
			// SAP - Open AP List (Payment block, Due Date, Payment Method, Partner Bank Type 정보 변경하고 결과 메시지 보내줌)
			GFI07 gfi07 = new GFI07();
			resultMsg = gfi07.GFI07_out(mDtlXi);
			
			String paymentType = "";
			
			// Payment Type 값 설정
			if(mstInputData.getString("currCd").equals(mstInputData.getString("exchCurrCd"))){
				paymentType = "Local";
			}else{
				paymentType = "Foreign";
			}
			
			// 출금요청 마스터 저장 정보 셋팅 (총금액, SAP RETURN MESSAGE, 등록자ID)
			mstInputData.setString("totalAmount", Integer.toString(totalAmount));          // 총금액 (Foreign)
			mstInputData.setString("exchTotalAmount", Integer.toString(exchTotalAmount));  // 총금액 (Local)
			mstInputData.setString("sapRtnMsg", resultMsg.getString("sapRtnMsg"));         // SAP에서 넘어온값 셋팅
			mstInputData.setString("userId", inputData.getString("userId"));               // 등록자ID
			mstInputData.setString("paymentType", paymentType);
			
			// SAP 전송 Error 발생시
			if("E".equals(resultMsg.getString("sapStatus"))){
				mstInputData.setString("status", "F");  // WEB에서 관리하는 요청상태 (I : Insert , B : Request , D : Confirm, C: Reject, F: Fail)
			
			// 정상처리
			}else{
				mstInputData.setString("status", "I");  // WEB에서 관리하는 요청상태 (I : Insert , B : Request , D : Confirm, C: Reject, F: Fail)
			}
															
			dao.add("/fi/tr/paymentSql/insertMstPaymentRequest", mstInputData);
			dao.executeUpdate();
			
			LLog.info.write("==================  출금요청 마스터 정보 저장 PARAM  =====================");
			LLog.info.write("companyCd:" + mstInputData.getString("companyCd"));
			LLog.info.write("requestNo:" + mstInputData.getString("requestNo"));
			LLog.info.write("sapRequestNo:" + mstInputData.getString("sapRequestNo"));           
			LLog.info.write("vendCd:" + mstInputData.getString("vendCd"));
			LLog.info.write("paymentMethod:" + mstInputData.getString("paymentMethod"));
			LLog.info.write("partnerBankType:" + mstInputData.getString("partnerBankType"));
			LLog.info.write("houseBank:" + mstInputData.getString("houseBank"));
			LLog.info.write("houseBankAcct:" + mstInputData.getString("houseBankAcct"));
			LLog.info.write("baselineDate:" + mstInputData.getString("baselineDate"));
			LLog.info.write("currCd:" + mstInputData.getString("currCd"));
			LLog.info.write("status:" + mstInputData.getString("status"));
			LLog.info.write("delYn:" + mstInputData.getString("delYn"));
			LLog.info.write("sapStatus:" + mstInputData.getString("sapStatus"));                       
			LLog.info.write("totalAmount:" + mstInputData.getString("totalAmount"));
			LLog.info.write("sapRtnMsg:" + mstInputData.getString("sapRtnMsg"));
			LLog.info.write("userId:" + mstInputData.getString("userId"));
			LLog.info.write("exchTotalAmount:" + mstInputData.getString("exchTotalAmount"));
			LLog.info.write("exchCurrCd:" + mstInputData.getString("exchCurrCd"));
			LLog.info.write("paymentType:" + mstInputData.getString("paymentType"));
			LLog.info.write("==========================================================================");
										
			for(int i=0;i<mDtlXi.getDataCount();i++) {
				
				LData cudlData = mDtlXi.getLData(i);																						
	            
				// 출금요청 상세 정보 저장
				dao.add ("/fi/tr/paymentSql/insertDtlPaymentRequest", cudlData);				
				dao.executeUpdate();      
	            
				LLog.info.write("==================  출금요청 상세 정보 저장 PARAM ["+i+"] ====================");
				LLog.info.write("companyCd:" + cudlData.getString("companyCd"));
				LLog.info.write("requestNo:" + cudlData.getString("requestNo"));						
				LLog.info.write("vendCd:" + cudlData.getString("vendCd"));
				LLog.info.write("vendNm:" + cudlData.getString("vendNm"));
				LLog.info.write("docNo:" + cudlData.getString("docNo"));					
				LLog.info.write("fiscalYear:" + cudlData.getString("fiscalYear"));           					
				LLog.info.write("lineItem:" + cudlData.getString("lineItem"));
				LLog.info.write("amount:" + cudlData.getString("amount"));
				LLog.info.write("currCd:" + cudlData.getString("currCd"));					
				LLog.info.write("exchAmount:" + cudlData.getString("exchAmount"));           
				LLog.info.write("exchCurrCd:" + cudlData.getString("exchCurrCd"));           
				LLog.info.write("docDesc:" + cudlData.getString("docDesc"));                 
				LLog.info.write("postDate:" + cudlData.getString("postDate"));
				LLog.info.write("docDate:" + cudlData.getString("docDate"));                 
				LLog.info.write("docType:" + cudlData.getString("docType"));                 
				LLog.info.write("acctCd:" + cudlData.getString("acctCd"));
				LLog.info.write("acctNm:" + cudlData.getString("acctNm"));
				LLog.info.write("baselineDate:" + cudlData.getString("baselineDate"));
				LLog.info.write("paymentMethod:" + cudlData.getString("paymentMethod"));
				LLog.info.write("paymentBlock:" + cudlData.getString("paymentBlock"));       
				LLog.info.write("houseBank:" + cudlData.getString("houseBank"));             
				LLog.info.write("partnerBankType:" + cudlData.getString("partnerBankType")); 
				LLog.info.write("personalId:" + cudlData.getString("personalId"));           
				LLog.info.write("exchRate:" + cudlData.getString("exchRate"));
				LLog.info.write("attr01:" + cudlData.getString("attr01"));
				LLog.info.write("attr02:" + cudlData.getString("attr02"));
				LLog.info.write("attr03:" + cudlData.getString("attr03"));
				LLog.info.write("attr04:" + cudlData.getString("attr04"));
				LLog.info.write("attr05:" + cudlData.getString("attr05"));
				LLog.info.write("attr06:" + cudlData.getString("attr06"));
				LLog.info.write("attr07:" + cudlData.getString("attr07"));
				LLog.info.write("attr08:" + cudlData.getString("attr08"));
				LLog.info.write("attr09:" + cudlData.getString("attr09"));
				LLog.info.write("attr10:" + cudlData.getString("attr10"));
				LLog.info.write("==========================================================================");							            									          
			}
			
			LLog.info.write("\n PaymentBiz > cudPaymentRequest() ------------- End \n");
									
			// SAP 전송 Error 발생시
			if("E".equals(resultMsg.getString("sapStatus"))){
				
				getMessage = resultMsg.getString("sapRtnMsg");
				getErrorCode = "1000"; // SAP 전송 에러
			
			// 정상 처리	
			}else{
				
				getMessage = "Ok";
			}
			
			dao.commit();	
			
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "cudPaymentRequest()" + "=>" + se.getMessage());			
			dao.rollback();
			getErrorCode = "-1403";
			getMessage = se.getMessage();
			
			// DB 저장 Error 발생
			// SAP - Open AP List 정보 원복	Start  		
			LMultiData mDtlXiInit = new LMultiData();
			
			// SAP - Open AP List (원본데이타)
			for(int i=0;i<mData.getDataCount();i++){
				
				LData cudlData = mData.getLData(i);								
				
				cudlData.setString("paymentBlock", "R");                            // Payment block (AP 전표의 출금요청상태 default = R, 요청=B , 승인 =D , 요청자 삭제시 = R , 반려 = C)
				cudlData.setString("requestNo", "");                                // Request No
				cudlData.setString("companyCd", inputData.getString("companyCd"));  // 법인코드
				
				mDtlXiInit.addLData(cudlData);
			}
			
			GFI07 gfi07 = new GFI07();
			resultMsg = gfi07.GFI07_out(mDtlXiInit);
			// SAP - Open AP List 정보 원복	End  
        }
		
		result.put("getErrorCode", getErrorCode);
		result.put("getMessage", getMessage);
		
		return result;
    }
    
    /**
     * Payment Request List 화면 - Request List 정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveRequestList(LData inputData) throws LException {    	
    	
    	LLog.debug.write("PaymentBiz.retrieveRequestList -----------> Start ");
    	
    	LCommonDao dao = new LCommonDao();
		try{			
			return dao.executeQuery("fi/tr/paymentSql/retrieveRequestList", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveRequestList------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		}
    }
    
    /**
     * Payment Request List 화면 - Payment AP Invoice List 정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrievePaymentApInvoiceList(LData inputData) throws LException {    	
    	
    	LLog.debug.write("PaymentBiz.retrievePaymentApInvoiceList -----------> Start ");
    	
    	LCommonDao dao = new LCommonDao();
		try{			
			return dao.executeQuery("fi/tr/paymentSql/retrievePaymentApInvoiceList", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrievePaymentApInvoiceList------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		}
    }
    
    /**
     * Payment Request List - Status 정보 변경 (I(Insert) --> B(Request))
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LData cudPaymentRequestStatus(LMultiData mData, LData inputData) throws LException {
		
    	LLog.info.write("\n PaymentBiz > cudPaymentRequestStatus() ------------- Start \n");
    	
        LCompoundDao dao = new LCompoundDao();
        LData result     = new LData();
        
        String getErrorCode = "0" ;
		String getMessage	= "Failed";
		
		try{
									
			dao.startTransaction();																		
										
			for(int i=0;i<mData.getDataCount();i++) {
				
				LData cudlData = mData.getLData(i);																						
	            
				cudlData.setString("userId", inputData.getString("userId")); // 수정자ID
				cudlData.setString("status", "B");                           // WEB에서 관리하는 요청상태 (I : Insert , B : Request , D : Confirm C: Reject)
				
				// 출금요청 마스터 상세 정보 변경
				dao.add ("/fi/tr/paymentSql/updatePaymentRequestStatus", cudlData);				
				dao.executeUpdate();      
	            
				LLog.info.write("==================  Payment Request List - Status 변경 PARAM ["+i+"] ====================");
				LLog.info.write("companyCd:" + cudlData.getString("companyCd"));
				LLog.info.write("requestNo:" + cudlData.getString("requestNo"));
				LLog.info.write("status   :" + cudlData.getString("status"));
				LLog.info.write("userId   :" + cudlData.getString("userId"));
				LLog.info.write("==========================================================================================");							            									          
			}
			
			getMessage = "Ok";
			
			dao.commit();	
			
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "cudPaymentRequestStatus()" + "=>" + se.getMessage());			
			dao.rollback();
			getErrorCode = "-1403";
			getMessage = se.getMessage();						  
        }
		
		result.put("getErrorCode", getErrorCode);
		result.put("getMessage", getMessage);
		
		return result;
    }
    
    /**
     * Payment Request List 정보 삭제, SAP AP전표 상태를 R로 변경 (SAP 호출)
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LData cudPaymentRequestDelete(LMultiData mData, LData inputData) throws LException {
		
    	LLog.info.write("\n PaymentBiz > cudPaymentRequestDelete() ------------- Start \n");
    	
        LCompoundDao dao  = new LCompoundDao();
        LData result      = new LData();
        LMultiData mDtl   = new LMultiData(); // Payment Request 상세 정보        
        LData resultMsg	  = new LData();      // SAP 결과 메시지 정보
        
        String getErrorCode = "0" ;
		String getMessage	= "Failed";
		
		try{
									
			dao.startTransaction();																		
										
			for(int i=0;i<mData.getDataCount();i++) {
				
				LData cudlData = mData.getLData(i);																						
	            				
				cudlData.setString("userId", inputData.getString("userId")); // 수정자ID	
				cudlData.setString("delYn", "Y");                            // 삭제유무 (Y:Yes, N:No)
				
				// 출금요청 마스터 정보 삭제
				dao.add ("/fi/tr/paymentSql/updatePaymentRequestDelete", cudlData);				
				dao.executeUpdate();      	            												
				
				// 출금요청 상세 정보 조회
				mDtl = dao.executeQuery("fi/tr/paymentSql/retrievePaymentApInvoiceList", cudlData);
				
				LMultiData mDtlXi = new LMultiData(); // SAP 보내는 정보
				
				for(int k=0;k<mDtl.getDataCount();k++) {
					LData dtllData = mDtl.getLData(k);
					
					dtllData.setString("paymentBlock", "R");                           // Payment block (AP 전표의 출금요청상태 default = R, 요청=B , 승인 =D , 요청자 삭제시 = R , 반려 = C)					
					dtllData.setString("paymentMethod", "");                           // Payment Method
					dtllData.setString("partnerBankType", "");                         // Partner Bank Type
					dtllData.setString("houseBank", "");                               // House Bank
					dtllData.setString("companyCd", inputData.getString("companyCd")); // Company Code
					
					// SAP AP전표 상태 변경을 위한 정보 담기		        		                                               
					mDtlXi.addLData(dtllData);
															
				}
				
				// SAP 호출 (AP 전표 상태 변경)
				GFI07 gfi07 = new GFI07();
				resultMsg = gfi07.GFI07_out(mDtlXi);
				
				LLog.info.write("==================  Payment Request List 정보 삭제 PARAM ["+i+"] ====================");
				LLog.info.write("companyCd:" + cudlData.getString("companyCd"));
				LLog.info.write("requestNo:" + cudlData.getString("requestNo"));
				LLog.info.write("userId   :" + cudlData.getString("userId"));
				LLog.info.write("delYn    :" + cudlData.getString("delYn"));
				LLog.info.write("출금요청 상세 정보 ---------------> =>\n " + mDtl.toString());
				LLog.info.write("SAP 호출 (AP 전표 상태 변경) 정보 ---------------> =>\n " + mDtlXi.toString());
				LLog.info.write("=====================================================================================");		
				
				// SAP 전송 Error 발생시
				if("E".equals(resultMsg.getString("sapStatus"))){
					
					getMessage = "Request No (" + resultMsg.getString("requestNo") + ") :" + resultMsg.getString("sapRtnMsg");
					getErrorCode = "1000"; // SAP 전송 에러
					
					dao.rollback();
					
					break;
				
				// 정상 처리	
				}else{
					
					getMessage = "Ok";
					
					dao.commit();
				}
			}																			
			
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "cudPaymentRequestDelete()" + "=>" + se.getMessage());			
			dao.rollback();
			getErrorCode = "-1403";
			getMessage = se.getMessage();		
			
			// DB 저장 Error 발생
			// SAP - Open AP List 정보 원복	Start
			for(int i=0;i<mData.getDataCount();i++) {
				
				LData cudlData = mData.getLData(i);																						
	            
				// 출금요청 상세 정보 조회
				mDtl = dao.executeQuery("fi/tr/paymentSql/retrievePaymentApInvoiceList", inputData);
				
				LMultiData mDtlXi = new LMultiData(); // SAP 보내는 정보
				
				for(int k=0;k<mDtl.getDataCount();k++) {
					LData dtllData = mDtl.getLData(k);
					
					dtllData.setString("paymentBlock", "B"); // Payment block (AP 전표의 출금요청상태 default = R, 요청=B , 승인 =D , 요청자 삭제시 = R , 반려 = C)
					dtllData.setString("companyCd", inputData.getString("companyCd")); // Company Code
					
					// SAP AP전표 상태 변경을 위한 정보 담기		        		                                               
					mDtlXi.addLData(dtllData);										
					
				}
				
				// SAP 호출 (AP 전표 상태 변경)
				GFI07 gfi07 = new GFI07();
				resultMsg = gfi07.GFI07_out(mDtlXi);
				
				LLog.info.write("==================  Payment Request List 정보 삭제 Error 시 SAP 전송 PARAM ["+i+"] ====================");
				LLog.info.write("companyCd:" + cudlData.getString("companyCd"));
				LLog.info.write("requestNo:" + cudlData.getString("requestNo"));	
				LLog.info.write("출금요청 상세 정보 ---------------> =>\n " + mDtl.toString());
				LLog.info.write("SAP 호출 (AP 전표 상태 변경) 정보 ---------------> =>\n " + mDtlXi.toString());
				LLog.info.write("=======================================================================================================");							            									          
			}
			// SAP - Open AP List 정보 원복	End
        }
		
		result.put("getErrorCode", getErrorCode);
		result.put("getMessage", getMessage);
		
		return result;
    }
    
    /**
     * Payment Request Confirm 화면 - Request List 정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveConfirmRequestList(LData inputData) throws LException {    	
    	
    	LLog.debug.write("PaymentBiz.retrieveConfirmRequestList -----------> Start ");
    	
    	LCommonDao dao = new LCommonDao();
		try{			
			return dao.executeQuery("fi/tr/paymentSql/retrieveConfirmRequestList", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveConfirmRequestList------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		}
    }
    
    /**
     * Payment Request Confirm - Status 정보 변경 (B(Request) --> D(Confirm) )
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LData cudPaymentRequestConfirmStatus(LMultiData mData, LData inputData) throws LException {
		
    	LLog.info.write("\n PaymentBiz > cudPaymentRequestConfirmStatus() ------------- Start \n");
    	
        LCompoundDao dao = new LCompoundDao();
        LData result     = new LData();
        LMultiData mDtl  = new LMultiData(); // Payment Request 상세 정보        
        LData resultMsg	 = new LData();      // SAP 결과 메시지 정보
        
        String getErrorCode = "0" ;
		String getMessage	= "Failed";
		
		try{
									
			dao.startTransaction();																		
										
			for(int i=0;i<mData.getDataCount();i++) {
												
				LData cudlData = mData.getLData(i);								
	            
				// 출금요청 상세 정보 조회
				mDtl = dao.executeQuery("fi/tr/paymentSql/retrievePaymentApInvoiceList", cudlData);
				
				LMultiData mDtlXi = new LMultiData(); // SAP 보내는 정보
				
				for(int k=0;k<mDtl.getDataCount();k++) {
					LData dtllData = mDtl.getLData(k);
					
					dtllData.setString("paymentBlock", "D"); // Payment block (AP 전표의 출금요청상태 default = R, 요청=B , 승인 =D , 요청자 삭제시 = R , 반려 = C)
					
					// SAP AP전표 상태 변경을 위한 정보 담기		        		                                               
					mDtlXi.addLData(dtllData);
															
				}
				
				// SAP 호출 (AP 전표 상태 변경)
				GFI07 gfi07 = new GFI07();
				resultMsg = gfi07.GFI07_out(mDtlXi);																				
				
				cudlData.setString("userId", inputData.getString("userId")); // 수정자ID
				cudlData.setString("status", "D");                           // WEB에서 관리하는 요청상태 (I : Insert , B : Request , D : Confirm C: Reject)
				cudlData.setString("sapRequestNo", resultMsg.getString("sapRequestNo"));				
				
				// 출금요청 마스터 상세 정보 변경
				dao.add ("/fi/tr/paymentSql/updatePaymentRequestConfirmStatus", cudlData);				
				dao.executeUpdate();      
	            
				LLog.info.write("==================  Payment Request Confirm List - Status 변경 PARAM ["+i+"] ====================");
				LLog.info.write("companyCd    :" + cudlData.getString("companyCd"));
				LLog.info.write("requestNo    :" + cudlData.getString("requestNo"));
				LLog.info.write("status       :" + cudlData.getString("status"));
				LLog.info.write("sapRequestNo :" + cudlData.getString("sapRequestNo"));
				LLog.info.write("userId       :" + cudlData.getString("userId"));
				LLog.info.write("출금요청 상세 정보 ---------------> =>\n " + mDtl.toString());
				LLog.info.write("SAP 호출 (AP 전표 Confirm 정보 ) ---------------> =>\n " + mDtlXi.toString());
				LLog.info.write("=================================================================================================");
				
				// SAP 전송 Error 발생시
				if("E".equals(resultMsg.getString("sapStatus"))){
					
					getMessage = "Request No (" + resultMsg.getString("requestNo") + ") :" + resultMsg.getString("sapRtnMsg");
					getErrorCode = "1000"; // SAP 전송 에러
					
					dao.rollback();
					
					break;
				
				// 정상 처리	
				}else{
					
					getMessage = "Ok";
					
					dao.commit();
				}
			}
			
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "cudPaymentRequestConfirmStatus()" + "=>" + se.getMessage());			
			dao.rollback();
			getErrorCode = "-1403";
			getMessage = se.getMessage();	
			
			// DB 저장 Error 발생
			// SAP - Open AP List 정보 원복	Start
			for(int i=0;i<mData.getDataCount();i++) {
				
				LData cudlData = mData.getLData(i);																						
	            								
				// 출금요청 상세 정보 조회
				mDtl = dao.executeQuery("fi/tr/paymentSql/retrievePaymentApInvoiceList", cudlData);
				
				LMultiData mDtlXi = new LMultiData(); // SAP 보내는 정보
				
				for(int k=0;k<mDtl.getDataCount();k++) {
					LData dtllData = mDtl.getLData(k);
					
					dtllData.setString("paymentBlock", "B"); // Payment block (AP 전표의 출금요청상태 default = R, 요청=B , 승인 =D , 요청자 삭제시 = R , 반려 = C)
					
					// SAP AP전표 상태 변경을 위한 정보 담기		        		                                               
					mDtlXi.addLData(dtllData);															
				}
				
				// SAP 호출 (AP 전표 상태 변경)
				GFI07 gfi07 = new GFI07();
				resultMsg = gfi07.GFI07_out(mDtlXi);																				    
	            
				LLog.info.write("==================  Payment Request Confirm List - Status 변경 Error 시 SAP 전송 PARAM ["+i+"] ====================");
				LLog.info.write("companyCd    :" + cudlData.getString("companyCd"));
				LLog.info.write("requestNo    :" + cudlData.getString("requestNo"));;
				LLog.info.write("출금요청 상세 정보 ---------------> =>\n " + mDtl.toString());
				LLog.info.write("SAP 호출 (AP 전표 Confirm 정보 ) ---------------> =>\n " + mDtlXi.toString());
				LLog.info.write("===================================================================================================================");							            									          
			}
			// SAP - Open AP List 정보 원복	End
        }
		
		result.put("getErrorCode", getErrorCode);
		result.put("getMessage", getMessage);
		
		return result;
    }
    
    /**
     * Payment Request Reject - Status 정보 변경 (B(Request) --> C(Reject) )
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LData cudPaymentRequestReject(LMultiData mData, LData inputData) throws LException {
		
    	LLog.info.write("\n PaymentBiz > cudPaymentRequestReject() ------------- Start \n");
    	
        LCompoundDao dao = new LCompoundDao();
        LData result     = new LData();
        LMultiData mDtl  = new LMultiData(); // Payment Request 상세 정보        
        LData resultMsg	 = new LData();      // SAP 결과 메시지 정보
        
        String getErrorCode = "0" ;
		String getMessage	= "Failed";
		
		try{
									
			dao.startTransaction();																		
										
			for(int i=0;i<mData.getDataCount();i++) {
												
				LData cudlData = mData.getLData(i);								
	            
				cudlData.setString("userId", inputData.getString("userId")); // 수정자ID
				cudlData.setString("status", "C");                           // WEB에서 관리하는 요청상태 (I : Insert , B : Request , D : Confirm C: Reject)								
				
				// 출금요청 마스터 상세 정보 변경
				dao.add ("/fi/tr/paymentSql/updatePaymentRequestRejectStatus", cudlData);				
				dao.executeUpdate();      	            				
				
				// 출금요청 상세 정보 조회
				mDtl = dao.executeQuery("fi/tr/paymentSql/retrievePaymentApInvoiceList", cudlData);
				
				LMultiData mDtlXi = new LMultiData(); // SAP 보내는 정보
				
				for(int k=0;k<mDtl.getDataCount();k++) {
					LData dtllData = mDtl.getLData(k);
					
					dtllData.setString("paymentBlock", "C"); // Payment block (AP 전표의 출금요청상태 default = R, 요청=B , 승인 =D , 요청자 삭제시 = R , 반려 = C)
					
					// SAP AP전표 상태 변경을 위한 정보 담기		        		                                               
					mDtlXi.addLData(dtllData);
															
				}
				
				// SAP 호출 (AP 전표 상태 변경)
				GFI07 gfi07 = new GFI07();
				resultMsg = gfi07.GFI07_out(mDtlXi);																				
				
				LLog.info.write("==================  Payment Request Confirm List - Reject에 따른 Status 변경 PARAM ["+i+"] ====================");
				LLog.info.write("companyCd    :" + cudlData.getString("companyCd"));
				LLog.info.write("requestNo    :" + cudlData.getString("requestNo"));
				LLog.info.write("status       :" + cudlData.getString("status"));				
				LLog.info.write("userId       :" + cudlData.getString("userId"));
				LLog.info.write("출금요청 상세 정보 ---------------> =>\n " + mDtl.toString());
				LLog.info.write("SAP 호출 (AP 전표 Confirm 정보 ) ---------------> =>\n " + mDtlXi.toString());
				LLog.info.write("===============================================================================================================");	
				
				// SAP 전송 Error 발생시
				if("E".equals(resultMsg.getString("sapStatus"))){
					
					getMessage = "Request No (" + resultMsg.getString("requestNo") + ") :" + resultMsg.getString("sapRtnMsg");
					getErrorCode = "1000"; // SAP 전송 에러
					
					dao.rollback();
				
					break;
					
				// 정상 처리	
				}else{
					
					getMessage = "Ok";
					
					dao.commit();
				}
			}
																
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "cudPaymentRequestReject()" + "=>" + se.getMessage());			
			dao.rollback();
			getErrorCode = "-1403";
			getMessage = se.getMessage();	
			
			// DB 저장 Error 발생
			// SAP - Open AP List 정보 원복	Start
			for(int i=0;i<mData.getDataCount();i++) {
				
				LData cudlData = mData.getLData(i);																						
	            								
				// 출금요청 상세 정보 조회
				mDtl = dao.executeQuery("fi/tr/paymentSql/retrievePaymentApInvoiceList", cudlData);
				
				LMultiData mDtlXi = new LMultiData(); // SAP 보내는 정보
				
				for(int k=0;k<mDtl.getDataCount();k++) {
					LData dtllData = mDtl.getLData(k);
					
					dtllData.setString("paymentBlock", "B"); // Payment block (AP 전표의 출금요청상태 default = R, 요청=B , 승인 =D , 요청자 삭제시 = R , 반려 = C)
					
					// SAP AP전표 상태 변경을 위한 정보 담기		        		                                               
					mDtlXi.addLData(dtllData);															
				}
				
				// SAP 호출 (AP 전표 상태 변경)
				GFI07 gfi07 = new GFI07();
				resultMsg = gfi07.GFI07_out(mDtlXi);																				    
	            
				LLog.info.write("==================  Payment Request Confirm List - Reject에 따른 Status 변경 Error 시 SAP 전송 PARAM ["+i+"] ====================");
				LLog.info.write("companyCd    :" + cudlData.getString("companyCd"));
				LLog.info.write("requestNo    :" + cudlData.getString("requestNo"));;
				LLog.info.write("출금요청 상세 정보 ---------------> =>\n " + mDtl.toString());
				LLog.info.write("SAP 호출 (AP 전표 원복 정보 ) ---------------> =>\n " + mDtlXi.toString());
				LLog.info.write("=================================================================================================================================");							            									          
			}
			// SAP - Open AP List 정보 원복	End
        }
		
		result.put("getErrorCode", getErrorCode);
		result.put("getMessage", getMessage);
		
		return result;
    }
    
    /**
     * Payment Request List 화면 - Request List Print 정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveRequestListPrint(LData inputData, LMultiData mData) throws LException {    	
    	
    	LMultiData resultTot = new LMultiData();
    	LCommonDao dao = new LCommonDao();
    	
		try{	 
			
			LMultiData result = new LMultiData();						
			
			for(int i=0;i<mData.getDataCount();i++){								
				
				LData cudlData = mData.getLData(i);	
				cudlData.setString("lang", inputData.getString("lang"));												
				
				LLog.info.write("==================  Payment Request Print List 조회 PARAM ["+i+"] ====================");
				LLog.info.write("cudlData :" + cudlData);				
				LLog.info.write("======================================================================================");	
				
				result= dao.executeQuery("fi/tr/paymentSql/retrieveRequestListPrint", cudlData);
			 
				if(i==0){
					resultTot.setMetaData(result.getMetaData());
				} 
				
				resultTot.addLMultiData(result);			
			}
			 
			return resultTot;
    	
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveRequestListPrint------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		}
    }
}
