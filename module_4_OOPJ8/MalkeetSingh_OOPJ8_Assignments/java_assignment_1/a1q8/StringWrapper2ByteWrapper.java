public class StringWrapper2ByteWrapper {
    public static void main(String[] args) {
        String s1 = new String();
        s1 = "four";
        System.out.println("String Wrapper s1: "+s1);
        byte b1[]= new byte[s1.length()];
        b1 = s1.getBytes();
        for(int i=0; i<b1.length; i++){
            System.out.println("b1["+i+"] : "+b1[i]);
        }
        System.out.println("Primitive byte array b1: "+b1+" len of byte array: "+b1.length);
        
    }
    
}
