<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.gymproject.model.Payment" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Subscriptions</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        #body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        th, td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
            font-weight: bold;
        }

        tr:hover {
            background-color: #f9f9f9;
        }

        .action-links a {
            margin-right: 10px;
            text-decoration: none;
            color: #007bff;
        }

        .action-links a:hover {
            text-decoration: underline;
        }

        .no-records {
            text-align: center;
            color: #777;
            margin-top: 20px;
        }

        .button-container {
            margin-top: 20px;
            text-align: left;
        }

        .button-container a {
            display: inline-block;
            padding: 10px 15px;
            text-decoration: none;
            background-color: #28a745;
            color: white;
            border-radius: 4px;
            transition: background-color 0.3s ease;
            margin-right: 10px;
        }

        .button-container a:hover {
            background-color: #218838;
        }
    </style>
</head>
<body id="body">
<div class="container">
    <h1>Manage Subscriptions</h1>

    <%
        List<Payment> payments = (List<Payment>) request.getAttribute("payments");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        if (payments != null && !payments.isEmpty()) {
    %>
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>User Name</th>
            <th>Package Name</th>
            <th>Package Price</th>
            <th>Payment Date</th>
            <th>Amount</th>
            <th>Method</th>
            <th>Card Number</th>
            <th>Expiry</th>
            <th>Cardholder</th>
            <th>Type</th>
            <th>Recurring</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            for (Payment payment : payments) {
        %>
        <tr>
            <td><%= payment.getPaymentId() %></td>
            <td><%= payment.getUserName() %></td>
            <td><%= payment.getPackageName() %></td>
            <td><%= String.format("%.2f", payment.getPackagePrice()) %></td>
            <td><%= sdf.format(payment.getPaymentDate()) %></td>
            <td><%= String.format("%.2f", payment.getAmount()) %></td>
            <td><%= payment.getPaymentMethod() %></td>
            <td><%= payment.getCardNumber() != null ? payment.getCardNumber() : "-" %></td>
            <td><%= payment.getCardExpiry() != null ? payment.getCardExpiry() : "-" %></td>
            <td><%= payment.getCardholderName() != null ? payment.getCardholderName() : "-" %></td>
            <td><%= payment.getPaymentType() != null ? payment.getPaymentType() : "-" %></td>
            <td><%= payment.isRecurring() ? "Yes" : "No" %></td>
            <td class="action-links">
                <a href="${pageContext.request.contextPath}/admin/payments?action=view&id=<%= payment.getPaymentId() %>">View</a>
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
    <%
    } else {
    %>
    <p class="no-records">No subscriptions found.</p>
    <%
        }
    %>

    <div class="button-container">
        <a href="${pageContext.request.contextPath}/admin/payments?action=record">Record New Subscription</a>
    </div>
</div>
</body>
</html>