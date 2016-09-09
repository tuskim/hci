/*
 *------------------------------------------------------------------------------
 * RetrieveCurrentStockRFC.java,v 1.0 2010/08/06 14:43:35 
 * 
 * PROJ : PT-PAM 
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2010/08/06   hskim   Init
 *----------------------------------------------------------------------------
 */

package rfc.biz;

import java.util.Vector;

import rfc.entity.CurrentStockEntity;

import com.sap.mw.jco.JCO;
import comm.util.SAPWrap;
import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.log.LLog;
import devonframework.persistent.autodao.LCommonDao;

/**
 * UXPCardCancelRFC
 */
public class RetrieveCurrentStockRFC extends SAPWrap {

    private String functionName = "Z_MM_CURRENT_STOCK";
    
    public String E_SUBRC; //결과 Flag

    /**
     *  재고현황 조회
     *  @param java.lang.String I_PLANT               Plant
     *  @param java.lang.String I_LOCATION        Storage Location
     *  @param java.lang.String I_DESCRIPTION  Material Description
     *  @return java.util.Vector
     */
    public LMultiData getStockList(LData inputData) throws Exception {

        JCO.Client mConnection = null;
        LMultiData resultData = new LMultiData();
        LData rfcData; 
        String plant = inputData.getString("plant");
        String location = inputData.getString("location");
        String material = inputData.getString("material");

        try {
            mConnection = getClient();

            JCO.Function function = createFunction(functionName);

            setInput(function, plant, location, material);
            
            excute(mConnection, function);

            //this.E_SUBRC = getField("E_SUBRC", function);
            
            Vector ret = getOutput(function); 
            LLog.debug.write("Vector ::" + ret);
            LLog.debug.write("Vector Count::" + ret.size());

            int cnt = ret==null? 0 : ret.size();
           
            for( int i = 0 ; i < cnt; i++ ) {
            	CurrentStockEntity stock = (CurrentStockEntity)ret.get(i);
            	
                LLog.debug.write("MATNR : " +  stock.getMATNR());
                LLog.debug.write("MAKTX  : " + stock.getMAKTX());
                LLog.debug.write("MEINS  : " + stock.getMEINS());
                LLog.debug.write("LABST   : " + stock.getLABST());
                
                rfcData = new LData();
            	
            	rfcData.setString("MATNR", stock.getMATNR());		//자재코드
            	rfcData.setString("MAKTX", stock.getMAKTX());		//자재명
            	rfcData.setString("MEINS", stock.getMEINS());		//단위
            	rfcData.setString("LABST", stock.getLABST());		//현재고
                
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

    
    /*
     * Moving Qty 추가함
     * 
     */
    public LMultiData getStockMoveList_New(LData inputData) throws Exception {
    	LLog.info.println("              getStockMoveList_New in ");
        JCO.Client mConnection = null;
        LMultiData resultData = new LMultiData();
        LData sapInfoData;

        String getMessage = "";

        // plant값을 DB에서 가져오기
        LCommonDao dao = new LCommonDao("/po/is/stockMoveSql/retrievePlantCode", inputData);
        LData result_plant = dao.executeQueryForSingle();

        String plant 	= result_plant.getString("plantCode");
        String issueLoc = inputData.getString("issueLoc");
        String materCd  = inputData.getString("materCd");

        LLog.debug.write("plant : " +  plant);
        
        try {
        	LLog.info.println("12121212");
            mConnection = getClient();
            LLog.info.println("getClient");
            JCO.Function function = createFunction(functionName);
            LLog.info.println("createFunction");
            setInput(function, plant, issueLoc, materCd);
            LLog.info.println("setInput");
            excute(mConnection, function);
            LLog.info.println("excute");
            Vector ret = getOutput(function);
            
            LLog.debug.write("Vector ::" + ret);
            LLog.debug.write("Vector Count::" + ret.size());
        
            

            
            
            int cnt = ret==null? 0 : ret.size();
           
            for( int i = 0 ; i < cnt; i++ ) {
 
            	CurrentStockEntity stock = (CurrentStockEntity)ret.get(i);
            	
                sapInfoData = new LData();
                sapInfoData.setString("companyCd", 	"");		//자재코드
                sapInfoData.setString("userId", 	"");		//자재명
                sapInfoData.setString("tranNo", 	"");		//단위
                sapInfoData.setString("materCd", 	stock.getMATNR());		//자재코드
                sapInfoData.setString("materNm", 	stock.getMAKTX());		//자재명
                sapInfoData.setString("unit", 		stock.getMEINS());		//단위
                sapInfoData.setString("remainQty", 	stock.getLABST());		//현재고
                sapInfoData.setDouble("movingQty", 	0.0);					//이동재고		
                sapInfoData.setString("tranQty", 	"0");					//출고잔량
                
                resultData.addLData(sapInfoData);
            }

            // Moving 중인 Material Qty 가져옴 
            dao = new LCommonDao("/po/is/stockMoveSql/retrieveMovingMaterialQty", inputData);
            LMultiData materialQtyList = dao.executeQuery();

            for(int j=0; j<materialQtyList.getDataCount(); j++){
            	for(int k=0; k<resultData.getDataCount(); k++){
            		if(materialQtyList.getString("materCd", j).equals(resultData.getString("materCd", k))){
            			resultData.modifyDouble("movingQty", k, resultData.getDouble("movingQty", k ) + materialQtyList.getDouble("requestMoveQty",j));
            			break;
            		}
            	}
            }
            
            LLog.debug.write("result :: " + resultData);

        } catch (Exception ex) {
			getMessage   = ex.getMessage();
			LLog.err.write(this.getClass().getName()+"."+"RetrieveCurrentStockRFC()"+"=>" + getMessage);
        } finally {
            close(mConnection);
        }
        LLog.info.println("              getStockMoveList_New end ");
        return resultData;
    }
    
    
    
    /**
     *  재고현황 조회
     *  @param java.lang.String I_PLANT               Plant
     *  @param java.lang.String I_LOCATION        Storage Location
     *  @param java.lang.String I_DESCRIPTION  Material Description
     *  @return java.util.Vector
     */
    public LMultiData retrieveStockList(LData inputData, LMultiData p_resultTmp) throws Exception {

        JCO.Client mConnection = null;
        LMultiData resultData = new LMultiData();
        LData rfcData; 
        String plant = inputData.getString("plantCd");
        String location = inputData.getString("storageCd");
        String material = "";

        try {
            mConnection = getClient();

            JCO.Function function = createFunction(functionName);

            setInput(function, plant, location, material);
            
            excute(mConnection, function);

            //this.E_SUBRC = getField("E_SUBRC", function);
            
            Vector ret = getOutput(function);
            
            LLog.debug.write("Vector ::" + ret);
            LLog.debug.write("Vector Count::" + ret.size());

            int cnt = ret==null? 0 : ret.size();
           
            for( int i = 0 ; i < cnt; i++ ) {
            	CurrentStockEntity stock = (CurrentStockEntity)ret.get(i);
            	
                LLog.debug.write("MATNR : " +  stock.getMATNR());
                LLog.debug.write("MAKTX  : " + stock.getMAKTX());
                LLog.debug.write("MEINS  : " + stock.getMEINS());
                LLog.debug.write("LABST   : " + stock.getLABST());
                
                rfcData = new LData();
            	
            	rfcData.setString("MATNR", stock.getMATNR());		//자재코드
            	rfcData.setString("MAKTX", stock.getMAKTX());		//자재명
            	rfcData.setString("MEINS", stock.getMEINS());		//단위
            	rfcData.setString("LABST", stock.getLABST());		//현재고
                
                resultData.addLData(rfcData);
            }
            for(int i = 0 ; i < p_resultTmp.getDataCount() ; i++){
            	for(int j = 0 ; j < resultData.getDataCount() ; j++){
            		LLog.debug.write(p_resultTmp.get("materCd",i)+"     :      "+resultData.get("MATNR",j));
            		if(p_resultTmp.get("materCd",i).equals(resultData.get("MATNR",j))){
            			p_resultTmp.modify("currentQty", i, resultData.get("LABST",j));
            		}
            	}
            
            }
            	
            
            
            LLog.debug.write("p_resultTmp ::" + p_resultTmp);

        } catch (Exception ex) {
        	 LLog.debug.write(ex.getMessage());
        } finally {
            close(mConnection);
        }
        
        return p_resultTmp;
    }    
    
    /**
     *  재고자산 출고용 재고현황 조회
     *  @param java.lang.String I_PLANT               Plant
     *  @param java.lang.String I_LOCATION        Storage Location
     *  @param java.lang.String I_DESCRIPTION  Material Description
     *  @return java.util.Vector
     */
    public LMultiData getStockIssueList(LData inputData) throws Exception {

        JCO.Client mConnection = null;
        LMultiData resultData = new LMultiData();
        LData rfcData;
        
        // plant값을 DB에서 가져오기
        LCommonDao dao = new LCommonDao("/po/is/stockIssueSql/retrievePlant", inputData);
        LData result_plant = dao.executeQueryForSingle();
        
        String plant = result_plant.getString("plant");
        String location = inputData.getString("issue_loc");
        String material = inputData.getString("materCd");

        try {
            mConnection = getClient();

            JCO.Function function = createFunction(functionName);

            setInput(function, plant, location, material);
            
            excute(mConnection, function);

            //this.E_SUBRC = getField("E_SUBRC", function);
            
            Vector ret = getOutput(function);
            
            LLog.debug.write("Vector ::" + ret);
            LLog.debug.write("Vector Count::" + ret.size());

            int cnt = ret==null? 0 : ret.size();
           
            for( int i = 0 ; i < cnt; i++ ) {
            	CurrentStockEntity stock = (CurrentStockEntity)ret.get(i);
            	
                LLog.debug.write("MATNR : " +  stock.getMATNR());
                LLog.debug.write("MAKTX  : " + stock.getMAKTX());
                LLog.debug.write("MEINS  : " + stock.getMEINS());
                LLog.debug.write("LABST   : " + stock.getLABST());
                
                rfcData = new LData();
            	
            	rfcData.setString("materCd", stock.getMATNR());		//자재코드
            	rfcData.setString("MAKTX", stock.getMAKTX());		//자재명
            	rfcData.setString("MEINS", stock.getMEINS());		//단위
            	rfcData.setString("LABST", stock.getLABST());		//현재고
            	
            	//그리드 입력용
            	rfcData.setString("issueQty", "0");
            	rfcData.setString("desc", "");
            	rfcData.setString("areaCd", "");
            	rfcData.setString("divCd", "");
            	rfcData.setString("blockCd", "");
            	rfcData.setString("blockCd2", "");
            	rfcData.setString("yearCd", "");
            	rfcData.setString("tmTbm", "");
            	rfcData.setString("issueType", "");
            	rfcData.setString("costCenter", "");
            	rfcData.setString("attr1", "");
            	rfcData.setString("attr2", "");
            	rfcData.setString("chk", "F");
                
                resultData.addLData(rfcData);
            }
            
            LLog.debug.write("result ::" + resultData);

        } catch (Exception ex) {
        	 LLog.debug.write(ex.getMessage());
        } finally {
            close(mConnection);
        }
        
        return resultData;
    }
    
    
    
    
    
    
    /**
     *  재고자산 이동용 재고현황 조회
     *  @param java.lang.String I_PLANT               Plant
     *  @param java.lang.String I_LOCATION        Storage Location
     *  @param java.lang.String I_DESCRIPTION  Material Description
     *  @return java.util.Vector
     */
    public LMultiData getStockMoveList(LData inputData) throws Exception {

        JCO.Client mConnection = null;
        LMultiData resultData = new LMultiData();
        LData sapInfoData;

        String getMessage = "";

        // plant값을 DB에서 가져오기
        LCommonDao dao = new LCommonDao("/po/is/stockMoveSql/retrievePlantCode", inputData);
        LData result_plant = dao.executeQueryForSingle();

        String plant 	= result_plant.getString("plantCode");
        String issueLoc = inputData.getString("issueLoc");
        String materCd  = inputData.getString("materCd");

        LLog.debug.write("plant : " +  plant);
        
        try {
            mConnection = getClient();

            JCO.Function function = createFunction(functionName);

            setInput(function, plant, issueLoc, materCd);
            
            excute(mConnection, function);

            Vector ret = getOutput(function);
            
            LLog.debug.write("Vector ::" + ret);
            LLog.debug.write("Vector Count::" + ret.size());

            int cnt = ret==null? 0 : ret.size();
           
            for( int i = 0 ; i < cnt; i++ ) {
 
            	CurrentStockEntity stock = (CurrentStockEntity)ret.get(i);
            	
                sapInfoData = new LData();
                sapInfoData.setString("companyCd", 	"");		//자재코드
                sapInfoData.setString("userId", 	"");		//자재명
                sapInfoData.setString("tranNo", 	"");		//단위
                sapInfoData.setString("materCd", 	stock.getMATNR());		//자재코드
                sapInfoData.setString("materNm", 	stock.getMAKTX());		//자재명
                sapInfoData.setString("unit", 		stock.getMEINS());		//단위
                sapInfoData.setString("stockQty", 	stock.getLABST());		//현재고
                sapInfoData.setString("tranQty", 	"0");					//이동재고		
                sapInfoData.setString("remainQty", 	"0");					//출고잔량
                
                resultData.addLData(sapInfoData);
            }
            
            LLog.debug.write("result :: " + resultData);

        } catch (Exception ex) {
			getMessage   = ex.getMessage();
			LLog.err.write(this.getClass().getName()+"."+"RetrieveCurrentStockRFC()"+"=>" + getMessage);
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
   
    private void setInput(JCO.Function function, String I_PALNT, String I_LOCATION, String  I_MATERIAL) throws Exception {
    	setField(function, "I_PLANT",    I_PALNT);
    	setField(function, "I_LOCATION",    I_LOCATION);
    	setField(function, "I_MATERIAL",    I_MATERIAL);
    }
  
    private Vector getOutput(JCO.Function function) throws Exception {
        String entityName= "rfc.entity.CurrentStockEntity";
        String tableName = "ET_OUTTAB";
        return getTable(entityName,function,tableName);
    }
}