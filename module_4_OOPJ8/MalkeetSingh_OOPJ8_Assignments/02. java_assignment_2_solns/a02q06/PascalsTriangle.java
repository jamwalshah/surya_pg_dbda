import java.util.Scanner;
public class PascalsTriangle{
    public static void main(String[] args) {
        System.out.println("Input number of rows: ");
        Scanner sc =  new Scanner(System.in);
        Integer rows = sc.nextInt();
        sc.close();

        Integer p[][] = new Integer[rows][rows];
        for(int line = 0; line<rows; line++){
            for (int lsp=0;lsp<rows+1-line;lsp++){
                System.out.print(" ");
            }
            for(int sym=0;sym<=line;sym++){
                if(sym==0 || sym==line){
                    p[line][sym]=1;
                }
                else{
                    p[line][sym] = p[line-1][sym-1] + p[line-1][sym];
                }
                System.out.print(p[line][sym]+" ");
            }
            for(int rsp=0;rsp<rows+1-line;rsp++){
                System.out.print(" ");
            }
            System.out.println();
        }
    }
}