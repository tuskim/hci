/*
 *------------------------------------------------------------------------------
 * CementSalesMgntBiz.java,v 1.0 2016/08/02  
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

package sd.sm.biz;

import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Date;

import rfc.biz.RetrieveCustomerCreditLimitRFC;
import xi.GSD01;
import xi.GSD03;

import devon.core.exception.LBizException;
import devon.core.exception.LException;
import devon.core.exception.LSysException;
import devon.core.log.LLog;
import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devonframework.persistent.autodao.LCommonDao;
import devonframework.persistent.autodao.LCompoundDao;
/**
 * <PRE>
 * Cement Sales Management 업무를 처리하는 Biz 클래스.
 *
 * Database Tables : 
 * </PRE>
 * @author    LTK
 */
public class CementSalesMgntBiz {

	/**
	 * Cement Sales 조회
	 * @param inputData 검색조건 입력 값
	 * @return Cement Sales 목록 조회
	 * @throws LException
	 */
	public LMultiData retrieveCementSalesMgntList(LData inputData) throws LException {

		LMultiData resultData = null;
        try {
        	LCommonDao dao = new LCommonDao( "/sd/sm/cementSalesMgntSql/retrieveCementSalesMgntList",inputData );
        	resultData = dao.executeQuery();
        	
        } catch (Exception le ) {
        	LLog.err.write(this.getClass().getName()+"." +"retrieveCementSalesMgntList()"+"=>"+le.getMessage());
            throw new LBizException("sd.sm.cmd.retrieve");
        }
        return resultData;
	}

	/**
	 * Cement Detail Sales 조회
	 * @param inputData 검색조건 입력 값
	 * @return Cement Detail Sales 목록 조회
	 * @throws LException
	 */
	public LMultiData retrieveCementDetailSalesMgnt(LData inputData) throws LException {

		LMultiData resultData = null;
        try {
        	LCommonDao dao = new LCommonDao( "/sd/sm/cementSalesMgntSql/retrieveCementDetailSalesMgnt",inputData );
        	resultData = dao.executeQuery();
        	
        } catch (Exception le ) {
        	LLog.err.write(this.getClass().getName()+"." +"retrieveCementDetailSalesMgnt()"+"=>"+le.getMessage());
            throw new LBizException("sd.sm.cmd.retrieve");
        }
        return resultData;
	}

