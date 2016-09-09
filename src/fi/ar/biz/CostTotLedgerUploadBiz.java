/*
 *------------------------------------------------------------------------------
 * CostTotLedgerUploadBiz.java,v 1.0 2010/07/23 16:43:35 
 * 
 * PROJ : PT-MGE System
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2010/10/11   mskim   Init
 *----------------------------------------------------------------------------
 */

package fi.ar.biz;

import devon.core.exception.LException;
import devon.core.exception.LSysException;
import devon.core.log.LLog;
import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devonframework.persistent.autodao.LCommonDao;
import devonframework.persistent.autodao.LCompoundDao;
import comm.util.DataUtil;
import comm.util.StringUtil;
import fi.ar.biz.CostTotLedgerValidationBiz;

/**
 * <PRE>
 * Menu Mgnt 정보의 조회/추가/수정/삭제/ 업무를 처리하는 Biz 클래스.
 *
 * Database Tables : 
 * </PRE>
 * @author    CEH
 */
public class CostTotLedgerUploadBiz {

    
    /**
     * Menu Authority 정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveCostTotUploadList(LData inputData) throws LException {    	
    	
    	LLog.debug.write("retrieveCostTotUploadList inputData==>\n"+inputData.toString());
    	
    	LCommonDao dao = new LCommonDao();
		try{			
			return dao.executeQuery("fi/ar/costTotLedgerUploadSql/retrieveCostTotLedger", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveCostTotUploadList------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		}
    }
    
    /**
     *Menu Authority 저장하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * @throws Exception 
     */
    public LData cudCostTotUpload(LMultiData inputData, LData loginUser) throws LException {

    	LLog.debug.write("CostTotLedgerUploadBiz cudCostTotUpload Start");
    	
    	LCompoundDao dao = new LCompoundDao();        
        LData result = new LData();        
        LMultiData inputChgLMultData = new LMultiData(); // docSeq 자동 채변 변경 LMultiData
        
		String	getErrorCode = "0" ;
		String	getMessage	 = "";        
		String  msg = "";
		String errorMsg  = "";
		
		LData schlData = inputData.getLData(0);
		String docYmFst = StringUtil.chknull(schlData.getString("docYm"));
						
		LLog.debug.write("=============  MAX docSeq (문서번호) 조회 Param  ===============");
		LLog.debug.write("companyCd:" + schlData.getString("companyCd"));
		LLog.debug.write("docYm:" + schlData.getString("docYm"));
		LLog.debug.write("docYmFst:" + docYmFst);		
		LLog.debug.write("================================================================");						
		
		// max docSeq (문서번호) 정보 조회 (tb_doc_master)
		LData DocSeqInfo = dao.executeQueryForSingle("/fi/ar/costTotLedgerUploadSql/retrieveMaxDocSeqInfo", schlData);
		int MaxDocSeq = DocSeqInfo.getInt("docSeq");					
						
		LLog.debug.write("=============  MAX docSeq (문서번호) 조회 결과  ===============");
		LLog.debug.write("MaxDocSeq:" + MaxDocSeq);				
		LLog.debug.write("================================================================");
				
		String preDocSeq = "";
		
		// inputData (사용자 업로드 데이타) - docSeq 재설정
		for(int i = 0; i < inputData.getDataCount(); i++) {

			LData inputUploadData = inputData.getLData(i);
			
			// 첫번째 데이터가 아닌 경우
			if(i != 0){
				// 이전, 현재 docSeq 비교 - MaxDocSeq 채번
				if(!preDocSeq.equals(inputUploadData.getString("docSeq"))){
					MaxDocSeq++;
				}
			}
		
			LData inputChgLData = new LData();								
			
			inputChgLData.setString("DEVON_CUD_FILTER_KEY", inputUploadData.getString("DEVON_CUD_FILTER_KEY"));
			inputChgLData.setString("docYm", inputUploadData.getString("docYm"));			
			//===============   WEB Doc No 자동 채번  ===============================
			inputChgLData.setString("docSeq", String.valueOf(MaxDocSeq));
			//=======================================================================
			inputChgLData.setString("docNum", inputUploadData.getString("docNum"));
			inputChgLData.setString("docDate", inputUploadData.getString("docDate"));
			inputChgLData.setString("postDate", inputUploadData.getString("postDate"));
			inputChgLData.setString("sapAcctCd", inputUploadData.getString("sapAcctCd"));
			inputChgLData.setString("acctNm", inputUploadData.getString("acctNm"));
			inputChgLData.setString("debitAmt", inputUploadData.getString("debitAmt"));
			inputChgLData.setString("creditAmt", inputUploadData.getString("creditAmt"));
			inputChgLData.setString("currencyCd", inputUploadData.getString("currencyCd"));
			inputChgLData.setString("vat", inputUploadData.getString("vat"));
			inputChgLData.setString("base", inputUploadData.getString("base"));
			inputChgLData.setString("docDesc", inputUploadData.getString("docDesc"));
			inputChgLData.setString("costCenter", inputUploadData.getString("costCenter"));
			inputChgLData.setString("intOrder", inputUploadData.getString("intOrder"));
			inputChgLData.setString("sapAcctV", inputUploadData.getString("sapAcctV"));
			inputChgLData.setString("sapAcctC", inputUploadData.getString("sapAcctC"));
			inputChgLData.setString("code", inputUploadData.getString("code"));
			inputChgLData.setString("rate", inputUploadData.getString("rate"));
			inputChgLData.setString("spglNo", inputUploadData.getString("spglNo"));
			inputChgLData.setString("createDate", inputUploadData.getString("createDate"));
			inputChgLData.setString("returnMsg", inputUploadData.getString("returnMsg"));
			inputChgLData.setString("companyCd", inputUploadData.getString("companyCd"));
			inputChgLData.setString("deptCd", inputUploadData.getString("deptCd"));										
						
			inputChgLMultData.addLData(inputChgLData);
			
			preDocSeq = inputUploadData.getString("docSeq");  // 이전 DocSeq
						
		}
		
		LLog.debug.write("=======================  사용자 ExcelUpload Data Param  =====================");
		LLog.debug.write("inputData:" + inputData);
		LLog.debug.write("=============  사용자 ExcelUpload Data(DocNo 자동채번) Param  ===============");
		LLog.debug.write("inputChgData:" + inputChgLMultData);
		LLog.debug.write("=============================================================================");
        
		LData cudlData = inputChgLMultData.getLData(0);
        LData infoLData = new LData();
		LMultiData mDataInfo = new LMultiData();

        infoLData.setString("userId", 	 loginUser.getString("userId"));
        infoLData.setString("companyCd", cudlData.getString("companyCd"));
        infoLData.setString("deptCd",    cudlData.getString("deptCd"));
        
		try{		

			dao.startTransaction();

			//Excel Upload 삭제
			dao.add("fi/ar/costTotLedgerUploadSql/deleteCostTotLedgerTempUpload", infoLData);

	    	//Cost Total Ledger Temp Upload 등록
			dao.setInsertQuery("fi/ar/costTotLedgerUploadSql/insertCostTotTempUpload");
			dao.addWithJobType(inputChgLMultData);
			dao.executeUpdate();

			
			//-------------- Data Validation Check Start ---------------
			mDataInfo = dao.executeQuery("fi/ar/costTotLedgerUploadSql/retrieveCostTotUploadValidation", infoLData);

			LLog.debug.write("CostTotLedgerUploadBiz ------------ mDataInfo.getDataCount():" + mDataInfo.getDataCount());

			for(int i = 0; i < mDataInfo.getDataCount(); i++) {

				LData cudlInfoData = mDataInfo.getLData(i);
				String deptCd         = StringUtil.chknull(cudlInfoData.getString("deptCd")); 
				String docYm          = StringUtil.chknull(cudlInfoData.getString("docYm"));
				String docSeq         = StringUtil.chknull(cudlInfoData.getString("docSeq"));
				String availCheck     = StringUtil.chknull(cudlInfoData.getString("availCheck"));
				String availCheckTemp = StringUtil.chknull(cudlInfoData.getString("availCheckTemp"));

				if ( docSeq.length() != 7 || !docSeq.startsWith("1")) {
					msg += "simpleMsg : Document No [ "+ deptCd + " " + docYm + " " + docSeq +" ] Invalid Document No!.";	
					throw new Exception(msg);	
				} 

				if ( !DataUtil.isMonth(docYm) ) {
					msg += "simpleMsg : Document No [ "+ deptCd + " " + docYm + " " + docSeq +" ] Invalid Document Year Month!.";	
					throw new Exception(msg);	
				}
				
				// 동일한 docYm  여부 체크
				if ( !docYmFst.equals(docYm) ) {
					msg += "simpleMsg : Please check fiscal year field";	
					throw new Exception(msg);	
				}

				if ( availCheckTemp.equals("N")) {
					msg += "simpleMsg : Document No [ "+ deptCd + " " + docYm + " " + docSeq +" ] Temp Month or Document No Invalid!.";
					throw new Exception(msg);	
				}
				
				if ( availCheck.equals("N")) {
					msg += "simpleMsg : Document No [ "+ deptCd + " " + docYm + " " + docSeq +" ] Month or Document No Invalid!.";
					throw new Exception(msg);	
				}

			}			
			//-------------- Data Validation Check End ---------------
			
			
			//Cost Total Ledger Master / Detail Upload 등록
			dao.add("fi/ar/costTotLedgerUploadSql/insertMsCostTotLedgerUpload",infoLData);
			dao.add("fi/ar/costTotLedgerUploadSql/insertDtlCostTotLedgerUpload",infoLData);
			
			dao.executeUpdate();

			dao.commit();

			//----------------------------------------------------------------------------
			// Cost Total Ledger Check Validation
			//----------------------------------------------------------------------------// 
			CostTotLedgerValidationBiz vali = new CostTotLedgerValidationBiz();
			vali.updateCostTotLedgerCheckValidation(infoLData, loginUser);			
			
			LLog.debug.write("CostTotLedgerUploadBiz cudCostTotUpload End");
			
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "cudCostTotUpload()" + "=>" + se.getMessage());
			dao.rollback();

			//throw new LSysException("pbf.err.com.save", se);
			getErrorCode = "-1403";
			getMessage = se.getMessage();
			//throw new LSysException(getMessage,se);
        }
		
		result.put("getErrorCode"	,getErrorCode + "" );
		result.put("getMessage"		,getMessage);
		
		return result;
    }
        
}
