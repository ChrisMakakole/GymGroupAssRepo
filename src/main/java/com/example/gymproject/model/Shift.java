package com.example.gymproject.model;

import java.sql.Time;

public class Shift {
    private int id;
    private String name;
    private Time startTime;
    private Time endTime;
    private String dayOfWeek;

    // Default constructor
    public Shift() {
    }

    // Constructor with all fields
    public Shift(int id, String name, Time startTime, Time endTime, String dayOfWeek) {
        this.id = id;
        this.name = name;
        this.startTime = startTime;
        this.endTime = endTime;
        this.dayOfWeek = dayOfWeek;
    }

    // Constructor without ID (for adding new shifts)
    public Shift(String name, Time startTime, Time endTime, String dayOfWeek) {
        this.name = name;
        this.startTime = startTime;
        this.endTime = endTime;
        this.dayOfWeek = dayOfWeek;
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

    public Time getStartTime() {
        return startTime;
    }

    public void setStartTime(Time startTime) {
        this.startTime = startTime;
    }

    public Time getEndTime() {
        return endTime;
    }

    public void setEndTime(Time endTime) {
        this.endTime = endTime;
    }

    public String getDayOfWeek() {
        return dayOfWeek;
    }

    public void setDayOfWeek(String dayOfWeek) {
        this.dayOfWeek = dayOfWeek;
    }

    @Override
    public String toString() {
        return "Shift{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", startTime=" + startTime +
                ", endTime=" + endTime +
                ", dayOfWeek='" + dayOfWeek + '\'' +
                '}';
    }
}