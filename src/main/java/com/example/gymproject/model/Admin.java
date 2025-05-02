package com.example.gymproject.model;

public class Admin {
    private int id;
    private String username;
    private String password; // In a real application, this should only be stored as a hash

    // Default constructor
    public Admin() {
    }

    // Constructor with all fields
    public Admin(int id, String username, String password) {
        this.id = id;
        this.username = username;
        this.password = password;
    }

    // Constructor without ID (for adding new admins)
    public Admin(String username, String password) {
        this.username = username;
        this.password = password;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public String toString() {
        return "Admin{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", password='[PROTECTED]'" + // Don't print the actual password
                '}';
    }
}