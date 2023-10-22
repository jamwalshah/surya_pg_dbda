package com.cdac.moduleEnd;

class Person{
	String Name;
	int Age;
	
	public Person(String name, int age) {
		super();
		this.Name = name;
		this.Age = age;
	}

	@Override
	public String toString() {
		return "Person [Name=" + Name + ", Age=" + Age + "]";
	}
}

class Student extends Person{
	Character Grade;

	public Student(String name, int age, Character grade) {
		super(name, age); //chaining to parent class constructor
		this.Grade = grade;
	}
	
	public Student(String name, int age) {
		super(name, age); //chaining to parent class constructor
	}

	@Override
	public String toString() {
		return "Student [Name=" + Name + ", Age=" + Age + ", Grade=" + Grade + "]";
	}
}

public class PersonTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Student s1 = new Student("Saman", 13);
		System.out.println(s1.toString());
		
		Student s2 = new Student("Danish", 15, 'A');
		System.out.println(s2.toString());
		
		Person p1 = new Student("Hitesh", 14);
		System.out.println(p1.toString());
		
		Person p2 = new Student("Rajan", 12, 'A');
		System.out.println(p2.toString());
	}
}
