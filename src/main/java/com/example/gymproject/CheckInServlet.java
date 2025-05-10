package com.example.gymproject;

import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.time.LocalDate;

@WebServlet("/CheckInServlet")
public class CheckInServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/gym_management?useSSL=false&&allowPublicKeyRetrieval=true";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "12345";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Use com.mysql.cj.jdbc.Driver
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String phone = request.getParameter("phone");
        String name = request.getParameter("name");

        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            // Check if the member is already checked in today
            if (isAlreadyCheckedIn(conn, phone)) {
                request.getSession().setAttribute("message", "Member with phone " + phone + " is already checked in today.");
                request.getSession().setAttribute("messageType", "error");
            } else {
                // Record attendance in the attendance table
                if (recordCheckIn(conn, phone)) {
                    request.getSession().setAttribute("message", "Member " + name + " checked in successfully.");
                    request.getSession().setAttribute("messageType", "success");
                } else {
                    request.getSession().setAttribute("message", "Failed to record check-in for member with phone: " + phone);
                    request.getSession().setAttribute("messageType", "error");
                }
            }
        } catch (SQLException e) {
            System.out.println("Database error: " + e.getMessage());
            request.getSession().setAttribute("message", "Database error: " + e.getMessage());
            request.getSession().setAttribute("messageType", "error");
        }

        response.sendRedirect(request.getContextPath() + "/Attendance.jsp"); // Redirect to Attendance.jsp
    }

    private boolean isAlreadyCheckedIn(Connection conn, String phone) throws SQLException {
        String query = "SELECT id FROM attendance WHERE phone = ? AND attendance_date = CURDATE() AND check_out_time IS NULL";
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, phone);
            ResultSet rs = pstmt.executeQuery();
            return rs.next(); // Returns true if there's an active check-in for today
        }
    }

    private boolean recordCheckIn(Connection conn, String phone) throws SQLException {
        String query = "INSERT INTO attendance (phone, attendance_date, check_in_time) VALUES (?, CURDATE(), NOW())";
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, phone);
            int rowsInserted = pstmt.executeUpdate();
            return rowsInserted > 0;
        }
    }
}