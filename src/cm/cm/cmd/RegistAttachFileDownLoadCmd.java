/*******************************************************************************
 * PROJ : M3
 * NAME : RegistAttachFileDownLoadCmd 
 * DESC : 파일 다운로드
 * Author : SOFTONE
 * VER  : v1.0  * 
 * Copyright 2005 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항                       
 *------------------------------------------------------------------------------
 *    DATE     AUTHOR                      DESCRIPTION                        
 * ----------  ------  --------------------------------------------------------- 
 * 2009.11.05  김종철                     최초 프로그램 작성                                     
 *******************************************************************************/
package cm.cm.cmd;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import comm.util.LXssCollectionUtility; 
import devon.core.exception.LException;
import devon.core.log.LLog; 
import devonframework.front.command.LCommandIF;
import devonframework.front.filedownload.LFileDownload;
import devon.core.collection.LData;

public class RegistAttachFileDownLoadCmd implements LCommandIF {
    /**
     * 
     *
     * @param req Http Request 객체.
     * @param res Http Response 객체.
     * @param gauceRequest 가우스 Request 객체.
     * @param gauceResponse 가우스 Response 객체.
     * @exception LException Commnad 단 이하의 모든 에러.
     */
	public void execute(HttpServletRequest req, HttpServletResponse res) throws LException {
    	LData data = LXssCollectionUtility.getData(req);
    	String filepath = data.getString("filepath"); //시스템구분
    	String fileSysName = data.getString("sysfilename"); //시스템파일명
    	String fileName = data.getString("filename"); //파일명
    	String redirectUrl = data.getString("redirectUrl"); //파일없을때 이동할 경로
    	
    	fileDownload(filepath, fileSysName, fileName, redirectUrl);
    	
    	req.setAttribute("query", data);
    }
    
    
    // 파일 다운로드
    public void fileDownload(String filepath, String fileSysName, String fileName, String redirectUrl) throws LException {

        try {    		
    		String pathMarker = "";
    		String fileRootPath = "";//Constants.getFileUploadRoot();
        	String sysUploadPath = filepath;
        	if(fileRootPath.indexOf("C:") != -1 ){
        	  fileRootPath  = fileRootPath.replace('/', '\\');
        	  sysUploadPath = filepath.replace('/', '\\');
        	  pathMarker = "\\";
        	}else{
        	  pathMarker = "/";	
        	}
        	String fileFullPath = fileRootPath +  sysUploadPath + pathMarker + fileSysName;
        	
            LLog.info.println(fileFullPath);
            LFileDownload fileDownload = null;
            File file = new File(fileFullPath);
            LLog.debug.write("file.isFile()============>" + file.isFile());
            if (file.isFile()) {
                fileDownload.streamTo(file, fileName);
            } else {
                fileDownload.redirectTo(redirectUrl);
            }
        } catch (LException e) {
            throw new LException("dev.err.fileDownload", e);
        }
    }

}
