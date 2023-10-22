import java.io.*;
public class JavaBufferReader {
	public static void main(String[] args) throws IOException {
		try {
			FileReader fr = new FileReader("./src/sample.txt");
			BufferedReader br = new BufferedReader(fr);
			String line = br.readLine();
			while (line != null)
			{
				System.out.println(line);
				line = br.readLine();
			}
			br.close();
			fr.close();
		}
		catch(FileNotFoundException f)
		{
			System.out.println("File is not avialable");
		}
	}
}
