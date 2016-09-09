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
public class DocPrintBiz {

 
    /**
     * Doc Type For Web 정보를 ComboBox조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveDocTypeWebComboList(LData inputData) throws LException {    	
    	
    	LLog.debug.write("retrieveDocTypeWebComboList -----------> Start ");
    	
    	LCommonDao dao = new LCommonDao();
		try{			
			return dao.executeQuery("fi/ar/docPrintSql/retrieveDocTypeWebComboList", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveDocTypeWebComboList------()" + "=>" + se.getMessage());
			throw new LSysException("fi.ar.biz.retrieveDocTypeWebComboList", se);
		}
    }     
    /**
     * Document Doc Print List 정보를 Grid조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveDocPrintList(LData inputData) throws LException {
		
    	LLog.info.write("\n retrieveDocPrintList ------------- Start \n");
    	
        LCompoundDao dao		= new LCompoundDao();       
        LCommonDao xdao		= new LCommonDao(); 
         
		String	getMessage		= "";  
		LData resultMsg		    = new LData(); 
		LMultiData resultDtlMsg  = new LMultiData();
		try{
			
			LData xmlNo = xdao.executeQueryForSingle("cm/cm/commCodeMgntSql/retireveXmlDocNo", inputData); 
			LData webNo = xdao.executeQueryForSingle("fi/ar/docPrintSql/retrieveDocTypeWebPoNo", inputData); 
			dao.startTransaction();
 
			GFI04 gfi04 = new GFI04();
			Vector oResultMsg = gfi04.GFI04_out(xmlNo,webNo, inputData);
 
			resultMsg =(LData) oResultMsg.get(0);
	 
			resultDtlMsg =(LMultiData) oResultMsg.get(1); 
			if(resultMsg.size()!=0){
				if (resultMsg.getString("returnType").equals("0")) {
					getMessage = resultMsg.getString("returnText");
					LLog.err.println(  this.getClass().getName() + "." + "retrieveDocPrintList1-returnType::" +resultMsg.getString("returnType")+"=>\n" + getMessage);			
				} else {  
					getMessage = resultMsg.getString("returnText");
					LLog.err.println(  this.getClass().getName() + "." + "retrieveDocPrintList2-returnType:: "+resultMsg.getString("returnType")+"=>\n" + getMessage);
					//throw new LSysException(getMessage); 
				}
			}else{
				LLog.err.println(  this.getClass().getName() + "." + "retrieveDocPrintList No Return Date");
			}
			 
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveDocPrintList Exceiption------()" + "=>" + se.getMessage());
			throw new LSysException("fi.ar.biz.retrieveDocPrintList Exceiption", se); 
		} 
		return resultDtlMsg;
	}
    /**
     * Document Doc Print List 정보를  출력하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveDocPrintListOutPut(LData inputData,LMultiData inputMulit) throws LException {    	
		
    	LLog.info.write("\n retrieveDocPrintListOutPut ------------- Start \n");

        LCompoundDao dao		= new LCompoundDao();       
        LCommonDao xdao		= new LCommonDao(); 
         
		String	getMessage		= "";  
		LData resultMsg		    = new LData();  
		LMultiData resultDtlMsg  = new LMultiData();
		try{
			
			LData xmlNo = xdao.executeQueryForSingle("cm/cm/commCodeMgntSql/retireveXmlDocNo", inputData); 
			dao.startTransaction();
 
			GFI05 gfi05 = new GFI05();
			Vector oResultMsg = gfi05.GFI05_out(xmlNo, inputData,inputMulit);
 
			resultMsg =(LData) oResultMsg.get(0);
	 
			resultDtlMsg =(LMultiData) oResultMsg.get(1); 
			if(resultMsg.size()!=0){
				if (resultMsg.getString("returnType").equals("0")) {
					getMessage = resultMsg.getString("returnText");
					LLog.err.println(  this.getClass().getName() + "." + "retrieveDocPrintListOutPut1-returnType::" +resultMsg.getString("returnType")+"=>\n" + getMessage);			
				} else {  
					getMessage = resultMsg.getString("returnText");
					LLog.err.println(  this.getClass().getName() + "." + "retrieveDocPrintListOutPut2-returnType:: "+resultMsg.getString("returnType")+"=>\n" + getMessage);
					//throw new LSysException(getMessage); 
				}
			}else{
				LLog.err.println(  this.getClass().getName() + "." + "retrieveDocPrintListOutPut No Return Date");
			}
			 
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveDocPrintListOutPut Exceiption------()" + "=>" + se.getMessage());
			throw new LSysException("fi.ar.biz.retrieveDocPrintListOutPut Exceiption", se); 
		} 
		return resultDtlMsg;
	}
}
