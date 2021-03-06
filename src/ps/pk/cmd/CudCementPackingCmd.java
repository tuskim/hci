/*
 *------------------------------------------------------------------------------
 * CudCementPackingCmd.java,v 1.0 2010/08/03 16:43:35 
 * 
 * PROJ : PT-PAM System.
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2010/08/20   mskim   Init
 *----------------------------------------------------------------------------
 */

package ps.pk.cmd;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ps.pk.biz.CementPackingBiz;

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
public class CudCementPackingCmd implements LGauceCommandIF {
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
		
		LLog.debug.write("CudCementPackingCmd ------------ START");
		
		

		long   getErrorCode = 0 ;
        String getMessage   = "";

        /////////////////////////////////////////////////////////////////////////////////
        // 세션체크
	    HttpSession session = req.getSession(false);
	    LData loginUser = new LData();
	    
	    if (session != null) loginUser = (LData)session.getAttribute("loginUser");
	    if( loginUser.getString("userId") == null) {
	    	getMessage = "Session is Terminated. You need to relogin!";
	    	gauceResponse.writeException("Error","", getMessage);
	    	return;
	    }
        /////////////////////////////////////////////////////////////////////////////////

	    
		
		
		
        /////////////////////////////////////////////////////////////////////////////////
        // 데이터체크
        GauceDataSet masterGds = gauceRequest.getGauceDataSet("ds_master");
		GauceDataSet detailGds = gauceRequest.getGauceDataSet("ds_detail");
		GauceDataSet resultGds = gauceRequest.getGauceDataSet("ds_result");

		if(masterGds == null || detailGds == null || resultGds == null) {	
	    	getMessage = "You need to your data!";
	    	gauceResponse.writeException("Error","", getMessage);
			return;
		}
		LMultiData MDataMaster   = LGauceConverter.convertToLMultiDataWithJobType(masterGds);
		LMultiData MDataDetail = LGauceConverter.convertToLMultiDataWithJobType(detailGds);
		LMultiData MDataResult = LGauceConverter.convertToLMultiDataWithJobType(resultGds);
		LLog.debug.write("CudCementPackingCmd MDataMaster ---------------> =>\n " + MDataMaster);
		LLog.debug.write("CudCementPackingCmd MDataDetail ---------------> =>\n " + MDataDetail);	
		LLog.debug.write("CudCementPackingCmd MDataResult ---------------> =>\n " + MDataResult);
        /////////////////////////////////////////////////////////////////////////////////

		

        /////////////////////////////////////////////////////////////////////////////////
        // 비즈호출
		LData inputData = LXssCollectionUtility.getData(req);
//		loginUser.set("poNo", inputData.get("poNo"));
		LData resultData = new LData();

		CementPackingBiz biz = new CementPackingBiz();
		resultData = biz.cudCementPacking(MDataMaster, MDataDetail, MDataResult, loginUser);
		
		getErrorCode = resultData.getLong("getErrorCode");
		getMessage	 = resultData.getString("getMessage");

		if (getErrorCode != 0 && getErrorCode != -999999) {             
			if (getMessage == null) getMessage = "";
			gauceResponse.writeException("Error", String.valueOf(getErrorCode), "\n[Detail Msg]==>" + getMessage);
		}
        /////////////////////////////////////////////////////////////////////////////////

		LLog.debug.write("CudCementPackingCmd ------------ END");
	
	}
}
