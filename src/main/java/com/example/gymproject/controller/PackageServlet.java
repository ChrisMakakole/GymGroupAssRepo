package com.example.gymproject.controller;

import com.example.gymproject.model.Package;
import com.example.gymproject.util.DatabaseConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/admin/packages")
public class PackageServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Package pkg = getPackageById(id);
            request.setAttribute("package", pkg);
            request.getRequestDispatcher("/admin/edit_package.jsp").forward(request, response);
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            deletePackage(id);
            response.sendRedirect(request.getContextPath() + "/admin/packages");
        } else {
            List<Package> packages = getAllPackages();
            request.setAttribute("packages", packages);
            request.getRequestDispatcher("/admin/manage_packages.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            int durationDays = Integer.parseInt(request.getParameter("duration"));

            Package newPackage = new Package(0, name, description, price, durationDays);
            addPackage(newPackage);
            response.sendRedirect(request.getContextPath() + "/admin/packages");

        } else if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            int durationDays = Integer.parseInt(request.getParameter("duration"));

            Package updatedPackage = new Package(id, name, description, price, durationDays);
            updatePackage(updatedPackage);
            response.sendRedirect(request.getContextPath() + "/admin/packages");
        }
    }

    private List<Package> getAllPackages() {
        List<Package> packages = new ArrayList<>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM packages";
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Package pkg = new Package();
                pkg.setId(resultSet.getInt("id"));
                pkg.setName(resultSet.getString("name"));
                pkg.setDescription(resultSet.getString("description"));
                pkg.setPrice(resultSet.getDouble("price"));
                pkg.setDurationDays(resultSet.getInt("duration_days"));
                packages.add(pkg);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(resultSet);
            DatabaseConnection.close(preparedStatement);
            DatabaseConnection.close(connection);
        }
        return packages;
    }

    private Package getPackageById(int id) {
        Package pkg = null;
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM packages WHERE id = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, id);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                pkg = new Package();
                pkg.setId(resultSet.getInt("id"));
                pkg.setName(resultSet.getString("name"));
                pkg.setDescription(resultSet.getString("description"));
                pkg.setPrice(resultSet.getDouble("price"));
                pkg.setDurationDays(resultSet.getInt("duration_days"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(resultSet);
            DatabaseConnection.close(preparedStatement);
            DatabaseConnection.close(connection);
        }
        return pkg;
    }

    private void addPackage(Package pkg) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = DatabaseConnection.getConnection();
            String sql = "INSERT INTO packages (name, description, price, duration_days) VALUES (?, ?, ?, ?)";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, pkg.getName());
            preparedStatement.setString(2, pkg.getDescription());
            preparedStatement.setDouble(3, pkg.getPrice());
            preparedStatement.setInt(4, pkg.getDurationDays());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(preparedStatement);
            DatabaseConnection.close(connection);
        }
    }

    private void updatePackage(Package pkg) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = DatabaseConnection.getConnection();
            String sql = "UPDATE packages SET name = ?, description = ?, price = ?, duration_days = ? WHERE id = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, pkg.getName());
            preparedStatement.setString(2, pkg.getDescription());
            preparedStatement.setDouble(3, pkg.getPrice());
            preparedStatement.setInt(4, pkg.getDurationDays());
            preparedStatement.setInt(5, pkg.getId());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(preparedStatement);
            DatabaseConnection.close(connection);
        }
    }

    private void deletePackage(int id) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = DatabaseConnection.getConnection();
            String sql = "DELETE FROM packages WHERE id = ?";
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