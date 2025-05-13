<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.gymproject.model.TrainerShift" %>
<%@ page import="com.example.gymproject.model.Trainer" %>
<%@ page import="com.example.gymproject.model.Shift" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Trainer Shifts</title>
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

        .action-buttons form {
            display: inline-block;
            margin-right: 5px;
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
    <h1>Manage Trainer Shifts</h1>

    <div class="add-button-container">
        <a href="${pageContext.request.contextPath}/admin/trainer_shifts?action=assign" class="add-button">Assign Trainer to Shift</a>
    </div>

    <%
        List<TrainerShift> trainerShifts = (List<TrainerShift>) request.getAttribute("trainerShifts");
        SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
        if (trainerShifts != null && !trainerShifts.isEmpty()) {
    %>
    <table>
        <thead>
        <tr>
            <th>Trainer</th>
            <th>Shift</th>
            <th>Day of Week</th>
            <th>Start Time</th>
            <th>End Time</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <% for (TrainerShift ts : trainerShifts) { %>
        <tr>
            <td><%= ts.getTrainer().getName() %></td>
            <td><%= ts.getShift().getName() %></td>
            <td><%= ts.getShift().getDayOfWeek() %></td>
            <td><%= timeFormat.format(ts.getShift().getStartTime()) %></td>
            <td><%= timeFormat.format(ts.getShift().getEndTime()) %></td>
            <td class="action-buttons">
                <form action="${pageContext.request.contextPath}/admin/trainer_shifts" method="post" class="delete-form">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="id" value="<%= ts.getId() %>">
                    <button type="submit" class="delete-button" onclick="return confirm('Are you sure you want to remove this trainer from this shift?')">Remove</button>
                </form>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <%
    } else {
    %>
    <p>No trainers are currently assigned to shifts.</p>
    <%
        }
    %>

    <div style="margin-top: 20px;">
        <a href="${pageContext.request.contextPath}/admin/dashboard">Back to Dashboard</a>
    </div>
</div>
</body>
</html>
