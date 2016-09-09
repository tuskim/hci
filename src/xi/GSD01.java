/*
 *------------------------------------------------------------------------------
 * GSD01.java,v 1.0 2010/08/12 15:00:00 
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

import com.lgicorp.gims.sap.gsd01.GSD01R_GIMS_DT;
import com.lgicorp.gims.sap.gsd01.GSD01R_GIMS_DTZSAPMSG;
import com.lgicorp.gims.sap.gsd01.GSD01_GIMS_DT;
import com.lgicorp.gims.sap.gsd01.GSD01_GIMS_DTZIFMTS001;
import com.lgicorp.gims.sap.gsd01.GSD01_GIMS_DTZIFMTS002;
import com.lgicorp.gims.sap.gsd01.GSD01_outBindingStub;
import com.lgicorp.gims.sap.gsd01.GSD01_outServiceLocator;

import comm.util.Util;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LSysException;
import devon.core.log.LLog;

public class GSD01 {
	
	public LData GSD01_out(LData headerData, LMultiData bodyData) throws LSysException {
		
		LLog.info.write("GSD01_out Service Start");
		
		Util util = new Util();
		LData resultMsg = new LData();

		GSD01_GIMS_DT GSD01_DT = new GSD01_GIMS_DT();
		GSD01R_GIMS_DT R_GSD01_DT = new GSD01R_GIMS_DT();
				
		//총계정원가 Header
		LLog.info.write("Master : \n" + headerData);
		
			GSD01_GIMS_DTZIFMTS001 headerItem = new GSD01_GIMS_DTZIFMTS001();
			
			headerItem.setZXMLDOCNO(util.nullToString(headerData.getString("zxmldocno")));
			headerItem.setVKORG(util.nullToString(headerData.getString("companyCd")));
			headerItem.setSDATE(util.nullToString(headerData.getString("transDate")));
			headerItem.setZSSEQ(util.nullToString(headerData.getString("sapSeq")));
			headerItem.setZZCLOSE(util.nullToString(headerData.getString("status")));
			
			headerItem.setBSTKD(util.nullToString(headerData.getString("syskey")));
			headerItem.setPERNR(util.nullToString(headerData.getString("userId")));
			headerItem.setAUDAT(util.nullToString(headerData.getString("deliveryDate")));
			headerItem.setFKDAT(util.nullToString(headerData.getString("postDate")));
			headerItem.setSALCL(util.nullToString(headerData.getString("cancelType")));

			headerItem.setKUNNR(util.nullToString(headerData.getString("vendorCd")));
			headerItem.setKUNNR2(util.nullToString(headerData.getString("vendorCd2")));
			headerItem.setAUART(util.nullToString(headerData.getString("deptCd")));
			headerItem.setWERKS(util.nullToString(headerData.getString("plantCd")));
			headerItem.setLGORT(util.nullToString(headerData.getString("storLoct")));

			headerItem.setVKGRP(util.nullToString(headerData.getString("groupcd")));
			headerItem.setWAERK(util.nullToString(headerData.getString("currencyCd")));
			headerItem.setZTERM(util.nullToString(headerData.getString("payKey1")));
			headerItem.setZZTERM1(util.nullToString(headerData.getString("payKey2")));
			headerItem.setZZNETWR1(util.nullToString(headerData.getString("amt2")));
			
			headerItem.setZZTERM2(util.nullToString(headerData.getString("payKey3")));
			headerItem.setZZNETWR2(util.nullToString(headerData.getString("amt3")));
			headerItem.setZZTERM3(util.nullToString(headerData.getString("payKey4")));
			headerItem.setZZNETWR3(util.nullToString(headerData.getString("amt4")));
			headerItem.setTRJOB(util.nullToString(headerData.getString("psType")));
			headerItem.setBWART(util.nullToString(headerData.getString("bwart")));
			
			headerItem.setFKDAT_RE(util.nullToString(headerData.getString("fkdatRe")));
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

			
		//총계정원가 Body
		LLog.info.write("Master : \n" + bodyData);
		GSD01_GIMS_DTZIFMTS002[] ZIFMTS002 = new GSD01_GIMS_DTZIFMTS002[bodyData.getDataCount()];
		
		for (int j = 0; j < bodyData.getDataCount(); j++) {
			LData bodyRowData = bodyData.getLData(j);
			GSD01_GIMS_DTZIFMTS002 bodyItem = new GSD01_GIMS_DTZIFMTS002();
			
			bodyItem.setVKORG(util.nullToString(bodyRowData.getString("companyCd")));
			bodyItem.setSDATE(util.nullToString(headerData.getString("transDate")));
			bodyItem.setZSSEQ(util.nullToString(headerData.getString("zsseq")));
			bodyItem.setPOSNR(util.nullToString(bodyRowData.getString("itemSeq")));
			bodyItem.setSALTY(util.nullToString(bodyRowData.getString("salesType")));
			
			bodyItem.setLGORT(util.nullToString(bodyRowData.getString("storLoct")));
			bodyItem.setCHARG(util.nullToString(bodyRowData.getString("batchCode")));
			bodyItem.setMATNR(util.nullToString(bodyRowData.getString("materCd")));
			bodyItem.setVRKME(util.nullToString(bodyRowData.getString("unit")));
			bodyItem.setKWMENG(util.nullToString(bodyRowData.getString("divSalesWeight")));
			
			bodyItem.setWAERK(util.nullToString(bodyRowData.getString("currencyCd")));
			bodyItem.setKWERT_SALE(util.nullToString(bodyRowData.getString("divSalesAmt")));
			bodyItem.setKWERT_TAX(util.nullToString(bodyRowData.getString("taxAmt")));
			bodyItem.setWERKS(util.nullToString(bodyRowData.getString("plantCd")));
		
			bodyItem.setATTR1(util.nullToString(bodyRowData.getString("attr1")));
			bodyItem.setATTR2(util.nullToString(bodyRowData.getString("attr2")));
			bodyItem.setATTR3(util.nullToString(bodyRowData.getString("attr3")));
			bodyItem.setATTR4(util.nullToString(bodyRowData.getString("attr4")));
			bodyItem.setATTR5(util.nullToString(bodyRowData.getString("attr5")));
			bodyItem.setATTR6(util.nullToString(bodyRowData.getString("attr6")));
			bodyItem.setATTR7(util.nullToString(bodyRowData.getString("attr7")));
			bodyItem.setATTR8(util.nullToString(bodyRowData.getString("attr8")));
			bodyItem.setATTR9(util.nullToString(bodyRowData.getString("attr9")));
			bodyItem.setATTR10(util.nullToString(bodyRowData.getString("attr10")));
						
			ZIFMTS002[j] = bodyItem;
		}
	

		//DT에 header 및 boby 데이터 Setting
		GSD01_DT.setZIFMTS001(headerItem);
		GSD01_DT.setZIFMTS002(ZIFMTS002);
		
		//Return Msg
		GSD01R_GIMS_DTZSAPMSG zsapmsg = new GSD01R_GIMS_DTZSAPMSG();  		
		
		try{
			
			GSD01_outServiceLocator serviceLocator = new GSD01_outServiceLocator();
	        
	        serviceLocator.setGSD01_outPortEndpointAddress(util.getProp("EAI_HTTP_URL_PTPAM_GSD01_SAP"));
	            
	        GSD01_outBindingStub bindingStub = (GSD01_outBindingStub) serviceLocator.getGSD01_outPort();
	            
            bindingStub.setUsername(util.getProp("EAI_USER"));
            bindingStub.setPassword(util.getProp("EAI_PWD"));

            //XI 전송 및 결과 Return
            LLog.info.println("XI Connection try!!");
            R_GSD01_DT = bindingStub.GSD01_out(GSD01_DT);
	            	
            zsapmsg = R_GSD01_DT.getZSAPMSG();
	            
            LLog.info.write("GSD01 zsapmsg.getCBOMTYPE() :: " + zsapmsg.getCBOMTYPE());
            LLog.info.write("GSD01 zsapmsg.getZSAPMSG() :: " + zsapmsg.getZSAPMSG());
            LLog.info.write("GSD01 zsapmsg.getZSSEQ() :: " + zsapmsg.getZSSEQ());
            
            resultMsg.setString("returnStatus", zsapmsg.getCBOMTYPE());
            resultMsg.setString("returnMsg", zsapmsg.getZSAPMSG());
            resultMsg.setString("returnSapSeq", zsapmsg.getZSSEQ());
 
		
		} catch(Exception e){
			e.getMessage();
			throw new LSysException(e.getMessage());
		}
		
		return resultMsg;
	}	
}
