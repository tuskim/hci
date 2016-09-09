/*
 *------------------------------------------------------------------------------
 * emailBiz.java,v 1.0 2010/07/23 16:43:35 
 * 
 * PROJ : PIT-PAM 
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2010/07/23            최초 프로그램 작성
 *----------------------------------------------------------------------------
 */

package email.biz;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import comm.util.StringUtil;
import comm.util.Util;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.config.LConfiguration;
import devon.core.exception.LBizException;
import devon.core.exception.LException;
import devon.core.log.LLog;
import devonframework.front.fileupload.LFileInfo;
import devonframework.front.fileupload.LMultipartRequest;
import devonframework.persistent.autodao.LCommonDao;
import devonframework.persistent.autodao.LCompoundDao;
import devonframework.service.mail.LMail;

public class emailBiz {
	
	/* ******************************
	 * E-mail Send
	 * ******************************/
    public LData sendMgntCmd(LData inputData) throws LException {

    	LLog.debug.write("\n emailBiz > sendMgntCmd() ------------- Start"+inputData);
    	
        //LCompoundDao dao			= new LCompoundDao();

        String msg 					= "";
        
		String	getErrorCode		= "";
		String	getMessage			= "";
		String	getStatus			= "";
			
		LData dataBox	  	 		= new LData();
		
		//dao.startTransaction();
		
		try{
			
			String fromAddress 			= inputData.getString("txemail");						// 메일 보낸이
			String subject 				= inputData.getString("subject");						// 메일 제목
			
			String toAddress[]  		= inputData.getString("receive").split(",");				// 메일 받는이들
			String ccAddress[]      	= ",".split(","); 											// 참조 받는이들
			String bccAddress[]     	= ",".split(",");											// 숨은참조 받는이들
			String strMailHtml		    = "";														// 메일 Html
			
			String fileName = "";
			
			if(inputData.getString("uploadfile") != null && !inputData.getString("uploadfile").equals("")) {
				fileName = inputData.getString("uploadfile");
			}
			
		    // Method 위치변수
	        String location = this.getClass().getName() + ".sendEmailMgntCmd() ";


			//------------------------------------------------------- 파일첨부 END
			
			strMailHtml  += "\n<html>";
			strMailHtml  += "\n<head>";
			strMailHtml  += "\n	<title>GO! SCM</title>";
			strMailHtml  += "\n</head>";
			strMailHtml  += "\n<body>";
			strMailHtml  += "\n<table border=0 cellpadding=0 cellspacing=0 bgcolor='#0e133b'>";
			strMailHtml  += "\n  <tr>";
			strMailHtml  += "\n	  <td><img src='http://www.goscm.net/sys/images/mail_top.jpg' width='600' height='54' alt=''></td>";
			strMailHtml  += "\n	</tr>";
			strMailHtml  += "\n	<tr>";
			strMailHtml  += "\n	  <td style='text-align:center;'>";
			strMailHtml  += "\n		  <table border=0 cellpadding=0 cellspacing=0 style='background:#fff; width:586px;'>";
			strMailHtml  += "\n			  <tr>";
			strMailHtml  += "\n				  <td><img src='http://www.goscm.net/sys/images/mail_body_top.jpg' width='586' height='20' alt=''></td>";
			strMailHtml  += "\n				</tr>";
			strMailHtml  += "\n				<tr>";
			strMailHtml  += "\n				  <td style='text-align:center; padding:0 15px 20px 15px'>";
			strMailHtml  += "\n						<table border=0 cellpadding=0 cellspacing=0 width=100% style='border:1px solid; border-collapse: collapse; border-color:#76c7e7 #fff'>";
			strMailHtml  += "\n							<tr>";
			strMailHtml  += "\n							  <th style='font:12px tahoma, AppleGothic, Sans-serif; color:#2daed9; background:#ecf8fe; padding:5px; font-weight:bold; border:1px solid #cbdee5;'>Subject</th>";
			strMailHtml  += "\n								<td style='font:12px tahoma, AppleGothic, Sans-serif; color:#666; background:#fff; padding:5px;; border:1px solid #cbdee5;'>" + subject + "</td>";
			strMailHtml  += "\n							</tr>";
			strMailHtml  += "\n							<tr>";
			strMailHtml  += "\n							  <th style='font:12px tahoma, AppleGothic, Sans-serif; color:#2daed9; background:#ecf8fe; padding:5px; font-weight:bold; border:1px solid #cbdee5;'>Content</th>";
			strMailHtml  += "\n								<td style='font:12px tahoma, AppleGothic, Sans-serif; color:#666; background:#fff; padding:5px;; border:1px solid #cbdee5; line-height:18px'>";
			strMailHtml  += 							Util.replace(inputData.getString("content1"), "\n", "<br>");
			strMailHtml  += "\n								</td>";
			strMailHtml  += "\n							</tr>	";

			if(inputData.getString("uploadfile") != null && !inputData.getString("uploadfile").equals("")) {
				strMailHtml  += "\n							<tr>";
				strMailHtml  += "\n							  <th style='font:12px tahoma, AppleGothic, Sans-serif; color:#2daed9; background:#ecf8fe; padding:5px; font-weight:bold; border:1px solid #cbdee5;'>Attachment</th>";
				strMailHtml  += "\n								<td style='font:12px tahoma, AppleGothic, Sans-serif; color:#666; background:#fff; padding:5px;; border:1px solid #cbdee5; line-height:18px'>";
				strMailHtml  += 			(inputData.getString("uploadfilename") == null) ? "" : inputData.getString("uploadfilename");
				strMailHtml  += "\n								</td>";
				strMailHtml  += "\n							</tr>	";
			}

			strMailHtml  += "\n						</table>	";				
			strMailHtml  += "\n					</td>";
			strMailHtml  += "\n				</tr>";
			strMailHtml  += "\n				<tr>";
			strMailHtml  += "\n				  <td style='text-align:center; padding-bottom:20px;'>";
			strMailHtml  += "\n					  <table border=0 cellpadding=0 cellspacing=0>";
			strMailHtml  += "\n						  <tr>";
			strMailHtml  += "\n							  <td><img src='http://www.goscm.net/sys/images/mail_btn_l.gif' width='15' height='28' alt=''></td>";
			strMailHtml  += "\n								<td background='http://www.goscm.net/sys/images/mail_btn_c.gif' style='font:12px tahoma, AppleGothic, Sans-serif; color:#fff; font-weight:bold;'><a href='http://www.goscm.net/' target='_blank'><span style='color:#fff; text-decoration:none;'>Total Services based on Fulfillment HUB</span><img src='http://www.goscm.net/sys/images/mail_btn_arrow.gif' width='9' height='5' alt='' align='absmiddle' style='margin-left:5px' border='0'></a></td>";
			strMailHtml  += "\n								<td><img src='http://www.goscm.net/sys/images/mail_btn_r.gif' width='15' height='28' alt=''></td>";
			strMailHtml  += "\n							</tr>";
			strMailHtml  += "\n						</table>";
			strMailHtml  += "\n					</td>";
			strMailHtml  += "\n				</tr>";
			strMailHtml  += "\n			</table>";
			strMailHtml  += "\n		</td>";
			strMailHtml  += "\n	</tr>";
			strMailHtml  += "\n	<tr>";
			strMailHtml  += "\n	  <td height=40>";
			strMailHtml  += "\n		  <table border=0 cellpadding=0 cellspacing=0 width=600>";
			strMailHtml  += "\n			  <tr>";
			strMailHtml  += "\n				  <td style='padding-left:5px'><img src='http://www.goscm.net/sys/images/mail_footer_logo.gif' width='80' height='21' alt=''></td>";
			strMailHtml  += "\n					<td align='right'><div style='font:11px tahoma, AppleGothic, Sans-serif; color:#575a76; padding-right:10px;'>Global Organized Supply Chain Management System</div></td>";
			strMailHtml  += "\n				</tr>";
			strMailHtml  += "\n			</table>";
			strMailHtml  += "\n		</td>";
			strMailHtml  += "\n	</tr>";
			strMailHtml  += "\n</table>";
			strMailHtml  += "\n</body>";
			strMailHtml  += "\n</html>";

		    
			// mail 보내기
			LMail mail = new LMail();  
            
		    mail.setFromMailAddress(fromAddress);
			mail.setSubject(subject);

			mail.setToMailAddress(toAddress);
			mail.setCcMailAddress(ccAddress);
			mail.setBccMailAddress(bccAddress);

			LLog.debug.println("1--------------- send Html:\r\n" + strMailHtml);
			
			if(inputData.getString("uploadfile") != null && !inputData.getString("uploadfile").equals("")) {
				//mail.setHtmlAndFile(strMailHtml, new String[]{inputData.getString("LOCALFILEPATH", 0)});	// 파일첨부인 경우
				mail.setHtmlAndFile(strMailHtml, new String[]{fileName});	// 파일첨부인 경우
			} else {
				mail.setHtml(strMailHtml);
			}
			
			mail.send();

		} catch (Exception se) {
			
			//dao.rollback();
			
			getErrorCode = "-99901";
			getMessage   = se.toString();
			getStatus    = "fail."+this.getClass().getName()+"."+"sendMgntCmd";
			
			LLog.err.println(this.getClass().getName()+"."+"sendMgntCmd()"+"=>" + msg);
		}
		
		//dao.executeUpdate();
		//dao.commit();
			
		LLog.info.write("\n emailBiz > sendMgntCmd() ------------- END --> \n");
		
		dataBox.put("getErrorCode"	,getErrorCode);
		dataBox.put("getMessage"	,getMessage);
		
		if(!getStatus.equals("")) dataBox.put("getStatus" ,getStatus ); //현 프로그램에서 에러

		return dataBox;
    }
    
