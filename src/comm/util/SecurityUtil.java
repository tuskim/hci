package comm.util;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.PBEParameterSpec;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;
import devon.core.log.LLog;


/**
 * <pre>
 * 암호화 모듈
 * </pre>
 * 
 * @since 2009. 9. 23.
 * @version 1.0
 * @author 이종수<br>
 */
public class SecurityUtil {

	static int iteration = 9;
	static String key = "lgi";
	static byte[] salt = { (byte) 0x24, (byte) 0x85, (byte) 0x62, (byte) 0x79,
						   (byte) 0xfe, (byte) 0x10, (byte) 0xa6, (byte) 0xb2 };

	
	public SecurityUtil() {
	}

	public static String encrypt(String sourceText) {
		String  result = "";

		byte[] encryptedText = null;

		try {

			//LLog.info.println("sourceText : " + sourceText);

			// 암호화
			PBEKeySpec pks = new PBEKeySpec(key.toCharArray());
			SecretKeyFactory skf = SecretKeyFactory.getInstance("PBEWithMD5AndDES");
			SecretKey sk = skf.generateSecret(pks);
			PBEParameterSpec pps = new PBEParameterSpec(salt, iteration);

			Cipher cipher = Cipher.getInstance("PBEWithMD5AndDES");
			cipher.init(Cipher.ENCRYPT_MODE, sk, pps);

			encryptedText = cipher.doFinal(sourceText.getBytes("euc-kr"));

			result = new BASE64Encoder().encode(encryptedText);
			
			//LLog.info.println("encryptedText : " + result);

		} catch (Exception e) {
			e.getMessage();
		}

		return result;

	}

	public static String decrypt(String encryptedText) {
		String result = "";

		byte[] decryptedText = null;
    	
		try {

			// 복호화
			PBEKeySpec pks = new PBEKeySpec(key.toCharArray());
			SecretKeyFactory skf = SecretKeyFactory.getInstance("PBEWithMD5AndDES");
			SecretKey sk = skf.generateSecret(pks);
			PBEParameterSpec pps = new PBEParameterSpec(salt, iteration);
			Cipher cipher = Cipher.getInstance("PBEWithMD5AndDES");
			
			cipher.init(Cipher.DECRYPT_MODE, sk, pps);
			
			decryptedText = cipher.doFinal(new BASE64Decoder().decodeBuffer(encryptedText));
			
			result = new String(decryptedText, "euc-kr");
			
		} catch (Exception e) {
			e.getMessage();
		}
		
		return result;

	}
	
	public static void main(String[] args) {
		String src = "C1234";
		LLog.info.println("src : " + src);		

		String a = SecurityUtil.encrypt(src);
		LLog.info.println("encrypt : " + a);

		String b = SecurityUtil.decrypt(a);
		LLog.info.println("decrypt : " + b);
	}

}