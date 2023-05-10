import java.util.Scanner;

public class checkPosNegZero {
    public static void main(String[] args) {
        int CheckNum;
        Scanner sc = new Scanner(System.in);
        System.out.println("Input a number: ");
        CheckNum = sc.nextInt();
        if(CheckNum>0){
            System.out.println("Number is Positive");
        } else if(CheckNum<0){
            System.out.println("Number is Negative");
        } else{
            System.out.println("Number is Zero");
        }
        sc.close();
    }
}
