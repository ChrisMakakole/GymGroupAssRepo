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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

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
            // Initialize error list
            List<String> errors = new ArrayList<>();

            // Get and validate basic payment info
            String userName = request.getParameter("userName");
            if (userName == null || userName.trim().isEmpty()) {
                errors.add("User name is required");
            }

            String packageName = request.getParameter("packageName");
            if (packageName == null || packageName.trim().isEmpty()) {
                errors.add("Package name is required");
            }

            double packagePrice = 0;
            try {
                packagePrice = Double.parseDouble(request.getParameter("packagePrice"));
                if (packagePrice <= 0) {
                    errors.add("Package price must be positive");
                }
            } catch (NumberFormatException e) {
                errors.add("Invalid package price format");
            }

            double amount = 0;
            try {
                amount = Double.parseDouble(request.getParameter("amount"));
                if (amount <= 0) {
                    errors.add("Amount must be positive");
                }
                if (Math.abs(amount - packagePrice) > 0.01) { // Allow small rounding differences
                    errors.add("Amount must match package price");
                }
            } catch (NumberFormatException e) {
                errors.add("Invalid amount format");
            }

            String paymentMethod = request.getParameter("paymentMethod");
            if (paymentMethod == null || paymentMethod.trim().isEmpty()) {
                errors.add("Payment method is required");
            }

            // Validate credit card details if payment method is credit card
            String cardNumber = null;
            String cardExpiry = null;
            String cardholderName = null;
            String cardCvv = "";

            if ("credit_card".equals(paymentMethod)) {
                cardNumber = request.getParameter("cardNumber");
                if (cardNumber == null || !cardNumber.matches("\\d{13,19}")) {
                    errors.add("Valid card number (13-19 digits) is required");
                }

                cardExpiry = request.getParameter("expiryDate"); // Note: parameter name consistency
                if (cardExpiry == null || cardExpiry.trim().isEmpty()) {
                    errors.add("Card expiry date is required");
                } else {
                    try {
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
                        Date expiryDate = sdf.parse(cardExpiry);
                        if (expiryDate.before(new Date())) {
                            errors.add("Card has expired");
                        }
                    } catch (ParseException e) {
                        errors.add("Invalid expiry date format (use MM/YYYY)");
                    }
                }

                cardholderName = request.getParameter("cardholderName");
                if (cardholderName == null || cardholderName.trim().isEmpty()) {
                    errors.add("Cardholder name is required");
                }

                cardCvv = request.getParameter("cvv");
                if (cardCvv == null || !cardCvv.matches("\\d{3,4}")) {
                    errors.add("Valid CVV (3-4 digits) is required");
                }
            }

            // For other payment methods
            String paymentType = request.getParameter("paymentType");
            if (!"credit_card".equals(paymentMethod) &&
                    (paymentType == null || paymentType.trim().isEmpty())) {
                errors.add("Payment type is required for non-card payments");
            }

            boolean isRecurring = Boolean.parseBoolean(request.getParameter("recurring"));

            // If there are errors, return to form with messages
            if (!errors.isEmpty()) {
                request.setAttribute("errorMessages", errors);
                // Repopulate form data
                request.setAttribute("users", getAllUsers());
                request.setAttribute("packages", getAllPackages());
                request.getRequestDispatcher("/admin/record_payment.jsp").forward(request, response);
                return;
            }

            // Create payment object only if validation passes
            Payment newPayment = new Payment();
            newPayment.setUserName(userName);
            newPayment.setPackageName(packageName);
            newPayment.setPackagePrice(packagePrice);
            newPayment.setPaymentDate(new Timestamp(System.currentTimeMillis()));
            newPayment.setAmount(amount);
            newPayment.setPaymentMethod(paymentMethod);

            // Only set card details if payment method is credit card
            if ("credit_card".equals(paymentMethod)) {
                // Mask card number before storage (only store last 4 digits)
                String maskedCardNumber = "****" + cardNumber.substring(cardNumber.length() - 4);
                newPayment.setCardNumber(maskedCardNumber);
                newPayment.setCardExpiry(cardExpiry);
                newPayment.setCardholderName(cardholderName);
                // Don't store CVV - it's only for authorization
                newPayment.setCardCvv(cardCvv);
            } else {
                newPayment.setPaymentType(paymentType);
            }

            newPayment.setRecurring(isRecurring);

            try {
                recordPayment(newPayment, "payments");
                response.sendRedirect(request.getContextPath() + "/admin/payments");
            } catch (Exception e) {
                errors.add("Failed to record payment: " + e.getMessage());
                request.setAttribute("errorMessages", errors);
                request.getRequestDispatcher("/admin/record_payment.jsp").forward(request, response);
            }
        }
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
            String sql = "SELECT * FROM payments WHERE is_recurring = TRUE";
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