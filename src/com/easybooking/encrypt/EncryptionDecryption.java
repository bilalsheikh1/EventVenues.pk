package com.easybooking.encrypt;

import java.security.*;

import javax.crypto.*;



public class EncryptionDecryption {

	public static Key key = null;
    public static Cipher cipher ;
    
    
    
    public static String encrypt(String input)throws Exception {
    	key = KeyGenerator.getInstance("DESede").generateKey();
    	cipher = Cipher.getInstance("DESede");
        cipher.init(Cipher.ENCRYPT_MODE, key);
        byte[] inputBytes = input.getBytes();
        String encrypted=""+cipher.doFinal(inputBytes);
        return encrypted;
    }
    
    
    
    public static String decrypt(String input)throws Exception {
    	key = KeyGenerator.getInstance("DESede").generateKey();
    	cipher = Cipher.getInstance("DESede");
    	cipher.init(Cipher.DECRYPT_MODE, key); 
    	byte[] recoveredBytes =  cipher.doFinal(input.getBytes());
    	String recovered =  new String(recoveredBytes);
    	return recovered;
  }
}
