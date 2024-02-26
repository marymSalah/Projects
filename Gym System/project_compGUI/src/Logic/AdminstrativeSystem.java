package Logic;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
import GUI.UnassignFromTrainer1;
import GUI.UnassignFromTrainer2;
//import GUI.UnassignFromTrainer3;
import GUI.UnassignorChange;
import GUI.assignTrainer1;
import GUI.assignTrainer2;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.PrintStream;
import java.io.Serializable;
import java.util.ArrayList;

/**
 *
 * @author 202103422
 */
public class AdminstrativeSystem implements Serializable {

    //only class we are serializing
    private ArrayList<Member> memberList;
    private ArrayList<Employee> employees;

    /**
     *
     */
    public AdminstrativeSystem() {
        memberList = new ArrayList<Member>();
        employees = new ArrayList<Employee>();
    }

    /**
     * Name: addNewEmployee Author: Maryam Salah Purpose/description: Adds a new
     * employee with all their details
     *
     * @param firstName The first name of the employee.
     * @param surname The surname of the employee.
     * @param address The address of the employee.
     * @param phone The phone number of the employee.
     * @param salary The salary of the employee.
     * @param trainer A Boolean value indicating whether the employee is a
     * trainer or not.
     * @throws IllegalArgumentException if any of the input parameters are
     * invalid.
     */
    public void addNewEmployee(String firstName, String surname, String address, String phone, double salary, boolean trainer) throws IllegalArgumentException {

        boolean valid = false;

        // for first name 
        do {
            //validation for first name, must be atleast 2 characters and max of 30 characters  
            if (firstName.length() >= 2 && firstName.length() <= 30) {
                valid = true;
            } else {
                throw new IllegalArgumentException("Enter valid first name");
            }
        } while (!valid);
        //reset the valid  
        valid = false;
        do {
            //validation for surname, must be atleast 2 characters and max of 30 characters  
            if (surname.length() >= 2 && surname.length() <= 30) {
                valid = true;
            } else {
                throw new IllegalArgumentException("Enter valid surname");
            }
        } while (!valid);

        //reset the valid  
        valid = false;

        // for address 
        do {
            //validate the address  
            if (address.length() >= 5 && address.length() <= 150) {
                valid = true;
            } else {
                throw new IllegalArgumentException("Enter valid address");
            }
        } while (!valid);

        //reset the valid  
        valid = false;
        do {
            if (phone.length() != 8) {
                throw new IllegalArgumentException("Enter valid phone number in the following format: XXXX XXXX");

            } else {
                valid = true;
            }
        } while (!valid);
// reset the valid        
        valid = false;

        do {

            //validate salary  
            if (salary < 0) {
                throw new IllegalArgumentException("Enter valid salary");
            } else {
                valid = true;
            }

        } while (!valid);
        // if the employee is a normal employee
        if (trainer == false) {
            Employee employee2 = new Employee(firstName, surname, address, phone, salary);
            employees.add(employee2);

        } else if (trainer == true) {
// if the employee is a personal trainer 
            PersonalTrainer PersonalTrainer1 = new PersonalTrainer(firstName, surname, address, phone, salary);

            employees.add(PersonalTrainer1);
        }
    }

