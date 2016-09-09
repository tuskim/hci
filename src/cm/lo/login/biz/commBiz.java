/* ------------------------------------------------------------------------
 * @source  : commBiz.java
 * @desc    : 사용자 로그인/로그아웃 등 시스템 공통 비즈니스 로직 구현
 * ------------------------------------------------------------------------
 * PROJ : 투자사 시스템 표준안 개발
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2010.05.12  김현수                 Initial
 * 1.1  2014.04.14    JwHan			      CSR:C20140414_23324
 * 1.2  2014.11.13    hskim			          CSR:C20141111_41481 패스워드 분개 로직 코드 수정
 * ------------------------------------------------------------------------ */

package cm.lo.login.biz;

import java.io.File;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import comm.util.Constants;
import comm.util.OneWaySecurityUtil;

import devon.core.collection.LData;
import devon.core.collection.LMultiData;
import devon.core.exception.LBizException;
import devon.core.exception.LException;
import devon.core.log.LLog;
import devonframework.persistent.autodao.LCommonDao;

public class commBiz {

    public LData retrieveUserInfo(LData userInfo) throws LException{
    	LLog.info.println("commBiz.retrieveUserInfo ==> start");
        LData loginUser = null;
        boolean userOk = true;
        String validation = null;
        
        try{
            LCommonDao userDao = new LCommonDao("/cm/lo/commSql/retrieveLoginUser", userInfo);
            loginUser = userDao.executeQueryForSingle();
           
            
            // ID가 없을 때
            if(loginUser.getString("userId") == null ){
                userOk = false;
                validation = "0001";
            }

            //일방향 암호화 20140526
            OneWaySecurityUtil os = new OneWaySecurityUtil();
            // 패스워드 암호화
            String securityPasswd = os.encryptPassword(userInfo.getString("password"));
            LLog.info.println("사용자가 입력한 뒤 암호화된 암호"+securityPasswd);
            
            // 비밀번호가 틀릴 때
            if(userOk){
                if(!loginUser.getString("userPw").equals(securityPasswd)){
                    userOk = false;
                    //2014.11.13 hskim CSR:C20141111_41481
                    //validation = "0002";
                    validation = "0001";
                    
                    //비밀번호 카운트 증가
                    whenLoginFail(loginUser);
                    
                    
                }
            }             
            
            //계정은 맞지만 블록 되어 있는 경우.
            if( loginUser.getString("userId") != null && loginUser.getInt("loginErrorCount") >5 )  {
            	userOk = false;
            	validation = "0003";
            }
            
            LLog.info.println(loginUser);
            LLog.info.println("Last login date!!!!!!!!!!#######################"+ loginUser.getString("loginBetween"));
            //마지막 로그인 시간  3달 초과
            if(loginUser.getString("userId")!= null && loginUser.getInt("loginBetween")>= 90 ){
            	userOk = false;
            	validation = "0004";
            }
            
            
            // 로그인 성공
            if(userOk){
                validation = "9999";
            }
            loginUser.setString("validation", validation);

        }catch(LException e){
        	e.printStackTrace();
        }
        //login 성공시 시간 업데이트
        LLog.info.println("commBiz  =============  \n\n"+loginUser);
        
        return loginUser;
    }
    
    /**
     * 패스워드 변경 기간을 확인하는 메소드
     * */
    public LData retrievePasswordBetween (LData userInfo) throws LException{
    	LLog.info.println("commBiz.retrievePasswordBetween   userInfo Data \n"+userInfo);
    	LData passwordBetween = null;
    	LCommonDao dao = new LCommonDao("/cm/lo/commSql/retrievePasswordBetween",userInfo);
    	passwordBetween = dao.executeQueryForSingle();
    	return passwordBetween;
    }
    
    
    /**
     * 가우스 레포트에서 호출하는 공통 로직 from comm10ReportGauCmd 
     * @author ymkang 2009-06-27
     * @param inputData
     * @return
     * @throws LException
     */
    public LMultiData retrieveMenuInfo(LData inputData) throws LException{

    	LMultiData resultData = null;

        try{        	 
            LCommonDao dao = new LCommonDao("/cm/lo/commSql/retrieveMenuInfo", inputData); 
            resultData = dao.executeQuery();

        }catch(LException e){
        }

        return resultData;
    }    
    
