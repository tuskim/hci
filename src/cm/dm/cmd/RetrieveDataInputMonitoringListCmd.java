/*
 *------------------------------------------------------------------------------
 * RetrieveVendorDetailListCmd.java,v 1.0 2010/05/30 16:43:35 
 * Vendor Detail 조회 
 * 
 * PROJ : PT-PAM System
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2010/08/30   임민수   Init
 *----------------------------------------------------------------------------
 */
 

package cm.dm.cmd;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cm.cd.biz.PopupBiz;
import cm.dm.biz.DataInputMgntBiz;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
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

public class RetrieveDataInputMonitoringListCmd implements LGauceCommandIF{
	
	/**
	 * Request 정보가 실제 수행되는 인터페이스 메소드
	 *
	 * @param req Http Request 객체.
	 * @param res Http Response 객체.
	 * @exception LException Commnad 단 이하의 모든 에러.
	 */
	public void execute(HttpServletRequest req, HttpServletResponse res, 
			             GauceRequest gauceRequest, GauceResponse gauceResponse) throws Exception {
	
		LLog.info.write("\n RetrieveDataInputMonitoringListCmd --> Start \n");
		
		LData inputData = LXssCollectionUtility.getData(req);

		LLog.debug.println("inputData = " + inputData.toString());

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

		DataInputMgntBiz biz = new DataInputMgntBiz();


		GauceDataSet 	gauDsRes 	= new GauceDataSet();
		gauceResponse.enableFirstRow( gauDsRes );
		
		gauDsRes.addDataColumn(new GauceDataColumn("dataInput1", 	GauceDataColumn.TB_DECIMAL,  13, 2 ));
		gauDsRes.addDataColumn(new GauceDataColumn("dataInput2", 	GauceDataColumn.TB_DECIMAL,  13, 2 ));
		gauDsRes.addDataColumn(new GauceDataColumn("dataInput3", 	GauceDataColumn.TB_DECIMAL,  13, 2 ));
		
		int [][] resultList = biz.retrieveDataInputList(inputData);
		
		LLog.debug.println("-----------------------------"+resultList.toString());
		GauceDataRow row = null;
		
		for(int idx = 0 ; idx < 16 ; idx++)
		{
			
			row = gauDsRes.newDataRow();
		
			for(int j=0; j<3; j++){
				row.addColumnValue(String.valueOf(resultList[idx][j]));
				
			}
			
			gauDsRes.addDataRow(row);
			
		}
		
		//req.setAttribute("board", resultList);
		
		gauDsRes.flush();
		
		
		LLog.info.write("\n RetrieveDataInputMonitoringListCmd --> End \n");
	}
}