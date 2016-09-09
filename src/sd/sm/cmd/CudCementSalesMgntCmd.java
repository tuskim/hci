/*
 *------------------------------------------------------------------------------
 * CudProdCPOSalesMgntCmd.java,v 1.0 2012/10/10 
 * 
 * PROJ : JIT-HUB  
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2012/10/10   이태경         최초 프로그램 작성
 *----------------------------------------------------------------------------
 */

package sd.sm.cmd;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import sd.sm.biz.CementSalesMgntBiz;

import com.gauce.GauceDataSet;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import comm.util.LXssCollectionUtility;

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
 */
public class CudCementSalesMgntCmd implements LGauceCommandIF {
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
			
	try {
		 	LLog.info.write("\n CudCementSalesMgntCmd --> Start \n");	
		 	CementSalesMgntBiz biz = new CementSalesMgntBiz();
			LData lData = null;
			
			lData	= LXssCollectionUtility.getData(req);
			
			//-------------------------------------- Session 종료시 처리 START
			HttpSession session = req.getSession(false);
			LData loginUser = new LData();
			
			if (session != null) loginUser = (LData)session.getAttribute("loginUser");
			if( loginUser.getString("userId") == null) {
				String getMessage = "Session is Terminated. You need to relogin!";
				gauceResponse.writeException("Error", "", "\n[Detail Msg]==>" + getMessage);
				return;
			}
			//-------------------------------------- Session 종료시 처리 END
	
			GauceDataSet gdsm = gauceRequest.getGauceDataSet("IN_DS1");
			GauceDataSet gdsd = gauceRequest.getGauceDataSet("IN_DS2");
			
			if (gdsm == null && gdsd==null)
				return;
			
			//프린트 출력 후 주문상태 변경
			if("Y".equals(lData.getString("printMode"))) {
				LData inputm = LGauceConverter.convertToLDataWithJobType(gdsm);
				
				biz.updateCementSalesMasterStatus(inputm,loginUser);
			}else{
				LData result = null;
				
				LMultiData inputm = LGauceConverter.convertToLMultiDataWithJobType(gdsm);
				LMultiData inputd = LGauceConverter.convertToLMultiDataWithJobType(gdsd);	
				
				//prod detail만 수정되었을시
				if(inputm.getDataCount() ==0){	
					LLog.info.write("\n CudCementSalesMgntCmd > detail grid  -->\n" + inputd);
					biz.cudCementDetailList(inputd,loginUser);
					
					//CPO master,  detail수정시
				}else{	 	 
					LLog.info.write("\n CudCementSalesMgntCmd > main grid    -->\n" + inputm);	
					LLog.info.write("\n CudCementSalesMgntCmd > detail grid -->\n" + inputd);
					result = biz.CudCementSalesMgnt(inputm,inputd, loginUser); 
					
					String returnType = result.getString("returnType");
					String returnMsg = result.getString("returnMsg");	
					System.out.println(result);
					
					if(returnType.equals("99")){	
						gauceResponse.writeException("Error",99, returnMsg);
						return;
					}
				}
			}
			
			
		} catch (Exception e) {
			throw new LException(e.getMessage());
		} 
		LLog.info.write("\n CudCementSalesMgntCmd --> End \n");	
	}
}