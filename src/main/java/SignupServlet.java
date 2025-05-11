import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.*;

/**
 * Servlet implementation class SignupServlet
 */
@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SignupServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

       // Get parameters from URL or form with method="get"
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("pass");
        String role = request.getParameter("role");

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
        	String url="jdbc:mysql://localhost:3307/HealthCarePortal";
        	String user="root";
        	String pass="root";
        	// SQL insert statement
            String query = "INSERT INTO users (name, email, password_hash, role) VALUES (?, ?, ?, ?)";
            // Load JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Connect to database (update with your actual DB name, username, password)
            
            conn = DriverManager.getConnection(url, user, pass);

            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, name);
            pstmt.setString(2, email);
            pstmt.setString(3, password);
            pstmt.setString(4, role);

            int rows = pstmt.executeUpdate();

            if (rows > 0) {
                // Successful signup → redirect to login page with success message
                response.sendRedirect("login.html?message=Signup successful! Please login.");
                
            } else {
                // Failed signup → redirect to signup page with error
                response.sendRedirect("signup.html?error=Signup failed. Try again.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            // Redirect with error message
            response.sendRedirect("signup.html?error=Error occurred during signup.");
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
	}

}