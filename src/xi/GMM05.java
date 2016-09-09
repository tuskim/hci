/*
 *------------------------------------------------------------------------------
 * GMM05.java,v 1.0 2010/08/04 08:57:00 
 * 
 * PROJ : PT-PAM
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2010/08/25   mskim   최초 프로그램 작성
 *----------------------------------------------------------------------------
 */

package xi;

import java.rmi.RemoteException;

import javax.xml.rpc.ServiceException;

import com.lgicorp.gims.sap.gmm05.GMM05R_GIMS_DT;
import com.lgicorp.gims.sap.gmm05.GMM05R_GIMS_DTZSAPMSG;
import com.lgicorp.gims.sap.gmm05.GMM05_GIMS_DT;
import com.lgicorp.gims.sap.gmm05.GMM05_GIMS_DTZMMMT09;
import com.lgicorp.gims.sap.gmm05.GMM05_GIMS_DTZMMMT10;
import com.lgicorp.gims.sap.gmm05.GMM05_outBindingStub;
import com.lgicorp.gims.sap.gmm05.GMM05_outServiceLocator;

import comm.util.Util;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LSysException;
import devon.core.log.LLog;

public class GMM05 {
	
	public LData GMM05_out(LData xmlDocNo, LData headerData, LMultiData bodyData) throws LSysException {
		
		LLog.info.write("GMM05_out Service Start");
		
		Util util = new Util();
		LData resultMsg = new LData();

		GMM05_GIMS_DT GMM05_DT = new GMM05_GIMS_DT();
		GMM05R_GIMS_DT R_GMM05_DT = new GMM05R_GIMS_DT();
				
		//총계정원가 Header
		LLog.info.write("Master : \n" + headerData);
		GMM05_GIMS_DTZMMMT09 ZFIMT0001 = new GMM05_GIMS_DTZMMMT09();
		
		ZFIMT0001.setZXMLDOCNO( util.nullToString(xmlDocNo.getString("zxmldocno")));
		ZFIMT0001.setBUKRS(   	util.nullToString(headerData.getString("companyCd")));
		ZFIMT0001.setZMBLNR(	util.nullToString(headerData.getString("tranNo")));
		ZFIMT0001.setBLDAT(	 	util.nullToString(headerData.getString("moveDate")));
		ZFIMT0001.setBUDAT(	 	util.nullToString(headerData.getString("postingDate")));
		ZFIMT0001.setWERKS(	 	util.nullToString(headerData.getString("issuePlant")));
		ZFIMT0001.setUMWRK(	 	util.nullToString(headerData.getString("recePlant")));
		ZFIMT0001.setLGORT(	 	util.nullToString(headerData.getString("issueLoc")));
		ZFIMT0001.setUMLGO(	 	util.nullToString(headerData.getString("receLoc")));
		ZFIMT0001.setZFSTATUS(	util.nullToString(headerData.getString("status")));
		ZFIMT0001.setMBLNR(	 	util.nullToString(headerData.getString("sapDocNo")));
		ZFIMT0001.setATTR1(	 	util.nullToString(headerData.getString("attr1")));
		ZFIMT0001.setATTR2(	 	util.nullToString(headerData.getString("attr2")));
		ZFIMT0001.setATTR3(	 	util.nullToString(headerData.getString("attr3")));
		ZFIMT0001.setATTR4(	 	util.nullToString(headerData.getString("attr4")));
		ZFIMT0001.setATTR5(	 	util.nullToString(headerData.getString("attr5")));
		ZFIMT0001.setATTR6(	 	util.nullToString(headerData.getString("attr6")));
		ZFIMT0001.setATTR7(	 	util.nullToString(headerData.getString("attr7")));
		ZFIMT0001.setATTR8(	 	util.nullToString(headerData.getString("attr8")));
		ZFIMT0001.setATTR9(	 	util.nullToString(headerData.getString("attr9")));
		ZFIMT0001.setATTR10(	util.nullToString(headerData.getString("attr10")));
			
		//총계정원가 Body
		LLog.info.write("Master : \n" + bodyData);
		GMM05_GIMS_DTZMMMT10[] ZFIMT0002 = new GMM05_GIMS_DTZMMMT10[bodyData.getDataCount()];
		
		for (int j = 0; j < bodyData.getDataCount(); j++) {
			LData bodyRowData = bodyData.getLData(j);
			GMM05_GIMS_DTZMMMT10 bodyItem = new GMM05_GIMS_DTZMMMT10();
			
			bodyItem.setBUKRS(  util.nullToString(bodyRowData.getString("companyCd")));
			bodyItem.setZMBLNR( util.nullToString(bodyRowData.getString("tranNo")));
			bodyItem.setMATNR(  util.nullToString(bodyRowData.getString("materCd")));
			bodyItem.setERFMG(  util.nullToString(bodyRowData.getString("tranQty")));
			bodyItem.setATTR1(  util.nullToString(bodyRowData.getString("attr1")));
			bodyItem.setATTR2(  util.nullToString(bodyRowData.getString("attr2")));
			bodyItem.setATTR3(  util.nullToString(bodyRowData.getString("attr3")));
			bodyItem.setATTR4(  util.nullToString(bodyRowData.getString("attr4")));
			bodyItem.setATTR5(  util.nullToString(bodyRowData.getString("attr5")));
			bodyItem.setATTR6(  util.nullToString(bodyRowData.getString("attr6")));
			bodyItem.setATTR7(  util.nullToString(bodyRowData.getString("attr7")));
			bodyItem.setATTR8(  util.nullToString(bodyRowData.getString("attr8")));
			bodyItem.setATTR9(  util.nullToString(bodyRowData.getString("attr9")));
			bodyItem.setATTR10( util.nullToString(bodyRowData.getString("attr10")));
						
			ZFIMT0002[j] = bodyItem;
		}
				
		//DT에 header 및 boby 데이터 Setting
		GMM05_DT.setZMMMT09(ZFIMT0001);
		GMM05_DT.setZMMMT10(ZFIMT0002);
		
		//Return Msg
		GMM05R_GIMS_DTZSAPMSG zsapmsg = new GMM05R_GIMS_DTZSAPMSG();  		
		
		try{
			
			GMM05_outServiceLocator serviceLocator = new GMM05_outServiceLocator();
	        
			LLog.info.println(util.getProp("EAI_HTTP_URL_PTPAM_GMM05_SAP"));
	        serviceLocator.setGMM05_outPortEndpointAddress(util.getProp("EAI_HTTP_URL_PTPAM_GMM05_SAP"));
	            
	        GMM05_outBindingStub bindingStub = (GMM05_outBindingStub) serviceLocator.getGMM05_outPort();
	            
            bindingStub.setUsername(util.getProp("EAI_USER"));
            bindingStub.setPassword(util.getProp("EAI_PWD"));

            //XI 전송 및 결과 Return
            LLog.info.println("XI Connection try!!");
            R_GMM05_DT = bindingStub.GMM05_out(GMM05_DT);
	            	
            zsapmsg = R_GMM05_DT.getZSAPMSG();
	            
            //LLog.info.write("GMM05 zsapmsg.getMTYPE() :: " + zsapmsg.getMTYPE());
            //LLog.info.write("GMM05 zsapmsg.getMTEXT() :: " + zsapmsg.getMTEXT());
            //LLog.info.write("GMM05 zsapmsg.getMBLNR() :: " + zsapmsg.getMBLNR());

            resultMsg.setString("returnType",  zsapmsg.getMTYPE());
            resultMsg.setString("returnText",  zsapmsg.getMTEXT());
            resultMsg.setString("returnDocNo", zsapmsg.getMBLNR());
		
		} catch(Exception e){
			e.getMessage();
			throw new LSysException(e.getMessage());
		}
		
		return resultMsg;
	}	
}
