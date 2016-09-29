/*
 *-------------------------------------------------------------------------------------
 * CostTotLedgerValidationBiz.java,v 1.0 2010/07/23 16:43:35 
 * 
 * PROJ : PT-MGE System
 * Copyright 2006-2007 LG CNS All rights reserved
 *-------------------------------------------------------------------------------------
 *                  변         경         사         항
 *-------------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------------
 * 2010/10/11   mskim   Init
 * 2015/12/01   hckim   Internal Order 필드 추가에 따른 유효성 체크로직 추가 및 수정
 *-------------------------------------------------------------------------------------
 */

package fi.ar.biz;

import comm.util.DataUtil;
import comm.util.StringUtil;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LException;
import devon.core.exception.LSysException;
import devon.core.log.LLog;
import devonframework.persistent.autodao.LCommonDao;
import devonframework.persistent.autodao.LCompoundDao;

/**
 * <PRE>
 * Cost Total Ledger Validation 업무를 처리하는 Biz 클래스.
 *
 * Database Tables : 
 * </PRE>
 * @author    CEH
 */
public class CostTotLedgerValidationBiz {

    
    /**
     * Cost Total Ledger Master Validation 정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveCostTotLedgerMstValidation(LData inputData) throws LException {    	
    	
    	LLog.debug.write("CostTotLedgerValidationBiz.retrieveCostTotLedgerMstValidation -----------> Start ");
    	
    	LCommonDao dao = new LCommonDao();
		try{			
			return dao.executeQuery("fi/ar/costTotLedgerValidationSql/retrieveCostTotLedgerMstValidation", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveCostTotLedgerMstValidation------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		}
    }

    
     /**
     * Cost Total Ledger Validation Delete 정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
	public LData deleteCostTotLedgerValidation(LMultiData inputData, LData loginUser) throws LException {
		
    	LLog.info.write("\n CostTotLedgerValidationBiz > deleteCostTotLedgerValidation() ------------- Start \n");
    	
        LCompoundDao dao		= new LCompoundDao();
        String msg 				= "";
        
		long	getErrorCode	= 0 ;
		String	getMessage		= "";
		String	getStatus		= "";
	
		LData dataBox		    = new LData();
		
		try{
			
			dao.startTransaction();

			for(int i=0; i<inputData.getDataCount(); i++) {
				LData cudlData = inputData.getLData(i);
				cudlData.setString("userId", loginUser.getString("userId"));

				LLog.info.write("\n SQL -> fi/ar/costTotLedgerValidationSql/deleteCostTotLedgerMstValidation ---------------------------------- \n");

		        //1) Delete Cost Total Ledger Master
		        dao.add ("fi/ar/costTotLedgerValidationSql/deleteCostTotLedgerMstValidation", inputData ); 

		        //2) Delete Cost Total Ledger Detail
		        dao.add ("fi/ar/costTotLedgerValidationSql/deleteCostTotLedgerAllDtlValidation", inputData ); 
				dao.executeUpdate();
			}
			
			dao.commit();
			
		} catch (Exception se) {
			dao.rollback();
			getErrorCode = -99901;
			getMessage   = se.toString();
			getStatus    = "fail."+this.getClass().getName()+"."+"CostTotLedgerValidationBiz";
			LLog.err.write(this.getClass().getName()+"."+"CostTotLedgerValidationBiz()"+"=>" + msg);
		}

		LLog.info.write("\n CostTotLedgerValidationBiz > cudDelCostTotLedgerValidation() ------------- END --> \n");
      
		getErrorCode = 0;
		dataBox.put("getErrorCode"	,getErrorCode + "" );
		dataBox.put("getMessage"	,getMessage);
		
		if(!getStatus.equals("")) dataBox.put("getStatus" ,getStatus ); //현 프로그램에서 에러
		return dataBox;
	}
	
	
    /**
     * Cost Total Ledger Detail Validation 정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveCostTotLedgerDtlValidation(LData inputData) throws LException {    	
    	
    	LLog.debug.write("CostTotLedgerValidationBiz.retrieveCostTotLedgerDtlValidation -----------> Start ");
    	
    	LCommonDao dao = new LCommonDao();
		try{			
			return dao.executeQuery("fi/ar/costTotLedgerValidationSql/retrieveCostTotLedgerDtlValidation", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveCostTotLedgerDtlValidation------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		}
    }	


    /**
     *Cost Total Ledger Detail 저장하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     ** @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LData cudCostTotLedgerValidation(LMultiData inMstData, LMultiData inDtlData, 
    		                                 LData inputData, LData loginUser) throws LException {
        
    	LCompoundDao dao = new LCompoundDao();
        LData result = new LData();
        //int cnt = 0;
        
		LLog.debug.println("CostTotLedgerValidationBiz.cudCostTotLedgerValidation inputData1234--------------- =>\n " + inDtlData.toString());
		
		long	getErrorCode = 0;
		String	getMessage	 = "";
        String  getStatus    = "";		
		String  msg = "";

        try{			

			dao.startTransaction();

			String docYm     = "";
			String docSeq    = "";

			/*----------------------------------------------------------------------------
			 * Cost Total Ledger Master Update
			 *----------------------------------------------------------------------------*/ 
			for(int i=0;i<inMstData.getDataCount();i++) {
				LData cudlData = inMstData.getLData(i);

				String docDate  = cudlData.getString("docDate").replaceAll("/", "");
				String postDate = cudlData.getString("postDate").replaceAll("/", "");
				docYm = cudlData.getString("docYm");
	
				cudlData.setString("userId",    loginUser.getString("userId"));
				cudlData.setString("docYm",   	docYm);
				cudlData.setString("postDate",  postDate);
				cudlData.setString("docDate",   docDate);

				docSeq  = cudlData.getString("docSeq");
				
		    	String tr_Mode  = cudlData.getString("DEVON_CUD_FILTER_KEY");
	
		    	if( tr_Mode.equals("DEVON_UPDATE_FILTER_VALUE")) {
	
					//1) Cost Total Ledger Detail Insert
					dao.add("fi/ar/costTotLedgerValidationSql/updateCostTotLedgerMstValidation", cudlData);
				}
			}

