public class Double2Others {
    public static void main(String[] args) {
        Double D1 = new Double(1256.5516813);
        System.out.println("Double instance D1                              : "+D1);
        double d1 = D1;
        byte b1 = (byte)d1;
        System.out.println("Double instance D1 to primitive byte b1         : "+b1);
        short sh1 = (short)d1;
        System.out.println("Double intance D1 to primitive short sh1        : "+sh1);
        int i1 = (int)d1;
        System.out.println("Double instance D1 to int i1                    : "+i1);
        long l1 = (long)d1;
        System.out.println("Double instance D1 to long l1                   : "+l1);
        float f1 = (float)d1;
        System.out.println("Double instacne D1 to float f1                  : "+f1);
        System.out.println("Double instance to D1 to primitive double d1    : "+d1);
    }
}
