import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public LoginServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String email = request.getParameter("id");     // From login form: name="id"
        String password = request.getParameter("pass"); // From login form: name="pass"
        String role = request.getParameter("role");     // From login form: name="role"

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // JDBC setup
            String url = "jdbc:mysql://localhost:3307/HealthCarePortal";
            String user = "root";
            String pass = "root";

            Class.forName("com.mysql.cj.jdbc.Driver");

            // Trim inputs
            email = email.trim();
            password = password.trim();

            // Check database for credentials
            String query = "SELECT * FROM users WHERE email = ? AND password_hash = ? AND role = ?";
            conn = DriverManager.getConnection(url, user, pass);
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, email);
            pstmt.setString(2, password); // Ideally, this should be hashed
            pstmt.setString(3, role);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                // Valid login - create session
                HttpSession session = request.getSession(true); // create new session
                String userName = rs.getString("name");
                session.setAttribute("userName", userName);
                session.setAttribute("role", role);

                // Optionally create cookies
                Cookie emailCookie = new Cookie("userEmail", email);
                emailCookie.setMaxAge(3600); // 1 hour
                response.addCookie(emailCookie);

                Cookie roleCookie = new Cookie("userRole", role);
                roleCookie.setMaxAge(3600); // 1 hour
                response.addCookie(roleCookie);

                // Redirect to appropriate dashboard
                redirectToRolePage(role, response);
            } else {
                // Invalid credentials
                response.sendRedirect("login.html?msg=Incorrect+username+or+password+or+role");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h3>Login Error: " + e.getMessage() + "</h3>");
        } finally {
            // Clean up JDBC
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
    }

    // Redirect to dashboards based on role
    private void redirectToRolePage(String role, HttpServletResponse response) throws IOException {
        switch (role.toLowerCase()) {
            case "user":
                response.sendRedirect("userDashboard.jsp");
                break;
            case "admin":
                response.sendRedirect("adminDashboard.jsp");
                break;
            case "doctor":
                response.sendRedirect("doctorDashboard.jsp");
                break;
            default:
                response.sendRedirect("login.html?msg=Invalid+role");
                break;
        }
    }
}
