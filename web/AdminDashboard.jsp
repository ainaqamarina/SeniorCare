<%@page import="util.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.sql.*" %>

<%
    HttpSession userSession = request.getSession(false);
    String username = (userSession != null) ? (String) userSession.getAttribute("username") : null;
    String role = (userSession != null) ? (String) userSession.getAttribute("role") : null;

    // Redirect to login if not an admin
    if (username == null || !"admin".equals(role)) {
        response.sendRedirect("login.jsp?error=Unauthorized Access");
        return;
    }

    // Database connection
    int therapyBookingCount = 0;
    int roomBookingCount = 0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/seniorcare", "root", "password");
        Statement stmt = con.createStatement();

        // Get Therapy Booking Count
        ResultSet rs1 = stmt.executeQuery("SELECT COUNT(*) AS count FROM TherapyBookings");
        if (rs1.next()) {
            therapyBookingCount = rs1.getInt("count");
        }
        rs1.close();

        // Get Room Booking Count
        ResultSet rs2 = stmt.executeQuery("SELECT COUNT(*) AS count FROM RoomBookings");
        if (rs2.next()) {
            roomBookingCount = rs2.getInt("count");
        }
        rs2.close();

        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="css/FormRoom.css">
    <link rel="stylesheet" href="css/sidebar.css">  
    <link rel="icon" href="images/seniorcarebg3.png" type="image/png"> 

    <style>
        /* Global Styles */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            background-color: #ffffff; 
            color: #333; 
        }

        .main-content {
            margin-left: 250px;
            padding: 40px;
            flex: 1;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px;
            background-color: #f8f8f8;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }

        .header h1 {
            font-size: 2rem;
            color: #333;
            margin: 0;
        }

        .logout-btn {
            background-color: #e74c3c;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1rem;
            transition: background-color 0.3s;
        }

        .logout-btn:hover {
            background-color: #c0392b;
        }

        .section {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
        }

        .card {
            background-color: #ffffff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
            color: #333;
            text-align: center;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 15px rgba(41, 128, 185, 0.5);
        }

        .card h3 {
            font-size: 1.5rem;
            color: #333;
            margin-bottom: 15px;
        }

        .card p {
            font-size: 1rem;
            color: #555;
        }

        .card .btn {
            display: inline-block;
            margin-top: 15px;
            background-color: #2980b9;
            color: white;
            padding: 12px 20px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 1rem;
            transition: background-color 0.3s;
        }

        .card .btn:hover {
            background-color: #3498db;
        }

        footer {
            text-align: center;
            padding: 20px;
            background-color: #f8f8f8;
            color: #333;
            font-size: 0.9rem;
            margin-top: auto;
        }
        .analytics-container {
    display: flex;
    justify-content: space-between;
    gap: 20px;
    margin-bottom: 30px; /* Adds spacing below the analytics */
}

.analytics-container .card {
    flex: 1; /* Makes all cards equal width */
    min-width: 200px; /* Prevents cards from being too small */
    background-color: #2980b9; /* Dark Blue */
    color: white; /* White text for readability */
    border-radius: 8px;
    padding: 20px;
    text-align: center;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    transition: transform 0.3s, box-shadow 0.3s;
}

.analytics-container .card:hover {
    transform: translateY(-5px);
    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
}

.analytics-container .card h3 {
    font-size: 1.5rem;
    margin-bottom: 10px;
}

.analytics-container .card p {
    color: white;
    font-size: 1.2rem;
    font-weight: bold;
}

    </style>
</head>
<body>

    <jsp:include page="SidebarAdmin.jsp" />

    <div class="main-content">
        <div class="header">
            <h1>Welcome, <%= username %>!</h1>
            <form action="LogoutServlet" method="POST">
                <button type="submit" class="logout-btn">Logout</button>
            </form>
        </div>
<%
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    int userCount = 0;

    try {
        conn = DBConnection.getConnection(); // Ensure connection is properly established

        if (conn != null) {
            // Get Room Booking Count
            String sql1 = "SELECT COUNT(*) AS total FROM BOOKING"; 
            ps = conn.prepareStatement(sql1);
            rs = ps.executeQuery();
            if (rs.next()) {
                roomBookingCount = rs.getInt("total"); 
            }
            rs.close();
            ps.close();

            // Get Therapy Booking Count
            String sql2 = "SELECT COUNT(*) AS total FROM BOOKINGT"; 
            ps = conn.prepareStatement(sql2);
            rs = ps.executeQuery();
            if (rs.next()) {
                therapyBookingCount = rs.getInt("total"); 
            }
            rs.close();
            ps.close();

            // Get Total Users Count
            String sql3 = "SELECT COUNT(DISTINCT SENIOR_USERNAME) AS total FROM (SELECT SENIOR_USERNAME FROM BOOKING UNION SELECT SENIOR_USERNAME FROM BOOKINGT) AS Users";
            ps = conn.prepareStatement(sql3);
            rs = ps.executeQuery();
            if (rs.next()) {
                userCount = rs.getInt("total"); 
            }
        } else {
            out.println("<p style='color:red;'>Database connection failed!</p>");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<p style='color:red;'>Error retrieving analytics: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
        if (ps != null) try { ps.close(); } catch (SQLException ignored) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
    }
%>

<div class="analytics-container">
    <!-- Total Registered Users -->
    <div class="card">
        <h3>Total Users</h3>
        <p><%= userCount %></p>
    </div>

    <!-- Total Room Bookings -->
    <div class="card">
        <h3>Total Room Bookings</h3>
        <p><%= roomBookingCount %></p>
    </div>

    <!-- Total Therapy Bookings -->
    <div class="card">
        <h3>Total Therapy Bookings</h3>
        <p><%= therapyBookingCount %></p>
    </div>
</div>


        <div class="section">
            <div class="card">
                <h3>Room Registration</h3>
                <p>Register new room services and manage their availability.</p>
                <a href="RoomAdmin.jsp" class="btn">Go to Form</a>
            </div>

            <div class="card">
                <h3>Therapy Registration</h3>
                <p>Register new therapy sessions and assign therapists.</p>
                <a href="TherapyAdmin.jsp" class="btn">Go to Form</a>
            </div>

            <div class="card">
                <h3>Room List</h3>
                <p>Track and manage bookings for therapy sessions.</p>
                <a href="AdminRoomList.jsp" class="btn">View List</a>
            </div>

            <div class="card">
                <h3>Therapy List</h3>
                <p>Track and manage bookings for therapy sessions.</p>
                <a href="AdminTherapyList.jsp" class="btn">View List</a>
            </div>






            <div class="card">
                <h3>Room Booking List</h3>
                <p>View and manage bookings for room services.</p>
                <a href="RoomList.jsp" class="btn">View List</a>
            </div>

            <div class="card">
                <h3>Therapy Booking List</h3>
                <p>Track and manage bookings for therapy sessions.</p>
                <a href="TherapyList.jsp" class="btn">View List</a>
            </div>
        </div>
    </div>

    <footer>
        &copy; 2024 Senior Care Coordinate System. All rights reserved.
    </footer>

</body>
</html>
