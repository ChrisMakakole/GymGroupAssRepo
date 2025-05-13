package com.example.gymproject.model;

import java.sql.Date;

public class Trainer {
    private int id;
    private String name;
    private String phone;
    private String email;
    private String trainingType;
    private Date registrationDate;

    // Default constructor
    public Trainer() {
    }

    // Constructor with all fields
    public Trainer(int id, String name, String phone, String email, String trainingType, Date registrationDate) {
        this.id = id;
        this.name = name;
        this.phone = phone;
        this.email = email;
        this.trainingType = trainingType;
        this.registrationDate = registrationDate;
    }

    // Constructor without ID (for adding new trainers)
    public Trainer(String name, String phone, String email, String trainingType, Date registrationDate) {
        this.name = name;
        this.phone = phone;
        this.email = email;
        this.trainingType = trainingType;
        this.registrationDate = registrationDate;
    }

    // Getters and Setters
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

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTrainingType() {
        return trainingType;
    }

    public void setTrainingType(String trainingType) {
        this.trainingType = trainingType;
    }

    public Date getRegistrationDate() {
        return registrationDate;
    }

    public void setRegistrationDate(Date registrationDate) {
        this.registrationDate = registrationDate;
    }

    @Override
    public String toString() {
        return "Trainer{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", phone='" + phone + '\'' +
                ", email='" + email + '\'' +
                ", trainingType='" + trainingType + '\'' +
                ", registrationDate=" + registrationDate +
                '}';
    }
}

