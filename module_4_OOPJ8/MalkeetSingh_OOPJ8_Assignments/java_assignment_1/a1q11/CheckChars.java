import java.util.Scanner;
public class CheckChars {
    public static void main(String[] args) {
        Scanner sc  = new Scanner(System.in);
        System.out.println("Enter one char: ");
        String s1 = sc.nextLine();
        sc.close();
        char ch1 = s1.charAt(0);
        if (Character.isLetter(ch1)){
            System.out.println(ch1+" is Letter");
            if (Character.isUpperCase(ch1)){
                System.out.println("Entered Letter is "+ch1+" and its codepoint is "+Character.codePointAt(s1, 0));
                System.out.println("Lowered Letter is "+Character.toLowerCase(ch1)+" and its codepoint is "+(Character.codePointAt(s1, 0)+32));
            }else{
                System.out.println("Entered Letter is "+ch1+" and its codepoint is "+Character.codePointAt(s1, 0));
                System.out.println("Uppered Letter is "+Character.toUpperCase(ch1)+" and its codepoint is "+(Character.codePointAt(s1, 0)-32));
            }
        }
        if (Character.isDigit(ch1)){
            System.out.println(ch1+" is Digit");
            System.out.println("Entered Digit Value: "+ch1+" codepoint: "+Character.codePointAt(s1, 0));
        }
    }   
}
