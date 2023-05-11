public class BookInventory {
	String Title;
    String Author;
    String Publisher;
    String Isbn;
    int Year;
    Double Price;
    int Quantity;

	public BookInventory(){
        this.Title="Fantastic Beasts and Where to Find Them";
        this.Author="J. K. Rowling";
        this.Publisher="Bloomsbury, 2009";
        this.Isbn="1408803011, 9781408803011";
        this.Year=2017;
        this.Price=774.00;
        this.Quantity=1;
    }
	
	void Display() {
		System.out.println( "BookInventory [\nTitle=" + Title + ", \nAuthor=" + Author 
				+ ", \nPublisher=" + Publisher + ", \nIsbn=" + Isbn + ", \nYear=" + Year 
				+ ", \nPrice=" + Price + ", \nQuantity=" + Quantity + "\n]");
	}

    public static void main(String[] args) {
        BookInventory bi1 = new BookInventory();
		bi1.Display();
    }
}