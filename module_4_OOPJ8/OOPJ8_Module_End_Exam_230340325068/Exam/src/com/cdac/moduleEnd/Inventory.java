package com.cdac.moduleEnd;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Iterator;
import java.util.Scanner;

class CompareProduct implements Comparator<Product>{

	@Override
	public int compare(Product o1, Product o2) {
		// TODO Auto-generated method stub
		if (o1.getProductName().equals(o2.getProductName()) && o1.getQuantity()== o2.getQuantity()) {
			return 1;
		}
		return 0;
	}
}

class Product implements Comparable<Product>{
	String ProductName;
	int Quantity;
	
	public Product(String productName, int quantity) {
		super();
		ProductName = productName;
		Quantity = quantity;
	}

	public Product() {
		// default constructor without parameters, just to create uninitialized object
	}

	
	public void setProductName(String productName) {
		ProductName = productName;
	}
	public void setQuantity(int quantity) {
		Quantity = quantity;
	}

	
	public String getProductName() {
		return ProductName;
	}
	public int getQuantity() {
		return Quantity;
	}

	@Override
	public String toString() {
		return "Product [ProductName=" + ProductName + ", Quantity=" + Quantity + "]";
	}

	@Override
	public int compareTo(Product o) {
		// TODO Auto-generated method stub
		int cmp = this.getProductName().compareTo(o.getProductName());
		if (cmp==0) {
			cmp = this.getQuantity() - o.getQuantity();
		}
		return cmp;
	}
	
	
	
}

public class Inventory {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		ArrayList<Product> ProductList = new ArrayList<Product>();
		int choice = 0;
		Scanner sc = new Scanner(System.in);
		Scanner scn = new Scanner(System.in);
		
		
		do {
			System.out.println("\n1. Add Product Details");
			System.out.println("2. Remove Product Details");
			System.out.println("3. Display Complete Inventory in sorted order");
			System.out.println("4. Exit");
			choice = sc.nextInt();
			
			switch (choice) {
			case 1: //add products
				System.out.println("Enter Product Details to add product");
				Product p1 = new Product();
				System.out.println("Enter Product Name: ");
				p1.setProductName(scn.nextLine());
				System.out.println("Enter Quantity: ");
				p1.setQuantity(sc.nextInt());
				
//				ProductList.add(p1);//add single product
				
				CompareProduct cpa = new CompareProduct();
				int afound=0;
				Iterator<Product> ait = ProductList.iterator();
				
				while(ait.hasNext()) {
					if(cpa.compare(p1, ait.next())==1) {
						afound=1;
						System.out.println("DEBUG: Product found in add");
						break;
					}
				}
				if (afound==1) {
					System.out.println("Error Adding Product: Product Already exists");
				}
				else {
					ProductList.add(p1);
				}
				
				break;

			case 2: //remove products
				System.out.println("Enter Product Details to remove product");
				Product p2 = new Product();
				System.out.println("Enter Product Name: ");
				p2.setProductName(scn.nextLine());
				System.out.println("Enter Quantity: ");
				p2.setQuantity(sc.nextInt());
				
				CompareProduct cpr = new CompareProduct();
				Iterator<Product> rit = ProductList.iterator();
				int rfound=0;
//				ProductList.remove(p2); //to remove single object
				
				while(rit.hasNext()) {
					if(cpr.compare(p2, rit.next())==1) {
						rfound=1;
						System.out.println("DEBUG: Product found in remove");
						break;
					}
				}
				if(rfound==1) {
					rit.remove();
					System.out.println("Product removed successfully");
				}
				else {
					System.out.println("Error Removing Product: Product not found");
				}
				
				break;

			case 3: //display products
				
//				for printing elements without sorting
//				System.out.println("All of inventory in sorted order");
//				for(Product oneProduct: ProductList) {
//					System.out.println(oneProduct.toString());
//				}
				
				Collections.sort(ProductList);
				for(Product oneProduct: ProductList) {
					System.out.println(oneProduct.toString());
				}
				
				break;

			case 4:
				System.out.println("Exiting App...");
				break;

			default:
				System.out.println("Invalid choice option");
				break;
			}
			
		}while(choice !=4 );
		
		sc.close();
		scn.close();
	}

}
