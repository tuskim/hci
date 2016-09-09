/*
 *------------------------------------------------------------------------------
 * RetrieveMainNoticeCmd.java,v 1.0 2010/05/30 16:43:35 
 * 
 * PROJ : JIT-HUB 
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2010/05/30   hani1005         최초 프로그램 작성
 *----------------------------------------------------------------------------
 */

package cm.lo.login.cmd;

import comm.util.LXssCollectionUtility;
import comm.util.SecurityUtil;
import cm.lo.login.biz.commRetrieveUserBiz;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.gauce.GauceDataSet;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LException;
import devon.core.log.LLog;
import devonframework.bridge.gauce.command.LGauceCommandIF;
import devonframework.bridge.gauce.util.LGauceConverter;
/**
 * <PRE>
 * 
 * 
 * </PRE>
 * 
 * @author    ceh
 * @see       
 */
public class commRetrieveUserPwCmd implements LGauceCommandIF {
    /**
     * 
     *
     * @param req Http Request 객체.
     * @param res Http Response 객체.
     * @param gauceRequest 가우스 Request 객체.
     * @param gauceResponse 가우스 Response 객체.
     * @exception LException Commnad 단 이하의 모든 에러.
     */
	public void execute(HttpServletRequest req, HttpServletResponse res, GauceRequest gauceRequest, GauceResponse gauceResponse) throws Exception { 
		LData inputData = LXssCollectionUtility.getData(req);
		commRetrieveUserBiz Biz = new commRetrieveUserBiz();
		LMultiData result = Biz.commRetrieveUserPw(inputData);  
		if(result.getDataCount()>0){
			result.modify("userPw", 0, SecurityUtil.decrypt((result.getString("userPw",0))))	;
		}
		GauceDataSet gds = new GauceDataSet("ds_findPw");
		gauceResponse.enableFirstRow(gds);
		LGauceConverter.extractToGauceDataSet(result, gds);
		gds.flush();

		
	}

}
