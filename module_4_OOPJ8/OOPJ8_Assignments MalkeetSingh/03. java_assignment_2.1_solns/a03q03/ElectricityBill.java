public class ElectricityBill {
	private String customerName;
    private double unitsConsumed;
    private double billAmount;

	public void setData(String customerName, double unitsConsumed) {
		this.customerName = customerName;
		this.unitsConsumed = unitsConsumed;
	}

	protected void calculateBillAmount() {
		if(this.unitsConsumed<=100){
            this.billAmount = 5*this.unitsConsumed;
        } else if(100<this.unitsConsumed && this.unitsConsumed<=200){
            this.billAmount = (5*100)+(7*(this.unitsConsumed-100));
        }else{
            this.billAmount = (5*100)+(7*200)+(10*(this.unitsConsumed-200));
        }
	}
	
	public void PrintData() {
		System.out.println("Customer Name: "+this.customerName);
        System.out.println("Units Consumed: "+this.unitsConsumed);
        System.out.println("Bill Amount: "+this.billAmount);
	}

    public static void main(String[] args) {
        ElectricityBill e1 = new ElectricityBill();
		e1.setData("Karan Aujla", 455.35);
		e1.calculateBillAmount();
		e1.PrintData();
    }
}