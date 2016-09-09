/*
 *------------------------------------------------------------------------------
 * $Id: PopupBiz.java
 * 
 * PROJ : LGI-Hub System
 * Copyright 2010 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2010.08.05   mskim   Init
 *----------------------------------------------------------------------------
 */

package cm.dm.biz;

import javax.servlet.http.HttpServletRequest;

import comm.util.CommonUtil;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LBizException;
import devon.core.exception.LException;
import devon.core.exception.LSysException;
import devon.core.log.LLog;
import devon.core.util.LDateUtils;
import devonframework.bridge.gauce.util.LGauceConverter;
import devonframework.persistent.autodao.LCommonDao;
import devonframework.persistent.autodao.LCompoundDao;

public class DataInputMgntBiz {


	/* ******************************
	 * 시스템 입력 현황 조회
	 * 회계 : Document
	 * 영업 : Po + Receipt + Issue + Movement
	 * 생산 : Production & Sales
	 * 
	 * 입력 Sum  &   적시 입력비율(증빙일과 입력일이 5일 이내인 건의 비율)
	 * 
	 * ******************************/
	public int[][] retrieveDataInputList(LData inputData) throws LException {

		
		String currentMonth = inputData.getString("month");         // 조회달
		
		LLog.info.write("\n DataInputMgntBiz > retrieveDataInputList() -------> Start \n");
		
        LCommonDao dao = new LCommonDao();

        // 회계, po, receipt, issue, movement, 생산판매별 입력 건수 및 적시 입력 건수를 받아오는 변수
        LMultiData document, po, receipt, issue, invoice, waste, hauling, production, sales;  
        
      
        int [][] board = new int[16][3];
        
		try{
			//회계
			document =  dao.executeQuery("/cm/dm/dataInputMonitoringSql/retrieveDataInputDocumentList", inputData);
			
			//영업
			//po =  dao.executeQuery("/cm/dm/dataInputMonitoringSql/retrieveDataInputPoList", inputData);
			receipt =  dao.executeQuery("/cm/dm/dataInputMonitoringSql/retrieveDataInputReceiptList", inputData);
			issue =  dao.executeQuery("/cm/dm/dataInputMonitoringSql/retrieveDataInputIssueList", inputData);
			invoice =  dao.executeQuery("/cm/dm/dataInputMonitoringSql/retrieveDataInputInvoiceList", inputData);
			//movement =  dao.executeQuery("/cm/dm/dataInputMonitoringSql/retrieveDataInputTranList", inputData);
			
			//생산 
			waste =  dao.executeQuery("/cm/dm/dataInputMonitoringSql/retrieveDataInputWasteList", inputData);
			hauling =  dao.executeQuery("/cm/dm/dataInputMonitoringSql/retrieveDataInputHaulingList", inputData);
			production =  dao.executeQuery("/cm/dm/dataInputMonitoringSql/retrieveDataInputProductionList", inputData);
			
			//판매
			sales =  dao.executeQuery("/cm/dm/dataInputMonitoringSql/retrieveDataInputSalesList", inputData);
			
			// 월별 덧셈 계산
			// 회계 
			for(int i=0; i<document.getDataCount(); i++){
				if(document.getString("month", i).equals(currentMonth.substring(0, 6))){    // 당월 
					board[0][2] = document.getInt("total", i);
					board[8][2] = document.getInt("rightinput", i) * 100 / document.getInt("total", i);
					
				}else if(document.getString("month", i).equals(LDateUtils.getPrevMonthDate(currentMonth+"01", 1).substring(0, 6))){
					board[0][1] = document.getInt("total", i);
					board[8][1] = document.getInt("rightinput", i) * 100 / document.getInt("total", i);
					
				}else if(document.getString("month", i).equals(LDateUtils.getPrevMonthDate(currentMonth+"01", 2).substring(0, 6))){
					board[0][0] = document.getInt("total", i);
					board[8][0] = document.getInt("rightinput", i) * 100 / document.getInt("total", i);
				}
			}
			
			/*
			//po 
			for(int i=0; i<po.getDataCount(); i++){
				if(po.getString("month", i).equals(currentMonth.substring(0, 6))){    // 당월 
					board[1][2] = po.getInt("total", i);
					board[4][2] = po.getInt("rightinput", i);
					
				}else if(po.getString("month", i).equals(LDateUtils.getPrevMonthDate(currentMonth+"01", 1).substring(0, 6))){
					board[1][1] = po.getInt("total", i);
					board[4][1] = po.getInt("rightinput", i);
					
				}else if(po.getString("month", i).equals(LDateUtils.getPrevMonthDate(currentMonth+"01", 2).substring(0, 6))){
					board[1][0] = po.getInt("total", i);
					board[4][0] = po.getInt("rightinput", i);
				}
			}
			*/
			
			//입고 
			for(int i=0; i<receipt.getDataCount(); i++){
				if(receipt.getString("month", i).equals(currentMonth.substring(0, 6))){    // 당월 
					board[1][2] += receipt.getInt("total", i);
					board[9][2] += receipt.getInt("rightinput", i) * 100 / receipt.getInt("total", i);
					
				}else if(receipt.getString("month", i).equals(LDateUtils.getPrevMonthDate(currentMonth+"01", 1).substring(0, 6))){
					board[1][1] += receipt.getInt("total", i);
					board[9][1] += receipt.getInt("rightinput", i) * 100 / receipt.getInt("total", i);
					
				}else if(receipt.getString("month", i).equals(LDateUtils.getPrevMonthDate(currentMonth+"01", 2).substring(0, 6))){
					board[1][0] += receipt.getInt("total", i);
					board[9][0] += receipt.getInt("rightinput", i) * 100 / receipt.getInt("total", i);
				}
			}
			
			//issue 
			for(int i=0; i<issue.getDataCount(); i++){
				if(issue.getString("month", i).equals(currentMonth.substring(0, 6))){    // 당월 
					board[2][2] += issue.getInt("total", i);
					board[10][2] += issue.getInt("rightinput", i) * 100 / issue.getInt("total", i);
					
				}else if(issue.getString("month", i).equals(LDateUtils.getPrevMonthDate(currentMonth+"01", 1).substring(0, 6))){
					board[2][1] += issue.getInt("total", i);
					board[10][1] += issue.getInt("rightinput", i) * 100 / issue.getInt("total", i);
					
				}else if(issue.getString("month", i).equals(LDateUtils.getPrevMonthDate(currentMonth+"01", 2).substring(0, 6))){
					board[2][0] += issue.getInt("total", i);
					board[10][0] += issue.getInt("rightinput", i) * 100 / issue.getInt("total", i);
				}
			}
			
			//invoice 
			for(int i=0; i<invoice.getDataCount(); i++){
				if(invoice.getString("month", i).equals(currentMonth.substring(0, 6))){    // 당월 
					board[3][2] += invoice.getInt("total", i);
					board[11][2] += invoice.getInt("rightinput", i) * 100 / invoice.getInt("total", i);
					
				}else if(invoice.getString("month", i).equals(LDateUtils.getPrevMonthDate(currentMonth+"01", 1).substring(0, 6))){
					board[3][1] += invoice.getInt("total", i);
					board[11][1] += invoice.getInt("rightinput", i) * 100 / invoice.getInt("total", i);
					
				}else if(invoice.getString("month", i).equals(LDateUtils.getPrevMonthDate(currentMonth+"01", 2).substring(0, 6))){
					board[3][0] += invoice.getInt("total", i);
					board[11][0] += invoice.getInt("rightinput", i) * 100 / invoice.getInt("total", i);
				}
			}
			
			/*
			board[4][0] = board[4][0] * 100 / ((board[1][0]==0)?100:board[1][0]) ;
			board[4][1] = board[4][1] * 100 / ((board[1][1]==0)?100:board[1][1]) ;
			board[4][2] = board[4][2] * 100 / ((board[1][2]==0)?100:board[1][2]) ;
			*/
			
			//Waste 
			for(int i=0; i<waste.getDataCount(); i++){
				if(waste.getString("month", i).equals(currentMonth.substring(0, 6))){    // 당월 
					board[4][2] = waste.getInt("total", i);
					board[12][2] = waste.getInt("rightinput", i) * 100 / waste.getInt("total", i);
					
				}else if(waste.getString("month", i).equals(LDateUtils.getPrevMonthDate(currentMonth+"01", 1).substring(0, 6))){
					board[4][1] = waste.getInt("total", i);
					board[12][1] = waste.getInt("rightinput", i) * 100 / waste.getInt("total", i);
					
				}else if(waste.getString("month", i).equals(LDateUtils.getPrevMonthDate(currentMonth+"01", 2).substring(0, 6))){
					board[4][0] = waste.getInt("total", i);
					board[12][0] = waste.getInt("rightinput", i) * 100 / waste.getInt("total", i);
				}
			}
			
			//Hauling 
			for(int i=0; i<hauling.getDataCount(); i++){
				if(hauling.getString("month", i).equals(currentMonth.substring(0, 6))){    // 당월 
					board[5][2] = hauling.getInt("total", i);
					board[13][2] = hauling.getInt("rightinput", i) * 100 / hauling.getInt("total", i);
					
				}else if(hauling.getString("month", i).equals(LDateUtils.getPrevMonthDate(currentMonth+"01", 1).substring(0, 6))){
					board[5][1] = hauling.getInt("total", i);
					board[13][1] = hauling.getInt("rightinput", i) * 100 / hauling.getInt("total", i);
					
				}else if(hauling.getString("month", i).equals(LDateUtils.getPrevMonthDate(currentMonth+"01", 2).substring(0, 6))){
					board[5][0] = hauling.getInt("total", i);
					board[13][0] = hauling.getInt("rightinput", i) * 100 / hauling.getInt("total", i);
				}
			}
			
			//production 
			for(int i=0; i<production.getDataCount(); i++){
				if(production.getString("month", i).equals(currentMonth.substring(0, 6))){    // 당월 
					board[6][2] = production.getInt("total", i);
					board[14][2] = production.getInt("rightinput", i) * 100 / production.getInt("total", i);
					
				}else if(production.getString("month", i).equals(LDateUtils.getPrevMonthDate(currentMonth+"01", 1).substring(0, 6))){
					board[6][1] = production.getInt("total", i);
					board[14][1] = production.getInt("rightinput", i) * 100 / production.getInt("total", i);
					
				}else if(production.getString("month", i).equals(LDateUtils.getPrevMonthDate(currentMonth+"01", 2).substring(0, 6))){
					board[6][0] = production.getInt("total", i);
					board[14][0] = production.getInt("rightinput", i) * 100 / production.getInt("total", i);
				}
			}
			
			
			//sales
			for(int i=0; i<sales.getDataCount(); i++){
				if(sales.getString("month", i).equals(currentMonth.substring(0, 6))){    // 당월 
					board[7][2] += sales.getInt("total", i);
					board[15][2] += sales.getInt("rightinput", i) * 100 / sales.getInt("total", i);
					
				}else if(sales.getString("month", i).equals(LDateUtils.getPrevMonthDate(currentMonth+"01", 1).substring(0, 6))){
					board[7][1] += sales.getInt("total", i);
					board[15][1] += sales.getInt("rightinput", i) * 100 / sales.getInt("total", i);
					
				}else if(sales.getString("month", i).equals(LDateUtils.getPrevMonthDate(currentMonth+"01", 2).substring(0, 6))){
					board[7][0] += sales.getInt("total", i);
					board[15][0] += sales.getInt("rightinput", i) * 100 / sales.getInt("total", i);
				}
			}
			
			/*
			board[5][0] = board[5][0] * 100 / ((board[2][0]==0)?100:board[2][0]) ;
			board[5][1] = board[5][1] * 100 / ((board[2][1]==0)?100:board[2][1]) ;
			board[5][2] = board[5][2] * 100 / ((board[2][2]==0)?100:board[2][2]) ;
			 */
			
			
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveDataInputList------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		} 
		
		return board; 
    }
	
