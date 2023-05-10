class BytePrimitive2ByteWrapper{
    public static void main(String[] args) {
        byte b1 = 15;
        System.out.println("Primitive byte b1: "+b1);
        Byte b2 = new Byte(b1);
        System.out.println("Byte wrapper b2: "+b2);

    }
}