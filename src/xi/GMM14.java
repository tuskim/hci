package xi;

import com.lgicorp.gims.sap.gmm14.GMM14R_GIMS_DT;
import com.lgicorp.gims.sap.gmm14.GMM14R_GIMS_DTZSAPMSG;
import com.lgicorp.gims.sap.gmm14.GMM14_GIMS_DT;
import com.lgicorp.gims.sap.gmm14.GMM14_GIMS_DTZMMMT909;
import com.lgicorp.gims.sap.gmm14.GMM14_GIMS_DTZMMMT910;
import com.lgicorp.gims.sap.gmm14.GMM14_outBindingStub;
import com.lgicorp.gims.sap.gmm14.GMM14_outServiceLocator;

import comm.util.Util;
import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LSysException;
import devon.core.log.LLog;

public class GMM14 {

	public LData GMM14_out(LData headerData, LMultiData bodyData) throws LSysException {
		
		LLog.info.write("GMM14_out Service Start");
		
		Util util = new Util();
		LData resultMsg = new LData();
		
		GMM14_GIMS_DT 	GMM14_DT = new  GMM14_GIMS_DT();
		GMM14R_GIMS_DT 	R_GMM14_DT = new  GMM14R_GIMS_DT();
			
		GMM14_GIMS_DTZMMMT909 headerItem = new GMM14_GIMS_DTZMMMT909();
			
		headerItem.setZXMLDOCNO(util.nullToString(headerData.getString("zxmldocno")));
		headerItem.setCOMPANY_CD(util.nullToString(headerData.getString("companyCd")));
		headerItem.setZEBELN(util.nullToString(headerData.getString("syskey")));
		headerItem.setZFSTATUS(util.nullToString(headerData.getString("status")));
		headerItem.setBLDAT(util.nullToString(headerData.getString("prodDate")));
		headerItem.setBUDAT(util.nullToString(headerData.getString("postDate")));
		headerItem.setLOEVM(util.nullToString(headerData.getString("cancelType")));
		headerItem.setATTR1(util.nullToString(headerData.getString("attr1")));
		headerItem.setATTR2(util.nullToString(headerData.getString("attr2")));
		headerItem.setATTR3(util.nullToString(headerData.getString("attr3")));
		headerItem.setATTR4(util.nullToString(headerData.getString("attr4")));
		headerItem.setATTR5(util.nullToString(headerData.getString("attr5")));
        
		GMM14_GIMS_DTZMMMT910[] ZMMMT910 = new GMM14_GIMS_DTZMMMT910[bodyData.getDataCount()];
			
		for (int j = 0; j < bodyData.getDataCount(); j++) {
			LData bodyRowData = bodyData.getLData(j);
			GMM14_GIMS_DTZMMMT910 bodyItem = new GMM14_GIMS_DTZMMMT910();
				
			bodyItem.setBUKRS(util.nullToString(bodyRowData.getString("companyCd")));
			bodyItem.setZEBELN(util.nullToString(bodyRowData.getString("syskey")));
			bodyItem.setITEM_SEQ(util.nullToString(bodyRowData.getString("materSeq")));
			bodyItem.setMATER_CD(util.nullToString(bodyRowData.getString("materCd")));
			bodyItem.setWERKS(util.nullToString(bodyRowData.getString("plantCd")));
			bodyItem.setLGORT(util.nullToString(bodyRowData.getString("storLoct")));
			bodyItem.setERFMG(util.nullToString(bodyRowData.getString("prodInQty")));
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
	
			ZMMMT910[j] = bodyItem;
		}
		
        // DT에 header 및 boby 데이터 Setting
		GMM14_DT.setZMMMT909(headerItem);
		GMM14_DT.setZMMMT910(ZMMMT910);

		//Return Msg
		GMM14R_GIMS_DTZSAPMSG zsapmsg = new GMM14R_GIMS_DTZSAPMSG(); 
			
		try{
			GMM14_outServiceLocator locator = new GMM14_outServiceLocator();
			locator.setHTTP_PortEndpointAddress(util.getProp("EAI_HTTP_URL_PTPAM_GMM14_SAP"));
			GMM14_outBindingStub stub = (GMM14_outBindingStub) locator.getHTTP_Port();
			stub.setUsername(util.getProp("EAI_USER"));
			stub.setPassword(util.getProp("EAI_PWD"));
				
			 System.out.println("XI Connection try!!");
			 R_GMM14_DT = stub.GMM14_out(GMM14_DT);
		            	
	         zsapmsg = R_GMM14_DT.getZSAPMSG();
		            
	         LLog.info.write("GMM14 zsapmsg.getMTYPE() :: " + zsapmsg.getMTYPE());
	         LLog.info.write("GMM14 zsapmsg.getMTEXT() :: " + zsapmsg.getMTEXT());
	         LLog.info.write("GMM14 zsapmsg.getSAP_GI_NO() :: " + zsapmsg.getSAP_GI_NO());
	         LLog.info.write("GMM14 zsapmsg.getSAP_GR_NO() :: " + zsapmsg.getSAP_GR_NO());
	         LLog.info.write("GMM14 zsapmsg.getMJAHR() :: " + zsapmsg.getMJAHR());
	         LLog.info.write("GMM14 zsapmsg.getSTATUS() :: " + zsapmsg.getSTATUS());
	           
	         resultMsg.setString("returnType", zsapmsg.getMTYPE());
	         resultMsg.setString("returnText", zsapmsg.getMTEXT());
	         resultMsg.setString("returnSapGiNo", zsapmsg.getSAP_GI_NO());
	         resultMsg.setString("returnSapGrNo", zsapmsg.getSAP_GR_NO());
	         resultMsg.setString("returnMjahr", zsapmsg.getMJAHR());
	         resultMsg.setString("returnStatus", zsapmsg.getSTATUS());
		}catch(Exception e){
			e.getMessage();
			throw new LSysException(e.getMessage());
		}    
		
		return resultMsg;
	}

}