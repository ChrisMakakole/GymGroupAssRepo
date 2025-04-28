package com.example.gymproject;

import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "CheckInOutServlet", urlPatterns = {"/CheckInOutServlet"})
public class CheckInOutServlet extends HttpServlet {
    
    private static final String DB_URL = "jdbc:mysql://localhost:3306/GymManagement?useSSL=false";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "59908114";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String phone = request.getParameter("phone");

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try (PrintWriter out = response.getWriter()) {
            if (action == null || phone == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"status\":\"error\", \"message\":\"Missing action or phone parameter\"}");
                return;
            }

            String attendanceStatus = "out".equalsIgnoreCase(action) ? "out" : "in";

            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String sql = "UPDATE users SET attendance = ? WHERE phone = ?";
                try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    pstmt.setString(1, attendanceStatus);
                    pstmt.setString(2, phone);
                    
                    int rowsUpdated = pstmt.executeUpdate();
                    if (rowsUpdated > 0) {
                        out.print("{\"status\":\"success\", \"message\":\"Attendance updated\", \"newStatus\":\"" + 
                                attendanceStatus + "\"}");
                    } else {
                        response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                        out.print("{\"status\":\"error\", \"message\":\"Phone number not found\"}");
                    }
                }
            } catch (SQLException e) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                out.print(String.format("{\"status\":\"error\", \"message\":\"Database error: %s\"}", 
                    e.getMessage().replace("\"", "'")));
            }
        }
    }
}