	// email list 조회 
	public LMultiData retrieveDataInputEmailList(LData inputData) throws LBizException {
        LMultiData list = null;

        try {
 
            LCommonDao dao = new LCommonDao("/cm/dm/dataInputMonitoringSql/retrieveDataInputEmailList", inputData);
            list = dao.executeQuery();
            
        } catch (LException le) {
            LLog.err.write(this.getClass().getName() + "." + "RetrievecodeCbList()" + "=>" + le.getMessage());
            throw new LBizException("cm.cm.com.retrieve");
        }
        return list;
	}

	  /**
     * email list CUD
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LData cudRetrieveDataInputEmailList(LMultiData mData, LData inputData) throws LException {
        LCompoundDao dao = new LCompoundDao();
        LData result = new LData();
        int cnt = 0;
        int cnt2 = 0;
        
		LLog.debug.println("cudRetrieveDataInputEmailList mData--------------- =>\n " + mData.toString());
		
		String	getErrorCode = "0" ;
		String	getMessage	 = "Failed"; 	

        try{			
	        
			for(int i=0;i<mData.getDataCount();i++) {
				
				LData cudlData = mData.getLData(i);
				
				cudlData.setString("companyCd", inputData.getString("companyCd"));
				
				if( "DEVON_CREATE_FILTER_VALUE".equals(cudlData.getString( "DEVON_CUD_FILTER_KEY")) ) {
		            dao.add ("/cm/dm/dataInputMonitoringSql/insertDataInputEmailList", cudlData);            
		            
				} else if( "DEVON_UPDATE_FILTER_VALUE".equals(cudlData.getString( "DEVON_CUD_FILTER_KEY")) ) {
		            dao.add ("/cm/dm/dataInputMonitoringSql/updateDataInputEmailList", cudlData);
		            
				} else if( "DEVON_DELETE_FILTER_VALUE".equals(cudlData.getString( "DEVON_CUD_FILTER_KEY")) ) {
		            dao.add ("/cm/dm/dataInputMonitoringSql/deleteDataInputEmailList", cudlData);
		            
				}
				
			}
			
			dao.executeUpdate();
				
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "cudStockMove()" + "=>" + se.getMessage());
			//throw new LSysException("pbf.err.com.save", se);
			getErrorCode = "-1403";
			getMessage = se.getMessage();
			throw new LSysException(getMessage,se);
        }
		
		result.put("getErrorCode"	,getErrorCode);
		result.put("getMessage"	,getMessage);
		
		return result;
    }	

}
