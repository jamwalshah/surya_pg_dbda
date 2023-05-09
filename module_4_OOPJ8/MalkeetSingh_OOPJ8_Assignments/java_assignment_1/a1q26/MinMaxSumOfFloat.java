public class MinMaxSumOfFloat {
    public static void main(String[] args) {
        Float F1 = 10.45f;
        Float F2 = 30.55f;
        System.out.println("Float instance F1   : "+F1);
        System.out.println("Float instance F2   : "+F2);
        System.out.println("Minimum             : "+Float.min(F1, F2));
        System.out.println("Maximum             : "+Float.max(F1, F2));
        System.out.println("Sum                 : "+Float.sum(F1, F2));
    }
    
}
