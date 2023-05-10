import java.util.Scanner;

public class CubesTillNum {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.println("Input number of terms : ");
        Integer terms = sc.nextInt();
        sc.close();

        for(int i=1; i<=terms;i++){
            Integer cube = i*i*i;
            System.out.println("Number is : "+i+" and cube of 1 is : "+cube);
        }
    }
}
