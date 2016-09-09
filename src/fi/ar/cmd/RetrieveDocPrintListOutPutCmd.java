/*
 *------------------------------------------------------------------------------
 * RetrieveDocPrintListCmd.java,v 1.0 2010/10/06 16:43:35 
 * 
 * PROJ : PT-PAM
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2010/10/06   노태훈   Init
 *----------------------------------------------------------------------------
 */

package fi.ar.cmd;

import fi.ar.biz.DocPrintBiz;

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
public class RetrieveDocPrintListOutPutCmd implements LGauceCommandIF  {
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
		 
		LLog.info.write("\n RetrieveDocPrintListOutPutCmd --> Start \n");		

		GauceDataSet gds = new GauceDataSet();
		gauceResponse.enableFirstRow(gds); 
		LMultiData mData = LGauceConverter.convertToLMultiDataWithJobType(gauceRequest.getGauceDataSet("ds_dummy"));
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
	    inputData.setString("userId",   loginUser.getString("userId"));
	    inputData.setString("lang",     loginUser.getString("lang"));
	    inputData.setString("companyCd",loginUser.getString("companyCd"));
	    inputData.setString("deptCd",loginUser.getString("deptCd"));
	    inputData.setString("userNm",loginUser.getString("userNm"));
	    
	    GauceDataSet 	ds_report 	= new GauceDataSet("ds_report");
		 
	    DocPrintBiz biz = new DocPrintBiz();
		LMultiData result = biz.retrieveDocPrintListOutPut(inputData,mData);
 
