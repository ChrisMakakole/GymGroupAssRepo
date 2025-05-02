package com.example.gymproject.model;

import java.sql.Date;
import java.sql.Timestamp;

public class Attendance {
    private int id;
    private int userId;
    private Date attendanceDate;
    private Timestamp checkInTime;
    private Timestamp checkOutTime;

    // Optional: To hold the related User object for easier access
    private User user;

    // Default constructor
    public Attendance() {
    }

    // Constructor with all fields
    public Attendance(int id, int userId, Date attendanceDate, Timestamp checkInTime, Timestamp checkOutTime) {
        this.id = id;
        this.userId = userId;
        this.attendanceDate = attendanceDate;
        this.checkInTime = checkInTime;
        this.checkOutTime = checkOutTime;
    }

    // Constructor without ID (for new check-ins)
    public Attendance(int userId, Date attendanceDate, Timestamp checkInTime, Timestamp checkOutTime) {
        this.userId = userId;
        this.attendanceDate = attendanceDate;
        this.checkInTime = checkInTime;
        this.checkOutTime = checkOutTime;
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

    public Date getAttendanceDate() {
        return attendanceDate;
    }

    public void setAttendanceDate(Date attendanceDate) {
        this.attendanceDate = attendanceDate;
    }

    public Timestamp getCheckInTime() {
        return checkInTime;
    }

    public void setCheckInTime(Timestamp checkInTime) {
        this.checkInTime = checkInTime;
    }

    public Timestamp getCheckOutTime() {
        return checkOutTime;
    }

    public void setCheckOutTime(Timestamp checkOutTime) {
        this.checkOutTime = checkOutTime;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Override
    public String toString() {
        return "Attendance{" +
                "id=" + id +
                ", userId=" + userId +
                ", attendanceDate=" + attendanceDate +
                ", checkInTime=" + checkInTime +
                ", checkOutTime=" + checkOutTime +
                ", user=" + (user != null ? user.getName() : null) +
                '}';
    }
}