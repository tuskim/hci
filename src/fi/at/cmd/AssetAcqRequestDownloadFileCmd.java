/* ------------------------------------------------------------------------
 * @source  : AssetAcqRequestDownloadFileCmd.java
 * @desc    : Requested Asset List 화면 : 그리드 내 첨부된 파일 다운로드 
 * ------------------------------------------------------------------------
 *
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2015.12.24   hckim              Initial
 * ------------------------------------------------------------------------ */

package fi.at.cmd;

import java.io.File;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import comm.util.LXssCollectionUtility;
import devon.core.DevOnHome;
import devon.core.collection.LData;
import devonframework.front.command.LCommandIF;
import devonframework.front.filedownload.LFileDownload;
import devon.core.exception.LSysException;
import devon.core.log.LLog;

public class AssetAcqRequestDownloadFileCmd implements LCommandIF{

	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		LData inputData = LXssCollectionUtility.getData(req);

		long  getErrorCode = 0 ;
        String getMessage   = "";
        
		//-------------------------------------- Session 종료시 처리 START
	    HttpSession session = req.getSession(false);
	    LData loginUser = new LData();
	    
	    try
	    {
		    if (session != null){
		    	loginUser = (LData)session.getAttribute("loginUser");
		    }
		    if( loginUser.getString("userId") == null) {
		    	getMessage = "Session is Terminated. You need to relogin!";
		    	return;
		    }
		    //-------------------------------------- Session 종료시 처리 END
		    
		    //사용자iD 추가.`
		    inputData.setString("userId", loginUser.getString("userId"));
		    inputData.setString("lang",   loginUser.getString("lang"));
			inputData.setString("companyCd",loginUser.getString("companyCd"));
			
			LLog.info.println("==================  Asset File Download 관련 PARAM  ====================");
		    LLog.info.println("fileUrl  : " + inputData.getString("fileUrl"));
		    LLog.info.println("fileName : " + inputData.getString("fileName"));
		    LLog.info.println("========================================================================");
									
			LFileDownload download = new LFileDownload(req, res);
			
			File file = null;
			
			if(File.separator.equals("/")){  // Unix								
//				file = new File(DevOnHome.getHome() + File.separator + "doc" + File.separator + "asset"  + File.separator + inputData.getString("fileUrl"));  //개발  
				file = new File(File.separator + "data2" + File.separator + "lils" + File.separator + "doc" + File.separator + "sr"  + File.separator + "gims" + File.separator + inputData.getString("fileUrl"));  // 운영
			}else{
//				file = new File(DevOnHome.getHome() + File.separator + "doc" + File.separator + "asset"  + File.separator + inputData.getString("fileUrl"));  //개발
				file = new File(File.separator + "data2" + File.separator + "lils" + File.separator + "doc" + File.separator + "sr"  + File.separator + "gims" + File.separator + inputData.getString("fileUrl"));  // 운영
			}
								
			File f = file.getAbsoluteFile();
			 
			download.streamTo(file, inputData.getString("fileName"));
			
	    }catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "AssetAcqRequestDownloadFileCmd------()" + "=>" + se.getMessage());
			throw new LSysException("AssetAcqRequestDownloadFileCmd", se);
	    }
	}

}
