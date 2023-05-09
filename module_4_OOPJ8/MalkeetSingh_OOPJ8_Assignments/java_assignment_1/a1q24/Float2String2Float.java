public class Float2String2Float {
    public static void main(String[] args) {
        float f1 = 10.12f;
        System.out.println("Primitive float f1                      : "+f1);
        String S1 = String.valueOf(f1);
        System.out.println("Primitive float f1 to String S1         : "+S1);
        Float F1 = f1;
        System.out.println("Primitive float f1 to Wrapper Float F1  : "+F1);
        Float F2 = Float.valueOf(S1);
        System.out.println("String S1 to Wrapper Float F1           : "+F2);
        System.out.println("HexaDecimal for primitive float f1      : "+Float.toHexString(f1)); // ?? why it shows incorrect value
        System.out.println("Hexadecmial for primitive float f1      : "+Integer.toHexString(Float.floatToIntBits(f1)));
    }
}