	/**
     * Cement master Sales
     * @param inputData 
     * @return sales 목록 조회 수정
     * @exception LException
     */
    public LData CudCementSalesMgnt(LMultiData inputm, LMultiData inputd, LData loginUser) throws LException {
 	
  		LCompoundDao dao = new LCompoundDao();
  		dao.startTransaction();  
  	 	LData seq 	= new LData();
    	LData Lrow  = new LData();
    	LData Lrow2 = new LData();
    	LData resultData = new LData();
    	LData creditChkData = new LData();
    	try{
  
    		for(int i = 0 ; i < inputm.getDataCount() ; i++){
    			Lrow = inputm.getLData(i);	//List의 값
    			Lrow.set("userId", 	 loginUser.getString("userId"));
    			Lrow.set("companyCd",loginUser.getString("companyCd"));
    			Lrow.set("deptCd", loginUser.getString("companyCd"));
    			
    			LLog.info.write("\n CudCementSalesMgnt Biz --> inputData \n" +Lrow);	
	    			
    			String key = Lrow.getString("DEVON_CUD_FILTER_KEY");
        		//Delete
    			if(key.equals("DEVON_DELETE_FILTER_VALUE")){ 
						dao.add ("/sd/sm/cementSalesMgntSql/deleteCementSalesMaster",  Lrow); 
						dao.add ("/sd/sm/cementSalesMgntSql/deleteCementSalesDetail",Lrow); 
						dao.executeUpdate();
				//Update
    			}else if(key.equals("DEVON_UPDATE_FILTER_VALUE")){
    				
    				creditChkData = RetrieveCustomerCreditLimit(Lrow, inputd); //여신체크
    				
    				Lrow.set("orderStatus",  creditChkData.get("creditYn").equals("Y")?"1":"0");  //여신체크 결과 N이면 status는 0, Y이면 1처리
    				Lrow.set("creditMsg"  ,  creditChkData.get("creditMsg"));  //여신체크 결과
    				
    				
			    	dao.add ("/sd/sm/cementSalesMgntSql/updateCementSalesMaster",  Lrow );
			    	dao.executeUpdate();
		    		
			    	//CPO detail
			    	for(int j = 0 ; j < inputd.getDataCount() ; j++){
						Lrow2 = inputd.getLData(j);	//List의 값
		    			Lrow2.set("salesDate",Lrow.get("salesDate"));
		    			Lrow2.set("salesNo",Lrow.get("salesNo"));
						Lrow2.set("userId",   loginUser.getString("userId"));
						Lrow2.set("companyCd",loginUser.getString("companyCd"));
						Lrow2.set("deptCd",loginUser.getString("companyCd"));

		    		 	LLog.info.write("\n CudCementSalesMgnt Biz --> Cement Update Detail \n" +Lrow2);
					 	String key2 = Lrow2.getString("DEVON_CUD_FILTER_KEY");
						if(key2.equals("DEVON_DELETE_FILTER_VALUE")){ 
							dao.add ("/sd/sm/cementSalesMgntSql/deleteCementSalesDetailOneRow", Lrow2 );
							dao.executeUpdate();	
						}else if(key2.equals("DEVON_UPDATE_FILTER_VALUE")){
						    dao.add ("/sd/sm/cementSalesMgntSql/updateCementSalesDetail", Lrow2 ); 
				    		dao.executeUpdate();				
					    }else if(key2.equals("DEVON_CREATE_FILTER_VALUE")){
				    		dao.add ("/sd/sm/cementSalesMgntSql/createCementSalesDetail", Lrow2 );
				    		dao.executeUpdate();				 
					    }
		    		}
	    	    //Create
    			}else if(key.equals("DEVON_CREATE_FILTER_VALUE")){
    				
    				creditChkData = RetrieveCustomerCreditLimit(Lrow, inputd); //여신체크
    				
//    				if (creditChkData.getString("creditYn").equals("Y")) {
    					seq = dao.executeQueryForSingle("/sd/sm/cementSalesMgntSql/createCementSalesNo", Lrow );
    					Lrow.set("salesNo"    ,  seq.get("salesNo"));
    					Lrow.set("orderStatus",  creditChkData.get("creditYn").equals("Y")?"1":"0"); //여신체크 결과 N이면 status는 0, Y이면 1처리
    					Lrow.set("creditMsg"  ,  creditChkData.get("creditMsg"));  //여신체크 결과
    					
    			    	dao.add ("/sd/sm/cementSalesMgntSql/createCementSalesMaster",  Lrow );
    			    	dao.executeUpdate();
    	
    		    		//CPO detail
    					for(int j = 0 ; j < inputd.getDataCount() ; j++){
    		    			Lrow2 = inputd.getLData(j);	//List의 값
    						Lrow2.set("salesNo", seq.get("salesNo"));
    						Lrow2.set("salesDate", Lrow.get("salesDate"));
    		    			Lrow2.set("userId", 	 loginUser.getString("userId"));
    		    			Lrow2.set("companyCd",loginUser.getString("companyCd"));
    						Lrow2.set("deptCd",loginUser.getString("companyCd"));
    		    		 	LLog.info.write("\n CudCementSalesMgnt Biz --> Cement Create Detail \n" +Lrow2);
    			    		dao.add ("/sd/sm/cementSalesMgntSql/createCementSalesDetail", Lrow2 );
    			    		dao.executeUpdate();
    					}
    					
//    				} else {
//    					
//    					resultData.setString("returnType", "99");
//    					resultData.setString("returnMsg", "Exceed Credit Available Amount!");	
//    					dao.rollback();
//    					
//    					return resultData;
//    				}
				}
    		}

			resultData.setString("returnType", "00");
			resultData.setString("returnMsg", "Successfully Saved.");		
    		dao.commit(); 
        
    	} catch ( LException e ) {
        	dao.rollback();
        	LLog.err.println(  this.getClass().getName() + "." + "CudCementSalesMgnt()" + "=>" + e.getMessage());
        }	
    	
        return resultData;
    }  

