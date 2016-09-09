package cm.ur.cmd;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cm.ur.biz.UserMgntBiz;

import com.gauce.GauceDataSet;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

import devon.core.collection.LData;
import devon.core.exception.LException;
import devon.core.log.LLog;
import devonframework.bridge.gauce.command.LGauceCommandIF;
import devonframework.bridge.gauce.util.LGauceConverter;


/**
 * <pre>사용자 ID Check 관련( 가우스 ) Cmd</pre>
 * 
 * @author    
 * @version     1.0     2010.02.23
 * @copyright   2009    lams
 * @history
*/
public class RetrieveUserIdCheckCmd implements LGauceCommandIF {

	/**
	 * <pre>사용자 ID가 존재하는지 점검한다./pre>
	 * 
     * @author 	
     * @update
     * @since  	
	 * @param 	lData		LData
	 * @return	결과정보
	 * @throws 	Exception
	 */
	public void execute(HttpServletRequest req, HttpServletResponse res, GauceRequest gauceRequest, GauceResponse gauceResponse) throws LException {
		
		LLog.info.write("\n RetrieveUserIdCheckCmd --> Start \n");	


		UserMgntBiz 	biz 	= new UserMgntBiz();
		GauceDataSet 	gsuDsReq 	= gauceRequest.getGauceDataSet("ds_param");
		GauceDataSet 	gauDsRes 	= new GauceDataSet("ds_temp");
		LData			lData 		= new LData();

		//-------------------------------------- Session 종료시 처리 START
	    HttpSession session = req.getSession(false);
	    LData loginUser = new LData();
	    
	    if (session != null) loginUser = (LData)session.getAttribute("loginUser");
	    if( loginUser.getString("userId") == null) {
	    	String getMessage = "Session is Terminated. You need to relogin!";
	    	return;
	    }
	 //-------------------------------------- Session 종료시 처리 END
	 
		
		if( null != gsuDsReq ) {
			lData = LGauceConverter.convertToLDataWithJobType(gsuDsReq);
		}
		   lData.setString("companyCd", loginUser.getString("companyCd"));
		    lData.setString("lang", 	 loginUser.getString("lang"));

	
		
		gauceResponse.enableFirstRow( gauDsRes );
		LGauceConverter.extractToGauceDataSet( biz.userIdCheck(lData), gauDsRes );
		gauDsRes.flush();		
		
		LLog.info.write("\n RetrieveUserIdCheckCmd --> End \n");
	}
}
