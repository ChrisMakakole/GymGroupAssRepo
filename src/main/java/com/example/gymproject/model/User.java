package com.example.gymproject.model;

import java.util.Date;

public class User {
    private int id;
    private String name;
    private String email;
    private String phone;
    private Date membershipStartDate;
    private Date membershipEndDate;

    // Default constructor (required by some frameworks)
    public User() {
    }

    // Constructor with all fields
    public User(int id, String name, String email, String phone, Date membershipStartDate, Date membershipEndDate) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.membershipStartDate = membershipStartDate;
        this.membershipEndDate = membershipEndDate;
    }

    // Constructor without ID (for adding new users)
    public User(String name, String email, String phone, Date membershipStartDate, Date membershipEndDate) {
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.membershipStartDate = membershipStartDate;
        this.membershipEndDate = membershipEndDate;
    }

    // Constructor without membership dates (if you're handling that separately initially)
    public User(int id, String name, String email, String phone) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.phone = phone;
    }

    public User(String name, String email, String phone) {
        this.name = name;
        this.email = email;
        this.phone = phone;
    }


    // Getters and Setters for all fields
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Date getMembershipStartDate() {
        return membershipStartDate;
    }

    public void setMembershipStartDate(Date membershipStartDate) {
        this.membershipStartDate = membershipStartDate;
    }

    public Date getMembershipEndDate() {
        return membershipEndDate;
    }

    public void setMembershipEndDate(Date membershipEndDate) {
        this.membershipEndDate = membershipEndDate;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", phone='" + phone + '\'' +
                ", membershipStartDate=" + membershipStartDate +
                ", membershipEndDate=" + membershipEndDate +
                '}';
    }
}