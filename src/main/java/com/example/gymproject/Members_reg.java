package com.example.gymproject;

import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "Members_reg", urlPatterns = {"/Members_reg"})
public class Members_reg extends HttpServlet {
    
    private static final String DB_URL = "jdbc:mysql://localhost:3306/gym_management?useSSL=false&&allowPublicKeyRetrieval=true";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "12345";

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
        
        // Set response type before getting writer
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(
                 "INSERT INTO users (name, email, phone, membership_start_date, membership_end_date, attendance) VALUES (?, ?, ?, ?, ?, ?)")) {
            
            // Set parameters
            pstmt.setString(1, request.getParameter("name"));
            pstmt.setString(2, request.getParameter("email"));
            pstmt.setString(3, request.getParameter("phone"));
            
            // Handle dates
            pstmt.setDate(4, parseDate(request.getParameter("membership_start_date")));
            pstmt.setDate(5, parseDate(request.getParameter("membership_end_date")));
            pstmt.setString(6, "out");
            
            int rows = pstmt.executeUpdate();
            
            if (rows > 0) {
                // Set success message in session
                request.getSession().setAttribute("message", "Member registered successfully");
                request.getSession().setAttribute("messageType", "success");
            } else {
                request.getSession().setAttribute("message", "Failed to register member");
                request.getSession().setAttribute("messageType", "error");
            }
            
        } catch (SQLException e) {
            request.getSession().setAttribute("message", "Database error: " + e.getMessage());
            request.getSession().setAttribute("messageType", "error");
        }
        
        // Redirect to index.jsp
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
    
    private Date parseDate(String dateString) {
        if (dateString == null || dateString.isEmpty()) {
            return null;
        }
        return Date.valueOf(dateString);
    }
}