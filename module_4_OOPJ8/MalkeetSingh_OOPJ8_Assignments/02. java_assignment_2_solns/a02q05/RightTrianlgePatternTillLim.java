public class RightTrianlgePatternTillLim {
    public static void main(String[] args) {
        // System.out.println("");

        int lim=10;
        int counter = 1;
        for(int i=1;counter<=lim;i++){
            for(int j=1;j<=i;j++){
                if (counter<=lim){
                    System.out.print(counter+" ");
                    counter++;
                }
                else{
                    break;
                }
                
            }
            System.out.println();
        }
    }
}
