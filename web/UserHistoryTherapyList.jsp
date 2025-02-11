<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, util.DBConnection" %>
<%@ page import="java.util.List, bean.TherapyBean, dao.TherapyDao" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Therapy Booking History</title>
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background: #f8f9fa;
            margin: 0;
            text-align: center;
        }
        nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 10;
            padding: 20px 45px;
            background-color: rgba(101, 135, 53, 0.9); 
        }
        .logo {
            font-size: 24px;
            font-weight: bold;
            color: white;
            text-decoration: none; /* Remove underline from link */
        }
        .nav-links {
            display: flex;
            gap: 20px; /* Space between links */
        }
        .nav-link {
            color: white;
            text-decoration: none;
            font-size: 18px;
            transition: color 0.3s;
        }
        .nav-link:hover {
            color: #e0e0e0; /* Change color on hover */
        }
        .container {
            width: 80%;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            margin-top: 80px; /* Space for fixed navbar */
        }
        h2 {
            color: #658735;
            margin-bottom: 20px;
        }
        .search-container {
            margin-bottom: 20px;
        }
        .search-input {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            width: 80%;
            max-width: 400px;
            box-sizing: border-box;
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: white;
            border-radius: 10px;
            overflow: hidden;
        }
        th, td {
            padding: 15px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }
        th {
            background: #658735;
            color: white;
            font-weight: bold;
        }
        tbody tr:hover {
            background-color: #f1f1f1;
        }
        .delete-btn {
            background: #dc3545;
            color: white;
            padding: 8px 12px;
            text-decoration: none;
            border-radius: 5px;
            transition: 0.3s;
            border: none;
            cursor: pointer;
        }
        .delete-btn:hover {
            background: #c82333;
        }

    </style>
</head>
<body>
    <nav>
        <a href="SeniorHomepage.jsp" class="logo">SeniorCare</a>
    </nav>

    <div class="container">
        <h2>Your Therapy Booking History</h2>
        
        <div class="search-container">
            <input type="text" id="searchInput" class="search-input" placeholder="Search by Booking ID or Package">
        </div>
        <table>
            <thead>
                <tr>
                    <th>Booking ID</th>
                    <th>Therapy Package</th>
                    <th>Therapy Date</th>
                    <th>Total Price (RM)</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    // Retrieve the logged-in username from session
                    String username = (String) session.getAttribute("username");

                    if (username != null) {
                        Connection conn = null;
                        PreparedStatement ps = null;
                        ResultSet rs = null;

                        try {
                            conn = DriverManager.getConnection("jdbc:derby://localhost:1527/SeniorCareDD", "app", "app");

                            String query = "SELECT * FROM BOOKINGT WHERE SENIOR_USERNAME = ?";
                            ps = conn.prepareStatement(query);
                            ps.setString(1, username);
                            rs = ps.executeQuery();

                            while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getInt("BOOKINGT_ID") %></td>
                    <td><%= rs.getString("THERAPY_PACKAGE") %></td>
                    <td><%= rs.getDate("THERAPY_DATE") %></td>
                    <td>RM <%= String.format("%.2f", rs.getDouble("THERAPY_TOTAL_PRICE")) %></td> <!-- Format price -->
                    <td>
                        <a href="BookingTherapyServlet?action=delete&bookingt_id=<%= rs.getInt("BOOKINGT_ID") %>" 
                           class="delete-btn" onclick="return confirm('Are you sure you want to cancel this booking?');">
                            Cancel Book
                        </a>
                    </td>
                </tr>
                <%
                            }
                        } catch (Exception e) {
                            out.println("Error: " + e.getMessage());
                        } finally {
                            if (rs != null) rs.close();
                            if (ps != null) ps.close();
                            if (conn != null) conn.close();
                        }
                    } else {
                        out.println("<tr><td colspan='5'>You need to be logged in to view your booking history.</td></tr>");
                    }
                %>
            </tbody>
        </table>
    </div>

    <script>
        const searchInput = document.getElementById('searchInput');
        const tableRows = document.querySelectorAll('tbody tr');

        searchInput.addEventListener('keyup', () => {
            const searchTerm = searchInput.value.toLowerCase();

            tableRows.forEach(row => {
                const therapyId = row.cells[0].textContent.toLowerCase();
                const therapyPackage = row.cells[1].textContent.toLowerCase();

                if (therapyId.includes(searchTerm) || therapyPackage.includes(searchTerm)) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        });
    </script>
</body>
</html>