    /**
     * Name: addNewMember Author: Msryam Salah Purpose/description: Adds a new
     * member to the system with the provided details. The member can be either
     * a staff or a student.
     *
     * For staff members: - The position and department are required.
     *
     * For student members: - The course and team are required.
     *
     * The method prompts the user to enter the necessary details and performs
     * validations before adding the member.
     *
     * @param choice The choice indicating whether the member is a staff or a
     * student
     * @param firstName The first name of the member.
     * @param surname The surname of the member.
     * @param address The address of the member.
     * @param dob The date of birth of the member in the format dd-mm-yyyy.
     * @param phone The phone number of the member.
     * @param gender The gender of the member.
     *
     *
     * @throws IllegalArgumentException if there is no input available when
     * reading from the console.
     */
    public void addNewMember(String firstName, String surname, String address, String phone, String dob, String gender, String choice) throws IllegalArgumentException {

        //Maryooma <3 
        int ch = 0;
        if (choice.equalsIgnoreCase("Staff")) {
            ch = 1;
        } else if (choice.equalsIgnoreCase("Student")) {
            ch = 2;
        } else {
            throw new IllegalArgumentException("ok");
        }
        boolean valid = false;
        //GUI.addnewmember a1 = new GUI.addnewmember();

        // for first name
        do {
            //validation for first name, must be atleast 2 characters and max of 30 characters  
            if (firstName.length() >= 2 && firstName.length() <= 30) {
                valid = true;
            } else {
                throw new IllegalArgumentException("Enter valid first name");
            }
        } while (!valid);

        //reset the valid  
        valid = false;

        // for surname 
        do {
            //validation for first name, must be atleast 2 characters and max of 30 characters  
            if (surname.length() >= 2 && surname.length() <= 30) {
                valid = true;
            } else {
                throw new IllegalArgumentException("Enter valid surname");
            }
        } while (!valid);

        //reset the valid  
        valid = false;
        // for address 
        do {
            //validate the address  
            if (address.length() >= 5 && address.length() <= 150) {
                valid = true;
            } else {
                throw new IllegalArgumentException("Enter valid address");
            }
        } while (!valid);

        //reset the valid  
        valid = false;
        do {
            // validates the format of the dob   
            if (dob.length() != 10 || dob.charAt(2) != '-' || dob.charAt(5) != '-') {
                throw new IllegalArgumentException("Enter valid date of birth Using this format : dd-mm-yyyy");
            } else {
                valid = true;
            }
        } while (!valid);

        //reset valid 
        valid = false;

        do {

            //validate phone number  
            if (phone.length() != 8) {
                throw new IllegalArgumentException("Enter valid phone number");
            } else {
                valid = true;
            }
        } while (!valid);
        // reset valid
        valid = false;

        do {
            if (gender.equalsIgnoreCase("Female") || gender.equalsIgnoreCase("Male")) {
                valid = true;
            } else {
                throw new IllegalArgumentException("Enter valid gender");
            }
        } while (!valid);
        // reset valid
        valid = false;
        switch (ch) {
            case 1:
                // department
                GUI.AddMember1 adm = new GUI.AddMember1();
                String department,
                 position;
                department = adm.getDepartment();
                do {

                    if (department.length() >= 2 && department.length() <= 30) {
                        valid = true;
                    } else {
                        throw new IllegalArgumentException("Enter valid department");
                    }
                } while (!valid);
                // reset valid
                valid = false;
                // position
                position = adm.getPosition();

                do {
                    if (position.length() >= 2 && position.length() <= 30) {
                        valid = true;
                    } else {
                        throw new IllegalArgumentException("Enter valid position");
                    }
                } while (!valid);
                // reset valid    
                valid = false;
                // add staff item
                Staff staff1 = new Staff(position, department, firstName, surname, address, dob, phone, gender);
                memberList.add(staff1);
                break;
            case 2:

                GUI.AddMember2 adm1 = new GUI.AddMember2();
                String course,
                 team;
                course = adm1.getCourse();
                team = adm1.getTeam();
                do {
                    if (course.length() >= 2 && course.length() <= 30) {
                        valid = true;
                    } else {
                        throw new IllegalArgumentException("Enter valid course");
                    }
                } while (!valid);
                // reset value    
                valid = false;

                // position
                do {

                    if (team.length() >= 2 && team.length() <= 30) {
                        valid = true;
                    } else {
                        throw new IllegalArgumentException("Enter valid  team");
                    }
                } while (!valid);

                // reset valid
                valid = false;
                // add item 
                Student student1 = new Student(course, team, firstName, surname, address, dob, phone, gender);
                memberList.add(student1);
                break;
        }
    }
/**
 * Name: updateMemberDetaik
 * Author: Fatema Naser
 * 
 * Purpose/description:
 * updated the details of a member based on user input from the GUI
 * The corresponding field of the member is updated with the new value
 * validation is happening for the fields 
 * @throws IllegalArgumentException
 */
    public void updateMemberDetail() throws IllegalArgumentException {

        int id, choice = 0;
        id = new GUI.updatememberID().getID();
        boolean find = false, valid = false;
        String firstName, surName, address, dob, phone, gender;
        String type = new GUI.updMember().getText();
        String text = new GUI.updMember1().getnewText();

        if (type.equalsIgnoreCase("First Name")) {
            choice = 1;
        } else if (type.equalsIgnoreCase("surname")) {
            choice = 2;
        } else if (type.equalsIgnoreCase("Address")) {
            choice = 3;
        } else if (type.equalsIgnoreCase("Date of Birth")) {
            choice = 4;
        } else if (type.equalsIgnoreCase("phone")) {
            choice = 5;
        } else if (type.equalsIgnoreCase("position")) {
            choice = 6;
        } else if (type.equalsIgnoreCase("department")) {
            choice = 7;
        } else if (type.equalsIgnoreCase("course")) {
            choice = 8;
        } else if (type.equalsIgnoreCase("team")) {
            choice = 9;
        }

        for (int i = 0; i < memberList.size(); i++) {
            if (id == memberList.get(i).getMembershipid()) {
                find = true;
                switch (choice) {
                    case 1 -> {
                        firstName = text;
                        //validation for first name, must be atleast 2 characters and max of 30 characters 
                        if (firstName.length() >= 2 && firstName.length() <= 30) {
                            memberList.get(i).setFirstName(firstName);
                        } else {
                            throw new IllegalArgumentException("Please enter a valid name");
                        }
                    }
                    // surname  
                    case 2 -> {
                        surName = text;
                        //validation of surname 
                        if (surName.length() >= 2 && surName.length() <= 30) {
                            memberList.get(i).setSurname(surName);
                        } else {
                            throw new IllegalArgumentException("Please enter a valid surname");
                        }
                    }

                    // address 
                    case 3 -> {
                        do {
                            address = text;
                            if (address.length() >= 5 && address.length() <= 150) {
                                memberList.get(i).setAddress(address);
                                valid = true;
                            } else {

                                throw new IllegalArgumentException("Please enter a valid address");

                            }

                        } while (!valid);

                    }

                    //Date of birth 
                    case 4 -> {

                        do {
                            dob = text;
                            // validates the format of the dob  
                            if (dob.length() != 10 || dob.charAt(2) != '-' || dob.charAt(5) != '-') {
                                throw new IllegalArgumentException("Please enter a valid date of birth");
                            } else {
                                memberList.get(i).setDateOfBirth(dob);
                                valid = true;
                            }
                        } while (!valid);

                    }

                    //phone number 
                    case 5 -> {

                        do {
                            phone = text;
                            //validate phone number 
                            if (phone.length() != 8) {
                                throw new IllegalArgumentException("Please enter a valid date phone number: XXXX XXXX");
                            } else {
                                memberList.get(i).setPhone(phone);
                                valid = true;
                            }
                        } while (!valid);
                    }
                    case 6 -> {
                        ((Staff) memberList.get(i)).setPosition(text);
                    }
                    case 7 -> {
                        ((Staff) memberList.get(i)).setDepartment(text);
                    }
                    case 8 -> {
                        ((Student) memberList.get(i)).setCourse(text);
                    }
                    case 9 -> {
                        ((Student) memberList.get(i)).setTeam(text);
                    }

                }

            }

        }

        if (!find) {

            System.out.println("Member id doesn't exist.");

        }

    }

