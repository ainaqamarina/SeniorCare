<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="Navbar.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title>About Us - SeniorCare</title>
      
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
       <link rel="icon" href="images/seniorcarebg3.png" type="image/png"> 
      <style>
            * {
                box-sizing: border-box;
            }
            body {
                margin: 0;
                font-family: 'Roboto', sans-serif; /* Use Roboto font */
            }
            .hero {
                background: url('images/seniorcarebg3.png') no-repeat center center/cover;
                height: 100vh;
                display: flex;
                align-items: center;
                justify-content: flex-start;
                text-align: left; /* Align text to the left */
                color: white;
                position: relative;
                padding: 20px;
            }
            .hero::before {
                content: "";
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
            }
            .hero-content {
                position: relative;
                z-index: 1;
                max-width: 600px;
                padding: 20px; /* Add padding for spacing */
            }
            .hero-content h1 {
                font-size: 3em;
                margin: 0;
                font-weight: 600; /* Make the heading bold */
            }
            .hero-content p {
                font-size: 1.2em;
                margin: 10px 0;
                line-height: 1.5; /* Better line spacing */
            }
            .hero .btn {
                display: inline-block;
                padding: 12px 30px; /* Increased padding */
                background: #658735;
                color: white;
                border-radius: 50px;
                text-decoration: none;
                margin-top: 20px;
                transition: background 0.3s;
                font-size: 1.2em;
                font-weight: 700; /* Bold button text */
            }
            .hero .btn:hover {
                background: #c7ddb5;
                color: #658735;
            }
            /*    section*/
            section {
                padding: 60px 20px;
                text-align: center;
            }
            /*    footer*/
            footer {
                background: #333;
                color: white;
                text-align: center;
                padding: 20px 0;
            }

            /* About Section */
            #about {
                position: relative; /* Allow positioning of pseudo-elements */
                text-align: center; /* Center align the heading */
                padding: 60px 20px;
                height: 100vh; /* Full viewport height */
                overflow: hidden; /* Hide overflow for shapes */
            }

            #about h1 {
                font-size: 2.5em;
                margin-bottom: 90px; /* Adjusted for better spacing */
            }

            /* Geometric Shapes */
            #about::before, #about::after {
                content: '';
                position: absolute;
                border-radius: 50%; /* Create circles */
                width: 300px; /* Size of the circles */
                height: 300px;
                background: rgba(101, 135, 53, 0.1); /* Light green for the background */
                z-index: 0; /* Behind the content */
            }

            #about::before {
                left: -150px; /* Position left */
                top: 50px; /* Position down */
            }

            #about::after {
                right: -150px; /* Position right */
                bottom: -30px; /* Position up */
            }

            /* Container to hold image & text */
            .about-container {
                display: flex;  
                align-items: center;  /* Align items in the center vertically */
                justify-content: center;
                max-width: 1200px;
                margin: 0 auto; /* Center the content */
                gap: 70px; /* Space between image and text */
                position: relative; /* Position relative for layering */
                z-index: 1; /* Bring content above shapes */
            }

            .about-image {
                flex: 1;
                text-align: center; /* Center the image */
            }

            .image-back {
                max-width: 100%;
                height: auto;
                border-radius: 20px; /* Set rounded corners for the image */
                transition: transform 0.3s ease, box-shadow 0.3s ease; /* Smooth transitions for scale and shadow */
            }

            .about-image:hover .image-back {
                transform: scale(1.0); /* Zoom in effect on hover */
                box-shadow: 0 0 20px rgba(101, 135, 53, 0.8), 0 0 30px rgba(101, 135, 53, 0.6); /* Green glow effect */
            }
            /* Text on the right */
            .about-text {
                flex: 1;
                text-align: left;
            }

            .about-text h2 {
                font-size: 2em;
                margin-bottom: 15px;
            }

            .about-text p {
                text-align: justify;
                line-height: 1.6;
                max-width: 600px;
            }

                  </style>
</head>
<body>
    <section id="about">
        <h1 class="fade-in">
            <br>
            <span style="color: black;">About</span> 
            <span style="color: #658735;">Us</span>
        </h1>
        <div class="about-container fade-in" id="about-content">
            <div class="about-image">
                <div class="image-overlay">
                    <img class="image-back" src="images/seniorcarebg2.png">
                </div>
            </div>
            <div class="about-text">
                <h2>
                    <span style="color: black;">Welcome To </span> 
                    <span style="color: #658735;">SeniorCare</span>
                </h2>
                <p>At SeniorCare, we are dedicated to providing compassionate and personalized care that empowers seniors to live their best lives, fostering not only their physical well-being but also enhancing their emotional and social connections. We invite you to learn more about our wide range of services designed to meet the unique needs of each individual, and we encourage you to join us in our mission to make a meaningful difference in the lives of seniors and their families, creating a supportive community where everyone can thrive.</p>
            </div>
        </div>
    </section>
    
       <script src="script/javascript.js"></script>
</body>
<%@ include file="footer.jsp" %>
</html>