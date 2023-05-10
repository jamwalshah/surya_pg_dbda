import java.util.Scanner;

public class SumAvgOfFiveNums {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        
        System.out.println("Input the 5 numbers :");
        // System.out.println("Enter Number 1: ");
        Integer num1 = sc.nextInt();
        // System.out.println("Enter Number 2: ");
        Integer num2 = sc.nextInt();
        // System.out.println("Enter Number 3: ");
        Integer num3 = sc.nextInt();
        // System.out.println("Enter Number 4: ");
        Integer num4 = sc.nextInt();
        // System.out.println("Enter Number 5: ");
        Integer num5 = sc.nextInt();
        sc.close();

        // Integer Sum = num1 + num2 + num3 + num4 + num5;
        Integer Sum = Integer.sum(num1, Integer.sum(num2, Integer.sum(num3, Integer.sum(num4, num5))));
        System.out.println("The sum of 5 no is : "+Sum);

        Float Avg = (float)Sum/5;
        System.out.println("The Average is : "+Avg);
    }
}
