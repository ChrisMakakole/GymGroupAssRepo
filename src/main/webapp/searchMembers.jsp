<%@ page isELIgnored="true" import="java.util.*,java.sql.*" %>
<%
    String query = request.getParameter("query");
    List<String> members;
    // Dummy list - replace this with database logic
    members = Arrays.asList("Alice", "Bob", "Charlie", "David", "Diana");
    
    for (String name : members) {
        if (name.toLowerCase().contains(query.toLowerCase())) {
%>
            <div style="padding: 8px; border-bottom: 1px solid #ddd;"><%= name %></div>
<%
        }
    }
%>