	/**
	* Cement detail List 수정시
	* @param inputData 검색조건 입력 값
	* @throws LException
	*/
	public void cudCementDetailList(LMultiData inputp, LData loginUser) throws LException {
			LCompoundDao dao = new LCompoundDao();
			dao.startTransaction();  
			LData Lrow = new LData();
			LLog.info.write("\n cudCementDetailList Biz --> start \n");
			try{  
				for(int i = 0 ; i < inputp.getDataCount() ; i++){
					Lrow = inputp.getLData(i);	
					Lrow.set("userId",   loginUser.getString("userId"));
					Lrow.set("companyCd",loginUser.getString("companyCd"));
				 	LLog.info.write("\n cudCementDetailList Biz --> Sales detail \n" +Lrow);	
				 	
				 	String key = Lrow.getString("DEVON_CUD_FILTER_KEY");
					if(key.equals("DEVON_DELETE_FILTER_VALUE")){ 
						dao.add ("/sd/sm/cementSalesMgntSql/deleteCementDetailOneRow", Lrow ); 
						dao.executeUpdate();	
					}else if(key.equals("DEVON_UPDATE_FILTER_VALUE")){
					    dao.add ("/sd/sm/cementSalesMgntSql/updateCementDetail", Lrow ); 
			    		dao.executeUpdate();				
				    }else if(key.equals("DEVON_CREATE_FILTER_VALUE")){
			    		dao.add ("/sd/sm/cementSalesMgntSql/createCementSalesDetail", Lrow );
			    		dao.executeUpdate();				 
				    }			 
				}
				dao.commit(); 
			} catch (Exception se) {
				dao.rollback();
				LLog.err.println(  this.getClass().getName() + "." + "cudCementDetailList()" + "=>" + se.getMessage());
			}
	}  

	
	/**
	 * 프린트 출력 후 주문상태 변경
	 * @throws LException
	 */
	public void updateCementSalesMasterStatus(LData inputm, LData loginUser) throws LException {
		LCompoundDao dao = new LCompoundDao();
		dao.startTransaction();  
		LData Lrow = new LData();
		LLog.info.write("\n updateCementSalesMasterStatus Biz --> start \n");
		try{  
			Lrow.set("userId", 	 loginUser.getString("userId"));
			Lrow.set("companyCd",loginUser.getString("companyCd"));
			Lrow.set("deptCd", loginUser.getString("companyCd"));
			
			Lrow.set("salesDate",inputm.get("salesDate"));
			Lrow.set("salesNo",inputm.get("soNo"));
			
		    dao.add ("/sd/sm/cementSalesMgntSql/updateCementSalesMasterStatus", Lrow ); 
    		dao.executeUpdate();	
    		
			dao.commit(); 
		} catch (Exception se) {
			dao.rollback();
			LLog.err.println(  this.getClass().getName() + "." + "updateCementSalesMasterStatus()" + "=>" + se.getMessage());
		}
	}  
	
	/**
     * Sales Management VAT 가져오는 메소드
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
	public LMultiData retrieveSalesMgmtVatACombo(LData inputData) throws LException {    	
    	
    	LLog.debug.write("retrieveSalesMgmtVatACombo -----------> Start ");
    	
    	LCommonDao dao = new LCommonDao();
		try{			
			return dao.executeQuery("sd/sm/cementSalesMgntSql/retrieveSalesMgmtVatACombo", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveSalesMgmtVatACombo------()" + "=>" + se.getMessage());
			throw new LSysException("sd.sm", se);
		}
    }        

	public LMultiData retrieveCementMaterialCombo(LData inputData) throws LSysException {
		LLog.info.write("\n SalesMgmtBiz > retrieveCementMaterialCombo() -------> Start \n");
		
        LCommonDao dao = new LCommonDao();
		try{
			return dao.executeQuery("sd/sm/cementSalesMgntSql/retrieveCementMaterialCombo", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveCementMaterialCombo------()" + "=>" + se.getMessage());
			throw new LSysException("cpo.err.com.retrieve", se);
		} 
	}	

	
	/**
    * Cement 품목 마스터 Model Name 조회
    *
    * @param inputData Command로 부턴 전달받은 input LDataProtocol
    * 
    * @return LMultiData 조회된 리스트 결과.
    * @exception LException 메소드 수행시 발생한 모든 에러.
    */
    public LMultiData retrieveCementStockModelList(LData inputData) throws LException {
        LMultiData list = null;

        try {
 
            LCommonDao dao = new LCommonDao("/sd/sm/cementSalesMgntSql/retrieveCementStockModelList", inputData);
            list = dao.executeQuery();
            
        } catch (LException le) {
            LLog.err.write(this.getClass().getName() + "." + "retrieveCementStockModelList()" + "=>" + le.getMessage());
            throw new LBizException("cm.cm.com.retrieve");
        }
        return list;

    }

    /**
	 *POPUP Original Sales company CODE 목록 조회  
	 * @throws LException
	 */
	public LMultiData retrieveComboSalesCompanyList (LData inputData) throws LException {

		
		LMultiData resultData = new LMultiData();
    	LCommonDao dao = new LCommonDao();
		try{			
			resultData =  dao.executeQuery("/sd/sm/cementSalesMgntSql/retrieveComboSalesCompanyList", inputData);
        	        	
        } catch (Exception le ) {
        	LLog.err.write(this.getClass().getName() + "." + "retrieveComboSalesCompanyList()" + "=>" + le.getMessage());
            throw new LBizException("cm.ur.cmd.retrieve");
        }

        return resultData;
	}

	/**
	 * PopUp Original Sales List 조회
	 * @param inputData 검색조건 입력 값
	 * @return PopUp Original Sales List
	 * @throws LException
	 */
	public LMultiData retrievePopUpOriginalSalesList(LData inputData) throws LException {

		LMultiData resultData = null;
        try {
        	LCommonDao dao = new LCommonDao( "/sd/sm/cementSalesMgntSql/retrievePopUpOriginalSalesList",inputData );
        	resultData = dao.executeQuery();
        	
        } catch (Exception le ) {
        	LLog.err.write(this.getClass().getName()+"." +"retrievePopUpOriginalSalesList()"+"=>"+le.getMessage());
            throw new LBizException("sd.sm.cmd.retrieve");
        }
        return resultData;
	}

