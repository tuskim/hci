/* ------------------------------------------------------------------------
 * @source  : InitializeInputCommDevCmd.java
 * @desc    : 초기화면을 호출하는 공통 dev용 조회조건을 포함하는 Initialize cmd
 * ------------------------------------------------------------------------
 * 
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2010.04.21   김현수               Initial
 * ------------------------------------------------------------------------ */

package comm.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import devonframework.front.command.LCommandIF;
import devon.core.collection.LData;
import devon.core.log.LLog;

/**
 * <PRE>
 * 초기 화면을 호출하는 공통 Initail command
 * </PRE>
 *
 * @author    LG CNS 김현수
 * @version   1.0, 2010.04.21
 */
public class InitializeInputCommDevCmd implements LCommandIF {

    public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
         LLog.debug.write("\n InitializeInputCommDevCmd passby \n");
         
         LData inputData = LXssCollectionUtility.getData( req );
         
         req.setAttribute("inputData", inputData);
    }
}
