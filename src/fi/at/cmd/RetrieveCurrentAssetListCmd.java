/*
 *-------------------------------------------------------------------------------
 * RetrieveCurrentAssetListCmd.java
 * 
 * PROJ : PT-GAM 
 * Copyright 2006-2007 LG CNS All rights reserved
 *-------------------------------------------------------------------------------
 *                  변         경         사         항
 *-------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2015/12/29   hckim   Init
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

public class RetrieveCurrentAssetListCmd implements LGauceCommandIF  {
    
	/**
     * @param req Http Request 객체.
     * @param res Http Response 객체.
     * @param gauceRequest 가우스 Request 객체.
     * @param gauceResponse 가우스 Response 객체.
     * @exception LException Commnad 단 이하의 모든 에러.
     */
	public void execute(HttpServletRequest req, HttpServletResponse res, 
            GauceRequest gauceRequest, GauceResponse gauceResponse) throws LException {
		 
		LLog.info.write("\n RetrieveCurrentAssetListCmd --> Start \n");		

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
	    
	    LLog.info.write("===================  Asset List (Current Asset List 정보) 조회 PARAM  ======================");
	    LLog.info.write("companyCd  :" + inputData.getString("companyCd"));
	    LLog.info.write("yearMonth  :" + inputData.getString("yearMonth"));
	    LLog.info.write("costCenter :" + inputData.getString("costCenter"));
	    LLog.info.write("assetClass :" + inputData.getString("assetClass"));
	    LLog.info.write("assetNo    :" + inputData.getString("assetNo"));
	    LLog.info.write("assetNm    :" + inputData.getString("assetNm"));	   
	    LLog.info.write("============================================================================================");
	    
	    AssetBiz biz = new AssetBiz();
		LMultiData result = biz.retrieveCurrentAssetList(inputData);
		
		LLog.info.write("\n RetrieveCurrentAssetListCmd result:" + result.toString());				
 
		// Header 를 설정한다.
		gds.addDataColumn( new GauceDataColumn( "assetNo"       , GauceDataColumn.TB_STRING   , 50   ) ); 
        gds.addDataColumn( new GauceDataColumn( "assetSubNo"    , GauceDataColumn.TB_STRING   , 50   ) ); 
        gds.addDataColumn( new GauceDataColumn( "assetNm"       , GauceDataColumn.TB_STRING   , 50   ) ); 
        gds.addDataColumn( new GauceDataColumn( "assetClass"    , GauceDataColumn.TB_STRING   , 50   ) );    
        gds.addDataColumn( new GauceDataColumn( "assetClassNm"  , GauceDataColumn.TB_STRING   , 50   ) );         
        gds.addDataColumn( new GauceDataColumn( "costCenter"    , GauceDataColumn.TB_STRING   , 50   ) ); 
        gds.addDataColumn( new GauceDataColumn( "costCenterNm"  , GauceDataColumn.TB_STRING   , 50   ) );  
        gds.addDataColumn( new GauceDataColumn( "acqDate"       , GauceDataColumn.TB_STRING   , 50   ) ); 
        gds.addDataColumn( new GauceDataColumn( "acqYear"       , GauceDataColumn.TB_STRING   , 50   ) );         
        gds.addDataColumn( new GauceDataColumn( "durableYears"  , GauceDataColumn.TB_STRING   , 50   ) );
        gds.addDataColumn( new GauceDataColumn( "acqAmt"        , GauceDataColumn.TB_DECIMAL  , 13, 2) );
        gds.addDataColumn( new GauceDataColumn( "netAcqAmt"     , GauceDataColumn.TB_DECIMAL  , 13, 2) );
        gds.addDataColumn( new GauceDataColumn( "depAmt"        , GauceDataColumn.TB_DECIMAL  , 13, 2) );
        gds.addDataColumn( new GauceDataColumn( "balance"       , GauceDataColumn.TB_DECIMAL  , 13, 2) );
        gds.addDataColumn( new GauceDataColumn( "currCd"        , GauceDataColumn.TB_STRING   , 50   ) );
        gds.addDataColumn( new GauceDataColumn( "dueDate"       , GauceDataColumn.TB_STRING   , 50   ) );
        gds.addDataColumn( new GauceDataColumn( "unit"          , GauceDataColumn.TB_STRING   , 50   ) );
        gds.addDataColumn( new GauceDataColumn( "qty"           , GauceDataColumn.TB_STRING   , 50   ) );
        gds.addDataColumn( new GauceDataColumn( "attr01"        , GauceDataColumn.TB_STRING   , 50   ) );
        gds.addDataColumn( new GauceDataColumn( "attr02"        , GauceDataColumn.TB_STRING   , 50   ) );
        gds.addDataColumn( new GauceDataColumn( "attr03"        , GauceDataColumn.TB_STRING   , 50   ) );
        gds.addDataColumn( new GauceDataColumn( "attr04"        , GauceDataColumn.TB_STRING   , 50   ) );
        gds.addDataColumn( new GauceDataColumn( "attr05"        , GauceDataColumn.TB_STRING   , 50   ) );
        gds.addDataColumn( new GauceDataColumn( "attr06"        , GauceDataColumn.TB_STRING   , 50   ) );
        gds.addDataColumn( new GauceDataColumn( "attr07"        , GauceDataColumn.TB_STRING   , 50   ) );
        gds.addDataColumn( new GauceDataColumn( "attr08"        , GauceDataColumn.TB_STRING   , 50   ) );
        gds.addDataColumn( new GauceDataColumn( "attr09"        , GauceDataColumn.TB_STRING   , 50   ) );
        gds.addDataColumn( new GauceDataColumn( "attr10"        , GauceDataColumn.TB_STRING   , 50   ) );                 
     
	    LGauceConverter.convertToGauceDataSet(result, gds); 
	    gds.flush();
	    
		LLog.info.write("\n RetrieveCurrentAssetListCmd --> End \n");		
		
    }
}
