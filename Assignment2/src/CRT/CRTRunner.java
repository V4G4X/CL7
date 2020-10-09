package CRT;

import java.util.Scanner;

public class CRTRunner {
    private static final Scanner sc = new Scanner(System.in);

    public static void inputArray(int[] a, int[] m){
        int n = a.length;
        System.out.print("Enter \"a\" array: ");
        for(int i = 0 ; i<n ; ++i)
            if(sc.hasNextInt())
                a[i] = sc.nextInt();
        System.out.print("Enter \"m\" array: ");
        for(int i = 0 ; i<n ; ++i)
            m[i] = sc.nextInt();
    }

    public static void inputLines(int[] a, int[] m){
        int n = a.length;
        for (int i = 0; i < n; i++) {
            System.out.print("Enter a and m of Line "+(i+1)+": ");
            a[i] = sc.nextInt();
            m[i] = sc.nextInt();
        }
    }

    public static void main(String[] args) {

        System.out.print("Enter no. of Congruences: ");
        int n = sc.nextInt();
        int[] a = new int[n];
        int[] m = new int[n];

        System.out.print("1.Enter via Array\n2.Enter line-by-line\nEnter 1/2 (Incorrect choice picks 1): ");
        if(1 == sc.nextInt())
            inputArray(a,m);
        else inputLines(a,m);

        //Example One
//        int[] a = {1, 1, 3};
//        int[] m = {5, 7, 11};

        //Example Two
//        int[] a = {1, 6, 8};
//        int[] m = {5, 7, 11};

        System.out.println("The Answer X: " + CRT.getX(a,m));
    }
}
