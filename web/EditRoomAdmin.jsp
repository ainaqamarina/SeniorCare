<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*, util.DBConnection" %>
<%@ page import="bean.RoomBean, dao.RoomDao" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit Room</title>
        <link rel="stylesheet" href="css/style.css">
    </head>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            overflow: hidden; /* Prevent scrollbars */
        }

        .container {
            background: rgba(255, 255, 255, 0.9); /* Slight transparency for better effect */
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            max-width: 500px; /* Adjusted width of the container */
            width: 100%; /* Full width for smaller screens */
            text-align: center;
            position: relative; /* Position relative for the waves */
            z-index: 1; /* Ensure content is above the waves */
        }

        h2 {
            color: #2c3e50;
            margin-bottom: 20px;
            font-weight: 600;
        }

        .form-group {
            margin-bottom: 15px;
            text-align: left;
            display: flex; /* Flexbox for label and input */
            align-items: center; /* Center align items vertically */
        }

        label {
            display: block;
            font-weight: 500;
            margin-right: 10px; /* Space between label and input */
            color: #34495e;
            width: 120px; /* Fixed width for labels */
        }

        input[type="text"], input[type="number"], input[type="file"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 14px;
            transition: 0.3s;
        }

        input[type="text"]:focus, input[type="number"]:focus, input[type="file"]:focus {
            border-color: #3498db;
            outline: none;
            box-shadow: 0px 0px 5px rgba(52, 152, 219, 0.5);
        }

        img {
            display: block;
            margin: 10px auto;
            border-radius: 8px;
            width: 250px; /* Fixed width for the image */
            height: 200px; /* Fixed height for the image */
            object-fit: cover; /* Maintain aspect ratio and cover the area */
            box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
             transition: transform 0.3s ease, box-shadow 0.3s ease; /* Smooth transition for hover effects */
        }

         img:hover {
            transform: scale(1.05); /* Slight zoom effect on hover */
            
            box-shadow: 0 6px 15px rgba(41, 128, 185, 0.5); /* Blue shadow on hover */
        }

        .btn-submit {
            background: #2980b9;
            color: white;
            border: none;
            padding: 12px;
            width: 100%;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s;
        }

        .btn-submit:hover {
            background: #3498db;
        }

        .btn-back {
            background: transparent; /* Outline button */
            color: #e74c3c; /* Text color */
            border: 2px solid #e74c3c; /* Red border */
            padding: 12px;
            width: 100%;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s ease; /* Transition for all properties */
            margin-top: 10px; /* Space between the buttons */
        }

        .btn-back:hover {
            background: #e74c3c; /* Full red background on hover */
            color: white; /* Change text color to white */

            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2); /* Add shadow on hover */
        }

        /* Wave effect */
        .wave {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 300px; /* Adjust height as needed */
            background: linear-gradient(to right, rgba(41, 128, 185, 0.9), rgba(41, 128, 185, 0.6)); /* Gradient with #2980b9 */
            clip-path: ellipse(100% 100% at 50% 0%);
            opacity: 0.9; /* Adjust opacity for a more pronounced effect */
            z-index: 0; /* Behind the container */
        }
    </style>
    <body>
        <div class="container">
            <h2>Edit Room Package</h2>

            <%
                String roomId = request.getParameter("room_id");
                RoomBean room = RoomDao.getRoomById(roomId);
                if (room != null) {
            %>

            <form action="RoomServlet" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="room_id" value="<%= room.getRoomId()%>">

                <!-- Current Picture at the Top without Label -->
                <img src="uploads/<%= room.getRoomPicture()%>" width="250">

                <div class="form-group">
                    <label for="room_package">Package Name:</label>
                    <input type="text" id="room_package" name="room_package" value="<%= room.getRoomPackage()%>" required>
                </div>

                <div class="form-group">
                    <label for="room_price">Price (RM):</label>
                    <input type="number" id="room_price" name="room_price" value="<%= String.format("%.2f", room.getRoomPrice())%>" required>
                </div>

                <div class="form-group">
                    <label for="room_picture">New Picture:</label>
                    <input type="file" id="room_picture" name="room_picture" accept="image/*">
                </div>

                <button type="submit" class="btn-submit">Update Room</button>
            </form>

            <button class="btn-back" onclick="window.location.href = 'AdminRoomList.jsp';">Back to Room List</button>

            <% } else { %>
            <p>Room not found.</p>
            <% }%>
        </div>
        <div class="wave"></div> <!-- Wave effect -->
    </body>
</html>