<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="util.DBConnection" %> <!-- Ensure this path is correct -->
<%
    HttpSession sessionUser = request.getSession(false);
    String username = (sessionUser != null) ? (String) sessionUser.getAttribute("username") : null;

    // Redirect to login page if the user is not logged in
    if (username == null) {
        response.sendRedirect("login.jsp?error=Please login first");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>SeniorCare - Dashboard</title>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
        <link rel="icon" href="images/seniorcarebg3.png" type="image/png"> 
         <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>


            * {
                box-sizing: border-box;
            }

            body {
                margin: 0;
                font-family: 'Roboto', sans-serif; /* Use Roboto font */
            }

            nav {
                display: flex;
                justify-content: space-between;
                align-items: center;
                position: fixed;
                width: 100%;
                top: 0;
                z-index: 10;
                padding: 20px 45px; /* Added horizontal padding */
                transition: background-color 0.9s ease; /* Smooth transition for background color */
            }

            .logo {
                font-size: 24px;
                font-weight: bold;
                color: white;
            }

            ul {
                list-style: none;
                display: flex;
                padding: 0; /* Reset padding */
            }

            li {
                margin: 0 15px;
                font-size: 18px;
            }

            li a {
                text-decoration: none;
                color: white; /* Default link color */
            }

            li a:hover {
                color: #658735; /* Change text color on hover */
                text-shadow: 0 0 10px rgba(101, 135, 53, 0.8), 0 0 20px rgba(101, 135, 53, 0.6); /* Glowing effect */
            }

            .hero {
                background: url('images/seniorcarebg3.png') no-repeat center center/cover;
                height: 100vh;
                display: flex;
                align-items: center;
                justify-content: flex-start;
                text-align: left; /* Align text to the left */
                color: white;
                position: relative;
                padding: 20px;
            }

            .hero::before {
                content: "";
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
            }

            .hero-content {
                position: relative;
                z-index: 1;
                max-width: 600px;
                padding: 20px; /* Add padding for spacing */
            }

            .hero-content h1 {
                font-size: 3em;
                margin: 0;
                font-weight: 600; /* Make the heading bold */
            }

            .hero-content p {
                font-size: 1.2em;
                margin: 10px 0;
                line-height: 1.5; /* Better line spacing */
            }

            .hero .btn {
                display: inline-block;
                padding: 12px 30px; /* Increased padding */
                background: #658735;
                color: white;
                border-radius: 50px;
                text-decoration: none;
                margin-top: 20px;
                transition: background 0.3s;
                font-size: 1.2em;
                font-weight: 700; /* Bold button text */
            }

            .hero .btn:hover {
                background: #c7ddb5;
                color: #658735;
            }

            section {
                padding: 60px 20px;
                text-align: center;
            }
            .username {
                cursor: pointer;
                padding: 10px;
                background-color: #658735; /* Consistent background color */
                color: white;
                border-radius: 50px;
            }

            .room-section {
                background: #ffffff; /* Keep card white */
                border-radius: 15px;
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1); /* Softer shadow */
                margin: 20px;
                width: calc(33% - 40px); /* Ensure proper spacing */
                transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
                overflow: hidden;
            }

            .room-section:hover {
                transform: translateY(-5px);
                box-shadow: 0 12px 24px rgba(0, 0, 0, 0.2);
            }

            .room-section img {
                width: 100%;
                height: 200px;
                object-fit: cover;
                border-radius: 10px 10px 0 0;
                transition: transform 0.3s ease-in-out;
            }
            /* Dropdown styling */
            .dropdown {
                position: relative;
                display: inline-block;
            }

            .dropdown-content {
                display: none;
                position: absolute;
                background-color: white;
                min-width: 150px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
                z-index: 1;
                border-radius: 5px;
                right: 0;
            }

            .dropdown-content a {
                color: black;
                padding: 10px;
                display: block;
                text-decoration: none;
            }

            .dropdown-content a:hover {
                background-color: rgba(101, 135, 53, 0.2); /* Light background on hover */
            }

            .dropdown:hover .dropdown-content {
                display: block;
            }


            /* New class for the scrolled navbar */
            .scrolled {
                padding: 10px 45px; /* Reduced padding for smaller height */
                background-color: rgba(101, 135, 53, 0.9); /* Keep the background color */
            }

            /* Scrolled Navbar link hover */
            .scrolled li a:hover {
                color: black; /* Ensure that the text stays white when scrolled */
            }

            .room-section:hover img {
                transform: scale(1.05);
            }

            .room-info {
                padding: 20px;
                text-align: center;
            }

            .room-title {
                font-size: 20px;
                color: #2c3e50;
                margin-bottom: 10px;
            }

            .room-price {
                font-size: 18px;
                color: #658735; /* Direct color code */
                font-weight: bold;
                margin-bottom: 15px;
            }

            .booking-button {
                display: inline-block;
                background-color: #658735; /* Direct color code */
                color: #ffffff;
                padding: 12px 20px;
                border: none;
                border-radius: 50px; /* Pill shape */
                font-size: 16px;
                font-weight: bold;
                cursor: pointer;
                transition: background-color 0.3s, transform 0.2s;
                text-decoration: none;
            }

            .booking-button:hover {
                background-color: #66bb6a; /* Direct color code */
                transform: scale(1.05);
            }

            .therapy-packages {
                background: #E8F5E9; /* Light Green Background */
                padding: 40px 20px;
                text-align: center;
            }

            .therapy-section {
                background: #ffffff; /* Keep therapy cards white */
                border-radius: 15px;
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
                margin: 20px;
                width: calc(33% - 40px);
                transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
                overflow: hidden;
            }

            .therapy-section:hover {
                transform: translateY(-5px);
                box-shadow: 0 12px 24px rgba(0, 0, 0, 0.2);
            }

            .therapy-section img {
                width: 100%;
                height: 200px;
                object-fit: cover;
                border-radius: 10px 10px 0 0;
                transition: transform 0.3s ease-in-out;
            }

            .therapy-section:hover img {
                transform: scale(1.05);
            }

            .therapy-info {
                padding: 20px;
                text-align: center;
            }

            .therapy-title {
                font-size: 20px;
                color: black; /* Consistent green */
                margin-bottom: 10px;
            }

            .therapy-price {
                font-size: 18px;
                color: #658735; /* Direct color code */
                font-weight: bold;
                margin-bottom: 15px;
            }
            .therapy-button {
                display: inline-block;
                background-color: #658735; /* Direct color code */
                color: #ffffff;
                padding: 12px 20px;
                border: none;
                border-radius: 50px; /* Pill shape */
                font-size: 16px;
                font-weight: bold;
                cursor: pointer;
                transition: background-color 0.3s, transform 0.2s;
                text-decoration: none;
            }


            .therapy-button:hover {
                background-color: #66bb6a; /* Direct color code */
                transform: scale(1.05);
            }

            .see-more-button {
                background-color: #658735; /* Direct color code */
                color: white;
                padding: 10px 20px;
                border-radius: 50px; /* Pill shape */

                text-decoration: none;
                font-size: 16px;
                transition: background-color 0.3s;
            }

            .see-more-button:hover {
                background-color: #66bb6a; /* Direct color code */
            }

            /* Responsive Styles */
            @media (max-width: 768px) {
                .room-section, .therapy-section {
                    width: calc(50% - 40px);
                }
            }

            @media (max-width: 480px) {
                .room-section, .therapy-section {
                    width: calc(100% - 40px);
                }

                .room-title, .therapy-title {
                    font-size: 18px;
                }

                .room-price, .therapy-price {
                    font-size: 16px;
                }
            }

            .main-content {
                display: flex;
                flex-wrap: wrap; /* Allow wrapping */
                justify-content: space-between; /* Space between items */
                padding: 20px;
                width: 100%;
                max-width: 1200px;
                margin: 0 auto; /* Center the main content */
            }

            .room-section, .therapy-section {
                background: #ffffff; /* Keep card white */
                border-radius: 15px;
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1); /* Softer shadow */
                margin: 10px; /* Adjust margin for spacing */
                width: calc(33.33% - 20px); /* Set width to one third */
                transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
                overflow: hidden;
            }
            #contact {
                position: relative; /* Allow positioning of pseudo-elements */
                padding: 60px 20px;
                text-align: center; /* Set text alignment to center */
                overflow: hidden; /* Hide overflow for shapes */
                background: url('images/seniorcarebg3.png') no-repeat center center/cover; /* Set background image */
            }

            #contact::before {
                content: "";
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5); /* Black overlay with 80% opacity */


                z-index: 0; /* Behind the content */
            }

            #contact h1 {
                font-size: 2.5em;
                margin-bottom: 20px; /* Adjusted for better spacing */
                line-height: 1.5; /* Set line height */
                z-index: 1; /* Ensure it's above the overlay */
                position: relative; /* Position relative for z-index to work */
            }

            #contact p {
                font-size: 1em; /* Match the font size of the other paragraphs */
                margin-bottom: 30px; /* Space below paragraph */
                line-height: 1.5; /* Set line height */
                z-index: 1; /* Ensure it's above the overlay */
                position: relative; /* Position relative for z-index to work */
            }

            .contact-container {
                position: relative; /* Position relative for layering */
                z-index: 1; /* Bring content above shapes */
                display: flex; /* Align items side by side */
                justify-content: space-between; /* Space between contact info and form */
                max-width: 1000px; /* Limit the width of the container */
                margin: 20px auto; /* Center the container */
                padding: 20px; /* Add some padding */
            }

            .contact-info-container {
                flex: 1; /* Take up remaining space */
                margin-right: 20px; /* Space between the two containers */
                background-color: #f9f9f9; /* Light background for the container */
                border-radius: 10px; /* Rounded corners */
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); /* Subtle shadow */
                padding: 20px; /* Add padding */

            }

            .contact-info {
                display: flex;
                flex-direction: column; /* Stack the info items vertically */
                gap: 20px; /* Space between items */
                margin-top: 20px;
            }

            .info-item {
                display: flex; /* Use flexbox for alignment */
                align-items: center; /* Center items vertically */
                gap: 15px; /* Space between icon and text */
            }

            .info-item i {
                font-size: 24px; /* Size of the icon */
                color: #fff; /* Icon color */
                background-color: #658735; /* Background color for the circle */
                border-radius: 50%; /* Make it circular */
                width: 50px; /* Width of the circle */
                height: 50px; /* Height of the circle */
                display: flex; /* Use flexbox for centering the icon */
                justify-content: center; /* Center horizontally */
                align-items: center; /* Center vertically */
                margin-top: -30px; /* Move the icon up */
            }

            .contact-form-container {
                flex: 1; /* Take up remaining space */
                max-width: 400px; /* Limit the width of the form */
                background-color: #fff; /* White background for the form */
                border-radius: 10px; /* Rounded corners */
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); /* Subtle shadow */
                padding: 20px; /* Add padding */
            }
            .info-text {
                text-align: left; /* Align text to the left */
            }

            .info-text h3 {
                margin: 0; /* Remove default margin for better alignment */
                text-align: justify;
            }

            .info-text p {
                margin: 0; /* Remove default margin for better alignment */
                text-align: justify; /* Justify text */
                font-size: 1em; /* Adjust the size as needed (e.g., 1em, 1.2em, etc.) */
            }
            .contact-form h3 {
                margin-bottom: 20px; /* Space below heading */
            }

            .contact-form input, 
            .contact-form textarea {
                width: 100%; /* Full width */
                padding: 10px; /* Padding inside fields */
                margin-bottom: 15px; /* Space below fields */
                border: 1px solid #ddd; /* Border color */
                border-radius: 5px; /* Rounded corners */
            }


            .contact-form button {
                display: inline-block;
                padding: 12px 30px; /* Increased padding */
                background: #658735;
                color: white;
                border-radius: 50px;
                text-decoration: none;
                margin-top: 20px;
                transition: background 0.3s;
                font-size: 1em;
                font-weight: 700; /* Bold button text */
                border: none; /* Remove default border */
                outline: none; /* Remove outline on focus */
            }
            .contact-form button:hover{
                background: #c7ddb5;
                color: #658735;
            }
        </style>
    </head>

    <body>
        <header>
            <nav>
                <div class="logo">SeniorCare</div>
                <ul>
                    <li><a href="SeniorHomepage.jsp">Home</a></li>
                    <li><a href="About.jsp">About</a></li>
                    <li><a href="Services.jsp">Services</a></li>
                    <li><a href="Contact.jsp">Contact</a></li>
                    <!-- Show username with dropdown -->
                    <li class="dropdown">
                        <span class="username">Hi, <%= username%></span>
                        <div class="dropdown-content">
                            <a href="UserHistoryRoomList.jsp">History Room</a>
                            <a href="UserHistoryTherapyList.jsp">History Therapy</a>
                            <a href="UserProfile.jsp">Edit Profile</a>
                            <a href="LogoutServlet">Log Out</a>
                        </div>
                    </li>
                </ul>
            </nav>

            <div class="hero">
                <div class="hero-content">
                    <h1>Compassionate Care Enriches Senior Lives</h1>
                    <p>Join our SeniorCare family and experience the warmth of genuine connection, like the love of your own children.</p>
                    <a href="UserRoomPackage.jsp" class="btn">Book Room</a>
                    <a href="UserTherapyPackage.jsp" class="btn">Book Therapy</a>
                    <a href="UserHistoryRoomList.jsp" class="btn">Room History</a>
                    <a href="UserHistoryTherapyList.jsp" class="btn">Therapy History</a>
                </div>
            </div>
        </header>

        <section class="room-packages">
            <h2>
                <span style="color: black;font-size: 1.5em;">Our</span>
                <span style="color: #658735;font-size: 1.5em;">Room Packages</span>
            </h2>
            <p>Indulge in the comfort and care you deserve with our senior care room packages.</p>
            <div class="main-content">
                <%
                    Connection conn = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;
                    int count = 0; // Counter to limit displayed rooms

                    try {
                        conn = DBConnection.getConnection();
                        if (conn != null) {
                            String sql = "SELECT room_id, room_package, room_picture, room_price FROM Room"; // Fetch all rooms
                            ps = conn.prepareStatement(sql);
                            rs = ps.executeQuery();

                            while (rs.next() && count < 3) { // Limit to 3 packages
                                String roomId = rs.getString("room_id");
                                String roomName = rs.getString("room_package");
                                String roomImage = rs.getString("room_picture");
                                double roomPrice = rs.getDouble("room_price");
                                count++; // Increment counter
                %>
                <div class="room-section">
                    <img src="uploads/<%= roomImage%>" alt="<%= roomName%>">
                    <div class="room-info">
                        <div class="room-title"><%= roomName%></div>
                        <div class="room-price">RM <%= String.format("%.2f", roomPrice)%></div>
                        <a href="UserBookRoom.jsp?roomId=<%= roomId%>" class="booking-button">Book Now</a>
                    </div>
                </div>
                <%
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace(new java.io.PrintWriter(out)); // Correctly print stack trace
                    } finally {
                        if (rs != null) {
                            try {
                                rs.close();
                            } catch (Exception ignored) {
                            }
                        }
                        if (ps != null) {
                            try {
                                ps.close();
                            } catch (Exception ignored) {
                            }
                        }
                        if (conn != null) {
                            try {
                                conn.close();
                            } catch (Exception ignored) {
                            }
                        }
                    }
                %>
            </div>
            <div class="see-more">
                <a href="UserRoomPackage.jsp" class="see-more-button">See More →</a>
            </div>
        </section>

        <section class="therapy-packages">
            <h2>
                <span style="color: black; font-size: 1.5em;">Our</span>
                <span style="color: #658735; font-size: 1.5em;">Therapy Packages</span>
            </h2>
            <p>Experience healing and wellness with our tailored therapy packages.</p>
            <div class="main-content">
                <%
                    Connection connTherapy = null;
                    PreparedStatement psTherapy = null;
                    ResultSet rsTherapy = null;
                    int therapyCount = 0; // Counter to limit displayed therapy packages

                    try {
                        connTherapy = DBConnection.getConnection();
                        if (connTherapy != null) {
                            String sqlTherapy = "SELECT THERAPY_ID, THERAPY_PACKAGE, THERAPY_PICTURE, THERAPY_PRICE FROM THERAPY"; // Correct column name
                            psTherapy = connTherapy.prepareStatement(sqlTherapy);
                            rsTherapy = psTherapy.executeQuery();

                            while (rsTherapy.next() && therapyCount < 3) { // Limit to 3 packages
                                String therapyId = rsTherapy.getString("THERAPY_ID");
                                String therapyName = rsTherapy.getString("THERAPY_PACKAGE");
                                String therapyImage = rsTherapy.getString("THERAPY_PICTURE");
                                double therapyPrice = rsTherapy.getDouble("THERAPY_PRICE");
                                therapyCount++; // Increment counter
                %>
                <div class="therapy-section">
                    <img src="uploads/<%= therapyImage%>" alt="<%= therapyName%>">
                    <div class="therapy-info">
                        <div class="therapy-title"><%= therapyName%></div>
                        <div class="therapy-price">RM <%= String.format("%.2f", therapyPrice)%></div>
                        <a href="UserBookTherapy.jsp?therapyId=<%= therapyId%>" class="therapy-button">Book Now</a>
                    </div>
                </div>
                <%
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace(new java.io.PrintWriter(out)); // Correctly print stack trace
                    } finally {
                        if (rsTherapy != null) {
                            try {
                                rsTherapy.close();
                            } catch (Exception ignored) {
                            }
                        }
                        if (psTherapy != null) {
                            try {
                                psTherapy.close();
                            } catch (Exception ignored) {
                            }
                        }
                        if (connTherapy != null) {
                            try {
                                connTherapy.close();
                            } catch (Exception ignored) {
                            }
                        }
                    }
                %>
            </div>
            <div class="see-more">
                <a href="UserTherapyPackage.jsp" class="see-more-button">See More →</a>
            </div>
        </section>
        <section id="contact" class="fade-in">
            <h1>
                <br>
                <span style="color: black;">Contact</span> 
                <span style="color: #658735;">Us</span>
            </h1>
            <p>Don’t hesitate to reach out for any questions. Simply contact us, and we will be happy to assist you!</p>

            <div class="contact-container">
                <div class="contact-info-container">
                    <div class="contact-info">
                        <div class="info-item">
                            <i class="fas fa-map-marker-alt"></i>
                            <div class="info-text">
                                <h3>Address</h3>
                                <p>3, Jalan P16e, Presint 16, 62150 Putrajaya, Wilayah Persekutuan Putrajaya</p>
                            </div>
                        </div>
                        <div class="info-item">
                            <i class="fas fa-phone-alt"></i>
                            <div class="info-text">
                                <h3>Phone</h3>
                                <p>03-6666 7777</p>
                            </div>
                        </div>
                        <div class="info-item">
                            <i class="fas fa-envelope"></i>
                            <div class="info-text">
                                <h3>Email</h3>
                                <p>seniorcare@gmail.com</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="contact-form-container">
                    <form class="contact-form">
                        <h3>Send Message</h3>
                        <input type="text" placeholder="Full Name" required>
                        <input type="email" placeholder="Email" required>
                        <textarea placeholder="Type your message here..." required></textarea>
                        <button type="submit">Send Message</button>
                    </form>
                </div>
            </div>
        </section>
        <script src="script/javascript.js"></script>
    </body>
    <%@ include file="footer.jsp" %>
</html>