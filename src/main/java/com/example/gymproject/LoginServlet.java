import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/GymManament?useSSL=false";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "59908114";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
                
                String sql = "SELECT * FROM login WHERE username = ? AND password = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, username);
                    stmt.setString(2, password);
                    
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            // Successful login
                            HttpSession session = request.getSession();
                            session.setAttribute("username", username);
                            response.sendRedirect("dashboard.jsp");
                        } else {
                            // Invalid credentials
                            request.setAttribute("errorMessage", "Invalid username or password");
                            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
                        }
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error occurred");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }
}