    /**
     * Author : Fatema Naser Name: updateEmployeeDetails Purpose/description:
     * Updates the details of an employee based on user input from the GUI. The
     * corresponding field of the employee is updated with the new value
     * provided by the user. If the entered value is invalid, an
     * IllegalArgumentException is thrown.
     *
     * @throws IllegalArgumentException if the entered value is invalid.
     */
    public void updateEmployeeDetail() {

        //declare variables 
        boolean find = false;
        int choice = 0;
        String firstName, address, phone;
        double salary;
        boolean valid = false;
// to get the id from the GUI
        int id = new GUI.updateemployeeID().getID();

        String type = new GUI.updEmployee().getText();
// finds out what data that needs to be updated and assign a number to it. 
        if (type.equalsIgnoreCase("First Name")) {
            choice = 1;
        } else if (type.equalsIgnoreCase("Address")) {
            choice = 2;
        } else if (type.equalsIgnoreCase("Phone number")) {
            choice = 3;
        } else if (type.equalsIgnoreCase("Salary")) {
            choice = 4;
        }

        // loops to find the employee 
        for (int i = 0; i < employees.size(); i++) {
            if (id == employees.get(i).getStaffId()) {
                find = true;
                switch (choice) {
                    //first name  
                    case 1 -> {
                        do {
                            firstName = new GUI.updEmployee1().getText();
                            //validation for first name, must be atleast 2 characters and max of 30 characters 
                            if (firstName.length() >= 2 && firstName.length() <= 30) {
                                employees.get(i).setFirstName(firstName);
                                valid = true;
                            } else {
                                throw new IllegalArgumentException("Please enter a valid name");
                            }
                        } while (!valid);
                    }
                    //address 
                    case 2 -> {
                        do {
                            // validates the address entered
                            address = new GUI.updEmployee1().getText();
                            if (address.length() >= 5 && address.length() <= 150) {
                                employees.get(i).setAddress(address);
                                valid = true;
                            } else {
                                throw new IllegalArgumentException("Please enter a valid address");
                            }
                        } while (!valid);
                    }

                    //phone 
                    case 3 -> {
                        do {
                            phone = new GUI.updEmployee1().getText();
                            //validate phone number 
                            if (phone.length() == 8) {
                                employees.get(i).setPhone(phone);
                                valid = true;
                            } else {
                                throw new IllegalArgumentException("Please enter a valid phone number in following format XXXX XXXX");
                            }
                        } while (!valid);
                    }
                    //salary 
                    case 4 -> {
                        do {

                            salary = Double.parseDouble(new GUI.updEmployee1().getText());
                            //validate the salary 
                            if (salary < 0) {
                                throw new IllegalArgumentException("Please enter a valid phone number in following format XXXX XXXX");
                            } else {
                                employees.get(i).setSalary(salary);
                                valid = true;
                            }
                        } while (!valid);
                    }
                }
            }
        }
    }

