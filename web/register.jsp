<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<!DOCTYPE html> 
<html lang="en"> 

<head> 
    <meta charset="UTF-8"> 
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> 
    <title>Register - SeniorCare</title> 
    <link href="css/register.css" rel="stylesheet"> 
       <link rel="icon" href="images/seniorcarebg3.png" type="image/png"> 
</head> 

<body> 
    <header>
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
    </header>

    <div class="overlay"></div>

    <div class="register-container"> 
        <form action="RegisterServlet" method="POST" class="register-form"> 
            <h2>
                <span style="color: black;">Let's Join</span> 
                <span style="color: #658735;">Us</span>
            </h2>

            <div class="form-group"> 
                <div> 
                    <label for="fullname">Full Name</label> 
                    <input type="text" id="fullname" name="fullname" placeholder="Place Your Full Name Here" required> 
                </div> 
            </div> 

            <div class="form-group">
                <div>
                    <label for="phone">Phone Number</label>
                    <input type="text" id="phone" name="phone" placeholder="0136797541" required>
                </div>
                <div>
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email" placeholder="example@example.com" required>
                </div>
            </div>

            <div class="form-group"> 
                <div> 
                    <label for="age">Age</label> 
                    <input type="number" id="age" name="age" placeholder="Enter Your Age" required min="1"> 
                </div> 
            </div>

            <div class="form-group"> 
                <label>Gender</label> 
                <div class="gender-options"> 
                    <label><input type="radio" name="gender" value="Male" required> Male</label> 
                    <label><input type="radio" name="gender" value="Female" required> Female</label> 
                </div> 
            </div>

            <div class="form-group"> 
                <div> 
                    <label for="username">Username</label> 
                    <input type="text" id="username" name="username" placeholder="Place Your Username Here" required> 
                </div> 
            </div> 

            <div class="form-group"> 
                <div> 
                    <label for="password">Password</label> 
                    <input type="password" id="password" name="password" placeholder="******" required> 
                </div> 
                <div> 
                    <label for="confirm-password">Re-enter Password</label> 
                    <input type="password" id="confirm-password" name="confirmPassword" placeholder="******" required> 
                </div> 
            </div> 

            <button type="submit" class="btn-submit">Sign Up</button> 

        </form> 
    </div>

    <script>
        function goToAbout() {
            window.location.href = "index.html#about";
        }

        function goToService() {
            window.location.href = "index.html#service";
        }

        function goToContact() {
            window.location.href = "index.html#contact";
        }

        // Show success or generic failure messages in a popup
        window.onload = function() {
            <% if (request.getParameter("error") != null) { %>
                alert("Not Successful");
            <% } %>

            <% if (request.getParameter("message") != null) { %>
                alert("Registration Successful");
            <% } %>
        };

        // Password Matching Script
        document.addEventListener("DOMContentLoaded", function() { 
            const form = document.querySelector(".register-form"); 
            form.addEventListener("submit", function(event) { 
                const password = document.getElementById("password").value; 
                const confirmPassword = document.getElementById("confirm-password").value; 
                if (password !== confirmPassword) { 
                    event.preventDefault(); 
                    alert("Passwords do not match!"); 
                } 
            }); 
        }); 
    </script>

</body> 
</html>
