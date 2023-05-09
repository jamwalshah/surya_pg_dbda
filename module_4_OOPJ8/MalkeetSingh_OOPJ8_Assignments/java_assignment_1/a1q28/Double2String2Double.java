public class Double2String2Double {
    public static void main(String[] args) {
        double d1 = 121.154645;
        System.out.println("primitive double d1                         : "+d1);
        String S1 = String.valueOf(d1);
        System.out.println("Primitive double d1 to String S1            : "+S1);
        Double D1 = new Double(d1);
        System.out.println("Primitive double d1 to Double instance D1   : "+D1);
        Double D2 = Double.parseDouble(S1);
        System.out.println("String S1 to Double instance D2             : "+D2);
        System.out.println("Binary                                      : "+Long.toBinaryString(Double.doubleToLongBits(d1)));
        System.out.println("Octal                                       : "+Long.toOctalString(Double.doubleToLongBits(d1)));
        System.out.println("Hexadeciaml                                 : "+Long.toHexString(Double.doubleToLongBits(d1)));


    }
}
