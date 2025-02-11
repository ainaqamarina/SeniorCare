<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="bean.RoomBean, dao.RoomDao" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>View Room</title>
      
        <style>
            body {
                font-family: 'Poppins', sans-serif;
                background: linear-gradient(to right, #f8f9fa, #e3eaf5);
                margin: 0;
                padding: 20px;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                position: relative; /* Position relative for wave effect */
            }

            .container {
                background: #ffffff;
                padding: 25px;
                border-radius: 12px;
                box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.1);
                max-width: 450px;
                width: 100%;
                text-align: center;
                position: relative; /* Ensure content is above wave */
                z-index: 1; /* Ensure content is above the wave */
            }

            h2 {
                color: #2c3e50;
                margin-bottom: 20px;
                font-weight: 600;
            }

            .room-table {
                width: 100%;
                border-collapse: collapse;
            }

            .room-table th, .room-table td {
                padding: 12px;
                text-align: left;
                font-size: 14px;
                border-bottom: 1px solid #e0e0e0;
            }

            .room-table th {
                color: #2980b9;
                font-weight: 600;
                width: 40%;
            }

            .room-table td {
                color: #2c3e50;
                font-weight: 500;
            }
            img {
                border-radius: 10px;
                width: 240px; /* Fixed width */
                height: 190px; /* Fixed height */
                object-fit: cover; /* Maintain aspect ratio and cover the area */
                margin-top: 10px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            }

            .btn-back {
                display: inline-block; /* Make button inline */
                background: transparent; /* Outline button */
                color: #e74c3c; /* Text color */
                border: 2px solid #e74c3c; /* Red border */
                padding: 12px;
                width: 90%;
                border-radius: 8px;
                font-size: 16px;
                cursor: pointer;
                text-decoration: none; /* Remove underline */
                transition: all 0.3s ease; /* Transition for all properties */
                margin-top: 20px; /* Space above the button */
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
    </head>
    <body>
        <div class="wave"></div> <!-- Wave effect -->
        <div class="container">
            <h2>Room Details</h2>

            <%
                String roomId = request.getParameter("room_id");
                RoomBean room = RoomDao.getRoomById(roomId);
                if (room != null) {
            %>

            <table class="room-table">
                <tr>
                    <th>Room ID:</th>
                    <td><%= room.getRoomId()%></td>
                </tr>
                <tr>
                    <th>Package Name:</th>
                    <td><%= room.getRoomPackage()%></td>
                </tr>
                <tr>
                    <th>Price (RM):</th>
                    <td><%= String.format("%.2f", room.getRoomPrice())%></td>
                </tr>
                <tr>
                    <th>Picture:</th>
                    <td><img src="uploads/<%= room.getRoomPicture()%>" alt="Room Picture"></td>
                </tr>
            </table>

            <a href="AdminRoomList.jsp" class="btn-back">Back to Room List</a>

            <% } else { %>
            <p>Room not found.</p>
            <% }%>
        </div>
    </body>
</html>