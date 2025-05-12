<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Book Appointment - MedicalCare</title>
    <link rel="stylesheet" href="appointment.css">
</head>
<body>

<div class="container">
    <h2>Book an Appointment</h2>
    <form action="BookAppointmentServlet" method="post">

        <label for="specialization">Select Specialization</label>
        <select id="specialization" name="specialization" required onchange="loadDoctors(this.value)">
            <option value="">-- Select Specialization --</option>
            <option value="Cardiologist">Cardiologist</option>
            <option value="Neurologist">Neurologist</option>
            <option value="Pediatrician">Pediatrician</option>
            <option value="Radiologist">Radiologist</option>
            <option value="Orthopedic Surgeon">Orthopedic Surgeon</option>
        </select>

        <label for="doctor">Select Doctor</label>
        <select id="doctor" name="doctor" required>
            <option value="">-- Select Doctor --</option>
            <!-- Filled by JS -->
        </select>

        <label>Appointment Type</label>
        <div class="radio-group">
            <label><input type="radio" name="appointmentType" value="Online" required> Online</label>
            <label><input type="radio" name="appointmentType" value="Offline" required> Offline</label>
        </div>

        <label for="date">Appointment Date</label>
        <input type="date" id="date" name="date" required>

        <label for="time">Appointment Time</label>
        <input type="time" id="time" name="time" required>

        <button type="submit">Book Appointment</button>
    </form>
</div>

<script>
    // Example: You can replace this with AJAX from server
    const doctorData = {
        "Cardiologist": ["Dr. Aarti Mehta", "Dr. Ramesh Pawar"],
        "Neurologist": ["Dr. Rajiv Malhotra"],
        "Pediatrician": ["Dr. Sneha Patil"],
        "Radiologist": ["Dr. Nisha Kaur"],
        "Orthopedic Surgeon": ["Dr. Vikram Joshi"]
    };

    function loadDoctors(specialty) {
        const doctorSelect = document.getElementById("doctor");
        doctorSelect.innerHTML = '<option value="">-- Select Doctor --</option>';

        if (specialty in doctorData) {
            doctorData[specialty].forEach(doctor => {
                const opt = document.createElement("option");
                opt.value = doctor;
                opt.textContent = doctor;
                doctorSelect.appendChild(opt);
            });
        }
    }
</script>

</body>
</html>
