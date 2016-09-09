/*
 *------------------------------------------------------------------------------
 * GFI01.java,v 1.0 2010/08/04 08:57:00 
 * 
 * PROJ : PT-PAM
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2010/08/04   hskim   최초 프로그램 작성
 *----------------------------------------------------------------------------
 */

package xi;

import java.rmi.RemoteException;
import java.util.Vector;
import javax.xml.rpc.ServiceException;

import com.lgicorp.gims.sap.gfi01.GFI01_GIMS_DTZFIMT0001;
import com.lgicorp.gims.sap.gfi04.*;

import comm.util.Util;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LSysException;
import devon.core.log.LLog;

public class GFI04 {
	
	public Vector GFI04_out(LData xmlDocNo,LData webPo, LData inputData) throws LSysException {
		
		LLog.info.write("GFI04_out Service Start");
		
		Util util = new Util();
		LData resultMsg = new LData();

		GFI04_GIMS_DT GFI04_DT = new GFI04_GIMS_DT();
		GFI04R_GIMS_DT R_GFI04_DT = new GFI04R_GIMS_DT();
				
		//총계정원가 Header
		LLog.info.write("inputData : \n" + inputData); 
	  
		GFI04_GIMS_DTHEADER[]  GFI04HD = new GFI04_GIMS_DTHEADER[1]; 
		GFI04_GIMS_DTHEADER  GFI04DTS = new GFI04_GIMS_DTHEADER();
 
		GFI04DTS.setZXMLDOCNO(util.nullToString(xmlDocNo.getString("zxmldocno"))); 
		//GFI04DTS.setBUKRS(util.nullToString("O000"));
		GFI04DTS.setBUKRS(util.nullToString(inputData.getString("companyCd")));
		GFI04DTS.setGJAHR(util.nullToString(inputData.getString("docYear")));
		GFI04DTS.setKUNNR(util.nullToString(inputData.getString("customer")));
		GFI04DTS.setLIFNR(util.nullToString(inputData.getString("vendor")));
		GFI04DTS.setBLART(util.nullToString(inputData.getString("docType"))); 
		GFI04DTS.setBLDAT_From(util.nullToString(inputData.getString("docFromDate").replaceAll("\\/", "")));
		GFI04DTS.setBLDAT_TO(util.nullToString(inputData.getString("docToDate").replaceAll("\\/", "")));
		GFI04DTS.setBUDAT_From(util.nullToString(inputData.getString("postFromDate").replaceAll("\\/", "")));
		GFI04DTS.setBUDAT_TO(util.nullToString(inputData.getString("postToDate").replaceAll("\\/", "")));  
		GFI04DTS.setUSNAM(util.nullToString(webPo.getString("name"))); 
		GFI04HD[0]=GFI04DTS;
		GFI04_DT.setHEADER(GFI04HD); 
		GFI04R_GIMS_DTZSAPMSG zsapmsg = new GFI04R_GIMS_DTZSAPMSG();  	

		Vector rtn = new Vector();
		try{
			
			GFI04_outServiceLocator serviceLocator = new GFI04_outServiceLocator();
 
			LLog.debug.write(util.getProp("EAI_HTTP_URL_PTPAM_GFI04_SAP"));
 
	        serviceLocator.setGFI04_outPortEndpointAddress(util.getProp("EAI_HTTP_URL_PTPAM_GFI04_SAP"));
 
	        GFI04_outBindingStub bindingStub = (GFI04_outBindingStub) serviceLocator.getGFI04_outPort();
  
            bindingStub.setUsername(util.getProp("EAI_USER"));
            bindingStub.setPassword(util.getProp("EAI_PWD"));

            //XI 전송 및 결과 Return
            LLog.debug.write("XI Connection try!!");
            R_GFI04_DT = bindingStub.GFI04_out(GFI04_DT);
    
            zsapmsg = R_GFI04_DT.getZSAPMSG(); 
             
            GFI04R_GIMS_DTITEM[] itemsmsg = R_GFI04_DT.getITEM(); 
            LLog.info.write("GFI04 zsapmsg.getMTYPE() :: " + zsapmsg.getMTYPE());
            LLog.info.write("GFI04 zsapmsg.getMTEXT() :: " + zsapmsg.getMTEXT());
 
            resultMsg.setString("returnType", zsapmsg.getMTYPE());
            resultMsg.setString("returnText", zsapmsg.getMTEXT()); 
            LMultiData itemResultMsg = new LMultiData();   
            if(itemsmsg!=null){     
	            for(int j=0; j<itemsmsg.length;j++){
	            
	            	String[] strList=itemsmsg[j].getGFIMQ().split("\\^",16); 
	            	/*for(int v=0;v<strList.length;v++){
	            		LLog.info.println("strList["+v+"]==>"+strList[v]);
	            	}*/ 
	        		itemResultMsg.add( "chk"          ,"0" ); //
	        		itemResultMsg.add( "companyCd"    ,strList[0] ); //BUKRS 
		            itemResultMsg.add( "fiscalYear"   ,strList[1] ); //GJAHR
		            itemResultMsg.add( "docNo"        ,strList[2] ); //BELNR
		            itemResultMsg.add( "docType"      ,strList[3] ); //BLART   
		            itemResultMsg.add( "docDate"      ,strList[4] ); //BLDAT        
		            itemResultMsg.add( "postDate"     ,strList[5] ); //BUDAT
		            itemResultMsg.add( "headerDesc"   ,strList[6] ); //BKTXT 
		            itemResultMsg.add( "curr"         ,strList[7] ); //WAERS
		            itemResultMsg.add( "docAmt"       ,strList[8].replaceAll("\\,","")); //WRBTR
		            itemResultMsg.add( "localAmt"     ,strList[9].replaceAll("\\,","") ); //DMBTR  
		            itemResultMsg.add( "reverseWith"  ,strList[10] ); //STBLG 		
		            itemResultMsg.add( "taxCd"        ,strList[11] ); //MWSKZ
		            itemResultMsg.add( "customer"     ,strList[12] ); //KUNNR
		            itemResultMsg.add( "customerName" ,strList[13] ); //KUNNR_DES
		            itemResultMsg.add( "vendor"       ,strList[14] ); //LIFNR
		            itemResultMsg.add( "vendorName"   ,strList[15] ); //LIFNR_DES 
	            	 
	            } 
            }  
            rtn.add(resultMsg);
            rtn.add(itemResultMsg);
		} catch(Exception e){
			e.getMessage();
			throw new LSysException(e.getMessage());
		}
		
		return rtn;
	}	
}
