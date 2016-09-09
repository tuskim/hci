/*
 *------------------------------------------------------------------------------
 * PurchOrderRegBiz.java,v 1.0 2010/08/19 17:30:35 
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

package po.oc.biz;
import java.util.Properties;
import java.util.Vector;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility; 

import xi.GMM01;
import devon.core.exception.LException;
import devon.core.exception.LSysException;
import devon.core.log.LLog;
import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.config.LConfiguration;
import devonframework.persistent.autodao.LCommonDao;
import devonframework.persistent.autodao.LCompoundDao;
import devonframework.service.mail.LMail; 
import java.text.*;



/**
 * <PRE>
 * P/O RegsiTration 업무를 처리하는 Biz 클래스.
 *
 * Database Tables : 
 * </PRE>
 * @author    CEH
 */
public class PurchOrderRegBiz {

    
    /**
     * P/O RegsiTration  정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrievePurchOrderRegMainList(LData inputData) throws LException {    	
    	
    	LLog.debug.write("retrievePurchOrderRegMainList-----------> Start ");
    	
    	LCommonDao dao = new LCommonDao();
		try{			
			return dao.executeQuery("po/oc/purchOrderRegSql/retrievePurchOrderRegMainList", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrievePurchOrderRegMainList------()" + "=>" + se.getMessage());
			throw new LSysException("po.oc.retrievePurchOrderRegMainList", se);
		}
    }
	

    /**
     * Search P/O RegsiTration Detail 정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrievePurchOrderRegDetailList(LData inputData) throws LException {    	
    	
    	LLog.debug.write("retrievePurchOrderRegDetailList -----------> Start ");
    	
    	LCommonDao dao = new LCommonDao();
		try{			
			return dao.executeQuery("po/oc/purchOrderRegSql/retrievePurchOrderRegDetailList", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrievePurchOrderRegDetailList------()" + "=>" + se.getMessage());
			throw new LSysException("po.oc.retrievePurchOrderRegAppList", se);
		}
    }	

    /**
     * Search P/O RegsiTration AppList 정보를 조회하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
    public LMultiData retrievePurchOrderRegAppList(LData inputData) throws LException {    	
    	
    	LLog.debug.write("retrievePurchOrderRegAppList -----------> Start ");
    	
    	LCommonDao dao = new LCommonDao();
		try{			
			return dao.executeQuery("po/oc/purchOrderRegSql/retrievePurchOrderRegAppList", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrievePurchOrderRegAppList------()" + "=>" + se.getMessage());
			throw new LSysException("po.oc.retrievePurchOrderRegAppList", se);
		}
    }	
    /**
     * P/O RegsiTration 정보를 저장 하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     * @return LMultiData 조회된 리스트 결과.
     * @exception LException 메소드 수행시 발생한 모든 에러.
     */
	public LData cudPurchOrderReg(LMultiData mainMData,LMultiData detailMData, LMultiData taxMData,LMultiData appMData, LData loginUser) throws LException {
		
    	LLog.info.write("\n cudPurchOrderReg ------------- Start \n");

    	LCompoundDao dao = new LCompoundDao();
        LData result = new LData(); 

		String	getErrorCode = "0" ;
		String	getMessage	 = "";
        //String  getStatus    = "";		

        try{			

			dao.startTransaction();

			LData   resultInfo 	= new LData();		// Seq 생성
  
			// Purchase Order  Manage
			for(int i=0;i<mainMData.getDataCount();i++) {
				
				LData cudMstData = mainMData.getLData(i);
		    	String tr_Mode  = cudMstData.getString("DEVON_CUD_FILTER_KEY");

		    	cudMstData.setString("userId",    loginUser.getString("userId"));
		    	cudMstData.setString("companyCd", loginUser.getString("companyCd"));
		    	cudMstData.setString("lang",       loginUser.getString("lang"));		    	
				if( tr_Mode.equals("DEVON_CREATE_FILTER_VALUE") ) {

					// New Pr No Create
					resultInfo = dao.executeQueryForSingle("po/oc/purchOrderRegSql/cudPurchOrderRegGetPONo", cudMstData);
					cudMstData.setString("poNo", resultInfo.getString("poNo"));
			    	LLog.info.write("\n cudMstData \n"+cudMstData);
					//Purch Order  Detail Insert
					dao.add("po/oc/purchOrderRegSql/cudPurchOrderRegMainInsert", cudMstData);
				
				} else if( tr_Mode.equals("DEVON_UPDATE_FILTER_VALUE") ) {

					//Purch Order  Detail Update
					dao.add("po/oc/purchOrderRegSql/cudPurchOrderRegMainUpdate", cudMstData);
				} else if( tr_Mode.equals("DEVON_DELETE_FILTER_VALUE") ) {

					//Purch Order Manage Delete
					dao.add("po/oc/purchOrderRegSql/cudPurchOrderRegMainDel", cudMstData);
					dao.add("po/oc/purchOrderRegSql/cudPurchOrderRegDTDelAll", cudMstData);
					dao.add("po/oc/purchOrderRegSql/cudPurchOrderRegTaxDel", cudMstData);
				} 
				if(!cudMstData.get("currencyCd").equals("MMK")){
					dao.add("po/oc/purchOrderRegSql/cudPurchOrderRegTaxDel", cudMstData);
				}
			} 
			// Purchase Order Detail   

			for(int j=0;j<detailMData.getDataCount();j++) {
				
				LData cudDtlData = detailMData.getLData(j);
		    	String tr_Moded  = cudDtlData.getString("DEVON_CUD_FILTER_KEY");
		 
				cudDtlData.setString("userId",    loginUser.getString("userId"));
				cudDtlData.setString("companyCd", loginUser.getString("companyCd"));
				cudDtlData.setString("lang",       loginUser.getString("lang")); 
					
				if(loginUser.getString("poNo").equals("")){
					cudDtlData.setString("poNo", resultInfo.getString("poNo"));
				}else{
					cudDtlData.setString("poNo", loginUser.getString("poNo"));
				}
				  
 				if( tr_Moded.equals("DEVON_CREATE_FILTER_VALUE") ) {
					LLog.info.write("\n cudDtlData \n"+cudDtlData);
					//Purch Order Manage Detail Insert
					dao.add("po/oc/purchOrderRegSql/cudPurchOrderRegMainDTInsert", cudDtlData);
					
				} else if( tr_Moded.equals("DEVON_UPDATE_FILTER_VALUE") ) {

					//Purch Order Manage Detail Update
					dao.add("po/oc/purchOrderRegSql/cudPurchOrderRegDTUpdate", cudDtlData);

				} else if( tr_Moded.equals("DEVON_DELETE_FILTER_VALUE") ) {

					//Purch Order Manage Delete
					dao.add("po/oc/purchOrderRegSql/cudPurchOrderRegDTDel", cudDtlData);
				}
			
			}
			
			// Purchase Order Tax			
			for(int j=0;j<taxMData.getDataCount();j++) {
				
				LData cudTaxData = taxMData.getLData(j);
		    	String tr_Mode  = cudTaxData.getString("DEVON_CUD_FILTER_KEY");

		    	cudTaxData.setString("userId",    loginUser.getString("userId"));
		    	cudTaxData.setString("companyCd", loginUser.getString("companyCd"));
		    	cudTaxData.setString("lang",       loginUser.getString("lang"));
				if(loginUser.getString("poNo").equals("")){
					cudTaxData.setString("poNo", resultInfo.getString("poNo"));
				}else{
					cudTaxData.setString("poNo", loginUser.getString("poNo"));
				}		    	
				if( tr_Mode.equals("DEVON_CREATE_FILTER_VALUE") ) {
					//Purch Order  App Insert
					dao.add("po/oc/purchOrderRegSql/cudPurchOrderRegTaxMerge", cudTaxData);
					
				} else if( tr_Mode.equals("DEVON_UPDATE_FILTER_VALUE") ) {

					//Purch Order  App Update
					dao.add("po/oc/purchOrderRegSql/cudPurchOrderRegTaxMerge", cudTaxData);

				} else if( tr_Mode.equals("DEVON_DELETE_FILTER_VALUE") ) {

					//Purch Order App Delete
					dao.add("po/oc/purchOrderRegSql/cudPurchOrderRegTaxDel", cudTaxData);
				}
			
			}				
			
			// Purchase Order App 
			for(int j=0;j<appMData.getDataCount();j++) {
				
				LData cudAppData = appMData.getLData(j);
		    	String tr_Mode  = cudAppData.getString("DEVON_CUD_FILTER_KEY");

		    	cudAppData.setString("userId",    loginUser.getString("userId"));
				cudAppData.setString("companyCd", loginUser.getString("companyCd"));
				cudAppData.setString("lang",       loginUser.getString("lang"));
				if( tr_Mode.equals("DEVON_CREATE_FILTER_VALUE") ) {
					//Purch Order  App Insert
					dao.add("po/oc/purchOrderRegSql/cudPurchOrderRegAppInsert", cudAppData);
					
				} else if( tr_Mode.equals("DEVON_UPDATE_FILTER_VALUE") ) {

					//Purch Order  App Update
					dao.add("po/oc/purchOrderRegSql/cudPurchOrderRegAppUpDate", cudAppData);

				} else if( tr_Mode.equals("DEVON_DELETE_FILTER_VALUE") ) {

					//Purch Order App Delete
					dao.add("po/oc/purchOrderRegSql/cudPurchOrderRegAppDel", cudAppData);
				}
			
			}			
			
			dao.executeUpdate();
			
			dao.commit();
				
		} catch (Exception se) {
			dao.rollback();

			LLog.err.println(  this.getClass().getName() + "." + "cudMenuMgnt()" + "=>" + se.getMessage());
			//throw new LSysException("pbf.err.com.save", se);
			getErrorCode = "-1403";
			getMessage = se.getMessage();
			throw new LSysException(getMessage,se);
        }
		
		result.put("getErrorCode"	,getErrorCode);
		result.put("getMessage"	,getMessage);
		
		return result;
    }

