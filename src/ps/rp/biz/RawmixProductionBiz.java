/*
 *------------------------------------------------------------------------------
 * RawmixProductionBiz.java,v 1.0 2010/08/19 17:30:35 
 * 
 * PROJ : PT-PAM
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2010/08/19   mskim   Init
 *----------------------------------------------------------------------------
 */

package ps.rp.biz;

import xi.GMM11;
import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LBizException;
import devon.core.exception.LException;
import devon.core.exception.LSysException;
import devon.core.log.LLog;
import devonframework.persistent.autodao.LCommonDao;
import devonframework.persistent.autodao.LCompoundDao;

/**
 * <PRE>
 * Raw Mix Production 업무를 처리하는 Biz 클래스.
 * 
 * Database Tables :
 * </PRE>
 * 
 * @author CEH
 */
public class RawmixProductionBiz {

	/**
	 * Raw Mix Production 정보를 조회하는 메소드.
	 * 
	 * @param inputData
	 *            Command로 부턴 전달받은 input LDataProtocol
	 * 
	 * @return LMultiData 조회된 리스트 결과.
	 * @exception LException
	 *                메소드 수행시 발생한 모든 에러.
	 */
	public LMultiData retrieveRawmixProductionMasterList(LData inputData) throws LException {

		LLog.debug.write("retrieveRawmixProductionMasterList-----------> Start ");

		LCommonDao dao = new LCommonDao();
		try {
			return dao.executeQuery("ps/rp/rawmixProductionSql/retrieveRawmixProductionMasterList", inputData);
		} catch (Exception se) {
			LLog.err.println(this.getClass().getName() + "." + "retrieveRawmixProductionMasterList------()" + "=>" + se.getMessage());
			throw new LSysException("ps.rp.retrieveRawmixProductionMasterList", se);
		}
	}

	
    /**
     * Raw Mix Production Excel 다운 정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveRawmixProductionExcelList(LData inputData) throws LException {    	
    	
		LLog.debug.write("retrieveRawmixProductionExcelList-----------> Start ");

		LCommonDao dao = new LCommonDao();
		try {
			return dao.executeQuery("ps/rp/rawmixProductionSql/retrieveRawmixProductionExcelList", inputData);
		} catch (Exception se) {
			LLog.err.println(this.getClass().getName() + "." + "retrieveRawmixProductionExcelList------()" + "=>" + se.getMessage());
			throw new LSysException("ps.rp.retrieveRawmixProductionExcelList", se);
		}
    }	
    

	/**
	 * Raw Mix Production 정보를 조회하는 메소드.
	 * 
	 * @param inputData
	 *            Command로 부턴 전달받은 input LDataProtocol
	 * 
	 * @return LMultiData 조회된 리스트 결과.
	 * @exception LException
	 *                메소드 수행시 발생한 모든 에러.
	 */
	public LMultiData retrieveRawmixProductionMasterProdDate(LData inputData) throws LException {
		
		LLog.debug.write("retrieveRawmixProductionMasterProdDate-----------> Start ");
		
		LCommonDao dao = new LCommonDao();
		try {
			return dao.executeQuery("ps/rp/rawmixProductionSql/retrieveRawmixProductionMasterProdDate", inputData);
		} catch (Exception se) {
			LLog.err.println(this.getClass().getName() + "." + "retrieveRawmixProductionMasterProdDate------()" + "=>" + se.getMessage());
			throw new LSysException("ps.rp.retrieveRawmixProductionMasterProdDate", se);
		}
	}
        
    
    