    /**
     * 메일 전송
     * @param to         받는주소
     * @param cc         참조
     * @param title      제목
     * @param content    내용
     * @param sendAddr   보내는주소
     * @param sendName   보내는이름
     * @param mailServer 메일서버
     * @return 메일전송 true or false
     */
    public boolean sendMail(String to,String cc, String title,String content, String sendAddr
            , String sendName, String mailServer){

        // Method 위치변수
        String location = this.getClass().getName() + ".sendMail() ";
        
        try {
            Session session = Session.getInstance(System.getProperties(),null);

            MimeMessage msg = new MimeMessage(session);

            msg.setHeader("Content-Type","text/html;charset=UTF-8");
            msg.setHeader("Content-Transfer-Encoding",  "8bit");
            msg.setFrom(new InternetAddress(sendAddr,sendAddr,"UTF-8"));

            if (to != null && to.trim().length() != 0) {
                InternetAddress[] tos = InternetAddress.parse(to);
                msg.setRecipients(Message.RecipientType.TO, tos);
            }

            if (cc != null && cc.trim().length() != 0) {
                InternetAddress[] ccs = InternetAddress.parse(cc);
                msg.setRecipients(Message.RecipientType.CC, ccs);
            }

            msg.setSubject(title, "UTF-8");
            msg.setSentDate(new java.util.Date());
            msg.setContent(content, "text/html; charset=UTF-8");
            msg.saveChanges();

            Transport transport = session.getTransport("smtp");

            if (mailServer == null || mailServer.trim().length() == 0 
                    || mailServer.trim().equals("localhost")) {
                Transport.send(msg, msg.getAllRecipients());
            } else {
                transport.connect(mailServer, "", "");
                transport.sendMessage(msg, msg.getAllRecipients());
            }

            transport.close();
            return true;
        
        } catch(Exception ex) {
            // Exception 발생시 debug에는 trace까지 남기고, err에는 메세지만 남기도록 함
            LLog.err.println(location +" Exception => " + ex.getMessage());
            return false;
        }
    }
    
