import java.util.Scanner;

public class FindGreatest{
    public static void main(String[] args){
        Scanner sc = new Scanner(System.in);
        
        System.out.println("Enter 1st number: ");
        Integer num1 = sc.nextInt();
        
        System.out.println("Enter 2nd number: ");
        Integer num2 = sc.nextInt();
        
        System.out.println("Enter 3rd number: ");
        Integer num3 = sc.nextInt();
        sc.close();

        if (num1==num2 && num2==num3){
            System.out.println("All three are equal");
        }
        else if(num1==num2 || num2==num3 || num3==num1){
            System.out.println("Any two numbers are equal");
        }
        else if (num1>num2 && num1>num3){
            System.out.println("The greatest: "+num1);
        }
        else if (num2>num1 && num2>num3){
            System.out.println("The greatest: "+num2);
        }
        else {
            System.out.println("The greatest: "+num3);
        }
    }
}