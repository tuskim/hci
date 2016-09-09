/* ------------------------------------------------------------------------
 * @source  : RetrieveMainNoticeCmd.java
 * @desc    : main notice List 
 * ------------------------------------------------------------------------
 *
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2010.07.24                      Initial
 * 1.1 2014.04.14    jwhan				CSR:C20140414_23324
 * ------------------------------------------------------------------------ */

package cm.nt.cmd;

import cm.lo.login.biz.commBiz;
import cm.nt.biz.NoticeBiz;
import comm.util.LXssCollectionUtility;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LException;
import devon.core.log.LLog;
import devonframework.front.channel.LNavigationAlter;
import devonframework.front.command.LCommandIF;

/**
 * <PRE>
 * 
 * 
 * </PRE>
 * 
 * @author ceh
 * @see
 */
public class RetrieveMainNoticeCmd implements LCommandIF {
	/**
	 * 
	 * 
	 * @param req
	 *            Http Request 객체.
	 * @param res
	 *            Http Response 객체.
	 * @param gauceRequest
	 *            가우스 Request 객체.
	 * @param gauceResponse
	 *            가우스 Response 객체.
	 * @exception LException
	 *                Commnad 단 이하의 모든 에러.
	 */
	public void execute(HttpServletRequest req, HttpServletResponse res) throws LException {

		LData inputData = LXssCollectionUtility.getData(req);

		
		
		long getErrorCode = 0;
		String getMessage = "";

		// -------------------------------------- Session 종료시 처리 START
		HttpSession session = req.getSession(false);
		LData loginUser = new LData();

		if (session != null)
			loginUser = (LData) session.getAttribute("loginUser");
		if (loginUser.getString("userId") == null) {
			getMessage = "Session is Terminated. You need to relogin!";

			return;
		}
		// -------------------------------------- Session 종료시 처리 END
		// 사용자iD 추가.`
		inputData.setString("userId", loginUser.getString("userId"));
		inputData.setString("lang", loginUser.getString("lang"));
		inputData.setString("companyCd", loginUser.getString("companyCd"));
		LData result = null;
		LMultiData noticeList = new LMultiData();
		LMultiData qnaList = new LMultiData();

		LLog.debug.write("RetrieveMainNoticeCmd MPP inputData==>\n" + inputData.toString());

		NoticeBiz biz = new NoticeBiz();

		noticeList = biz.retrieveMainNotice(inputData); // Notice

		// 20140310 추가 패스워드 유효기간 확인
		commBiz commbiz = new commBiz();
		LData passwordBetween = commbiz.retrievePasswordBetween(inputData);

		
		LLog.info.write("passwordBetween LData    ========================" + passwordBetween);

		req.setAttribute("passwordBetween", passwordBetween);
		req.setAttribute("result", result);
		req.setAttribute("noticeList", noticeList);
		req.setAttribute("qnaList", qnaList);
		

		LLog.debug.write("RetrieveMainNoticeCmd end==>\n" + noticeList);
	}
}
