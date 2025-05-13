<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.gymproject.model.Trainer" %>
<%@ page import="com.example.gymproject.model.Shift" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Assign Trainer to Shift</title>
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

        form {
            margin-top: 20px;
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

        select {
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
    <h1>Assign Trainer to Shift</h1>

    <% if (request.getAttribute("errorMessage") != null) { %>
    <div class="error-message"><%= request.getAttribute("errorMessage") %></div>
    <% } %>

    <form action="${pageContext.request.contextPath}/admin/trainer_shifts" method="post">
        <input type="hidden" name="action" value="assignTrainerShift">

        <div class="form-group">
            <label for="trainerId">Trainer:</label>
            <select id="trainerId" name="trainerId" required>
                <option value="">Select Trainer</option>
                <%
                    List<Trainer> trainers = (List<Trainer>) request.getAttribute("trainers");
                    if (trainers != null) {
                        for (Trainer trainer : trainers) {
                %>
                <option value="<%= trainer.getId() %>"><%= trainer.getName() %></option>
                <%
                        }
                    }
                %>
            </select>
        </div>

        <div class="form-group">
            <label for="shiftId">Shift:</label>
            <select id="shiftId" name="shiftId" required>
                <option value="">Select Shift</option>
                <%
                    List<Shift> shifts = (List<Shift>) request.getAttribute("shifts");
                    if (shifts != null) {
                        for (Shift shift : shifts) {
                %>
                <option value="<%= shift.getId() %>"><%= shift.getName() %> (<%= shift.getDayOfWeek() %>: <%= shift.getStartTime() %> - <%= shift.getEndTime() %>)</option>
                <%
                        }
                    }
                %>
            </select>
        </div>

        <div class="button-container">
            <button type="submit">Assign Trainer</button>
            <a href="${pageContext.request.contextPath}/admin/trainer_shifts" class="back-button">Back to Trainer Shifts</a>
        </div>
    </form>
</div>
</body>
</html>
