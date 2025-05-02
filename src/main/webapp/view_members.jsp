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

        // Create statement
        Statement stmt = conn.createStatement();

        // Execute query
        ResultSet rs = stmt.executeQuery("SELECT * FROM users");

        // Process results
        while(rs.next()) {
          String memberName = rs.getString("name");
          String memberEmail = rs.getString("email");
          String memberPhone = rs.getString("phone");
          Date startDate = rs.getDate("membership_start_date");
          Date endDate = rs.getDate("membership_end_date");
          // You would need to add a status column to your table or manage it separately
          String status = rs.getString("attendance"); // Default status
    %>
    <tr>
      <td><%= memberName %></td>
      <td><%= memberEmail %></td>
      <td><%= memberPhone %></td>
      <td><%= startDate %></td>
      <td><%= endDate %></td>
    </tr>
    <%
        }

        // Close connections
        rs.close();
        stmt.close();
        conn.close();
      } catch (Exception e) {
        out.println("<tr><td colspan='7'>Error: " + e.getMessage() + "</td></tr>");
      }
    %>
    </tbody>
  </table>
</div>

<script>
  const contextPath = '<%= request.getContextPath() %>';

  function checkIn(phone) {
    window.location.href = contextPath + '/CheckIn.jsp?phone=' + encodeURIComponent(phone);
  }

  function checkOut(phone) {
    window.location.href = contextPath + '/CheckOut.jsp?phone=' + encodeURIComponent(phone);
  }


</script>
</body>
</html>