/* ------------------------------------------------------------------------
 * @source  : CudMaterialApprovalCmd.java
 * @desc    : 신규 품목 마스터 등록 요청
 * ------------------------------------------------------------------------
 *
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2016.09.01                      Initial
 * ------------------------------------------------------------------------ */

package cm.cm.cmd;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cm.cm.biz.MaterialApprovalBiz;

import com.gauce.GauceDataSet;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import comm.util.LXssCollectionUtility;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.log.LLog;
import devonframework.bridge.gauce.command.LGauceCommandIF;
import devonframework.bridge.gauce.util.LGauceConverter;

public class CudMaterialApprovalCmd implements LGauceCommandIF {

	public void execute(HttpServletRequest req, HttpServletResponse res, GauceRequest gauceApproval, GauceResponse gauceResponse) throws Exception {

		LLog.debug.write("CudMaterialApprovalCmd inputData--------------- Start \n");

		GauceDataSet userGdsMst = gauceApproval.getGauceDataSet("IN_DS1");

		LData resultData = new LData();

		String getErrorCode = "";
		String getMessage = "";

		if (userGdsMst == null) {
			LLog.debug.write("CudMaterialApprovalCmd : DS_GRID   Null Point Error! \n");
			return;
		}

		// -------------------------------------- Session 종료시 처리 START
		HttpSession session = req.getSession(false);
		LData loginUser = new LData();

		if (session != null)
			loginUser = (LData) session.getAttribute("loginUser");
		if (loginUser.getString("userId") == null) {
			getMessage = "Session is Terminated. You need to relogin!";
			gauceResponse.writeException("Error", String.valueOf(getErrorCode), "\n[Detail Msg]==>" + getMessage);
			return;
		}
		// -------------------------------------- Session 종료시 처리 END

		LMultiData mDataMst = LGauceConverter.convertToLMultiDataWithJobType(userGdsMst);

		LLog.debug.println("CudMaterialApprovalCmd inputData MstDataSet--------------- =>\n " + mDataMst.toString());

		MaterialApprovalBiz biz = new MaterialApprovalBiz();

		LData lData = LXssCollectionUtility.getData(req);
		LLog.debug.println("CudMaterialApprovalCmd inputData lData--------------- =>\n " + lData.toString());
		if ("f_approval".equals(lData.getString("cmdMode"))) {
			resultData = biz.cudMaterialApprovalSapApproval(mDataMst, loginUser);
		} else {
			resultData = biz.cudMaterialApprovalSapCancel(mDataMst, loginUser);
		}

		getErrorCode = resultData.getString("getErrorCode");
		getMessage = resultData.getString("getMessage");

		if (!getErrorCode.equals("0") && !getErrorCode.equals("-999999")) {
			if (getMessage == null)
				getMessage = "";

			gauceResponse.writeException("Error", String.valueOf(getErrorCode), "\n[Detail Msg]==>" + getMessage);
		}

		LLog.debug.write("CudMaterialApprovalCmd inputData--------------- End \n");

	}

}