package com.example.gymproject.model;

import java.text.SimpleDateFormat;

public class TrainerShift {
    private int id;
    private int trainerId;
    private int shiftId;
    private Trainer trainer;
    private Shift shift;

    // Default constructor
    public TrainerShift() {
    }

    // Constructor with IDs
    public TrainerShift(int trainerId, int shiftId) {
        this.trainerId = trainerId;
        this.shiftId = shiftId;
    }

    // Constructor with associated objects
    public TrainerShift(Trainer trainer, Shift shift) {
        this.trainer = trainer;
        this.shift = shift;
        this.trainerId = trainer.getId();
        this.shiftId = shift.getId();
    }

    // Getters and setters for all attributes

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getTrainerId() {
        return trainerId;
    }

    public void setTrainerId(int trainerId) {
        this.trainerId = trainerId;
    }

    public int getShiftId() {
        return shiftId;
    }

    public void setShiftId(int shiftId) {
        this.shiftId = shiftId;
    }

    public Trainer getTrainer() {
        return trainer;
    }

    public void setTrainer(Trainer trainer) {
        this.trainer = trainer;
        if (trainer != null) {
            this.trainerId = trainer.getId();
        }
    }

    public Shift getShift() {
        return shift;
    }

    public void setShift(Shift shift) {
        this.shift = shift;
        if (shift != null) {
            this.shiftId = shift.getId();
        }
    }

    @Override
    public String toString() {
        return "TrainerShift{" +
                "id=" + id +
                ", trainerId=" + trainerId +
                ", shiftId=" + shiftId +
                (trainer != null ? ", trainer=" + trainer.getName() : "") +
                (shift != null ? ", shift=" + shift.getName() + " (" + shift.getDayOfWeek() + " " + new SimpleDateFormat("HH:mm").format(shift.getStartTime()) + "-" + new SimpleDateFormat("HH:mm").format(shift.getEndTime()) + ")" : "") +
                '}';
    }

    // Optional: equals() and hashCode() methods
}