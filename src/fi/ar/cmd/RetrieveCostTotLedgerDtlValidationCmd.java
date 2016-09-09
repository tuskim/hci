/*
 *------------------------------------------------------------------------------
 * RetrieveCostTotLedgerDtlValidationCmd.java,v 1.0 2010/07/23 16:43:35 
 * 
 * PROJ : PT-MGE System. 
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2010/10/11   mskim   Init
 * 2015/12/01   hckim   Internal Order 필드 추가에 따른 소스 수정
 *----------------------------------------------------------------------------
 */

package fi.ar.cmd;

import fi.ar.biz.CostTotLedgerValidationBiz;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataSet;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

import comm.util.LXssCollectionUtility;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LException;
import devon.core.log.LLog;
import devonframework.bridge.gauce.command.LGauceCommandIF;
import devonframework.bridge.gauce.util.LGauceConverter;

/**
 * <PRE>
 * 
 * 
 * </PRE>
 * 
 * @author    ceh
 * @see       
 */
public class RetrieveCostTotLedgerDtlValidationCmd implements LGauceCommandIF  {
    /**
     * 
     *
     * @param req Http Request 객체.
     * @param res Http Response 객체.
     * @param gauceRequest 가우스 Request 객체.
     * @param gauceResponse 가우스 Response 객체.
     * @exception LException Commnad 단 이하의 모든 에러.
     */
	public void execute(HttpServletRequest req, HttpServletResponse res, 
            GauceRequest gauceRequest, GauceResponse gauceResponse) throws LException {
		 
		LLog.info.write("\n RetrieveCostTotLedgerDtlValidationCmd --> Start \n");		

		GauceDataSet gds = new GauceDataSet();
		gauceResponse.enableFirstRow(gds);
		
		LData inputData = LXssCollectionUtility.getData(req);

		long  getErrorCode = 0 ;
        String getMessage   = "";
        
		//-------------------------------------- Session 종료시 처리 START
	    HttpSession session = req.getSession(false);
	    LData loginUser = new LData();
	    
	    if (session != null) loginUser = (LData)session.getAttribute("loginUser");
	    if( loginUser.getString("userId") == null) {
	    	getMessage = "Session is Terminated. You need to relogin!";
	    	gauceResponse.writeException("Error", String.valueOf(getErrorCode), "\n[Detail Msg]==>" + getMessage);
	    	return;
	    }
	    //-------------------------------------- Session 종료시 처리 END
	    
	    //사용자iD 추가.`
	    inputData.setString("userId", loginUser.getString("userId"));
	    inputData.setString("lang",   loginUser.getString("lang"));
	    
	    CostTotLedgerValidationBiz biz = new CostTotLedgerValidationBiz();
		LMultiData result = biz.retrieveCostTotLedgerDtlValidation(inputData);
		
		//req.setAttribute("resultData", result);

		gds.addDataColumn( new GauceDataColumn("companyCd"			, GauceDataColumn.TB_STRING, 4));
		gds.addDataColumn( new GauceDataColumn("deptCd"    			, GauceDataColumn.TB_STRING, 4));
		gds.addDataColumn( new GauceDataColumn("docYm"    			, GauceDataColumn.TB_STRING, 6));
		gds.addDataColumn( new GauceDataColumn("docSeq"    			, GauceDataColumn.TB_STRING, 20));
		gds.addDataColumn( new GauceDataColumn("docNum"    			, GauceDataColumn.TB_STRING, 3));
		gds.addDataColumn( new GauceDataColumn("sapAcctCd"    		, GauceDataColumn.TB_STRING, 10));
		gds.addDataColumn( new GauceDataColumn("sapAcctNm"    		, GauceDataColumn.TB_STRING, 100));
		gds.addDataColumn( new GauceDataColumn("debitAmt"    		, GauceDataColumn.TB_DECIMAL, 15,2));
		gds.addDataColumn( new GauceDataColumn("creditAmt"    		, GauceDataColumn.TB_DECIMAL, 15,2));
		gds.addDataColumn( new GauceDataColumn("docDesc"    		, GauceDataColumn.TB_STRING, 50));
		gds.addDataColumn( new GauceDataColumn("vat"    			, GauceDataColumn.TB_STRING, 50));
		gds.addDataColumn( new GauceDataColumn("base"    			, GauceDataColumn.TB_DECIMAL, 15,2));
		gds.addDataColumn( new GauceDataColumn("code"    			, GauceDataColumn.TB_STRING, 50));
		gds.addDataColumn( new GauceDataColumn("rate"    			, GauceDataColumn.TB_DECIMAL, 3,1));
		gds.addDataColumn( new GauceDataColumn("dueDate"   			, GauceDataColumn.TB_STRING, 10));
		gds.addDataColumn( new GauceDataColumn("spglNo"    			, GauceDataColumn.TB_STRING, 1));
		gds.addDataColumn( new GauceDataColumn("sapAcctV"    		, GauceDataColumn.TB_STRING, 10));
		gds.addDataColumn( new GauceDataColumn("sapAcctVNm"    		, GauceDataColumn.TB_STRING, 50));
		gds.addDataColumn( new GauceDataColumn("sapAcctC"    		, GauceDataColumn.TB_STRING, 10));
		gds.addDataColumn( new GauceDataColumn("sapAcctCNm"    		, GauceDataColumn.TB_STRING, 50));
		gds.addDataColumn( new GauceDataColumn("errorMsg"    		, GauceDataColumn.TB_STRING, 1000));
		gds.addDataColumn( new GauceDataColumn("costCenter"    		, GauceDataColumn.TB_STRING, 10));
		gds.addDataColumn( new GauceDataColumn("sp"    				, GauceDataColumn.TB_STRING, 50));
		gds.addDataColumn( new GauceDataColumn("checkDuedate"  		, GauceDataColumn.TB_STRING, 1));
		gds.addDataColumn( new GauceDataColumn("acctSapCd"    		, GauceDataColumn.TB_STRING, 50));
		gds.addDataColumn( new GauceDataColumn("checkCenter"    	, GauceDataColumn.TB_STRING, 50));
		gds.addDataColumn( new GauceDataColumn("intOrder"    	    , GauceDataColumn.TB_STRING, 50));
		gds.addDataColumn( new GauceDataColumn("intOrderNm"    	    , GauceDataColumn.TB_STRING, 50));
		gds.addDataColumn( new GauceDataColumn("periodCostFrom"   	, GauceDataColumn.TB_STRING, 10));
		gds.addDataColumn( new GauceDataColumn("periodCostTo"   	, GauceDataColumn.TB_STRING, 10));
		
	    //LGauceConverter.extractToGauceDataSet(result, gds);
	    LGauceConverter.convertToGauceDataSet(result, gds);
	    gds.flush();
	    
		LLog.info.write("\n RetrieveCostTotLedgerDtlValidationCmd --> End \n");		
		
    }
}
