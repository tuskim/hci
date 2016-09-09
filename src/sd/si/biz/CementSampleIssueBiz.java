/*
 *------------------------------------------------------------------------------
 * CementSampleIssueBiz.java,v 1.0 2016/08/02  
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

package sd.si.biz;

import xi.GSD01;
import xi.GSD03;
import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LBizException;
import devon.core.exception.LException;
import devon.core.log.LLog;
import devonframework.persistent.autodao.LCommonDao;
import devonframework.persistent.autodao.LCompoundDao;
/**
 * <PRE>
 * Cement Sample Issue 업무를 처리하는 Biz 클래스.
 *
 * Database Tables : 
 * </PRE>
 * @author    LTK
 */
public class CementSampleIssueBiz {

	/**
	 * Cement Sales 조회
	 * @param inputData 검색조건 입력 값
	 * @return Cement Sales 목록 조회
	 * @throws LException
	 */
	public LMultiData retrieveCementSampleIssueMasterList(LData inputData) throws LException {

		LMultiData resultData = null;
        try {
        	LCommonDao dao = new LCommonDao( "/sd/si/cementSampleIssueSql/retrieveCementSampleIssueMasterList",inputData );
        	resultData = dao.executeQuery();
        	
        } catch (Exception le ) {
        	LLog.err.write(this.getClass().getName()+"." +"retrieveCementSampleIssueMasterList()"+"=>"+le.getMessage());
            throw new LBizException("sd.si.cmd.retrieve");
        }
        return resultData;
	}

	/**
	 * Cement Detail Sales 조회
	 * @param inputData 검색조건 입력 값
	 * @return Cement Detail Sales 목록 조회
	 * @throws LException
	 */
	public LMultiData retrieveCementSampleIssueDetailList(LData inputData) throws LException {

		LMultiData resultData = null;
        try {
        	LCommonDao dao = new LCommonDao( "/sd/si/cementSampleIssueSql/retrieveCementSampleIssueDetailList",inputData );
        	resultData = dao.executeQuery();
        	
        } catch (Exception le ) {
        	LLog.err.write(this.getClass().getName()+"." +"retrieveCementSampleIssueDetailList()"+"=>"+le.getMessage());
            throw new LBizException("sd.si.cmd.retrieve");
        }
        return resultData;
	}