	/**
     * Raw Mix Production Add Row 데이터 조회
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveClinkerProductionAddRow(LData inputData) throws LException {
        LMultiData list = null;

        try {
        	
        	String sql = "";
        	
        	if(inputData.getString("dsType").equals("master")){
        		sql = "ps/rp/rawmixProductionSql/retrieveRawmixProductionMasterAdd";
        	}else if(inputData.getString("dsType").equals("detail")){
        		sql = "ps/rp/rawmixProductionSql/retrieveRawmixProductionDetailAddList";
        	}else if(inputData.getString("dsType").equals("result")){
        		sql = "ps/rp/rawmixProductionSql/retrieveRawmixProductionResultAdd";
        	}
            
            LCommonDao dao = new LCommonDao(sql, inputData);
            list = dao.executeQuery();
            
        } catch (LException le) {
            LLog.err.write(this.getClass().getName() + "." + "RetrievecodeCbList()" + "=>" + le.getMessage());
            throw new LBizException("cm.cm.com.retrieve");
        }
        return list;

    }	

	/**
	 * Search Raw Mix Production Detail 정보를 조회하는 메소드.
	 * 
	 * @param inputData
	 *            Command로 부턴 전달받은 input LDataProtocol
	 * 
	 * @return LMultiData 조회된 리스트 결과.
	 * @exception LException
	 *                메소드 수행시 발생한 모든 에러.
	 */
	public LMultiData retrieveRawmixProductionDetailList(LData inputData) throws LException {

		LLog.debug.write("retrieveRawmixProductionDetailList -----------> Start ");

		LCommonDao dao = new LCommonDao();
		try {
			return dao.executeQuery("ps/rp/rawmixProductionSql/retrieveRawmixProductionDetailList", inputData);
		} catch (Exception se) {
			LLog.err.println(this.getClass().getName() + "." + "retrieveRawmixProductionDetailList------()" + "=>" + se.getMessage());
			throw new LSysException("ps.rp.retrieveRawmixProductionAppList", se);
		}
	}

	/**
	 * Search Raw Mix Production Result 정보를 조회하는 메소드.
	 * 
	 * @param inputData
	 *            Command로 부턴 전달받은 input LDataProtocol
	 * 
	 * @return LMultiData 조회된 리스트 결과.
	 * @exception LException
	 *                메소드 수행시 발생한 모든 에러.
	 */
	public LMultiData retrieveRawmixProductionResultList(LData inputData) throws LException {

		LLog.debug.write("retrieveRawmixProductionResultList -----------> Start ");

		LCommonDao dao = new LCommonDao();
		try {
			return dao.executeQuery("ps/rp/rawmixProductionSql/retrieveRawmixProductionResultList", inputData);
		} catch (Exception se) {
			LLog.err.println(this.getClass().getName() + "." + "retrieveRawmixProductionResultList------()" + "=>" + se.getMessage());
			throw new LSysException("ps.rp.retrieveRawmixProductionAppList", se);
		}
	}

