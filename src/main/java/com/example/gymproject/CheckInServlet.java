package com.example.gymproject;

import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/CheckInServlet")
public class CheckInServlet extends HttpServlet {
    
    private static final String DB_URL = "jdbc:mysql://localhost:3306/GymManagement?useSSL=false&&allowPublicKeyRetrieval=true";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "59908114";

    static {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String phone = request.getParameter("phone");
        String name = request.getParameter("name");
 
        
        // Set response type before any output
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            // Update user attendance status
            try (PreparedStatement pstmt = conn.prepareStatement(
                 "UPDATE users SET attendance = 'in' WHERE phone = ?")) {
                
                pstmt.setString(1, phone);
                int rowsUpdated = pstmt.executeUpdate();
                
                if (rowsUpdated > 0) {
                    // Record attendance in the attendance table
                    recordAttendance(conn, phone, "in");
                    
                    // Set success message in session
                    request.getSession().setAttribute("message", "Member checked in successfully");
                    request.getSession().setAttribute("messageType", "success");
                } else {
                    request.getSession().setAttribute("message", "No member found with phone: " + phone);
                    request.getSession().setAttribute("messageType", "error");
                }
            }
        } catch (SQLException e) {
            request.getSession().setAttribute("message", "Database error: " + e.getMessage());
            request.getSession().setAttribute("messageType", "error");
        }
        
        // Redirect back to member list
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
    
    private void recordAttendance(Connection conn, String phone, String status) throws SQLException {
        String query = "INSERT INTO attendance (phone, attendance_date, checked) VALUES (?, CURDATE(), ?)";
        
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, phone);
            pstmt.setString(2, status);
            pstmt.executeUpdate();
        }
    }
}