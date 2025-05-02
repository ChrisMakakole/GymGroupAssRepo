package com.example.gymproject.controller;

import com.example.gymproject.model.Shift;
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
import java.sql.Time;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/admin/shifts")
public class ShiftServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Shift shift = getShiftById(id);
            request.setAttribute("shift", shift);
            request.getRequestDispatcher("/admin/edit_shift.jsp").forward(request, response);
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            deleteShift(id);
            response.sendRedirect(request.getContextPath() + "/admin/shifts");
        } else {
            List<Shift> shifts = getAllShifts();
            request.setAttribute("shifts", shifts);
            request.getRequestDispatcher("/admin/manage_shifts.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            String name = request.getParameter("name");
            Time startTime = parseTime(request.getParameter("startTime"));
            Time endTime = parseTime(request.getParameter("endTime"));
            String dayOfWeek = request.getParameter("dayOfWeek");

            Shift newShift = new Shift(name, startTime, endTime, dayOfWeek);
            addShift(newShift);
            response.sendRedirect(request.getContextPath() + "/admin/shifts");

        } else if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            Time startTime = parseTime(request.getParameter("startTime"));
            Time endTime = parseTime(request.getParameter("endTime"));
            String dayOfWeek = request.getParameter("dayOfWeek");

            Shift updatedShift = new Shift(id, name, startTime, endTime, dayOfWeek);
            updateShift(updatedShift);
            response.sendRedirect(request.getContextPath() + "/admin/shifts");
        }
    }

    private Time parseTime(String timeString) {
        if (timeString != null && !timeString.isEmpty()) {
            try {
                return Time.valueOf(timeString + ":00"); // Ensure seconds are included
            } catch (IllegalArgumentException e) {
                e.printStackTrace();
                return null;
            }
        }
        return null;
    }

    private List<Shift> getAllShifts() {
        List<Shift> shifts = new ArrayList<>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM shifts ORDER BY day_of_week, start_time";
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Shift shift = new Shift();
                shift.setId(resultSet.getInt("id")); // Corrected line
                shift.setName(resultSet.getString("name"));
                shift.setStartTime(resultSet.getTime("start_time"));
                shift.setEndTime(resultSet.getTime("end_time"));
                shift.setDayOfWeek(resultSet.getString("day_of_week"));
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

    private Shift getShiftById(int id) {
        Shift shift = null;
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM shifts WHERE id = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, id);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                shift = new Shift();
                shift.setId(resultSet.getInt("id"));
                shift.setName(resultSet.getString("name"));
                shift.setStartTime(resultSet.getTime("start_time"));
                shift.setEndTime(resultSet.getTime("end_time"));
                shift.setDayOfWeek(resultSet.getString("day_of_week"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(resultSet);
            DatabaseConnection.close(preparedStatement);
            DatabaseConnection.close(connection);
        }
        return shift;
    }

    private void addShift(Shift shift) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = DatabaseConnection.getConnection();
            String sql = "INSERT INTO shifts (name, start_time, end_time, day_of_week) VALUES (?, ?, ?, ?)";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, shift.getName());
            preparedStatement.setTime(2, shift.getStartTime());
            preparedStatement.setTime(3, shift.getEndTime());
            preparedStatement.setString(4, shift.getDayOfWeek());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(preparedStatement);
            DatabaseConnection.close(connection);
        }
    }

    private void updateShift(Shift shift) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = DatabaseConnection.getConnection();
            String sql = "UPDATE shifts SET name = ?, start_time = ?, end_time = ?, day_of_week = ? WHERE id = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, shift.getName());
            preparedStatement.setTime(2, shift.getStartTime());
            preparedStatement.setTime(3, shift.getEndTime());
            preparedStatement.setString(4, shift.getDayOfWeek());
            preparedStatement.setInt(5, shift.getId());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(preparedStatement);
            DatabaseConnection.close(connection);
        }
    }

    private void deleteShift(int id) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = DatabaseConnection.getConnection();
            String sql = "DELETE FROM shifts WHERE id = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(preparedStatement);
            DatabaseConnection.close(connection);
        }
    }
}