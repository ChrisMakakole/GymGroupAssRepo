package com.example.gymproject;

import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;


@WebServlet(name = "Members_reg", urlPatterns = {"/Members_reg"})
public class Members_reg extends HttpServlet {
    
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
        
      
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        
        PrintWriter out = response.getWriter();
        
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(
                 "INSERT INTO users (name, email, phone, membership_start_date, membership_end_date) VALUES (?, ?, ?, ?, ?)")) {
            
            // Set parameters
            pstmt.setString(1, request.getParameter("name"));
            pstmt.setString(2, request.getParameter("email"));
            pstmt.setString(3, request.getParameter("phone"));
            
            // Handle dates
            pstmt.setDate(4, parseDate(request.getParameter("membership_start_date")));
            pstmt.setDate(5, parseDate(request.getParameter("membership_end_date")));
            
            int rows = pstmt.executeUpdate();
            
            if (rows > 0) {
                out.print("{\"status\":\"success\", \"message\":\"Member registered successfully\"}");
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"status\":\"error\", \"message\":\"No rows affected\"}");
            }
            
        } catch (SQLException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print(String.format("{\"status\":\"error\", \"message\":\"Database error: %s\"}", 
                e.getMessage().replace("\"", "'")));
        } finally {
            out.close();
        }
    }
    
    private Date parseDate(String dateString) {
        if (dateString == null || dateString.isEmpty()) {
            return null;
        }
        return Date.valueOf(dateString);
    }
}