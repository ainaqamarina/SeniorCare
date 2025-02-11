<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - SeniorCare</title>
    <link href="css/login.css" rel="stylesheet"> 
       <link rel="icon" href="images/seniorcarebg3.png" type="image/png"> 
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
</head>

<body>
    <nav>
        <div class="logo">SeniorCare</div>
        <ul>
            <li><a href="index.html">Home</a></li>
            <li><a href="#" onclick="goToAbout()">About</a></li>
            <li><a href="#" onclick="goToService()">Services</a></li>
            <li><a href="#" onclick="goToContact()">Contact</a></li>
            <li><a href="register.jsp">Register</a></li>
            <li><a href="login.jsp">Login</a></li>
        </ul>
    </nav>

    <div class="overlay"></div>

    <div class="login-container">
        <form action="LoginServlet" method="POST" class="login-form">
           <h2>
                <span style="color: black;">Welcome</span> 
                <span style="color: #658735;">Back</span>
            </h2>


            <!-- Username -->
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" required>
            </div>

            <!-- Password -->
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>

            <!-- Submit Button -->
            <button type="submit" class="btn-submit">Login</button>
        </form>
    </div>

    <script>
        // Check for error or success messages
        window.onload = function() {
            <% if (request.getParameter("error") != null) { %>
                alert("Login Not Successful: <%= request.getParameter("error") %>");
            <% } %>

            <% if (request.getParameter("message") != null) { %>
                alert("Login Successful: <%= request.getParameter("message") %>");
            <% } %>
        };

        function goToAbout() {
            window.location.href = "index.html#about";
        }

        function goToService() {
            window.location.href = "index.html#service";
        }

        function goToContact() {
            window.location.href = "index.html#contact";
        }
    </script>
</body>

</html>