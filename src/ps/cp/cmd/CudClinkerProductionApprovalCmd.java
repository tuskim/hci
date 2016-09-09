/* ------------------------------------------------------------------------
 * @source  : CudClinkerProductionApprovalCmd.java
 * @desc    : Clinker Production Save
 * ------------------------------------------------------------------------
 *
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2016.08.02   kjkim               Initial
 * ------------------------------------------------------------------------ */

package ps.cp.cmd;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ps.cp.biz.ClinkerProductionBiz;

import com.gauce.GauceDataSet;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LException;
import devon.core.log.LLog;
import devonframework.bridge.gauce.command.LGauceCommandIF;
import devonframework.bridge.gauce.util.LGauceConverter;


public class CudClinkerProductionApprovalCmd implements LGauceCommandIF {

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
	        GauceRequest gauceRequest, GauceResponse gauceResponse) throws Exception {
				
		LLog.debug.write("CudClinkerProductionApprovalCmd inputData--------------- Start \n");
		
		GauceDataSet userGdsMst    = gauceRequest.getGauceDataSet("IN_DS1");
		
		LData resultData = new LData();
		
		String getErrorCode = "";
	    String getMessage   = "";
		
		if(userGdsMst == null){
			LLog.debug.write("CudClinkerProductionApprovalCmd : DS_GRID   Null Point Error! \n");
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
		
		LLog.debug.println("CudClinkerProductionApprovalCmd inputData MstDataSet--------------- =>\n " + mDataMst.toString());
	
		ClinkerProductionBiz biz = new ClinkerProductionBiz();
		
		resultData = biz.cudClinkerProductionApproval(mDataMst, loginUser);		
		 
		getErrorCode = resultData.getString("getErrorCode");
		getMessage	 = resultData.getString("getMessage");
		
		 if (!getErrorCode.equals("0") && !getErrorCode.equals("-999999")) {             
	         if (getMessage == null) getMessage = "";
	         
	         gauceResponse.writeException("Error", String.valueOf(getErrorCode), "\n[Detail Msg]==>" + getMessage);
	     }
	
		 LLog.debug.write("CudClinkerProductionApprovalCmd inputData--------------- End \n");
	
	}
}