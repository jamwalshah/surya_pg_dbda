import java.util.ArrayList;
import java.util.Scanner;

public class Bank {
    private String name;
    private int accountNumber;
    private double balance;

    public Bank(String name, int accountNumber, double balance) {
        this.name = name;
        this.accountNumber = accountNumber;
        this.balance = balance;
    }

    public void showDetails() {
        System.out.println("Bank Name: " + name);
        System.out.println("Account Number: " + accountNumber);
        System.out.println("Balance: $" + balance);
    }

    public void transfer(Bank receiver, double amount) {
        if (this.balance >= amount) {
            this.balance -= amount;
            receiver.balance += amount;
            System.out.println("$" + amount + " transferred from " + this.name + " to " + receiver.name);
        } else {
            System.out.println("Insufficient funds to complete the transfer.");
        }
    }

    public void receive(Bank sender, double amount) {
        if (sender.balance >= amount) {
            sender.balance -= amount;
            this.balance += amount;
            System.out.println("$" + amount + " received from " + sender.name + " to " + this.name);
        } else {
            System.out.println("Insufficient funds to complete the transfer.");
        }
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAccountNumber() {
        return accountNumber;
    }

    public void setAccountNumber(int accountNumber) {
        this.accountNumber = accountNumber;
    }

    public double getBalance() {
        return balance;
    }

    public void setBalance(double balance) {
        this.balance = balance;
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        ArrayList<Bank> banks = new ArrayList<>();

        Bank bank1 = new Bank("Bank 1", 1234, 10000);
        Bank bank2 = new Bank("Bank 2", 5678, 5000);
        banks.add(bank1);
        banks.add(bank2);

        int choice;
        do {
            System.out.println("\nBank System Menu");
            System.out.println("1. Show bank details");
            System.out.println("2. Transfer money");
            System.out.println("3. Receive money");
            System.out.println("4. Add new bank account");
            System.out.println("5. Delete existing bank account");
            System.out.println("6. View transaction history");
            System.out.println("7. View balance");
            System.out.println("8. Update balance");
            System.out.println("9. View total balance");
            System.out.println("10. Search for a bank account");
            System.out.println("11. Sort bank accounts");
            System.out.println("12. Exit");
            System.out.print("Enter your choice: ");
            choice = scanner.nextInt();

            switch (choice) {
                case 1:
                    for (Bank bank : banks) {
                        bank.showDetails();
                    }
                    break;
                case 2:
                    System.out.print("Enter amount to transfer from bank 1 to bank 2: ");
                    double amount = scanner.nextDouble();
                    bank1.transfer(bank2, amount);
                    break;
                case 3:
                    System.out.print("Enter amount to receive from bank 1 to bank 2: ");
                    amount = scanner.nextDouble();
                    bank2.receive(bank1, amount);
                    break;
                case 4:
                    System.out.print("Enter name of the new bank account: ");
                    scanner.nextLine(); // consume the newline character
                    String name = scanner.nextLine();
                    System.out.print("Enter account number of the new bank account: ");
                    int accountNumber = scanner.nextInt();
                    System.out.print("Enter initial balance of the new bank account: ");
                    double balance = scanner.nextDouble();
                    Bank newBank = new Bank(name, accountNumber, balance);
                    banks.add(newBank);
                    System.out.println("New bank account added successfully.");
                    break;
                case 5:
                    System.out.print("Enter account number of the bank account to be deleted: ");
                    accountNumber = scanner.nextInt();
                    for (Bank bank : banks) {
                        if (bank.getAccountNumber() == accountNumber) {
                            banks.remove(bank);
                            System.out.println("Bank account deleted successfully.");
                            break;
                        }
                    }
                    break;
                case 6:
                    System.out.print("Enter account number of the bank account to view the transaction history: ");
                    accountNumber = scanner.nextInt();
                    for (Bank bank : banks) {
                        if (bank.getAccountNumber() == accountNumber) {
                            // display the transaction history of this bank account
                            break;
                        }
                    }
                    break;
                case 7:
                    System.out.print("Enter account number of the bank account to view the balance: ");
                    accountNumber = scanner.nextInt();
                    for (Bank bank : banks) {
                        if (bank.getAccountNumber() == accountNumber) {
                            System.out.println("Balance of " + bank.getName() + ": $" + bank.getBalance());
                            break;
                        }
                    }
                    break;
                case 8:
                    System.out.print("Enter account number of the bank account to update the balance: ");
                    accountNumber = scanner.nextInt();
                    for (Bank bank : banks) {
                        if (bank.getAccountNumber() == accountNumber) {
                            System.out.print("Enter new balance of " + bank.getName() + ": $");
                            balance = scanner.nextDouble();
                            bank.setBalance(balance);
                            System.out.println("Balance updated successfully.");
                            break;
                        }
                    }
                    break;
                case 9:
                    double totalBalance = 0;
                    for (Bank bank : banks) {
                        totalBalance += bank.getBalance();
                    }
                    System.out.println("Total balance of all bank accounts: $" + totalBalance);
                    break;
                case 10:
                    System.out.print("Enter the name or account number of the bank account to search: ");
                    scanner.nextLine(); // consume the newline character
                    String keyword = scanner.nextLine();
                    boolean found = false;
                    for (Bank bank : banks) {
                        if (bank.getName().equalsIgnoreCase(keyword) || bank.getAccountNumber() == Integer.parseInt(keyword)) {
                            bank.showDetails();
                            found = true;
                        }
                    }
                    if (!found) {
                        System.out.println("No bank account found with the given name or account number.");
                    }
                    break;
                case 11:
                    System.out.println("Sort bank accounts by:");
                    System.out.println("1. Balance");
                    System.out.println("2. Name");
                    System.out.println("3. Account Number");
                    System.out.print("Enter your choice: ");
                    int sortChoice = scanner.nextInt();
                    switch (sortChoice) {
                        case 1:
                            banks.sort((b1, b2) -> Double.compare(b2.getBalance(), b1.getBalance())); // descending order
                            break;
                        case 2:
                            banks.sort((b1, b2) -> b1.getName().compareToIgnoreCase(b2.getName())); // ascending order
                            break;
                        case 3:
                            banks.sort((b1, b2) -> Integer.compare(b1.getAccountNumber(), b2.getAccountNumber())); // ascending order
                            break;
                        default:
                            System.out.println("Invalid choice. Please try again.");
                            break;
                    }
                    System.out.println("Bank accounts sorted successfully.");
                    break;
                case 12:
                    System.out.println("Exiting program... Thank you for using our services.");
                    break;
                default:
                    System.out.println("Invalid choice. Please try again.");
            }
        } while (choice != 12);
    }
}