/*
 *-------------------------------------------------------------------------------
 * RetrieveRequestedAssetListCmd.java 
 * 
 * PROJ : PT-PAM 
 * Copyright 2006-2007 LG CNS All rights reserved
 *-------------------------------------------------------------------------------
 *                  변         경         사         항
 *-------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2015/12/24   hckim   Init
 *-------------------------------------------------------------------------------
 */

package fi.at.cmd;

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
import fi.at.biz.AssetBiz;

public class RetrieveRequestedAssetListCmd implements LGauceCommandIF  {
    
	/**
     * @param req Http Request 객체.
     * @param res Http Response 객체.
     * @param gauceRequest 가우스 Request 객체.
     * @param gauceResponse 가우스 Response 객체.
     * @exception LException Commnad 단 이하의 모든 에러.
     */
	public void execute(HttpServletRequest req, HttpServletResponse res, 
            GauceRequest gauceRequest, GauceResponse gauceResponse) throws LException {
		 
		LLog.info.write("\n RetrieveRequestedAssetListCmd --> Start \n");		

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
	    
	    LLog.info.write("===================  Requested Asset List 조회 PARAM  ======================");
	    LLog.info.write("requestDateFrom :" + inputData.getString("requestDateFrom"));
	    LLog.info.write("requestDateTo   :" + inputData.getString("requestDateTo"));
	    LLog.info.write("assetNm         :" + inputData.getString("assetNm"));
	    LLog.info.write("requestType     :" + inputData.getString("requestType"));
	    LLog.info.write("sapStatus       :" + inputData.getString("sapStatus"));	   
	    LLog.info.write("companyCd       :" + inputData.getString("companyCd"));
	    LLog.info.write("lang            :" + inputData.getString("lang"));
	    LLog.info.write("============================================================================");
	    
	    AssetBiz biz = new AssetBiz();
	    
	    // 요청된 자산취득 정보 목록 조회
		LMultiData result = biz.retrieveRequestedAssetList(inputData);
		
		LLog.info.write("\n RetrieveRequestedAssetListCmd result:" + result.toString());				
 
		// Header 를 설정한다.
		gds.addDataColumn( new GauceDataColumn( "requestNo"      , GauceDataColumn.TB_STRING   , 50   ) );
        gds.addDataColumn( new GauceDataColumn( "assetNm"        , GauceDataColumn.TB_STRING   , 50   ) );
        gds.addDataColumn( new GauceDataColumn( "requestType"    , GauceDataColumn.TB_STRING   , 50   ) );
        gds.addDataColumn( new GauceDataColumn( "requestTypeNm"  , GauceDataColumn.TB_STRING   , 50   ) );
        gds.addDataColumn( new GauceDataColumn( "sapStatus"      , GauceDataColumn.TB_STRING   , 50   ) );   
        gds.addDataColumn( new GauceDataColumn( "sapStatusNm"    , GauceDataColumn.TB_STRING   , 50   ) );
        gds.addDataColumn( new GauceDataColumn( "amount"         , GauceDataColumn.TB_DECIMAL  , 13, 2) );
        gds.addDataColumn( new GauceDataColumn( "currCd"         , GauceDataColumn.TB_STRING   , 50   ) );        
        gds.addDataColumn( new GauceDataColumn( "qty"            , GauceDataColumn.TB_STRING   , 50   ) );
        gds.addDataColumn( new GauceDataColumn( "acqDate"        , GauceDataColumn.TB_STRING   , 50   ) );
        gds.addDataColumn( new GauceDataColumn( "assetDesc"      , GauceDataColumn.TB_STRING   , 500  ) );
        gds.addDataColumn( new GauceDataColumn( "costCenter"     , GauceDataColumn.TB_STRING   , 50   ) );
        gds.addDataColumn( new GauceDataColumn( "costCenterNm"   , GauceDataColumn.TB_STRING   , 50   ) );                
        gds.addDataColumn( new GauceDataColumn( "vendCd"         , GauceDataColumn.TB_STRING   , 50   ) );
        gds.addDataColumn( new GauceDataColumn( "vendNm"         , GauceDataColumn.TB_STRING   , 50   ) );
        gds.addDataColumn( new GauceDataColumn( "assetNo"        , GauceDataColumn.TB_STRING   , 50   ) );
        gds.addDataColumn( new GauceDataColumn( "docNo"          , GauceDataColumn.TB_STRING   , 50   ) );
        gds.addDataColumn( new GauceDataColumn( "fileName"       , GauceDataColumn.TB_STRING   , 500  ) );
        gds.addDataColumn( new GauceDataColumn( "fileUrl"        , GauceDataColumn.TB_STRING   , 500  ) );
        gds.addDataColumn( new GauceDataColumn( "companyCd"      , GauceDataColumn.TB_STRING   , 50   ) );
        
	    LGauceConverter.convertToGauceDataSet(result, gds); 
	    gds.flush();
	    
		LLog.info.write("\n RetrieveRequestedAssetListCmd --> End \n");		
		
    }
}
