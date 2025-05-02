package com.example.gymproject.controller;

import com.example.gymproject.model.Trainer;
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

@WebServlet("/admin/trainers")
public class TrainerServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Trainer trainer = getTrainerById(id);
            request.setAttribute("trainer", trainer);
            request.getRequestDispatcher("/admin/edit_trainer.jsp").forward(request, response);
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            deleteTrainer(id);
            response.sendRedirect(request.getContextPath() + "/admin/trainers");
        } else {
            List<Trainer> trainers = getAllTrainers();
            request.setAttribute("trainers", trainers);
            request.getRequestDispatcher("/admin/manage_trainers.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            String name = request.getParameter("name");
            String specialization = request.getParameter("specialization");

            Trainer newTrainer = new Trainer(name, specialization);
            addTrainer(newTrainer);
            response.sendRedirect(request.getContextPath() + "/admin/trainers");

        } else if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String specialization = request.getParameter("specialization");

            Trainer updatedTrainer = new Trainer(id, name, specialization);
            updateTrainer(updatedTrainer);
            response.sendRedirect(request.getContextPath() + "/admin/trainers");
        }
    }

    private List<Trainer> getAllTrainers() {
        List<Trainer> trainers = new ArrayList<>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM trainers";
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Trainer trainer = new Trainer();
                trainer.setId(resultSet.getInt("id"));
                trainer.setName(resultSet.getString("name"));
                trainer.setSpecialization(resultSet.getString("specialization"));
                trainers.add(trainer);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(resultSet);
            DatabaseConnection.close(preparedStatement);
            DatabaseConnection.close(connection);
        }
        return trainers;
    }

    private Trainer getTrainerById(int id) {
        Trainer trainer = null;
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM trainers WHERE id = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, id);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                trainer = new Trainer();
                trainer.setId(resultSet.getInt("id"));
                trainer.setName(resultSet.getString("name"));
                trainer.setSpecialization(resultSet.getString("specialization"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(resultSet);
            DatabaseConnection.close(preparedStatement);
            DatabaseConnection.close(connection);
        }
        return trainer;
    }

    private void addTrainer(Trainer trainer) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = DatabaseConnection.getConnection();
            String sql = "INSERT INTO trainers (name, specialization) VALUES (?, ?)";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, trainer.getName());
            preparedStatement.setString(2, trainer.getSpecialization());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(preparedStatement);
            DatabaseConnection.close(connection);
        }
    }

    private void updateTrainer(Trainer trainer) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = DatabaseConnection.getConnection();
            String sql = "UPDATE trainers SET name = ?, specialization = ? WHERE id = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, trainer.getName());
            preparedStatement.setString(2, trainer.getSpecialization());
            preparedStatement.setInt(3, trainer.getId());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(preparedStatement);
            DatabaseConnection.close(connection);
        }
    }

    private void deleteTrainer(int id) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = DatabaseConnection.getConnection();
            String sql = "DELETE FROM trainers WHERE id = ?";
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