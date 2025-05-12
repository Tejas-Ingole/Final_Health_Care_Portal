<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    // Disable browser caching and ensure the user is logged in
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies

    // Check if the session is valid and the user is logged in
    if (session == null || session.getAttribute("userName") == null) {
        response.sendRedirect("login.html?msg=Please+login+first");
        return;
    }

    String userName = (String) session.getAttribute("userName"); // Assuming you store userName in session
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>User Dashboard - MedicalCare</title>
  <link rel="stylesheet" href="userDash.css">
</head>
<body>

  <!-- Sidebar -->
  <div id="sidebar" class="sidebar">
    <a href="javascript:void(0)" class="closebtn" onclick="closeSidebar()">&times;</a>
    <a href="#">Profile</a>
    <a href="#">Medical History</a>
    <a href="#">Book Appointment</a>
    <a href="#">Chat</a>
    <a href="#">Prescriptions</a>
    <a href="#">Support</a>
    <hr>
    <a href="about.html">About Hospital</a>
    <a href="facility.html">Facilities</a>
    <a href="doctors.html">Doctors</a>
    <a href="index.html#contact">Contact</a>

    <div class="logout-section">
      <a href="LogoutServlet" class="logout-btn">Logout</a>
    </div>    
  </div>

  <!-- Header -->
  <div class="header">
    <div class="logo">MedicalCare</div>
    <span class="menu-icon" onclick="openSidebar()">&#9776;</span>
  </div>

  <!-- Main Content -->
  <div class="main-content">
    <h1>Welcome, <%= userName %>!</h1> <!-- Display user email from session -->
    <p>Manage your healthcare activities, appointments, and records all in one place.</p>

    <div class="dashboard-grid">
      <div class="card">
        <h2>Book Appointment</h2>
        <p>Schedule your next visit easily.</p>
        <a href="#">Book Now</a>
      </div>

      <div class="card">
        <h2>Medical History</h2>
        <p>Access your health records anytime.</p>
        <a href="#">View History</a>
      </div>

      <div class="card">
        <h2>Profile</h2>
        <p>Update your personal information.</p>
        <a href="#">Edit Profile</a>
      </div>

      <div class="card">
        <h2>Chat with Doctor</h2>
        <p>Get advice from specialists instantly.</p>
        <a href="#">Start Chat</a>
      </div>

      <div class="card">
        <h2>Prescriptions</h2>
        <p>View your prescribed medicines.</p>
        <a href="#">See Prescriptions</a>
      </div>

      <div class="card">
        <h2>Support</h2>
        <p>Need help? Contact our team 24/7.</p>
        <a href="#">Contact Us</a>
      </div>
    </div>
  </div>

  <!-- Footer -->
  <footer class="footer">
    <p>&copy; 2025 MedicalCare Hospital. All rights reserved.</p>
  </footer>

  <!-- JavaScript -->
  <script>
    function openSidebar() {
      document.getElementById("sidebar").style.width = "250px";
    }

    function closeSidebar() {
      document.getElementById("sidebar").style.width = "0";
    }
  </script>

</body>
</html>
