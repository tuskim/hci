/*
 *-------------------------------------------------------------------------------
 * RetrieveRequestListCmd.java 
 * 
 * PROJ : PT-PAM 
 * Copyright 2006-2007 LG CNS All rights reserved
 *-------------------------------------------------------------------------------
 *                  변         경         사         항
 *-------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2015/12/14   hckim   Init
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

public class RetrieveRequestListCmd implements LGauceCommandIF  {
    
	/**
     * @param req Http Request 객체.
     * @param res Http Response 객체.
     * @param gauceRequest 가우스 Request 객체.
     * @param gauceResponse 가우스 Response 객체.
     * @exception LException Commnad 단 이하의 모든 에러.
     */
	public void execute(HttpServletRequest req, HttpServletResponse res, 
            GauceRequest gauceRequest, GauceResponse gauceResponse) throws LException {
		 
		LLog.info.write("\n RetrieveRequestListCmd --> Start \n");		

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
	    
	    LLog.info.write("===================  Payment Request List 조회 PARAM  ======================");
	    LLog.info.write("requestDateFrom :" + inputData.getString("requestDateFrom"));
	    LLog.info.write("requestDateTo   :" + inputData.getString("requestDateTo"));
	    LLog.info.write("baselineDate    :" + inputData.getString("baselineDate"));
	    LLog.info.write("status          :" + inputData.getString("status"));
	    LLog.info.write("vendCd          :" + inputData.getString("vendCd"));
	    LLog.info.write("currCd          :" + inputData.getString("currCd"));
	    LLog.info.write("companyCd       :" + inputData.getString("companyCd"));
	    LLog.info.write("lang            :" + inputData.getString("lang"));
	    LLog.info.write("============================================================================");
	    
	    PaymentBiz biz = new PaymentBiz();
		LMultiData result = biz.retrieveRequestList(inputData);
		
		LLog.info.write("\n RetrieveRequestListCmd result:" + result.toString());				
 
		// Header 를 설정한다.
		gds.addDataColumn( new GauceDataColumn( "chk"             , GauceDataColumn.TB_STRING   , 1    ) );
		gds.addDataColumn( new GauceDataColumn( "requestNo"       , GauceDataColumn.TB_STRING   , 20   ) );
        gds.addDataColumn( new GauceDataColumn( "requestDate"     , GauceDataColumn.TB_STRING   , 10   ) );
        gds.addDataColumn( new GauceDataColumn( "vendCd"          , GauceDataColumn.TB_STRING   , 10   ) );
        gds.addDataColumn( new GauceDataColumn( "vendNm"          , GauceDataColumn.TB_STRING   , 40   ) );   
        gds.addDataColumn( new GauceDataColumn( "paymentMethod"   , GauceDataColumn.TB_STRING   , 10   ) );
        gds.addDataColumn( new GauceDataColumn( "paymentMethodNm" , GauceDataColumn.TB_STRING   , 80   ) );
        gds.addDataColumn( new GauceDataColumn( "partnerBankType" , GauceDataColumn.TB_STRING   , 10   ) );        
        gds.addDataColumn( new GauceDataColumn( "baselineDate"    , GauceDataColumn.TB_STRING   , 10   ) );
        gds.addDataColumn( new GauceDataColumn( "currCd"          , GauceDataColumn.TB_STRING   , 10   ) );
        gds.addDataColumn( new GauceDataColumn( "totalAmount"     , GauceDataColumn.TB_DECIMAL  , 13, 2) );
        gds.addDataColumn( new GauceDataColumn( "status"          , GauceDataColumn.TB_STRING   , 10   ) );
        gds.addDataColumn( new GauceDataColumn( "statusNm"        , GauceDataColumn.TB_STRING   , 10   ) );                
        gds.addDataColumn( new GauceDataColumn( "sapRtnMsg"       , GauceDataColumn.TB_STRING   , 80   ) );
        gds.addDataColumn( new GauceDataColumn( "companyCd"       , GauceDataColumn.TB_STRING   , 10   ) );
     
	    LGauceConverter.convertToGauceDataSet(result, gds); 
	    gds.flush();
	    
		LLog.info.write("\n RetrieveRequestListCmd --> End \n");		
		
    }
}
