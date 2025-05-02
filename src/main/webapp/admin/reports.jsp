<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.gymproject.model.Attendance" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gym Management Reports</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body {
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

        .report-options {
            margin-bottom: 20px;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            background-color: #f9f9f9;
        }

        .report-options h2 {
            color: #555;
            margin-top: 0;
            margin-bottom: 10px;
        }

        .report-options form {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .report-options label {
            font-weight: bold;
            color: #555;
        }

        .report-options select,
        .report-options input[type="date"] {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
        }

        .report-options button[type="submit"] {
            background-color: #007bff;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        .report-options button[type="submit"]:hover {
            background-color: #0056b3;
        }

        .report-output {
            margin-top: 20px;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            background-color: #f9f9f9;
        }

        .report-output h2 {
            color: #555;
            margin-top: 0;
            margin-bottom: 10px;
        }

        .report-output p {
            color: #333;
        }

        .report-output table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        .report-output th, .report-output td {
            padding: 8px;
            border-bottom: 1px solid #eee;
            text-align: left;
        }

        .report-output th {
            background-color: #f2f2f2;
            font-weight: bold;
        }

        .back-button-container {
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
<body>
<div class="container">
    <h1>Gym Management Reports</h1>

    <div class="report-options">
        <h2>Generate Reports</h2>
        <% if (request.getAttribute("reportError") != null) { %>
        <p class="error-message"><%= request.getAttribute("reportError") %></p>
        <% } %>
        <form action="${pageContext.request.contextPath}/admin/reports" method="get">
            <label for="reportType">Report Type:</label>
            <select id="reportType" name="reportType">
                <option value="member_attendance">Member Attendance</option>
                <option value="payment_summary">Payment Summary</option>
                <option value="package_usage">Package Usage</option>
            </select>

            <label for="startDate">Start Date:</label>
            <input type="date" id="startDate" name="startDate">

            <label for="endDate">End Date:</label>
            <input type="date" id="endDate" name="endDate">

            <button type="submit">Generate Report</button>
        </form>
    </div>

    <% if (request.getAttribute("reportType") != null) { %>
    <div class="report-output">
        <h2><%= request.getAttribute("reportTitle") %></h2>
        <% if (request.getAttribute("reportData") == null || ((java.util.List)request.getAttribute("reportData")).isEmpty()) { %>
        <p>No data available for the selected report criteria.</p>
        <% } else {
            String reportType = (String) request.getAttribute("reportType");
            if ("member_attendance".equals(reportType)) { %>
        <table>
            <thead>
            <tr>
                <th>Member Name</th>
                <th>Attendance Date</th>
                <th>Check-in Time</th>
                <th>Check-out Time</th>
            </tr>
            </thead>
            <tbody>
            <% java.util.List attendanceList = (java.util.List) request.getAttribute("reportData");
                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                for (Object attendanceObj : attendanceList) {
                    com.example.gymproject.model.Attendance attendance = (com.example.gymproject.model.Attendance) attendanceObj; %>
            <tr>
                <td><%= attendance.getUser().getName() %></td>
                <td><%= attendance.getAttendanceDate() %></td>
                <td><%= (attendance.getCheckInTime() != null) ? sdf.format(attendance.getCheckInTime()) : "" %></td>
                <td><%= (attendance.getCheckOutTime() != null) ? sdf.format(attendance.getCheckOutTime()) : "" %></td>
            </tr>
            <%  } %>
            </tbody>
        </table>
        <% } else if ("payment_summary".equals(reportType)) { %>
        <table>
            <thead>
            <tr>
                <th>Payment Date</th>
                <th>Total Amount</th>
                <th>Number of Payments</th>
            </tr>
            </thead>
            <tbody>
            <% java.util.List paymentSummaryList = (java.util.List) request.getAttribute("reportData");
                java.text.NumberFormat currencyFormat = java.text.NumberFormat.getCurrencyInstance(java.util.Locale.getDefault());
                for (Object summaryObj : paymentSummaryList) {
                    Object[] summary = (Object[]) summaryObj; %>
            <tr>
                <td><%= summary[0] %></td>
                <td><%= currencyFormat.format(summary[1]) %></td>
                <td><%= summary[2] %></td>
            </tr>
            <%  } %>
            </tbody>
        </table>
        <% } else if ("package_usage".equals(reportType)) { %>
        <table>
            <thead>
            <tr>
                <th>Package Name</th>
                <th>Number of Users</th>
            </tr>
            </thead>
            <tbody>
            <% java.util.List packageUsageList = (java.util.List) request.getAttribute("reportData");
                for (Object usageObj : packageUsageList) {
                    Object[] usage = (Object[]) usageObj; %>
            <tr>
                <td><%= usage[0] %></td>
                <td><%= usage[1] %></td>
            </tr>
            <%  } %>
            </tbody>
        </table>
        <% } else { %>
        <p>Report type not supported for display here.</p>
        <% } %>
        <% } %>
    </div>
    <% } %>

    <div class="back-button-container">
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="back-button">Back to Dashboard</a>
    </div>
</div>
</body>
</html>