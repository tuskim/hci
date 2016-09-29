/*
 *------------------------------------------------------------------------------
 * GFI06.java 
 * 
 * PROJ : PT-PAM
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2015/12/07   hckim   최초 프로그램 작성
 *----------------------------------------------------------------------------
 */

package xi;

import java.util.Vector;

import com.lgicorp.gims.sap.gfi06.GFI06R_GIMS_DT;
import com.lgicorp.gims.sap.gfi06.GFI06R_GIMS_DTITEM;
import com.lgicorp.gims.sap.gfi06.GFI06R_GIMS_DTZSAPMSG;
import com.lgicorp.gims.sap.gfi06.GFI06_GIMS_DT;
import com.lgicorp.gims.sap.gfi06.GFI06_GIMS_DTHEADER;
import com.lgicorp.gims.sap.gfi06.GFI06_outBindingStub;
import com.lgicorp.gims.sap.gfi06.GFI06_outServiceLocator;
import comm.util.Util;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LSysException;
import devon.core.log.LLog;

public class GFI06 {
	
	public Vector GFI06_out(LData inputData) throws LSysException {
		
		LLog.info.write("GFI06_out Service Start");
		
		Util util = new Util();
		LData resultMsg = new LData();

		GFI06_GIMS_DT GFI06_DT = new GFI06_GIMS_DT();
		GFI06R_GIMS_DT R_GFI06_DT = new GFI06R_GIMS_DT();
	  
		GFI06_GIMS_DTHEADER GFI06HD = new GFI06_GIMS_DTHEADER(); 
		GFI06_GIMS_DTHEADER GFI06DTS = new GFI06_GIMS_DTHEADER();
		
		GFI06DTS.setCOMPANY_CD(util.nullToString(inputData.getString("companyCd")));
		GFI06DTS.setPOST_DATE(util.nullToString(inputData.getString("postDate")));
		GFI06DTS.setVEND_CD(util.nullToString(inputData.getString("vendCd")));
		GFI06DTS.setBASELINE_DATE(util.nullToString(inputData.getString("baselineDate")));
		GFI06DTS.setCURR_CD(util.nullToString(inputData.getString("currCd")));
		GFI06DTS.setPERSONAL_ID(util.nullToString(inputData.getString("personalId")));
 
		GFI06HD = GFI06DTS;		
		
		GFI06_DT.setHEADER(GFI06HD);

		GFI06R_GIMS_DTZSAPMSG zsapmsg = new GFI06R_GIMS_DTZSAPMSG();  	

		Vector rtn = new Vector();
		
		try{
			
			GFI06_outServiceLocator serviceLocator = new GFI06_outServiceLocator();
 
			LLog.debug.write(util.getProp("EAI_HTTP_URL_PTPAM_GFI06_SAP"));
 
			serviceLocator.setHTTP_PortEndpointAddress(util.getProp("EAI_HTTP_URL_PTPAM_GFI06_SAP"));		
			
			GFI06_outBindingStub bindingStub = (GFI06_outBindingStub) serviceLocator.getHTTP_Port();		
  
            bindingStub.setUsername(util.getProp("EAI_USER"));
            bindingStub.setPassword(util.getProp("EAI_PWD"));

            //XI 전송 및 결과 Return
            LLog.debug.write("XI Connection try!!");
            
            R_GFI06_DT = bindingStub.GFI06_out(GFI06_DT);                
            
            zsapmsg = R_GFI06_DT.getZSAPMSG(); 
             
            GFI06R_GIMS_DTITEM[] itemsmsg = R_GFI06_DT.getITEM();
            
            LLog.info.write("GFI06 zsapmsg.getMTYPE() :: " + zsapmsg.getMTYPE());
            LLog.info.write("GFI06 zsapmsg.getMTEXT() :: " + zsapmsg.getMTEXT());
 
            resultMsg.setString("returnType", zsapmsg.getMTYPE());
            resultMsg.setString("returnText", zsapmsg.getMTEXT());
             		
            LMultiData openApList = new LMultiData();   
                                   
         	if(itemsmsg!=null){     
	        	
         		for(int j=0; j<itemsmsg.length;j++){
         			         		         		             		          		            		            		                 		          		
            		openApList.add( "chk"             ,"0" );                                 // chk
	        		openApList.add( "docNo"           ,itemsmsg[j].getDOC_NO().trim());       // Sap Doc No   (sap 전표번호)
	        		openApList.add( "lineItem"        ,itemsmsg[j].getLINE_ITEM().trim());    // Item Seq     (라인아이템)
	        		openApList.add( "vendCd"          ,itemsmsg[j].getVEND_CD().trim());      // Vendor Code  (거래처코드)
		            openApList.add( "vendNm"          ,itemsmsg[j].getVEND_NM().trim());      // Vendor Name  (거래처 이름)
		            openApList.add( "acctCd"          ,itemsmsg[j].getACCT_CD().trim());      // Account Code (계정코드)
		            openApList.add( "acctNm"          ,itemsmsg[j].getACCT_NM().trim());      // 계정이름
		            openApList.add( "postDate"        ,itemsmsg[j].getPOST_DATE().trim());    // Posting Date (전기일)
		            openApList.add( "amount"          ,itemsmsg[j].getAMOUNT().trim());       // AP Amount    (금액)
		            openApList.add( "currCd"          ,itemsmsg[j].getCURR_CD().trim());      // Currency     (통화코드)
		            openApList.add( "sapRequestNo"    ,"");                                   // Sap출금요청번호
		            openApList.add( "houseBank"       ,itemsmsg[j].getHOUSE_BANK().trim());   // 하우스뱅크
		            openApList.add( "sapStatus"       ,"");                                   // sap STATUS
		            openApList.add( "fiscalYear"      ,itemsmsg[j].getFISCAL_YEAR().trim());  // 회계년도 
		            openApList.add( "exchAmount"      ,itemsmsg[j].getEXCH_AMOUNT().trim());  // 환산금액
		            openApList.add( "exchCurrCd"      ,itemsmsg[j].getEXCH_CURR_CD().trim()); // 환산통화
		            openApList.add( "docDesc"         ,itemsmsg[j].getDESC().trim());         // 적요
		            openApList.add( "docDate"         ,itemsmsg[j].getDOC_DATE().trim());     // 생성일
		            openApList.add( "docType"         ,itemsmsg[j].getDOC_TYPE().trim());     // 전표종류
		            openApList.add( "paymentBlock"    ,itemsmsg[j].getSTATUS().trim());       // AP 전표의 출금요청상태
		            openApList.add( "personalId"      ,itemsmsg[j].getPERSONAL_ID().trim());  // 사용자 아이디
		            openApList.add( "attr1"           ,itemsmsg[j].getATTR01().trim());
		            openApList.add( "attr2"           ,itemsmsg[j].getATTR02().trim());
		            openApList.add( "attr3"           ,itemsmsg[j].getATTR03().trim());
		            openApList.add( "attr4"           ,itemsmsg[j].getATTR04().trim());
		            openApList.add( "attr5"           ,itemsmsg[j].getATTR05().trim());
		            openApList.add( "attr6"           ,itemsmsg[j].getATTR06().trim());
		            openApList.add( "attr7"           ,itemsmsg[j].getATTR07().trim());
		            openApList.add( "attr8"           ,itemsmsg[j].getATTR08().trim());
		            openApList.add( "attr9"           ,itemsmsg[j].getATTR09().trim());
		            openApList.add( "attr10"          ,itemsmsg[j].getATTR10().trim());
		            openApList.add( "baselineDate"    ,itemsmsg[j].getBASELINE_DATE().trim());
		            openApList.add( "paymentMethod"   ,itemsmsg[j].getPAYMENT_METHOD().trim());
		            openApList.add( "partnerBankType" ,itemsmsg[j].getPARTNER_BANK_TYPE().trim());
		            openApList.add( "exchRate"        ,itemsmsg[j].getEXCH_RATE().trim());
	            }
	             
         	}  
            	
         	rtn.add(resultMsg);
         	rtn.add(openApList);
            
		} catch(Exception e){
			e.getMessage();
			throw new LSysException(e.getMessage());
		}
		
		return rtn;
	}	
}
