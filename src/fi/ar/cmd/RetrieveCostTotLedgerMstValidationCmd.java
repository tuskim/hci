/*
 *------------------------------------------------------------------------------
 * RetrieveCostTotLedgerMstValidationCmd.java,v 1.0 2010/07/23 16:43:35 
 * 
 * PROJ : PT-MGE System 
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2010/10/11   mskim   Init
 * 2015/12/04   hckim   valiSuccessNm 필드 추가에 따른 소스 수정
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
public class RetrieveCostTotLedgerMstValidationCmd implements LGauceCommandIF  {
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
		 
		LLog.info.write("\n RetrieveCostTotLedgerMstValidationCmd --> Start \n");		

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
	    
	    //회사코드 추가.`
	    inputData.setString("companyCd", loginUser.getString("companyCd"));
	    inputData.setString("lang",      loginUser.getString("lang"));
	    
	    CostTotLedgerValidationBiz biz = new CostTotLedgerValidationBiz();
		LMultiData result = biz.retrieveCostTotLedgerMstValidation(inputData);
		
		LLog.info.write("\n RetrieveCostTotLedgerMstValidationCmd result:" + result.toString());		
		//req.setAttribute("resultData", result);

		// Header 를 설정한다.
		gds.addDataColumn( new GauceDataColumn( "chk"             , GauceDataColumn.TB_STRING   , 1     ) ); //
		gds.addDataColumn( new GauceDataColumn( "companyCd"       , GauceDataColumn.TB_STRING   , 4     ) ); //
        gds.addDataColumn( new GauceDataColumn( "deptCd"          , GauceDataColumn.TB_STRING   , 4     ) ); //
        gds.addDataColumn( new GauceDataColumn( "deptNm"          , GauceDataColumn.TB_STRING   , 100   ) ); //
        gds.addDataColumn( new GauceDataColumn( "docYm"           , GauceDataColumn.TB_STRING   , 6     ) ); //
        gds.addDataColumn( new GauceDataColumn( "docSeq"          , GauceDataColumn.TB_STRING   , 10    ) ); //
        gds.addDataColumn( new GauceDataColumn( "amount"          , GauceDataColumn.TB_DECIMAL  , 13, 2 ) ); //
        gds.addDataColumn( new GauceDataColumn( "docType"         , GauceDataColumn.TB_STRING   , 1     ) ); //
        gds.addDataColumn( new GauceDataColumn( "currencyCd"      , GauceDataColumn.TB_STRING   , 3     ) ); //
        gds.addDataColumn( new GauceDataColumn( "createDate"      , GauceDataColumn.TB_STRING   , 10    ) ); //
        gds.addDataColumn( new GauceDataColumn( "docDate"         , GauceDataColumn.TB_STRING   , 10    ) ); // 		
        gds.addDataColumn( new GauceDataColumn( "postDate"        , GauceDataColumn.TB_STRING   , 10    ) ); //
        gds.addDataColumn( new GauceDataColumn( "errorMsg"        , GauceDataColumn.TB_STRING   , 200   ) ); // 		
        gds.addDataColumn( new GauceDataColumn( "valiSuccessYn"   , GauceDataColumn.TB_STRING   , 1     ) ); //
        gds.addDataColumn( new GauceDataColumn( "valiSuccessNm"   , GauceDataColumn.TB_STRING   , 10     ) ); //
        gds.addDataColumn( new GauceDataColumn( "docDiv"          , GauceDataColumn.TB_STRING   , 1     ) ); // 		
        gds.addDataColumn( new GauceDataColumn( "docDivNm"        , GauceDataColumn.TB_STRING   , 50    ) ); // 		
        //gds.addDataColumn( new GauceDataColumn( "consultationDocNo"        , GauceDataColumn.TB_STRING   , 50    ) ); // 		
		
	    LGauceConverter.convertToGauceDataSet(result, gds);
	    gds.flush();
	    
		LLog.info.write("\n RetrieveCostTotLedgerMstValidationCmd --> End \n");		
		
    }
}
