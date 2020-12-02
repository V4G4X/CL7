package SHA1;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Scanner;

public class SHA1 {
    public static String hash(String input){
        try {
            //Get Instance of SHA-1 message Digest from Java Library
            MessageDigest md = MessageDigest.getInstance("SHA-1");
            //Convert String into array of bytes
            byte[] digestedMessage = md.digest(input.getBytes());
            //Byte Array to SigNum
            BigInteger bi = new BigInteger(1,digestedMessage);
            //Convert to Hex-Value
            String hash = bi.toString(16);
            //Pad with 0s until 32 bit
            while (hash.length() < 32) hash = "0"+hash;
            return hash;
        }
        catch (NoSuchAlgorithmException e){
            throw new RuntimeException(e);
        }
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter a string: ");
        String str1 = sc.nextLine();
        System.out.println("Hash of "+str1+" is: "+hash(str1));
    }
}