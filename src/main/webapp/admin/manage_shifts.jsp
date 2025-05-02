<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.gymproject.model.Shift" %>
<%@ page import="java.sql.Time" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Manage Shifts</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
  <style>
    #body
    {
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

    .add-button-container {
      text-align: right;
      margin-bottom: 15px;
    }

    .add-button {
      background-color: #28a745;
      color: white;
      padding: 10px 15px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      text-decoration: none;
      font-size: 16px;
      transition: background-color 0.3s ease;
    }

    .add-button:hover {
      background-color: #1e7e34;
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

    .action-buttons a, .action-buttons form {
      display: inline-block;
      margin-right: 5px;
    }

    .edit-button {
      background-color: #007bff;
      color: white;
      padding: 8px 12px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      text-decoration: none;
      font-size: 14px;
      transition: background-color 0.3s ease;
    }

    .edit-button:hover {
      background-color: #0056b3;
    }

    .delete-button {
      background-color: #dc3545;
      color: white;
      padding: 8px 12px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      text-decoration: none;
      font-size: 14px;
      transition: background-color 0.3s ease;
    }

    .delete-button:hover {
      background-color: #c82333;
    }

    .delete-form {
      margin: 0;
      padding: 0;
    }
  </style>
</head>
<body id="body">
<div class="container">
  <h1>Manage Shifts</h1>

  <div class="add-button-container">
<%--    <a href="${pageContext.request.contextPath}/admin/add_shift.jsp" class="add-button">Add New Shift</a>--%>
    <button class="add-button" onclick="loadContent('admin/add_shift.jsp')">Add New Shift</button>
  </div>

  <%
    List<Shift> shifts = (List<Shift>) request.getAttribute("shifts");
    SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
    if (shifts != null && !shifts.isEmpty()) {
  %>
  <table>
    <thead>
    <tr>
      <th>ID</th>
      <th>Name</th>
      <th>Start Time</th>
      <th>End Time</th>
      <th>Day of Week</th>
      <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <% for (Shift shift : shifts) { %>
    <tr>
      <td><%= shift.getId() %></td>
      <td><%= shift.getName() %></td>
      <td><%= timeFormat.format(shift.getStartTime()) %></td>
      <td><%= timeFormat.format(shift.getEndTime()) %></td>
      <td><%= shift.getDayOfWeek() %></td>
      <td class="action-buttons">
<%--        <a href="${pageContext.request.contextPath}/admin/shifts?action=edit&id=<%= shift.getId() %>" class="edit-button">Edit</a>--%>
        <button class="edit-button" onclick="loadContent('admin/shifts?action=edit&id=<%= shift.getId() %>')">Edit</button>
        <form action="${pageContext.request.contextPath}/admin/shifts" method="post" class="delete-form">
          <input type="hidden" name="action" value="delete">
          <input type="hidden" name="id" value="<%= shift.getId() %>">
          <button type="submit" class="delete-button" onclick="return confirm('Are you sure you want to delete this shift?')">Delete</button>
        </form>
      </td>
    </tr>
    <% } %>
    </tbody>
  </table>
  <%
  } else {
  %>
  <p>No shifts available.</p>
  <%
    }
  %>

  <div style="margin-top: 20px;">
    <a href="${pageContext.request.contextPath}/admin/dashboard">Back to Dashboard</a>
  </div>
</div>
</body>
</html>