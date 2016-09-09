/* ------------------------------------------------------------------------
 * @source  : GeneralServlet.java
 * @desc    : 占싹뱄옙占쏙옙占쏙옙 HTTP Request 占쏙옙 처占쏙옙占싹댐옙 占쏙옙占?
 * ------------------------------------------------------------------------
 * LG CNS LTE(DevOn Test Environment)
 * Copyright(c) 2006 LG CNS,  All rights reserved.
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2006.01.27   占쏙옙:占쏙옙                占쏙옙占쏙옙 占퐓慣瀏占?占쌜쇽옙
 * 1.1  2006.12.27   v占쏙옙占쏙옙/占싱삼옙占?황占싣울옙  LTE占쏙옙 占쏙옙占?
 * ------------------------------------------------------------------------ */

package comm.channel;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import comm.util.Constants;
import devon.core.log.LLog;
import devon.core.log.trace.LTraceID;
import devon.core.util.stopwatch.LHistorialWatch;
import devonframework.front.channel.LAbstractServlet;

/**
 * <PRE>
 * 
 * 占싹뱄옙占쏙옙占쏙옙 HTTP Request 占쏙옙 처占쏙옙占싹댐옙 占쏙옙占?
 * 
 * </PRE>
 * 
 * @author LG CNS S/W Innovation Group Technoloy Reuse Team v占쏙옙占쏙옙/占싱삼옙占?황占싣울옙
 * @version 1.1, 2006.12.27
 */
public class GeneralServlet extends LAbstractServlet {

	private static final long serialVersionUID = 9022722988639227411L;

	public GeneralServlet() {
		super();
	}

	protected void catchService(HttpServletRequest req, HttpServletResponse res) {
        // servlet 占쌌단울옙 filter占쏙옙 占쏙옙占쏙옙磯摸占?占싣뤄옙 占쏙옙 占쏙옙; 占쏙옙f占싼댐옙.
        // 占쏙옙占?filter 占쌤울옙占쏙옙 servlet占쏙옙 doGet 占실댐옙 doPost占쏙옙 占쏙옙占쏙옙占싹깍옙 占쏙옙, LTraceID.regist(key)占쏙옙 호占쏙옙占쌔억옙 占싼댐옙.
        LTraceID.regist("DEV");
        
        LHistorialWatch hw = new LHistorialWatch();
		req.setAttribute(Constants.SERVLET_STOPWATCH_KEY, hw);

		try {
			hw.tick("Processing command begin");
			this.process(req, res);
		} catch (Exception e) {
			LLog.err.write("Unexpected Exception occurred - " + e.toString());

			String errorCode = e.getMessage();
			if (errorCode == null || !errorCode.startsWith(Constants.MSG_PREFIX)) {
				errorCode = Constants.MSG_ERROR_DEFAULT;
			}

			req.setAttribute(Constants.SERVLET_ERROR_CODE_KEY, errorCode);
			req.setAttribute(Constants.SERVLET_ERROR_EXCEPTION_KEY, e);
			req.setAttribute(Constants.SERVLET_ERROR_REQUEST_URI_KEY, req.getRequestURI());
			this.processError(req, res);
		}
        // servlet 占쌌단울옙 filter占쏙옙 占쏙옙占쏙옙磯摸占?占싣뤄옙 占쏙옙 占쏙옙; 占쏙옙f占싼댐옙.
        // 占쏙옙占?filter 占쌤울옙占쏙옙 servlet占쏙옙 doGet 占실댐옙 doPost占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙, LTraceID.clear()占쏙옙 호占쏙옙占쌔억옙 占싼댐옙.  
        LTraceID.clear();
	}
}
