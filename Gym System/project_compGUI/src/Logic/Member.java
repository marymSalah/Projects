package Logic;

import java.io.Serializable;
/**
 * Name: Member
 * Author: Fatema Naser
 * 
 * Purpose/description:
 * This class represents a member with their details such as membership 
 * ID, first name, surname, address, date of birth, phone, and gender.
 *
 */


public class Member implements Serializable{
    private int membershipid;
    private String firstName;
    private String surname;
    private String address;
    private String dateOfBirth;
    private String phone;
    private String gender;
    static transient int count =0;
    // to resit the static after a rerun
    private transient int counter=0;
    //added these two cuz it didnt make sense as to why i have to loop through each trainer to find this 
    private boolean trainer;
    private int trainerID;

    public Member(String firstName, String surname, String address, String dateOfBirth, String phone, String gender) {
        this.firstName = firstName;
        this.surname = surname;
        this.address = address;
        this.dateOfBirth = dateOfBirth;
        this.phone = phone;
        this.gender = gender;
        count++;
        membershipid = count;
        trainer = false;
        trainerID = 0;
    }

    public boolean isTrainer() {
        return trainer;
    }

    public void setTrainer(boolean trainer) {
        this.trainer = trainer;
    }
    
    public void setCounter(int c2){
        counter = c2;
        Member.count = counter;
    }

    public int getTrainerID() {
        return trainerID;
    }
    

    public void setTrainerID(int trainerID) {
        this.trainerID = trainerID;
        trainer = true;
    }

    public int getMembershipid() {
        return membershipid;
    }

    public void setMembershipid(int membershipid) {
        this.membershipid = membershipid;
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

    public String getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(String dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }
    
    
    
}
