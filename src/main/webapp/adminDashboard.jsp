<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Gym Management Dashboard</title>
  <style>
    #body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 20px;
      background-color: #f5f5f5;
    }
    .dashboard {
      max-width: 1200px;
      margin: 0 auto;
    }
    .metrics {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 20px;
      margin-bottom: 30px;
    }
    .metric-card {
      background: white;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    .metric-value {
      font-size: 24px;
      font-weight: bold;
      margin: 10px 0;
    }
    .metric-trend {
      font-size: 14px;
      color: #666;
    }
    .up {
      color: green;
    }
    .down {
      color: red;
    }
    .section {
      background: white;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 2px 4px rgba(0,0,0,0.1);
      margin-bottom: 30px;
    }
    table {
      width: 100%;
      border-collapse: collapse;
    }
    th, td {
      padding: 12px 15px;
      text-align: left;
      border-bottom: 1px solid #ddd;
    }
    th {
      background-color: #f2f2f2;
    }
    .active {
      color: green;
    }
    .expired {
      color: red;
    }
  </style>
</head>
<body id="body">
<div class="dashboard">
  <h1>Gym Management Dashboard</h1>

  <div class="metrics">
    <%
      // Database connection details
      String url = "jdbc:mysql://localhost:3306/gym_management?useSSL=false";
      String user = "root";
      String password = "12345";

      int totalMembers = 0;
      int activeMembers = 0;
      double totalRevenue = 0;
      int todaysAttendance = 0;

      try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection(url, user, password);

        // Get total members
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM users");
        if(rs.next()) totalMembers = rs.getInt(1);

        // Get active members (membership_end_date >= current date)
        rs = stmt.executeQuery("SELECT COUNT(*) FROM users WHERE membership_end_date >= CURDATE()");
        if(rs.next()) activeMembers = rs.getInt(1);

        // Get total revenue
        rs = stmt.executeQuery("SELECT SUM(amount) FROM payments");
        if(rs.next()) totalRevenue = rs.getDouble(1);

        // Get today's attendance
        rs = stmt.executeQuery("SELECT COUNT(*) FROM attendance WHERE attendance_date = CURDATE() AND check_out_time IS NULL");
        if(rs.next()) todaysAttendance = rs.getInt(1);

        conn.close();
      } catch(Exception e) {
        out.println("Error: " + e.getMessage());
      }
    %>

    <div class="metric-card">
      <h3>Total Members</h3>
      <div class="metric-value"><%= totalMembers %></div>
      <div class="metric-trend">↔ No change from yesterday</div>
    </div>

    <div class="metric-card">
      <h3>Active Memberships</h3>
      <div class="metric-value"><%= activeMembers %> (<%= Math.round((activeMembers * 100.0) / totalMembers) %>%)</div>
      <div class="metric-trend down">↓ Down from yesterday</div>
    </div>

    <div class="metric-card">
      <h3>Total Revenue</h3>
      <div class="metric-value">M<%= String.format("%.2f", totalRevenue) %></div>
      <div class="metric-trend up">↑ Up from yesterday</div>
    </div>

    <div class="metric-card">
      <h3>Today's Attendance</h3>
      <div class="metric-value"><%= todaysAttendance %></div>
      <div class="metric-trend down">↓ Down from yesterday</div>
    </div>
  </div>

  <div class="section">
    <h2>Recent Memberships</h2>
    <table>
      <tr>
        <th>Name</th>
        <th>Membership Start</th>
        <th>Membership End</th>
        <th>Status</th>
      </tr>
      <%
        try {
          Class.forName("com.mysql.jdbc.Driver");
          Connection conn = DriverManager.getConnection(url, user, password);
          Statement stmt = conn.createStatement();
          ResultSet rs = stmt.executeQuery("SELECT name, membership_start_date, membership_end_date FROM users ORDER BY membership_start_date DESC LIMIT 3");

          while(rs.next()) {
            String statusClass = rs.getDate("membership_end_date").toLocalDate().isBefore(java.time.LocalDate.now()) ? "expired" : "active";
            String statusText = statusClass.equals("active") ? "Active" : "Expired";
      %>
      <tr>
        <td><%= rs.getString("name") %></td>
        <td><%= rs.getDate("membership_start_date") %></td>
        <td><%= rs.getDate("membership_end_date") %></td>
        <td class="<%= statusClass %>"><%= statusText %></td>
      </tr>
      <%
          }
          conn.close();
        } catch(Exception e) {
          out.println("Error: " + e.getMessage());
        }
      %>
    </table>
  </div>

  <div class="section">
    <h2>Today's Attendance</h2>
    <table>
      <tr>
        <th>Name</th>
        <th>Check-in Time</th>
      </tr>
      <%
        try {
          Class.forName("com.mysql.jdbc.Driver");
          Connection conn = DriverManager.getConnection(url, user, password);
          Statement stmt = conn.createStatement();
          ResultSet rs = stmt.executeQuery(
                  "SELECT u.name, check_in_time " +
                          "FROM attendance a " +
                          "JOIN users u ON a.phone = u.phone " +
                          "WHERE a.attendance_date = CURDATE() AND a.check_out_time IS NULL;"
          );

          while(rs.next()) {
      %>
      <tr>
        <td><%= rs.getString("name") %></td>
        <td>Morning</td>
      </tr>
      <%
          }
          conn.close();
        } catch(Exception e) {
          out.println("Error: " + e.getMessage());
        }
      %>
    </table>
  </div>

  <div class="section">
    <h2>Recent Payments</h2>
    <table>
      <tr>
        <th>Member</th>
        <th>Amount</th>
        <th>Date</th>
        <th>Status</th>
      </tr>
      <%
        try {
          Class.forName("com.mysql.jdbc.Driver");
          Connection conn = DriverManager.getConnection(url, user, password);
          Statement stmt = conn.createStatement();
          ResultSet rs = stmt.executeQuery(
                  "SELECT u.name, p.amount, p.payment_date " +
                          "FROM payments p " +
                          "LEFT JOIN users u ON p.user_name = u.name " +
                          "ORDER BY p.payment_date DESC LIMIT 3"
          );

          while(rs.next()) {
      %>
      <tr>
        <td><%= rs.getString("name") != null ? rs.getString("name") : "User " + rs.getInt("user_id") %></td>
        <td>M<%= String.format("%.2f", rs.getDouble("amount")) %></td>
        <td><%= rs.getDate("payment_date") %></td>
        <td>Processed</td>
      </tr>
      <%
          }
          conn.close();
        } catch(Exception e) {
          out.println("Error: " + e.getMessage());
        }
      %>
    </table>
  </div>

  <div class="section">
    <h2>Trainer Activity</h2>
    <table>
      <tr>
        <th>Trainer</th>
        <th>Specialty</th>
      </tr>
      <%
        try {
          Class.forName("com.mysql.jdbc.Driver");
          Connection conn = DriverManager.getConnection(url, user, password);
          Statement stmt = conn.createStatement();
          ResultSet rs = stmt.executeQuery(
                  "SELECT t.name, t.training_type FROM trainers t LEFT JOIN attendance a ON t.phone = a.phone AND a.attendance_date = CURDATE()GROUP BY t.name, t.training_type;"
          );

          while(rs.next()) {
      %>
      <tr>
        <td><%= rs.getString("name") %></td>
        <td><%= rs.getString("training_type") %></td>
      </tr>
      <%
          }
          conn.close();
        } catch(Exception e) {
          out.println("Error: " + e.getMessage());
        }
      %>
    </table>
  </div>
</div>
</body>
</html>