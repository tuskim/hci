/* ------------------------------------------------------------------------
 * @source  : InitializeCommDevCmd.java
 * @desc    : 초기 화면을 호출하는 공통 dev용 Initialize cmd
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

import devonframework.front.command.LCommandIF;
import devon.core.log.LLog;

/**
 * <PRE>
 * 초기 화면을 호출하는 공통 Initail command
 * </PRE>
 *
 * @author    LG 패션 MDP 개발 심현철
 * @version   1.0, 2008.09.25
 */
public class InitializeCommDevCmd implements LCommandIF {

    public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
         LLog.info.write("\n InitializeCommDevCmd passby \n");
    }
}
