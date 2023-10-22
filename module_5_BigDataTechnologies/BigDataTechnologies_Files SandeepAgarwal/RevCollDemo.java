package com.cdac.revcoll;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.Iterator;
import java.util.ListIterator;
import java.util.Scanner;

class Student
{
	int RollNo;
	int Fees;
	int age;
	String Name;
	public Student()
	{
		super();
	}
	public Student(int rollNo, int fees, int age, String name) {
		super();
		RollNo = rollNo;
		Fees = fees;
		this.age = age;
		Name = name;
	}
	
	void Getdata()
	{
		Scanner sc =new Scanner(System.in);
		System.out.println("Enter RollNo, Fees, Age and Name of the Student");
		RollNo=sc.nextInt();
		Fees=sc.nextInt();
		age=sc.nextInt();
		sc.nextLine();
		Name=sc.nextLine();
		
	}
	@Override
	public String toString() {
		return "Student [RollNo=" + RollNo + ", Fees=" + Fees + ", age=" + age + ", Name=" + Name + "]";
	}
}

class StudentSortedAgeWise implements Comparator<Student>
{

	@Override
	public int compare(Student o1, Student o2) {
		
		if(o1.age>o2.age)
		{
			return 1;
		}
		if(o1.age<o2.age)
		{
			return -1;
		}
		
		return 0;
	}
	
}

public class RevCollDemo {

	public static void main(String[] args) {
		
		ArrayList<Student> list=new ArrayList<Student>();
		Scanner sc=new Scanner(System.in);
		int choice=0;
		do
		{
			System.out.println("Press 1 to Enter a Student Record");
			System.out.println("Press 2 to Display the all Record");
			System.out.println("Press 3 to Display Sorted records Age Wise");
			System.out.println("Press 4 to Update Student Record");
			System.out.println("Press 5 Exit");
			choice=sc.nextInt();
			
			switch(choice)
			{
			case 1:
			Add: {
				Student s1=new Student();
				s1.Getdata();
				
				for(Student s: list)
				{
					if(s.RollNo==s1.RollNo)
					{
						System.out.println("Student RollNo already exist");
						break Add;
					}
				}
				
				list.add(s1);
				break;
			}
			case 2:
			{
				Iterator<Student> it=list.iterator();
				
				while(it.hasNext())
				{
					System.out.println(it.next().toString());
				}
				
				break;
			}
			case 3:
			{
				StudentSortedAgeWise sortage=new StudentSortedAgeWise();
				list.sort(sortage);
				Iterator<Student> it=list.iterator();
				while(it.hasNext())
				{
					System.out.println(it.next().toString());
				}
				
				break;
			}
			case 4:
			{
				Iterator<Student> it=list.iterator();
				while(it.hasNext())
				{
					System.out.println(it.next().toString());
				}
				System.out.println("Enter the RollNo of Student to Update");
				int Rno=sc.nextInt();
				
				for(Student s: list)
				{
					if(s.RollNo==Rno)
					{
						Student sa=s;
						System.out.println("Enter Fees, Age, Name to update");
						int f=sc.nextInt();
						int a=sc.nextInt();
						sc.nextLine();
						String n=sc.nextLine();
						sa.Fees=f;
						sa.age=a;
						sa.Name=n;
						break;
					}
				}
				
				/*
				while(it.hasNext())
				{
					if(Rno==it.next().RollNo)
					{
						Student s=it.next();
						System.out.println("Enter Fees, Age, Name to update");
						
						int f=sc.nextInt();
						int a=sc.nextInt();
						sc.nextLine();
						String n=sc.nextLine();
						it.next().Fees=f;
						it.next().age=a;
						it.next().Name=n;
						System.out.println("Upodate record List");
						while(it.hasNext())
						{
							System.out.println(it.next().toString());
						}
					}
				}*/
				
				break;
			}
			case 5:
			{
				System.out.println("Exiting.................");
				break;
			}
			default:
			{
				System.out.println("Wrong Input");
				break;
			}
			}
			
		}while(choice<4);
		
	}

}
