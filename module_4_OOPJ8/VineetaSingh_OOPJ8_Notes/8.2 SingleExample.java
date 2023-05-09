
package Single;
class Person{
	String name;
	Person(String name){
		this.name=name;
	}
		
	
public void displays() {
	System.out.println("Person name is "+ name);
}

}

class Student extends Person{
	

	String course;
	
	public Student(String name,String course) {
		// TODO Auto-generated constructor stub
		super(name);
		this.course=course;
	}
	public void show() {
		System.out.println("Student name "+ name+" "+course);
	}
}


public class SingleExample {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Student s =new Student("Dhiraj","123an");
		s.show();
		s.displays();
		
		Person p =new Person("Nilofar");
		p.show()
;	}

}
