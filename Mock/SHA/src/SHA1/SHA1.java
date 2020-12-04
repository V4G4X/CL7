package SHA1;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Scanner;

//Write a program in C++ or java to implement
//  SHA1 algorithm using libraries (API)

public class SHA1 {
    public static String hash(String input){
        try{
            // Get SHA1 message digest from library
            MessageDigest md = MessageDigest.getInstance("SHA-1");
            //Convert string to byte array
            byte[] digestedMessage = md.digest(input.getBytes());
            //Convert byte[] to SigNum
            BigInteger bi = new BigInteger(1,digestedMessage);
            //Convert to Hex-Value
            String hash = bi.toString(16);
            //Pad with 0s on left until 32bit
            while(hash.length() < 32) hash = "0".concat(hash);
            return hash;
        }
        catch (NoSuchAlgorithmException e){
            throw new RuntimeException(e);
        }
    }
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter a string to input: ");
        String str = sc.nextLine();
        System.out.println("Hash of "+str+" is: "+hash(str));
    }
}
