/*
 *------------------------------------------------------------------------------
 * GFI10.java 
 * 
 * PROJ : PT-GAM
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2015/12/29   hckim   최초 프로그램 작성
 *----------------------------------------------------------------------------
 */

package xi;

import java.util.Vector;

import com.lgicorp.gims.sap.gfi10.GFI10R_GIMS_DT;
import com.lgicorp.gims.sap.gfi10.GFI10R_GIMS_DTITEM;
import com.lgicorp.gims.sap.gfi10.GFI10R_GIMS_DTZSAPMSG;
import com.lgicorp.gims.sap.gfi10.GFI10_GIMS_DT;
import com.lgicorp.gims.sap.gfi10.GFI10_GIMS_DTHEADER;
import com.lgicorp.gims.sap.gfi10.GFI10_outBindingStub;
import com.lgicorp.gims.sap.gfi10.GFI10_outServiceLocator;
import comm.util.Util;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LSysException;
import devon.core.log.LLog;

public class GFI10 {
	
	public Vector GFI10_out(LData inputData) throws LSysException {
		
		LLog.info.write("GFI10_out Service Start");
		
		Util util = new Util();
		LData resultMsg = new LData();

		GFI10_GIMS_DT GFI10_DT = new GFI10_GIMS_DT();
		GFI10R_GIMS_DT R_GFI10_DT = new GFI10R_GIMS_DT();
	  
		GFI10_GIMS_DTHEADER GFI10HD = new GFI10_GIMS_DTHEADER(); 
		GFI10_GIMS_DTHEADER GFI10DTS = new GFI10_GIMS_DTHEADER();
		
		GFI10DTS.setCOMPANY_CD(util.nullToString(inputData.getString("companyCd")));
		GFI10DTS.setFISCAL_YEAR(util.nullToString(inputData.getString("yearMonth")));
		GFI10DTS.setCOST_CENTER(util.nullToString(inputData.getString("costCenter")));
		GFI10DTS.setASSET_CLASS(util.nullToString(inputData.getString("assetClass")));
		GFI10DTS.setASSET_NO(util.nullToString(inputData.getString("assetNo")));
		GFI10DTS.setASSET_NM(util.nullToString(inputData.getString("assetNm")));
 
		GFI10HD = GFI10DTS;		
		
		GFI10_DT.setHEADER(GFI10HD);

		GFI10R_GIMS_DTZSAPMSG zsapmsg = new GFI10R_GIMS_DTZSAPMSG();  	

		Vector rtn = new Vector();
		
		try{
			
			GFI10_outServiceLocator serviceLocator = new GFI10_outServiceLocator();
 
			LLog.debug.write(util.getProp("EAI_HTTP_URL_PTPAM_GFI10_SAP"));
 
			serviceLocator.setHTTPS_PortEndpointAddress(util.getProp("EAI_HTTP_URL_PTPAM_GFI10_SAP"));						
 
			GFI10_outBindingStub bindingStub = (GFI10_outBindingStub) serviceLocator.getHTTP_Port();		
  
            bindingStub.setUsername(util.getProp("EAI_USER"));
            bindingStub.setPassword(util.getProp("EAI_PWD"));

            //XI 전송 및 결과 Return
            LLog.debug.write("XI Connection try!!");
            
            R_GFI10_DT = bindingStub.GFI10_out(GFI10_DT);                
            
            zsapmsg = R_GFI10_DT.getZSAPMSG(); 
             
            GFI10R_GIMS_DTITEM[] itemsmsg = R_GFI10_DT.getITEM();
            
            LLog.info.write("GFI10 zsapmsg.getMTYPE() :: " + zsapmsg.getMTYPE());
            LLog.info.write("GFI10 zsapmsg.getMTEXT() :: " + zsapmsg.getMTEXT());
 
            resultMsg.setString("returnType", zsapmsg.getMTYPE());
            resultMsg.setString("returnText", zsapmsg.getMTEXT());
             		
            LMultiData currentAssetList = new LMultiData();   
                                   
         	if(itemsmsg!=null){     
	        	
         		for(int j=0; j<itemsmsg.length;j++){
         			         		         		             		          		            		            		                 		          		
            		currentAssetList.add( "assetNo"       ,itemsmsg[j].getASSET_NO().trim());        // Asset No
	        		currentAssetList.add( "assetSubNo"    ,itemsmsg[j].getASSET_SUB_NO().trim());    // Asset Sub No
	        		currentAssetList.add( "assetNm"       ,itemsmsg[j].getASSET_NM().trim());        // Asset Name
		            currentAssetList.add( "assetClass"    ,itemsmsg[j].getASSET_CLASS().trim());     // Asset Class
		            currentAssetList.add( "assetClassNm"  ,itemsmsg[j].getASSET_CLASS_NM().trim());  // Asset Class Name
		            currentAssetList.add( "costCenter"    ,itemsmsg[j].getCOST_CENTER().trim());     // Cost Center
		            currentAssetList.add( "costCenterNm"  ,itemsmsg[j].getCOST_CENTER_NM().trim());  // Cost Center Name
		            currentAssetList.add( "acqDate"       ,itemsmsg[j].getACQ_DATE().trim());        // First acq. Date
		            currentAssetList.add( "acqYear"       ,itemsmsg[j].getACQ_YEAR().trim());        // Acquisition year 		            
		            currentAssetList.add( "durableYears"  ,itemsmsg[j].getDURABLE_YEARS().trim());   // Useful life		            
		            currentAssetList.add( "acqAmt"        ,itemsmsg[j].getACQ_AMT().trim());         // Acquisition amount 
		            currentAssetList.add( "netAcqAmt"     ,itemsmsg[j].getNET_ACQ_AMT().trim());     // 자산가액
		            currentAssetList.add( "depAmt"        ,itemsmsg[j].getDEP_AMT().trim());         // 감가상각액
		            currentAssetList.add( "balance"       ,itemsmsg[j].getBALANCE().trim());         // 잔액
		            currentAssetList.add( "currCd"        ,itemsmsg[j].getCURR_CD().trim());         // Currency
		            currentAssetList.add( "dueDate"       ,itemsmsg[j].getDUE_DATE().trim());        // 완료예정(YYYYMM)
		            currentAssetList.add( "unit"          ,itemsmsg[j].getUNIT().trim());            // Unit
		            currentAssetList.add( "qty"           ,itemsmsg[j].getQTY().trim());             // Quantity
		            currentAssetList.add( "attr01"        ,itemsmsg[j].getATTR01().trim());
		            currentAssetList.add( "attr02"        ,itemsmsg[j].getATTR02().trim());
		            currentAssetList.add( "attr03"        ,itemsmsg[j].getATTR03().trim());
		            currentAssetList.add( "attr04"        ,itemsmsg[j].getATTR04().trim());
		            currentAssetList.add( "attr05"        ,itemsmsg[j].getATTR05().trim());
		            currentAssetList.add( "attr06"        ,itemsmsg[j].getATTR06().trim());
		            currentAssetList.add( "attr07"        ,itemsmsg[j].getATTR07().trim());
		            currentAssetList.add( "attr08"        ,itemsmsg[j].getATTR08().trim());
		            currentAssetList.add( "attr09"        ,itemsmsg[j].getATTR09().trim());
		            currentAssetList.add( "attr10"        ,itemsmsg[j].getATTR10().trim());
	            }
	             
         	}  
                
         	rtn.add(resultMsg);
         	rtn.add(currentAssetList);
            
		} catch(Exception e){
			e.getMessage();
			throw new LSysException(e.getMessage());
		}
		
		return rtn;
	}	
}
