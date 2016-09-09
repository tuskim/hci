/*
 *------------------------------------------------------------------------------
 * RetrieveDocPrintWebPopListOutPutCmd.java,v 1.0 2010/10/06 16:43:35 
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

import fi.ar.biz.DocPrintWebPopBiz;

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
public class RetrieveDocPrintWebPopListOutPutCmd implements LGauceCommandIF  {
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
		 
		LLog.info.write("\n RetrieveDocPrintWebPopListOutPutCmd --> Start \n");		

		GauceDataSet gds = new GauceDataSet();
		gauceResponse.enableFirstRow(gds); 
		LMultiData mData = LGauceConverter.convertToLMultiDataWithJobType(gauceRequest.getGauceDataSet("ds_dummy"));
		
		LData inputData = LXssCollectionUtility.getData(req);

		long  getErrorCode = 0 ;
        String getMessage   = "";
        GauceDataSet 	ds_report 	= new GauceDataSet("ds_report");
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
	    inputData.setString("lang",loginUser.getString("lang"));
	    DocPrintWebPopBiz biz = new DocPrintWebPopBiz(); 
		LMultiData result = biz.retrieveDocPrintWebPopListOutPut(inputData,mData);
 
		
	    ds_report.addDataColumn( new GauceDataColumn( "docYmSeq"        , GauceDataColumn.TB_STRING   , 100  ) ); 
	    ds_report.addDataColumn( new GauceDataColumn( "deptCd"          , GauceDataColumn.TB_STRING   , 100  ) ); //BUKRS      
	    ds_report.addDataColumn( new GauceDataColumn( "docYm"           , GauceDataColumn.TB_STRING   , 100  ) ); //GJAHR      
	    ds_report.addDataColumn( new GauceDataColumn( "docSeq"          , GauceDataColumn.TB_STRING   , 100  ) ); //BELNR      
	    ds_report.addDataColumn( new GauceDataColumn( "createType"      , GauceDataColumn.TB_STRING   , 100  ) ); //BLART      
	    ds_report.addDataColumn( new GauceDataColumn( "docType"         , GauceDataColumn.TB_STRING   , 100  ) ); //BLART_Des  
	    ds_report.addDataColumn( new GauceDataColumn( "createDate"      , GauceDataColumn.TB_STRING   , 100  ) ); //WAERS
	    ds_report.addDataColumn( new GauceDataColumn( "docDate"        , GauceDataColumn.TB_STRING   , 100  ) ); //BUZEI_Total
	    ds_report.addDataColumn( new GauceDataColumn( "postDate"        , GauceDataColumn.TB_STRING   , 100  ) ); //BLDAT      
	    ds_report.addDataColumn( new GauceDataColumn( "cVendorCustumer" , GauceDataColumn.TB_STRING   , 100  ) ); //BUDAT      
	    ds_report.addDataColumn( new GauceDataColumn( "sapAcctV"        , GauceDataColumn.TB_STRING   , 100  ) ); //STBLG      
	    ds_report.addDataColumn( new GauceDataColumn( "sapAcctC"        , GauceDataColumn.TB_STRING   , 100  ) ); //BUZEI_1    
	    ds_report.addDataColumn( new GauceDataColumn( "delYn"           , GauceDataColumn.TB_STRING   , 100  ) ); //BSCHL
	    ds_report.addDataColumn( new GauceDataColumn( "progStatus"      , GauceDataColumn.TB_STRING   , 100  ) ); //SHKZG
	    ds_report.addDataColumn( new GauceDataColumn( "progStatusDate"  , GauceDataColumn.TB_STRING   , 100  ) ); //HKONT      
	    ds_report.addDataColumn( new GauceDataColumn( "progStatusTime"  , GauceDataColumn.TB_STRING   , 100  ) ); //HKONT_Des  
	    ds_report.addDataColumn( new GauceDataColumn( "transDate"       , GauceDataColumn.TB_STRING   , 100  ) ); //KUNNR      
	    ds_report.addDataColumn( new GauceDataColumn( "transTime"       , GauceDataColumn.TB_STRING   , 100  ) ); //KUNNR_Des  
	    ds_report.addDataColumn( new GauceDataColumn( "sapDocSeq"       , GauceDataColumn.TB_STRING   , 100  ) ); //LIFNR      
	    ds_report.addDataColumn( new GauceDataColumn( "successType"     , GauceDataColumn.TB_STRING   , 100  ) ); //LIFNR_Des  
	    ds_report.addDataColumn( new GauceDataColumn( "currencyCd"      , GauceDataColumn.TB_STRING   , 100  ) ); //MWSKZ      
	    ds_report.addDataColumn( new GauceDataColumn( "docNum"          , GauceDataColumn.TB_STRING   , 100  ) ); //MWSKZ_Des  
	    ds_report.addDataColumn( new GauceDataColumn( "acctCd"          , GauceDataColumn.TB_STRING   , 100  ) ); //PRCTR      
	    ds_report.addDataColumn( new GauceDataColumn( "spglNo"          , GauceDataColumn.TB_STRING   , 100  ) ); //PRCTR_Des  
	    ds_report.addDataColumn( new GauceDataColumn( "dGlAccountDec"   , GauceDataColumn.TB_STRING   , 100  ) ); //ZFBDT      
	    ds_report.addDataColumn( new GauceDataColumn( "cGlAccountDec"   , GauceDataColumn.TB_STRING   , 100  ) ); //ZFBDT_due  
	    ds_report.addDataColumn( new GauceDataColumn( "sapAcctNm"       , GauceDataColumn.TB_STRING   , 100  ) ); //KOSTL      
	    ds_report.addDataColumn( new GauceDataColumn( "amount"          , GauceDataColumn.TB_DECIMAL  , 13,3 ) ); //AUFNR      
	    ds_report.addDataColumn( new GauceDataColumn( "dLocalAmt"       , GauceDataColumn.TB_DECIMAL  , 13,3 ) ); //MATNR      
	    ds_report.addDataColumn( new GauceDataColumn( "cLocalAmt"       , GauceDataColumn.TB_DECIMAL  , 13,3 ) ); //MENGE      
	    ds_report.addDataColumn( new GauceDataColumn( "areaCd"          , GauceDataColumn.TB_STRING   , 100  ) ); //MEINS      
	    ds_report.addDataColumn( new GauceDataColumn( "divCd"           , GauceDataColumn.TB_STRING   , 100  ) ); //WRBTE
	    ds_report.addDataColumn( new GauceDataColumn( "blockCd"         , GauceDataColumn.TB_STRING   , 100  ) ); //WRBTE      
	    ds_report.addDataColumn( new GauceDataColumn( "yearCd"          , GauceDataColumn.TB_STRING   , 100  ) ); //DMBTR      
	    ds_report.addDataColumn( new GauceDataColumn( "tmTbm"           , GauceDataColumn.TB_STRING   , 100  ) ); //SGTXT      
	    ds_report.addDataColumn( new GauceDataColumn( "docDesc"         , GauceDataColumn.TB_STRING   , 100  ) ); //XREF1      
	    ds_report.addDataColumn( new GauceDataColumn( "delYnDtl"        , GauceDataColumn.TB_STRING   , 100  ) ); //XREF2      
	    ds_report.addDataColumn( new GauceDataColumn( "returnMsg"       , GauceDataColumn.TB_STRING   , 100  ) ); //XREF3      
	    ds_report.addDataColumn( new GauceDataColumn( "dGlAccount"      , GauceDataColumn.TB_STRING   , 100  ) ); //ZOUNR  
	    ds_report.addDataColumn( new GauceDataColumn( "cGlAccount"      , GauceDataColumn.TB_STRING   , 100  ) ); //DOCSQ          
	    ds_report.addDataColumn( new GauceDataColumn( "attr2"           , GauceDataColumn.TB_STRING   , 100  ) ); //SGTXT      
	    ds_report.addDataColumn( new GauceDataColumn( "vatCd"           , GauceDataColumn.TB_STRING   , 100  ) ); //XREF1      
	    ds_report.addDataColumn( new GauceDataColumn( "cTaxCd"          , GauceDataColumn.TB_STRING   , 100  ) ); //XREF2    
	    ds_report.addDataColumn( new GauceDataColumn( "attr4"           , GauceDataColumn.TB_STRING   , 100  ) ); //XREF2
	    ds_report.addDataColumn( new GauceDataColumn( "attr5"           , GauceDataColumn.TB_STRING   , 100  ) ); //XREF2	    
	    ds_report.addDataColumn( new GauceDataColumn( "attr6"           , GauceDataColumn.TB_STRING   , 100  ) ); //SGTXT      
	    ds_report.addDataColumn( new GauceDataColumn( "attr7"           , GauceDataColumn.TB_STRING   , 100  ) ); //XREF1      
	    ds_report.addDataColumn( new GauceDataColumn( "costCenter"      , GauceDataColumn.TB_STRING   , 100  ) ); //XREF2      
	    ds_report.addDataColumn( new GauceDataColumn( "costCenterNm"    , GauceDataColumn.TB_STRING   , 100  ) ); //XREF3      
	    ds_report.addDataColumn( new GauceDataColumn( "interOrder"      , GauceDataColumn.TB_STRING   , 100  ) ); //XREF3      
	    ds_report.addDataColumn( new GauceDataColumn( "attr10"          , GauceDataColumn.TB_STRING   , 100  ) ); //ZOUNR 
	    ds_report.addDataColumn( new GauceDataColumn( "regid"           , GauceDataColumn.TB_STRING   , 100  ) ); //ZOUNR 
	    ds_report.addDataColumn( new GauceDataColumn( "regdate"         , GauceDataColumn.TB_STRING   , 100  ) ); //SGTXT      
	    ds_report.addDataColumn( new GauceDataColumn( "regtime"         , GauceDataColumn.TB_STRING   , 100  ) ); //XREF1  
	    ds_report.addDataColumn( new GauceDataColumn( "modid"           , GauceDataColumn.TB_STRING   , 100  ) ); //SGTXT      
	    ds_report.addDataColumn( new GauceDataColumn( "moddate"         , GauceDataColumn.TB_STRING   , 100  ) ); //XREF1   
	    ds_report.addDataColumn( new GauceDataColumn( "modtime"         , GauceDataColumn.TB_STRING   , 100  ) ); ///BLART BLART_Des	    
	    ds_report.addDataColumn( new GauceDataColumn( "blockCd2"        , GauceDataColumn.TB_STRING   , 100  ) ); //XREF2
	    ds_report.addDataColumn( new GauceDataColumn( "workCd"          , GauceDataColumn.TB_STRING   , 100  ) ); //XREF2
	    ds_report.addDataColumn( new GauceDataColumn( "workVendor"      , GauceDataColumn.TB_STRING   , 100  ) ); //XREF2
	    ds_report.addDataColumn( new GauceDataColumn( "workYm"          , GauceDataColumn.TB_STRING   , 100  ) ); //XREF2
	    ds_report.addDataColumn( new GauceDataColumn( "attr11"          , GauceDataColumn.TB_STRING   , 100  ) ); //XREF2
	    ds_report.addDataColumn( new GauceDataColumn( "attr12"          , GauceDataColumn.TB_STRING   , 100  ) ); //XREF2    
	    ds_report.addDataColumn( new GauceDataColumn( "attr13"          , GauceDataColumn.TB_STRING   , 100  ) ); //XREF2
	    ds_report.addDataColumn( new GauceDataColumn( "attr14"          , GauceDataColumn.TB_STRING   , 100  ) ); //XREF2
	    ds_report.addDataColumn( new GauceDataColumn( "attr15"          , GauceDataColumn.TB_STRING   , 100  ) ); //XREF2
	    ds_report.addDataColumn( new GauceDataColumn( "attr16"          , GauceDataColumn.TB_STRING   , 100  ) ); //XREF2	 
	    ds_report.addDataColumn( new GauceDataColumn( "attr17"          , GauceDataColumn.TB_STRING   , 100  ) ); //XREF2    
	    ds_report.addDataColumn( new GauceDataColumn( "attr18"          , GauceDataColumn.TB_STRING   , 100  ) ); //XREF2
	    ds_report.addDataColumn( new GauceDataColumn( "attr19"          , GauceDataColumn.TB_STRING   , 100  ) ); //XREF2
	    ds_report.addDataColumn( new GauceDataColumn( "attr20"          , GauceDataColumn.TB_STRING   , 100  ) ); //XREF2
	    ds_report.addDataColumn( new GauceDataColumn( "workRentalType"  , GauceDataColumn.TB_STRING   , 100  ) ); //XREF2	 
	    ds_report.addDataColumn( new GauceDataColumn( "userNm"          , GauceDataColumn.TB_STRING   , 100  ) ); //XREF2	    
	    ds_report.addDataColumn( new GauceDataColumn( "userDept"        , GauceDataColumn.TB_STRING   , 100  ) ); //XREF2	    
	    ds_report.addDataColumn( new GauceDataColumn( "runDate"         , GauceDataColumn.TB_STRING   , 100  ) ); //XREF2	    
	    ds_report.addDataColumn( new GauceDataColumn( "runTime"         , GauceDataColumn.TB_STRING   , 100  ) ); //XREF2	    
	    ds_report.addDataColumn( new GauceDataColumn( "totLiqty"        , GauceDataColumn.TB_DECIMAL  , 13,3 ) ); //XREF2
	    ds_report.addDataColumn( new GauceDataColumn( "debitQty"        , GauceDataColumn.TB_DECIMAL  , 13,3 ) ); //XREF2
	    ds_report.addDataColumn( new GauceDataColumn( "creditQty"       , GauceDataColumn.TB_DECIMAL  , 13,3 ) ); //XREF2
	    ds_report.addDataColumn( new GauceDataColumn( "totAmt"          , GauceDataColumn.TB_DECIMAL  , 13,3 ) ); //XREF2
	    
 
		gauceResponse.enableFirstRow( ds_report ); 	
		LGauceConverter.convertToGauceDataSet( result, ds_report ); 
		 
	    ds_report.flush();
	    
		LLog.info.write("\n RetrieveDocPrintWebPopListOutPutCmd --> End \n");		
		
    }
}
