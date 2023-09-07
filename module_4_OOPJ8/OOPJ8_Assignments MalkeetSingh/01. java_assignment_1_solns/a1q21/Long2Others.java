public class Long2Others {
    public static void main(String[] args) {
        Long L1 = new Long(21);
        System.out.println("Long instance L1    : "+L1);
        String S1 = String.valueOf(L1);
        byte b1 = Byte.valueOf(S1);
        System.out.println("Primitive byte b1   : "+b1);
        long l1 = L1;
        short sh1 = (short)l1;
        System.out.println("Primitive short sh1 : "+sh1);
        int i1 = (int)l1;
        System.out.println("Primitive int i1    : "+i1);
        System.out.println("Primitive long l1   : "+l1);
        float f1 = l1;
        System.out.println("Primitive float f1  : "+f1);
        double d1 = l1;
        System.out.println("Primitive double d1 : "+d1);
        
    }
    
}
