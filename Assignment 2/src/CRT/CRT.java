package CRT;

public class CRT {
    private int[] a;
    private int[] m;
    private int N;
    private int[] Ni;
    private int[] Xi;
    private long[] prod;

    CRT(int[] a, int[] m) {
        //Allocate Array Memories
        this.a = new int[a.length];
        this.m = new int[m.length];
        this.Ni = new int[m.length];
        this.Xi = new int[m.length];
        this.prod = new long[m.length];

        //Initialize basic array values
        int len = a.length;
        for (int i = 0; i < len; ++i) {
            this.a[i] = a[i];
            this.m[i] = m[i];
        }
        //Calculate required Values
        getN();
        getNi();
        getXi();
    }

    private int getN(){
        int temp = 1;
        for(int each : m)
            temp*=each;
        this.N = temp;
        return temp;
    }

    private int[] getNi(){
        getN();
        for (int i = 0 ; i<this.m.length ; ++i)
            this.Ni[i] = this.N / this.m[i];
        return this.Ni;
    }

    private static int modInverse(int a, int r, int m){
        int b;
        for(b = 1 ; (a*b)%m!=r ; ++b);
        return b;
    }

    private int[] getXi(){
        for(int i = 0 ; i<this.m.length ; ++i)
            this.Xi[i] = modInverse(this.Ni[i],1,this.m[i]);
        return Xi;
    }

    public static int getX(int[] a, int[] m){
        //If arrays are not equivalent, return incorrect Value;
        if(a.length != m.length)
            return -1;
        //Create object and feed it values.
        CRT obj = new CRT(a,m);
        long sum = 0;
        //Calcualte the product of m, Ni, and Ni-inverse for each row,
        //And Simultaneously keep track of Sum
        for(int i = 0 ; i<obj.m.length ; ++i){
            obj.prod[i] = (long)obj.a[i] * obj.Ni[i] * obj.Xi[i];
            sum+=obj.prod[i];
        }
        //Required Value X is sum mod N.
        return (int)(sum%obj.N);
    }
}