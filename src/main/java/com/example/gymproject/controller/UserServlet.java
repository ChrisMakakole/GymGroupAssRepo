package com.example.gymproject.controller;

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
import java.util.ArrayList;
import java.util.List;

@WebServlet("/admin/users")
public class UserServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            User user = getUserById(id);
            request.setAttribute("user", user);
            request.getRequestDispatcher("/admin/edit_user.jsp").forward(request, response);
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            deleteUser(id);
            response.sendRedirect(request.getContextPath() + "/admin/users");
        } else {
            List<User> users = getAllUsers();
            request.setAttribute("users", users);
            request.getRequestDispatcher("/admin/manage_users.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            Date startDate = parseDate(request.getParameter("membershipStartDate"));
            Date endDate = parseDate(request.getParameter("membershipEndDate"));

            User newUser = new User(name, email, phone, startDate, endDate);
            addUser(newUser);
            response.sendRedirect(request.getContextPath() + "/admin/users");

        } else if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            Date startDate = parseDate(request.getParameter("membershipStartDate"));
            Date endDate = parseDate(request.getParameter("membershipEndDate"));

            User updatedUser = new User(id, name, email, phone, startDate, endDate);
            updateUser(updatedUser);
            response.sendRedirect(request.getContextPath() + "/admin/users");
        }
    }

    private Date parseDate(String dateString) {
        if (dateString != null && !dateString.isEmpty()) {
            try {
                return Date.valueOf(dateString);
            } catch (IllegalArgumentException e) {
                // Handle invalid date format if needed
                e.printStackTrace();
                return null;
            }
        }
        return null;
    }

    private List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM users";
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                User user = new User();
                user.setId(resultSet.getInt("id"));
                user.setName(resultSet.getString("name"));
                user.setEmail(resultSet.getString("email"));
                user.setPhone(resultSet.getString("phone"));
                user.setMembershipStartDate(resultSet.getDate("membership_start_date"));
                user.setMembershipEndDate(resultSet.getDate("membership_end_date"));
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

    private User getUserById(int id) {
        User user = null;
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM users WHERE id = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, id);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                user = new User();
                user.setId(resultSet.getInt("id"));
                user.setName(resultSet.getString("name"));
                user.setEmail(resultSet.getString("email"));
                user.setPhone(resultSet.getString("phone"));
                user.setMembershipStartDate(resultSet.getDate("membership_start_date"));
                user.setMembershipEndDate(resultSet.getDate("membership_end_date"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(resultSet);
            DatabaseConnection.close(preparedStatement);
            DatabaseConnection.close(connection);
        }
        return user;
    }

    private void addUser(User user) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = DatabaseConnection.getConnection();
            String sql = "INSERT INTO users (name, email, phone, membership_start_date, membership_end_date) VALUES (?, ?, ?, ?, ?)";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, user.getName());
            preparedStatement.setString(2, user.getEmail());
            preparedStatement.setString(3, user.getPhone());
            preparedStatement.setDate(4, (Date) user.getMembershipStartDate());
            preparedStatement.setDate(5, (Date) user.getMembershipEndDate());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(preparedStatement);
            DatabaseConnection.close(connection);
        }
    }

    private void updateUser(User user) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = DatabaseConnection.getConnection();
            String sql = "UPDATE users SET name = ?, email = ?, phone = ?, membership_start_date = ?, membership_end_date = ? WHERE id = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, user.getName());
            preparedStatement.setString(2, user.getEmail());
            preparedStatement.setString(3, user.getPhone());
            preparedStatement.setDate(4, (Date) user.getMembershipStartDate());
            preparedStatement.setDate(5, (Date) user.getMembershipEndDate());
            preparedStatement.setInt(6, user.getId());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(preparedStatement);
            DatabaseConnection.close(connection);
        }
    }

    private void deleteUser(int id) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = DatabaseConnection.getConnection();
            String sql = "DELETE FROM users WHERE id = ?";
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