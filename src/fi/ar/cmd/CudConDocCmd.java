/* ------------------------------------------------------------------------
 * @source  : CudConDocCmd.java
 * @desc    : ConDoc cud 
 * ------------------------------------------------------------------------
 *
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2010.07.24                      Initial
 * ------------------------------------------------------------------------ */


package fi.ar.cmd;

import fi.ar.biz.ConDocBiz;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import comm.util.LXssCollectionUtility;

import devon.core.collection.LData;
//import devon.core.collection.LMultiData;
import devon.core.exception.LException;
import devonframework.front.command.LCommandIF;
import devonframework.front.fileupload.LFileInfo;
import devonframework.front.fileupload.LMultipartRequest;

/**
 * <PRE>
 * 
 * 
 * </PRE>
 * 
 * @author    ceh
 * @see       
 */
public class CudConDocCmd implements LCommandIF {
    /**
     * 
     *
     * @param req Http Request 객체.
     * @param res Http Response 객체.
     * @param gauceRequest 가우스 Request 객체.
     * @param gauceResponse 가우스 Response 객체.
     * @exception LException Commnad 단 이하의 모든 에러.
     */
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {

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
		
		ConDocBiz biz = new ConDocBiz();
 
				
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

		if(bFileYN) {
 
	        inputData =  LXssCollectionUtility.getData( lmtpReq );		
 
			inputData.setString("userIp", req.getRemoteAddr());//등록자 IP
			
			LData seqData = biz.retrieveConDocSeq(inputData);	//신규일 경우 게시판 Seq
	 
			String[] delInfo = inputData.getString("delInfo").split(",");//파일 삭제 데이타
			
			//파일 삭제
			LData delData = new LData();
			for(int j=0; j < delInfo.length; j++){ 
				if(delInfo[j] != null){
					delData.setString("companyCd", inputData.getString("companyCd"));
					delData.setString("docNo", inputData.getString("docNo"));
					delData.setString("seqAttach", delInfo[j]);
					
					biz.deleteConDocAttach(delData);
				}
			}
			
			//첨부파일 등록
			int tmp = 1;
			for(int i=0; i < lfifFileInfos.length; i++) {
		        if ( lfifFileInfos[i] != null ) {
		        	if(inputData.getString("cudmode").equals("C")){
		        		inputData.setString("docNo", seqData.getString("nextSeq"));
		        	}
	
		        	LData attachSeqData = biz.retrieveConDocAttachSeq(inputData);
		        	inputData.setInt("seqAttach", attachSeqData.getInt("nextSeq"));
		            inputData.setString( "fileUrl" ,   lfifFileInfos[i].getFileName() ); // Upload시 원래 파일명
		            inputData.setString( "fileNm" , lfifFileInfos[i].getClientFileName() ); // 파일명
		
		            biz.saveConDocAttach(inputData);
		            
		            tmp++;
		        }
		        
	        } 
			biz.saveConDoc(inputData);		

	        resultMsg.setString("msg", "Success");
	        
		}
        
        req.setAttribute("inputData", inputData);
        req.setAttribute("resultMsg", resultMsg);	
		
    }
}