			/*----------------------------------------------------------------------------
			 * Cost Total Ledger Detail Update
			 *----------------------------------------------------------------------------*/ 
			//Cost Total Ledger Detail
			for(int i=0;i<inDtlData.getDataCount();i++) {
				
				LData cudDtlData = inDtlData.getLData(i);
				cudDtlData.setString("userId",  loginUser.getString("userId"));

		    	String tr_Mode_dtl  = cudDtlData.getString("DEVON_CUD_FILTER_KEY");
		    	
		    	LLog.debug.write("===================  Document Detail 정보 Param [" + i + "]  =========================");
		    	LLog.debug.write("periodCostFrom:" + cudDtlData.getString("periodCostFrom"));
		    	LLog.debug.write("periodCostTo:" + cudDtlData.getString("periodCostTo"));
		    	LLog.debug.write("================================================================");
				
				if( tr_Mode_dtl.equals("DEVON_CREATE_FILTER_VALUE") ) {

					//if ( !docSeq.equals("") ) cudDtlData.setString("docSeq", docSeq);
					//Cost Total Ledger Detail Insert
					dao.add("fi/ar/costTotLedgerValidationSql/insertCostTotLedgerDtlValidation", cudDtlData);
					
				} else if( tr_Mode_dtl.equals("DEVON_UPDATE_FILTER_VALUE") ) {

					//Cost Total Ledger Detail Update
					dao.add("fi/ar/costTotLedgerValidationSql/updateCostTotLedgerDtlValidation", cudDtlData);

				} else if( tr_Mode_dtl.equals("DEVON_DELETE_FILTER_VALUE") ) {

					//Cost Total Ledger Detail Delete
					dao.add("fi/ar/costTotLedgerValidationSql/deleteCostTotLedgerDtlValidation", cudDtlData);

				}
			}			

