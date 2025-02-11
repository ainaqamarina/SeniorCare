<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="Navbar.jsp" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Our Services - SeniorCare</title>
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
         
            /*    footer*/
            footer {
                background: #333;
                color: white;
                text-align: center;
                padding: 20px 0;
            }

            /* Service Section */
            #service {
                position: relative; /* Allow positioning of pseudo-elements */
                text-align: center; /* Center align the heading */
                padding: 60px 20px;
                height: 100vh; /* Full viewport height */
                background-color: #f9f9f9; /* Light background color */

            }

            #service h1 {
                font-size: 2.5em;
                margin-bottom: 60px; /* Adjusted for better spacing */
            }

            .service-container {
                display: flex; /* Use flexbox for layout */
                justify-content: center; /* Center items */
                gap: 30px; /* Space between items */
                flex-wrap: wrap; /* Allow wrapping */
                padding: 0 20px; /* Horizontal padding for the container */
            }

            .service-item {
                background: white; /* White background for each service item */
                border-radius: 10px; /* Rounded corners */
                padding: 20px; /* Padding inside items */
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); /* Subtle shadow */
                width: calc(33.33% - 20px); /* Each item takes up one-third of the row, minus gap */
                transition: transform 0.3s, box-shadow 0.3s; /* Smooth transformation and shadow */
            }

            .service-item:hover {
                transform: translateY(-5px); /* Lift effect on hover */
                box-shadow: 0 0 20px rgba(101, 135, 53, 0.8), 0 0 30px rgba(101, 135, 53, 0.6); /* Green glow effect */
            }
            .service-item:hover {
                transform: translateY(-5px); /* Lift effect on hover */
            }

            /* Responsive adjustments */
            @media (max-width: 768px) {
                .service-item {
                    width: calc(50% - 20px); /* Two items per row on smaller screens */
                }
            }

            @media (max-width: 480px) {
                .service-item {
                    width: 100%; /* One item per row on very small screens */
                }
            }

            .service-item i {
                font-size: 40px; /* Size of the icon */
                color: #658735; /* Icon color */
                margin-bottom: 10px; /* Space between icon and text */
            }

            .service-item h3 {
                font-size: 1.5em; /* Heading size */
                margin-bottom: 10px; /* Space below heading */
                color: black; /* Heading color */
            }

            .service-item p {
                color: #555; /* Text color */
                line-height: 1.6; /* Line height for readability */
            }
        
        </style>
    </head>
    <body>
        <section id="service">
            <h1 class="fade-in">
                <br>
                <span style="color: black;">Our</span> 
                <span style="color: #658735;">Services</span>
            </h1>
            <div class="service-container fade-in" id="service-content">
                <div class="service-item">
                    <i class="fas fa-heartbeat"></i>
                    <h3>Health Monitoring</h3>
                    <p>We ensure continuous health checks for our residents to maintain their well-being.</p>
                </div>
                <div class="service-item">
                    <i class="fas fa-brain"></i>
                    <h3>Memory Care</h3>
                    <p>Specialized care for individuals with dementia or Alzheimer's.</p>
                </div>
                <div class="service-item">
                    <i class="fas fa-user-friends"></i>
                    <h3>Personal Care</h3>
                    <p>Support for daily activities to ensure dignity and comfort.</p>
                </div>
                <div class="service-item">
                    <i class="fas fa-users"></i>
                    <h3>Community Engagement</h3>
                    <p>Encouraging social activities to keep seniors active and connected.</p>
                </div>
                <div class="service-item">
                    <i class="fas fa-utensils"></i>
                    <h3>Nutritional Support</h3>
                    <p>Customized meal plans to meet dietary needs and preferences.</p>
                </div>
                <div class="service-item">
                    <i class="fas fa-bed"></i>
                    <h3>Respite Care</h3>
                    <p>Temporary relief for primary caregivers, providing professional care.</p>
                </div>
            </div>
        </section>

    </body>
    <%@ include file="footer.jsp" %>
</html>