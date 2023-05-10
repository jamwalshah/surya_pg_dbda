#!/home/user1/g++
     1                                                                          
    1 1                                                                         
   1 2 1                                                                        
  1 3 3 1                                                                       
 1 4 6 4 1

 void printPascal(int n)
{
     
    // An auxiliary array to store
    // generated pascal triangle values
    int arr[n][n];
 
    // Iterate through every line and
    // print integer(s) in it
    for (int line = 0; line < n; line++)
    {
        // Every line has number of integers
        // equal to line number
        for (int i = 0; i <= line; i++)
        {
        // First and last values in every row are 1
        if (line == i || i == 0)
            arr[line][i] = 1;
        // Other values are sum of values just
        // above and left of above
        else
            arr[line][i] = arr[line - 1][i - 1] + arr[line - 1][i];
        cout << arr[line][i] << " ";

        }
        cout << "\n";
    }
}