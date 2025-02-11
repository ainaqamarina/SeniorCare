<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="Navbar.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - SeniorCare</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
           <style>
            * {
                box-sizing: border-box;
            }
            body {
                margin: 0;
                font-family: 'Roboto', sans-serif; /* Use Roboto font */
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
                background: rgba(255, 255, 255, 0.8); /* White overlay with transparency */
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
</body>
<%@ include file="footer.jsp" %>
</html>