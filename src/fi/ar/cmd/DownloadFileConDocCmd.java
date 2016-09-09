/* ------------------------------------------------------------------------
 * @source  : DownloadFileConDocCmd.java
 * @desc    : ConDocList filez 
 * ------------------------------------------------------------------------
 *
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2010.12.13                      Initial
 * ------------------------------------------------------------------------ */

package fi.ar.cmd;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import comm.util.LXssCollectionUtility;

import devon.core.DevOnHome;
import devon.core.collection.LData;
import devon.core.exception.LSysException;
import devon.core.log.LLog;
import devonframework.front.command.LCommandIF;
import devonframework.front.filedownload.LFileDownload;

public class DownloadFileConDocCmd implements LCommandIF{

	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		LData inputData = LXssCollectionUtility.getData(req);

		long  getErrorCode = 0 ;
        String getMessage   = "";
        
		//-------------------------------------- Session 종료시 처리 START
	    HttpSession session = req.getSession(false);
	    LData loginUser = new LData();
	    try
	    {
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
			LFileDownload download = new LFileDownload(req, res);
			
			File file = null;
			if(File.separator.equals("/")) // Unix
				file = new File(DevOnHome.getHome() + File.separator + "doc" + File.separator + "board"  + File.separator + inputData.getString("filename"));
			else
				file = new File(DevOnHome.getHome() + File.separator + "doc" + File.separator + "board"  + File.separator + inputData.getString("filename"));
	
			
			File f = file.getAbsoluteFile();
			
	
			
			download.streamTo(file, inputData.getString("fileReal"));
	    }catch (Exception se) {
			LLog.err.println(  this.getClass().getName() + "." + "DownloadFileConDoc------()" + "=>" + se.getMessage());
			throw new LSysException("DownloadFileConDoc", se);
	    }
	}

}
