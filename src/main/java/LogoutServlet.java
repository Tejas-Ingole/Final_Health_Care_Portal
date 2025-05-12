import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public LogoutServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Invalidate session to log out the user
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate(); // Invalidates the session and removes all session attributes
        }

        // Clear cookies if they exist
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("userEmail".equals(cookie.getName()) || "userRole".equals(cookie.getName())) {
                    cookie.setMaxAge(0); // Set cookie expiry time to 0 to remove it
                    response.addCookie(cookie);
                }
            }
        }

        // Prevent the page from being cached by the browser
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0
        response.setDateHeader("Expires", 0); // Proxies

        // Redirect to login page
        response.sendRedirect("login.html?msg=You+have+logged+out+successfully");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
