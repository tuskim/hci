/*
 *------------------------------------------------------------------------------
 * ProductionApprovalBiz.java,v 1.0 2010/08/19 17:30:35 
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

package ps.dp.biz;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LException;
import devon.core.exception.LSysException;
import devon.core.log.LLog;
import devonframework.persistent.autodao.LCommonDao;
import devonframework.persistent.autodao.LCompoundDao;

/**
 * <PRE>
 * Production Approval 업무를 처리하는 Biz 클래스.
 * 
 * Database Tables :
 * </PRE>
 * 
 * @author CEH
 */
public class ProductionApprovalBiz {

	/**
	 * Production Approval 정보를 조회하는 메소드.
	 * 
	 * @param inputData
	 *            Command로 부턴 전달받은 input LDataProtocol
	 * 
	 * @return LMultiData 조회된 리스트 결과.
	 * @exception LException
	 *                메소드 수행시 발생한 모든 에러.
	 */
	public LMultiData retrieveProductionApprovalAnyList(LData inputData) throws LException {

		LLog.debug.write("retrieveProductionApprovalAnyList-----------> Start ");

		LCommonDao dao = new LCommonDao();
		try {
			LLog.debug.write("listType : "+inputData.getString("listType"));

			if("f_retrieveProd01".equals(inputData.getString("listType"))) {
				return dao.executeQuery("ps/dp/productionApprovalSql/retrieveProductionApproval01List", inputData);
			}
			
			if("f_retrieveProd02".equals(inputData.getString("listType"))) {
				return dao.executeQuery("ps/dp/productionApprovalSql/retrieveProductionApproval02List", inputData);
			}
			
			if("f_retrieveProd03".equals(inputData.getString("listType"))) {
				return dao.executeQuery("ps/dp/productionApprovalSql/retrieveProductionApproval03List", inputData);
			}
			
			if("f_retrieveProd04".equals(inputData.getString("listType"))) {
				return dao.executeQuery("ps/dp/productionApprovalSql/retrieveProductionApproval04List", inputData);
			}
			
			if("f_retrieveProd05".equals(inputData.getString("listType"))) {
				return dao.executeQuery("ps/dp/productionApprovalSql/retrieveProductionApproval05List", inputData);
			}

			return null;
		} catch (Exception se) {
			LLog.err.println(this.getClass().getName() + "." + "retrieveProductionApprovalAnyList------()" + "=>" + se.getMessage());
			throw new LSysException("ps.dp.retrieveProductionApprovalAnyList", se);
		}
	}
	
	
	
	
	
	
	public LData cudProductionApprovalStatus(LMultiData lmdProd01, LMultiData lmdProd02, LMultiData lmdProd03, LMultiData lmdProd04,
			LMultiData lmdProd05, LData loginUser) throws LException {
		// 승인

		LLog.info.write("\n cudProductionApprovalApproval ------------- Start \n");

		LCompoundDao dao = new LCompoundDao();
		LData result = new LData();

		String getErrorCode = "0";
		String getMessage = "";

		try {

			dao.startTransaction(); // 트랜잭션 시작

	        /////////////////////////////////////////////////////////////////////////////////
			// Prod01 data 처리
			for (int i = 0; i < lmdProd01.getDataCount(); i++) {
				LData cudOneData = lmdProd01.getLData(i);
				
				////////////////////////////////////////////////////////////
				// 세션정보
				cudOneData.setString("userId", loginUser.getString("userId"));
				cudOneData.setString("companyCd", loginUser.getString("companyCd"));
				cudOneData.setString("lang", loginUser.getString("lang"));
				////////////////////////////////////////////////////////////

				if (cudOneData.getString("DEVON_CUD_FILTER_KEY").equals("DEVON_UPDATE_FILTER_VALUE")) {
					////////////////////////////////////////////
					// DAO SQL 추가
					dao.add("ps/dp/productionApprovalSql/cudProductionApproval01UpdateStatus", cudOneData);
					////////////////////////////////////////////
				}
			}
	        /////////////////////////////////////////////////////////////////////////////////
			
			
			/////////////////////////////////////////////////////////////////////////////////
			// Prod02 data 처리
			for (int i = 0; i < lmdProd02.getDataCount(); i++) {
				LData cudOneData = lmdProd02.getLData(i);
				
				////////////////////////////////////////////////////////////
				// 세션정보
				cudOneData.setString("userId", loginUser.getString("userId"));
				cudOneData.setString("companyCd", loginUser.getString("companyCd"));
				cudOneData.setString("lang", loginUser.getString("lang"));
				////////////////////////////////////////////////////////////
				
				if (cudOneData.getString("DEVON_CUD_FILTER_KEY").equals("DEVON_UPDATE_FILTER_VALUE")) {
					////////////////////////////////////////////
					// DAO SQL 추가
					dao.add("ps/dp/productionApprovalSql/cudProductionApproval02UpdateStatus", cudOneData);
					////////////////////////////////////////////
				}
			}
			/////////////////////////////////////////////////////////////////////////////////
			
			
			/////////////////////////////////////////////////////////////////////////////////
			// Prod03 data 처리
			for (int i = 0; i < lmdProd03.getDataCount(); i++) {
				LData cudOneData = lmdProd03.getLData(i);
				
				////////////////////////////////////////////////////////////
				// 세션정보
				cudOneData.setString("userId", loginUser.getString("userId"));
				cudOneData.setString("companyCd", loginUser.getString("companyCd"));
				cudOneData.setString("lang", loginUser.getString("lang"));
				////////////////////////////////////////////////////////////
				
				if (cudOneData.getString("DEVON_CUD_FILTER_KEY").equals("DEVON_UPDATE_FILTER_VALUE")) {
					////////////////////////////////////////////
					// DAO SQL 추가
					dao.add("ps/dp/productionApprovalSql/cudProductionApproval03UpdateStatus", cudOneData);
					////////////////////////////////////////////
				}
			}
			/////////////////////////////////////////////////////////////////////////////////
			
			
			/////////////////////////////////////////////////////////////////////////////////
			// Prod04 data 처리
			for (int i = 0; i < lmdProd04.getDataCount(); i++) {
				LData cudOneData = lmdProd04.getLData(i);
				
				////////////////////////////////////////////////////////////
				// 세션정보
				cudOneData.setString("userId", loginUser.getString("userId"));
				cudOneData.setString("companyCd", loginUser.getString("companyCd"));
				cudOneData.setString("lang", loginUser.getString("lang"));
				////////////////////////////////////////////////////////////
				
				if (cudOneData.getString("DEVON_CUD_FILTER_KEY").equals("DEVON_UPDATE_FILTER_VALUE")) {
					////////////////////////////////////////////
					// DAO SQL 추가
					dao.add("ps/dp/productionApprovalSql/cudProductionApproval04UpdateStatus", cudOneData);
					////////////////////////////////////////////
				}
			}
			/////////////////////////////////////////////////////////////////////////////////
			
			
			/////////////////////////////////////////////////////////////////////////////////
			// Prod05 data 처리
			for (int i = 0; i < lmdProd05.getDataCount(); i++) {
				LData cudOneData = lmdProd05.getLData(i);
				
				////////////////////////////////////////////////////////////
				// 세션정보
				cudOneData.setString("userId", loginUser.getString("userId"));
				cudOneData.setString("companyCd", loginUser.getString("companyCd"));
				cudOneData.setString("lang", loginUser.getString("lang"));
				////////////////////////////////////////////////////////////
				
				if (cudOneData.getString("DEVON_CUD_FILTER_KEY").equals("DEVON_UPDATE_FILTER_VALUE")) {
					////////////////////////////////////////////
					// DAO SQL 추가
					dao.add("ps/dp/productionApprovalSql/cudProductionApproval05UpdateStatus", cudOneData);
					////////////////////////////////////////////
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
	

}
