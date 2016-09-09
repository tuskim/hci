/*
 *-------------------------------------------------------------------------------
 * RetrievePaymentRequestCmd.java 
 * 
 * PROJ : PT-PAM 
 * Copyright 2006-2007 LG CNS All rights reserved
 *-------------------------------------------------------------------------------
 *                  변         경         사         항
 *-------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2015/12/07   hckim   Init
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

public class RetrievePaymentRequestCmd implements LGauceCommandIF  {
    
	/**
     * @param req Http Request 객체.
     * @param res Http Response 객체.
     * @param gauceRequest 가우스 Request 객체.
     * @param gauceResponse 가우스 Response 객체.
     * @exception LException Commnad 단 이하의 모든 에러.
     */
	public void execute(HttpServletRequest req, HttpServletResponse res, 
            GauceRequest gauceRequest, GauceResponse gauceResponse) throws LException {
		 
		LLog.info.write("\n RetrievePaymentRequestCmd --> Start \n");		

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
  			LNavigationAlter.setReturnUrl(req, "/index.jsp");
  			return;
  		}
  		//-------------------------------------- Session 종료시 처리 END
	    
	    //회사코드 추가.
	    inputData.setString("companyCd", loginUser.getString("companyCd"));
	    inputData.setString("lang",      loginUser.getString("lang"));
	    
	    LLog.info.write("===================  Payment Request (Open AP List 정보) 조회 PARAM  ======================");
	    LLog.info.write("companyCd   :" + inputData.getString("companyCd"));
	    LLog.info.write("postDate    :" + inputData.getString("postDate"));
	    LLog.info.write("vendCd      :" + inputData.getString("vendCd"));
	    LLog.info.write("baselineDate:" + inputData.getString("baselineDate"));
	    LLog.info.write("currCd      :" + inputData.getString("currCd"));
	    LLog.info.write("===========================================================================================");
	    
	    PaymentBiz biz = new PaymentBiz();
		LMultiData result = biz.retrieveOpenApList(inputData);
		
		LLog.info.write("\n RetrievePaymentRequestCmd result:" + result.toString());				
 
		// Header 를 설정한다.
		gds.addDataColumn( new GauceDataColumn( "chk"             , GauceDataColumn.TB_STRING   , 1    ) ); // chk
		gds.addDataColumn( new GauceDataColumn( "docNo"           , GauceDataColumn.TB_STRING   , 20   ) ); // SAP Doc No
        gds.addDataColumn( new GauceDataColumn( "lineItem"        , GauceDataColumn.TB_STRING   , 10   ) ); // Item Seq
        gds.addDataColumn( new GauceDataColumn( "vendCd"          , GauceDataColumn.TB_STRING   , 10   ) ); // Vendor Code
        gds.addDataColumn( new GauceDataColumn( "vendNm"          , GauceDataColumn.TB_STRING   , 40   ) ); // Vendor Name   
        gds.addDataColumn( new GauceDataColumn( "acctCd"          , GauceDataColumn.TB_STRING   , 10   ) ); // Account Code        
        gds.addDataColumn( new GauceDataColumn( "acctNm"          , GauceDataColumn.TB_STRING   , 40   ) ); // Account Name
        gds.addDataColumn( new GauceDataColumn( "postDate"        , GauceDataColumn.TB_STRING   , 10   ) ); // Posting Date 
        gds.addDataColumn( new GauceDataColumn( "amount"          , GauceDataColumn.TB_DECIMAL  , 13, 2) ); // AP Amount
        gds.addDataColumn( new GauceDataColumn( "currCd"          , GauceDataColumn.TB_STRING   , 10   ) ); // Currency        
        gds.addDataColumn( new GauceDataColumn( "sapRequestNo"    , GauceDataColumn.TB_STRING   , 10   ) );
        gds.addDataColumn( new GauceDataColumn( "houseBank"       , GauceDataColumn.TB_STRING   , 10   ) );
        gds.addDataColumn( new GauceDataColumn( "sapStatus"       , GauceDataColumn.TB_STRING   , 10   ) );
        gds.addDataColumn( new GauceDataColumn( "fiscalYear"      , GauceDataColumn.TB_STRING   , 10   ) );
        gds.addDataColumn( new GauceDataColumn( "exchAmount"      , GauceDataColumn.TB_DECIMAL  , 13, 2) );
        gds.addDataColumn( new GauceDataColumn( "exchCurrCd"      , GauceDataColumn.TB_STRING   , 10   ) );
        gds.addDataColumn( new GauceDataColumn( "docDesc"         , GauceDataColumn.TB_STRING   , 10   ) );
        gds.addDataColumn( new GauceDataColumn( "docDate"         , GauceDataColumn.TB_STRING   , 10   ) );
        gds.addDataColumn( new GauceDataColumn( "docType"         , GauceDataColumn.TB_STRING   , 10   ) );
        gds.addDataColumn( new GauceDataColumn( "paymentBlock"    , GauceDataColumn.TB_STRING   , 10   ) );
        gds.addDataColumn( new GauceDataColumn( "personalId"      , GauceDataColumn.TB_STRING   , 10   ) );
        gds.addDataColumn( new GauceDataColumn( "attr1"           , GauceDataColumn.TB_STRING   , 10   ) );
        gds.addDataColumn( new GauceDataColumn( "attr2"           , GauceDataColumn.TB_STRING   , 10   ) );
        gds.addDataColumn( new GauceDataColumn( "attr3"           , GauceDataColumn.TB_STRING   , 10   ) );
        gds.addDataColumn( new GauceDataColumn( "attr4"           , GauceDataColumn.TB_STRING   , 10   ) );
        gds.addDataColumn( new GauceDataColumn( "attr5"           , GauceDataColumn.TB_STRING   , 10   ) );
        gds.addDataColumn( new GauceDataColumn( "attr6"           , GauceDataColumn.TB_STRING   , 10   ) );
        gds.addDataColumn( new GauceDataColumn( "attr7"           , GauceDataColumn.TB_STRING   , 10   ) );
        gds.addDataColumn( new GauceDataColumn( "attr8"           , GauceDataColumn.TB_STRING   , 10   ) );
        gds.addDataColumn( new GauceDataColumn( "attr9"           , GauceDataColumn.TB_STRING   , 10   ) );
        gds.addDataColumn( new GauceDataColumn( "attr10"          , GauceDataColumn.TB_STRING   , 10   ) );         
        gds.addDataColumn( new GauceDataColumn( "baselineDate"    , GauceDataColumn.TB_STRING   , 10   ) );
        gds.addDataColumn( new GauceDataColumn( "paymentMethod"   , GauceDataColumn.TB_STRING   , 10   ) );
        gds.addDataColumn( new GauceDataColumn( "partnerBankType" , GauceDataColumn.TB_STRING   , 10   ) );
        gds.addDataColumn( new GauceDataColumn( "exchRate"        , GauceDataColumn.TB_STRING   , 30   ) );
     
	    LGauceConverter.convertToGauceDataSet(result, gds); 
	    gds.flush();
	    
		LLog.info.write("\n RetrievePaymentRequestCmd --> End \n");		
		
    }
}
