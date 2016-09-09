/*
 *------------------------------------------------------------------------------
 * GSD03.java,v 1.0 2010/08/30 15:00:00 
 * 
 * PROJ : PT-PAM
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2010/08/10   hskim   최초 프로그램 작성
 *----------------------------------------------------------------------------
 */

package xi;

import java.rmi.RemoteException;

import javax.xml.rpc.ServiceException;

import com.lgicorp.gims.sap.gsd03.GSD03_GIMS_DT;
import com.lgicorp.gims.sap.gsd03.GSD03_GIMS_DTZIFMTS001;
import com.lgicorp.gims.sap.gsd03.GSD03_outBindingStub;
import com.lgicorp.gims.sap.gsd03.GSD03_outServiceLocator;

import comm.util.Util;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LSysException;
import devon.core.log.LLog;

public class GSD03 {
	
	public LData GSD03_out(LData headerData) throws LSysException {
		
		LLog.info.write("GSD03 Service Start");
		
		Util util = new Util();
		LData resultMsg = new LData();

		GSD03_GIMS_DT GSD03_DT = new GSD03_GIMS_DT();
				
		//총계정원가 Header
		LLog.info.write("Master : \n" + headerData);
		
			GSD03_GIMS_DTZIFMTS001 headerItem = new GSD03_GIMS_DTZIFMTS001();
			
			headerItem.setZXMLDOCNO(util.nullToString(headerData.getString("zxmldocno")));
			headerItem.setVKORG(util.nullToString(headerData.getString("companyCd")));
			headerItem.setSDATE(util.nullToString(headerData.getString("transDate")));
			headerItem.setZSSEQ(util.nullToString(headerData.getString("sapSeq")));
			headerItem.setZZCLOSE(util.nullToString(headerData.getString("status")));
			headerItem.setSALCL(util.nullToString(headerData.getString("cancelType")));
			headerItem.setFKDAT_RE(util.nullToString(headerData.getString("billDate")));
			
			headerItem.setATTR1(util.nullToString(headerData.getString("attr1")));
			headerItem.setATTR2(util.nullToString(headerData.getString("attr2")));
			headerItem.setATTR3(util.nullToString(headerData.getString("attr3")));
			headerItem.setATTR4(util.nullToString(headerData.getString("attr4")));
			headerItem.setATTR5(util.nullToString(headerData.getString("attr5")));
			headerItem.setATTR6(util.nullToString(headerData.getString("attr6")));
			headerItem.setATTR7(util.nullToString(headerData.getString("attr7")));
			headerItem.setATTR8(util.nullToString(headerData.getString("attr8")));
			headerItem.setATTR9(util.nullToString(headerData.getString("attr9")));
			headerItem.setATTR10(util.nullToString(headerData.getString("attr10")));
			

		//DT에 header 및 boby 데이터 Setting
		GSD03_DT.setZIFMTS001(headerItem);
		
		//Return Msg
		
		try{
			
			GSD03_outServiceLocator serviceLocator = new GSD03_outServiceLocator();
	        
	        serviceLocator.setGSD03_outPortEndpointAddress(util.getProp("EAI_HTTP_URL_PTPAM_GSD03_SAP"));
	            
	        GSD03_outBindingStub bindingStub = (GSD03_outBindingStub) serviceLocator.getGSD03_outPort();
	            
            bindingStub.setUsername(util.getProp("EAI_USER"));
            bindingStub.setPassword(util.getProp("EAI_PWD"));

            //XI 전송 및 결과 Return
            LLog.info.println("XI Connection try!!");
            bindingStub.GSD03_out(GSD03_DT);
	            	
		} catch(Exception e){
			e.getMessage();
			throw new LSysException(e.getMessage());
			
		}
		
		return resultMsg;
	}	
}