    /**
     * Assigns Member to Trainer. The methods takes memberID and Trainer ID from
     * GUI then it changes the member's information accordingly
     */
    public void assignToTrainer() {
        //Declartion of variable outside of loop scope

        boolean validInput = false;
        boolean foundID = false;
        //get the static memberID from the assignTrainer 1 form
        int memberID = assignTrainer1.getMemberID();
        //do{
        //input validation Loop
        do {
            if (memberID > 0) {
                validInput = true;
            } //Throw Exception when ID is invalid
            else {
                throw new IllegalArgumentException("Enter valid ID");
            }
        } while (!validInput);

        // Loop Through members arrylist for memberID
        for (int i = 0; i < memberList.size() && foundID == false; i++) {
            // Check if member exists
            if (memberID == memberList.get(i).getMembershipid()) {
                foundID = true;
                //check if member is assigned to trainer
                if (memberList.get(i).isTrainer() == false) {
                    //get Trainer ID from the GUI
                    int trainerID = assignTrainer2.getTrainerid();
                    //Edit the member's information

                    memberList.get(i).setTrainerID(trainerID);
                    memberList.get(i).setTrainer(true);
                    //get Trainer's list from employees List
                    for (int j = 0; j < employees.size(); j++) {
                        if (getEmployees().get(j) instanceof PersonalTrainer) {
                            ((PersonalTrainer) employees.get(j)).getListOfMember().add(memberList.get(i));
                        }
                    }
                } // if member is already assigned to trainer
                else {

                    throw new IllegalArgumentException("Error: Member already assigned to Trainer");
                }
            } else {
                throw new IllegalArgumentException("Member Does not Exist in our Records");
            }
        }

    }

