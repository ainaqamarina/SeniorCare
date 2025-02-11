<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="util.DBConnection" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Senior Care Booking</title>
    <style>
        /* Global Styles */
        body {
            font-family: 'Roboto', Arial, sans-serif;
            background-color: #ffffff;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        /* Hero Section */
        .hero {
            width: 100%;
            height: 400px;
            background: url('images/seniorcarebg3.png') no-repeat center center/cover;
            position: relative;
            display: flex;
            flex-direction: column; /* Change to column for vertical layout */
            justify-content: center;
            align-items: center;
            text-align: center;
            color: white;
            font-size: 36px;
            font-weight: bold;
            text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.6);
        }

        /* Overlay */
        .hero::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
        }

        /* Hero Title */
        .hero h1 {
            position: relative;
            font-size: 1.2em;
            z-index: 1;
            margin-top: 40px; /* Remove default margin */
        }

        /* Search and Filter Form */
        .search-filter-form {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 10px;
            padding: 20px;
            margin-top: 10px; /* Space below the title */
            background: #f9f9f9;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            z-index: 2; /* Ensure it is above other elements */
        }

        .search-filter-form input,
        .search-filter-form select,
        .search-filter-form button {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }

        .search-filter-form button {
            background-color: #658735;
            color: white;
            cursor: pointer;
        }

        .search-filter-form button:hover {
            background-color: #66bb6a;
        }

        /* Main Content */
        .main-content {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            padding: 20px;
            max-width: 1200px;
            width: 100%;
        }

        .room-section {
            background: #ffffff;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            margin: 20px;
            width: calc(33% - 40px);
            transition: transform 0.3s ease-in-out;
            overflow: hidden;
        }

        .room-section:hover {
            transform: translateY(-5px);
        }

        .room-section img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .room-info {
            padding: 20px;
            text-align: center;
        }

        .room-title {
            font-size: 20px;
            color: black;
            margin-bottom: 10px;
        }

        .room-price {
            font-size: 18px;
            color: #658735;
            font-weight: bold;
            margin-bottom: 15px;
        }

        .booking-button {
            display: inline-block;
            background-color: #658735;
            color: #ffffff;
            padding: 12px 20px;
            border-radius: 50px;
            text-decoration: none;
        }

        .booking-button:hover {
            background-color: #66bb6a;
        }
    </style>
</head>
<body>

<%@ include file="Navbar.jsp" %>

<!-- Hero Section -->
<div class="hero">
    <h1>Senior Care Booking - Find Your Perfect Room</h1>

    <!-- Search and Filter Form -->
    <form method="GET" action="<%= request.getContextPath()%>/UserRoomPackage.jsp" class="search-filter-form">
        <input type="text" name="searchQuery" placeholder="Search room name..." value="<%= request.getParameter("searchQuery") != null ? request.getParameter("searchQuery") : ""%>">

        <select name="sortOrder">
            <option value="">Sort By</option>
            <option value="asc" <%= "asc".equals(request.getParameter("sortOrder")) ? "selected" : ""%>>Price: Low to High</option>
            <option value="desc" <%= "desc".equals(request.getParameter("sortOrder")) ? "selected" : ""%>>Price: High to Low</option>
        </select>

        <input type="number" name="minPrice" placeholder="Min Price" min="0" value="<%= request.getParameter("minPrice") != null ? request.getParameter("minPrice") : ""%>">
        <input type="number" name="maxPrice" placeholder="Max Price" min="0" value="<%= request.getParameter("maxPrice") != null ? request.getParameter("maxPrice") : ""%>">

        <button type="submit">Apply</button>
    </form>
</div>

<!-- Main Content Section -->
<main class="main-content">
    <%
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            if (conn == null) {
                out.println("<p style='color:red;'>Database connection failed!</p>");
            } else {
                // Retrieve search and filter parameters
                String searchQuery = request.getParameter("searchQuery");
                String sortOrder = request.getParameter("sortOrder");
                String minPrice = request.getParameter("minPrice");
                String maxPrice = request.getParameter("maxPrice");

                // Base SQL Query
                String sql = "SELECT room_id, room_package, room_picture, room_price FROM Room WHERE 1=1";

                // Append Search Filter
                if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                    sql += " AND room_package LIKE ?";
                }

                // Append Price Range Filter
                if (minPrice != null && !minPrice.isEmpty()) {
                    sql += " AND room_price >= ?";
                }
                if (maxPrice != null && !maxPrice.isEmpty()) {
                    sql += " AND room_price <= ?";
                }

                // Append Sorting
                if ("asc".equals(sortOrder)) {
                    sql += " ORDER BY room_price ASC";
                } else if ("desc".equals(sortOrder)) {
                    sql += " ORDER BY room_price DESC";
                }

                ps = conn.prepareStatement(sql);

                // Set Query Parameters
                int paramIndex = 1;
                if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                    ps.setString(paramIndex++, "%" + searchQuery + "%");
                }
                if (minPrice != null && !minPrice.isEmpty()) {
                    ps.setDouble(paramIndex++, Double.parseDouble(minPrice));
                }
                if (maxPrice != null && !maxPrice.isEmpty()) {
                    ps.setDouble(paramIndex++, Double.parseDouble(maxPrice));
                }

                rs = ps.executeQuery();
                DecimalFormat df = new DecimalFormat("#,##0.00");
                boolean hasData = false;

                while (rs.next()) {
                    hasData = true;
                    String roomId = rs.getString("room_id");
                    String roomName = rs.getString("room_package");
                    String roomImage = rs.getString("room_picture");
                    double roomPrice = rs.getDouble("room_price");
    %>

    <div class="room-section">
        <img src="uploads/<%= roomImage%>" alt="<%= roomName%>" 
             onerror="this.onerror=null; this.src='uploads/default.jpg';">
        <div class="room-info">
            <div class="room-title"><%= roomName%></div>
            <div class="room-price">RM <%= df.format(roomPrice)%> Per Day</div>
            <a href="UserBookRoom.jsp?roomId=<%= roomId%>" class="booking-button">Book Now</a>
        </div>
    </div>

    <%
                }
                if (!hasData) {
                    out.println("<p style='color:red;'>No rooms match your search criteria.</p>");
                }
            }
        } catch (Exception e) {
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    %>
</main>
<%@ include file="footer.jsp" %>
</body>
</html>