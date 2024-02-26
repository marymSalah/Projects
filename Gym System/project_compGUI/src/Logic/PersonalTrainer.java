package Logic;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */


import java.io.Serializable;
import java.util.ArrayList;
/**
 * Name: PersonalTrainer
 * Author: Noora Qasim
 * 
 * Purpose/description:
 * This class represents a personal trainer,
 * which is a type of employee. It includes a list of members associated with the personal trainer.
 *
 */
/**
 *
 * @author 202103422
 */
public class PersonalTrainer extends Employee implements Serializable{

    private ArrayList<Member> listOfMember;

    public PersonalTrainer(String firstName,String surname, String address, String phone, double salary) {
        super(firstName, surname,address, phone, salary);
        listOfMember = new ArrayList<Member>();
    }

    public PersonalTrainer(ArrayList<Member> listOfMember, String firstName,String surname, String address, String phone, double salary) {
        super(firstName,surname, address, phone, salary);
        this.listOfMember = listOfMember;
    }

    public ArrayList<Member> getListOfMember() {
        return listOfMember;
    }

    public void setListOfMember(ArrayList<Member> listOfMember) {
        this.listOfMember = listOfMember;
    }

    public void addMember(Member m1) {
        listOfMember.add(m1);
    }

    public void removeMember(Member m1) {
        //have to throw an exception here later remind noora LOL 
        for (int i=0; i<listOfMember.size();i++){
            if(m1.getMembershipid()==listOfMember.get(i).getMembershipid()){
                listOfMember.remove(i);
            }
        }
    }
    
    

}
