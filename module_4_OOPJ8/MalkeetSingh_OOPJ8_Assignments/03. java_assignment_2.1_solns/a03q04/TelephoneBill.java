public class TelephoneBill {
	String CustomerName;
    String PhoneNumber;
    int NumOfCalls;
    int DurationOfCalls;
    double BillAmount;
    
	public void setData(String customerName, String phoneNumber, int numOfCalls, int durationOfCalls) {
		CustomerName = customerName;
		PhoneNumber = phoneNumber;
		NumOfCalls = numOfCalls;
		DurationOfCalls = durationOfCalls;
	}
		
	@Override
	public String toString() {
		return "TelephoneBill [CustomerName=" + CustomerName + ", PhoneNumber=" + PhoneNumber + ", NumOfCalls="
				+ NumOfCalls + ", DurationOfCalls=" + DurationOfCalls + "]";
	}

	public void CalculateBill() {
		if (NumOfCalls<=100) {
			BillAmount = DurationOfCalls * 0.5;
		}else {
			BillAmount = DurationOfCalls * 0.25;
		}
		
		if(BillAmount<10) {
			BillAmount = 10;
		}
		System.out.println("Bill: "+BillAmount);
	}

    public static void main(String[] args) {
		TelephoneBill t1 = new TelephoneBill();
		t1.setData("Graham Bell", "1202544562", 120, 100);
		System.out.println(t1.toString());
		t1.CalculateBill();
	}
}
