/*
 *------------------------------------------------------------------------------
 * GMM07.java,v 1.0 2010/08/04 08:57:00 
 * 
 * PROJ : PT-PAM
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2010/09/13   msLim   최초 프로그램 작성
 *----------------------------------------------------------------------------
 */

package xi;

import java.rmi.RemoteException;
import java.text.DecimalFormat;

import javax.xml.rpc.ServiceException;

import com.lgicorp.gims.sap.gmm07.GMM07R_GIMS_DT;
import com.lgicorp.gims.sap.gmm07.GMM07R_GIMS_DTZSAPMSG;
import com.lgicorp.gims.sap.gmm07.GMM07_GIMS_DT;
import com.lgicorp.gims.sap.gmm07.GMM07_GIMS_DTZMMMT15;
import com.lgicorp.gims.sap.gmm07.GMM07_GIMS_DTZMMMT16;
import com.lgicorp.gims.sap.gmm07.GMM07_GIMS_DTZMMMT17;
import com.lgicorp.gims.sap.gmm07.GMM07_outBindingStub;
import com.lgicorp.gims.sap.gmm07.GMM07_outServiceLocator;
import comm.util.Util;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LSysException;
import devon.core.log.LLog;

public class GMM07 {
	
	public LData GMM07_out(LData headerData, LMultiData bodyData, LMultiData bodyData2) throws LSysException {
		
		LLog.info.write("GMM07_out Service Start");
		
		Util util = new Util();
		LData resultMsg = new LData();

		GMM07_GIMS_DT GMM07_DT = new GMM07_GIMS_DT();
		GMM07R_GIMS_DT R_GMM07_DT = new GMM07R_GIMS_DT();
		
		DecimalFormat format = new DecimalFormat("0.####");
				
		//Header
		LLog.info.write("Master : \n" + headerData);
		GMM07_GIMS_DTZMMMT15 ZFIMT0001 = new GMM07_GIMS_DTZMMMT15();
		
		ZFIMT0001.setZXMLDOCNO( util.nullToString(headerData.getString("zxmldocno")));
		ZFIMT0001.setBUKRS(util.nullToString(headerData.getString("companyCd")));
		ZFIMT0001.setZEBELN(util.nullToString(headerData.getString("poNo")));
		ZFIMT0001.setZGRSEQ(util.nullToString(headerData.getString("ivSeq")));
		ZFIMT0001.setEBELN(	util.nullToString(headerData.getString("sapPoNo")));
		ZFIMT0001.setBLDAT(util.nullToString(headerData.getString("ivDate")));
		ZFIMT0001.setBUDAT(util.nullToString(headerData.getString("postDate")));
		ZFIMT0001.setZFBDT(util.nullToString(headerData.getString("dueDate")));
		ZFIMT0001.setWRBTR(util.nullToString(format.format(headerData.getDouble("ivAmt"))));
		ZFIMT0001.setWAERS(util.nullToString(headerData.getString("currencyCd")));
		ZFIMT0001.setWMWST(util.nullToString(format.format(headerData.getDouble("vatAmt"))));
		ZFIMT0001.setMWSKZ(util.nullToString(""));
		ZFIMT0001.setWERKS(util.nullToString(headerData.getString("plant")));
		ZFIMT0001.setLGORT(util.nullToString(headerData.getString("storLoct")));
		ZFIMT0001.setZFSTATUS(util.nullToString(headerData.getString("status")));
		ZFIMT0001.setBELNR(util.nullToString(headerData.getString("sapIvDoNo")));
		ZFIMT0001.setMBLNR(util.nullToString(headerData.getString("sapGrDoNo")));
		ZFIMT0001.setCANCELNO(util.nullToString(headerData.getString("cancelNo")));

		
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
		
		LLog.info.println("ZFIMT0001.getZXMLDOCNO  ====>"+ZFIMT0001.getZXMLDOCNO()); 
		LLog.info.println("ZFIMT0001.getBUKRS      ====>"+ZFIMT0001.getBUKRS    ()); 
		LLog.info.println("ZFIMT0001.getZEBELN     ====>"+ZFIMT0001.getZEBELN   ()); 
		LLog.info.println("ZFIMT0001.getZGRSEQ     ====>"+ZFIMT0001.getZGRSEQ   ()); 
		LLog.info.println("ZFIMT0001.getEBELN      ====>"+ZFIMT0001.getEBELN    ()); 
		LLog.info.println("ZFIMT0001.getBLDAT      ====>"+ZFIMT0001.getBLDAT    ()); 
		LLog.info.println("ZFIMT0001.getBUDAT      ====>"+ZFIMT0001.getBUDAT    ()); 
		LLog.info.println("ZFIMT0001.getZFBDT      ====>"+ZFIMT0001.getZFBDT    ()); 
		LLog.info.println("ZFIMT0001.getWRBTR      ====>"+ZFIMT0001.getWRBTR    ()); 
		LLog.info.println("ZFIMT0001.getWAERS      ====>"+ZFIMT0001.getWAERS    ()); 
		LLog.info.println("ZFIMT0001.getWMWST      ====>"+ZFIMT0001.getWMWST    ()); 
		LLog.info.println("ZFIMT0001.getMWSKZ      ====>"+ZFIMT0001.getMWSKZ    ()); 
		LLog.info.println("ZFIMT0001.getWERKS      ====>"+ZFIMT0001.getWERKS    ()); 
		LLog.info.println("ZFIMT0001.getLGORT      ====>"+ZFIMT0001.getLGORT    ()); 
		LLog.info.println("ZFIMT0001.getZFSTATUS   ====>"+ZFIMT0001.getZFSTATUS ()); 
		LLog.info.println("ZFIMT0001.getBELNR      ====>"+ZFIMT0001.getBELNR    ()); 
		LLog.info.println("ZFIMT0001.getMBLNR      ====>"+ZFIMT0001.getMBLNR    ()); 
		LLog.info.println("ZFIMT0001.getCANCELNO   ====>"+ZFIMT0001.getCANCELNO ()); 
		LLog.info.println("ZFIMT0001.getATTR1      ====>"+ZFIMT0001.getATTR1    ()); 
		LLog.info.println("ZFIMT0001.getATTR2      ====>"+ZFIMT0001.getATTR2    ()); 
		LLog.info.println("ZFIMT0001.getATTR3      ====>"+ZFIMT0001.getATTR3    ()); 
		LLog.info.println("ZFIMT0001.getATTR4      ====>"+ZFIMT0001.getATTR4    ()); 
		LLog.info.println("ZFIMT0001.getATTR5      ====>"+ZFIMT0001.getATTR5    ()); 
		LLog.info.println("ZFIMT0001.getATTR6      ====>"+ZFIMT0001.getATTR6    ()); 
		LLog.info.println("ZFIMT0001.getATTR7      ====>"+ZFIMT0001.getATTR7    ()); 
		LLog.info.println("ZFIMT0001.getATTR8      ====>"+ZFIMT0001.getATTR8    ()); 
		LLog.info.println("ZFIMT0001.getATTR9      ====>"+ZFIMT0001.getATTR9    ()); 
		LLog.info.println("ZFIMT0001.getATTR10     ====>"+ZFIMT0001.getATTR10   ()); 

			
		//Body1
		LLog.info.write("Master : \n" + bodyData);
		GMM07_GIMS_DTZMMMT16[] ZFIMT0002 = new GMM07_GIMS_DTZMMMT16[bodyData.getDataCount()];
		
		for (int j = 0; j < bodyData.getDataCount(); j++) {
			LData bodyRowData = bodyData.getLData(j);
			GMM07_GIMS_DTZMMMT16 bodyItem = new GMM07_GIMS_DTZMMMT16();
			
			bodyItem.setBUKRS(  util.nullToString(bodyRowData.getString("companyCd")));
			bodyItem.setZEBELN(  util.nullToString(bodyRowData.getString("poNo")));
			bodyItem.setZGRSEQ(  util.nullToString(bodyRowData.getString("ivSeq")));
			bodyItem.setEBELP(  util.nullToString(bodyRowData.getString("poSeq")));
			bodyItem.setMATNR(  util.nullToString(bodyRowData.getString("materCd")));
			bodyItem.setWRBTR(  util.nullToString(format.format(bodyRowData.getDouble("amount"))));
			bodyItem.setMENGE(  util.nullToString(bodyRowData.getString("receiptQty")));
			bodyItem.setZMWSKZ(  util.nullToString(bodyRowData.getString("vatCd")));
			bodyItem.setATTR1(  util.nullToString(format.format(bodyRowData.getDouble("attr1"))));
			bodyItem.setATTR2(  util.nullToString(bodyRowData.getString("attr2")));
			bodyItem.setATTR3(  util.nullToString(bodyRowData.getString("attr3")));
			bodyItem.setATTR4(  util.nullToString(bodyRowData.getString("attr4")));
			bodyItem.setATTR5(  util.nullToString(bodyRowData.getString("attr5")));
			bodyItem.setATTR6(  util.nullToString(bodyRowData.getString("attr6")));
			bodyItem.setATTR7(  util.nullToString(bodyRowData.getString("attr7")));
			bodyItem.setATTR8(  util.nullToString(bodyRowData.getString("attr8")));
			bodyItem.setATTR9(  util.nullToString(bodyRowData.getString("attr9")));
						
			ZFIMT0002[j] = bodyItem;
			
			LLog.info.println("bodyItem.getBUKRS      =====>"+bodyItem.getBUKRS ());
			LLog.info.println("bodyItem.getZEBELN     =====>"+bodyItem.getZEBELN());
			LLog.info.println("bodyItem.getZGRSEQ     =====>"+bodyItem.getZGRSEQ());
			LLog.info.println("bodyItem.getEBELP      =====>"+bodyItem.getEBELP ());
			LLog.info.println("bodyItem.getMATNR      =====>"+bodyItem.getMATNR ());
			LLog.info.println("bodyItem.getWRBTR      =====>"+bodyItem.getWRBTR ());
			LLog.info.println("bodyItem.getMENGE      =====>"+bodyItem.getMENGE ());
			LLog.info.println("bodyItem.getZMWSKZ     =====>"+bodyItem.getZMWSKZ());
			LLog.info.println("bodyItem.getATTR1      =====>"+bodyItem.getATTR1 ());
			LLog.info.println("bodyItem.getATTR2      =====>"+bodyItem.getATTR2 ());
			LLog.info.println("bodyItem.getATTR3      =====>"+bodyItem.getATTR3 ());
			LLog.info.println("bodyItem.getATTR4      =====>"+bodyItem.getATTR4 ());
			LLog.info.println("bodyItem.getATTR5      =====>"+bodyItem.getATTR5 ());
			LLog.info.println("bodyItem.getATTR6      =====>"+bodyItem.getATTR6 ());
			LLog.info.println("bodyItem.getATTR7      =====>"+bodyItem.getATTR7 ());
			LLog.info.println("bodyItem.getATTR8      =====>"+bodyItem.getATTR8 ());
			LLog.info.println("bodyItem.getATTR9      =====>"+bodyItem.getATTR9 ());

		}
				
		//Body2
		LLog.info.write("Master : \n" + bodyData);
		GMM07_GIMS_DTZMMMT17[] ZFIMT0003 = new GMM07_GIMS_DTZMMMT17[bodyData2.getDataCount()];
		
		for (int j = 0; j < bodyData2.getDataCount(); j++) {
			LData bodyRowData = bodyData2.getLData(j);
			GMM07_GIMS_DTZMMMT17 bodyItem = new GMM07_GIMS_DTZMMMT17();
			
			
			bodyItem.setBUKRS(  util.nullToString(bodyRowData.getString("companyCd")));
			bodyItem.setZEBELN(  util.nullToString(bodyRowData.getString("poNo")));
			bodyItem.setZGRSEQ(  util.nullToString(bodyRowData.getString("ivSeq")));
			bodyItem.setWTGP(  util.nullToString(bodyRowData.getString("wtSeq")));
			bodyItem.setWITHT(  util.nullToString(bodyRowData.getString("code")));
			bodyItem.setWITHCD ( util.nullToString(bodyRowData.getString("taxCode")));
			bodyItem.setWITHRTE(  util.nullToString(bodyRowData.getString("rate")));
			bodyItem.setQSSHB(  util.nullToString(format.format(bodyRowData.getDouble("baseAmt"))));
			bodyItem.setQBSHB(  util.nullToString(format.format(bodyRowData.getDouble("taxAmt"))));
			
			bodyItem.setATTR1(  util.nullToString(bodyRowData.getString("attr1")));
			bodyItem.setATTR2(  util.nullToString(bodyRowData.getString("attr2")));
			bodyItem.setATTR3(  util.nullToString(bodyRowData.getString("attr3")));
			bodyItem.setATTR4(  util.nullToString(bodyRowData.getString("attr4")));
			bodyItem.setATTR5(  util.nullToString(bodyRowData.getString("attr5")));
			bodyItem.setATTR6(  util.nullToString(bodyRowData.getString("attr6")));
			bodyItem.setATTR7(  util.nullToString(bodyRowData.getString("attr7")));
			bodyItem.setATTR8(  util.nullToString(bodyRowData.getString("attr8")));
			bodyItem.setATTR9(  util.nullToString(bodyRowData.getString("attr9")));
						
			ZFIMT0003[j] = bodyItem;
			
			LLog.info.println("bodyItem.getBUKRS      =====>"+bodyItem.getBUKRS  ());
			LLog.info.println("bodyItem.getZEBELN     =====>"+bodyItem.getZEBELN ());
			LLog.info.println("bodyItem.getZGRSEQ     =====>"+bodyItem.getZGRSEQ ());
			LLog.info.println("bodyItem.getWTGP       =====>"+bodyItem.getWTGP   ());
			LLog.info.println("bodyItem.getWITHT      =====>"+bodyItem.getWITHT  ());
			LLog.info.println("bodyItem.getWITHCD     =====>"+bodyItem.getWITHCD ());
			LLog.info.println("bodyItem.getWITHRTE    =====>"+bodyItem.getWITHRTE());
			LLog.info.println("bodyItem.getQSSHB      =====>"+bodyItem.getQSSHB  ());
			LLog.info.println("bodyItem.getQBSHB      =====>"+bodyItem.getQBSHB  ());
			LLog.info.println("bodyItem.getATTR1      =====>"+bodyItem.getATTR1  ());
			LLog.info.println("bodyItem.getATTR2      =====>"+bodyItem.getATTR2  ());
			LLog.info.println("bodyItem.getATTR3      =====>"+bodyItem.getATTR3  ());
			LLog.info.println("bodyItem.getATTR4      =====>"+bodyItem.getATTR4  ());
			LLog.info.println("bodyItem.getATTR5      =====>"+bodyItem.getATTR5  ());
			LLog.info.println("bodyItem.getATTR6      =====>"+bodyItem.getATTR6  ());
			LLog.info.println("bodyItem.getATTR7      =====>"+bodyItem.getATTR7  ());
			LLog.info.println("bodyItem.getATTR8      =====>"+bodyItem.getATTR8  ());
			LLog.info.println("bodyItem.getATTR9      =====>"+bodyItem.getATTR9  ());


			
		}
		//DT에 header 및 boby 데이터 Setting
		GMM07_DT.setZMMMT15(ZFIMT0001);
		GMM07_DT.setZMMMT16(ZFIMT0002);
		GMM07_DT.setZMMMT17(ZFIMT0003);
		
		//Return Msg
		GMM07R_GIMS_DTZSAPMSG zsapmsg = new GMM07R_GIMS_DTZSAPMSG();  		
		
		try{
			
			GMM07_outServiceLocator serviceLocator = new GMM07_outServiceLocator();
	        
			LLog.info.println(util.getProp("EAI_HTTP_URL_PTPAM_GMM07_SAP"));
	        serviceLocator.setGMM07_outPortEndpointAddress(util.getProp("EAI_HTTP_URL_PTPAM_GMM07_SAP"));
	            
	        GMM07_outBindingStub bindingStub = (GMM07_outBindingStub) serviceLocator.getGMM07_outPort();
	            
            bindingStub.setUsername(util.getProp("EAI_USER"));
            bindingStub.setPassword(util.getProp("EAI_PWD"));

            //XI 전송 및 결과 Return
            LLog.info.println("XI Connection try!!");
            R_GMM07_DT = bindingStub.GMM07_out(GMM07_DT);
	            	
            zsapmsg = R_GMM07_DT.getZSAPMSG();
	            
            
            LLog.info.write("GMM07 zsapmsg.getMTYPE() :: " + zsapmsg.getMTYPE());
            LLog.info.write("GMM07 zsapmsg.getMTEXT() :: " + zsapmsg.getMTEXT());
            LLog.info.write("GMM07 zsapmsg.getMBLNR() :: " + zsapmsg.getMBLNR());
            LLog.info.write("GMM07 zsapmsg.getBELNR() :: " + zsapmsg.getBELNR());

            resultMsg.setString("returnType",  zsapmsg.getMTYPE());
            resultMsg.setString("returnText",  zsapmsg.getMTEXT());
            resultMsg.setString("returnGrDocNo", zsapmsg.getMBLNR());
            resultMsg.setString("returnIvDocNo", zsapmsg.getBELNR());
		
		} catch(Exception e){
			e.getMessage();
			throw new LSysException(e.getMessage());
			
		}
		
		return resultMsg;
	}	
}