    /**
     * Save P/O RegsiTration 정보를 저장하는 메소드.
     *
     * @param inputData Command로 부턴 전달받은 input LDataProtocol
     * 
     ** @exception LException 메소드 수행시 발생한 모든 에러.
     */
 
    public LData cudPurchOrderRegSapSend(LMultiData mainMData,LMultiData detailMData,LMultiData appMData, LData loginUser) throws LException {
		
    	LLog.info.write("\n cudPurchOrderRegSapSend ------------- Start \n");
    	
        LCompoundDao dao		= new LCompoundDao();       
        LCommonDao xdao		= new LCommonDao(); 
        
		long	getErrorCode	= -1403 ;
		String	getMessage		= "";
		String	getStatus		= "";
	
		LData dataBox		    = new LData();
		LData resultMsg		    = new LData();
		LData resultInfo		= new LData();
		LMultiData resultDtlMsg  = new LMultiData();
		try{
			
			LData xmlNo = xdao.executeQueryForSingle("cm/cm/commCodeMgntSql/retireveXmlDocNo", loginUser);
			xmlNo.setString("progStatus", "30"); // SAP Transper 30
			
			dao.startTransaction();
			resultInfo = dao.executeQueryForSingle("po/oc/purchOrderRegSql/cudPurchOrderRegTransDate",loginUser);
			for(int i=0; i<mainMData.getDataCount(); i++) {   
				
				LLog.info.write("\n po/oc/purchOrderRegSql/cudPurchOrderRegSapSend --------->  \n");
				mainMData.modify("companyCd",i, loginUser.getString("companyCd")); 
				mainMData.modify("transDate",i, resultInfo.getString("transDate"));  
				dao.add ("po/oc/purchOrderRegSql/cudPurchOrderRegSapSend", mainMData.getLData(i) );            
				dao.executeUpdate();
			}
			for(int i=0; i<detailMData.getDataCount(); i++) {  
				detailMData.modify("companyCd",i, loginUser.getString("companyCd"));  
			}
			
			GMM01 gmm01 = new GMM01();
			Vector oResultMsg = gmm01.GMM01_out(xmlNo, mainMData, detailMData);
			resultMsg =(LData) oResultMsg.get(0);
			resultDtlMsg =(LMultiData) oResultMsg.get(1);
			if (resultMsg.getString("returnType").equals("00")) {
				getErrorCode = 0;
				for(int i=0; i<mainMData.getDataCount(); i++) {   
					
					LLog.info.write("\n po/oc/purchOrderRegSql/cudPurchOrderRegSapSend --------->  \n");
					mainMData.modify("companyCd",i, loginUser.getString("companyCd")); 
					mainMData.modify("transDate",i, resultInfo.getString("transDate"));  
					mainMData.modify("sapIfStatus",i, resultMsg.getString("returnType"));		
						
					mainMData.modify("sapPoNo",i, resultMsg.getString("returnPoNo"));	
					if(mainMData.get("pstatus",i).equals("02")){
						mainMData.modify("pstatus",i,    "03"); 
						mainMData.modify("sapRtnMsg",i,"TRANS MSG - "+resultMsg.getString("returnText"));
					}else if(mainMData.get("pstatus",i).equals("04")){
						mainMData.modify("pstatus",i,    "05"); 
						mainMData.modify("sapRtnMsg",i,"CANCEL MSG - "+resultMsg.getString("returnText"));
					}
					 
					dao.add ("po/oc/purchOrderRegSql/cudPurchOrderRegSapSend", mainMData.getLData(i)  );            
					
				}	
				dao.add ("po/oc/purchOrderRegSql/cudPurchOrderRegUpdateSapPrice", resultDtlMsg); 
				dao.executeUpdate();
			} else {  
				for(int i=0; i<mainMData.getDataCount(); i++) {   
					 
					mainMData.modify("companyCd",i, loginUser.getString("companyCd"));  
					mainMData.modify("transDate",i, resultInfo.getString("transDate"));    
					mainMData.modify("sapIfStatus",i, resultMsg.getString("returnType"));		 
					if(mainMData.get("pstatus",i).equals("02")){ 
						mainMData.modify("pstatus",i,    "01");  
						mainMData.modify("sapRtnMsg",i,"TRANS MSG - "+resultMsg.getString("returnText")); 
					}else if(mainMData.get("pstatus",i).equals("04")){ 
						mainMData.modify("pstatus",i,    "03");  
						mainMData.modify("sapRtnMsg",i,"CANCEL MSG - "+resultMsg.getString("returnText")); 
					}    
					//mainMData.modify("sapPoNo",i,    ""); 
					dao.add ("po/oc/purchOrderRegSql/cudPurchOrderRegSapSend", mainMData.getLData(i) ); 			
					dao.executeUpdate();
					
				}				
			}
			dao.commit();
			getMessage = resultMsg.getString("returnText");
		} catch (Exception se) {
			dao.rollback(); 
			LLog.debug.write("exception :"+se.getMessage());
			getErrorCode = -99901;
			getMessage   = se.toString();
			getStatus    = "fail."+this.getClass().getName()+"."+"cudPurchOrderRegSapSend"; 
		}
 
		
		dataBox.put("getErrorCode"	,getErrorCode + "" );
		dataBox.put("getMessage"	,getMessage); 
		if(!getStatus.equals("")) dataBox.put("getStatus" ,getStatus ); //현 프로그램에서 에러
		return dataBox;
	}
    
