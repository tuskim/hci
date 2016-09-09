/* ------------------------------------------------------------------------
 * @source  : RetrieveNoticeListCmd.java
 * @desc    : notice List
 * ------------------------------------------------------------------------
 *
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2010.07.24                      Initial
 * 1.1  2015.10.08   hskim              CSR:C20151005_87394 XSS 파일 필터링
 * 1.2  2016.04.04   hskim              CSR:C20160330_24662 게시물 ID와 세션 ID 비교 처리 추가
 * ------------------------------------------------------------------------ */

 

package cm.nt.cmd;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cm.nt.biz.NoticeBiz;

import comm.util.LXssCollectionUtility;

import devon.core.collection.LData;
import devon.core.exception.LException;
import devon.core.log.LLog;
import devonframework.front.command.LCommandIF;
import devonframework.front.fileupload.LFileInfo;
import devonframework.front.fileupload.LMultipartRequest;
import SCSL.SLDsFile;
/**
 * <PRE>
 * </PRE>
 * 
 * @author    ceh
 * @see       
 */
public class RetrieveNoticeCudCmd implements LCommandIF {
    /**
     * @param req Http Request 객체.
     * @param res Http Response 객체.
     * @param gauceRequest 가우스 Request 객체.
     * @param gauceResponse 가우스 Response 객체.
     * @exception LException Commnad 단 이하의 모든 에러.
     */
	
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {

		LLog.info.println("RetrieveNoticeCudCmd ================  start");
		
		LData inputData = LXssCollectionUtility.getData(req);

		long  getErrorCode = 0 ;
        String getMessage   = "";
        
		//-------------------------------------- Session 종료시 처리 START
	    HttpSession session = req.getSession(false);
	    LData loginUser = new LData();
	    
	    if (session != null) loginUser = (LData)session.getAttribute("loginUser");
	    if( loginUser.getString("userId") == null) {
	    	getMessage = "Session is Terminated. You need to relogin!";
	    	 
	    	return;
	    }
	    //-------------------------------------- Session 종료시 처리 END
	    
	    LLog.info.println("JSP 에서 받아온 데이터 inputData"+inputData);
	    
	    NoticeBiz biz = new NoticeBiz();
	
	    //사용자iD 추가.
	    inputData.setString("userId", loginUser.getString("userId"));
	    inputData.setString("lang",   loginUser.getString("lang"));
		inputData.setString("companyCd",loginUser.getString("companyCd"));
		LData resultMsg = new LData();
		LData noticeData = new LData();
				
		//이미지 파일 업로드
		LMultipartRequest lmtpReq = new LMultipartRequest( req , "board" );


		//upload된 파일의 정보를 얻어온다.
        LFileInfo lfifFileInfos[] = lmtpReq.getFileInfos( "uploadfile" ); 
        
        //파일명 CSS 체크
        String fileNm = "";
        boolean checkXss = true;
        for(int i=0; i < lfifFileInfos.length; i++) {
        	fileNm = lfifFileInfos[i].getFileName();
        	
        	checkXss = LXssCollectionUtility.checkXSS(fileNm);
        	
        	if (!checkXss) {
        		throw new Exception("XSS : Error on File Name!");
        	}
        }
        
        //파일용량 체크
        long lFileSize = 0;
        boolean bFileYN = true;
        for(int i=0; i < lfifFileInfos.length; i++) {
 
            lFileSize = lfifFileInfos[i].getSize();
            
            if(lFileSize > 5120000) {

            	for(int j=0; j < lfifFileInfos.length; j++) {

            		lfifFileInfos[j].delete();
            	}
            	bFileYN = false;
            	resultMsg.setString("msg", "FileSizeOver");

            	break;
            }
        }
        
        boolean realUser = true;
        
        inputData =  LXssCollectionUtility.getData( lmtpReq );
        
        if (!inputData.getString("cudmode").equals("C")) {
        	noticeData = biz.retrieveNoticeUpdate(inputData);
        	System.out.println(noticeData);
        	realUser = noticeData.getString("regid").equals(loginUser.getString("userId"));
        }    
        
        //boolean realUser = LXssCollectionUtility.getData( lmtpReq ).getString("regId").equals(loginUser.getString("userId"));
		boolean authAdmin = loginUser.getString("authCd").equals("AD");
       
		if(bFileYN && ( realUser || authAdmin )) {
			
	        inputData =  LXssCollectionUtility.getData( lmtpReq );
	        inputData.setString("userIp", req.getRemoteAddr());//등록자 IP
			LData seqData = biz.retrieveNoticeSeq(inputData);	//신규일 경우 게시판 Seq
			String[] delInfo = inputData.getString("delInfo").split(",");//파일 삭제 데이타
			
			//파일 삭제
			LData delData = new LData();
			for(int j=0; j < delInfo.length; j++){ 
				if(delInfo[j] != null){
					delData.setString("companyCd", inputData.getString("companyCd"));
					delData.setString("seq", inputData.getString("seq"));
					delData.setString("seqAttach", delInfo[j]);
					
					biz.deleteNoticeAttach(delData);
				}
			}
			
			//첨부파일 등록
			int tmp = 1;
			for(int i=0; i < lfifFileInfos.length; i++) {
		        if ( lfifFileInfos[i] != null ) {
		        	if(inputData.getString("cudmode").equals("C")){
		        		inputData.setString("seq", seqData.getString("nextSeq"));
		        	}
	
		        	LData attachSeqData = biz.retrieveNoticeAttachSeq(inputData);
		        	inputData.setInt("seqAttach", attachSeqData.getInt("nextSeq"));
		            inputData.setString( "fileUrl" ,   lfifFileInfos[i].getFileName() ); // Upload시 원래 파일명
		            inputData.setString( "fileNm" , lfifFileInfos[i].getClientFileName() ); // 파일명
		
		            biz.saveNoticeAttach(inputData);
		            
		            
		                       

//			         DRM 복호화 부분  ////////////
		            /**
		             * DevonFramework 3, 4 의 파일 경로 구하는 메소드가 다름.
		             * */
			         //LLog.info.println(saveFile.getAbsolutePath());//devonFramework4
			         LLog.info.write( "file path  +++++++++++++++++++++++++++"+lfifFileInfos[i].getServerPath()  );//devonFramework3
			         
			         //String dstFile=saveFile.getAbsolutePath()+"_dec";//devonFramework4
			         String dstFile = lfifFileInfos[i].getServerPath()+"_dec";//devonFramework3
			         
			         
			         SLDsFile sFile = new SLDsFile();

			         //sFile.SettingPathForProperty("/data1/bea103/keyManager/softcamp.properties"); //Production
			         sFile.SettingPathForProperty("/data2/bea103/keyManager/softcamp.properties");   //Development



//			         첨부 파일 복호화
			         int retVal = sFile.CreateDecryptFileDAC (
			         //"/data1/bea103/keyManager/keyDAC_SVR0.sc", //Production
					 "/data2/bea103/keyManager/keyDAC_SVR0.sc",    //Development
			         "SECURITYDOMAIN",
			         lfifFileInfos[i].getServerPath(),
			         dstFile);
			         LLog.info.println( " CreateDecryptFileDAC [" + retVal + "]");


//			          복호화된 파일을 원본 파일로 복사 (이름 변경) 
			         retVal = sFile.CreateDecryptFileDAC (
			        		 		//"/data1/bea103/keyManager/keyDAC_SVR0.sc",  //Production
		         					"/data2/bea103/keyManager/keyDAC_SVR0.sc",    //Development
			         				"SECURITYDOMAIN",
			         				dstFile,
			         				lfifFileInfos[i].getServerPath());
                    LLog.info.write(lfifFileInfos[i].getServerPath());
		            LLog.info.println(" CreateDecryptFileDAC [" + retVal + "]");
		               
		            
		            tmp++;
		                       
		            
		        }
		        
	        } 
			
			LLog.info.println("SAVE 바로 전 inputData **********************\n"+ inputData);
			biz.saveNotice(inputData);		

	        resultMsg.setString("msg", "Success");
	        
		}else{
		    LLog.info.println("else in !!!!!!!!!!!!");
			resultMsg.setString("msg", "You are not writer or Administrator");
			
		}
        
        req.setAttribute("inputData", inputData);
        req.setAttribute("resultMsg", resultMsg);	
		
        
    	LLog.info.println("RetrieveNoticeCudCmd ================  end");
        
    }
}