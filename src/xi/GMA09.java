package xi;

import com.lgicorp.gims.sap.gma09.GMA09R_GIMS_DT;
import com.lgicorp.gims.sap.gma09.GMA09R_GIMS_DTZSAPMSG;
import com.lgicorp.gims.sap.gma09.GMA09_GIMS_DT;
import com.lgicorp.gims.sap.gma09.GMA09_GIMS_DTTB_MATER_REQUEST;
import com.lgicorp.gims.sap.gma09.GMA09_outBindingStub;
import com.lgicorp.gims.sap.gma09.GMA09_outServiceLocator;

import comm.util.Util;
import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LSysException;
import devon.core.log.LLog;

public class GMA09 {

	public LData GMA09_out(LData headerData, LMultiData bodyData) throws LSysException {
		
		LLog.info.write("GMA09_out Service Start");
		
		Util util = new Util();
		LData resultMsg = new LData();
		
		GMA09_GIMS_DT 	GMA09_DT = new  GMA09_GIMS_DT();
		GMA09R_GIMS_DT 	R_GMA09_DT = new  GMA09R_GIMS_DT();
			
		GMA09_GIMS_DTTB_MATER_REQUEST headerItem = new GMA09_GIMS_DTTB_MATER_REQUEST();
			
		headerItem.setZXMLDOCNO(util.nullToString(headerData.getString("zxmldocno")));
		headerItem.setBUKRS(util.nullToString(headerData.getString("companyCd")));
		headerItem.setZWEBNO(util.nullToString(headerData.getString("requestNo")));
		headerItem.setMAKTXK1(util.nullToString(headerData.getString("materNmEn")));
		headerItem.setMAKTXK2(util.nullToString(headerData.getString("materNmEn")));
		headerItem.setMTART(util.nullToString("UNBW")); //Spare Part 유형만 
		headerItem.setMEINS(util.nullToString(headerData.getString("unit")));
		headerItem.setZASTATUS(util.nullToString(headerData.getString("requestType")));
		headerItem.setZFSTATUS(util.nullToString(headerData.getString("status")));
		headerItem.setMATNR(util.nullToString(headerData.getString("materCd")));
		headerItem.setLVORM(util.nullToString(headerData.getString("cancelType")));
		headerItem.setMATKL(util.nullToString(headerData.getString("")));
		headerItem.setRESON(util.nullToString(headerData.getString("cancelMsg")));
		headerItem.setPRCTR(util.nullToString(headerData.getString("")));
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
        
		GMA09_DT.setTB_MATER_REQUEST(headerItem);

		//Return Msg
		GMA09R_GIMS_DTZSAPMSG zsapmsg = new GMA09R_GIMS_DTZSAPMSG(); 
			
		try{
			GMA09_outServiceLocator locator = new GMA09_outServiceLocator();
			locator.setHTTP_PortEndpointAddress(util.getProp("EAI_HTTP_URL_PTPAM_GMA09_SAP"));
			GMA09_outBindingStub stub = (GMA09_outBindingStub) locator.getHTTP_Port();
			stub.setUsername(util.getProp("EAI_USER"));
			stub.setPassword(util.getProp("EAI_PWD"));
				
			LLog.info.write("XI Connection try!!");
			 R_GMA09_DT = stub.GMA09_out(GMA09_DT);
		            	
	         zsapmsg = R_GMA09_DT.getZSAPMSG();
		            
	         LLog.info.write("GMA09 zsapmsg.getMTYPE() :: " + zsapmsg.getMTYPE());
	         LLog.info.write("GMA09 zsapmsg.getMTEXT() :: " + zsapmsg.getMTEXT());
	         LLog.info.write("GMA09 zsapmsg.getMATNR() :: " + zsapmsg.getMATNR());
	         LLog.info.write("GMA09 zsapmsg.getZREQNO() :: " + zsapmsg.getZREQNO ());
	           
	         resultMsg.setString("returnType", zsapmsg.getMTYPE());
	         resultMsg.setString("returnText", zsapmsg.getMTEXT());
	         resultMsg.setString("returnMaterCd", zsapmsg.getMATNR());
	         resultMsg.setString("returnRequestNo", zsapmsg.getZREQNO());
	         
		}catch(Exception e){
			e.getMessage();
			throw new LSysException(e.getMessage());
		}    
		
		return resultMsg;
	}

}