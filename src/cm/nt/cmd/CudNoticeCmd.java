/* ------------------------------------------------------------------------
 * @source  : CudNoticeCmd.java
 * @desc    : notice cud 
 * ------------------------------------------------------------------------
 *
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2010.07.24                      Initial
 * 1.1 2014.04.14    jwhan				CSR:C20140414_23324
 * ------------------------------------------------------------------------ */


package cm.nt.cmd;

import cm.nt.biz.NoticeBiz;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
public class CudNoticeCmd implements LCommandIF {
    /**
     * @param req Http Request 객체.
     * @param res Http Response 객체.
     * @param gauceRequest 가우스 Request 객체.
     * @param gauceResponse 가우스 Response 객체.
     * @exception LException Commnad 단 이하의 모든 에러.
     */
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {

		
		LLog.info.write("CudNoticeCmd =========== start ");
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
	    
	    //사용자iD 추가.`
	    inputData.setString("userId", loginUser.getString("userId"));
	    inputData.setString("lang",   loginUser.getString("lang"));
		inputData.setString("companyCd",loginUser.getString("companyCd"));
		LData resultMsg = new LData();
		
		NoticeBiz biz = new NoticeBiz();
 
		String userIdInSession   = loginUser.getString("userId");
		String userIdInInputData = inputData.getString("regid");
		

		
		
		if(userIdInSession.equals(userIdInInputData)){
	    LLog.info.println("\nuserIdInSession.equals(userIdInInputData)\n");
		//이미지 파일 업로드
		LMultipartRequest lmtpReq = new LMultipartRequest( req , "board" );


		//upload된 파일의 정보를 얻어온다.
        LFileInfo lfifFileInfos[] = lmtpReq.getFileInfos( "uploadfile" ); 
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

        boolean realUser = LXssCollectionUtility.getData( lmtpReq ).getString("regId").equals(loginUser.getString("userId"));
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
		            
//		          DRM 복호화 부분  //////////// 
		            /**
		              DevonFramework 3, 4 의 파일 경로 구하는 메소드가 다름.
		             */
			         //LLog.info.println(saveFile.getAbsolutePath());//devonFramework4
			         LLog.info.write( "file path  +++++++++++++++++++++++++++"+lfifFileInfos[i].getServerPath()  );//devonFramework3
			         
			         //String dstFile=saveFile.getAbsolutePath()+"_dec";//devonFramework4
			         String dstFile = lfifFileInfos[i].getServerPath()+"_dec";//devonFramework3
			         
			         
			         SLDsFile sFile = new SLDsFile();

			         //sFile.SettingPathForProperty("/data1/bea103/keyManager/softcamp.properties"); //Production
			         sFile.SettingPathForProperty("/data2/bea103/keyManager/softcamp.properties");   //Development
			         
			         System.out.println("/data2/bea103/keyManager/softcamp.properties");
			         
			         System.out.println("/data2/bea103/keyManager/keyDAC_SVR0.sc");


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
		            
		            LLog.info.println( "file path  +++++++++++++++++++++++++++"+lfifFileInfos[i].getServerPath());
		           
		            
		        }
		        
	        } 
			biz.saveNotice(inputData);		

	        resultMsg.setString("msg", "Success");
	        
		}
        
        req.setAttribute("inputData", inputData);
        req.setAttribute("resultMsg", resultMsg);	
        LLog.info.write("CudNoticeCmd =========== end ");
    }
	}
	
}
