/*
 *------------------------------------------------------------------------------
 * DocPrintBiz.java,v 1.0 2010/10/06 16:43:35 
 * 
 * PROJ : PT-PAM
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2010/10/06   노태훈   Init
 *----------------------------------------------------------------------------
 */

package fi.ar.biz;
import java.util.Vector;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataSet;

import xi.GFI04; 
import xi.GFI05; 
import devon.core.exception.LException;
import devon.core.exception.LSysException;
import devon.core.log.LLog;
import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devonframework.persistent.autodao.LCommonDao;
import devonframework.persistent.autodao.LCompoundDao;

/**
 * <PRE>
 * Document Print List 업무를 처리하는 Biz 클래스.
 *
 * Database Tables : 
 * </PRE>
 * @author    CEH
 */
public class DocBargeBiz {

	/**
	 * Barge 조회
	 * @param inputData
	 * @return
	 * @throws LException
	 */
	public LMultiData retrieveDocBargeList(LData inputData) throws LException {    	
	
		LMultiData resultData = new LMultiData(); 	
		LCommonDao dao = new LCommonDao();
		String sql = "";
			try{			
				String workType= inputData.getString("workType");
				LLog.info.println(  "retrieveBargeSearch : inputData" + inputData.size());
				LLog.info.println(  "retrieveBargeSearch : inputData : docDateFrom : " +inputData.toString());

				if(inputData.getString("flag").equals("1")){
					sql = "fi/ar/docBargeSql/retrieveDocBarge";
					resultData =  dao.executeQuery(sql, inputData);
				}else{
					sql = "fi/ar/docBargeSql/retrieveBargeDoc";
					resultData =  dao.executeQuery(sql, inputData);
				}

			} catch (Exception se) {
				LLog.err.println(  this.getClass().getName() + "." + "rentalUnitSearch------()" + "=>" + se.getMessage());
				throw new LSysException("pbf.err.com.retrieve", se);
			}
			LLog.info.println(  "resultData : getDataCount" + resultData.getDataCount());
			LLog.info.println(  "resultData : getDataCount" + resultData.getDataCount());
			LLog.info.println(  "resultData : getDataCount" + resultData.getDataCount());
			LLog.info.println(  "resultData : getDataCount" + resultData.getDataCount());
			return resultData;
	}
}
