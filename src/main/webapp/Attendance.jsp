<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.net.URLEncoder"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gym Member Management</title>
    <style>
        #body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #3498db;
            color: white;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .action-btn {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            color: white;
            font-weight: bold;
        }
        .check-in {
            background-color: #2ecc71;
        }
        .check-out {
            background-color: #e74c3c;
        }
        .status {
            padding: 4px 8px;
            border-radius: 4px;
            font-weight: bold;
        }
        .checked-in {
            background-color: #d4edda;
            color: #155724;
        }
        .checked-out {
            background-color: #f8d7da;
            color: #721c24;
        }
        .already-checked-in {
            color: orange;
        }
    </style>
</head>
<body id="body">
<div class="container">
    <h1>Gym Member Management</h1>

    <table>
        <thead>
        <tr>
            <th>Name</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Membership Start</th>
            <th>Membership End</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <%
            // Database connection parameters
            String url = "jdbc:mysql://localhost:3306/gym_management?useSSL=false";
            String user = "root";
            String password = "12345";

            try {
                // Load JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Create connection
                Connection conn = DriverManager.getConnection(url, user, password);

                // Prepare statement to get user data and today's attendance status
                String query = "SELECT u.name, u.email, u.phone, u.membership_start_date, u.membership_end_date, " +
                        "CASE WHEN a.check_in_time IS NOT NULL AND a.check_out_time IS NULL THEN 'Checked In' " +
                        "     WHEN a.check_out_time IS NOT NULL THEN 'Checked Out' " +
                        "     ELSE 'Not Checked In' END AS attendance_status " +
                        "FROM users u " +
                        "LEFT JOIN attendance a ON u.phone = a.phone AND a.attendance_date = CURDATE()";
                try (PreparedStatement pstmt = conn.prepareStatement(query);
                     ResultSet rs = pstmt.executeQuery()) {

                    while(rs.next()) {
                        String memberName = rs.getString("name");
                        String memberEmail = rs.getString("email");
                        String memberPhone = rs.getString("phone");
                        Date startDate = rs.getDate("membership_start_date");
                        Date endDate = rs.getDate("membership_end_date");
                        String attendanceStatus = rs.getString("attendance_status");
        %>
        <tr>
            <td><%= memberName %></td>
            <td><%= memberEmail %></td>
            <td><%= memberPhone %></td>
            <td><%= startDate %></td>
            <td><%= endDate %></td>
            <td><span class="status <%= attendanceStatus.toLowerCase().replace(" ", "-") %>"><%= attendanceStatus %></span></td>
            <td>
                <% if (!"Checked In".equals(attendanceStatus)) { %>
                <button class="action-btn check-in"
                        onclick="window.location.href='CheckIn.jsp?name=<%= URLEncoder.encode(memberName, "UTF-8") %>&phone=<%= memberPhone %>&startDate=<%= startDate %>&endDate=<%= endDate %>'" >
                    Check In
                </button>
                <% } else { %>
                <button class="action-btn check-in" disabled style="background-color: gray; cursor: not-allowed;">
                    Checked In
                </button>
                <% } %>

                <% if ("Checked In".equals(attendanceStatus)) { %>
                <button class="action-btn check-out"
                        onclick="window.location.href='CheckOut.jsp?name=<%= URLEncoder.encode(memberName, "UTF-8") %>&phone=<%= memberPhone %>&startDate=<%= startDate %>&endDate=<%= endDate %>'" >
                    Check Out
                </button>
                <% } else { %>
                <button class="action-btn check-out" disabled style="background-color: gray; cursor: not-allowed;">
                    Check Out
                </button>
                <% } %>
            </td>
        </tr>
        <%
                    }
                }

                // Close connection
                conn.close();
            } catch (Exception e) {
                out.println("<tr><td colspan='7'>Error: " + e.getMessage() + "</td></tr>");
            }
        %>
        </tbody>
    </table>
</div>
</body>
</html>