	/**
	 * Cement Credit Memo 조회
	 * @param inputData 검색조건 입력 값
	 * @return Cement Credit Memo 목록 조회
	 * @throws LException
	 */
	public LMultiData retrieveCementCreditMemoMgntList(LData inputData) throws LException {

		LMultiData resultData = null;
        try {
        	LCommonDao dao = new LCommonDao( "/sd/sm/cementSalesMgntSql/retrieveCementCreditMemoMgntList",inputData );
        	resultData = dao.executeQuery();
        	
        } catch (Exception le ) {
        	LLog.err.write(this.getClass().getName()+"." +"retrieveCementCreditMemoMgntList()"+"=>"+le.getMessage());
            throw new LBizException("sd.sm.cmd.retrieve");
        }
        return resultData;
	}

	/**
	 * Cement Credit Memo Condition 조회
	 * @param inputData 검색조건 입력 값
	 * @return Cement Credit Memo Condition 목록 조회
	 * @throws LException
	 */
	public LMultiData retrieveCementCreditMemoCondition(LData inputData) throws LException {

		LMultiData resultData = null;
        try {
        	LCommonDao dao = new LCommonDao( "/sd/sm/cementSalesMgntSql/retrieveCementCreditMemoCondition",inputData );
        	resultData = dao.executeQuery();
        	
        } catch (Exception le ) {
        	LLog.err.write(this.getClass().getName()+"." +"retrieveCementCreditMemoCondition()"+"=>"+le.getMessage());
            throw new LBizException("sd.sm.cmd.retrieve");
        }
        return resultData;
	}

	/**
     * Cement Credit Memo 수정
     * @param inputData 
     * @return sales 목록 수정
     * @exception LException
     */
    public LData CudProdCPOCreditMemoMgnt(LMultiData inputm,  LData loginUser) throws LException {
 	
  		LCompoundDao dao = new LCompoundDao();
  		dao.startTransaction();  
  	 	LData seq 	= new LData();
    	LData Lrow  = new LData();
    	LData resultData = new LData();
		//LData oriSalesNoCheck = new LData();
    	try{
  
    		for(int i = 0 ; i < inputm.getDataCount() ; i++){
    			Lrow = inputm.getLData(i);	//List의 값
    			Lrow.set("userId", 	 loginUser.getString("userId"));
    			Lrow.set("companyCd",loginUser.getString("companyCd"));
    			Lrow.set("deptCd",loginUser.getString("companyCd"));
    			
    			LLog.info.write("\n CudProdCPOCreditMemoMgnt Biz --> inputData \n" +Lrow);	
	    			
    			String key = Lrow.getString("DEVON_CUD_FILTER_KEY");
        		//Delete
    			if(key.equals("DEVON_DELETE_FILTER_VALUE")){ 
						dao.add ("/sd/sm/cementSalesMgntSql/deleteCementCreditMemoMaster",  Lrow); 
						dao.executeUpdate();
				//Update
    			}else if(key.equals("DEVON_UPDATE_FILTER_VALUE")){
			    	dao.add ("/sd/sm/cementSalesMgntSql/updateCementCreditMemoMaster",  Lrow );
			    	dao.executeUpdate();
	    	    //Create
    			}else if(key.equals("DEVON_CREATE_FILTER_VALUE")){	
    	    		//Original Sales NO 중복 체크
    				/*20121116 Original Sales NO 중복체크 안하기로 함.
    				oriSalesNoCheck = dao.executeQueryForSingle("/sd/sm/cementSalesMgntSql/dupCheckOriSalesNo", Lrow);
    				if(oriSalesNoCheck.containsValue("EXIST")){
    					resultData.setString("returnType", "99");
    					resultData.setString("returnMsg", "The Original Sales No duplicate, \nCheck the Original Sales No!");
    					return resultData;
    				}
    				*/

    	    		seq = dao.executeQueryForSingle("/sd/sm/cementSalesMgntSql/createCementSalesNo", Lrow );
					Lrow.set("salesNo",  seq.get("salesNo"));
			    	dao.add ("/sd/sm/cementSalesMgntSql/createCementCreditMemoMaster",  Lrow );
			    	dao.executeUpdate();
				}
    		}

			resultData.setString("returnType", "00");
			resultData.setString("returnMsg", "Successfully Saved.");		
    		dao.commit(); 
        
    	} catch ( LException e ) {
        	dao.rollback();
        	LLog.err.println(  this.getClass().getName() + "." + "CudProdCPOCreditMemoMgnt()" + "=>" + e.getMessage());
        }	
    	
        return resultData;
    }

