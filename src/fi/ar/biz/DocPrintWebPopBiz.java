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
public class DocPrintWebPopBiz {

 
    /**
     * Doc Print List For Web 정보를 Grid 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveDocPrintWebPopListOutPut(LData inputData,LMultiData mData) throws LException {    	
    	
    	LLog.debug.write("retrieveDocPrintWebPopListOutPut -----------> Start ");
    	
    	LMultiData resultTot = new LMultiData();
    	LCommonDao dao = new LCommonDao();
		try{	 
			/*StringBuffer strYmKey= new StringBuffer();
			StringBuffer strSeqKey= new StringBuffer();
			
			for(int i=0;i<mData.getDataCount();i++){
				if(mData.getDataCount()==1){
					strYmKey.append(mData.getLData(i).get("docYm"));
					strSeqKey.append(mData.getLData(i).get("docSeq"));
				}else{
					if(i==0){
						strYmKey.append(mData.getLData(i).get("docYm")+"'");
						strSeqKey.append(mData.getLData(i).get("docSeq")+"'");
					}else if((mData.getDataCount()-1)==i){
						strYmKey.append(",'"+mData.getLData(i).get("docYm"));
						strSeqKey.append(",'"+mData.getLData(i).get("docSeq"));
					}else{
						strYmKey.append(",'"+mData.getLData(i).get("docYm")+"'");
						strSeqKey.append(",'"+mData.getLData(i).get("docSeq")+"'");
					}
				}
			}	
			inputData.set("docYm",strYmKey);
			inputData.set("docSeq",strSeqKey);
			*/
		 
			LMultiData result = new LMultiData();
			for(int i=0;i<mData.getDataCount();i++){
				
				mData.modify("companyCd", i, inputData.get("companyCd"));
				mData.modify("userId", i, inputData.get("userId"));
				mData.modify("userNm", i, inputData.get("userNm"));
				mData.modify("deptCd", i, inputData.get("deptCd"));
				mData.modify("lang", i, inputData.get("lang"));
				 
				 
				result= dao.executeQuery("fi/ar/docPrintWebPopSql/retrieveDocPrintWebPopListOutPut", mData.getLData(i));
			 
				if(i==0){
					resultTot.setMetaData(result.getMetaData());
				} 
				resultTot.addLMultiData(result);
				
			}
 
			int count=resultTot.getDataCount();
			for(int j=0;j<count;j++){ 
				 
				if(resultTot.getLData(j).get("docYmSeq")==null){
					
					 
					resultTot.removeRow(j);
					j=0;
					count=resultTot.getDataCount();
				}else if(resultTot.getLData(j).get("docYmSeq").equals("")){
  
					j=0;
					count=resultTot.getDataCount();					
					resultTot.removeRow(j);
				}else if(resultTot.getLData(j).get("docYmSeq").equals("null")){
		  
					j=0;
					count=resultTot.getDataCount();					
					resultTot.removeRow(j);
				}					
			} 
			return resultTot;
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveDocPrintWebPopListOutPut------()" + "=>" + se.getMessage());
			throw new LSysException("fi.ar.biz.retrieveDocPrintWebPopListOutPut", se);
		} 
    }   
}