	/**
     * Cement master Sales
     * @param inputData 
     * @return sales 목록 조회 수정
     * @exception LException
     */
	public LData cudCementSampleIssue(LMultiData lmdMasterList, LMultiData lmdDetailList, LData loginUser) throws LException {

		LCompoundDao dao = new LCompoundDao();
		dao.startTransaction();
		LData seq = new LData();
		LData ldMaster = new LData();
		LData Lrow2 = new LData();
		LData resultData = new LData();
		
		
		try {

			for (int i = 0; i < lmdMasterList.getDataCount(); i++) {
				ldMaster = lmdMasterList.getLData(i); // List의 값
				ldMaster.set("userId", loginUser.getString("userId"));
				ldMaster.set("companyCd", loginUser.getString("companyCd"));
				ldMaster.set("deptCd", loginUser.getString("deptCd"));

				LLog.info.write("\n CudCementSampleIssue Biz --> inputData \n" + ldMaster);

				String key = ldMaster.getString("DEVON_CUD_FILTER_KEY");
				if (key.equals("DEVON_DELETE_FILTER_VALUE")) {
					// Delete
					dao.add("/sd/si/cementSampleIssueSql/deleteMaster", ldMaster);
					dao.add("/sd/si/cementSampleIssueSql/deleteDetailList", ldMaster);
					dao.executeUpdate();
					// Update
				} else if (key.equals("DEVON_UPDATE_FILTER_VALUE")) {
					dao.add("/sd/si/cementSampleIssueSql/updateMaster", ldMaster);
					dao.executeUpdate();

					// CPO detail
					for (int j = 0; j < lmdDetailList.getDataCount(); j++) {
						Lrow2 = lmdDetailList.getLData(j); // List의 값
						Lrow2.set("salesDate", ldMaster.get("salesDate"));
						Lrow2.set("salesNo", ldMaster.get("salesNo"));
						Lrow2.set("userId", loginUser.getString("userId"));
						Lrow2.set("companyCd", loginUser.getString("companyCd"));
						Lrow2.set("deptCd", loginUser.getString("deptCd"));

						LLog.info.write("\n CudCementSampleIssue Biz --> Cement Update Detail \n" + Lrow2);
						String key2 = Lrow2.getString("DEVON_CUD_FILTER_KEY");
						if (key2.equals("DEVON_DELETE_FILTER_VALUE")) {
							dao.add("/sd/si/cementSampleIssueSql/deleteDetail", Lrow2);
							dao.executeUpdate();
						} else if (key2.equals("DEVON_UPDATE_FILTER_VALUE")) {
							dao.add("/sd/si/cementSampleIssueSql/updateDetail", Lrow2);
							dao.executeUpdate();
						} else if (key2.equals("DEVON_CREATE_FILTER_VALUE")) {
							dao.add("/sd/si/cementSampleIssueSql/createDetail", Lrow2);
							dao.executeUpdate();
						}
					}
					// Create
				} else if (key.equals("DEVON_CREATE_FILTER_VALUE")) {
					seq = dao.executeQueryForSingle("/sd/si/cementSampleIssueSql/createCementSampleIssueNo", ldMaster);
					ldMaster.set("salesNo", seq.get("salesNo"));
					dao.add("/sd/si/cementSampleIssueSql/createMaster", ldMaster);
					dao.executeUpdate();

					// CPO detail
					for (int j = 0; j < lmdDetailList.getDataCount(); j++) {
						Lrow2 = lmdDetailList.getLData(j); // List의 값
						Lrow2.set("salesNo", seq.get("salesNo"));
						Lrow2.set("salesDate", ldMaster.get("salesDate"));
						Lrow2.set("userId", loginUser.getString("userId"));
						Lrow2.set("companyCd", loginUser.getString("companyCd"));
						Lrow2.set("deptCd", loginUser.getString("deptCd"));
						LLog.info.write("\n CudCementSampleIssue Biz --> Cement Create Detail \n" + Lrow2);
						dao.add("/sd/si/cementSampleIssueSql/createDetail", Lrow2);
						dao.executeUpdate();
					}
				}
			}

			resultData.setString("returnType", "00");
			resultData.setString("returnMsg", "Successfully Saved.");
			dao.commit();

		} catch (LException e) {
			dao.rollback();
			LLog.err.println(this.getClass().getName() + "." + "CudCementSampleIssue()" + "=>" + e.getMessage());
		}

		return resultData;
	}  

