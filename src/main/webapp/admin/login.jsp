<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Admin Login - Gym Management System</title>
  <link rel="stylesheet" href="../css/style.css">
  <style>
    body {
      font-family: Arial, sans-serif;
      background: #e6f0ff;
      display: flex;
      align-items: center;
      justify-content: center;
      height: 100vh;
    }
    .login-container {
      background: white;
      padding: 30px 40px;
      border-radius: 10px;
      box-shadow: 0 0 15px rgba(0,0,0,0.2);
      width: 350px;
    }
    h2 {
      text-align: center;
      color: #333;
    }
    input[type="text"], input[type="password"] {
      width: 100%;
      padding: 10px 15px;
      margin: 10px 0;
      border: 1px solid #ccc;
      border-radius: 6px;
    }
    input[type="submit"] {
      width: 100%;
      background-color: #007BFF;
      color: white;
      padding: 10px;
      border: none;
      border-radius: 6px;
      font-weight: bold;
      cursor: pointer;
    }
    input[type="submit"]:hover {
      background-color: #0056b3;
    }
    .error {
      color: red;
      text-align: center;
      margin-top: 10px;
    }
  </style>
</head>
<body>
<div class="login-container">
  <h2>Admin Login</h2>
  <form action="../AdminLoginServlet" method="post">
    <input type="text" name="username" placeholder="Enter username" required>
    <input type="password" name="password" placeholder="Enter password" required>
    <input type="submit" value="Login">
  </form>
  <%
    String error = request.getParameter("error");
    if ("invalid".equals(error)) {
  %>
  <div class="error">Invalid username or password.</div>
  <% } %>

</div>
</body>
</html>