	/**
    * Sales Management List SAP send
    *
    * @param inputData Command로 부턴 전달받은 input LDataProtocol
    * 
    * @return LMultiData 조회된 리스트 결과.
    * @exception LException 메소드 수행시 발생한 모든 에러.
    */
    public LData CudCementSalesSapSend(LMultiData headerData, LData loginUser) throws LException {
		
    	LLog.info.write("\n Biz > CudCementSalesSapSend() ------------- Start \n");
    	
        LCompoundDao dao		= new LCompoundDao();
        LCommonDao xdao = new LCommonDao();
        LCommonDao statusDao = new LCommonDao();
	
		LData resultSap		    = new LData();
		LData resultMsg		    = new LData();
		LMultiData bodyData		    = new LMultiData();
		
		GSD01 gsd01 = new GSD01();
		GSD03 gsd03 = new GSD03();
		
		try{
			
			//xmldocno 채번
			LData xmlNo = xdao.executeQueryForSingle("cm/cm/commCodeMgntSql/retireveXmlDocNo", loginUser);			
	    	LLog.info.write("\n Biz > xmlNo() ------------- > "+xmlNo);
	    
			dao.startTransaction();
			
			for(int i=0; i<headerData.getDataCount(); i++) {
			
				LData header = headerData.getLData(i);
				header.setString("userId", 	loginUser.getString("userId"));
				header.setString("deptCd", 	loginUser.getString("deptCd"));
				header.setString("companyCd", 	loginUser.getString("companyCd"));
				header.setString("zxmldocno", xmlNo.getString("zxmldocno")); //xmldocno
				//header.setString("transDate", xmlNo.getString("transDate")); //send Date
				
				if (headerData.getString("status", i).equals("0")) { //신규 전송 건
					header.setString("zsseq", header.getString("sapSeq"));
					header.setString("bstkd", "");
					header.setString("deliveryDate", header.getString("salesDate")); 
					header.setString("postDate", header.getString("salesDate")); 
					
					header.setString("transDate", xmlNo.getString("transDate")); //send Date : 신규 전송 시
					
					header.setString("canceltype", ""); 
					header.setString("vendorCd", header.getString("customerCd")); 
					header.setString("vendorCd2", header.getString("customerCd")); 
//					header.setString("deptCd", 	"ZORI");
					header.setString("plantCd", 	"GA10"); //Plant
					header.setString("storLoct", 	"");
					header.setString("groupcd", 	"GA1"); //Sales Group
					header.setString("payKey1", 	header.getString("payTerm"));
					header.setString("payKey2", 	"");
					header.setString("amt2", 	"");
					header.setString("payKey3", 	"");
					header.setString("amt3", 	"");
					header.setString("payKey4","");
					header.setString("amt4", "");
					header.setString("psType", 	"S");
					header.setString("bwart", 	"");
					header.setString("fkdatRe", 	header.getString("salesDate"));
					header.setString("attr1", 	"");
					header.setString("attr2", 	"");
					header.setString("attr3", 	"");
					header.setString("attr4", 	"");
					header.setString("attr5", 	"");
					header.setString("attr6", 	"");
					header.setString("attr7", 	"");
					header.setString("attr8", 	"");
					header.setString("attr9", 	"");
					header.setString("attr10", "");

					//전송시 상태 0(sales confirm)인지 재확인	
					 LData checkStatus = statusDao.executeQueryForSingle( "/sd/sm/cementSalesMgntSql/checkSendingStatus" , header );
					 LLog.info.write("SAP 전송할때의 status----->: " +checkStatus.getString("status"));								 
					 if(checkStatus.getString("status").equals("0")){
						
						 //전송시 상태 8(sending)으로 변경
						statusDao = new LCommonDao( "/sd/sm/cementSalesMgntSql/cudCementSalesListUpdateSendingStatus" , header );
						statusDao.executeUpdate();
						
						LCommonDao commonDao = new LCommonDao( "/sd/sm/cementSalesMgntSql/cudCementSalesSapSend" , header );
						bodyData = commonDao.executeQuery();
						
						resultMsg = gsd01.GSD01_out(header, bodyData);
						
						header.setString("sapSeq", resultMsg.getString("returnSapSeq"));
						
						if (resultMsg.getString("returnStatus").equals("00")) {	
							dao.add ("/sd/sm/cementSalesMgntSql/cudCementSalesAfterSapSuccess", header ); 
							dao.executeUpdate();			
							dao.commit();							
							gsd03.GSD03_out(header);	
						} else {
							dao.rollback();
						}
					 }else{ //전송시 상태0이 아닌경우
						 resultMsg.set("returnStatus", "98765");
						 resultMsg.set("returnMsg", "Check status again. Can not send when the status is Sending.");
						 resultMsg.set("returnSapSeq", "0");
					 }
				}else if(!"0".equals(headerData.getString("status", i)) || !"6".equals(headerData.getString("status", i)) 
						|| !"8".equals(headerData.getString("status", i)) || !"9".equals(headerData.getString("status", i))){ //신규전송아닌경우
					gsd03.GSD03_out(header);
					
					resultMsg.setString("returnStatus","00");
				}
			}

		} catch (Exception se) {
			dao.rollback();
			throw new LBizException("sd.sm.cmd.send - " + "I/F Connection Error");
		}
		
		resultSap.put("returnStatus",resultMsg.getString("returnStatus"));
		resultSap.put("returnMsg"	,resultMsg.getString("returnMsg"));
		resultSap.put("returnSapSeq",resultMsg.getString("returnSapSeq"));

		return resultSap;
}

