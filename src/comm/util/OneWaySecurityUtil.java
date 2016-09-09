package comm.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LException;
import devonframework.persistent.autodao.LCommonDao;

public class OneWaySecurityUtil {

    /**
     * 일방향 암호화 공통 함수 
     * @author hskim 2011-10-06
     * @param inputData
     * @return
     * @throws LException
     */
    public String encryptPassword(String value ) throws LException{
    	
    	String encryptData = "";  

        try{        	
        	
        	MessageDigest sha = MessageDigest.getInstance("SHA-256");  
        	sha.update(value.getBytes());  


        	byte[] digest = sha.digest();  

        	for (int i=0; i<digest.length; i++) {  

        	    encryptData += Integer.toHexString(digest[i] & 0xFF);
        	}
        	

        }catch(NoSuchAlgorithmException e){
        } catch (Exception e) {
			// TODO Auto-generated catch block
			e.getMessage();
		}
        
        return encryptData;
        
    }
    
    /**
     * 암호화 데이터 저장 
     * @author hskim 2011-10-06
     * @param inputData
     * @return
     * @throws LException
     */
    public void createEncrptedPwd() throws LException{
    	
    	LData inputData = new LData();
    	LMultiData userList = new LMultiData();

        try{        	
        	
            LCommonDao dao = new LCommonDao("/ma/maz10Sql/retrieveAllUser", inputData); 
            userList = dao.executeQuery();
            
            String pwd = "";
            String encrpyted = "";
            LData rowData = new LData();
            
            for (int i = 0; i < userList.getDataCount(); i++) {
            	rowData = userList.getLData(i);
            	
            	pwd = rowData.getString("password");
            	
            	encrpyted = encryptPassword(pwd);
            	
            	rowData.setString("encrypyed", encrpyted);
            	
            	LCommonDao encDao = new LCommonDao("/ma/maz10Sql/createEncryptedUser", rowData); 
            	encDao.executeUpdate();
            }

        }catch(LException e){
			// TODO Auto-generated catch block
			e.getMessage();
		}
    }
	
	
}
