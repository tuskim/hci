/*                                                                               
 *------------------------------------------------------------------------------ 
 * GMM03.java,v 1.0 2010/08/26                                          
 *                                                                               
 * PROJ : PT-PAM                                                                 
 * Copyright 2006-2007 LG CNS All rights reserved                                
 *------------------------------------------------------------------------------ 
 *                  변         경         사         항                          
 *------------------------------------------------------------------------------ 
 *   DATE       AUTHOR                      DESCRIPTION                          
 * -----------  ------  ---------------------------------------------------------
 * 2010/08/26   임민수   최초 프로그램 작성                                       
 *----------------------------------------------------------------------------   
 */   
 
package xi;                                                                                                      
                                    
import java.rmi.RemoteException;

import javax.xml.rpc.ServiceException;

import com.lgicorp.gims.sap.gmm03.GMM03_GIMS_DT;
import com.lgicorp.gims.sap.gmm03.GMM03_GIMS_DTZMMMT08;
import com.lgicorp.gims.sap.gmm03.GMM03_outBindingStub;
import com.lgicorp.gims.sap.gmm03.GMM03_outServiceLocator;
import comm.util.Util;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LSysException;
import devon.core.log.LLog;

public class GMM03 {         
   public LData GMM03_out(LMultiData inputMultiData, LData inputData) throws LSysException {  
       LLog.info.write("GMM03_out Service Start");
        
       Util util = new Util();
       LData resultMsg = new LData();
    
       GMM03_GIMS_DT  GMM03_DT   = new GMM03_GIMS_DT();
       
       //출고등록 Data
       LLog.info.write("Input Data : \n" + inputData);
       
       int dataCount = 0;
       for(int i=0; i<inputMultiData.getDataCount(); i++){
    	   if(inputMultiData.getString("chk", i).equals("T")){
    		   dataCount++;
    	   }
       }
       
           GMM03_GIMS_DTZMMMT08[] inputItems = new GMM03_GIMS_DTZMMMT08[dataCount];
           
           for (int i = 0; i < inputMultiData.getDataCount(); i++) {
        	   if(inputMultiData.getString("chk", i).equals("F"))
        		   continue;
        	   
        	   LData data = inputMultiData.getLData(i);       
        	   GMM03_GIMS_DTZMMMT08 item = new GMM03_GIMS_DTZMMMT08();

               item.setBUKRS    (util.nullToString(data.getString("companyCd")==null?inputData.getString("companyCd"):data.getString("companyCd")));      //Company Code                                                          
               item.setZMBLNR   (util.nullToString(data.getString("issueNo")));           //Issue No                                                         
               item.setMATNR   (util.nullToString(data.getString("materCd")));            //Material Code                                                         
               item.setZXMLDOCNO(util.nullToString(util.getPlainDateTime("yyyyMMddHHmmss")));     //Interface ID명 (YYYYMMDD24HHMISS)                                  
               item.setBLDAT    (util.nullToString(data.getString("issueDate")==null?inputData.getString("issueDate"):data.getString("issueDate")));        //Issue Date                                                         
               item.setBUDAT    (util.nullToString(data.getString("postingDate")==null?inputData.getString("postingDate"):data.getString("postingDate")));        //Posting Date                                                          
               item.setKOSTL   (util.nullToString(data.getString("costCenter")));          //CostCenter                                                     
               item.setWERKS    (util.nullToString(data.getString("plantCd")));        //Plant                                                                 
               item.setLGORT    (util.nullToString(data.getString("issueLoc")==null?inputData.getString("issueLoc"):data.getString("issueLoc")));        //Issue Location                                                      
               item.setERFMG    (util.nullToString(data.getString("issueQty")));        //Issue Qty                                                         
               item.setMVGR1 (util.nullToString(data.getString("areaCd")));      //Area    
               item.setMVGR2 (util.nullToString(data.getString("divCd")));        //Div    
               item.setMVGR3 (util.nullToString(data.getString("blockCd")));     //Block    
               item.setMVGR4 (util.nullToString(data.getString("blockCd2")));     //Block    
               item.setMVGR5 (util.nullToString(data.getString("yearCd")));      //Year    
               item.setGUBUN    (util.nullToString(data.getString("tmTbm")));   //Document No.(문서번호)                                                    
               item.setZFSTATUS    (util.nullToString(inputData.getString("status")));   // //STATUS(01. 출고등록, 02. SAP전송, 03.SAP전송완료, 04.취소요청, 05.취소완료, 99. 오류 )                                                    
               item.setMBLNR    (util.nullToString(data.getString("sapDocNo")));   //Document No.(문서번호)                                                    
               item.setATTR1    (util.nullToString(data.getString("attr1")));          //    
               item.setATTR2    (util.nullToString(data.getString("attr2")));          //    
               item.setATTR3    (util.nullToString(data.getString("attr3")));          //    
               item.setATTR4    (util.nullToString(data.getString("attr4")));          //    
               item.setATTR5    (util.nullToString(data.getString("attr5")));          //    
               item.setATTR6    (util.nullToString(data.getString("attr6")));          //    
               item.setATTR7    (util.nullToString(data.getString("attr7")));          //    
               item.setATTR8    (util.nullToString(data.getString("attr8")));          //    
               item.setATTR9    (util.nullToString(data.getString("attr9")));          //
               item.setATTR10    (util.nullToString(data.getString("attr10")));       //
               inputItems[i] = item;
               
           }

           //DT에 데이터 Setting                                                        
           GMM03_DT.setZMMMT08(inputItems);                              
           
           try{                                                                                                     
                                                                                                                 
                GMM03_outServiceLocator serviceLocator = new GMM03_outServiceLocator();                          
                                                                                                                 
                    serviceLocator.setGMM03_outPortEndpointAddress(util.getProp("EAI_HTTP_URL_PTPAM_GMM03_SAP"));
                                                                                                                 
                    GMM03_outBindingStub bindingStub = (GMM03_outBindingStub) serviceLocator.getGMM03_outPort(); 
                                                                                                                 
                       bindingStub.setUsername(util.getProp("EAI_USER"));                                        
                       bindingStub.setPassword(util.getProp("EAI_PWD"));                                         
                                                                                                      
                       //XI 전송 및 결과 Return                                                                       
                       LLog.debug.write("XI Connection try!!");                                                
                       bindingStub.GMM03_out(GMM03_DT);            // 비동기 이므로 리턴값은 없음                                             
                                                                                                                 
                                                                                                                 
            } catch(Exception e){
    			e.getMessage();
    			throw new LSysException(e.getMessage());
    		}                                                                                                
                                                                                                                 
        return resultMsg;                                                                                  
    }                                                                                                    
}                                                                                                     