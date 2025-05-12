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
  <title>Doctor Dashboard - MedicalCare</title>
  <link rel="stylesheet" href="doctorDash.css">
</head>
<body>

  <div id="sidebar" class="sidebar">
    <a href="javascript:void(0)" class="closebtn" onclick="closeSidebar()">&times;</a>
    <a href="#">My Profile</a>
    <a href="#">Patient List</a>
    <a href="#">Appointments</a>
    <a href="#">Medical Records</a>
    <a href="#">Prescriptions</a>
    <a href="#">Messages</a>
    <hr>
    <a href="index.html">Home</a>
    <a href="LogoutServlet" class="logout-btn">Logout</a>
  </div>

  <div class="header">
    <div class="logo">MedicalCare</div>
    <span class="menu-icon" onclick="openSidebar()">&#9776;</span>
  </div>

  <div class="main-content">
    <h1>Welcome, Doctor <%= userName %>!</h1> <!-- Display user email from session -->
    

    <div class="dashboard-grid">
      <div class="card">
        <h2>Appointments</h2>
        <p>View and manage upcoming appointments.</p>
        <a href="#">Manage</a>
      </div>

      <div class="card">
        <h2>Patients</h2>
        <p>Access patient health details.</p>
        <a href="#">View Patients</a>
      </div>

      <div class="card">
        <h2>Write Prescriptions</h2>
        <p>Create or update prescriptions.</p>
        <a href="#">Prescribe</a>
      </div>

      <div class="card">
        <h2>Messages</h2>
        <p>Communicate with your patients.</p>
        <a href="#">Open Chat</a>
      </div>
    </div>
  </div>

  <footer class="footer">
    <p>&copy; 2025 MedicalCare Hospital. All rights reserved.</p>
  </footer>

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