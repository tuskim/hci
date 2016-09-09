/*                                                                               
 *------------------------------------------------------------------------------ 
 * GMM01.java,v 1.0 2010/08/26                                          
 *                                                                               
 * PROJ : PT-PAM                                                                 
 * Copyright 2006-2007 LG CNS All rights reserved                                
 *------------------------------------------------------------------------------ 
 *                  변         경         사         항                          
 *------------------------------------------------------------------------------ 
 *   DATE       AUTHOR                      DESCRIPTION                          
 * -----------  ------  ---------------------------------------------------------
 * 2010/08/26   yrchoi   최초 프로그램 작성                                       
 *----------------------------------------------------------------------------   
 */   
 
package xi;                                                                                                      
                                    
import java.rmi.RemoteException;      
                                    
import javax.xml.rpc.ServiceException;

import com.lgicorp.gims.sap.gmm02.GMM02R_GIMS_DT;         
import com.lgicorp.gims.sap.gmm02.GMM02R_GIMS_DTZSAPMSG;  
import com.lgicorp.gims.sap.gmm02.GMM02_GIMS_DT;          
import com.lgicorp.gims.sap.gmm02.GMM02_GIMS_DTZMMMT006; 
import com.lgicorp.gims.sap.gmm02.GMM02_GIMS_DTZMMMT007; 
import com.lgicorp.gims.sap.gmm02.GMM02_outBindingStub;   
import com.lgicorp.gims.sap.gmm02.GMM02_outServiceLocator;

import comm.util.Util;                  
                                      
import devon.core.collection.LData;     
import devon.core.collection.LMultiData;
import devon.core.exception.LSysException;
import devon.core.log.LLog;    

