<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.gymproject.model.Payment" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>View Payment Details</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
  <style>
    #body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f4;
      margin: 0;
      padding: 20px;
    }

    .container {
      max-width: 600px;
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

    .payment-details {
      margin-top: 20px;
      padding: 15px;
      border: 1px solid #ddd;
      border-radius: 4px;
      background-color: #f9f9f9;
    }

    .detail-item {
      margin-bottom: 10px;
    }

    .detail-label {
      font-weight: bold;
      color: #555;
      display: block;
      margin-bottom: 5px;
    }

    .detail-value {
      color: #333;
    }

    .button-container {
      margin-top: 20px;
      text-align: center;
    }

    .back-button {
      display: inline-block;
      padding: 10px 15px;
      text-decoration: none;
      background-color: #007bff;
      color: white;
      border-radius: 4px;
      transition: background-color 0.3s ease;
    }

    .back-button:hover {
      background-color: #0056b3;
    }

    .error-message {
      color: red;
      margin-top: 10px;
      text-align: center;
    }
  </style>
</head>
<body id="body">
<div class="container">
  <h1>Payment Details</h1>

  <%
    Payment payment = (Payment) request.getAttribute("payment");
    if (payment == null) {
  %>
  <p class="error-message">Payment not found.</p>
  <%
  } else {
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(Locale.getDefault());
  %>
  <div class="payment-details">
    <div class="detail-item">
      <span class="detail-label">Payment ID:</span>
      <span class="detail-value"><%= payment.getId() %></span>
    </div>
    <div class="detail-item">
      <span class="detail-label">User:</span>
      <span class="detail-value"><%= payment.getUser().getName() %> (ID: <%= payment.getUserId() %>)</span>
    </div>
    <div class="detail-item">
      <span class="detail-label">Package:</span>
      <span class="detail-value"><%= payment.getPackage().getName() %> (ID: <%= payment.getPackageId() %>)</span>
    </div>
    <div class="detail-item">
      <span class="detail-label">Payment Date:</span>
      <span class="detail-value"><%= dateFormat.format(payment.getPaymentDate()) %></span>
    </div>
    <div class="detail-item">
      <span class="detail-label">Amount Paid:</span>
      <span class="detail-value"><%= currencyFormat.format(payment.getAmount()) %></span>
    </div>
    <div class="detail-item">
      <span class="detail-label">Payment Type:</span>
      <span class="detail-value"><%= payment.getPaymentType() %></span>
    </div>
    <div class="detail-item">
      <span class="detail-label">Recurring Payment:</span>
      <span class="detail-value"><%= payment.isRecurring() ? "Yes" : "No" %></span>
    </div>
  </div>
  <%
    }
  %>

  <div class="button-container">
    <a href="${pageContext.request.contextPath}/admin/payments" class="back-button">Back to Payments</a>
  </div>
</div>
</body>
</html>