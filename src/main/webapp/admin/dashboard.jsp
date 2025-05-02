<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Admin Dashboard</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f4;
      margin: 0;
      padding: 0;
    }

    .dashboard-container {
      max-width: 960px;
      margin: 20px auto;
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

    .admin-info {
      text-align: center;
      margin-bottom: 20px;
      color: #555;
    }

    .module-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
      gap: 15px;
    }

    .module-card {
      background-color: #e9ecef;
      padding: 15px;
      border-radius: 6px;
      text-align: center;
      transition: background-color 0.3s ease;
    }

    .module-card:hover {
      background-color: #d3d9df;
    }

    .module-card a {
      text-decoration: none;
      color: #333;
      display: block;
      font-weight: bold;
      font-size: 1.1em;
    }

    .logout-link {
      display: block;
      text-align: center;
      margin-top: 20px;
      color: #007bff;
      text-decoration: none;
      font-weight: bold;
    }

    .logout-link:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>
<div class="dashboard-container">
  <h1>Admin Dashboard</h1>

  <div class="admin-info">
    Welcome, <%= session.getAttribute("admin") %>!
  </div>

  <div class="module-grid">
    <div class="module-card">
      <a href="${pageContext.request.contextPath}/admin/users">Manage Users</a>
    </div>
    <div class="module-card">
      <a href="${pageContext.request.contextPath}/admin/packages">Manage Packages</a>
    </div>
    <div class="module-card">
      <a href="${pageContext.request.contextPath}/admin/trainers">Manage Trainers</a>
    </div>
    <div class="module-card">
      <a href="${pageContext.request.contextPath}/admin/payments">Manage Payments</a>
    </div>
    <div class="module-card">
      <a href="${pageContext.request.contextPath}/admin/attendance?action=view">View Attendance</a>
    </div>
    <div class="module-card">
      <a href="${pageContext.request.contextPath}/admin/attendance?action=mark">Mark Attendance</a>
    </div>
    <div class="module-card">
      <a href="${pageContext.request.contextPath}/admin/shifts">Manage Shifts</a>
    </div>
    <div class="module-card">
      <a href="${pageContext.request.contextPath}/admin/trainer_shifts">Manage Trainer Shifts</a>
    </div>
  </div>

  <a class="logout-link" href="${pageContext.request.contextPath}/admin/logout">Logout</a>
</div>
</body>
</html>