	    ds_report.addDataColumn( new GauceDataColumn( "chk"             , GauceDataColumn.TB_STRING   , 1    ) ); 
	    ds_report.addDataColumn( new GauceDataColumn( "companyCd"       , GauceDataColumn.TB_STRING   , 4    ) ); //BUKRS      
	    ds_report.addDataColumn( new GauceDataColumn( "fiscalYear"      , GauceDataColumn.TB_STRING   , 4    ) ); //GJAHR      
	    ds_report.addDataColumn( new GauceDataColumn( "docNo"           , GauceDataColumn.TB_STRING   , 10   ) ); //BELNR      
	    ds_report.addDataColumn( new GauceDataColumn( "docType"         , GauceDataColumn.TB_STRING   , 2    ) ); //BLART      
	    ds_report.addDataColumn( new GauceDataColumn( "docTypeDec"      , GauceDataColumn.TB_STRING   , 20   ) ); //BLART_Des  
	    ds_report.addDataColumn( new GauceDataColumn( "curr"            , GauceDataColumn.TB_STRING   , 20   ) ); //WAERS
	    ds_report.addDataColumn( new GauceDataColumn( "totLineItem"     , GauceDataColumn.TB_STRING   , 3    ) ); //BUZEI_Total
	    ds_report.addDataColumn( new GauceDataColumn( "docDate"         , GauceDataColumn.TB_STRING   , 8    ) ); //BLDAT      
	    ds_report.addDataColumn( new GauceDataColumn( "postDate"        , GauceDataColumn.TB_STRING   , 8    ) ); //BUDAT      
	    ds_report.addDataColumn( new GauceDataColumn( "reverseWith"     , GauceDataColumn.TB_STRING   , 10   ) ); //STBLG      
	    ds_report.addDataColumn( new GauceDataColumn( "lineItemCnt"     , GauceDataColumn.TB_STRING   , 3    ) ); //BUZEI_1    
	    ds_report.addDataColumn( new GauceDataColumn( "postKey"         , GauceDataColumn.TB_STRING   , 2    ) ); //BSCHL
	    ds_report.addDataColumn( new GauceDataColumn( "indcator"        , GauceDataColumn.TB_STRING   , 2    ) ); //SHKZG
	    ds_report.addDataColumn( new GauceDataColumn( "glAccount"       , GauceDataColumn.TB_STRING   , 10   ) ); //HKONT      
	    ds_report.addDataColumn( new GauceDataColumn( "glAccountDec"    , GauceDataColumn.TB_STRING   , 40   ) ); //HKONT_Des  
	    ds_report.addDataColumn( new GauceDataColumn( "customer"        , GauceDataColumn.TB_STRING   , 10   ) ); //KUNNR      
	    ds_report.addDataColumn( new GauceDataColumn( "customerDec"     , GauceDataColumn.TB_STRING   , 40   ) ); //KUNNR_Des  
	    ds_report.addDataColumn( new GauceDataColumn( "vendor"          , GauceDataColumn.TB_STRING   , 10   ) ); //LIFNR      
	    ds_report.addDataColumn( new GauceDataColumn( "vendorDec"       , GauceDataColumn.TB_STRING   , 40   ) ); //LIFNR_Des  
	    ds_report.addDataColumn( new GauceDataColumn( "taxCd"           , GauceDataColumn.TB_STRING   , 2    ) ); //MWSKZ      
	    ds_report.addDataColumn( new GauceDataColumn( "taxCdDec"        , GauceDataColumn.TB_STRING   , 10   ) ); //MWSKZ_Des  
	    ds_report.addDataColumn( new GauceDataColumn( "profitCenter"    , GauceDataColumn.TB_STRING   , 10   ) ); //PRCTR      
	    ds_report.addDataColumn( new GauceDataColumn( "profitCenterDec" , GauceDataColumn.TB_STRING   , 20   ) ); //PRCTR_Des  
	    ds_report.addDataColumn( new GauceDataColumn( "baselineDate"    , GauceDataColumn.TB_STRING   , 8    ) ); //ZFBDT      
	    ds_report.addDataColumn( new GauceDataColumn( "dueDate"         , GauceDataColumn.TB_STRING   , 8    ) ); //ZFBDT_due  
	    ds_report.addDataColumn( new GauceDataColumn( "costCenter"      , GauceDataColumn.TB_STRING   , 10   ) ); //KOSTL      
	    ds_report.addDataColumn( new GauceDataColumn( "interOrder"      , GauceDataColumn.TB_STRING   , 10   ) ); //AUFNR      
	    ds_report.addDataColumn( new GauceDataColumn( "materialNo"      , GauceDataColumn.TB_STRING   , 18   ) ); //MATNR      
	    ds_report.addDataColumn( new GauceDataColumn( "qty"             , GauceDataColumn.TB_STRING  ,  20   ) ); //MENGE      
	    ds_report.addDataColumn( new GauceDataColumn( "unit"            , GauceDataColumn.TB_STRING   , 3    ) ); //MEINS      
	    ds_report.addDataColumn( new GauceDataColumn( "docAmt"          , GauceDataColumn.TB_STRING  ,  20   ) ); //WRBTE      
	    ds_report.addDataColumn( new GauceDataColumn( "localAmt"        , GauceDataColumn.TB_STRING  ,  20   ) ); //DMBTR      
	    ds_report.addDataColumn( new GauceDataColumn( "text"            , GauceDataColumn.TB_STRING   , 50   ) ); //SGTXT      
	    ds_report.addDataColumn( new GauceDataColumn( "poNo"            , GauceDataColumn.TB_STRING   , 18   ) ); //XREF1      
	    ds_report.addDataColumn( new GauceDataColumn( "soNo"            , GauceDataColumn.TB_STRING   , 12   ) ); //XREF2      
	    ds_report.addDataColumn( new GauceDataColumn( "type"            , GauceDataColumn.TB_STRING   , 18   ) ); //XREF3      
	    ds_report.addDataColumn( new GauceDataColumn( "assign"          , GauceDataColumn.TB_STRING   , 18   ) ); //ZOUNR  
	    ds_report.addDataColumn( new GauceDataColumn( "webDoc"          , GauceDataColumn.TB_STRING    , 30   ) ); //DOCSQ          
 
