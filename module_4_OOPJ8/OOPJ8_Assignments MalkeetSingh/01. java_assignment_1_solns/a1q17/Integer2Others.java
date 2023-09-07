public class Integer2Others {
    public static void main(String[] args) {
        Integer I1 = new Integer(111);
        System.out.println("Wrapper Integer I1  : "+I1);
        String S1 = String.valueOf(I1);
        Byte B1 = Byte.valueOf(S1);
        byte b1 = B1;
        System.out.println("Primitive byte b1   : "+b1);
        int i1 = I1;
        short sh1 = (short)i1;
        System.out.println("Primitive short sh1 : "+sh1);
        System.out.println("primitive int i1    : "+i1);
        long l1 = i1;
        System.out.println("primitive long l1   : "+l1);
        float f1 = i1;
        System.out.println("Primitive float f1  : "+f1);
        double d1 = i1;
        System.out.println("Primitive double d1 : "+d1);
    }
    
}
