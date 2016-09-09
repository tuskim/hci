/*
 *-------------------------------------------------------------------------------
 * RetrievePaymentRequestListPrintCmd.java 
 * 
 * PROJ : PT-PAM 
 * Copyright 2006-2007 LG CNS All rights reserved
 *-------------------------------------------------------------------------------
 *                  변         경         사         항
 *-------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2015/12/17   hckim   Init
 *-------------------------------------------------------------------------------
 */

package fi.tr.cmd;

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
import devonframework.front.channel.LNavigationAlter;
import fi.tr.biz.PaymentBiz;

public class RetrievePaymentRequestListPrintCmd implements LGauceCommandIF  {
    
	/**
     * @param req Http Request 객체.
     * @param res Http Response 객체.
     * @param gauceRequest 가우스 Request 객체.
     * @param gauceResponse 가우스 Response 객체.
     * @exception LException Commnad 단 이하의 모든 에러.
     */
	public void execute(HttpServletRequest req, HttpServletResponse res, 
            GauceRequest gauceRequest, GauceResponse gauceResponse) throws LException {
		 
		LLog.info.write("\n RetrievePaymentRequestListPrintCmd --> Start \n");		

		GauceDataSet gds = new GauceDataSet();
		gauceResponse.enableFirstRow(gds);

		GauceDataSet requestListGds = gauceRequest.getGauceDataSet("IN_DS1");
		LData inputData = LXssCollectionUtility.getData(req);

		long  getErrorCode = 0 ;
        String getMessage  = "";
        GauceDataSet ds_report = new GauceDataSet("ds_report");
        
		//-------------------------------------- Session 종료시 처리 START
  		HttpSession session = req.getSession(false);
  		LData loginUser = new LData();
  		
  		if (session != null) loginUser = (LData)session.getAttribute("loginUser");
  		if( loginUser.getString("userId") == null) {
  			getMessage = "Session is Terminated. You need to relogin!";
  			gauceResponse.writeException("Error", String.valueOf(getErrorCode), "\n[Detail Msg]==>" + getMessage);
  			LNavigationAlter.setReturnUrl(req, "/index.jsp");
  			return;
  		}
  		//-------------------------------------- Session 종료시 처리 END
	    
	    //회사코드 추가.
	    inputData.setString("companyCd", loginUser.getString("companyCd"));
	    inputData.setString("lang",      loginUser.getString("lang"));
	    
	    LMultiData mData = LGauceConverter.convertToLMultiDataWithJobType(requestListGds);
	    	    	    
	    LLog.info.write("===================  Payment Request List Print 조회 PARAM  ======================");	   
	    LLog.info.write("companyCd       :" + inputData.getString("companyCd"));
	    LLog.info.write("lang            :" + inputData.getString("lang"));
	    LLog.debug.write("RetrievePaymentRequestListPrintCmd mData (Request List 원본 데이타) ---------------> =>\n " + mData.toString());
	    LLog.info.write("==================================================================================");
	    
	    PaymentBiz biz = new PaymentBiz();
		LMultiData result = biz.retrieveRequestListPrint(inputData, mData);
		
		LLog.info.write("\n RetrievePaymentRequestListPrintCmd result:" + result.toString());				
 
		// Header 를 설정한다.		
		ds_report.addDataColumn( new GauceDataColumn( "requestNo"       , GauceDataColumn.TB_STRING   , 50   ) );
		ds_report.addDataColumn( new GauceDataColumn( "requestDate"     , GauceDataColumn.TB_STRING   , 50   ) );
		ds_report.addDataColumn( new GauceDataColumn( "currCd"          , GauceDataColumn.TB_STRING   , 50   ) );
		ds_report.addDataColumn( new GauceDataColumn( "amount"          , GauceDataColumn.TB_DECIMAL  , 13, 2) );
		ds_report.addDataColumn( new GauceDataColumn( "docNo"           , GauceDataColumn.TB_STRING   , 50   ) );   
		ds_report.addDataColumn( new GauceDataColumn( "personnel"       , GauceDataColumn.TB_STRING   , 50   ) );
		ds_report.addDataColumn( new GauceDataColumn( "baselineDate"    , GauceDataColumn.TB_STRING   , 50   ) );
		ds_report.addDataColumn( new GauceDataColumn( "vendor"          , GauceDataColumn.TB_STRING   , 50   ) );        
		ds_report.addDataColumn( new GauceDataColumn( "paymentMethod"   , GauceDataColumn.TB_STRING   , 50   ) );
		ds_report.addDataColumn( new GauceDataColumn( "vendAddr"        , GauceDataColumn.TB_STRING   , 50   ) );
		ds_report.addDataColumn( new GauceDataColumn( "country"         , GauceDataColumn.TB_STRING   , 50   ) );
		ds_report.addDataColumn( new GauceDataColumn( "mstCurrCd"       , GauceDataColumn.TB_STRING   , 50   ) );
		ds_report.addDataColumn( new GauceDataColumn( "exchCurrCd"      , GauceDataColumn.TB_STRING   , 50   ) );                
		ds_report.addDataColumn( new GauceDataColumn( "totalAmount"     , GauceDataColumn.TB_DECIMAL  , 13, 2) );
		ds_report.addDataColumn( new GauceDataColumn( "exchTotalAmount" , GauceDataColumn.TB_DECIMAL  , 13, 2) );
		ds_report.addDataColumn( new GauceDataColumn( "paymentType"     , GauceDataColumn.TB_STRING   , 50   ) );
		ds_report.addDataColumn( new GauceDataColumn( "bankCode"        , GauceDataColumn.TB_STRING   , 50   ) );
		ds_report.addDataColumn( new GauceDataColumn( "bankAcct"        , GauceDataColumn.TB_STRING   , 50   ) );
		ds_report.addDataColumn( new GauceDataColumn( "houseBank"       , GauceDataColumn.TB_STRING   , 200  ) );
     
	    gauceResponse.enableFirstRow( ds_report ); 	
		LGauceConverter.convertToGauceDataSet( result, ds_report ); 		 
	    ds_report.flush();
	    
		LLog.info.write("\n RetrievePaymentRequestListPrintCmd --> End \n");		
		
    }
}