    /**
     * UnAssigns Member From Trainer or Changes Trainer. The methods takes
     * choice, memberID and Trainer ID from GUI then it changes the member's
     * information accordingly
     */
    public void unassignFromTrainer() {
        boolean validInput = false;
        boolean foundID = false;
        int TrainerID;
        int memberID = UnassignFromTrainer1.getMemberID();
        // Input validation loop
        do {
            if (memberID > 0) {
                validInput = true;
            } else {
                throw new IllegalArgumentException("Enter valid ID");
            }
        } while (!validInput);

        if (memberID > memberList.size()) {
            throw new IndexOutOfBoundsException("Invalid ID");
        }

        //get Selection from UnassignedFromTrainer1 choice
        int choice = UnassignorChange.getChoice();
        //case statement to to either Change/Unassign
        switch (choice) {
            //If the user entered "Unassign From Trainer"
            case 1:
                //Loop through memberList ArrayList to find MemberID
                for (int i = 0; i < memberList.size() && foundID == false; i++) {
                    // If found
                    if (memberID == memberList.get(i).getMembershipid()) {
                        foundID = true;
                        // If Assigned to trainer or not
                        if (memberList.get(i).isTrainer() == true) {

                            //Edit the member's information
                            TrainerID = memberList.get(i).getTrainerID();
                            memberList.get(i).setTrainerID(0);
                            memberList.get(i).setTrainer(false);
                            //get Trainer's list from employees List and remove member
                            for (int j = 0; j < employees.size(); j++) {
                                if (TrainerID == employees.get(j).getStaffId()) {
                                    ((PersonalTrainer) employees.get(j)).removeMember(memberList.get(i));
                                }
                            }
                        } //if member is not assigned to trainer
                        else {
                            throw new IllegalArgumentException("Not assigned to any trainer");
                        }
                    } // If not found

                }
                if (!foundID) {
                    throw new IllegalArgumentException("Member Does not Exist in our Records");
                }
                break;

            case 2:
                //If the user entered "Change Trainer"
                for (int i = 0; i < memberList.size() && foundID == false; i++) {
                    if (memberID == memberList.get(i).getMembershipid()) {
                        foundID = true;
                        //check if member  is assigned or not
                        if (memberList.get(i).isTrainer() == true) {
                            int oldTrainer = memberList.get(i).getTrainerID();
                            for (int l = 0; l < employees.size(); l++) {
                                if (getEmployees().get(l) instanceof PersonalTrainer && getEmployees().get(l).getStaffId() == oldTrainer) {
                                    ((PersonalTrainer) employees.get(l)).getListOfMember().remove(memberList.get(i));
                                }
                            }
                            int trainerID = UnassignFromTrainer2.getTrainerid();
                            memberList.get(i).setTrainerID(trainerID);
                            for (int j = 0; j < employees.size(); j++) {
                                if (getEmployees().get(j) instanceof PersonalTrainer && getEmployees().get(j).getStaffId() == trainerID ) {
                                    ((PersonalTrainer) employees.get(j)).getListOfMember().add(memberList.get(i));
                                }
                            }
                        } 
                        else 
                        {
                            IllegalArgumentException("Error: Member not assigned to any Trainer");
                        }
                    } 
                }
                if(!foundID){
                    IllegalArgumentException("Member Does not Exist in our Records");
                }
                break;
            default:
                throw new IllegalArgumentException("Wrong Choice");
        }

    }

