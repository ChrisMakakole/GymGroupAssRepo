package com.example.gymproject;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/AddTrainers")
public class AddTrainers extends HttpServlet {
    
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
        
        // Get form parameters
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String trainingType = request.getParameter("trainingType");
        String registrationDateStr = request.getParameter("membership_start_date");
        
        // Set response type
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        // Validate required fields
        if (name == null || name.trim().isEmpty() || phone == null || phone.trim().isEmpty()) {
            sendErrorResponse(out, "Name and Phone are required fields");
            return;
        }
        
        // Parse registration date (use current date if not provided)
        Date registrationDate = null;
        try {
            if (registrationDateStr != null && !registrationDateStr.trim().isEmpty()) {
                registrationDate = new SimpleDateFormat("yyyy-MM-dd").parse(registrationDateStr);
            } else {
                registrationDate = new Date(); // current date
            }
        } catch (Exception e) {
            sendErrorResponse(out, "Invalid date format");
            return;
        }
        
        // Insert into database
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "INSERT INTO Trainers (name, phone, email, training_type, registration_date) VALUES (?, ?, ?, ?, ?)";
            
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, name);
                pstmt.setString(2, phone);
                pstmt.setString(3, email);
                pstmt.setString(4, trainingType);
                pstmt.setDate(5, new java.sql.Date(registrationDate.getTime()));
                
                int rowsInserted = pstmt.executeUpdate();
                
                if (rowsInserted > 0) {
                    // Success - redirect to a success page or show message
                    request.setAttribute("successMessage", "Trainer registered successfully!");
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                } else {
                    sendErrorResponse(out, "Failed to register trainer");
                }
            }
        } catch (SQLException e) {
            sendErrorResponse(out, "Database error: " + e.getMessage());
        }
    }
    
    private void sendErrorResponse(PrintWriter out, String message) {
        out.println("<html><body>");
        out.println("<div class='error'>" + message + "</div>");
        out.println("<a href='index.jsp'>Go back</a>");
        out.println("</body></html>");
    }
}