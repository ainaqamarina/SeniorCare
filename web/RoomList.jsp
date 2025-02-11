<%@page import="util.DBConnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.text.DecimalFormat"%>
<jsp:include page="SidebarAdmin.jsp" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Room Booking List</title>
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { 
             font-family: 'Roboto', sans-serif;
            background: #f4f4f4; 
            margin: 0; 
            padding: 20px;
        }
        .container { 
            width: 90%; 
            max-width: 1000px; 
            margin: 40px auto; 
            padding: 20px;
            background: white; 
            border-radius: 12px; 
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.1);
             transform: translateX(12%); 
        }
        h1 {
            text-align: center; 
            color: #2C3E50; 
            margin-bottom: 20px;
            font-size: 2em;
        }
        .booking-table {
            width: 100%; 
            border-collapse: collapse; 
            margin-bottom: 20px; 
            border-radius: 8px;
            overflow: hidden;
            font-size: 16px;
        }
        th, td { 
            padding: 12px; 
            text-align: center; /* Center the text */
            border-bottom: 1px solid #ddd; 
        }
        th { 
            background: #2C3E50; 
            color: white; 
            text-transform: uppercase;
        }
        tr:nth-child(even) { background: #f9f9f9; }
        .search-container {
            margin-bottom: 20px;
            text-align: center;
            position: relative; /* Positioning for the icon */
        }
        .search-input {
            padding: 10px 10px; /* Add padding to the left for the icon */
            border: 1px solid #ccc;
            border-radius: 5px;
            width: 100%; 
            max-width: 300px; 
            box-sizing: border-box; 
            background: url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/svgs/solid/search.svg') no-repeat 10px center; /* Add icon as background */
           
        }
        .search-input::placeholder {
            color: #aaa; /* Placeholder color */
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Room Booking List</h1>
    
    <div class="search-container">
        <input type="text" id="searchInput" class="search-input" placeholder="Search by Booking ID, Username, or Room Name">
    </div>

    <table class="booking-table">
        <thead>
            <tr>
                <th>Booking ID</th>
                <th>Username</th>
                <th>Room Name</th>
                <th>Date Check-In</th>
                <th>Date Check-Out</th>
                <th>Total Payment</th>
            </tr>
        </thead>
        <tbody id="bookingTableBody">
            <%
                Connection conn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;

                try {
                    conn = DBConnection.getConnection();
                    if (conn == null) {
                        out.println("<tr><td colspan='6'>Database connection failed!</td></tr>");
                    }

                    // SQL query to match the table structure
                    String sql = "SELECT BOOKING_ID, SENIOR_USERNAME, ROOM_PACKAGE, " +
                                 "ROOM_CHECKIN, ROOM_CHECKOUT, " +  
                                 "ROOM_TOTAL_PRICE " +
                                 "FROM BOOKING";

                    ps = conn.prepareStatement(sql);
                    rs = ps.executeQuery();

                    if (!rs.next()) {
                        out.println("<tr><td colspan='6'>No records found!</td></tr>");
                    } else {
                        do {
                            int bookingId = rs.getInt("BOOKING_ID");
                            String username = rs.getString("SENIOR_USERNAME");
                            String roomName = rs.getString("ROOM_PACKAGE");
                            String checkInDate = rs.getDate("ROOM_CHECKIN").toString();
                            String checkOutDate = rs.getDate("ROOM_CHECKOUT").toString();
                            double totalPayment = rs.getDouble("ROOM_TOTAL_PRICE");
            %>
            <tr>
                <td><%= bookingId %></td>
                <td><%= username %></td>
                <td><%= roomName %></td>
                <td><%= checkInDate %></td>
                <td><%= checkOutDate %></td>
                <td>RM <%= new DecimalFormat("#,##0.00").format(totalPayment) %></td>
            </tr>
            <%
                        } while (rs.next());
                    }
                } catch (SQLException sqlEx) {
                    out.println("<tr><td colspan='6'>SQL Error: " + sqlEx.getMessage() + "</td></tr>");
                    sqlEx.printStackTrace();
                } catch (Exception e) {
                    out.println("<tr><td colspan='6'>General Error: " + e.getMessage() + "</td></tr>");
                    e.printStackTrace();
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
        </tbody>
    </table>
</div>

<script>
    const searchInput = document.getElementById('searchInput');
    const tableRows = document.querySelectorAll('#bookingTableBody tr');

    searchInput.addEventListener('keyup', () => {
        const searchTerm = searchInput.value.toLowerCase();

        tableRows.forEach(row => {
            const bookingId = row.cells[0].textContent.toLowerCase();
            const username = row.cells[1].textContent.toLowerCase();
            const roomName = row.cells[2].textContent.toLowerCase();

            if (bookingId.includes(searchTerm) || username.includes(searchTerm) || roomName.includes(searchTerm)) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    });
</script>
</body>
</html>