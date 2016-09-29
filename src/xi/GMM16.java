package xi;

import com.lgicorp.gims.sap.gmm16.GMM16R_GIMS_DT;
import com.lgicorp.gims.sap.gmm16.GMM16R_GIMS_DTZSAPMSG;
import com.lgicorp.gims.sap.gmm16.GMM16_GIMS_DT;
import com.lgicorp.gims.sap.gmm16.GMM16_GIMS_DTTB_PO_DETAIL;
import com.lgicorp.gims.sap.gmm16.GMM16_GIMS_DTTB_PO_MASTER;
import com.lgicorp.gims.sap.gmm16.GMM16_outBindingStub;
import com.lgicorp.gims.sap.gmm16.GMM16_outServiceLocator;

import comm.util.Util;
import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LSysException;
import devon.core.log.LLog;

public class GMM16 {

	public LData GMM16_out(LData headerData, LMultiData bodyData) throws LSysException {
		
		LLog.info.write("GMM16_out_out Service Start");
		
		Util util = new Util();
		LData resultMsg = new LData();
		
		GMM16_GIMS_DT 	GMM16_DT = new  GMM16_GIMS_DT();
		GMM16R_GIMS_DT 	R_GMM16_DT = new  GMM16R_GIMS_DT();
		
		LLog.info.write("Master : \n" + headerData);
			
		GMM16_GIMS_DTTB_PO_MASTER headerItem = new GMM16_GIMS_DTTB_PO_MASTER();
			
		headerItem.setZXMLDOCNO(util.nullToString(headerData.getString("zxmldocno")));
		headerItem.setCOMPANY_CD(util.nullToString(headerData.getString("companyCd")));
		headerItem.setPO_NO(util.nullToString(headerData.getString("poNo")));
		headerItem.setSAP_PO_NO(util.nullToString(headerData.getString("sapPoNo")));
		headerItem.setRETPO(util.nullToString(headerData.getString("poType")));
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
		
		// 총계정원가 Body
		LLog.info.write("Detail : \n" + bodyData);
		GMM16_GIMS_DTTB_PO_DETAIL[] detailData = new GMM16_GIMS_DTTB_PO_DETAIL[bodyData.getDataCount()];

		for (int j = 0; j < bodyData.getDataCount(); j++) {
			LData bodyRowData = bodyData.getLData(j);
			GMM16_GIMS_DTTB_PO_DETAIL bodyItem = new GMM16_GIMS_DTTB_PO_DETAIL();

			bodyItem.setCOMPANY_CD(util.nullToString(bodyRowData.getString("companyCd")));
			bodyItem.setPO_NO(util.nullToString(bodyRowData.getString("poNo")));
			bodyItem.setPO_SEQ(util.nullToString(bodyRowData.getString("poSeq")));
			bodyItem.setMATER_CD(util.nullToString(bodyRowData.getString("materCd")));
			bodyItem.setCLOSE(util.nullToString(bodyRowData.getString("receiptClsYn").equals("Y")?"S":""));
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

			detailData[j] = bodyItem;
		}
        
		GMM16_DT.setTB_PO_MASTER(headerItem);
		GMM16_DT.setTB_PO_DETAIL(detailData);

		//Return Msg
		GMM16R_GIMS_DTZSAPMSG zsapmsg = new GMM16R_GIMS_DTZSAPMSG(); 
			
		try{
			GMM16_outServiceLocator locator = new GMM16_outServiceLocator();
			locator.setHTTP_PortEndpointAddress(util.getProp("EAI_HTTP_URL_PTPAM_GMM16_SAP"));
			GMM16_outBindingStub stub = (GMM16_outBindingStub) locator.getHTTP_Port();
			stub.setUsername(util.getProp("EAI_USER"));
			stub.setPassword(util.getProp("EAI_PWD"));
				
			LLog.info.write("XI Connection try!!");
			R_GMM16_DT = stub.GMM16_out(GMM16_DT);
		            	
	        zsapmsg = R_GMM16_DT.getZSAPMSG();
		            
	        LLog.info.write("GMM16_out zsapmsg.getSAP_IF_STATUS() :: " + zsapmsg.getSAP_IF_STATUS());
	        LLog.info.write("GMM16_out zsapmsg.getSAP_RTN_MSG() :: " + zsapmsg.getSAP_RTN_MSG());
	        LLog.info.write("GMM16_out zsapmsg.getSAP_PO_NO() :: " + zsapmsg.getSAP_PO_NO());
	          	
	        resultMsg.setString("returnType", zsapmsg.getSAP_IF_STATUS());
	        resultMsg.setString("returnText", zsapmsg.getSAP_RTN_MSG());
	        resultMsg.setString("returnSapPoNo", zsapmsg.getSAP_PO_NO());
	         
		}catch(Exception e){
			e.getMessage();
			throw new LSysException(e.getMessage());
		}    
		
		return resultMsg;
	}

}