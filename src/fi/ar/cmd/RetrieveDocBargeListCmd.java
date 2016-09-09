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

import fi.ar.biz.DocBargeBiz;
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
public class RetrieveDocBargeListCmd implements LGauceCommandIF  {
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
		 
		LLog.info.write("\n RetrieveDocPrintListCmd --> Start \n");		

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
	    inputData.setString("userId",   loginUser.getString("userId"));
	    inputData.setString("lang",     loginUser.getString("lang"));
	    inputData.setString("companyCd",loginUser.getString("companyCd"));
	    DocBargeBiz biz = new DocBargeBiz();
		LMultiData result = biz.retrieveDocBargeList(inputData);
		if(inputData.getString("flag").equals("1")){
			gds.addDataColumn( new GauceDataColumn( "seq"   					, GauceDataColumn.TB_STRING   , 10    ) ); //BUKRS
			gds.addDataColumn( new GauceDataColumn( "companyCd"   	, GauceDataColumn.TB_STRING   , 4    ) ); //BUKRS
	        gds.addDataColumn( new GauceDataColumn( "deptCd"   				, GauceDataColumn.TB_STRING   , 4    ) ); //GJAHR
	        gds.addDataColumn( new GauceDataColumn( "docYm"        		, GauceDataColumn.TB_STRING   , 10   ) ); //BELNR
	        gds.addDataColumn( new GauceDataColumn( "docSeq"      			, GauceDataColumn.TB_STRING   , 20    ) ); //BLART   
	        gds.addDataColumn( new GauceDataColumn( "sapDocSeq"      	, GauceDataColumn.TB_STRING   , 10    ) ); //BLDAT        
	        gds.addDataColumn( new GauceDataColumn( "docDate"     			, GauceDataColumn.TB_STRING   , 10    ) ); //BUDAT
	        gds.addDataColumn( new GauceDataColumn( "postDate"   			, GauceDataColumn.TB_STRING   , 10   ) ); //BKTXT 
	        gds.addDataColumn( new GauceDataColumn( "amount"         		, GauceDataColumn.TB_DECIMAL   , 50    ) ); //WAERS
	        gds.addDataColumn( new GauceDataColumn( "currencyCd"       	, GauceDataColumn.TB_STRING  , 3) ); //WRBTR
	        gds.addDataColumn( new GauceDataColumn( "vendor"     			, GauceDataColumn.TB_STRING  , 50) ); //DMBTR  
	        gds.addDataColumn( new GauceDataColumn( "seq2"  	        		, GauceDataColumn.TB_STRING   , 10   ) ); //STBLG 		
	        gds.addDataColumn( new GauceDataColumn( "syskey"        		, GauceDataColumn.TB_STRING   , 10   ) ); //MWSKZ
	        gds.addDataColumn( new GauceDataColumn( "mvCd"     				, GauceDataColumn.TB_STRING   , 10   ) ); //KUNNR
	        gds.addDataColumn( new GauceDataColumn( "bargeSeq" 			, GauceDataColumn.TB_STRING   , 40   ) ); //KUNNR_DES
	        gds.addDataColumn( new GauceDataColumn( "bargeCd"       		, GauceDataColumn.TB_STRING   , 10   ) ); //LIFNR
	        gds.addDataColumn( new GauceDataColumn( "bargePostDate" , GauceDataColumn.TB_STRING   , 10   ) ); //LIFNR_DES 		
	        gds.addDataColumn( new GauceDataColumn( "mvArrivalDate"  , GauceDataColumn.TB_STRING   , 10   ) ); //LIFNR_DES 		
	        gds.addDataColumn( new GauceDataColumn( "loadingQty"   		, GauceDataColumn.TB_STRING   , 30   ) ); //LIFNR_DES 	
		    LGauceConverter.convertToGauceDataSet(result, gds); 
		    gds.flush();	
		}else{
			gds.addDataColumn( new GauceDataColumn( "seq"   					, GauceDataColumn.TB_STRING   , 10    ) ); //BUKRS
	        gds.addDataColumn( new GauceDataColumn( "syskey"        		, GauceDataColumn.TB_STRING   , 10   ) ); //MWSKZ
	        gds.addDataColumn( new GauceDataColumn( "mvCd"     				, GauceDataColumn.TB_STRING   , 10   ) ); //KUNNR
	        gds.addDataColumn( new GauceDataColumn( "bargeSeq" 			, GauceDataColumn.TB_STRING   , 40   ) ); //KUNNR_DES
	        gds.addDataColumn( new GauceDataColumn( "bargeCd"       		, GauceDataColumn.TB_STRING   , 10   ) ); //LIFNR
	        gds.addDataColumn( new GauceDataColumn( "bargePostDate" , GauceDataColumn.TB_STRING   , 10   ) ); //LIFNR_DES 		
	        gds.addDataColumn( new GauceDataColumn( "mvArrivalDate"  , GauceDataColumn.TB_STRING   , 10   ) ); //LIFNR_DES 		
	        gds.addDataColumn( new GauceDataColumn( "loadingQty"   		, GauceDataColumn.TB_STRING   , 30   ) ); //LIFNR_DES 	
	        gds.addDataColumn( new GauceDataColumn( "seq2"  	        		, GauceDataColumn.TB_STRING   , 10   ) ); //STBLG 		
			gds.addDataColumn( new GauceDataColumn( "companyCd"   	, GauceDataColumn.TB_STRING   , 4    ) ); //BUKRS
	        gds.addDataColumn( new GauceDataColumn( "deptCd"   				, GauceDataColumn.TB_STRING   , 4    ) ); //GJAHR
	        gds.addDataColumn( new GauceDataColumn( "docYm"        		, GauceDataColumn.TB_STRING   , 10   ) ); //BELNR
	        gds.addDataColumn( new GauceDataColumn( "docSeq"      			, GauceDataColumn.TB_STRING   , 20    ) ); //BLART   
	        gds.addDataColumn( new GauceDataColumn( "sapDocSeq"      	, GauceDataColumn.TB_STRING   , 10    ) ); //BLDAT        
	        gds.addDataColumn( new GauceDataColumn( "docDate"     			, GauceDataColumn.TB_STRING   , 10    ) ); //BUDAT
	        gds.addDataColumn( new GauceDataColumn( "postDate"   			, GauceDataColumn.TB_STRING   , 10   ) ); //BKTXT 
	        gds.addDataColumn( new GauceDataColumn( "amount"         		, GauceDataColumn.TB_DECIMAL   , 50    ) ); //WAERS
	        gds.addDataColumn( new GauceDataColumn( "currencyCd"       	, GauceDataColumn.TB_STRING  , 3) ); //WRBTR
	        gds.addDataColumn( new GauceDataColumn( "vendor"     			, GauceDataColumn.TB_STRING  , 50) ); //DMBTR  	
		    LGauceConverter.convertToGauceDataSet(result, gds); 
		    gds.flush();
		}
     
	    
		LLog.info.write("\n RetrieveDocPrintListCmd --> End \n");		
		
    }
}
