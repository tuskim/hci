/*
 *------------------------------------------------------------------------------
 * CementSalesMgntBiz.java,v 1.0 2016/08/02  
 * 
 * PROJ : HCI 프로젝트
 * Copyright 2006-2016 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2016.08.02   hskim    Init
 *----------------------------------------------------------------------------
 */

package sd.sc.biz;

import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Date;

import rfc.biz.RetrieveCustomerCreditLimitRFC;
import xi.GSD01;
import xi.GSD03;

import devon.core.exception.LBizException;
import devon.core.exception.LException;
import devon.core.exception.LSysException;
import devon.core.log.LLog;
import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devonframework.persistent.autodao.LCommonDao;
import devonframework.persistent.autodao.LCompoundDao;
/**
 * <PRE>
 * Cement Sales Management 업무를 처리하는 Biz 클래스.
 *
 * Database Tables : 
 * </PRE>
 * @author    LTK
 */
public class CustomerCreditBiz {

	/**
	 * Cement Sales 조회
	 * @param inputData 검색조건 입력 값
	 * @return Cement Sales 목록 조회
	 * @throws LException
	 */
	public LMultiData retrieveCustomerCreditList(LData inputData) throws LException {

		RetrieveCustomerCreditLimitRFC rbiz = new RetrieveCustomerCreditLimitRFC();
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date nowDate = new Date();
		
		LMultiData resultData = new LMultiData();
		LData salesData = new LData();
		
		double salesAmount = 0.0;
		
        try {
        	
        	
        	resultData = rbiz.getVendorCreditLimit(inputData);
        	
	    	for (int i = 0; i < resultData.getDataCount(); i++) {
	    		
	    		Date formDate = format.parse(resultData.getString("DATAB", i));
	    		Date toDate = format.parse(resultData.getString("DATBI", i));
	    		
	    		LLog.debug.write("WEB 등록 여신 체크 전(SAP 여신)");
	    		System.out.println(resultData);
	    		
	    		LLog.debug.write("Current Date : " + nowDate);
	    		LLog.debug.write("Form Date : " + formDate);
	    		LLog.debug.write("To Date  : " + toDate);
	    		
	    		if (nowDate.before(toDate)) {
	    			
	    			if (nowDate.after(formDate)) {
	    				
	    				LLog.debug.write("여신 유효 기간 OK!");
	    				
	    				//WEB 기 등록 한 Open Sales 금액 조회
	    				LCommonDao dao = new LCommonDao( "/sd/sc/customerCreditSql/retrieveCustomerSalesAmount",resultData.getLData(i) );
	    				salesData = dao.executeQueryForSingle();
	    				
	    				if (salesData.isEmpty()) {
	    					salesAmount = 0.0;
	    				} else {
	    					salesAmount = salesData.getDouble("salesAmount");
	    				}
	    				
	    				//resultData.modifyDouble("OPEN_SALES", i, resultData.getDouble("OPEN_SALES", i) + salesAmount); //SAP Open S/O 금액 + WEB S/O 금액
	    				resultData.modifyDouble("OPEN_SALES_WEB", i, salesAmount); //WEB S/O 금액
	    				resultData.modifyDouble("clExposure", i, resultData.getDouble("SKFOR", i) + resultData.getDouble("OPEN_SALES", i) 
	    						                                 + resultData.getDouble("OPEN_SALES_WEB", i) - resultData.getDouble("SSOBL", i)); //여신 사용 금액 업데이트 
	    				resultData.modifyDouble("clAvailable", i, resultData.getDouble("cl", i) - resultData.getDouble("clExposure", i)); //여신 잔액 업데이트
	    				
	    				LLog.debug.write("WEB 등록 여신 체크 후");
	    	    		System.out.println(resultData);
	    	    		
	    			} else {
	    				LLog.debug.write("여신 유효 기간 NG! : 시작일 보다 작음");
	    			}
	    		} else {
	    			LLog.debug.write("여신 유효 기간 NG! : 종료일 보다 큼");
	    		}
	    	}
        	
        	
        	
        } catch (Exception le ) {
        	LLog.err.write(this.getClass().getName()+"." +"retrieveCementSalesMgntList()"+"=>"+le.getMessage());
            throw new LBizException("sd.sm.cmd.retrieve");
        }
        return resultData;
	}

	

}
 
