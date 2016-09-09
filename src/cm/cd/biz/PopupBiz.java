/*
 *------------------------------------------------------------------------------
 * $Id: PopupBiz.java
 * 
 * PROJ : LGI-Hub System
 * Copyright 2010 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2010.08.05   mskim   Init
 *----------------------------------------------------------------------------
 */

package cm.cd.biz;

import javax.servlet.http.HttpServletRequest;

import comm.util.CommonUtil;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LException;
import devon.core.exception.LSysException;
import devon.core.log.LLog;
import devonframework.bridge.gauce.util.LGauceConverter;
import devonframework.persistent.autodao.LCommonDao;
import devonframework.persistent.autodao.LCompoundDao;

public class PopupBiz {


	/* ******************************
	 * 팝업 Account Code List 조회
	 * ******************************/
	public LMultiData retrieveAccountCodeListPopup(LData inputData) throws LException {

		LLog.info.write("\n popupBiz > retrieveAccountCodeListPopup() -------> Start \n");
		
        LCommonDao dao = new LCommonDao();
		try{
			
			String acctGb = inputData.getString("acctGb");
			if (acctGb.equals("LOC")) {
				return dao.executeQuery("/cm/cd/popupSql/retrieveLocAccountCodeListPopup", inputData);
			} else {
				return dao.executeQuery("/cm/cd/popupSql/retrieveSapAccountCodeListPopup", inputData);
			}
			
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveAccountCodeListPopup------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		} 
    }

	/* ******************************
	 * 팝업 Material Code List 조회
	 * ******************************/
	public LMultiData retrieveMaterialCodeListPopup(LData inputData) throws LException {

		LLog.info.write("\n popupBiz > retrieveMaterialCodeListPopup() -------> Start \n");
		
        LCommonDao dao = new LCommonDao();
		try{
			return dao.executeQuery("/cm/cd/popupSql/retrieveMaterialCodeListPopup", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveMaterialCodeListPopup------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		} 
    }
	
	/* ******************************
	 * 팝업 Vendor Code List 조회
	 * ******************************/
	public LMultiData retrieveVendorCodeListPopup(LData inputData) throws LException {

		LLog.info.write("\n popupBiz > retrieveVendorCodeListPopup() -------> Start \n");
		
        LCommonDao dao = new LCommonDao();
		try{
			return dao.executeQuery("/cm/cd/popupSql/retrieveVendorCodeListPopup", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveVendorCodeListPopup------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		} 
    }

	public LMultiData retrieveVendorDetailList(LData inputData) throws LSysException {
		LLog.info.write("\n popupBiz > retrieveVendorDetailList() -------> Start \n");
		
        LCommonDao dao = new LCommonDao();
		try{
			return dao.executeQuery("/cm/cd/popupSql/retrieveVendorDetailList", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveVendorDetailList------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		} 
	}
	
	public LMultiData retrieveMaterPopupPoCombo(LData inputData) throws LSysException {
		LLog.info.write("\n popupBiz > retrieveMaterPopupPoCombo() -------> Start \n");
		
        LCommonDao dao = new LCommonDao();
		try{
			return dao.executeQuery("/cm/cd/popupSql/retrieveMaterPopupPoCombo", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveMaterPopupPoCombo------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		} 
	}	

	public LData cudVendorDetail(LMultiData dataMst, LData loginUser, HttpServletRequest req) throws LException {
        LCompoundDao dao = new LCompoundDao();
        LData result = new LData();
        
		LLog.debug.println("cudStockMove mData--------------- =>\n " + dataMst.toString());
		
		String	getErrorCode = "0" ;
		String	getMessage	 = "Failed"; 	

        try{			
        	dao.startTransaction();
        	
	        
			// Purchase Order App 
			for(int j=0;j<dataMst.getDataCount();j++) {
				
				LData cudAppData = dataMst.getLData(j);
		    	String tr_Mode  = cudAppData.getString("DEVON_CUD_FILTER_KEY");

		    	cudAppData.setString("userId",    loginUser.getString("userId"));
				cudAppData.setString("companyCd", loginUser.getString("companyCd"));
				cudAppData.setString("vendCd", req.getParameter("vendCd"));
				cudAppData.setString("lang",       loginUser.getString("lang"));
				if( tr_Mode.equals("DEVON_CREATE_FILTER_VALUE") ) {
					//Purch Order  App Insert
					dao.add("po/oc/purchOrderRegSql/cudPurchOrderRegAppInsert", cudAppData);
						
				} else if( tr_Mode.equals("DEVON_UPDATE_FILTER_VALUE") ) {

					//Purch Order  App Update
					dao.add("po/oc/purchOrderRegSql/cudPurchOrderRegAppUpDate", cudAppData);

				} else if( tr_Mode.equals("DEVON_DELETE_FILTER_VALUE") ) {

					//Purch Order App Delete
					dao.add("po/oc/purchOrderRegSql/cudPurchOrderRegAppDel", cudAppData);
				}
			
			}		
			
			dao.executeUpdate();
			
			dao.commit();
			
		} catch (Exception se) {
			dao.rollback();
			LLog.err.println(  this.getClass().getName() + "." + "cudStockMove()" + "=>" + se.getMessage());
			//throw new LSysException("pbf.err.com.save", se);
			getErrorCode = "-1403";
			getMessage = se.getMessage();
			throw new LSysException(getMessage,se);
        }
		
		result.put("getErrorCode"	,getErrorCode);
		result.put("getMessage"	,getMessage);
		
		return result;
	}
	
	/* ******************************
	 * 팝업 Master Code List PO 조회
	 * ******************************/
	public LMultiData retrieveMaterialCodeListPopupCon(LData inputData) throws LException {

		LLog.info.write("\n popupBiz > retrieveMaterialCodeListPopupCon() -------> Start \n");
		
        LCommonDao dao = new LCommonDao();
		try{
			return dao.executeQuery("/cm/cd/popupSql/retrieveMaterialCodeListPopupCon", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveMaterialCodeListPopupCon------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		} 
    }	
	
	/* ******************************
	 * 팝업 Master Code List Sales 조회
	 * ******************************/
	public LMultiData retrieveProductMaterialCodeListPopupCon(LData inputData) throws LException {

		LLog.info.write("\n popupBiz > retrieveProductMaterialCodeListPopupCon() -------> Start \n");
		
        LCommonDao dao = new LCommonDao();
		try{
			return dao.executeQuery("/cm/cd/popupSql/retrieveProductMaterialCodeListPopupCon", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveProductMaterialCodeListPopupCon------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		} 
    }
}
