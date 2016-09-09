package xi;

import com.lgicorp.gims.sap.gmm11.GMM11R_GIMS_DT;
import com.lgicorp.gims.sap.gmm11.GMM11R_GIMS_DTZSAPMSG;
import com.lgicorp.gims.sap.gmm11.GMM11_GIMS_DT;
import com.lgicorp.gims.sap.gmm11.GMM11_GIMS_DTZMMMT008;
import com.lgicorp.gims.sap.gmm11.GMM11_GIMS_DTZMMMT909;
import com.lgicorp.gims.sap.gmm11.GMM11_GIMS_DTZMMMT910;
import com.lgicorp.gims.sap.gmm11.GMM11_outBindingStub;
import com.lgicorp.gims.sap.gmm11.GMM11_outServiceLocator;

import comm.util.Util;
import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LSysException;
import devon.core.log.LLog;

public class GMM11 {

	public LData GMM11_out(LData headerData, LMultiData bodyData1, LMultiData bodyData2) throws LSysException {
		
			LLog.info.write("GMM11_out Service Start");
		
			Util util = new Util();
			LData resultMsg = new LData();
			
			GMM11_GIMS_DT 	GMM11_DT = new  GMM11_GIMS_DT();
			GMM11R_GIMS_DT 	R_GMM11_DT = new  GMM11R_GIMS_DT();
			
			GMM11_GIMS_DTZMMMT909 headerItem = new GMM11_GIMS_DTZMMMT909();
			
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
        
		GMM11_GIMS_DTZMMMT008[] ZMMMT008 = new GMM11_GIMS_DTZMMMT008[bodyData1.getDataCount()];
		
		for (int j = 0; j < bodyData1.getDataCount(); j++) {
			LData bodyRowData = bodyData1.getLData(j);
			GMM11_GIMS_DTZMMMT008 bodyItem1 = new GMM11_GIMS_DTZMMMT008();
			
			bodyItem1.setCOMPANY_CD(util.nullToString(bodyRowData.getString("companyCd")));
			bodyItem1.setZEBELN(util.nullToString(bodyRowData.getString("syskey")));
			bodyItem1.setITEM_SEQ(util.nullToString(bodyRowData.getString("materSeq")));
			bodyItem1.setMATER_CD(util.nullToString(bodyRowData.getString("materCd")));
			bodyItem1.setKOSTL(util.nullToString(bodyRowData.getString("kostl")));
			bodyItem1.setPLANT_CD(util.nullToString(bodyRowData.getString("plantCd")));
			bodyItem1.setSTOR_LOCT(util.nullToString(bodyRowData.getString("storLoct")));
			bodyItem1.setERFMG(util.nullToString(bodyRowData.getString("prodOutQty")));
			bodyItem1.setATTR1(util.nullToString(bodyRowData.getString("attr1")));
			bodyItem1.setATTR2(util.nullToString(bodyRowData.getString("attr2")));
			bodyItem1.setATTR3(util.nullToString(bodyRowData.getString("attr3")));
			bodyItem1.setATTR4(util.nullToString(bodyRowData.getString("attr4")));
			bodyItem1.setATTR5(util.nullToString(bodyRowData.getString("attr5")));
			bodyItem1.setATTR6(util.nullToString(bodyRowData.getString("attr6")));
			bodyItem1.setATTR7(util.nullToString(bodyRowData.getString("attr7")));
			bodyItem1.setATTR8(util.nullToString(bodyRowData.getString("attr8")));
			bodyItem1.setATTR9(util.nullToString(bodyRowData.getString("attr9")));
			bodyItem1.setATTR10(util.nullToString(bodyRowData.getString("attr10")));

			ZMMMT008[j] = bodyItem1;
		}
		
	GMM11_GIMS_DTZMMMT910[] ZMMMT910 = new GMM11_GIMS_DTZMMMT910[bodyData2.getDataCount()];
			
	for (int j = 0; j < bodyData2.getDataCount(); j++) {
			LData bodyRowData = bodyData2.getLData(j);
			GMM11_GIMS_DTZMMMT910 bodyItem2 = new GMM11_GIMS_DTZMMMT910();
			
			bodyItem2.setBUKRS(util.nullToString(bodyRowData.getString("companyCd")));
			bodyItem2.setZEBELN(util.nullToString(bodyRowData.getString("syskey")));
			bodyItem2.setITEM_SEQ(util.nullToString(bodyRowData.getString("materSeq")));
			bodyItem2.setMATER_CD(util.nullToString(bodyRowData.getString("materCd")));
			bodyItem2.setWERKS(util.nullToString(bodyRowData.getString("plantCd")));
			bodyItem2.setLGORT(util.nullToString(bodyRowData.getString("storLoct")));
			bodyItem2.setERFMG(util.nullToString(bodyRowData.getString("prodInQty")));
			bodyItem2.setATTR1(util.nullToString(bodyRowData.getString("attr1")));
			bodyItem2.setATTR2(util.nullToString(bodyRowData.getString("attr2")));
			bodyItem2.setATTR3(util.nullToString(bodyRowData.getString("attr3")));
			bodyItem2.setATTR4(util.nullToString(bodyRowData.getString("attr4")));
			bodyItem2.setATTR5(util.nullToString(bodyRowData.getString("attr5")));
			bodyItem2.setATTR6(util.nullToString(bodyRowData.getString("attr6")));
			bodyItem2.setATTR7(util.nullToString(bodyRowData.getString("attr7")));
			bodyItem2.setATTR8(util.nullToString(bodyRowData.getString("attr8")));
			bodyItem2.setATTR9(util.nullToString(bodyRowData.getString("attr9")));
			bodyItem2.setATTR10(util.nullToString(bodyRowData.getString("attr10")));

			ZMMMT910[j] = bodyItem2;
	}
		
        	// DT에 header 및 boby 데이터 Setting
			GMM11_DT.setZMMMT909(headerItem);
			GMM11_DT.setZMMMT008(ZMMMT008);
			GMM11_DT.setZMMMT910(ZMMMT910);

			//Return Msg
			GMM11R_GIMS_DTZSAPMSG zsapmsg = new GMM11R_GIMS_DTZSAPMSG(); 
			
			try{
				GMM11_outServiceLocator locator = new GMM11_outServiceLocator();
				locator.setGMM11_outPortEndpointAddress(util.getProp("EAI_HTTP_URL_PTPAM_GMM11_SAP"));
				GMM11_outBindingStub stub = (GMM11_outBindingStub) locator.getGMM11_outPort();
				stub.setUsername(util.getProp("EAI_USER"));
				stub.setPassword(util.getProp("EAI_PWD"));
				
				 System.out.println("XI Connection try!!");
				 R_GMM11_DT = stub.GMM11_out(GMM11_DT);
		            	
	            zsapmsg = R_GMM11_DT.getZSAPMSG();
		            
	            LLog.info.write("GMM11 zsapmsg.getMTYPE() :: " + zsapmsg.getMTYPE());
	            LLog.info.write("GMM11 zsapmsg.getMTEXT() :: " + zsapmsg.getMTEXT());
	            LLog.info.write("GMM11 zsapmsg.getSAP_GI_NO() :: " + zsapmsg.getSAP_GI_NO());
	            LLog.info.write("GMM11 zsapmsg.getSAP_GR_NO() :: " + zsapmsg.getSAP_GR_NO());
	            LLog.info.write("GMM11 zsapmsg.getMJAHR() :: " + zsapmsg.getMJAHR());
	            LLog.info.write("GMM11 zsapmsg.getSTATUS() :: " + zsapmsg.getSTATUS());
	            
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