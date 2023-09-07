import java.util.ArrayList;
import java.util.Collections;
import java.util.Scanner;

public class FindKSmallest {
    public static void main(String[] args) {
        Integer[] arr = {1, 4, 17, 7, 25, 3, 100};
        ArrayList<Integer> a1 = new ArrayList<Integer>();
        
        for (int i = 0; i<arr.length;i++){
            a1.add(arr[i]);
        }

        System.out.println("Original Array: "+a1);
        System.out.println("Enter value of k: ");
        Scanner sc = new Scanner(System.in);
        int k = sc.nextInt();
        sc.close();

        Collections.sort(a1);
        for(int i =1;i<=k; i++){
            System.out.print(a1.get(a1.size()-i)+" ");
        }
        // System.out.println(a1.get(a1.size()-1)+" "+a1.get(a1.size()-2)+" "+a1.get(a1.size()-3));
    }
}
