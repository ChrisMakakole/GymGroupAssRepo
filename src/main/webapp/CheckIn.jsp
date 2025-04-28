<%@ page import="java.sql.*" %>
<%
    String phone = request.getParameter("checkInP");
    if (phone != null) {
        // Perform the database update to set attendance to 'Checked In'
        // Example:
        String url = "jdbc:mysql://localhost:3306/GymManagement?useSSL=false";
        String user = "root";
        String password = "59908114";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, user, password);

            PreparedStatement ps = conn.prepareStatement("UPDATE users SET attendance = 'In' WHERE phone = ?");
            ps.setString(1, phone);
            int rowsUpdated = ps.executeUpdate();

            if (rowsUpdated > 0) {
%>
                <p>Member with phone <%= phone %> successfully checked in.</p>
                <a href="index.jsp">Go back</a> <!-- Replace with your main page -->
<%
            } else {
%>
                <p>No member found with phone <%= phone %>.</p>
                <a href="index.jsp">Go back</a>
<%
            }

            ps.close();
            conn.close();
        } catch (Exception e) {
%>
            <p>Error: <%= e.getMessage() %></p>
            <a href="index.jsp">Go back</a>
<%
        }
    } else {
%>
        <p>Phone number not provided.</p>
        <a href="index.jsp">Go back</a>
<%
    }
%>
