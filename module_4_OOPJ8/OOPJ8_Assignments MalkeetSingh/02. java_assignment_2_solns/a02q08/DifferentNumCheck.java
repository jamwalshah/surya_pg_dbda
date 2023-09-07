import java.util.Scanner;

public class DifferentNumCheck {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.println("Input first number: ");
        int num1 = sc.nextInt();
        System.out.println("Input second number: ");
        int num2 = sc.nextInt();
        System.out.println("Input third number: ");
        int num3 = sc.nextInt();
        sc.close();

        if (num1==num2 && num2==num3){
            System.out.println("All numbers are equal");
        }
        else if(num1!=num2 && num2!=num3 && num3!=num1){
            System.out.println("All numbers are different");
        } else{
            System.out.println("Neither all are equal nor different");
        }
    }
}
