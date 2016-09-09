package rfc.cmd;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import rfc.biz.RetrieveCurrentStockRFC;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.log.LLog;
import devonframework.front.command.LCommandIF;

public class RetrieveCurrentStockListCmd implements LCommandIF{

	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		LLog.debug.write("RetrieveCurrentStockListCmd --> Start");
		
		LMultiData resultData = new LMultiData();
		LData inputData = new LData();
		
		//inputData.setString("plant", "O100");
		//inputData.setString("location", "001A");
		//inputData.setString("material", "61000001");
		
		RetrieveCurrentStockRFC biz = new RetrieveCurrentStockRFC();
		resultData = biz.getStockList(inputData);
		
		LLog.debug.write("RetrieveCurrentStockListCmd --> END");
	}
}
