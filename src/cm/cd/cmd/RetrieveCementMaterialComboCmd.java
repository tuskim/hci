/*
 *------------------------------------------------------------------------------
 * RetrieveCPOMaterialComboCmd.java,v 1.0 2012/10/04
 * 
 * PROJ : PT-PAM System
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2010/08/05   이태경             Init
 *----------------------------------------------------------------------------
 */
 

package cm.cd.cmd;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import sd.sm.biz.CementSalesMgntBiz;

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

public class RetrieveCementMaterialComboCmd implements LGauceCommandIF{
	
	/**
	 * Request 정보가 실제 수행되는 인터페이스 메소드
	 *
	 * @param req Http Request 객체.
	 * @param res Http Response 객체.
	 * @exception LException Commnad 단 이하의 모든 에러.
	 */
	public void execute(HttpServletRequest req, HttpServletResponse res, 
			             GauceRequest gauceRequest, GauceResponse gauceResponse) throws Exception {
	
		LLog.info.write("\n RetrieveCementMaterialComboCmd --> Start \n");
		
		GauceDataSet gds = new GauceDataSet();
		gauceResponse.enableFirstRow(gds);
		LData inputData = LXssCollectionUtility.getData(req);

		LLog.debug.write("inputData = " + inputData.toString());

		//-------------------------------------- Session 종료시 처리 START
		HttpSession session = req.getSession(false);
		LData loginUser = new LData();
		
		if (session != null) loginUser = (LData)session.getAttribute("loginUser");
		if( loginUser.getString("userId") == null) {
			throw new LException("Sorry, You are not authorized for this menu.");
		}
		//-------------------------------------- Session 종료시 처리 END
		
		inputData.setString("companyCd", loginUser.getString("companyCd"));
		inputData.setString("lang", 	 loginUser.getString("lang"));

		CementSalesMgntBiz biz = new CementSalesMgntBiz();
		LMultiData result = biz.retrieveCementMaterialCombo(inputData);
	    LGauceConverter.extractToGauceDataSet(result, gds);
	    gds.flush();
	    
		LLog.info.write("\n RetrieveCementMaterialComboCmd --> End \n");
	}
}