    public LData retrieveUserId(LData inputData) throws LException{

        LData resultData = null;

        try{        	
            LCommonDao userDao = new LCommonDao("/cm/lo/commSql/retrieveUserId", inputData);
            resultData = userDao.executeQueryForSingle();

        }catch(LException e){
        }

        return resultData;
    }
    
    
    /*   
     * 새롭게 추가 시킨 부분입니다. 
     * 
     */
    public LData retrieveUserPw(LData inputData) throws LException{

        LData resultData = null;

        try{        	
            LCommonDao userDao = new LCommonDao("/cm/lo/commSql/retrieveUserPw", inputData);
            resultData = userDao.executeQueryForSingle();

        }catch(LException e){
        }

        return resultData;
    }
    
    
    public int retrieveUserPwReset(LData inputData) throws LException{

    	int updateCnt = 0;
    	LData resultData = null;
    	
        try{
        	int randomPw = (int)(Math.random()*1000);
        	
        	inputData.setString("randomPw", String.valueOf(randomPw));
        	
        	LCommonDao userDao = new LCommonDao("/cm/lo/commSql/retrieveUserRandomPw", inputData);
        	resultData = userDao.executeQueryForSingle();
        	
        	inputData.setString("password", resultData.getString("rannum"));
        	
            LCommonDao userDao1 = new LCommonDao("/cm/lo/commSql/retrieveUserPwReset", inputData);
            updateCnt = userDao1.executeUpdate();;

        }catch(LException e){
        }
        return updateCnt;
    }
    
    
	public LMultiData parseXml(LData _loginUser, String scope) {
		LMultiData menuData = new LMultiData();
		LData rowData = new LData(); 
		String s_lang=_loginUser.getString("lang");
		
		try { 
			//각 서버별 경로 가져오기
			String localPath = Constants.getXmlPath(_loginUser.getString("serverIP"));			
			String xml_lang = localPath + "menu/menu_"+s_lang+".xml";

	        DocumentBuilder docBuilder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
	        File f = new File(xml_lang);
	        Document doc = docBuilder.parse(f); 
	        NodeList rowgroup = doc.getDocumentElement().getElementsByTagName( scope );
	
	        //Common XML parsing
	        for ( int i = 0; i < rowgroup.getLength(); i++ ) {

				Node _row = rowgroup.item( i );

				if ( _row.getNodeType() == Node.ELEMENT_NODE ) {

					NodeList _child = _row.getChildNodes();

					for ( int j = 0; j < _child.getLength(); j++ ) {
						Node _row2 = _child.item( j ); 
						
						if(_row2.getNodeType() == Node.ELEMENT_NODE ){
							rowData.set(_row2.getNodeName(),_row2.getFirstChild().getNodeValue());
						}
					}
					menuData.addLData(rowData);
				}
			}
	        
        } catch (Exception e) {
        	LLog.debug.write(e.getMessage()); 
		} finally {
		}
		
		return menuData;
	}
	
	public LMultiData menuAuthLangCheck(LMultiData _loginMenu, LMultiData _xmlMenu) {

		try { 

			for(int i = 0; i < _xmlMenu.getDataCount(); i++){  
				for(int j = 0; j < _loginMenu.getDataCount(); j++){ 
					if(_xmlMenu.getLData(i).getString("id").equals(_loginMenu.getLData(j).getString("progCd")))
					{
						//메뉴명 xml 값 받아옴
						//_loginMenu.modify("progNm", j,_xmlMenu.getLData(i).getString("name")); 
					}
				}
			}
        } catch (Exception e) {
        	LLog.debug.write(e.getMessage()); 
		} finally {
		} 
		return _loginMenu;
	}	
	
	/**
     * SSO Login
     * @author hskim 2010-08-23
     * @param inputData
     * @return
     * @throws LException
     */
	public LData retrieveSSOUserInfo(LData userInfo) throws LException{

        LData loginUser = null;
        boolean userOk = true;
        String validation = null;

        try{
            LCommonDao userDao = new LCommonDao("/cm/lo/commSql/retrieveLoginSSOUser", userInfo);
            loginUser = userDao.executeQueryForSingle();
            
            // ID가 없을 때
            if(loginUser.getString("userId") == null){
                userOk = false;
                validation = "0001";
            }
            if(userOk){
                validation = "9999";
            }
            loginUser.setString("validation", validation);

        }catch(LException e){
        	throw new LBizException( e.getMessage());
        }

        return loginUser;
    }
    


	////////////////////////////////////////////////////////////////////20140221
	/**
	 * Login 마지막 성공 입력, 시도횟수 초기화
	 * @throws LBizException 
	 */
	public void lastLoginTimeUpdate ( LData loginUser ) throws LBizException{
		
		
		LLog.info.write("biz.lastLogin  =====================   start");
		
		
		try {
			int updateResult = 0;
			LCommonDao dao = new LCommonDao("/cm/ur/userSql/lastLogin", loginUser);
			updateResult = dao.executeUpdate();
			
			
			if(updateResult == 1){
				LLog.info.println("updated successfully!!!  ");
				
			}else{
				LLog.info.println("Not updated!!");
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		 	throw new LBizException( e.getMessage());
		}
		
		LLog.info.write("biz.lastLogin  =====================   end");
		
		
	}

	/**
	 * 로그인 실패시 카운트 증가.
	 * @param loginUser
	 * @throws LBizException 
	 */
	public void whenLoginFail(LData loginUser) throws LBizException {
		
		try {
			
			LCommonDao dao = new LCommonDao("/cm/ur/userSql/loginFailCount" , loginUser);
			
			dao.executeUpdate();
			
			
			int updateResult = 0;
			if(updateResult == 1){
				LLog.info.println("updated successfully!!!  ");
				
			}else{
				LLog.info.println("Not updated!!");
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		 	throw new LBizException( e.getMessage());
		}
		
		
	}
     //////////////////////////////////////////////////////
	
	
}
