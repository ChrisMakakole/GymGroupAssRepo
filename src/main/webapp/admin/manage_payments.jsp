<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.gymproject.model.Payment" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Payments</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        #body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }

        .container {
            max-width: 960px;
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

        .record-button-container {
            text-align: right;
            margin-bottom: 15px;
        }

        .record-button {
            background-color: #007bff;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        .record-button:hover {
            background-color: #0056b3;
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

        .action-buttons a {
            display: inline-block;
            margin-right: 5px;
            text-decoration: none;
            background-color: #6c757d;
            color: white;
            padding: 8px 12px;
            border-radius: 4px;
            font-size: 14px;
            transition: background-color 0.3s ease;
        }

        .action-buttons a:hover {
            background-color: #5a6268;
        }

        .recurring-yes {
            color: green;
            font-weight: bold;
        }

        .recurring-no {
            color: red;
        }
    </style>
</head>
<body id="body">
<div class="container">
    <h1>Manage Payments</h1>

    <div class="record-button-container">
<%--        <a href="${pageContext.request.contextPath}/admin/payments?action=record" class="record-button">Record New Payment</a>--%>
        <button class="record-button" onclick="loadContent('admin/payments?action=record')">Record New Payment</button>
    </div>

    <%
        List<Payment> payments = (List<Payment>) request.getAttribute("payments");
        if (payments != null && !payments.isEmpty()) {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(Locale.getDefault()); // You might want to specify a locale
    %>
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>User</th>
            <th>Package</th>
            <th>Payment Date</th>
            <th>Amount</th>
            <th>Type</th>
            <th>Recurring</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <% for (Payment payment : payments) { %>
        <tr>
            <td><%= payment.getId() %></td>
            <td><%= payment.getUser().getName() %></td>
            <td><%= payment.getPackage().getName() %></td>
            <td><%= dateFormat.format(payment.getPaymentDate()) %></td>
            <td><%= currencyFormat.format(payment.getAmount()) %></td>
            <td><%= payment.getPaymentType() %></td>
            <td>
                <% if (payment.isRecurring()) { %>
                <span class="recurring-yes">Yes</span>
                <% } else { %>
                <span class="recurring-no">No</span>
                <% } %>
            </td>
            <td class="action-buttons">
<%--                <a href="${pageContext.request.contextPath}/admin/payments?action=view&id=<%= payment.getId() %>">View</a>--%>
                <button class="record-button" onclick="loadContent('admin/payments?action=view&id=<%= payment.getId() %>')">View</button>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <%
    } else {
    %>
    <p>No payments recorded yet.</p>
    <%
        }
    %>

    <div style="margin-top: 20px;">
        <a href="${pageContext.request.contextPath}/admin/dashboard">Back to Dashboard</a>
    </div>
</div>
</body>
</html>