			dao.executeUpdate();

			dao.commit();

			/*----------------------------------------------------------------------------
			 * Cost Total Ledger Check Validation
			 *----------------------------------------------------------------------------*/ 
			updateCostTotLedgerCheckValidation(inputData, loginUser);
				
		} catch (Exception se) {
			dao.rollback();

			getErrorCode = -99901;
			getMessage   = se.toString();
			getStatus    = "fail."+this.getClass().getName()+"."+"cudCostTotLedgerValidation";

			LLog.err.write(this.getClass().getName()+"."+"cudCostTotLedgerValidation()"+"=>" + msg);			
        }
		
		result.put("getErrorCode"	,getErrorCode + "");
		result.put("getMessage"		,getMessage);

		if(!getStatus.equals("")) result.put("getStatus" ,getStatus ); //현 프로그램에서 에러
		
		return result;
    }

    
    /**
     *Temp Cost Total Ledger 내역을 Cost Total Ledger 이동한다..
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     ** @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LData cudCostTotTransValidation(LMultiData inMstData, LData loginUser) throws LException {
        LCompoundDao dao = new LCompoundDao();
        LData result = new LData();
        //int cnt = 0;
        
		LLog.debug.println("CostTotLedgerValidationBiz.cudCostTotTransValidation inputData--------------- =>\n " + inMstData.toString());
		
		long	getErrorCode = 0;
		String	getMessage	 = "";
        String  getStatus    = "";		
		String  msg = "";

        try{			

			dao.startTransaction();

			//Cost Total Ledger Master
			for(int i=0;i<inMstData.getDataCount();i++) {
				
				LData cudlData = inMstData.getLData(i);

				cudlData.setString("userId",     loginUser.getString("userId"));
				
				//1) Cost Total Ledger Master Insert
				dao.add("fi/ar/costTotLedgerValidationSql/insertMstCostTotLedgerUpload", cudlData);
					
				//2) Cost Total Ledger Detail Insert
				dao.add("fi/ar/costTotLedgerValidationSql/insertDtlCostTotLedgerUpload", cudlData);

				/*-------------- Master / Detail Delete --------------*/
		        //1) Delete Cost Total Ledger Master
		        dao.add ("fi/ar/costTotLedgerValidationSql/deleteCostTotLedgerMstValidation", cudlData ); 

		        //2) Cost Total Ledger Detail Temp All Delete
		        dao.add ("fi/ar/costTotLedgerValidationSql/deleteCostTotLedgerAllDtlValidation", cudlData ); 
				
			}

			dao.executeUpdate();

			dao.commit();
				
		} catch (Exception se) {
			dao.rollback();

			getErrorCode = -99901;
			getMessage   = se.toString();
			getStatus    = "fail."+this.getClass().getName()+"."+"cudCostTotValidation";

			LLog.err.write(this.getClass().getName()+"."+"cudCostTotValidation()"+"=>" + msg);			
        }
		
		result.put("getErrorCode"	,getErrorCode + "");
		result.put("getMessage"		,getMessage);

		if(!getStatus.equals("")) result.put("getStatus" ,getStatus ); //현 프로그램에서 에러
		
		return result;
    }    
    
    
    /**
     *Cost Total Ledger Detail 저장하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     ** @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LData updateCostTotLedgerCheckValidation(LData inputData, LData loginUser) throws LException {
        LCompoundDao dao = new LCompoundDao();
        LCommonDao dao2 = new LCommonDao();
        LData result = new LData();
        LData schData = new LData();
        
        //int cnt = 0;
        
		LLog.debug.println("CostTotLedgerValidationBiz.updateCostTotLedgerCheckValidation inputData--------------- =>\n " + inputData.toString());
		
		long	getErrorCode = 0;
		String	getMessage	 = "";
        String  getStatus    = "";		
		String  msg = "";

        try{			

			dao.startTransaction();

			String errorMstMsg  = "";
			String errorDtlMsg  = "";
			int    errorDtlCnt  = 0;
			
			LMultiData inMstData = new LMultiData();
			LMultiData inDtlData = new LMultiData();
			LMultiData pidCostAcctData = new LMultiData();
			
			/*----------------------------------------------------------------------------
			 * Cost Total Ledger Detail Validation
			 *----------------------------------------------------------------------------*/ 
			
			inputData.setString("companyCd",  loginUser.getString("companyCd"));

			// Cost Total Ledger Detail Error List Retrieve
			inDtlData = dao.executeQuery("fi/ar/costTotLedgerValidationSql/retrieveCostTotLedgerDtlCheck", inputData);

			LLog.debug.write("CostTotLedgerValidationBiz.updateCostTotLedgerCheckValidation inputData---------------1 =>\n ");
			
			schData.set("lang", loginUser.getString("lang"));
			schData.set("companyCd", loginUser.getString("companyCd"));
			schData.set("groupCd", "PCST");
			
			// 기간비용계정 정보 조회
			pidCostAcctData = dao2.executeQuery("cm/cm/commCodeMgntSql/retrieveCommCodeCombo", schData);
			
			LLog.debug.write("===================  기간비용계정 정보 목록  ========================");
			LLog.debug.write("pidCostAcctData:"+pidCostAcctData);
			LLog.debug.write("=====================================================================");
			
			//item 1개 씩 검사
			//Cost Total Ledger Detail
			for(int i=0;i<inDtlData.getDataCount();i++) {
				
				LData cudlData   = inDtlData.getLData(i);
				double debitAmt  = cudlData.getDouble("debitAmt");
				double creditAmt = cudlData.getDouble("creditAmt");
				String special   = StringUtil.chknull(cudlData.getString("sp"));
				errorDtlMsg      = "";
				
				String sapAcctCd = StringUtil.chknull(cudlData.getString("sapAcctCd")); // 계정코드
				String sapAcctCdF = "";                                                 // 계정코드 첫째 자리 값
				
				if(!StringUtil.chknull(cudlData.getString("sapAcctCd")).equals("")){
					sapAcctCdF = sapAcctCd.substring(0, 1);
				}

				// Available Value Check
				String columnCheck = "";
				if ( StringUtil.chknull(cudlData.getString("sapAcctCd")).equals("") ) {
					errorDtlMsg = "required field. please fill Account Code";												
				} else if ( StringUtil.chknull(cudlData.getString("acctSapCd")).equals("") ) {
					errorDtlMsg = "Account Code Invalid";
				} else if ( debitAmt < 0) {
					errorDtlMsg = "required field. please fill Account Code";
				} else if ( creditAmt < 0) {
					errorDtlMsg = "The negative number will not be able to input!";
				} else if ( debitAmt == 0 && creditAmt == 0) {
					errorDtlMsg = "Debit or Crddit must be greater than 0.";
/*					
				} else if ( StringUtil.chknull(cudlData.getString("costCenter")).equals("")) {
					errorDtlMsg = "Cost Center Must be inputed";

				} else if ( StringUtil.chknull(cudlData.getString("checkCenter")).equals("N")) {
					errorDtlMsg = "Cost Center Code is Not Exists!";
*/
				// Account Code 값이 있는 경우
				}else if (!StringUtil.chknull(cudlData.getString("sapAcctCd")).equals("")){
					
					// Account Code 첫번째 자리 값이 '8' 인 경우
					if("8".equals(sapAcctCdF)){
						
						/*
						// CIP & DEC (I/O) 값이 있는 경우
						if(!StringUtil.chknull(cudlData.getString("intOrder")).equals("")){
							errorDtlMsg = "Cost center Code Only.";
						}
						// Cost center 값이 없는 경우
						if(StringUtil.chknull(cudlData.getString("costCenter")).equals("")){
							errorDtlMsg = "Cost center Code Only.";
						}
						*/
					}
					
					// Account Code 첫번째 자리 값이 '9' 인 경우
					if("9".equals(sapAcctCdF)){
						
						/*
						// CIP & DEC (I/O) 값이 없는 경우
						if(StringUtil.chknull(cudlData.getString("intOrder")).equals("")){
							errorDtlMsg = "CIP & DEC Code Only.";
						}
						// Cost center 값이 있는 경우
						if(!StringUtil.chknull(cudlData.getString("costCenter")).equals("")){
							errorDtlMsg = "CIP & DEC Code Only.";
						}
						*/
					}	
					
					// Account Code 첫번째 자리 값이 '8', '9' 가 아닌 경우
					if(!"8".equals(sapAcctCdF) && !"9".equals(sapAcctCdF)){
						
						// Cost Center, Internal Order 값이 모두 있는 경우	
						if ( !StringUtil.chknull(cudlData.getString("costCenter")).equals("") && !StringUtil.chknull(cudlData.getString("intOrder")).equals("")) {	
							errorDtlMsg = "Choose one, Cost Center or I/O code.";
						}
						
						// Cost Center, Internal Order 값이 모두 없는 경우
						if ( StringUtil.chknull(cudlData.getString("costCenter")).equals("") && StringUtil.chknull(cudlData.getString("intOrder")).equals("")) {		
							errorDtlMsg = "Please input Cost Center or I/O code.";
						}
						
						// Cost Center 값이 있는 경우	
						if ( !StringUtil.chknull(cudlData.getString("costCenter")).equals("")) {
						
							// Cost Center 사용유무가 N 인 경우
							if(StringUtil.chknull(cudlData.getString("checkCenter")).equals("N")){
								errorDtlMsg = "Cost Center Code is Not Exists!";
							}
						}
						
						// Internal Order 값이 있는 경우	
						if ( !StringUtil.chknull(cudlData.getString("intOrder")).equals("")) {
						
							// Internal Order 사용유무가 N 인 경우
							if(StringUtil.chknull(cudlData.getString("checkInt")).equals("N")){
								errorDtlMsg = "Check the I/O code";
							}
						}
					}
					
					// 기간비용계정인 경우 기간비용시작일자, 기간비용종료일자 유효성 체크 
					for(int k=0;k<pidCostAcctData.getDataCount();k++) {
						
						LData acctlData = pidCostAcctData.getLData(k);
						
						// Account Code 가 기관계정코드 인 경우
						if(StringUtil.chknull(cudlData.getString("sapAcctCd")).equals(StringUtil.chknull(acctlData.getString("code")))){
							
							// 기간비용시작일자 없는 경우
							if(StringUtil.chknull(cudlData.getString("periodCostFrom")).equals("")){
								errorDtlMsg = "Please input cost period";
								break;
							}
							
							// 기간비용종료일자 없는 경우
							if(StringUtil.chknull(cudlData.getString("periodCostTo")).equals("")){
								errorDtlMsg = "Please input cost period";
								break;
							}
						}
					}					
					
				// Account Code 값이 없는 경우
				} else if(StringUtil.chknull(cudlData.getString("sapAcctCd")).equals("")){	
					
					// Cost Center, Internal Order 값이 모두 있는 경우	
					if ( !StringUtil.chknull(cudlData.getString("costCenter")).equals("") && !StringUtil.chknull(cudlData.getString("intOrder")).equals("")) {	
						errorDtlMsg = "Choose one, Cost Center or I/O code.";
					}
					
					// Cost Center, Internal Order 값이 모두 없는 경우
					if ( StringUtil.chknull(cudlData.getString("costCenter")).equals("") && StringUtil.chknull(cudlData.getString("intOrder")).equals("")) {		
						errorDtlMsg = "Please input Cost Center or I/O code.";
					}
					
					// Cost Center 값이 있는 경우	
					if ( !StringUtil.chknull(cudlData.getString("costCenter")).equals("")) {
					
						// Cost Center 사용유무가 N 인 경우
						if(StringUtil.chknull(cudlData.getString("checkCenter")).equals("N")){
							errorDtlMsg = "Cost Center Code is Not Exists!";
						}
					}
					
					// Internal Order 값이 있는 경우	
					if ( !StringUtil.chknull(cudlData.getString("intOrder")).equals("")) {
					
						// Internal Order 사용유무가 N 인 경우
						if(StringUtil.chknull(cudlData.getString("checkInt")).equals("N")){
							errorDtlMsg = "Check the I/O code";
						}
					}
					
				// Vendor code 가 존재하고, 상태가 N일경우
				} else if ( !StringUtil.chknull(cudlData.getString("sapAcctV")).equals("") && 
							  StringUtil.chknull(cudlData.getString("checkVend")).equals("N") ) {
					errorDtlMsg = "Vendor Invalid!";

				} else if ( !StringUtil.chknull(cudlData.getString("sapAcctC")).equals("") && 
							  StringUtil.chknull(cudlData.getString("checkCust")).equals("N") ) {
					errorDtlMsg = "Customer Invalid!";

					
					//vAT 코드가 존재하고, VAT 코드가 부적합 할 경우
				} else if ( !StringUtil.chknull(cudlData.getString("vat")).equals("") &&
						      StringUtil.chknull(cudlData.getString("checkVatcd")).equals("N") ) {
					errorDtlMsg = "VAT CODE Invalid!";
					
/*				} else if ( StringUtil.chknull(cudlData.getString("docDiv")).equals("B") ) {

					if ( !StringUtil.chknull(cudlData.getString("vat")).equals("") ) {
						errorDtlMsg = "VAT CODE Invalid!";
					}*/
				
				//VAT 계정y 이면서, 
				} else if ( StringUtil.chknull(cudlData.getString("checkVatacct")).equals("Y") && 
						     StringUtil.chknull(cudlData.getString("vat")).equals("") ) {
					
						errorDtlMsg = "VAT Must be inputed!";

				} else if ( StringUtil.chknull(cudlData.getString("checkVatacct")).equals("N") && 
						    !StringUtil.chknull(cudlData.getString("vat")).equals("")) {
						LLog.info.println("  log"+ cudlData.getString("checkVatacct"));
						errorDtlMsg = "VAT Must be empty!";

				} 
				
				
				
				//원천세 여부 검토
				//원천세의 경우 세금코드 Baseamount 
				if ( StringUtil.chknull(cudlData.getString("checkWithtax")).equals("Y") ) {

					if ( !StringUtil.chknull(cudlData.getString("base")).equals("0.0") ) {
						errorDtlMsg = "Withholding Tax account is not permitted inputting VAT base amount";
					
					}
					else if ( !StringUtil.chknull(cudlData.getString("vat")).equals("") ) {
						errorDtlMsg = "Withholding Tax account is not permitted inputting VAT code";
					
					}
					
					/* 다른 컬럼 미사용 
					else if ( StringUtil.chknull(cudlData.getString("code")).equals("") ) {
						errorDtlMsg = "W/T Code Must be inputed!";
					
					} else if ( StringUtil.chknull(cudlData.getString("rate")).equals("0.0") ) {
						errorDtlMsg = "W/T Rate Must be inputed!";
					}*/

				} else if ( StringUtil.chknull(cudlData.getString("checkVatacct")).equals("Y") ) {
					System.out.println("log checkwithtax "+cudlData.getString("checkWithtax"));
					System.out.println("cudlData 핡\n"+cudlData);
					//부가세인데 세금 코드 없는 경우


					 if ( StringUtil.chknull(cudlData.getString("vat")).equals("") ) {
						errorDtlMsg = "VAT account.\nCheck VAT code.";
					}				
					/* else if ( StringUtil.chknull(cudlData.getString("base")).equals("0.0") ) {
						System.out.println("log "+  cudlData.getString("base"));
						errorDtlMsg = "VAT account.\nCheck VAT base amount.";
					}
*/
					
				} 

				if ( special.equals("D") ) {
					
					// Account Special Check
					if ( StringUtil.chknull(cudlData.getString("sapAcctC")).equals("") ) {
						errorDtlMsg = "Customer Must be inputed!";
					} else if ( !StringUtil.chknull(cudlData.getString("sapAcctV")).equals("") ) {
						errorDtlMsg = "Not required field Vendor!";
					}
					
				} else if ( special.equals("K") ) {
					
					// Account Special Check
					if ( StringUtil.chknull(cudlData.getString("sapAcctV")).equals("") ) {
						errorDtlMsg = "Vendor Must be inputed!";
					}
					
					if ( !StringUtil.chknull(cudlData.getString("sapAcctC")).equals("") ) {
						errorDtlMsg = "Not required field Customer!";
					}
				
				} else if ( special.equals("S") ) {
				
					if ( !StringUtil.chknull(cudlData.getString("spglNo")).equals("") ) {
						errorDtlMsg = "Not required field SPGL No!";
					}

					if ( !StringUtil.chknull(cudlData.getString("sapAcctV")).equals("") ) {
						errorDtlMsg = "Not required field Vendor!";
					}

					if ( !StringUtil.chknull(cudlData.getString("sapAcctC")).equals("") ) {
						errorDtlMsg = "Not required field Customer!";
					}

					if ( StringUtil.chknull(cudlData.getString("checkDuedate")).equals("Y") && 
						 StringUtil.chknull(cudlData.getString("dueDate")).equals("")) {
						errorDtlMsg = "Due Date Must be inputed!";
					}

				}
				
				if ( !StringUtil.chknull(cudlData.getString("spglNo")).equals("") ) {

					if ( StringUtil.chknull(cudlData.getString("dueDate")).equals("") ) {
						errorDtlMsg = "Due Date Must be inputed!";
					}
					
				}

				if (( special.equals("D") || special.equals("K")) && 
					 !StringUtil.chknull(cudlData.getString("spglNo")).equals("") &&
			          StringUtil.chknull(cudlData.getString("checkSpgl")).equals("N") ) {
					errorDtlMsg = "SPGL No Invalid!";
				}
				
				cudlData.setString("errorMsg",  errorDtlMsg);

				//Cost Total Ledger Detail Update
				dao.add("fi/ar/costTotLedgerValidationSql/updateCostTotLedgerErrorDtlValidation", cudlData);

			}			

			dao.executeUpdate();
			LLog.debug.write("CostTotLedgerValidationBiz.updateCostTotLedgerCheckValidation inputData---------------2 =>\n ");
			
			/*
			 *----------------------------------------------------------------------------
			 * Cost Total Ledger Master Validation
			 *---------------------------------------------------------------------------- 
			 */
			
			inMstData = dao.executeQuery("fi/ar/costTotLedgerValidationSql/retrieveCostTotLedgerMstCheck", inputData);
			
			//Cost Total Ledger Master
			for(int i=0;i<inMstData.getDataCount();i++) {
				
				LData cudlData = inMstData.getLData(i);
				String docYm      = StringUtil.chknull(cudlData.getString("docYm"));
				String docDate    = StringUtil.chknull(cudlData.getString("docDate"));
				String postDate   = StringUtil.chknull(cudlData.getString("postDate"));
				String currencyCd = StringUtil.chknull(cudlData.getString("currencyCd"));
				String availCheck = StringUtil.chknull(cudlData.getString("availCheck"));
				String consultationCheck = StringUtil.chknull(cudlData.getString("consultationCheck"));
				errorMstMsg       = "";
				
				double debitAmt  = cudlData.getDouble("debitAmt");
				double creditAmt = cudlData.getDouble("creditAmt");

				if ( !DataUtil.isDate(docDate) ) {
					errorMstMsg = "Invalid Document Date!";
				} else if ( !postDate.equals("") && !DataUtil.isDate(postDate) ) {
					errorMstMsg = "Invalid Post Date!";
				} else if ( Integer.parseInt(docDate.substring(0,6)) != Integer.parseInt(docYm) ) {
					errorMstMsg = "Document Year-Month and Document Date Month must be the same month!";
				} else if ( !postDate.equals("") && DataUtil.getBetween(docDate, postDate) < 0 ) {
					errorMstMsg = "Posting Date is the less then Document Date";
				} else if ( !currencyCd.equals("USD") && !currencyCd.equals("MMK")) {
					errorMstMsg = "Invalid Currency Code";
				} else if ( debitAmt != creditAmt) {
					errorMstMsg = "The debit and credit total are not right.";
				} else if ( availCheck.equals("N")) {
					errorMstMsg = "Month or Document No Invalid!.";
				} else if ( consultationCheck.equals("N")) {
					errorMstMsg = "Consultation Doc No does not exist.";
				}
				
				if ( errorMstMsg.equals("") ) {
					cudlData.setString("errorMsg",      "");
					cudlData.setString("valiSuccessYn", "Y");
				} else {
					cudlData.setString("errorMsg",      errorMstMsg);
					cudlData.setString("valiSuccessYn", "N");
				}
				
				LLog.debug.write("================  Cost Price Upload Validation Master Param ["+ i +"]  ==================");
				LLog.debug.write("errorMsg:"+cudlData.getString("errorMsg"));
				LLog.debug.write("valiSuccessYn:"+cudlData.getString("valiSuccessYn"));
				LLog.debug.write("===============================================================================");
				
				//Cost Total Ledger Detail Insert
				dao.add("fi/ar/costTotLedgerValidationSql/updateCostTotLedgerErrorMstValidation", cudlData);

				//Cost Total Ledger Master Error Check Update
				dao.add("fi/ar/costTotLedgerValidationSql/updateCostTotLedgerErrorValidation", cudlData);
				
			}

			LLog.debug.write("CostTotLedgerValidationBiz.updateCostTotLedgerCheckValidation inputData---------------3 =>\n ");
			dao.executeUpdate();

			dao.commit();
				
		} catch (Exception se) {
			dao.rollback();

			getErrorCode = -99901;
			getMessage   = se.toString();
			getStatus    = "fail."+this.getClass().getName()+"."+"cudCostTotLedgerValidation";

			LLog.err.write(this.getClass().getName()+"."+"cudCostTotLedgerValidation()"+"=>" + msg);			
        }
		
		result.put("getErrorCode"	,getErrorCode + "");
		result.put("getMessage"		,getMessage);

		if(!getStatus.equals("")) result.put("getStatus" ,getStatus ); //현 프로그램에서 에러
		
		return result;
    }    
    
    
	public LMultiData retrieveCostTotLedgerValidationVatVCombo(LData inputData) throws LSysException {
    	LLog.debug.write("retrieveCostTotLedgerValidationVatVCombo -----------> Start ");
    	
    	LCommonDao dao = new LCommonDao();
		try{			
			return dao.executeQuery("fi/ar/costTotLedgerValidationSql/retrieveCostTotLedgerValidationVatVCombo", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveCostTotLedgerValidationVatVCombo------()" + "=>" + se.getMessage());
			throw new LSysException("fi.ar.retrieveCostTotLedgerValidationVatVCombo", se);
		}
	}    
    
}
