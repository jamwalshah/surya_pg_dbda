class Vehicles{
	String model;
	Vehicles(String model){
		this.model=model;
	}
	
	public void display() {
		System.out.println("vehicle model is "+ model);
	}
	
}

public class Bike extends Vehicles{
	public int mileage=0;

	
	public void display() {
		System.out.println("car model is "+ model +" "+mileage);
	}
} 
public class Single {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Bike c= new Bike();
		c.display();
		System.out.println();
	}

}