	/**
	 * Raw Mix Production 정보를 저장 하는 메소드.
	 * 
	 * @param inputData
	 *            Command로 부턴 전달받은 input LDataProtocol
	 * 
	 * @return LMultiData 조회된 리스트 결과.
	 * @exception LException
	 *                메소드 수행시 발생한 모든 에러.
	 */
	public LData cudRawmixProduction(LMultiData masterMData, LMultiData detailMData, LMultiData resultMData, LData loginUser) throws LException {

		LLog.info.write("\n cudRawmixProduction ------------- Start \n");

		LCompoundDao dao = new LCompoundDao();
		LData result = new LData();

		String getErrorCode = "0";
		String getMessage = "";
		// String getStatus = "";

		try {

			dao.startTransaction(); // 트랜잭션 시작


	        /////////////////////////////////////////////////////////////////////////////////
			// master data 처리
			for (int i = 0; i < masterMData.getDataCount(); i++) {

				LData cudMasterData = masterMData.getLData(i);
				
				////////////////////////////////////////////////////////////
				// 세션정보
				cudMasterData.setString("userId", loginUser.getString("userId"));
				cudMasterData.setString("companyCd", loginUser.getString("companyCd"));
				cudMasterData.setString("lang", loginUser.getString("lang"));
				////////////////////////////////////////////////////////////

				String tr_Mode = cudMasterData.getString("DEVON_CUD_FILTER_KEY"); // CUD 모드 가져오기
				if (tr_Mode.equals("DEVON_CREATE_FILTER_VALUE")) {
					////////////////////////////////////////////////////////////
					// 신규

					////////////////////////////////////////////
					// DAO SQL 추가
					dao.add("ps/rp/rawmixProductionSql/cudRawmixProductionMasterInsert", cudMasterData);
					////////////////////////////////////////////

					////////////////////////////////////////////////////////////
				} else if (tr_Mode.equals("DEVON_UPDATE_FILTER_VALUE")) {
					////////////////////////////////////////////////////////////
					// 수정

					////////////////////////////////////////////
					// DAO SQL 추가
					dao.add("ps/rp/rawmixProductionSql/cudRawmixProductionMasterUpdate", cudMasterData);
					////////////////////////////////////////////

					////////////////////////////////////////////////////////////
				} else if (tr_Mode.equals("DEVON_DELETE_FILTER_VALUE")) {
					////////////////////////////////////////////////////////////
					// 삭제

					////////////////////////////////////////////
					// DAO SQL 추가
					dao.add("ps/rp/rawmixProductionSql/cudRawmixProductionMasterDel", cudMasterData);
					////////////////////////////////////////////

					////////////////////////////////////////////////////////////
				}
			}
	        /////////////////////////////////////////////////////////////////////////////////
			
			
			

	        /////////////////////////////////////////////////////////////////////////////////
			// detail data 처리
			for (int j = 0; j < detailMData.getDataCount(); j++) {

				LData cudDetailData = detailMData.getLData(j);

				////////////////////////////////////////////////////////////
				// 세션정보
				cudDetailData.setString("userId", loginUser.getString("userId"));
				cudDetailData.setString("companyCd", loginUser.getString("companyCd"));
				cudDetailData.setString("lang", loginUser.getString("lang"));
				////////////////////////////////////////////////////////////

				
				String tr_Moded = cudDetailData.getString("DEVON_CUD_FILTER_KEY"); // CUD 모드 가져오기
				if (tr_Moded.equals("DEVON_CREATE_FILTER_VALUE")) {
					LLog.info.write("\n cudDtlData \n" + cudDetailData);
					////////////////////////////////////////////////////////////
					// 신규

					////////////////////////////////////////////
					// DAO SQL 추가
					dao.add("ps/rp/rawmixProductionSql/cudRawmixProductionDetailInsert", cudDetailData);
					////////////////////////////////////////////

					////////////////////////////////////////////////////////////
				} else if (tr_Moded.equals("DEVON_UPDATE_FILTER_VALUE")) {
					////////////////////////////////////////////////////////////
					// 수정

					////////////////////////////////////////////
					// DAO SQL 추가
					dao.add("ps/rp/rawmixProductionSql/cudRawmixProductionDetailUpdate", cudDetailData);
					////////////////////////////////////////////

					////////////////////////////////////////////////////////////

				} else if (tr_Moded.equals("DEVON_DELETE_FILTER_VALUE")) {
					////////////////////////////////////////////
					// DAO SQL 추가
					dao.add("ps/rp/rawmixProductionSql/cudRawmixProductionDetailDel", cudDetailData);
					////////////////////////////////////////////
				}
			}
	        /////////////////////////////////////////////////////////////////////////////////

			
			
	        /////////////////////////////////////////////////////////////////////////////////
			// result data 처리
			for (int j = 0; j < resultMData.getDataCount(); j++) {

				LData cudResultData = resultMData.getLData(j);

				////////////////////////////////////////////////////////////
				// 세션정보
				cudResultData.setString("userId", loginUser.getString("userId"));
				cudResultData.setString("companyCd", loginUser.getString("companyCd"));
				cudResultData.setString("lang", loginUser.getString("lang"));
				////////////////////////////////////////////////////////////

				
				String tr_Moded = cudResultData.getString("DEVON_CUD_FILTER_KEY"); // CUD 모드 가져오기
				if (tr_Moded.equals("DEVON_CREATE_FILTER_VALUE")) {
					////////////////////////////////////////////////////////////
					// 신규

					////////////////////////////////////////////
					// DAO SQL 추가
					dao.add("ps/rp/rawmixProductionSql/cudRawmixProductionResultInsert", cudResultData);
					////////////////////////////////////////////

					////////////////////////////////////////////////////////////
				} else if (tr_Moded.equals("DEVON_UPDATE_FILTER_VALUE")) {
					////////////////////////////////////////////////////////////
					// 수정

					////////////////////////////////////////////
					// DAO SQL 추가
					dao.add("ps/rp/rawmixProductionSql/cudRawmixProductionResultUpdate", cudResultData);
					////////////////////////////////////////////

					////////////////////////////////////////////////////////////
				} else if (tr_Moded.equals("DEVON_DELETE_FILTER_VALUE")) {
					////////////////////////////////////////////////////////////
					// 삭제
					////////////////////////////////////////////////////////////
				}
			}
	        /////////////////////////////////////////////////////////////////////////////////


			/////////////////////////////////////////////////////////////////////////////////
			// DAO 일괄 실행
			dao.executeUpdate();
			dao.commit();
			/////////////////////////////////////////////////////////////////////////////////

		} catch (Exception se) {
			dao.rollback();

			LLog.err.println(this.getClass().getName() + "." + "cudMenuMgnt()" + "=>" + se.getMessage());
			// throw new LSysException("pbf.err.com.save", se);
			getErrorCode = "-1403";
			getMessage = se.getMessage();
			throw new LSysException(getMessage, se);
		}

		result.put("getErrorCode", getErrorCode);
		result.put("getMessage", getMessage);

		return result;
	}
	
	
	public LData cudRawmixProductionStatus(LMultiData masterMData, LData loginUser) throws LException {
		// 승인

		LLog.info.write("\n cudRawmixProductionApproval ------------- Start \n");

		LCompoundDao dao = new LCompoundDao();
		LData result = new LData();

		String getErrorCode = "0";
		String getMessage = "";

		try {

			dao.startTransaction(); // 트랜잭션 시작

	        /////////////////////////////////////////////////////////////////////////////////
			// master data 처리
			for (int i = 0; i < masterMData.getDataCount(); i++) {

				LData cudMasterData = masterMData.getLData(i);
				
				////////////////////////////////////////////////////////////
				// 세션정보
				cudMasterData.setString("userId", loginUser.getString("userId"));
				cudMasterData.setString("companyCd", loginUser.getString("companyCd"));
				cudMasterData.setString("lang", loginUser.getString("lang"));
				////////////////////////////////////////////////////////////

				String tr_Mode = cudMasterData.getString("DEVON_CUD_FILTER_KEY"); // CUD 모드 가져오기
				if (tr_Mode.equals("DEVON_UPDATE_FILTER_VALUE")) {
					////////////////////////////////////////////////////////////
					// 수정

					////////////////////////////////////////////
					// DAO SQL 추가
					dao.add("ps/rp/rawmixProductionSql/cudRawmixProductionMasterUpdateStatus", cudMasterData);
					////////////////////////////////////////////

					////////////////////////////////////////////////////////////
				}
			}
	        /////////////////////////////////////////////////////////////////////////////////



			/////////////////////////////////////////////////////////////////////////////////
			// DAO 일괄 실행
			dao.executeUpdate();
			dao.commit();
			/////////////////////////////////////////////////////////////////////////////////

		} catch (Exception se) {
			dao.rollback();

			LLog.err.println(this.getClass().getName() + "." + "cudMenuMgnt()" + "=>" + se.getMessage());
			// throw new LSysException("pbf.err.com.save", se);
			getErrorCode = "-1403";
			getMessage = se.getMessage();
			throw new LSysException(getMessage, se);
		}

		result.put("getErrorCode", getErrorCode);
		result.put("getMessage", getMessage);

		return result;
	}
	
	
	

