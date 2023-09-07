import java.util.Scanner;

public class MountainPattern {
    public static void main(String[] args) {
        System.out.println("Input number of rows: ");
        Scanner sc =  new Scanner(System.in);
        Integer rows = sc.nextInt();
        sc.close();

        for(int i=1;i<=rows;i++){
            for(int j=1;j<(rows-i+1);j++){
                System.out.print(" ");
            }
            for(int j=1;j<=i;j++){
                System.out.print("* ");
            }
            for(int j=1;j<(rows-i+1);j++){
                System.out.print(" ");
            }
            System.out.println();
        }
    }
}
