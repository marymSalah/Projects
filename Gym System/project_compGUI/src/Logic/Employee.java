package Logic;

import java.io.Serializable;
/**
 * Name: Employee
 * Author:  Maryam Saleh
 * 
 * Purpose/description:
 * This class represents an employee with their details such as 
 * staff ID, first name, surname, address, phone, and salary.
 *
 */


public class Employee implements Serializable {
    private int staffId;
    private String firstName;
    private String surname;
    private String address;
    private String phone;
    private double salary;
    static transient int count =0;
    private transient int counter =0;

    public Employee(String firstName,String surname, String address, String phone, double salary) {
        this.firstName = firstName;
        this.surname = surname;
        this.address = address;
        this.phone = phone;
        this.salary = salary;
         // to resit the static after a rerun
        count ++;
        staffId = count;
    }

    public int getStaffId() {
        return staffId;
    }
    public void setCounter(int counter){
        this.counter = counter;
        Employee.count = this.counter;
    }
    

    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public double getSalary() {
        return salary;
    }

    public void setSalary(double salary) {
        this.salary = salary;
    }

   
}
