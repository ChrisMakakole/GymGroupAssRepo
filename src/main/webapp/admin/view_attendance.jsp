<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.gymproject.model.Attendance" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>View Attendance</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
  <style>
    #body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f4;
      margin: 0;
      padding: 20px;
    }

    .container {
      max-width: 1000px;
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
      margin-top: 20px;
    }

    th, td {
      border: 1px solid #ddd;
      padding: 8px;
      text-align: left;
    }

    th {
      background-color: #f2f2f2;
      font-weight: bold;
    }

    tr:nth-child(even) {
      background-color: #f9f9f9;
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

    .checkout-button {
      background-color: #dc3545;
      color: white;
      border: none;
      padding: 8px 12px;
      border-radius: 4px;
      cursor: pointer;
      font-size: 14px;
      transition: background-color 0.3s ease;
    }

    .checkout-button:hover {
      background-color: #c82333;
    }

    .no-records {
      text-align: center;
      color: #777;
      margin-top: 20px;
    }
  </style>
</head>
<body id="body">
<div class="container">
  <h1>View Attendance Records</h1>

  <%
    List<Attendance> attendanceRecords = (List<Attendance>) request.getAttribute("attendanceRecords");
    if (attendanceRecords != null && !attendanceRecords.isEmpty()) {
  %>
  <table>
    <thead>
    <tr>
      <th>ID</th>
      <th>User</th>
      <th>Attendance Date</th>
      <th>Check-In Time</th>
      <th>Check-Out Time</th>
      <th>Action</th>
    </tr>
    </thead>
    <tbody>
    <%
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
      for (Attendance record : attendanceRecords) {
    %>
    <tr>
      <td><%= record.getId() %></td>
      <td><%= record.getUser().getName() %></td>
      <td><%= sdf.format(record.getAttendanceDate()) %></td>
      <td><%= sdf.format(record.getCheckInTime()) %></td>
      <td>
        <% if (record.getCheckOutTime() != null) { %>
        <%= sdf.format(record.getCheckOutTime()) %>
        <% } else { %>
        <form action="${pageContext.request.contextPath}/admin/attendance" method="post" style="display:inline;">
          <input type="hidden" name="action" value="checkOut">
          <input type="hidden" name="attendanceId" value="<%= record.getId() %>">
          <button type="submit" class="checkout-button">Check Out</button>
        </form>
        <% } %>
      </td>
      <td>
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
  <p class="no-records">No attendance records found.</p>
  <%
    }
  %>

  <div class="button-container">
    <a href="${pageContext.request.contextPath}/admin/attendance?action=mark" class="back-button">Mark Attendance</a>
    <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="back-button">Back to Dashboard</a>
  </div>
</div>
</body>
</html>
