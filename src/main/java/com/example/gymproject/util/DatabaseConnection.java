package com.example.gymproject.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DatabaseConnection {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/gym_management?useSSL=false&allowPublicKeyRetrieval=true";
    private static final String DB_USER = "root"; // Replace with your database username
    private static final String DB_PASSWORD = "12345"; // Replace with your database password

    public static Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // For MySQL Connector/J 8.0+
            connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            System.out.println("Database connection established successfully.");
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL JDBC Driver not found: " + e.getMessage());
        } catch (SQLException e) {
            System.err.println("Failed to connect to the database: " + e.getMessage());
        }
        return connection;
    }

    public static void close(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
                System.out.println("Database connection closed.");
            } catch (SQLException e) {
                System.err.println("Error closing the connection: " + e.getMessage());
            }
        }
    }

    public static void close(Statement statement) {
        if (statement != null) {
            try {
                statement.close();
            } catch (SQLException e) {
                System.err.println("Error closing the statement: " + e.getMessage());
            }
        }
    }

    public static void close(ResultSet resultSet) {
        if (resultSet != null) {
            try {
                resultSet.close();
            } catch (SQLException e) {
                System.err.println("Error closing the result set: " + e.getMessage());
            }
        }
    }

    // Convenience method to close all resources
    public static void close(ResultSet resultSet, Statement statement, Connection connection) {
        close(resultSet);
        close(statement);
        close(connection);
    }

    public static void main(String[] args) {
        // Simple test to check if the connection is successful
        Connection conn = DatabaseConnection.getConnection();
        if (conn != null) {
            DatabaseConnection.close(conn);
        }
    }
}