    /**
     * Author : Noora Qasim Name: deleteMember Purpose/description: This method
     * deletes a member from the member list based on the provided ID.
     *
     * @param id the ID of the member to be deleted.
     * @throws IllegalArgumentException if no member with the specified ID is
     * found.
     */
    public void deleteMember(int id) {
        boolean b1 = false;
        if (memberList.isEmpty()) {
            throw new IllegalArgumentException("No member with this id"); // Throw an exception if the member list is empty
        }
        // loop over the member list to find the member
        for (int i = 0; i < memberList.size(); i++) {
            // Check if the id is found
            if (memberList.get(i).getMembershipid() == id) {
                b1 = true;
                // Check if the member is a trainer
                if (memberList.get(i).isTrainer()) {
                    // Get the ID of the trainer associated with this member
                    int trainerID = memberList.get(i).getTrainerID();
                    // loop over the list of employees to find the trainer with the matching ID
                    for (int j = 0; j < employees.size(); j++) {
                        // Check if the current employee is the trainer
                        if (employees.get(j).getStaffId() == trainerID) {
                            // Remove the member from the trainer's list of members
                            ((PersonalTrainer) employees.get(j)).removeMember(memberList.get(i));
                        }
                    }
                }
                memberList.remove(i);
            }
        }
        if (b1 == false) {
            throw new IllegalArgumentException("No member with this id"); // Throw an exception if no member with the given ID is found
        }
    }

    /**
     * Author : Noora Qasim Name: deleteEmployee Purpose/description: This
     * method deletes an employee from the employee list based on the ID given.
     *
     * @param id the ID of the employee to be deleted.
     * @throws IllegalArgumentException if no employee with the specified ID is
     * found.
     *
     */
    public void deleteEmployee(int id) {
        boolean b1 = false;
        if (employees.size() == 0) {
            // Throws error if the employee list is empty
            throw new IllegalArgumentException("No Employee with this id");
        }
        // loop over the employee’s list to find the employee with the given ID
        for (int i = 0; i < employees.size(); i++) {
// if employee is found
            if (employees.get(i).getStaffId() == id) {
                b1 = true;
// Checks if the employee is a personal trainer
                if (employees.get(i) instanceof PersonalTrainer) {
                    // Get the list of members associated with this trainer
                    ArrayList<Member> listofMems = ((PersonalTrainer) employees.get(i)).getListOfMember();
                    // loop over the list of members and update their trainer’s information
                    for (int j = 0; j < listofMems.size(); j++) {
                        for (int k = 0; k < memberList.size(); k++) {
                            if (listofMems.get(j).getMembershipid() == memberList.get(k).getMembershipid()) {
                                // Remove the trainer association from the member
                                memberList.get(k).setTrainer(false);
                                memberList.get(k).setTrainerID(0);
                            }
                        }
                    }

                }
                employees.remove(i);

            }
        }
        if (!b1) {
// Throw an exception if no employee with the given ID is found
            throw new IllegalArgumentException("No Employee with this ID");

        }
    }

    /**
     *
     * @param id
     */
    public void listPTMembers(int id) {
        //noon
        for (int i = 0; i < employees.size(); i++) {
            if (employees.get(i).getStaffId() == id) {
                // System.out.println("Employee found");
                if (employees.get(i) instanceof PersonalTrainer) {
                    System.out.println("Employee is a presonal Trainer");
                    ArrayList<Member> listofMems = ((PersonalTrainer) employees.get(i)).getListOfMember();
                    for (int j = 0; j < listofMems.size(); j++) {
                        System.out.println(listofMems.get(j).getMembershipid());

                    }
                }

            }

        }
    }

