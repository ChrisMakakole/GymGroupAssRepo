<%@ page isELIgnored="true" import="java.util.*,java.sql.*,java.util.Date" %>
<%
    String url = "jdbc:mysql://localhost:3306/gym_management?useSSL=false";
    String user = "root";
    String password = "12345";

    String query = request.getParameter("query");

    List<String> members = new ArrayList<>();

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
        while (rs.next()) {
            String memberName = rs.getString("name");
            members.add(memberName); 
        }

        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        out.println("<div style='color:red;'>Error: " + e.getMessage() + "</div>");
    }

    for (String name : members) {
        if (name.toLowerCase().contains(query.toLowerCase())) {
%>
            <div style="padding: 8px; border-bottom: 1px solid #ddd;"><%= name %></div>
<%
        }
    }
%>