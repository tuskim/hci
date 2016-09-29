/*
 *------------------------------------------------------------------------------
 * CostTotLedgerMgntBiz.java,v 1.0 2010/07/23 16:43:35 
 * 
 * PROJ : PT-PAM
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2010/08/20   mskim   Init
 *----------------------------------------------------------------------------
 */

package fi.ar.biz;

import devon.core.exception.LException;
import devon.core.exception.LSysException;
import devon.core.log.LLog;
import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devonframework.persistent.autodao.LCommonDao;
import devonframework.persistent.autodao.LCompoundDao;
import java.text.DecimalFormat;

/**
 * <PRE>
 * Cost Total Ledger Mgnt 업무를 처리하는 Biz 클래스.
 *
 * Database Tables : 
 * </PRE>
 * @author    CEH
 */
public class CostTotLedgerMgntBiz {
 
    
    /**
     * Cost Total Ledger Master Mgnt 정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveCostTotLedgerMstMgnt(LData inputData) throws LException {    	
    	
    	LLog.debug.write("CostTotLedgerMgntBiz.retrieveCostTotLedgerMstMgnt -----------> Start ");
    	
    	LCommonDao dao = new LCommonDao();
		try{			
			return dao.executeQuery("fi/ar/costTotLedgerMgntSql/retrieveCostTotLedgerMstMgnt", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveCostTotLedgerMstMgnt------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		}
    }

    
     /**
     * Cost Total Ledger Mgnt Delete 정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
	public LData deleteCostTotLedgerMgnt(LData inputData, LData loginUser) throws LException {
		
    	LLog.info.write("\n CostTotLedgerMgntBiz > deleteCostTotLedgerMgnt() ------------- Start \n");
    	
        LCompoundDao dao		= new LCompoundDao();
        LCommonDao xdao		= new LCommonDao();
        String msg 				= "";
        
		long	getErrorCode	= 0 ;
		String	getMessage		= "";
		String	getStatus		= "";
		String status 			= "";
	
		LData dataBox		    = new LData();
		
		try{
			
			dao.startTransaction();

			inputData.setString("userId", loginUser.getString("userId"));

			LLog.info.write("\n CostTotLedgerMgntBiz > cudDelCostTotLedgerMgnt() inputData ------------- >>>>>>>>>" + inputData);

	        //1) Delete Cost Total Ledger Master
	        dao.add ("fi/ar/costTotLedgerMgntSql/deleteCostTotLedgerMstMgnt", inputData ); 

	        //2) Delete Cost Total Ledger Detail
	        dao.add ("fi/ar/costTotLedgerMgntSql/deleteCostTotLedgerAllDtlMgnt", inputData ); 

	        //3) Delete Cost Total Ledger Barge
	        dao.add ("fi/ar/costTotLedgerMgntSql/deleteCostTotLedgerBargeMgnt", inputData ); 
	        
	        
			String workType = inputData.getString("workType");	//Work Type
			
			if ( workType.equals("W01")) {
				// Waste Removal
				
				if(inputData.getString("currencyCd").equals("IDR")){
					inputData.setString("statusIdr",   "10");
				}else if(inputData.getString("currencyCd").equals("USD")){
					inputData.setString("statusUsd",  "10");
				}
				status = xdao.executeQueryForSingle("fi/ar/costTotLedgerMgntSql/getWasteRemovalStatus", inputData).getString("status");
				inputData.setString("status",   status);   		// Delete (20)
				
				dao.add("fi/ar/costTotLedgerMgntSql/updateWasteRemovalStatus", inputData);
			} else if ( workType.equals("W02")) {
				// Coal Hauling
				if(inputData.getString("currencyCd").equals("IDR")){
					inputData.setString("statusIdr",   "10");
				}else if(inputData.getString("currencyCd").equals("USD")){
					inputData.setString("statusUsd",  "10");
				}
				status = xdao.executeQueryForSingle("fi/ar/costTotLedgerMgntSql/getCoalHaulingStatus", inputData).getString("status");
				inputData.setString("status",   status);   		// Delete (20)
				
				dao.add("fi/ar/costTotLedgerMgntSql/updateCoalHaulingStatus", inputData);
			} else if ( workType.equals("W03")) {
				// Rental Hour
				inputData.setString("status",  "20");
				dao.add("fi/ar/costTotLedgerMgntSql/updateRentalHourStatus", inputData);
			}			
			
			dao.executeUpdate();

			dao.commit();
			
		} catch (Exception se) {
			dao.rollback();
			getErrorCode = -99901;
			getMessage   = se.toString();
			getStatus    = "fail."+this.getClass().getName()+"."+"CostTotLedgerMgntBiz";
			LLog.err.write(this.getClass().getName()+"."+"CostTotLedgerMgntBiz()"+"=>" + msg);
		}

		LLog.info.write("\n CostTotLedgerMgntBiz > cudDelCostTotLedgerMgnt() ------------- END --> \n");
      
		getErrorCode = 0;
		dataBox.put("getErrorCode"	,getErrorCode + "" );
		dataBox.put("getMessage"	,getMessage);
		
		if(!getStatus.equals("")) dataBox.put("getStatus" ,getStatus ); //현 프로그램에서 에러
		return dataBox;
	}
	
	
    /**
     * Cost Total Ledger Detail Mgnt 정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveCostTotLedgerDtlMgnt(LData inputData) throws LException {    	
    	
    	LLog.debug.write("CostTotLedgerMgntBiz.retrieveCostTotLedgerDtlMgnt -----------> Start ");
    	
    	LCommonDao dao = new LCommonDao();
		try{			
			return dao.executeQuery("fi/ar/costTotLedgerMgntSql/retrieveCostTotLedgerDtlMgnt", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveCostTotLedgerDtlMgnt------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		}
    }	
	
	
    /**
     * Cost Total Ledger Barge Mgnt 정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveCostTotLedgerBargeMgnt(LData inputData) throws LException {    	
    	
    	LLog.debug.write("CostTotLedgerMgntBiz.retrieveCostTotLedgerBargeMgnt -----------> Start ");
    	
    	LCommonDao dao = new LCommonDao();
		try{			
			return dao.executeQuery("fi/ar/costTotLedgerMgntSql/selectCostTotLedgerBargeMgnt2", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveCostTotLedgerBargeMgnt------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		}
    }	


    /**
     *Cost Total Ledger Detail 저장하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     ** @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LData cudCostTotLedgerMgnt(LMultiData inMstData, LMultiData inDtlData, LMultiData inBargeData, LData loginUser) throws LException {
        LCompoundDao dao = new LCompoundDao();
        LCompoundDao sdao = new LCompoundDao();
        LCompoundDao xdao = new LCompoundDao();
        LData result = new LData();
        //int cnt = 0;
        
		LLog.debug.println("CostTotLedgerMgntBiz.cudCostTotLedgerMgnt inputData--------------- =>\n " + inDtlData.toString());
		
		long	getErrorCode = 0;
		String	getMessage	 = "";
        String  getStatus    = "";		
		String  msg = "";
		DecimalFormat format = new DecimalFormat("0.####");

        try{			

			dao.startTransaction();

			LData  resultInfo  = new LData();		// Seq 생성
			LData  resultInfo2  = new LData();		// Seq 생성
			String docYm       = "";
			String docSeq      = "";
			String strCheck    = "";
			String columnCheck = "";
			String status 			= "";
			
			LMultiData dtlList = new LMultiData();
			String workType = "";

			
			//Cost Total Ledger Master
				
			LData cudlData = inMstData.getLData(0);
LLog.info.print("cudlData : "+cudlData.toString());
			//Work Type
			//String workType = cudlData.getString("workType");
			String docDate  ="";
			if(!cudlData.getString("docDate").equals(""))
				docDate = cudlData.getString("docDate").replaceAll("/", "");
			String postDate = "";
			if(!cudlData.getString("postDate").equals(""))
				postDate = cudlData.getString("postDate").replaceAll("/", "");
			docYm = docDate.substring(0, 6);

			cudlData.setString("userId",     loginUser.getString("userId"));
			cudlData.setString("docYm",   	 docYm);
			cudlData.setString("postDate",   postDate);
			cudlData.setString("docDate",    docDate);
			
	    	String tr_Mode  = cudlData.getString("DEVON_CUD_FILTER_KEY");

	    	if( tr_Mode.equals("DEVON_CREATE_FILTER_VALUE")) {

				// New Doc Seq Search
				resultInfo = dao.executeQueryForSingle("fi/ar/costTotLedgerMgntSql/retrieveCostTotLedgerDocSeq", cudlData);
				docSeq     = resultInfo.getString("docSeq");
				cudlData.setString("docSeq", docSeq);

				//1) Cost Total Ledger Detail Insert
				dao.add("fi/ar/costTotLedgerMgntSql/insertCostTotLedgerMstMgnt", cudlData);
	    	
	    	}
			
			int mstCnt = inMstData.getDataCount();
			LData cudlDataInfo = new LData();
				cudlDataInfo = inDtlData.getLData(0);
				// detail 다시 조회
				
				dtlList = sdao.executeQuery("fi/ar/costTotLedgerMgntSql/retrieveCostTotLedgerDtlMgnt", cudlDataInfo);
				for(int j = 0; j < dtlList.getDataCount(); j++){
					LData dtlData = dtlList.getLData(j);
					workType = dtlData.getString("workCd");
					dtlData.setString("vendCd", dtlData.getString("workVendor"));
					dtlData.setString("postYm", dtlData.getString("workYm"));
					dtlData.setString("currencyCd", cudlData.getString("currencyCd"));
					if(workType != null){
						//TODO: status 값 입력설정
						if ( workType.equals("W01")) {
							// Waste Removal
							if(dtlData.getString("currencyCd").equals("IDR")){
								dtlData.setString("statusIdr",   "10");
							}else if(dtlData.getString("currencyCd").equals("USD")){
								dtlData.setString("statusUsd",  "10");
							}
							status = xdao.executeQueryForSingle("fi/ar/costTotLedgerMgntSql/getWasteRemovalStatus", dtlData).getString("status");
							dtlData.setString("status",   status); 
							
							dao.add("fi/ar/costTotLedgerMgntSql/updateWasteRemovalStatus", dtlData);
						} else if ( workType.equals("W02")) {
							// Coal Hauling
							if(dtlData.getString("currencyCd").equals("IDR")){
								dtlData.setString("statusIdr",   "10");
							}else if(dtlData.getString("currencyCd").equals("USD")){
								dtlData.setString("statusUsd",  "10");
							}
							status = xdao.executeQueryForSingle("fi/ar/costTotLedgerMgntSql/getCoalHaulingStatus", dtlData).getString("status");
							dtlData.setString("status",   status);   		// Delete (20)
							
							dao.add("fi/ar/costTotLedgerMgntSql/updateCoalHaulingStatus", dtlData);
						
						} else if ( workType.equals("W03")) {
							// Rental Hour
							dtlData.setString("status",  "20");
							dao.add("fi/ar/costTotLedgerMgntSql/updateRentalHourStatus", dtlData);
						}
					}
				}
		        dao.add ("fi/ar/costTotLedgerMgntSql/deleteCostTotLedgerAllDtlMgnt", cudlDataInfo ); 

			//Cost Total Ledger Detail
			for(int i=0;i<inDtlData.getDataCount();i++) {
				
				LData cudDtlData = inDtlData.getLData(i);
				cudDtlData.setString("userId",  loginUser.getString("userId"));
				cudDtlData.setString("base",    cudDtlData.getString("base"));
		    	String tr_Mode2  = cudDtlData.getString("DEVON_CUD_FILTER_KEY");
				
				if( tr_Mode2.equals("DEVON_CREATE_FILTER_VALUE") ) {

					if ( !docSeq.equals("") ) cudDtlData.setString("docSeq", docSeq);
					if ( !docYm.equals("") )  cudDtlData.setString("docYm",   docYm);
					
					LLog.info.write("=================  Document Detail 저장 Param [" + i + "]  ======================");
					LLog.info.write("periodCostFrom:"+cudDtlData.getString("periodCostFrom"));
					LLog.info.write("periodCostTo:"+cudDtlData.getString("periodCostTo"));
					LLog.info.write("=========================================================================");
					
					//Cost Total Ledger Detail Insert
					dao.add("fi/ar/costTotLedgerMgntSql/insertCostTotLedgerDtlMgnt", cudDtlData);
					
					// detail 다시 조회
					workType = cudDtlData.getString("workCd");
					cudDtlData.setString("status", "30");
					
					cudDtlData.setString("vendCd", cudDtlData.getString("workVendor"));
					cudDtlData.setString("postYm", cudDtlData.getString("workYm"));
					cudDtlData.setString("currencyCd", cudlData.getString("currencyCd"));
					
					if ( workType.equals("W01")) {
						// Waste Removal
						if(cudDtlData.getString("currencyCd").equals("IDR")){
							cudDtlData.setString("statusIdr",   "20");
						}else if(cudDtlData.getString("currencyCd").equals("USD")){
							cudDtlData.setString("statusUsd",  "20");
						}
						status = xdao.executeQueryForSingle("fi/ar/costTotLedgerMgntSql/getWasteRemovalStatus2", cudDtlData).getString("status");
						cudDtlData.setString("status",   status); 
						dao.add("fi/ar/costTotLedgerMgntSql/updateWasteRemovalStatus", cudDtlData);
					} else if ( workType.equals("W02")) {
						// Coal Hauling
						if(cudDtlData.getString("currencyCd").equals("IDR")){
							cudDtlData.setString("statusIdr",   "20");
						}else if(cudDtlData.getString("currencyCd").equals("USD")){
							cudDtlData.setString("statusUsd",  "20");
						}
						status = xdao.executeQueryForSingle("fi/ar/costTotLedgerMgntSql/getCoalHaulingStatus2", cudDtlData).getString("status");
						cudDtlData.setString("status",   status);   		// Delete (20)
						
						dao.add("fi/ar/costTotLedgerMgntSql/updateCoalHaulingStatus", cudDtlData);
					} else if ( workType.equals("W03")) {
						// Rental Hour
						cudDtlData.setString("status",  "50");
						dao.add("fi/ar/costTotLedgerMgntSql/updateRentalHourStatus", cudDtlData);
					}
				}
				
			}
			
			
			String istatus = xdao.executeQueryForSingle("fi/ar/costTotLedgerMgntSql/selectCostTotLedgerBargeMgnt", cudlData).getString("cnt");
	    	
			if(Integer.parseInt(istatus)>0){
				dao.add("fi/ar/costTotLedgerMgntSql/deleteCostTotLedgerBargeMgnt", cudlData);
			}
			
			
			//Barge info
			for(int i=0;i<inBargeData.getDataCount();i++) {

			LLog.info.write("inBargeData()"+"=>" + inBargeData.toString());			
			
				LData cudBargeData = inBargeData.getLData(i);
				cudBargeData.setString("userId",  loginUser.getString("userId"));
				cudBargeData.setString("base",    cudBargeData.getString("base"));
				cudBargeData.setString("companyCd",    cudlData.getString("companyCd"));
				cudBargeData.setString("deptCd",    cudlData.getString("deptCd"));
				cudBargeData.setString("docYm",    cudlData.getString("docYm"));
				cudBargeData.setString("docSeq",    cudlData.getString("docSeq"));
		    	String tr_Mode3  = cudBargeData.getString("DEVON_CUD_FILTER_KEY");
		    	
				LLog.debug.print("Barge Data : "+cudBargeData.toString());
				dao.add("fi/ar/costTotLedgerMgntSql/insertCostTotLedgerBargeMgnt", cudBargeData);
		    	
//				if( tr_Mode3.equals("DEVON_CREATE_FILTER_VALUE") ) {
//
//					if ( !docSeq.equals("") ) cudBargeData.setString("docSeq", docSeq);
//					if ( !docYm.equals("") )  cudBargeData.setString("docYm",   docYm);
//					
//					//Cost Total Ledger Detail Insert
//					dao.add("fi/ar/costTotLedgerMgntSql/mergeCostTotLedgerBargeMgnt", cudBargeData);
//					
//
//				}
//				
//
//				if(tr_Mode3.equals("DEVON_DELETE_FILTER_VALUE")){ 				
//					dao.add ("fi/ar/costTotLedgerMgntSql/deleteCostTotLedgerBargeMgnt", cudBargeData); 
//				}else if(tr_Mode3.equals("DEVON_UPDATE_FILTER_VALUE")){
//					dao.add ("fi/ar/costTotLedgerMgntSql/updateCostTotLedgerBargeMgnt", cudBargeData); 
//				}else if(tr_Mode3.equals("DEVON_CREATE_FILTER_VALUE")){
//					dao.add ("fi/ar/costTotLedgerMgntSql/insertCostTotLedgerBargeMgnt", cudBargeData); 
//				} 
				
				
				
			}

			cudlData.setString("userId",    loginUser.getString("userId"));
			//Master Infomation Change
            dao.add ("fi/ar/costTotLedgerMgntSql/updateCostTotLedgerDtlChgMgnt", cudlData); 
			
			dao.executeUpdate();

			dao.commit();
				
		} catch (Exception se) {
			dao.rollback();
			se.getMessage();
			getErrorCode = -99901;
			getMessage   = se.toString();
			getStatus    = "fail."+this.getClass().getName()+"."+"cudCostTotLedgerMgnt";

			LLog.info.write(this.getClass().getName()+"."+"cudCostTotLedgerMgnt()"+"=>" + msg);			
        }
		
		result.put("getErrorCode"	,getErrorCode + "");
		result.put("getMessage"		,getMessage);

		if(!getStatus.equals("")) result.put("getStatus" ,getStatus ); //현 프로그램에서 에러
		
		return result;
    }
    
    /**
     * Cost Total Ledger Master Excel 다운 정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveCostTotLedgerMstExcelList(LData inputData) throws LException {    	
    	
    	LLog.debug.write("CostTotLedgerMgntBiz.retrieveCostTotLedgerMstExcelList -----------> Start ");
    	
    	LCommonDao dao = new LCommonDao();
		try{			
			return dao.executeQuery("fi/ar/costTotLedgerMgntSql/retrieveCostTotLedgerMstExcelList", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveCostTotLedgerMstExcelList------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		}
    }


	public LMultiData retrieveCostTotLedgerVatVCombo(LData inputData) throws LSysException {
    	LLog.debug.write("retrieveCostTotLedgerVatVCombo -----------> Start ");
    	
    	LCommonDao dao = new LCommonDao();
		try{			
			return dao.executeQuery("fi/ar/costTotLedgerMgntSql/retrieveCostTotLedgerVatVCombo", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveCostTotLedgerVatVCombo------()" + "=>" + se.getMessage());
			throw new LSysException("fi.ar.retrieveCostTotLedgerVatVCombo", se);
		}
	}

    
}
