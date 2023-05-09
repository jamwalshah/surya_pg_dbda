class ConvertShortWrapper2Others{
    public static void main(String[] args) {
        // short sh1 = 12;
        Short Sho1 = new Short("12");
        System.out.println("Wrapper Short Sho1:  "+Sho1);
        short sh1 = Sho1;
        int i1 = sh1;
        String s1 = String.valueOf(i1);
        Byte B1 = Byte.valueOf(s1);
        byte b1 = B1;
        System.out.println("Primitive byte b1:   "+b1);
        System.out.println("Primitive short sh1: "+sh1);
        System.out.println("Primitive int i1:    "+i1);
        long l1 = sh1;
        System.out.println("Primitive long l1:   "+l1);
        float f1 = sh1;
        System.out.println("Primitive float f1:  "+f1);
        double d1 = sh1;
        System.out.println("Primitve double d1:  "+d1);

    }
}