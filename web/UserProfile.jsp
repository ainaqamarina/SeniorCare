<%@ page import="java.sql.*, javax.sql.*, util.DBConnection" %>
<%@ page session="true" %>
<%
    String username = (String) session.getAttribute("username"); 

    if (username == null || username.isEmpty()) {
        response.sendRedirect("login.jsp");
        return;
    }

    String updateMessage = (String) session.getAttribute("updateMessage");
    if (updateMessage != null) {
        session.removeAttribute("updateMessage");
    }

    String dbURL = "jdbc:derby://localhost:1527/SeniorCareDD";
    String dbUser = "app"; 
    String dbPass = "app";    

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String gender = "";
    int age = 0;
    String contact = "";

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
        ps = conn.prepareStatement("SELECT * FROM SENIORS WHERE SENIOR_USERNAME = ?");
        ps.setString(1, username);
        rs = ps.executeQuery();

        if (rs.next()) {
            gender = rs.getString("SENIOR_GENDER");
            age = rs.getInt("SENIOR_AGE");
            contact = rs.getString("SENIOR_CONTACT");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Profile</title>
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
            height: 100vh; /* Full height */
            display: flex; /* Use flexbox for centering */
            justify-content: center; /* Center horizontally */
            align-items: center; /* Center vertically */
            position: relative; /* Required for overlay positioning */
            overflow: hidden; /* Prevent scrolling */
        }

        /* Overlay */
        body::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%; /* Ensure the overlay covers the full height of the body */
            background: rgba(0, 0, 0, 0.5); /* Dark overlay */
            z-index: 1; /* Make sure the overlay is behind the content */
        }

        nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 45px;
            background-color: rgba(101, 135, 53, 0.9);
            position: fixed;
            width: 95%;
            top: 0;
            z-index: 10;
        }
        .logo {
            font-size: 24px;
            font-weight: bold;
            color: white;
            text-decoration: none;
        }
       .container {
    background: rgba(255, 255, 255, 0.8); /* White background with 80% opacity */
    padding: 20px; /* Reduced padding */
    border-radius: 8px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2); /* Slightly increased shadow for better visibility */
    width: 100%;
    max-width: 400px; /* Adjusted max-width for a smaller form */
    z-index: 2; /* Ensure the form is above the overlay */
    position: relative; /* Position relative to allow z-index to work */
}
        h1 {
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
            text-align: center;
        }
        .profile-list {
            display: flex;
            flex-direction: column;
        }
        .profile-item {
            margin-bottom: 15px;
            display: flex;
            align-items: center;
        }
        .profile-item label {
            width: 100px; /* Set a fixed width for labels */
            font-weight: bold;
            margin-right: 10px; /* Space between label and input */
            color: #555;
        }
        .profile-item input {
            border: 1px solid #ccc;
            border-radius: 4px;
            padding: 10px;
            width: calc(100% - 120px); /* Adjust width based on label size */
            font-size: 16px;
            transition: border-color 0.3s;
        }
        .profile-item select {
            border: 1px solid #ccc;
            border-radius: 4px;
            padding: 10px;
            width: calc(100% - 105px); /* Match input size */
            font-size: 16px;
            transition: border-color 0.3s;
        }
        .profile-item input:focus,
        .profile-item select:focus {
            border-color: #658735;
            outline: none;
        }
        .btn {
            background-color: #658735;
            color: white;
            border: none;
            padding: 10px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
            transition: background-color 0.3s;
        }
        .btn:hover {
            background-color: #5a7a2d;
        }
        .readonly-input {
    border: none; /* No border */
    background: none; /* No background */
    color: #333; /* Text color */
    padding: 0; /* No padding */
    font-size: 16px; /* Font size */
    width: calc(100% - 120px); /* Adjust width based on label size */
    cursor: default; /* Change cursor to indicate it's non-editable */
    pointer-events: none; /* Prevent click events */
}
    </style>
    <script>
        window.onload = function() {
            var message = "<%= updateMessage != null ? updateMessage : "" %>";
            if (message) {
                alert(message);
            }
        };
    </script>
</head>
<body>
    <nav>
        <a href="SeniorHomepage.jsp" class="logo">SeniorCare</a>
    </nav>

    <div class="container">
        <h1>User Profile</h1>
        <form action="UpdateProfileServlet" method="POST">
            <div class="profile-list">
                <div class="profile-item">
    <label for="username">Username:</label>
    <input type="text" id="username" name="username" value="<%= username %>" readonly class="readonly-input">
</div>
                <div class="profile-item">
                    <label for="gender">Gender:</label>
                    <select id="gender" name="gender" class="gender-select">
                        <option value="Male" <%= "Male".equals(gender) ? "selected" : "" %>>Male</option>
                        <option value="Female" <%= "Female".equals(gender) ? "selected" : "" %>>Female</option>
                    </select>
                </div>
                <div class="profile-item">
                    <label for="age">Age:</label>
                    <input type="number" id="age" name="age" value="<%= age %>">
                </div>
                <div class="profile-item">
                    <label for="contact">Contact:</label>
                    <input type="text" id="contact" name="contact" value="<%= contact %>">
                </div>
            </div>
            <button type="submit" class="btn">Update Profile</button>
        </form>
    </div>
</body>
</html>