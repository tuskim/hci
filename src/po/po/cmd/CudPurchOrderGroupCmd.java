/*
 *------------------------------------------------------------------------------
 * CudSafetyStockMgntCmd.java,v 1.0 2010/07/23 16:43:35 
 * 
 * PROJ : PT-PAM 
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2010/07/23   thno   최초 프로그램 작성
 *----------------------------------------------------------------------------
 */

package po.po.cmd;

import po.po.biz.PurchOrderGroupBiz;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gauce.GauceDataSet;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LException;
import devon.core.log.LLog;
import devonframework.bridge.gauce.util.LGauceConverter;
import devonframework.bridge.gauce.command.LGauceCommandIF;
import devonframework.persistent.autodao.LCompoundDao;

/**
 * <PRE>
 * 
 * 
 * </PRE>
 * 
 * @author    ceh
 * @see       
 */
public class CudPurchOrderGroupCmd implements LGauceCommandIF {
    /**
     * 
     *
     * @param req Http Request 객체.
     * @param res Http Response 객체.
     * @param gauceRequest 가우스 Request 객체.
     * @param gauceResponse 가우스 Response 객체.
     * @exception LException Commnad 단 이하의 모든 에러.
     */
	public void execute(HttpServletRequest req, HttpServletResponse res, GauceRequest gauceRequest, GauceResponse gauceResponse) throws Exception {
		try {
			LLog.debug.write("CudSafetyStockMgntCmd inputData--------------- Start \n");
			
			GauceDataSet gd_deail = gauceRequest.getGauceDataSet("ds_main");
			GauceDataSet gd_master = gauceRequest.getGauceDataSet("ds_save");
			LData resultData = new LData(); 
			long   getErrorCode = 0 ;
			String getMessage   = "";
			
			if(gd_master == null &&  gd_deail ==null )
				return;
			
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
			LMultiData mData = LGauceConverter.convertToLMultiDataWithJobType(gd_master);
			LMultiData dData = LGauceConverter.convertToLMultiDataWithJobType(gd_deail);
			LLog.debug.println("CudProgMgntCmd inputData--------------- =>\n " + mData.toString());
			
			PurchOrderGroupBiz biz = new PurchOrderGroupBiz();
			resultData = biz.cudPurchOrderGroup(mData,dData, loginUser); 
			
			getErrorCode = resultData.getLong("getErrorCode");
			getMessage	 = resultData.getString("getMessage");
			
			if (getErrorCode != 0 && getErrorCode != -999999) {             
			    if (getMessage == null) getMessage = "";
			 
			    gauceResponse.writeException("Error", String.valueOf(getErrorCode), "\n[Detail Msg]==>" + getMessage);
			}
			
			LLog.debug.write("CudSafetyStockMgntCmd inputData--------------- End \n");
		} catch (Exception e) {
			throw new LException(e.getMessage());
		} finally {	
		}
	}

}