	/**
	 *  SAP Send
	 *
	 * @param inputData Command로 부턴 전달받은 input LDataProtocol
	 * 
	 * @return LMultiData 조회된 리스트 결과.
	 * @exception LException 메소드 수행시 발생한 모든 에러.
	 */
	public LData cudRawmixProductionSapSend(LMultiData headerData, LData loginUser) throws LException {

		LLog.info.write("\n Biz > cudRawmixProductionSapSend() ------------- Start \n");

		LCompoundDao dao = new LCompoundDao();
		LCommonDao xdao = new LCommonDao();
		LCommonDao statusDao = new LCommonDao();

		LData resultSap = new LData();
		LData resultMsg = new LData();
		LMultiData bodyData1 = new LMultiData();
		LMultiData bodyData2 = new LMultiData();

		GMM11 gmm11 = new GMM11(); // 인터페이스 SRC 클래스

		try {
			
			//////////////////////////////////////////////////////////////////////////////////////
			// xmldocno 채번
			LData xmlNo = xdao.executeQueryForSingle("cm/cm/commCodeMgntSql/retireveXmlDocNo", loginUser);
			LLog.info.write("\n Biz > xmlNo() ------------- > " + xmlNo);
			//////////////////////////////////////////////////////////////////////////////////////

			dao.startTransaction();

			//////////////////////////////////////////////////////////////////////////////////////
			// HeaderData(ds_master) 로 Body1(detail), Body2(result) 넘기기
			for (int i = 0; i < headerData.getDataCount(); i++) {

				///////////////////////////////////////////////////////////////
				// Header 값 셋팅
				LData header = headerData.getLData(i);
				header.setString("userId", loginUser.getString("userId"));
				header.setString("companyCd", loginUser.getString("companyCd"));
				header.setString("deptCd", loginUser.getString("deptCd"));
				header.setString("zxmldocno", xmlNo.getString("zxmldocno")); // xmldocno

				header.setString("transDate", xmlNo.getString("transDate")); // send Date
				header.setString("cancelType", ""); // cancelType null:정상, X: 취소
				
				header.setString("prodDate", header.getString("prodDate").replaceAll("/", "")); // 날짜 슬래쉬 빼기
				header.setString("postDate", header.getString("postDate").replaceAll("/", "")); // 날짜 슬래쉬 빼기
				LLog.info.write("SAP 전송할때의 prodDate----->: " + header.getString("prodDate"));
				///////////////////////////////////////////////////////////////

				///////////////////////////////////////////////////////////////
				// 전송시 상태 01(Progress)인지 재확인
				LData checkStatus = statusDao.executeQueryForSingle("ps/rp/rawmixProductionSql/retrieveRawmixProductionMaster", header);
				LLog.info.write("SAP 전송할때의 status----->: " + checkStatus.getString("status"));
				///////////////////////////////////////////////////////////////

				if (checkStatus.getString("status").equals("01")) {
					// 01: Approval, 02: SAP Sent, 03: SAP G/I, 04: SAP G/R, 

					///////////////////////////////////////////////////////////////
					// 결과값 셋팅
					LCommonDao commonDao = new LCommonDao("ps/rp/rawmixProductionSql/retrieveRawmixProductionDetailSapList", header); // 2개 점토자재 제외
					bodyData1 = commonDao.executeQuery();
					LCommonDao commonDao2 = new LCommonDao("ps/rp/rawmixProductionSql/retrieveRawmixProductionResultSapList", header);
					bodyData2 = commonDao2.executeQuery();

					resultMsg = gmm11.GMM11_out(header, bodyData1, bodyData2);
					///////////////////////////////////////////////////////////////

					

					///////////////////////////////////////////////////////////////
					// 결과값 셋팅
					header.setString("returnStatus", resultMsg.getString("returnStatus"));
					header.setString("returnMsg", resultMsg.getString("returnText"));
					header.setString("fiscalYear", resultMsg.getString("returnMjahr"));
					header.setString("returnType", resultMsg.getString("returnType"));
					header.setString("returnSapGiNo", resultMsg.getString("returnSapGiNo"));
					header.setString("returnSapGrNo", resultMsg.getString("returnSapGrNo"));
					///////////////////////////////////////////////////////////////
					

					
					///////////////////////////////////////////////////////////////
					// 전송시 상태 02(sent)으로 변경
					dao.add("ps/rp/rawmixProductionSql/cudRawmixProductionMasterUpdateSapSend", header);
					dao.executeUpdate();
					dao.commit();
					///////////////////////////////////////////////////////////////
					

					///////////////////////////////////////////////////////////////
					// 전송결과 에러시
					if("99".equals(resultMsg.getString("returnType"))) {
						resultSap.setString("getErrorCode", "99");
						resultSap.setString("getMessage", resultMsg.getString("returnText"));
						return resultSap;
					}
					///////////////////////////////////////////////////////////////

				} else { // 전송시 상태01이 아닌경우
					resultSap.setString("getErrorCode", "99");
					resultSap.setString("getMessage", "Check status again. You Can send when the status is Progress.");
					return resultSap;
				}
			}
			//////////////////////////////////////////////////////////////////////////////////////

		} catch (Exception se) {
			dao.rollback();
			throw new LBizException("sd.sm.cmd.send - " + "I/F Connection Error");
		}

		resultSap.setString("getErrorCode", "00");
		resultSap.setString("getMessage", "Successfully Sent");
		return resultSap;
	}
	