	    //사용자 정보
	    ds_report.addDataColumn( new GauceDataColumn( "userId"          , GauceDataColumn.TB_STRING   , 100  ) ); //SGTXT      
	    ds_report.addDataColumn( new GauceDataColumn( "runDate"         , GauceDataColumn.TB_STRING   , 100  ) ); //XREF1      
	    ds_report.addDataColumn( new GauceDataColumn( "runTime"         , GauceDataColumn.TB_STRING   , 100  ) ); //XREF2    
	    ds_report.addDataColumn( new GauceDataColumn( "deptCd"          , GauceDataColumn.TB_STRING   , 100  ) ); //XREF2
	    ds_report.addDataColumn( new GauceDataColumn( "userNm"          , GauceDataColumn.TB_STRING   , 100  ) ); //XREF2
	    
	    ds_report.addDataColumn( new GauceDataColumn( "cVendorCustomer" , GauceDataColumn.TB_STRING   , 100  ) ); //SGTXT      
	    ds_report.addDataColumn( new GauceDataColumn( "cProfitCenter"   , GauceDataColumn.TB_STRING   , 100  ) ); //XREF1      
	    ds_report.addDataColumn( new GauceDataColumn( "cTaxCd"          , GauceDataColumn.TB_STRING   , 100  ) ); //XREF2      
	    ds_report.addDataColumn( new GauceDataColumn( "dLocalAmt"       , GauceDataColumn.TB_STRING   , 20   ) ); //XREF3      
	    ds_report.addDataColumn( new GauceDataColumn( "dTotLocalAmt"    , GauceDataColumn.TB_DECIMAL  , 13,3 ) ); //XREF3      
	    ds_report.addDataColumn( new GauceDataColumn( "cLocalAmt"       , GauceDataColumn.TB_STRING  ,  20   ) ); //ZOUNR 
	    ds_report.addDataColumn( new GauceDataColumn( "cTotLocalAmt"       , GauceDataColumn.TB_DECIMAL  , 13,3 ) ); //ZOUNR 
	    ds_report.addDataColumn( new GauceDataColumn( "dGlAccount"      , GauceDataColumn.TB_STRING   , 100  ) ); //SGTXT      
	    ds_report.addDataColumn( new GauceDataColumn( "dGlAccountDec"   , GauceDataColumn.TB_STRING   , 100  ) ); //XREF1  
	    ds_report.addDataColumn( new GauceDataColumn( "cGlAccount"      , GauceDataColumn.TB_STRING   , 100  ) ); //SGTXT      
	    ds_report.addDataColumn( new GauceDataColumn( "cGlAccountDec"   , GauceDataColumn.TB_STRING   , 100  ) ); //XREF1   
	    ds_report.addDataColumn( new GauceDataColumn( "cDocType"        , GauceDataColumn.TB_STRING   , 100  ) ); ///BLART BLART_Des	    
	    ds_report.addDataColumn( new GauceDataColumn( "totDocQty"       , GauceDataColumn.TB_DECIMAL  , 13,3) ); //XREF2
	    ds_report.addDataColumn( new GauceDataColumn( "totLiQty"        , GauceDataColumn.TB_DECIMAL  , 13,3) ); //XREF2
	    ds_report.addDataColumn( new GauceDataColumn( "debitQty"        , GauceDataColumn.TB_DECIMAL  , 13,3) ); //XREF2
	    ds_report.addDataColumn( new GauceDataColumn( "creditQty"       , GauceDataColumn.TB_DECIMAL  , 13,3) ); //XREF2
	    ds_report.addDataColumn( new GauceDataColumn( "totAmt"          , GauceDataColumn.TB_DECIMAL  , 13,3 ) ); //XREF2    
 
		gauceResponse.enableFirstRow( ds_report ); 	
		LGauceConverter.convertToGauceDataSet( result, ds_report );        
		ds_report.flush();
	    
		LLog.info.write("\n RetrieveDocPrintListOutPutCmd --> End \n");		
		
    }
}
