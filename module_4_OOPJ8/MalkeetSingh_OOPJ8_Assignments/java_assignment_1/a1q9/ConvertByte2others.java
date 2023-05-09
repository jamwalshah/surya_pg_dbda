public class ConvertByte2others {
    
    public static void main(String[] args) {
        byte b1 = 15;
        System.out.println("Primitive byte  : "+b1);
        // Byte B1 = new Byte(b1);
        // System.out.println("Wrapper Byte    : "+B1);
        // // byte b2 = B1;
        short sht1 = b1;
        System.out.println("Primitive short : "+sht1);
        int i1 = b1;
        System.out.println("Primitive int   : "+i1);
        long l1 = b1;
        System.out.println("Primitive long  : "+l1);
        float f1 = b1;
        System.out.println("Primitive float : "+f1);
        double d1 = b1;
        System.out.println("Primitive double: "+d1);
        
    }
}