	/**
	 *  SAP Cancel
	 *
	 * @param inputData Command로 부턴 전달받은 input LDataProtocol
	 * 
	 * @return LMultiData 조회된 리스트 결과.
	 * @exception LException 메소드 수행시 발생한 모든 에러.
	 */
	public LData cudRawmixProductionSapCancel(LMultiData headerData, LData loginUser) throws LException {
		
		LLog.info.write("\n Biz > cudRawmixProductionSapCancel() ------------- Start \n");
		
		LCompoundDao dao = new LCompoundDao();
		LCommonDao xdao = new LCommonDao();
		LCommonDao statusDao = new LCommonDao();
		
		LData resultSap = new LData();
		LData resultMsg = new LData();
		LMultiData bodyData1 = new LMultiData();
		LMultiData bodyData2 = new LMultiData();
		
		GMM11 gmm11 = new GMM11(); // 인터페이스 SRC 클래스
		
		try {
			
			//////////////////////////////////////////////////////////////////////////////////////
			// xmldocno 채번
			LData xmlNo = xdao.executeQueryForSingle("cm/cm/commCodeMgntSql/retireveXmlDocNo", loginUser);
			LLog.info.write("\n Biz > xmlNo() ------------- > " + xmlNo);
			//////////////////////////////////////////////////////////////////////////////////////
			
			dao.startTransaction();
			
			//////////////////////////////////////////////////////////////////////////////////////
			// HeaderData(ds_master) 로 Body1(detail), Body2(result) 넘기기
			for (int i = 0; i < headerData.getDataCount(); i++) {
				
				///////////////////////////////////////////////////////////////
				// Header 값 셋팅
				LData header = headerData.getLData(i);
				header.setString("userId", loginUser.getString("userId"));
				header.setString("companyCd", loginUser.getString("companyCd"));
				header.setString("deptCd", loginUser.getString("deptCd"));
				header.setString("zxmldocno", xmlNo.getString("zxmldocno")); // xmldocno
				
				header.setString("transDate", xmlNo.getString("transDate")); // send Date
				header.setString("cancelType", "X"); // cancelType null:정상, X: 취소
				
				header.setString("prodDate", header.getString("prodDate").replaceAll("/", "")); // 날짜 슬래쉬 빼기
				header.setString("postDate", header.getString("postDate").replaceAll("/", "")); // 날짜 슬래쉬 빼기
				LLog.info.write("SAP 전송할때의 prodDate----->: " + header.getString("prodDate"));
				///////////////////////////////////////////////////////////////
				
				///////////////////////////////////////////////////////////////
				// 전송시 상태 01(Progress)인지 재확인
				LData checkStatus = statusDao.executeQueryForSingle("ps/rp/rawmixProductionSql/retrieveRawmixProductionMaster", header);
				LLog.info.write("SAP 전송할때의 status----->: " + checkStatus.getString("status"));
				///////////////////////////////////////////////////////////////
				
				if (checkStatus.getString("status").equals("03") || checkStatus.getString("status").equals("04")) {
					// 02: SAP Sent, 03: SAP G/I, 04: SAP G/R, 
					
					///////////////////////////////////////////////////////////////
					// 결과값 셋팅
					LCommonDao commonDao = new LCommonDao("ps/rp/rawmixProductionSql/retrieveRawmixProductionDetailSapList", header); // 2개 점토자재 제외
					bodyData1 = commonDao.executeQuery();
					LCommonDao commonDao2 = new LCommonDao("ps/rp/rawmixProductionSql/retrieveRawmixProductionResultSapList", header);
					bodyData2 = commonDao2.executeQuery();
					
					resultMsg = gmm11.GMM11_out(header, bodyData1, bodyData2);
					///////////////////////////////////////////////////////////////
					
					
					
					///////////////////////////////////////////////////////////////
					// 결과값 셋팅
					header.setString("returnStatus", resultMsg.getString("returnStatus"));
					header.setString("returnMsg", resultMsg.getString("returnText"));
					header.setString("fiscalYear", resultMsg.getString("returnMjahr"));
					header.setString("returnType", resultMsg.getString("returnType"));
					header.setString("returnSapGiNo", resultMsg.getString("returnSapGiNo"));
					header.setString("returnSapGrNo", resultMsg.getString("returnSapGrNo"));
					///////////////////////////////////////////////////////////////
					
					
					
					///////////////////////////////////////////////////////////////
					// 전송시 상태 00(성공)시 05(SAP Cancel)상태로 변경, 99(실패)시 현재상태 유지
					dao.add("ps/rp/rawmixProductionSql/cudRawmixProductionMasterUpdateSapCancel", header);
					dao.executeUpdate();
					dao.commit();
					///////////////////////////////////////////////////////////////
					
					
					///////////////////////////////////////////////////////////////
					// 전송결과 에러시
					if("99".equals(resultMsg.getString("returnType"))) {
						resultSap.setString("getErrorCode", "99");
						resultSap.setString("getMessage", resultMsg.getString("returnText"));
						return resultSap;
					}
					///////////////////////////////////////////////////////////////
					
					
				} else { // 전송시 상태01이 아닌경우
					resultSap.setString("getErrorCode", "99");
					resultSap.setString("getMessage", "Check status again. You Can send when the status is Progress.");
					return resultSap;
				}
			}
			//////////////////////////////////////////////////////////////////////////////////////
			
		} catch (Exception se) {
			dao.rollback();
			throw new LBizException("sd.sm.cmd.send - " + "I/F Connection Error");
		}
		
		resultSap.setString("getErrorCode", "00");
		resultSap.setString("getMessage", "Successfully Sent");
		return resultSap;
	}

}
