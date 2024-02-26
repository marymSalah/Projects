package Logic;

import java.io.Serializable;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */


/**
 * Name: Staff
 * Author:  Noora Qasim
 * 
 * Purpose/description:
 * This class represents a staff member, which is a type of member. It includes information about the position and department of the staff member.
 *
 */
public class Staff extends Member implements Serializable {
    private String position;
    private String department;

    public Staff(String position, String department, String firstName, String surname, String address, String dateOfBirth, String phone, String gender) {
        super(firstName, surname, address, dateOfBirth, phone, gender);
        this.position = position;
        this.department = department;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    
    
}
