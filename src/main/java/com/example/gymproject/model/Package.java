package com.example.gymproject.model;

public class Package {
    private int id;
    private String name;
    private String description;
    private double price;
    private int durationDays;

    // Default constructor
    public Package() {
    }

    // Constructor with all fields
    public Package(int id, String name, String description, double price, int durationDays) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.durationDays = durationDays;
    }

    // Constructor without ID (for adding new packages)
    public Package(String name, String description, double price, int durationDays) {
        this.name = name;
        this.description = description;
        this.price = price;
        this.durationDays = durationDays;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getDurationDays() {
        return durationDays;
    }

    public void setDurationDays(int durationDays) {
        this.durationDays = durationDays;
    }

    @Override
    public String toString() {
        return "Package{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", price=" + price +
                ", durationDays=" + durationDays +
                '}';
    }
}