/* ------------------------------------------------------------------------
 * @source  : RetrieveCementPackingAddRowCmd.java
 * @desc    : [Add Row] New Data Search
 * ------------------------------------------------------------------------
 *
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2016.08.03   kjkim               Initial
 * ------------------------------------------------------------------------ */

package ps.pk.cmd;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ps.pk.biz.CementPackingBiz;

import com.gauce.GauceDataSet;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import comm.util.LXssCollectionUtility;

import devon.core.collection.LData;
import devon.core.log.LLog;
import devonframework.bridge.gauce.command.LGauceCommandIF;
import devonframework.bridge.gauce.util.LGauceConverter;

public class RetrieveCementPackingAddRowCmd implements LGauceCommandIF {

	public void execute(HttpServletRequest req, HttpServletResponse res, GauceRequest gauceRequest, GauceResponse gauceResponse) throws Exception {

		LLog.debug.write("RetrieveCementPackingAddRowCmd --> Start");

		CementPackingBiz biz = new CementPackingBiz();
		GauceDataSet dsGrid = new GauceDataSet("ds_master");

		LData lData = null;

		lData = LXssCollectionUtility.getData(req);

		HttpSession session = req.getSession();
		LData loginUser = (LData) session.getAttribute("loginUser");
		lData.setString("lang", loginUser.getString("lang"));
		lData.setString("companyCd", loginUser.getString("companyCd"));

		gauceResponse.enableFirstRow(dsGrid);

		LGauceConverter.extractToGauceDataSet(biz.retrieveClinkerProductionAddRow(lData), dsGrid);

		dsGrid.flush();

		LLog.debug.write("RetrieveCementPackingAddRowCmd --> End");

	}

}
