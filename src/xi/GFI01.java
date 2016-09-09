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

import com.lgicorp.gims.sap.gfi01.GFI01R_GIMS_DT;
import com.lgicorp.gims.sap.gfi01.GFI01R_GIMS_DTZSAPMSG;
import com.lgicorp.gims.sap.gfi01.GFI01_GIMS_DT;
import com.lgicorp.gims.sap.gfi01.GFI01_GIMS_DTZFIMT0001;
import com.lgicorp.gims.sap.gfi01.GFI01_GIMS_DTZFIMT0002;
import com.lgicorp.gims.sap.gfi01.GFI01_outBindingStub;
import com.lgicorp.gims.sap.gfi01.GFI01_outServiceLocator;
import comm.util.Util;
import java.text.*;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LSysException;
import devon.core.log.LLog;

public class GFI01 {
	
	public LData GFI01_out(LMultiData headerData, LMultiData bodyData) throws LSysException {
		
		LLog.info.write("GFI01_out Service Start");
		
		Util util = new Util();
		LData resultMsg = new LData();
		DecimalFormat format = new DecimalFormat("0.####");

		GFI01_GIMS_DT GFI01_DT = new GFI01_GIMS_DT();
		GFI01R_GIMS_DT R_GFI01_DT = new GFI01R_GIMS_DT();
				
		//총계정원가 Header
		LLog.info.write("Master : \n" + headerData);
		GFI01_GIMS_DTZFIMT0001[] ZFIMT0001 = new GFI01_GIMS_DTZFIMT0001[headerData.getDataCount()];
		
		for (int i = 0; i < headerData.getDataCount(); i++) {
			LData headRowData = headerData.getLData(i);
			GFI01_GIMS_DTZFIMT0001 headerItem = new GFI01_GIMS_DTZFIMT0001();
			
			headerItem.setZXMLDOCNO(util.nullToString(headRowData.getString("zxmldocno")));
			headerItem.setBUKRS(util.nullToString(headRowData.getString("companyCd")));
			headerItem.setGSBER(util.nullToString(headRowData.getString("deptCd")));
			headerItem.setDOCYM(util.nullToString(headRowData.getString("docYm")));
			headerItem.setBELNR_2(util.nullToString(headRowData.getString("docSeq")));
			headerItem.setBLDAT(util.nullToString(headRowData.getString("docDate")));
			headerItem.setBUDAT(util.nullToString(headRowData.getString("postDate")));
			headerItem.setPROG_STATUS(util.nullToString(headRowData.getString("progStatus")));
			headerItem.setBELNR(util.nullToString(headRowData.getString("sapDocSeq")));
			headerItem.setWERAS(util.nullToString(headRowData.getString("currencyCd")));
			headerItem.setATTR1(util.nullToString(headRowData.getString("attr1")));
			headerItem.setATTR2(util.nullToString(headRowData.getString("attr2")));
			headerItem.setATTR3(util.nullToString(headRowData.getString("attr3")));
			headerItem.setATTR4(util.nullToString(headRowData.getString("attr4")));
			headerItem.setATTR5(util.nullToString(headRowData.getString("attr5")));
			headerItem.setATTR6(util.nullToString(headRowData.getString("attr6")));
			headerItem.setATTR7(util.nullToString(headRowData.getString("attr7")));
			headerItem.setATTR8(util.nullToString(headRowData.getString("attr8")));
			headerItem.setATTR9(util.nullToString(headRowData.getString("attr9")));
			headerItem.setATTR10(util.nullToString(headRowData.getString("attr10")));
			
			ZFIMT0001[i] = headerItem;
		}
		
		//총계정원가 Body
		LLog.info.write("Body : \n" + bodyData);
		GFI01_GIMS_DTZFIMT0002[] ZFIMT0002 = new GFI01_GIMS_DTZFIMT0002[bodyData.getDataCount()];
		
		for (int j = 0; j < bodyData.getDataCount(); j++) {
			LData bodyRowData = bodyData.getLData(j);
			GFI01_GIMS_DTZFIMT0002 bodyItem = new GFI01_GIMS_DTZFIMT0002();
			
			bodyItem.setBUKRS(util.nullToString(bodyRowData.getString("companyCd")));
			bodyItem.setGSBER(util.nullToString(bodyRowData.getString("deptCd")));
			bodyItem.setDOCYM(util.nullToString(bodyRowData.getString("docYm")));
			bodyItem.setBELNR_2(util.nullToString(bodyRowData.getString("docSeq")));
			bodyItem.setBUZEI_2(util.nullToString(bodyRowData.getString("docNum")));
			bodyItem.setHKONT_2(util.nullToString(bodyRowData.getString("acctCd")));
			bodyItem.setUMSKZ(util.nullToString(bodyRowData.getString("spglNo")));
			bodyItem.setLIFNR(util.nullToString(bodyRowData.getString("sapAcctV")));
			bodyItem.setKUNNR(util.nullToString(bodyRowData.getString("sapAcctC")));
			bodyItem.setHKONT(util.nullToString(bodyRowData.getString("sapAcctCd")));
			bodyItem.setWERAS(util.nullToString(bodyRowData.getString("currencyCd")));
			bodyItem.setWRBTR_1(util.nullToString(format.format(bodyRowData.getDouble("debitAmt"))));
			bodyItem.setWRBTR_2(util.nullToString(format.format(bodyRowData.getDouble("creditAmt"))));
			bodyItem.setSGTXT(util.nullToString(bodyRowData.getString("docDesc")));
			bodyItem.setAREA(util.nullToString(bodyRowData.getString("areaCd")));
			bodyItem.setDIVIS(util.nullToString(bodyRowData.getString("divCd")));
			bodyItem.setBLOCK1(util.nullToString(bodyRowData.getString("blockCd")));
			bodyItem.setBLOCK2(util.nullToString(bodyRowData.getString("blockCd2")));
			bodyItem.setYEAR(util.nullToString(bodyRowData.getString("yearCd")));
			bodyItem.setTM_TBM(util.nullToString(bodyRowData.getString("tmTbm")));
			bodyItem.setATTR1(util.nullToString(bodyRowData.getString("attr1")));
			bodyItem.setATTR2(util.nullToString(bodyRowData.getString("attr2")));
			bodyItem.setATTR3(util.nullToString(bodyRowData.getString("attr3")));
			bodyItem.setATTR4(util.nullToString(format.format(bodyRowData.getDouble("attr4"))));
			bodyItem.setATTR5(util.nullToString(bodyRowData.getString("attr5")));
			bodyItem.setATTR6(util.nullToString(format.format(bodyRowData.getDouble("attr6"))));
			bodyItem.setATTR7(util.nullToString(bodyRowData.getString("attr7")));
			bodyItem.setATTR8(util.nullToString(bodyRowData.getString("attr8")));
			bodyItem.setATTR9(util.nullToString(bodyRowData.getString("attr9")));
			//bodyItem.setATTR10(util.nullToString(bodyRowData.getString("attr10")));
			bodyItem.setATTR10(util.nullToString(format.format(bodyRowData.getDouble("attr10"))));
			bodyItem.setATTR11(util.nullToString(bodyRowData.getString("attr11")));
			bodyItem.setATTR12(util.nullToString(bodyRowData.getString("attr12")));
			bodyItem.setATTR13(util.nullToString(bodyRowData.getString("attr13")));
			bodyItem.setATTR14(util.nullToString(bodyRowData.getString("attr14")));
			bodyItem.setATTR15(util.nullToString(bodyRowData.getString("attr15")));
			bodyItem.setATTR16(util.nullToString(bodyRowData.getString("attr16")));
			bodyItem.setATTR17(util.nullToString(bodyRowData.getString("attr17")));
			bodyItem.setATTR18(util.nullToString(bodyRowData.getString("attr18")));
			bodyItem.setATTR19(util.nullToString(bodyRowData.getString("attr19")));
			bodyItem.setATTR20(util.nullToString(bodyRowData.getString("attr20")));
			
			
						
			ZFIMT0002[j] = bodyItem;
		}
				
		//DT에 header 및 boby 데이터 Setting
		GFI01_DT.setZFIMT0001(ZFIMT0001);
		GFI01_DT.setZFIMT0002(ZFIMT0002);
		
		//Return Msg
		GFI01R_GIMS_DTZSAPMSG zsapmsg = new GFI01R_GIMS_DTZSAPMSG();  		
		
		try{
			
			GFI01_outServiceLocator serviceLocator = new GFI01_outServiceLocator();
	        
			LLog.info.println(util.getProp("EAI_HTTP_URL_PTPAM_GFI01_SAP"));
	        serviceLocator.setGFI01_outPortEndpointAddress(util.getProp("EAI_HTTP_URL_PTPAM_GFI01_SAP"));
	            
	        GFI01_outBindingStub bindingStub = (GFI01_outBindingStub) serviceLocator.getGFI01_outPort();
	            
            bindingStub.setUsername(util.getProp("EAI_USER"));
            bindingStub.setPassword(util.getProp("EAI_PWD"));

            //XI 전송 및 결과 Return
            LLog.info.println("XI Connection try!!");
            R_GFI01_DT = bindingStub.GFI01_out(GFI01_DT);
	            	
            zsapmsg = R_GFI01_DT.getZSAPMSG();
	            
            LLog.info.write("GFI01 zsapmsg.getMTYPE() :: " + zsapmsg.getMTYPE());
            LLog.info.write("GFI01 zsapmsg.getMTEXT() :: " + zsapmsg.getMTEXT());
            
            resultMsg.setString("returnType", zsapmsg.getMTYPE());
            resultMsg.setString("returnText", zsapmsg.getMTEXT());
		
		} catch(Exception e){
			e.getMessage();
			throw new LSysException(e.getMessage());
		}
		
		return resultMsg;
	}	
}