	/**
	 * Sales Management List SAP Cancel
	 *
	 * @param inputData Command로 부턴 전달받은 input LDataProtocol
	 * 
	 * @return LMultiData 조회된 리스트 결과.
	 * @exception LException 메소드 수행시 발생한 모든 에러.
	 */
	public LData CudCementSalesSapCancel(LMultiData headerData, LData loginUser) throws LException {
		LLog.info.write("\n Biz > CudCementSalesSapCancel() ------------- Start \n");
		
	    LCommonDao xdao = new LCommonDao();
	
		LData resultMsg		    = new LData();
		LData xmlNo             = new LData();
		
		GSD03 gsd03 = new GSD03();
		
		try{    
			      
			xmlNo = xdao.executeQueryForSingle("cm/cm/commCodeMgntSql/retireveXmlDocNo", loginUser);
			
			for(int i=0; i<headerData.getDataCount(); i++) {
				LData rowData = headerData.getLData(i);
				if(!"0".equals(headerData.getString("status", i)) || !"8".equals(headerData.getString("status", i)) || !"9".equals(headerData.getString("status", i))){	
					rowData.setString("zxmldocno", xmlNo.getString("zxmldocno")); //xmldocno
					rowData.setString("companyCd", 	loginUser.getString("companyCd"));
					rowData.setString("billDate", rowData.getString("salesDate")); //Cancel Date
					rowData.setString("cancelType", "X"); //Cancel Date
	
					gsd03.GSD03_out(rowData);
				}
			}
			
			resultMsg.setLong("returnStatus", 00);
			resultMsg.setString("returnMsg", "Success");
	
		} catch (Exception se) {
			throw new LBizException("sd.sm.cmd.cancel - " + "I/F Connection Error");
		}
	
		return resultMsg;
	}
	
