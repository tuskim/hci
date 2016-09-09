/*
 *------------------------------------------------------------------------------
 * RetrieveCountDocClosingListCmd.java,v 1.0 2010/07/23 16:43:35 
 * 
 * PROJ : PT-PAM 
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2011/04/25   kang   Init 		결산모니터링용 데이터 조회
 *----------------------------------------------------------------------------
 */

package fi.ar.cmd;

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
import fi.ar.biz.StatementOfAccoutnsBiz;

/**
 * <PRE>
 * 
 * 
 * </PRE>
 * 
 * @author    ceh
 * @see       
 */
public class RetrieveQtyClosingListCmd implements LGauceCommandIF  {
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
		 
		LLog.info.write("\n RetrieveQtyClosingListCmd 결산모니터링--> Start \n");		

		GauceDataSet ds_main4 = new GauceDataSet();
		gauceResponse.enableFirstRow(ds_main4);

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
	    
	    //회사코드 추가
	    inputData.setString("companyCd", loginUser.getString("companyCd"));
	    inputData.setString("lang",      loginUser.getString("lang"));
	    
	    StatementOfAccoutnsBiz biz = new StatementOfAccoutnsBiz();
		LMultiData result = biz.RetrieveQtyClosingList(inputData);
		LLog.info.write("\n RetrieveStatementOfAccountsCmd 결산모니터링 전표 상태별수:" + result.toString());		
		
	    
		// Header 를 설정한다.
		ds_main4.addDataColumn( new GauceDataColumn( "receiptQty"  , GauceDataColumn.TB_DECIMAL   , 13, 2   ) ); //
		ds_main4.addDataColumn( new GauceDataColumn( "issueQty"    , GauceDataColumn.TB_DECIMAL   , 13, 2  ) ); //
		ds_main4.addDataColumn( new GauceDataColumn( "coalProdQty" , GauceDataColumn.TB_DECIMAL   , 13, 2    ) ); //	    
		
	    LGauceConverter.convertToGauceDataSet(result, ds_main4);
	    ds_main4.flush();

		LLog.info.write("\n RetrieveQtyClosingListCmd --> End \n");		
		
    }
}