public class GMM02 {         
   public LData GMM02_out(LData headerData, LMultiData bodyData) throws LSysException {  
       LLog.info.write("GMM02_out Service Start");
        
       Util util = new Util();
       LData resultMsg = new LData();
    
       GMM02_GIMS_DT  GMM02_DT   = new GMM02_GIMS_DT();
       GMM02R_GIMS_DT R_GMM02_DT = new GMM02R_GIMS_DT();
       
       //입고등록 Header
       LLog.info.write("Master : \n" + headerData);
       
           GMM02_GIMS_DTZMMMT006 headerItem = new GMM02_GIMS_DTZMMMT006();
           
           headerItem.setZXMLDOCNO(util.nullToString(headerData.getString("zxmldocno")));      //Interface ID명 (YYYYMMDD24HHMISS)                                  
           headerItem.setBUKRS    (util.nullToString(headerData.getString("companyCd")));      //Company Code                                                          
           headerItem.setZEBELN   (util.nullToString(headerData.getString("poNo")));           //WEB PO Number                                                         
           headerItem.setZGRSEQ   (util.nullToString(headerData.getString("recNo")));          //입고순번 ( 001, 002 )                                                     
           headerItem.setEBELN    (util.nullToString(headerData.getString("sapPoNo")));        //SAP PO Number                                                         
           headerItem.setBLDAT    (util.nullToString(headerData.getString("recDate")));        //Document Date                                                         
           headerItem.setBUDAT    (util.nullToString(headerData.getString("postDate")));       //Posting Date                                                          
           headerItem.setWERKS    (util.nullToString(headerData.getString("plantCd")));        //Plant                                                                 
           headerItem.setLGORT    (util.nullToString(headerData.getString("deliLoct")));       //Storage Location                                                      
           headerItem.setZFSTATUS (util.nullToString(headerData.getString("recStatus")));      //STATUS(01. 입고등록, 02. SAP전송, 03.SAP전송완료, 04.취소요청, 05.취소완료, 99. 오류 )    
           headerItem.setMBLNR    (util.nullToString(headerData.getString("sapReceiptNo")));   //Document No.(문서번호)                                                    
           headerItem.setATTR1    (util.nullToString(headerData.getString("attr1")));          //    
           headerItem.setATTR2    (util.nullToString(headerData.getString("attr2")));          //    
           headerItem.setATTR3    (util.nullToString(headerData.getString("attr3")));          //    
           headerItem.setATTR4    (util.nullToString(headerData.getString("attr4")));          //    
           headerItem.setATTR5    (util.nullToString(headerData.getString("attr5")));          //    
           headerItem.setATTR6    (util.nullToString(headerData.getString("attr6")));          //    
           headerItem.setATTR7    (util.nullToString(headerData.getString("attr7")));          //    
           headerItem.setATTR8    (util.nullToString(headerData.getString("attr8")));          //    
           headerItem.setATTR9    (util.nullToString(headerData.getString("attr9")));          //
           headerItem.setATTR10   (util.nullToString(headerData.getString("attr10")));        //
           
       //입고등록 Body                                                                                
       LLog.info.write("Body : \n" + bodyData);                  
       if(bodyData !=null){   // 취소할 떄는 Body가 필요 없음
           GMM02_GIMS_DTZMMMT007[] DTZMMMT007 = new GMM02_GIMS_DTZMMMT007[bodyData.getDataCount()];
                                                                                                   
           for (int j = 0; j < bodyData.getDataCount(); j++) {                                      
               LData bodyRowData = bodyData.getLData(j);                                              
               GMM02_GIMS_DTZMMMT007 bodyItem = new GMM02_GIMS_DTZMMMT007();                        
                                                                                                               
               bodyItem.setBUKRS  (util.nullToString(bodyRowData.getString("companyCd")));    //Company Code                       
               bodyItem.setZEBELN (util.nullToString(bodyRowData.getString("poNo")));         //WEB PO Number              
               bodyItem.setZGRSEQ (util.nullToString(headerData.getString("recNo")));         //입고순번 ( 001, 002 )          
               bodyItem.setEBELP  (util.nullToString(bodyRowData.getString("poSeq")));        //WEB PO SEQ ( 00010, 00020 )
               bodyItem.setMATNR  (util.nullToString(bodyRowData.getString("materCd")));      //Material Number            
               bodyItem.setERFMG  (util.nullToString(bodyRowData.getString("recQty")));       //Input Quantity             
               bodyItem.setATTR1  (util.nullToString(bodyRowData.getString("attr1")));        //
               bodyItem.setATTR2  (util.nullToString(bodyRowData.getString("attr2")));        //
               bodyItem.setATTR3  (util.nullToString(bodyRowData.getString("attr3")));        //
               bodyItem.setATTR4  (util.nullToString(bodyRowData.getString("attr4")));        //
               bodyItem.setATTR5  (util.nullToString(bodyRowData.getString("attr5")));        //
               bodyItem.setATTR6  (util.nullToString(bodyRowData.getString("attr6")));        //
               bodyItem.setATTR7  (util.nullToString(bodyRowData.getString("attr7")));        //
               bodyItem.setATTR8  (util.nullToString(bodyRowData.getString("attr8")));        //
               bodyItem.setATTR9  (util.nullToString(bodyRowData.getString("attr9")));        //
               bodyItem.setATTR10 (util.nullToString(bodyRowData.getString("attr10")));       //
               
               DTZMMMT007[j] = bodyItem;
           }
           GMM02_DT.setZMMMT007(DTZMMMT007);   
       }
       
           //DT에 header 및 boby 데이터 Setting                                                        
           GMM02_DT.setZMMMT006(headerItem);                              
                                       
                                                                              
           //Return Msg                                                    
           GMM02R_GIMS_DTZSAPMSG zsapmsg = new GMM02R_GIMS_DTZSAPMSG(); 
           
           try{                                                                                                     
                                                                                                                 
                GMM02_outServiceLocator serviceLocator = new GMM02_outServiceLocator();                          
                                                                                                                 
                    serviceLocator.setGMM02_outPortEndpointAddress(util.getProp("EAI_HTTP_URL_PTPAM_GMM02_SAP"));
                                                                                                                 
                    GMM02_outBindingStub bindingStub = (GMM02_outBindingStub) serviceLocator.getGMM02_outPort(); 
                                                                                                                 
                       bindingStub.setUsername(util.getProp("EAI_USER"));                                        
                       bindingStub.setPassword(util.getProp("EAI_PWD"));                                         
                                                                                                      
                       //XI 전송 및 결과 Return                                                                       
                       LLog.info.println("XI Connection try!!");                                                
                       R_GMM02_DT = bindingStub.GMM02_out(GMM02_DT);                                             
                                                                                                                 
                       zsapmsg = R_GMM02_DT.getZSAPMSG();             
                                                                                                                 
                       LLog.info.write("GMM02 zsapmsg.getMTYPE() :: " + zsapmsg.getMTYPE());               
                       LLog.info.write("GMM02 zsapmsg.getMTEXT() :: " + zsapmsg.getMTEXT());                 
                       LLog.info.write("GMM02 zsapmsg.getMBLNR() :: " + zsapmsg.getMBLNR());                     
                                                                                                                 
                       resultMsg.setString("returnStatus", zsapmsg.getMTYPE());                               
                       resultMsg.setString("returnMsg", zsapmsg.getMTEXT());                                   
                       resultMsg.setString("returnSapSeq", zsapmsg.getMBLNR());                                  
                                                                                                                 
                                                                                                                 
            } catch(Exception e){
    			e.getMessage();
    			throw new LSysException(e.getMessage());
    		}                                                                                          
                                                                                                                 
        return resultMsg;                                                                                  
    }                                                                                                    
}                                                                                                     