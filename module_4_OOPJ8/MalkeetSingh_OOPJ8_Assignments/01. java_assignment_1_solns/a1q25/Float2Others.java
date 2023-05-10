public class Float2Others {
    public static void main(String[] args) {
        Float F1 = new Float(12.45f);
        System.out.println("Float instance F1                           : "+F1);
        float f1 = F1;
        byte b1 = (byte)f1;
        System.out.println("Float instance F1 to Primitive byte b1      : "+b1);
        short sh1 = (short)f1;
        System.out.println("Float instance F1 to Primitive short sh1    : "+sh1);
        int i1 = (int)f1;
        System.out.println("Float instance F1 to primitive int i1       : "+i1);
        long l1 = (long)f1;
        System.out.println("Float instance F1 to primtitive long l1     : "+l1);
        // double d1 = f1; // converting float to double causes precision loss, so convert first to String
        String S1 = String.valueOf(f1);
        Double D1 = Double.parseDouble(S1);
        double d1 = D1; // converting to string to Double intance to primitive double to avoid precision loss
        System.out.println("Float instance F1 to primitive double d1    : "+d1);


    }
    
}
