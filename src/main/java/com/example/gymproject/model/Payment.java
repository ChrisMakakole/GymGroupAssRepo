package com.example.gymproject.model;

import java.sql.Timestamp;

public class Payment {
    private int id;
    private int userId;
    private int packageId;
    private Timestamp paymentDate;
    private double amount;
    private String paymentType;
    private boolean recurring;

    // Optional: To hold related User and Package objects for easier access
    private User user;
    private Package gymPackage;

    // Default constructor
    public Payment() {
    }

    // Constructor with all fields (excluding related objects)
    public Payment(int id, int userId, int packageId, Timestamp paymentDate, double amount, String paymentType, boolean recurring) {
        this.id = id;
        this.userId = userId;
        this.packageId = packageId;
        this.paymentDate = paymentDate;
        this.amount = amount;
        this.paymentType = paymentType;
        this.recurring = recurring;
    }

    // Constructor without ID (for recording new payments)
    public Payment(int userId, int packageId, Timestamp paymentDate, double amount, String paymentType, boolean recurring) {
        this.userId = userId;
        this.packageId = packageId;
        this.paymentDate = paymentDate;
        this.amount = amount;
        this.paymentType = paymentType;
        this.recurring = recurring;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getPackageId() {
        return packageId;
    }

    public void setPackageId(int packageId) {
        this.packageId = packageId;
    }

    public Timestamp getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(Timestamp paymentDate) {
        this.paymentDate = paymentDate;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getPaymentType() {
        return paymentType;
    }

    public void setPaymentType(String paymentType) {
        this.paymentType = paymentType;
    }

    public boolean isRecurring() {
        return recurring;
    }

    public void setRecurring(boolean recurring) {
        this.recurring = recurring;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Package getPackage() {
        return gymPackage;
    }

    public void setPackage(Package gymPackage) {
        this.gymPackage = gymPackage;
    }

    @Override
    public String toString() {
        return "Payment{" +
                "id=" + id +
                ", userId=" + userId +
                ", packageId=" + packageId +
                ", paymentDate=" + paymentDate +
                ", amount=" + amount +
                ", paymentType='" + paymentType + '\'' +
                ", recurring=" + recurring +
                ", user=" + (user != null ? user.getName() : null) +
                ", gymPackage=" + (gymPackage != null ? gymPackage.getName() : null) +
                '}';
    }
}