/*
 *------------------------------------------------------------------------------
 * StatementOfAccoutnsBiz.java,v 1.0 2011/04/25 16:43:35 
 * 
 * PROJ : PT-PAM
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2011/04/25   kang   Init			결산모니터링용 조회
 *----------------------------------------------------------------------------
 */

package fi.ar.biz;

import comm.util.StringUtil;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LException;
import devon.core.exception.LSysException;
import devon.core.log.LLog;
import devonframework.persistent.autodao.LCommonDao;
import devonframework.persistent.autodao.LCompoundDao;
import devonframework.service.mail.LMail;

/**
 * <PRE>
 * Statement of accounts 결산모니터링 업무를 처리하는 Biz 클래스.
 *
 */
public class StatementOfAccoutnsBiz {

   
    //결산모니터링 - 상태별 전표 수 조회하는 메소드.  
    public LMultiData retrieveCountDocClosingList(LData inputData) throws LException {    	
    	
    	LLog.debug.write("retrieveCountDocClosingList 결산모니터링 전표 상태별 수----------> Start ");
    	LCommonDao dao = new LCommonDao();
		try{			
			return dao.executeQuery("fi/ar/statementOfAccountsSql/retrieveCountDocClosingList", inputData);		
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveCountDocClosingList------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		}
    }
    
   
    //결산모니터링 - 전표내역 조회하는 메소드.
    public LMultiData retrieveDocClosingList(LData inputData) throws LException {    	
    	
    	LLog.debug.write("retrieveDocClosingList 결산모니터링 전표내역 조회-----------> Start "); 	
    	LCommonDao dao = new LCommonDao();
		try{			
			return dao.executeQuery("fi/ar/statementOfAccountsSql/retrieveDocClosingList", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveDocClosingList------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		}
    }


    //결산모니터링 - 전표내역 조회하는 메소드.
    public LMultiData RetrievePoClosingList(LData inputData) throws LException {    	
    	
    	LLog.debug.write("RetrievePoClosingList 결산모니터 PO및 입고내역 조회-----------> Start ");
    	LCommonDao dao = new LCommonDao();
		try{			
			return dao.executeQuery("fi/ar/statementOfAccountsSql/retrievePoClosingList", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "retrieveDocClosingList------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		}
    }    
 
    //결산모니터링 - Qty 조회하는 메소드.
    public LMultiData RetrieveQtyClosingList(LData inputData) throws LException {    	
    	
    	LLog.debug.write("RetrieveQtyClosingList 결산모니터 Qty내역 조회-----------> Start ");
    	LCommonDao dao = new LCommonDao();
		try{			
			return dao.executeQuery("fi/ar/statementOfAccountsSql/retrieveQtyClosingList", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "RetrieveQtyClosingList------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		}
    }
   
    //결산모니터링 - 출고내역 조회하는 메소드.
    public LMultiData RetrieveIssueClosingList(LData inputData) throws LException {    	
    	
    	LLog.debug.write("RetrieveIssueClosingList 결산모니터 출고내역조-----------> Start ");
    	LCommonDao dao = new LCommonDao();
		try{			
			return dao.executeQuery("fi/ar/statementOfAccountsSql/RetrieveIssueClosingList", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "RetrieveIssueClosingList------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
		}
    }
    
    //결산모니터링 - 출고내역 조회하는 메소드.
    public LMultiData RetrieveCoalProdClosingList(LData inputData) throws LException {    	
    	
    	LLog.debug.write("RetrieveCoalProdClosingList 결산모니터 출고내역조-----------> Start ");
    	LCommonDao dao = new LCommonDao();
		try{			
			return dao.executeQuery("fi/ar/statementOfAccountsSql/RetrieveCoalProdClosingList", inputData);
		} catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "RetrieveCoalProdClosingList------()" + "=>" + se.getMessage());
			throw new LSysException("pbf.err.com.retrieve", se);
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

	    	LLog.debug.write("\n emailBiz > sendOnlyMail() ------------- mainMail"+inputData.getString("mainMail"));
	    	LLog.debug.write("\n emailBiz > sendOnlyMail() ------------- mainMail"+inputData.getString("mainMail"));
	    	LLog.debug.write("\n emailBiz > sendOnlyMail() ------------- mainMail"+inputData.getString("mainMail"));
			LLog.debug.write("\n emailBiz > sendOnlyMail() : totalDocs : "+inputData.getString("colProdQty"));
			LLog.debug.write("\n emailBiz > sendOnlyMail() : totalDocs : "+StringUtil.commaSetting(inputData.getString("colProdQty")));
	    	LLog.debug.write("\n emailBiz > sendOnlyMail() ------------- mainMail"+inputData.getString("mainMail"));
	    	LLog.debug.write("\n emailBiz > sendOnlyMail() ------------- mainMail"+inputData.getString("mainMail"));
	    	LLog.debug.write("\n emailBiz > sendOnlyMail() ------------- mainMail"+inputData.getString("mainMail"));
	    	LLog.debug.write("\n emailBiz > sendOnlyMail() ------------- mainMail"+inputData.getString("mainMail"));
			String toAddress[]  		= inputData.getString("mainMail").split(",");//"jcomposedm@gmail.com".split(",");				// 메일 받는이들
			String[] ccAddress = null;
			if(toAddress.length > 1){
				for(int i=1; i < toAddress.length; i++){
					ccAddress[i-1]      	= 	toAddress[i];		
				}
			}
			String tite                 = inputData.getString("title");                           
			String fromAddress		    = "test@gmail.com";//inputData.getString("email");	
 
			StringBuffer strContent = new StringBuffer();
			
			
			
			strContent.append("<div id='conts_box'>                                                                      		\n");
			strContent.append("    <h2> <span> 1.회계전표 내역  </span></h2>                           \n");
			strContent.append("    <!--검색 S -->                                                                        				\n");
//			strContent.append("     <fieldset >                                                                          				\n");
//			strContent.append("        <div>                                                                             					\n");
//			strContent.append("            <dl>                                                                          					\n");
//			strContent.append("            <dt>                                                                          					\n");
			strContent.append("            <table width='100%' border='1' cellpadding='0' cellspacing='0' />             \n");
			strContent.append("                    <colgroup>                                                            				\n");
			strContent.append("                    <col width=''/>                                                    		\n");
			strContent.append("                    <col width=''/>                                                    		\n");
			strContent.append("                    <col width=''/>                                                     		\n");
			strContent.append("                    <col width=''/>                                                    		\n");
			strContent.append("                    <col width=''/>                                                             		\n");
			strContent.append("                    <col width=''/>                                                            		\n");
			strContent.append("                    <col width=''/>                                                             		\n");
			strContent.append("                    <col width=''/>                                                             		\n");
			strContent.append("                    </colgroup>                                                                 		\n");
			strContent.append("                    <tr>                                                                        		      	\n");
			strContent.append("                        <th>처리상태</th>                                               			\n");
			strContent.append("                        <th>Total</th>                                                          	\n");
			strContent.append("                        <th>Insert</th>                                                   		\n");
			strContent.append("                        <th>Confirm</th>                                                  		\n");
			strContent.append("                        <th>SAPsended</th>                                                	\n");
			strContent.append("                        <th>Return SAP</th>                                               	\n");
			strContent.append("                        <th>Cancel Request</th>                                       	\n");
			strContent.append("                        <th>Posting</th>                                                  		\n");
			strContent.append("                    </tr>                                                                 					\n");
			strContent.append("                    <tr>                                                                  					\n");
			strContent.append("                        <th>건수</th>                                                     			\n");
			strContent.append("                        <th>"+StringUtil.commaSetting(inputData.getString("totalDocs"))+"</th>                                                      			\n");
			strContent.append("                        <th>"+StringUtil.commaSetting(inputData.getString("insert"))+"</th>                                                       			\n");
			strContent.append("                        <th>"+StringUtil.commaSetting(inputData.getString("confirm"))+"</th>                                                        			\n");
			strContent.append("                        <th>"+StringUtil.commaSetting(inputData.getString("sapSended"))+"</th>                                                        			\n");
			strContent.append("                        <th>"+StringUtil.commaSetting(inputData.getString("returnSap"))+"</th>                                                        			\n");
			strContent.append("                        <th>"+StringUtil.commaSetting(inputData.getString("cancelRequest"))+"</th>                                                        			\n");
			strContent.append("                        <th>"+StringUtil.commaSetting(inputData.getString("posting"))+"</th>                                                      			\n");
			strContent.append("                    </tr>                                                                 					\n");
			strContent.append("            </table>                                                                            			\n");
//			strContent.append("            </dt>                                                                               			\n");
//			strContent.append("            </dl>                                                                               				\n");
//			strContent.append("        </div>                                                                            \n");
//			strContent.append("    </fieldset>                                                                           \n");
			strContent.append("    <h2> <span> 2.유류  </span></h2>                                                      \n");
			strContent.append("    <!--검색 S -->                                                                        \n");
			strContent.append("     <fieldset >                                                                          \n");
			strContent.append("        <div>                                                                             \n");
			strContent.append("            <dl>                                                                          \n");
			strContent.append("            <dt>                                                                          \n");
			strContent.append("            <table width='100%' border='1' cellpadding='0' cellspacing='0' />             \n");
			strContent.append("                    <colgroup>                                                            \n");
			strContent.append("                    <col width='30%'/>                                                    \n");
			strContent.append("                    <col width='35%'/>                                                    \n");
			strContent.append("                    <col width='35%'/>                                                    \n");
			strContent.append("                    </colgroup>                                                           \n");
			strContent.append("                    <tr>                                                                  \n");
			strContent.append("                        <th></th>                                                       \n");
			strContent.append("                        <th>WEB</th>                                                      \n");
			strContent.append("                        <th>SAP</th>                                                      \n");
			strContent.append("                    </tr>                                                                 \n");
			strContent.append("                    <tr>                                                                  \n");
			strContent.append("                        <th>입고수량(L)</th>                                              \n");
			strContent.append("                        <th>"+StringUtil.commaSetting(inputData.getString("receiptQty"))+"</th>                                                        \n");
			strContent.append("                        <th></th>                                                        \n");
			strContent.append("                    </tr>                                                                 \n");
			strContent.append("                    <tr>                                                                  \n");
			strContent.append("                        <th>출고수량(L)</th>                                              \n");
			strContent.append("                        <th>"+StringUtil.commaSetting(inputData.getString("issueQty"))+"</th>                                                        \n");
			strContent.append("                        <th></th>                                                        \n");
			strContent.append("                    </tr>                                                                 \n");
			strContent.append("            </table>                                                                      \n");
			strContent.append("            </dt>                                                                         \n");
			strContent.append("            </dl>                                                                         \n");
			strContent.append("        </div>                                                                            \n");
			strContent.append("    </fieldset>                                                                           \n");
			strContent.append("    <h2> <span> 3.석탄  </span></h2>                                                      \n");
			strContent.append("    <!--검색 S -->                                                                        \n");
			strContent.append("     <fieldset >                                                                          \n");
			strContent.append("        <div>                                                                             \n");
			strContent.append("            <dl>                                                                          \n");
			strContent.append("            <dt>                                                                          \n");
			strContent.append("            <table width='100%' border='1' cellpadding='0' cellspacing='0' />             \n");
			strContent.append("                    <colgroup>                                                            \n");
			strContent.append("                    <col width='30%'/>                                                    \n");
			strContent.append("                    <col width='35%'/>                                                    \n");
			strContent.append("                    <col width='35%'/>                                                    \n");
			strContent.append("                    </colgroup>                                                           \n");
			strContent.append("                    <tr>                                                                  \n");
			strContent.append("                        <th></th>                                                       \n");
			strContent.append("                        <th>WEB</th>                                                      \n");
			strContent.append("                        <th>SAP</th>                                                      \n");
			strContent.append("                    </tr>                                                                 \n");
			strContent.append("                    <tr>                                                                  \n");
			strContent.append("                        <th>생산량(MT)</th>                                               \n");
			strContent.append("                        <th>"+StringUtil.commaSetting(inputData.getString("colProdQty"))+"</th>                                                        \n");
			strContent.append("                        <th></th>                                                        \n");
			strContent.append("                    </tr>                                                                 \n");
			strContent.append("            </table>                                                                      \n");
			strContent.append("            </dt>                                                                         \n");
			strContent.append("            </dl>                                                                         \n");
			strContent.append("        </div>                                                                            \n");
			strContent.append("    </fieldset>                                                                           \n");
			strContent.append("</div>                                                                                    \n");

			LLog.info.write("\n emailBiz > sendOnlyMail() : totalDocs : "+StringUtil.commaSetting(inputData.getString("totalDocs")));
			LLog.info.write("\n emailBiz > sendOnlyMail() : insert : "+StringUtil.commaSetting(inputData.getString("insert")));
			LLog.info.write("\n emailBiz > sendOnlyMail() : confirm : "+StringUtil.commaSetting(inputData.getString("confirm")));
			LLog.info.write("\n emailBiz > sendOnlyMail() : sapSended : "+StringUtil.commaSetting(inputData.getString("sapSended")));
			LLog.info.write("\n emailBiz > sendOnlyMail() : returnSap : "+StringUtil.commaSetting(inputData.getString("returnSap")));
			LLog.info.write("\n emailBiz > sendOnlyMail() : cancelRequest : "+StringUtil.commaSetting(inputData.getString("cancelRequest")));
			LLog.info.write("\n emailBiz > sendOnlyMail() : posting : "+StringUtil.commaSetting(inputData.getString("posting")));
			
			String strMailHtml		    = strContent.toString();	
			// mail 보내기
			LMail mail = new LMail();  
		    mail.setFromMailAddress(fromAddress);

		    mail.setToMailAddress(toAddress);
//			mail.setToMailAddress(toAddress);
			
			LLog.debug.println("1--------------- send Html:\r\n" + strMailHtml); 
//			LLog.debug.println("1--------------- send strContent:\r\n" + strContent); 
			LLog.info.write("\n emailBiz > sendOnlyMail() : tite : "+tite);
			LLog.info.write("\n emailBiz > sendOnlyMail() : fileName : "+inputData.getString("filename"));
			
			mail.setSubject(tite); 
			mail.setHtmlAndFile(strMailHtml,  inputData.getString("filename"));//.setHtml(strMailHtml); "C:\\Statement_of_accounts.xls"
			
			mail.send();
			
			//dao.add ("po/oc/purchOrderRegSql/cudPurchOrderRegUpdateSendDate",inputData ); 
			//dao.executeUpdate();
			//dao.commit();
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
    
}
