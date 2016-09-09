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
import devonframework.front.util.LCollectionUtility;
import devon.core.collection.LData;
import devon.core.log.LLog;

/**
 * <PRE>
 * 초기 화면을 호출하는 공통 Initail command
 * </PRE>
 *
 * @author   김현수
 * @version   1.0, 2009.09.07
 */
public class InitializePoPCommDevCmd implements LCommandIF {

    public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
         LLog.info.write("\n InitializePoPCommDevCmd passby \n");
         
         req.setCharacterEncoding("utf-8");
         
         LData inputData = LCollectionUtility.getData(req);
         
         LLog.info.println(inputData);
         
         req.setAttribute("inputData", inputData);
    }
}
