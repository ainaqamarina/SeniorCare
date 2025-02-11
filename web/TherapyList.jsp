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
    <title>Therapy Booking List</title>
    
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
            background-size: 20px; /* Size of the icon */
        }
        .search-input::placeholder {
            color: #aaa; /* Placeholder color */
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Therapy Booking List</h1>
    
    <div class="search-container">
        <input type="text" id="searchInput" class="search-input" placeholder="Search by Booking ID, Username, or Therapy Package"> 
    </div>

    <table class="booking-table">
        <thead>
            <tr>
                <th>Booking ID</th>
                <th>Username</th>
                <th>Therapy Package</th>
                <th>Therapy Date</th>
                <th>Total Payment</th>
            </tr>
        </thead>
        <tbody id="therapyTableBody">
            <%
                Connection conn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;

                try {
                    conn = DBConnection.getConnection();
                    if (conn == null) {
                        out.println("<tr><td colspan='5'>Database connection failed!</td></tr>");
                    }

                    // Updated SQL query to match the new table structure
                    String sql = "SELECT BOOKINGT_ID, SENIOR_USERNAME, THERAPY_PACKAGE, " +
                                 "THERAPY_DATE, THERAPY_TOTAL_PRICE " +
                                 "FROM BOOKINGT";

                    ps = conn.prepareStatement(sql);
                    rs = ps.executeQuery();

                    if (!rs.next()) {
                        out.println("<tr><td colspan='5'>No records found!</td></tr>");
                    } else {
                        do {
                            int bookingId = rs.getInt("BOOKINGT_ID");
                            String username = rs.getString("SENIOR_USERNAME");
                            String therapyPackage = rs.getString("THERAPY_PACKAGE");
                            String therapyDate = rs.getDate("THERAPY_DATE").toString();
                            double totalPayment = rs.getDouble("THERAPY_TOTAL_PRICE");
            %>
            <tr>
                <td><%= bookingId %></td>
                <td><%= username %></td>
                <td><%= therapyPackage %></td>
                <td><%= therapyDate %></td>
                <td>RM <%= new DecimalFormat("#,##0.00").format(totalPayment) %></td>
            </tr>
            <%
                        } while (rs.next());
                    }
                } catch (SQLException sqlEx) {
                    out.println("<tr><td colspan='5'>SQL Error: " + sqlEx.getMessage() + "</td></tr>");
                    sqlEx.printStackTrace();
                } catch (Exception e) {
                    out.println("<tr><td colspan='5'>General Error: " + e.getMessage() + "</td></tr>");
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
    const tableRows = document.querySelectorAll('#therapyTableBody tr');

    searchInput.addEventListener('keyup', () => {
        const searchTerm = searchInput.value.toLowerCase();

        tableRows.forEach(row => {
            const bookingId = row.cells[0].textContent.toLowerCase();
            const username = row.cells[1].textContent.toLowerCase();
            const therapyPackage = row.cells[2].textContent.toLowerCase();

            if (bookingId.includes(searchTerm) || username.includes(searchTerm) || therapyPackage.includes(searchTerm)) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    });
</script>
</body>
</html>