    /**
     * Author : Noora Qasim Name: generateReport Purpose/description: Generates
     * a marketing report and creates a file named "marketingReport.txt" and
     * puts the report in it.The report contains information about staff and
 student gym members.
     *
     * @throws FileNotFoundException if the file cannot be created or written
     * to.
     */
    public void generateReport() throws FileNotFoundException {
        // Create a new file output stream and print stream for the report file.
        FileOutputStream file = new FileOutputStream("marketingReport.txt");
        PrintStream outFile = new PrintStream(file);

        outFile.println("Summary report - Polytechnic administration system");
        outFile.println("\n");
        outFile.println("Information about Staff Gym members");
        outFile.println("\n");

        int countStaff = 0;
        int countmember = 0;
        // loop over the list of members and write the staff members’ information to the report
        for (int i = 0; i < memberList.size(); i++) {
            if (memberList.get(i) instanceof Staff) {
                outFile.println("Name: " + memberList.get(i).getFirstName() + " " + memberList.get(i).getSurname());
                outFile.println("Address: " + memberList.get(i).getAddress());
                outFile.println("Phone Number: " + memberList.get(i).getPhone());
                outFile.println("Position: " + ((Staff) memberList.get(i)).getPosition());
                outFile.println("Department: " + ((Staff) memberList.get(i)).getDepartment());
                countStaff++;
                outFile.println("\n");
            }
        }

        // Write summary of details of the staff members
        outFile.println("*********************************************************");
        outFile.println("\n");
        outFile.println("Total number of Staff: " + countStaff);
        outFile.println("\n");
        outFile.println("*********************************************************");
        outFile.println("\n");

        outFile.println("Information about Student Gym Members");
        outFile.println("\n");
        // loop over the list of members and write the student members’ information to the report
        for (int i = 0; i < memberList.size(); i++) {
            if (memberList.get(i) instanceof Student) {
                outFile.println("Name: " + memberList.get(i).getFirstName() + " " + memberList.get(i).getSurname());
                outFile.println("Address: " + memberList.get(i).getAddress());
                outFile.println("Phone Number: " + memberList.get(i).getPhone());
                outFile.println("Degree: " + ((Student) memberList.get(i)).getCourse());
                outFile.println("Team: " + ((Student) memberList.get(i)).getTeam());
                countmember++;
                outFile.println("\n");
            }
        }

        // Write summary of details of the student members
        outFile.println("*********************************************************");
        outFile.println("\n");
        outFile.println("Total number of Members: " + countmember);
        outFile.println("\n");
        outFile.println("*********************************************************");
    }

    /**
     *
     * @return
     */
    public ArrayList<Member> getMemberList() {
        return memberList;
    }

    /**
     *
     * @param memberList
     */
    public void setMemberList(ArrayList<Member> memberList) {
        this.memberList = memberList;
    }

    /**
     *
     * @return
     */
    public ArrayList<Employee> getEmployees() {
        return employees;
    }

    /**
     *
     * @param employees
     */
    public void setEmployees(ArrayList<Employee> employees) {
        this.employees = employees;
    }

    /**
     *
     * @param ID
     * @return
     */
    public boolean isEmployee(int ID) {
        boolean b1 = false;
        for (int i = 0; i < employees.size(); i++) {
            if (ID == employees.get(i).getStaffId()) {
                b1 = true;
            }
        }
        return b1;
    }

    /**
     *
     * @param ID
     * @return
     */
    public boolean isMember(int ID) {
        boolean b1 = false;
        for (int i = 0; i < memberList.size(); i++) {
            if (ID == memberList.get(i).getMembershipid()) {
                b1 = true;
            }
        }
        return b1;
    }

    /**
     *
     * @param ID
     * @return
     */
    public String memberType(int ID) {
        String type = "Student";
        for (int i = 0; i < memberList.size(); i++) {
            if (ID == memberList.get(i).getMembershipid()) {
                if (memberList.get(i) instanceof Staff) {
                    type = "Staff";
                }
            }
        }
        return type;
    }

    /**
     *
     * @param ID
     * @return
     */
    public boolean isTrainer(int ID) {
        boolean b1 = false;
        for (int i = 0; i < employees.size(); i++) {
            if (ID == employees.get(i).getStaffId()) {
                if (employees.get(i) instanceof PersonalTrainer) {

                    b1 = true;
                }
            }
        }
        return b1;
    }

    /**
     *
     * @param ID
     * @return
     */
    public int getPositiont(int ID) {
        int b1 = 0;
        for (int i = 0; i < employees.size(); i++) {
            if (ID == employees.get(i).getStaffId()) {
                if (employees.get(i) instanceof PersonalTrainer) {

                    b1 = i;
                }
            }
        }
        return b1;
    }

    private Exception IllegalArgumentException(String number_must_be_over_0) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
