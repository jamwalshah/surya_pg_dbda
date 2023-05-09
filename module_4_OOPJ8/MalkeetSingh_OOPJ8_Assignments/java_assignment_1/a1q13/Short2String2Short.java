public class Short2String2Short {
    public static void main(String[] args) {
        short sh1 = 15;
        System.out.println("Primitive Short: "+sh1);
        Short Sho1 = new Short(sh1);
        System.out.println("Wrapper Short instance: "+Sho1);
        String st1 = Sho1.toString();
        // String st1 = new String(Sho1);
        System.out.println("String instance: "+st1);
        Short Sho2 = new Short(st1);
        System.out.println("String to Short instance: "+Sho2);
    }    
}
