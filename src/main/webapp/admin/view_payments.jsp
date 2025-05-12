<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.gymproject.model.Payment" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>View Subscription Details</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f4;
      margin: 0;
      padding: 20px;
    }

    .container {
      max-width: 800px;
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

    .detail-row {
      margin-bottom: 10px;
      padding: 8px 0;
      border-bottom: 1px solid #eee;
    }

    .detail-row strong {
      display: inline-block;
      width: 150px;
      font-weight: bold;
      color: #555;
    }

    .button-container {
      margin-top: 20px;
      text-align: left;
    }

    .button-container a {
      display: inline-block;
      padding: 10px 15px;
      text-decoration: none;
      background-color: #007bff;
      color: white;
      border-radius: 4px;
      transition: background-color 0.3s ease;
      margin-right: 10px;
    }

    .button-container a:hover {
      background-color: #0056b3;
    }
  </style>
</head>
<body>
<div class="container">
  <h1>Subscription Details</h1>

  <%
    Payment payment = (Payment) request.getAttribute("payment");
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    if (payment != null) {
  %>
  <div class="detail-row"><strong>Subscription ID:</strong> <%= payment.getPaymentId() %></div>
  <div class="detail-row"><strong>User Name:</strong> <%= payment.getUserName() %></div>
  <div class="detail-row"><strong>Package Name:</strong> <%= payment.getPackageName() %></div>
  <div class="detail-row"><strong>Package Price:</strong> <%= String.format("%.2f", payment.getPackagePrice()) %></div>
  <div class="detail-row"><strong>Payment Date:</strong> <%= sdf.format(payment.getPaymentDate()) %></div>
  <div class="detail-row"><strong>Amount Paid:</strong> <%= String.format("%.2f", payment.getAmount()) %></div>
  <div class="detail-row"><strong>Payment Method:</strong> <%= payment.getPaymentMethod() %></div>
  <div class="detail-row"><strong>Card Number:</strong> <%= payment.getCardNumber() != null ? payment.getCardNumber() : "-" %></div>
  <div class="detail-row"><strong>Card Expiry:</strong> <%= payment.getCardExpiry() != null ? payment.getCardExpiry() : "-" %></div>
  <div class="detail-row"><strong>Cardholder Name:</strong> <%= payment.getCardholderName() != null ? payment.getCardholderName() : "-" %></div>
  <div class="detail-row"><strong>Payment Type:</strong> <%= payment.getPaymentType() != null ? payment.getPaymentType() : "-" %></div>
  <div class="detail-row"><strong>Recurring:</strong> <%= payment.isRecurring() ? "Yes" : "No" %></div>
  <div class="detail-row"><strong>Created At:</strong> <%= payment.getCreatedAt() != null ? sdf.format(payment.getCreatedAt()) : "-" %></div>
  <div class="detail-row"><strong>Updated At:</strong> <%= payment.getUpdatedAt() != null ? sdf.format(payment.getUpdatedAt()) : "-" %></div>

  <div class="button-container">
    <a href="${pageContext.request.contextPath}/admin/payments">Back to Subscriptions</a>
  </div>
  <%
  } else {
  %>
  <p>Subscription not found.</p>
  <%
    }
  %>
</div>
</body>
</html>