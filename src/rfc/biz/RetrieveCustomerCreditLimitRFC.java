/*
 *------------------------------------------------------------------------------
 * RetrieveCustomerCreditLimitRFC.java,v 1.0  2015.11.16
 * 
 * PROJ : PT-PAM 
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2015.11.16   jwhan     C20151030_07129 여신한도관리 신규  
 *----------------------------------------------------------------------------
 */

package rfc.biz;

import java.util.Vector;


import rfc.entity.*;

import com.sap.mw.jco.JCO;
import comm.util.SAPWrap;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.log.LLog;
import devonframework.persistent.autodao.LCommonDao;

/**
 * UXPCardCancelRFC
 */
public class RetrieveCustomerCreditLimitRFC extends SAPWrap {

    private String functionName = "Z_SDM_GET_CREDIT_LIMIT";
    
    public String E_SUBRC; //결과 Flag

    /**
     *  여신 한도리스트 조회
     *  @param java.lang.String I_PLANT               Plant
     *  @param java.lang.String I_LOCATION        Storage Location
     *  @param java.lang.String I_DESCRIPTION  Material Description
     *  @return java.util.Vector
     */
    public LMultiData getVendorCreditLimit  (LData inputData) throws Exception {

    	System.out.println("getVendorCreditLimit  =--==-=-=-=-=   start  ");
    	
    	
        JCO.Client mConnection = null;
        LMultiData resultData = new LMultiData();
        LData rfcData;
        
        LLog.info.println(" getVendorCreditLimit =  "+inputData);
        
        String customerCd = inputData.getString("customerCd");
        String customerNm = inputData.getString("customer");
        String companyCd = inputData.getString("companyCd");
        
                
        try {
        	LLog.info.println("mConnection . getClient()");
            mConnection = getClient();
            LLog.info.println("11111111111111");
            JCO.Function function = createFunction(functionName);
            LLog.info.println("createFunction . function name = " + functionName );
            
            
            // #참고
            //setInput(function, plant, location, material);
            setInput(function, companyCd , customerCd);
            LLog.info.println("setInput");
            
            
            excute(mConnection, function);
            LLog.info.println("execute");
            
            
            //this.E_SUBRC = getField("E_SUBRC", function);
            
            Vector ret = getOutput(function); 
            LLog.debug.write("Vector ::" + ret);
            LLog.debug.write("Vector Count::" + ret.size());

            int cnt = ret==null? 0 : ret.size();
           
            for( int i = 0 ; i < cnt; i++ ) {
            	CustomerCreditLimitEntity entity = (CustomerCreditLimitEntity)ret.get(i);
            	
            	//SAP 에서 받아오는 데이터 셋팅
                LLog.debug.write("CompanyCd : " +  entity.getKKBER());
                LLog.debug.write("customerCd  : " + entity.getKUNNR());
                LLog.debug.write("NAME1  : " + entity.getNAME1());
                LLog.debug.write("AVAILABLE   : " + entity.getAVAILABLE());
                LLog.debug.write("CRDT_LIMT   : " + entity.getCRDT_LIMT());
                LLog.debug.write("EXPOSURE   : " + entity.getEXPOSURE());
                LLog.debug.write("SKFOR 채권   : " + entity.getSKFOR());
                LLog.debug.write("SSOBL 선수금   : " + entity.getSSOBL());
                LLog.debug.write("WAERS  currency  : " + entity.getWAERS());
                LLog.debug.write("open sales  : " + entity.getSALES_VALUE2());
                
                rfcData = new LData();
           	    
                rfcData.setString("CompanyCd", entity.getKKBER());
                rfcData.setString("customerCd", entity.getKUNNR());
                rfcData.setString("customerNm", entity.getNAME1());
                rfcData.setString("clAvailable",( entity.getAVAILABLE().replace(",", "")));
                rfcData.setString("cl",( entity.getCRDT_LIMT().replace(",", "")));
                rfcData.setString("clExposure",( entity.getEXPOSURE().replace(",", "")));
                rfcData.setString("SSOBL",( entity.getSSOBL().replace(",", "")));
                rfcData.setString("SKFOR",( entity.getSKFOR().replace(",", "")));
                rfcData.setString("WAERS",( entity.getWAERS().replace(",", "")));
                rfcData.setString("OPEN_SALES",( entity.getSALES_VALUE2().replace(",", "")));
                rfcData.setString("OPEN_SALES_WEB","0");
                rfcData.setString("DATAB",( entity.getDATAB().replace(",", "")));
                rfcData.setString("DATBI",( entity.getDATBI().replace(",", "")));
                
                
                resultData.addLData(rfcData);
            }
 
            LLog.debug.write("resultData ::" + resultData);

        } catch (Exception ex) {
        	LLog.debug.write(ex.getMessage());
        } finally {
            close(mConnection);
        }
        
        return resultData;
    }

    
    
    /**
     * RFC 실행전에 Import 값을 setting 한다.
     * com.sns.jdf.SAPWrap.excute(JCO.Client mConnection, JCO.Function function) 가 호출되기 전에 실행되어야하는 메소드
     * @param function com.sap.mw.jco.JCO.Function
     * @exception com.sns.jdf.GeneralException
     */
   
    private void setInput(JCO.Function function, String companyCd, String customerCd) throws Exception {
    	setField(function, "I_KKBER",    companyCd);
    	setField(function, "I_KUNNR",    customerCd);
    }
  
    private Vector getOutput(JCO.Function function) throws Exception {
        String entityName= "rfc.entity.CustomerCreditLimitEntity";
        
        
        String tableName = "ET_OUTTAB";
        return getTable(entityName,function,tableName);
    }
}