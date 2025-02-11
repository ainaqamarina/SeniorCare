<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, bean.RoomBean, dao.RoomDao" %>

<jsp:include page="SidebarAdmin.jsp" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Room List</title>
  
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { 
            font-family: Arial, sans-serif; 
            background: #f4f4f4; 
            margin: 0; 
            padding: 20px;
        }
        .container { 
            width: 90%; 
            max-width: 1000px; 
            margin: 40px auto 0 auto; 
            padding: 20px;
            background: white; 
            border-radius: 12px; 
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.1); 
            transform: translateX(12%); 
        }
        h2 { 
            text-align: center; 
            color: #2c3e50; 
            margin-bottom: 20px;
        }
        table { 
            width: 100%; 
            border-collapse: collapse; 
            margin-bottom: 20px; 
            border-radius: 8px;
            overflow: hidden;
        }
        th, td { 
            padding: 12px; 
            text-align: center; /* Center the text */
            border-bottom: 1px solid #ddd; 
        }
        th { 
            background: #2c3e50; 
            color: white; 
            text-transform: uppercase;
        }
        tr:nth-child(even) { background: #f9f9f9; }
        .action-btn { 
            padding: 8px 12px; 
            border-radius: 5px; 
            cursor: pointer; 
            border: none; 
            transition: background 0.3s; 
            font-size: 16px;
        }
        .edit { color: #f39c12; }
        .delete { color: #e74c3c; }
        .view { color: #3498db; }
        .search-container {
            margin-bottom: 20px;
            text-align: center;
            position: relative; /* Positioning for the icon */
        }
        .search-input {
            padding: 10px 10px; /* Add padding to the left for the icon */
            border: 1px solid #ccc;
            border-radius: 5px;
            width: 100%; 
            max-width: 300px; 
            box-sizing: border-box; 
            background: url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/svgs/solid/search.svg') no-repeat 10px center; /* Add icon as background */
            background-size: 20px; /* Size of the icon */
        }
        .search-input::placeholder {
            color: #aaa; /* Placeholder color */
        }
        /* Fixed size and rounded corners for images */
        .room-image {
            width: 90px; /* Set fixed width */
            height: 90px; /* Set fixed height */
            border-radius: 5px; /* Round corners */
            object-fit: cover; /* Maintain aspect ratio */
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Room Packages</h2>
        
        <div class="search-container">
            <input type="text" id="searchInput" class="search-input" placeholder="Search by Room ID or Package">
        </div>
        
        <table>
            <thead>
                <tr>
                    <th>Room ID</th>
                    <th>Package Name</th>
                    <th>Price (RM)</th>
                    <th>Picture</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% List<RoomBean> roomList = RoomDao.getAllRooms(); %>
                <% for (RoomBean room : roomList) { %>
                <tr>
                    <td><%= room.getRoomId() %></td>
                    <td><%= room.getRoomPackage() %></td>
                   <td>RM <%= String.format("%.2f", room.getRoomPrice()) %></td>
                    <td>
                        <img src="uploads/<%= room.getRoomPicture() %>" class="room-image" alt="Room Image"> 
                    </td>
                    <td>
                        <button class="action-btn edit" onclick="location.href='EditRoomAdmin.jsp?room_id=<%= room.getRoomId() %>'">
                            <i class="fas fa-pen"></i>
                        </button>
                        <button class="action-btn delete" onclick="location.href='RoomServlet?action=delete&room_id=<%= room.getRoomId() %>'">
                            <i class="fas fa-trash"></i>
                        </button>
                        <button class="action-btn view" onclick="location.href='ViewRoomAdmin.jsp?room_id=<%= room.getRoomId() %>'">
                            <i class="fas fa-eye"></i>
                        </button>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <script>
        const searchInput = document.getElementById('searchInput');
        const tableRows = document.querySelectorAll('tbody tr'); 

        searchInput.addEventListener('keyup', () => {
            const searchTerm = searchInput.value.toLowerCase();
            tableRows.forEach(row => {
                const roomId = row.cells[0].textContent.toLowerCase();
                const roomPackage = row.cells[1].textContent.toLowerCase();
                if (roomId.includes(searchTerm) || roomPackage.includes(searchTerm)) {
                    row.style.display = ''; 
                } else {
                    row.style.display = 'none'; 
                }
            });
        });

        function confirmDelete(roomId) {
            if (confirm('Are you sure you want to delete this room?')) {
                fetch(`RoomServlet?action=delete&room_id=${roomId}`, {
                    method: 'DELETE' // Ensure the method is DELETE
                })
                .then(response => {
                    if (response.ok) {
                        alert('Successfully deleted the room package!');
                        window.location.reload();
                    } else {
                        alert('Failed to delete the room package. Please try again.');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('An error occurred while trying to delete the room. Please try again.');
                });
            }
        }
    </script>
</body>
</html>