<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Add New Package</title>
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

    input[type="text"],
    input[type="number"],
    textarea {
      width: calc(100% - 12px);
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 4px;
      box-sizing: border-box;
      font-size: 16px;
    }

    textarea {
      resize: vertical;
      min-height: 80px;
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
      background-color: #007bff;
      color: white;
      border-radius: 4px;
      transition: background-color 0.3s ease;
      margin-right: 10px;
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
  <h1>Add New Package</h1>

  <% if (request.getAttribute("errorMessage") != null) { %>
  <div class="error-message"><%= request.getAttribute("errorMessage") %></div>
  <% } %>

  <form action="${pageContext.request.contextPath}/admin/packages" method="post">
    <input type="hidden" name="action" value="add">

    <div class="form-group">
      <label for="name">Package Name:</label>
      <input type="text" id="name" name="name" required>
    </div>

    <div class="form-group">
      <label for="description">Description:</label>
      <textarea id="description" name="description"></textarea>
    </div>

    <div class="form-group">
      <label for="price">Price:</label>
      <input type="number" id="price" name="price" step="0.01" required>
    </div>

    <div class="form-group">
      <label for="durationDays">Duration (Days):</label>
      <input type="number" id="durationDays" name="durationDays" required>
    </div>

    <div class="button-container">
      <button type="submit">Add Package</button>
      <a href="${pageContext.request.contextPath}/admin/packages" class="back-button">Back to Packages</a>
    </div>
  </form>
</div>
</body>
</html>