<%@ page import="java.sql.*, javax.sql.*, util.DBConnection" %>
<%@ page import="java.util.Random" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.time.*, java.time.temporal.ChronoUnit" %>
<%@ page import="java.time.format.DateTimeParseException" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Therapy Package</title>
    <style>
         /* Global Styles */
            body {
                font-family: 'Arial', sans-serif;
                background-image: url('images/seniorcarebg3.png'); /* Background image */
                background-size: cover; /* Cover the entire viewport */
                background-position: center; /* Center the image */
                margin: 0;
                padding: 0;
                color: #333;
                height: 70vh; /* Ensures the body takes the full height of the viewport */
                position: relative; /* Required for overlay positioning */
            }

            /* Overlay */
            body::before {
                content: "";
                position: absolute;
                margin-top: -120px;

                top: 0;
                left: 0;
                width: 100%;
                height: 145%; /* Ensures the overlay covers the full height of the body */
                background: rgba(0, 0, 0, 0.5); /* Dark overlay */
                z-index: 1; /* Make sure the overlay is behind the content */
            }

         /* Popup Styles */
            .popup {
                display: none; /* Hidden by default */
                position: fixed;
                left: 50%;
                top: 50%;
                transform: translate(-50%, -50%);
                background-color: white;
                border-radius: 10px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
                z-index: 3; /* Above other content */
                padding: 20px;
                text-align: center;
            }

            .popup h2 {
                color: #658735;
            }

            .popup button {
                background-color: #658735;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .popup button:hover {
                background-color: #66bb6a;
            }
        .main-content {
            background-color: rgba(255, 255, 255, 0.9); /* White background with some transparency */
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            padding: 30px;
            max-width: 600px;
            width: 100%;
            margin: 20px auto; /* Center the content */
            margin-top: 120px;
            display: flex;
            flex-direction: column;
            gap: 20px; /* Space between elements */
            position: relative; /* Required for z-index stacking */
            z-index: 2; /* Ensure content is above the overlay */
        }

        .therapy-section {
            text-align: center;
        }

        .therapy-section img {
            width: 100%;
            border-radius: 8px;
            height: auto;
            max-height: 200px;
            object-fit: cover;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .therapy-info {
            margin-top: 10px;
        }

        .therapy-title {
            font-size: 20px;
            color: #333;
            margin: 5px 0;
            font-weight: 500;
        }

        .therapy-price {
            font-size: 18px;
            color: #658735;
            font-weight: bold;
        }

        
            /* Booking Form Styles */
            form {
                display: flex;
                flex-direction: column;
                gap: 15px; /* Space between form elements */
            }

            .form-row {
                display: flex;
                justify-content: space-between; /* Aligns children horizontally */
                gap: 15px; /* Space between fields */
            }

            label {
                font-weight: 600;
                color: #333;
                margin-bottom: 5px; /* Space below label */
            }

        input[type="text"],
        input[type="date"],
        input[type="number"] {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            transition: border-color 0.3s;
            width: 100%; /* Make all input boxes the same width */
            box-sizing: border-box; /* Include padding and border in the element's total width and height */
        }

        input[readonly] {
            background-color: #f0f0f0; /* Light gray background to indicate read-only fields */
            cursor: default; /* Change cursor to default for read-only fields */
        }

        input[type="text"]:focus,
        input[type="date"]:focus,
        input[type="number"]:focus {
            border-color: #658735;
            outline: none;
        }

        .booking-button {
            background-color: #658735;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 5px;
            font-size: 18px;
            cursor: pointer;
            transition: background-color 0.3s;
            font-weight: bold;
        }

        .booking-button:hover {
            background-color: #66bb6a;
        }

        /* Responsive Styles */
        @media (max-width: 600px) {
            .main-content {
                padding: 20px;
            }

            .therapy-section img {
                max-height: 150px; /* Smaller image on mobile */
            }
        }
    </style>
</head>
<body>
    <%@ include file="Navbar.jsp" %>
    <main class="main-content">

        <%
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            String bookingMessage = "";
            String errorMessage = ""; // Variable to store error messages
            String therapyPackage = ""; // Variable to store the therapy package
            String therapyImage = ""; // Variable to store therapy image
            double therapyPrice = 0; // Variable to store therapy price
            Double totalCost = null; // Variable to store total cost

            // Retrieve the logged-in username from session
            String seniorName = (String) session.getAttribute("username");
            // Retrieve therapy ID from request parameters
            String therapyId = request.getParameter("therapyId");

            // Process the booking if the form is submitted
            String bookingIdStr = request.getParameter("bookingId");
            String bookingDate = request.getParameter("bookingDate");

            if (bookingDate != null && bookingIdStr != null) {
                try {
                    conn = DBConnection.getConnection();
                    if (conn != null) {
                        int bookingId = Integer.parseInt(bookingIdStr); // Convert to int

                        // Validate booking date
                        LocalDate bookingDateParsed = LocalDate.parse(bookingDate);
                        if (bookingDateParsed.isBefore(LocalDate.now())) {
                            errorMessage = "Booking date must not be in the past.";
                        } else {
                            // Get therapy details including price and package
                            String sql = "SELECT therapy_price, therapy_package FROM Therapy WHERE therapy_id = ?";
                            ps = conn.prepareStatement(sql);
                            ps.setString(1, therapyId);
                            rs = ps.executeQuery();

                            if (rs.next()) {
                                therapyPrice = rs.getDouble("therapy_price");
                                therapyPackage = rs.getString("therapy_package"); // Retrieve therapy package
                            }

                            // Calculate total cost (assuming one session for the selected date)
                            totalCost = therapyPrice;

                            // Insert into booking table
                            sql = "INSERT INTO bookingt (bookingt_id, therapy_id, senior_username, therapy_date, therapy_total_price, therapy_package) VALUES (?, ?, ?, ?, ?, ?)";
                            ps = conn.prepareStatement(sql);
                            ps.setInt(1, bookingId);              // booking_id
                            ps.setString(2, therapyId);           // therapy_id
                            ps.setString(3, seniorName);           // senior_username
                            ps.setDate(4, Date.valueOf(bookingDateParsed));  // booking_date
                            ps.setDouble(5, totalCost);            // therapy_total_price
                            ps.setString(6, therapyPackage);       // therapy_package
                            ps.executeUpdate();

                            bookingMessage = "Booking successful!";
                        }
                    } else {
                        errorMessage = "Database connection failed.";
                    }
                } catch (DateTimeParseException dtpe) {
                    errorMessage = "Invalid date format. Please use YYYY-MM-DD.";
                } catch (NumberFormatException nfe) {
                    errorMessage = "Invalid booking ID format.";
                } catch (Exception e) {
                    errorMessage = "Error: " + e.getMessage();
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            }

            // Generate a unique booking ID
            Random random = new Random();
            int bookingId = 1000 + random.nextInt(9000); // Generates a random booking ID between 1000 and 9999

            try {
                conn = DBConnection.getConnection();
                if (conn == null) {
        %>
            <p style="color:red;">Database connection failed!</p>
        <%
                } else {
                    // SQL query to select the therapy by ID
                    String sql = "SELECT * FROM Therapy WHERE therapy_id = ?"; // Use the correct table name
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, therapyId);
                    rs = ps.executeQuery();

                    if (rs.next()) { // Check if there is data for the specific therapy ID
                        therapyPackage = rs.getString("therapy_package"); // Get the therapy package
                        therapyImage = rs.getString("therapy_picture"); // Get the therapy image
                        therapyPrice = rs.getDouble("therapy_price"); // Get the therapy price
        %>

            <div class="therapy-section">
                <img src="uploads/<%= therapyImage %>" alt="<%= therapyPackage %>">
                <div class="therapy-info">
                    <div class="therapy-title"><%= therapyPackage %></div>
                    <div class="therapy-price">RM <%= new DecimalFormat("#,##0.00").format(therapyPrice) %> per session</div> <!-- Format price -->
                </div>
            </div>

            <!-- Booking Form -->
            <form action="UserBookTherapy.jsp" method="post">
                <input type="hidden" name="bookingId" value="<%= bookingId %>"> <!-- Hidden Booking ID field -->
                
                 <div>
                    <label for="seniorName">Name</label>
                    <input type="text" id="seniorName" name="seniorName" value="<%= seniorName %>" readonly> <!-- Auto-filled with session username -->
                </div>
                 <div class="form-row">
                <div>
                    <label for="bookingIdDisplay">Booking ID:</label>
                    <input type="text" id="bookingIdDisplay" name="bookingIdDisplay" value="<%= bookingId %>" readonly>
                </div>
                <input type="hidden" name="therapyId" value="<%= therapyId %>">
                <div>
                    <label for="therapyPackage">Therapy Package:</label>
                    <input type="text" id="therapyPackage" name="therapyPackage" value="<%= therapyPackage %>" readonly> <!-- Auto-filled with therapy package -->
                </div>
                 </div>
                <div>
                    <label for="bookingDate">Booking Date:</label>
                    <input type="date" id="bookingDate" name="bookingDate" required>
                </div>
               
                <button type="submit" class="booking-button">Confirm Booking</button>
              
        <%
                    } else {
                        out.println("<p style='color:red;'>No therapy found with the specified ID!</p>");
                    }
                }
            } catch (Exception e) {
                out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
                e.printStackTrace(); // Useful for debugging
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>

    </main>
          <!-- Success Popup -->
        <div class="popup" id="successPopup">
            <h2>Booking Successful!</h2>
            <p id="popupMessage"></p> <!-- Placeholder for booking message -->
            <p id="popupTotalCost"></p> <!-- Placeholder for total cost -->
            <button onclick="closePopup()">Close</button>
        </div>

        <script>
            // Show the success popup if bookingMessage is not empty
            <% if (!bookingMessage.isEmpty()) {%>
            document.getElementById('popupMessage').innerText = "<%= bookingMessage%>";
            <% if (totalCost != null) {%>
            document.getElementById('popupTotalCost').innerText = "Total Cost: RM <%= new DecimalFormat("#,##0.00").format(totalCost)%>";
            <% } %>
            document.getElementById('successPopup').style.display = 'block';
            <% }%>

          function closePopup() {
    document.getElementById('successPopup').style.display = 'none';
    window.location.href = 'UserHistoryTherapyList.jsp'; // Redirect to the specified page
}
        </script>

</body>
</html>