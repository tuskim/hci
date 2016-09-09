/* ------------------------------------------------------------------------
 * @source  : MaterialApprovalBiz.java
 * @desc    : 신규 품목 마스터 등록 및 기 등록 품목에 대한 수정 요청 
 * ------------------------------------------------------------------------
 * PROJ : 미얀마 생산 시스템 구축
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2016.09.01                   Initial
 * ------------------------------------------------------------------------ */

package cm.cm.biz;

import xi.GMA09;
import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LBizException;
import devon.core.exception.LException;
import devon.core.log.LLog;
import devonframework.persistent.autodao.LCommonDao;
import devonframework.persistent.autodao.LCompoundDao;

public class MaterialApprovalBiz {
 
    /**
     * Material Approval List
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrieveMaterialApprovalList(LData inputData) throws LException {
        LMultiData list = new LMultiData();

        try { 
            LCommonDao dao = new LCommonDao("/cm/cm/materialApprovalSql/retrieveMaterialApprovalList", inputData);
 
            list = dao.executeQuery();
            
        } catch (LException le) {
            LLog.err.write(this.getClass().getName() + "." + "retrieveMaterialApprovalList()" + "=>" + le.getMessage());
            throw new LBizException("cm.cm.com.retrieve");
        }
        return list;

    }	  
    

    
    
    
	/**
	 *  SAP Approval
	 *
	 * @param inputData Command로 부턴 전달받은 input LDataProtocol
	 * 
	 * @return LMultiData 조회된 리스트 결과.
	 * @exception LException 메소드 수행시 발생한 모든 에러.
	 */
	public LData cudMaterialApprovalSapApproval(LMultiData headerData, LData loginUser) throws LException {

		LLog.info.write("\n Biz > cudMaterialApprovalSapApproval() ------------- Start \n");

		LCompoundDao dao = new LCompoundDao();
		LCommonDao xdao = new LCommonDao();
		LCommonDao statusDao = new LCommonDao();

		LData resultSap = new LData();
		LData resultMsg = new LData();

		GMA09 gma09 = new GMA09(); // 인터페이스 SRC 클래스

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

				header.setString("cancelType", ""); // cancelType null:정상, X: 취소
				///////////////////////////////////////////////////////////////

				///////////////////////////////////////////////////////////////
				// 전송시 상태 01(Progress)인지 재확인
				LData checkStatus = statusDao.executeQueryForSingle("/cm/cm/materialApprovalSql/retrieveMaterialApprovalMasterStatus", header);
				LLog.info.write("SAP 전송할때의 status----->: " + checkStatus.getString("status"));
				///////////////////////////////////////////////////////////////

				if (checkStatus.getString("status").equals("01")) {
					// 01:request, 02:approval, 03:canceled

					///////////////////////////////////////////////////////////////
					// 결과값 셋팅
//					header.setString("status", checkStatus.getString("status")); // 01:request, 02:approval, 03:canceled
					resultMsg = gma09.GMA09_out(header, null);
					LLog.info.write("SAP 전송할때의 returnType----->: " + resultMsg.getString("returnType"));
					///////////////////////////////////////////////////////////////

					///////////////////////////////////////////////////////////////
					// 전송결과 성공시
					if("00".equals(resultMsg.getString("returnType"))) {
						// 00: 성공시
						header.setString("returnType", resultMsg.getString("returnType"));
						header.setString("status", "02"); // 01:request, 02:approval, 03:canceled
						header.setString("sapMsg", resultMsg.getString("returnText"));
						header.setString("materCd", resultMsg.getString("returnMaterCd"));
						
						dao.add("/cm/cm/materialApprovalSql/updateMaterialApprovalMasterSapResult", header);
						dao.add("/cm/cm/materialApprovalSql/mergeMaterialInfo", header);
						dao.executeUpdate();
						dao.commit();
					} else {
						// 99: 실패시
						header.setString("returnType", resultMsg.getString("returnType"));
						header.setString("status", "01"); // 01:request, 02:approval, 03:canceled
						header.setString("sapMsg", resultMsg.getString("returnText"));
						header.setString("materCd", resultMsg.getString("returnMaterCd"));
						
						dao.add("/cm/cm/materialApprovalSql/updateMaterialApprovalMasterSapResult", header);
						dao.executeUpdate();
						dao.commit();

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
			se.printStackTrace();
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
	public LData cudMaterialApprovalSapCancel(LMultiData headerData, LData loginUser) throws LException {

		LLog.info.write("\n Biz > cudMaterialApprovalSapCancel() ------------- Start \n");

		LCompoundDao dao = new LCompoundDao();
		LCommonDao xdao = new LCommonDao();
		LCommonDao statusDao = new LCommonDao();

		LData resultSap = new LData();
		LData resultMsg = new LData();

		GMA09 gma09 = new GMA09(); // 인터페이스 SRC 클래스

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

				header.setString("cancelType", "X"); // cancelType null:정상, X: 취소
				///////////////////////////////////////////////////////////////

				///////////////////////////////////////////////////////////////
				// 전송시 상태 01(Progress)인지 재확인
				LData checkStatus = statusDao.executeQueryForSingle("/cm/cm/materialApprovalSql/retrieveMaterialApprovalMasterStatus", header);
				LLog.info.write("SAP 전송할때의 status----->: " + checkStatus.getString("status"));
				///////////////////////////////////////////////////////////////

				if (checkStatus.getString("status").equals("02")) {
					// 01:request, 02:approval, 03:canceled

					///////////////////////////////////////////////////////////////
					// 결과값 셋팅
//					header.setString("status", checkStatus.getString("status")); // 01:request, 02:approval, 03:canceled
					resultMsg = gma09.GMA09_out(header, null);
					LLog.info.write("SAP 전송할때의 returnType----->: " + resultMsg.getString("returnType"));
					///////////////////////////////////////////////////////////////

					///////////////////////////////////////////////////////////////
					// 전송결과 성공시
					if("00".equals(resultMsg.getString("returnType"))) {
						// 00: 성공시
						header.setString("returnType", resultMsg.getString("returnType"));
						header.setString("status", "03"); // 01:request, 02:approval, 03:canceled
						header.setString("useyn", "N"); 
						header.setString("sapMsg", resultMsg.getString("returnText"));
						
						dao.add("/cm/cm/materialApprovalSql/updateMaterialApprovalMasterSapResult", header);
						dao.add("/cm/cm/materialApprovalSql/updateMaterialInfoYn", header);
						dao.executeUpdate();
						dao.commit();
					} else {
						// 99: 실패시
						header.setString("returnType", resultMsg.getString("returnType"));
						header.setString("status", "02"); // 01:request, 02:approval, 03:canceled
						header.setString("sapMsg", resultMsg.getString("returnText"));
						
						dao.add("/cm/cm/materialApprovalSql/updateMaterialApprovalMasterSapResult", header);
						dao.executeUpdate();
						dao.commit();

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
			se.printStackTrace();
			throw new LBizException("sd.sm.cmd.send - " + "I/F Connection Error");
		}

		resultSap.setString("getErrorCode", "00");
		resultSap.setString("getMessage", "Successfully Sent");
		return resultSap;
	}
    	
}
