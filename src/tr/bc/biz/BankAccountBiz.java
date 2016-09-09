/*
 *------------------------------------------------------------------------------
 * $Id: BankAccountBiz.java
 * 
 * PROJ : LGI-Hub System
 * Copyright 2010 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2015.11.26           Init
 *----------------------------------------------------------------------------
 */

package tr.bc.biz;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LException;
import devon.core.exception.LSysException;
import devon.core.log.LLog;
import devonframework.persistent.autodao.LCommonDao;

public class BankAccountBiz {

	/* ******************************
	 * Vendor Bank Account List 조회
	 * ******************************/
	public LMultiData retrieveVendorBankAcctListPopup(LData inputData) throws LException {

		LLog.info.write("\n BankAccountBiz > retrieveVendorBankAcctListPopup() -------> Start \n");
		
        LCommonDao dao = new LCommonDao();
        
		try{
			return dao.executeQuery("/tr/bc/bankAccountSql/retrieveVendorBankAcctListPopup", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveVendorBankAcctListPopup------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		} 
    }
	
	/* ******************************
	 * Payment Bank Account List 조회
	 * ******************************/
	public LMultiData retrievePaymentBankAcctListPopup(LData inputData) throws LException {

		LLog.info.write("\n BankAccountBiz > retrievePaymentBankAcctListPopup() -------> Start \n");
		
        LCommonDao dao = new LCommonDao();
        
		try{
			return dao.executeQuery("/tr/bc/bankAccountSql/retrievePaymentBankAcctListPopup", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrievePaymentBankAcctListPopup------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		} 
    }

}
