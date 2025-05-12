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
  <title>Admin Dashboard - MedicalCare</title>
  <link rel="stylesheet" href="adminDash.css">
</head>
<body>

  <div id="sidebar" class="sidebar">
    <a href="javascript:void(0)" class="closebtn" onclick="closeSidebar()">&times;</a>
    <a href="#">Manage Users</a>
    <a href="#">Manage Doctors</a>
    <a href="#">Appointments</a>
    <a href="#">Hospital Records</a>
    <a href="#">Support Tickets</a>
    <hr>
    <a href="index.html">Home</a>
    <a href="LogoutServlet" class="logout-btn">Logout</a>
  </div>

  <div class="header">
    <div class="logo">MedicalCare</div>
    <span class="menu-icon" onclick="openSidebar()">&#9776;</span>
  </div>

  <div class="main-content">
    <h1>Welcome, Admin <%= userName %>!</h1> <!-- Display user email from session -->
  

    <div class="dashboard-grid">
      <div class="card">
        <h2>User Management</h2>
        <p>Add, update or remove user accounts.</p>
        <a href="#">Manage Users</a>
      </div>

      <div class="card">
        <h2>Doctor Management</h2>
        <p>Approve or remove doctors from the system.</p>
        <a href="#">Manage Doctors</a>
      </div>

      <div class="card">
        <h2>Appointments</h2>
        <p>Monitor all hospital appointments.</p>
        <a href="#">View Appointments</a>
      </div>

      <div class="card">
        <h2>Hospital Records</h2>
        <p>Maintain official hospital documents and data.</p>
        <a href="#">Manage Records</a>
      </div>

      <div class="card">
        <h2>Support</h2>
        <p>Resolve user-submitted issues.</p>
        <a href="#">Support Tickets</a>
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