	/**
	 * Credit Memo List SAP send
	 *
	 * @param inputData Command로 부턴 전달받은 input LDataProtocol
	 * 
	 * @return LMultiData 조회된 리스트 결과.
	 * @exception LException 메소드 수행시 발생한 모든 에러.
	 */
	public LData CudCementCreditMemoSapSend(LMultiData headerData, LData loginUser) throws LException {
		
		LLog.info.write("\n Biz > CudCementCreditMemoSapSend() ------------- Start \n");
		
	    LCompoundDao dao		= new LCompoundDao();
	    LCommonDao xdao = new LCommonDao();
	    LCommonDao statusDao = new LCommonDao();
	
		LData resultSap		    = new LData();
		LData resultMsg		    = new LData();
		LMultiData bodyData		    = new LMultiData();
		
		GSD01 gsd01 = new GSD01();
		GSD03 gsd03 = new GSD03();
		
		try{
			
			//xmldocno 채번
			LData xmlNo = xdao.executeQueryForSingle("cm/cm/commCodeMgntSql/retireveXmlDocNo", loginUser);			
	    	LLog.info.write("\n Biz > xmlNo() ------------- > "+xmlNo);
	    
			dao.startTransaction();
			
			for(int i=0; i<headerData.getDataCount(); i++) {
			
				LData header = headerData.getLData(i);
				header.setString("userId", 	loginUser.getString("userId"));
				header.setString("deptCd", 	loginUser.getString("deptCd"));
				header.setString("companyCd", 	loginUser.getString("companyCd"));
				header.setString("zxmldocno", xmlNo.getString("zxmldocno")); //xmldocno
				header.setString("transDate", xmlNo.getString("transDate")); //send Date
	
				if (headerData.getString("status", i).equals("0")) { //신규 전송 건
					header.setString("zsseq", header.getString("sapSeq"));
					header.setString("bstkd", "");
					header.setString("deliveryDate", header.getString("docDate")); 
					header.setString("postDate", header.getString("postingDate")); 
					header.setString("canceltype", ""); 
					header.setString("vendorCd", header.getString("customerCd")); 
					header.setString("vendorCd2", header.getString("customerCd")); 
	//				header.setString("deptCd", 	"ZORI");
					header.setString("plantCd", 	"GA10");
					header.setString("storLoct", 	"");
					header.setString("groupcd", 	"GA1");
					header.setString("payKey1", 	header.getString("payTerm"));
					header.setString("payKey2", 	"");
					header.setString("amt2", 	"");
					header.setString("payKey3", 	"");
					header.setString("amt3", 	"");
					header.setString("payKey4","");
					header.setString("amt4", "");
					header.setString("psType", 	"P");
					header.setString("bwart", 	"");
					header.setString("fkdatRe", 	header.getString("salesDate"));
					header.setString("attr1", 	header.getString("orgBillingNo"));
					header.setString("attr2", 	header.getString("conditionValue"));
					header.setString("attr3", 	header.getString("memoType"));
					header.setString("attr4", 	"");
					header.setString("attr5", 	"");
					header.setString("attr6", 	"");
					header.setString("attr7", 	"");
					header.setString("attr8", 	"");
					header.setString("attr9", 	"");
					header.setString("attr10", "");
	
					//전송시 상태 0(sales confirm)인지 재확인	
					 LData checkStatus = statusDao.executeQueryForSingle( "/sd/sm/cementSalesMgntSql/checkCreditMemoSendingStatus" , header );
					 LLog.info.write("SAP 전송할때의 status----->: " +checkStatus.getString("status"));								 
					 if(checkStatus.getString("status").equals("0")){
						
						 //전송시 상태 8(sending)으로 변경
						statusDao = new LCommonDao( "/sd/sm/cementSalesMgntSql/cudCementCreditMemoUpdateSendingStatus" , header );
						statusDao.executeUpdate();
						
						LCommonDao commonDao = new LCommonDao( "/sd/sm/cementSalesMgntSql/cudCementSalesSapSend" , header );
						bodyData = commonDao.executeQuery();
						
						resultMsg = gsd01.GSD01_out(header, bodyData);
						
						header.setString("sapSeq", resultMsg.getString("returnSapSeq"));
						
						System.out.println(resultMsg);
						
						if (resultMsg.getString("returnStatus").equals("00")) {	
							dao.add ("/sd/sm/cementSalesMgntSql/cudCementCreditMemosAfterSapSuccess", header ); 
							dao.executeUpdate();			
							dao.commit();							
							gsd03.GSD03_out(header);	
						} else {
							dao.rollback();
						}
					 }else{ //전송시 상태0이 아닌경우
						 resultMsg.set("returnStatus", "98765");
						 resultMsg.set("returnMsg", "Check status again. Can not send when the status is Sending.");
						 resultMsg.set("returnSapSeq", "0");
					 }
				}else if(!"0".equals(headerData.getString("status", i)) || !"6".equals(headerData.getString("status", i)) 
						|| !"8".equals(headerData.getString("status", i)) || !"9".equals(headerData.getString("status", i))){ //신규전송아닌경우
					gsd03.GSD03_out(header);
					
					resultMsg.setString("returnStatus","00");
				}
			}
	
		} catch (Exception se) {
			dao.rollback();
			throw new LBizException("sd.sm.cmd.send - " + "I/F Connection Error");
		}
		
		resultSap.put("returnStatus",resultMsg.getString("returnStatus"));
		resultSap.put("returnMsg"	,resultMsg.getString("returnMsg"));
		resultSap.put("returnSapSeq",resultMsg.getString("returnSapSeq"));
	
		return resultSap;
	}
	
	/**
	 * Sales Management List SAP Cancel
	 *
	 * @param inputData Command로 부턴 전달받은 input LDataProtocol
	 * 
	 * @return LMultiData 조회된 리스트 결과.
	 * @exception LException 메소드 수행시 발생한 모든 에러.
	 */
	public LData CudCpoCreditMemoSapCancel(LMultiData headerData, LData loginUser) throws LException {
		LLog.info.write("\n Biz > CudCpoCreditMemoSapCancel() ------------- Start \n");
		
	    LCommonDao xdao = new LCommonDao();
	
		LData resultMsg		    = new LData();
		LData xmlNo             = new LData();
		
		GSD03 gsd03 = new GSD03();
		
		try{    
			      
			xmlNo = xdao.executeQueryForSingle("cm/cm/commCodeMgntSql/retireveXmlDocNo", loginUser);
			
			for(int i=0; i<headerData.getDataCount(); i++) {
				LData rowData = headerData.getLData(i);
				if(!"0".equals(headerData.getString("status", i)) || !"1".equals(headerData.getString("status", i))
						|| !"8".equals(headerData.getString("status", i)) || !"9".equals(headerData.getString("status", i))){	
					rowData.setString("zxmldocno", xmlNo.getString("zxmldocno")); //xmldocno
					rowData.setString("companyCd", 	loginUser.getString("companyCd"));
					rowData.setString("billDate", rowData.getString("salesDate")); //Cancel Date
					rowData.setString("cancelType", "X"); //Cancel Date
					rowData.setString("transDate", rowData.getString("transDate")); 
					rowData.setString("sapSeq", rowData.getString("sapSeq")); 
	
					gsd03.GSD03_out(rowData);
				}
			}
			
			resultMsg.setLong("returnStatus", 00);
			resultMsg.setString("returnMsg", "Success");
	
		} catch (Exception se) {
			throw new LBizException("sd.sm.cmd.cancel - " + "I/F Connection Error");
		}
	
		return resultMsg;
	}
	
