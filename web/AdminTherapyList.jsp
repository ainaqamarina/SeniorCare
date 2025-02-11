
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, bean.TherapyBean, dao.TherapyDao" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="SidebarAdmin.jsp" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Therapy List</title>
  
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
            margin: 40px auto; 
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
        .therapy-image {
            width: 90px; /* Set fixed width */
            height: 90px; /* Set fixed height */
            border-radius: 5px; /* Round corners */
            object-fit: cover; /* Maintain aspect ratio */
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Therapy Packages</h2>
        
        <div class="search-container">
            <input type="text" id="searchInput" class="search-input" placeholder="Search by Therapy ID or Package">
        </div>
        
        <table>
            <thead>
                <tr>
                    <th>Therapy ID</th>
                    <th>Package Name</th>
                    <th>Price (RM)</th>
                    <th>Picture</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<TherapyBean> therapyList = TherapyDao.getAllTherapies(); // Fetch all therapy packages
                    for (TherapyBean therapy : therapyList) {
                %>
                <tr>
                    <td><%= therapy.getTherapyId() %></td>
                    <td><%= therapy.getTherapyPackage() %></td>
                    <td>RM <%= String.format("%.2f", therapy.getTherapyPrice()) %></td>
                    <td>
                        <img src="uploads/<%= therapy.getTherapyPicture() %>" class="therapy-image" alt="Therapy Image">
                    </td>
                    <td>
                        <button class="action-btn edit" onclick="location.href='EditTherapyAdmin.jsp?therapy_id=<%= therapy.getTherapyId() %>'">
                            <i class="fas fa-pen"></i>
                        </button>
                        <button class="action-btn delete" onclick="location.href='TherapyServlet?action=delete&therapy_id=<%= therapy.getTherapyId() %>'">
                            <i class="fas fa-trash"></i>
                        </button>
                        <button class="action-btn view" onclick="location.href='ViewTherapyAdmin.jsp?therapy_id=<%= therapy.getTherapyId() %>'">
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
                const therapyId = row.cells[0].textContent.toLowerCase();
                const therapyPackage = row.cells[1].textContent.toLowerCase();

                if (therapyId.includes(searchTerm) || therapyPackage.includes(searchTerm)) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        });

        function confirmDelete(therapyId) {
            if (confirm('Are you sure you want to delete this therapy package?')) {
                fetch(`TherapyServlet?action=delete&therapy_id=${therapyId}`, {
                    method: 'DELETE' // Ensure the method is DELETE
                })
                .then(response => {
                    if (response.ok) {
                        alert('Successfully deleted the therapy package!');
                        window.location.reload();
                    } else {
                        alert('Failed to delete the therapy package. Please try again.');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('An error occurred while trying to delete the therapy package. Please try again.');
                });
            }
        }
    </script>
</body>
</html>