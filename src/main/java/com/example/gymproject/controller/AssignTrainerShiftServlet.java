package com.example.gymproject.controller;

import com.example.gymproject.model.Trainer;
import com.example.gymproject.model.Shift;
import com.example.gymproject.model.TrainerShift;
import com.example.gymproject.util.DatabaseConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/admin/trainer_shifts")
public class AssignTrainerShiftServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("assign".equals(action)) {
            // Populate the lists of trainers and shifts
            List<Trainer> trainers = getAllTrainers();
            List<Shift> shifts = getAllShifts();
            request.setAttribute("trainers", trainers);
            request.setAttribute("shifts", shifts);
            request.getRequestDispatcher("/admin/assign_trainer_shift.jsp").forward(request, response);
        } else if ("delete".equals(action)) {
            int trainerId = Integer.parseInt(request.getParameter("trainerId"));
            int shiftId = Integer.parseInt(request.getParameter("shiftId"));
            deleteTrainerShift(trainerId, shiftId);
            response.sendRedirect(request.getContextPath() + "/admin/trainer_shifts");
        } else {
            List<TrainerShift> trainerShifts = getAllTrainerShifts();
            request.setAttribute("trainerShifts", trainerShifts);
            request.getRequestDispatcher("/admin/manage_trainer_shifts.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("assignTrainerShift".equals(action)) {
            int trainerId = Integer.parseInt(request.getParameter("trainerId"));
            int shiftId = Integer.parseInt(request.getParameter("shiftId"));

            TrainerShift trainerShift = new TrainerShift(trainerId, shiftId);
            assignTrainerToShift(trainerShift);
            response.sendRedirect(request.getContextPath() + "/admin/trainer_shifts");
        } else if ("delete".equals(action)) {
            int trainerId = Integer.parseInt(request.getParameter("trainerId"));
            int shiftId = Integer.parseInt(request.getParameter("shiftId"));
            deleteTrainerShift(trainerId, shiftId);
            response.sendRedirect(request.getContextPath() + "/admin/trainer_shifts");
        }
    }

    private void assignTrainerToShift(TrainerShift trainerShift) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = DatabaseConnection.getConnection();
            String sql = "INSERT INTO trainer_shifts (trainer_id, shift_id) VALUES (?, ?)";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, trainerShift.getTrainerId());
            preparedStatement.setInt(2, trainerShift.getShiftId());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(preparedStatement);
            DatabaseConnection.close(connection);
        }
    }

    private List<TrainerShift> getAllTrainerShifts() {
        List<TrainerShift> trainerShifts = new ArrayList<>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnection.getConnection();
            // Corrected SQL: Select trainer name,
            String sql = "SELECT ts.trainer_id, ts.shift_id, t.name as trainer_name, s.name as shift_name, s.day_of_week, s.start_time, s.end_time " +
                    "FROM trainer_shifts ts " +
                    "JOIN trainers t ON ts.trainer_id = t.id " +
                    "JOIN shifts s ON ts.shift_id = s.id";
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                TrainerShift ts = new TrainerShift();
                ts.setTrainerId(resultSet.getInt("trainer_id"));
                ts.setShiftId(resultSet.getInt("shift_id"));

                // Create Trainer and Shift objects and set their attributes
                Trainer trainer = new Trainer();
                trainer.setId(resultSet.getInt("trainer_id"));
                trainer.setName(resultSet.getString("trainer_name"));
                ts.setTrainer(trainer);

                Shift shift = new Shift();
                shift.setId(resultSet.getInt("shift_id"));
                shift.setName(resultSet.getString("shift_name"));
                shift.setDayOfWeek(resultSet.getString("day_of_week"));
                shift.setStartTime(resultSet.getTime("start_time"));
                shift.setEndTime(resultSet.getTime("end_time"));
                ts.setShift(shift);

                trainerShifts.add(ts);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(resultSet);
            DatabaseConnection.close(preparedStatement);
            DatabaseConnection.close(connection);
        }
        return trainerShifts;
    }

    private void deleteTrainerShift(int trainerId, int shiftId) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = DatabaseConnection.getConnection();
            String sql = "DELETE FROM trainer_shifts WHERE trainer_id = ? AND shift_id = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, trainerId);
            preparedStatement.setInt(2, shiftId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(preparedStatement);
            DatabaseConnection.close(connection);
        }
    }

    private List<Trainer> getAllTrainers() {
        List<Trainer> trainers = new ArrayList<>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnection.getConnection();
            String sql = "SELECT id, name, phone, email, training_type, registration_date FROM trainers";
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Trainer trainer = new Trainer();
                trainer.setId(resultSet.getInt("id"));
                trainer.setName(resultSet.getString("name"));
                trainer.setPhone(resultSet.getString("phone"));
                trainer.setEmail(resultSet.getString("email"));
                trainer.setTrainingType(resultSet.getString("training_type"));
                trainer.setRegistrationDate(resultSet.getDate("registration_date"));
                trainers.add(trainer);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(resultSet);
            DatabaseConnection.close(preparedStatement);
            DatabaseConnection.close(connection);
        }
        return trainers;
    }

    private List<Shift> getAllShifts() {
        List<Shift> shifts = new ArrayList<>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnection.getConnection();
            String sql = "SELECT id, name, day_of_week, start_time, end_time FROM shifts";
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Shift shift = new Shift();
                shift.setId(resultSet.getInt("id"));
                shift.setName(resultSet.getString("name"));
                shift.setDayOfWeek(resultSet.getString("day_of_week"));
                shift.setStartTime(resultSet.getTime("start_time"));
                shift.setEndTime(resultSet.getTime("end_time"));
                shifts.add(shift);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(resultSet);
            DatabaseConnection.close(preparedStatement);
            DatabaseConnection.close(connection);
        }
        return shifts;
    }
}

