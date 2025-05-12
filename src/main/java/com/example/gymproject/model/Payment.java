package com.example.gymproject.model;

import java.sql.Timestamp;

public class Payment {
    private int paymentId; // Changed from id to paymentId to match DB
    private String userName; // Changed from userId and now stores name directly
    private String packageName; // Changed from packageId and now stores name directly
    private double packagePrice; // Added to store package price
    private Timestamp paymentDate;
    private double amount;
    private String paymentMethod;
    private String cardNumber;
    private String cardExpiry;
    private String cardholderName;
    private String cardCvv;
    private String paymentType;
    private boolean recurring;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Default constructor
    public Payment() {
    }

    // Constructor for recording new payments
    public Payment(String userName, String packageName, double packagePrice, Timestamp paymentDate, double amount, String paymentMethod, String cardNumber, String cardExpiry, String cardholderName, String cardCvv, String paymentType, boolean recurring) {
        this.userName = userName;
        this.packageName = packageName;
        this.packagePrice = packagePrice;
        this.paymentDate = paymentDate;
        this.amount = amount;
        this.paymentMethod = paymentMethod;
        this.cardNumber = cardNumber;
        this.cardExpiry = cardExpiry;
        this.cardholderName = cardholderName;
        this.cardCvv = cardCvv;
        this.paymentType = paymentType;
        this.recurring = recurring;
    }

    // Getters and Setters

    public int getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPackageName() {
        return packageName;
    }

    public void setPackageName(String packageName) {
        this.packageName = packageName;
    }

    public double getPackagePrice() {
        return packagePrice;
    }

    public void setPackagePrice(double packagePrice) {
        this.packagePrice = packagePrice;
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

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getCardNumber() {
        return cardNumber;
    }

    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }

    public String getCardExpiry() {
        return cardExpiry;
    }

    public void setCardExpiry(String cardExpiry) {
        this.cardExpiry = cardExpiry;
    }

    public String getCardholderName() {
        return cardholderName;
    }

    public void setCardholderName(String cardholderName) {
        this.cardholderName = cardholderName;}

    public String getCardCvv() {
        return cardCvv;
    }

    public void setCardCvv(String cardCvv) {
        this.cardCvv = cardCvv;
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

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    @Override
    public String toString() {
        return "Payment{" +
                "paymentId=" + paymentId +
                ", userName='" + userName + '\'' +
                ", packageName='" + packageName + '\'' +
                ", packagePrice=" + packagePrice +
                ", paymentDate=" + paymentDate +
                ", amount=" + amount +
                ", paymentMethod='" + paymentMethod + '\'' +
                ", cardNumber='" + cardNumber + '\'' +
                ", cardExpiry='" + cardExpiry + '\'' +
                ", cardholderName='" + cardholderName + '\'' +
                ", cardCvv='" + cardCvv + '\'' +
                ", paymentType='" + paymentType + '\'' +
                ", recurring=" + recurring +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                '}';
    }
}