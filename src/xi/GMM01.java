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
import java.text.*;
import com.lgicorp.gims.sap.gmm01.GMM01R_GIMS_DTZSAPITEM;
import com.lgicorp.gims.sap.gmm01.GMM01_GIMS_DT;
import com.lgicorp.gims.sap.gmm01.GMM01_GIMS_DTZMMMT004;
import com.lgicorp.gims.sap.gmm01.GMM01_GIMS_DTZMMMT005;
import com.lgicorp.gims.sap.gmm01.GMM01_out;
import com.lgicorp.gims.sap.gmm01.GMM01_outBindingStub;
import com.lgicorp.gims.sap.gmm01.GMM01_outService;
import com.lgicorp.gims.sap.gmm01.GMM01_outServiceLocator;
import com.lgicorp.gims.sap.gmm01.GMM01R_GIMS_DT;
import com.lgicorp.gims.sap.gmm01.GMM01R_GIMS_DTZSAPMSG;  

import comm.util.Util;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LException;
import devon.core.exception.LSysException;
import devon.core.log.LLog;

public class GMM01 {
	
	public Vector GMM01_out(LData xmlDocNo, LMultiData headerData, LMultiData bodyData) throws LSysException {
		
		LLog.info.write("GMM01_out Service Start");
		
		Util util = new Util();
		LData resultMsg = new LData();
		DecimalFormat format = new DecimalFormat("0.####");
		GMM01_GIMS_DT GMM01_DT = new GMM01_GIMS_DT();
		GMM01R_GIMS_DT R_GMM01_DT = new GMM01R_GIMS_DT();
				
		//총계정원가 Header
		LLog.info.write("Master : \n" + headerData); 
	 
		LData headRowData = headerData.getLData(0);
		GMM01_GIMS_DTZMMMT004 ZMMMT004 = new GMM01_GIMS_DTZMMMT004();
	
		ZMMMT004.setZXMLDOCNO(util.nullToString(xmlDocNo.getString("zxmldocno")));
		ZMMMT004.setBUKRS(util.nullToString(headRowData.getString("companyCd")));
		ZMMMT004.setZEBELN(util.nullToString(headRowData.getString("poNo")));
		ZMMMT004.setLIFNR(util.nullToString(headRowData.getString("vendCd")));
		ZMMMT004.setBEDAT(util.nullToString(headRowData.getString("transDate")));
		ZMMMT004.setEKORG(util.nullToString(headRowData.getString("companyCd")));
		ZMMMT004.setWAERS(util.nullToString(headRowData.getString("currencyCd")));	 
		ZMMMT004.setKWERT(util.nullToString(format.format(headRowData.getDouble("minusdiscountAmt"))));	
		ZMMMT004.setPARVW(util.nullToString(headRowData.getString("parvw")));
		ZMMMT004.setGPARN(util.nullToString(headRowData.getString("pernr")));
		ZMMMT004.setZTERM(util.nullToString("")); //2016.09.09 hskim Payment Term 삭제 (출금 의뢰 영향)
		ZMMMT004.setEKGRP(util.nullToString(headRowData.getString("purGroup")));
		ZMMMT004.setABSGR(util.nullToString(headRowData.getString("absgr")));
		ZMMMT004.setZFSTATUS(util.nullToString(headRowData.getString("pstatus")));
		ZMMMT004.setEBELN(util.nullToString(headRowData.getString("sapPoNo")));
		ZMMMT004.setWERKS(util.nullToString(headRowData.getString("plantCd"))); 		
		ZMMMT004.setLGORT(util.nullToString(headRowData.getString("deliLoct"))); 				
		ZMMMT004.setATTR1(util.nullToString(headRowData.getString("deliDate")));//attr1
		ZMMMT004.setATTR2(util.nullToString(headRowData.getString("poType")));//attr2 
		ZMMMT004.setATTR3(util.nullToString(headRowData.getString("attr3")));
		ZMMMT004.setATTR4(util.nullToString(headRowData.getString("attr4")));
		ZMMMT004.setATTR5(util.nullToString(headRowData.getString("attr5")));
		ZMMMT004.setATTR6(util.nullToString(headRowData.getString("attr6")));
		ZMMMT004.setATTR7(util.nullToString(headRowData.getString("attr7")));
		ZMMMT004.setATTR8(util.nullToString(headRowData.getString("attr8")));
		ZMMMT004.setATTR9(util.nullToString(headRowData.getString("attr9")));
		ZMMMT004.setATTR10(util.nullToString(headRowData.getString("attr10")));
 
		//총계정원가 Body
		LLog.info.write("Master : \n" + bodyData);
		GMM01_GIMS_DTZMMMT005[] ZMMMT005 = new GMM01_GIMS_DTZMMMT005[bodyData.getDataCount()];
		
		for (int j = 0; j < bodyData.getDataCount(); j++) {
			LData bodyRowData = bodyData.getLData(j);
			GMM01_GIMS_DTZMMMT005 bodyItem = new GMM01_GIMS_DTZMMMT005();
 
			bodyItem.setBUKRS(util.nullToString(bodyRowData.getString("companyCd")));
			bodyItem.setZEBELN(util.nullToString(bodyRowData.getString("poNo")));
			bodyItem.setEBELP(util.nullToString(bodyRowData.getString("poSeq")));
			bodyItem.setMATNR(util.nullToString(bodyRowData.getString("materCd"))); 
			bodyItem.setMENGE(util.nullToString(format.format(bodyRowData.getDouble("qty"))));
			
			bodyItem.setMWSKZ(util.nullToString(bodyRowData.getString("vatCd"))); 
			bodyItem.setATTR1(util.nullToString(format.format(bodyRowData.getDouble("tranTaxRate")))); 
			bodyItem.setATTR2(util.nullToString(format.format(bodyRowData.getDouble("tranTaxAmt")))); 

			if(bodyRowData.getString("currType").equals("N")){
				bodyItem.setNETPR(util.nullToString(format.format(bodyRowData.getDouble("price")).replaceAll("\\.", "")));
				bodyItem.setATTR3(util.nullToString(getPer(format.format(bodyRowData.getDouble("price"))))); 
			}else{
				//USD즉 소수점사용일 경우 per값을 1
				bodyItem.setNETPR(util.nullToString(format.format(bodyRowData.getDouble("price"))));
				bodyItem.setATTR3(util.nullToString("1"));
				
			}  
			bodyItem.setATTR4(util.nullToString(format.format(bodyRowData.getDouble("vatAmt"))));
			bodyItem.setATTR5(util.nullToString(bodyRowData.getString("attr5")));
			bodyItem.setATTR6(util.nullToString(bodyRowData.getString("attr6")));
			bodyItem.setATTR7(util.nullToString(bodyRowData.getString("attr7")));
			bodyItem.setATTR8(util.nullToString(bodyRowData.getString("attr8")));
			bodyItem.setATTR9(util.nullToString(bodyRowData.getString("attr9")));
			bodyItem.setATTR10(util.nullToString(bodyRowData.getString("attr10"))); 
			
			ZMMMT005[j] = bodyItem; 
		}
				
		//DT에 header 및 boby 데이터 Setting
		GMM01_DT.setZMMMT004(ZMMMT004);
		GMM01_DT.setZMMMT005(ZMMMT005);
		
		//Return Msg
		GMM01R_GIMS_DTZSAPMSG zsapmsg = new GMM01R_GIMS_DTZSAPMSG();  		
		GMM01R_GIMS_DTZSAPITEM[] itemsmsg = new GMM01R_GIMS_DTZSAPITEM[bodyData.getDataCount()];  		
		Vector rtn = new Vector();
		try{
			
			GMM01_outServiceLocator serviceLocator = new GMM01_outServiceLocator();
	        
			LLog.debug.write(util.getProp("EAI_HTTP_URL_PTPAM_GMM01_SAP"));
	        serviceLocator.setGMM01_outPortEndpointAddress(util.getProp("EAI_HTTP_URL_PTPAM_GMM01_SAP"));
	            
	        GMM01_outBindingStub bindingStub = (GMM01_outBindingStub) serviceLocator.getGMM01_outPort();
	            
            bindingStub.setUsername(util.getProp("EAI_USER"));
            bindingStub.setPassword(util.getProp("EAI_PWD"));

            //XI 전송 및 결과 Return
            LLog.debug.write("XI Connection try!!");
            R_GMM01_DT = bindingStub.GMM01_out(GMM01_DT);
	            	
            zsapmsg = R_GMM01_DT.getZSAPMSG();
            itemsmsg = R_GMM01_DT.getZSAPITEM();
	            
            LLog.info.write("GMM01 zsapmsg.getMTYPE() :: " + zsapmsg.getMTYPE());
            LLog.info.write("GMM01 zsapmsg.getMTEXT() :: " + zsapmsg.getMTEXT());
            LLog.info.write("GMM01 itemsmsg :: " + itemsmsg);
            resultMsg.setString("returnType", zsapmsg.getMTYPE());
            resultMsg.setString("returnText", zsapmsg.getMTEXT());
            resultMsg.setString("returnPoNo",zsapmsg.getEBELN());
            LLog.info.write("GMM01 itemsmsg:: "+itemsmsg);
            LMultiData itemResultMsg = new LMultiData();
            if(itemsmsg!=null){
                for(int j=0; j<itemsmsg.length;j++){
                	itemResultMsg.addString("rCompanyCd", itemsmsg[j].getBUKRS());
                	itemResultMsg.addString("rPoNo", itemsmsg[j].getZEBELN());
                	itemResultMsg.addString("rPoSeq", itemsmsg[j].getEBELP());
                	itemResultMsg.addString("rSapPrice", itemsmsg[j].getZNETPR());
                }
            }

            LLog.info.write("GMM01 itemsm3:: ");
            LLog.info.write("GMM01 itemResultMsg :: " + itemResultMsg);
            
            
            rtn.add(resultMsg);
            rtn.add(itemResultMsg);
		} catch(Exception e){
			e.getMessage();
			throw new LSysException(e.getMessage());
		}
		
		return rtn;
	}	
	
    public String getPer(String str) throws LSysException {  
    	int dble=1; 
    	String result=""; 
		try{	 
			if(str.split("\\.").length>1){ 
				for(int i=0;i<str.split("\\.")[1].length();i++){				
					dble = dble * 10 ; 
				}
				result= Integer.toString(dble);
			}else{
				result =Integer.toString(dble);
			}
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "getPer------()" + "=>" + se.getMessage());
			throw new LSysException("po.oc", se);
		}
		return result;
    }   	
}
