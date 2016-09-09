/* ------------------------------------------------------------------------
 * @source  : CudAssetAcqRequestCmd.java
 * @desc    : 자산 취득 요청 정보 등록 처리
 * ------------------------------------------------------------------------
 *
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2015.12.22   hckim              Initial
 * ------------------------------------------------------------------------ */

package fi.at.cmd;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import SCSL.SLDsFile;
import comm.util.LXssCollectionUtility;
import devon.core.collection.LData;
import devon.core.exception.LException;
import devon.core.log.LLog;
import devonframework.front.channel.LNavigationAlter;
import devonframework.front.command.LCommandIF;
import devonframework.front.fileupload.LFileInfo;
import devonframework.front.fileupload.LMultipartRequest;
import fi.at.biz.AssetBiz;

public class CudAssetAcqRequestCmd implements LCommandIF {
    /**
     * @param req Http Request 객체.
     * @param res Http Response 객체.
     * @param gauceRequest 가우스 Request 객체.
     * @param gauceResponse 가우스 Response 객체.
     * @exception LException Commnad 단 이하의 모든 에러.
     */
	
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {

		LLog.info.println("CudAssetAcqRequestCmd ================  start");
		
		LData inputData = LXssCollectionUtility.getData(req);
		LData resultMsg = new LData();				
		LData resultData = new LData();
		
		long getErrorCode = 0 ;
        String getMessage = "";
        
        //-------------------------------------- Session 종료시 처리 START
  		HttpSession session = req.getSession(false);
  		LData loginUser = new LData();
  		
  		if (session != null) loginUser = (LData)session.getAttribute("loginUser");
  		if( loginUser.getString("userId") == null) {
  			getMessage = "Session is Terminated. You need to relogin!";  			
  			LNavigationAlter.setReturnUrl(req, "/index.jsp");
  			return;
  		}
  		//-------------------------------------- Session 종료시 처리 END
	    
  	    // Session 정보 추가
	    inputData.setString("userId", loginUser.getString("userId"));
	    inputData.setString("lang",   loginUser.getString("lang"));
		inputData.setString("companyCd",loginUser.getString("companyCd"));
  			    	    	    	   		    												
		// 이미지 파일 업로드		
		LMultipartRequest lmtpReq = new LMultipartRequest( req , "asset" );

		// upload 된 파일의 정보를 얻어온다.
        LFileInfo lfifFileInfos[] = lmtpReq.getFileInfos( "fileUpload" ); 
        
        // 파일명 CSS 체크
        String fileNm = "";
        boolean checkXss = true;
        
    	fileNm = lfifFileInfos[0].getFileName();    	
    	checkXss = LXssCollectionUtility.checkXSS(fileNm);
    	
    	LLog.info.println("==================  Request Information 등록 PARAM  ====================");
	    LLog.info.println("assetNm    : " + inputData.getString("assetNm"));
	    LLog.info.println("qty        : " + inputData.getString("qty"));
	    LLog.info.println("amount     : " + inputData.getString("amount"));
	    LLog.info.println("currCd     : " + inputData.getString("currCd"));
	    LLog.info.println("acqDate    : " + inputData.getString("acqDate"));
	    LLog.info.println("vendCd     : " + inputData.getString("vendCd"));
	    LLog.info.println("assetDesc  : " + inputData.getString("assetDesc"));
	    LLog.info.println("unit       : " + inputData.getString("unit"));
	    LLog.info.println("costCenter : " + inputData.getString("costCenter"));
	    LLog.info.println("userId     : " + inputData.getString("userId"));
	    LLog.info.println("lang       : " + inputData.getString("lang"));
	    LLog.info.println("companyCd  : " + inputData.getString("companyCd"));
	    LLog.info.println("fileNm     : " + fileNm);
	    LLog.info.println("checkXss   : " + checkXss);
	    LLog.info.println("========================================================================");
    	
    	if (!checkXss) {
    		throw new Exception("XSS : Error on File Name!");
    	}
                
        //파일용량 체크
        long lFileSize = 0;
        boolean bFileYN = true;
                 
        lFileSize = lfifFileInfos[0].getSize();
        
        if(lFileSize > 5120000) {        	
        	bFileYN = false;
        	resultMsg.setString("msg", "FileSizeOver");
        }
        
        LLog.info.println("lFileSize  : " + lFileSize);
        LLog.info.println("bFileYN    : " + bFileYN);
	    LLog.info.println("========================================================================");
	    
	    
        
		if(bFileYN) {     
				        	        	       				        									
			// 첨부파일 정보 담기						
	        if ( lfifFileInfos[0] != null ) {	   
	        	
	        	// 원본 파일명 추가
	            inputData.setString("fileNm", lfifFileInfos[0].getClientFileName());	            	            
	            
	            // 업로드 된 파일명 추가
	            inputData.setString("fileUrl", lfifFileInfos[0].getFileName());
	           	            
	            // DRM 복호화 부분	            
	            // DevonFramework 3, 4 의 파일 경로 구하는 메소드가 다름.
	            LLog.info.println("file path : " + lfifFileInfos[0].getServerPath()  ); //devonFramework3	             	            	           
	            
		        String dstFile = lfifFileInfos[0].getServerPath() + "_dec"; //devonFramework3
		         		         
		        LLog.info.println("dstFile : " + dstFile  );
		        
		        SLDsFile sFile = new SLDsFile();

		        sFile.SettingPathForProperty("/data1/bea103/keyManager/softcamp.properties"); //arr2는 227 서버 기준.

                // 첨부 파일 복호화
		        int retVal = sFile.CreateDecryptFileDAC("/data1/bea103/keyManager/keyDAC_SVR0.sc", "SECURITYDOMAIN", lfifFileInfos[0].getServerPath(), dstFile);
		        LLog.info.println("CreateDecryptFileDAC [" + retVal + "]"); //devonFramework3

                // 복호화된 파일을 원본 파일로 복사 (이름 변경) 
		        retVal = sFile.CreateDecryptFileDAC("/data1/bea103/keyManager/keyDAC_SVR0.sc", "SECURITYDOMAIN", dstFile, lfifFileInfos[0].getServerPath());
                LLog.info.println("CreateDecryptFileDAC [" + retVal + "]");
	            LLog.info.println("========================================================================");
	        }
		        	        	        	        	        	        
	        LLog.info.println("fileUrl   : " + inputData.getString("fileUrl"));
	        LLog.info.println("fileNm    : " + inputData.getString("fileNm"));
	        LLog.info.println("========================================================================");
            
            AssetBiz biz = new AssetBiz();
            
            LData seqData = new LData();
            
            // 자산요청번호 정보( MD 또는 UA + YYYYMMDD + *** + A ) 
            if("MD00".equals(inputData.getString("companyCd"))){
            	seqData = biz.retrieveMdAssetRequestNo(inputData);
            }else{
            	seqData = biz.retrieveUaAssetRequestNo(inputData);
            }                 	    

            // 자산요청번호 추가
            inputData.setString("requestNo", seqData.getString("requestNo"));
            
            LLog.info.println("========================  자산요청번호  ================================");
            LLog.info.println("requestNo : " + inputData.getString("requestNo"));
            LLog.info.println("========================================================================");
            
            // 요청 타입 ( A (취득요청(Acquisition)), D (매각요청(Disposal)), R (폐기요청(Retirement)) )
            inputData.setString("requestType", "A");
            
            // SAP 상태코드 ( R(최초등록), P(XI SAP 전송), S(SAP 처리) )
            inputData.setString("sapStatus", "R");
            
            // 삭제유무
            inputData.setString("delYn", "N");
            
            LLog.info.println("requestType : " + inputData.getString("requestType"));
            LLog.info.println("sapStatus   : " + inputData.getString("sapStatus"));
            LLog.info.println("delYn       : " + inputData.getString("delYn"));
            LLog.info.println("========================================================================");
			
			// 자산취득 요청 정보 저장
            resultData = biz.cudAssetInfo(inputData);
            
            getErrorCode = resultData.getLong("getErrorCode");
            getMessage	 = resultData.getString("getMessage");                        

    		LLog.info.write("===================  Request Information (자산취득 요청) 등록 결과 MSG  ======================");    		
    		LLog.info.write("getMessage   :" + getMessage);
    		LLog.info.write("==============================================================================================");
    		    		
    		resultMsg.setString("msg", getMessage);    			        
	        
		}else{
		    LLog.info.println("else in !!!!!!!!!!!!");
			resultMsg.setString("msg", "You are not writer or Administor");
			
		}
        
        req.setAttribute("inputData", inputData);
        req.setAttribute("resultMsg", resultMsg);	
		        
    	LLog.info.println("CudAssetAcqRequestCmd ================  end");
        
    }
}