package comm.util; 

import java.security.SecureRandom;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

import devon.core.log.LLog;

/**
* This program generates a AES key, retrieves its raw bytes, and
* then reinstantiates a AES key from the key bytes.
* The reinstantiated key is used to initialize a AES cipher for
* encryption and decryption.
*/

public class AES {

	private final static String mode = "AES";
	private static byte[] key = "randomize key".getBytes(); // <-- 占쏙옙 占싸븝옙; 占쏙옙占쏙옙占쏙옙 占십울옙占쏙옙=.
	
	public static void main(String args[]) 
	{
		try {
			String message = (args.length==0 ? "Example" : args[0]);
			String encrypt = "";
			String decrypt = "";
	
			encrypt = encryptAES(message);
	
			decrypt = decryptAES(encrypt);
	
			LLog.info.println("占쏙옙호화 :: " + encrypt);
			LLog.info.println("占쏙옙호화 :: " + decrypt);
			
		} catch (Exception e) {
			e.getMessage();
		}
	}
	
	public static String encryptAES(String msg) throws Exception {
		return encryptAES(msg, key);
	}
	
	public static String encryptAES(String msg, byte[] key) throws Exception {
		String result = "";

		// Get the KeyGenerator
		SecureRandom ran = new SecureRandom(key);

		KeyGenerator kgen = KeyGenerator.getInstance(mode);
		kgen.init(128, ran); // 192 and 256 bits may not be available


		// Generate the secret key specs.
		SecretKey skey = kgen.generateKey();
		byte[] raw = skey.getEncoded();

		SecretKeySpec skeySpec = new SecretKeySpec(raw, mode);


		// Instantiate the cipher

		Cipher cipher = Cipher.getInstance(mode);

		cipher.init(Cipher.ENCRYPT_MODE, skeySpec);

		byte[] encrypted = cipher.doFinal(msg.getBytes());

		result = asHex(encrypted);

		return result;

	}


	public static String decryptAES(String msg) throws Exception {
		return decryptAES(msg, key);
	}

	public static String decryptAES(String msg, byte[] key) throws Exception {
		String result = "";

		// Get the KeyGenerator
		SecureRandom ran = new SecureRandom(key);

		KeyGenerator kgen = KeyGenerator.getInstance(mode);
		kgen.init(128, ran); // 192 and 256 bits may not be available


		// Generate the secret key specs.
		SecretKey skey = kgen.generateKey();
		byte[] raw = skey.getEncoded();

		SecretKeySpec skeySpec = new SecretKeySpec(raw, mode);


		// Instantiate the cipher

		Cipher cipher = Cipher.getInstance(mode);

		cipher.init(Cipher.ENCRYPT_MODE, skeySpec);

		cipher.init(Cipher.DECRYPT_MODE, skeySpec);

		byte[] encrypt = asHex(msg);
		byte[] original = null;
		original = cipher.doFinal(encrypt);

		result = new String(original);

		return result;

	}


	/**
	* Turns array of bytes into string
	*
	* @param buf	Array of bytes to convert to hex string
	* @return		Generated hex string
	*/
	private static String asHex (byte buf[]) {
		StringBuffer strbuf = new StringBuffer(buf.length * 2);
		int i;

		for (i = 0; i < buf.length; i++) {
			if (((int) buf[i] & 0xff) < 0x10)
				strbuf.append("0");
			strbuf.append(Long.toString((int) buf[i] & 0xff, 16));
		}
		return strbuf.toString();
	}

	private static byte[] asHex (String msg) {
		byte buf[] = null;
		String str = "";
		int iTemp = 0;
		StringBuffer strbuf = new StringBuffer(msg);
		buf = new byte[strbuf.length()/2];
		for (int i=0; i<buf.length; i++) {
			iTemp = i*2;
			str = strbuf.substring(iTemp, iTemp+2);
			buf[i] = (byte) Integer.parseInt(str, 16);
		}
		return buf;
	}

	
}