   	public int doOBLInsertDetailFileUpload( LData ldParam ) throws LException {

        LLog.debug.write( "\n emailBiz > doOBLInsertDetailFileUpload Start \n" );

        int iRtnTrs = 0;
        LData saveSeq = null;

        try {
        	
            LCommonDao lcomDao = new LCommonDao( "/sr/sra10Sql/insertSRDetailForwarderOBL" , ldParam );
            iRtnTrs = lcomDao.executeUpdate();

        } catch ( LException le ) {
            LLog.err.write(
                            this.getClass().getName() + "." + "doOBLInsertDetailFileUpload()" + "=>" + le.getMessage()
                          );
            throw new LBizException( "lgd.err.com.retrieve" );
        }

        LLog.debug.write( "\n emailBiz > doOBLInsertDetailFileUpload End \n" );

        return iRtnTrs;
    }
    public LData sendOnlyMail(LData inputData) throws LException {

    	LLog.debug.write("\n emailBiz > sendOnlyMail() ------------- Start"+inputData);
    	
        LCompoundDao dao			= new LCompoundDao(); 
        String msg 					= ""; 
		String	getErrorCode		= "";
		String	getMessage			= "";
		String	getStatus			= ""; 
		LData dataBox	  	 		= new LData();
		
		dao.startTransaction();
		
		try{
 
			String toAddress[]  		= inputData.getString("mainMail").split(",");				// 메일 받는이들
			String ccAddress[]      	= inputData.getString("refMail").split(","); 				// 참조 받는이들			
			String strMailHtml		    = inputData.getString("mailbody");							// 메일 Html
			String fromAddress		    = inputData.getString("email");	
 
			// mail 보내기
			LMail mail = new LMail();  
		    mail.setFromMailAddress(fromAddress);


			mail.setToMailAddress(toAddress);
			mail.setCcMailAddress(ccAddress);

			LLog.debug.println("1--------------- send Html:\r\n" + strMailHtml);

			mail.setHtml(strMailHtml); 
			
			mail.send();
			dao.add ("po/oc/purchOrderRegSql/cudPurchOrderRegUpdateSendDate",inputData ); 
			dao.executeUpdate();
			dao.commit();
		} catch (Exception se) {
			
			dao.rollback();
			LLog.err.println(this.getClass().getName()+"."+"rollback()"+"=>" + msg);
			getErrorCode = "-99901";
			getMessage   = se.toString();
			getStatus    = "fail."+this.getClass().getName()+"."+"sendOnlyMail";
			
			LLog.err.println(this.getClass().getName()+"."+"sendOnlyMail()"+"=>" + msg);
		} 
			
		LLog.info.write("\n emailBiz > sendOnlyMail() ------------- END --> \n");
		
		dataBox.put("getErrorCode"	,getErrorCode);
		dataBox.put("getMessage"	,getMessage);
		return dataBox;
    }	   	
}