    public LMultiData retrievePurchOrderRegMaterCombo(LData inputData) throws LException {    	
    	
    	LLog.debug.write("retrievePurchOrderRegMainList -----------> Start ");
    	
    	LCommonDao dao = new LCommonDao();
		try{			
			return dao.executeQuery("po/oc/purchOrderRegSql/retrievePurchOrderRegMaterCombo", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrievePurchOrderRegMainList------()" + "=>" + se.getMessage());
			throw new LSysException("po.oc.retrievePurchOrderRegMainList", se);
		}
    }    
    
    public LMultiData retrievePurchOrderRegVatVCombo(LData inputData) throws LException {    	
    	
    	LLog.debug.write("retrievePurchOrderRegVatVCombo -----------> Start ");
    	
    	LCommonDao dao = new LCommonDao();
		try{			
			return dao.executeQuery("po/oc/purchOrderRegSql/retrievePurchOrderRegVatVCombo", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrievePurchOrderRegVatVCombo------()" + "=>" + se.getMessage());
			throw new LSysException("po.oc.retrievePurchOrderRegVatVCombo", se);
		}
    }        
    /**
     * 메일 전송
     * @param toAddress   받는주소
     * @param ccAddress   참조 
     * @param strMailHtml 내용
     * @param fromAddress 보내는주소
     * @param fromName    보내는이름
     * @param host        메일서버 
     */
    public LData sendMail(LData inputData) throws Exception {

    	LLog.err.println("strMailHtml------()" + "=>" + inputData);
		String getErrorCode		    = "0";
		String getMessage			= "Successfully Send";
		LData LError	  	 		= new LData();
		LCompoundDao dao			= new LCompoundDao(); 
		dao.startTransaction();
        try {
    		String toAddress  		= inputData.getString("mainMail");				// 메일 받는이들
    		String ccAddress      	= inputData.getString("refMail"); 				// 참조 받는이들			
    		String strMailHtml		= inputData.getString("mailbody");			    // 메일 Html
    		String fromAddress		= inputData.getString("email");
    		String fromName		    = inputData.getString("userNm");
    		String host = LConfiguration.getInstance().get("/devon-framework.xml/mail/mail-host");    
			Properties props = new Properties(); 
			props.put("mail.smtp.starttls.enable", "true"); 
			props.put("mail.transport.protocol", "smtp"); 
			props.put("mail.smtp.host", host); 		
			props.put("mail.smtp.user", fromAddress); 

			Session session = Session.getDefaultInstance(props);         
			Message msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress(fromAddress, MimeUtility.encodeText(
					fromName, "UTF-8", "B")));
			msg.setHeader("content-type", "text/html;charset=utf-8");
			msg.setSentDate(new java.util.Date());	
			msg.setContent(strMailHtml, "text/html;charset=utf-8");
			
            if (toAddress != null && toAddress.trim().length() != 0) {
                InternetAddress[] tos = InternetAddress.parse(toAddress);
                msg.setRecipients(Message.RecipientType.TO, tos);
            }

            if (ccAddress != null && ccAddress.trim().length() != 0) { 
                InternetAddress[] ccs = InternetAddress.parse(ccAddress);
                msg.setRecipients(Message.RecipientType.CC, ccs);
            }        
            
            Transport.send(msg);  
            
		} catch (Exception e) {
			dao.rollback();
			LLog.err.println(this.getClass().getName()+"."+"Exception");
			getErrorCode = "-99901";
			getMessage   = e.toString();   
			LLog.err.println(  this.getClass().getName() + "." + "sendMail------()" + "=>" + e.getMessage());
		}
		LError.set("getErrorCode",getErrorCode);
		LError.set("getMessage"	,getMessage.replaceAll("\n", " "));

		return LError;		
    }
    
    public LMultiData cudPurchOrderRegUpdateSendDate(LData inputData) throws LException {    	
    	
    	LLog.debug.write("cudPurchOrderRegUpdateSendDate -----------> Start ");
    	
    	LCommonDao dao = new LCommonDao();
		try{			
			return dao.executeQuery("po/oc/purchOrderRegSql/cudPurchOrderRegUpdateSendDate", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "cudPurchOrderRegUpdateSendDate------()" + "=>" + se.getMessage());
			throw new LSysException("po.oc.cudPurchOrderRegUpdateSendDate", se);
		}
    }  
    public LData sendOnlyMail(LData inputData) throws Exception {

    	LLog.debug.write("\n emailBiz > sendOnlyMail() ------------- Start"+inputData);
    	
        LCompoundDao dao			= new LCompoundDao();  
		String getErrorCode		    = "0";
		String getMessage			= "Successfully Send";
		LData dataBox	  	 		= new LData();
		
		dao.startTransaction();
		
		try{
 
			String toAddress[]  		= inputData.getString("mainMail").split(",");				// 메일 받는이들
			String ccAddress[]      	= inputData.getString("refMail").split(","); 				// 참조 받는이들			
			String tite                 = inputData.getString("title");                           
			String strMailHtml		    = inputData.getString("mailbody");							// 메일 Html
			String fromAddress		    = inputData.getString("email");	
 
			// mail 보내기
			LMail mail = new LMail();  
		    mail.setFromMailAddress(fromAddress);

		    mail.setToMailAddress(toAddress);
		    
			mail.setToMailAddress(toAddress);
			if(!ccAddress[0].equals("")){
				mail.setCcMailAddress(ccAddress);
			}
			LLog.debug.println("1--------------- send Html:\r\n" + strMailHtml); 
			mail.setSubject(tite); 
			mail.setHtml(strMailHtml); 
			mail.send();
			dao.add ("po/oc/purchOrderRegSql/cudPurchOrderRegUpdateSendDate",inputData ); 
			dao.executeUpdate();
			dao.commit();
		} catch (Exception e) { 
			getErrorCode = e.toString();
			getMessage = e.getLocalizedMessage();
			dataBox.put("getErrorCode"	,getErrorCode);
			dataBox.put("getMessage"	,getMessage);
        } 
		LLog.info.write("\n emailBiz > sendOnlyMail() ------------- END --> \n");
		
		dataBox.put("getErrorCode"	,getErrorCode);
		dataBox.put("getMessage"	,getMessage.replaceAll("\n", " ")); 
		return dataBox;
    }	    
    public LMultiData retrievePurchOrderRegDeptCombo(LData inputData) throws LException {    	
    	
    	LLog.debug.write("retrievePurchOrderRegDeptCombo -----------> Start ");
    	
    	LCommonDao dao = new LCommonDao();
		try{			
			return dao.executeQuery("po/oc/purchOrderRegSql/retrievePurchOrderRegDeptCombo", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrievePurchOrderRegDeptCombo------()" + "=>" + se.getMessage());
			throw new LSysException("po.oc.sendOnlyMail", se);
		}
    }   
    
    public LMultiData retrievePurchOrderRegTaxList(LData inputData) throws LException {    	
    	
    	LLog.debug.write("retrievePurchOrderRegTaxList -----------> Start ");
    	
    	LCommonDao dao = new LCommonDao();
		try{			
			return dao.executeQuery("po/oc/purchOrderRegSql/retrievePurchOrderRegTaxList", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrievePurchOrderRegTaxList------()" + "=>" + se.getMessage());
			throw new LSysException("po.oc.retrievePurchOrderRegTaxList", se);
		}
    }     
    
    public LMultiData retrievePurchOrderRegCurrList(LData inputData) throws LException {    	
    	
    	LLog.debug.write("retrievePurchOrderRegCurrList -----------> Start ");
    	
    	LCommonDao dao = new LCommonDao();
		try{			
			return dao.executeQuery("po/oc/purchOrderRegSql/retrievePurchOrderRegCurrList", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrievePurchOrderRegCurrList------()" + "=>" + se.getMessage());
			throw new LSysException("po.oc.retrievePurchOrderRegCurrList", se);
		}
    } 
 
}
 
