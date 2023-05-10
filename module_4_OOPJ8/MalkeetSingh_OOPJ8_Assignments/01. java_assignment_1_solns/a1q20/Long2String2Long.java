public class Long2String2Long {
    public static void main(String[] args) {
        long l1 = 112;
        System.out.println("Primitive long l1  : "+l1);
        String S1 = String.valueOf(l1);
        System.out.println("String instance S1 : "+S1);
        // Long L1 = l1;
        Long L1 = Long.parseLong(S1);
        System.out.println("Wrapper Long L1    : "+L1);
        long l2 = L1;
        System.out.println("Primitive long l2  : "+l2);
        System.out.println("Binary             : "+Long.toBinaryString(L1));
        System.out.println("Octal              : "+Long.toOctalString(l2));
        System.out.println("Hexadecimal        : "+Long.toHexString(l2));

    }
    
}
