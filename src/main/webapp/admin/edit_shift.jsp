<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.gymproject.model.Shift" %>
<%@ page import="java.sql.Time" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Shift</title>
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
        input[type="time"],
        select {
            width: calc(100% - 12px);
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
        }

        button[type="submit"] {
            background-color: #007bff;
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
            background-color: #0056b3;
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
    <h1>Edit Shift</h1>

    <%
        Shift shiftToEdit = (Shift) request.getAttribute("shift");
        SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
        if (shiftToEdit == null) {
    %>
    <p class="error-message">Shift not found.</p>
    <div class="button-container">
        <a href="${pageContext.request.contextPath}/admin/shifts" class="back-button">Back to Shifts</a>
    </div>
    <%
    } else {
    %>
    <% if (request.getAttribute("errorMessage") != null) { %>
    <div class="error-message"><%= request.getAttribute("errorMessage") %></div>
    <% } %>

    <form action="${pageContext.request.contextPath}/admin/shifts" method="post">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="<%= shiftToEdit.getId() %>">

        <div class="form-group">
            <label for="name">Shift Name:</label>
            <input type="text" id="name" name="name" value="<%= shiftToEdit.getName() %>" required>
        </div>

        <div class="form-group">
            <label for="startTime">Start Time:</label>
            <input type="time" id="startTime" name="startTime" value="<%= timeFormat.format(shiftToEdit.getStartTime()) %>" required>
            <small>Format: HH:mm (24-hour)</small>
        </div>

        <div class="form-group">
            <label for="endTime">End Time:</label>
            <input type="time" id="endTime" name="endTime" value="<%= timeFormat.format(shiftToEdit.getEndTime()) %>" required>
            <small>Format: HH:mm (24-hour)</small>
        </div>

        <div class="form-group">
            <label for="dayOfWeek">Day of Week:</label>
            <select id="dayOfWeek" name="dayOfWeek" required>
                <option value="">Select Day</option>
                <option value="Monday" <%= "Monday".equals(shiftToEdit.getDayOfWeek()) ? "selected" : "" %>>Monday</option>
                <option value="Tuesday" <%= "Tuesday".equals(shiftToEdit.getDayOfWeek()) ? "selected" : "" %>>Tuesday</option>
                <option value="Wednesday" <%= "Wednesday".equals(shiftToEdit.getDayOfWeek()) ? "selected" : "" %>>Wednesday</option>
                <option value="Thursday" <%= "Thursday".equals(shiftToEdit.getDayOfWeek()) ? "selected" : "" %>>Thursday</option>
                <option value="Friday" <%= "Friday".equals(shiftToEdit.getDayOfWeek()) ? "selected" : "" %>>Friday</option>
                <option value="Saturday" <%= "Saturday".equals(shiftToEdit.getDayOfWeek()) ? "selected" : "" %>>Saturday</option>
                <option value="Sunday" <%= "Sunday".equals(shiftToEdit.getDayOfWeek()) ? "selected" : "" %>>Sunday</option>
            </select>
        </div>

        <div class="button-container">
            <button type="submit">Update Shift</button>
            <a href="${pageContext.request.contextPath}/admin/shifts" class="back-button">Back to Shifts</a>
        </div>
    </form>
    <%
        }
    %>
</div>
</body>
</html>