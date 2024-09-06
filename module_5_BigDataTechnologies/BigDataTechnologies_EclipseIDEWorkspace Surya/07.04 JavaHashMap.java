import java.util.HashMap;
import java.util.TreeMap;

public class JavaHashMap {
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		System.out.println("Hashap Employees");
		HashMap<Integer, String> Employees = new HashMap<>();
		
		Employees.put(20, "John");
		Employees.put(35, "Mary");
		Employees.put(20, "Alan"); // replaces John with value Alan at key 20
		
		System.out.println(Employees.size());
		System.out.println(Employees);
		System.out.println(Employees.get(20));
		
		
		System.out.println("\nTreeMap Emp");
		TreeMap<Integer, String> Emp = new TreeMap<>();
		
		Emp.put(20, "John");
		Emp.put(35, "Mary");
		Emp.put(20, "Alan"); // replaces John with value Alan at key 20
		
		System.out.println(Emp.size());
		System.out.println(Emp);
		System.out.println(Emp.get(20));
	}
}
