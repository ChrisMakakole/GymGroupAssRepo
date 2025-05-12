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
            Payment payment = getPaymentById(id, "subscriptions"); // Assuming you view from subscriptions
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
            String userName = request.getParameter("userName");
            String packageName = request.getParameter("packageName");
            double packagePrice = Double.parseDouble(request.getParameter("packagePrice"));
            double amount = Double.parseDouble(request.getParameter("amount"));
            String paymentMethod = request.getParameter("paymentMethod");
            String cardNumber = request.getParameter("cardNumber");
            String cardExpiry = request.getParameter("cardExpiry");
            String cardholderName = request.getParameter("cardholderName");
            String cardCvv = request.getParameter("cardCvv");
            String paymentType = request.getParameter("paymentType");
            boolean isRecurring = Boolean.parseBoolean(request.getParameter("recurring"));

            Payment newPayment = new Payment();
            newPayment.setUserName(userName);
            newPayment.setPackageName(packageName);
            newPayment.setPackagePrice(packagePrice);
            newPayment.setPaymentDate(new Timestamp(System.currentTimeMillis()));
            newPayment.setAmount(amount);
            newPayment.setPaymentMethod(paymentMethod);
            newPayment.setCardNumber(cardNumber);
            newPayment.setCardExpiry(cardExpiry);
            newPayment.setCardholderName(cardholderName);
            newPayment.setCardCvv(cardCvv);
            newPayment.setPaymentType(paymentType);
            newPayment.setRecurring(isRecurring);

            recordPayment(newPayment, "payments");
            response.sendRedirect(request.getContextPath() + "/admin/payments");
        }
        // You might add logic for updating or deleting payments here if needed
    }

    private void processAutoPayment() {
        System.out.println("Checking for 'forever' recurring subscriptions...");
        List<Payment> foreverSubscriptions = getForeverRecurringPayments();

        for (Payment subscription : foreverSubscriptions) {
            System.out.println("Simulating automatic payment for user " + subscription.getUserName() + " (forever recurring)");
            Payment newSubscription = new Payment();
            newSubscription.setUserName(subscription.getUserName());
            newSubscription.setPackageName(subscription.getPackageName());
            newSubscription.setPackagePrice(subscription.getPackagePrice());
            newSubscription.setPaymentDate(new Timestamp(System.currentTimeMillis()));
            newSubscription.setAmount(subscription.getAmount());
            newSubscription.setPaymentMethod(subscription.getPaymentMethod());
            newSubscription.setCardNumber(subscription.getCardNumber());
            newSubscription.setCardExpiry(subscription.getCardExpiry());
            newSubscription.setCardholderName(subscription.getCardholderName());
            newSubscription.setCardCvv(subscription.getCardCvv());
            newSubscription.setPaymentType("Automatic Recurring (Simulated)");
            newSubscription.setRecurring(true); // Still using recurring flag

            recordPayment(newSubscription, "subscriptions");
            System.out.println("Simulated automatic payment recorded in subscriptions.");
        }
    }

    private List<Payment> getForeverRecurringPayments() {
        List<Payment> foreverSubscriptions = new ArrayList<>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM subscriptions WHERE is_recurring = TRUE";
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Payment subscription = new Payment();
                subscription.setPaymentId(resultSet.getInt("payment_id"));
                subscription.setUserName(resultSet.getString("user_name"));
                subscription.setPackageName(resultSet.getString("package_name"));
                subscription.setPackagePrice(resultSet.getDouble("package_price"));
                subscription.setPaymentDate(resultSet.getTimestamp("payment_date"));
                subscription.setAmount(resultSet.getDouble("amount"));
                subscription.setPaymentMethod(resultSet.getString("payment_method"));
                subscription.setCardNumber(resultSet.getString("card_number"));
                subscription.setCardExpiry(resultSet.getString("card_expiry"));
                subscription.setCardholderName(resultSet.getString("cardholder_name"));
                subscription.setCardCvv(resultSet.getString("card_cvv"));
                subscription.setPaymentType(resultSet.getString("payment_type"));
                subscription.setRecurring(resultSet.getBoolean("is_recurring"));
                foreverSubscriptions.add(subscription);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(resultSet);
            DatabaseConnection.close(preparedStatement);
            DatabaseConnection.close(connection);
        }
        return foreverSubscriptions;
    }

    private List<Payment> getAllPayments() {
        List<Payment> payments = new ArrayList<>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM subscriptions"; // Assuming you manage and view from subscriptions
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Payment payment = new Payment();
                payment.setPaymentId(resultSet.getInt("payment_id"));
                payment.setUserName(resultSet.getString("user_name"));
                payment.setPackageName(resultSet.getString("package_name"));
                payment.setPackagePrice(resultSet.getDouble("package_price"));
                payment.setPaymentDate(resultSet.getTimestamp("payment_date"));
                payment.setAmount(resultSet.getDouble("amount"));
                payment.setPaymentMethod(resultSet.getString("payment_method"));
                payment.setCardNumber(resultSet.getString("card_number"));
                payment.setCardExpiry(resultSet.getString("card_expiry"));
                payment.setCardholderName(resultSet.getString("cardholder_name"));
                payment.setCardCvv(resultSet.getString("card_cvv"));
                payment.setPaymentType(resultSet.getString("payment_type"));
                payment.setRecurring(resultSet.getBoolean("is_recurring"));

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

    private Payment getPaymentById(int id, String table) {
        Payment payment = null;
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM " + table + " WHERE payment_id = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, id);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                payment = new Payment();
                payment.setPaymentId(resultSet.getInt("payment_id"));
                payment.setUserName(resultSet.getString("user_name"));
                payment.setPackageName(resultSet.getString("package_name"));
                payment.setPackagePrice(resultSet.getDouble("package_price"));
                payment.setPaymentDate(resultSet.getTimestamp("payment_date"));
                payment.setAmount(resultSet.getDouble("amount"));
                payment.setPaymentMethod(resultSet.getString("payment_method"));
                payment.setCardNumber(resultSet.getString("card_number"));
                payment.setCardExpiry(resultSet.getString("card_expiry"));
                payment.setCardholderName(resultSet.getString("cardholder_name"));
                payment.setCardCvv(resultSet.getString("card_cvv"));
                payment.setPaymentType(resultSet.getString("payment_type"));
                payment.setRecurring(resultSet.getBoolean("is_recurring"));
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

    private void recordPayment(Payment payment, String table) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = DatabaseConnection.getConnection();
            String sql = "INSERT INTO " + table + " (user_name, package_name, package_price, payment_date, amount, payment_method, card_number, card_expiry, cardholder_name, card_cvv, payment_type, is_recurring) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, payment.getUserName());
            preparedStatement.setString(2, payment.getPackageName());
            preparedStatement.setDouble(3, payment.getPackagePrice());
            preparedStatement.setTimestamp(4, payment.getPaymentDate());
            preparedStatement.setDouble(5, payment.getAmount());
            preparedStatement.setString(6, payment.getPaymentMethod());
            preparedStatement.setString(7, payment.getCardNumber());
            preparedStatement.setString(8, payment.getCardExpiry());
            preparedStatement.setString(9, payment.getCardholderName());
            preparedStatement.setString(10, payment.getCardCvv());
            preparedStatement.setString(11, payment.getPaymentType());
            preparedStatement.setBoolean(12, payment.isRecurring());
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
            String sql = "SELECT id, name, price FROM packages"; // Fetch price as well
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Package pkg = new Package();
                pkg.setId(resultSet.getInt("id"));
                pkg.setName(resultSet.getString("name"));
                pkg.setPrice(resultSet.getDouble("price")); // Fetch the price
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