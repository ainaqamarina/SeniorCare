<%@page import="java.time.temporal.ChronoUnit"%>
<%@ page import="java.sql.*, util.DBConnection" %>
<%@ page import="java.time.*, java.time.format.DateTimeParseException" %>

<%
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null; // Declare ResultSet to close it later
    String bookingMessage = "";
    String roomPackage = ""; // Variable to store the room package

    try {
        conn = DBConnection.getConnection();
        if (conn != null) {
            String roomId = request.getParameter("roomId");
            String checkInDate = request.getParameter("checkInDate");
            String checkOutDate = request.getParameter("checkOutDate");
            String seniorName = request.getParameter("seniorName"); // Now this is filled from the form
            String bookingIdStr = request.getParameter("bookingId"); // Get the booking ID from the form
            int bookingId = Integer.parseInt(bookingIdStr); // Convert to int

            // Validate check-in and check-out dates
            LocalDate checkIn = LocalDate.parse(checkInDate);
            LocalDate checkOut = LocalDate.parse(checkOutDate);
            if (!checkOut.isAfter(checkIn)) {
                bookingMessage = "Check-out date must be after check-in date.";
            } else {
                // Get room details including price and package
                String sql = "SELECT room_price, room_package FROM room WHERE room_id = ?";
                ps = conn.prepareStatement(sql);
                ps.setString(1, roomId);
                rs = ps.executeQuery();

                double roomPrice = 0;
                if (rs.next()) {
                    roomPrice = rs.getDouble("room_price");
                    roomPackage = rs.getString("room_package"); // Retrieve room package
                }

                // Calculate total cost
                long totalDays = ChronoUnit.DAYS.between(checkIn, checkOut);
                double totalCost = totalDays * roomPrice;

                // Insert into booking table
                sql = "INSERT INTO booking (booking_id, room_id, senior_username, room_checkin, room_checkout, room_total_price, room_package) VALUES (?, ?, ?, ?, ?, ?, ?)";
                ps = conn.prepareStatement(sql);
                ps.setInt(1, bookingId);              // booking_id
                ps.setString(2, roomId);              // room_id
                ps.setString(3, seniorName);           // senior_username
                ps.setDate(4, Date.valueOf(checkIn));  // room_checkin
                ps.setDate(5, Date.valueOf(checkOut)); // room_checkout
                ps.setDouble(6, totalCost);            // room_total_price
                ps.setString(7, roomPackage);          // room_package
                ps.executeUpdate();

                bookingMessage = "Booking successful! Total Cost: RM " + totalCost + " for package: " + roomPackage;
            }
        } else {
            bookingMessage = "Database connection failed.";
        }
    } catch (DateTimeParseException dtpe) {
        bookingMessage = "Invalid date format. Please use YYYY-MM-DD.";
    } catch (NumberFormatException nfe) {
        bookingMessage = "Invalid booking ID format.";
    } catch (Exception e) {
        bookingMessage = "Error: " + e.getMessage();
    } finally {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (ps != null) {
            try {
                ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Set the message as a request attribute
    request.setAttribute("bookingMessage", bookingMessage);
    // Forward to userbookroom.jsp
    request.getRequestDispatcher("userbookroom.jsp").forward(request, response);
%>