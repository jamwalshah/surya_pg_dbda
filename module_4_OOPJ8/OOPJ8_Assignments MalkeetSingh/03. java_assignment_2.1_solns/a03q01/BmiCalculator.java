public class BmiCalculator {
	double Height;
    double Weight;
    
    void calculateBMI(){
        double Bmi = Weight/(Height * Height);
        System.out.println("BMI: "+Bmi);
    }
    
	public void setData(double height, double weight) {
		Height = height;
		Weight = weight;
	}

	
	void ShowData() {
		System.out.println("Height=" + Height + ", Weight=" + Weight);
	}

	public static void main(String[] args) {
		BmiCalculator b1 = new BmiCalculator();
		b1.setData(160, 62);
		b1.ShowData();
		b1.calculateBMI();
	}
}
