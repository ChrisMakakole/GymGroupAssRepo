package com.example.gymproject.model;

public class Trainer {
    private int id;
    private String name;
    private String specialization;

    // Default constructor
    public Trainer() {
    }

    // Constructor with all fields
    public Trainer(int id, String name, String specialization) {
        this.id = id;
        this.name = name;
        this.specialization = specialization;
    }

    // Constructor without ID (for adding new trainers)
    public Trainer(String name, String specialization) {
        this.name = name;
        this.specialization = specialization;
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

    public String getSpecialization() {
        return specialization;
    }

    public void setSpecialization(String specialization) {
        this.specialization = specialization;
    }

    @Override
    public String toString() {
        return "Trainer{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", specialization='" + specialization + '\'' +
                '}';
    }
}