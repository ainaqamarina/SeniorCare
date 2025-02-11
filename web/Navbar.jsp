<%@ page import="javax.servlet.http.HttpSession" %>
<%
    HttpSession sessionUser = request.getSession(false);
    String username = (sessionUser != null) ? (String) sessionUser.getAttribute("username") : null;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
                   padding: 20px 45px;
 background-color: rgba(101, 135, 53, 0.8); 
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
                color: black; /* Change text color on hover */
                text-shadow: 0 0 10px rgba(101, 135, 53, 0.8), 0 0 20px rgba(101, 135, 53, 0.6); /* Glowing effect */
            }

            a {
                text-decoration: none;
                color: white;
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

        .username {
            cursor: pointer;
            padding: 10px;
            background-color: #658735; /* Consistent background color */
            color: white;
            border-radius: 50px;
        }
    </style>
</head>
<body>
    <nav>
        <div class="logo">SeniorCare</div>
        <ul>
            <li><a href="SeniorHomepage.jsp">Home</a></li>
            <li><a href="About.jsp">About</a></li>
            <li><a href="Services.jsp">Services</a></li>
            <li><a href="Contact.jsp">Contact</a></li>
            <li class="dropdown">
                <span class="username">Hi, <%= username != null ? username : "Guest" %></span>
                <div class="dropdown-content">
                     <a href="UserHistoryRoomList.jsp">History Room</a>
                    <a href="UserHistoryTherapyList.jsp">History Therapy</a>
                    <a href="UserProfile.jsp">Edit Profile</a>
                    <a href="LogoutServlet">Log Out</a>
                    
                </div>
            </li>
        </ul>
    </nav>
</body>
</html>