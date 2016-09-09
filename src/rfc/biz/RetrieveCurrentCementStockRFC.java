/*
 *------------------------------------------------------------------------------
 * RetrieveCurrentCementStockRFC.java,v 1.0 2016/08/02
 * 
 * PROJ : HCI 프로젝트
 * Copyright 2006-2016 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2016.08.02   hskim    Init
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


public class RetrieveCurrentCementStockRFC extends SAPWrap {

    private String functionName = "Z_MM_CURRENT_STOCK";
    
    public String E_SUBRC; //결과 Flag

    /**
     *  Cement 재고자산 재고현황 조회
     *  @param java.lang.String I_PLANT               Plant
     *  @param java.lang.String I_LOCATION        Storage Location
     *  @param java.lang.String I_DESCRIPTION  Material Description
     *  @return java.util.Vector
     */
    public LMultiData getCementStockList(LData inputData, LMultiData resultTemp) throws Exception {

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
            	for (int modelCnt = 0; modelCnt < resultTemp.getDataCount(); modelCnt++) {
            		if ( stock.getMATNR().equals(resultTemp.getString("materCd", modelCnt))) {
		            	rfcData.setString("materCd", stock.getMATNR());		//자재코드
		            	rfcData.setString("materNm", stock.getMAKTX());		//자재명
		            	rfcData.setString("currentQty", stock.getLABST());		//현재고
		            	rfcData.setString("unit", stock.getMEINS());		//단위
	           	
		            	//그리드 입력용
		            	//rfcData.setString("modelNm", "");
		            	//rfcData.setString("materType", "");
		            	//rfcData.setString("actvCd", "");
		            	//rfcData.setString("actvType", "F");
            			if(resultTemp.getString("unitPrice", modelCnt) != null || !"".equals(resultTemp.getString("unitPrice", modelCnt))){
            				rfcData.setString("unitPrice", resultTemp.getString("unitPrice", modelCnt));
            			}else{
			            	rfcData.setString("unitPrice", "0");
            			}
		            	rfcData.setString("useyn", "Y");
		               
		                resultData.addLData(rfcData);
	            	}
            	}
            }
            
            System.out.println(resultTemp);
            LLog.debug.write("result ::" + resultData);

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