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
 
import com.lgicorp.gims.sap.gfi05.*;

import comm.util.Util;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LSysException;
import devon.core.log.LLog; 

public class GFI05 {
	
	public Vector GFI05_out(LData xmlDocNo, LData inputData, LMultiData inputMulit) throws LSysException {
		
		LLog.info.write("GFI05_out Service Start");
		
		Util util = new Util();
		LData resultMsg = new LData();

		GFI05_GIMS_DT GFI05_DT = new GFI05_GIMS_DT();
		GFI05R_GIMS_DT R_GFI05_DT = new GFI05R_GIMS_DT();
				
		//총계정원가 Header
		LLog.info.write("inputData : \n" + inputData);  	
		GFI05_GIMS_DTHEADER[]  GFI05HD = new GFI05_GIMS_DTHEADER[inputMulit.getDataCount()]; 
		for(int i=0; i<inputMulit.getDataCount();i++){
			GFI05_GIMS_DTHEADER  GFI05DTS = new GFI05_GIMS_DTHEADER();
			 
			GFI05DTS.setZXMLDOCNO(util.nullToString(xmlDocNo.getString("zxmldocno"))); 
			GFI05DTS.setBUKRS(util.nullToString(inputData.getString("companyCd"))); 
			GFI05DTS.setGJAHR(util.nullToString(inputMulit.getLData(i).getString("fiscalYear")));
			GFI05DTS.setBELNR(util.nullToString(inputMulit.getLData(i).getString("docNo")));	//1400000003
			//GFI05DTS.setBELNR(util.nullToString("1400000003"));
			GFI05HD[i]=GFI05DTS;
		}
		
		GFI05_DT.setHEADER(GFI05HD); 
		GFI05R_GIMS_DTZSAPMSG zsapmsg = new GFI05R_GIMS_DTZSAPMSG();  	
 
		Vector rtn = new Vector();
		try{
			
			GFI05_outServiceLocator serviceLocator = new GFI05_outServiceLocator();
 
			LLog.debug.write(util.getProp("EAI_HTTP_URL_PTPAM_GFI05_SAP"));
 
	        serviceLocator.setGFI05_outPortEndpointAddress(util.getProp("EAI_HTTP_URL_PTPAM_GFI05_SAP"));
 
	        GFI05_outBindingStub bindingStub = (GFI05_outBindingStub) serviceLocator.getGFI05_outPort();
  
            bindingStub.setUsername(util.getProp("EAI_USER"));
            bindingStub.setPassword(util.getProp("EAI_PWD"));

            //XI 전송 및 결과 Return
            LLog.debug.write("XI Connection try!!");
            R_GFI05_DT = bindingStub.GFI05_out(GFI05_DT);
    
            zsapmsg = R_GFI05_DT.getZSAPMSG(); 
             
            GFI05R_GIMS_DTITEM[] itemsmsg = R_GFI05_DT.getITEM(); 
            LLog.info.write("GFI05 zsapmsg.getMTYPE() :: " + zsapmsg.getMTYPE());
            LLog.info.write("GFI05 zsapmsg.getMTEXT() :: " + zsapmsg.getMTEXT());
 
            resultMsg.setString("returnType", zsapmsg.getMTYPE());
            resultMsg.setString("returnText", zsapmsg.getMTEXT()); 
            LMultiData itemResultMsg = new LMultiData();   
            LMultiData itemTotal = new LMultiData();   
            if(itemsmsg!=null){     
	            for(int j=0; j<itemsmsg.length;j++){ 
	            	String[] strList=itemsmsg[j].getGFIMQ().split("\\^",38); 
	            	/*for(int v=0;v<strList.length;v++){
	            		System.out.println("strList["+v+"]==>"+strList[v]);
	            	}*/
	            	 
	        		itemResultMsg.add( "chk"             ,"0" ); //
	        		itemResultMsg.add( "companyCd"       ,strList[0].trim()  ); //BUKRS
		            itemResultMsg.add( "fiscalYear"      ,strList[1].trim()  ); //GJAHR
		            itemResultMsg.add( "docNo"           ,strList[2].trim()  ); //BELNR
		            itemResultMsg.add( "docType"         ,strList[3].trim()  ); //BLART 헤더
		            itemResultMsg.add( "docTypeDec"      ,strList[4].trim()  ); //BLART_Des
		            itemResultMsg.add( "curr"            ,strList[5].trim()  ); //WAERS
		            itemResultMsg.add( "totLineItem"     ,strList[6].trim()  ); //BUZEI_Total
		            if(strList[7].trim().equals("00000000")){
		            	itemResultMsg.add( "docDate"         ,""); //BLDAT
		            }else{
		            	itemResultMsg.add( "docDate"         ,strList[7].trim() ); //BLDAT		            	
		            }
		            if(strList[8].trim().equals("00000000")){
		            	itemResultMsg.add( "postDate"         ,""); //BUDAT
		            }else{
		            	itemResultMsg.add( "postDate"         ,strList[8].trim() ); //BUDAT
		            }	 			             
		            itemResultMsg.add( "reverseWith"     ,strList[9].trim()  ); //STBLG
		            itemResultMsg.add( "lineItemCnt"     ,strList[10].trim()  ); //BUZEI_1
		            itemResultMsg.add( "postKey"         ,strList[11].trim() ); //BSCHL
		            itemResultMsg.add( "indicator"       ,strList[12].trim() ); //SHKZG
		            itemResultMsg.add( "glAccount"       ,strList[13].trim() ); //HKONT
		            itemResultMsg.add( "glAccountDec"    ,strList[14].trim() ); //HKONT_Des
		            itemResultMsg.add( "customer"        ,strList[15].trim() ); //KUNNR
	        		itemResultMsg.add( "customerDec"     ,strList[16].trim() ); //KUNNR_Des
		            itemResultMsg.add( "vendor"          ,strList[17].trim() ); //LIFNR
		            itemResultMsg.add( "vendorDec"       ,strList[18].trim() ); //LIFNR_Des
		            itemResultMsg.add( "taxCd"           ,strList[19].trim() ); //MWSKZ
		            itemResultMsg.add( "taxCdDec"        ,strList[20].trim() ); //MWSKZ_Des
		            itemResultMsg.add( "profitCenter"    ,strList[21].trim() ); //PRCTR
		            itemResultMsg.add( "profitCenterDec" ,strList[22].trim() ); //PRCTR_Des
		            if(strList[23].trim().equals("00000000")){
		            	itemResultMsg.add( "baselineDate"         ,""); //ZFBDT_due
		            }else{
		            	itemResultMsg.add( "baselineDate"         ,strList[23].trim() ); //ZFBDT
		            }		              
		            if(strList[24].trim().equals("00000000")){
		            	itemResultMsg.add( "dueDate"         ,""); //ZFBDT_due
		            }else{
		            	itemResultMsg.add( "dueDate"         ,strList[24].trim() ); //ZFBDT_due
		            }
		            
		            itemResultMsg.add( "costCenter"      ,strList[25].trim() ); //KOSTL
		            itemResultMsg.add( "interOrder"      ,strList[26].trim() ); //AUFNR
		            itemResultMsg.add( "materialNo"      ,strList[27].trim() ); //MATNR
		            itemResultMsg.add( "qty"             ,strList[28].replaceAll("\\,","").trim() ); //MENGE
		            itemResultMsg.add( "unit"            ,strList[29].trim() ); //MEINS
	        	    itemResultMsg.add( "docAmt"          ,strList[30].trim() ); //WRBTE
		            itemResultMsg.add( "localAmt"        ,strList[31].replaceAll("\\,","").trim() ); //DMBTR
		            itemResultMsg.add( "text"            ,strList[32].trim() ); //SGTXT
		            itemResultMsg.add( "poNo"            ,strList[33].trim() ); //XREF1
		            itemResultMsg.add( "soNo"            ,strList[34].trim() ); //XREF2
		            itemResultMsg.add( "type"            ,strList[35].trim() ); //XREF3
		            itemResultMsg.add( "assign"          ,strList[36].trim() ); //ZOUNR 
		            itemResultMsg.add( "webDoc"          ,strList[37].trim() ); //DOCSQ 
		            
		            //헤더
		            itemResultMsg.add( "userId"          ,inputData.getString("userId") ); //user-id
		            itemResultMsg.add( "runDate"         ,xmlDocNo.getString("transDate") ); //run date
		            itemResultMsg.add( "runTime"         ,xmlDocNo.getString("transTime") ); //runt type  
		            itemResultMsg.add( "deptCd"            ,inputData.getString("deptCd") ); //dept
		            itemResultMsg.add( "userNm"          ,"["+inputData.getString("userNm")+"]" ); //dept
		            
		            //재정의 
		            if(strList[15].trim().equals("")&&strList[16].trim().equals("")){
		            	itemResultMsg.add( "cVendorCustomer"          ,strList[17].trim()+" "+strList[18].trim() );//LIFNR LIFNR_Des
		            }else{
		            	itemResultMsg.add( "cVendorCustomer"          ,strList[15].trim()+" "+strList[16].trim() );//KUNNR KUNNR_Des
		            } 
		            
		            itemResultMsg.add( "cProfitCenter"    ,strList[21].trim()+" "+strList[22].trim() ); //PRCTR PRCTR_Des	  
		            itemResultMsg.add( "cTaxCd"    ,strList[19].trim()+" "+strList[20].trim() ); //MWSKZ MWSKZ_Des	
 
		            //재정의 
		            if(strList[12].equals("S")){
		            	//차변
		            	itemResultMsg.add( "dLocalAmt"        ,strList[31].trim() );//DMBTR
		            	
		            	if (strList[31].trim().replaceAll("\\,","").trim().equals("")) {
		            		itemResultMsg.add( "dTotLocalAmt"        ,"0" );
		            	} else {
		            		itemResultMsg.add( "dTotLocalAmt"        ,strList[31].trim().replaceAll("\\,","").trim() );//DMBTR //LIst 모드 총합
		            	}
		            	
		            	itemResultMsg.add( "cLocalAmt"        ,"");//DMBTR
		            	itemResultMsg.add( "cTotLocalAmt"        ,"0");//DMBTR //LIst 모드 총합
			            itemResultMsg.add( "dGlAccount"       ,strList[13].trim()); //HKONT
			            itemResultMsg.add( "dGlAccountDec"    ,strList[14].trim()); //HKONT_Des
			            itemResultMsg.add( "cGlAccount"       ,""); //HKONT
			            itemResultMsg.add( "cGlAccountDec"    ,""); //HKONT_Des	
		            }else{
		            	//대변 
		            	itemResultMsg.add( "dLocalAmt"        ,"");//DMBTR 
		            	itemResultMsg.add( "dTotLocalAmt"        ,"0" );//DMBTR//LIst 모드 총합
		            	itemResultMsg.add( "cLocalAmt"        ,strList[31].trim() );//DMBTR
		            	itemResultMsg.add( "cTotLocalAmt"        ,null2zero(strList[31].trim().replaceAll("\\,","").trim())) ;//DMBTR//LIst 모드 총합
			            itemResultMsg.add( "dGlAccount"       ,""); //HKONT
			            itemResultMsg.add( "dGlAccountDec"    ,""); //HKONT_Des	
			            itemResultMsg.add( "cGlAccount"       ,strList[13].trim()); //HKONT
			            itemResultMsg.add( "cGlAccountDec"    ,strList[14].trim()); //HKONT_Des				            
		            } 	
		            itemResultMsg.add( "cDocType"          ,strList[3].trim()+" "+strList[4].trim() );//BLART BLART_Des
		            itemResultMsg.add("totDocQty", "0"); 
		            itemResultMsg.add("totLiqty", "0"); 
		            itemResultMsg.add("debitQty", "0"); 
		            itemResultMsg.add("creditQty", "0"); 
		            itemResultMsg.add("totAmt", "0"); 
	            } 
            }   
            
            //LI COUNT 및 TOTAL AMT
            for(int k=0;k<itemResultMsg.getDataCount();k++){ 
            	double dTotal=0; //TOTAL Debit  AMT
            	double cTotal=0; //TOTAL Crebit AMT 
            	double dLiQty=0; //LI COUNT
            	for(int kk=0;kk<itemResultMsg.getDataCount();kk++){ 
            		
            		//if(k!=kk){
    	            	if(itemResultMsg.get("docNo", k).equals(itemResultMsg.get("docNo", kk))){
    	            		 
    	            			
    	            		if(itemResultMsg.get("indicator",kk).equals("S")){
    	            			
    	            			dTotal = dTotal + Double.parseDouble(null2zero(itemResultMsg.get("localAmt", kk)).toString());
    	              
    	            		}else if(itemResultMsg.get("indicator",kk).equals("H")){
    	            			cTotal = cTotal +  Double.parseDouble(null2zero(itemResultMsg.get("localAmt", kk)).toString());
    	            		}
    	            		dLiQty++;   
    	            		//LLog.info.write("\n dLiQty --> "+dLiQty);
    	            	}   	
            		//}
	            	

            	} 
            	itemResultMsg.modifyDouble("totLiqty",k, dLiQty);
            	itemResultMsg.modifyDouble("totAmt",k, dTotal);
            	//Page모드일때만 사용
            	itemResultMsg.modifyDouble("debitQty",k, dTotal);
            	itemResultMsg.modifyDouble("creditQty",k, cTotal);
            	
            	if(k!=itemResultMsg.getDataCount()-1){
	            	if(itemResultMsg.get("docNo", k).equals(itemResultMsg.get("docNo", k+1))){
	            		itemTotal.add("docNo",itemResultMsg.get("docNo", k));
	            	}
            	}
            	 
            } 
            
            for(int xx=0;xx<itemResultMsg.getDataCount();xx++){ 
            	itemResultMsg.modifyLong("totDocQty",xx, itemTotal.getDataCount());
            }
            // totAmt 값 세팅
 
            /*
            for(int t=0;t<itemResultMsg.getDataCount();t++){
            	itemResultMsg.modifyString("lResult", t, itemResultMsg.get("postDate", t)+"\n\n"
            			            +"\n\n"
            			            +itemResultMsg.get("postDate", t)+"\n\n");  
            	itemResultMsg.modifyString("rResult", t,itemResultMsg.getDouble("totLineItem", t)+"\n\n"
			            +itemResultMsg.get("docNo", t)+"\n\n"
			            +itemResultMsg.get("reverseWith", t)+"\n\n");       	            	
            }            
            */
            
            /*
            for (int cnt = 0; cnt < itemResultMsg.getDataCount(); cnt++) {
            	if (itemResultMsg.getString("cTotLocalAmt", cnt) == null ) {
            		System.out.println("123");
            		itemResultMsg.modifyDouble("cTotLocalAmt", cnt, 0);
            	}
            }
            */
            
            System.out.println(itemResultMsg);
            
            rtn.add(resultMsg);
            rtn.add(itemResultMsg);
		} catch(Exception e){
			e.getMessage();
			throw new LSysException(e.getMessage());
		}
		
		return rtn;
	}	
	public String lPad(String s, int size, String txt){
		int len = size - s.length();

		if (len <= 0) return s;

		String tmp = "";

		for (int i = 0; i < len; i++)
			tmp += txt;

		return tmp + s;
	}	
	/****************************************************************************************
	 * 문자열의 좌변에 지정된 문자열을 원하는 지정된 길이이만큼 붙여준다 ("123", 5, "0"  --> "00123")
	 *****************************************************************************************/	
	public String rPad(String s, int size, String txt){
		int len = size - s.length();

		if (len <= 0) return s;

		String tmp = s;

		for (int i = 0; i < len; i++)
			tmp += txt;

		return tmp;
	}	
	
	/****************************************************************************************
	 * 문자열의 좌변에 지정된 문자열을 원하는 지정된 길이이만큼 붙여준다 ("123", 5, "0"  --> "00123")
	 *****************************************************************************************/	
	public Object null2zero(Object str){
		Object ret = null;
		
		if (str == null || str.toString().trim().equals("")) {
			ret =  "0.0";
			return ret;
		}
		return str;
	}
}
