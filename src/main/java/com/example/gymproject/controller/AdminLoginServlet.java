package com.example.gymproject.controller;

import com.example.gymproject.util.DatabaseConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.*;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try (Connection conn = DatabaseConnection.getConnection()) {
            String query = "SELECT * FROM admins WHERE username = ? AND password = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, password); // NOTE: use hashing in real apps

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Valid login
                HttpSession session = request.getSession();
                session.setAttribute("admin", username);
                response.sendRedirect("admin/dashboard.jsp");
            } else {
                // Invalid login
                response.sendRedirect("admin/login.jsp?error=invalid");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Database connection error: " + e.getMessage());
        }
    }
}
