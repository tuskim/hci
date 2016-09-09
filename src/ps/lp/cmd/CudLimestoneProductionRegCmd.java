/* ------------------------------------------------------------------------
 * @source  : CudLimestoneProductionRegCmd.java
 * @desc    : Limestone Production Save
 * ------------------------------------------------------------------------
 *
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2016.08.02   kjkim               Initial
 * ------------------------------------------------------------------------ */

package ps.lp.cmd;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ps.lp.biz.LimestoneProductionBiz;

import com.gauce.GauceDataSet;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.log.LLog;
import devonframework.bridge.gauce.command.LGauceCommandIF;
import devonframework.bridge.gauce.util.LGauceConverter;


public class CudLimestoneProductionRegCmd implements LGauceCommandIF {

	public void execute(HttpServletRequest req, HttpServletResponse res, 
	        GauceRequest gauceRequest, GauceResponse gauceResponse) throws Exception {
				
		LLog.debug.write("CudLimestoneProductionRegCmd inputData--------------- Start \n");
		
		GauceDataSet userGdsMst    = gauceRequest.getGauceDataSet("IN_DS1");
		GauceDataSet userGdsInput  = gauceRequest.getGauceDataSet("IN_DS2");
		
		LData resultData = new LData();
		
		String getErrorCode = "";
	    String getMessage   = "";
		
		if(userGdsMst == null || userGdsInput == null ){
			LLog.debug.write("CudLimestoneProductionRegCmd : DS_GRID   Null Point Error! \n");
			return;
		}
		
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
		
		LMultiData mDataMst    = LGauceConverter.convertToLMultiDataWithJobType(userGdsMst);
		LMultiData mDataInput = LGauceConverter.convertToLMultiDataWithJobType(userGdsInput);
		
		LLog.debug.println("CudLimestoneProductionRegCmd inputData MstDataSet--------------- =>\n " + mDataMst.toString());
		LLog.debug.println("CudLimestoneProductionRegCmd inputData OutputDataSet --------------- =>\n " + userGdsInput.toString());
	
		LimestoneProductionBiz biz = new LimestoneProductionBiz();
		
		resultData = biz.cudLimestoneProductionRegMod(mDataMst, mDataInput, loginUser);		
		 
		getErrorCode = resultData.getString("getErrorCode");
		getMessage	 = resultData.getString("getMessage");
		
		 if (!getErrorCode.equals("0") && !getErrorCode.equals("-999999")) {             
	         if (getMessage == null) getMessage = "";
	         
	         gauceResponse.writeException("Error", String.valueOf(getErrorCode), "\n[Detail Msg]==>" + getMessage);
	     }
	
		 LLog.debug.write("CudLimestoneProductionRegCmd inputData--------------- End \n");
	
	}
}