/*
 *------------------------------------------------------------------------------
 * GFI07.java 
 * 
 * PROJ : PT-PAM
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2015/12/11   hckim   최초 프로그램 작성
 *----------------------------------------------------------------------------
 */

package xi;

import com.lgicorp.gims.sap.gfi07.GFI07R_GIMS_DTITEM;
import com.lgicorp.gims.sap.gfi07.GFI07_GIMS_DTITEM;
import com.lgicorp.gims.sap.gfi07.GFI07_outBindingStub;
import com.lgicorp.gims.sap.gfi07.GFI07_outServiceLocator;
import comm.util.Util;
import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LSysException;
import devon.core.log.LLog;

public class GFI07 {
	
	public LData GFI07_out(LMultiData headerData) throws LSysException {
		
		LLog.info.write("GFI07_out Service Start");
		
		Util util = new Util();
		LData resultMsg = new LData();
		
		GFI07_GIMS_DTITEM[] GFI07_DT = new GFI07_GIMS_DTITEM[headerData.getDataCount()];
		GFI07R_GIMS_DTITEM[] R_GFI07_DT = new GFI07R_GIMS_DTITEM[headerData.getDataCount()];
						
		LLog.info.write("Master : \n" + headerData);		
		
		//DT에 header 데이터 Setting
		for (int i = 0; i < headerData.getDataCount(); i++) {
			
			LData headRowData = headerData.getLData(i);
			
			GFI07_GIMS_DTITEM headerItem = new GFI07_GIMS_DTITEM();
			
			headerItem.setCOMPANY_CD(util.nullToString(headRowData.getString("companyCd")));
			headerItem.setREQUEST_NO(util.nullToString(headRowData.getString("requestNo")));
			headerItem.setSAP_DOC_NO(util.nullToString(headRowData.getString("docNo")));
			headerItem.setFISCAL_YEAR(util.nullToString(headRowData.getString("fiscalYear")));
			headerItem.setLINE_ITEM(util.nullToString(headRowData.getString("lineItem")));
			headerItem.setBASELINE_DATE(util.nullToString(headRowData.getString("baselineDate")));			
			headerItem.setPAYMENT_METHOD(util.nullToString(headRowData.getString("paymentMethod")));
			headerItem.setPARTNER_BANK_TYPE(util.nullToString(headRowData.getString("partnerBankType")));
			headerItem.setPAYMENT_BLOCK_KEY(util.nullToString(headRowData.getString("paymentBlock")));
			headerItem.setHOUSE_BANK(util.nullToString(headRowData.getString("houseBank")));			
			headerItem.setATTR1(util.nullToString(headRowData.getString("attr01")));
			headerItem.setATTR2(util.nullToString(headRowData.getString("attr02")));
			headerItem.setATTR3(util.nullToString(headRowData.getString("attr03")));
			headerItem.setATTR4(util.nullToString(headRowData.getString("attr04")));
			headerItem.setATTR5(util.nullToString(headRowData.getString("attr05")));
			headerItem.setATTR6(util.nullToString(headRowData.getString("attr06")));
			headerItem.setATTR7(util.nullToString(headRowData.getString("attr07")));
			headerItem.setATTR8(util.nullToString(headRowData.getString("attr08")));
			headerItem.setATTR9(util.nullToString(headRowData.getString("attr09")));
			headerItem.setATTR10(util.nullToString(headRowData.getString("attr10")));
						
			GFI07_DT[i] = headerItem;
		}				  		
		
		try{
			
			GFI07_outServiceLocator serviceLocator = new GFI07_outServiceLocator();
	        
			LLog.info.println(util.getProp("EAI_HTTP_URL_PTPAM_GFI07_SAP"));
	        
			serviceLocator.setHTTP_PortEndpointAddress(util.getProp("EAI_HTTP_URL_PTPAM_GFI07_SAP"));
	        
	        GFI07_outBindingStub bindingStub = (GFI07_outBindingStub) serviceLocator.getHTTP_Port();
	            
            bindingStub.setUsername(util.getProp("EAI_USER"));
            bindingStub.setPassword(util.getProp("EAI_PWD"));

            //XI 전송 및 결과 Return
            LLog.info.println("XI Connection try!!");
            
            R_GFI07_DT = bindingStub.GFI07_out(GFI07_DT);
            
            LMultiData sapResultList = new LMultiData();   
            
         	if(R_GFI07_DT!=null){     
	        	
         		for(int j=0; j<R_GFI07_DT.length;j++){
         			         		         		             		          		            		            		                 		          		
         			sapResultList.add( "companyCd"       ,R_GFI07_DT[j].getCOMPANY_CD());
         			sapResultList.add( "requestNo"       ,R_GFI07_DT[j].getREQUEST_NO());
         			sapResultList.add( "paymentBlockKey" ,R_GFI07_DT[j].getPAYMENT_BLOCK_KEY());
         			sapResultList.add( "sapRequestNo"    ,R_GFI07_DT[j].getSAP_REQUEST_NO());
         			sapResultList.add( "sapStatus"       ,R_GFI07_DT[j].getSAP_STATUS());
         			sapResultList.add( "sapRtnMsg"       ,R_GFI07_DT[j].getSAP_RTN_MSG());
	            }	             
         	}
         	
         	LLog.info.write("sapResultList : \n" + sapResultList);
	        
         	// 동일한 SAP 결과 정보가  들어옴 - 첫번째 ROW 정보 받음
         	resultMsg =  sapResultList.getLData(0);	
         	
         	LLog.info.write("resultMsg : \n" + resultMsg);
		
		} catch(Exception e){
			e.getMessage();
			throw new LSysException(e.getMessage());
		}
		
		return resultMsg;
	}	
}
