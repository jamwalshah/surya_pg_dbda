import java.util.Scanner;

public class ArithmeticCalc {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.println("Enter Number 1: ");
        Double D1 = sc.nextDouble();
        System.out.println("Enter Number 2: ");
        Double D2 = sc.nextDouble();
        System.out.println("Enter Number 1: "+D1);
        System.out.println("Enter Number 2: "+D2);
        System.out.println("1. Add\n2. Subtract\n3. Multiply\n4. Divide");
        System.out.println("Choose the operation: ");
        Integer choice = sc.nextInt();
        Double res;
        switch (choice) {
            case 1:
                res = D1+D2;
                System.out.println("A + B: "+res);
                break;
            case 2:
                res = D1-D2;
                System.out.println("A - B: "+res);
                break;
            case 3:
                res = D1*D2;
                System.out.println("A x B: "+res);
                break;
            case 4:
                res = D1/D2;
                System.out.println("A / B: "+res);
                break;
        
            default:
                System.out.println("Please enter valid cloice option");
                break;
        }
        sc.close();
    }
}
