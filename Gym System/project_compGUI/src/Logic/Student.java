package Logic;

import java.io.Serializable;
/**
 * Name: Student
 * Author: Noora Qasim
 * 
 * Purpose/description:
 * This class represents a student, which is a type of member. It includes information about the course and team of the student.
 *
 */

public class Student extends Member implements Serializable{
    private String course;
    private String team;

    public Student(String course, String team, String firstName, String surname, String address, String dateOfBirth, String phone, String gender) {
        super(firstName, surname, address, dateOfBirth, phone, gender);
        this.course = course;
        this.team = team;
    }

  
    public String getCourse() {
        return course;
    }

    public void setCourse(String course) {
        this.course = course;
    }

    public String getTeam() {
        return team;
    }

    public void setTeam(String team) {
        this.team = team;
    }
    
    public void removeTeam(){
        team =null;
    }
}