	/**
	 * Prod & Sales Histroy 조회
	 * @param inputData 검색조건 입력 값
	 * @return Production & Sales 목록 조회
	 * @throws LException
	 */
	public LMultiData retrieveCementSalesHistoryList(LData inputData) throws LException {
	
		LMultiData resultData = null;
	    try {
	    	LCommonDao dao = new LCommonDao( "/sd/sm/cementSalesMgntSql/retrieveCementSalesHistoryList",inputData );
	    	resultData = dao.executeQuery();
	    	
	    } catch (Exception le ) {
	    	LLog.err.write(this.getClass().getName()+"." +"retrieveCementSalesHistoryList()"+"=>"+le.getMessage());
	        throw new LBizException("ps.hv.cmd.retrieve");
	    }
	    return resultData;
	}
	
	/**
	 * Prod & Sales Histroy 조회
	 * @param inputData 검색조건 입력 값
	 * @return Production & Sales 목록 조회
	 * @throws LException
	 */
	public LData RetrieveCustomerCreditLimit(LData headerData, LMultiData bodyData) throws LException {
	
		RetrieveCustomerCreditLimitRFC rbiz = new RetrieveCustomerCreditLimitRFC();
		LMultiData result = new LMultiData();
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date nowDate = new Date();
		
		double salesAmount = 0.0;
		String creditMsg = "";
		
		LData resultData = new LData();
		LData salesData = new LData();
		
		
	    try {
	    	
	    	resultData.setString("creditYn", "N");
	    	resultData.setString("creditMsg", "Exceed Credit Limit. Check Credit Exposure.");
	    	
	    	//해당 판매 건의 금액 확인
	    	for (int i = 0 ; i < bodyData.getDataCount(); i++ ) {
	    		salesAmount = salesAmount + bodyData.getDouble("salesAmt", i);
	    	}
	    	
	    	//SAP 기준 여신 현황
	    	result = rbiz.getVendorCreditLimit(headerData);
	    	
	    	for (int i = 0; i < result.getDataCount(); i++) {
	    		
	    		Date formDate = format.parse(result.getString("DATAB", i));
	    		Date toDate = format.parse(result.getString("DATBI", i));
	    		
	    		LLog.debug.write("WEB 등록 여신 체크 전(SAP 여신)");
	    		System.out.println(result);
	    		
	    		LLog.debug.write("Current Date : " + nowDate);
	    		LLog.debug.write("Form Date : " + formDate);
	    		LLog.debug.write("To Date  : " + toDate);
	    		
	    		if (nowDate.before(toDate)) {
	    			
	    			if (nowDate.after(formDate)) {
	    				
	    				LLog.debug.write("여신 유효 기간 OK!");
	    				
	    				//WEB 기 등록 한 Open Sales 금액 조회
	    				LCommonDao dao = new LCommonDao( "/sd/sc/customerCreditSql/retrieveCustomerSalesAmount", headerData );
	    				salesData = dao.executeQueryForSingle();
	    				
	    				
	    				if (!salesData.isEmpty()) {
	    					salesAmount = salesAmount + salesData.getDouble("salesAmount");
	    				} 
	    				
	    				//result.modifyDouble("OPEN_SALES", i, result.getDouble("OPEN_SALES", i) + salesAmount); //SAP Open S/O 금액 + WEB S/O 금액
	    				result.modifyDouble("OPEN_SALES_WEB", i, salesAmount); //WEB S/O 금액
	    				result.modifyDouble("clExposure", i, result.getDouble("SKFOR", i) + result.getDouble("OPEN_SALES", i) 
	    						                             + result.getDouble("OPEN_SALES_WEB", i) - result.getDouble("SSOBL", i)); //여신 사용 금액 업데이트 
	    				result.modifyDouble("clAvailable", i, result.getDouble("cl", i) - result.getDouble("clExposure", i)); //여신 잔액 업데이트
	    				
	    				LLog.debug.write("WEB 등록 여신 체크 후");
	    	    		System.out.println(result);
	    	    		
	    	    		if (result.getDouble("clAvailable", i) >= 0) {
	    	    			resultData.setString("creditYn", "Y");
	    	    			resultData.setString("creditMsg", "Customer Credit Available.");
	    	    		}
	    				
	    			} else {
	    				LLog.debug.write("여신 유효 기간 NG! : 시작일 보다 작음");
	    			}
	    		} else {
	    			LLog.debug.write("여신 유효 기간 NG! : 종료일 보다 큼");
	    		}
	    	}
	    	
	    	
	    	
	    } catch (Exception le ) {
	    	LLog.err.write(this.getClass().getName()+"." +"retrieveCementSalesHistoryList()"+"=>"+le.getMessage());
	        throw new LBizException("ps.hv.cmd.retrieve");
	    }
	    return resultData;
	}

}
 
