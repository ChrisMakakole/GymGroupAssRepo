<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.gymproject.model.User" %>
<%@ page import="com.example.gymproject.model.Package" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Record New Payment</title>
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

    .form-group {
      margin-bottom: 15px;
    }

    label {
      display: block;
      margin-bottom: 5px;
      color: #555;
      font-weight: bold;
    }

    select,
    input[type="text"],
    input[type="number"],
    input[type="checkbox"] {
      width: calc(100% - 12px);
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 4px;
      box-sizing: border-box;
      font-size: 16px;
    }

    button[type="submit"] {
      background-color: #28a745;
      color: white;
      padding: 12px 20px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-size: 16px;
      transition: background-color 0.3s ease;
      width: 100%;
    }

    button[type="submit"]:hover {
      background-color: #1e7e34;
    }

    .button-container {
      margin-top: 20px;
      text-align: center;
    }

    .back-button {
      display: inline-block;
      padding: 10px 15px;
      text-decoration: none;
      background-color: #6c757d;
      color: white;
      border-radius: 4px;
      transition: background-color 0.3s ease;
      margin-right: 10px;
    }

    .back-button:hover {
      background-color: #5a6268;
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
  <h1>Record New Payment</h1>

  <% if (request.getAttribute("errorMessage") != null) { %>
  <div class="error-message"><%= request.getAttribute("errorMessage") %></div>
  <% } %>

  <form action="${pageContext.request.contextPath}/admin/payments" method="post">
    <input type="hidden" name="action" value="recordPayment">

    <div class="form-group">
      <label for="userId">User:</label>
      <select id="userId" name="userId" required>
        <option value="">Select User</option>
        <%
          List<User> users = (List<User>) request.getAttribute("users");
          if (users != null) {
            for (User user : users) {
        %>
        <option value="<%= user.getId() %>"><%= user.getName() %></option>
        <%
            }
          }
        %>
      </select>
    </div>

    <div class="form-group">
      <label for="packageId">Package:</label>
      <select id="packageId" name="packageId" required>
        <option value="">Select Package</option>
        <%
          List<Package> packages = (List<Package>) request.getAttribute("packages");
          if (packages != null) {
            for (Package pkg : packages) {
        %>
        <option value="<%= pkg.getId() %>"><%= pkg.getName() %> (<%= pkg.getPrice() %>)</option>
        <%
            }
          }
        %>
      </select>
    </div>

    <div class="form-group">
      <label for="paymentDate">Payment Date:</label>
      <% SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); %>
      <input type="text" id="paymentDate" name="paymentDate" value="<%= sdf.format(new Date()) %>" required>
      <small>Format: yyyy-MM-dd HH:mm:ss</small>
    </div>

    <div class="form-group">
      <label for="amount">Amount Paid:</label>
      <input type="number" id="amount" name="amount" step="0.01" required>
    </div>

    <div class="form-group">
      <label for="paymentType">Payment Type:</label>
      <input type="text" id="paymentType" name="paymentType">
    </div>

    <div class="form-group">
      <label for="recurring">Recurring Payment:</label>
      <input type="checkbox" id="recurring" name="recurring" value="true"> Yes
    </div>

    <div class="button-container">
      <button type="submit">Record Payment</button>
      <a href="${pageContext.request.contextPath}/admin/payments" class="back-button">Back to Payments</a>
    </div>
  </form>
</div>
</body>
</html>