import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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

        // Get parameters from request (GET method)
        String email = request.getParameter("id");    // HTML form uses "id" as the name for email
        String password = request.getParameter("pass"); // "pass" is the name for password
        String role = request.getParameter("role");

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            String url = "jdbc:mysql://localhost:3307/HealthCarePortal";
            String user = "root";
            String pass = "root";

            // Load JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // 1. Check for existing cookie
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    // Check if the cookie name matches the current email
                    if ("userEmail".equals(cookie.getName())) {
                        // Optional: verify password for extra security (less secure than server-side validation)
                        if (cookie.getValue().equals(password)) {
                            redirectToRolePage(role, response);
                            return;
                        }
                    }
                }
            }

            // Correct SQL query with proper column names
            String query = "SELECT * FROM users WHERE email = ? AND password_hash = ? AND role = ?";

            // 2. Connect to database and validate credentials
            conn = DriverManager.getConnection(url, user, pass);

            email = email.trim(); // Trim any spaces from the email
            password = password.trim();
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            pstmt.setString(3, role);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                // Valid login, create cookies and redirect
                Cookie emailCookie = new Cookie("userEmail", email); // Save email in cookie
                emailCookie.setMaxAge(3600); // 1 hour
                response.addCookie(emailCookie);

                Cookie roleCookie = new Cookie("userRole", role); // Save role in cookie
                roleCookie.setMaxAge(3600); // 1 hour
                response.addCookie(roleCookie);

                redirectToRolePage(role, response);
            } else {
                // Invalid credentials, redirect to login page
            	response.sendRedirect("login.html?msg=Incorrect+username+or+password+or+role");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h3>Error: " + e.getMessage() + "</h3>");
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
    }
    
    private void redirectToRolePage(String role, HttpServletResponse response) throws IOException {
        switch (role) {
            case "user":
                response.sendRedirect("userDashboard.html");
                break;
            case "admin":
                response.sendRedirect("adminDashboard.html");
                break;
            case "doctor":
                response.sendRedirect("doctorDashboard.html");
                break;
            default:
                response.sendRedirect("login.html?msg=Invalid+role");
                break;
        }
    }
}
