public class Boolean2String2Boolean {
    public static void main(String[] args){
        boolean b1 = true;
        System.out.println("Primitive boolean b1                : "+b1);
        String S1 = String.valueOf(b1);
        System.out.println("Primitive boolean b1 to String S1   : "+S1);
        // Boolean B1 = b1;                // auto-boxing
        Boolean B1 = new Boolean(b1);   // boxing, but manual boxing
        System.out.println("Wrapper Boolean B1                  : "+B1);
        boolean b2 = Boolean.valueOf(S1);
        System.out.println("String S1 to boolean b2             : "+b2);
        Boolean B2 = Boolean.valueOf(S1);
        System.out.println("String S1 to Wrapper Boolean B2     : "+B2);
    }
}
