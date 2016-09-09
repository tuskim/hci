/* ------------------------------------------------------------------------
 * @source  : GauceServlet.java
 * @desc    : GauceRequest 를 처리하는 서블릿
 * ------------------------------------------------------------------------
 * LG CNS LTE(DevOn Test Environment)
 * Copyright(c) 2006 LG CNS,  All rights reserved.
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2006.01.27   민병석                최초 프로그램 작성
 * 1.1  2006.12.27   조남웅/이상원/황아영  LTE에 적용
 * ------------------------------------------------------------------------ */

package comm.channel;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import comm.util.Constants;

import com.gauce.GauceService;
import com.gauce.ServiceLoader;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

import devon.core.log.LLog;
import devon.core.log.trace.LTraceID;
import devonframework.bridge.gauce.channel.LDefaultGauceChannelServlet;
import devonframework.service.message.LMessageSource;

/**
 * <PRE>
 * GauceRequest 를 처리하는 서블릿
 * </PRE>
 * 
 * @author    LG CNS S/W Innovation Group Technoloy Reuse Team 조남웅/이상원/황아영
 * @version   1.1, 2006.12.27
 */
public class GauceServlet extends LDefaultGauceChannelServlet {

    private static final long serialVersionUID = -1018172639469001519L;

    public GauceServlet() {
        super();
    }

	/**
	 * Navigation과 관련된 Main Process를 담당한다.<BR>
	 * Request가 들어오면 그 Request를 분석하여 이후에 실행해야할 Command를 찾아서<BR>
	 * execute()하게 되며, execute후에 발생되는 Error에 대한 Message처리 또한 담당하게 된다.<BR>
	 * 그리고 모든 실행을 하고난 후에는 return 페이지로 Dispatch하는 역할을 하고 있다.<BR>
	 * 
	 * @param req servlet에서 전달받은 HttpServletRequest. form processing을 위하여 사용한다.
	 * @param res servlet에서 전달받은 HttpServletResponse. result redirect을 위하여 사용한다.
	 * @return void
	*/
    protected void catchService(HttpServletRequest req, HttpServletResponse res) {

        ServiceLoader loader = null;
        GauceService service = null;
        GauceResponse gauceRes = null;
        GauceRequest gauceReq = null;        
        try {

            loader = new ServiceLoader(req, res);
            service = loader.newService();
            gauceReq = service.getGauceRequest();
            gauceRes = service.getGauceResponse();

            LTraceID.regist("DEVON");
            this.process(req, res, gauceReq, gauceRes);            

        } catch (Exception e) {
            LLog.err.write("Unexpected Exception occurred - " + e.toString());
            String errorCode = e.getMessage();
            if (errorCode == null || !errorCode.startsWith(Constants.MSG_PREFIX))
                errorCode = Constants.MSG_ERROR_DEFAULT;
            this.processError(req, res, gauceReq, gauceRes, "LDefaultGauceChannelServlet-catchService Failed ", e);
            try {
                LMessageSource messageSource = new LMessageSource(req.getLocale());                
                String messageStr = messageSource.getMessage(errorCode); 
                gauceRes.writeException("ERROR", "ERROR", messageStr);
            } catch (Exception me) {
                // nothing
            }
        } finally {
            try {
                gauceRes.flush();
                gauceRes.commit();
                gauceRes.close();
                loader.restoreService(service);
            } catch (Throwable runtime) {
                runtime.printStackTrace(LLog.err);
            }
        }
    }
}
