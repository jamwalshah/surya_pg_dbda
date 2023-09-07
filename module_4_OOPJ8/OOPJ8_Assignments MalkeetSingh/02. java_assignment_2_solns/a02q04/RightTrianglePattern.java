import java.util.Scanner;

public class RightTrianglePattern{
    public static void main(String[] args) {
        System.out.println("Input number of rows : ");
        Scanner sc = new Scanner(System.in);
        Integer lim = sc.nextInt();
        sc.close();

        for(int i=1; i<=lim;i++){
            for(int j=1;j<=i;j++){
                System.out.print(j);
            }
            System.out.println();
        }
    }
}