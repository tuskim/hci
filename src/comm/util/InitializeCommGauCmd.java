/* ------------------------------------------------------------------------
 * @source  : InitializeCommGauCmd.java
 * @desc    : 초기 화면을 호출하는 공통  gau용 Initialize cmd
 * ------------------------------------------------------------------------
 * 
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2008.09.25   심현철             Initial
 * ------------------------------------------------------------------------ */

package comm.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

import devon.core.log.LLog;
import devonframework.bridge.gauce.command.LGauceCommandIF;

/**
 * <PRE>
 * 초기 화면을 호출하는 공통 Initail command
 * </PRE>
 *
 * @author    LG 패션 MDP 개발 심현철
 * @version   1.0, 2008.09.25
 */
public class InitializeCommGauCmd implements LGauceCommandIF {

    public void execute(HttpServletRequest req, HttpServletResponse res, GauceRequest gauceRequest, GauceResponse gauceResponse) throws Exception {
    	LLog.info.write("\n InitializeCommGauCmd passby \n");
    }
}
