public class createNumFrmtExcptn {
    public static void main(String[] args) {
        String S1 = "A";
        // Integer I1 = S1.codePointAt(0);     //  use codePointAt() to avoid NumberFormatException and print ASCII value
        Integer I1 = Integer.valueOf(S1);       //  also throws NumberFormatException
        // Integer I1 = Integer.parseInt(S1);      //  also throws NumberFormatException
        System.out.println(I1);
    }
}
