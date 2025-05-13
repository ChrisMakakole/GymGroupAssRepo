package com.example.gymproject.controller;

import com.example.gymproject.model.Attendance;
import com.example.gymproject.model.User;
import com.example.gymproject.util.DatabaseConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/admin/attendance")
public class AttendanceServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("mark".equals(action)) {
            List<User> users = getAllUsers();
            request.setAttribute("users", users);
            request.getRequestDispatcher("/admin/mark_attendance.jsp").forward(request, response);
        } else if ("view".equals(action)) {
            List<Attendance> attendanceRecords = getAllAttendance();
            request.setAttribute("attendanceRecords", attendanceRecords);
            request.getRequestDispatcher("/admin/view_attendance.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/attendance?action=view"); // Default to viewing attendance
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("checkIn".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            Date attendanceDate = new Date(System.currentTimeMillis()); // Today's date
            Timestamp checkInTime = new Timestamp(System.currentTimeMillis());

            Attendance attendance = new Attendance(0, userId, attendanceDate, checkInTime, null);
            markCheckIn(attendance);
            response.sendRedirect(request.getContextPath() + "/admin/attendance?action=view");

        } else if ("checkOut".equals(action)) {
            int attendanceId = Integer.parseInt(request.getParameter("attendanceId"));
            Timestamp checkOutTime = new Timestamp(System.currentTimeMillis());
            markCheckOut(attendanceId, checkOutTime);
            response.sendRedirect(request.getContextPath() + "/admin/attendance?action=view");
        }
    }

    private void markCheckIn(Attendance attendance) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = DatabaseConnection.getConnection();
            String sql = "INSERT INTO attendance (phone, attendance_date, check_in_time) VALUES (?, ?, ?)";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, attendance.getUserId());  //still using userId in attendance object.
            preparedStatement.setDate(2, attendance.getAttendanceDate());
            preparedStatement.setTimestamp(3, attendance.getCheckInTime());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(preparedStatement);
            DatabaseConnection.close(connection);
        }
    }

    private void markCheckOut(int attendanceId, Timestamp checkOutTime) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = DatabaseConnection.getConnection();
            String sql = "UPDATE attendance SET check_out_time = ? WHERE id = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setTimestamp(1, checkOutTime);
            preparedStatement.setInt(2, attendanceId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(preparedStatement);
            DatabaseConnection.close(connection);
        }
    }

    private List<Attendance> getAllAttendance() {
        List<Attendance> attendanceRecords = new ArrayList<>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnection.getConnection();
            // Corrected SQL: Join on a.phone = u.phone
            String sql = "SELECT a.*, u.name AS user_name FROM attendance a JOIN users u ON a.phone = u.phone ORDER BY a.attendance_date DESC, a.check_in_time DESC";
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Attendance attendance = new Attendance();
                attendance.setId(resultSet.getInt("id"));
                attendance.setUserId(resultSet.getInt("phone")); //changed to phone
                attendance.setAttendanceDate(resultSet.getDate("attendance_date"));
                attendance.setCheckInTime(resultSet.getTimestamp("check_in_time"));
                attendance.setCheckOutTime(resultSet.getTimestamp("check_out_time"));

                User user = new User();
                user.setName(resultSet.getString("user_name"));
                attendance.setUser(user);

                attendanceRecords.add(attendance);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(resultSet);
            DatabaseConnection.close(preparedStatement);
            DatabaseConnection.close(connection);
        }
        return attendanceRecords;
    }

    private List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnection.getConnection();
            String sql = "SELECT id, name FROM users ORDER BY name";
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                User user = new User();
                user.setId(resultSet.getInt("id"));
                user.setName(resultSet.getString("name"));
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(resultSet);
            DatabaseConnection.close(preparedStatement);
            DatabaseConnection.close(connection);
        }
        return users;
    }
}

