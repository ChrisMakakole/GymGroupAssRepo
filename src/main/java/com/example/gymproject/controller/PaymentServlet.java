package com.example.gymproject.controller;

import com.example.gymproject.model.Package;
import com.example.gymproject.model.Payment;
import com.example.gymproject.model.User;
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
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

@WebServlet("/admin/payments")
public class PaymentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private Timer autoPayTimer;
    private boolean autoPayStarted = false;

    @Override
    public void init() throws ServletException {
        super.init();
        if (!autoPayStarted) {
            autoPayTimer = new Timer();
            autoPayTimer.schedule(new TimerTask() {
                @Override
                public void run() {
                    processAutoPayment();
                }
            }, 0, 60 * 1000); // Run every 1 minute

            autoPayStarted = true;
        }
    }

    @Override
    public void destroy() {
        if (autoPayTimer != null) {
            autoPayTimer.cancel();
        }
        super.destroy();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("view".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Payment payment = getPaymentById(id);
            request.setAttribute("payment", payment);
            request.getRequestDispatcher("/admin/view_payments.jsp").forward(request, response);
        } else if ("record".equals(action)) {
            List<User> users = getAllUsers();
            List<Package> packages = getAllPackages();
            request.setAttribute("users", users);
            request.setAttribute("packages", packages);
            request.getRequestDispatcher("/admin/record_payment.jsp").forward(request, response);
        } else {
            List<Payment> payments = getAllPayments();
            request.setAttribute("payments", payments);
            request.getRequestDispatcher("/admin/manage_payments.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("recordPayment".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            int packageId = Integer.parseInt(request.getParameter("packageId"));
            double amount = Double.parseDouble(request.getParameter("amount"));
            String paymentType = request.getParameter("paymentType");
            //String foreverSubscriptionParam = request.getParameter("recurring");
            boolean isForeverSubscription = Boolean.parseBoolean(request.getParameter("recurring"));

            Payment newPayment = new Payment(0, userId, packageId, new Timestamp(System.currentTimeMillis()), amount, paymentType, isForeverSubscription);
            recordPayment(newPayment);
            response.sendRedirect(request.getContextPath() + "/admin/payments");
        }
        // You might add logic for updating or deleting payments here if needed
    }

    private void processAutoPayment() {
        System.out.println("Checking for 'forever' recurring payments...");
        List<Payment> foreverPayments = getForeverRecurringPayments();

        for (Payment payment : foreverPayments) {
            System.out.println("Simulating automatic payment for user " + payment.getUserId() + " (forever recurring)");
            Payment newPayment = new Payment(0, payment.getUserId(), payment.getPackageId(),
                    new Timestamp(System.currentTimeMillis()), payment.getAmount(),
                    "Automatic Recurring (Simulated)", true); // 'recurring' is now our 'forever' flag
            recordPayment(newPayment);
            System.out.println("Simulated automatic payment recorded.");
        }
    }

    private List<Payment> getForeverRecurringPayments() {
        List<Payment> foreverPayments = new ArrayList<>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM payments WHERE recurring = TRUE";
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Payment payment = new Payment();
                payment.setId(resultSet.getInt("id"));
                payment.setUserId(resultSet.getInt("user_id"));
                payment.setPackageId(resultSet.getInt("package_id"));
                payment.setPaymentDate(resultSet.getTimestamp("payment_date"));
                payment.setAmount(resultSet.getDouble("amount"));
                payment.setPaymentType(resultSet.getString("payment_type"));
                payment.setRecurring(resultSet.getBoolean("recurring"));
                foreverPayments.add(payment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(resultSet);
            DatabaseConnection.close(preparedStatement);
            DatabaseConnection.close(connection);
        }
        return foreverPayments;
    }

    private List<Payment> getAllPayments() {
        List<Payment> payments = new ArrayList<>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnection.getConnection();
            String sql = "SELECT p.*, u.name AS user_name, pkg.name AS package_name " +
                    "FROM payments p " +
                    "JOIN users u ON p.user_id = u.id " +
                    "JOIN packages pkg ON p.package_id = pkg.id";
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Payment payment = new Payment();
                payment.setId(resultSet.getInt("id"));
                payment.setUserId(resultSet.getInt("user_id"));
                payment.setPackageId(resultSet.getInt("package_id"));
                payment.setPaymentDate(resultSet.getTimestamp("payment_date"));
                payment.setAmount(resultSet.getDouble("amount"));
                payment.setPaymentType(resultSet.getString("payment_type"));
                payment.setRecurring(resultSet.getBoolean("recurring")); // Using 'recurring' as 'forever'

                User user = new User();
                user.setName(resultSet.getString("user_name"));
                payment.setUser(user);
                Package pkg = new Package();
                pkg.setName(resultSet.getString("package_name"));
                payment.setPackage(pkg);

                payments.add(payment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(resultSet);
            DatabaseConnection.close(preparedStatement);
            DatabaseConnection.close(connection);
        }
        return payments;
    }

    private Payment getPaymentById(int id) {
        Payment payment = null;
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnection.getConnection();
            String sql = "SELECT p.*, u.name AS user_name, pkg.name AS package_name " +
                    "FROM payments p " +
                    "JOIN users u ON p.user_id = u.id " +
                    "JOIN packages pkg ON p.package_id = pkg.id " +
                    "WHERE p.id = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, id);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                payment = new Payment();
                payment.setId(resultSet.getInt("id"));
                payment.setUserId(resultSet.getInt("user_id"));
                payment.setPackageId(resultSet.getInt("package_id"));
                payment.setPaymentDate(resultSet.getTimestamp("payment_date"));
                payment.setAmount(resultSet.getDouble("amount"));
                payment.setPaymentType(resultSet.getString("payment_type"));
                payment.setRecurring(resultSet.getBoolean("recurring")); // Using 'recurring' as 'forever'

                User user = new User();
                user.setName(resultSet.getString("user_name"));
                payment.setUser(user);
                Package pkg = new Package();
                pkg.setName(resultSet.getString("package_name"));
                payment.setPackage(pkg);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(resultSet);
            DatabaseConnection.close(preparedStatement);
            DatabaseConnection.close(connection);
        }
        return payment;
    }

    private void recordPayment(Payment payment) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = DatabaseConnection.getConnection();
            String sql = "INSERT INTO payments (user_id, package_id, payment_date, amount, payment_type, recurring) VALUES (?, ?, ?, ?, ?, ?)";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, payment.getUserId());
            preparedStatement.setInt(2, payment.getPackageId());
            preparedStatement.setTimestamp(3, payment.getPaymentDate());
            preparedStatement.setDouble(4, payment.getAmount());
            preparedStatement.setString(5, payment.getPaymentType());
            preparedStatement.setBoolean(6, payment.isRecurring());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(preparedStatement);
            DatabaseConnection.close(connection);
        }
    }

    private List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnection.getConnection();
            String sql = "SELECT id, name FROM users";
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                User user = new User();
                user.setId(resultSet.getInt("id"));
                user.setName(resultSet.getString("name"));
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

    private List<Package> getAllPackages() {
        List<Package> packages = new ArrayList<>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnection.getConnection();
            String sql = "SELECT id, name FROM packages";
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Package pkg = new Package();
                pkg.setId(resultSet.getInt("id"));
                pkg.setName(resultSet.getString("name"));
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
}