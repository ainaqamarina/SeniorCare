<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    
    <!-- Include Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <style>
        /* Sidebar Styles */
        .sidebar {
            width: 250px;
            height: 100%;
            background-color: #ffffff; /* Light background */
            padding-top: 20px;
            position: fixed;
            left: 0;
            top: 0;
            border-right: 1px solid #e0e0e0; /* Subtle border */
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1); /* Light shadow */
            transition: width 0.3s;
        }

        .sidebar h2 {
            color: #333; /* Dark text for contrast */
            text-align: center;
            font-size: 1.8rem;
            margin-bottom: 30px;
            font-weight: normal;
        }

        .sidebar a {
            display: flex;
            align-items: center;
            color: #555; /* Dark text for links */
            padding: 12px 20px;
            text-decoration: none;
            font-size: 1rem;
            margin-bottom: 15px;
            border-radius: 5px;
            transition: background-color 0.3s, color 0.3s;
        }

        .sidebar a i {
            margin-right: 10px; /* Space between icon and text */
        }

        .sidebar a:hover {
            background-color: #f0f0f0; /* Light grey on hover */
            color: #2980b9; /* Highlight color for text on hover */
        }
    </style>
</head>
<body>

<div class="sidebar">
    <h2>SeniorCare</h2>
    <a href="AdminDashboard.jsp"><i class="fas fa-user-shield"></i> Admin Dashboard</a>
    <a href="RoomAdmin.jsp"><i class="fas fa-bed"></i> Room Registration</a>
    <a href="TherapyAdmin.jsp"><i class="fas fa-user-md"></i> Therapy Registration</a>
    <a href="AdminRoomList.jsp"><i class="fas fa-list"></i> Room List</a>
    <a href="AdminTherapyList.jsp"><i class="fas fa-list-alt"></i> Therapy List</a>
    <a href="RoomList.jsp"><i class="fas fa-calendar-alt"></i> Room Booking List</a>
    <a href="TherapyList.jsp"><i class="fas fa-calendar-check"></i> Therapy Booking List</a>
</div>

</body>
</html>