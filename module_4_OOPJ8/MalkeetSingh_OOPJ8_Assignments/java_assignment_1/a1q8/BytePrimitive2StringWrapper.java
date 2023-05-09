public class BytePrimitive2StringWrapper {
    public static void main(String[] args) {
        byte b1 = 12;
        System.out.println("Primitive byte b1: "+b1);
        String s1 = new String();
        s1 = String.valueOf(b1);
        System.out.println("Wrapper String s1: "+s1);
    }
    
}
