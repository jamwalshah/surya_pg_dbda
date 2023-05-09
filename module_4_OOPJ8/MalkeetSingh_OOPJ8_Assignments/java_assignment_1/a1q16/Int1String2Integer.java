public class Int1String2Integer {
    public static void main(String[] args) {
        int i1 = 10;
        System.out.println("Primitive int i1   : "+i1);
        Integer I1 = new Integer(i1);
        System.out.println("Wrapper Integer I1 : "+I1);
        String S1 = String.valueOf(i1);
        System.out.println("String instance S1 : "+S1);
        System.out.println("Binary             : "+Integer.toBinaryString(i1));
        System.out.println("Octal              : "+Integer.toOctalString(i1));
        System.out.println("Hexadecimal        : "+Integer.toHexString(i1));

    }
    
}