	/**
	* Cement detail List 수정시
	* @param inputData 검색조건 입력 값
	* @throws LException
	*/
	public void cudCementSampleIssueDetailList(LMultiData lmdDetailList, LData loginUser) throws LException {
			LCompoundDao dao = new LCompoundDao();
			dao.startTransaction();  
			LData ldDetail = new LData();
			LLog.info.write("\n cudCementDetailList Biz --> start \n");
			try{  
				for(int i = 0 ; i < lmdDetailList.getDataCount() ; i++){
					ldDetail = lmdDetailList.getLData(i);	
					ldDetail.set("userId",   loginUser.getString("userId"));
					ldDetail.set("companyCd",loginUser.getString("companyCd"));
				 	LLog.info.write("\n cudCementDetailList Biz --> Sales detail \n" +ldDetail);	
				 	
				 	String key = ldDetail.getString("DEVON_CUD_FILTER_KEY");
					if(key.equals("DEVON_DELETE_FILTER_VALUE")){ 
						dao.add ("/sd/si/cementSampleIssueSql/deleteDetail", ldDetail ); 
						dao.executeUpdate();	
					}else if(key.equals("DEVON_UPDATE_FILTER_VALUE")){
					    dao.add ("/sd/si/cementSampleIssueSql/updateDetail", ldDetail ); 
			    		dao.executeUpdate();				
				    }else if(key.equals("DEVON_CREATE_FILTER_VALUE")){
			    		dao.add ("/sd/si/cementSampleIssueSql/createDetail", ldDetail );
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
	    * Sales Management List SAP send
	    *
	    * @param inputData Command로 부턴 전달받은 input LDataProtocol
	    * 
	    * @return LMultiData 조회된 리스트 결과.
	    * @exception LException 메소드 수행시 발생한 모든 에러.
	    */
	    public LData cudCementSampleIssueSapSend(LMultiData lmdMasterList, LData loginUser) throws LException {
			
	    	LLog.info.write("\n Biz > cudCementSampleIssueSapSend() ------------- Start \n");
	    	
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
				
				for(int i=0; i<lmdMasterList.getDataCount(); i++) {
				
					LData header = lmdMasterList.getLData(i);
					header.setString("userId", 	loginUser.getString("userId"));
					header.setString("deptCd", 	loginUser.getString("deptCd"));
					header.setString("companyCd", 	loginUser.getString("companyCd"));
					header.setString("zxmldocno", xmlNo.getString("zxmldocno")); //xmldocno
					//header.setString("transDate", xmlNo.getString("transDate")); //send Date
					
					if (lmdMasterList.getString("status", i).equals("0")) { //신규 전송 건
						header.setString("zsseq", header.getString("sapSeq"));
						header.setString("bstkd", "");
						header.setString("deliveryDate", header.getString("salesDate")); 
						header.setString("postDate", header.getString("salesDate")); 
						
						header.setString("transDate", xmlNo.getString("transDate")); //send Date : 신규 전송 시
						
						header.setString("canceltype", ""); 
						header.setString("vendorCd", header.getString("customerCd")); 
						header.setString("vendorCd2", header.getString("customerCd")); 
//						header.setString("deptCd", 	"ZORI");
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
						 LData checkStatus = statusDao.executeQueryForSingle( "/sd/si/cementSampleIssueSql/checkSendingStatus" , header );
						 LLog.info.write("SAP 전송할때의 status----->: " +checkStatus.getString("status"));								 
						 if(checkStatus.getString("status").equals("0")){
							
							 //전송시 상태 8(sending)으로 변경
							statusDao = new LCommonDao( "/sd/si/cementSampleIssueSql/cudCementSampleIssueListUpdateSendingStatus" , header );
							statusDao.executeUpdate();
							
							LCommonDao commonDao = new LCommonDao( "/sd/si/cementSampleIssueSql/retrieveCementSampleIssueSapSend" , header );
							bodyData = commonDao.executeQuery();
							
							resultMsg = gsd01.GSD01_out(header, bodyData);
							
							header.setString("sapSeq", resultMsg.getString("returnSapSeq"));
							header.setString("giIfDocSeq", resultMsg.getString("returnSapGiNo"));
							
							if (resultMsg.getString("returnStatus").equals("00")) {	
								dao.add ("/sd/si/cementSampleIssueSql/cudCementSampleIssueAfterSapSuccess", header ); 
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
					}else if(!"0".equals(lmdMasterList.getString("status", i)) || !"6".equals(lmdMasterList.getString("status", i)) 
							|| !"8".equals(lmdMasterList.getString("status", i)) || !"9".equals(lmdMasterList.getString("status", i))){ //신규전송아닌경우
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
		public LData cudCementSampleIssueSapCancel(LMultiData headerData, LData loginUser) throws LException {
			LLog.info.write("\n Biz > CudCementSampleIssueSapCancel() ------------- Start \n");
			
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
		

}
 
